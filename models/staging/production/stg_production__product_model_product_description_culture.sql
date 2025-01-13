WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productmodelproductdescriptionculture') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productmodelid') AS INT64) AS fk_product_model_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productdescriptionid') AS INT64) AS fk_product_description_id,
    JSON_VALUE(json_data, '$.cultureid') AS fk_culture_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
