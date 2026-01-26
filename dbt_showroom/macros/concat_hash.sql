{% macro concat_hash(attr_list) %}

    MD5({{safe_concat(attr_list)}})

{% endmacro %}