WITH CUSTOMERS AS (
    SELECT DISTINCT
        COALESCE(CUSTOMER_NAME, 'dummy') AS CUSTOMER_FULL_NAME,
        REGEXP_EXTRACT(CUSTOMER_NAME, '^([^ ]+)', 1) AS CUSTOMER_FIRST_NAME,
        TRIM(REGEXP_EXTRACT(CUSTOMER_NAME, ' (.*)$', 1)) AS CUSTOMER_LAST_NAME
    FROM {{ ref ('stg_customer_support') }}
    UNION
    SELECT DISTINCT
        COALESCE(CUSTOMER_NAME, 'dummy') AS CUSTOMER_FULL_NAME,
        REGEXP_EXTRACT(CUSTOMER_NAME, '^([^ ]+)', 1) AS CUSTOMER_FIRST_NAME,
        TRIM(REGEXP_EXTRACT(CUSTOMER_NAME, ' (.*)$', 1)) AS CUSTOMER_LAST_NAME
    FROM {{ ref ('stg_sales') }}
),
CUSTOMER_KEYS AS (
    SELECT
        CUSTOMER_FULL_NAME,
        CUSTOMER_FIRST_NAME,
        CUSTOMER_LAST_NAME,,
        customer_email
        {{ dbt_utils.generate_surrogate_key([
            'CUSTOMER_FULL_NAME',
            'CUSTOMER_FIRST_NAME',
            'CUSTOMER_LAST_NAME',
            'customer_email'
        ]) }} AS CUSTOMER_KEY
    FROM CUSTOMERS
    LEFT JOIN 
        {{ ref ('stg_sales') }} AS SALES
    ON CUSTOMERS.CUSTOMER_FULL_NAME = SALES.CUSTOMER_NAME
)

SELECT * FROM CUSTOMER_KEYS