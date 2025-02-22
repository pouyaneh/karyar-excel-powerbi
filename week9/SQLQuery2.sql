SELECT emp.FirstName + ' ' + emp.LastName AS _Employee,
emp2.FirstName + ' ' + emp2.LastName AS _maneger

FROM Employees emp
LEFT JOIN Employees emp2 on emp.ReportsTo = emp2.EmployeeID