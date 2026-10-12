<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><title>Sửa khách hàng</title></head>
<body>
<h1>Sửa khách hàng</h1>
<form action="${pageContext.request.contextPath}/customers?action=edit" method="post">
    <input type="hidden" name="id" value="${customer.id}">
    <label>Họ tên: <input name="name" value="${customer.name}" required></label><br>
    <label>Email: <input name="email" type="email" value="${customer.email}" required></label><br>
    <label>Địa chỉ: <input name="address" value="${customer.address}" required></label><br>
    <button type="submit">Cập nhật</button>
</form>
<a href="${pageContext.request.contextPath}/customers">Quay lại</a>
</body>
</html>
