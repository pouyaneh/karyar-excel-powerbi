select 
	e.EmployeeID,
	CONCAT(e.FirstName,' ',e.LastName) as EmployeeName,
	JSON_VALUE(AdditionalEmployeeInfo,'$.FinancialDetails.Bonus') Bonus,
	JSON_VALUE(AdditionalEmployeeInfo,'$.FinancialDetails.Salary') Salary,
	JSON_VALUE(AdditionalEmployeeInfo,'$.FinancialDetails.Currency') Currency
from Employees e
	where e.EmployeeID = 1;