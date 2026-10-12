<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><title>Chi tiết khách hàng</title></head>
<body>
<h1>Chi tiết khách hàng</h1>
<p>ID: ${customer.id}</p>
<p>Họ tên: ${customer.name}</p>
<p>Email: ${customer.email}</p>
<p>Địa chỉ: ${customer.address}</p>
<a href="${pageContext.request.contextPath}/customers">Quay lại</a>
</body>
</html>
