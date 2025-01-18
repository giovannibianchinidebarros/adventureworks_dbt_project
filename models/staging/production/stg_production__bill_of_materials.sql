WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_billofmaterials') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.billofmaterialsid') AS INT64) AS pk_bill_of_materials_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productassemblyid') AS INT64) AS fk_product_assembly_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.componentid') AS INT64) AS fk_product_component_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.startdate') AS DATETIME) AS start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.enddate') AS DATETIME) AS end_date,
    JSON_VALUE(json_data, '$.unitmeasurecode') AS fk_unit_measure_code,
    SAFE_CAST(JSON_VALUE(json_data, '$.bomlevel') AS INT64) AS bom_level,
    SAFE_CAST(JSON_VALUE(json_data, '$.perassemblyqty') AS FLOAT64) AS per_assembly_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
