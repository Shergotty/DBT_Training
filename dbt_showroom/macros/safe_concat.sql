{% macro safe_concat(attr_list) %}
    CONCAT(
        {%- for attr in attr_list -%}
            TRIM(TEXT({{ attr }})){%- if not loop.last -%}, {% endif -%}
        {%- endfor -%}
    )
{% endmacro %}