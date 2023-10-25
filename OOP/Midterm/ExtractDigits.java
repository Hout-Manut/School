package Midterm;

import java.util.Scanner;

public class ExtractDigits {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter an interger: ");
        int n = scanner.nextInt();
        int temp = n;
        while (temp > 0) {
            int digit = temp % 10;
            System.out.print(digit + " ");
            temp /= 10;
        }
        scanner.close();
    }
}
