select

    md5(date::varchar || campaign_id::varchar) as id,

    to_date(date, 'yyyy-mm-dd') as date_day,
    campaign_id,

    impressions,
    clicks,
    cpa_actions_num as conversions,
    spent as spend,
    currency

from {{var('performance_table')}}
