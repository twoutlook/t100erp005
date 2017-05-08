#該程式未解開Section, 採用最新樣板產出!
{<section id="abxr011_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-08-17 10:55:23), PR版次:0001(2016-08-17 12:06:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000017
#+ Filename...: abxr011_x01
#+ Description: ...
#+ Creator....: 08171(2016-07-25 14:56:17)
#+ Modifier...: 08171 -SD/PR- 08171
 
{</section>}
 
{<section id="abxr011_x01.global" readonly="Y" >}
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="abxr011_x01.main" readonly="Y" >}
PUBLIC FUNCTION abxr011_x01(p_arg1)
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
   LET g_rep_code = "abxr011_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abxr011_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abxr011_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abxr011_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abxr011_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abxr011_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abxr011_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abxr011_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "bxge001.bxge_t.bxge001,l_imaal0031.imaal_t.imaal003,l_imaal0041.imaal_t.imaal003,imaa009.imaa_t.imaa009,rtaxl_t_rtaxl003.rtaxl_t.rtaxl003,iman_t_iman012.iman_t.iman012,iman_t_iman001.iman_t.iman001,l_imaal0032.imaal_t.imaal003,l_imaal0042.imaal_t.imaal004,bxge000.bxge_t.bxge000,l_gzcbl004.gzcbl_t.gzcbl004,bxge007.bxge_t.bxge007" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abxr011_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abxr011_x01_ins_prep()
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
 
{<section id="abxr011_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abxr011_x01_sel_prep()
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
   LET g_select = " SELECT bxge001,a.imaal003,a.imaal004,", #主件料號 品名 規格
                  " imaa009,(SELECT rtaxl003 FROM rtaxl_t WHERE imaaent = rtaxlent AND imaa009 = rtaxl001 AND rtaxl002 ='"||g_dlang||"'),iman012,", #產品分類 產品分類說明 保稅否
                  " bxge005,b.imaal003,b.imaal004,",        #料件編號 品名 規格
                  " bxge000,(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4079' AND gzcbl002 = bxge000 AND gzcbl003 = '"||g_dlang||"'),bxge007 "   #型態代號(隱藏) 型態 折合數量
#   #end add-point
#   LET g_select = " SELECT bxge001,'','',imaa009,rtaxl_t.rtaxl003,iman_t.iman012,iman_t.iman001,'','', 
#       bxge000,'',bxge007"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM bxge_t ",
                " LEFT JOIN  imaal_t  a ON a.imaalent = bxgeent AND a.imaal001 = bxge001 AND a.imaal002 = '"||g_dlang||"'",
                " LEFT JOIN  imaal_t  b ON b.imaalent = bxgeent AND b.imaal001 = bxge005 AND b.imaal002 = '"||g_dlang||"'",
                " LEFT JOIN  iman_t ON imanent = bxgeent AND imansite = bxgesite AND iman001 = bxge005",
                " LEFT JOIN  imaa_t ON imaaent = bxgeent AND imaa001 = bxge001"
#   #end add-point
#    LET g_from = " FROM bxge_t,imaa_t,iman_t,rtaxl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE bxgeent = '"||g_enterprise||"'",
                 "   AND bxgesite = '"||g_site||"' AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bxge_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE abxr011_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abxr011_x01_curs CURSOR FOR abxr011_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abxr011_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abxr011_x01_ins_data()
DEFINE sr RECORD 
   bxge001 LIKE bxge_t.bxge001, 
   l_imaal0031 LIKE imaal_t.imaal003, 
   l_imaal0041 LIKE imaal_t.imaal003, 
   imaa009 LIKE imaa_t.imaa009, 
   rtaxl_t_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   iman_t_iman012 LIKE iman_t.iman012, 
   iman_t_iman001 LIKE iman_t.iman001, 
   l_imaal0032 LIKE imaal_t.imaal003, 
   l_imaal0042 LIKE imaal_t.imaal004, 
   bxge000 LIKE bxge_t.bxge000, 
   l_gzcbl004 LIKE gzcbl_t.gzcbl004, 
   bxge007 LIKE bxge_t.bxge007
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abxr011_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.bxge001,sr.l_imaal0031,sr.l_imaal0041,sr.imaa009,sr.rtaxl_t_rtaxl003,sr.iman_t_iman012,sr.iman_t_iman001,sr.l_imaal0032,sr.l_imaal0042,sr.bxge000,sr.l_gzcbl004,sr.bxge007
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abxr011_x01_execute"
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
 
{<section id="abxr011_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abxr011_x01_rep_data()
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
 
{<section id="abxr011_x01.other_function" readonly="Y" >}

 
{</section>}
 
