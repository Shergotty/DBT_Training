{% set source_relation = source('seed', get_current_filename_staging())%}

WITH staging_table_cte AS (
    SELECT
        *
    FROM {{ source_relation }}
)
SELECT 
    * 
FROM 
    staging_table_cte