SELECT 
    MD5(client_id::text) AS HASH_PK
    ,MD5(CONCAT(first_name::text, last_name::text, date_of_birth::text, email::text, phone::text, address::text, zip_code::text, city::text)) AS HASH_DIFF
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