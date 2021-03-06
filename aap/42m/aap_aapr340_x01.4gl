{<section id="aapr340_x01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:) Build-000046
#+ 
#+ Filename...: aapr340_x01
#+ Description: 模擬付款明細表列印
#+ Creator....: 02716(2013/12/02)
#+ Modifier...: 02716(2013/12/30)
#+ Buildtype..: 應用 x01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aapr340_x01.global" >}
 
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
 
{<section id="aapr340_x01.main" >}
PUBLIC FUNCTION aapr340_x01(--)
   #add-point:component段變數傳入
p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7
   #end add-point
   )
${componet_define_str}
#add-point:init段define

#end add-point
 
   
   #add-point:報表元件參數準備
   
   #end add-point
   #報表元件代號
   LET g_rep_code = "aapr340_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aapr340_x01_create_tmptable()
 
   #報表select欄位準備
   CALL aapr340_x01_sel_prep()
 
   #報表insert的prepare
   CALL aapr340_x01_ins_prep()  
 
   #將資料存入tmptable
   CALL aapr340_x01_ins_data() 
 
   #將tmptable資料印出
   CALL aapr340_x01_rep_data()
 
   #刪除TEMP TABLE
   CALL cl_xg_drop_tmptable()
 
END FUNCTION
 
{</section>}
 
{<section id="aapr340_x01.create_tmptable" >}
FUNCTION aapr340_x01_create_tmptable()
 
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before
   
   #end add-point:create_tmp.before
 
   #建立TEMP TABLE 透過此lib(組字串+create temp table+組ins的問號)
   IF NOT cl_xg_create_tmptable() THEN
      CALL cl_ap_exitprogram("0")           
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aapr340_x01.ins_prep" >}
FUNCTION aapr340_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_gre_del_data(g_rep_tmpname[i])
       LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
       CASE i
         WHEN 1
         PREPARE insert_prep FROM g_sql
 
 
       END CASE
       IF STATUS THEN
          LET l_prep_str="insert_prep",i
          CALL cl_err(l_prep_str,status,1)
          CALL cl_xg_drop_tmptable()
          CALL cl_ap_exitprogram("0")
       END IF
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="aapr340_x01.sel_prep" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr340_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define

#end add-point
 
   #add-point:sel_prep before
   
   #end add-point
 
   #add-point:sel_prep g_select
   
   #end add-point
   LET g_select = " SELECT inba002"
 
   #add-point:sel_prep g_from
   
   #end add-point
    LET g_from = " FROM inba_t LEFT OUTER JOIN inbb_t ON inba_t.inbaent = inbb_t.inbbent AND inba_t.inbasite  
        = inbb_t.inbbsite AND inba_t.inbadocno = inbb_t.inbbdocno ) x  ON inbb_t.inbbent = inbc_t.inbcent  
        AND inbb_t.inbbsite = inbc_t.inbcsite AND inbb_t.inbbdocno = inbc_t.inbcdocno AND inbb_t.inbbseq  
        = inbc_t.inbcseq"
 
   #add-point:sel_prep g_where
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order
   
   #end add-point
 
   #add-point:sel_prep.sql.before
   
   #end add-point:sel_prep.sql.before
 
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
 
   #add-point:sel_prep.sql.after
   
   #end add-point
   PREPARE aapr340_x01_prepare FROM g_sql
   IF STATUS THEN
      CALL cl_err('prepare:',STATUS,1)
      CALL cl_ap_exitprogram("0")
   END IF
   DECLARE aapr340_x01_curs CURSOR FOR aapr340_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapr340_x01.ins_data" >}
PRIVATE FUNCTION aapr340_x01_ins_data()
DEFINE sr RECORD 
   inba002 LIKE inba_t.inba002
 END RECORD
#add-point:ins_data段define

#end add-point
 
    #add-point:ins_data段before
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aapr340_x01_curs INTO sr.*                               
       IF STATUS THEN
          CALL cl_err('foreach:',STATUS,1)
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach
       
       #end add-point
 
       #add-point:ins_data段before.save
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inba002
 
        IF SQLCA.sqlcode THEN
          CALL cl_err("aapr340_x01_execute",SQLCA.sqlcode,0)
          LET g_rep_success = 'N'
          EXIT FOREACH
        END IF
 
       #add-point:ins_data段after_save
       
       #end add-point
 
    END FOREACH
 
    IF g_rep_success = 'N' THEN
      EXIT PROGRAM
    END IF
 
    #add-point:ins_data段after
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapr340_x01.rep_data" >}
FUNCTION aapr340_x01_rep_data()
#add-point:rep_data.define

#end add-point:rep_data.define
 
    #add-point:rep_data.before
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="aapr340_x01.other_function" >}

 
{</section>}
 
