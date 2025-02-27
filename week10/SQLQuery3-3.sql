SELECT Country, Count(*) AS Number_Of_Country

FROM Customers

GROUP BY Country
HAVING COUNT(*) >= 1;
