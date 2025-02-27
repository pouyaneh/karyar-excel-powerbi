SELECT OrderID, ProductID, Quantity, Discount,
CASE
WHEN Discount > 0 THEN 'YES'
	ELSE 'NO'
END AS _Discount


FROM Northwind.dbo.[Order Details]
