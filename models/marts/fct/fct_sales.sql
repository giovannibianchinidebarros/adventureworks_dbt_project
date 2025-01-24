WITH 
sales AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_order_header") }}
)
, reason AS (
    SELECT *
    FROM {{ ref("int_sales_reason") }}
)
, quantity AS (
    SELECT *
    FROM {{ ref("int_sales_item_quantity") }}
)
, customer AS (
    SELECT * 
    FROM {{ ref("dim_customer") }}
)
, sales_person AS (
    SELECT * 
    FROM {{ ref("dim_sales_person") }}
)
, territory AS (
    SELECT * 
    FROM {{ ref("dim_territory") }}
)
, credit_card AS (
    SELECT * 
    FROM {{ ref("stg_sales__credit_card") }}
)
, date AS (
    SELECT * 
    FROM {{ ref("dim_date") }}
)
, final AS (
    SELECT
        sales.pk_sales_order_id as sales_order_id
        , COALESCE(sales_reasons, 'Other') AS sales_reasons
        , COALESCE(sales_reason_type, 'Other') AS sales_reason_type
        , sales.order_date
        , date.year_number as order_date_year
        , date.month_of_year as order_date_month
        , date.month_name as order_date_month_name
        , sales.status
        , CASE 
            WHEN status = 1 THEN 'In process'
            WHEN status = 2 THEN 'Approved'
            WHEN status = 3 THEN 'Backordered'
            WHEN status = 4 THEN 'Rejected'
            WHEN status = 5 THEN 'Shipped'
            WHEN status = 6 THEN 'Cancelled'
            ELSE 'Unknown'
        END AS status_description
        , sales.online_order_flag as is_online_order
        , customer.customer_type
        , customer.customer_name
        , sales_person.salesperson_id as salesperson_id
        , sales_person.sales_person_name
        , territory.territory_id as territory_id
        , territory.territory_name
        , territory.country_region_code
        , territory.country_region_name
        , territory.territory_group
        , quantity.num_items as number_of_itens
        , quantity.total_cost
        , sales.subtotal
        , sales.tax_amount
        , sales.freight
        , sales.total_due
        , COALESCE(credit_card.card_type, 'Other') AS credit_card_type
    FROM sales
    LEFT JOIN reason 
        ON sales.pk_sales_order_id = reason.sales_order_id
    LEFT JOIN quantity 
        ON sales.pk_sales_order_id = quantity.sales_order_id
    LEFT JOIN customer 
        ON sales.fk_customer_id = customer.customer_id
    LEFT JOIN sales_person 
        ON sales.fk_salesperson_id = sales_person.salesperson_id
    LEFT JOIN territory 
        ON sales.fk_territory_id = territory.territory_id
    LEFT JOIN credit_card 
        ON sales.fk_credit_card_id = credit_card.pk_credit_card_id
    LEFT JOIN date 
        ON sales.order_date = date.date_day
)
SELECT * FROM final
ORDER BY sales_order_id