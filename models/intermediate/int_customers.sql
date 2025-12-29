
WITH CUSTOMERS AS 
(
SELECT 
	DISTINCT  
	COALESCE(CUSTOMER_NAME,'dummy') AS CUSTOMER_FULL_NAME,
	regexp_extract(CUSTOMER_NAME, '^([^ ]+)', 1) AS CUSTOMER_FIRST_NAME,
	trim(regexp_extract(CUSTOMER_NAME, ' (.*)$', 1)) AS CUSTOMER_LAST_NAME
FROM {{ ref ('stg_customer_support') }}
UNION 
SELECT
	DISTINCT  
	COALESCE(CUSTOMER_NAME,'dummy') AS CUSTOMER_FULL_NAME,
	regexp_extract(CUSTOMER_NAME, '^([^ ]+)', 1) AS CUSTOMER_FIRST_NAME,
	trim(regexp_extract(CUSTOMER_NAME, ' (.*)$', 1)) AS CUSTOMER_LAST_NAME
FROM {{ ref ('stg_sales') }}
)

SELECT * FROM CUSTOMERS
