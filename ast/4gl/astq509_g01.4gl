#該程式未解開Section, 採用最新樣板產出!
{<section id="astq509_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-08-27 21:47:47), PR版次:0001(2015-09-10 10:02:29)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: astq509_g01
#+ Description: ...
#+ Creator....: 06529(2015-08-27 18:21:40)
#+ Modifier...: 06529 -SD/PR- 06529
 
{</section>}
 
{<section id="astq509_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   debaent LIKE deba_t.debaent, 
   debasite LIKE deba_t.debasite, 
   l_debasite LIKE type_t.chr30, 
   deba002 LIKE deba_t.deba002, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   l_rtaw001 LIKE type_t.chr30, 
   deba017 LIKE deba_t.deba017, 
   l_deba017 LIKE type_t.chr100, 
   l_deba024 LIKE type_t.chr30, 
   l_deba032 LIKE type_t.chr30, 
   l_deba045 LIKE type_t.chr30, 
   l_deba047 LIKE type_t.chr30, 
   l_sell LIKE type_t.chr30, 
   l_guide LIKE type_t.chr30
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING                   #遮掩金额
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="astq509_g01.main" readonly="Y" >}
PUBLIC FUNCTION astq509_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  遮掩金额
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "astq509_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL astq509_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL astq509_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL astq509_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="astq509_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astq509_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
    LET g_select = " SELECT  UNIQUE debaent,debasite,ooefl003,deba002,rtaw001,rtaxl003,deba017,stfal003,sum(deba024) ,sum(deba032) ,
                     sum(deba045) ,sum(deba047) ,'','' "
#   #end add-point
#   LET g_select = " SELECT debaent,debasite,'',deba002,rtaw001,'',deba017,'','','','','',NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from =  "   FROM deba_t",
                  "   LEFT JOIN ooefl_t ON ooeflent=debaent AND ooefl001=debasite AND ooefl002='",g_dlang,"' ",                    
                  "   LEFT JOIN rtaw_t  ON rtaw002 = deba016  AND rtawent = debaent AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"'",  #通过小类编号抓取管理部类
                  "   LEFT JOIN rtaxl_t ON rtaw001 = rtaxl001 AND rtawent = rtaxlent AND rtaxl002 = '",g_dlang ,"'",
                  "   LEFT JOIN stfal_t ON deba017 = stfal001 AND debaent = stfalent AND stfal002 = '",g_dlang ,"'"
#   #end add-point
#    LET g_from = " FROM deba_t,rtaw_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE debasite = '",g_site,"'  AND " ,tm.wc CLIPPED 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_order =  " GROUP BY DEBAENT, DEBASITE, OOEFL003,DEBA002, RTAW001,RTAXL003, DEBA017, STFAL003 ",
                   " ORDER BY  DEBAENT, DEBASITE, DEBA002, RTAW001, DEBA017 "
#   #end add-point
#    LET g_order = " ORDER BY debasite,deba002,rtaw001"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("deba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE astq509_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE astq509_g01_curs CURSOR FOR astq509_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="astq509_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION astq509_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   debaent LIKE deba_t.debaent, 
   debasite LIKE deba_t.debasite, 
   l_debasite LIKE type_t.chr30, 
   deba002 LIKE deba_t.deba002, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   l_rtaw001 LIKE type_t.chr30, 
   deba017 LIKE deba_t.deba017, 
   l_deba017 LIKE type_t.chr100, 
   l_deba024 LIKE type_t.chr30, 
   l_deba032 LIKE type_t.chr30, 
   l_deba045 LIKE type_t.chr30, 
   l_deba047 LIKE type_t.chr30, 
   l_sell LIKE type_t.chr30, 
   l_guide LIKE type_t.chr30
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
 DEFINE l_str      STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH astq509_g01_curs INTO sr_s.*
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

      IF tm.a1 = 'Y' THEN     #由于要使用截取函数，所以把栏位类型改成varchar，但是varchar结果保留的小数位数不是两位，所以加0填充位数
         LET l_str = sr_s.l_deba024
         LET l_str = '000',l_str,'000'                    #在抓出来的值前面、后面补0填充位数
         LET l_str = '***',l_str.subString( l_str.getIndexOf('.',1)-3,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba024 = l_str
         
         LET l_str = sr_s.l_deba032
         LET l_str = '000',l_str,'000'                   #在抓出来的值前面、后面补0填充位数
         LET l_str = '***',l_str.subString( l_str.getIndexOf('.',1)-3,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba032 = l_str
         
         LET l_str = sr_s.l_deba045
         LET l_str = '000',l_str,'000'                  #在抓出来的值前面、后面补0填充位数
         LET l_str = '***',l_str.subString( l_str.getIndexOf('.',1)-3,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba045 = l_str
         
         LET l_str = sr_s.l_deba047
         LET l_str = '000',l_str,'000'                    #在抓出来的值前面、后面补0填充位数
         LET l_str = '***',l_str.subString( l_str.getIndexOf('.',1)-3,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba047 = l_str
      ELSE
         LET l_str = sr_s.l_deba024
         LET l_str = l_str,'000'                    #在抓出来的值后面补0填充位数
         LET l_str = l_str.subString( 1,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba024 = l_str
         
         LET l_str = sr_s.l_deba032
         LET l_str = l_str,'000'                   #在抓出来的值后面补0填充位数
         LET l_str = l_str.subString( 1,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba032 = l_str
         
         LET l_str = sr_s.l_deba045
         LET l_str = l_str,'000'                  #在抓出来的值后面补0填充位数
         LET l_str = l_str.subString( 1,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba045 = l_str
         
         LET l_str = sr_s.l_deba047
         LET l_str = l_str,'000'                    #在抓出来的值后面补0填充位数
         LET l_str = l_str.subString( 1,l_str.getIndexOf('.',1)+2)
         LET sr_s.l_deba047 = l_str
      END IF   

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].debaent = sr_s.debaent
       LET sr[l_cnt].debasite = sr_s.debasite
       LET sr[l_cnt].l_debasite = sr_s.l_debasite
       LET sr[l_cnt].deba002 = sr_s.deba002
       LET sr[l_cnt].rtaw001 = sr_s.rtaw001
       LET sr[l_cnt].l_rtaw001 = sr_s.l_rtaw001
       LET sr[l_cnt].deba017 = sr_s.deba017
       LET sr[l_cnt].l_deba017 = sr_s.l_deba017
       LET sr[l_cnt].l_deba024 = sr_s.l_deba024
       LET sr[l_cnt].l_deba032 = sr_s.l_deba032
       LET sr[l_cnt].l_deba045 = sr_s.l_deba045
       LET sr[l_cnt].l_deba047 = sr_s.l_deba047
       LET sr[l_cnt].l_sell = sr_s.l_sell
       LET sr[l_cnt].l_guide = sr_s.l_guide
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astq509_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION astq509_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT astq509_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT astq509_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT astq509_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="astq509_g01.rep" readonly="Y" >}
PRIVATE REPORT astq509_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE l_ooefl006   LIKE ooefl_t.ooefl006
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.debasite,sr1.deba002,sr1.rtaw001
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.debasite
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            SELECT ooefl006 INTO l_ooefl006      #抓取法人名称
              FROM ooefl_t 
             WHERE ooeflent = sr1.debaent
               AND ooefl001 = (SELECT ooef017 
                                 FROM ooef_t 
                                WHERE ooefent = sr1.debaent AND ooef001 = sr1.debasite) 
               AND ooefl002 = g_dlang
            LET g_grPageHeader.title0101 = l_ooefl006
            #end add-point:rep.header 
            LET g_rep_docno = sr1.debasite
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'debaent=' ,sr1.debaent,'{+}debasite=' ,sr1.debasite,'{+}deba002=' ,sr1.deba002,'{+}deba017=' ,sr1.deba017         
            CALL cl_gr_init_apr(sr1.debasite)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.debasite.before name="rep.b_group.debasite.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.debaent CLIPPED ,"'", " AND  ooff003 = '", sr1.debasite CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astq509_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE astq509_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT astq509_g01_subrep01
           DECLARE astq509_g01_repcur01 CURSOR FROM g_sql
           FOREACH astq509_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astq509_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT astq509_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT astq509_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.debasite.after name="rep.b_group.debasite.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.deba002
 
           #add-point:rep.b_group.deba002.before name="rep.b_group.deba002.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.deba002.after name="rep.b_group.deba002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.rtaw001
 
           #add-point:rep.b_group.rtaw001.before name="rep.b_group.rtaw001.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.rtaw001.after name="rep.b_group.rtaw001.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.debaent CLIPPED ,"'", " AND  ooff003 = '", sr1.debasite CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astq509_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE astq509_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT astq509_g01_subrep02
           DECLARE astq509_g01_repcur02 CURSOR FROM g_sql
           FOREACH astq509_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astq509_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT astq509_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT astq509_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.debaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astq509_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE astq509_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT astq509_g01_subrep03
           DECLARE astq509_g01_repcur03 CURSOR FROM g_sql
           FOREACH astq509_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astq509_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT astq509_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT astq509_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.debasite
 
           #add-point:rep.a_group.debasite.before name="rep.a_group.debasite.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.debaent CLIPPED ,"'", " AND  ooff003 = '", sr1.debasite CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE astq509_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE astq509_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT astq509_g01_subrep04
           DECLARE astq509_g01_repcur04 CURSOR FROM g_sql
           FOREACH astq509_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "astq509_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT astq509_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT astq509_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.debasite.after name="rep.a_group.debasite.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.deba002
 
           #add-point:rep.a_group.deba002.before name="rep.a_group.deba002.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.deba002.after name="rep.a_group.deba002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.rtaw001
 
           #add-point:rep.a_group.rtaw001.before name="rep.a_group.rtaw001.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.rtaw001.after name="rep.a_group.rtaw001.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="astq509_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astq509_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astq509_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astq509_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT astq509_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="astq509_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="astq509_g01.other_report" readonly="Y" >}

 
{</section>}
 
