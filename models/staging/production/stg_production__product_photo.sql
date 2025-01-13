WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productphoto') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productphotoid') AS INT64) AS pk_product_photo_id,
    JSON_VALUE(json_data, '$.thumbnailphoto') AS thumbnail_photo,
    JSON_VALUE(json_data, '$.thumbnailphotofilename') AS thumbnail_photo_filename,
    JSON_VALUE(json_data, '$.largephoto') AS large_photo,
    JSON_VALUE(json_data, '$.largephotofilename') AS large_photo_filename,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
