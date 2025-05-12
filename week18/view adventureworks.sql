CREATE VIEW v_CustomerSalesWithProduct AS
SELECT 
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    st.Name AS TerritoryName,
    st.CountryRegionCode,
    sp.BusinessEntityID AS SalesPersonID,
    p2.FirstName + ' ' + p2.LastName AS SalesPersonName,
    soh.OrderDate,
    soh.SalesOrderID AS OrderID,
    soh.Status AS OrderStatus,
    pr.ProductID,
    pr.Name AS ProductName,
    pc.Name AS ProductCategory,
    soh.TotalDue AS TotalSales,
    sod.OrderQty AS QuantityPurchased

FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pr ON sod.ProductID = pr.ProductID
JOIN Production.ProductSubcategory psc ON pr.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
LEFT JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
LEFT JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
LEFT JOIN Person.Person p2 ON e.BusinessEntityID = p2.BusinessEntityID;


select * from v_CustomerSalesWithProduct