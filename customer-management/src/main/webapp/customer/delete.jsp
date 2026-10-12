<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><title>Xóa khách hàng</title></head>
<body>
<h1>Xác nhận xóa</h1>
<p>Bạn có chắc muốn xóa khách hàng <strong>${customer.name}</strong> không?</p>
<form action="${pageContext.request.contextPath}/customers?action=delete" method="post">
    <input type="hidden" name="id" value="${customer.id}">
    <button type="submit">Xóa</button>
</form>
<a href="${pageContext.request.contextPath}/customers">Hủy</a>
</body>
</html>
