{{ config(materialized='ephemeral') }}

select * from {{ ref('staging_claim')}}