WITH 
sales_person AS (
    SELECT * 
    FROM {{ ref("stg_sales__sales_person") }}
)
, person AS (
    SELECT * 
    FROM {{ ref("int_person") }}
)
, final AS (
    SELECT
        sales_person.pk_salesperson_id as salesperson_id
        , person.person_name as sales_person_name
        , sales_person.fk_territory_id as territory_id
        , sales_person.sales_quota
        , sales_person.bonus
        , sales_person.commission_pct
        , sales_person.sales_ytd
        , sales_person.sales_last_year

    FROM sales_person
    LEFT JOIN person 
        ON sales_person.pk_salesperson_id = person.person_id
)
SELECT * FROM final