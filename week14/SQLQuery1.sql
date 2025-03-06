SELECT 
    A.CustomerID,
    A.OrderDate AS FirstOrderDate,
    B.OrderDate AS SecondOrderDate
FROM 
    Orders A
JOIN 
    Orders B 
ON 
    A.CustomerID = B.CustomerID
AND 
    DATEDIFF(day, A.OrderDate, B.OrderDate) = 1
ORDER BY 
    A.CustomerID, A.OrderDate;
