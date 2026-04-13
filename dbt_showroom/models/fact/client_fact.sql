{% set source_table = ref('snapshot_staging_client') %}
{% set claim_type_dim = ref('address_dim') %}

WITH FACT_CLIENT_CTE AS (
    SELECT
        CLIENT_ID
        , FIRST_NAME
        , LAST_NAME
        , DATE_OF_BIRTH
        , EMAIL
        , PHONE
        , A.ADDRESS_KEY
    FROM {{ source_table }} AS SC
    INNER JOIN {{ claim_type_dim }} AS A
        ON MD5({{ safe_concat(['SC.STREET_NAME', 'SC.STREET_NUMBER', 'SC.ZIP_CODE', 'SC.CITY'], separator='|') }}) = A.ADDRESS_KEY
    WHERE
        SC.dbt_valid_to = '9999-12-31'
    
)
SELECT 
    *
FROM FACT_CLIENT_CTE
