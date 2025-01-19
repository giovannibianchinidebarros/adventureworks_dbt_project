WITH 
entity_address AS (
    SELECT * 
    FROM {{ ref("stg_person__business_entity_address") }}
)
,entity AS (
    SELECT * 
    FROM {{ ref("stg_person__business_entity") }}
)
,address AS (
    SELECT * 
    FROM {{ ref("stg_person__address") }}
)
,address_type AS (
    SELECT * 
    FROM {{ ref("stg_person__address_type") }}
)
,state_province AS (
    SELECT * 
    FROM {{ ref("stg_person__state_province") }}
)
,country AS (
    SELECT * 
    FROM {{ ref("stg_person__country_region") }}
)
,final AS (
    SELECT
        entity_address.fk_business_entity_id AS entity_id
        , address.pk_address_id as address_id
        , address.full_address
        , address.city
        , state_province.state_province_code
        , state_province.state_province_name
        , state_province.fk_country_region_code as country_region_code
        , country.country_region_name
        , state_province.fk_territory_id as territory_id
        , address.postal_code
        , address_type.address_type_name AS address_type
    FROM entity_address
    LEFT JOIN entity 
        ON entity_address.fk_business_entity_id = entity.pk_business_entity_id
    LEFT JOIN address 
        ON entity_address.fk_address_id = address.pk_address_id
    LEFT JOIN address_type 
        ON entity_address.fk_address_type_id = address_type.pk_address_type_id
    LEFT JOIN state_province 
        ON address.fk_state_province_id = state_province.pk_state_province_id -- Novo join
    LEFT JOIN country 
        ON state_province.fk_country_region_code = country.pk_country_region_code -- Novo join
)
SELECT * FROM final
