WITH aggregated_monthly AS (
    SELECT 
        week_start_date
        , territory_name
        , category
        , SUM(order_quantity) AS total_order_quantity
    FROM {{ ref("fct_sales_items") }}
    GROUP BY 
        week_start_date
        , territory_name
        , category
    ORDER BY 
        week_start_date
        , territory_name
        , category
)
SELECT * FROM aggregated_monthly