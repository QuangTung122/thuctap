package com.codegym;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CalculatorServlet extends HttpServlet {
    private final Calculator calculator = new Calculator();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            double firstNumber = Double.parseDouble(request.getParameter("firstNumber"));
            double secondNumber = Double.parseDouble(request.getParameter("secondNumber"));
            char operator = request.getParameter("operator").charAt(0);

            double result = calculator.calculate(firstNumber, secondNumber, operator);
            request.setAttribute("result", result);
        } catch (ArithmeticException | IllegalArgumentException exception) {
            request.setAttribute("error", exception.getMessage());
        }

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
