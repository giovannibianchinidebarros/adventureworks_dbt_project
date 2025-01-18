WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_transactionhistoryarchive') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.transactionid') AS INT64) AS transaction_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.referenceorderid') AS INT64) AS reference_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.referenceorderlineid') AS INT64) AS reference_order_line_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.transactiondate') AS DATETIME) AS transaction_date,
    JSON_VALUE(json_data, '$.transactiontype') AS transaction_type,
    SAFE_CAST(JSON_VALUE(json_data, '$.quantity') AS INT64) AS quantity,
    SAFE_CAST(JSON_VALUE(json_data, '$.actualcost') AS FLOAT64) AS actual_cost,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
