<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><title>Danh sách khách hàng</title></head>
<body>
<h1>Danh sách khách hàng</h1>
<a href="${pageContext.request.contextPath}/customers?action=create">Thêm khách hàng</a>
<table border="1" cellpadding="8" cellspacing="0">
    <tr><th>ID</th><th>Họ tên</th><th>Email</th><th>Địa chỉ</th><th>Thao tác</th></tr>
    <c:forEach items="${customers}" var="customer">
        <tr>
            <td>${customer.id}</td>
            <td><a href="${pageContext.request.contextPath}/customers?action=view&id=${customer.id}">${customer.name}</a></td>
            <td>${customer.email}</td>
            <td>${customer.address}</td>
            <td>
                <a href="${pageContext.request.contextPath}/customers?action=edit&id=${customer.id}">Sửa</a>
                <a href="${pageContext.request.contextPath}/customers?action=delete&id=${customer.id}">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
