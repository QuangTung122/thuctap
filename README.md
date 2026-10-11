
# Thực hành MySQL View (Khung nhìn) - Classicmodels

Bài tập thực hành về cách khởi tạo, cập nhật cấu trúc và xóa Khung nhìn (View) trong MySQL sử dụng cơ sở dữ liệu mẫu `classicmodels`.

## Mục tiêu bài học

- Hiểu cách tạo một bảng ảo (View) để che giấu các dữ liệu nhạy cảm hoặc đơn giản hóa các câu lệnh truy vấn phức tạp.
- Thành thạo cú pháp chỉnh sửa cấu trúc của View mà không làm gián đoạn dịch vụ hệ thống.
- Biết cách dọn dẹp và giải phóng tài nguyên khi không còn nhu cầu sử dụng View.

## Nội dung thực hành trong file `queries.sql`

Tiến trình mã nguồn thực thi tuần tự theo các bước:

1. **Tạo View đầu tiên (`customer_views`)**: Trích xuất các thông tin cơ bản gồm mã khách hàng, tên khách hàng và số điện thoại từ bảng gốc `customers`.
2. **Kiểm tra dữ liệu**: Thực hiện lệnh `SELECT` trực tiếp trên View để kiểm tra kết quả hiển thị.
3. **Cập nhật View (`CREATE OR REPLACE VIEW`)**: Mở rộng cấu trúc View bằng cách thêm thông tin họ tên người liên hệ (`contactFirstName`, `contactLastName`) đồng thời áp dụng bộ lọc điều kiện chỉ lấy các khách hàng ở thành phố `Nantes`.
4. **Xóa View (`DROP VIEW IF EXISTS`)**: Thực hiện xóa bỏ khung nhìn một cách an toàn để dọn dẹp cơ sở dữ liệu.

## Hướng dẫn chạy bài thực hành

1. Khởi động công cụ **MySQL Workbench** (hoặc Command Line).
2. Mở file `queries.sql` chứa mã nguồn thực hành.
3. Nhấn tổ hợp phím `Ctrl + Shift + Enter` để thực thi toàn bộ kịch bản script từ trên xuống dưới.
