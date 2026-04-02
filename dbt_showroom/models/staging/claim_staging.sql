{%- set source_relation = source('seed', get_current_filename_staging()) -%}

{%- set first_attr_name = 'parse_dummy' -%}
{%- set all_attrs = [] -%}
{%- set diff_attrs = [] -%}

{%- if execute -%}
    {%- set all_attrs = get_attribute_list(source_relation) -%}    
    {%- set first_attr_name = get_first_attribute_in_list(all_attrs) -%}    
    {%- set diff_attrs = filter_attribute_list(all_attrs, [first_attr_name]) -%}
{%- endif %}

WITH staging_table_cte AS (
    SELECT
        MD5({{ first_attr_name }}::text) AS HASH_PK,
        MD5({{ safe_concat(diff_attrs) }}) AS HASH_DIFF,
        {{ all_attrs | join(', ') }}
    FROM {{ source_relation }}
)

SELECT * FROM staging_table_cte