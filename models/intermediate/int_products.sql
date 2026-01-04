WITH PRODUCTS AS (
    SELECT DISTINCT
        PRODUCT_NAME,
        CATEGORY,
        BRAND,
        PRODUCT_KEY
    FROM {{ ref('stg_inventory') }}

    UNION

    SELECT DISTINCT
        PRODUCT_NAME,
        CATEGORY,
        BRAND,
        PRODUCT_KEY
    FROM {{ ref('stg_sales') }}
)

SELECT
    *,
    {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_NAME',
        'CATEGORY',
        'BRAND'
        ]) }} AS PRODUCT_KEY
FROM PRODUCTS
