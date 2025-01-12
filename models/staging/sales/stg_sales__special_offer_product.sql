WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_specialofferproduct') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.specialofferid') AS INT64) AS special_offer_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS product_id,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
