package com.codegym;

public class Calculator {
    public double calculate(double firstNumber, double secondNumber, char operator) {
        return switch (operator) {
            case '+' -> firstNumber + secondNumber;
            case '-' -> firstNumber - secondNumber;
            case '*' -> firstNumber * secondNumber;
            case '/' -> divide(firstNumber, secondNumber);
            default -> throw new IllegalArgumentException("Phép tính không hợp lệ.");
        };
    }

    private double divide(double firstNumber, double secondNumber) {
        if (secondNumber == 0) {
            throw new ArithmeticException("Không thể chia cho 0.");
        }
        return firstNumber / secondNumber;
    }
}
