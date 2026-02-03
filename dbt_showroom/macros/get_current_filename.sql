{% macro get_current_filename() %}
    {{ return(model.name.replace('staging_', '')) }}
{% endmacro %}