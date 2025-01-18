WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_businessentity') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS pk_business_entity_id,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
