{% macro get_attribute_list(relation) %}
    {% set attributes = adapter.get_columns_in_relation(relation) %}
    {%- set attribute_list = [] -%}
    {%- for attr in attributes -%}
        {%- do attribute_list.append(adapter.quote(attr.name)) -%}
    {%- endfor -%}
    {{ return(attribute_list) }}
{% endmacro %}