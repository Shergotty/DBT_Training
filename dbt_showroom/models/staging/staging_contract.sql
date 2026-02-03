{{ config(materialized='table', schema = 'staging') }}
{% set relation = source('seed', get_current_filename()) %}

{{ create_stg_table(relation) }}