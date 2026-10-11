-- =========================================================================
-- BÀI THỰC HÀNH: KHỞI TẠO, CẬP NHẬT VÀ XÓA VIEW (KHUNG NHÌN)
-- CƠ SỞ DỮ LIỆU: classicmodels
-- =========================================================================

USE classicmodels;

-- -------------------------------------------------------------------------
-- BƯỚC 1: TẠO VIEW ĐẦU TIÊN (customer_views)
-- Trích xuất các cột: customerNumber, customerName, phone từ bảng customers
-- -------------------------------------------------------------------------
-- Xóa view cũ nếu đã tồn tại để tránh xung đột hệ thống
DROP VIEW IF EXISTS customer_views;

CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- Kiểm tra: Truy vấn dữ liệu trực tiếp từ View vừa tạo
SELECT * FROM customer_views;


-- -------------------------------------------------------------------------
-- BƯỚC 2: CẬP NHẬT VIEW (Sử dụng cấu trúc CREATE OR REPLACE VIEW)
-- Thay đổi cấu trúc: Thêm họ tên liên hệ và lọc khách hàng ở thành phố 'Nantes'
-- -------------------------------------------------------------------------
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Kiểm tra: Truy vấn lại dữ liệu để xác nhận cấu trúc và bộ lọc mới đã áp dụng
SELECT * FROM customer_views;


-- -------------------------------------------------------------------------
-- BƯỚC 3: XÓA VIEW (Giải phóng tài nguyên hệ thống)
-- -------------------------------------------------------------------------
DROP VIEW IF EXISTS customer_views;
