{{ config(materialized='table', schema = 'staging') }}

WITH STG_CONTRACT AS (

    SELECT 
        MD5(TRIM(incident_date, claim_amount, claim_type, status)) AS HASH_CONTRACT
        , client_id
        , insurance_type
        , monthly_premium
        , start_date
        , payment_plan
        , acquisition_cost
        , insurance_sum
    FROM 
        {{ ref('contract') }}
)

SELECT 
    *
FROM    
    STG_CONTRACT