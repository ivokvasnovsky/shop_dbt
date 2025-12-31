with stg_customer_support as (
    select
        ticket_id::INT as ticket_id,
        ticket_date,
        customer_name::VARCHAR(255) as customer_name,
        country::VARCHAR(255) as country,
        region::VARCHAR(255) as region,
        store_name::VARCHAR(255) as store_name,
        issue_type::VARCHAR(255) as issue_type,
        resolution_minutes::INT as resolution_time_in_minutes,
        satisfaction_score::INT as satisfaction_score,
        {{ generate_load_timestamp() }}
    from {{ source('dev_shop', 'fact_customer_support') }}
    --from {{ ref('fact_customer_support') }}
)

select * from stg_customer_support
