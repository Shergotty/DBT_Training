{{ config(materialized='table', schema = 'mart') }}

WITH DIM_INSURANCE_TYPE AS (

    SELECT 
        MD5(TRIM(INSURANCE_TYPE)) AS INSURANCE_TYPE_PK
        , INSURANCE_TYPE
    FROM 
        {{ ref('staging_contract') }}
    GROUP BY INSURANCE_TYPE
)

SELECT 
    *
FROM    
    DIM_INSURANCE_TYPE