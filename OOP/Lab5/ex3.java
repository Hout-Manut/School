package Lab5;

import java.util.Scanner;

class Line {
    private static int count;
    private int length;

    public Line(int length) {
        this.length = length;
        count++;
    }

    public void displayLine() {
        for (int i = 0; i < length; i++)
            System.out.print("_");
        System.out.println();
    }

    public static int getCount() {
        return count;
    }
}

class Rectangle {
    private static int count;
    private int length;
    private int width;

    public Rectangle(int length, int width) {
        this.length = length;
        this.width = width;
        count++;
    }

    public void displayRectangle() {
        for (int i = 0; i < length; i++) {
            for (int j = 0; j < width; j++)
                System.out.print("* ");
            System.out.println();
        }
        System.out.println();
    }

    public static int getCount() {
        return count;
    }
}

class Triangle {
    private static int count;
    private int base;
    private int height;

    public Triangle(int base, int height) {
        this.base = base;
        this.height = height;
        count++;
    }

    public void displayTriangle() {
        for (int i = this.height; i > 0; i--) {
            for (int j = 0; j < i; j++)
                System.out.print(" ");
            for (int j = base; j < he; j--)
                System.out.print("*");
            System.out.println();
        }
        System.out.println();

    }

    public static int getCount() {
        return count;
    }
}

class Menu {

    public static void main() {
        Line line1 = new Line(10);
        Rectangle rectangle1 = new Rectangle(5, 3);
        Triangle triangle1 = new Triangle(10, 5);

        line1.displayLine();
        rectangle1.displayRectangle();
        triangle1.displayTriangle();
    }
}

public class ex3 {
    public static void main(String[] args) {
        Menu.main();
    }

}
