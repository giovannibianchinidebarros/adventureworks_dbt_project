WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productinventory') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.locationid') AS INT64) AS fk_location_id,
    JSON_VALUE(json_data, '$.shelf') AS shelf,
    SAFE_CAST(JSON_VALUE(json_data, '$.bin') AS INT64) AS bin,
    SAFE_CAST(JSON_VALUE(json_data, '$.quantity') AS INT64) AS quantity,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
