WITH 
sales_person AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_person") }}
)
, final AS (
    SELECT
        sales_person.pk_salesperson_id
        , sales_person.fk_territory_id
        , sales_person.sales_quota
        , sales_person.bonus
        , sales_person.commission_pct
        , sales_person.sales_ytd
        , sales_person.sales_last_year

    FROM sales_person
)
SELECT * FROM final