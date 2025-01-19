WITH 
sales_reason AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_order_header_sales_reason") }}
)
, reason AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_reason") }}
)
, final AS (
    SELECT
        sales_reason.fk_sales_order_id as sales_order_id
        , STRING_AGG(reason.reason_name, ', ') AS sales_reasons
        , STRING_AGG(reason.reason_type, ', ') AS sales_reason_type
    FROM sales_reason
    LEFT JOIN reason 
        ON sales_reason.fk_sales_reason_id = reason.pk_sales_reason_id
    GROUP BY
    sales_reason.fk_sales_order_id
)
SELECT * FROM final
order by sales_order_id