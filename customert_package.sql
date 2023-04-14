SET SERVEROUTPUT ON;

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

--test case
DECLARE
  v_customer_id   customer.customer_id%TYPE := 100;
  v_first_name    customer.first_name%TYPE := 'Johnson';
  v_last_name     customer.last_name%TYPE := 'Dsouza';
  v_email_id      customer.email_id%TYPE := 'johnd@gmail.com';
  v_phone_number  customer.phone_number%TYPE := '1234567890';
  v_customer_type customer.customer_type%TYPE := 'Student';
BEGIN
  customert_package.create_newcustomer(
    p_customer_id   => v_customer_id,
    p_first_name    => v_first_name,
    p_last_name     => v_last_name,
    p_email_id      => v_email_id,
    p_phone_number  => v_phone_number,
    p_customer_type => v_customer_type
  );
END;
/

DECLARE
  v_customer_id   NUMBER := 100;
  v_first_name    VARCHAR2(50) := 'Johnson';
  v_last_name     VARCHAR2(50) := 'Dsouza';
  v_email_id      VARCHAR2(100) := 'johndsouza@example.com';
  v_phone_number  VARCHAR2(20) := '1234567890';
  v_customer_type VARCHAR2(50) := 'Student';
BEGIN
  customert_package.update_customers(
    p_customer_id   => v_customer_id,
    p_first_name    => v_first_name,
    p_last_name     => v_last_name,
    p_email_id      => v_email_id,
    p_phone_number  => v_phone_number,
    p_customer_type => v_customer_type
  );
END;
