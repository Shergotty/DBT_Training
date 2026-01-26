{{ config(materialized='table', schema = 'staging') }}

WITH STG_CONTRACT AS (

    SELECT 
        MD5(
            {{ 
                safe_concat(['policy_number'])
                }}
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
        , {{concat_hash([
            'policy_number'
            , 'client_id'
            , 'insurance_type'
            , 'monthly_premium'
            , 'start_date'
            , 'payment_plan'
            , 'acquisition_cost'
            , 'insurance_sum'
                ])
            }}
            AS HASH_DIFF
            
    FROM 
        {{ source('seed', 'contract') }}
)

SELECT 
    *
FROM    
    STG_CONTRACT