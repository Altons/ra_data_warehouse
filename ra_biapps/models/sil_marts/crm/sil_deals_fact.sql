{{
    config(
        alias='deals_fact'
    )
}}
SELECT
   d.source,
   GENERATE_UUID() as deal_pk,
   company_pk as deal_company_pk,
   deal_name,
   deal_amount,
   deal_local_amount,
   deal_type,
   deal_description,
   deal_pricing_model,
   deal_products_in_solution,
   deal_sprint_type,
   deal_days_to_close,
   deal_delivery_start_ts,
   deal_delivery_schedule_ts,
   deal_number_of_sprints,
   deal_duration_days,
   deal_source,
   deal_partner_referral_type,
   deal_components,
   s.staff_pk as deal_assigned_consultant_staff_pk,
   deal_owner_id,
   deal_last_modified_ts,
   deal_stage_name,
   deal_stage_id,
   deal_stage_ts,
   deal_pipeline_name,
   deal_closed_date,
   deal_created_ts,
   deal_closed_lost_reason,
   sp.staff_pk as deal_salesperson_staff_pk
FROM
   {{ ref('sde_deals_fs') }} d
LEFT OUTER JOIN {{ ref('sil_companies_dim') }} c
   ON d.deal_company_id = c.hubspot_company_id
LEFT OUTER JOIN {{ ref('sil_staff_dim') }} s
   ON d.deal_assigned_consultant = s.staff_full_name
LEFT OUTER JOIN {{ ref('sil_staff_dim') }} sp
   ON d.deal_salesperson_email = sp.staff_email
