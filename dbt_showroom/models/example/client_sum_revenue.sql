/*
    Model: client_sum_revenue
    Description: Calculates the total monthly revenue generated per client.
                 It joins client and contract data on policy_number and aggregates
                 the monthly premiums.
*/

{{ config(materialized='table') }}

with client_sum_revenue as (
    SELECT 
        CL.CLIENT_ID
        , SUM(CO.MONTHLY_PREMIUM) AS REVENUE_PER_CLIENT 
    FROM 
        {{ ref('client') }} AS CL
    INNER JOIN {{ ref('contract') }} AS CO 
    ON
        TRIM(CL.POLICY_NUMBER) = TRIM(CO.POLICY_NUMBER)
    GROUP BY CL.CLIENT_ID
    ORDER BY SUM(CO.MONTHLY_PREMIUM) DESC
)

select *
from client_sum_revenue