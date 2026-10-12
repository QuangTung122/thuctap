<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- BƯỚC 4: Khai báo thư viện JSTL Core trên đầu trang -->
<%@ taglib prefix="c" uri="http://sun.com" %>

<html>
<head>
    <title>Danh Sách Khách Hàng</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
    </style>
</head>
<body>

    <h2>Danh Sách Khách Hàng Thành Viên</h2>

    <!-- BƯỚC 6: Sử dụng kết hợp HTML và JSTL để hiển thị thông tin -->
    <table>
        <thead>
            <tr>
                <th>Mã KH</th>
                <th>Họ và Tên</th>
                <th>Email</th>
                <th>Số Điện Thoại</th>
            </tr>
        </thead>
        <tbody>
            <!-- Dùng thẻ c:forEach của JSTL để duyệt qua danh sách "customerList" -->
            <c:forEach var="customer" items="${customerList}">
                <tr>
                    <td>${customer.id}</td>
                    <td>${customer.name}</td>
                    <td>${customer.email}</td>
                    <td>${customer.phone}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
