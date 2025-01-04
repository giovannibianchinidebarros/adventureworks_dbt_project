WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productsubcategory') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productsubcategoryid') AS INT64) AS product_subcategory_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productcategoryid') AS INT64) AS product_category_id,
    JSON_VALUE(json_data, '$.name') AS name,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
