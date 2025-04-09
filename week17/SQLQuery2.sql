WITH OrderLineCounts AS (
    SELECT 
        o.CustomerID,
        o.OrderID,
        COUNT(od.ProductID) AS LineCount
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID, o.OrderID
)
SELECT DISTINCT CustomerID
FROM OrderLineCounts
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM OrderLineCounts
    WHERE LineCount = 1
);
