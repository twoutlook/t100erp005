#Primary Key Constant

CONSTANT cs_new_line          STRING = "\n"     

CONSTANT cs_slave_user        STRING = "dsdemo"

CONSTANT cs_dept              STRING = "None"

CONSTANT cs_synonym_shorthand STRING = "S"
CONSTANT cs_table_shorthand   STRING = "T"

CONSTANT cs_modify_template   STRING = "modtpl"
CONSTANT cs_modify_view       STRING = "modview"
CONSTANT cs_create_view       STRING = "crtview"
CONSTANT cs_drop_view         STRING = "drpview"
CONSTANT cs_browse_view       STRING = "brsview"
CONSTANT cs_test_view         STRING = "tstview"

CONSTANT cs_side_left  STRING = "LEFT"
CONSTANT cs_side_right STRING = "RIGHT"

CONSTANT cs_view_type_row       STRING = "row"
CONSTANT cs_view_type_statement STRING = "statement"

CONSTANT cs_null_username_default STRING = "Tester"

#Parameter Level define
CONSTANT cs_param_level_view    STRING = "View"

#View Level
CONSTANT cs_param_event STRING = "Event"

CONSTANT cs_response_cancel STRING = "cancel" 

CONSTANT cs_lang_zh_cn  STRING = "zh_CN"
CONSTANT cs_lang_zh_tw  STRING = "zh_TW"

CONSTANT cs_view_keyword_begin STRING = "BEGIN"

CONSTANT cs_exclude_keyword_delete STRING = "DELETE"
CONSTANT cs_exclude_keyword_update STRING = "UPDATE"

CONSTANT cs_mdm_module_name STRING = "MDM"

CONSTANT cs_type_std_to_cust STRING = "STD_TO_CUST"   #標準轉客制  --add at 20160315 by CircleLai
CONSTANT cs_type_cust_to_std STRING = "CUST_TO_STD"   #客制還原標準  --add at 20160315 by CircleLai

CONSTANT cs_topind_standard STRING = "sd"
CONSTANT cs_view_tail_code STRING = "_v"
CONSTANT cs_view_user_customize STRING = "uc"

CONSTANT cs_view_head_code_erp STRING = "erp_"
CONSTANT cs_view_head_code_all STRING = "all_"
CONSTANT cs_view_head_code_b2b STRING = "b2b_"
CONSTANT cs_view_head_code_dsm STRING = "dsm_"
CONSTANT cs_view_head_code_pos STRING = "pos_"

CONSTANT cs_identift_viewname STRING = "{VIEWNAME}"
CONSTANT cs_create_view_syntax STRING = "CREATE OR REPLACE VIEW {VIEWNAME} AS "

CONSTANT ci_max_view_length INTEGER = 20

CONSTANT cs_sql_base_select       STRING = "SELECT "
CONSTANT cs_sql_base_distinct     STRING = "DISTINCT "
CONSTANT cs_sql_base_from         STRING = "FROM "
CONSTANT cs_sql_base_where        STRING = "WHERE "
CONSTANT cs_sql_base_and          STRING = "AND "
CONSTANT cs_sql_base_or           STRING = "OR "
CONSTANT cs_sql_base_not          STRING = "NOT "
CONSTANT cs_sql_base_in           STRING = "IN "
CONSTANT cs_sql_base_between      STRING = "BETWEEN "
CONSTANT cs_sql_base_like         STRING = "LIKE "
CONSTANT cs_sql_base_exists       STRING = "EXISTS "
CONSTANT cs_sql_base_order_by     STRING = "ORDER BY "
CONSTANT cs_sql_base_group_by     STRING = "GROUP BY "
CONSTANT cs_sql_base_union        STRING = "UNION "
CONSTANT cs_sql_base_having       STRING = "HAVING "

CONSTANT cs_sql_cmpnd_select_from      STRING = "SELECT  FROM "
CONSTANT cs_sql_cmpnd_inner_join       STRING = "INNER JOIN "
CONSTANT cs_sql_cmpnd_left_outer_join  STRING = "LEFT OUTER JOIN "
CONSTANT cs_sql_cmpnd_on               STRING = "ON "
CONSTANT cs_sql_cmpnd_where_exists     STRING = "WHERE EXISTS "
CONSTANT cs_sql_cmpnd_where_not_exists STRING = "WHERE NOT EXISTS "

CONSTANT cs_sql_open_paren  STRING = "("
CONSTANT cs_sql_close_paren STRING = ")"
CONSTANT cs_sql_dot         STRING = "."

CONSTANT cs_db_name_ds     STRING = "DS"
CONSTANT cs_db_name_dsdemo STRING = "DSDEMO"
CONSTANT cs_db_name_dsdata STRING = "DSDATA"
CONSTANT cs_db_name_dsaws  STRING = "DSAWS"
CONSTANT cs_db_name_dsawst STRING = "DSAWST"

CONSTANT cs_test_sql_begin STRING = "SELECT 'TEST' FROM ("
CONSTANT cs_test_sql_end   STRING = ") TEST_SQL WHERE 1=2"

CONSTANT cs_ora_set_sqlblanklines_on STRING = "SET SQLBLANKLINES ON"