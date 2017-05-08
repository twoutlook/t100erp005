#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq004_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-11-09 14:30:23), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: asfq004_g01
#+ Description: ...
#+ Creator....: 03297(2014-11-24 16:15:04)
#+ Modifier...: 08992 -SD/PR- 00000
 
{</section>}
 
{<section id="asfq004_g01.global" readonly="Y" >}
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
   bmba001 LIKE bmba_t.bmba001, 
   bmba002 LIKE bmba_t.bmba002, 
   l_xmdc006 LIKE xmdc_t.xmdc006, 
   l_xmdc007 LIKE type_t.num20_6, 
   bmba003 LIKE bmba_t.bmba003, 
   bmba010 LIKE bmba_t.bmba010, 
   l_xmdc_imaal003 LIKE type_t.chr500, 
   l_xmdc_imaal004 LIKE type_t.chr500, 
   l_xmdc002_desc LIKE type_t.chr500, 
   l_xmdc_oocal003 LIKE type_t.chr500, 
   l_bmba_imaal003 LIKE type_t.chr500, 
   l_bmba_imaal004 LIKE type_t.chr500, 
   l_bmba_oocal003 LIKE type_t.chr500, 
   l_qty1 LIKE type_t.num20_6, 
   l_qty2 LIKE type_t.num20_6, 
   l_qty3 LIKE type_t.num20_6, 
   l_qty4 LIKE type_t.num20_6, 
   l_qty5 LIKE type_t.num20_6, 
   l_qty6 LIKE type_t.num20_6, 
   l_qty8 LIKE type_t.num20_6, 
   l_qty9 LIKE type_t.num20_6, 
   l_qty10 LIKE type_t.num20_6, 
   l_qty11 LIKE type_t.num20_6, 
   l_stus LIKE type_t.chr1, 
   bmbaent LIKE bmba_t.bmbaent, 
   l_qty1_s LIKE type_t.chr200, 
   l_qty2_s LIKE type_t.chr200, 
   l_qty3_s LIKE type_t.chr200, 
   l_qty4_s LIKE type_t.chr200, 
   l_qty5_s LIKE type_t.chr200, 
   l_qty6_s LIKE type_t.chr200, 
   l_qty7_s LIKE type_t.chr200, 
   l_qty8_s LIKE type_t.chr200, 
   l_qty9_s LIKE type_t.chr200, 
   l_qty10_s LIKE type_t.chr200, 
   l_qty11_s LIKE type_t.chr200, 
   l_qty12 LIKE type_t.num20_6, 
   l_qty7 LIKE type_t.num20_6, 
   l_qty13 LIKE type_t.num20_6
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #暫存檔1 
       a2 STRING                   #暫存檔2
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
DEFINE g_tmptable1      STRING
DEFINE g_tmptable2      STRING
 TYPE sr3_r RECORD
   xmdc001 LIKE bmba_t.bmba001, 
   xmdc002 LIKE bmba_t.bmba002, 
   xmdc006 LIKE xmdc_t.xmdc006, 
   xmdc007 LIKE type_t.num20_6,
   l_xmdc_imaal003 LIKE type_t.chr500, 
   l_xmdc_imaal004 LIKE type_t.chr500, 
   l_xmdc002_desc LIKE type_t.chr500, 
   l_xmdc_oocal003 LIKE type_t.chr500   
END RECORD
DEFINE sr3 DYNAMIC ARRAY OF sr3_r   
#end add-point
 
{</section>}
 
{<section id="asfq004_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfq004_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  暫存檔1 
DEFINE  p_arg3 STRING                  #tm.a2  暫存檔2
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmptable1 = tm.a1
   LET g_tmptable2 = tm.a2
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asfq004_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfq004_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfq004_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfq004_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfq004_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT bmba001,bmba002,'','',bmba003,bmba010,'','','','','','','','','','','','', 
       '','','','','','',bmbaent,'','','','','','','','','','','','','',NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
#   LET g_select = " SELECT xmdc001,xmdc002,xmdc006,xmdc007,bmba003,bmba010,t1.imaal003,t1.imaal004,",
#                  "        '',t2.oocal003,t3.imaal003,t3.imaal004,t4.oocal003, ",
#                  "        qty1,qty2,qty3,qty4,qty5,qty6,qty7,qty8,qty9,qty10,qty11,stus,",
#                  "        bmbaent,'','','','','','','','','','','' "
                  
   LET g_select = " SELECT '','','','',bmba003,bmba010,'','','','',t3.imaal003,t3.imaal004,t4.oocal003, ",
                  "        qty1,qty2,qty3,qty4,qty5,qty6,qty8,qty9,qty10,qty11,stus,",
                  "        bmbaent,'','','','','','','','','','','',qty12,qty7,qty13 "
   #end add-point
    LET g_from = " FROM bmba_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
#   LET g_from = " FROM ",g_tmptable,
#                " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=xmdc001 AND t1.imaal002='"||g_dlang||"' ",
#                " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=bmba003 AND t3.imaal002='"||g_dlang||"' ",
#                " LEFT JOIN oocal_t t2 ON t2.oocalent='"||g_enterprise||"' AND t2.oocal001=xmdc006 AND t2.oocal002='"||g_dlang||"' ", 
#                " LEFT JOIN oocal_t t4 ON t4.oocalent='"||g_enterprise||"' AND t4.oocal001=bmba010 AND t4.oocal002='"||g_dlang||"' "
   LET g_from = " FROM ",g_tmptable2,                
                " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=bmba003 AND t3.imaal002='"||g_dlang||"' ",
                " LEFT JOIN oocal_t t4 ON t4.oocalent='"||g_enterprise||"' AND t4.oocal001=bmba010 AND t4.oocal002='"||g_dlang||"' "

#   LET g_from = " FROM ",g_tmptable
                
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY bmba001,bmba003"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY bmba003"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bmba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_where = " WHERE " ,tm.wc CLIPPED 
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   #end add-point
   PREPARE asfq004_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfq004_g01_curs CURSOR FOR asfq004_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfq004_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfq004_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   bmba001 LIKE bmba_t.bmba001, 
   bmba002 LIKE bmba_t.bmba002, 
   l_xmdc006 LIKE xmdc_t.xmdc006, 
   l_xmdc007 LIKE type_t.num20_6, 
   bmba003 LIKE bmba_t.bmba003, 
   bmba010 LIKE bmba_t.bmba010, 
   l_xmdc_imaal003 LIKE type_t.chr500, 
   l_xmdc_imaal004 LIKE type_t.chr500, 
   l_xmdc002_desc LIKE type_t.chr500, 
   l_xmdc_oocal003 LIKE type_t.chr500, 
   l_bmba_imaal003 LIKE type_t.chr500, 
   l_bmba_imaal004 LIKE type_t.chr500, 
   l_bmba_oocal003 LIKE type_t.chr500, 
   l_qty1 LIKE type_t.num20_6, 
   l_qty2 LIKE type_t.num20_6, 
   l_qty3 LIKE type_t.num20_6, 
   l_qty4 LIKE type_t.num20_6, 
   l_qty5 LIKE type_t.num20_6, 
   l_qty6 LIKE type_t.num20_6, 
   l_qty8 LIKE type_t.num20_6, 
   l_qty9 LIKE type_t.num20_6, 
   l_qty10 LIKE type_t.num20_6, 
   l_qty11 LIKE type_t.num20_6, 
   l_stus LIKE type_t.chr1, 
   bmbaent LIKE bmba_t.bmbaent, 
   l_qty1_s LIKE type_t.chr200, 
   l_qty2_s LIKE type_t.chr200, 
   l_qty3_s LIKE type_t.chr200, 
   l_qty4_s LIKE type_t.chr200, 
   l_qty5_s LIKE type_t.chr200, 
   l_qty6_s LIKE type_t.chr200, 
   l_qty7_s LIKE type_t.chr200, 
   l_qty8_s LIKE type_t.chr200, 
   l_qty9_s LIKE type_t.chr200, 
   l_qty10_s LIKE type_t.chr200, 
   l_qty11_s LIKE type_t.chr200, 
   l_qty12 LIKE type_t.num20_6, 
   l_qty7 LIKE type_t.num20_6, 
   l_qty13 LIKE type_t.num20_6
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_str1 STRING
DEFINE l_str2 STRING
DEFINE l_str3 STRING
DEFINE l_str4 STRING
DEFINE l_str5 STRING
DEFINE l_str6 STRING

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asfq004_g01_curs INTO sr_s.*
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
       LET sr[l_cnt].bmba001 = sr_s.bmba001
       LET sr[l_cnt].bmba002 = sr_s.bmba002
       LET sr[l_cnt].l_xmdc006 = sr_s.l_xmdc006
       LET sr[l_cnt].l_xmdc007 = sr_s.l_xmdc007
       LET sr[l_cnt].bmba003 = sr_s.bmba003
       LET sr[l_cnt].bmba010 = sr_s.bmba010
       LET sr[l_cnt].l_xmdc_imaal003 = sr_s.l_xmdc_imaal003
       LET sr[l_cnt].l_xmdc_imaal004 = sr_s.l_xmdc_imaal004
       LET sr[l_cnt].l_xmdc002_desc = sr_s.l_xmdc002_desc
       LET sr[l_cnt].l_xmdc_oocal003 = sr_s.l_xmdc_oocal003
       LET sr[l_cnt].l_bmba_imaal003 = sr_s.l_bmba_imaal003
       LET sr[l_cnt].l_bmba_imaal004 = sr_s.l_bmba_imaal004
       LET sr[l_cnt].l_bmba_oocal003 = sr_s.l_bmba_oocal003
       LET sr[l_cnt].l_qty1 = sr_s.l_qty1
       LET sr[l_cnt].l_qty2 = sr_s.l_qty2
       LET sr[l_cnt].l_qty3 = sr_s.l_qty3
       LET sr[l_cnt].l_qty4 = sr_s.l_qty4
       LET sr[l_cnt].l_qty5 = sr_s.l_qty5
       LET sr[l_cnt].l_qty6 = sr_s.l_qty6
       LET sr[l_cnt].l_qty8 = sr_s.l_qty8
       LET sr[l_cnt].l_qty9 = sr_s.l_qty9
       LET sr[l_cnt].l_qty10 = sr_s.l_qty10
       LET sr[l_cnt].l_qty11 = sr_s.l_qty11
       LET sr[l_cnt].l_stus = sr_s.l_stus
       LET sr[l_cnt].bmbaent = sr_s.bmbaent
       LET sr[l_cnt].l_qty1_s = sr_s.l_qty1_s
       LET sr[l_cnt].l_qty2_s = sr_s.l_qty2_s
       LET sr[l_cnt].l_qty3_s = sr_s.l_qty3_s
       LET sr[l_cnt].l_qty4_s = sr_s.l_qty4_s
       LET sr[l_cnt].l_qty5_s = sr_s.l_qty5_s
       LET sr[l_cnt].l_qty6_s = sr_s.l_qty6_s
       LET sr[l_cnt].l_qty7_s = sr_s.l_qty7_s
       LET sr[l_cnt].l_qty8_s = sr_s.l_qty8_s
       LET sr[l_cnt].l_qty9_s = sr_s.l_qty9_s
       LET sr[l_cnt].l_qty10_s = sr_s.l_qty10_s
       LET sr[l_cnt].l_qty11_s = sr_s.l_qty11_s
       LET sr[l_cnt].l_qty12 = sr_s.l_qty12
       LET sr[l_cnt].l_qty7 = sr_s.l_qty7
       LET sr[l_cnt].l_qty13 = sr_s.l_qty13
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
#       LET l_str1 = cl_getmsg("asf-00458",g_lang) #備置量：
#       LET l_str2 = cl_getmsg("asf-00459",g_lang) #在揀量：
#       LET l_str3 = cl_getmsg("asf-00460",g_lang) #可用餘量：
#       LET l_str4 = cl_getmsg("asf-00461",g_lang) #在途量：
#       LET l_str5 = cl_getmsg("asf-00462",g_lang) #在驗量：
#       LET l_str6 = cl_getmsg("asf-00463",g_lang) #在制量：
#       LET sr[l_cnt].l_qty3_s = l_str1,sr_s.l_qty3
#       LET sr[l_cnt].l_qty4_s = l_str2,sr_s.l_qty4
#       LET sr[l_cnt].l_qty5_s = l_str3,sr_s.l_qty5
#       LET sr[l_cnt].l_qty8_s = l_str4,sr_s.l_qty8
#       LET sr[l_cnt].l_qty9_s = l_str5,sr_s.l_qty9
#       LET sr[l_cnt].l_qty10_s = l_str6,sr_s.l_qty10
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfq004_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfq004_g01_rep_data()
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
          START REPORT asfq004_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfq004_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfq004_g01_rep
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
 
{<section id="asfq004_g01.rep" readonly="Y" >}
PRIVATE REPORT asfq004_g01_rep(sr1)
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
DEFINE sr3 sr3_r
DEFINE l_subrep05_show  LIKE type_t.chr1       
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.bmba001,sr1.bmba003
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
        BEFORE GROUP OF sr1.bmba001
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.bmba001
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'bmbaent=' ,sr1.bmbaent,'{+}bmba001=' ,sr1.bmba001,'{+}bmba002=' ,sr1.bmba002,'{+}bmba003=' ,sr1.bmba003         
            CALL cl_gr_init_apr(sr1.bmba001)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.bmba001.before name="rep.b_group.bmba001.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.bmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.bmba001 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfq004_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfq004_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfq004_g01_subrep01
           DECLARE asfq004_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfq004_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfq004_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfq004_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfq004_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.bmba001.after name="rep.b_group.bmba001.after"
----------------------子報表一：第一单身
          LET l_subrep05_show = "Y"
          LET g_sql = " SELECT xmdc001,xmdc002,xmdc006,xmdc007,t1.imaal003,t1.imaal004,'',t2.oocal003 ",
                      " FROM ",g_tmptable1,
                      " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=xmdc001 AND t1.imaal002='"||g_dlang||"' ",                    
                      " LEFT JOIN oocal_t t2 ON t2.oocalent='"||g_enterprise||"' AND t2.oocal001=xmdc006 AND t2.oocal002='"||g_dlang||"' "
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE asfq004_g01_repcur05_cnt_pre FROM l_sub_sql
          EXECUTE asfq004_g01_repcur05_cnt_pre INTO l_cnt
#          IF l_cnt > 0 AND tm.pr1 = 'Y'THEN 
#            LET l_subrep05_show ="Y"
#          ELSE 
#            LET l_subrep05_show = "N"
#          END IF
          PRINTX l_subrep05_show
          START REPORT asfq004_g01_subrep05
          DECLARE asfq004_g01_repcur05 CURSOR FROM g_sql
          FOREACH asfq004_g01_repcur05 INTO sr3.*
             
             OUTPUT TO REPORT asfq004_g01_subrep05(sr3.*)

          END FOREACH
          FINISH REPORT asfq004_g01_subrep05
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.bmba003
 
           #add-point:rep.b_group.bmba003.before name="rep.b_group.bmba003.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.bmba003.after name="rep.b_group.bmba003.after"
           
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
                sr1.bmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.bmba001 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.bmba003 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfq004_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfq004_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfq004_g01_subrep02
           DECLARE asfq004_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfq004_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfq004_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfq004_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfq004_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.bmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.bmba001 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.bmba003 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfq004_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfq004_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfq004_g01_subrep03
           DECLARE asfq004_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfq004_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfq004_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfq004_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfq004_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.bmba001
 
           #add-point:rep.a_group.bmba001.before name="rep.a_group.bmba001.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.bmbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.bmba001 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfq004_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfq004_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfq004_g01_subrep04
           DECLARE asfq004_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfq004_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfq004_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfq004_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfq004_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.bmba001.after name="rep.a_group.bmba001.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.bmba003
 
           #add-point:rep.a_group.bmba003.before name="rep.a_group.bmba003.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.bmba003.after name="rep.a_group.bmba003.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfq004_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfq004_g01_subrep01(sr2)
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
PRIVATE REPORT asfq004_g01_subrep02(sr2)
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
PRIVATE REPORT asfq004_g01_subrep03(sr2)
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
PRIVATE REPORT asfq004_g01_subrep04(sr2)
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
 
{<section id="asfq004_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="asfq004_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE REPORT asfq004_g01_subrep05(sr3)
    DEFINE sr3 sr3_r
    FORMAT
#        ORDER EXTERNAL BY sr3.xmdc001   
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
        
END REPORT

 
{</section>}
 
