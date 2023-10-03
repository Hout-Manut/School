package Lab2;

import java.util.Scanner;

public class ex9 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        char option;
        int[] n = new int[64];
        int order = 0, highest = 0;

        while (true) {
            System.out.print("Input value in Array at index " + order + ": ");
            n[order] = scanner.nextInt();
            if (n[order] > highest) {
                highest = n[order];
            }
            order++;
            System.out.print("Do you want to add more? (y/n)");
            option = scanner.next().charAt(0);
            if (option == 'n')
                break;
        }

        System.out.println("The biggest number in the Array is: " + highest);

        scanner.close();
    }
}
