UPDATE employees
SET dinid = 3
WHERE EmployeeID IN (3, 4, 5);

SELECT 
    EmployeeID, 
    FirstName + ' ' + LastName AS EmployeeName,
    CASE 
        WHEN dinid = 3 THEN 'Christian'
        WHEN dinid = 2 THEN 'Zoroastrian'
        WHEN dinid = 1 THEN 'Muslim'
        ELSE 'Unknown'
    END AS Religion
FROM employees;
