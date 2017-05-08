#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr620_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-10-13 15:03:38), PR版次:0004(2016-10-13 15:22:29)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000075
#+ Filename...: apsr620_x01
#+ Description: ...
#+ Creator....: 05231(2014-07-17 15:12:15)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr620_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160614-00029#2  2016/06/15 By ming     增加保稅欄位(psos063)在預計完工日前
#160824-00003#3  2016/10/13 By dorislai 生產數量(poso045)，需多扣除APS算出來的已轉工單量(psos024)  
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr620_x01.main" readonly="Y" >}
PUBLIC FUNCTION apsr620_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr620_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr620_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr620_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr620_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr620_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr620_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr620_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr620_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "psos054.psos_t.psos054,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,psos055.psos_t.psos055,psos045.psos_t.psos045,psos017.psos_t.psos017,psos063.psos_t.psos063,psos011.psos_t.psos011,psos012.psos_t.psos012,psos021.psos_t.psos021,psos057.psos_t.psos057,psos062.psos_t.psos062" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr620_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr620_x01_ins_prep()
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
             ?,?,?,?,?,?)"
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
 
{<section id="apsr620_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr620_x01_sel_prep()
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
   #160824-00003#3-s-mod
   ##160614-00029#2 20160615 modify by ming -----(S) 
   ##LET g_select = " SELECT c.psos054,g.imaal003,g.imaal004,c.psos055,c.psos045,c.psos017,c.psos011,c.psos012,c.psos021,c.psos057,c.psos062 "
   #LET g_select = " SELECT c.psos054,g.imaal003,g.imaal004,c.psos055,c.psos045, ", 
   #               "        c.psos017,COALESCE(c.psos063,'N'),c.psos011,c.psos012, ", 
   #               "        c.psos021,c.psos057,c.psos062 "
   ##160614-00029#2 20160615 modify by ming -----(E) 
   LET g_select = " SELECT c.psos054,g.imaal003,g.imaal004,c.psos055,(c.psos045-c.psos024), ", 
                  "        c.psos017,COALESCE(c.psos063,'N'),c.psos011,c.psos012, ", 
                  "        c.psos021,c.psos057,c.psos062 "
   #160824-00003#3-e-mod
#   #end add-point
#   LET g_select = " SELECT psos054,'','',psos055,psos045,psos017,psos063,psos011,psos012,psos021,psos057, 
#       psos062"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from =
     " FROM psca_t a, ",
     "      ( SELECT psosent ,psossite,psos001,max(psos002) AS psos002 FROM psos_t GROUP BY  psosent ,psossite,psos001 ) b ",
     "      LEFT JOIN psos_t  c ON c.psosent =b.psosent AND c.psossite=b.psossite AND c.psos001=b.psos001 AND c.psos002=b.psos002 ",
     "      LEFT JOIN imaa_t  d ON d.imaaent =c.psosent AND d.imaa001 =c.psos054  ",
     "      LEFT JOIN imae_t  e ON e.imaeent =c.psosent AND e.imae001 =c.psos054 AND e.imaesite=c.psossite ",
     "      LEFT JOIN imaf_t  f ON f.imafent =c.psosent AND f.imaf001 =c.psos054 AND f.imafsite=c.psossite ",
     "      LEFT JOIN imaal_t g ON g.imaalent=c.psosent AND g.imaal001=c.psos054 AND g.imaal002='",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM psos_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc CLIPPED ," AND a.pscaent=b.psosent AND a.pscasite=b.psossite AND a.psca001=b.psos001 AND c.psos009 = 1"
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psos_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apsr620_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr620_x01_curs CURSOR FOR apsr620_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr620_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr620_x01_ins_data()
DEFINE sr RECORD 
   psos054 LIKE psos_t.psos054, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   psos055 LIKE psos_t.psos055, 
   psos045 LIKE psos_t.psos045, 
   psos017 LIKE psos_t.psos017, 
   psos063 LIKE psos_t.psos063, 
   psos011 LIKE psos_t.psos011, 
   psos012 LIKE psos_t.psos012, 
   psos021 LIKE psos_t.psos021, 
   psos057 LIKE psos_t.psos057, 
   psos062 LIKE psos_t.psos062
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr620_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.psos054,sr.imaal003,sr.imaal004,sr.psos055,sr.psos045,sr.psos017,sr.psos063,sr.psos011,sr.psos012,sr.psos021,sr.psos057,sr.psos062
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr620_x01_execute"
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
 
{<section id="apsr620_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr620_x01_rep_data()
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
 
{<section id="apsr620_x01.other_function" readonly="Y" >}

 
{</section>}
 
