
--BEGIN
--EXECUTE IMMEDIATE 'DROP TABLE ADDRESS CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE ZIPCODE CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE ORDER_PRODUCT CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE REVIEWS CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE PRODUCT CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE SUPPLIER CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE BILLING CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE PRODUCT_GROUP CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE PAYMENT CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEES CASCADE CONSTRAINTS';
--EXECUTE IMMEDIATE 'DROP TABLE VOUCHER CASCADE CONSTRAINTS';
--EXCEPTION
--WHEN OTHERS
--THEN NULL;
--END;
--COMMIT;


--Create table Statements
Create table Zipcode(
zipcode_id number(5) PRIMARY KEY,
state varchar(20),
city varchar(20),
zipcode varchar(5)
);

Create table Customer(
customer_id number(20) PRIMARY KEY,
first_name varchar(20),
last_name varchar(20),
email_id varchar(50),
phone_number varchar(10),
customer_type varchar(20)
);


create table Supplier(
supplier_id number(20) primary key,
supplier_name varchar(20),
supply_quantity number(10)
);

create table product_group(
group_id number(20) primary key,
group_name varchar(50)
);

create table Voucher(
voucher_id number(20) primary key,
voucher_code varchar(20),
discounts number(2)
);

create table Employee(
employee_id number(20) primary key,
employee_name varchar(50),
designation varchar(20),
join_date Date,
salary float
);

create table Reviews(
review_id number(20) primary key,
quality_rating number(2),
defect_percentage number(2),
review_desc varchar(120),
review_date Date
);

Create table Address
(
address_id number(20) PRIMARY KEY,
address_line1 varchar(50),
address_line2 varchar(50),
customer_id number(20),
CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
    REFERENCES CUSTOMER(customer_id),
zipcode_id number(5),
CONSTRAINT fk_zipcode
    FOREIGN KEY (zipcode_id)
    REFERENCES ZIPCODE(zipcode_id)
);


create table Product(
product_id number(20) primary key,
review_id number(20),
CONSTRAINT fk_review_id
    FOREIGN KEY (review_id)
    REFERENCES REVIEWS(review_id),
supplier_id number(20),
CONSTRAINT fk_supplier_id
    FOREIGN KEY (supplier_id)
    REFERENCES SUPPLIER(supplier_id),
group_id number(20),
CONSTRAINT fk_group_id
    FOREIGN KEY (group_id)
    REFERENCES PRODUCT_GROUP(group_id),
product_name varchar(20),
available_number varchar(5),
status varchar(50),
price number(5),
shipment_duration varchar(50),
weight float,
width float,
color varchar(20),
height float
);


create table payment(
payment_id number(20) primary key,
customer_id number(20),
CONSTRAINT fk_customer_id
    FOREIGN KEY (customer_id)
    REFERENCES CUSTOMER(customer_id),
payment_mode varchar(20),
card_type varchar(20),
card_number varchar(20),
cardholder_name varchar(50),
order_date date,
voucher_id number(20),
CONSTRAINT fk_voucher_id
    FOREIGN KEY (voucher_id)
    REFERENCES voucher(voucher_id),
amount_paid float
);

create table order_product(
order_product_id number(20) primary key,
product_id number(20),
CONSTRAINT fk_product_id
    FOREIGN KEY (product_id)
    REFERENCES PRODUCT(product_id),
payment_id number(20),
CONSTRAINT fk_payment_id
    FOREIGN KEY (payment_id)
    REFERENCES PAYMENT(payment_id),
employee_id number(20),
CONSTRAINT fk_employee_id
    FOREIGN KEY (employee_id)
    REFERENCES EMPLOYEE(employee_id),
quantity number(5)
);

COMMIT;







