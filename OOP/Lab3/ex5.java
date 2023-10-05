package Lab3;

import java.util.Scanner;

public class ex5 {
    public static class Math{
        public int add(int a, int b){
            return a+b;
        }
        public int subtract(int a, int b){
            return a-b;
        }
        public int multiply(int a, int b){
            return a*b;
        }
        public float divide(float a, float b){
            if (b == 0)
                throw new ArithmeticException("Cannot divide by zero");
            else if (a == 0)
                return 0;
            else if (b < 0)
                return -a/b;
            else 
                return a/b;
        }
        public int min(int a, int b) {
            if (a == b) 
                return a;
            else if (a < b)
                return a;
            else
                return b;
        }
        public int max(int a, int b) {
            if (a == b) 
                return a;
            else if (a > b)
                return a;
            else
                return b;
        }
    }
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Math math = new Math();
        int a, b;
        String operator;

        System.out.print("Input value of A: ");
        a = scanner.nextInt();
        System.out.print("Input value of B: ");
        b = scanner.nextInt();

        System.out.println("Choose an operator: +, -, *, /, min, max");
        operator = scanner.next();
        switch (operator) {
            case "+":
                System.out.println(math.add(a, b));
                break;
            case "-":
                System.out.println(math.subtract(a, b));
                break;
            case "*":
                System.out.println(math.multiply(a, b));
                break;
            case "/":
                System.out.println(math.divide(a, b));
                break;
            case "min":
                System.out.println(math.min(a, b));
                break;
            case "max":
                System.out.println(math.max(a, b));
                break;
            default:
                System.out.println("Invalid operator");
        
        }
        scanner.close();
    }
}
