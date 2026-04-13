WITH SRC AS (
    SELECT 
        DISTINCT CLAIM_TYPE
    FROM 
        {{ ref('snapshot_staging_claim') }}
    WHERE
        dbt_valid_to = '9999-12-31'
)

select
    MD5(TRIM(CLAIM_TYPE)) AS CLAIM_TYPE_KEY
    , CLAIM_TYPE
FROM SRC