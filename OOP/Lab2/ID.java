package Lab2;

public class ID {

    class IDCard {
    int id;
    String name;
    String address;
    String phone;
    int age;
    String nationality;
    }

    public static void main(String[] args) {
        ID id = new ID();

        IDCard idCard1 = id.new IDCard();
        IDCard idCard2 = id.new IDCard();
        IDCard idCard3 = id.new IDCard();

        idCard1.id = 123456789;
        idCard1.name = "John Doe";
        idCard1.address = "123 Main St";
        idCard1.phone = "555-1234";
        idCard1.age = 30;
        idCard1.nationality = "American";

        idCard2.id = 987654321;
        idCard2.name = "Jane Doe";
        idCard2.address = "456 Oak St";
        idCard2.phone = "555-5678";
        idCard2.age = 25;
        idCard2.nationality = "Canadian";

        idCard3.id = 333333333;
        idCard3.name = "Bob Smith";
        idCard3.address = "789 Elm St";
        idCard3.phone = "555-9999";
        idCard3.age = 35;
        idCard3.nationality = "American";

        IDCard[] idCardArr = new IDCard[3];
        idCardArr[0] = idCard1;
        idCardArr[1] = idCard2;
        idCardArr[2] = idCard3;
    }
}