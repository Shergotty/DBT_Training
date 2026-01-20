{{ config(materialized='table', schema = 'mart') }}

WITH FACT_CLAIM AS (
    SELECT hash_claim,
            claim_id,
            policy_number,
            incident_date,
            claim_amount,
            claim_type,
            status,
            hash_diff,
            timestamp_insert
    FROM public_staging.staging_contract as  stg
    INNER JOIN {{ ref('dim_claim_status') }} as cs
    ON cs.CLAIM_STATUS_PK = md5(trim(stg.status))
    INNER join {{ ref('dim_claim_type') }} as ct
    on ct.CLAIM_TYPE_PK = md5(trim(stg.claim_type))
)

SELECT * FROM FACT_CLAIM