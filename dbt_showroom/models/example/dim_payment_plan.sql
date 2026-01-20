{{ config(materialized='table', schema = 'dimensions') }}

WITH DIM_PAYMENT_PLAN AS (

    SELECT 
        MD5(PAYMENT_PLAN) AS INSURANCE_TYPE_PK
        , PAYMENT_PLAN
    FROM 
        {{ ref('contract') }}
    GROUP BY PAYMENT_PLAN
)

SELECT 
    *
FROM    
    DIM_PAYMENT_PLAN