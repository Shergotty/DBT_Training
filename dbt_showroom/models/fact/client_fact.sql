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
        ON MD5({{safe_concat('SC.STREET', 'SC.STREET_NUMBER', 'SC.ZIP_CODE', 'SC.CITY')}}) = A.ADDRESS_KEY
)
SELECT 
    *
FROM FACT_CLIENT_CTE
WHERE
    DBT_VALID_TO = '9999-12-31'