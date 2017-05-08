#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr510_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-11-04 16:52:21), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: axrr510_g01
#+ Description: ...
#+ Creator....: 03080(2016-04-29 14:30:43)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="axrr510_g01.global" readonly="Y" >}
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
   xrga001 LIKE xrga_t.xrga001, 
   xrga002 LIKE xrga_t.xrga002, 
   xrga003 LIKE xrga_t.xrga003, 
   xrga004 LIKE xrga_t.xrga004, 
   xrga005 LIKE xrga_t.xrga005, 
   xrga006 LIKE xrga_t.xrga006, 
   xrga007 LIKE xrga_t.xrga007, 
   xrga008 LIKE xrga_t.xrga008, 
   xrga009 LIKE xrga_t.xrga009, 
   xrga010 LIKE xrga_t.xrga010, 
   xrga011 LIKE xrga_t.xrga011, 
   xrga012 LIKE xrga_t.xrga012, 
   xrga013 LIKE xrga_t.xrga013, 
   xrga014 LIKE xrga_t.xrga014, 
   xrga015 LIKE xrga_t.xrga015, 
   xrga016 LIKE xrga_t.xrga016, 
   xrga017 LIKE xrga_t.xrga017, 
   xrga018 LIKE xrga_t.xrga018, 
   xrga019 LIKE xrga_t.xrga019, 
   xrga020 LIKE xrga_t.xrga020, 
   xrga021 LIKE xrga_t.xrga021, 
   xrga022 LIKE xrga_t.xrga022, 
   xrga023 LIKE xrga_t.xrga023, 
   xrga024 LIKE xrga_t.xrga024, 
   xrga025 LIKE xrga_t.xrga025, 
   xrga100 LIKE xrga_t.xrga100, 
   xrga101 LIKE xrga_t.xrga101, 
   xrga103 LIKE xrga_t.xrga103, 
   xrga104 LIKE xrga_t.xrga104, 
   xrga113 LIKE xrga_t.xrga113, 
   xrgacnfdt LIKE xrga_t.xrgacnfdt, 
   xrgacnfid LIKE xrga_t.xrgacnfid, 
   xrgacomp LIKE xrga_t.xrgacomp, 
   xrgacrtdp LIKE xrga_t.xrgacrtdp, 
   xrgacrtdt DATETIME YEAR TO SECOND, 
   xrgacrtid LIKE xrga_t.xrgacrtid, 
   xrgadocdt LIKE xrga_t.xrgadocdt, 
   xrgadocno LIKE xrga_t.xrgadocno, 
   xrgaent LIKE xrga_t.xrgaent, 
   xrgamoddt DATETIME YEAR TO SECOND, 
   xrgamodid LIKE xrga_t.xrgamodid, 
   xrgaowndp LIKE xrga_t.xrgaowndp, 
   xrgaownid LIKE xrga_t.xrgaownid, 
   xrgastus LIKE xrga_t.xrgastus, 
   l_xrga005_desc LIKE type_t.chr80, 
   l_xrga004_desc LIKE type_t.chr100, 
   l_xrga006_desc LIKE type_t.chr100, 
   l_xrga007_desc LIKE type_t.chr100, 
   l_xrga008_desc LIKE type_t.chr100, 
   l_xrga009_desc LIKE type_t.chr100, 
   l_xrga022_desc LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where condition
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
TYPE sr3_r RECORD #子報表01
   apgcdocno        LIKE apgc_t.apgcdocno,
   apgcseq          LIKE apgc_t.apgcseq,
   apgc001          LIKE apgc_t.apgc001,
   apgc001_desc     LIKE type_t.chr100,
   apgc006          LIKE apgc_t.apgc006, #稅別
   apgc006_desc     LIKE apgc_t.apgc101, #稅
   apgc009          LIKE apgc_t.apgc009, #發票號碼
   apgc014          LIKE apgc_t.apgc014, #付款帳戶
   apgc100          LIKE apgc_t.apgc100, 
   apgc101          LIKE apgc_t.apgc101,
   apgc103          LIKE apgc_t.apgc103, #原幣未稅金額
   apgc104          LIKE apgc_t.apgc104, #稅額
   apgc105          LIKE apgc_t.apgc105, #原幣含稅金額
   apgc113          LIKE apgc_t.apgc113, #本幣未稅金額
   apgc114          LIKE apgc_t.apgc114, #本幣稅額
   apgc115          LIKE apgc_t.apgc115 #本幣含稅金額
        END RECORD
TYPE sr4_r RECORD #子報表02
   xrgbcomp         LIKE xrgb_t.xrgbcomp,
   xrgbdocno        LIKE xrgb_t.xrgbdocno,
   xrgbseq          LIKE xrgb_t.xrgbseq,
   xrgb001          LIKE xrgb_t.xrgb001,
   xrgb002          LIKE xrgb_t.xrgb002,
   xrgb003          LIKE xrgb_t.xrgb003,
   xrgb004          LIKE xrgb_t.xrgb004,
   xrgb008          LIKE xrgb_t.xrgb008,
   xrgb009          LIKE xrgb_t.xrgb009,
   xrgb105          LIKE xrgb_t.xrgb105
        END RECORD
#end add-point
 
{</section>}
 
{<section id="axrr510_g01.main" readonly="Y" >}
PUBLIC FUNCTION axrr510_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "axrr510_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axrr510_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axrr510_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axrr510_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrr510_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr510_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xrga001,xrga002,xrga003,xrga004,xrga005,xrga006,xrga007,xrga008,xrga009,xrga010, 
       xrga011,xrga012,xrga013,xrga014,xrga015,xrga016,xrga017,xrga018,xrga019,xrga020,xrga021,xrga022, 
       xrga023,xrga024,xrga025,xrga100,xrga101,xrga103,xrga104,xrga113,xrgacnfdt,xrgacnfid,xrgacomp, 
       xrgacrtdp,xrgacrtdt,xrgacrtid,xrgadocdt,xrgadocno,xrgaent,xrgamoddt,xrgamodid,xrgaowndp,xrgaownid, 
       xrgastus,'','','','','','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT xrga001,xrga002,xrga003,xrga004,xrga005,xrga006,xrga007,xrga008,xrga009,xrga010, 
       xrga011,xrga012,xrga013,xrga014,xrga015,xrga016,xrga017,xrga018,xrga019,xrga020,xrga021,xrga022, 
       xrga023,xrga024,xrga025,xrga100,xrga101,xrga103,xrga104,xrga113,xrgacnfdt,xrgacnfid,xrgacomp, 
       xrgacrtdp,xrgacrtdt,xrgacrtid,xrgadocdt,xrgadocno,xrgaent,xrgamoddt,xrgamodid,xrgaowndp,xrgaownid, 
       xrgastus,",
       " (SELECT ta05.ooag011 FROM ooag_t ta05 WHERE ta05.ooagent = xrgaent AND ta05.ooag001 = xrga005), ",
       " (SELECT ta04.pmaal004 FROM pmaal_t ta04 WHERE ta04.pmaalent = xrgaent AND ta04.pmaal001 = xrga004 AND ta04.pmaal002 = '",g_dlang,"'),",
       " (SELECT ta06.gzcbl004 FROM gzcbl_t ta06 WHERE ta06.gzcbl001 = '8517' AND ta06.gzcbl002 = xrga006 AND ta06.gzcbl003 ='",g_dlang,"' ),",
       " (SELECT ta07.gzcbl004 FROM gzcbl_t ta07 WHERE ta07.gzcbl001 = '8515' AND ta07.gzcbl002 = xrga007 AND ta07.gzcbl003 ='",g_dlang,"' ),",
       " (SELECT ta08.nmabl003 FROM nmabl_t ta08 WHERE ta08.nmablent = xrgaent AND ta08.nmabl001 = xrga008 AND ta08.nmabl002 = '",g_dlang,"'),",
       " (SELECT ta09.nmabl003 FROM nmabl_t ta09 WHERE ta09.nmablent = xrgaent AND ta09.nmabl001 = xrga009 AND ta09.nmabl002 = '",g_dlang,"'),",
       " (SELECT ta22.nmabl003 FROM nmabl_t ta22 WHERE ta22.nmablent = xrgaent AND ta22.nmabl001 = xrga022 AND ta22.nmabl002 = '",g_dlang,"')"

       
   #end add-point
    LET g_from = " FROM xrga_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY xrgadocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xrga_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axrr510_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axrr510_g01_curs CURSOR FOR axrr510_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrr510_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrr510_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xrga001 LIKE xrga_t.xrga001, 
   xrga002 LIKE xrga_t.xrga002, 
   xrga003 LIKE xrga_t.xrga003, 
   xrga004 LIKE xrga_t.xrga004, 
   xrga005 LIKE xrga_t.xrga005, 
   xrga006 LIKE xrga_t.xrga006, 
   xrga007 LIKE xrga_t.xrga007, 
   xrga008 LIKE xrga_t.xrga008, 
   xrga009 LIKE xrga_t.xrga009, 
   xrga010 LIKE xrga_t.xrga010, 
   xrga011 LIKE xrga_t.xrga011, 
   xrga012 LIKE xrga_t.xrga012, 
   xrga013 LIKE xrga_t.xrga013, 
   xrga014 LIKE xrga_t.xrga014, 
   xrga015 LIKE xrga_t.xrga015, 
   xrga016 LIKE xrga_t.xrga016, 
   xrga017 LIKE xrga_t.xrga017, 
   xrga018 LIKE xrga_t.xrga018, 
   xrga019 LIKE xrga_t.xrga019, 
   xrga020 LIKE xrga_t.xrga020, 
   xrga021 LIKE xrga_t.xrga021, 
   xrga022 LIKE xrga_t.xrga022, 
   xrga023 LIKE xrga_t.xrga023, 
   xrga024 LIKE xrga_t.xrga024, 
   xrga025 LIKE xrga_t.xrga025, 
   xrga100 LIKE xrga_t.xrga100, 
   xrga101 LIKE xrga_t.xrga101, 
   xrga103 LIKE xrga_t.xrga103, 
   xrga104 LIKE xrga_t.xrga104, 
   xrga113 LIKE xrga_t.xrga113, 
   xrgacnfdt LIKE xrga_t.xrgacnfdt, 
   xrgacnfid LIKE xrga_t.xrgacnfid, 
   xrgacomp LIKE xrga_t.xrgacomp, 
   xrgacrtdp LIKE xrga_t.xrgacrtdp, 
   xrgacrtdt DATETIME YEAR TO SECOND, 
   xrgacrtid LIKE xrga_t.xrgacrtid, 
   xrgadocdt LIKE xrga_t.xrgadocdt, 
   xrgadocno LIKE xrga_t.xrgadocno, 
   xrgaent LIKE xrga_t.xrgaent, 
   xrgamoddt DATETIME YEAR TO SECOND, 
   xrgamodid LIKE xrga_t.xrgamodid, 
   xrgaowndp LIKE xrga_t.xrgaowndp, 
   xrgaownid LIKE xrga_t.xrgaownid, 
   xrgastus LIKE xrga_t.xrgastus, 
   l_xrga005_desc LIKE type_t.chr80, 
   l_xrga004_desc LIKE type_t.chr100, 
   l_xrga006_desc LIKE type_t.chr100, 
   l_xrga007_desc LIKE type_t.chr100, 
   l_xrga008_desc LIKE type_t.chr100, 
   l_xrga009_desc LIKE type_t.chr100, 
   l_xrga022_desc LIKE type_t.chr100
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
    FOREACH axrr510_g01_curs INTO sr_s.*
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
       LET sr[l_cnt].xrga001 = sr_s.xrga001
       LET sr[l_cnt].xrga002 = sr_s.xrga002
       LET sr[l_cnt].xrga003 = sr_s.xrga003
       LET sr[l_cnt].xrga004 = sr_s.xrga004
       LET sr[l_cnt].xrga005 = sr_s.xrga005
       LET sr[l_cnt].xrga006 = sr_s.xrga006
       LET sr[l_cnt].xrga007 = sr_s.xrga007
       LET sr[l_cnt].xrga008 = sr_s.xrga008
       LET sr[l_cnt].xrga009 = sr_s.xrga009
       LET sr[l_cnt].xrga010 = sr_s.xrga010
       LET sr[l_cnt].xrga011 = sr_s.xrga011
       LET sr[l_cnt].xrga012 = sr_s.xrga012
       LET sr[l_cnt].xrga013 = sr_s.xrga013
       LET sr[l_cnt].xrga014 = sr_s.xrga014
       LET sr[l_cnt].xrga015 = sr_s.xrga015
       LET sr[l_cnt].xrga016 = sr_s.xrga016
       LET sr[l_cnt].xrga017 = sr_s.xrga017
       LET sr[l_cnt].xrga018 = sr_s.xrga018
       LET sr[l_cnt].xrga019 = sr_s.xrga019
       LET sr[l_cnt].xrga020 = sr_s.xrga020
       LET sr[l_cnt].xrga021 = sr_s.xrga021
       LET sr[l_cnt].xrga022 = sr_s.xrga022
       LET sr[l_cnt].xrga023 = sr_s.xrga023
       LET sr[l_cnt].xrga024 = sr_s.xrga024
       LET sr[l_cnt].xrga025 = sr_s.xrga025
       LET sr[l_cnt].xrga100 = sr_s.xrga100
       LET sr[l_cnt].xrga101 = sr_s.xrga101
       LET sr[l_cnt].xrga103 = sr_s.xrga103
       LET sr[l_cnt].xrga104 = sr_s.xrga104
       LET sr[l_cnt].xrga113 = sr_s.xrga113
       LET sr[l_cnt].xrgacnfdt = sr_s.xrgacnfdt
       LET sr[l_cnt].xrgacnfid = sr_s.xrgacnfid
       LET sr[l_cnt].xrgacomp = sr_s.xrgacomp
       LET sr[l_cnt].xrgacrtdp = sr_s.xrgacrtdp
       LET sr[l_cnt].xrgacrtdt = sr_s.xrgacrtdt
       LET sr[l_cnt].xrgacrtid = sr_s.xrgacrtid
       LET sr[l_cnt].xrgadocdt = sr_s.xrgadocdt
       LET sr[l_cnt].xrgadocno = sr_s.xrgadocno
       LET sr[l_cnt].xrgaent = sr_s.xrgaent
       LET sr[l_cnt].xrgamoddt = sr_s.xrgamoddt
       LET sr[l_cnt].xrgamodid = sr_s.xrgamodid
       LET sr[l_cnt].xrgaowndp = sr_s.xrgaowndp
       LET sr[l_cnt].xrgaownid = sr_s.xrgaownid
       LET sr[l_cnt].xrgastus = sr_s.xrgastus
       LET sr[l_cnt].l_xrga005_desc = sr_s.l_xrga005_desc
       LET sr[l_cnt].l_xrga004_desc = sr_s.l_xrga004_desc
       LET sr[l_cnt].l_xrga006_desc = sr_s.l_xrga006_desc
       LET sr[l_cnt].l_xrga007_desc = sr_s.l_xrga007_desc
       LET sr[l_cnt].l_xrga008_desc = sr_s.l_xrga008_desc
       LET sr[l_cnt].l_xrga009_desc = sr_s.l_xrga009_desc
       LET sr[l_cnt].l_xrga022_desc = sr_s.l_xrga022_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrr510_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrr510_g01_rep_data()
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
          START REPORT axrr510_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axrr510_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axrr510_g01_rep
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
 
{<section id="axrr510_g01.rep" readonly="Y" >}
PRIVATE REPORT axrr510_g01_rep(sr1)
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
DEFINE sr3       sr3_r
DEFINE l_subrep05_show LIKE type_t.chr1
DEFINE l_oodb004    LIKE oodb_t.oodb004
DEFINE l_oodb011    LIKE oodb_t.oodb011
DEFINE l_apcb105    LIKE apcb_t.apcb105
DEFINE l_apca013    LIKE apca_t.apca013
DEFINE l_apca012    LIKE apca_t.apca012
DEFINE sr4       sr4_r
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.xrgadocno
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
        BEFORE GROUP OF sr1.xrgadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xrgadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xrgaent=' ,sr1.xrgaent,'{+}xrgacomp=' ,sr1.xrgacomp,'{+}xrgadocno=' ,sr1.xrgadocno         
            CALL cl_gr_init_apr(sr1.xrgadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xrgadocno.before name="rep.b_group.xrgadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xrgaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrgadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr510_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axrr510_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axrr510_g01_subrep01
           DECLARE axrr510_g01_repcur01 CURSOR FROM g_sql
           FOREACH axrr510_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr510_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axrr510_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axrr510_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xrgadocno.after name="rep.b_group.xrgadocno.after"
           
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
                sr1.xrgaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrgadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr510_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axrr510_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axrr510_g01_subrep02
           DECLARE axrr510_g01_repcur02 CURSOR FROM g_sql
           FOREACH axrr510_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr510_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axrr510_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axrr510_g01_subrep02
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
                sr1.xrgaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr510_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axrr510_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axrr510_g01_subrep03
           DECLARE axrr510_g01_repcur03 CURSOR FROM g_sql
           FOREACH axrr510_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr510_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axrr510_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axrr510_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xrgadocno
 
           #add-point:rep.a_group.xrgadocno.before name="rep.a_group.xrgadocno.before"
           #subrep 訂單
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET g_sql = " SELECT xrgbcomp,xrgbdocno,xrgbseq,xrgb001,xrgb002,xrgb003,xrgb004,xrgb008,xrgb009,xrgb105 ",
                       "   FROM xrgb_t WHERE xrgbent = '",g_enterprise,"' ",                       
                       "    AND xrgbdocno = '",sr1.xrgadocno,"'           ",
                       "    AND xrgbcomp  = '",sr1.xrgacomp,"'            ",
                       "   ORDER BY xrgbseq "
           LET l_sub_sql = "SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE axrr510_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE axrr510_g01_repcur06_cnt_pre INTO l_cnt

           START REPORT axrr510_g01_subrep06
           DECLARE axrr510_g01_repcur06 CURSOR FROM g_sql
           FOREACH axrr510_g01_repcur06 INTO sr4.*
              OUTPUT TO REPORT axrr510_g01_subrep06(sr4.*)
           END FOREACH
           FINISH REPORT axrr510_g01_subrep06
           
           #subrep 費用資訊
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show = 'N'
           LET g_sql = " SELECT apgcdocno,apgcseq,apgc001,",
                       "        (SELECT tc01.oocql004 FROM oocql_t tc01 WHERE tc01.oocqlent = apgcent AND tc01.oocql001 = '3117' AND tc01.oocql002 = apgc001 AND tc01.oocql003 = '",g_dlang,"'),",
                       "        apgc006,",
                       "        (SELECT tc06.oodb006 FROM oodb_t tc06,ooef_t tc062 WHERE tc06.oodbent = apgcent AND tc06.oodb001 = tc062.ooef019 AND tc06.oodbent = tc062.ooefent AND tc062.ooef001 = apgccomp AND tc06.oodb002 = apgc006),",
                       "        apgc009,                        ",
                       "        apgc014,apgc100,apgc101,apgc103,apgc104,  ",
                       "        apgc105,apgc113,apgc114,apgc115           ",
                       "   FROM apgc_t WHERE apgcent = '",g_enterprise,"' ",                       
                       "    AND apgcdocno = '",sr1.xrgadocno,"'           ",
                       "    AND apgccomp  = '",sr1.xrgacomp,"'            ",
                       "    AND apgc900 = '0' ",
                       " ORDER BY apgcseq"
           
           LET l_sub_sql = "SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE axrr510_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE axrr510_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep05_show ="Y"
           END IF
           START REPORT axrr510_g01_subrep05
           DECLARE axrr510_g01_repcur05 CURSOR FROM g_sql
           FOREACH axrr510_g01_repcur05 INTO sr3.*
           
#              CALL s_desc_get_acc_desc('3117',sr3.apgc001) RETURNING sr3.apgc001_desc
#              CALL s_tax_chk(sr1.xrgacomp,sr3.apgc006)
#                     RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
#              LET sr3.apgc006_desc = l_apca012
              OUTPUT TO REPORT axrr510_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT axrr510_g01_subrep05
           PRINTX l_subrep05_show
           

           #PRINTX l_subrep05_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xrgaent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrgadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr510_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axrr510_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axrr510_g01_subrep04
           DECLARE axrr510_g01_repcur04 CURSOR FROM g_sql
           FOREACH axrr510_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr510_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axrr510_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axrr510_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xrgadocno.after name="rep.a_group.xrgadocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axrr510_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axrr510_g01_subrep01(sr2)
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
PRIVATE REPORT axrr510_g01_subrep02(sr2)
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
PRIVATE REPORT axrr510_g01_subrep03(sr2)
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
PRIVATE REPORT axrr510_g01_subrep04(sr2)
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
 
{<section id="axrr510_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="axrr510_g01.other_report" readonly="Y" >}

PRIVATE REPORT axrr510_g01_subrep05(sr3)
DEFINE sr3 sr3_r
DEFINE l_apgc103_sum  LIKE apgc_t.apgc103
DEFINE l_apgc104_sum  LIKE apgc_t.apgc104
DEFINE l_apgc105_sum  LIKE apgc_t.apgc105
DEFINE l_apgc113_sum  LIKE apgc_t.apgc113
DEFINE l_apgc114_sum  LIKE apgc_t.apgc114
DEFINE l_apgc115_sum  LIKE apgc_t.apgc115

 ORDER EXTERNAL BY sr3.apgcdocno
   FORMAT

      ON EVERY ROW
         PRINTX sr3.*
         PRINTX g_grNumFmt.*

      AFTER GROUP OF sr3.apgcdocno
         LET l_apgc103_sum = GROUP SUM(sr3.apgc103)
         LET l_apgc104_sum = GROUP SUM(sr3.apgc104)
         LET l_apgc105_sum = GROUP SUM(sr3.apgc105)
         LET l_apgc113_sum = GROUP SUM(sr3.apgc113)
         LET l_apgc114_sum = GROUP SUM(sr3.apgc114)
         LET l_apgc115_sum = GROUP SUM(sr3.apgc115)         
         PRINTX l_apgc103_sum,l_apgc104_sum,l_apgc105_sum,
                l_apgc113_sum,l_apgc114_sum,l_apgc115_sum
END REPORT

PRIVATE REPORT axrr510_g01_subrep06(sr4)
   DEFINE sr4 sr4_r
   DEFINE l_xrgb105_sum  LIKE xrgb_t.xrgb105
   ORDER EXTERNAL BY sr4.xrgbdocno
   
   FORMAT

      ON EVERY ROW
         PRINTX sr4.*
         PRINTX g_grNumFmt.*
         
      AFTER GROUP OF sr4.xrgbdocno
         LET l_xrgb105_sum = GROUP SUM(sr4.xrgb105)
         PRINTX l_xrgb105_sum
END REPORT

 
{</section>}
 
