USE classicmodels;

DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers;
END //

DELIMITER ;

-- CALL findAllCustomers();

DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers` //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers WHERE customerNumber = 175;
END //

DELIMITER ;

-- CALL findAllCustomers();

DELIMITER //

DROP PROCEDURE IF EXISTS `getCustomersByCity` //

CREATE PROCEDURE getCustomersByCity(IN cityName VARCHAR(50))
BEGIN
    SELECT * FROM customers WHERE city = cityName;
END //

DELIMITER ;