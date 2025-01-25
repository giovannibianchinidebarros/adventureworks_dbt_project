WITH aggregated_monthly AS (
    SELECT 
        month_start_date
        , territory_name
        , category
        , subcategory
        , SUM(order_quantity) AS total_order_quantity
    FROM {{ ref("fct_sales_items") }}
    GROUP BY 
        month_start_date
        , territory_name
        , category
        , subcategory
    ORDER BY 
        month_start_date
        , territory_name
        , category
        , subcategory
)
SELECT * FROM aggregated_monthly