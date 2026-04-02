SELECT 
    MD5(client_id::text) AS HASH_PK
    ,MD5(CONCAT_WS('-', TRIM(first_name::text), TRIM(last_name::text), TRIM(date_of_birth::text), TRIM(email::text), TRIM(phone::text), TRIM(address::text), TRIM(zip_code::text), TRIM(city::text))) AS HASH_DIFF
    ,client_id
    ,first_name
    ,last_name
    ,date_of_birth
    ,email
    ,phone
    ,address
    ,zip_code
    ,city
FROM 
   {{source('seed', 'client')}}