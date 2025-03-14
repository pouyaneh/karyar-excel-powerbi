-- ایجاد جدول جدید و کپی کردن داده‌ها
SELECT * INTO product_test FROM products;
-- تغییر مقادیر کالاهای تکراری
UPDATE product_test SET productName = 'Chai' WHERE productID IN (1, 11, 21);
UPDATE product_test SET productName = 'Chang' WHERE productID IN (2, 12, 22);
-- ایجاد یک CTE برای شناسایی موارد تکراری
WITH DuplicateProducts AS (
    SELECT productID, 
           productName, 
           ROW_NUMBER() OVER (PARTITION BY productName ORDER BY productID DESC) AS row_num
    FROM product_test )
-- حذف موارد تکراری با row_num بزرگتر از 1
DELETE FROM product_test
WHERE productID IN (
    SELECT productID
    FROM DuplicateProducts
    WHERE row_num > 1 );
--- تست کردن درستی جواب
SELECT productName, COUNT(*) as duplicate_count
FROM product_test
GROUP BY productName
HAVING COUNT(*) > 1