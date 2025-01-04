WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productreview') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productreviewid') AS INT64) AS product_review_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS product_id,
    JSON_VALUE(json_data, '$.reviewername') AS reviewer_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.reviewdate') AS DATETIME) AS review_date,
    JSON_VALUE(json_data, '$.emailaddress') AS email_address,
    SAFE_CAST(JSON_VALUE(json_data, '$.rating') AS INT64) AS rating,
    JSON_VALUE(json_data, '$.comments') AS comments,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
