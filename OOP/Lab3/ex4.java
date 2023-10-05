package Lab3;

import java.util.Scanner;
import java.util.ArrayList;

public class ex4 {
    class Student {
        private int id;
        private String name;
        private int age;

        public Student(int id, String name, int age) {
            this.id = id;
            this.name = name;
            this.age = age;
        }        
    }
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int studentCount = 0;
        ArrayList<Student> students = new ArrayList<Student>();
        ex4 ex4 = new ex4();

        int id;
        String name;
        int age;

        while (true) {
            System.out.println("Student #" + (studentCount + 1) + ":");
            System.out.print("ID: ");
            id = scanner.nextInt();
            System.out.print("Name: ");
            name = scanner.next();
            System.out.print("Age: ");
            age = scanner.nextInt();
            System.out.println();

            Student student = ex4.new Student(id, name, age);
            students.add(student);
            studentCount++;

            System.out.print("Do you wan to add more? (y/n): ");
            String option = scanner.next();
            if (option.equals("n"))
                break;
            System.out.println();
        }
        System.out.println("===========================================");
        System.out.println("| No    | ID    | Name            | Age   |");
        System.out.println("===========================================");
        for (int i = 0; i < studentCount; i++) {
            System.out.printf("| %-5d | %-5d | %-15s | %-5d |\n", i + 1, students.get(i).id, students.get(i).name, students.get(i).age);
        }
        System.out.println("===========================================");
        scanner.close();
    }
}
