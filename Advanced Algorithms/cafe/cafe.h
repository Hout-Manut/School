#ifndef CAFE_H
#define CAFE_H

#include <iostream>
#include <string>
using namespace std;

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
        void removeMenuItem(string name);
        void updateMenuItem(string name, MenuItem item);
        void showMenu();
        void addOrder(Order &order);
    };

    struct MenuItem
    {
        string name;
        double priceSmall;
        double priceMedium;
        double priceLarge;
        int quantity;
    };

    struct Order
    {
        string name;
        int quantity;
        double price;
        string size;
        string status;
        string time;
        string date;
        string payment;
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