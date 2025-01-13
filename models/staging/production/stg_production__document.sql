WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_document') }}
)

SELECT
    JSON_VALUE(json_data, '$.title') AS title,
    SAFE_CAST(JSON_VALUE(json_data, '$.owner') AS INT64) AS fk_document_employee_owner_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.folderflag') AS BOOL) AS folder_flag,
    JSON_VALUE(json_data, '$.filename') AS file_name,
    JSON_VALUE(json_data, '$.fileextension') AS file_extension,
    SAFE_CAST(JSON_VALUE(json_data, '$.revision') AS INT64) AS revision,
    SAFE_CAST(JSON_VALUE(json_data, '$.changenumber') AS INT64) AS change_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.status') AS INT64) AS status,
    JSON_VALUE(json_data, '$.documentsummary') AS document_summary,
    JSON_VALUE(json_data, '$.document') AS document,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date,
    JSON_VALUE(json_data, '$.documentnode') AS pk_document_node
FROM base
