WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_personcreditcard') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.creditcardid') AS INT64) AS credit_card_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
