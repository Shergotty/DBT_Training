{{ config(materialized='table', schema = 'mart') }}

WITH DIM_CLAIM_STATUS AS (

    SELECT 
        MD5(TRIM(STATUS)) AS CLAIM_STATUS_PK
        , STATUS
    FROM 
        {{ ref('snapshot_staging_claim') }}
    GROUP BY STATUS
)

SELECT
    *
FROM
    DIM_CLAIM_STATUS