WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productdocument') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date,
    JSON_VALUE(json_data, '$.documentnode') AS document_node
FROM base
