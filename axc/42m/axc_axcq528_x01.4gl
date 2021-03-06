#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq528_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-04 10:11:37), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: axcq528_x01
#+ Description: ...
#+ Creator....: 05384(2015-12-10 14:49:15)
#+ Modifier...: 07024 -SD/PR- 00000
 
{</section>}
 
{<section id="axcq528_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       tmp STRING                   #臨時表
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axcq528_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq528_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.tmp  臨時表
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.tmp = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcq528_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq528_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq528_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq528_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq528_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq528_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq528_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq528_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdtsite.pmdt_t.pmdtsite,l_pmdtsite.type_t.chr500,pmds008.pmds_t.pmds008,l_pmds008_desc.type_t.chr500,pmdsdocdt.pmds_t.pmdsdocdt,pmdtdocno.pmdt_t.pmdtdocno,pmdtseq.pmdt_t.pmdtseq,pmdt001.pmdt_t.pmdt001,pmdt051.pmdt_t.pmdt051,l_pmdt051_desc.type_t.chr500,pmdt006.pmdt_t.pmdt006,l_pmdt006_desc.type_t.chr500,l_pmdt006_desc1.type_t.chr500,pmdt023.pmdt_t.pmdt023,l_pmdt023_desc.type_t.chr500,pmdt024.pmdt_t.pmdt024,pmds037.pmds_t.pmds037,l_pmds037_desc.type_t.chr500,pmds038.pmds_t.pmds038,pmdt036.pmdt_t.pmdt036,pmdt038.pmdt_t.pmdt038,xcck_t_xcckcomp.xcck_t.xcckcomp,l_xcckcomp_desc.type_t.chr500,xcck_t_xcckld.xcck_t.xcckld,l_xcckld_desc.type_t.chr500,xcck_t_xcck004.xcck_t.xcck004,l_xcck004_desc.type_t.chr500,xcck_t_xcck005.xcck_t.xcck005,xcck_t_xcck001.xcck_t.xcck001,l_xcck001_desc.type_t.chr500,xcck_t_xcck003.xcck_t.xcck003,l_xcck003_desc.type_t.chr500,l_key.type_t.chr500,l_apca038.apca_t.apca038" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq528_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq528_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axcq528_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq528_x01_sel_prep()
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
   LET g_select = " SELECT * "
#   #end add-point
#   LET g_select = " SELECT pmdtsite,NULL,pmds008,NULL,pmdsdocdt,pmdtdocno,pmdtseq,pmdt001,pmdt051,NULL, 
#       pmdt006,NULL,NULL,pmdt023,NULL,pmdt024,pmds037,NULL,pmds038,pmdt036,pmdt038,xcck_t.xcckcomp,NULL, 
#       xcck_t.xcckld,NULL,xcck_t.xcck004,NULL,xcck_t.xcck005,xcck_t.xcck001,NULL,xcck_t.xcck003,NULL, 
#       NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM ",tm.tmp
#   #end add-point
#    LET g_from = " FROM pmdt_t,pmds_t,xcck_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdt_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axcq528_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq528_x01_curs CURSOR FOR axcq528_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq528_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq528_x01_ins_data()
DEFINE sr RECORD 
   pmdtsite LIKE pmdt_t.pmdtsite, 
   l_pmdtsite LIKE type_t.chr500, 
   pmds008 LIKE pmds_t.pmds008, 
   l_pmds008_desc LIKE type_t.chr500, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmdtdocno LIKE pmdt_t.pmdtdocno, 
   pmdtseq LIKE pmdt_t.pmdtseq, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt051 LIKE pmdt_t.pmdt051, 
   l_pmdt051_desc LIKE type_t.chr500, 
   pmdt006 LIKE pmdt_t.pmdt006, 
   l_pmdt006_desc LIKE type_t.chr500, 
   l_pmdt006_desc1 LIKE type_t.chr500, 
   pmdt023 LIKE pmdt_t.pmdt023, 
   l_pmdt023_desc LIKE type_t.chr500, 
   pmdt024 LIKE pmdt_t.pmdt024, 
   pmds037 LIKE pmds_t.pmds037, 
   l_pmds037_desc LIKE type_t.chr500, 
   pmds038 LIKE pmds_t.pmds038, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   pmdt038 LIKE pmdt_t.pmdt038, 
   xcck_t_xcckcomp LIKE xcck_t.xcckcomp, 
   l_xcckcomp_desc LIKE type_t.chr500, 
   xcck_t_xcckld LIKE xcck_t.xcckld, 
   l_xcckld_desc LIKE type_t.chr500, 
   xcck_t_xcck004 LIKE xcck_t.xcck004, 
   l_xcck004_desc LIKE type_t.chr500, 
   xcck_t_xcck005 LIKE xcck_t.xcck005, 
   xcck_t_xcck001 LIKE xcck_t.xcck001, 
   l_xcck001_desc LIKE type_t.chr500, 
   xcck_t_xcck003 LIKE xcck_t.xcck003, 
   l_xcck003_desc LIKE type_t.chr500, 
   l_key LIKE type_t.chr500, 
   l_apca038 LIKE apca_t.apca038
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq528_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.l_xcckcomp_desc) THEN
         LET sr.l_xcckcomp_desc = sr.xcck_t_xcckcomp,"(",sr.l_xcckcomp_desc CLIPPED,")"
       ELSE
         LET sr.l_xcckcomp_desc = sr.xcck_t_xcckcomp
       END IF
       LET sr.l_xcck004_desc = sr.xcck_t_xcck004,sr.xcck_t_xcck005
       IF NOT cl_null(sr.l_xcckld_desc) THEN
         LET sr.l_xcckld_desc = sr.xcck_t_xcckld,"(",sr.l_xcckld_desc CLIPPED,")"
       ELSE
         LET sr.l_xcckld_desc = sr.xcck_t_xcckld
       END IF
       
       IF NOT cl_null(sr.l_xcck003_desc) THEN
         LET sr.l_xcck003_desc = sr.xcck_t_xcck003,"(",sr.l_xcck003_desc CLIPPED,")"
       ELSE
         LET sr.l_xcck003_desc = sr.xcck_t_xcck003
       END IF
       
       IF NOT cl_null(sr.l_xcck001_desc) THEN
         LET sr.l_xcck001_desc = sr.xcck_t_xcck001,"(",sr.l_xcck001_desc CLIPPED,")"
       ELSE
         LET sr.l_xcck001_desc = sr.xcck_t_xcck001
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdtsite,sr.l_pmdtsite,sr.pmds008,sr.l_pmds008_desc,sr.pmdsdocdt,sr.pmdtdocno,sr.pmdtseq,sr.pmdt001,sr.pmdt051,sr.l_pmdt051_desc,sr.pmdt006,sr.l_pmdt006_desc,sr.l_pmdt006_desc1,sr.pmdt023,sr.l_pmdt023_desc,sr.pmdt024,sr.pmds037,sr.l_pmds037_desc,sr.pmds038,sr.pmdt036,sr.pmdt038,sr.xcck_t_xcckcomp,sr.l_xcckcomp_desc,sr.xcck_t_xcckld,sr.l_xcckld_desc,sr.xcck_t_xcck004,sr.l_xcck004_desc,sr.xcck_t_xcck005,sr.xcck_t_xcck001,sr.l_xcck001_desc,sr.xcck_t_xcck003,sr.l_xcck003_desc,sr.l_key,sr.l_apca038
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq528_x01_execute"
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
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq528_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq528_x01_rep_data()
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
 
{<section id="axcq528_x01.other_function" readonly="Y" >}

 
{</section>}
 
