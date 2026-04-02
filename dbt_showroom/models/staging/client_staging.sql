SELECT 
    MD5({{ client_id }}) AS id
    ,client_id
    ,first_name
    ,last_name
    ,date_of_birth
    ,email
    ,phone
    ,address
    ,zip_code
    ,city
    , MD5(CONCAT(first_name, last_name, date_of_birth, email, phone, address, zip_code, city)) AS full_name
FROM 
   {{source('seed', 'client')}}