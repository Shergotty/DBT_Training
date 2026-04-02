SELECT 
    MD5({{ client_id }}) AS id
    ,client_id
    ,first_name
    ,last_name
    ,date_of_birt
    ,email
    ,phone
    ,address
    ,zip_code
    ,city 
FROM 
    source('seed', 'client')