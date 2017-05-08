#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr174_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-11-23 18:47:48), PR版次:0003(2015-11-24 16:07:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: axmr174_x02
#+ Description: ...
#+ Creator....: 02748(2014-09-02 15:48:20)
#+ Modifier...: 06815 -SD/PR- 06815
 
{</section>}
 
{<section id="axmr174_x02.global" readonly="Y" >}
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
 
{<section id="axmr174_x02.main" readonly="Y" >}
PUBLIC FUNCTION axmr174_x02(p_arg1)
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
   LET g_rep_code = "axmr174_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr174_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr174_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr174_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr174_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr174_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr174_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr174_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmigsite.xmig_t.xmigsite,xmig001.xmig_t.xmig001,xmig003.xmig_t.xmig003,xmig002.xmig_t.xmig002,xmig006.xmig_t.xmig006,xmig007.xmig_t.xmig007,xmig010.xmig_t.xmig010,xmig016.xmig_t.xmig016,xmig013.xmig_t.xmig013,l_imaa009.imaa_t.imaa009,l_imaa009_desc.rtaxl_t.rtaxl003,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127desc.type_t.chr80,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr174_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr174_x02_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr174_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr174_x02_sel_prep()
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
   #151113-00022#9 20151124 s983961--add(s)
   LET g_select = " SELECT xmigsite,xmig001,xmig003,xmig002,xmig006,xmig007,xmig010,xmig016,xmig013, 
       imaa009,rtaxl003,imaa127,oocql004,trim(imaa127)||'.'||trim(oocql004),imaal003,imaal004"
   #151113-00022#9 20151124 s983961--add(e)   
#   #end add-point
#   LET g_select = " SELECT xmigsite,xmig001,xmig003,xmig002,xmig006,xmig007,xmig010,xmig016,xmig013, 
#       '','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151113-00022#9 20151124 s983961--add(s)
   LET g_from = " FROM  xmig_t  LEFT OUTER JOIN imaal_t ON imaalent = xmigent AND imaal001 = xmig006 AND imaal002 = '",g_dlang,"' ",
                "               LEFT OUTER JOIN imaa_t ON imaaent = xmigent AND imaa001 = xmig006 ",
                "               LEFT OUTER JOIN rtaxl_t ON rtaxlent = xmigent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                "               LEFT OUTER JOIN oocql_t ON oocqlent = xmigent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"' "
   #151113-00022#9 20151124 s983961--add(e)             
#   #end add-point
#    LET g_from = " FROM  xmig_t "
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   #LET g_from = g_from, " LEFT OUTER JOIN imaa_t ON imaaent = xmigent AND imaa001 = xmig006 "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmig_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "G_SQL :",g_sql
   #end add-point
   PREPARE axmr174_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr174_x02_curs CURSOR FOR axmr174_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr174_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr174_x02_ins_data()
DEFINE sr RECORD 
   xmigsite LIKE xmig_t.xmigsite, 
   xmig001 LIKE xmig_t.xmig001, 
   xmig003 LIKE xmig_t.xmig003, 
   xmig002 LIKE xmig_t.xmig002, 
   xmig006 LIKE xmig_t.xmig006, 
   xmig007 LIKE xmig_t.xmig007, 
   xmig010 LIKE xmig_t.xmig010, 
   xmig016 LIKE xmig_t.xmig016, 
   xmig013 LIKE xmig_t.xmig013, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE rtaxl_t.rtaxl003, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr174_x02_curs INTO sr.*                               
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
       #151113-00022#9 20151124 s983961--mark(s)
       #CALL s_desc_get_item_desc(sr.xmig006)RETURNING sr.l_imaal003,sr.l_imaal004
       #
       #SELECT imaa009 INTO sr.l_imaa009
       #  FROM imaa_t
       # WHERE imaaent = g_enterprise
       #   AND imaa001 = sr.xmig006
       #
       #SELECT rtaxl003 INTO sr.l_imaa009_desc
       #  FROM rtaxl_t
       # WHERE rtaxlent = g_enterprise
       #   AND rtaxl001 = sr.l_imaa009
       #   AND rtaxl002 = g_dlang
       ##系列   20150819 by dorislai add   (S)
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.xmig006
       #   AND imaaent = g_enterprise
       #   #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc
       #ELSE
       #   LET sr.l_imaa127desc = ''          
       #END IF
       ##       20150819 by dorislai add   (E)
       #151113-00022#9 20151124 s983961--mark(e)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmigsite,sr.xmig001,sr.xmig003,sr.xmig002,sr.xmig006,sr.xmig007,sr.xmig010,sr.xmig016,sr.xmig013,sr.l_imaa009,sr.l_imaa009_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc,sr.l_imaal003,sr.l_imaal004
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr174_x02_execute"
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
 
{<section id="axmr174_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr174_x02_rep_data()
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
 
{<section id="axmr174_x02.other_function" readonly="Y" >}

 
{</section>}
 