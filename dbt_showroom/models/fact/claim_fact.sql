{% set source_table = ref('snapshot_staging_claim') %}
{% set claim_type_dim = ref('claim_type_dim') %}
{% set claim_status_dim = ref('claim_status_dim') %}

WITH FACT_CLAIM_CTE AS (
    SELECT
        CLAIM_ID
        , POLICY_NUMBER
        , INCIDENT_DATE
        , CLAIM_AMOUNT
        , CT.CLAIM_TYPE_KEY AS CLAIM_TYPE_KEY
        , CS.CLAIM_STATUS_KEY AS CLAIM_STATUS_KEY
    FROM {{ source_table }} AS SC
    INNER JOIN {{ claim_type_dim }} AS CT
        ON MD5(TRIM(SC.CLAIM_TYPE)) = CT.CLAIM_TYPE_KEY
    INNER JOIN {{ claim_status_dim }} AS CS
        ON MD5(TRIM(SC.STATUS)) = CS.CLAIM_STATUS_KEY
    WHERE
        SC.dbt_valid_to = '9999-12-31'
)

SELECT 
    *
FROM FACT_CLAIM_CTE