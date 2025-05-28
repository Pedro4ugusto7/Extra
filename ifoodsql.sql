CREATE DATABASE PROJETO;
USE PROJETO;
CREATE TABLE category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(100) NOT NULL,
    neighborhood VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    number INT NOT NULL,
    complement VARCHAR(100)
);

CREATE TABLE restaurant (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    address_id INT NOT NULL,
    opening_time TIME NOT NULL,
    rating DECIMAL(3,1),
    delivery_fee DECIMAL(6,2),
    preparation_time DECIMAL(4,2),
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (address_id) REFERENCES address(id)
);

CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    rating VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    description VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

CREATE TABLE addon (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    price DECIMAL(6,2) NOT NULL
);

CREATE TABLE coupon (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expiration_date DATE NOT NULL,
    discount_value DECIMAL(6,2) NOT NULL
);

CREATE TABLE order_status (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE payment_status (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE payment_method (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE order_table (
    id INT PRIMARY KEY AUTO_INCREMENT,
    total_value DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    delivery_fee DECIMAL(6,2) NOT NULL,
    address_id INT NOT NULL,
    coupon_id INT,
    restaurant_id INT NOT NULL,
    order_status_id INT NOT NULL,
    payment_status_id INT NOT NULL,
    payment_method_id INT NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id),
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (coupon_id) REFERENCES coupon(id),
    FOREIGN KEY (payment_status_id) REFERENCES payment_status(id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(id)
);

CREATE TABLE product_order (
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    PRIMARY KEY (product_id, order_id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (order_id) REFERENCES order_table(id)
);

CREATE TABLE product_order_addon (
    id INT PRIMARY KEY AUTO_INCREMENT,
    addon_id INT NOT NULL,
    type VARCHAR(100) NOT NULL,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    unit_price DECIMAL(6,2) NOT NULL,
    FOREIGN KEY (addon_id) REFERENCES addon(id),
    FOREIGN KEY (product_id, order_id) REFERENCES product_order(product_id, order_id)
);