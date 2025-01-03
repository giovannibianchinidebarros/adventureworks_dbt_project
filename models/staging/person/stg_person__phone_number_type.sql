WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_phonenumbertype') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.phonenumbertypeid') AS INT64) AS phone_number_type_id,
    JSON_VALUE(json_data, '$.name') AS phone_number_type_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
