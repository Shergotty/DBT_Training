{% set source_table = ref('snapshot_staging_contract') %}
{% set insurance_type_dim = ref('insurance_type_dim') %}
{% set payment_plan_dim = ref('payment_plan_dim') %}

WITH CONTRACT_FACT_CTE AS (
    SELECT
        CONTRACT_ID
        , POLICY_NUMBER
        , EFFECTIVE_DATE
        , EXPIRATION_DATE
        , PREMIUM_AMOUNT
        , IT.INSURANCE_TYPE_KEY AS INSURANCE_TYPE_KEY
        , PP.PAYMENT_PLAN_KEY AS PAYMENT_PLAN_KEY
    FROM {{ source_table }} AS SC
    INNER JOIN {{ insurance_type_dim }} AS IT
        ON MD5(TRIM(SC.INSURANCE_TYPE)) = IT.INSURANCE_TYPE_KEY
    INNER JOIN {{ payment_plan_dim }} AS PP
        ON MD5(TRIM(SC.PAYMENT_PLAN)) = PP.PAYMENT_PLAN_KEY
)
SELECT 
    *
FROM CONTRACT_FACT_CTE
WHERE
    DBT_VALID_TO = '9999-12-31'
