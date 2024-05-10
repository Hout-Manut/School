DROP DATABASE IF EXISTS inventory;
CREATE DATABASE inventory;

USE inventory;

CREATE TABLE employees (
    emp_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    address VARCHAR(45) NOT NULL,
    dob DATE NOT NULL,
    pn VARCHAR(45) NOT NULL,
    job_title VARCHAR(45) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_id)
);


CREATE TABLE customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    address VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    phone VARCHAR(45) NOT NULL,
    PRIMARY KEY (customer_id)
);


CREATE TABLE suppliers (
    supplier_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    address VARCHAR(45) NOT NULL,
    contact_person VARCHAR(45) NOT NULL,
    conatct_email VARCHAR(45) NOT NULL,
    conatct_phone VARCHAR(45) NOT NULL,
    PRIMARY KEY (supplier_id)
);


CREATE TABLE category (
    id INT NOT NULL AUTO_INCREMENT,
    inventory_id INT NOT NULL,
    name VARCHAR(45) NOT NULL,
    type VARCHAR(45) NOT NULL,
    category_qty INT NOT NULL,
    PRIMARY KEY (id)
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
);


CREATE TABLE product (
    pid INT NOT NULL AUTO_INCREMENT,
    category_id INT NOT NULL,
    name VARCHAR(45) NOT NULL,
    qty INT NOT NULL,
    description VARCHAR(45) NOT NULL,
    price DOUBLE NOT NULL,
    PRIMARY KEY (pid)
    FOREIGN KEY (category_id) REFERENCES category(id)
);


CREATE TABLE inventory (
    id INT NOT NULL AUTO_INCREMENT,
    emp_id INT NOT NULL,
    category_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (id)
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
    FOREIGN KEY (category_id) REFERENCES category(id)
);


CREATE TABLE transactions (
    transaction_id INT NOT NULL AUTO_INCREMENT,
    product_id INT NOT NULL,
    employee_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    transaction_date DATE NOT NULL,
    quantity_change INT NOT NULL,
    totalPrice DOUBLE NOT NULL,
    PRIMARY KEY (transaction_id)
    FOREIGN KEY (product_id) REFERENCES product(idProduct)
    FOREIGN KEY (employee_id) REFERENCES employees(emp_id)
);


CREATE TABLE purchasedetail (
    idPurchaseDetail INT NOT NULL AUTO_INCREMENT,
    idPurchase INT NOT NULL,
    idProduct INT NOT NULL,
    quantity INT NOT NULL,
    pricePerItem DOUBLE NOT NULL,
    PRIMARY KEY (idPurchasedetail)
    FOREIGN KEY (idPurchase) REFERENCES purchase(idPurchase)
    FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

CREATE TABLE order (
    idOrder INT NOT NULL AUTO_INCREMENT,
    idCustomer INT NOT NULL,
    idEmployee INT NOT NULL,
    date DATE NOT NULL,
    totalPrice DOUBLE NOT NULL,
    address VARCHAR(45) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (idOrder)
    FOREIGN KEY (idCustomer) REFERENCES customer(idCustomer)
    FOREIGN KEY (idEmployee) REFERENCES employee(idEmployee)
);


CREATE TABLE orderdetail (
    idOrderDetail INT NOT NULL AUTO_INCREMENT,
    idOrder INT NOT NULL,
    idProduct INT NOT NULL,
    quantity INT NOT NULL,
    pricePerItem DOUBLE NOT NULL,
    PRIMARY KEY (idOrderDetail)
    FOREIGN KEY (idOrder) REFERENCES order(idOrder)
    FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);
