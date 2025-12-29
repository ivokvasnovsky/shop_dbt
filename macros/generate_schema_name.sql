{% macro generate_schema_name(custom_schema_name, node) -%}
    {# 
       If a custom schema is defined in dbt_project.yml or config blocks, 
       use ONLY that name. Otherwise, fall back to the default target schema.
    #}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}