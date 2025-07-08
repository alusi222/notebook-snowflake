select end_date as ds, count(distinct salesforce_account_name), sum(total_credits) from snowhouse.product.job_credits_day_tool_fact fct
inner join snowscience.dimensions.dim_accounts_history dim
on fct.account_id = dim.SNOWFLAKE_ACCOUNT_ID
and fct.deployment = dim.snowflake_deployment
and ds = dim.general_date
and dim.agreement_type = 'Capacity'
and ds > '2025-02-01'
where tool = 'hex_technologies'
group by 1
order by 1 asc;