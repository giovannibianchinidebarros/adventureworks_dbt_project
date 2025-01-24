WITH 
item AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_order_detail") }}
)
, sales AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_order_header") }}
)
, product AS (
    SELECT *
    FROM {{ ref("dim_product") }}
)
, territory AS (
    SELECT *
    FROM {{ ref("dim_territory") }}
)
, date AS (
    SELECT * 
    FROM {{ ref("dim_date") }}
)
, final AS (
    SELECT
        item.fk_sales_order_id as sales_order_id
        , item.pk_sales_order_detail_id as sales_order_detail_id
        , item.order_quantity
        , item.fk_product_id as product_id
        , item.unit_price
        , sales.order_date
        , date.year_number as order_date_year
        , date.month_of_year as order_date_month
        , date.month_name as order_date_month_name
        , date.month_start_date
        , date.week_start_date
        , sales.fk_territory_id
        , territory.territory_id as territory_id
        , territory.territory_name
        , territory.country_region_code
        , territory.country_region_name
        , territory.territory_group
        , product.product_name
        , product.standard_cost
        , product.list_price
        , product.subcategory
        , product.category
        , product.model_name

    FROM item
    LEFT JOIN sales 
        ON item.fk_sales_order_id = sales.pk_sales_order_id
    LEFT JOIN product 
        ON item.fk_product_id = product.product_id
    LEFT JOIN territory 
        ON sales.fk_territory_id = territory.territory_id
    LEFT JOIN date 
        ON sales.order_date = date.date_day
)
SELECT * FROM final
ORDER BY sales_order_id, sales_order_detail_id