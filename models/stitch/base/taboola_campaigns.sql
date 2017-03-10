with base as (

    select

        id,
        name,

        to_date(start_date, 'yyyy-mm-dd') as start_date,
        nullif(end_date, '9999-12-31') as end_date,

        is_active,
        lower(status) as status,

        spent as spend,

        nullif(tracking_code, 'None') as tracking_code

    from {{var('campaigns_table')}}


),

splits as (

    select

        id,
        name,
        start_date,
        end_date,
        is_active,
        status,
        spend,

        split_part(split_part(tracking_code,'utm_source=',2), '&', 1) as utm_source,
        split_part(split_part(tracking_code,'utm_medium=',2), '&', 1) as utm_medium,
        split_part(split_part(tracking_code,'utm_campaign=',2), '&', 1) as utm_campaign,
        split_part(split_part(tracking_code,'utm_content=',2), '&', 1) as utm_content,
        split_part(split_part(tracking_code,'utm_term=',2), '&', 1) as utm_term

    from base


)

select * from splits
