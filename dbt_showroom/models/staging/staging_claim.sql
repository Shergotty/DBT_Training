{% set relation = source('seed', get_current_filename_staging()) %}

{{ create_stg_table(relation) }}