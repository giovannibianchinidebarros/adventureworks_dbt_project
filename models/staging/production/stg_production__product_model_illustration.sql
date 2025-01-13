WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productmodelillustration') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productmodelid') AS INT64) AS fk_product_model_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.illustrationid') AS INT64) AS fk_illustration_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
