{{ config(materialized='table') }}

WITH PRODUCTS AS 
(
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

SELECT * FROM PRODUCTS