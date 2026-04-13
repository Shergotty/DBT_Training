WITH SRC AS (
    SELECT 
        DISTINCT STATUS
    FROM 
        {{ ref('snapshot_staging_claim') }}
)

select
    MD5(TRIM(STATUS)) AS CLAIM_STATUS_KEY
    , STATUS
FROM SRC
WHERE
    DBT_VALID_TO = '9999-12-31'
