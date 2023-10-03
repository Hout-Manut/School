package Lab2;

import java.util.Scanner;

public class ex10 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int option, a = 0, b = 0;
        char option2;

        while (true) {
            System.out.println("=== Math Menu ===");
            System.out.println("1. Addition (+)");
            System.out.println("2. Subtraction (-)");
            System.out.println("3. Multiplication (x)");
            System.out.println("4. Division (/)");
            System.out.println("5. Quit\n");
            System.out.print("Please choose an option: ");
            option = scanner.nextInt();
            switch (option) {
                case 1:
                    while (true) {
                        System.out.println("=== Addition (+) ===");
                        System.out.print("Please input value A: ");
                        a = scanner.nextInt();
                        System.out.print("Please input value B: ");
                        b = scanner.nextInt();

                        int answer = a + b;
                        System.out.println("\nAnswer of A + B = " + answer);

                        System.out.println("\nDo you want to continue? If no go to menu.");
                        System.out.print("Input your answer (y/n): ");
                        option2 = scanner.next().charAt(0);
                        if (option2 == 'n' || option2 == 'N')
                            break;
                        System.out.println("\n");
                    }
                    break;
                case 2:
                    while (true) {
                        System.out.println("=== Subtraction (-) ===");
                        System.out.print("Please input value A: ");
                        a = scanner.nextInt();
                        System.out.print("Please input value B: ");
                        b = scanner.nextInt();

                        int answer = a - b;
                        System.out.println("\nAnswer of A - B = " + answer);

                        System.out.println("\nDo you want to continue? If no go to menu.");
                        System.out.print("Input your answer (y/n): ");
                        option2 = scanner.next().charAt(0);
                        if (option2 == 'n' || option2 == 'N')
                            break;
                        System.out.println("\n");
                    }
                    break;
                case 3:
                    while (true) {
                        System.out.println("=== Multiplication (x) ===");
                        System.out.print("Please input value A: ");
                        a = scanner.nextInt();
                        System.out.print("Please input value B: ");
                        b = scanner.nextInt();

                        int answer = a * b;
                        System.out.println("\nAnswer of A x B = " + answer);

                        System.out.println("\nDo you want to continue? If no go to menu.");
                        System.out.print("Input your answer (y/n): ");
                        System.out.print("Input your answer (y/n): ");
                        option2 = scanner.next().charAt(0);
                        if (option2 == 'n' || option2 == 'N')
                            break;
                        System.out.println("\n");
                    }
                    break;
                case 4:
                    while (true) {
                        float bf = 0;
                        System.out.println("=== Division (/) ===");
                        System.out.print("Please input value A: ");
                        a = scanner.nextInt();
                        while (bf == 0) {
                            System.out.print("Please input value B: ");
                            bf = scanner.nextInt();
                            if (bf == 0)
                                System.out.println("B cannot be zero");
                        }

                        float answer = a / bf;
                        System.out.println("\nAnswer of A / B = " + answer);

                        System.out.println("\nDo you want to continue? If no go to menu.");
                        System.out.print("Input your answer (y/n): ");
                        option2 = scanner.next().charAt(0);
                        if (option2 == 'n' || option2 == 'N')
                            break;
                    }
                    System.out.println("\n");
                    break;
                case 5:
                    System.out.println("Bye");
                    scanner.close();
                    System.exit(0);
                default:
                    System.out.println("\n\n");
                    System.out.println("Invalid option");
                    break;
            }
        }
    }
}
