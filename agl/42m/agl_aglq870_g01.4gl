#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq870_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-14 18:10:01), PR版次:0001(2016-11-14 18:58:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aglq870_g01
#+ Description: ...
#+ Creator....: 07900(2016-10-24 10:09:03)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="aglq870_g01.global" readonly="Y" >}
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
   glfbent LIKE glfb_t.glfbent, 
   glfb001 LIKE glfb_t.glfb001, 
   glfbseq LIKE glfb_t.glfbseq, 
   glfb002 LIKE glfb_t.glfb002, 
   l_glfbl004 LIKE type_t.chr500, 
   glfb003 LIKE glfb_t.glfb003, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   l_amt4 LIKE type_t.num20_6, 
   l_per1 LIKE type_t.num20_6, 
   l_per2 LIKE type_t.num20_6, 
   l_per3 LIKE type_t.num20_6, 
   l_per4 LIKE type_t.num20_6, 
   glfb010 LIKE glfb_t.glfb010
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #临时表 
       a2 LIKE glfa_t.glfa001,         #报表模板编号 
       a3 LIKE glfa_t.glfa005,         #账套 
       a4 LIKE glfa_t.glfa006,         #年度 
       a5 LIKE glfa_t.glfa011,         #起始期别 
       a6 LIKE glfa_t.glfa012,         #截止期别 
       a7 LIKE glfa_t.glfa013,         #比较年度 
       a8 LIKE glfa_t.glfa014,         #起始比较期别 
       a9 LIKE glfa_t.glfa015,         #截止比较期别 
       a10 LIKE glfa_t.glfa009,         #小数字数 
       a11 LIKE glfa_t.glfa008          #单位
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
DEFINE g_tmptable      STRING         #暫存檔
DEFINE g_glfa001       LIKE glfa_t.glfa001          #報表模板編號
DEFINE g_glfa005       LIKE glfa_t.glfa005          #帳套
DEFINE g_glfa006       LIKE glfa_t.glfa006          #年度 
DEFINE g_glfa008       LIKE glfa_t.glfa008          #單位
DEFINE g_glfa009       LIKE glfa_t.glfa009          #小數位數
DEFINE g_glfa011       LIKE glfa_t.glfa011          #起始期别
DEFINE g_glfa012       LIKE glfa_t.glfa012          #截止期别

#end add-point
 
{</section>}
 
{<section id="aglq870_g01.main" readonly="Y" >}
PUBLIC FUNCTION aglq870_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9,p_arg10,p_arg11,p_arg12)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  临时表 
DEFINE  p_arg3 LIKE glfa_t.glfa001         #tm.a2  报表模板编号 
DEFINE  p_arg4 LIKE glfa_t.glfa005         #tm.a3  账套 
DEFINE  p_arg5 LIKE glfa_t.glfa006         #tm.a4  年度 
DEFINE  p_arg6 LIKE glfa_t.glfa011         #tm.a5  起始期别 
DEFINE  p_arg7 LIKE glfa_t.glfa012         #tm.a6  截止期别 
DEFINE  p_arg8 LIKE glfa_t.glfa013         #tm.a7  比较年度 
DEFINE  p_arg9 LIKE glfa_t.glfa014         #tm.a8  起始比较期别 
DEFINE  p_arg10 LIKE glfa_t.glfa015         #tm.a9  截止比较期别 
DEFINE  p_arg11 LIKE glfa_t.glfa009         #tm.a10  小数字数 
DEFINE  p_arg12 LIKE glfa_t.glfa008         #tm.a11  单位
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
   LET tm.a5 = p_arg6
   LET tm.a6 = p_arg7
   LET tm.a7 = p_arg8
   LET tm.a8 = p_arg9
   LET tm.a9 = p_arg10
   LET tm.a10 = p_arg11
   LET tm.a11 = p_arg12
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmptable = tm.a1        #临时表  
   LET g_glfa001  = tm.a2          #报表编号 
   LET g_glfa005  = tm.a3          #账套
   LET g_glfa006  = tm.a4          #年度
   LET g_glfa011  = tm.a5          #起始期别
   LET g_glfa012  = tm.a6          #截止期别 
   LET g_glfa009  = tm.a10          #小數位數
   LET g_glfa008  = tm.a11       #tm.a11  单位
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aglq870_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aglq870_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aglq870_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aglq870_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq870_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq870_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
    LET g_select = " SELECT glfbent,glfb001,glfbseq,glfb002,glfbl004,glfb003,amt1,amt2,amt3,amt4,per1,per2,per3,per4,glfb010 "
#   #end add-point
#   LET g_select = " SELECT glfbent,glfb001,glfbseq,glfb002,NULL,glfb003,NULL,NULL,NULL,NULL,0,0,0,0, 
#       glfb010"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM ",g_tmptable
#   #end add-point
#    LET g_from = " FROM glfb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_where = " WHERE " ,tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY glfb001"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
    LET g_order = " ORDER BY glfbseq" 
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glfb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aglq870_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aglq870_g01_curs CURSOR FOR aglq870_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq870_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq870_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   glfbent LIKE glfb_t.glfbent, 
   glfb001 LIKE glfb_t.glfb001, 
   glfbseq LIKE glfb_t.glfbseq, 
   glfb002 LIKE glfb_t.glfb002, 
   l_glfbl004 LIKE type_t.chr500, 
   glfb003 LIKE glfb_t.glfb003, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   l_amt4 LIKE type_t.num20_6, 
   l_per1 LIKE type_t.num20_6, 
   l_per2 LIKE type_t.num20_6, 
   l_per3 LIKE type_t.num20_6, 
   l_per4 LIKE type_t.num20_6, 
   glfb010 LIKE glfb_t.glfb010
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
    FOREACH aglq870_g01_curs INTO sr_s.*
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
       LET sr[l_cnt].glfbent = sr_s.glfbent
       LET sr[l_cnt].glfb001 = sr_s.glfb001
       LET sr[l_cnt].glfbseq = sr_s.glfbseq
       LET sr[l_cnt].glfb002 = sr_s.glfb002
       LET sr[l_cnt].l_glfbl004 = sr_s.l_glfbl004
       LET sr[l_cnt].glfb003 = sr_s.glfb003
       LET sr[l_cnt].l_amt1 = sr_s.l_amt1
       LET sr[l_cnt].l_amt2 = sr_s.l_amt2
       LET sr[l_cnt].l_amt3 = sr_s.l_amt3
       LET sr[l_cnt].l_amt4 = sr_s.l_amt4
       LET sr[l_cnt].l_per1 = sr_s.l_per1
       LET sr[l_cnt].l_per2 = sr_s.l_per2
       LET sr[l_cnt].l_per3 = sr_s.l_per3
       LET sr[l_cnt].l_per4 = sr_s.l_per4
       LET sr[l_cnt].glfb010 = sr_s.glfb010
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq870_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq870_g01_rep_data()
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
          START REPORT aglq870_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aglq870_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aglq870_g01_rep
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
 
{<section id="aglq870_g01.rep" readonly="Y" >}
PRIVATE REPORT aglq870_g01_rep(sr1)
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
DEFINE l_glaa003        LIKE glaa_t.glaa003
DEFINE l_max_glav004    LIKE glav_t.glav004
DEFINE l_min_glav004    LIKE glav_t.glav004
DEFINE l_glaacomp       LIKE glaa_t.glaacomp
DEFINE l_glaacomp_desc  LIKE ooefl_t.ooefl003   #編製單位說明
DEFINE l_title02        STRING
DEFINE l_glfal003       LIKE glfal_t.glfal003
DEFINE l_glfa008_desc   STRING                   #單位說明
DEFINE l_yy_s           LIKE type_t.num10
DEFINE l_mm_s           LIKE type_t.num10
DEFINE l_dd_s           LIKE type_t.num10
DEFINE l_yy_e           LIKE type_t.num10
DEFINE l_mm_e           LIKE type_t.num10
DEFINE l_dd_e           LIKE type_t.num10
DEFINE l_format         LIKE type_t.chr30
DEFINE l_glfb010        LIKE type_t.num20_6
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.glfb001
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
        BEFORE GROUP OF sr1.glfb001
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            #報表名稱
            LET l_glfal003 =''
            SELECT glfal003 INTO l_glfal003 FROM glfal_t WHERE glfalent = g_enterprise AND glfal001 = g_glfa001 AND glfal002 = g_dlang
            LET g_grPageHeader.title0201 = l_glfal003
            
            #通过帐套抓取对应的法人
            SELECT glaacomp INTO l_glaacomp FROM glaa_t 
             WHERE glaaent = g_enterprise AND glaald = g_glfa005 
            #法人简称
            LET l_glaacomp_desc=''
            SELECT ooefl006 INTO l_glaacomp_desc FROM ooefl_t
             WHERE ooeflent = g_enterprise AND ooefl001= l_glaacomp AND ooefl002 = g_dlang
            IF cl_null(l_glaacomp_desc) THEN
               SELECT ooefl003 INTO l_glaacomp_desc FROM ooefl_t
                WHERE ooeflent = g_enterprise AND ooefl001= l_glaacomp AND ooefl002 = g_dlang
            END IF           
            PRINTX l_glaacomp_desc
            
            #單位
            CASE g_glfa008
               WHEN "1"
                  LET l_glfa008_desc = cl_getmsg("agl-00282",g_dlang)
               WHEN "2"
                  LET l_glfa008_desc = cl_getmsg("agl-00283",g_dlang)  
               WHEN "3"
                  LET l_glfa008_desc = cl_getmsg("agl-00284",g_dlang)                
            END CASE
            PRINTX l_glfa008_desc
            
            #年月日
            
            
           
            
            LET l_glaa003 = ''
            LET l_max_glav004 = 0
            LET l_min_glav004 = 0                      
            SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_glfa005
            #从周期表中抓取第一天
            SELECT MIN(glav004) INTO l_min_glav004 FROM glav_t WHERE glavent= g_enterprise AND glav001=l_glaa003 AND glav002=g_glfa006 AND glav006= g_glfa011
            LET l_yy_s = YEAR(l_min_glav004)
            LET l_mm_s = MONTH(l_min_glav004)
            LET l_dd_s = DAY(l_min_glav004)
            PRINTX l_yy_s
            PRINTX l_mm_s
            PRINTX l_dd_s
            #从周期表中抓取最后一天
            SELECT MAX(glav004) INTO l_max_glav004 FROM glav_t WHERE glavent= g_enterprise AND glav001=l_glaa003 AND glav002=g_glfa006 AND glav006= g_glfa012
            LET l_yy_e = YEAR(l_max_glav004)
            LET l_mm_e = MONTH(l_max_glav004)
            LET l_dd_e = DAY(l_max_glav004)
            
            PRINTX l_yy_e
            PRINTX l_mm_e
            PRINTX l_dd_e
            
            #---報表顯示格式。
            CALL aglq870_g01_getnum(g_glfa009) RETURNING l_format
        
            PRINTX l_format
            
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.glfb001
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'glfbent=' ,sr1.glfbent,'{+}glfb001=' ,sr1.glfb001,'{+}glfbseq=' ,sr1.glfbseq         
            CALL cl_gr_init_apr(sr1.glfb001)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.glfb001.before name="rep.b_group.glfb001.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.glfbent CLIPPED ,"'", " AND  ooff003 = '", sr1.glfb001 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq870_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aglq870_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aglq870_g01_subrep01
           DECLARE aglq870_g01_repcur01 CURSOR FROM g_sql
           FOREACH aglq870_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq870_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aglq870_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aglq870_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.glfb001.after name="rep.b_group.glfb001.after"
           
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
                sr1.glfbent CLIPPED ,"'", " AND  ooff003 = '", sr1.glfb001 CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq870_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aglq870_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aglq870_g01_subrep02
           DECLARE aglq870_g01_repcur02 CURSOR FROM g_sql
           FOREACH aglq870_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq870_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aglq870_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aglq870_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          #标示呈现下划线
          LET l_glfb010 = 0
          IF sr1.glfb010 = '1' THEN
             LET l_glfb010 = 1
          END IF
         
          PRINTX l_glfb010
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.glfbent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq870_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aglq870_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aglq870_g01_subrep03
           DECLARE aglq870_g01_repcur03 CURSOR FROM g_sql
           FOREACH aglq870_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq870_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aglq870_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aglq870_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.glfb001
 
           #add-point:rep.a_group.glfb001.before name="rep.a_group.glfb001.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.glfbent CLIPPED ,"'", " AND  ooff003 = '", sr1.glfb001 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq870_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aglq870_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aglq870_g01_subrep04
           DECLARE aglq870_g01_repcur04 CURSOR FROM g_sql
           FOREACH aglq870_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq870_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aglq870_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aglq870_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.glfb001.after name="rep.a_group.glfb001.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aglq870_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aglq870_g01_subrep01(sr2)
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
PRIVATE REPORT aglq870_g01_subrep02(sr2)
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
PRIVATE REPORT aglq870_g01_subrep03(sr2)
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
PRIVATE REPORT aglq870_g01_subrep04(sr2)
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
 
{<section id="aglq870_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...:數值的報表顯示樣式
# Memo...........:
# Usage..........: CALL aglq810_g01_getnum(p_glfa009)
#                  RETURNING r_format
# Input parameter: p_glfa009   小數位數
# Return code....: r_format    數值的樣式
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq870_g01_getnum(p_glfa009)
  DEFINE p_glfa009      LIKE glfa_t.glfa009
  DEFINE r_format       LIKE type_t.chr30
  DEFINE l_i            LIKE type_t.num5
  DEFINE l_str          LIKE type_t.chr30

        
   LET r_format="--,---,---,---,--&" #數值--報表樣式
   LET l_str=""
   FOR l_i=1 TO p_glfa009  
       LET l_str=l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET r_format=r_format,".",l_str
   END IF
   
   RETURN r_format
END FUNCTION

 
{</section>}
 
{<section id="aglq870_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
