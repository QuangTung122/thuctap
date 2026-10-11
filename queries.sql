-- =========================================================================
-- BÀI THỰC HÀNH: THAM SỐ TRONG STORED PROCEDURE (IN, OUT, INOUT)
-- CƠ SỞ DỮ LIỆU: classicmodels
-- =========================================================================

USE classicmodels;

-- -------------------------------------------------------------------------
-- PHẦN 1: THAM SỐ LOẠI IN (Tham số truyền vào để lọc dữ liệu)
-- Thủ tục lấy thông tin khách hàng theo mã số (customerNumber)
-- -------------------------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS `getCusById` //

CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi thử nghiệm thủ tục loại IN:
-- CALL getCusById(175);


-- -------------------------------------------------------------------------
-- PHẦN 2: THAM SỐ LOẠI OUT (Tham số dùng để trả kết quả ra ngoài)
-- Thủ tục đếm số lượng khách hàng theo thành phố và gán vào biến 'total'
-- -------------------------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS `GetCustomersCountByCity` //

CREATE PROCEDURE GetCustomersCountByCity(
    IN  in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi thử nghiệm thủ tục loại OUT (sử dụng biến có dấu @):
-- CALL GetCustomersCountByCity('Lyon', @total);
-- SELECT @total;


-- -------------------------------------------------------------------------
-- PHẦN 3: THAM SỐ LOẠI INOUT (Kết hợp giữa nhận giá trị và trả giá trị)
-- Thủ tục cộng thêm một giá trị (inc) vào một biến đếm (counter) có sẵn
-- -------------------------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS `SetCounter` //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Gọi thử nghiệm thủ tục loại INOUT theo các bước tăng dần:
-- SET @counter = 1;
-- CALL SetCounter(@counter, 1); -- Kết quả mong đợi: 2
-- CALL SetCounter(@counter, 1); -- Kết quả mong đợi: 3
-- CALL SetCounter(@counter, 5); -- Kết quả mong đợi: 8
-- SELECT @counter;              -- Hiển thị giá trị cuối cùng: 8
