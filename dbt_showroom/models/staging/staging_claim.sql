{{ config(materialized='table', schema = 'staging') }}
{% set relation = source('seed', get_current_filename()) %}

WITH STG_TABLE AS (

    SELECT 
       MD5(
            {{ 
                safe_concat([get_first_column(relation)])
                }}
            ) AS HASH_CLIENT
        , *
        , {{ concat_hash(get_change_attributes(relation)) }}
            AS HASH_DIFF

    FROM 
        {{ relation }}
)

SELECT 
    *
FROM    
    STG_TABLE