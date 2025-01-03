WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_personphone') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    JSON_VALUE(json_data, '$.phonenumber') AS phone_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.phonenumbertypeid') AS INT64) AS phone_number_type_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
