WITH CustomerTotalSales AS (
    -- محاسبه مجموع فروش برای هر مشتری
    SELECT 
        o.CustomerID,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
),
CustomerCancelledOrders AS (
    -- محاسبه تعداد سفارش‌های لغو شده برای هر مشتری
    SELECT 
        o.CustomerID,
        COUNT(*) AS CancelledOrders
    FROM Orders o
    WHERE o.ShippedDate IS NULL  -- فرض می‌کنیم سفارش‌هایی که `ShippedDate` مقدار ندارد، لغو شده‌اند
    GROUP BY o.CustomerID
),
NormalizedScores AS (
    -- نرمال‌سازی داده‌ها برای ترکیب وزنی
    SELECT 
        cts.CustomerID,
        -- نرمال‌سازی فروش کل: مقدار فروش هر مشتری نسبت به بیشترین مقدار فروش
        (1.0 * (cts.TotalSales - MIN(cts.TotalSales) OVER()) / NULLIF(MAX(cts.TotalSales) OVER() - MIN(cts.TotalSales) OVER(), 0)) AS NormalizedSales,
        -- نرمال‌سازی تعداد لغو: تعداد سفارش لغو شده هر مشتری نسبت به بیشترین مقدار لغو
        (1.0 * (cco.CancelledOrders - MIN(cco.CancelledOrders) OVER()) / NULLIF(MAX(cco.CancelledOrders) OVER() - MIN(cco.CancelledOrders) OVER(), 0)) AS NormalizedCancellations
    FROM CustomerTotalSales cts
    LEFT JOIN CustomerCancelledOrders cco ON cts.CustomerID = cco.CustomerID
),
WorstCustomers AS (
    -- محاسبه امتیاز ترکیبی: کمترین خرید (50%) + بیشترین سفارش لغو شده (50%)
    SELECT TOP 5 CustomerID,
           (1 - NormalizedSales) * 0.5 + NormalizedCancellations * 0.5 AS BadScore
    FROM NormalizedScores
    ORDER BY BadScore DESC  -- مرتب‌سازی از بدترین مشتری
),
WorstCountries AS (
    -- شناسایی کشورهایی که مشتریان بد در آنها قرار دارند
    SELECT DISTINCT c.Country, wc.BadScore
    FROM Customers c
    JOIN WorstCustomers wc ON c.CustomerID = wc.CustomerID
    WHERE c.Country IS NOT NULL
    -- محدود کردن به 3 کشور از بدترین مشتریان
    ORDER BY wc.BadScore DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
),
EmployeesToWorstCountries AS (
    -- شناسایی کارمندان که به کشورهای بد فروش داشته‌اند
    SELECT DISTINCT e.EmployeeID, e.LastName, e.FirstName, c.Country
    FROM Orders o
    JOIN Employees e ON o.EmployeeID = e.EmployeeID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN WorstCountries wc ON c.Country = wc.Country
)
SELECT DISTINCT EmployeeID, LastName, FirstName
FROM EmployeesToWorstCountries
ORDER BY EmployeeID;
