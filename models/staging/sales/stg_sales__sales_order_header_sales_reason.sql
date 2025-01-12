WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salesorderheadersalesreason') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.salesorderid') AS INT64) AS sales_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.salesreasonid') AS INT64) AS sales_reason_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
