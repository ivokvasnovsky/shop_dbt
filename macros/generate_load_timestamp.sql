{% macro generate_load_timestamp() %}
    current_timestamp::TIMESTAMP as load_timestamp
{% endmacro %}