{{ config(materialized='table', schema = 'mart') }}

WITH DIM_PAYMENT_PLAN AS (

    SELECT 
        MD5(TRIM(PAYMENT_PLAN)) AS PAYMENT_TYPE_PK
        , PAYMENT_PLAN
    FROM 
        {{ ref('staging_contract') }}
    GROUP BY PAYMENT_PLAN
)

SELECT 
    *
FROM    
    DIM_PAYMENT_PLAN