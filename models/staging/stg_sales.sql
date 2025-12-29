WITH stg_fact_sales AS 
(
    SELECT
        sale_id::INT AS SALE_ID,
        STRPTIME(sale_date, '%Y-%m-%d')::DATE AS SALE_DATE,
        TRIM(customer_name)::VARCHAR(255) AS CUSTOMER_NAME,
        TRIM(customer_email)::VARCHAR(255) AS CUSTOMER_EMAIL,
        TRIM(country)::VARCHAR(255) AS COUNTRY,
        TRIM(region)::VARCHAR(255) AS REGION,
        TRIM(store_name)::VARCHAR(255) AS STORE_NAME,
        TRIM(product_name)::VARCHAR(255) AS PRODUCT_NAME,
        TRIM(category)::VARCHAR(255) AS CATEGORY,
        TRIM(brand)::VARCHAR(255) AS BRAND,
        quantity::INT AS QUANTITY,
        revenue::DECIMAL(10, 2) AS REVENUE,
        load_timestamp::TIMESTAMP AS LOAD_TIMESTAMP
    FROM {{ source('dev_shop', 'fact_sales') }}
) 

SELECT 
    *,
    {{ dbt_utils.generate_surrogate_key(['PRODUCT_NAME', 'CATEGORY', 'BRAND']) }} AS PRODUCT_KEY
FROM stg_fact_sales