{% macro get_attribute_list(attributes) %}
    {% set attr_list = [] %}

    {% for attr in attributes %}
        {% do attr_list.append(attr) %}
    {% endfor %}

    {{ return(attr_list) }}

{% endmacro %}