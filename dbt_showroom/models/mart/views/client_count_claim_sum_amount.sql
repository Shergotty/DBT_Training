/*
    Model: client_sum_revenue
    Description: Calculates the total monthly revenue generated per client.
                 It joins client and contract data on policy_number and aggregates
                 the monthly premiums.
*/

{{ config(materialized='view', schema = 'mart') }}

with client_count_claim_sum_amount as (
    SELECT 
    FCT.CLIENT_ID
    , COUNT(FCL.CLAIM_ID) AS COUNT_CLAIM
    , SUM(FCL.claim_amount) AS SUM_CLAIM_AMOUNT
    FROM 
        {{ ref('fact_contract') }} as FCT
    INNER JOIN 
       {{ ref('fact_claim') }} as FCL
    ON 
        FCL.policy_number = FCT.policy_number
    GROUP BY FCT.CLIENT_ID
    ORDER BY COUNT(FCL.CLAIM_ID) DESC
)

select *
from client_count_claim_sum_amount