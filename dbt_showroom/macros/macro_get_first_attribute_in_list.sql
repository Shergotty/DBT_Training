{% macro get_first_attribute_in_list(attributes) %}
    {%- if attributes | length > 0 -%}
        {{ attributes[0] }}
    {%- endif -%}
{% endmacro %}