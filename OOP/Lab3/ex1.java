package Lab3;

import java.util.Scanner;

public class ex1 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        float a, b, c, x1, x2;

        System.out.println("Program for calculating roots of quadratic equaltion");
        System.out.println("ax^2 + bx + c = 0");
        System.out.print("Input value of a: ");
        a = scanner.nextFloat();
        System.out.print("Input value of b: ");
        b = scanner.nextFloat();
        System.out.print("Input value of c: ");
        c = scanner.nextFloat();

        float d = b * b - 4 * a * c;
        if (d < 0) {
            System.out.println("Equation roots are complex!");
        }
        else if (d == 0) {
            x1 = -b / (2 * a);
            System.out.println("Equation roots are equal: " + x1);
        }
        else {
            x1 = (-b + (float)Math.sqrt(d)) / (2 * a);
            x2 = (-b - (float)Math.sqrt(d)) / (2 * a);
            System.out.println("X1 " + x1 + ", X2: " + x2);
        }
        scanner.close();
    }
}