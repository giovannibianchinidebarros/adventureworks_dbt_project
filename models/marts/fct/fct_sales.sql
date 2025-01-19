WITH 
sales AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_order_header") }}
)
, reason AS (
    SELECT *
    FROM {{ ref("int_sales_reason") }}
)
, products AS (
    SELECT *
    FROM {{ ref("int_sales_products") }}
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
        , date.month_of_year
        , date.month_name
        , date.year_number
        , sales.status
        , sales.online_order_flag
        , customer.pk_customer_id
        , customer.fk_person_id
        , customer.fk_store_id
        , sales_person.pk_salesperson_id
        , territory.pk_territory_id
        , territory.territory_name
        , territory.country_region_code
        , territory.country_region_name
        , territory.territory_group
        , products.num_items as number_of_itens
        , products.total_cost
        , sales.subtotal
        , sales.tax_amount
        , sales.freight
        , sales.total_due
        , COALESCE(credit_card.card_type, 'Other') AS credit_card_type
    FROM sales
    LEFT JOIN reason 
        ON sales.pk_sales_order_id = reason.sales_order_id
    LEFT JOIN products 
        ON sales.pk_sales_order_id = products.sales_order_id
    LEFT JOIN customer 
        ON sales.fk_customer_id = customer.pk_customer_id
    LEFT JOIN sales_person 
        ON sales.fk_salesperson_id = sales_person.pk_salesperson_id
    LEFT JOIN territory 
        ON sales.fk_territory_id = territory.pk_territory_id
    LEFT JOIN credit_card 
        ON sales.fk_credit_card_id = credit_card.pk_credit_card_id
    LEFT JOIN date 
        ON sales.order_date = date.date_day
)
SELECT * FROM final
ORDER BY sales_order_id