--CLEANUP SCRIPT
set serveroutput on

DECLARE
    v_table_exists VARCHAR(1) := 'Y';
    v_sql          VARCHAR(2000);
BEGIN
    dbms_output.put_line('Start schema cleanup');
    FOR i IN (
        SELECT
            'ORDER_PRODUCT' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'PAYMENT' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'PRODUCT' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'ADDRESS' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'REVIEWS' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'EMPLOYEE' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'VOUCHER' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'PRODUCT_GROUP' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'SUPPLIER' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'CUSTOMER' table_name
        FROM
            dual
        UNION ALL
        SELECT
            'ZIPCODE' table_name
        FROM
            dual
    ) LOOP
        dbms_output.put_line('....Drop table ' || i.table_name);
        BEGIN
            SELECT
                'Y'
            INTO v_table_exists
            FROM
                user_tables
            WHERE
                table_name = i.table_name;

            v_sql := 'drop table ' || i.table_name;
            EXECUTE IMMEDIATE v_sql;
            dbms_output.put_line('........Table '
                                 || i.table_name
                                 || ' dropped successfully');
        EXCEPTION
            WHEN no_data_found THEN
                dbms_output.put_line('........Table already dropped');
        END;

    END LOOP;

    dbms_output.put_line('Schema cleanup successfully completed');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Failed to execute code:' || sqlerrm);
END;
/

COMMIT;
--Create table Statements
CREATE TABLE zipcode (
    zipcode_id NUMBER(5) PRIMARY KEY,
    state      VARCHAR(20),
    city       VARCHAR(20),
    zipcode    VARCHAR(5)
);

CREATE TABLE customer (
    customer_id   NUMBER(20) PRIMARY KEY,
    first_name    VARCHAR(20),
    last_name     VARCHAR(20),
    email_id      VARCHAR(50),
    phone_number  VARCHAR(10),
    customer_type VARCHAR(20)
);

CREATE TABLE supplier (
    supplier_id     NUMBER(20) PRIMARY KEY,
    supplier_name   VARCHAR(20),
    supply_quantity NUMBER(10)
);

CREATE TABLE product_group (
    group_id   NUMBER(20) PRIMARY KEY,
    group_name VARCHAR(50)
);

CREATE TABLE voucher (
    voucher_id   NUMBER(20) PRIMARY KEY,
    voucher_code VARCHAR(20),
    discounts    NUMBER(2)
);

CREATE TABLE employee (
    employee_id   NUMBER(20) PRIMARY KEY,
    employee_name VARCHAR(50),
    designation   VARCHAR(20),
    join_date     DATE,
    salary        FLOAT
);

CREATE TABLE reviews (
    review_id         NUMBER(20) PRIMARY KEY,
    product_id        NUMBER(20),
    quality_rating    NUMBER(2),
    defect_percentage NUMBER(2),
    review_desc       VARCHAR(120),
    review_date       DATE
);

CREATE TABLE address (
    address_id    NUMBER(20) PRIMARY KEY,
    address_line1 VARCHAR(50),
    address_line2 VARCHAR(50),
    customer_id   NUMBER(20),
    CONSTRAINT fk_customer FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id ),
    zipcode_id    NUMBER(5),
    CONSTRAINT fk_zipcode FOREIGN KEY ( zipcode_id )
        REFERENCES zipcode ( zipcode_id )
);

CREATE TABLE product (
    product_id        NUMBER(20) PRIMARY KEY,
    review_id         NUMBER(20),
    CONSTRAINT fk_review_id FOREIGN KEY ( review_id )
        REFERENCES reviews ( review_id ),
    supplier_id       NUMBER(20),
    CONSTRAINT fk_supplier_id FOREIGN KEY ( supplier_id )
        REFERENCES supplier ( supplier_id ),
    group_id          NUMBER(20),
    CONSTRAINT fk_group_id FOREIGN KEY ( group_id )
        REFERENCES product_group ( group_id ),
    product_name      VARCHAR(20),
    available_number  VARCHAR(5),
    status            VARCHAR(50),
    price             NUMBER(5),
    shipment_duration VARCHAR(50),
    weight            FLOAT,
    width             FLOAT,
    color             VARCHAR(20),
    height            FLOAT
);

CREATE TABLE payment (
    payment_id      NUMBER(20) PRIMARY KEY,
    customer_id     NUMBER(20),
    CONSTRAINT fk_customer_id FOREIGN KEY ( customer_id )
        REFERENCES customer ( customer_id ),
    payment_mode    VARCHAR(20),
    card_type       VARCHAR(20),
    card_number     VARCHAR(20),
    cardholder_name VARCHAR(50),
    order_date      DATE,
    voucher_id      NUMBER(20),
    CONSTRAINT fk_voucher_id FOREIGN KEY ( voucher_id )
        REFERENCES voucher ( voucher_id ),
    amount_paid     FLOAT
);

CREATE TABLE order_product (
    order_product_id NUMBER(20) PRIMARY KEY,
    product_id       NUMBER(20),
    CONSTRAINT fk_product_id FOREIGN KEY ( product_id )
        REFERENCES product ( product_id ),
    payment_id       NUMBER(20),
    CONSTRAINT fk_payment_id FOREIGN KEY ( payment_id )
        REFERENCES payment ( payment_id ),
    employee_id      NUMBER(20),
    CONSTRAINT fk_employee_id FOREIGN KEY ( employee_id )
        REFERENCES employee ( employee_id ),
    quantity         NUMBER(5)
);

COMMIT;

TRUNCATE TABLE zipcode;

TRUNCATE TABLE customer;

TRUNCATE TABLE supplier;

TRUNCATE TABLE product_group;

TRUNCATE TABLE voucher;

TRUNCATE TABLE employee;

TRUNCATE TABLE reviews;

TRUNCATE TABLE address;

TRUNCATE TABLE product;

TRUNCATE TABLE payment;

TRUNCATE TABLE order_product;

-- Script to insert values in tables
--truncate table Zipcode;

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    1,
    'California',
    'Los Angeles',
    '90001'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    2,
    'California',
    'San Francisco',
    '94102'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    3,
    'California',
    'San Diego',
    '92101'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    4,
    'New York',
    'New York City',
    '10001'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    5,
    'New York',
    'Albany',
    '12201'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    6,
    'New York',
    'Buffalo',
    '14201'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    7,
    'Texas',
    'Houston',
    '77001'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    8,
    'Texas',
    'Dallas',
    '75201'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    9,
    'Texas',
    'Austin',
    '78701'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    10,
    'Florida',
    'Miami',
    '33101'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    11,
    'Florida',
    'Tampa',
    '33601'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    12,
    'Florida',
    'Orlando',
    '32801'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    13,
    'Illinois',
    'Chicago',
    '60601'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    14,
    'Illinois',
    'Springfield',
    '62701'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    15,
    'Illinois',
    'Peoria',
    '61601'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    16,
    'Ohio',
    'Columbus',
    '43201'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    17,
    'Ohio',
    'Cleveland',
    '44101'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    18,
    'Ohio',
    'Cincinnati',
    '45201'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    19,
    'Washington',
    'Seattle',
    '98101'
);

INSERT INTO zipcode (
    zipcode_id,
    state,
    city,
    zipcode
) VALUES (
    20,
    'Washington',
    'Spokane',
    '99201'
);

COMMIT;

--truncate table customer;
INSERT INTO customer VALUES (
    1,
    'John',
    'Doe',
    'johndoe@email.com',
    '1234567890',
    'Student'
);

INSERT INTO customer VALUES (
    2,
    'Jane',
    'Smith',
    'janesmith@email.com',
    '2345678901',
    'Faculty'
);

INSERT INTO customer VALUES (
    3,
    'David',
    'Lee',
    'davidlee@email.com',
    '3456789012',
    'Student'
);

INSERT INTO customer VALUES (
    4,
    'Sarah',
    'Johnson',
    'sarahjohnson@email.com',
    '4567890123',
    'Faculty'
);

INSERT INTO customer VALUES (
    5,
    'Michael',
    'Brown',
    'michaelbrown@email.com',
    '5678901234',
    'Student'
);

INSERT INTO customer VALUES (
    6,
    'Amy',
    'Davis',
    'amydavis@email.com',
    '6789012345',
    'Faculty'
);

INSERT INTO customer VALUES (
    7,
    'Peter',
    'Nguyen',
    'peternguyen@email.com',
    '7890123456',
    'Student'
);

INSERT INTO customer VALUES (
    8,
    'Melissa',
    'Garcia',
    'melissagarcia@email.com',
    '8901234567',
    'Faculty'
);

INSERT INTO customer VALUES (
    9,
    'Kevin',
    'Jackson',
    'kevinjackson@email.com',
    '9012345678',
    'Student'
);

INSERT INTO customer VALUES (
    10,
    'Emily',
    'Kim',
    'emilykim@email.com',
    '0123456789',
    'Faculty'
);

INSERT INTO customer VALUES (
    11,
    'Daniel',
    'Wilson',
    'danielwilson@email.com',
    '1234567890',
    'Faculty'
);

INSERT INTO customer VALUES (
    12,
    'Maria',
    'Martinez',
    'mariamartinez@email.com',
    '2345678901',
    'Student'
);

INSERT INTO customer VALUES (
    13,
    'Brian',
    'Chen',
    'brianchen@email.com',
    '3456789012',
    'Faculty'
);

INSERT INTO customer VALUES (
    14,
    'Cynthia',
    'Lopez',
    'cynthialopez@email.com',
    '4567890123',
    'Student'
);

INSERT INTO customer VALUES (
    15,
    'Thomas',
    'Gonzalez',
    'thomasgonzalez@email.com',
    '5678901234',
    'Faculty'
);

INSERT INTO customer VALUES (
    16,
    'Jennifer',
    'Martin',
    'jennifermartin@email.com',
    '6789012345',
    'Student'
);

INSERT INTO customer VALUES (
    17,
    'Steven',
    'Lee',
    'stevenlee@email.com',
    '7890123456',
    'Faculty'
);

INSERT INTO customer VALUES (
    18,
    'Jessica',
    'Hernandez',
    'jessicahernandez@email.com',
    '8901234567',
    'Student'
);

INSERT INTO customer VALUES (
    19,
    'Christopher',
    'Gomez',
    'christophergomez@email.com',
    '9012345678',
    'Faculty'
);

INSERT INTO customer VALUES (
    20,
    'Kimberly',
    'Perez',
    'kimberlyperez@email.com',
    '0123456789',
    'Student'
);

COMMIT;

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    1,
    'ABC Inc.',
    500
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    2,
    'XYZ Corp.',
    1000
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    3,
    'PQR Enterprises',
    750
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    4,
    'LMN Corp.',
    1500
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    5,
    'DEF Industries',
    800
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    6,
    'GHI Manufacturing',
    900
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    7,
    'JKL Enterprises',
    1200
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    8,
    'MNO Inc.',
    600
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    9,
    'QRS Corp.',
    1100
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    10,
    'STU Industries',
    850
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    11,
    'VWX Inc.',
    950
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    12,
    'YZA Enterprises',
    1300
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    13,
    'BCD Corp.',
    700
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    14,
    'EFG Manufacturing',
    1000
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    15,
    'HIJ Industries',
    1250
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    16,
    'KLM Enterprises',
    900
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    17,
    'NOP Inc.',
    650
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    18,
    'QRT Corp.',
    800
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    19,
    'UVW Industries',
    950
);

INSERT INTO supplier (
    supplier_id,
    supplier_name,
    supply_quantity
) VALUES (
    20,
    'XYZ Enterprises',
    1100
);

COMMIT;

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    1,
    'Electronics'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    2,
    'Home Appliances'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    3,
    'Clothing'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    4,
    'Books'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    5,
    'Office Supplies'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    6,
    'Toys'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    7,
    'Sports and Fitness'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    8,
    'Health and Beauty'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    9,
    'Automotive'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    10,
    'Pet Supplies'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    11,
    'Jewelry'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    12,
    'Furniture'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    13,
    'Music'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    14,
    'Movies'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    15,
    'Food and Beverages'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    16,
    'Baby and Kids'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    17,
    'Outdoor and Garden'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    18,
    'Tools and Hardware'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    19,
    'Travel and Luggage'
);

INSERT INTO product_group (
    group_id,
    group_name
) VALUES (
    20,
    'Gifts and Collectibles'
);

COMMIT;

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    1,
    'ABC123',
    10
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    2,
    'DEF456',
    20
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    3,
    'GHI789',
    30
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    4,
    'JKL012',
    40
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    5,
    'MNO345',
    50
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    6,
    'PQR678',
    10
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    7,
    'STU901',
    20
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    8,
    'VWX234',
    30
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    9,
    'YZA567',
    40
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    10,
    'BCD890',
    50
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    11,
    'EFG123',
    10
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    12,
    'HIJ456',
    20
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    13,
    'KLM789',
    30
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    14,
    'NOP012',
    40
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    15,
    'QRS345',
    50
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    16,
    'TUV678',
    10
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    17,
    'WXY901',
    20
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    18,
    'ZAB234',
    30
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    19,
    'CDE567',
    40
);

INSERT INTO voucher (
    voucher_id,
    voucher_code,
    discounts
) VALUES (
    20,
    'FGH890',
    50
);

COMMIT;

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    1,
    'John Doe',
    'Manager',
    TO_DATE('2022-01-01', 'YYYY-MM-DD'),
    10000
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    2,
    'Jane Smith',
    'Sales',
    TO_DATE('2022-02-01', 'YYYY-MM-DD'),
    8000
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    3,
    'David Lee',
    'Sales',
    TO_DATE('2022-03-01', 'YYYY-MM-DD'),
    7000
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    4,
    'Sarah Johnson',
    'Sales',
    TO_DATE('2022-04-01', 'YYYY-MM-DD'),
    6000
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    5,
    'Mike Brown',
    'Sales',
    TO_DATE('2022-05-01', 'YYYY-MM-DD'),
    5500
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    6,
    'Emily Davis',
    'Sales',
    TO_DATE('2022-06-01', 'YYYY-MM-DD'),
    9000
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    7,
    'Kevin Kim',
    'Sales',
    TO_DATE('2022-07-01', 'YYYY-MM-DD'),
    5000
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    8,
    'Linda Wang',
    'Sales',
    TO_DATE('2022-08-01', 'YYYY-MM-DD'),
    8500
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    9,
    'Robert Chen',
    'Sales',
    TO_DATE('2022-09-01', 'YYYY-MM-DD'),
    6000
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    10,
    'Amy Lee',
    'Sales',
    TO_DATE('2022-10-01', 'YYYY-MM-DD'),
    9500
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    11,
    'Erica Nguyen',
    'Sales',
    TO_DATE('2022-11-01', 'YYYY-MM-DD'),
    6500
);

INSERT INTO employee (
    employee_id,
    employee_name,
    designation,
    join_date,
    salary
) VALUES (
    12,
    'Chris Johnson',
    'Sales',
    TO_DATE('2022-12-01', 'YYYY-MM-DD'),
    10000
);

COMMIT;

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    1,
    4,
    2,
    'Great product, works as advertised!',
    TO_DATE('2022-01-05', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    2,
    3,
    5,
    'Product had some minor defects but overall satisfied.',
    TO_DATE('2022-02-10', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    3,
    5,
    0,
    'Absolutely love this product! Best purchase ever.',
    TO_DATE('2022-03-15', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    4,
    2,
    10,
    'Product arrived damaged, disappointed with quality.',
    TO_DATE('2022-04-20', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    5,
    4,
    3,
    'Works well but had some minor issues with delivery.',
    TO_DATE('2022-05-25', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    6,
    5,
    0,
    'Incredible product, exceeded my expectations!',
    TO_DATE('2022-06-30', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    7,
    3,
    5,
    'Product had some defects but customer service was helpful in resolving the issue.',
    TO_DATE('2022-07-05', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    8,
    4,
    2,
    'Great product, would highly recommend to others.',
    TO_DATE('2022-08-10', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    9,
    2,
    8,
    'Product did not work properly, had to return it for a refund.',
    TO_DATE('2022-09-15', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    10,
    4,
    1,
    'Product is of good quality, arrived in a timely manner.',
    TO_DATE('2022-10-20', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    11,
    3,
    4,
    'Product had some minor issues but was able to fix them myself.',
    TO_DATE('2022-11-25', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    12,
    5,
    0,
    'Product exceeded my expectations, would purchase again!',
    TO_DATE('2022-12-30', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    13,
    4,
    2,
    'Good product overall, but had some issues with delivery.',
    TO_DATE('2023-01-05', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    14,
    2,
    10,
    'Product was not as described, disappointed with purchase.',
    TO_DATE('2023-02-10', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    15,
    5,
    0,
    'Amazing product, could not be happier with my purchase!',
    TO_DATE('2023-03-15', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    16,
    3,
    5,
    'Product had some defects, but customer service was able to assist in resolving the issue.',
    TO_DATE('2023-04-20', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    17,
    4,
    2,
    'Great product, would definitely recommend to others!',
    TO_DATE('2023-05-25', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    18,
    2,
    8,
    'Product did not work properly, had to return it for a replacement.',
    TO_DATE('2023-06-30', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    19,
    5,
    0,
    'Product exceeded my expectations, could not be happier!',
    TO_DATE('2023-07-05', 'YYYY-MM-DD')
);

INSERT INTO reviews (
    review_id,
    quality_rating,
    defect_percentage,
    review_desc,
    review_date
) VALUES (
    20,
    3,
    4,
    'Product had some minor issues, but overall satisfied with purchase.',
    TO_DATE('2023-08-10', 'YYYY-MM-DD')
);

COMMIT;

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    1,
    '123 Main St',
    'Apt 1',
    1,
    1
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    2,
    '456 Broadway',
    'Suite 2',
    2,
    4
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    3,
    '789 Main St',
    'Unit 3',
    3,
    2
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    4,
    '321 Elm St',
    '',
    4,
    10
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    5,
    '555 Oak St',
    'Apt 5B',
    5,
    13
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    6,
    '777 Walnut Ave',
    '',
    6,
    16
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    7,
    '999 Pine St',
    'Unit 7',
    7,
    19
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    8,
    '234 Main St',
    'Apt 2B',
    8,
    3
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    9,
    '567 Park Ave',
    '',
    9,
    4
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    10,
    '890 Elm St',
    'Suite 4',
    10,
    8
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    11,
    '432 Maple St',
    '',
    11,
    11
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    12,
    '654 Oak St',
    'Unit 6',
    12,
    14
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    13,
    '876 Walnut Ave',
    'Apt 3C',
    13,
    17
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    14,
    '1098 Pine St',
    '',
    14,
    19
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    15,
    '135 Main St',
    'Unit 8',
    15,
    20
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    16,
    '246 Broadway',
    '',
    16,
    5
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    17,
    '357 Main St',
    'Apt 3A',
    17,
    9
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    18,
    '468 Elm St',
    '',
    18,
    12
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    19,
    '579 Oak St',
    'Suite 5',
    19,
    15
);

INSERT INTO address (
    address_id,
    address_line1,
    address_line2,
    customer_id,
    zipcode_id
) VALUES (
    20,
    '690 Walnut Ave',
    'Unit 9',
    20,
    18
);

COMMIT;

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
    1,
    4,
    10,
    6,
    'Rough Book',
    '50',
    'ordered',
    3.99,
    '3-5 days',
    0.5,
    8.5,
    'White',
    11.0
);

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
    2,
    12,
    17,
    1,
    'Cup',
    '20',
    'delivered',
    9.99,
    '2-3 days',
    0.3,
    3.5,
    'Blue',
    4.5
);

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
    3,
    9,
    7,
    5,
    'T-shirt',
    '30',
    'ordered',
    19.99,
    '5-7 days',
    0.6,
    10.0,
    'Black',
    8.0
);

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
    4,
    18,
    2,
    12,
    'Notepad',
    '40',
    'ordered',
    1.99,
    '3-5 days',
    0.2,
    6.0,
    'Yellow',
    9.0
);

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
    5,
    15,
    19,
    8,
    'Mug',
    '10',
    'delivered',
    7.99,
    '2-3 days',
    0.4,
    4.5,
    'Red',
    4.0
);

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
    6,
    2,
    8,
    9,
    'Pen',
    '100',
    'ordered',
    0.99,
    '3-5 days',
    0.1,
    1.0,
    'Black',
    14.0
);

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
    7,
    7,
    14,
    2,
    'Highlighter',
    '50',
    'delivered',
    2.49,
    '2-3 days',
    0.1,
    1.5,
    'Yellow',
    11.0
);

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
    8,
    11,
    16,
    18,
    'Eraser',
    '30',
    'ordered',
    0.49,
    '3-5 days',
    0.05,
    2.0,
    'Pink',
    6.0
);

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
    9,
    13,
    3,
    16,
    'Pencil',
    '75',
    'ordered',
    0.29,
    '3-5 days',
    0.1,
    1.0,
    'Green',
    15.0
);

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
    10,
    5,
    18,
    11,
    'Scissors',
    '20',
    'delivered',
    4.99,
    '2-3 days',
    0.3,
    4.5,
    'Black',
    4.5
);

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
    11,
    20,
    9,
    7,
    'Stapler',
    '10',
    'ordered',
    6.99,
    '3-5 days',
    0.7,
    6.0,
    'Silver',
    3.5
);

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
    12,
    6,
    1,
    19,
    'Calculator',
    '5',
    'delivered',
    14.99,
    '2-3 days',
    0.5,
    4.0,
    'Black',
    2.0
);

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
    13,
    1,
    1,
    7,
    'Marker',
    '35',
    'ordered',
    3.99,
    '2-3 days',
    0.2,
    4.0,
    'Black',
    5.0
);

COMMIT;

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    1,
    5,
    'credit',
    'visa',
    '1234-5678-9012-3456',
    'John Smith',
    TO_DATE('2022-05-15', 'YYYY-MM-DD'),
    10,
    50.00
);

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    2,
    9,
    'cash',
    NULL,
    NULL,
    NULL,
    TO_DATE('2022-01-21', 'YYYY-MM-DD'),
    NULL,
    25.50
);

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    3,
    12,
    'debit',
    'mastercard',
    '9876-5432-1098-7654',
    'Emily Davis',
    TO_DATE('2022-03-12', 'YYYY-MM-DD'),
    NULL,
    30.00
);

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    4,
    7,
    'credit',
    'amex',
    '2468-1357-9135-2468',
    'Michael Johnson',
    TO_DATE('2022-08-05', 'YYYY-MM-DD'),
    5,
    20.00
);

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    5,
    16,
    'cash',
    NULL,
    NULL,
    NULL,
    TO_DATE('2022-11-18', 'YYYY-MM-DD'),
    NULL,
    12.75
);

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    6,
    1,
    'debit',
    'visa',
    '5555-5555-5555-4444',
    'Sarah Lee',
    TO_DATE('2022-02-08', 'YYYY-MM-DD'),
    NULL,
    45.00
);

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    7,
    20,
    'credit',
    'mastercard',
    '1111-2222-3333-4444',
    'David Kim',
    TO_DATE('2022-06-23', 'YYYY-MM-DD'),
    7,
    75.00
);

INSERT INTO payment (
    payment_id,
    customer_id,
    payment_mode,
    card_type,
    card_number,
    cardholder_name,
    order_date,
    voucher_id,
    amount_paid
) VALUES (
    8,
    4,
    'cash',
    NULL,
    NULL,
    NULL,
    TO_DATE('2022-09-14', 'YYYY-MM-DD'),
    NULL,
    16.50
);

COMMIT;

--truncate table order_product;
INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    1,
    5,
    3,
    8,
    10
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    2,
    2,
    4,
    3,
    5
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    3,
    7,
    2,
    9,
    2
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    4,
    11,
    1,
    5,
    1
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    5,
    9,
    3,
    2,
    8
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    6,
    6,
    5,
    3,
    3
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    7,
    1,
    5,
    6,
    6
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    8,
    10,
    7,
    7,
    12
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    9,
    12,
    8,
    10,
    4
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    10,
    4,
    2,
    4,
    7
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    11,
    8,
    1,
    12,
    2
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    12,
    3,
    6,
    2,
    9
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    13,
    13,
    4,
    4,
    1
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    14,
    1,
    2,
    5,
    3
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    15,
    2,
    1,
    8,
    6
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    16,
    7,
    8,
    2,
    8
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    17,
    11,
    6,
    10,
    5
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    18,
    9,
    1,
    7,
    2
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    19,
    6,
    4,
    3,
    11
);

INSERT INTO order_product (
    order_product_id,
    product_id,
    payment_id,
    employee_id,
    quantity
) VALUES (
    20,
    4,
    2,
    12,
    3
);

COMMIT;

CREATE OR REPLACE VIEW customer_view AS
    SELECT
        customer_id,
        first_name
        || ' '
        || last_name AS customer_name,
        customer_type
    FROM
        customer;

COMMIT;

CREATE OR REPLACE VIEW product_color_view AS
    SELECT
        product_name,
        color
    FROM
        product;

COMMIT;

CREATE OR REPLACE VIEW product_view AS
    SELECT
        p.review_id,
        p.product_name,
        r.review_desc,
        LISTAGG(r.quality_rating, ';') WITHIN GROUP(
        ORDER BY
            r.quality_rating
        ) AS product_rating
    FROM
             reviews r
        JOIN product p ON r.review_id = p.review_id
    GROUP BY
        p.review_id,
        p.product_name,
        r.review_desc
    ORDER BY
        p.review_id;

COMMIT;

CREATE OR REPLACE VIEW customer_order_history AS
    SELECT
        c.customer_id,
        c.first_name
        || ' '
        || c.last_name       AS customer_name,
        p.product_name,
        pay.order_date,
        SUM(o.quantity)      AS quantity,
        SUM(pay.amount_paid) AS amount_paid
    FROM
             customer c
        JOIN payment       pay ON c.customer_id = pay.customer_id
        JOIN order_product o ON pay.payment_id = o.payment_id
        JOIN product       p ON o.product_id = p.product_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        p.product_name,
        pay.order_date
    ORDER BY
        c.customer_id;

COMMIT;

CREATE OR REPLACE VIEW employee_sales_view AS
    SELECT
        e.employee_id,
        e.employee_name,
        trunc(p.order_date, 'IW')        AS week,
        SUM(op.quantity * p.amount_paid) AS weekly_sales
    FROM
             order_product op
        JOIN payment  p ON op.payment_id = p.payment_id
        JOIN employee e ON op.employee_id = e.employee_id
    GROUP BY
        e.employee_id,
        e.employee_name,
        trunc(p.order_date, 'IW')
    HAVING
        SUM(op.quantity * p.amount_paid) > 10;

COMMIT;

CREATE OR REPLACE VIEW revenue_by_payment_mode AS
    SELECT
        payment_mode,
        SUM(amount_paid) AS total_revenue
    FROM
        payment
    GROUP BY
        payment_mode;

COMMIT;

CREATE OR REPLACE VIEW employee_customer_count_view AS
    SELECT
        e.employee_id,
        e.employee_name,
        COUNT(DISTINCT op.payment_id) AS num_of_customers
    FROM
             employee e
        JOIN order_product op ON e.employee_id = op.employee_id
    GROUP BY
        e.employee_id,
        e.employee_name
    ORDER BY
        e.employee_id;

COMMIT;

CREATE OR REPLACE VIEW employee_salary_view AS
    SELECT
        designation,
        employee_name,
        salary
    FROM
        employee
    ORDER BY
        designation,
        employee_name;

COMMIT;

--******************Stored Procedures*******************************
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

END create_newcustomer;
/

-- ********************************UPDATE CUSTOMERS*******************************************

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
END update_customers;
/

--********************* DELETE CUSTOMER ***********************************
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
END delete_customer;
/

-- ************************* Update procedure to update availability of quantity ***************************

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

END update_product_quantity;
/

-- **************************** Get employee details from employee id ******************************

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
END get_employee_details;
/

-- ********************* get all products ******************************

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
END get_all_products;
/
-- ***************************** get all customers who have applied voucher ******************************

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
END get_customers_using_voucher;
/

-- ******************************** Insert/Create new products ************************************
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

-- **************************************** Procedure for updating an existing record in the Product table ********************************************
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

-- ******************************************* DELETE A PRODUCT FROM TABLE *********************************

CREATE OR REPLACE PROCEDURE delete_product (
    p_product_id IN product.product_id%TYPE
) IS
    v_count NUMBER;
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
        dbms_output.put_line('Error deleting product: '
                             || p_product_id
                             || 'with error message'
                             || sqlerrm);
END;
/

-- ********************************************* modified delete product *******************************************
CREATE OR REPLACE PROCEDURE delete_product (
    p_product_id IN product.product_id%TYPE
) IS
    v_count NUMBER;
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
        -- Check if there are any reviews associated with the product
        SELECT
            COUNT(*)
        INTO v_count
        FROM
            reviews
        WHERE
            product_id = p_product_id;

        IF v_count > 0 THEN
            -- Set the product_id to NULL in the reviews table
            UPDATE reviews
            SET
                product_id = NULL
            WHERE
                product_id = p_product_id;

            dbms_output.put_line('Associated reviews updated successfully');
        END IF;

        -- Delete the product
        DELETE FROM product
        WHERE
            product_id = p_product_id;

        dbms_output.put_line('Product deleted successfully');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Handle any other exceptions
        dbms_output.put_line('Error deleting product: '
                             || p_product_id
                             || ' with error message '
                             || sqlerrm);
END;
/
-- ************SEQUENCES******************
--CREATE SEQUENCE reviews_seq START WITH 100 INCREMENT BY 1 NOCACHE;

-- ************************************** stored procedure to add reviews ************************************************
CREATE OR REPLACE PROCEDURE add_review (
    p_quality_rating    IN reviews.quality_rating%TYPE,
    p_defect_percentage IN reviews.defect_percentage%TYPE,
    p_review_desc       IN reviews.review_desc%TYPE,
    p_product_id        IN product.product_id%TYPE
) AS
BEGIN
    -- Handle null values
    IF p_quality_rating IS NULL THEN
        raise_application_error(-20001, 'Quality rating cannot be null');
    END IF;
    IF p_defect_percentage IS NULL THEN
        raise_application_error(-20002, 'Defect percentage cannot be null');
    END IF;
    IF p_review_desc IS NULL THEN
        raise_application_error(-20003, 'Review description cannot be null');
    END IF;
    IF p_product_id IS NULL THEN
        raise_application_error(-20004, 'Product ID cannot be null');
    END IF;

    -- Insert the review
    INSERT INTO reviews (
        review_id,
        quality_rating,
        defect_percentage,
        review_desc,
        review_date
    ) VALUES (
        reviews_seq.NEXTVAL,
        p_quality_rating,
        p_defect_percentage,
        p_review_desc,
        sysdate
    );

    -- Update the product review_id
    UPDATE product
    SET
        review_id = reviews_seq.CURRVAL
    WHERE
        product_id = p_product_id;

    COMMIT;
END add_review;
/
--packages
--1. Customer package -> sp create/update/delete -> functions-> Function to insert a new address for a customer:
--
--2. Product package -> sp create/update/delete -> functions-> Function to calculate order total
--
--3. Review Package -> sp create/update/delete -> functions-> Get all reviews
--
--4. Trigger Package

-- **************************************** REVIEW PACKAGE **************************************************

CREATE OR REPLACE PACKAGE review_package AS
    PROCEDURE add_review (
        p_quality_rating    IN reviews.quality_rating%TYPE,
        p_defect_percentage IN reviews.defect_percentage%TYPE,
        p_review_desc       IN reviews.review_desc%TYPE,
        p_product_id        IN product.product_id%TYPE
    );

END review_package;
/

CREATE OR REPLACE PACKAGE BODY review_package AS

    PROCEDURE add_review (
        p_quality_rating    IN reviews.quality_rating%TYPE,
        p_defect_percentage IN reviews.defect_percentage%TYPE,
        p_review_desc       IN reviews.review_desc%TYPE,
        p_product_id        IN product.product_id%TYPE
    ) AS
    BEGIN
    -- Handle null values
        IF p_quality_rating IS NULL THEN
            raise_application_error(-20001, 'Quality rating cannot be null');
        END IF;
        IF p_defect_percentage IS NULL THEN
            raise_application_error(-20002, 'Defect percentage cannot be null');
        END IF;
        IF p_review_desc IS NULL THEN
            raise_application_error(-20003, 'Review description cannot be null');
        END IF;
        IF p_product_id IS NULL THEN
            raise_application_error(-20004, 'Product ID cannot be null');
        END IF;

    -- Insert the review
        INSERT INTO reviews (
            review_id,
            quality_rating,
            defect_percentage,
            review_desc,
            review_date
        ) VALUES (
            reviews_seq.NEXTVAL,
            p_quality_rating,
            p_defect_percentage,
            p_review_desc,
            sysdate
        );

    -- Update the product review_id
        UPDATE product
        SET
            review_id = reviews_seq.CURRVAL
        WHERE
            product_id = p_product_id;

        COMMIT;
    END add_review;

END review_package;
/

--  *************************************** Customer package *******************************************************************
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

-- ************************************* Product package ***************************************

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
        p_product_id IN product.product_id%TYPE
    );

    PROCEDURE update_product_quantity (
        p_product_id IN NUMBER,
        p_quantity   IN NUMBER
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
        p_product_id IN product.product_id%TYPE
    ) IS
        v_count NUMBER;
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
        -- Check if there are any reviews associated with the product
            SELECT
                COUNT(*)
            INTO v_count
            FROM
                reviews
            WHERE
                product_id = p_product_id;

            IF v_count > 0 THEN
            -- Set the product_id to NULL in the reviews table
                UPDATE reviews
                SET
                    product_id = NULL
                WHERE
                    product_id = p_product_id;

                dbms_output.put_line('Associated reviews updated successfully');
            END IF;

        -- Delete the product
            DELETE FROM product
            WHERE
                product_id = p_product_id;

            dbms_output.put_line('Product deleted successfully');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
        -- Handle any other exceptions
            dbms_output.put_line('Error deleting product: '
                                 || p_product_id
                                 || ' with error message '
                                 || sqlerrm);
    END delete_product;

    PROCEDURE update_product_quantity (
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

END product_package;
/

-- ************************************** TRIGGERS *******************************************

CREATE OR REPLACE TRIGGER add_review_date BEFORE
    INSERT ON reviews
    FOR EACH ROW
BEGIN
    :new.review_date := sysdate;
END;
/
CREATE OR REPLACE TRIGGER update_product_with_latest_review FOR
    INSERT ON reviews
COMPOUND TRIGGER
    TYPE review_ids_tbl IS
        TABLE OF reviews.review_id%TYPE INDEX BY PLS_INTEGER;
    reviews_ids review_ids_tbl;
    AFTER EACH ROW IS BEGIN
        reviews_ids(reviews_ids.count + 1) := :new.review_id;
    END AFTER EACH ROW;
    AFTER STATEMENT IS BEGIN
        FOR i IN 1..reviews_ids.count LOOP
            UPDATE product
            SET
                review_id = reviews_ids(i)
            WHERE
                    product_id = (
                        SELECT
                            product_id
                        FROM
                            reviews
                        WHERE
                            review_id = reviews_ids(i)
                    )
                AND review_id IS NULL;

        END LOOP;
    END AFTER STATEMENT;
END update_product_with_latest_review;
/

-- ******************* FUNCTIONS ****************************

CREATE OR REPLACE FUNCTION review(product_name in VARCHAR)
RETURN VARCHAR
IS
	review_descrip varchar(120);
BEGIN
    select r.review_desc into review_descrip from reviews r JOIN product p on p.review_id = r.review_id AND p.product_name = product_name;
	dbms_output.put_line(review_descrip);
 
	RETURN review_descrip;
END;
/
--******************* FUNCTIONS ****************************

CREATE OR REPLACE FUNCTION review(product_name in VARCHAR)
RETURN VARCHAR
IS
	review_descrip varchar(120);
BEGIN
    select r.review_desc into review_descrip from reviews r JOIN product p on p.review_id = r.review_id AND p.product_name = product_name;
	dbms_output.put_line(review_descrip);
 
	RETURN review_descrip;
END;
/

--**************** Graph Queries ***********************

--** Total Products Sold **
SELECT product_name, SUM(op.quantity) AS total_quantity_sold 
FROM product p
JOIN order_product op ON p.product_id = op.product_id
GROUP BY product_name 
ORDER BY total_quantity_sold DESC;
/
--** Total Revenue Per Products **
SELECT p.product_name, SUM(op.quantity * p.price) AS total_revenue
  FROM product p
  JOIN order_product op ON p.product_id = op.product_id
  JOIN payment pa ON op.payment_id = pa.payment_id
  WHERE pa.order_date >= ADD_MONTHS(SYSDATE, -12)
  GROUP BY p.product_name
  ORDER BY total_revenue DESC;
/
--** Top Trending Products **
SELECT *
FROM (
  SELECT p.product_name, SUM(op.quantity) AS total_quantity_sold
  FROM product p
  JOIN order_product op ON p.product_id = op.product_id
  JOIN payment pa ON op.payment_id = pa.payment_id
  WHERE pa.order_date >= ADD_MONTHS(SYSDATE, -12)
  GROUP BY p.product_name
  ORDER BY total_quantity_sold DESC
) 
WHERE ROWNUM <=5;
/
--** Top Customers **
SELECT c.first_name, SUM(pa.amount_paid) AS total_spent 
FROM customer c 
JOIN payment pa ON c.customer_id = pa.customer_id
WHERE pa.amount_paid >=20
GROUP BY first_name 
ORDER BY total_spent DESC;
/
--******************************************************************
--grant select on CUSTOMER_ORDER_HISTORY to Customer , NU_MERCHANDISE_ADMIN;
--grant select on CUSTOMER_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on EMPLOYEE_CUSTOMER_COUNT_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on EMPLOYEE_SALARY_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on EMPLOYEE_SALES_VIEW to NU_MERCHANDISE_ADMIN;
--grant select on PRODUCT_COLOR_VIEW to Customer , NU_MERCHANDISE_ADMIN;
--grant select on PRODUCT_VIEW to Customer , NU_MERCHANDISE_ADMIN;
--grant select on REVENUE_BY_PAYMENT_MODE to NU_MERCHANDISE_ADMIN;
