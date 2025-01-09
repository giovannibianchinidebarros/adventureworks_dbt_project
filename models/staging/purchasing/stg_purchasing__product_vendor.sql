WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('purchasing', 'purchasing_productvendor') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.averageleadtime') AS INT64) AS average_lead_time,
    SAFE_CAST(JSON_VALUE(json_data, '$.standardprice') AS FLOAT64) AS standard_price,
    SAFE_CAST(JSON_VALUE(json_data, '$.lastreceiptcost') AS FLOAT64) AS last_receipt_cost,
    SAFE_CAST(JSON_VALUE(json_data, '$.lastreceiptdate') AS DATETIME) AS last_receipt_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.minorderqty') AS INT64) AS min_order_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.maxorderqty') AS INT64) AS max_order_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.onorderqty') AS INT64) AS on_order_qty,
    JSON_VALUE(json_data, '$.unitmeasurecode') AS unit_measure_code,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
