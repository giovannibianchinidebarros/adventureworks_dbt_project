WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_person') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    JSON_VALUE(json_data, '$.persontype') AS person_type,
    SAFE_CAST(JSON_VALUE(json_data, '$.namestyle') AS BOOL) AS name_style,
    JSON_VALUE(json_data, '$.title') AS title,
    JSON_VALUE(json_data, '$.firstname') AS first_name,
    JSON_VALUE(json_data, '$.middlename') AS middle_name,
    JSON_VALUE(json_data, '$.lastname') AS last_name,
    JSON_VALUE(json_data, '$.suffix') AS suffix,
    SAFE_CAST(JSON_VALUE(json_data, '$.emailpromotion') AS INT64) AS email_promotion,
    JSON_VALUE(json_data, '$.additionalcontactinfo') AS additional_contact_info,
    JSON_VALUE(json_data, '$.demographics') AS demographics,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
