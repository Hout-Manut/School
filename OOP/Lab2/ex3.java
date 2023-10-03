package Lab2;

import java.util.Scanner;

public class ex3 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String[] answer = new String[8];

        System.out.println("=== Covid-19 Screen Health ===");
        System.out.print("Q1. Feeling feverish and/or having chills? ");
        answer[0] = scanner.nextLine();
        System.out.print("Q2. Has there been any use of fever reducing medication within the last 24 hours not due to another health condition? ");
        answer[1] = scanner.nextLine();
        System.out.print("Q3. A new cough that is not due to another health condition? ");
        answer[2] = scanner.nextLine();
        System.out.print("Q4. A new chills that are not due to another health condition? ");
        answer[3] = scanner.nextLine();
        System.out.print("Q5. A new sore throat that is not due to another health condition? ");
        answer[4] = scanner.nextLine();
        System.out.print("Q6. A new loss of taste or smell? ");
        answer[5] = scanner.nextLine();
        System.out.print("Q7. Have you had a positive test for the virus that causes COVID-19 disease within the past 10 days? ");
        answer[6] = scanner.nextLine();
        System.out.print("Q8. In the past 14 days, have you had close contact (within about 6 feet for 15 minutes or more) with someone with suspected or confirmed COVID-19? ");
        answer[7] = scanner.nextLine();

        System.out.println("=== Covid-19 Screen Health ===");
        for (int i = 0; i < answer.length; i++) {
            System.out.println("Q" + (i + 1) + ". " + answer[i]);
        }

        scanner.close();
    }
}