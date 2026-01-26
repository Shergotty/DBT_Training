{{ config(materialized='table', schema = 'mart') }}

WITH DIM_CLAIM_TYPE AS (

    SELECT 
        MD5(TRIM(CLAIM_TYPE)) AS CLAIM_TYPE_PK
        , CLAIM_TYPE
    FROM 
        {{ ref('snapshot_staging_claim') }}
    GROUP BY CLAIM_TYPE
)

SELECT
    *
FROM
    DIM_CLAIM_TYPE