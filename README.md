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

## Chạy truy vấn mẫu

Sau khi import dữ liệu, chạy file `queries.sql` hoặc thực thi:

```sql
USE classicmodels;

SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';
```
