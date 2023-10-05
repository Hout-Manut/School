package Lab3;

import java.util.Scanner;
import java.util.ArrayList;

public class ex7 {
    public static Scanner scanner = new Scanner(System.in);

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
        int option;
        int studentCount = 0, id, age;
        String name;
        boolean using = true;
        ArrayList<Student> students = new ArrayList<Student>();
        ex7 ex7 = new ex7();
        while (using) {
            System.out.println("====== Menu ======");
            System.out.println("1. Add new student");
            System.out.println("2. Show student list");
            System.out.println("3. Exit");
            System.out.print("Choose an option: ");
            option = scanner.nextInt();
            System.out.println();
            switch (option) {
                case 1:
                    System.out.println("Student #" + (studentCount + 1) + ":");
                    System.out.print("ID: ");
                    id = scanner.nextInt();
                    System.out.print("Name: ");
                    name = scanner.next();
                    System.out.print("Age: ");
                    age = scanner.nextInt();

                    Student student = ex7.new Student(id, name, age);
                    students.add(studentCount, student);
                    studentCount++;

                    System.out.println("Student #" + studentCount + " has been added to the list.");
                    System.out.println();
                    break;
                case 2:
                    System.out.println("===========================================");
                    System.out.println("| No    | ID    | Name            | Age   |");
                    System.out.println("===========================================");
                    for (int i = 0; i < studentCount; i++) {
                        System.out.printf("| %-5d | %-5d | %-15s | %-5d |\n", i + 1, students.get(i).id,
                                students.get(i).name, students.get(i).age);
                    }
                    System.out.println("===========================================");
                    System.out.println();
                    break;
                default:
                    using = false;
                    scanner.close();
            }
        }
    }
}
