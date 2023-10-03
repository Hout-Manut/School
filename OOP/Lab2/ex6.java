package Lab2;

import java.util.Scanner;

public class ex6 {

    static int checkPrime(int n) {
        for (int i = 2; i < n; i++) {
            if (n % i == 0) {
                return i;
            }
        }
        return 0;
    }
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n;

        System.out.print("Input a number to check whether it is a prime number: ");
        n = scanner.nextInt();
        int output = checkPrime(n);
        if (output == 0) {
            System.out.println(n + " is a Prime nummber.");
        }
        else {
            System.out.println(n + " is not a Prime number, because it is divisable by " + output + ".");
        }

        scanner.close();
    }
}
