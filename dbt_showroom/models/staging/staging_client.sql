{{ config(materialized='table', schema = 'staging') }}

WITH STG_CLIENT AS (

    SELECT 
       MD5(
            {{ 
                safe_concat(['client_id'])
                }}
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
        , {{concat_hash([
            'first_name'
            , 'last_name'
            , 'date_of_birth'
            , 'email'
            , 'phone'
            , 'address'
            , 'zip_code'
            , 'city'
                ])
            }}
            AS HASH_DIFF

    FROM 
        {{ source('seed', 'client') }}
)

SELECT 
    *
FROM    
    STG_CLIENT