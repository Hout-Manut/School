package Lab2;

import java.util.Scanner;

public class ex1 {
    public static void main(String[] args) {
        String name = new String();
        System.out.print("Input your name: ");
        Scanner scanner = new Scanner(System.in);
        name = scanner.nextLine();

        System.out.println("Hello " + name + "!");

        scanner.close();
    }
}
