WITH FACT_CONCTRACT AS (
    SELECT 
           policy_number
           , client_id
           , it.insurance_type_pk
           , monthly_premium
           , start_date
           , pp.payment_type_pk
           , acquisition_cost
           , insurance_sum
    FROM {{ ref('snapshot_staging_contract') }} as  stg
    INNER JOIN {{ ref('dim_payment_plan') }} as pp
    ON pp.payment_type_pk = md5(trim(stg.payment_plan))
    INNER join {{ ref('dim_insurance_type') }} as it
    on it.insurance_type_pk = md5(trim(stg.insurance_type))
    WHERE DATE(stg.VALID_TO) = (SELECT MAX(DATE(VALID_TO)) FROM {{ ref('snapshot_staging_contract') }}) 
)

SELECT * FROM FACT_CONCTRACT