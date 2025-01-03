WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_addresstype') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.addresstypeid') AS INT64) AS address_type_id,
    JSON_VALUE(json_data, '$.name') AS address_type_name,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
