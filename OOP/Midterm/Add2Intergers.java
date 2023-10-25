package Midterm;

import java.util.Scanner;

public class Add2Intergers {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int a, b;
        System.out.print("Enter first integer: ");
        a = scanner.nextInt();
        System.out.print("Enter second integer: ");
        b = scanner.nextInt();
        System.out.println("The sum is: " + (a + b));
        scanner.close();
    }
}
