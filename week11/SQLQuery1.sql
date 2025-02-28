SELECT EMP.EmployeeID,
	   EMP.FirstName,
	   EMP.LastName,
	   COUNT(ORD.OrderID) AS TotalOrders
FROM Employees EMP
	 JOIN Orders ORD 
	 ON EMP.EmployeeID = ORD.EmployeeID
WHERE YEAR(ORD.OrderDate) = 1997
GROUP BY EMP.EmployeeID, EMP.FirstName, EMP.LastName
HAVING COUNT(ORD.OrderDate) > (SELECT AVG(OrderCount)
							   FROM (SELECT EmployeeID, COUNT(OrderID) AS OrderCount
									 FROM Orders
									 WHERE YEAR(Orderdate) = 1997
									 GROUP BY EmployeeID) AS EmployeeOrders)
ORDER BY TotalOrders