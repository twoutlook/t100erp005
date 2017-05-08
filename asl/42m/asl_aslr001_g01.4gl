#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr001_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-12-30 13:52:50), PR版次:0002(2017-01-23 10:57:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000020
#+ Filename...: aslr001_g01
#+ Description: ...
#+ Creator....: 03247(2016-07-26 18:03:22)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="aslr001_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#IMPORT util      #161228-00033#4 161230 by lori mark
#######################
#161228-00033#4   2016/12/30   By lori     1.ROWNUM語法改為Scrolling CURSOR  
#                                          2.IMPORT util 搬遷至正確的add-point
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
IMPORT util    #161228-00033#4 161230 by lori add
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   imaaent LIKE imaa_t.imaaent, 
   imaa001 LIKE imaa_t.imaa001, 
   imaa126 LIKE imaa_t.imaa126, 
   imaal003 LIKE imaal_t.imaal003, 
   imaa157 LIKE imaa_t.imaa157, 
   imaa130 LIKE imaa_t.imaa130, 
   imaa158 LIKE imaa_t.imaa158, 
   l_item LIKE type_t.num10, 
   l_imec002 LIKE imec_t.imec002, 
   l_imas002 LIKE imas_t.imas002, 
   l_url LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #condition 
       year LIKE imaa_t.imaa154,         #input1 
       sea LIKE imaa_t.imaa155          #input2
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
 
{<section id="aslr001_g01.main" readonly="Y" >}
PUBLIC FUNCTION aslr001_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  condition 
DEFINE  p_arg2 LIKE imaa_t.imaa154         #tm.year  input1 
DEFINE  p_arg3 LIKE imaa_t.imaa155         #tm.sea  input2
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.year = p_arg2
   LET tm.sea = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aslr001_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aslr001_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aslr001_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aslr001_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr001_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr001_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   CALL aslr001_g01_temp('a')
   CALL aslr001_g01_tmp_ins()
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT imaaent,imaa001,imaa126,imaal003,imaa157,imaa130,imaa158,NULL,NULL,NULL,NULL" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT DISTINCT imaaent,imaa001,COALESCE(imaa126,' '),imaal003,imaa157,imaa130,imaa158,tmp_item,tmp_imec002,tmp_imas002,NULL "
   #end add-point
    LET g_from = " FROM imaa_t,imaal_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM aslr001_imaa_tmp,imaa_t ",
                " LEFT JOIN imaal_t ON imaaent=imaalent AND imaa001=imaal001 AND imaal002='",g_dlang,"' "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE imaaent = ",g_enterprise," ",
                 "   AND imaa001 = tmp_imaa001 "
#                 "   AND " ,tm.wc CLIPPED 
#   IF NOT cl_null(tm.year) THEN
#      LET g_where = g_where," AND imaa154 = '",tm.year,"' "
#   END IF
#   IF NOT cl_null(tm.sea) THEN
#      LET g_where = g_where," AND imaa155 = '",tm.sea,"' "
#   END IF
   #end add-point
    LET g_order = " ORDER BY imaa126"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
#   LET g_order = " ORDER BY imaaent,imaa013 "
   LET g_order = " ORDER BY imaaent,tmp_item "
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("imaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aslr001_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aslr001_g01_curs CURSOR FOR aslr001_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr001_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr001_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   imaaent LIKE imaa_t.imaaent, 
   imaa001 LIKE imaa_t.imaa001, 
   imaa126 LIKE imaa_t.imaa126, 
   imaal003 LIKE imaal_t.imaal003, 
   imaa157 LIKE imaa_t.imaa157, 
   imaa130 LIKE imaa_t.imaa130, 
   imaa158 LIKE imaa_t.imaa158, 
   l_item LIKE type_t.num10, 
   l_imec002 LIKE imec_t.imec002, 
   l_imas002 LIKE imas_t.imas002, 
   l_url LIKE type_t.chr1000
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aslr001_g01_curs INTO sr_s.*
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
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].imaaent = sr_s.imaaent
       LET sr[l_cnt].imaa001 = sr_s.imaa001
       LET sr[l_cnt].imaa126 = sr_s.imaa126
       LET sr[l_cnt].imaal003 = sr_s.imaal003
       LET sr[l_cnt].imaa157 = sr_s.imaa157
       LET sr[l_cnt].imaa130 = sr_s.imaa130
       LET sr[l_cnt].imaa158 = sr_s.imaa158
       LET sr[l_cnt].l_item = sr_s.l_item
       LET sr[l_cnt].l_imec002 = sr_s.l_imec002
       LET sr[l_cnt].l_imas002 = sr_s.l_imas002
       LET sr[l_cnt].l_url = sr_s.l_url
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aslr001_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr001_g01_rep_data()
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
          START REPORT aslr001_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aslr001_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aslr001_g01_rep
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
    CALL aslr001_g01_temp('d')
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="aslr001_g01.rep" readonly="Y" >}
PRIVATE REPORT aslr001_g01_rep(sr1)
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
DEFINE l_url           DYNAMIC ARRAY OF STRING
DEFINE l_js            STRING
DEFINE l_loaa001       LIKE loaa_t.loaa001
DEFINE l_imaa005       LIKE imaa_t.imaa005
DEFINE l_imeb002_1     LIKE imeb_t.imeb002
DEFINE l_imeb002_2     LIKE imeb_t.imeb002
DEFINE l_imeb004       LIKE imeb_t.imeb004
DEFINE l_imec003       LIKE imec_t.imec003
DEFINE l_imecl005      LIKE imecl_t.imecl005
DEFINE l_title         RECORD
       t1              LIKE imecl_t.imecl005,
       t2              LIKE imecl_t.imecl005,
       t3              LIKE imecl_t.imecl005,
       t4              LIKE imecl_t.imecl005,
       t5              LIKE imecl_t.imecl005,
       t6              LIKE imecl_t.imecl005,
       t7              LIKE imecl_t.imecl005
                       END RECORD
DEFINE l_column        RECORD
       c1              LIKE imecl_t.imecl005,
       c2              LIKE imecl_t.imecl005,
       c3              LIKE imecl_t.imecl005,
       c4              LIKE imecl_t.imecl005
                       END RECORD
DEFINE l_sql           STRING
DEFINE l_str1          LIKE type_t.chr5
DEFINE l_str2          LIKE type_t.chr50
DEFINE l_pageheader    LIKE type_t.chr100
DEFINE l_logo          LIKE type_t.chr1000
DEFINE l_imaa126       LIKE imaa_t.imaa126
DEFINE l_month         LIKE type_t.chr5
DEFINE l_day           LIKE type_t.chr5
DEFINE l_date          LIKE type_t.chr100
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.imaa126
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
        BEFORE GROUP OF sr1.imaa126
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.imaa126
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'imaaent=' ,sr1.imaaent,'{+}imaa001=' ,sr1.imaa001         
            CALL cl_gr_init_apr(sr1.imaa126)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            #组合画面条件
            LET l_str1 = tm.year
            CASE tm.sea
               WHEN '0'
                  LET l_str2 = cl_getmsg('asl-00003',g_dlang)
               WHEN '1'
                  LET l_str2 = cl_getmsg('asl-00004',g_dlang)
               WHEN '2'
                  LET l_str2 = cl_getmsg('asl-00005',g_dlang)
            END CASE
            LET l_pageheader = l_str1 CLIPPED,l_str2 CLIPPED
            PRINTX l_pageheader
            
            #抓取品牌logo
#            LET l_imaa126 = ''
#            SELECT imaa126 INTO l_imaa126 FROM imaa_t
#             WHERE imaaent = g_enterprise
#               AND imaa001 = sr1.imaa001
            CALL g_pk_array.clear()
            CALL l_url.clear()
            LET l_js = ''
            LET l_loaa001 = ''
            LET g_pk_array[1].values = '2002'
            LET g_pk_array[1].column = 'oocq001'
            LET g_pk_array[2].values = sr1.imaa126
            LET g_pk_array[2].column = 'oocq002'
            LET l_js = util.JSON.stringify(g_pk_array)
            LET l_loaa001 = l_js.trim()
            LET l_url = cl_doc_open_attach(l_loaa001,"","","2")
            LET l_logo = l_url[1]
            #抓取空图片
            IF cl_null(l_logo) THEN
               LET l_logo = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"pic"),"reptpic")
               LET l_logo = os.Path.join(l_logo,"no_logo.png")
            END IF
            PRINTX l_logo
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.imaa126.before name="rep.b_group.imaa126.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.imaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.imaa126 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aslr001_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aslr001_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aslr001_g01_subrep01
           DECLARE aslr001_g01_repcur01 CURSOR FROM g_sql
           FOREACH aslr001_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aslr001_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aslr001_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aslr001_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.imaa126.after name="rep.b_group.imaa126.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          #陈列日期
          LET l_month = ''
          LET l_day = ''
          LET l_date = ''
          IF NOT cl_null(sr1.imaa158) THEN
             LET l_month = MONTH(sr1.imaa158)
             LET l_day = DAY(sr1.imaa158)
             LET l_str1 = cl_getmsg('aoo-00215',g_dlang)
             LET l_str2 = cl_getmsg('art-00662',g_dlang)
             LET l_date = l_month CLIPPED,l_str1 CLIPPED,l_day CLIPPED,l_str2 CLIPPED
          END IF
          PRINTX l_date
          #抓取图片URL
          CALL g_pk_array.clear()
          CALL l_url.clear()
          LET l_js = ''
          LET l_loaa001 = ''
          LET g_pk_array[1].values = sr1.imaa001
          LET g_pk_array[1].column = 'imaa001'
          LET l_js = util.JSON.stringify(g_pk_array)
          LET l_loaa001 = l_js.trim()
          LET l_url = cl_doc_open_attach(l_loaa001,"","","2")
          LET sr1.l_url = l_url[1]
          #抓取空图片
          IF cl_null(sr1.l_url) THEN
             LET sr1.l_url = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"pic"),"reptpic")
             LET sr1.l_url = os.Path.join(sr1.l_url,"no_logo.png")
          END IF
          #抓取二维设置
          INITIALIZE l_title.* TO NULL
          INITIALIZE l_column.* TO NULL
          LET l_imaa005 = ''
          SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = sr1.imaa001
#          #抓取非二维的特征类型
#          SELECT imeb002,imeb004 INTO l_imeb002_1,l_imeb004 FROM imeb_t
#           WHERE imebent = g_enterprise
#             AND imeb001 = l_imaa005
#             AND imeb012 = 'N'
#             AND ROWNUM = 1
#           ORDER BY imeb002
#          #非二维特征说明
#          SELECT oocql004 INTO l_title.t1
#            FROM oocql_t
#           WHERE oocqlent = g_enterprise AND oocql001 = '273'
#             AND oocql002 = l_imeb004 AND oocql003 = g_dlang
          #非二维特征说明
          SELECT oocql004 INTO l_title.t1
            FROM oocql_t
           WHERE oocqlent = g_enterprise AND oocql001 = '273'
             AND oocql002 = sr1.l_imas002 AND oocql003 = g_dlang
          #二维特征类型
          #161228-00033#4 161230 by lori mod---(S) 
          #SELECT imeb002,imeb004 INTO l_imeb002_2,l_imeb004 FROM imeb_t,imas_t
          # WHERE imebent = g_enterprise
          #   AND imebent = imasent AND imas001 = sr1.imaa001
          #   AND imas002 = imeb004
          #   AND imeb001 = l_imaa005
          #   AND imeb012 = 'Y'
          #   AND ROWNUM = 1
          # ORDER BY imeb002
          LET g_sql = "SELECT imeb002,imeb004  FROM imeb_t,imas_t ",
                      " WHERE imebent = ",g_enterprise,
                      "   AND imebent = imasent AND imas001 = '",sr1.imaa001,"' ",
                      "   AND imas002 = imeb004 ",
                      "   AND imeb001 = '",l_imaa005,"' ",
                      "   AND imeb012 = 'Y' ",
                      " ORDER BY imeb002 "  
          PREPARE aslr001_g01_sel_imeb_pre FROM g_sql
          DECLARE aslr001_g01_sel_imeb_cur SCROLL CURSOR FOR aslr001_g01_sel_imeb_pre   
          OPEN aslr001_g01_sel_imeb_cur   
          FETCH FIRST aslr001_g01_sel_imeb_cur INTO l_imeb002_2,l_imeb004
          CLOSE aslr001_g01_sel_imeb_cur               
          FREE aslr001_g01_sel_imeb_pre          
          #161228-00033#4 161230 by lori mod---(E) 
          #二维特征说明
          LET l_sql = " SELECT DISTINCT imec003,imecl005 FROM imas_t,imec_t ",
                      "   LEFT JOIN imecl_t ON imecent=imeclent AND imec001=imecl001 ",
                      "         AND imec002=imecl002 AND imec003=imecl003 AND imecl004='",g_dlang,"' ",
                      "  WHERE imecent = ",g_enterprise," ",
                      "    AND imecent = imasent AND imas001 = '",sr1.imaa001,"' ",
                      "    AND imas002 = '",l_imeb004,"' AND imas003 = imec003 ",
                      "    AND imec001 = '",l_imaa005,"' ",
                      "    AND imec002 = ",l_imeb002_2," ",
                      "    AND imecstus = 'Y' ",
                      "  ORDER BY imec003 "
          PREPARE sel_imec003_pre1 FROM l_sql
          DECLARE sel_imec003_cs1  CURSOR FOR sel_imec003_pre1
          LET l_imec003 = ''
          LET l_imecl005 = ''
          LET l_cnt = 2
          FOREACH sel_imec003_cs1  INTO l_imec003,l_imecl005
             CASE l_cnt
                WHEN 2
                   LET l_title.t2 = l_imecl005
                WHEN 3
                   LET l_title.t3 = l_imecl005
                WHEN 4
                   LET l_title.t4 = l_imecl005
                WHEN 5
                   LET l_title.t5 = l_imecl005
                WHEN 6
                   LET l_title.t6 = l_imecl005
                WHEN 7
                   LET l_title.t7 = l_imecl005
             END CASE
             LET l_cnt = l_cnt + 1
             IF l_cnt > 7 THEN
                EXIT FOREACH
             END IF
             LET l_imec003 = ''
             LET l_imecl005 = ''
          END FOREACH
          #抓取非二维特征值
#          LET l_sql = " SELECT DISTINCT imec003,imecl005 FROM imec_t ",
#                      "   LEFT JOIN imecl_t ON imecent=imeclent AND imec001=imecl001 ",
#                      "         AND imec002=imecl002 AND imec003=imecl003 AND imecl004='",g_dlang,"' ",
#                      "  WHERE imecent = ",g_enterprise," ",
#                      "    AND imec001 = '",l_imaa005,"' ",
#                      "    AND imec002 = ",l_imeb002_1," ",
#                      "    AND imecstus = 'Y' ",
#                      "  ORDER BY imec003 "
          LET l_sql = " SELECT DISTINCT tmp_imas003,imecl005 FROM aslr001_imas_tmp ",
                      "   LEFT JOIN imecl_t ON imeclent=",g_enterprise," AND imecl001='",l_imaa005,"' ",
                      "         AND imecl002='",sr1.l_imec002,"' AND tmp_imas003=imecl003 AND imecl004='",g_dlang,"' ",
                      "  WHERE tmp_item = ",sr1.l_item," ",
                      "  ORDER BY tmp_imas003 "
          PREPARE sel_imec003_pre2 FROM l_sql
          DECLARE sel_imec003_cs2  CURSOR FOR sel_imec003_pre2
          LET l_imec003 = ''
          LET l_imecl005 = ''
          LET l_cnt = 1
          FOREACH sel_imec003_cs2  INTO l_imec003,l_imecl005
             CASE l_cnt
                WHEN 1
                   LET l_column.c1 = l_imecl005
                WHEN 2
                   LET l_column.c2 = l_imecl005
                WHEN 3
                   LET l_column.c3 = l_imecl005
                WHEN 4
                   LET l_column.c4 = l_imecl005
             END CASE
             LET l_cnt = l_cnt + 1
             IF l_cnt > 4 THEN
                EXIT FOREACH
             END IF
             LET l_imec003 = ''
             LET l_imecl005 = ''
          END FOREACH
          PRINTX l_title.*
          PRINTX l_column.*
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.imaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.imaa126 CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aslr001_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aslr001_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aslr001_g01_subrep02
           DECLARE aslr001_g01_repcur02 CURSOR FROM g_sql
           FOREACH aslr001_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aslr001_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aslr001_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aslr001_g01_subrep02
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
                sr1.imaaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aslr001_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aslr001_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aslr001_g01_subrep03
           DECLARE aslr001_g01_repcur03 CURSOR FROM g_sql
           FOREACH aslr001_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aslr001_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aslr001_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aslr001_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.imaa126
 
           #add-point:rep.a_group.imaa126.before name="rep.a_group.imaa126.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.imaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.imaa126 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aslr001_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aslr001_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aslr001_g01_subrep04
           DECLARE aslr001_g01_repcur04 CURSOR FROM g_sql
           FOREACH aslr001_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aslr001_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aslr001_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aslr001_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.imaa126.after name="rep.a_group.imaa126.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aslr001_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aslr001_g01_subrep01(sr2)
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
PRIVATE REPORT aslr001_g01_subrep02(sr2)
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
PRIVATE REPORT aslr001_g01_subrep03(sr2)
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
PRIVATE REPORT aslr001_g01_subrep04(sr2)
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
 
{<section id="aslr001_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL aslr001_g01_temp(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aslr001_g01_temp(p_type)
DEFINE p_type      LIKE type_t.chr1

   
   CASE p_type
      WHEN 'a'
         #创建临时表
         DROP TABLE aslr001_imaa_tmp;
         DROP TABLE aslr001_imas_tmp;
         CREATE TEMP TABLE aslr001_imaa_tmp(
            tmp_item          SMALLINT,             #项序
            tmp_imaa001       VARCHAR(40),          #料号
            tmp_imec002       INTEGER,          #特征类型项次
            tmp_imas002       VARCHAR(10));         #特征类型
            
         CREATE TEMP TABLE aslr001_imas_tmp(
            tmp_item          SMALLINT,             #项序
            tmp_imas003       VARCHAR(30));         #特征值
            
      WHEN 'd'
         #删除临时表
         DROP TABLE aslr001_imaa_tmp;
         DROP TABLE aslr001_imas_tmp;
        
   END CASE

END FUNCTION

################################################################################
# Descriptions...: 写入临时表
# Memo...........:
# Usage..........: CALL aslr001_g01_tmp_ins()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aslr001_g01_tmp_ins()
DEFINE l_sql        STRING
DEFINE l_imaa001    LIKE imaa_t.imaa001
DEFINE l_imaa005    LIKE imaa_t.imaa005
DEFINE l_imaa013    LIKE imaa_t.imaa013
DEFINE l_mod        LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num10
DEFINE l_n          LIKE type_t.num10
DEFINE l_imeb002       LIKE imeb_t.imeb002
DEFINE l_imeb004       LIKE imeb_t.imeb004
DEFINE l_imec003       LIKE imec_t.imec003
DEFINE l_imecl005      LIKE imecl_t.imecl005

   #根据条件组sql
   LET l_sql = " SELECT DISTINCT imaa001,imaa005,imaa013 FROM imaa_t ",
               "  WHERE imaaent = ",g_enterprise," AND " ,tm.wc CLIPPED,
               "    AND imaastus = 'Y' "
   IF NOT cl_null(tm.year) THEN
      LET l_sql = l_sql," AND imaa154 = '",tm.year,"' "
   END IF
   IF NOT cl_null(tm.sea) THEN
      LET l_sql = l_sql," AND imaa155 = '",tm.sea,"' "
   END IF
   LET l_sql = l_sql," ORDER BY imaa013 "
   LET l_sql = cl_sql_add_mask(l_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
   
   PREPARE sel_imaa001_pre FROM l_sql
   DECLARE sel_imaa001_cs  CURSOR FOR sel_imaa001_pre
   
      #161228-00033#4 161230 by lori add---(S)
      LET g_sql = "SELECT imeb002,imeb004 FROM imeb_t,imas_t ",
                  " WHERE imebent = ",g_enterprise,
                  "   AND imebent = imasent AND imas001 = ? ",
                  "   AND imas002 = imeb004 ",
                  "   AND imeb001 = ? ",
                  "   AND imeb012 = 'N' ",
                  " ORDER BY imeb002 "
      PREPARE aslr001_g01_sel_imeb_pre1 FROM g_sql
      DECLARE aslr001_g01_sel_imeb_cur1 SCROLL CURSOR FOR aslr001_g01_sel_imeb_pre1
      #161228-00033#4 161230 by lori add---(E) 
      
   LET l_cnt = 1
   FOREACH sel_imaa001_cs  INTO l_imaa001,l_imaa005,l_imaa013
      #抓取非二维的特征类型
      LET l_imeb002 = ''
      LET l_imeb004 = ''
      
      #161228-00033#4 161230 by lori mod---(S)  
      #SELECT imeb002,imeb004 INTO l_imeb002,l_imeb004 FROM imeb_t,imas_t
      # WHERE imebent = g_enterprise
      #   AND imebent = imasent AND imas001 = l_imaa001
      #   AND imas002 = imeb004
      #   AND imeb001 = l_imaa005
      #   AND imeb012 = 'N'
      #   AND ROWNUM = 1
      # ORDER BY imeb002
 
      OPEN aslr001_g01_sel_imeb_cur1 USING l_imaa001,l_imaa005  
      FETCH FIRST aslr001_g01_sel_imeb_cur1 INTO l_imeb002,l_imeb004
      CLOSE aslr001_g01_sel_imeb_cur1               
      FREE aslr001_g01_sel_imeb_pre1          
      #161228-00033#4 161230 by lori mod---(E)        
       
      INSERT INTO aslr001_imaa_tmp(tmp_item,tmp_imaa001,tmp_imec002,tmp_imas002)
      VALUES (l_cnt,l_imaa001,l_imeb002,l_imeb004) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins_imaa_tmp'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()   
         RETURN
      END IF
          
      #抓取非二维特征值
      LET l_sql = " SELECT DISTINCT imec003,imecl005 FROM imas_t,imec_t ",
                  "   LEFT JOIN imecl_t ON imecent=imeclent AND imec001=imecl001 ",
                  "         AND imec002=imecl002 AND imec003=imecl003 AND imecl004='",g_dlang,"' ",
                  "  WHERE imecent = ",g_enterprise," ",
                  "    AND imecent = imasent AND imas001 = '",l_imaa001,"' ",
                  "    AND imas002 = '",l_imeb004,"' AND imas003 = imec003 ",
                  "    AND imec001 = '",l_imaa005,"' ",
                  "    AND imec002 = ",l_imeb002," ",
                  "    AND imecstus = 'Y' ",
                  "  ORDER BY imec003 "
      PREPARE sel_imec003_pre3 FROM l_sql
      DECLARE sel_imec003_cs3  CURSOR FOR sel_imec003_pre3
      LET l_imec003 = ''
      LET l_imecl005 = ''
      LET l_n = 1
      FOREACH sel_imec003_cs3  INTO l_imec003,l_imecl005
         #取除4的余数
         LET l_mod = l_n MOD 4
         #余数=1时新增一笔项序
         IF l_n <> 1 AND l_mod = 1 THEN
            LET l_cnt = l_cnt + 1
            INSERT INTO aslr001_imaa_tmp(tmp_item,tmp_imaa001,tmp_imec002,tmp_imas002)
            VALUES (l_cnt,l_imaa001,l_imeb002,l_imeb004)
         END IF
         INSERT INTO aslr001_imas_tmp(tmp_item,tmp_imas003)
         VALUES (l_cnt,l_imec003)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins_imas_tmp'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()   
            RETURN
         END IF
         LET l_n = l_n + 1
         LET l_imec003 = ''
         LET l_imecl005 = ''
      END FOREACH
      LET l_cnt = l_cnt + 1
      LET l_imaa001 = ''
      LET l_imaa005 = ''
   END FOREACH
   
END FUNCTION

 
{</section>}
 
{<section id="aslr001_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
