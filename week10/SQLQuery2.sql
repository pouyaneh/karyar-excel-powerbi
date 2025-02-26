WITH ProductWithRowNumber AS (
    SELECT 
        ProductID,
        ProductName,
        UnitPrice,
        NTILE(10) OVER (ORDER BY UnitPrice) AS Decile
    FROM Products
)
SELECT 
    ProductID,
    ProductName,
    UnitPrice,
    Decile
FROM ProductWithRowNumber
WHERE Decile IN (1, 10)
ORDER BY Decile, UnitPrice;
