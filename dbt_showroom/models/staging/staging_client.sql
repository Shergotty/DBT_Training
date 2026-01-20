{{ config(materialized='table', schema = 'staging') }}

WITH STG_CLIENT AS (

    SELECT 
        MD5(
            CONCAT(
                TEXT(client_id)
                , TEXT(first_name)
                , TEXT(last_name)
                , TEXT(date_of_birth)
                , TEXT(email)
                , TEXT(phone)
                , TEXT(address)
                , TEXT(zip_code)
                , TEXT(city)
                )
            ) AS HASH_CLIENT
        , client_id
        , first_name
        , last_name
        , date_of_birth
        , email
        , phone
        , address
        , zip_code
        , city
        , MD5(
            CONCAT(
                TEXT(first_name)
                , TEXT(last_name)
                , TEXT(date_of_birth)
                , TEXT(email)
                , TEXT(phone)
                , TEXT(address)
                , TEXT(zip_code)
                , TEXT(city)
                )
            ) 
        AS HASH_DIFF
        , CURRENT_TIMESTAMP AS TIMESTAMP_INSERT

    FROM 
        {{ ref('client') }}
)

SELECT 
    *
FROM    
    STG_CLIENT