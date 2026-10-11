-- =========================================================================
-- BÀI THỰC HÀNH: TẠO VÀ SỬ DỤNG TRIGGER TRONG MYSQL
-- CƠ SỞ DỮ LIỆU: company
-- =========================================================================

-- Bước 1: Khởi tạo Cơ sở dữ liệu và Bảng nhân viên
DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- Bước 2: Khởi tạo Trigger tự động phân loại Phòng ban theo Mức lương
DELIMITER //

DROP TRIGGER IF EXISTS update_department //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- Bước 3: Thử nghiệm cơ chế hoạt động của Trigger (Chèn dữ liệu mới)
-- Lưu ý: Giá trị phòng ban nhập tạm thời là 'A' sẽ bị Trigger ghi đè tự động
INSERT INTO employees (name, department, salary)
VALUES ('John Doe', 'A', 3500.00),
       ('Jane Smith', 'A', 2000.00),
       ('David Johnson', 'A', 6000.00);

-- Bước 4: Kiểm tra kết quả sau khi Trigger xử lý dữ liệu
SELECT * FROM employees;
