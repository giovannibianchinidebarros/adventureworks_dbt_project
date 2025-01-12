WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salespersonquotahistory') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.quotadate') AS DATETIME) AS quota_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.salesquota') AS FLOAT64) AS sales_quota,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
