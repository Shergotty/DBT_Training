{% macro get_first_column(attr_list) %}
    
    {% for attr in attr_list %}
        {% if loop.first %}
            {{ adapter.quote(attr.name) }}
        {% endif %}
    {% endfor %}

{% endmacro %}
