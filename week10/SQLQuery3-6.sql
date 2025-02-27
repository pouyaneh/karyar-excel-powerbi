SELECT COUNT(DISTINCT od.ProductID) AS _count

FROM [Order Details] od
WHERE od.Discount = 0