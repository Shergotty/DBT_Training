{% macro get_current_filename_staging() %}
    {{ return(model.name.replace('staging_', '')) }}
{% endmacro %}