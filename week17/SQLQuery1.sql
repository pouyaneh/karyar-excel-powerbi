WITH DailyTopProducts AS (
    SELECT 
        od.ProductID,
        SUM(od.Quantity) AS TotalQuantity,
        o.OrderDate,
        RANK() OVER (PARTITION BY o.OrderDate ORDER BY SUM(od.Quantity) DESC) AS Rank
    FROM [Order Details] od
    JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY od.ProductID, o.OrderDate
)
SELECT OrderDate, ProductID, TotalQuantity
FROM DailyTopProducts
WHERE Rank = 1 AND ProductID = 11;




WITH DailyTopProducts AS (
    SELECT 
        od.ProductID,
        SUM(od.Quantity) AS TotalQuantity,
        o.OrderDate,
        RANK() OVER (PARTITION BY o.OrderDate ORDER BY SUM(od.Quantity) DESC) AS Rank
    FROM [Order Details] od
    JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY od.ProductID, o.OrderDate
),
TotalSalesPerDay AS (
    SELECT 
        OrderDate,
        SUM(TotalQuantity) AS TotalSales
    FROM DailyTopProducts
    GROUP BY OrderDate
)
SELECT 
    dp.OrderDate,
    dp.ProductID AS ProductID,
    dp.TotalQuantity AS TotalQuantity,
    ts.TotalSales
FROM DailyTopProducts dp
JOIN TotalSalesPerDay ts ON dp.OrderDate = ts.OrderDate
WHERE dp.Rank = 1 AND dp.ProductID = 11;
