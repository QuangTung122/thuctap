<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><title>Thêm khách hàng</title></head>
<body>
<h1>Thêm khách hàng</h1>
<form action="${pageContext.request.contextPath}/customers?action=create" method="post">
    <label>Họ tên: <input name="name" required></label><br>
    <label>Email: <input name="email" type="email" required></label><br>
    <label>Địa chỉ: <input name="address" required></label><br>
    <button type="submit">Lưu</button>
</form>
<a href="${pageContext.request.contextPath}/customers">Quay lại</a>
</body>
</html>
