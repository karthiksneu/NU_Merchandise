SET SERVEROUTPUT ON;

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


-- test cases
-- First, create a new product record
BEGIN
    product_package.insert_product(
        p_product_id        => 100,
        p_review_id         => NULL,
        p_supplier_id       => 1,
        p_group_id          => 1,
        p_product_name      => 'Pencil',
        p_available_number  => 10,
        p_status            => 'status',
        p_price             => 100.00,
        p_shipment_duration => 2,
        p_weight            => 1.0,
        p_width             => 10.0,
        p_color             => 'RED',
        p_height            => 10.0
    );
END;
/
-- Next, update the product record
BEGIN
    product_package.update_product(
        p_product_id        => 100,
        p_review_id         => NULL,
        p_supplier_id       => 2,
        p_group_id          => 2,
        p_product_name      => 'PEN Product',
        p_available_number  => 20,
        p_status            => 'status',
        p_price             => 200.00,
        p_shipment_duration => 3,
        p_weight            => 2.0,
        p_width             => 20.0,
        p_color             => 'BLUE',
        p_height            => 20.0
    );
END;
/
-- Finally, delete the product record
BEGIN
    product_package.delete_product(100);
END;

/
