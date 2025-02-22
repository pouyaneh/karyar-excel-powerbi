SELECT c.CategoryName,
CASE
WHEN p.Discontinued = 0 THEN 'Active'
	ELSE 'Inactive'
	END AS STATUS,
COUNT(*) AS ProductCount

FROM Northwind.dbo.Products p

JOIN Northwind.dbo.Categories c ON p.CategoryID = c.CategoryID

GROUP BY
	c.CategoryName , p.Discontinued
	ORDER BY c.CategoryName, STATUS