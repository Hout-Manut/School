package Lab5;

import java.util.Scanner;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

class MyDate {
    public static String getCurrentDate() {
        String pattern = "dd/MM/yyyy HH:mm:ss";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        Date date = new Date();
        return simpleDateFormat.format(date);
    }

    public static int calculateDaysBtwDates(Date date1, Date date2) {
        return (int) ((date2.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));
    }

    public static String findDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        String day = "";
        switch (dayOfWeek) {
            case 1:
                day = "Sunday";
                break;
            case 2:
                day = "Monday";
                break;
            case 3:
                day = "Tuesday";
                break;
            case 4:
                day = "Wednesday";
                break;
            case 5:
                day = "Thursday";
                break;
            case 6:
                day = "Friday";
                break;
            case 7:
                day = "Saturday";
                break;
        }
        return day;
    }
}

public class ex1 {
    public static void main(String[] args) throws ParseException {
        Scanner scanner = new Scanner(System.in);
        String pattern = "dd/MM/yyyy";
        SimpleDateFormat format = new SimpleDateFormat(pattern);
        String date = new String();
        Date date1 = new Date();
        Date date2 = new Date();
        int option;

        System.out.println("==== Menu ====");
        System.out.println("1. Current date and time.");
        System.out.println("2. Calculate days between 2 dates.");
        System.out.println("3. Find the days of the week.");
        System.out.println("4. Quit.");
        System.out.print("Choose an option: ");
        option = scanner.nextInt();
        System.out.println();

        switch (option) {
            case 1:
                System.out.println("Current datetime is: " + MyDate.getCurrentDate());
                break;
            case 2:
                System.out.print("First date (dd/MM/yyyy): ");
                date = scanner.next();
                date1 = format.parse(date);
                System.out.print("Second date (dd/MM/yyyy): ");
                date = scanner.next();
                date2 = format.parse(date);

                System.out.println(
                        "Difference between 2 days is: " + MyDate.calculateDaysBtwDates(date1, date2) + " days.");
                break;
            case 3:
                System.out.print("Input a date: ");
                date = scanner.next();
                System.out.println("The day is: " + MyDate.findDay(format.parse(date)));
                break;
            default:
                break;
        }
        scanner.close();
    }
}
