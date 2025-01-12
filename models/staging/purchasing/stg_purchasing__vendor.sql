WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('purchasing', 'purchasing_vendor') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS pk_vendor_id,
    JSON_VALUE(json_data, '$.accountnumber') AS account_number,
    JSON_VALUE(json_data, '$.name') AS name,
    SAFE_CAST(JSON_VALUE(json_data, '$.creditrating') AS INT64) AS credit_rating,
    SAFE_CAST(JSON_VALUE(json_data, '$.preferredvendorstatus') AS BOOL) AS preferred_vendor_status,
    SAFE_CAST(JSON_VALUE(json_data, '$.activeflag') AS BOOL) AS active_flag,
    JSON_VALUE(json_data, '$.purchasingwebserviceurl') AS purchasing_web_service_url,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
