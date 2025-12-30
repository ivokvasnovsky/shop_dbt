WITH stg_fact_sales AS (
    SELECT
        sale_id::INT AS sale_id,
        sale_date,
        TRIM(customer_name)::VARCHAR(255) AS customer_name,
        TRIM(customer_email)::VARCHAR(255) AS customer_email,
        TRIM(country)::VARCHAR(255) AS country,
        TRIM(region)::VARCHAR(255) AS region,
        TRIM(store_name)::VARCHAR(255) AS store_name,
        TRIM(product_name)::VARCHAR(255) AS product_name,
        TRIM(category)::VARCHAR(255) AS category,
        TRIM(brand)::VARCHAR(255) AS brand,
        quantity::INT AS quantity,
        revenue::DECIMAL(10, 2) AS revenue,
        {{ generate_load_timestamp() }}
    --FROM {{ source('dev_shop', 'fact_sales') }}
    FROM {{ ref('fact_sales') }}
)

SELECT
    *,
    {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_NAME',
         'CATEGORY',
         'BRAND'
    ]) }} AS product_key
FROM stg_fact_sales
