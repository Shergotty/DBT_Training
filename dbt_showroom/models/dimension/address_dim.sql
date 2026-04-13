WITH SRC AS (
    SELECT 
        DISTINCT STREET, STREET_NUMBER, ZIP_CODE, CITY
    FROM 
        {{ ref('snapshot_staging_client') }}
)

SELECT   
    MD5({{safe_concat('STREET', 'STREET_NUMBER', 'ZIP_CODE', 'CITY')}}) AS ADDRESS_KEY
    , STREET
    , STREET_NUMBER
    , ZIP_CODE
    , CITY
FROM SRC
WHERE
    DBT_VALID_TO = '9999-12-31'