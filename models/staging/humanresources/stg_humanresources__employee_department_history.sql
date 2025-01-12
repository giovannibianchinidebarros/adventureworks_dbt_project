WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('humanresources', 'humanresources_employeedepartmenthistory') }}
)
SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS fk_employee_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.departmentid') AS INT64) AS department_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.shiftid') AS INT64) AS shift_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.startdate') AS DATE) AS start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.enddate') AS DATE) AS end_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
