# jwbd-2023-using-index

CSDL mẫu `classicmodels` dùng để thực hành SQL và index tại [CodeGym](https://codegym.vn).

## Chạy file SQL

### MySQL Workbench

1. Mở `index.sql`.
2. Kết nối tới MySQL Server.
3. Chọn chạy toàn bộ script bằng `Ctrl + Shift + Enter`.

### PowerShell

PowerShell không hỗ trợ toán tử `<` trực tiếp. Dùng `cmd` bên trong PowerShell:

```powershell
cmd /c 'mysql -u root -p < "D:\jwbd-2023-using-index\index.sql"'
```

Nhập mật khẩu MySQL khi được yêu cầu.

> Lưu ý: script sẽ xóa và tạo lại các bảng trong database `classicmodels`.

## Chạy bài thực hành index

Sau khi import dữ liệu, mở và chạy toàn bộ file `queries.sql`. File thực hiện theo thứ tự:

1. Chạy truy vấn tìm khách hàng `Land of Toys Inc.`.
2. Dùng `EXPLAIN` trước khi tạo chỉ mục.
3. Tạo chỉ mục đơn `idx_customerName` cho `customerName`.
4. Dùng `EXPLAIN` lại để so sánh kế hoạch thực thi.
5. Tạo chỉ mục kép `idx_full_name` cho `contactFirstName` và `contactLastName`.
6. Dùng `EXPLAIN` với điều kiện tìm họ tên và điều kiện `OR`.
7. Xóa các chỉ mục đã tạo.

Có thể chạy bằng MySQL Workbench hoặc bằng PowerShell:

```powershell
cmd /c 'mysql -u root -p < "D:\jwbd-2023-using-index\queries.sql"'
```

File truy vấn tương ứng:

```sql
USE classicmodels;

SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';
```
