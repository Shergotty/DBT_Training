{% macro get_change_attributes(relation) %}

    {% set query %}
        WITH column_list AS (
            SELECT 
                column_name, 
                ordinal_position,
                COUNT(*) OVER() as total_columns
            FROM 
                information_schema.columns
            WHERE 
                table_schema = '{{ relation.schema }}' 
                AND table_name = '{{ relation.identifier }}'
        )
        SELECT 
            column_name
        FROM 
            column_list
        WHERE 
            ordinal_position > 1
        ORDER BY 
            ordinal_position
    {% endset %}

    {% set results = run_query(query) %}

    {% if execute %}
        {% set columns = results.columns[0].values() %}
        {{ return(columns) }}
    {% else %}
        {{ return([]) }}
    {% endif %}

{% endmacro %}