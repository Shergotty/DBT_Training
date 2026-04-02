{% macro get_first_attribute_in_list(attributes) %}
    
    {% for attr in attr_list %}
        {% if loop.first %}
            {{ adapter.quote(attr.name) }}
        {% endif %}
    {% endfor %}

{% endmacro %}
