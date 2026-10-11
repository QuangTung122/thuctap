# Thực hành MySQL Stored Procedure - Classicmodels

Bài tập thực hành về cách định nghĩa, gọi và quản lý các thủ tục lưu trữ (Stored Procedure) trong MySQL sử dụng cơ sở dữ liệu mẫu `classicmodels`.

## Nội dung thực hành

File `queries.sql` thực hiện các bước theo đúng tiến trình bài học:

1. **Tạo Stored Procedure đầu tiên (`findAllCustomers`)**: Tìm hiểu từ khóa `DELIMITER`, `BEGIN`, `END` để gom cụm các khai báo SQL nhằm tăng hiệu suất và giảm lưu lượng mạng.
2. **Gọi Stored Procedure**: Sử dụng cú pháp `CALL` để triệu gọi thủ tục.
3. **Sửa đổi Stored Procedure**: Thực hiện quy trình chuẩn trong MySQL bằng cách sử dụng `DROP PROCEDURE IF EXISTS` kết hợp tạo mới nhằm thay đổi logic lọc dữ liệu (lọc theo `customerNumber = 175`).
4. **Mở rộng (Tham số IN)**: Tạo thủ tục `getCustomersByCity` nhận vào tham số tên thành phố để tăng tính linh hoạt khi truy vấn.

## Cách chạy bài thực hành

Mở file `queries.sql` bằng MySQL Workbench, kết nối tới Server chứa database `classicmodels` và nhấn `Ctrl + Shift + Enter` để thực thi toàn bộ script.
