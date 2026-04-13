WITH SRC AS (
    SELECT 
        DISTINCT INSURANCE_TYPE
    FROM 
        {{ ref('snapshot_staging_contract') }}
    WHERE
        dbt_valid_to = '9999-12-31'
)

SELECT
    MD5(TRIM(INSURANCE_TYPE)) AS INSURANCE_TYPE_KEY
    , INSURANCE_TYPE
FROM SRC
