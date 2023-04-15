-- grant view access
grant select on CUSTOMER_ORDER_HISTORY to Customer , NU_MERCHANDISE_ADMIN;
grant select on CUSTOMER_VIEW to NU_MERCHANDISE_ADMIN;
grant select on EMPLOYEE_CUSTOMER_COUNT_VIEW to NU_MERCHANDISE_ADMIN;
grant select on EMPLOYEE_SALARY_VIEW to NU_MERCHANDISE_ADMIN;
grant select on EMPLOYEE_SALES_VIEW to NU_MERCHANDISE_ADMIN;
grant select on PRODUCT_COLOR_VIEW to Customer , NU_MERCHANDISE_ADMIN;
grant select on PRODUCT_VIEW to Customer , NU_MERCHANDISE_ADMIN;
grant select on REVENUE_BY_PAYMENT_MODE to NU_MERCHANDISE_ADMIN;

-- grant package access to Customer
grant execute on review_package to Customer;

-- grant package access to NU_MERCHANDISE_ADMIN
grant execute on customert_package to NU_MERCHANDISE_ADMIN;
grant execute on product_package to NU_MERCHANDISE_ADMIN;
grant execute on review_package to NU_MERCHANDISE_ADMIN;
