select 
	emp.EmployeeID,CONCAT(emp.FirstName,' ',emp.LastName) as EmployeeName,
	cer.Certification,
	cer.[Year]
from Employees emp
cross apply OpenJson(AdditionalEmployeeInfo,'$.WorkDetails.Certifications')
with (Certification nvarchar(max),
		[Year] int) cer
	where emp.EmployeeID = 1