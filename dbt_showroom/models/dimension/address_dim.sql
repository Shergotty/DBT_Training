WITH SRC AS (
    SELECT 
        DISTINCT STREET_NAME, STREET_NUMBER, ZIP_CODE, CITY
    FROM 
        {{ ref('snapshot_staging_client') }}
    WHERE
        dbt_valid_to = '9999-12-31'
)

SELECT   
    MD5(CONCAT_WS('|', TRIM(SRC.STREET_NAME::text), TRIM(SRC.STREET_NUMBER::text), TRIM(SRC.ZIP_CODE::text), TRIM(SRC.CITY::text))) AS ADDRESS_KEY
    , STREET_NAME
    , STREET_NUMBER
    , ZIP_CODE
    , CITY
FROM SRC