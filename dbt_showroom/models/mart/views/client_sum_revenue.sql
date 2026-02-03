/*
    Model: client_sum_revenue
    Description: Calculates the total monthly revenue generated per client.
                 It joins client and contract data on policy_number and aggregates
                 the monthly premiums.
*/
with client_sum_revenue as (
    SELECT 
        FC.CLIENT_ID
        , SUM(FC.MONTHLY_PREMIUM) AS REVENUE_PER_CLIENT 
    FROM 
        {{ ref('fact_contract') }} AS FC
    GROUP BY FC.CLIENT_ID
    ORDER BY SUM(FC.MONTHLY_PREMIUM) DESC
)

select *
from client_sum_revenue