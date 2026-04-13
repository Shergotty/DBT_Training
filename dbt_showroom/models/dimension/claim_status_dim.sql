WITH SRC AS (
    SELECT 
        DISTINCT STATUS
    FROM 
        {{ ref('snapshot_staging_claim') }}
    WHERE
        dbt_valid_to = '9999-12-31'
)

select
    MD5(TRIM(STATUS)) AS CLAIM_STATUS_KEY
    , STATUS
FROM SRC