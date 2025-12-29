with stg_fact_inventory AS 
(
    SELECT
        inventory_id::INT AS INVENTORY_ID,
        STRPTIME(check_date, '%Y-%m-%d')::DATE AS CHECK_DATE,
        TRIM(store_name)::VARCHAR(255) AS STORE_NAME,
        TRIM(product_name)::VARCHAR(255) AS PRODUCT_NAME,
        TRIM(category)::VARCHAR(255) AS CATEGORY,
        TRIM(brand)::VARCHAR(255) AS BRAND,
        stock_quantity::INT AS STOCK_QUANTITY,
        load_timestamp::TIMESTAMP AS LOAD_TIMESTAMP
    FROM {{ source('dev_shop', 'fact_inventory') }}
) 

SELECT 
    *,
    {{ dbt_utils.generate_surrogate_key(['PRODUCT_NAME', 'CATEGORY', 'BRAND']) }} AS PRODUCT_KEY
FROM stg_fact_inventory