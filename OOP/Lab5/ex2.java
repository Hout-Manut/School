package Lab5;

import java.util.Scanner;
import java.util.ArrayList;

class Student {
    public String id;
    public String name;
    public int age;

    public Student(String id, String name, int age) {
        this.id = id;
        this.name = name;
        this.age = age;
    }
}

public class ex2 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int studentCount = 0;
        int option;
        ArrayList<Student> students = new ArrayList<Student>();

        String id;
        String name;
        int age;
        boolean using = true;

        while (using){
        System.out.println("==== Menu ====");
        System.out.println("1. Add new students.");
        System.out.println("2. Delete multiple students.");
        System.out.println("3. Quit.");
        System.out.print("Choose an option: ");
        option = scanner.nextInt();
        System.out.println();
        switch (option) {
            case 1:
                while (true) {
                    System.out.println("Student #" + (studentCount + 1) + ":");
                    System.out.print("ID: ");
                    id = scanner.next();
                    System.out.print("Name: ");
                    name = scanner.next();
                    System.out.print("Age: ");
                    age = scanner.nextInt();
                    System.out.println();

                    Student student = new Student(id, name, age);
                    students.add(student);
                    studentCount++;

                    System.out.print("Do you wan to add more? (y/n): ");
                    String yes = scanner.next();
                    if (yes.equals("n"))
                        break;
                    System.out.println();
                }
                break;
            case 2:
                System.out.println("===========================================");
                System.out.println("| No    | ID    | Name            | Age   |");
                System.out.println("===========================================");
                for (int i = 0; i < studentCount; i++) {
                    System.out.printf("| %-5d | %-5s | %-15s | %-5d |\n", i + 1, students.get(i).id,
                            students.get(i).name,
                            students.get(i).age);
                }
                System.out.println("===========================================");
                System.out.println("==== Deletion ====");

                int deleteAmount = 0;
                String[] deleteId = new String[studentCount];
                String yes = new String();
                while (true) {
                    System.out.print("Input student #" + (deleteAmount + 1) + " ID: ");
                    deleteId[deleteAmount] = scanner.next();
                    deleteAmount++;
                    System.out.print("Do you want to delete more? (y/n): ");
                    yes = scanner.next();
                    if (yes.equals("n"))
                        break;
                    System.out.println();
                }

                for (int i = 0; i < deleteAmount; i++) {
                    boolean found = false;
                    for (int j = 0; j < studentCount; j++) {
                        if (deleteId[i].equals(students.get(j).id)) {
                            Student deletedStu = students.remove(j);
                            studentCount--;
                            System.out.println("Student with ID " + deletedStu.id + " deleted.");
                            found = true;
                            break;
                        }
                        if (!found) {
                            System.out.println("Student with ID " + deleteId[i] + " not found.");
                            break;
                        }
                    }
                }
                break;
            default:
                using = false;
                break;
                
        }
    }
        scanner.close();
    }
}
