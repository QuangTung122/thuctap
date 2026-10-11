USE classicmodels;

-- Truy van ban dau
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Phan tich truoc khi tao chi muc
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Tao chi muc don cho customerName
ALTER TABLE customers
	ADD INDEX idx_customerName (customerName);

-- Phan tich sau khi tao chi muc don
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Tao chi muc kep cho ho va ten
ALTER TABLE customers
	ADD INDEX idx_full_name (contactFirstName, contactLastName);

-- Phan tich truy van su dung chi muc kep
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
	AND contactLastName = 'King';

-- Phan tich truy van OR voi cot trong chi muc kep
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
	 OR contactLastName = 'King';

-- Xoa cac chi muc da tao
ALTER TABLE customers
	DROP INDEX idx_full_name;

ALTER TABLE customers
	DROP INDEX idx_customerName;
