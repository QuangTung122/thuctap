# Thực hành MySQL Trigger - Quản lý Nhân viên

Bài tập thực hành về cách khởi tạo và vận hành cơ chế Kích hoạt tự động (Trigger) trong MySQL nhằm kiểm soát, chuẩn hóa dữ liệu trước khi chèn vào bảng.

## Mục tiêu bài học

- Hiểu rõ khái niệm và cú pháp xây dựng một Trigger (`BEFORE INSERT`).
- Biết cách sử dụng từ khóa `NEW` để can thiệp và thay đổi giá trị của dòng dữ liệu sắp được thêm mới.
- Ứng dụng cấu trúc điều kiện `IF-ELSEIF-ELSE` để tự động hóa quy trình nghiệp vụ (Business Rule) ngay trong tầng cơ sở dữ liệu.

## Tiến trình thực thi trong file `queries.sql`

1. **Khởi tạo môi trường**: Tạo mới database `company` và cấu trúc bảng mẫu `employees`.
2. **Xây dựng Trigger (`update_department`)**: Tạo bộ lắng nghe sự kiện `BEFORE INSERT` trên bảng nhân viên. Trigger tự động kiểm tra mức lương (`salary`) để phân bổ chính xác vào các phòng ban `Management`, `Sales`, hoặc `Support`.
3. **Chèn dữ liệu thử nghiệm**: Thực hiện lệnh `INSERT` 3 nhân viên với các mức lương khác nhau (3500, 2000, 6000) và truyền giá trị phòng ban tạm thời là `'A'`.
4. **Kiểm chứng kết quả**: Sử dụng lệnh `SELECT` để xác nhận Trigger đã đè dữ liệu gốc thành các phòng ban chuẩn xác dựa trên cấu hình điều kiện.

## Hướng dẫn chạy bài thực hành

1. Khởi động công cụ điều khiển cơ sở dữ liệu (**MySQL Workbench** hoặc dòng lệnh).
2. Mở tệp tin `queries.sql` vừa cập nhật.
3. Chạy toàn bộ mã lệnh bằng tổ hợp phím `Ctrl + Shift + Enter`.
