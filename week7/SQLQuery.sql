CREATE FUNCTION fn_show(@category_ int, @price_ money)
RETURNS TABLE
AS
RETURN
	SELECT P.ProductName, P.CategoryID, P.UnitPrice
	FROM Products P
	WHERE P.CategoryID = @category_ and P.UnitPrice >= @price_

select *
from [dbo].[fn_show](1,20)