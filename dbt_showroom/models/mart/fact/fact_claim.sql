WITH FACT_CLAIM AS (
    SELECT 
        claim_id
        , policy_number
        , incident_date
        , claim_amount
        , ct.CLAIM_TYPE_PK
        , cs.CLAIM_STATUS_PK
    FROM {{ ref('snapshot_staging_claim') }} as  stg
    INNER JOIN {{ ref('dim_claim_status') }} as cs
    ON cs.CLAIM_STATUS_PK = md5(trim(stg.status))
    INNER join {{ ref('dim_claim_type') }} as ct
    on ct.CLAIM_TYPE_PK = md5(trim(stg.claim_type))
    WHERE DATE(stg.VALID_TO) = (SELECT MAX(DATE(VALID_TO)) FROM {{ ref('snapshot_staging_claim') }}) 
)

SELECT * FROM FACT_CLAIM