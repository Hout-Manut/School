#ifndef CAFE_H
#define CAFE_H

#include <iostream>
#include <string>

namespace cafe
{
    struct MenuItem;
    struct MenuItemNode;
    struct Order;
    struct OrderNode;

    class Cafe
    {
    private:
        MenuItemNode *menuHead;
        OrderNode *orderHead;

    public:
        Cafe();
        ~Cafe();

        void addMenuItem(MenuItem &item);
        void removeMenuItem(std::string name);
        void updateMenuItem(std::string name, MenuItem item);
        void showMenu();
        void addOrder(Order &order);
        void loadMenuItem();
    };

    struct MenuItem
    {
        int id;
        std::string name;
        double priceSmall;
        double priceMedium;
        double priceLarge;
        int quantity;
    };

    struct Order
    {
        int id;
        int productId;
        std::string name;
        std::string productName;
        int quantity;
        double price;
        std::string size;
        std::string status;
        std::string time;
        std::string date;
        std::string payment;
    };

    struct MenuItemNode
    {
        MenuItem data;
        MenuItemNode *next;
    };

    struct OrderNode
    {
        Order data;
        OrderNode *next;
    };
} // namespace cafe

#endif