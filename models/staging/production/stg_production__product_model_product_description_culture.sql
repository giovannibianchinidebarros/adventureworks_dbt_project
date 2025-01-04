WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productmodelproductdescriptionculture') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productmodelid') AS INT64) AS product_model_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productdescriptionid') AS INT64) AS product_description_id,
    JSON_VALUE(json_data, '$.cultureid') AS culture_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
