WITH CountrySales AS (
    -- محاسبه مجموع فروش برای هر کشور
    SELECT 
        c.Country,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY c.Country
    HAVING c.Country IS NOT NULL
)
SELECT Country, TotalSales
FROM CountrySales
ORDER BY TotalSales ASC;  -- مرتب‌سازی بر اساس کمترین فروش
