WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productmodel') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productmodelid') AS INT64) AS pk_product_model_id,
    JSON_VALUE(json_data, '$.name') AS product_model_name,
    JSON_VALUE(json_data, '$.catalogdescription') AS catalog_description,
    JSON_VALUE(json_data, '$.instructions') AS instructions,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
