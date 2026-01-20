{{ config(materialized='table', schema = 'staging') }}

WITH STG_CLAIM AS (

    SELECT 
        MD5(
            CONCAT(
                (claim_id)
                , TEXT(policy_number)
                , TEXT(incident_date)
                , TEXT(claim_amount)
                , TEXT(claim_type)
                , TEXT(status)
            )
            ) AS HASH_CLAIM
        , claim_id
        , policy_number
        , incident_date
        , claim_amount
        , claim_type
        , status
        , MD5(
            CONCAT(
                TEXT(policy_number)
                , TEXT(incident_date)
                , TEXT(claim_amount)
                , TEXT(claim_type)
                , TEXT(status)
                )
            )
         AS HASH_DIFF
        , CURRENT_TIMESTAMP AS TIMESTAMP_INSERT
       
    FROM 
        {{ ref('claim') }}
)

SELECT 
    *
FROM    
    STG_CLAIM