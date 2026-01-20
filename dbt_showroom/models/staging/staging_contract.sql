{{ config(materialized='table', schema = 'staging') }}

WITH STG_CONTRACT AS (

    SELECT 
        MD5(
            CONCAT(
                TEXT(policy_number)
                , TEXT(client_id)
                , TEXT(insurance_type)
                , TEXT(monthly_premium)
                , TEXT(start_date)
                , TEXT(payment_plan)
                , TEXT(acquisition_cost)
                , TEXT(insurance_sum)
                )
            ) 
         AS HASH_CONTRACT
        , policy_number
        , client_id
        , insurance_type
        , monthly_premium
        , start_date
        , payment_plan
        , acquisition_cost
        , insurance_sum
        , MD5(
            CONCAT(
                TEXT(client_id)
                , TEXT(insurance_type)
                , TEXT(monthly_premium)
                , TEXT(start_date)
                , TEXT(payment_plan)
                , TEXT(acquisition_cost)
                , TEXT(insurance_sum)
                )
            ) 
        AS HASH_DIFF
        , CURRENT_TIMESTAMP AS TIMESTAMP_INSERT  
    FROM 
        {{ ref('contract') }}
)

SELECT 
    *
FROM    
    STG_CONTRACT