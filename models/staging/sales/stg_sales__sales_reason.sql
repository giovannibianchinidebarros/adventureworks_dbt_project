WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salesreason') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.salesreasonid') AS INT64) AS sales_reason_id,
    JSON_VALUE(json_data, '$.name') AS reason_name,
    JSON_VALUE(json_data, '$.reasontype') AS reason_type,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
