set start_date = '2025-07-07';
set end_date = '2025-08-03';
select salesforce_account_name,
          deployment || account_id as global_account_id,
          sum(coalesce(workspaces_worksheets_num_queries, 0)) as sql_files_queries,
          sum(coalesce(worksheet_num_queries, 0)) as worksheet_queries,
          sum(coalesce(workspaces_worksheets_num_queries, 0) + coalesce(worksheet_num_queries, 0)) as total_queries,
          sql_files_queries / total_queries as pct
   from snowscience.ui.apex_user_day_fact apex
   where true
     and apex.snowflake_account_type='Customer'
     and apex.agreement_type in ('Capacity',
                                 'Evaluation',
                                 'On Demand',
                                 'Solution Partner',
                                 'Partner Access')
     and true
     and to_date(ds) >= $start_date
     and to_date(ds) <= $end_date
     and (coalesce(workspaces_worksheets_num_queries, 0) > 0
          or coalesce(worksheet_num_queries, 0) > 0)
   group by all
   having sql_files_queries / total_queries >= 0.8;