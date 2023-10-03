package Lab2;

import java.util.Scanner;

public class ex2 {
    public static void main(String[] args) {
        float conversion;
        int money;
        float convertedMoney;
        Scanner scanner = new Scanner(System.in);
        System.out.println("Program for converting money in Riels to Dollars.");
        System.out.print("Please input the conversion rate for 1 Dollar in Riel: ");
        conversion = scanner.nextFloat();
        System.out.print("Please input the money to exchange in Riel: ");
        money = scanner.nextInt();

        convertedMoney = money / conversion;
        System.out.println(money + " Riel = " + convertedMoney + "USD");
        scanner.close();
    }
}
