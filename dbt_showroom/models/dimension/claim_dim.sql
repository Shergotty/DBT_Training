{{ config(materialized='table') }}

with src as (
    select *
    from {{ ref('snapshot_staging_claim') }}
)

select
    md5(cast(claim_id as varchar)) as claim_sk,
    claim_id,
    policy_number,
    claim_type,
    status,
    cast(incident_date as date) as incident_date
from src
where
    dbt_valid_to = '9999-12-31'
