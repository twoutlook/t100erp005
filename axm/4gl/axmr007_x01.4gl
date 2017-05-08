#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr007_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2017-02-13 16:06:14), PR版次:0008(2017-02-13 16:25:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: axmr007_x01
#+ Description: ...
#+ Creator....: 05384(2015-03-06 11:47:27)
#+ Modifier...: 08525 -SD/PR- 08525
 
{</section>}
 
{<section id="axmr007_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160503-00030#15  2016/05/19 by ming 效能調整 
#161207-00033#5   2016/12/21 By 08993 一次性交易對象名稱顯示要改抓pmak003
#170210-00060#1   2017/02/13 By zhaoqya axrq007和axrq130抓取的单据性质状态应该一致，否则axmr007未完全立账的资料会打印不出（出货签收单部分）
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
       a1 LIKE type_t.chr1          #未完全立帳
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr007_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr007_x01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  未完全立帳
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr007_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr007_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr007_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr007_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr007_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr007_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr007_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr007_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xmdk007_pmaal003.type_t.chr300,l_xmdk008_pmaal003.type_t.chr300,l_xmdk009_pmaal003.type_t.chr300,l_xmdk010_desc.ooibl_t.ooibl004,l_xmdk012_desc.oodbl_t.oodbl004,xmdk016.xmdk_t.xmdk016,xmdkdocno.xmdk_t.xmdkdocno,xmdkdocdt.xmdk_t.xmdkdocdt,l_xmdk003_ooag011.type_t.chr300,l_xmdk004_ooefl003.type_t.chr1000,xmdl003.xmdl_t.xmdl003,xmdl004.xmdl_t.xmdl004,xmdl005.xmdl_t.xmdl005,xmdl008.xmdl_t.xmdl008,x_imaal_t_imaal003.imaal_t.imaal003,x_imaal_t_imaal004.imaal_t.imaal004,l_xmdl009_desc.type_t.chr1000,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127desc.type_t.chr80,xmdl022.xmdl_t.xmdl022,xmdl021.xmdl_t.xmdl021,xmdl024.xmdl_t.xmdl024,xmdl029.xmdl_t.xmdl029,xmdl027.xmdl_t.xmdl027,xmdl028.xmdl_t.xmdl028,xmdl038.xmdl_t.xmdl038,l_xmdl022_xmdl038.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr007_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr007_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr007_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr007_x01_sel_prep()
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
   #160503-00030#15 20160519 modify by ming -----(S) 
   ##151113-00022#3 20151116  add by beckxie---S
   #LET g_select = "SELECT trim(xmdk007)||'.'||trim(t9.pmaal003),trim(xmdk008)||'.'||trim(pmaal_t.pmaal003), ",
   #               "trim(xmdk009)||'.'||trim(t1.pmaal003),'',ooibl_t.ooibl004,xmdk012,t15.oodbl004,xmdk016,xmdkdocno,xmdkdocdt, ",
   #               "trim(xmdk003)||'.'||trim(ooag_t.ooag011),trim(xmdk004)||'.'||trim(ooefl_t.ooefl003),xmdl003,xmdl004, ",
   #               "xmdl005,xmdl008,x.imaal_t_imaal003,x.imaal_t_imaal004,xmdl009,'',x.imaa127,x.t16_oocql004,trim(x.imaa127)||'.'||trim(x.t16_oocql004),xmdl022,xmdl021,xmdl024, ",
   #               "xmdl029,xmdl027,xmdl028,xmdl038,'',xmdk000,xmdksite,xmdkent,xmdlsite,xmdlent,xmdk003,xmdk004, ",
   #               "xmdk007,xmdk008,xmdk009   "
   ##151113-00022#3 20151116  add by beckxie---E
   LET g_select = "SELECT trim(xmdk007)||'.'||trim(t9.pmaal003),trim(xmdk008)||'.'||trim(pmaal_t.pmaal003), ",
                  "trim(xmdk009)||'.'||trim(t1.pmaal003),ooibl_t.ooibl004,ooibl_t.ooibl004,xmdk012,t15.oodbl004,xmdk016,xmdkdocno,xmdkdocdt, ",
                  "trim(xmdk003)||'.'||trim(ooag_t.ooag011),trim(xmdk004)||'.'||trim(ooefl_t.ooefl003),xmdl003,xmdl004, ",
                  "xmdl005,xmdl008,x.imaal_t_imaal003,x.imaal_t_imaal004, ", 
                  "xmdl009,(SELECT inaml004 FROM inaml_t ", 
                  "          WHERE inamlent = '",g_enterprise,"' ", 
                  "            AND inaml001 = xmdl008 ", 
                  "            AND inaml002 = xmdl009 ", 
                  "            AND inaml003 = '",g_dlang,"' ), ", 
                  "x.imaa127,x.t16_oocql004,trim(x.imaa127)||'.'||trim(x.t16_oocql004),xmdl022,xmdl021,xmdl024, ",
                  "xmdl029,xmdl027,xmdl028,xmdl038,'',xmdk000,xmdksite,xmdkent,xmdlsite,xmdlent,xmdk003,xmdk004, ",
                  "xmdk007,xmdk008,xmdk009   "
   #160503-00030#15 20160519 modify by ming -----(E) 
#   #end add-point
#   LET g_select = " SELECT trim(xmdk007)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk007 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdk008)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk008 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),trim(xmdk009)||'.'||trim((SELECT pmaal003 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmdk_t.xmdk009 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),'',( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmdk_t.xmdk010 AND ooibl_t.ooiblent = xmdk_t.xmdkent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),xmdk012,'',xmdk016,xmdkdocno,xmdkdocdt,trim(xmdk003)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmdk_t.xmdk003 AND ooag_t.ooagent = xmdk_t.xmdkent)), 
#       trim(xmdk004)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmdk_t.xmdk004 AND ooefl_t.ooeflent = xmdk_t.xmdkent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),xmdl003,xmdl004,xmdl005,xmdl008,x.imaal_t_imaal003,x.imaal_t_imaal004,xmdl009, 
#       '','','','',xmdl022,xmdl021,xmdl024,xmdl029,xmdl027,xmdl028,xmdl038,'',xmdk000,xmdksite,xmdkent, 
#       xmdlsite,xmdlent,xmdk003,xmdk004,xmdk007,xmdk008,xmdk009"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151113-00022#3 20151116 mark by beckxie---S
   # LET g_from = " FROM xmdk_t LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = xmdk_t.xmdk004 AND ooefl_t.ooeflent = xmdk_t.xmdkent AND ooefl_t.ooefl002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN ooag_t ON ooag_t.ooag001 = xmdk_t.xmdk003 AND ooag_t.ooagent = xmdk_t.xmdkent             LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaal001 = xmdk_t.xmdk008 AND pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t1 ON t1.pmaal001 = xmdk_t.xmdk009 AND t1.pmaalent = xmdk_t.xmdkent AND t1.pmaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN ooibl_t ON ooibl_t.ooibl002 = xmdk_t.xmdk010 AND ooibl_t.ooiblent = xmdk_t.xmdkent AND ooibl_t.ooibl003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmdk_t.xmdk011 AND oocql_t.oocqlent = xmdk_t.xmdkent AND oocql_t.oocql003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t2 ON t2.pmaal001 = xmdk_t.xmdk020 AND t2.pmaalent = xmdk_t.xmdkent AND t2.pmaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t3 ON t3.oocql001 = '263' AND t3.oocql002 = xmdk_t.xmdk022 AND t3.oocqlent = xmdk_t.xmdkent AND t3.oocql003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t4 ON t4.oocql001 = '275' AND t4.oocql002 = xmdk_t.xmdk030 AND t4.oocqlent = xmdk_t.xmdkent AND t4.oocql003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t5 ON t5.oocql001 = '297' AND t5.oocql002 = xmdk_t.xmdk034 AND t5.oocqlent = xmdk_t.xmdkent AND t5.oocql003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocql_t t6 ON t6.oocql001 = '299' AND t6.oocql002 = xmdk_t.xmdk038 AND t6.oocqlent = xmdk_t.xmdkent AND t6.oocql003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t8 ON t8.pmaal001 = xmdk_t.xmdk202 AND t8.pmaalent = xmdk_t.xmdkent AND t8.pmaal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN pmaal_t t9 ON t9.pmaal001 = xmdk_t.xmdk007 AND t9.pmaalent = xmdk_t.xmdkent AND t9.pmaal002 = '" , 
   #     g_dlang,"'" ," LEFT OUTER JOIN ( SELECT xmdl_t.*,imaa_t.*,imaal_t.imaal003 imaal_t_imaal003,imaal_t.imaal004 imaal_t_imaal004 FROM xmdl_t LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = xmdl_t.xmdlent AND imaa_t.imaa001 = xmdl_t.xmdl008 LEFT OUTER JOIN oocql_t t10 ON t10.oocql001 = '221' AND t10.oocql002 = xmdl_t.xmdl011 AND t10.oocqlent = xmdl_t.xmdlent AND t10.oocql003 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xmdl_t.xmdl017 AND oocal_t.oocalent = xmdl_t.xmdlent AND oocal_t.oocal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t12 ON t12.oocal001 = xmdl_t.xmdl019 AND t12.oocalent = xmdl_t.xmdlent AND t12.oocal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN oocal_t t13 ON t13.oocal001 = xmdl_t.xmdl021 AND t13.oocalent = xmdl_t.xmdlent AND t13.oocal002 = '" , 
   #     g_dlang,"'" ,"             LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xmdl_t.xmdl008 AND imaal_t.imaalent = xmdl_t.xmdlent AND imaal_t.imaal002 = '" , 
   #     g_dlang,"'" ," ) x  ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdkdocno = x.xmdldocno"
   #151113-00022#3 20151116 mark by beckxie---E
   #151113-00022#3 20151116  add by beckxie---S
   LET g_from = " FROM xmdk_t ",
                " LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = xmdk_t.xmdkent AND ooefl_t.ooefl001 = xmdk_t.xmdk004 AND ooefl_t.ooefl002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN ooag_t ON ooag_t.ooagent = xmdk_t.xmdkent AND ooag_t.ooag001 = xmdk_t.xmdk003 ",
                " LEFT OUTER JOIN pmaal_t ON pmaal_t.pmaalent = xmdk_t.xmdkent AND pmaal_t.pmaal001 = xmdk_t.xmdk008 AND pmaal_t.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t t1 ON t1.pmaalent = xmdk_t.xmdkent AND t1.pmaal001 = xmdk_t.xmdk009 AND t1.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN ooibl_t ON ooibl_t.ooiblent = xmdk_t.xmdkent AND ooibl_t.ooibl002 = xmdk_t.xmdk010 AND ooibl_t.ooibl003 = '",g_dlang,"' ",
                " LEFT OUTER JOIN oocql_t ON oocql_t.oocqlent = xmdk_t.xmdkent AND oocql_t.oocql001 = '238' AND oocql_t.oocql002 = xmdk_t.xmdk011 AND oocql_t.oocql003 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t t2 ON t2.pmaalent = xmdk_t.xmdkent AND t2.pmaal001 = xmdk_t.xmdk020 AND t2.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN oocql_t t3 ON t3.oocqlent = xmdk_t.xmdkent AND t3.oocql001 = '263' AND t3.oocql002 = xmdk_t.xmdk022 AND t3.oocql003 = '",g_dlang,"' ",
               #160621-00003#6 160629 by lori mark and add---(S)
               #" LEFT OUTER JOIN oocql_t t4 ON t4.oocqlent = xmdk_t.xmdkent AND t4.oocql001 = '275' AND t4.oocql002 = xmdk_t.xmdk030 AND t4.oocql003 = '",g_dlang,"' ",
                " LEFT OUTER JOIN oojdl_t t4 ON t4.oojdlent = xmdk_t.xmdkent AND t4.oojdl001 = xmdk_t.xmdk030 AND t4.oojdl002 = '",g_dlang,"' ",
               #160621-00003#6 160629 by lori mark and add---(E)
                " LEFT OUTER JOIN oocql_t t5 ON t5.oocqlent = xmdk_t.xmdkent AND t5.oocql001 = '297' AND t5.oocql002 = xmdk_t.xmdk034 AND t5.oocql003 = '",g_dlang,"' ",
                " LEFT OUTER JOIN oocql_t t6 ON t6.oocqlent = xmdk_t.xmdkent AND t6.oocql001 = '299' AND t6.oocql002 = xmdk_t.xmdk038 AND t6.oocql003 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t t8 ON t8.pmaalent = xmdk_t.xmdkent AND t8.pmaal001 = xmdk_t.xmdk202 AND t8.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN pmaal_t t9 ON t9.pmaalent = xmdk_t.xmdkent AND t9.pmaal001 = xmdk_t.xmdk007 AND t9.pmaal002 = '",g_dlang,"' ",
                " LEFT OUTER JOIN ooef_t t14 ON t14.ooefent=",g_enterprise," AND t14.ooef001='",g_site,"' ",
                " LEFT OUTER JOIN oodbl_t t15 ON t15.oodblent=xmdk_t.xmdkent AND t15.oodbl001=t14.ooef019 AND t15.oodbl002=xmdk_t.xmdk012 AND t15.oodbl003='",g_dlang,"' ",
                " LEFT OUTER JOIN ( SELECT xmdl_t.*,imaa_t.imaa127,imaal_t.imaal003 imaal_t_imaal003,imaal_t.imaal004 imaal_t_imaal004,t16.oocql004 t16_oocql004 ",
                "                                FROM xmdl_t  ",
                "                                LEFT OUTER JOIN imaa_t ON imaa_t.imaaent = xmdl_t.xmdlent AND imaa_t.imaa001 = xmdl_t.xmdl008  ",
                "                                LEFT OUTER JOIN oocql_t t10 ON t10.oocql001 = '221' AND t10.oocql002 = xmdl_t.xmdl011 AND t10.oocqlent = xmdl_t.xmdlent AND t10.oocql003 = '",g_dlang,"' ",
                "                                LEFT OUTER JOIN oocal_t ON oocal_t.oocal001 = xmdl_t.xmdl017 AND oocal_t.oocalent = xmdl_t.xmdlent AND oocal_t.oocal002 = '",g_dlang,"' ",
                "                                LEFT OUTER JOIN oocal_t t12 ON t12.oocal001 = xmdl_t.xmdl019 AND t12.oocalent = xmdl_t.xmdlent AND t12.oocal002 = '",g_dlang,"' ",
                "                                LEFT OUTER JOIN oocal_t t13 ON t13.oocal001 = xmdl_t.xmdl021 AND t13.oocalent = xmdl_t.xmdlent AND t13.oocal002 = '",g_dlang,"' ",
                "                                LEFT OUTER JOIN imaal_t ON imaal_t.imaal001 = xmdl_t.xmdl008 AND imaal_t.imaalent = xmdl_t.xmdlent AND imaal_t.imaal002 = '",g_dlang,"' ",
                "                                LEFT OUTER JOIN oocql_t t16 ON t16.oocqlent = xmdl_t.xmdlent AND t16.oocql001 = '2003' AND t16.oocql002 = imaa_t.imaa127 AND t16.oocql003 = '",g_dlang,"' ",
                "                                ) x   ",
                "                            ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdkdocno = x.xmdldocno  "
   #151113-00022#3 20151116  add by beckxie---E
#   #end add-point
#    LET g_from = " FROM xmdk_t LEFT OUTER JOIN ( SELECT xmdl_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = xmdl_t.xmdl008 AND imaal_t.imaalent = xmdl_t.xmdlent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = xmdl_t.xmdl008 AND imaal_t.imaalent = xmdl_t.xmdlent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM xmdl_t ) x  ON xmdk_t.xmdkent = x.xmdlent AND xmdk_t.xmdkdocno  
#        = x.xmdldocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE ( xmdk_t.xmdk000 IN ('2','4','6') OR ( xmdk_t.xmdk000 = '1' AND xmdk_t.xmdk002 = '1' )) AND " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    #170210-00060#1 add by zhaoqya 17/02/13
    LET g_where = "WHERE ( (xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1') ",       
                  "   OR (xmdk000 IN ('4', '5') AND xmdkstus = 'Y' AND xmdk002 = '3') ",              
                  "   OR (xmdk000 = '6' AND xmdk082 <> '5' AND xmdkstus = 'S' ) ) AND ",tm.wc CLIPPED 
   #170210-00060#1 add by zhaoqya 17/02/13
   #160503-00030#15 20160520 add by ming -----(S) 
   #僅列印未完全立帳資料
   IF tm.a1 = 'Y' THEN 
      LET g_where = g_where,"AND COALESCE(xmdl022,0) > COALESCE(xmdl038,0) " 
   END IF 
   #160503-00030#15 20160520 add by ming -----(E) 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE axmr007_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr007_x01_curs CURSOR FOR axmr007_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr007_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr007_x01_ins_data()
DEFINE sr RECORD 
   l_xmdk007_pmaal003 LIKE type_t.chr300, 
   l_xmdk008_pmaal003 LIKE type_t.chr300, 
   l_xmdk009_pmaal003 LIKE type_t.chr300, 
   l_xmdk010_desc LIKE ooibl_t.ooibl004, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   xmdk012 LIKE xmdk_t.xmdk012, 
   l_xmdk012_desc LIKE oodbl_t.oodbl004, 
   xmdk016 LIKE xmdk_t.xmdk016, 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   l_xmdk003_ooag011 LIKE type_t.chr300, 
   l_xmdk004_ooefl003 LIKE type_t.chr1000, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmdl004 LIKE xmdl_t.xmdl004, 
   xmdl005 LIKE xmdl_t.xmdl005, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmdl009 LIKE xmdl_t.xmdl009, 
   l_xmdl009_desc LIKE type_t.chr1000, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl021 LIKE xmdl_t.xmdl021, 
   xmdl024 LIKE xmdl_t.xmdl024, 
   xmdl029 LIKE xmdl_t.xmdl029, 
   xmdl027 LIKE xmdl_t.xmdl027, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xmdl038 LIKE xmdl_t.xmdl038, 
   l_xmdl022_xmdl038 LIKE type_t.num20_6, 
   xmdk000 LIKE xmdk_t.xmdk000, 
   xmdksite LIKE xmdk_t.xmdksite, 
   xmdkent LIKE xmdk_t.xmdkent, 
   xmdlsite LIKE xmdl_t.xmdlsite, 
   xmdlent LIKE xmdl_t.xmdlent, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk008 LIKE xmdk_t.xmdk008, 
   xmdk009 LIKE xmdk_t.xmdk009
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success   LIKE type_t.num5
DEFINE r_pmak003  LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#5 add
DEFINE l_pmaa004  LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#5 add
DEFINE l_xmdk007 LIKE xmdk_t.xmdk007                        #161207-00033#5 add
DEFINE l_xmdk008 LIKE xmdk_t.xmdk008                        #161207-00033#5 add
DEFINE l_xmdk009 LIKE xmdk_t.xmdk009                        #161207-00033#5 add
DEFINE l_sql     STRING                                     #161207-00033#5 add
DEFINE p_type    LIKE type_t.num5                           #161207-00033#5 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #161207-00033#5-s add
    LET l_sql = "SELECT xmdk007,xmdk008,xmdk009,pmaa004 ",
                "  FROM xmdk_t LEFT JOIN pmaa_t ON pmaaent = xmdkent AND pmaa001 = xmdk007 ",
                " WHERE xmdkdocno = ?                   "
    PREPARE axmr007_x01_prep FROM l_sql
    #161207-00033#5-e add
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr007_x01_curs INTO sr.*                               
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
       #161207-00033#5-s add
       EXECUTE axmr007_x01_prep USING sr.xmdkdocno INTO l_xmdk007,l_xmdk008,l_xmdk009,l_pmaa004
       IF l_pmaa004 = '2' THEN   #2.一次性交易對象
          CASE sr.xmdk000
             WHEN '1' #出貨
                 LET p_type = '3'
             WHEN '2' #無訂單出貨
                 LET p_type = '3' 
             WHEN '4' #出通
                 LET p_type = '2'     
             WHEN '6' #銷退
                 LET p_type = '4'                  
          END CASE
          #一次性交易對象全名
          CALL s_desc_axm_get_oneturn_guest_desc(p_type,sr.xmdkdocno)
               RETURNING r_pmak003
          IF NOT cl_null(r_pmak003) THEN
             LET sr.l_xmdk007_pmaal003 = sr.xmdk007,".",r_pmak003            
             IF l_xmdk009 = l_xmdk007 THEN   #帳款客戶
                LET sr.l_xmdk009_pmaal003 = sr.l_xmdk007_pmaal003
             END IF
             IF l_xmdk008 = l_xmdk007 THEN   #收款客戶
                LET sr.l_xmdk008_pmaal003 = sr.l_xmdk007_pmaal003
             END IF
          END IF   
       END IF   
       #161207-00033#5-e add
       
       #160503-00030#15 20160519 mark by ming -----(S) 
       #LET sr.l_xmdk010_desc = sr.ooibl_t_ooibl004
       #160503-00030#15 20160519 mark by ming -----(E) 
       
       #151113-00022#3 20151116 mark by beckxie---S
       #稅別
       #CALL s_desc_get_tax_desc1(g_site,sr.xmdk012)RETURNING sr.l_xmdk012_desc
       #151113-00022#3 20151116 mark by beckxie---E
       
       #160503-00030#15 20160520 mark by ming -----(S) 
       ##產品特徵
       #CALL s_feature_description(sr.xmdl008,sr.xmdl009) RETURNING l_success,sr.l_xmdl009_desc
       #IF NOT l_success THEN
       #   LET sr.l_xmdl009_desc = ''
       #END IF
       #160503-00030#15 20160520 mark by ming -----(E) 
       
       #151113-00022#3 20151116 mark by beckxie---S
       ##系列   20150819 by dorislai add   (S)
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.xmdl008
       #   AND imaaent = g_enterprise
       #   #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
       #ELSE
       #   LET sr.l_imaa127desc = ''
       #END IF
       #       20150819 by dorislai add   (E)
       #151113-00022#3 20151116 mark by beckxie---E
       CALL axmr007_x01_nulltozero(sr.xmdl022) RETURNING sr.xmdl022
       CALL axmr007_x01_nulltozero(sr.xmdl024) RETURNING sr.xmdl024
       CALL axmr007_x01_nulltozero(sr.xmdl027) RETURNING sr.xmdl027
       CALL axmr007_x01_nulltozero(sr.xmdl028) RETURNING sr.xmdl028
       CALL axmr007_x01_nulltozero(sr.xmdl029) RETURNING sr.xmdl029
       CALL axmr007_x01_nulltozero(sr.xmdl038) RETURNING sr.xmdl038
       
       #160503-00030#15 20160520 mark by ming -----(S) 
       ##僅列印未完全立帳資料
       #IF tm.a1 = 'Y' AND sr.xmdl022 <= sr.xmdl038 THEN
       #   CONTINUE FOREACH
       #END IF
       #160503-00030#15 20160520 mark by ming -----(E) 
       
       IF sr.xmdk000 = '6' THEN
          LET sr.xmdl022 = sr.xmdl022 * (-1)
          LET sr.xmdl027 = sr.xmdl027 * (-1)
          LET sr.xmdl028 = sr.xmdl028 * (-1)
          LET sr.xmdl029 = sr.xmdl029 * (-1)
          LET sr.xmdl038 = sr.xmdl038 * (-1)
       END IF
       
       #未立帳金額
       LET sr.l_xmdl022_xmdl038 = sr.xmdl022 - sr.xmdl038
       LET sr.l_xmdl022_xmdl038 = sr.l_xmdl022_xmdl038 * sr.xmdl024
       
       #若來源為空則清掉字串 避免產生資料內容僅有一個 '.'
       CALL axmr007_x01_initialize(sr.xmdk007,sr.l_xmdk007_pmaal003) RETURNING sr.l_xmdk007_pmaal003
       CALL axmr007_x01_initialize(sr.xmdk008,sr.l_xmdk008_pmaal003) RETURNING sr.l_xmdk008_pmaal003
       CALL axmr007_x01_initialize(sr.xmdk009,sr.l_xmdk009_pmaal003) RETURNING sr.l_xmdk009_pmaal003
       CALL axmr007_x01_initialize(sr.xmdk003,sr.l_xmdk003_ooag011) RETURNING sr.l_xmdk003_ooag011
       CALL axmr007_x01_initialize(sr.xmdk004,sr.l_xmdk004_ooefl003) RETURNING sr.l_xmdk004_ooefl003
       #151113-00022#3 20151116  add by beckxie---S
       CALL axmr007_x01_initialize(sr.l_imaa127,sr.l_imaa127desc) RETURNING sr.l_imaa127desc
       #151113-00022#3 20151116  add by beckxie---E
       

       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_xmdk007_pmaal003,sr.l_xmdk008_pmaal003,sr.l_xmdk009_pmaal003,sr.l_xmdk010_desc,sr.l_xmdk012_desc,sr.xmdk016,sr.xmdkdocno,sr.xmdkdocdt,sr.l_xmdk003_ooag011,sr.l_xmdk004_ooefl003,sr.xmdl003,sr.xmdl004,sr.xmdl005,sr.xmdl008,sr.x_imaal_t_imaal003,sr.x_imaal_t_imaal004,sr.l_xmdl009_desc,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc,sr.xmdl022,sr.xmdl021,sr.xmdl024,sr.xmdl029,sr.xmdl027,sr.xmdl028,sr.xmdl038,sr.l_xmdl022_xmdl038
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr007_x01_execute"
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
 
{<section id="axmr007_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr007_x01_rep_data()
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
 
{<section id="axmr007_x01.other_function" readonly="Y" >}

PRIVATE FUNCTION axmr007_x01_nulltozero(p_num)
DEFINE p_num LIKE type_t.num20_6
   IF cl_null(p_num) THEN
      LET p_num = 0
   END IF

   RETURN p_num
END FUNCTION

PRIVATE FUNCTION axmr007_x01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING
   IF cl_null(p_arg) THEN
      INITIALIZE r_exp TO NULL
   ELSE
      LET r_exp = p_exp
   END IF
RETURN r_exp
END FUNCTION

 
{</section>}
 
