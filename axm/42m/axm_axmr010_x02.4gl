#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr010_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-10-30 17:20:19), PR版次:0002(2015-11-05 17:19:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: axmr010_x02
#+ Description: ...
#+ Creator....: 04226(2014-11-07 10:46:09)
#+ Modifier...: 05384 -SD/PR- 07024
 
{</section>}
 
{<section id="axmr010_x02.global" readonly="Y" >}
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
 
{<section id="axmr010_x02.main" readonly="Y" >}
PUBLIC FUNCTION axmr010_x02(p_arg1)
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
   LET g_rep_code = "axmr010_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr010_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr010_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr010_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr010_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr010_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr010_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr010_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xmdk003_ooag011.type_t.chr300,xmdl050.xmdl_t.xmdl050,l_reason.type_t.chr300,l_count.type_t.num20,l_count_pre.type_t.num15_3,l_money.type_t.num26_10,l_currency.type_t.num20_6,l_money_pre.type_t.num15_3" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr010_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr010_x02_ins_prep()
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
 
{<section id="axmr010_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr010_x02_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_sql         STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT NULL,xmdl050,NULL,NULL,NULL,NULL,0,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = "SELECT DISTINCT trim(xmdk003)||'.'||trim(t1.ooag011),",
                  
                  "       CASE (xmdk000)",
                  "          WHEN '5' THEN ",       #簽退單
                  "            xmdl084",
                  "          WHEN '6' THEN ",       #銷退單
                  "            xmdl050",
                  "       END,",
                  "       CASE (xmdk000)",
                  "          WHEN '5' THEN ",       #簽退單
                  "             t9.oocql004",
                  "          WHEN '6' THEN ",       #銷退單
                  "             t10.oocql004",
                  "       END,",
                  
                  #modify--2015/10/30 By shiun--(S)
#                  "       COUNT(xmdlseq), NULL, SUM(COALESCE(xmdl027,0)*COALESCE(xmdk017,1)),    NULL"
                  "       COUNT(xmdlseq), NULL,SUM(COALESCE(xmdl027,0)),SUM(COALESCE(xmdl027,0)*COALESCE(xmdk017,1)),    NULL"
                  #modify--2015/10/30 By shiun--(E)
                  
   #end add-point
    LET g_from = " FROM  xmdk_t  LEFT OUTER JOIN ( SELECT xmdl_t.* FROM xmdl_t  ) x  ON xmdk_t.xmdkent  
        = x.xmdlent AND xmdk_t.xmdkdocno = x.xmdldocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = g_from CLIPPED,
                " LEFT OUTER JOIN ooag_t t1 ON t1.ooagent = xmdkent AND t1.ooag001 = xmdk003",
                " LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent = xmdkent AND t2.ooefl001 = xmdk004 AND t2.ooefl002 = '",g_dlang,"'",
                " LEFT OUTER JOIN pmaal_t t3 ON t3.pmaalent = xmdkent AND t3.pmaal001 = xmdk007 AND t3.pmaal002 = '",g_dlang,"'",
                " LEFT OUTER JOIN pmaal_t t4 ON t4.pmaalent = xmdkent AND t4.pmaal001 = xmdk008 AND t4.pmaal002 = '",g_dlang,"'",
                " LEFT OUTER JOIN pmaal_t t5 ON t5.pmaalent = xmdkent AND t5.pmaal001 = xmdk009 AND t5.pmaal002 = '",g_dlang,"'",
                " LEFT OUTER JOIN pmaa_t ON pmaaent = xmdkent AND pmaa001 = xmdk007",
                " LEFT OUTER JOIN imaa_t ON imaaent = x.xmdlent AND imaa001 = x.xmdl008",
                " LEFT OUTER JOIN oocql_t t6 ON t6.oocqlent = pmaaent AND t6.oocql001 = '251' AND t6.oocql002 = pmaa080 AND t6.oocql003 = '",g_dlang,"'",
                " LEFT OUTER JOIN rtaxl_t t7 ON t7.rtaxlent = imaaent AND t7.rtaxl001 = imaa009 AND t7.rtaxl002 = '",g_dlang,"'",
                " LEFT OUTER JOIN imaal_t t8 ON t8.imaalent = xmdlent AND t8.imaal001 = xmdl008 AND t8.imaal002 = '",g_dlang,"'",
                "LEFT OUTER JOIN oocql_t t9 ON  t9.oocqlent = xmdlent AND",
                "                       EXISTS (SELECT gzcb004 FROM gzcb_t",
                "                                WHERE gzcb001 = '24'",
                "                                  AND gzcb002 = 'axmt590'",
                "                                  AND gzcb004 = t9.oocql001 )",
                "                                  AND t9.oocql002 = xmdl084",
                "                                  AND t9.oocql003 = '",g_dlang,"'",
                "LEFT OUTER JOIN oocql_t t10 ON t10.oocqlent = xmdlent AND",
                "                        EXISTS (SELECT gzcb004 FROM gzcb_t",
                "                                 WHERE gzcb001 = '24'",
                "                                   AND gzcb002 = 'axmt600'",
                "                                   AND gzcb004 = t10.oocql001 )",
                "                                   AND t10.oocql002 = xmdl050",
                "                                   AND t10.oocql003 = '",g_dlang,"'"
   #end add-point
    LET g_where = " WHERE ( xmdk_t.xmdk000 = '5' OR xmdk_t.xmdk000 = '6' ) AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED,
               " GROUP BY trim(xmdk003)||'.'||trim(t1.ooag011),",
               "       CASE (xmdk000)",
               "          WHEN '5' THEN ",       #簽退單
               "             t9.oocql004",
               "          WHEN '6' THEN ",       #銷退單
               "             t10.oocql004",
               "       END,",
               "       CASE (xmdk000)",
               "          WHEN '5' THEN ",       #簽退單
               "            xmdl084",
               "          WHEN '6' THEN ",       #銷退單
               "            xmdl050",
               "       END"
   
   #計算所有資料的筆數及總金額
   LET l_sql = "SELECT COUNT(xmdlseq),SUM(COALESCE(xmdl027,0)*COALESCE(xmdk017,1))" CLIPPED ,
               " ",g_from CLIPPED ," ",g_where CLIPPED
   PREPARE axmr010_x02_sum FROM l_sql
   #end add-point
   PREPARE axmr010_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr010_x02_curs CURSOR FOR axmr010_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr010_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr010_x02_ins_data()
DEFINE sr RECORD 
   l_xmdk003_ooag011 LIKE type_t.chr300, 
   xmdl050 LIKE xmdl_t.xmdl050, 
   l_reason LIKE type_t.chr300, 
   l_count LIKE type_t.num20, 
   l_count_pre LIKE type_t.num15_3, 
   l_money LIKE type_t.num26_10, 
   l_currency LIKE type_t.num20_6, 
   l_money_pre LIKE type_t.num15_3
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
 DEFINE l_sql        STRING
 DEFINE l_all_count  LIKE type_t.num26_10
 DEFINE l_all_money  LIKE type_t.num26_10
 DEFINE l_str        STRING
 #dorislai-20151105-add----(S)
 DEFINE l_ld           LIKE glap_t.glapld
 DEFINE l_ooaj004      LIKE ooaj_t.ooaj004
 DEFINE l_round_type   LIKE ooaa_t.ooaa002  #參數資料
 #dorislai-20151105-add----(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #dorislai-20151105-add---(S)
    #取位
    LET l_ooaj004 = s_num_round_local_curr()
    LET l_round_type = cl_get_para(g_enterprise,'','E-COM-0006')
    #dorislai-20151105-add---(E)
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr010_x02_curs INTO sr.*                               
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
       #銷退理由
       #簽退單(xmdk000 = '5') 抓簽退理由碼(xmdl084)
       #銷退單(xmdk000 = '6') 抓理由碼(xmdk050)
       
#       #退貨理由碼與說明
#       CASE 
#          WHEN NOT cl_null(sr.xmdl050) AND NOT cl_null(sr.l_reason)
#             LET sr.l_reason = sr.xmdl050,".",sr.l_reason
#          WHEN NOT cl_null(sr.xmdl050) AND cl_null(sr.l_reason)
#             LET sr.l_reason = sr.xmdl050
#       END CASE

       #dorislai-20151105-add----(S)
       #本幣金額取位
       CALL s_num_round(l_round_type,sr.l_currency,l_ooaj004) RETURNING sr.l_currency
       #dorislai-20151105-add----(E)
       
       #總筆數 總金額
       LET l_all_count = 0
       LET l_all_money = 0
       EXECUTE axmr010_x02_sum INTO l_all_count,l_all_money
       
       #筆數百分比
       IF l_all_count = 0 THEN
          LET sr.l_count_pre = 0
       ELSE
          LET sr.l_count_pre = sr.l_count / l_all_count * 100
       END IF
       
       #金額百分比
       IF l_all_money = 0 THEN
          LET sr.l_money_pre = 0
       ELSE
          LET sr.l_money_pre = sr.l_money / l_all_money * 100
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_xmdk003_ooag011,sr.xmdl050,sr.l_reason,sr.l_count,sr.l_count_pre,sr.l_money,sr.l_currency,sr.l_money_pre
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr010_x02_execute"
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
 
{<section id="axmr010_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr010_x02_rep_data()
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
 
{<section id="axmr010_x02.other_function" readonly="Y" >}

 
{</section>}
 
