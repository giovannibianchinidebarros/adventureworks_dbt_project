WITH 
territory AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_territory") }}
)
,country AS (
    SELECT * 
    FROM {{ ref("stg_person__country_region") }}
)
, final AS (
    SELECT
        territory.pk_territory_id as territory_id
        , territory.territory_name
        , territory.country_region_code
        , country.country_region_name
        , territory.territory_group
        , territory.sales_ytd
        , territory.sales_last_year
        , territory.cost_ytd
        , territory.cost_last_year
    FROM territory
    LEFT JOIN country 
        ON territory.country_region_code = country.pk_country_region_code
)
SELECT * FROM final
