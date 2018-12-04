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

        {{ dbt_utils.get_url_parameter('tracking_code', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('tracking_code', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('tracking_code', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('tracking_code', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('tracking_code', 'utm_term') }} as utm_term

    from base


)

select * from splits
