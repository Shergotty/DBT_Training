{{ config(materialized='table', schema = 'staging') }}

WITH STG_CONTRACT AS (

    SELECT 
        MD5(TRIM(client_id, insurance_type, monthly_premium, start_date, payment_plan, acquisition_cost, insurance_sum)) AS HASH_CONTRACT
        , policy_number
        , client_id
        , insurance_type
        , monthly_premium
        , start_date
        , payment_plan
        , acquisition_cost
        , insurance_sum
    FROM 
        {{ ref('claim') }}
)

SELECT 
    *
FROM    
    STG_CLAIM