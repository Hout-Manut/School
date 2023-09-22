package Lab1;

public class ex4 {

    public class Person {
        String country, name, profession;
        int age;
    }

    static void printShelf() {
        System.out.println("+------------------+----------+-------------------+-----+");
    }

    public static void main(String[] args) {
        System.out.println("A:");

        int col = 10;
        int row = 5;

        System.out.print("    |");
        for (int i = 1; i <= col; i++)
            System.out.printf("%4d|", i);
        System.out.println("\n-------------------------------------------------------");
        for (int i = 1; i <= row; i++) {
            System.out.printf("%4d|", i);
            for (int j = 1; j <= col; j++)
                System.out.printf("%4d|", i * j);
            System.out.println();
        }
        // =========================================

        System.out.println("\nB:");
        ex4 obj = new ex4();
        Person[] people = new Person[4];

        people[0] = obj.new Person();
        people[0].name = "Michael";
        people[0].country = "Germany";
        people[0].profession = "Computer engineer";
        people[0].age = 19;

        people[1] = obj.new Person();
        people[1].name = "Robert";
        people[1].country = "England";
        people[1].profession = "Artist";
        people[1].age = 34;

        people[2] = obj.new Person();
        people[2].name = "Julia";
        people[2].country = "United Kingdom";
        people[2].profession = "Designer";
        people[2].age = 42;

        people[3] = obj.new Person();
        people[3].name = "Jo";
        people[3].country = "United States";
        people[3].profession = "Actor";
        people[3].age = 21;


        printShelf();
        System.out.println("| Country          | Nama     | Profession        | Age |");
        printShelf();
        for (int i = 0; i < 4; i++)
        {
            System.out.printf("| %-16s | %-8s | %-17s | %-3d |\n", people[i].country, people[i].name, people[i].profession, people[i].age);
            printShelf();
        }
    }
}