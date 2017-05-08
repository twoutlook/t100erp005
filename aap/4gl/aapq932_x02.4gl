#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq932_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-08-01 10:34:16), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: aapq932_x02
#+ Description: ...
#+ Creator....: 05016(2015-04-23 14:51:03)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="aapq932_x02.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
#151022-00017#4    15/09/03 By Hans    axrq930/axrq932，彙總條件改變
#151029            15/10/29 By Hans    信用額度不隱藏
#151223-00001#4    15/12/28 By Reanna  1.本幣期末金額 欄位名稱改成:重評後未沖本幣
#                                      2.加一欄:重評前本幣>>xrea113 - 調匯金額
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #aapq932_print_tmp2 
       a2 LIKE type_t.chr1,         #g_check_hide 
       a3 LIKE type_t.chr1,         #g_curr_hide 
       a4 LIKE type_t.num5,         #g_input.cre 
       a5 LIKE type_t.num5,         #g_input.cre 
       a6 LIKE type_t.num5          #g_group
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table2     STRING
#end add-point
 
{</section>}
 
{<section id="aapq932_x02.main" readonly="Y" >}
PUBLIC FUNCTION aapq932_x02(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  aapq932_print_tmp2 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  g_check_hide 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  g_curr_hide 
DEFINE  p_arg5 LIKE type_t.num5         #tm.a4  g_input.cre 
DEFINE  p_arg6 LIKE type_t.num5         #tm.a5  g_input.cre 
DEFINE  p_arg7 LIKE type_t.num5         #tm.a6  g_group
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
   LET tm.a5 = p_arg6
   LET tm.a6 = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table2 = tm.a1
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aapq932_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aapq932_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aapq932_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aapq932_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aapq932_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aapq932_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapq932_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aapq932_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_group1.type_t.chr80,l_group1_desc.type_t.chr80,l_group2.type_t.chr80,l_group2_desc.type_t.chr80,l_group3.type_t.chr80,l_group3_desc.type_t.chr80,xrea011.xrea_t.xrea011,l_xrea011_desc.type_t.chr80,xrea016.xrea_t.xrea016,l_xrea016_desc.type_t.chr80,l_pmab053.type_t.chr80,l_pmab053_desc.type_t.chr80,xrea100.xrea_t.xrea100,l_xrea1031.xrea_t.xrea103,l_xrea1032.xrea_t.xrea103,l_xrea1033.xrea_t.xrea103,l_xrea1034.xrea_t.xrea103,l_xrea1131.xrea_t.xrea113,l_xrea1132.xrea_t.xrea113,l_xrea1133.xrea_t.xrea113,l_xrea1136.xrea_t.xrea113,l_xrea1134.xrea_t.xrea113,l_xrea1035.xrea_t.xrea103,l_xrea1135.xrea_t.xrea113,l_crecurr.xrea_t.xrea100,l_crelim.xrea_t.xrea113,l_stomoney.xrea_t.xrea113,l_advmoney.xrea_t.xrea113,l_retmoney.xrea_t.xrea113,l_addmoney.xrea_t.xrea113,l_adjmoney.xrea_t.xrea113,l_redmoney.xrea_t.xrea113,l_paymoney.xrea_t.xrea113,l_anomoney.xrea_t.xrea113,l_xrea103_01.xrea_t.xrea103,l_xrea113_01.xrea_t.xrea113,l_xrea103_02.xrea_t.xrea103,l_xrea113_02.xrea_t.xrea113,l_xrea103_03.xrea_t.xrea103,l_xrea113_03.xrea_t.xrea113,l_xrea103_04.xrea_t.xrea103,l_xrea113_04.xrea_t.xrea113,l_xrea103_05.xrea_t.xrea113,l_xrea113_05.xrea_t.xrea113,l_xrea103_06.xrea_t.xrea103,l_xrea113_06.xrea_t.xrea113,l_xrea103_07.xrea_t.xrea103,l_xrea113_07.xrea_t.xrea113,l_xrea103_08.xrea_t.xrea103,l_xrea113_08.xrea_t.xrea113,l_xrea103_09.xrea_t.xrea103,l_xrea113_09.xrea_t.xrea113,l_xrea103_10.xrea_t.xrea103,l_xrea113_10.xrea_t.xrea113,l_xrea103_11.xrea_t.xrea103,l_xrea113_11.xrea_t.xrea113,l_xrea103_12.xrea_t.xrea103,l_xrea113_12.xrea_t.xrea113,l_xrea103_13.xrea_t.xrea103,l_xrea113_13.xrea_t.xrea113,l_xrea103_14.xrea_t.xrea103,l_xrea113_14.xrea_t.xrea113,l_xrea103_15.xrea_t.xrea103,l_xrea113_15.xrea_t.xrea113,l_xrea103_16.xrea_t.xrea103,l_xrea113_16.xrea_t.xrea113,l_xrea103_17.xrea_t.xrea103,l_xrea113_17.xrea_t.xrea113,l_xrea103_18.xrea_t.xrea103,l_xrea113_18.xrea_t.xrea113,l_xrea103_19.xrea_t.xrea103,l_xrea113_19.xrea_t.xrea113,l_xrea103_20.xrea_t.xrea113,l_xrea113_20.xrea_t.xrea113,l_xrea103_21.xrea_t.xrea103,l_xrea113_21.xrea_t.xrea113,l_mon1.xrea_t.xrea113,l_mon2.xrea_t.xrea113,l_mon3.xrea_t.xrea113,l_mon4.xrea_t.xrea113,l_mon5.xrea_t.xrea113,l_mon6.xrea_t.xrea113,l_mon7.xrea_t.xrea113,l_mon8.xrea_t.xrea113,l_mon9.xrea_t.xrea113,l_mon10.xrea_t.xrea113,l_mon11.xrea_t.xrea113,l_mon12.xrea_t.xrea113,l_xreasite.type_t.chr80,l_year.xrea_t.xrea001,l_mon.xrea_t.xrea002,l_xrad001.type_t.chr80,l_xrad004.type_t.chr80,l_dedtype.type_t.chr80,l_cre_desc.type_t.chr80,l_group_desc.type_t.chr80" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aapq932_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aapq932_x02_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="aapq932_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapq932_x02_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT '','','','','','',xrea011,'',xrea016,'','','',xrea100,'','','','','','','', 
#       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','','','','','','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM xrea_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xrea_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table2 CLIPPED
   #end add-point
   PREPARE aapq932_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aapq932_x02_curs CURSOR FOR aapq932_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapq932_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapq932_x02_ins_data()
DEFINE sr RECORD 
   l_group1 LIKE type_t.chr80, 
   l_group1_desc LIKE type_t.chr80, 
   l_group2 LIKE type_t.chr80, 
   l_group2_desc LIKE type_t.chr80, 
   l_group3 LIKE type_t.chr80, 
   l_group3_desc LIKE type_t.chr80, 
   xrea011 LIKE xrea_t.xrea011, 
   l_xrea011_desc LIKE type_t.chr80, 
   xrea016 LIKE xrea_t.xrea016, 
   l_xrea016_desc LIKE type_t.chr80, 
   l_pmab053 LIKE type_t.chr80, 
   l_pmab053_desc LIKE type_t.chr80, 
   xrea100 LIKE xrea_t.xrea100, 
   l_xrea1031 LIKE xrea_t.xrea103, 
   l_xrea1032 LIKE xrea_t.xrea103, 
   l_xrea1033 LIKE xrea_t.xrea103, 
   l_xrea1034 LIKE xrea_t.xrea103, 
   l_xrea1131 LIKE xrea_t.xrea113, 
   l_xrea1132 LIKE xrea_t.xrea113, 
   l_xrea1133 LIKE xrea_t.xrea113, 
   l_xrea1136 LIKE xrea_t.xrea113, 
   l_xrea1134 LIKE xrea_t.xrea113, 
   l_xrea1035 LIKE xrea_t.xrea103, 
   l_xrea1135 LIKE xrea_t.xrea113, 
   l_crecurr LIKE xrea_t.xrea100, 
   l_crelim LIKE xrea_t.xrea113, 
   l_stomoney LIKE xrea_t.xrea113, 
   l_advmoney LIKE xrea_t.xrea113, 
   l_retmoney LIKE xrea_t.xrea113, 
   l_addmoney LIKE xrea_t.xrea113, 
   l_adjmoney LIKE xrea_t.xrea113, 
   l_redmoney LIKE xrea_t.xrea113, 
   l_paymoney LIKE xrea_t.xrea113, 
   l_anomoney LIKE xrea_t.xrea113, 
   l_xrea103_01 LIKE xrea_t.xrea103, 
   l_xrea113_01 LIKE xrea_t.xrea113, 
   l_xrea103_02 LIKE xrea_t.xrea103, 
   l_xrea113_02 LIKE xrea_t.xrea113, 
   l_xrea103_03 LIKE xrea_t.xrea103, 
   l_xrea113_03 LIKE xrea_t.xrea113, 
   l_xrea103_04 LIKE xrea_t.xrea103, 
   l_xrea113_04 LIKE xrea_t.xrea113, 
   l_xrea103_05 LIKE xrea_t.xrea113, 
   l_xrea113_05 LIKE xrea_t.xrea113, 
   l_xrea103_06 LIKE xrea_t.xrea103, 
   l_xrea113_06 LIKE xrea_t.xrea113, 
   l_xrea103_07 LIKE xrea_t.xrea103, 
   l_xrea113_07 LIKE xrea_t.xrea113, 
   l_xrea103_08 LIKE xrea_t.xrea103, 
   l_xrea113_08 LIKE xrea_t.xrea113, 
   l_xrea103_09 LIKE xrea_t.xrea103, 
   l_xrea113_09 LIKE xrea_t.xrea113, 
   l_xrea103_10 LIKE xrea_t.xrea103, 
   l_xrea113_10 LIKE xrea_t.xrea113, 
   l_xrea103_11 LIKE xrea_t.xrea103, 
   l_xrea113_11 LIKE xrea_t.xrea113, 
   l_xrea103_12 LIKE xrea_t.xrea103, 
   l_xrea113_12 LIKE xrea_t.xrea113, 
   l_xrea103_13 LIKE xrea_t.xrea103, 
   l_xrea113_13 LIKE xrea_t.xrea113, 
   l_xrea103_14 LIKE xrea_t.xrea103, 
   l_xrea113_14 LIKE xrea_t.xrea113, 
   l_xrea103_15 LIKE xrea_t.xrea103, 
   l_xrea113_15 LIKE xrea_t.xrea113, 
   l_xrea103_16 LIKE xrea_t.xrea103, 
   l_xrea113_16 LIKE xrea_t.xrea113, 
   l_xrea103_17 LIKE xrea_t.xrea103, 
   l_xrea113_17 LIKE xrea_t.xrea113, 
   l_xrea103_18 LIKE xrea_t.xrea103, 
   l_xrea113_18 LIKE xrea_t.xrea113, 
   l_xrea103_19 LIKE xrea_t.xrea103, 
   l_xrea113_19 LIKE xrea_t.xrea113, 
   l_xrea103_20 LIKE xrea_t.xrea113, 
   l_xrea113_20 LIKE xrea_t.xrea113, 
   l_xrea103_21 LIKE xrea_t.xrea103, 
   l_xrea113_21 LIKE xrea_t.xrea113, 
   l_mon1 LIKE xrea_t.xrea113, 
   l_mon2 LIKE xrea_t.xrea113, 
   l_mon3 LIKE xrea_t.xrea113, 
   l_mon4 LIKE xrea_t.xrea113, 
   l_mon5 LIKE xrea_t.xrea113, 
   l_mon6 LIKE xrea_t.xrea113, 
   l_mon7 LIKE xrea_t.xrea113, 
   l_mon8 LIKE xrea_t.xrea113, 
   l_mon9 LIKE xrea_t.xrea113, 
   l_mon10 LIKE xrea_t.xrea113, 
   l_mon11 LIKE xrea_t.xrea113, 
   l_mon12 LIKE xrea_t.xrea113, 
   l_xreasite LIKE type_t.chr80, 
   l_year LIKE xrea_t.xrea001, 
   l_mon LIKE xrea_t.xrea002, 
   l_xrad001 LIKE type_t.chr80, 
   l_xrad004 LIKE type_t.chr80, 
   l_dedtype LIKE type_t.chr80, 
   l_cre_desc LIKE type_t.chr80, 
   l_group_desc LIKE type_t.chr80
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_i          LIKE type_t.num5 
DEFINE l_j          LIKE type_t.num5   
DEFINE l_title1     LIKE gzzd_t.gzzd005
DEFINE l_title2     LIKE gzzd_t.gzzd005
DEFINE l_title DYNAMIC ARRAY OF RECORD
       title1   LIKE type_t.chr500,
       title2   LIKE type_t.chr500
       END RECORD
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aapq932_x02_curs INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_group1,sr.l_group1_desc,sr.l_group2,sr.l_group2_desc,sr.l_group3,sr.l_group3_desc,sr.xrea011,sr.l_xrea011_desc,sr.xrea016,sr.l_xrea016_desc,sr.l_pmab053,sr.l_pmab053_desc,sr.xrea100,sr.l_xrea1031,sr.l_xrea1032,sr.l_xrea1033,sr.l_xrea1034,sr.l_xrea1131,sr.l_xrea1132,sr.l_xrea1133,sr.l_xrea1136,sr.l_xrea1134,sr.l_xrea1035,sr.l_xrea1135,sr.l_crecurr,sr.l_crelim,sr.l_stomoney,sr.l_advmoney,sr.l_retmoney,sr.l_addmoney,sr.l_adjmoney,sr.l_redmoney,sr.l_paymoney,sr.l_anomoney,sr.l_xrea103_01,sr.l_xrea113_01,sr.l_xrea103_02,sr.l_xrea113_02,sr.l_xrea103_03,sr.l_xrea113_03,sr.l_xrea103_04,sr.l_xrea113_04,sr.l_xrea103_05,sr.l_xrea113_05,sr.l_xrea103_06,sr.l_xrea113_06,sr.l_xrea103_07,sr.l_xrea113_07,sr.l_xrea103_08,sr.l_xrea113_08,sr.l_xrea103_09,sr.l_xrea113_09,sr.l_xrea103_10,sr.l_xrea113_10,sr.l_xrea103_11,sr.l_xrea113_11,sr.l_xrea103_12,sr.l_xrea113_12,sr.l_xrea103_13,sr.l_xrea113_13,sr.l_xrea103_14,sr.l_xrea113_14,sr.l_xrea103_15,sr.l_xrea113_15,sr.l_xrea103_16,sr.l_xrea113_16,sr.l_xrea103_17,sr.l_xrea113_17,sr.l_xrea103_18,sr.l_xrea113_18,sr.l_xrea103_19,sr.l_xrea113_19,sr.l_xrea103_20,sr.l_xrea113_20,sr.l_xrea103_21,sr.l_xrea113_21,sr.l_mon1,sr.l_mon2,sr.l_mon3,sr.l_mon4,sr.l_mon5,sr.l_mon6,sr.l_mon7,sr.l_mon8,sr.l_mon9,sr.l_mon10,sr.l_mon11,sr.l_mon12,sr.l_xreasite,sr.l_year,sr.l_mon,sr.l_xrad001,sr.l_xrad004,sr.l_dedtype,sr.l_cre_desc,sr.l_group_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aapq932_x02_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    LET g_xgrid.visible_column = NULL

    IF tm.a2 = 'N' THEN #是否顯示壞帳
       LET g_xgrid.visible_column ="l_xrea1035|l_xrea1135|l_xrea113_01|l_xrea113_02|l_xrea113_03|l_xrea113_04|l_xrea113_05",
                                   "|l_xrea113_06|l_xrea113_07|l_xrea113_08|l_xrea113_09",
                                   "|l_xrea113_10|l_xrea113_11|l_xrea113_12|l_xrea113_13",
                                   "|l_xrea113_14|l_xrea113_15|l_xrea113_16|l_xrea113_17",
                                   "|l_xrea113_18|l_xrea113_19|l_xrea113_20|l_xrea113_21"
                                    
    END IF
    IF tm.a3 = 'N' THEN #原幣顯是否
       IF NOT cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|"
       END IF
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED ,"l_xrea100|l_xrea1031|l_xrea1032|l_xrea1033|l_xrea1034"
    END IF
    #151029 ---s---
#    IF tm.a4 = 1 THEN #信用額度
#       IF NOT cl_null(g_xgrid.visible_column)THEN       
#          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|"
#       END IF
#       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"l_crecurr|l_crelim"
#    END IF   
#151029 ---s---   
   
    FOR l_i = 1 TO 9  #儲存Table_Name,為了動態隱藏欄位
       LET l_title[l_i].title1 = 'l_xrea103_0'||l_i
       LET l_title[l_i].title2 = 'l_xrea113_0'||l_i      
    END FOR
    FOR l_i = 10 TO 20
       LET l_title[l_i].title1 = 'l_xrea103_'||l_i
       LET l_title[l_i].title2 = 'l_xrea113_'||l_i      
    END FOR
   
    FOR l_i = 1 TO 20
       IF l_i > tm.a5 THEN
          IF NOT cl_null(g_xgrid.visible_column)THEN       
              LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|"
          END IF           
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED, "",l_title[l_i].title1,"" 
          IF tm.a2  = 'Y' THEN
             LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED, "|",l_title[l_i].title2," "
          END IF             
       END IF          
    END FOR
    
    IF NOT cl_null(g_xgrid.visible_column)THEN       
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|"
    END IF    
    CASE tm.a6  #151022-00017#4 ---s--
       WHEN '1'
        IF g_prog = 'aapq930' THEN
           LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"l_group3|l_group3_desc|",
                                                                       "xrea011|l_xrea011_desc|xrea016|l_xrea016_desc|l_pmab053|l_pmab053_desc" 
           ELSE
              LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"l_group3|l_group3_desc"
           END IF       
       WHEN '2'
          IF g_prog = 'aapq930' THEN
            LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"xrea011|l_xrea011_desc|xrea016|l_xrea016_desc|l_pmab053|l_pmab053_desc"
          END IF
       WHEN '3'
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"l_group1|l_group1_desc|l_group2_desc|l_group3_desc"
       WHEN '4'
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"l_group3|l_group3_desc"      
       WHEN '5'       
       
    END CASE   #151022-00017#4 ---e--
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq932_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapq932_x02_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="aapq932_x02.other_function" readonly="Y" >}

 
{</section>}
 
