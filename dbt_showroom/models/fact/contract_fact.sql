{% set source_table = ref('snapshot_staging_contract') %}
{% set insurance_type_dim = ref('insurance_type_dim') %}
{% set payment_plan_dim = ref('payment_plan_dim') %}

WITH CONTRACT_FACT_CTE AS (
    SELECT
        POLICY_NUMBER
        , START_DATE
        , MONTHLY_PREMIUM
        , ACQUISITION_COST
        , INSURANCE_SUM
        , IT.INSURANCE_TYPE_KEY AS INSURANCE_TYPE_KEY
        , PP.PAYMENT_PLAN_KEY AS PAYMENT_PLAN_KEY
    FROM {{ source_table }} AS SC
    INNER JOIN {{ insurance_type_dim }} AS IT
        ON MD5(TRIM(SC.INSURANCE_TYPE)) = IT.INSURANCE_TYPE_KEY
    INNER JOIN {{ payment_plan_dim }} AS PP
        ON MD5(TRIM(SC.PAYMENT_PLAN)) = PP.PAYMENT_PLAN_KEY
    WHERE
        SC.dbt_valid_to = '9999-12-31'
)
SELECT 
    *
FROM CONTRACT_FACT_CTE
