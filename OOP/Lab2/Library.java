package Lab2;

public class Library {
    class Book {
        String title;
        String author;
        int year;
        int price;
        String category;
    }

    public static void main(String[] args) {
        Library lib = new Library();

        Book book1 = lib.new Book();
        Book book2 = lib.new Book();
        Book book3 = lib.new Book();

        book1.title = "Harry Potter";
        book1.author = "Arthur Weasley";
        book1.year = 1997;
        book1.price = 150;
        book1.category = "Fantasy";

        book2.title = "The Hobbit";
        book2.author = "John Ronald Reuel Tolkien";
        book2.year = 1999;
        book2.price = 200;
        book2.category = "Fantasy";

        book3.title = "The Lord of the Rings";
        book3.author = "John Ronald Reuel Tolkien";
        book3.year = 1999;
        book3.price = 250;
        book3.category = "Fantasy";

        Book[] bookArr = new Book[3];
        bookArr[0] = book1;
        bookArr[1] = book2;
        bookArr[2] = book3;
    }
}
