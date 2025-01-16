WITH 
person AS (
    SELECT
        pk_person_id
        , person_type
        , CONCAT(first_name, 
            CASE 
                WHEN middle_name IS NOT NULL AND middle_name <> '' THEN CONCAT(' ', middle_name) 
                ELSE '' 
            END, 
            CASE 
                WHEN last_name IS NOT NULL AND last_name <> '' THEN CONCAT(' ', last_name) 
                ELSE '' 
            END) AS full_name
    FROM {{ ref("stg_person__person") }}
)
, address AS (
    SELECT * 
    FROM {{ ref("int_address") }}
)
, phone_number AS (
    SELECT * 
    FROM {{ ref("stg_person__phone_number") }}
)
, phone_number_type AS (
    SELECT * 
    FROM {{ ref("stg_person__phone_number_type") }}
)
, email AS (
    SELECT 
        fk_person_id
        , email_address
    FROM (
        SELECT 
            fk_person_id
            , email_address
            , ROW_NUMBER() OVER (PARTITION BY fk_person_id ORDER BY email_address) AS row_num
        FROM {{ ref("stg_person__email_address") }}
    ) subquery
    WHERE row_num = 1
)
, final AS (
    SELECT
        person.pk_person_id AS person_id
        , person.person_type as person_type
        , person.full_name AS person_name
        , address.full_address as person_address
        , address.city
        , address.state_province_code
        , address.state_province_name
        , address.country_region_code
        , address.country_region_name
        , address.territory_id
        , address.postal_code
        , address.address_type
        , phone_number.phone_number as phone
        , phone_number_type.phone_number_type_name as phone_type
        , email.email_address
    FROM person
    LEFT JOIN address 
        ON person.pk_person_id = address.entity_id
    LEFT JOIN email 
        ON person.pk_person_id = email.fk_person_id
    LEFT JOIN phone_number 
        ON person.pk_person_id = phone_number.fk_person_id
    LEFT JOIN phone_number_type 
        ON phone_number.fk_phone_number_type_id = phone_number_type.pk_phone_number_type_id
)
SELECT * FROM final
