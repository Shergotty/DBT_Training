{%- macro get_first_attribute_in_relation(relation) -%}
    {%- set columns = adapter.get_columns_in_relation(relation) -%}
    {%- if columns | length == 0 -%}
        {{ exceptions.raise_compiler_error("The relation " ~ relation ~ " has no columns") }}
    {%- endif -%}
    {{- return(columns[0].name) -}}
{%- endmacro -%}