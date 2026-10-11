## **Mục tiêu**

Luyện tập sử dụng view, index, store procedure

## **Mô tả**

Thực hành tạo view, index, store procedure trên bảng.

## **Hướng dẫn**

Bước 1: Tạo cơ sở dữ liệu demo

Bước 2: Tạo bảng Products với các trường dữ liệu sau:

* Id
* productCode
* productName
* productPrice
* productAmount
* productDescription
* productStatus

Chèn một số dữ liệu mẫu cho bảng Products.

Bước 3:

* Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
* Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
* Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
* So sánh câu truy vấn trước và sau khi tạo index

Bước 4:

* Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
* Tiến hành sửa đổi view
* Tiến hành xoá view

Bước 5:

* Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
* Tạo store procedure thêm một sản phẩm mới
* Tạo store procedure sửa thông tin sản phẩm theo id
* Tạo store procedure xoá sản phẩm theo id
