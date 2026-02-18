{% macro create_stg_table(relation) %}
    {%- set attr_names = [] -%}
    
    {%- if execute -%}
        {%- set attr_names = adapter.get_columns_in_relation(relation) -%}
    {%- endif -%}

    SELECT 
    {% if attr_names | length > 0 %}
        MD5(CAST({{ get_first_column(attr_names) }} AS text)) AS HASH_PK
        , {% for attr in attr_names %}
            {{ adapter.quote(attr.name) }}{% if not loop.last %}, {% endif %}
          {% endfor %}
        {# Only call hashing if we actually have attributes to hash #}
        {% set change_attrs = get_change_attributes(attr_names) %}
        {% if change_attrs | length > 0 %}
            , {{ concat_hash(change_attrs) }} AS HASH_DIFF
        {% else %}
            , NULL AS HASH_DIFF
        {% endif %}
    {% else %}
        {# Fallback string for the parser #}
        *
    {% endif %}
    
    FROM {{ relation }}
{% endmacro %}