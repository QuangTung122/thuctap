<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Calculator</title>
</head>
<body>
    <main>
        <h1>Máy tính đơn giản</h1>
        <form action="${pageContext.request.contextPath}/calculate" method="post">
            <label for="firstNumber">Số thứ nhất</label>
            <input id="firstNumber" name="firstNumber" type="number" step="any" required>

            <label for="operator">Phép tính</label>
            <select id="operator" name="operator">
                <option value="+">Cộng (+)</option>
                <option value="-">Trừ (-)</option>
                <option value="*">Nhân (*)</option>
                <option value="/">Chia (/)</option>
            </select>

            <label for="secondNumber">Số thứ hai</label>
            <input id="secondNumber" name="secondNumber" type="number" step="any" required>

            <button type="submit">Tính</button>
        </form>

        <% if (request.getAttribute("result") != null) { %>
            <p>Kết quả: <strong><%= request.getAttribute("result") %></strong></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <p style="color: #b42318">Lỗi: <%= request.getAttribute("error") %></p>
        <% } %>
    </main>
</body>
</html>
