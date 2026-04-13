WITH SRC AS (
    SELECT 
        DISTINCT CLAIM_TYPE
    FROM 
        {{ ref('snapshot_staging_claim') }}
)

select
    MD5(TRIM(CLAIM_TYPE)) AS CLAIM_TYPE_KEY
    , CLAIM_TYPE
FROM SRC
WHERE
    DBT_VALID_TO = '9999-12-31'
