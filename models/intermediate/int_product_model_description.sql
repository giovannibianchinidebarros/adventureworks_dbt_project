WITH 
model_description_culture AS (
    SELECT * 
    FROM {{ ref("stg_production__product_model_product_description_culture") }}
)
, model AS (
    SELECT * 
    FROM {{ ref("stg_production__product_model") }}
)
, description AS (
    SELECT * 
    FROM {{ ref("stg_production__product_description") }}
)
, culture AS (
    SELECT * 
    FROM {{ ref("stg_production__culture") }}
)
, final AS (
    SELECT
        model_description_culture.fk_product_model_id as pk_product_model_id
        , model.product_model_name
        , description.description
        , culture.pk_culture_id as culture_id
        , culture.culture_name
    FROM model_description_culture
    LEFT JOIN model 
        ON model_description_culture.fk_product_model_id = model.pk_product_model_id
    LEFT JOIN description 
        ON model_description_culture.fk_product_description_id = description.pk_product_description_id
    LEFT JOIN culture 
        ON model_description_culture.fk_culture_id = culture.pk_culture_id
)
SELECT * FROM final
WHERE 
    TRIM(CAST(final.culture_id AS STRING)) = 'en'