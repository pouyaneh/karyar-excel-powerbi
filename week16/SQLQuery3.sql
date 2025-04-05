SELECT 
    EMP.EmployeeID,
    CONCAT(emp.FirstName,' ',emp.LastName) as EmployeeName,
	P.Rating,
	P.[Year],
	P.Comments
FROM Employees EMP
CROSS APPLY OPENJSON(AdditionalEmployeeInfo, '$.PerformanceReviews')
	WITH( Rating NCHAR(10),
		  [Year] INT,
		  Comments NVARCHAR(MAX)) P
WHERE EmployeeID = 1;
