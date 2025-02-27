SELECT COUNT(DISTINCT od.OrderID) AS _count

FROM [Order Details] od
WHERE od.Discount = 0