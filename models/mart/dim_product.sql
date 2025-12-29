{{ config(materialized='table') }}

with products as (
    select * from {{ ref('int_products') }}
)

select * from products