with stg_customer_support as (
    select
        ticket_id::INT as TICKET_ID,
        strptime(ticket_date, '%Y-%m-%d')::DATE as TICKET_DATE,
        customer_name::VARCHAR(255) as CUSTOMER_NAME,
        country::VARCHAR(255) as COUNTRY,
        region::VARCHAR(255) as REGION,
        store_name::VARCHAR(255) as STORE_NAME,
        issue_type::VARCHAR(255) as ISSUE_TYPE,
        resolution_minutes::INT as RESOLUTION_TIME_IN_MINUTES,
        satisfaction_score::INT as SATISFACTION_SCORE,
        load_timestamp::TIMESTAMP as LOAD_TIMESTAMP
    from {{ source('dev_shop', 'fact_customer_support') }}
)

select * from stg_customer_support