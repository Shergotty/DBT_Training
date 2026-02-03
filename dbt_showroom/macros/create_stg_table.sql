{% macro create_stg_table(relation) %}
    SELECT 
       MD5(
            {{ 
                safe_concat([get_first_column(relation)])
                }}
            ) AS HASH_PK
        , *
        , {{ concat_hash(get_change_attributes(relation)) }}
            AS HASH_DIFF

    FROM 
        {{ relation }}
{% endmacro %}