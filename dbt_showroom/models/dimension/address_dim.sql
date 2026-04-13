WITH SRC AS (
    SELECT 
        DISTINCT STREET_NAME, STREET_NUMBER, ZIP_CODE, CITY
    FROM 
        {{ ref('snapshot_staging_client') }}
    WHERE
        dbt_valid_to = '9999-12-31'
)

SELECT   
    MD5({{ safe_concat(['SRC.STREET_NAME', 'SRC.STREET_NUMBER', 'SRC.ZIP_CODE', 'SRC.CITY'], separator='|') }}) AS ADDRESS_KEY
    , STREET_NAME
    , STREET_NUMBER
    , ZIP_CODE
    , CITY
FROM SRC047320