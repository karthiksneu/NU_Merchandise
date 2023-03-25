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

 commit;
 
