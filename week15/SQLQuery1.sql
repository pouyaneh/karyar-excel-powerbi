-- ایجاد جدول جدید و کپی کردن داده‌ها
SELECT * INTO product_test FROM products;
-- تغییر مقادیر کالاهای تکراری
UPDATE product_test SET productName = 'Chai' WHERE productID IN (1, 11, 21);
UPDATE product_test SET productName = 'Chang' WHERE productID IN (2, 12, 22);
-- حذف کالاهای تکراری و نگه داشتن کالایی با productID بزرگتر
DELETE FROM product_test
WHERE productID NOT IN (
    SELECT MAX(productID)
    FROM product_test
    GROUP BY productName );
--- تست کردن درستی جواب
SELECT productName, COUNT(*) as duplicate_count
FROM product_test
GROUP BY productName
HAVING COUNT(*) > 1