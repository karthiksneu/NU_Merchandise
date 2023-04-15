SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE review_package AS
    PROCEDURE add_review(
        p_quality_rating IN Reviews.quality_rating%TYPE,
        p_defect_percentage IN Reviews.defect_percentage%TYPE,
        p_review_desc IN Reviews.review_desc%TYPE,
        p_product_id IN Product.product_id%TYPE
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
