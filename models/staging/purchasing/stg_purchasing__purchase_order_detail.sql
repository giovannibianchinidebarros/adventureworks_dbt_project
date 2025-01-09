WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('purchasing', 'purchasing_purchaseorderdetail') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.purchaseorderid') AS INT64) AS purchase_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.purchaseorderdetailid') AS INT64) AS purchase_order_detail_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.duedate') AS DATETIME) AS due_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.orderqty') AS INT64) AS order_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.unitprice') AS FLOAT64) AS unit_price,
    SAFE_CAST(JSON_VALUE(json_data, '$.receivedqty') AS INT64) AS received_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.rejectedqty') AS INT64) AS rejected_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
ORDER BY purchase_order_id
