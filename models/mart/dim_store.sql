{{ config(materialized='table') }}

with stores as (
    select * from {{ ref('int_customers') }}
)

select * from stores