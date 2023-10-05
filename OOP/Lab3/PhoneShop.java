package Lab3;

public class PhoneShop {
    class Category {
        String name;
    }

    class Product {
        String model;
        int year;
        int price;
        String color;
        int storage;
        Category category;

        void addProduct(String newModel, int newYear, int newPrice,
                String newColor, int newStorage, Category newCategory) {
            model = newModel;
            year = newYear;
            price = newPrice;
            color = newColor;
            storage = newStorage;
            category = newCategory;
        }

        void displayProducts() {
            System.out.println("Model: " + model);
            System.out.println("Year: " + year);
            System.out.println("Price: " + price);
            System.out.println("Color: " + color);
            System.out.println("Storage: " + storage);
            System.out.println("Category: " + category.name);
            System.out.println();

        }
    }

    public static void main(String[] args) {
        PhoneShop shop = new PhoneShop();

        Category category1 = shop.new Category();
        category1.name = "New Arrivals";

        Category category2 = shop.new Category();
        category2.name = "Best Sellers";

        Product product1 = shop.new Product();
        product1.addProduct("iPhone 15 Pro Max", 2023, 14000,
                "Black", 256, category1);

        Product product2 = shop.new Product();
        product2.addProduct("Samsung Galaxy S23", 2023, 11000,
                "White", 256, category1);

        Product product3 = shop.new Product();
        product3.addProduct("Xiaomi Mi 11", 2021, 800,
                "White", 128, category2);

        Product[] productArr = new Product[3];
        productArr[0] = product1;
        productArr[1] = product2;
        productArr[2] = product3;
        for (Product product : productArr) {
            product.displayProducts();
        }
    }
}
