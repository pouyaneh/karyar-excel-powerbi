
BEGIN TRANSACTION;

BEGIN TRY

    INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipCountry)
    VALUES ('ALFKI', 5, GETDATE(), 'Germany');

    DECLARE @LastOrderID INT;
    SET @LastOrderID = SCOPE_IDENTITY();

    INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
    VALUES (@LastOrderID, 1, 18.00, 10, 0);

    UPDATE Products
    SET UnitPrice = UnitPrice * 1.10
    WHERE ProductID = 1;

    DECLARE @SavePointOrderDetails INT = @@TRANCOUNT;

 
    INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
    VALUES (@LastOrderID, NULL, 20.00, -5, 0); 


    COMMIT;

END TRY
BEGIN CATCH

    IF @@TRANCOUNT >= @SavePointOrderDetails
    BEGIN
        PRINT '??? ?? ???? ???!.';
        ROLLBACK;
    END

    PRINT ERROR_MESSAGE();
END CATCH;



create  index ix on employees (firstname, lastname)
