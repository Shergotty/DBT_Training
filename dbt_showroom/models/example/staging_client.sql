{{ config(materialized='table', schema = 'staging') }}

WITH STG_CLIENT AS (

    SELECT 
        MD5(TRIM(first_name, last_name, date_of_birth, email, phone, address, zip_code, city)) AS HASH_CLIENT
        , client_id
        , first_name
        , last_name
        , date_of_birth
        , email
        , phone
        , address
        , zip_code
        , city
    FROM 
        {{ ref('client') }}
)

SELECT 
    *
FROM    
    STG_CLIENT