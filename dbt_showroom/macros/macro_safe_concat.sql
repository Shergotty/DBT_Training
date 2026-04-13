{% macro safe_concat(attribute_list, separator='-') %}
    
    {%- if attribute_list | length > 0 -%}
        CONCAT_WS('{{ separator }}', 
            {%- for attr in attribute_list -%}
                TRIM({{ attr }}::text){%- if not loop.last -%}, {% endif -%}
            {%- endfor -%}
        )
    {%- else -%}
        -- Safe fallback if a table only has 1 column
        'NO_DIFF_ATTRIBUTES'
    {%- endif -%}

{% endmacro %}