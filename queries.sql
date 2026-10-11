-- ============================================================================
-- BÀI THỰC HÀNH: TẠO VÀ SỬ DỤNG TRIGGER TRONG MYSQL
-- CƠ SỞ DỮ LIỆU: classicmodels
-- Chạy index.sql trước để tạo và nạp dữ liệu mẫu.
-- ============================================================================

USE classicmodels;

-- Bước 1: Tạo bảng log để ghi nhận các đơn hàng mới
CREATE TABLE IF NOT EXISTS order_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_number INT NOT NULL,
    customer_number INT NOT NULL,
    action_name VARCHAR(30) NOT NULL,
    action_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Bước 2: Trigger kiểm tra dữ liệu trước khi thêm khách hàng
DELIMITER //

DROP TRIGGER IF EXISTS validate_customer_credit_limit //

CREATE TRIGGER validate_customer_credit_limit
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF NEW.creditLimit IS NULL THEN
        SET NEW.creditLimit = 0.00;
    ELSEIF NEW.creditLimit < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'creditLimit must not be negative';
    END IF;
END //

DELIMITER ;

-- Kiểm thử: creditLimit bị bỏ trống sẽ được trigger đặt thành 0.00
DELETE FROM customers WHERE customerNumber = 9999;

INSERT INTO customers (
    customerNumber, customerName, contactLastName, contactFirstName,
    phone, addressLine1, city, country, creditLimit
)
VALUES (
    9999, 'Trigger Test Customer', 'Test', 'Customer',
    '000-000-0000', 'Trigger test address', 'Test City', 'USA', NULL
);

SELECT customerNumber, customerName, creditLimit
FROM customers
WHERE customerNumber = 9999;

-- Bước 3: Tạo trigger ghi log sau khi thêm đơn hàng
DELIMITER //

DROP TRIGGER IF EXISTS log_new_order //

CREATE TRIGGER log_new_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit (order_number, customer_number, action_name)
    VALUES (NEW.orderNumber, NEW.customerNumber, 'INSERT');
END //

DELIMITER ;

-- Kiểm thử trigger ghi log
DELETE FROM order_audit WHERE order_number = 99999;
DELETE FROM orders WHERE orderNumber = 99999;

INSERT INTO orders (
    orderNumber, orderDate, requiredDate, shippedDate,
    status, comments, customerNumber
)
VALUES (
    99999, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY),
    NULL, 'In Process', 'Trigger test order', 103
);

SELECT *
FROM order_audit
WHERE order_number = 99999;

-- Bước 4: Sửa trigger bằng cách bổ sung nội dung mô tả cho bản ghi log
DELIMITER //

DROP TRIGGER IF EXISTS log_new_order //

CREATE TRIGGER log_new_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit (order_number, customer_number, action_name)
    VALUES (NEW.orderNumber, NEW.customerNumber, 'INSERTED_ORDER');
END //

DELIMITER ;

-- Kiểm tra phiên bản trigger sau khi sửa
DELETE FROM order_audit WHERE order_number = 99998;
DELETE FROM orders WHERE orderNumber = 99998;

INSERT INTO orders (
    orderNumber, orderDate, requiredDate, shippedDate,
    status, comments, customerNumber
)
VALUES (
    99998, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY),
    NULL, 'In Process', 'Modified trigger test order', 103
);

SELECT *
FROM order_audit
WHERE order_number = 99998;
