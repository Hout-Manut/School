package Lab3;

public class BookStore {
    class Book {
        String title;
        long date;
        Author[] authors;
        int numOfAuthor = 0;
        int price;
        int pages;

        void addAuthor(Author author) {
            authors[numOfAuthor] = author;
            numOfAuthor++;
        }

        void displayBook() {
            System.out.println("Title: " + title);
            System.out.println("Date: " + date);
            System.out.println("Price: " + price);
            System.out.println("Pages: " + pages);
            System.out.println("Authors: ");
            for (int i = 0; i < numOfAuthor; i++) {
                System.out.println(authors[i].name + " " + authors[i].surname);
            }
        }
    }

    class Author {
        String name;
        String surname;
        int age;
        Book[] books;
        int numOfBooks = 0;

        void addBook(Book book) {
            books[numOfBooks] = book;
            numOfBooks++;
        }

        void displayAuthor() {
            System.out.println("Name: " + name);
            System.out.println("Surname: " + surname);
            System.out.println("Age: " + age);
            System.out.println("Books: ");
            for (int i = 0; i < numOfBooks; i++) {
                System.out.println(books[i].title);
            }
        }
    }

    public static void main(String[] args) {
        BookStore bookStore = new BookStore();
        Author author1 = bookStore.new Author();
        Author author2 = bookStore.new Author();
        Author author3 = bookStore.new Author();
        Book book1 = bookStore.new Book();
        Book book2 = bookStore.new Book();
        Book book3 = bookStore.new Book();
        Book book4 = bookStore.new Book();

        author1.name = "Arthur Weasley";
        author1.surname = "Potter";
        author1.age = 50;

        author2.name = "John Ronald Reuel Tolkien";
        author2.surname = "Tolkien";
        author2.age = 81;

        author3.name = "George R. R. Martin";
        author3.surname = "Martin";
        author3.age = 78;

        book1.title = "Harry Potter";
        book1.date = 1997;
        book1.price = 500;
        book1.pages = 400;
        book1.addAuthor(author1);

        

    }
}
