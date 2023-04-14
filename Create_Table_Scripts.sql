--CLEANUP SCRIPT
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'ORDER_PRODUCT' table_name from dual union all
             select 'PAYMENT' table_name from dual union all
             select 'PRODUCT' table_name from dual union all
             select 'ADDRESS' table_name from dual union all
             select 'REVIEWS' table_name from dual union all
             select 'EMPLOYEE' table_name from dual union all
             select 'VOUCHER' table_name from dual union all
             select 'PRODUCT_GROUP' table_name from dual union all
             select 'SUPPLIER' table_name from dual union all
             select 'CUSTOMER' table_name from dual union all
             select 'ZIPCODE' table_name from dual
   )
   loop
   dbms_output.put_line('....Drop table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name;
       execute immediate v_sql;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/
COMMIT;
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

truncate table Zipcode;
truncate table Customer;
truncate table Supplier;
truncate table product_group;
truncate table Voucher;
truncate table Employee;
truncate table Reviews;
truncate table Address;
truncate table Product;
truncate table Payment;
truncate table order_product;

-- Script to insert values in tables
--truncate table Zipcode;

INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(1, 'California', 'Los Angeles', '90001');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(2, 'California', 'San Francisco', '94102');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(3, 'California', 'San Diego', '92101');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(4, 'New York', 'New York City', '10001');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(5, 'New York', 'Albany', '12201');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(6, 'New York', 'Buffalo', '14201');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(7, 'Texas', 'Houston', '77001');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(8, 'Texas', 'Dallas', '75201');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(9, 'Texas', 'Austin', '78701');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(10, 'Florida', 'Miami', '33101');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(11, 'Florida', 'Tampa', '33601');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(12, 'Florida', 'Orlando', '32801');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(13, 'Illinois', 'Chicago', '60601');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(14, 'Illinois', 'Springfield', '62701');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(15, 'Illinois', 'Peoria', '61601');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(16, 'Ohio', 'Columbus', '43201');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(17, 'Ohio', 'Cleveland', '44101');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(18, 'Ohio', 'Cincinnati', '45201');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(19, 'Washington', 'Seattle', '98101');
INSERT INTO Zipcode (zipcode_id, state, city, zipcode) VALUES(20, 'Washington', 'Spokane', '99201');
COMMIT;

--truncate table customer;
INSERT INTO Customer VALUES (1, 'John', 'Doe', 'johndoe@email.com', '1234567890', 'Student');
INSERT INTO Customer VALUES (2, 'Jane', 'Smith', 'janesmith@email.com', '2345678901', 'Faculty');
INSERT INTO Customer VALUES (3, 'David', 'Lee', 'davidlee@email.com', '3456789012', 'Student');
INSERT INTO Customer VALUES (4, 'Sarah', 'Johnson', 'sarahjohnson@email.com', '4567890123', 'Faculty');
INSERT INTO Customer VALUES (5, 'Michael', 'Brown', 'michaelbrown@email.com', '5678901234', 'Student');
INSERT INTO Customer VALUES (6, 'Amy', 'Davis', 'amydavis@email.com', '6789012345', 'Faculty');
INSERT INTO Customer VALUES (7, 'Peter', 'Nguyen', 'peternguyen@email.com', '7890123456', 'Student');
INSERT INTO Customer VALUES (8, 'Melissa', 'Garcia', 'melissagarcia@email.com', '8901234567', 'Faculty');
INSERT INTO Customer VALUES (9, 'Kevin', 'Jackson', 'kevinjackson@email.com', '9012345678', 'Student');
INSERT INTO Customer VALUES (10, 'Emily', 'Kim', 'emilykim@email.com', '0123456789', 'Faculty');
INSERT INTO Customer VALUES (11, 'Daniel', 'Wilson', 'danielwilson@email.com', '1234567890', 'Faculty');
INSERT INTO Customer VALUES (12, 'Maria', 'Martinez', 'mariamartinez@email.com', '2345678901', 'Student');
INSERT INTO Customer VALUES (13, 'Brian', 'Chen', 'brianchen@email.com', '3456789012', 'Faculty');
INSERT INTO Customer VALUES (14, 'Cynthia', 'Lopez', 'cynthialopez@email.com', '4567890123', 'Student');
INSERT INTO Customer VALUES (15, 'Thomas', 'Gonzalez', 'thomasgonzalez@email.com', '5678901234', 'Faculty');
INSERT INTO Customer VALUES (16, 'Jennifer', 'Martin', 'jennifermartin@email.com', '6789012345', 'Student');
INSERT INTO Customer VALUES (17, 'Steven', 'Lee', 'stevenlee@email.com', '7890123456', 'Faculty');
INSERT INTO Customer VALUES (18, 'Jessica', 'Hernandez', 'jessicahernandez@email.com', '8901234567', 'Student');
INSERT INTO Customer VALUES (19, 'Christopher', 'Gomez', 'christophergomez@email.com', '9012345678', 'Faculty');
INSERT INTO Customer VALUES (20, 'Kimberly', 'Perez', 'kimberlyperez@email.com', '0123456789', 'Student');
COMMIT;

INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (1, 'ABC Inc.', 500);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (2, 'XYZ Corp.', 1000);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (3, 'PQR Enterprises', 750);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (4, 'LMN Corp.', 1500);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (5, 'DEF Industries', 800);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (6, 'GHI Manufacturing', 900);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (7, 'JKL Enterprises', 1200);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (8, 'MNO Inc.', 600);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (9, 'QRS Corp.', 1100);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (10, 'STU Industries', 850);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (11, 'VWX Inc.', 950);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (12, 'YZA Enterprises', 1300);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (13, 'BCD Corp.', 700);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (14, 'EFG Manufacturing', 1000);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (15, 'HIJ Industries', 1250);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (16, 'KLM Enterprises', 900);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (17, 'NOP Inc.', 650);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (18, 'QRT Corp.', 800);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (19, 'UVW Industries', 950);
INSERT INTO Supplier (supplier_id, supplier_name, supply_quantity)
VALUES (20, 'XYZ Enterprises', 1100);
COMMIT;


INSERT INTO product_group (group_id, group_name)
VALUES (1, 'Electronics');
INSERT INTO product_group (group_id, group_name)
VALUES (2, 'Home Appliances');
INSERT INTO product_group (group_id, group_name)
VALUES (3, 'Clothing');
INSERT INTO product_group (group_id, group_name)
VALUES (4, 'Books');
INSERT INTO product_group (group_id, group_name)
VALUES (5, 'Office Supplies');
INSERT INTO product_group (group_id, group_name)
VALUES (6, 'Toys');
INSERT INTO product_group (group_id, group_name)
VALUES (7, 'Sports and Fitness');
INSERT INTO product_group (group_id, group_name)
VALUES (8, 'Health and Beauty');
INSERT INTO product_group (group_id, group_name)
VALUES (9, 'Automotive');
INSERT INTO product_group (group_id, group_name)
VALUES (10, 'Pet Supplies');
INSERT INTO product_group (group_id, group_name)
VALUES (11, 'Jewelry');
INSERT INTO product_group (group_id, group_name)
VALUES (12, 'Furniture');
INSERT INTO product_group (group_id, group_name)
VALUES (13, 'Music');
INSERT INTO product_group (group_id, group_name)
VALUES (14, 'Movies');
INSERT INTO product_group (group_id, group_name)
VALUES (15, 'Food and Beverages');
INSERT INTO product_group (group_id, group_name)
VALUES (16, 'Baby and Kids');
INSERT INTO product_group (group_id, group_name)
VALUES (17, 'Outdoor and Garden');
INSERT INTO product_group (group_id, group_name)
VALUES (18, 'Tools and Hardware');
INSERT INTO product_group (group_id, group_name)
VALUES (19, 'Travel and Luggage');
INSERT INTO product_group (group_id, group_name)
VALUES (20, 'Gifts and Collectibles');
COMMIT;

INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (1, 'ABC123', 10);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (2, 'DEF456', 20);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (3, 'GHI789', 30);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (4, 'JKL012', 40);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (5, 'MNO345', 50);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (6, 'PQR678', 10);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (7, 'STU901', 20);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (8, 'VWX234', 30);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (9, 'YZA567', 40);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (10, 'BCD890', 50);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (11, 'EFG123', 10);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (12, 'HIJ456', 20);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (13, 'KLM789', 30);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (14, 'NOP012', 40);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (15, 'QRS345', 50);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (16, 'TUV678', 10);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (17, 'WXY901', 20);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (18, 'ZAB234', 30);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (19, 'CDE567', 40);
INSERT INTO Voucher (voucher_id, voucher_code, discounts) VALUES (20, 'FGH890', 50);
COMMIT;

INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (1, 'John Doe', 'Manager', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 10000);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (2, 'Jane Smith', 'Sales', TO_DATE('2022-02-01', 'YYYY-MM-DD'), 8000);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (3, 'David Lee',  'Sales', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 7000);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (4, 'Sarah Johnson', 'Sales', TO_DATE('2022-04-01', 'YYYY-MM-DD'), 6000);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (5, 'Mike Brown', 'Sales', TO_DATE('2022-05-01', 'YYYY-MM-DD'), 5500);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (6, 'Emily Davis',  'Sales', TO_DATE('2022-06-01', 'YYYY-MM-DD'), 9000);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (7, 'Kevin Kim',  'Sales', TO_DATE('2022-07-01', 'YYYY-MM-DD'), 5000);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (8, 'Linda Wang',  'Sales', TO_DATE('2022-08-01', 'YYYY-MM-DD'), 8500);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (9, 'Robert Chen',  'Sales', TO_DATE('2022-09-01', 'YYYY-MM-DD'), 6000);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (10, 'Amy Lee',  'Sales', TO_DATE('2022-10-01', 'YYYY-MM-DD'), 9500);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (11, 'Erica Nguyen', 'Sales', TO_DATE('2022-11-01', 'YYYY-MM-DD'), 6500);
INSERT INTO Employee (employee_id, employee_name, designation, join_date, salary) VALUES (12, 'Chris Johnson', 'Sales', TO_DATE('2022-12-01', 'YYYY-MM-DD'), 10000);
COMMIT;

INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (1, 4, 2, 'Great product, works as advertised!', to_date('2022-01-05','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (2, 3, 5, 'Product had some minor defects but overall satisfied.', to_date('2022-02-10','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (3, 5, 0, 'Absolutely love this product! Best purchase ever.', to_date('2022-03-15','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (4, 2, 10, 'Product arrived damaged, disappointed with quality.', to_date('2022-04-20','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (5, 4, 3, 'Works well but had some minor issues with delivery.', to_date('2022-05-25','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (6, 5, 0, 'Incredible product, exceeded my expectations!', to_date('2022-06-30','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (7, 3, 5, 'Product had some defects but customer service was helpful in resolving the issue.', to_date('2022-07-05','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (8, 4, 2, 'Great product, would highly recommend to others.', to_date('2022-08-10','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (9, 2, 8, 'Product did not work properly, had to return it for a refund.', to_date('2022-09-15','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (10, 4, 1, 'Product is of good quality, arrived in a timely manner.', to_date('2022-10-20','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (11, 3, 4, 'Product had some minor issues but was able to fix them myself.', to_date('2022-11-25','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (12, 5, 0, 'Product exceeded my expectations, would purchase again!', to_date('2022-12-30','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (13, 4, 2, 'Good product overall, but had some issues with delivery.', to_date('2023-01-05','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (14, 2, 10, 'Product was not as described, disappointed with purchase.', to_date('2023-02-10','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (15, 5, 0, 'Amazing product, could not be happier with my purchase!', to_date('2023-03-15','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (16, 3, 5, 'Product had some defects, but customer service was able to assist in resolving the issue.', to_date('2023-04-20','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (17, 4, 2, 'Great product, would definitely recommend to others!', to_date('2023-05-25','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (18, 2, 8, 'Product did not work properly, had to return it for a replacement.', to_date('2023-06-30','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (19, 5, 0, 'Product exceeded my expectations, could not be happier!', to_date('2023-07-05','YYYY-MM-DD'));
INSERT INTO Reviews (review_id, quality_rating, defect_percentage, review_desc, review_date) VALUES (20, 3, 4, 'Product had some minor issues, but overall satisfied with purchase.', to_date('2023-08-10','YYYY-MM-DD'));
COMMIT;

INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (1, '123 Main St', 'Apt 1', 1, 1);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (2, '456 Broadway', 'Suite 2', 2, 4);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (3, '789 Main St', 'Unit 3', 3, 2);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (4, '321 Elm St', '', 4, 10);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (5, '555 Oak St', 'Apt 5B', 5, 13);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (6, '777 Walnut Ave', '', 6, 16);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (7, '999 Pine St', 'Unit 7', 7, 19);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (8, '234 Main St', 'Apt 2B', 8, 3);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (9, '567 Park Ave', '', 9, 4);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (10, '890 Elm St', 'Suite 4', 10, 8);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (11, '432 Maple St', '', 11, 11);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (12, '654 Oak St', 'Unit 6', 12, 14);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (13, '876 Walnut Ave', 'Apt 3C', 13, 17);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (14, '1098 Pine St', '', 14, 19);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (15, '135 Main St', 'Unit 8', 15, 20);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (16, '246 Broadway', '', 16, 5);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (17, '357 Main St', 'Apt 3A', 17, 9);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (18, '468 Elm St', '', 18, 12);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (19, '579 Oak St', 'Suite 5', 19, 15);
INSERT INTO Address (address_id, address_line1, address_line2, customer_id, zipcode_id)
VALUES (20, '690 Walnut Ave', 'Unit 9', 20, 18);
COMMIT;

INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (1, 4, 10, 6, 'Rough Book', '50', 'ordered', 3.99, '3-5 days', 0.5, 8.5, 'White', 11.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (2, 12, 17, 1, 'Cup', '20', 'delivered', 9.99, '2-3 days', 0.3, 3.5, 'Blue', 4.5);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (3, 9, 7, 5, 'T-shirt', '30', 'ordered', 19.99, '5-7 days', 0.6, 10.0, 'Black', 8.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (4, 18, 2, 12, 'Notepad', '40', 'ordered', 1.99, '3-5 days', 0.2, 6.0, 'Yellow', 9.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (5, 15, 19, 8, 'Mug', '10', 'delivered', 7.99, '2-3 days', 0.4, 4.5, 'Red', 4.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (6, 2, 8, 9, 'Pen', '100', 'ordered', 0.99, '3-5 days', 0.1, 1.0, 'Black', 14.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (7, 7, 14, 2, 'Highlighter', '50', 'delivered', 2.49, '2-3 days', 0.1, 1.5, 'Yellow', 11.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (8, 11, 16, 18, 'Eraser', '30', 'ordered', 0.49, '3-5 days', 0.05, 2.0, 'Pink', 6.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (9, 13, 3, 16, 'Pencil', '75', 'ordered', 0.29, '3-5 days', 0.1, 1.0, 'Green', 15.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (10, 5, 18, 11, 'Scissors', '20', 'delivered', 4.99, '2-3 days', 0.3, 4.5, 'Black', 4.5);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (11, 20, 9, 7, 'Stapler', '10', 'ordered', 6.99, '3-5 days', 0.7, 6.0, 'Silver', 3.5);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (12, 6, 1, 19, 'Calculator', '5', 'delivered', 14.99, '2-3 days', 0.5, 4.0, 'Black', 2.0);
INSERT INTO Product(product_id, review_id, supplier_id, group_id, product_name, available_number, status, price, shipment_duration, weight, width, color, height)
VALUES (13, 1, 1, 7, 'Marker', '35', 'ordered', 3.99, '2-3 days', 0.2, 4.0, 'Black', 5.0);
COMMIT;


INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id,  amount_paid)
VALUES (1, 5,  'credit', 'visa', '1234-5678-9012-3456', 'John Smith', to_date('2022-05-15','YYYY-MM-DD'), 10,  50.00);

INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id,  amount_paid)
VALUES (2, 9, 'cash', NULL, NULL, NULL, to_date('2022-01-21','YYYY-MM-DD'), NULL,  25.50);

INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id,  amount_paid)
VALUES (3, 12, 'debit', 'mastercard', '9876-5432-1098-7654', 'Emily Davis', to_date('2022-03-12','YYYY-MM-DD'), NULL,  30.00);

INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id,  amount_paid)
VALUES (4, 7, 'credit', 'amex', '2468-1357-9135-2468', 'Michael Johnson', to_date('2022-08-05','YYYY-MM-DD'), 5,  20.00);

INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id, amount_paid)
VALUES (5, 16, 'cash', NULL, NULL, NULL, to_date('2022-11-18','YYYY-MM-DD'), NULL,  12.75);

INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id, amount_paid)
VALUES (6, 1,  'debit', 'visa', '5555-5555-5555-4444', 'Sarah Lee', to_date('2022-02-08','YYYY-MM-DD'), NULL,  45.00);

INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id,  amount_paid)
VALUES (7, 20,  'credit', 'mastercard', '1111-2222-3333-4444', 'David Kim', to_date('2022-06-23','YYYY-MM-DD'), 7,  75.00);

INSERT INTO payment (payment_id, customer_id,  payment_mode, card_type, card_number, cardholder_name, order_date, voucher_id,  amount_paid)
VALUES (8, 4, 'cash', NULL, NULL, NULL, to_date('2022-09-14','YYYY-MM-DD'), NULL, 16.50);
COMMIT;

--truncate table order_product;
INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (1, 5, 3, 8, 10);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (2, 2, 4,  3, 5);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (3, 7, 2, 9, 2);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (4, 11, 1, 5, 1);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (5, 9, 3, 2, 8);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (6, 6, 5, 3, 3);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (7, 1, 5, 6, 6);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (8, 10, 7, 7, 12);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (9, 12, 8, 10, 4);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (10, 4, 2, 4, 7);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (11, 8, 1, 12, 2);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (12, 3, 6, 2, 9);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (13, 13, 4, 4, 1);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (14, 1, 2, 5, 3);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (15, 2, 1, 8, 6);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (16, 7, 8, 2, 8);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (17, 11, 6, 10, 5);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (18, 9, 1, 7, 2);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (19, 6, 4, 3, 11);

INSERT INTO order_product (order_product_id, product_id, payment_id, employee_id, quantity)
VALUES (20, 4, 2, 12, 3);
COMMIT;
 


CREATE OR REPLACE VIEW CUSTOMER_VIEW AS
SELECT customer_id, first_name || ' ' || last_name AS customer_name, customer_type
FROM customer;
COMMIT;

CREATE OR REPLACE VIEW PRODUCT_COLOR_VIEW AS
SELECT product_name, color
FROM product;
COMMIT;


CREATE OR REPLACE VIEW PRODUCT_VIEW AS
SELECT p.review_id, p.product_name, r.review_desc,
  LISTAGG(r.quality_rating, ';') WITHIN GROUP (ORDER BY r.quality_rating) AS product_rating
FROM REVIEWS r
JOIN PRODUCT p
  ON r.review_id = p.review_id
GROUP BY p.review_id, p.product_name, r.review_desc
ORDER BY p.review_id;
COMMIT;

CREATE OR REPLACE VIEW CUSTOMER_ORDER_HISTORY AS
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS customer_name, p.product_name, pay.order_date, SUM(o.quantity) as quantity, SUM(pay.amount_paid) as amount_paid
FROM Customer c
JOIN Payment pay ON c.customer_id = pay.customer_id
JOIN order_product o ON pay.payment_id = o.payment_id
JOIN Product p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name, p.product_name, pay.order_date
ORDER BY c.customer_id;

COMMIT;

CREATE OR REPLACE VIEW EMPLOYEE_SALES_VIEW AS
SELECT e.employee_id, e.employee_name, TRUNC(p.order_date, 'IW') as week, SUM(op.quantity * p.amount_paid) as weekly_sales
FROM order_product op
JOIN payment p ON op.payment_id = p.payment_id
JOIN employee e ON op.employee_id = e.employee_id
GROUP BY e.employee_id, e.employee_name, TRUNC(p.order_date, 'IW')
HAVING SUM(op.quantity * p.amount_paid) > 10;
COMMIT;

CREATE OR REPLACE VIEW REVENUE_BY_PAYMENT_MODE AS
SELECT payment_mode, SUM(amount_paid) AS total_revenue
FROM payment
GROUP BY payment_mode;
COMMIT;

CREATE OR REPLACE VIEW EMPLOYEE_CUSTOMER_COUNT_VIEW AS
SELECT e.employee_id, e.employee_name, COUNT(DISTINCT op.payment_id) AS num_of_customers
FROM employee e
JOIN order_product op ON e.employee_id = op.employee_id
GROUP BY e.employee_id, e.employee_name order by e.employee_id;
COMMIT;

CREATE OR REPLACE VIEW EMPLOYEE_SALARY_VIEW AS
SELECT designation, employee_name, salary
FROM employee
ORDER BY designation, employee_name;
COMMIT;

--Stored Procedures
-- Create new customer
CREATE OR REPLACE PROCEDURE create_newcustomer (
    p_customer_id   IN customer.customer_id%TYPE,
    p_first_name    IN customer.first_name%TYPE,
    p_last_name     IN customer.last_name%TYPE,
    p_email_id      IN customer.email_id%TYPE,
    p_phone_number  IN customer.phone_number%TYPE,
    p_customer_type IN customer.customer_type%TYPE
) AS
    l_count NUMBER;
BEGIN
  -- Check if customer already exists
    SELECT
        COUNT(*)
    INTO l_count
    FROM
        customer
    WHERE
        customer_id = p_customer_id;

    IF l_count > 0 THEN
        raise_application_error(-20001, 'Customer already exists.');
    ELSE
    -- Perform validation on customer data
        IF p_first_name IS NULL OR p_last_name IS NULL OR p_email_id IS NULL OR p_phone_number IS NULL OR p_customer_type IS NULL THEN
            raise_application_error(-20002, 'Invalid customer data.');
            dbms_output.put_line('Invalid customer data.');
        ELSE
      -- Insert new customer into the table
            INSERT INTO customer (
                customer_id,
                first_name,
                last_name,
                email_id,
                phone_number,
                customer_type
            ) VALUES (
                p_customer_id,
                p_first_name,
                p_last_name,
                p_email_id,
                p_phone_number,
                p_customer_type
            );

            dbms_output.put_line('New customer created successfully.');
            COMMIT;
        END IF;
    END IF;

EXCEPTION
  -- Handle exceptions
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Errors: '
                             || sqlcode
                             || ' - '
                             || sqlerrm);
END;

-- update customers

CREATE OR REPLACE PROCEDURE update_customers (
    p_customer_id   IN NUMBER,
    p_first_name    IN VARCHAR2,
    p_last_name     IN VARCHAR2,
    p_email_id      IN VARCHAR2,
    p_phone_number  IN VARCHAR2,
    p_customer_type IN VARCHAR2
) IS
    v_customer_count NUMBER;
BEGIN
    IF p_customer_id IS NULL OR p_first_name IS NULL OR p_last_name IS NULL OR p_email_id IS NULL OR p_phone_number IS NULL OR p_customer_type
    IS NULL THEN
        raise_application_error(-20002, 'Invalid customer data.');
        dbms_output.put_line('Invalid customer data.');
    ELSE
        -- Check if the customer exists
        SELECT
            COUNT(*)
        INTO v_customer_count
        FROM
            customer
        WHERE
            customer_id = p_customer_id;

        IF v_customer_count = 0 THEN
            -- Customer does not exist, raise an error
            raise_application_error(-20001, 'Customer does not exist.');
        ELSE
            -- Update the customer record
            UPDATE customer
            SET
                first_name = coalesce(p_first_name, first_name),
                last_name = coalesce(p_last_name, last_name),
                email_id = coalesce(p_email_id, email_id),
                phone_number = coalesce(p_phone_number, phone_number),
                customer_type = coalesce(p_customer_type, customer_type)
            WHERE
                customer_id = p_customer_id;

            COMMIT;
            dbms_output.put_line('Customer record updated successfully.');
        END IF;

    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error and rollback the transaction
        dbms_output.put_line('Error: ' || sqlerrm);
        ROLLBACK;
END;



--delete customer 
CREATE OR REPLACE PROCEDURE delete_customer (
    p_customer_id IN customer.customer_id%TYPE
) IS
    v_count NUMBER;
BEGIN
-- Check if p_customer_id is null
    IF p_customer_id IS NULL THEN
        raise_application_error(-20002, 'Customer ID is null');
    END IF;

-- Check if customer exists
    SELECT
        COUNT(*)
    INTO v_count
    FROM
        customer
    WHERE
        customer_id = p_customer_id;

    IF v_count = 0 THEN
-- Raise an exception if customer does not exist
        raise_application_error(-20001, 'Customer does not exist');
    ELSE
-- Delete the customer
        DELETE FROM customer
        WHERE
            customer_id = p_customer_id;

        dbms_output.put_line('Customer deleted successfully');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
-- Handle any other exceptions
        dbms_output.put_line('Error: ' || sqlerrm);
END;
/

-- Update procedure to update availability of quantity

CREATE OR REPLACE PROCEDURE update_product_quantity (
    p_product_id IN NUMBER,
    p_quantity   IN NUMBER
) IS
    v_available_number NUMBER;
BEGIN
    SELECT
        available_number
    INTO v_available_number
    FROM
        product
    WHERE
        product_id = p_product_id;

    IF v_available_number >= p_quantity THEN
        UPDATE product
        SET
            available_number = available_number - p_quantity
        WHERE
            product_id = p_product_id;

    ELSE
        raise_application_error(-20001, 'Not enough products available');
    END IF;

END;

-- Get employee details from employee id

CREATE OR REPLACE PROCEDURE get_employee_details (
    p_employee_id IN NUMBER
) IS
  -- Declare cursor
    CURSOR emp_cursor IS
    SELECT
        employee_id,
        employee_name,
        join_date
    FROM
        employee
    WHERE
        employee_id = p_employee_id;

  -- Declare variables to store data
    v_employee_id   employee.employee_id%TYPE;
    v_employee_name employee.employee_name%TYPE;
    v_join_date     employee.join_date%TYPE;
BEGIN
  -- Open cursor
    OPEN emp_cursor;

  -- Fetch data
    FETCH emp_cursor INTO
        v_employee_id,
        v_employee_name,
        v_join_date;

  -- Close cursor
    CLOSE emp_cursor;

  -- Display data
    dbms_output.put_line('Employee ID: ' || v_employee_id);
    dbms_output.put_line('First Name: ' || v_employee_name);
    dbms_output.put_line('Hire Date: ' || v_join_date);
END;

-- get all products

CREATE OR REPLACE PROCEDURE get_all_products IS
    CURSOR product_cursor IS
    SELECT
        *
    FROM
        product;

BEGIN
    FOR product_rec IN product_cursor LOOP
        dbms_output.put_line('Product ID: '
                             || product_rec.product_id
                             || ', Name: '
                             || product_rec.product_name
                             || ', Price: '
                             || product_rec.price
                             || ', Available: '
                             || product_rec.available_number);
    END LOOP;
END;

-- get all customers who have applied voucher

CREATE OR REPLACE PROCEDURE get_customers_using_voucher IS
BEGIN
    FOR customer IN (
        SELECT
            c.first_name,
            c.last_name,
            c.email_id,
            c.phone_number
        FROM
                 customer c
            JOIN payment p ON c.customer_id = p.customer_id
        WHERE
            p.voucher_id IS NOT NULL
    ) LOOP
        dbms_output.put_line(customer.first_name
                             || ' '
                             || customer.last_name
                             || ', '
                             || customer.email_id
                             || ', '
                             || customer.phone_number);
    END LOOP;
END;


--Insert/Create new products 
CREATE OR REPLACE PROCEDURE insert_product (
    p_product_id        IN product.product_id%TYPE,
    p_review_id         IN product.review_id%TYPE,
    p_supplier_id       IN product.supplier_id%TYPE,
    p_group_id          IN product.group_id%TYPE,
    p_product_name      IN product.product_name%TYPE,
    p_available_number  IN product.available_number%TYPE,
    p_status            IN product.status%TYPE,
    p_price             IN product.price%TYPE,
    p_shipment_duration IN product.shipment_duration%TYPE,
    p_weight            IN product.weight%TYPE,
    p_width             IN product.width%TYPE,
    p_color             IN product.color%TYPE,
    p_height            IN product.height%TYPE
) AS
    l_count NUMBER;
BEGIN
-- Check if product already exists
    SELECT
        COUNT(*)
    INTO l_count
    FROM
        product
    WHERE
        product_id = p_product_id;

    IF l_count > 0 THEN
    -- Update available_number if product exists
        UPDATE product
        SET
            available_number = available_number + p_available_number
        WHERE
            product_id = p_product_id;

        dbms_output.put_line('Product already exists, available number updated.');
        COMMIT;
    ELSE
    -- Insert new product into the table
        INSERT INTO product (
            product_id,
            review_id,
            supplier_id,
            group_id,
            product_name,
            available_number,
            status,
            price,
            shipment_duration,
            weight,
            width,
            color,
            height
        ) VALUES (
            p_product_id,
            p_review_id,
            p_supplier_id,
            p_group_id,
            p_product_name,
            p_available_number,
            p_status,
            p_price,
            p_shipment_duration,
            p_weight,
            p_width,
            p_color,
            p_height
        );

        dbms_output.put_line('New product created successfully.');
        COMMIT;
    END IF;

EXCEPTION
-- Handle exceptions
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Errors: '
                             || sqlcode
                             || ' - '
                             || sqlerrm);
END;
/

-- Procedure for updating an existing record in the Product table
CREATE OR REPLACE PROCEDURE update_product (
    p_product_id        IN product.product_id%TYPE,
    p_review_id         IN product.review_id%TYPE,
    p_supplier_id       IN product.supplier_id%TYPE,
    p_group_id          IN product.group_id%TYPE,
    p_product_name      IN product.product_name%TYPE,
    p_available_number  IN product.available_number%TYPE,
    p_status            IN product.status%TYPE,
    p_price             IN product.price%TYPE,
    p_shipment_duration IN product.shipment_duration%TYPE,
    p_weight            IN product.weight%TYPE,
    p_width             IN product.width%TYPE,
    p_color             IN product.color%TYPE,
    p_height            IN product.height%TYPE
) AS
BEGIN
    UPDATE product
    SET
        review_id = p_review_id,
        supplier_id = p_supplier_id,
        group_id = p_group_id,
        product_name = p_product_name,
        available_number = p_available_number,
        status = p_status,
        price = p_price,
        shipment_duration = p_shipment_duration,
        weight = p_weight,
        width = p_width,
        color = p_color,
        height = p_height
    WHERE
        product_id = p_product_id;

    COMMIT;
    dbms_output.put_line('Product with ID '
                         || p_product_id
                         || ' updated successfully.');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Product with ID '
                             || p_product_id
                             || ' not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error updating product with ID '
                             || p_product_id
                             || '.');
END;
/

CREATE OR REPLACE PROCEDURE delete_product (
    p_product_id in product.product_id%TYPE
) IS v_count NUMBER;
BEGIN
-- Check if p_product_id is null
    IF p_product_id IS NULL THEN
        raise_application_error(-20002, 'Product ID is null');
    END IF;

-- Check if product exists
    SELECT
        COUNT(*)
    INTO v_count
    FROM
        product
    WHERE
        product_id = p_product_id;

    IF v_count = 0 THEN
-- Raise an exception if product does not exist
        raise_application_error(-20001, 'Product does not exist');
    ELSE
-- Delete the product
        DELETE FROM product
        WHERE
            product_id = p_product_id;
        dbms_output.put_line('Product deleted successfully');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
-- Handle any other exceptions
        dbms_output.put_line('Error deleting product: ' || p_product_id || 'with error message' || sqlerrm);
END;
/

--packages
--1. Customer package -> sp create/update/delete -> functions-> Function to insert a new address for a customer:
--
--2. Product package -> sp create/update/delete -> functions-> Function to calculate order total
--
--3. Review Package -> sp create/update/delete -> functions-> Get all reviews
--
--4. Trigger Package

--Customer package
CREATE OR REPLACE PACKAGE customert_package AS
    PROCEDURE create_newcustomer (
        p_customer_id   IN customer.customer_id%TYPE,
        p_first_name    IN customer.first_name%TYPE,
        p_last_name     IN customer.last_name%TYPE,
        p_email_id      IN customer.email_id%TYPE,
        p_phone_number  IN customer.phone_number%TYPE,
        p_customer_type IN customer.customer_type%TYPE
    );

    PROCEDURE update_customers (
        p_customer_id   IN NUMBER,
        p_first_name    IN VARCHAR2,
        p_last_name     IN VARCHAR2,
        p_email_id      IN VARCHAR2,
        p_phone_number  IN VARCHAR2,
        p_customer_type IN VARCHAR2
    );

    PROCEDURE delete_customer (
        p_customer_id IN customer.customer_id%TYPE
    );

END customert_package;
/

CREATE OR REPLACE PACKAGE BODY customert_package AS

    PROCEDURE create_newcustomer (
        p_customer_id   IN customer.customer_id%TYPE,
        p_first_name    IN customer.first_name%TYPE,
        p_last_name     IN customer.last_name%TYPE,
        p_email_id      IN customer.email_id%TYPE,
        p_phone_number  IN customer.phone_number%TYPE,
        p_customer_type IN customer.customer_type%TYPE
    ) AS
        l_count NUMBER;
    BEGIN
  -- Check if customer already exists
        SELECT
            COUNT(*)
        INTO l_count
        FROM
            customer
        WHERE
            customer_id = p_customer_id;

        IF l_count > 0 THEN
            raise_application_error(-20001, 'Customer already exists.');
        ELSE
    -- Perform validation on customer data
            IF p_first_name IS NULL OR p_last_name IS NULL OR p_email_id IS NULL OR p_phone_number IS NULL OR p_customer_type IS NULL
            THEN
                raise_application_error(-20002, 'Invalid customer data.');
                dbms_output.put_line('Invalid customer data.');
            ELSE
      -- Insert new customer into the table
                INSERT INTO customer (
                    customer_id,
                    first_name,
                    last_name,
                    email_id,
                    phone_number,
                    customer_type
                ) VALUES (
                    p_customer_id,
                    p_first_name,
                    p_last_name,
                    p_email_id,
                    p_phone_number,
                    p_customer_type
                );

                dbms_output.put_line('New customer created successfully.');
                COMMIT;
            END IF;
        END IF;

    EXCEPTION
  -- Handle exceptions
        WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Errors: '
                                 || sqlcode
                                 || ' - '
                                 || sqlerrm);
    END create_newcustomer;

    PROCEDURE update_customers (
        p_customer_id   IN NUMBER,
        p_first_name    IN VARCHAR2,
        p_last_name     IN VARCHAR2,
        p_email_id      IN VARCHAR2,
        p_phone_number  IN VARCHAR2,
        p_customer_type IN VARCHAR2
    ) IS
        v_customer_count NUMBER;
    BEGIN
        IF p_customer_id IS NULL OR p_first_name IS NULL OR p_last_name IS NULL OR p_email_id IS NULL OR p_phone_number IS NULL OR p_customer_type
        IS NULL THEN
            raise_application_error(-20002, 'Invalid customer data.');
            dbms_output.put_line('Invalid customer data.');
        ELSE
        -- Check if the customer exists
            SELECT
                COUNT(*)
            INTO v_customer_count
            FROM
                customer
            WHERE
                customer_id = p_customer_id;

            IF v_customer_count = 0 THEN
            -- Customer does not exist, raise an error
                raise_application_error(-20001, 'Customer does not exist.');
            ELSE
            -- Update the customer record
                UPDATE customer
                SET
                    first_name = coalesce(p_first_name, first_name),
                    last_name = coalesce(p_last_name, last_name),
                    email_id = coalesce(p_email_id, email_id),
                    phone_number = coalesce(p_phone_number, phone_number),
                    customer_type = coalesce(p_customer_type, customer_type)
                WHERE
                    customer_id = p_customer_id;

                COMMIT;
                dbms_output.put_line('Customer record updated successfully.');
            END IF;

        END IF;
    EXCEPTION
        WHEN OTHERS THEN
        -- Log the error and rollback the transaction
            dbms_output.put_line('Error: ' || sqlerrm);
            ROLLBACK;
    END update_customers;

    PROCEDURE delete_customer (
        p_customer_id IN customer.customer_id%TYPE
    ) IS
        v_count NUMBER;
    BEGIN
-- Check if p_customer_id is null
        IF p_customer_id IS NULL THEN
            raise_application_error(-20002, 'Customer ID is null');
        END IF;

-- Check if customer exists
        SELECT
            COUNT(*)
        INTO v_count
        FROM
            customer
        WHERE
            customer_id = p_customer_id;

        IF v_count = 0 THEN
-- Raise an exception if customer does not exist
            raise_application_error(-20001, 'Customer does not exist');
        ELSE
-- Delete the customer
            DELETE FROM customer
            WHERE
                customer_id = p_customer_id;

            dbms_output.put_line('Customer deleted successfully');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
-- Handle any other exceptions
            dbms_output.put_line('Error: ' || sqlerrm);
    END delete_customer;

END customert_package;
/

--Product package

CREATE OR REPLACE PACKAGE product_package AS
    PROCEDURE insert_product (
        p_product_id        IN product.product_id%TYPE,
        p_review_id         IN product.review_id%TYPE,
        p_supplier_id       IN product.supplier_id%TYPE,
        p_group_id          IN product.group_id%TYPE,
        p_product_name      IN product.product_name%TYPE,
        p_available_number  IN product.available_number%TYPE,
        p_status            IN product.status%TYPE,
        p_price             IN product.price%TYPE,
        p_shipment_duration IN product.shipment_duration%TYPE,
        p_weight            IN product.weight%TYPE,
        p_width             IN product.width%TYPE,
        p_color             IN product.color%TYPE,
        p_height            IN product.height%TYPE
    );
    PROCEDURE update_product (
        p_product_id        IN product.product_id%TYPE,
        p_review_id         IN product.review_id%TYPE,
        p_supplier_id       IN product.supplier_id%TYPE,
        p_group_id          IN product.group_id%TYPE,
        p_product_name      IN product.product_name%TYPE,
        p_available_number  IN product.available_number%TYPE,
        p_status            IN product.status%TYPE,
        p_price             IN product.price%TYPE,
        p_shipment_duration IN product.shipment_duration%TYPE,
        p_weight            IN product.weight%TYPE,
        p_width             IN product.width%TYPE,
        p_color             IN product.color%TYPE,
        p_height            IN product.height%TYPE
    );
    PROCEDURE delete_product (
        p_product_id in product.product_id%TYPE
    );
    
END product_package;
/

CREATE OR REPLACE PACKAGE BODY product_package AS
    PROCEDURE insert_product (
    p_product_id        IN product.product_id%TYPE,
    p_review_id         IN product.review_id%TYPE,
    p_supplier_id       IN product.supplier_id%TYPE,
    p_group_id          IN product.group_id%TYPE,
    p_product_name      IN product.product_name%TYPE,
    p_available_number  IN product.available_number%TYPE,
    p_status            IN product.status%TYPE,
    p_price             IN product.price%TYPE,
    p_shipment_duration IN product.shipment_duration%TYPE,
    p_weight            IN product.weight%TYPE,
    p_width             IN product.width%TYPE,
    p_color             IN product.color%TYPE,
    p_height            IN product.height%TYPE
) AS
    l_count NUMBER;
BEGIN
-- Check if product already exists
    SELECT
        COUNT(*)
    INTO l_count
    FROM
        product
    WHERE
        product_id = p_product_id;

    IF l_count > 0 THEN
    -- Update available_number if product exists
        UPDATE product
        SET
            available_number = available_number + p_available_number
        WHERE
            product_id = p_product_id;

        dbms_output.put_line('Product already exists, available number updated.');
        COMMIT;
    ELSE
    -- Insert new product into the table
        INSERT INTO product (
            product_id,
            review_id,
            supplier_id,
            group_id,
            product_name,
            available_number,
            status,
            price,
            shipment_duration,
            weight,
            width,
            color,
            height
        ) VALUES (
            p_product_id,
            p_review_id,
            p_supplier_id,
            p_group_id,
            p_product_name,
            p_available_number,
            p_status,
            p_price,
            p_shipment_duration,
            p_weight,
            p_width,
            p_color,
            p_height
        );

        dbms_output.put_line('New product created successfully.');
        COMMIT;
    END IF;

EXCEPTION
-- Handle exceptions
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Errors: '
                             || sqlcode
                             || ' - '
                             || sqlerrm);
END insert_product;

PROCEDURE update_product (
    p_product_id        IN product.product_id%TYPE,
    p_review_id         IN product.review_id%TYPE,
    p_supplier_id       IN product.supplier_id%TYPE,
    p_group_id          IN product.group_id%TYPE,
    p_product_name      IN product.product_name%TYPE,
    p_available_number  IN product.available_number%TYPE,
    p_status            IN product.status%TYPE,
    p_price             IN product.price%TYPE,
    p_shipment_duration IN product.shipment_duration%TYPE,
    p_weight            IN product.weight%TYPE,
    p_width             IN product.width%TYPE,
    p_color             IN product.color%TYPE,
    p_height            IN product.height%TYPE
) AS
BEGIN
    UPDATE product
    SET
        review_id = p_review_id,
        supplier_id = p_supplier_id,
        group_id = p_group_id,
        product_name = p_product_name,
        available_number = p_available_number,
        status = p_status,
        price = p_price,
        shipment_duration = p_shipment_duration,
        weight = p_weight,
        width = p_width,
        color = p_color,
        height = p_height
    WHERE
        product_id = p_product_id;

    COMMIT;
    dbms_output.put_line('Product with ID '
                         || p_product_id
                         || ' updated successfully.');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Product with ID '
                             || p_product_id
                             || ' not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error updating product with ID '
                             || p_product_id
                             || '.');
END update_product;

PROCEDURE delete_product (
    p_product_id in product.product_id%TYPE
) IS v_count NUMBER;
BEGIN
-- Check if p_product_id is null
    IF p_product_id IS NULL THEN
        raise_application_error(-20002, 'Product ID is null');
    END IF;

-- Check if product exists
    SELECT
        COUNT(*)
    INTO v_count
    FROM
        product
    WHERE
        product_id = p_product_id;

    IF v_count = 0 THEN
-- Raise an exception if product does not exist
        raise_application_error(-20001, 'Product does not exist');
    ELSE
-- Delete the product
        DELETE FROM product
        WHERE
            product_id = p_product_id;
        dbms_output.put_line('Product deleted successfully');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
-- Handle any other exceptions
        dbms_output.put_line('Error deleting product: ' || p_product_id || 'with error message' || sqlerrm);
END delete_product;

END product_package;

/


--- triggers
create or replace TRIGGER add_review_date
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
    :NEW.review_date := SYSDATE;
END;

--grant select on CUSTOMER_ORDER_HISTORY to Customer , NU_MERCHANDISE_ADMIN;
--grant select on CUSTOMER_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on EMPLOYEE_CUSTOMER_COUNT_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on EMPLOYEE_SALARY_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on EMPLOYEE_SALES_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on PRODUCT_COLOR_VIEW to Customer , NU_MERCHANDISE_ADMIN;
--grant select on PRODUCT_VIEW to Customer , NU_MERCHANDISE_ADMIN;
--grant select on REVENUE_BY_PAYMENT_MODE to NU_MERCHANDISE_ADMIN;
