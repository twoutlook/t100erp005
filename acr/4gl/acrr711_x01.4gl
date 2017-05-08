#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr711_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-08-18 00:00:00), PR版次:0001(2014-10-10 15:37:34)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: acrr711_x01
#+ Description: ...
#+ Creator....: 01251(2014-08-08 11:21:14)
#+ Modifier...: 01251 -SD/PR- 01251
 
{</section>}
 
{<section id="acrr711_x01.global" readonly="Y" >}
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
 
{<section id="acrr711_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr711_x01(p_arg1)
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
   LET g_rep_code = "acrr711_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr711_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr711_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr711_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr711_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr711_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr711_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr711_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "crbd_t_crbd001.crbd_t.crbd001,oocql_t_oocql004.oocql_t.oocql004,l_count.type_t.num10,l_percent.type_t.chr10" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr711_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr711_x01_ins_prep()
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
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?)"
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
 
{<section id="acrr711_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr711_x01_sel_prep()
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
   
   #end add-point
   LET g_select = " SELECT crbd_t.crbd001,oocql_t.oocql004,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT crbd001,'',count(*),NULL"
   #end add-point
    LET g_from = " FROM crba_t,crbb_t,crbd_t,oocql_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM crba_t,crbd_t"
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"

    LET g_where = g_where," AND crbadocno=crbddocno",
                          " AND crbaent=crbdent ",
                          " AND crbd000='1'",
                          " AND crbaent='",g_enterprise,"'",
                          " AND crbastus <>'X' "

   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("crba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql=g_sql CLIPPED," GROUP BY crbd001 order by crbd001"
   #end add-point
   PREPARE acrr711_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr711_x01_curs CURSOR FOR acrr711_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr711_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr711_x01_ins_data()
DEFINE sr RECORD 
   crbd_t_crbd001 LIKE crbd_t.crbd001, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   l_count LIKE type_t.num10, 
   l_percent LIKE type_t.chr10
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
    DEFINE l_amount       LIKE type_t.num10
    DEFINE l_sql          STRING 
    DEFINE l_ooef016      LIKE ooef_t.ooef016
    DEFINE l_percent      LIKE type_t.num15_3
    DEFINE l_cnt          LIKE type_t.num10
    DEFINE l_num          LIKE type_t.num10
    DEFINE l_percent1     LIKE type_t.num15_3
    DEFINE l_percent2     LIKE type_t.num15_3
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_sql="SELECT count(*) FROM crbd_t,crba_t",
              " WHERE crbadocno=crbddocno",
              "   AND crbaent=crbdent",
              "   AND crbd000='1'",
              "   AND crbastus <>'X' ",
              "   AND ",tm.wc CLIPPED 

    PREPARE acrr711_x01_amount_pre FROM l_sql
     
    EXECUTE acrr711_x01_amount_pre INTO l_amount  
  
    LET l_sql="SELECT count(*) ",
              "FROM (SELECT crbd001,'',count(*),NULL",
              "        FROM crba_t,crbd_t",
              "       WHERE crbadocno=crbddocno",
              "         AND crbaent=crbdent ",
              "         AND crbd000='1'",
              "         AND crbaent='",g_enterprise,"'",
              "         AND crbastus <>'X'",  
              "         AND ",tm.wc CLIPPED,
              "        GROUP BY crbd001 order by crbd001",
              "      )"
              
    PREPARE acrr711_x01_cnt_pre FROM l_sql
     
    EXECUTE acrr711_x01_cnt_pre INTO l_cnt
    
    SELECT ooef016 INTO l_ooef016
      FROM ooef_t
     WHERE ooefent=g_enterprise
       AND ooef001=g_site
       
    LET l_percent=0
    LET l_num=0
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr711_x01_curs INTO sr.*                               
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
       LET l_num=l_num+1
       LET l_percent1= sr.l_count*100/l_amount
       CALL s_curr_round(g_site,l_ooef016,l_percent1,'2') RETURNING l_percent1
              
       IF l_num=l_cnt THEN
          LET l_percent2=100.000-l_percent
          CALL s_curr_round(g_site,l_ooef016,l_percent2,'2') RETURNING l_percent2
          LET sr.l_percent= l_percent2||"%"
       ELSE
          LET l_percent=l_percent+l_percent1          
          LET sr.l_percent= l_percent1||"%"
       END IF
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       SELECT oocql004 INTO sr.oocql_t_oocql004
         FROM oocql_t
        WHERE oocqlent=g_enterprise
          AND oocql001='2106'
          AND oocql002=sr.crbd_t_crbd001
          AND oocql003=g_dlang
         
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.crbd_t_crbd001,sr.oocql_t_oocql004,sr.l_count,sr.l_percent
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr711_x01_execute"
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
 
{<section id="acrr711_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr711_x01_rep_data()
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
 
{<section id="acrr711_x01.other_function" readonly="Y" >}

 
{</section>}
 