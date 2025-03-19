---
alter table employees
add AdditionalEmployeeInfo nvarchar(max)




UPDATE Employees
SET AdditionalEmployeeInfo = N'
{
  "EmployeeID": 1,
  "Name": "Nancy Davolio",
  "PersonalInfo": {
    "MaritalStatus": "Married",
    "BirthDate": "1985-06-15",
    "Children": [
      { "Name": "Alice", "Age": 10 },
      { "Name": "Bob", "Age": 8 }
    ]
  },
  "WorkDetails": {
    "ExperienceYears": 12,
    "Department": "Sales",
    "PositionHistory": [
      { "Position": "Sales Representative", "StartDate": "2009-01-01", "EndDate": "2012-12-31" },
      { "Position": "Senior Sales Representative", "StartDate": "2013-01-01", "EndDate": "2018-06-30" },
      { "Position": "Sales Manager", "StartDate": "2018-07-01", "EndDate": null }
    ],
    "Certifications": [
      { "Certification": "Certified Sales Professional", "Year": 2014 },
      { "Certification": "Advanced Negotiation Skills", "Year": 2017 }
    ]
  },
  "FinancialDetails": {
    "Salary": 75000,
    "Bonus": 8000,
    "Currency": "USD",
    "Increments": [
      { "Year": 2015, "Increment": 5000 },
      { "Year": 2018, "Increment": 7000 }
    ]
  },
  "PerformanceReviews": [
    { "Year": 2020, "Rating": "A", "Comments": "Excellent performance." },
    { "Year": 2021, "Rating": "B", "Comments": "Good performance with room for improvement." }
  ]
}
'
WHERE EmployeeID = 1;



select * from Employees
where EmployeeID=1


----وضعیت تاهل
select EmployeeID, 
JSON_VALUE(AdditionalEmployeeInfo,'$.Name') as fullname,
JSON_VALUE(AdditionalEmployeeInfo, '$.PersonalInfo.MaritalStatus') as marital


from Employees
where EmployeeID=1


----سابقه کار
select EmployeeID, 
JSON_VALUE(AdditionalEmployeeInfo,'$.Name') as fullname,
JSON_VALUE(AdditionalEmployeeInfo, '$.WorkDetails.ExperienceYears') as marital


from Employees
where EmployeeID=1


-----نام فرزندان رو نمایش بدم
select EmployeeID, 
JSON_VALUE(AdditionalEmployeeInfo,'$.Name') as fullname,
JSON_query(AdditionalEmployeeInfo,'$.PersonalInfo.Children') as child
from Employees
where EmployeeID=1



----Cross apply ] اسم بچه ها در ردیف های مجزا باشه


Select EmployeeID, JSON_VALUE(child.value, '$.Name') as childname,
JSON_VALUE(child.value, '$.Age') as childname


from Employees
Cross apply OpenJson (AdditionalEmployeeInfo,'$.PersonalInfo.Children') as child
where EmployeeID=1


------سابقه کاری کارمندان را نمایش دهید

----حالت اول
Select EmployeeID, JSON_VALUE(position.value, '$.Position') as position,
JSON_VALUE(position.value, '$.StartDate') as startdate,
JSON_VALUE(position.value, '$.EndDate') as enddate

from Employees
Cross apply OpenJson (AdditionalEmployeeInfo,'$.WorkDetails.PositionHistory') as position
where EmployeeID=1

-----حالت دوم با استفاده از with
Select EmployeeID, pos.position, pos.startdate, pos.enddate

from Employees
Cross apply OpenJson (AdditionalEmployeeInfo,'$.WorkDetails.PositionHistory')

with (position nvarchar(50) '$.Position',
startdate Date '$.StartDate',
enddate Date '$.EndDate') as pos
where EmployeeID=1



-----افزایش حقوق کارمند شماره یک را در سال های مختلف نمایش دهید با استفاده از with


Select EmployeeID,
inc.[year], inc.increments

from Employees
Cross apply OpenJson (AdditionalEmployeeInfo,'$.FinancialDetails.Increments')

with ([year] int '$.Year',
increments int '$.Increment'
) as inc
where EmployeeID=1


-----



