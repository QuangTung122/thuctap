package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // BƯỚC 5: Tạo danh sách khách hàng (Dữ liệu giả lập)
        List<Customer> list = new ArrayList<>();
        list.add(new Customer("KH001", "Nguyễn Văn A", "anguyen@gmail.com", "0901234567"));
        list.add(new Customer("KH002", "Trần Thị B", "btran@gmail.com", "0912345678"));
        list.add(new Customer("KH003", "Lê Hoàng C", "cle@gmail.com", "0923456789"));

        // Lưu danh sách vào request attribute với tên là "customerList"
        request.setAttribute("customerList", list);

        // Chuyển tiếp dữ liệu sang trang index.jsp để hiển thị
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
