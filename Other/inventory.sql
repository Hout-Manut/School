DROP DATABASE IF EXISTS inventory;

CREATE DATABASE inventory;

USE inventory;

CREATE TABLE
    Customers (
        idCustomers INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(45) NOT NULL,
        phone VARCHAR(45) NOT NULL,
        email VARCHAR(45) NOT NULL,
        address VARCHAR(100) NOT NULL,
        PRIMARY KEY (idCustomers)
    );

CREATE TABLE
    Suppliers (
        idSuppliers INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(45) NOT NULL,
        contactPerson VARCHAR(45) NOT NULL,
        phone VARCHAR(45) NOT NULL,
        email VARCHAR(45) NOT NULL,
        address VARCHAR(100) NOT NULL,
        PRIMARY KEY (idSuppliers)
    );

CREATE TABLE
    Categories (
        idCategories INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(45) NOT NULL,
        type VARCHAR(45) NOT NULL,
        description VARCHAR(45) NOT NULL,
        PRIMARY KEY (idCategories)
    );

CREATE TABLE
    Products (
        idProducts INT NOT NULL AUTO_INCREMENT,
        idCategories INT NOT NULL,
        name VARCHAR(45) NOT NULL,
        description VARCHAR(45) NOT NULL,
        buyPrice DOUBLE NOT NULL,
        salePrice DOUBLE NOT NULL,
        PRIMARY KEY (idProducts),
        FOREIGN KEY (idCategories) REFERENCES Categories (idCategories)
    );

CREATE TABLE
    Warehouses (
        idWarehouses INT NOT NULL AUTO_INCREMENT,
        name VARCHAR(45) NOT NULL,
        address VARCHAR(100) NOT NULL,
        capacity INT NOT NULL,
        PRIMARY KEY (idWarehouses)
    );

CREATE TABLE
    Inventories (
        idInventories INT NOT NULL AUTO_INCREMENT,
        idProducts INT NOT NULL,
        idWarehouses INT NOT NULL,
        quantity INT NOT NULL,
        PRIMARY KEY (idInventories),
        FOREIGN KEY (idProducts) REFERENCES Products (idProducts),
        FOREIGN KEY (idWarehouses) REFERENCES Warehouses (idWarehouses)
    );

CREATE TABLE
    Employees (
        idEmployees INT NOT NULL AUTO_INCREMENT,
        idWarehouses INT NOT NULL,
        name VARCHAR(45) NOT NULL,
        position VARCHAR(45) NOT NULL,
        gender VARCHAR(45) NOT NULL,
        dateOfBirth DATE NOT NULL,
        dateHired DATE NOT NULL,
        phone VARCHAR(45) NOT NULL,
        email VARCHAR(45) NOT NULL,
        PRIMARY KEY (idEmployees),
        FOREIGN KEY (idWarehouses) REFERENCES Warehouses (idWarehouses)
    );

CREATE TABLE
    Purchases (
        idPurchases INT NOT NULL AUTO_INCREMENT,
        idSuppliers INT NOT NULL,
        idEmployees INT NOT NULL,
        date DATE NOT NULL,
        totalPrice DOUBLE NOT NULL,
        PRIMARY KEY (idPurchases),
        FOREIGN KEY (idSuppliers) REFERENCES Suppliers (idSuppliers),
        FOREIGN KEY (idEmployees) REFERENCES Employees (idEmployees)
    );

CREATE TABLE
    PurchaseDetails (
        idPurchaseDetails INT NOT NULL AUTO_INCREMENT,
        idPurchases INT NOT NULL,
        idProducts INT NOT NULL,
        quantity INT NOT NULL,
        pricePerItem DOUBLE NOT NULL,
        PRIMARY KEY (idPurchaseDetails),
        FOREIGN KEY (idPurchases) REFERENCES Purchases (idPurchases),
        FOREIGN KEY (idProducts) REFERENCES Products (idProducts)
    );

CREATE TABLE
    Orders (
        idOrders INT NOT NULL AUTO_INCREMENT,
        idCustomers INT NOT NULL,
        idEmployees INT NOT NULL,
        date DATE NOT NULL,
        totalPrice DOUBLE NOT NULL,
        status VARCHAR(20) NOT NULL,
        PRIMARY KEY (idOrders),
        FOREIGN KEY (idCustomers) REFERENCES Customers (idCustomers),
        FOREIGN KEY (idEmployees) REFERENCES Employees (idEmployees)
    );

CREATE TABLE
    OrderDetails (
        idOrderDetails INT NOT NULL AUTO_INCREMENT,
        idOrders INT NOT NULL,
        idProducts INT NOT NULL,
        quantity INT NOT NULL,
        pricePerItem DOUBLE NOT NULL,
        PRIMARY KEY (idOrderDetails),
        FOREIGN KEY (idOrders) REFERENCES Orders (idOrders),
        FOREIGN KEY (idProducts) REFERENCES Products (idProducts)
    );
