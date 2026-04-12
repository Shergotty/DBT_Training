{{ config(materialized='table') }}

with src as (
    select *
    from {{ ref('snapshot_staging_claim') }}
)

select
    d.claim_sk,
    s.claim_id,
    s.policy_number,
    cast(s.incident_date as date) as incident_date,
    cast(s.claim_amount as numeric) as claim_amount
from src s

left join {{ ref('claim_dim') }} d
  using (claim_id)
where
    s.dbt_valid_to = '9999-12-31'