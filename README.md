# Thực hành MySQL Trigger - Classicmodels

Bài tập thực hành về cách tạo, kiểm thử và sửa đổi Trigger trong MySQL trên cơ sở dữ liệu mẫu `classicmodels`.

## Mục tiêu bài học

- Hiểu cú pháp xây dựng Trigger với các sự kiện `BEFORE INSERT` và `AFTER INSERT`.
- Biết sử dụng `NEW` để kiểm tra dữ liệu trước khi thêm bản ghi.
- Biết ghi nhận sự kiện phát sinh vào bảng log bằng Trigger.
- Biết sửa Trigger trong MySQL bằng cách xóa và tạo lại Trigger.

## Tiến trình thực thi trong file `queries.sql`

1. **Khởi tạo môi trường**: Chạy `index.sql` trước để tạo và nạp dữ liệu cho database `classicmodels`.
2. **Tạo `validate_customer_credit_limit`**: Trigger `BEFORE INSERT` đặt hạn mức mặc định là `0.00` khi giá trị bị bỏ trống và từ chối hạn mức âm.
3. **Tạo `log_new_order`**: Trigger `AFTER INSERT` trên bảng `orders` ghi số đơn hàng và khách hàng vào bảng `order_audit`.
4. **Gọi kiểm thử Trigger**: Chèn dữ liệu mẫu rồi dùng `SELECT` để kiểm tra kết quả Trigger.
5. **Sửa Trigger**: Xóa và tạo lại `log_new_order` để thay đổi giá trị `action_name` từ `INSERT` thành `INSERTED_ORDER`, sau đó kiểm tra lại.

## Hướng dẫn chạy bài thực hành

1. Khởi động công cụ điều khiển cơ sở dữ liệu (**MySQL Workbench** hoặc dòng lệnh).
2. Chạy `index.sql`, sau đó mở tệp tin `queries.sql`.
3. Chạy toàn bộ mã lệnh bằng tổ hợp phím `Ctrl + Shift + Enter`.
