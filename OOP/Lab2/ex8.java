package Lab2;

import java.util.Scanner;

public class ex8 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int a, b, c, d, e;
        int lowest;
        System.out.print("Input value of A: ");
        a = scanner.nextInt();
        System.out.print("Input value of B: ");
        b = scanner.nextInt();
        System.out.print("Input value of C: ");
        c = scanner.nextInt();
        System.out.print("Input value of D: ");
        d = scanner.nextInt();
        System.out.print("Input value of E: ");
        e = scanner.nextInt();

        lowest = a;
        int[] array = { a, b, c, d, e };
        for (int i = 0; i < array.length; i++) {
            if (array[i] < lowest) {
                lowest = array[i];
            }
        }

        System.out.println("The smallest among A, B, C, D and E is " + lowest);
        scanner.close();
    }
}
