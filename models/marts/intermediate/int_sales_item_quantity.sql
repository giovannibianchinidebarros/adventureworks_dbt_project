WITH 
order_details AS (
    SELECT *
    FROM {{ ref("stg_sales__sales_order_detail") }}
)
, product AS (
    SELECT * 
    FROM {{ ref("stg_production__product") }}
)
, final AS (
    SELECT
        order_details.fk_sales_order_id as sales_order_id
        , COUNT(*) as num_items  -- Conta o número de itens na ordem
        , SUM(product.standard_cost) as total_cost  -- Soma do custo total dos itens
    FROM order_details
    LEFT JOIN product 
        ON order_details.fk_product_id = product.pk_product_id
    GROUP BY
        order_details.fk_sales_order_id
)
SELECT * 
FROM final
ORDER BY sales_order_id
