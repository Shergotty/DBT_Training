{% macro get_change_attributes(attr_list) %}
    {% set attr_names = [] %}
    
    {# During parsing, attr_list might be None or empty #}
    {% if execute and attr_list is not none and attr_list | length > 0 %}
        {% for attr in attr_list[1:] %}
            {% do attr_names.append(adapter.quote(attr.name)) %}
        {% endfor %}
    {% endif %}

    {{ return(attr_names) }}
{% endmacro %}