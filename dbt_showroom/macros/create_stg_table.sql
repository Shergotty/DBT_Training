{% macro create_stg_table(relation) %}
    {% set table_columns = adapter.get_columns_in_relation(relation) %}
    SELECT 
       MD5(
            {{ 
                safe_concat([get_first_column(relation)])
                }}
            ) AS HASH_PK
        , {% for col in table_columns %}
            {{ col.name }}{% if not loop.last %}, {% endif %}
          {% endfor %}
        , {{ concat_hash(get_change_attributes(relation)) }}
            AS HASH_DIFF

    FROM 
        {{ relation }}
{% endmacro %}