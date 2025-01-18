WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productdescription') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productdescriptionid') AS INT64) AS pk_product_description_id,
    JSON_VALUE(json_data, '$.description') AS description,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
