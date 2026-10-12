package com.codegym.controller;

import com.codegym.model.Customer;
import com.codegym.service.CustomerService;
import com.codegym.service.CustomerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CustomerServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = valueOrEmpty(request.getParameter("action"));
        switch (action) {
            case "create" -> forward(request, response, "/customer/create.jsp");
            case "edit" -> showCustomerForm(request, response, "/customer/edit.jsp");
            case "delete" -> showCustomerForm(request, response, "/customer/delete.jsp");
            case "view" -> showCustomerForm(request, response, "/customer/view.jsp");
            default -> listCustomers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = valueOrEmpty(request.getParameter("action"));
        switch (action) {
            case "create" -> createCustomer(request, response);
            case "edit" -> updateCustomer(request, response);
            case "delete" -> deleteCustomer(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/customers");
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("customers", customerService.findAll());
        forward(request, response, "/customer/list.jsp");
    }

    private void showCustomerForm(HttpServletRequest request, HttpServletResponse response, String view)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        Customer customer = customerService.findById(id);
        if (customer == null) {
            forward(request, response, "/error-404.jsp");
            return;
        }
        request.setAttribute("customer", customer);
        forward(request, response, view);
    }

    private void createCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Customer customer = new Customer(
                nextId(), request.getParameter("name"), request.getParameter("email"), request.getParameter("address"));
        customerService.save(customer);
        response.sendRedirect(request.getContextPath() + "/customers");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (customerService.findById(id) == null) {
            forward(request, response, "/error-404.jsp");
            return;
        }
        Customer customer = new Customer(
                id, request.getParameter("name"), request.getParameter("email"), request.getParameter("address"));
        customerService.update(id, customer);
        response.sendRedirect(request.getContextPath() + "/customers");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        customerService.remove(parseId(request.getParameter("id")));
        response.sendRedirect(request.getContextPath() + "/customers");
    }

    private int nextId() {
        return customerService.findAll().stream().mapToInt(Customer::getId).max().orElse(0) + 1;
    }

    private int parseId(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException exception) {
            return -1;
        }
    }

    private String valueOrEmpty(String value) {
        return value == null ? "" : value;
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        request.getRequestDispatcher(path).forward(request, response);
    }
}
