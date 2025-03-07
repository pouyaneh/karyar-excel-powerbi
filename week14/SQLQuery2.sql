WITH OrderWithLag AS (
    SELECT 
        CustomerID,
        OrderDate,
        LAG(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousOrderDate
    FROM 
        Orders
)
SELECT 
    CustomerID,
    PreviousOrderDate AS FirstOrderDate,
    OrderDate AS SecondOrderDate
FROM 
    OrderWithLag
WHERE 
    DATEDIFF(day, PreviousOrderDate, OrderDate) = 1
ORDER BY 
    CustomerID, PreviousOrderDate;
