package Lab2;

import java.util.Scanner;

public class ex5 {
    float calculate(float y, float z) {
        float x;
        y = 1 / y;
        z = 1 / z;
        x = y + z;
        x = 1 / x;
        return x;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        float x, y, z;
        System.out.println("Program for calculating equation 1/x = 1/y + 1/z to find the value of x");
        System.out.print("Please input y: ");
        y = scanner.nextFloat();
        System.out.print("Please input z: ");
        z = scanner.nextFloat();
        ex5 ex5 = new ex5();
        x = ex5.calculate(y, z);
        System.out.println("Result x = " + x);
        scanner.close();
    }
}
