CREATE FUNCTION fn_discount (@discount int)
RETURNS TABLE
AS
RETURN
	SELECT P.ProductName, 
	P.CategoryID, 
	P.UnitPrice AS Price, 
	(P.UnitPrice - (P.UnitPrice * @discount) / 100) AS Discount_Price
	FROM Products P


select *
from [dbo].[fn_discount](50)