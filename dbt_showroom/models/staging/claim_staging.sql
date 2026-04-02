{% set source_relation = source('seed', get_current_filename_staging())%}
{% set attr_list = get_attribute_list(source_relation.columns) %}
{% set first_attr = get_first_attribute_in_list(attr_list) %}

WITH staging_table_cte AS (
    SELECT
        MD5({{ first_attr }}) AS HASH_PK
        , *
    FROM {{ source_relation }}
)
SELECT 
    * 
FROM 
    staging_table_cte