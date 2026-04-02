{% set source_relation = source('seed', 'claim')%}
{% set id_attribute = get_first_attribute_in_relation(source_relation) %}

WITH staging_table_cte AS (
    SELECT
        *
    FROM {{ source_relation }}
)
SELECT 
    MD5({{ id_attribute }}) AS id
    , * 
FROM 
    staging_table_cte