WITH fact_contract AS (
    SELECT * FROM {{ ref('contract_fact') }}
),

fact_claim AS (
    SELECT * FROM {{ ref('claim_fact') }}
),

address_dim AS (
    SELECT * FROM {{ ref('address_dim') }}
),

insurance_type_dim AS (
    SELECT * FROM {{ ref('insurance_type_dim') }}
),

claim_type_dim AS (
    SELECT * FROM {{ ref('claim_type_dim') }}
),

claim_status_dim AS (
    SELECT * FROM {{ ref('claim_status_dim') }}
),

payment_plan_dim AS (
    SELECT * FROM {{ ref('payment_plan_dim') }}
),

joined_data AS (
    SELECT
        -- Contract Info
        con.contract_id,
        con.start_date,
        con.end_date,
        con.premium_amount,
        
        -- Insurance Type Attributes
        it.insurance_type,
        
        -- Payment Plan Attributes
        pp.payment_plan,
        
        -- Address Attributes
        addr.street_name,
        addr.street_number,
        addr.zip_code,
        addr.city,
        
        -- Claim Info
        clm.claim_id,
        clm.claim_date,
        clm.claim_amount,
        
        -- Claim Type Attributes
        ct.claim_type,
        
        -- Claim Status Attributes
        cs.status AS claim_status

    FROM fact_contract con
    LEFT JOIN insurance_type_dim it ON con.insurance_type_key = it.insurance_type_key
    LEFT JOIN payment_plan_dim pp ON con.payment_plan_key = pp.payment_plan_key
    LEFT JOIN address_dim addr ON con.address_key = addr.address_key
    LEFT JOIN fact_claim clm ON con.contract_id = clm.contract_id
    LEFT JOIN claim_type_dim ct ON clm.claim_type_key = ct.claim_type_key
    LEFT JOIN claim_status_dim cs ON clm.claim_status_key = cs.claim_status_key
)

SELECT
    *,
    -- Sample Aggregations (Window Functions for Flatmart)
    COUNT(claim_id) OVER (PARTITION BY contract_id) AS total_claims_per_contract,
    SUM(claim_amount) OVER (PARTITION BY contract_id) AS total_claim_amount_per_contract,
    AVG(premium_amount) OVER (PARTITION BY city, insurance_type) AS avg_premium_by_city_and_type,
    SUM(claim_amount) OVER (PARTITION BY zip_code) AS total_claims_in_zip_area,
    CASE WHEN claim_id IS NOT NULL THEN 1 ELSE 0 END AS has_claim_flag
FROM joined_data
