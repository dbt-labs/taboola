with performance as (

    select * from {{ref('taboola_campaign_performance')}}

),

campaigns as (

    select * from {{ref('taboola_campaigns')}}

),

joined as (

    select

        performance.*,
        campaigns.utm_medium,
        campaigns.utm_source,
        campaigns.utm_campaign,
        campaigns.utm_content,
        campaigns.utm_term

    from performance
    left join campaigns on performance.campaign_id = campaigns.id

)

select * from joined
