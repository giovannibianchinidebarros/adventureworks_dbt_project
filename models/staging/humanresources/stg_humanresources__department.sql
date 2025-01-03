WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('humanresources','humanresources_department') }}
)
SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.departmentid') AS INT64) AS department_id,
    JSON_VALUE(json_data, '$.name') AS name,
    JSON_VALUE(json_data, '$.groupname') AS group_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base