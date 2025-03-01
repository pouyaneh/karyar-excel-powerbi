SELECT EMP.EmployeeID,
	   EMP.FirstName,
	   EMP.LastName,
	   YEA.YEARS,
	   COU.ShipCountry
FROM (SELECT DISTINCT YEAR(OrderDate) AS YEARS
	  FROM Orders ) YEA
	 CROSS JOIN (
		SELECT DISTINCT ShipCountry
		FROM Orders ) COU
	 CROSS JOIN 
		Employees EMP
	 LEFT JOIN
		Orders ORD
	 ON EMP.EmployeeID = ORD.EmployeeID
	 AND 
	 YEAR(ORD.OrderDate) = YEA.YEARS
	 AND
	 ORD.ShipCountry = COU.ShipCountry
WHERE ORD.OrderID IS NULL
