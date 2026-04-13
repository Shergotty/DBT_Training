WITH SRC AS (
    SELECT 
        DISTINCT PAYMENT_PLAN
    FROM 
        {{ ref('snapshot_staging_contract') }}
    WHERE
        dbt_valid_to = '9999-12-31'
)
SELECT
    MD5(TRIM(PAYMENT_PLAN)) AS PAYMENT_PLAN_KEY
    , PAYMENT_PLAN
FROM SRC
