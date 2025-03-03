SELECT CATE.CategoryName,
	   COUNT(PROD.ProductID) AS ProductCount,
	   SUM( CASE
			WHEN PROD.UnitsInStock > 0
			THEN PROD.UnitsInStock
			ELSE 0
			END) AS TotalStock,
	   COALESCE(SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)), 0) AS TotalSales
FROM Categories CATE
	 JOIN Products PROD 
		ON CATE.CategoryID = PROD.CategoryID
	 LEFT JOIN [Order Details] OD
		ON PROD.ProductID = OD.ProductID
GROUP BY CATE.CategoryName
