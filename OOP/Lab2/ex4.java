package Lab2;

import java.util.Scanner;

public class ex4 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int input, seconds, minutes, hours;
        String time = new String();
        System.out.print("Input number of seconds: ");
        input = scanner.nextInt();
        
        seconds = input % 60;
        minutes = (input / 60) % 60;
        hours = input / 3600;

        time = hours + ":" + minutes + ":" + seconds;
        System.out.println("Time corresponding to " + input + " seconds is: " + time);

        scanner.close();
    }
}
