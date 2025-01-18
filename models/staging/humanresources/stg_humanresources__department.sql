WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('humanresources','humanresources_department') }}
)
SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.departmentid') AS INT64) AS pk_department_id,
    JSON_VALUE(json_data, '$.name') AS department_name,
    JSON_VALUE(json_data, '$.groupname') AS department_group_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS department_modified_date
FROM base