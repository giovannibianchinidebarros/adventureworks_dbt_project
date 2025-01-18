WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productproductphoto') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productphotoid') AS INT64) AS fk_product_photo_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.primary') AS BOOLEAN) AS is_primary,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
