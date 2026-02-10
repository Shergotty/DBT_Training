{% macro get_first_column(relation) %}

    {% set query %}
        SELECT 
            column_name
        FROM 
            information_schema.columns
        WHERE 
            table_schema = '{{ relation.schema }}' 
            AND table_name = '{{ relation.identifier }}'
            AND ordinal_position = 1
    {% endset %}

    {% set results = run_query(query) %}

    {% if execute %}
        {% if results|length > 0 %}
            {{ return(results.columns[0].values()[0]) }}
        {% else %}
            {{ return('') }}
        {% endif %}
    {% else %}
        {{ return('') }}
    {% endif %}

{% endmacro %}
