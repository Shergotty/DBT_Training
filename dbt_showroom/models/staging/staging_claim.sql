{{ config(materialized='table', schema = 'staging') }}

WITH STG_CLAIM AS (

    SELECT 
        {{concat_hash(['claim_id'])}} AS HASH_CLAIM
        , claim_id
        , policy_number
        , incident_date
        , claim_amount
        , claim_type
        , status
        , {{concat_hash([
            'policy_number'
            , 'incident_date'
            , 'claim_amount'
            , 'claim_type'
            , 'status'
                ])
            }}
            AS HASH_DIFF
            
       
    FROM 
        {{ source('seed', 'claim') }}
)

SELECT 
    *
FROM    
    STG_CLAIM