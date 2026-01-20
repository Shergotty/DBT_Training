{{ config(materialized='table', schema = 'dimensions') }}

WITH DIM_INSURANCE_TYPE AS (

    SELECT 
        MD5(TRIM(INSURANCE_TYPE)) AS INSURANCE_TYPE_PK
        , INSURANCE_TYPE
    FROM 
        {{ ref('contract') }}
    GROUP BY INSURANCE_TYPE
)

SELECT 
    *
FROM    
    DIM_INSURANCE_TYPE