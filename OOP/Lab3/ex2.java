package Lab3;

import java.util.Scanner;

public class ex2 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int numOfInput;
        System.out.println("How many number do you want to enter?");
        System.out.print("Number of inputs: ");
        numOfInput = scanner.nextInt();
        int[] numbers = new int[numOfInput];
        for (int i = 0; i < numOfInput; i++) {
            System.out.print("Value #" + (i + 1) + ": ");
            numbers[i] = scanner.nextInt();
        }
        int max = 0, min = numbers[0];
        float sum = 0;
        for (int i = 0; i < numOfInput; i++) {
            if (numbers[i] > max) {
                max = numbers[i];
            }
            if (numbers[i] < min) {
                min = numbers[i];
            }
            sum += numbers[i];
        }
        float avg = sum / numOfInput;

        System.out.println();
        System.out.println("Max: " + max);
        System.out.println("Min: " + min);
        System.out.println("Average: " + avg);
        System.out.println("Sum: " + (int)sum);
        scanner.close();
    }
}
