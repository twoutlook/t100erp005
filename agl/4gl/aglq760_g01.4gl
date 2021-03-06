#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq760_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-27 15:04:37), PR版次:0003(2016-05-27 15:49:02)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000102
#+ Filename...: aglq760_g01
#+ Description: ...
#+ Creator....: 05416(2014-07-22 16:07:39)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq760_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160505-00007#17  2016/05/27  By 02599  程式优化
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
   glaqld LIKE glaq_t.glaqld, 
   glaqcomp LIKE glaq_t.glaqcomp, 
   glaqent LIKE glaq_t.glaqent, 
   glaq002 LIKE type_t.chr30, 
   glaq002_desc LIKE type_t.chr300, 
   glapdocdt LIKE type_t.dat, 
   glaqdocno LIKE type_t.chr20, 
   glap004 LIKE type_t.num5, 
   glaq001 LIKE type_t.chr300, 
   style LIKE type_t.chr1, 
   glaq005 LIKE type_t.chr10, 
   glaq006 LIKE type_t.num26_10, 
   glaq010d LIKE type_t.num20_6, 
   glaq010c LIKE type_t.num20_6, 
   glaq003 LIKE type_t.num20_6, 
   glaq004 LIKE type_t.num20_6, 
   state LIKE type_t.chr10, 
   amt LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   groupby1 LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       sdate LIKE type_t.dat,         #起始日期 
       syear LIKE glap_t.glap002,         #起始年度 
       speri LIKE glap_t.glap004,         #起始期別 
       edate LIKE type_t.dat,         #截止日期 
       eyear LIKE glap_t.glap002,         #截止年度 
       eperi LIKE glap_t.glap004,         #截止期別 
       curro LIKE type_t.chr1,         #顯示原幣 
       grby1 LIKE type_t.chr1,         #按幣別分頁 
       grby2 LIKE type_t.chr1,         #按科目分頁 
       ctype LIKE type_t.chr1,         #多本位幣 
       ld LIKE glaa_t.glaald          #帳套
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
 
{<section id="aglq760_g01.main" readonly="Y" >}
PUBLIC FUNCTION aglq760_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9,p_arg10,p_arg11,p_arg12)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.sdate  起始日期 
DEFINE  p_arg3 LIKE glap_t.glap002         #tm.syear  起始年度 
DEFINE  p_arg4 LIKE glap_t.glap004         #tm.speri  起始期別 
DEFINE  p_arg5 LIKE type_t.dat         #tm.edate  截止日期 
DEFINE  p_arg6 LIKE glap_t.glap002         #tm.eyear  截止年度 
DEFINE  p_arg7 LIKE glap_t.glap004         #tm.eperi  截止期別 
DEFINE  p_arg8 LIKE type_t.chr1         #tm.curro  顯示原幣 
DEFINE  p_arg9 LIKE type_t.chr1         #tm.grby1  按幣別分頁 
DEFINE  p_arg10 LIKE type_t.chr1         #tm.grby2  按科目分頁 
DEFINE  p_arg11 LIKE type_t.chr1         #tm.ctype  多本位幣 
DEFINE  p_arg12 LIKE glaa_t.glaald         #tm.ld  帳套
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.sdate = p_arg2
   LET tm.syear = p_arg3
   LET tm.speri = p_arg4
   LET tm.edate = p_arg5
   LET tm.eyear = p_arg6
   LET tm.eperi = p_arg7
   LET tm.curro = p_arg8
   LET tm.grby1 = p_arg9
   LET tm.grby2 = p_arg10
   LET tm.ctype = p_arg11
   LET tm.ld = p_arg12
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   IF tm.curro='Y' THEN
      LET g_template ="aglq760_g01"
   ELSE
      LET g_template ="aglq760_g01_01"
   END IF
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aglq760_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aglq760_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aglq760_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aglq760_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq760_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq760_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   DEFINE l_glaa004       LIKE glaa_t.glaa004 #160505-00007#17
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT glaqld,glaqcomp,glaqent,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160505-00007#17--mod--str--
#   LET g_select = " SELECT '','','',glaq002,'',glapdocdt,glaqdocno,glap004,glaq001,style,glaq005,glaq006,glaq010d,glaq010c,
#                           glaq003,glaq004,state,amt,amt1,''"  
   LET g_select = " SELECT '",tm.ld,"','',",g_enterprise,",glaq002,t1.glacl004,",
                  "        glapdocdt,glaqdocno,glap004,",
                  "        CASE WHEN RTRIM(style) IS NULL THEN glaq001 ELSE t3.gzcbl004 END,",
                  "        style,glaq005,glaq006,glaq010d,glaq010c,",
                  "        glaq003,glaq004,t2.gzcbl004,amt,amt1,",
                  "        CASE WHEN '",tm.grby1,"'='Y' THEN glaq002||','||glaq005 ELSE glaq002||','||",g_enterprise," END " 
   #160505-00007#17--mod--end                           
#   #end add-point
#    LET g_from = " FROM glaq_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_from = " FROM ",tm.wc
    #160505-00007#17--add--str--
    SELECT glaa004 INTO l_glaa004 FROM glaa_t
     WHERE glaaent=g_enterprise AND glaald= tm.ld     
    LET g_from =g_from,
                " LEFT JOIN glacl_t t1 ON t1.glaclent=",g_enterprise," AND t1.glacl001='",l_glaa004,"'",
                "                     AND t1.glacl002=glaq002 AND t1.glacl003='",g_dlang,"' ",
                " LEFT JOIN gzcbl_t t2 ON t2.gzcbl001='9926' AND t2.gzcbl002=state AND t2.gzcbl003='",g_dlang,"' ",
                " LEFT JOIN gzcbl_t t3 ON t3.gzcbl001='9927' AND t3.gzcbl002=style AND t3.gzcbl003='",g_dlang,"' "                
    #160505-00007#17--add--end
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE 1=1 "
   #end add-point
    LET g_order = " ORDER BY groupby1"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"

   IF tm.grby1='Y' THEN
      LET g_order = " ORDER BY glaq002,glaq005,seq"
   ELSE
      LET g_order = " ORDER BY glaq002,seq"
   END IF

   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glaq_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE aglq760_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aglq760_g01_curs CURSOR FOR aglq760_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq760_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq760_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   glaqld LIKE glaq_t.glaqld, 
   glaqcomp LIKE glaq_t.glaqcomp, 
   glaqent LIKE glaq_t.glaqent, 
   glaq002 LIKE type_t.chr30, 
   glaq002_desc LIKE type_t.chr300, 
   glapdocdt LIKE type_t.dat, 
   glaqdocno LIKE type_t.chr20, 
   glap004 LIKE type_t.num5, 
   glaq001 LIKE type_t.chr300, 
   style LIKE type_t.chr1, 
   glaq005 LIKE type_t.chr10, 
   glaq006 LIKE type_t.num26_10, 
   glaq010d LIKE type_t.num20_6, 
   glaq010c LIKE type_t.num20_6, 
   glaq003 LIKE type_t.num20_6, 
   glaq004 LIKE type_t.num20_6, 
   state LIKE type_t.chr10, 
   amt LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   groupby1 LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
    DEFINE l_glaa004       LIKE glaa_t.glaa004
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aglq760_g01_curs INTO sr_s.*
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
#160505-00007#17--mark--str--
#       LET sr_s.glaqld=tm.ld 
#       LET sr_s.glaqent=g_enterprise
       
#       #科目說明
#       LET l_glaa004=''
#       SELECT glaa004 INTO l_glaa004
#         FROM glaa_t
#        WHERE glaaent=g_enterprise
#          AND glaald= tm.ld     
#       SELECT glacl004 INTO sr_s.glaq002_desc
#         FROM glacl_t 
#        WHERE glaclent=g_enterprise
#          AND glacl001=l_glaa004
#          AND glacl002=sr_s.glaq002
#          AND glacl003=g_dlang
#       #借貸   
#       SELECT gzcbl004 INTO sr_s.state
#         FROM gzcbl_t
#        WHERE gzcbl001='9926'
#          AND gzcbl002=sr_s.state
#          AND gzcbl003=g_dlang
#       #類型說明
#       IF NOT cl_null(sr_s.style) THEN
#          SELECT gzcbl004 INTO sr_s.glaq001
#            FROM gzcbl_t
#           WHERE gzcbl001='9927'
#             AND gzcbl002=sr_s.style
#             AND gzcbl003=g_dlang 
#       END IF  
#       #1、分頁
#       #2、按照要求一定會按照科目分頁
#       #3、根據界面是否按照幣別分頁
#       LET sr_s.groupby1=sr_s.glaq002
#       IF tm.grby1='Y' THEN
#          LET sr_s.groupby1=sr_s.groupby1||','||sr_s.glaq005
#       ELSE
#          LET sr_s.groupby1=sr_s.groupby1||','||sr_s.glaqent
#       END IF
#160505-00007#17--mark--end
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].glaqld = sr_s.glaqld
       LET sr[l_cnt].glaqcomp = sr_s.glaqcomp
       LET sr[l_cnt].glaqent = sr_s.glaqent
       LET sr[l_cnt].glaq002 = sr_s.glaq002
       LET sr[l_cnt].glaq002_desc = sr_s.glaq002_desc
       LET sr[l_cnt].glapdocdt = sr_s.glapdocdt
       LET sr[l_cnt].glaqdocno = sr_s.glaqdocno
       LET sr[l_cnt].glap004 = sr_s.glap004
       LET sr[l_cnt].glaq001 = sr_s.glaq001
       LET sr[l_cnt].style = sr_s.style
       LET sr[l_cnt].glaq005 = sr_s.glaq005
       LET sr[l_cnt].glaq006 = sr_s.glaq006
       LET sr[l_cnt].glaq010d = sr_s.glaq010d
       LET sr[l_cnt].glaq010c = sr_s.glaq010c
       LET sr[l_cnt].glaq003 = sr_s.glaq003
       LET sr[l_cnt].glaq004 = sr_s.glaq004
       LET sr[l_cnt].state = sr_s.state
       LET sr[l_cnt].amt = sr_s.amt
       LET sr[l_cnt].amt1 = sr_s.amt1
       LET sr[l_cnt].groupby1 = sr_s.groupby1
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
 
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq760_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq760_g01_rep_data()
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
          START REPORT aglq760_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aglq760_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aglq760_g01_rep
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
 
{<section id="aglq760_g01.rep" readonly="Y" >}
PRIVATE REPORT aglq760_g01_rep(sr1)
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

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.groupby1
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
        BEFORE GROUP OF sr1.groupby1
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
 
            #end add-point:rep.header 
            LET g_rep_docno = sr1.groupby1
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'glaqent=' ,sr1.glaqent,'{+}glaqld=' ,sr1.glaqld         
            CALL cl_gr_init_apr(sr1.groupby1)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.groupby1.before name="rep.b_group.groupby1.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.glaqent CLIPPED ,"'", " AND  ooff003 = '", sr1.groupby1 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq760_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aglq760_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aglq760_g01_subrep01
           DECLARE aglq760_g01_repcur01 CURSOR FROM g_sql
           FOREACH aglq760_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq760_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aglq760_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aglq760_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.groupby1.after name="rep.b_group.groupby1.after"
           
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
                sr1.glaqent CLIPPED ,"'", " AND  ooff003 = '", sr1.groupby1 CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq760_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aglq760_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aglq760_g01_subrep02
           DECLARE aglq760_g01_repcur02 CURSOR FROM g_sql
           FOREACH aglq760_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq760_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aglq760_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aglq760_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
#          IF sr1.glaq003 > 0 THEN 
#            LET sr1.l_glaq010 = " 1:借 "
#          ELSE 
#            LET sr1.l_glaq010 = " 2:贷 "
#          END IF
#          
#          LET sr1.l_glaq020 =sr1.glaq003 - sr1.glaq004
#          IF sr1.l_glaq020 < 0 THEN
#             LET sr1.l_glaq020 = (-1) * sr1.l_glaq020
#          END IF
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
                sr1.glaqent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq760_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aglq760_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aglq760_g01_subrep03
           DECLARE aglq760_g01_repcur03 CURSOR FROM g_sql
           FOREACH aglq760_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq760_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aglq760_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aglq760_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.groupby1
 
           #add-point:rep.a_group.groupby1.before name="rep.a_group.groupby1.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.glaqent CLIPPED ,"'", " AND  ooff003 = '", sr1.groupby1 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq760_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aglq760_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aglq760_g01_subrep04
           DECLARE aglq760_g01_repcur04 CURSOR FROM g_sql
           FOREACH aglq760_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq760_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aglq760_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aglq760_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.groupby1.after name="rep.a_group.groupby1.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aglq760_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aglq760_g01_subrep01(sr2)
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
PRIVATE REPORT aglq760_g01_subrep02(sr2)
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
PRIVATE REPORT aglq760_g01_subrep03(sr2)
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
PRIVATE REPORT aglq760_g01_subrep04(sr2)
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
 
{<section id="aglq760_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aglq760_g01.other_report" readonly="Y" >}

 
{</section>}
 
