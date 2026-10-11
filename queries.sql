USE classicmodels;

-- 1. Tạo Stored Procedure lấy toàn bộ khách hàng
DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers` //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers;
END //

DELIMITER ;

-- Gọi thử nghiệm thủ tục đầu tiên
CALL findAllCustomers();


-- 2. Sửa Stored Procedure (Xóa và tạo lại để lọc theo mã khách hàng 175)
DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers` //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers WHERE customerNumber = 175;
END //

DELIMITER ;

-- Gọi thử nghiệm thủ tục sau khi sửa
CALL findAllCustomers();


-- 3. Tạo Stored Procedure có tham số đầu vào (IN) để lọc theo thành phố
DELIMITER //

DROP PROCEDURE IF EXISTS `getCustomersByCity` //

CREATE PROCEDURE getCustomersByCity(IN cityName VARCHAR(50))
BEGIN
    SELECT * FROM customers WHERE city = cityName;
END //

DELIMITER ;

-- Gọi thử nghiệm thủ tục có tham số
CALL getCustomersByCity('NYC');