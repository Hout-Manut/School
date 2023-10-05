package Lab3;

import java.util.Scanner;

public class ex3 {

    public static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        boolean using = true;
        while (using) {
            int option;
            System.out.print("\033c");

            System.out.println("Phone:");
            System.out.println("1. General                >");
            System.out.println("2. Wi-Fi                  >");
            System.out.println("3. Bluetooth              >");
            System.out.println("4. Mobile Data            >");
            System.out.println("5. Hotspot                >");
            System.out.println("6. Notification           >");
            System.out.println("0. Quit");
            option = scanner.nextInt();
            System.out.print("\033c");
            switch (option) {
                case 1:
                    general();
                    break;
                case 2:
                    wifi();
                    break;
                case 3:
                    System.out.println("Bluetooth:");
                    unavalible();
                    break;
                case 4:
                    System.out.println("Mobile Data:");
                    unavalible();
                    break;
                case 5:
                    System.out.println("Hotspot:");
                    unavalible();
                    break;
                case 6:
                    System.out.println("Notification:");
                    unavalible();
                    break;
                case 0:
                    System.out.println("Quit");
                default:
                    using = false;
                    scanner.close();
            }
        }
    }

    private static void unavalible() {
        System.out.println("=============================");
        System.out.println("This feature is not availible");
        System.out.println("=============================");
        System.out.println("0. Back");
        scanner.nextInt();
        System.out.print("\033c");
    }

    private static void wifi() {
        int option;
        boolean using = true;

        while (using) {
            System.out.print("\033c");
            System.out.println("Wi-Fi:");
            System.out.println("Status                        Connected");
            System.out.println("Network                   CADT-STUDENTS");
            System.out.println();
            System.out.println("1. Other Networks                     >");
            System.out.println("0. Back");
            option = scanner.nextInt();
            System.out.print("\033c");
            switch (option) {
                case 1:
                    System.out.println("Wi-Fi > Other Networks:");
                    System.out.println("CADT-VIP");
                    System.out.println("CADT-OFFICIALS");
                    System.out.println();
                    System.out.println("0. Back");
                    break;
                default:
                    using = false;
                    break;
            }
        }
    }

    private static void general() {
        int option;
        boolean using = true;

        while (using) {
            System.out.print("\033c");
            System.out.println("General: ");
            System.out.println("1. About                  >");
            System.out.println("2. Software Update        >");
            System.out.println("3. iPhone Storage         >");
            System.out.println("0. Back");
            option = scanner.nextInt();
            System.out.print("\033c");
            switch (option) {
                case 1:
                    System.out.println("General > About: ");
                    System.out.println("Name                        Manut's iPhone");
                    System.out.println("iOS Version                          17.1");
                    System.out.println("Moddal Name             iPhone 12 Pro Max");
                    System.out.println();
                    System.out.println("0. Back");
                    option = scanner.nextInt();
                    break;
                case 2:
                    System.out.println("General > Software Update:");
                    System.out.println("=========================");
                    System.out.println(" iOS 17.1 is up to date.");
                    System.out.println("=========================");
                    System.out.println();
                    System.out.println("0. Back");
                    option = scanner.nextInt();
                    break;
                case 3:
                    System.out.println("General > iPhone Storage:");
                    System.out.println();
                    System.out.println("iPhone             202.08 GB of 256 GB used");
                    System.out.println("==============================-------------");
                    System.out.println();
                    System.out.println("0. Back");
                    option = scanner.nextInt();
                    break;
                default:
                    using = false;
                    break;
            }
        }
    }
}
