package Lab3;

import java.util.Scanner;

public class ex6 {
    public static class Math {
        private static double pi = 3.14159;

        public int factorial(int a) {
            for (int i = a - 1; i > 0; i--) {
                a *= i;
            }
            return a;
        }

        public float rectangleSurface(float a, float b) {
            return a * b;
        }

        public float circleSurface(float a) {
            return (float) (pi * a * a);
        }

        public int max(int a, int b, int c, int d, int e) {
            int[] numArr = { a, b, c, d, e };
            int highest = 0;
            for (int i = 0; i < 5; i++) {
                if (numArr[i] > highest) {
                    highest = numArr[i];
                }
            }
            return highest;
        }

        public int min(int a, int b, int c, int d, int e) {
            int[] numArr = { a, b, c, d, e };
            int lowest = a;
            for (int i = 0; i < 5; i++) {
                if (numArr[i] < lowest) {
                    lowest = numArr[i];
                }
            }
            return lowest;
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Math math = new Math();
        int a, b, c, d, e;
        String operator;

        System.out.println("Choose an operator: !, rect, circ, min, max");
        operator = scanner.next();
        switch (operator) {
            case "!":
                System.out.print("Input value of A: ");
                a = scanner.nextInt();
                System.out.println(math.factorial(a));
                break;
            case "rect":
                System.out.print("Input value of A: ");
                a = scanner.nextInt();
                System.out.print("Input value of B: ");
                b = scanner.nextInt();
                System.out.println(math.rectangleSurface(a, b));
                break;
            case "circ":
                System.out.print("Input value of A: ");
                a = scanner.nextInt();
                System.out.println(math.circleSurface(a));
                break;
            case "max":
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
                System.out.println(math.max(a, b, c, d, e));
                break;
            case "min":
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
                System.out.println(math.min(a, b, c, d, e));

            default:
                System.out.println("Invalid operator");

        }
        scanner.close();
    }
}