{% macro filter_attribute_list(all_attributes, exclude_attributes) %}
    {%- set filtered_list = [] -%}
    
    {%- for attr in all_attributes -%}
        {%- if attr not in exclude_attributes -%}
            {%- do filtered_list.append(attr) -%}
        {%- endif -%}
    {%- endfor -%}
    
    {{ return(filtered_list) }}
{% endmacro %}