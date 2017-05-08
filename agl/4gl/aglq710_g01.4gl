#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq710_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-05-06 15:56:19), PR版次:0002(2016-05-06 16:06:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: aglq710_g01
#+ Description: ...
#+ Creator....: 01251(2015-01-22 13:49:41)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="aglq710_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160505-00007#5    2016/05/06   By 02114   效能優化
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
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr200, 
   glar009 LIKE glar_t.glar009, 
   oyeard LIKE type_t.num20_6, 
   oyearc LIKE type_t.num20_6, 
   yeard LIKE type_t.num20_6, 
   yearc LIKE type_t.num20_6, 
   yeard2 LIKE type_t.num20_6, 
   yearc2 LIKE type_t.num20_6, 
   yeard3 LIKE type_t.num20_6, 
   yearc3 LIKE type_t.num20_6, 
   oqcd LIKE type_t.num20_6, 
   oqcc LIKE type_t.num20_6, 
   qcd LIKE type_t.num20_6, 
   qcc LIKE type_t.num20_6, 
   qcd2 LIKE type_t.num20_6, 
   qcc2 LIKE type_t.num20_6, 
   qcd3 LIKE type_t.num20_6, 
   qcc3 LIKE type_t.num20_6, 
   oqjd LIKE type_t.num20_6, 
   oqjc LIKE type_t.num20_6, 
   qjd LIKE type_t.num20_6, 
   qjc LIKE type_t.num20_6, 
   qjd2 LIKE type_t.num20_6, 
   qjc2 LIKE type_t.num20_6, 
   qjd3 LIKE type_t.num20_6, 
   qjc3 LIKE type_t.num20_6, 
   oqmd LIKE type_t.num20_6, 
   oqmc LIKE type_t.num20_6, 
   qmd LIKE type_t.num20_6, 
   qmc LIKE type_t.num20_6, 
   qmd2 LIKE type_t.num20_6, 
   qmc2 LIKE type_t.num20_6, 
   qmd3 LIKE type_t.num20_6, 
   qmc3 LIKE type_t.num20_6, 
   osumd LIKE type_t.num20_6, 
   osumc LIKE type_t.num20_6, 
   sumd LIKE type_t.num20_6, 
   sumc LIKE type_t.num20_6, 
   sumd2 LIKE type_t.num20_6, 
   sumc2 LIKE type_t.num20_6, 
   sumd3 LIKE type_t.num20_6, 
   sumc3 LIKE type_t.num20_6, 
   glarent LIKE glar_t.glarent, 
   l_groupby LIKE type_t.chr10
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       sdate LIKE type_t.dat,         #起始日期 
       bdate LIKE type_t.dat,         #截止日期 
       ctype LIKE type_t.chr1,         #多本位幣 
       curro LIKE type_t.chr1,         #顯示原幣 
       currp LIKE type_t.chr1,         #按幣別分頁 
       showv LIKE type_t.chr1,         #顯示年初數 
       ld LIKE glaa_t.glaald,         #帳套 
       syear LIKE glap_t.glap002,         #起始年度 
       speri LIKE glap_t.glap004,         #起始期別 
       eyear LIKE glap_t.glap002,         #截止年度 
       eperi LIKE glap_t.glap004          #截止期別
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
 
{<section id="aglq710_g01.main" readonly="Y" >}
PUBLIC FUNCTION aglq710_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7,p_arg8,p_arg9,p_arg10,p_arg11,p_arg12)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.sdate  起始日期 
DEFINE  p_arg3 LIKE type_t.dat         #tm.bdate  截止日期 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.ctype  多本位幣 
DEFINE  p_arg5 LIKE type_t.chr1         #tm.curro  顯示原幣 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.currp  按幣別分頁 
DEFINE  p_arg7 LIKE type_t.chr1         #tm.showv  顯示年初數 
DEFINE  p_arg8 LIKE glaa_t.glaald         #tm.ld  帳套 
DEFINE  p_arg9 LIKE glap_t.glap002         #tm.syear  起始年度 
DEFINE  p_arg10 LIKE glap_t.glap004         #tm.speri  起始期別 
DEFINE  p_arg11 LIKE glap_t.glap002         #tm.eyear  截止年度 
DEFINE  p_arg12 LIKE glap_t.glap004         #tm.eperi  截止期別
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.sdate = p_arg2
   LET tm.bdate = p_arg3
   LET tm.ctype = p_arg4
   LET tm.curro = p_arg5
   LET tm.currp = p_arg6
   LET tm.showv = p_arg7
   LET tm.ld = p_arg8
   LET tm.syear = p_arg9
   LET tm.speri = p_arg10
   LET tm.eyear = p_arg11
   LET tm.eperi = p_arg12
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aglq710_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aglq710_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aglq710_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aglq710_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq710_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq710_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   #160505-00007#5--add--str--lujh
   DEFINE l_glar001_desc       STRING
   DEFINE l_glaa004            LIKE glaa_t.glaa004
   #160505-00007#5--add--end--lujh
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT glar001,NULL,glar009,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,glarent,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160505-00007#5--add--str--lujh
   SELECT glaa004 INTO l_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = tm.ld       
   
   LET l_glar001_desc = "(SELECT glacl004 FROM glacl_t WHERE glaclent = '",g_enterprise,"' AND glacl001 = '",l_glaa004,"' AND glacl002 = glar001 AND glacl003 ='",g_dlang,"')"
   
   LET g_select = " SELECT glar001,",l_glar001_desc,
                  " ,glar009,oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3,oqcd, ",  
                  "  oqcc,qcd,qcc,qcd2,qcc2,qcd3,qcc3,oqjd,oqjc,qjd,qjc,qjd2,qjc2,qjd3,qjc3,oqmd,",   
                  "  oqmc,qmd,qmc,qmd2,qmc2,qmd3,qmc3,osumd,osumc,sumd,sumc,sumd2,sumc2,sumd3,sumc3,'',''" 
   #160505-00007#5--add--end--lujh   
   
   #160505-00007#5--mark--str--lujh
   #LET g_select = " SELECT glar001,'',glar009,oyeard,oyearc,yeard,yearc,yeard2,yearc2,yeard3,yearc3,oqcd,   
   #                        oqcc,qcd,qcc,qcd2,qcc2,qcd3,qcc3,oqjd,oqjc,qjd,qjc,qjd2,qjc2,qjd3,qjc3,oqmd,   
   #                        oqmc,qmd,qmc,qmd2,qmc2,qmd3,qmc3,osumd,osumc,sumd,sumc,sumd2,sumc2,sumd3,sumc3, 
   #                        '',''"
   #160505-00007#5--mark--end--lujh   
   #end add-point
    LET g_from = " FROM glar_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM ",tm.wc
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE 1=1 " 
   #end add-point
    LET g_order = " ORDER BY glar001,glar009"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY glar009,glar001"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glar_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE aglq710_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aglq710_g01_curs CURSOR FOR aglq710_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq710_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq710_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr200, 
   glar009 LIKE glar_t.glar009, 
   oyeard LIKE type_t.num20_6, 
   oyearc LIKE type_t.num20_6, 
   yeard LIKE type_t.num20_6, 
   yearc LIKE type_t.num20_6, 
   yeard2 LIKE type_t.num20_6, 
   yearc2 LIKE type_t.num20_6, 
   yeard3 LIKE type_t.num20_6, 
   yearc3 LIKE type_t.num20_6, 
   oqcd LIKE type_t.num20_6, 
   oqcc LIKE type_t.num20_6, 
   qcd LIKE type_t.num20_6, 
   qcc LIKE type_t.num20_6, 
   qcd2 LIKE type_t.num20_6, 
   qcc2 LIKE type_t.num20_6, 
   qcd3 LIKE type_t.num20_6, 
   qcc3 LIKE type_t.num20_6, 
   oqjd LIKE type_t.num20_6, 
   oqjc LIKE type_t.num20_6, 
   qjd LIKE type_t.num20_6, 
   qjc LIKE type_t.num20_6, 
   qjd2 LIKE type_t.num20_6, 
   qjc2 LIKE type_t.num20_6, 
   qjd3 LIKE type_t.num20_6, 
   qjc3 LIKE type_t.num20_6, 
   oqmd LIKE type_t.num20_6, 
   oqmc LIKE type_t.num20_6, 
   qmd LIKE type_t.num20_6, 
   qmc LIKE type_t.num20_6, 
   qmd2 LIKE type_t.num20_6, 
   qmc2 LIKE type_t.num20_6, 
   qmd3 LIKE type_t.num20_6, 
   qmc3 LIKE type_t.num20_6, 
   osumd LIKE type_t.num20_6, 
   osumc LIKE type_t.num20_6, 
   sumd LIKE type_t.num20_6, 
   sumc LIKE type_t.num20_6, 
   sumd2 LIKE type_t.num20_6, 
   sumc2 LIKE type_t.num20_6, 
   sumd3 LIKE type_t.num20_6, 
   sumc3 LIKE type_t.num20_6, 
   glarent LIKE glar_t.glarent, 
   l_groupby LIKE type_t.chr10
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
    FOREACH aglq710_g01_curs INTO sr_s.*
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
       LET sr_s.glarent=g_enterprise
       IF tm.currp='Y' THEN
          LET sr_s.l_groupby=sr_s.glar009
       ELSE
          LET sr_s.l_groupby=sr_s.glarent
       END IF
       
       #160505-00007#5--mark--str--lujh
       #SELECT glaa004 INTO l_glaa004
       #  FROM glaa_t
       # WHERE glaaent=g_enterprise
       #   AND glaald=tm.ld       
       #SELECT glacl004 INTO sr_s.glar001_desc
       #  FROM glacl_t 
       # WHERE glaclent=g_enterprise
       #   AND glacl001=l_glaa004
       #   AND glacl002=sr_s.glar001
       #   AND glacl003=g_dlang
       #160505-00007#5--mark--end--lujh
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].glar001 = sr_s.glar001
       LET sr[l_cnt].glar001_desc = sr_s.glar001_desc
       LET sr[l_cnt].glar009 = sr_s.glar009
       LET sr[l_cnt].oyeard = sr_s.oyeard
       LET sr[l_cnt].oyearc = sr_s.oyearc
       LET sr[l_cnt].yeard = sr_s.yeard
       LET sr[l_cnt].yearc = sr_s.yearc
       LET sr[l_cnt].yeard2 = sr_s.yeard2
       LET sr[l_cnt].yearc2 = sr_s.yearc2
       LET sr[l_cnt].yeard3 = sr_s.yeard3
       LET sr[l_cnt].yearc3 = sr_s.yearc3
       LET sr[l_cnt].oqcd = sr_s.oqcd
       LET sr[l_cnt].oqcc = sr_s.oqcc
       LET sr[l_cnt].qcd = sr_s.qcd
       LET sr[l_cnt].qcc = sr_s.qcc
       LET sr[l_cnt].qcd2 = sr_s.qcd2
       LET sr[l_cnt].qcc2 = sr_s.qcc2
       LET sr[l_cnt].qcd3 = sr_s.qcd3
       LET sr[l_cnt].qcc3 = sr_s.qcc3
       LET sr[l_cnt].oqjd = sr_s.oqjd
       LET sr[l_cnt].oqjc = sr_s.oqjc
       LET sr[l_cnt].qjd = sr_s.qjd
       LET sr[l_cnt].qjc = sr_s.qjc
       LET sr[l_cnt].qjd2 = sr_s.qjd2
       LET sr[l_cnt].qjc2 = sr_s.qjc2
       LET sr[l_cnt].qjd3 = sr_s.qjd3
       LET sr[l_cnt].qjc3 = sr_s.qjc3
       LET sr[l_cnt].oqmd = sr_s.oqmd
       LET sr[l_cnt].oqmc = sr_s.oqmc
       LET sr[l_cnt].qmd = sr_s.qmd
       LET sr[l_cnt].qmc = sr_s.qmc
       LET sr[l_cnt].qmd2 = sr_s.qmd2
       LET sr[l_cnt].qmc2 = sr_s.qmc2
       LET sr[l_cnt].qmd3 = sr_s.qmd3
       LET sr[l_cnt].qmc3 = sr_s.qmc3
       LET sr[l_cnt].osumd = sr_s.osumd
       LET sr[l_cnt].osumc = sr_s.osumc
       LET sr[l_cnt].sumd = sr_s.sumd
       LET sr[l_cnt].sumc = sr_s.sumc
       LET sr[l_cnt].sumd2 = sr_s.sumd2
       LET sr[l_cnt].sumc2 = sr_s.sumc2
       LET sr[l_cnt].sumd3 = sr_s.sumd3
       LET sr[l_cnt].sumc3 = sr_s.sumc3
       LET sr[l_cnt].glarent = sr_s.glarent
       LET sr[l_cnt].l_groupby = sr_s.l_groupby
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq710_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq710_g01_rep_data()
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
          START REPORT aglq710_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aglq710_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aglq710_g01_rep
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
 
{<section id="aglq710_g01.rep" readonly="Y" >}
PRIVATE REPORT aglq710_g01_rep(sr1)
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
DEFINE l_format1         LIKE type_t.chr30
DEFINE l_format2         LIKE type_t.chr30
DEFINE l_format3         LIKE type_t.chr30
DEFINE l_format4         LIKE type_t.chr30
DEFINE l_glar009         LIKE glar_t.glar009 
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
 
    #end add-point
    ORDER EXTERNAL BY sr1.l_groupby
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
        BEFORE GROUP OF sr1.l_groupby
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            IF tm.currp='Y' THEN
               LET l_glar009=sr1.glar009
            END IF
            PRINTX l_glar009      
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_groupby
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'glarent=' ,sr1.glarent,'{+}glar001=' ,sr1.glar001         
            CALL cl_gr_init_apr(sr1.l_groupby)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_groupby.before name="rep.b_group.l_groupby.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.glarent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_groupby CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq710_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aglq710_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aglq710_g01_subrep01
           DECLARE aglq710_g01_repcur01 CURSOR FROM g_sql
           FOREACH aglq710_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq710_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aglq710_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aglq710_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_groupby.after name="rep.b_group.l_groupby.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
            #---報表金額顯示格式。
            CALL aglq710_g01_getnum(tm.ld,sr1.glar009) RETURNING l_format1,l_format2,l_format3,l_format4
        
            PRINTX l_format1
            PRINTX l_format2
            PRINTX l_format3
            PRINTX l_format4

          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.glarent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_groupby CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq710_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aglq710_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aglq710_g01_subrep02
           DECLARE aglq710_g01_repcur02 CURSOR FROM g_sql
           FOREACH aglq710_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq710_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aglq710_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aglq710_g01_subrep02
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
                sr1.glarent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq710_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aglq710_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aglq710_g01_subrep03
           DECLARE aglq710_g01_repcur03 CURSOR FROM g_sql
           FOREACH aglq710_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq710_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aglq710_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aglq710_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_groupby
 
           #add-point:rep.a_group.l_groupby.before name="rep.a_group.l_groupby.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.glarent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_groupby CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aglq710_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aglq710_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aglq710_g01_subrep04
           DECLARE aglq710_g01_repcur04 CURSOR FROM g_sql
           FOREACH aglq710_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aglq710_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aglq710_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aglq710_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_groupby.after name="rep.a_group.l_groupby.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aglq710_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aglq710_g01_subrep01(sr2)
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
PRIVATE REPORT aglq710_g01_subrep02(sr2)
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
PRIVATE REPORT aglq710_g01_subrep03(sr2)
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
PRIVATE REPORT aglq710_g01_subrep04(sr2)
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
 
{<section id="aglq710_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...:金額數值的報表顯示樣式
# Memo...........:
# Usage..........: CALL aglq710_g01_getnum(p_ld,p_glar009)
#                  RETURNING r_format1,r_format2,r_format3,r_format4
# Input parameter: p_ld        帳套
# ...............: p_glar009   原幣
# Return code....: r_format1   本幣一金額報表顯示樣式
# ...............: r_format2   本幣二金額報表顯示樣式
# ...............: r_format3   本幣三金額報表顯示樣式
# ...............: r_format4   原幣金額報表顯示樣式
# Date & Author..: 20150123 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq710_g01_getnum(p_ld,p_glar009)
DEFINE p_ld           LIKE glaa_t.glaald
DEFINE p_glar009      LIKE glar_t.glar009
DEFINE r_format1      LIKE type_t.chr30
DEFINE r_format2      LIKE type_t.chr30
DEFINE r_format3      LIKE type_t.chr30
DEFINE r_format4      LIKE type_t.chr30
DEFINE l_xrcald       LIKE xrca_t.xrcald
DEFINE l_glaa001      LIKE glaa_t.glaa001
DEFINE l_glaa026      LIKE glaa_t.glaa026
DEFINE l_glaa016      LIKE glaa_t.glaa016
DEFINE l_glaa020      LIKE glaa_t.glaa020
DEFINE l_ooaj004      LIKE ooaj_t.ooaj004
DEFINE l_i            LIKE type_t.num5
DEFINE l_str          LIKE type_t.chr30


   #幣別參照表號
   LET l_glaa026=''
   LET l_glaa001=''
   LET l_glaa016=''
   LET l_glaa020=''
   SELECT glaa001,glaa026,glaa016,glaa020 INTO l_glaa001,l_glaa026,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent=g_enterprise
      AND glaald=p_ld
 
   LET r_format1="--,---,---,---,--&" #本幣一金額報表顯示樣式
   LET r_format2="--,---,---,---,--&" #本幣二金額報表顯示樣式
   LET r_format3="--,---,---,---,--&" #本幣三金額報表顯示樣式
   LET r_format4="--,---,---,---,--&" #原幣金額報表顯示樣式 

   #本幣一金額--小數位數
   LET l_ooaj004='' #金額小數位數
   SELECT ooaj004 INTO l_ooaj004
     FROM ooaj_t
    WHERE ooajent=g_enterprise
      AND ooaj001=l_glaa026
      AND ooaj002=l_glaa001
      AND ooajstus='Y' 
              
   IF NOT cl_null(l_ooaj004) THEN
      LET l_str=""
      FOR l_i=1 TO l_ooaj004  
          LET l_str=l_str,"&"
      END FOR
      IF NOT cl_null(l_str) THEN
         LET r_format1=r_format1,".",l_str
      END IF
   END IF
 
   #本幣二金額--小數位數
   LET l_ooaj004='' #金額小數位數
   SELECT ooaj004 INTO l_ooaj004
     FROM ooaj_t
    WHERE ooajent=g_enterprise
      AND ooaj001=l_glaa026
      AND ooaj002=l_glaa016
      AND ooajstus='Y' 
              
   IF NOT cl_null(l_ooaj004) THEN
      LET l_str=""
      FOR l_i=1 TO l_ooaj004  
          LET l_str=l_str,"&"
      END FOR
      IF NOT cl_null(l_str) THEN
         LET r_format2=r_format2,".",l_str
      END IF
   END IF

   #本幣三金額--小數位數
   LET l_ooaj004='' #金額小數位數
   SELECT ooaj004 INTO l_ooaj004
     FROM ooaj_t
    WHERE ooajent=g_enterprise
      AND ooaj001=l_glaa026
      AND ooaj002=l_glaa020
      AND ooajstus='Y' 
              
   IF NOT cl_null(l_ooaj004) THEN
      LET l_str=""
      FOR l_i=1 TO l_ooaj004  
          LET l_str=l_str,"&"
      END FOR
      IF NOT cl_null(l_str) THEN
         LET r_format3=r_format3,".",l_str
      END IF
   END IF

   #本幣三金額--小數位數
   LET l_ooaj004='' #金額小數位數
   SELECT ooaj004 INTO l_ooaj004
     FROM ooaj_t
    WHERE ooajent=g_enterprise
      AND ooaj001=l_glaa026
      AND ooaj002=p_glar009
      AND ooajstus='Y' 
              
   IF NOT cl_null(l_ooaj004) THEN
      LET l_str=""
      FOR l_i=1 TO l_ooaj004  
          LET l_str=l_str,"&"
      END FOR
      IF NOT cl_null(l_str) THEN
         LET r_format4=r_format4,".",l_str
      END IF
   END IF

   RETURN r_format1,r_format2,r_format3,r_format4
END FUNCTION

 
{</section>}
 
{<section id="aglq710_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 