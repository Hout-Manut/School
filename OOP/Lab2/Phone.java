package Lab2;

public class Phone {
    class SmartPhone {
        String brand;
        String model;
        int price;
        String color;
        int storage;
        int year;
    }
    
    public static void main(String[] args) {
        Phone phone = new Phone();

        SmartPhone phone1 = phone.new SmartPhone();
        SmartPhone phone2 = phone.new SmartPhone();
        SmartPhone phone3 = phone.new SmartPhone();

        phone1.brand = "Samsung";
        phone1.model = "Galaxy S22 Ultra";
        phone1.price = 1500;
        phone1.color = "Black";
        phone1.storage = 512;
        phone1.year = 2021;

        phone2.brand = "Apple";
        phone2.model = "iPhone 12 Pro Max";
        phone2.price = 1300;
        phone2.color = "Pacific Blue";
        phone2.storage = 256;
        phone2.year = 2021;

        phone3.brand = "Xiaomi";
        phone3.model = "Mi 11";
        phone3.price = 1000;
        phone3.color = "White";
        phone3.storage = 128;

        SmartPhone[] phoneArr = new SmartPhone[3];
        phoneArr[0] = phone1;
        phoneArr[1] = phone2;
        phoneArr[2] = phone3;
    }
}
