package Midterm;

import java.util.Scanner;

public class SumProductMinMax3 {
    public static int Sum(int a, int b, int c) {
        return a + b + c;
    }

    public static int Product(int a, int b, int c) {
        return a * b * c;
    }

    public static int Min(int a, int b, int c) {
        return Math.min(a, Math.min(b, c));
    }

    public static int Max(int a, int b, int c) {
        return Math.max(a, Math.max(b, c));
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int a, b, c;

        System.out.print("Enter 1st interger: ");
        a = scanner.nextInt();
        System.out.print("Enter 2st interger: ");
        b = scanner.nextInt();
        System.out.print("Enter 3st interger: ");
        c = scanner.nextInt();

        System.out.println("The sum is: " + Sum(a, b, c));
        System.out.println("The product is: " + Product(a, b, c));
        System.out.println("The min is: " + Min(a, b, c));
        System.out.println("The max is: " + Max(a, b, c));


        scanner.close();
    }
}
