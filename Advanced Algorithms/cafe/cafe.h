#ifndef CAFE_H
#define CAFE_H

#include <string>

namespace cafe
{

    struct Product
    {
        int id;
        std::string name;
        double price;
        Product *next;

        Product(int id, std::string name, double price)
            : id(id), name(name), price(price), next(nullptr) {}
    };

    struct Order
    {
        int orderId;
        int productId;
        int quantity;
        Order *next;

        Order(int orderId, int productId, int quantity)
            : orderId(orderId), productId(productId), quantity(quantity), next(nullptr) {}
    };

    class ProductList
    {
    public:
        ProductList();
        ~ProductList();
        void addProduct(int id, std::string name, double price);
        void updateProduct(int id, std::string name, double price);
        void removeProduct(int id);
        Product *findProduct(int id);
        void displayProducts();

    private:
        Product *head;
    };

    class OrderList
    {
    public:
        OrderList();
        ~OrderList();
        void addOrder(int orderId, int productId, int quantity);
        void removeOrder(int orderId);
        Order *findOrder(int orderId);
        void displayOrders();

    private:
        Order *head;
    };
} // namespace cafe
#endif // CAFE_MANAGEMENT_H
