SELECT EMP.EmployeeID,
	   EMP.FirstName,
	   EMP.LastName,
	   YEA.YEARS,
	   COU.Country
FROM Employees EMP
	 CROSS JOIN (
		SELECT DISTINCT YEAR(OrderDate) AS YEARS
		FROM Orders ) YEA
	 CROSS JOIN (
		SELECT DISTINCT Country
		FROM Customers ) COU
WHERE NOT EXISTS ( SELECT 0
				   FROM Orders ORD
				   WHERE ORD.EmployeeID = EMP.EmployeeID
						 AND
						 YEAR(ORD.OrderDate) = YEA.YEARS
						 AND
						 ORD.ShipCountry = COU.Country )
ORDER BY EMP.EmployeeID, YEA.YEARS, COU.Country