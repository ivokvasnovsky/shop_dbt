with stg_fact_inventory as (
    select
        inventory_id::INT as inventory_id,
        check_date,
        TRIM(store_name)::VARCHAR(255) as store_name,
        TRIM(product_name)::VARCHAR(255) as product_name,
        TRIM(category)::VARCHAR(255) as category,
        TRIM(brand)::VARCHAR(255) as brand,
        stock_quantity::INT as stock_quantity,
        {{ generate_load_timestamp() }}
    from {{ source('dev_shop_cloud', 'fact_inventory') }}
)

select
    *,
    {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_NAME', 
        'CATEGORY', 
        'BRAND'
    ]) }} as product_key
from stg_fact_inventory
