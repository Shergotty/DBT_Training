{{
    config(
        materialized = 'table',
    )
}}

with days as (

    select generate_series(
        '2000-01-01'::date,
        '2035-01-01'::date,
        '1 day'::interval
    )::date as date_day

),

final as (
    select cast(date_day as date) as date_day
    from days
)

select * from final
where date_day > (current_date - interval '4 years')
and date_day < (current_date + interval '30 days')