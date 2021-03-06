{<section id="abmt300_x01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000016
#+ 
#+ Filename...: abmt300_x01
#+ Description: ECN清單
#+ Creator....: 00252(2014/01/09)
#+ Modifier...: (1899/12/31) -SD/PR- 00000(2013/01/01)
#+ Buildtype..: 應用 x01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="abmt300_x01.global" readonly="Y" >}
 
IMPORT os
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
${tm_fields_define_str}
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
 
#add-point:自定義環境變數(Global Variable)

#end add-point
 
{</section>}
 
{<section id="abmt300_x01.main" readonly="Y" >}
PUBLIC FUNCTION abmt300_x01()
${componet_define_str}
#add-point:init段define

#end add-point
 
   
   #add-point:報表元件參數準備
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abmt300_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abmt300_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abmt300_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abmt300_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abmt300_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abmt300_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abmt300_x01_create_tmptable()
 
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abmt300_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abmt300_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="abmt300_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmt300_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define

#end add-point
 
   #add-point:sel_prep before
   
   #end add-point
 
   #add-point:sel_prep g_select
   
   #end add-point
   
 
   #add-point:sel_prep g_from
   
   #end add-point
    LET g_from = " FROM  ) x "
 
   #add-point:sel_prep g_where
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order
   
   #end add-point
 
   #add-point:sel_prep.sql.before
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after
   
   #end add-point
   PREPARE abmt300_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abmt300_x01_curs CURSOR FOR abmt300_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmt300_x01_ins_data()
DEFINE sr RECORD  END RECORD
#add-point:ins_data段define

#end add-point
 
    #add-point:ins_data段before
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abmt300_x01_curs INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach
       
       #end add-point
 
       #add-point:ins_data段before.save
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING 
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abmt300_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abmt300_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmt300_x01_rep_data()
#add-point:rep_data.define

#end add-point:rep_data.define
 
    #add-point:rep_data.before
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="abmt300_x01.other_function" >}

 
{</section>}
 
