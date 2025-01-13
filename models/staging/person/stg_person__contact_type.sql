WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_contacttype') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.contacttypeid') AS INT64) AS pk_contact_type_id,
    JSON_VALUE(json_data, '$.name') AS contact_type_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
