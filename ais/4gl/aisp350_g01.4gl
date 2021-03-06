#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp350_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-09-09 11:45:56), PR版次:0003(2016-10-19 16:48:31)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aisp350_g01
#+ Description: ...
#+ Creator....: 06821(2016-03-01 17:55:03)
#+ Modifier...: 08171 -SD/PR- 08171
 
{</section>}
 
{<section id="aisp350_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160902-00040#1  2016/09/09  By 08171 一張對帳單拆分四張列印,每頁右側將說明改用縱向列印呈現
#160328                               SA補規格,合計改為"當頁顯示當頁合計"
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
   isahseq LIKE isah_t.isahseq, 
   isafcomp LIKE isaf_t.isafcomp, 
   isafsite LIKE isaf_t.isafsite, 
   isaf027 LIKE isaf_t.isaf027, 
   isaf028 LIKE isaf_t.isaf028, 
   isaf029 LIKE isaf_t.isaf029, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isafdocno LIKE isaf_t.isafdocno, 
   isahent LIKE isah_t.isahent, 
   isafent LIKE isaf_t.isafent, 
   l_isat005 LIKE type_t.chr500, 
   l_isah009_e LIKE type_t.chr30, 
   isah004 LIKE isah_t.isah004, 
   isah006 LIKE isah_t.isah006, 
   isah101 LIKE isah_t.isah101, 
   isaf021 LIKE isaf_t.isaf021, 
   isaf022 LIKE isaf_t.isaf022, 
   isaf023 LIKE isaf_t.isaf023, 
   isah113 LIKE isah_t.isah113, 
   isah114 LIKE isah_t.isah114, 
   isaf101 LIKE isaf_t.isaf101, 
   l_isah009_s LIKE type_t.chr30, 
   l_day LIKE type_t.chr10, 
   isah009 LIKE isah_t.isah009, 
   l_mon LIKE type_t.chr10, 
   l_year LIKE type_t.chr10, 
   l_isat022 LIKE isat_t.isat022, 
   l_isat027 LIKE isat_t.isat027
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 LIKE type_t.chr1          #print type
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
DEFINE g_glaald  LIKE glaa_t.glaald
DEFINE g_tot_cnt LIKE type_t.num10   #總筆數       
#160902-00040#1--s
DEFINE g_tmp_table  STRING  
TYPE sr3_r RECORD  #第一二三四聯
   isahseq LIKE isah_t.isahseq, 
   isafcomp LIKE isaf_t.isafcomp, 
   isafsite LIKE isaf_t.isafsite, 
   isaf027 LIKE isaf_t.isaf027, 
   isaf028 LIKE isaf_t.isaf028, 
   isaf029 LIKE isaf_t.isaf029, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isafdocno LIKE isaf_t.isafdocno, 
   isahent LIKE isah_t.isahent, 
   isafent LIKE isaf_t.isafent, 
   l_isat005 LIKE type_t.chr500, 
   l_isah009_e LIKE type_t.chr30, 
   isah004 LIKE isah_t.isah004, 
   isah006 LIKE isah_t.isah006, 
   isah101 LIKE isah_t.isah101, 
   isaf021 LIKE isaf_t.isaf021, 
   isaf022 LIKE isaf_t.isaf022, 
   isaf023 LIKE isaf_t.isaf023, 
   isah113 LIKE isah_t.isah113, 
   isah114 LIKE isah_t.isah114, 
   isaf101 LIKE isaf_t.isaf101, 
   l_isah009_s LIKE type_t.chr30, 
   l_day LIKE type_t.chr10, 
   isah009 LIKE isah_t.isah009, 
   l_mon LIKE type_t.chr10, 
   l_year LIKE type_t.chr10, 
   l_isat022 LIKE isat_t.isat022, 
   l_isat027 LIKE isat_t.isat027
END RECORD
#160902-00040#1--e
#end add-point
 
{</section>}
 
{<section id="aisp350_g01.main" readonly="Y" >}
PUBLIC FUNCTION aisp350_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  print type
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CASE tm.a1
      WHEN '1' #套表
         LET g_template ="aisp350_g01"
         
      WHEN '2' #非套表
         LET g_template ="aisp350_g01_01"
   END CASE
   
   CALL aisp350_g01_create_tmp()  #160902-00040#1 add
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aisp350_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aisp350_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aisp350_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aisp350_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp350_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp350_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
   #end add-point
   LET g_select = " SELECT isahseq,isafcomp,isafsite,isaf027,isaf028,isaf029,isafdocdt,isafdocno,isahent, 
       isafent,'','',isah004,isah006,isah101,isaf021,isaf022,isaf023,isah113,isah114,isaf101,'','',isah009, 
       NULL,'','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
 
   #end add-point
    LET g_from = " FROM isaf_t,isah_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = g_where CLIPPED," AND isafent = ",g_enterprise,"  AND isafent = isahent AND isafcomp = isahcomp AND isafdocno = isahdocno"
   #end add-point
    LET g_order = " ORDER BY isafdocno,isafdocdt,isahseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("isaf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aisp350_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aisp350_g01_curs CURSOR FOR aisp350_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisp350_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisp350_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   isahseq LIKE isah_t.isahseq, 
   isafcomp LIKE isaf_t.isafcomp, 
   isafsite LIKE isaf_t.isafsite, 
   isaf027 LIKE isaf_t.isaf027, 
   isaf028 LIKE isaf_t.isaf028, 
   isaf029 LIKE isaf_t.isaf029, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isafdocno LIKE isaf_t.isafdocno, 
   isahent LIKE isah_t.isahent, 
   isafent LIKE isaf_t.isafent, 
   l_isat005 LIKE type_t.chr500, 
   l_isah009_e LIKE type_t.chr30, 
   isah004 LIKE isah_t.isah004, 
   isah006 LIKE isah_t.isah006, 
   isah101 LIKE isah_t.isah101, 
   isaf021 LIKE isaf_t.isaf021, 
   isaf022 LIKE isaf_t.isaf022, 
   isaf023 LIKE isaf_t.isaf023, 
   isah113 LIKE isah_t.isah113, 
   isah114 LIKE isah_t.isah114, 
   isaf101 LIKE isaf_t.isaf101, 
   l_isah009_s LIKE type_t.chr30, 
   l_day LIKE type_t.chr10, 
   isah009 LIKE isah_t.isah009, 
   l_mon LIKE type_t.chr10, 
   l_year LIKE type_t.chr10, 
   l_isat022 LIKE isat_t.isat022, 
   l_isat027 LIKE isat_t.isat027
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_isah009 STRING
   DEFINE l_comp    LIKE glaa_t.glaacomp
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_ooef019 LIKE ooef_t.ooef019
   DEFINE l_isai005 LIKE isai_t.isai005
   DEFINE l_c       LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    DELETE FROM aisp350_g01_tmp  #160902-00040#1
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aisp350_g01_curs INTO sr_s.*
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
       #取原發票日期
       SELECT isat027 INTO sr_s.l_isat027 
         FROM isat_t   
        WHERE isatent = g_enterprise
          AND isatcomp = sr_s.isafcomp
          AND isat004 = sr_s.isah009  
          AND isat014 = '21'              
          AND isat025 = '21'       
       
       #民國年 
       LET sr_s.l_year = (YEAR(sr_s.l_isat027))-1911
       LET sr_s.l_year = sr_s.l_year USING "&&&"
       #月
       LET sr_s.l_mon  = MONTH(sr_s.l_isat027) USING "&&"
       #日
       LET sr_s.l_day  = DAY(sr_s.l_isat027) USING "&&"

       #取得稅區
       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = sr_s.isafcomp AND ooefstus = 'Y'
       #字軌編碼長度
       SELECT isai005 INTO l_isai005 FROM isai_t WHERE isaient = g_enterprise AND isai001 = l_ooef019
       #字軌號碼
       LET l_isah009 = sr_s.isah009
       LET sr_s.l_isah009_s = l_isah009.substring(1,l_isai005)
       LET sr_s.l_isah009_e = l_isah009.substring(l_isai005+1,l_isah009.getLength())

       #帳套
       CALL s_fin_orga_get_comp_ld(sr_s.isafsite) RETURNING g_sub_success,g_errno,l_comp,g_glaald
       #本幣
       SELECT glaa001 INTO l_glaa001 
         FROM glaa_t 
        WHERE glaaent = g_enterprise AND glaald = g_glaald  
       #計算單價
       LET sr_s.isah101 = sr_s.isah101 * sr_s.isaf101
       CALL s_curr_round_ld('1',g_glaald,l_glaa001,sr_s.isah101,2) RETURNING g_sub_success,g_errno,sr_s.isah101
       IF cl_null(sr_s.isah101) THEN
          LET sr_s.isah101 = 0
       END IF

       #目前聯別
       SELECT DISTINCT isat005 INTO sr_s.l_isat005 
         FROM isat_t
        WHERE isatent = g_enterprise
          AND isatcomp = sr_s.isafcomp
          AND isatdocno = sr_s.isafdocno
          AND isat004 = sr_s.isah009
          AND isat014 = '21' 
          AND isat025 = '21' 

       #聯別
       SELECT gzcb005 INTO sr_s.l_isat005   #系統應用碼三
         FROM gzcb_t  
        WHERE gzcb001 = '9734' 
          AND gzcb002 IN ( SELECT DISTINCT isat005 FROM isat_t  #原發票的isat005
                            WHERE isatent = g_enterprise
                              AND isatcomp = sr_s.isafcomp
                              AND isat004 = sr_s.isah009
                              AND isat014 = '11' 
                              AND isat025 <> '12' )  #目前發票的isat005
                              
       #課稅別(取原發票的課稅別)
       SELECT isat022 INTO sr_s.l_isat022  
         FROM isat_t                       
        WHERE isatent = g_enterprise
          AND isatcomp = sr_s.isafcomp
          AND isat004 = sr_s.isah009       #原開立之發票
          AND isat014 = '11'               #狀態開立
          AND isat025 = '11'               #最終狀態開立
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
 
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].isahseq = sr_s.isahseq
       LET sr[l_cnt].isafcomp = sr_s.isafcomp
       LET sr[l_cnt].isafsite = sr_s.isafsite
       LET sr[l_cnt].isaf027 = sr_s.isaf027
       LET sr[l_cnt].isaf028 = sr_s.isaf028
       LET sr[l_cnt].isaf029 = sr_s.isaf029
       LET sr[l_cnt].isafdocdt = sr_s.isafdocdt
       LET sr[l_cnt].isafdocno = sr_s.isafdocno
       LET sr[l_cnt].isahent = sr_s.isahent
       LET sr[l_cnt].isafent = sr_s.isafent
       LET sr[l_cnt].l_isat005 = sr_s.l_isat005
       LET sr[l_cnt].l_isah009_e = sr_s.l_isah009_e
       LET sr[l_cnt].isah004 = sr_s.isah004
       LET sr[l_cnt].isah006 = sr_s.isah006
       LET sr[l_cnt].isah101 = sr_s.isah101
       LET sr[l_cnt].isaf021 = sr_s.isaf021
       LET sr[l_cnt].isaf022 = sr_s.isaf022
       LET sr[l_cnt].isaf023 = sr_s.isaf023
       LET sr[l_cnt].isah113 = sr_s.isah113
       LET sr[l_cnt].isah114 = sr_s.isah114
       LET sr[l_cnt].isaf101 = sr_s.isaf101
       LET sr[l_cnt].l_isah009_s = sr_s.l_isah009_s
       LET sr[l_cnt].l_day = sr_s.l_day
       LET sr[l_cnt].isah009 = sr_s.isah009
       LET sr[l_cnt].l_mon = sr_s.l_mon
       LET sr[l_cnt].l_year = sr_s.l_year
       LET sr[l_cnt].l_isat022 = sr_s.l_isat022
       LET sr[l_cnt].l_isat027 = sr_s.l_isat027
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #160902-00040#1
       INSERT INTO aisp350_g01_tmp
       VALUES(sr_s.isahseq,
              sr_s.isafcomp, 
              sr_s.isafsite, 
              sr_s.isaf027,
              sr_s.isaf028, 
              sr_s.isaf029, 
              sr_s.isafdocdt, 
              sr_s.isafdocno, 
              sr_s.isahent, 
              sr_s.isafent,
              sr_s.l_isat005,
              sr_s.l_isah009_e,
              sr_s.isah004, 
              sr_s.isah006, 
              sr_s.isah101, 
              sr_s.isaf021,
              sr_s.isaf022,
              sr_s.isaf023,      
              sr_s.isah113,
              sr_s.isah114,
              sr_s.isaf101,
              sr_s.l_isah009_s,
              sr_s.l_day,
              sr_s.isah009,
              sr_s.l_mon,
              sr_s.l_year,
              sr_s.l_isat022,
              sr_s.l_isat027
              )
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
 
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp350_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisp350_g01_rep_data()
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
          START REPORT aisp350_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aisp350_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aisp350_g01_rep
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
 
{<section id="aisp350_g01.rep" readonly="Y" >}
PRIVATE REPORT aisp350_g01_rep(sr1)
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
DEFINE sr6            sr3_r               #160902-00040#1 第一聯
DEFINE sr3            sr3_r               #160902-00040#1 第二聯
DEFINE sr4            sr3_r               #160902-00040#1 第三聯
DEFINE sr5            sr3_r               #160902-00040#1 第四聯
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_tot_cnt      LIKE type_t.num10   #總筆數
DEFINE l_sum_isah113  LIKE isah_t.isah113 #總計金額
DEFINE l_sum_isah114  LIKE isah_t.isah114 #總計金額
DEFINE l_isat022_1    LIKE type_t.chr1    #1.應稅/2.零稅/3.免稅
DEFINE l_isat022_2    LIKE type_t.chr1    #1.應稅/2.零稅/3.免稅
DEFINE l_isat022_3    LIKE type_t.chr1    #1.應稅/2.零稅/3.免稅  
DEFINE l_cmd          STRING
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1    #160328
DEFINE l_year_h       STRING              #單頭年
DEFINE l_mon_h        STRING              #單頭月
DEFINE l_day_h        STRING              #單頭日
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.isafdocno
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
        BEFORE GROUP OF sr1.isafdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
       
            #end add-point:rep.header 
            LET g_rep_docno = sr1.isafdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'isafent=' ,sr1.isafent,'{+}isafcomp=' ,sr1.isafcomp,'{+}isafdocno=' ,sr1.isafdocno         
            CALL cl_gr_init_apr(sr1.isafdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            LET l_lineno = 0        
            
            #160328---s add 改為 當頁顯示當頁合計   
            #合計
            LET l_sum_isah113 = 0
            LET l_sum_isah114 = 0
            PRINTX l_sum_isah113
            PRINTX l_sum_isah114
            #160328---e add
            
            #單身總筆數           
            LET l_cmd = " SELECT COUNT(*)  ",
                        "   FROM isaf_t,isah_t ",
                        "  WHERE isafent = ",g_enterprise," AND isafent = isahent AND isafcomp = isahcomp AND isafdocno = isahdocno ",
                        "    AND isafcomp = '",sr1.isafcomp,"' AND isafsite = '",sr1.isafsite,"' AND isafdocno = '",sr1.isafdocno,"' ",
                        "  ORDER BY isafdocno,isafdocdt,isahseq"
                        
            PREPARE aisp350_g01_body_cnt_pr FROM l_cmd
            EXECUTE aisp350_g01_body_cnt_pr INTO g_tot_cnt
            
           
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.isafdocno.before name="rep.b_group.isafdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.isafdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp350_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aisp350_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aisp350_g01_subrep01
           DECLARE aisp350_g01_repcur01 CURSOR FROM g_sql
           FOREACH aisp350_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp350_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aisp350_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aisp350_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.isafdocno.after name="rep.b_group.isafdocno.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          #民國年 
          LET l_year_h = (YEAR(sr1.isafdocdt))-1911
          LET l_year_h = l_year_h USING "&&&"
          LET l_mon_h  = MONTH(sr1.isafdocdt) USING "&&"   #月
          LET l_day_h  = DAY(sr1.isafdocdt)  USING "&&"    #日
          
          PRINTX l_year_h
          PRINTX l_mon_h
          PRINTX l_day_h
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.isafdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp350_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aisp350_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aisp350_g01_subrep02
           DECLARE aisp350_g01_repcur02 CURSOR FROM g_sql
           FOREACH aisp350_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp350_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aisp350_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aisp350_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #目前已列筆數
          LET l_lineno = l_lineno + 1
          PRINTX l_lineno

          #160328---s add 改為 當頁顯示當頁合計   
          #合計
          LET l_sum_isah113 = l_sum_isah113 + sr1.isah113
          LET l_sum_isah114 = l_sum_isah114 + sr1.isah114
          #160328---e add
          
          #跳頁flag
          LET l_skip ='N' 
          
          #補空格flag
          LET l_show_space1 = 'N'
          LET l_show_space2 = 'N'
          LET l_show_space3 = 'N'
          LET l_show_space4 = 'N'
          LET l_show_space5 = 'N' #160328  add

          #五筆跳頁
          #160328 --s
          IF l_lineno MOD 5 = 0 THEN
             #IF l_tot_cnt <= 5 THEN  #若總筆數小於等於5,不用跳頁 #160902-00040#1 mark
             IF g_tot_cnt <= 5 THEN                             #160902-00040#1 add
                LET l_skip ='N'      #不用跳頁
             ELSE                    
                LET l_skip ='Y'      #跳頁
             END IF
             LET l_show_space5 = 'Y' #160328 add
          END IF
          #160328 --e

          #如果是最後一筆,補空格
          #IF l_lineno = l_tot_cnt THEN #160902-00040#1 mark
          IF l_lineno = g_tot_cnt THEN  #160902-00040#1 add
             CASE (l_lineno MOD 5)
                WHEN 1 #補4個
                   LET l_show_space1 = 'Y'
                   LET l_show_space2 = 'Y'
                   LET l_show_space3 = 'Y'
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y' 
                WHEN 2 #補3個
                   LET l_show_space2 = 'Y'
                   LET l_show_space3 = 'Y'
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y' 
                WHEN 3 #補2個
                   LET l_show_space3 = 'Y'
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y'
                WHEN 4 #補1個
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y'
             END CASE
          END IF
          
          #160328 --s mark 頁尾資料每頁列印 因此多一個l_show_space5 來顯示
          ##如果是最後一筆,補空格
          #IF l_lineno = l_tot_cnt THEN
          #   CASE (l_lineno MOD 5)
          #      WHEN 1 #補4個
          #         LET l_show_space1 = 'Y'
          #         LET l_show_space2 = 'Y'
          #         LET l_show_space3 = 'Y'
          #         LET l_show_space4 = 'Y'
          #      WHEN 2 #補3個
          #         LET l_show_space2 = 'Y'
          #         LET l_show_space3 = 'Y'
          #         LET l_show_space4 = 'Y'
          #      WHEN 3 #補2個
          #         LET l_show_space3 = 'Y'
          #         LET l_show_space4 = 'Y'
          #      WHEN 4 #補1個
          #         LET l_show_space4 = 'Y'
          #   END CASE
          #END IF
          #160328 --e mark 
          
          PRINTX l_skip
          PRINTX l_show_space1
          PRINTX l_show_space2
          PRINTX l_show_space3
          PRINTX l_show_space4
          PRINTX l_show_space5          
          PRINTX l_sum_isah113
          PRINTX l_sum_isah114
          
          #160328 --s add
          IF l_skip ='Y' THEN 
             LET l_sum_isah113 = 0
             LET l_sum_isah114 = 0
          END IF
          #160328 --e add
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
                sr1.isafent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp350_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aisp350_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aisp350_g01_subrep03
           DECLARE aisp350_g01_repcur03 CURSOR FROM g_sql
           FOREACH aisp350_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp350_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aisp350_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aisp350_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isafdocno
 
           #add-point:rep.a_group.isafdocno.before name="rep.a_group.isafdocno.before"

           #160328---s mark 改為 當頁顯示當頁合計   
           ##合計
           #LET l_sum_isah113 = GROUP SUM(sr1.isah113)
           #LET l_sum_isah114 = GROUP SUM(sr1.isah114)
           #PRINTX l_sum_isah113
           #PRINTX l_sum_isah114
           ##160328---e mark

           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.isafdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp350_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aisp350_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aisp350_g01_subrep04
           DECLARE aisp350_g01_repcur04 CURSOR FROM g_sql
           FOREACH aisp350_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp350_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aisp350_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aisp350_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.isafdocno.after name="rep.a_group.isafdocno.after"
           #160902-00040#1 ---s
           LET g_tmp_table = "SELECT*FROM aisp350_g01_tmp"
           #第一聯    
           START REPORT aisp350_g01_subrep08
              DECLARE aisp350_g01_repcur08 CURSOR FROM g_tmp_table
                 FOREACH aisp350_g01_repcur08 INTO sr6.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aisp350_g01_repcur08:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aisp350_g01_subrep08(sr6.*)
                 END FOREACH   
           FINISH REPORT aisp350_g01_subrep08
                      
           #第二聯    
           START REPORT aisp350_g01_subrep05
              DECLARE aisp350_g01_repcur05 CURSOR FROM g_tmp_table
                 FOREACH aisp350_g01_repcur05 INTO sr3.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aisp350_g01_repcur05:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aisp350_g01_subrep05(sr3.*)
                 END FOREACH   
           FINISH REPORT aisp350_g01_subrep05
           
           #第三聯    
           START REPORT aisp350_g01_subrep06
              DECLARE aisp350_g01_repcur06 CURSOR FROM g_tmp_table
                 FOREACH aisp350_g01_repcur06 INTO sr4.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aisp350_g01_repcur06:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aisp350_g01_subrep06(sr4.*)
                 END FOREACH   
           FINISH REPORT aisp350_g01_subrep06
           
           #第四聯    
           START REPORT aisp350_g01_subrep07
              DECLARE aisp350_g01_repcur07 CURSOR FROM g_tmp_table
                 FOREACH aisp350_g01_repcur07 INTO sr5.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aisp350_g01_repcur07:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aisp350_g01_subrep07(sr5.*)
                 END FOREACH   
           FINISH REPORT aisp350_g01_subrep07
           #160902-00040#1 ---e
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aisp350_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisp350_g01_subrep01(sr2)
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
PRIVATE REPORT aisp350_g01_subrep02(sr2)
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
PRIVATE REPORT aisp350_g01_subrep03(sr2)
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
PRIVATE REPORT aisp350_g01_subrep04(sr2)
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
 
{<section id="aisp350_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 四聯單資料的臨時表
# Memo...........:
# Usage..........: CALL aisp350_g01_create_tmp()
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160919 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp350_g01_create_tmp()
   DROP TABLE aisp350_g01_tmp;
   CREATE TEMP TABLE aisp350_g01_tmp(  
      isahseq           LIKE isah_t.isahseq,
      isafcomp          LIKE isaf_t.isafcomp,
      isafsite          LIKE isaf_t.isafsite,
      isaf027           LIKE isaf_t.isaf027,
      isaf028           LIKE isaf_t.isaf028,
      isaf029           LIKE isaf_t.isaf029,
      isafdocdt         LIKE isaf_t.isafdocdt,
      isafdocno         LIKE isaf_t.isafdocno,
      isahent           LIKE isah_t.isahent,
      isafent           LIKE isaf_t.isafent,
      l_isat005         LIKE type_t.chr100,
      l_isah009_e       LIKE type_t.chr100,
      isah004           LIKE isah_t.isah004,
      isah006           LIKE isah_t.isah006,
      isah101           LIKE isah_t.isah101,
      isaf021           LIKE isaf_t.isaf021,
      isaf022           LIKE isaf_t.isaf022,
      isaf023           LIKE isaf_t.isaf023,
      isah113           LIKE isah_t.isah113,
      isah114           LIKE isah_t.isah114,
      isaf101           LIKE isaf_t.isaf101,
      l_isah009_s       LIKE type_t.chr100,
      l_day             LIKE type_t.chr100,
      isah009           LIKE isah_t.isah009,
      l_mon             LIKE type_t.chr100,
      l_year            LIKE type_t.chr100,
      l_isat022         LIKE type_t.chr100,
      l_isat027         LIKE type_t.chr100
      )
END FUNCTION

 
{</section>}
 
{<section id="aisp350_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 第一聯
# Memo...........: #160902-00040#1
# Usage..........: CALL aisp350_g01_subrep08(sr6)
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 20160921 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aisp350_g01_subrep08(sr6)
DEFINE sr6 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_isah113  LIKE isah_t.isah113 #總計金額
DEFINE l_sum_isah114  LIKE isah_t.isah114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1   
DEFINE l_cmd          STRING
DEFINE l_year_h            STRING 
DEFINE l_mon_h           STRING 
DEFINE l_day_h             STRING

ORDER BY sr6.isafdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr6.isafdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr6.isafdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isafent=' ,sr6.isafent,'{+}isafcomp=' ,sr6.isafcomp,'{+}isafdocno=' ,sr6.isafdocno         
        CALL cl_gr_init_apr(sr6.isafdocno)
        LET l_lineno = 0        
        LET l_sum_isah113 = 0
        LET l_sum_isah114 = 0
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114
        
     ON EVERY ROW
        LET l_year_h = (YEAR(sr6.isafdocdt))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr6.isafdocdt) USING "&&"   #月
        LET l_day_h  = DAY(sr6.isafdocdt)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_isah113 = l_sum_isah113 + sr6.isah113
        LET l_sum_isah114 = l_sum_isah114 + sr6.isah114
        
        #補空格flag
        LET l_show_space1 = 'N'
        LET l_show_space2 = 'N'
        LET l_show_space3 = 'N'
        LET l_show_space4 = 'N'
        LET l_show_space5 = 'N'
        
        #目前已列筆數
        LET l_lineno = l_lineno + 1
        PRINTX l_lineno
         
        #五筆跳頁
        IF l_lineno MOD 5 = 0 THEN
           IF g_tot_cnt <= 5 THEN  #若總筆數小於等於5,不用跳頁
              LET l_skip ='N'      #不用跳頁
           ELSE                    
              LET l_skip ='Y'      #跳頁
           END IF
           LET l_show_space5 = 'Y' 
        END IF
        
        #如果是最後一筆,補空格
        IF l_lineno = g_tot_cnt THEN
           CASE (l_lineno MOD 5)
              WHEN 1 #補4個
                 LET l_show_space1 = 'Y'
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 2 #補3個
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 3 #補2個
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 4 #補1個
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
           END CASE
        END IF
        
        PRINTX l_skip
        PRINTX l_show_space1
        PRINTX l_show_space2
        PRINTX l_show_space3
        PRINTX l_show_space4
        PRINTX l_show_space5          
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114
          

        IF l_skip ='Y' THEN 
           LET l_sum_isah113 = 0
           LET l_sum_isah114 = 0
        END IF
        PRINTX sr6.*                    
        
     AFTER GROUP OF sr6.isafdocno
END REPORT

################################################################################
# Descriptions...: 第二聯
# Memo...........: #160902-00040#1
# Usage..........: CALL aisp350_g01_subrep05(sr3)
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 20160910 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aisp350_g01_subrep05(sr3)
DEFINE sr3 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_isah113  LIKE isah_t.isah113 #總計金額
DEFINE l_sum_isah114  LIKE isah_t.isah114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1    #160328
DEFINE l_cmd          STRING
DEFINE l_year_h            STRING 
DEFINE l_mon_h           STRING 
DEFINE l_day_h             STRING

ORDER BY sr3.isafdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr3.isafdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr3.isafdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isafent=' ,sr3.isafent,'{+}isafcomp=' ,sr3.isafcomp,'{+}isafdocno=' ,sr3.isafdocno         
        CALL cl_gr_init_apr(sr3.isafdocno)
        LET l_lineno = 0        
        LET l_sum_isah113 = 0
        LET l_sum_isah114 = 0
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114
               
     ON EVERY ROW
        LET l_year_h = (YEAR(sr3.isafdocdt))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr3.isafdocdt) USING "&&"   #月
        LET l_day_h  = DAY(sr3.isafdocdt)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_isah113 = l_sum_isah113 + sr3.isah113
        LET l_sum_isah114 = l_sum_isah114 + sr3.isah114
        
        #補空格flag
        LET l_show_space1 = 'N'
        LET l_show_space2 = 'N'
        LET l_show_space3 = 'N'
        LET l_show_space4 = 'N'
        LET l_show_space5 = 'N'
        
        #目前已列筆數
        LET l_lineno = l_lineno + 1
        PRINTX l_lineno
         
        #五筆跳頁
        IF l_lineno MOD 5 = 0 THEN
           IF g_tot_cnt <= 5 THEN  #若總筆數小於等於5,不用跳頁
              LET l_skip ='N'      #不用跳頁
           ELSE                    
              LET l_skip ='Y'      #跳頁
           END IF
           LET l_show_space5 = 'Y' 
        END IF
        
        #如果是最後一筆,補空格
        IF l_lineno = g_tot_cnt THEN
           CASE (l_lineno MOD 5)
              WHEN 1 #補4個
                 LET l_show_space1 = 'Y'
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 2 #補3個
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 3 #補2個
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 4 #補1個
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
           END CASE
        END IF
        
        PRINTX l_skip
        PRINTX l_show_space1
        PRINTX l_show_space2
        PRINTX l_show_space3
        PRINTX l_show_space4
        PRINTX l_show_space5          
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114
          

        IF l_skip ='Y' THEN 
           LET l_sum_isah113 = 0
           LET l_sum_isah114 = 0
        END IF
        PRINTX sr3.*                    
        
     AFTER GROUP OF sr3.isafdocno
END REPORT

################################################################################
# Descriptions...: 非套表第三聯
# Memo...........: #160902-00040#1
# Usage..........: CALL aisp350_g01_subrep06(sr4)
#                  RETURNING 回传参数
# Input parameter: sr4
# Return code....: 無
# Date & Author..: 20160914 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aisp350_g01_subrep06(sr4)
DEFINE sr4 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_isah113  LIKE isah_t.isah113 #總計金額
DEFINE l_sum_isah114  LIKE isah_t.isah114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1   
DEFINE l_cmd          STRING
DEFINE l_year_h            STRING 
DEFINE l_mon_h           STRING 
DEFINE l_day_h             STRING

ORDER BY sr4.isafdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr4.isafdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr4.isafdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isafent=' ,sr4.isafent,'{+}isafcomp=' ,sr4.isafcomp,'{+}isafdocno=' ,sr4.isafdocno         
        CALL cl_gr_init_apr(sr4.isafdocno)
        LET l_lineno = 0        
        LET l_sum_isah113 = 0
        LET l_sum_isah114 = 0
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114
        
     ON EVERY ROW
        LET l_year_h = (YEAR(sr4.isafdocdt))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr4.isafdocdt) USING "&&"   #月
        LET l_day_h  = DAY(sr4.isafdocdt)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_isah113 = l_sum_isah113 + sr4.isah113
        LET l_sum_isah114 = l_sum_isah114 + sr4.isah114
        
        #補空格flag
        LET l_show_space1 = 'N'
        LET l_show_space2 = 'N'
        LET l_show_space3 = 'N'
        LET l_show_space4 = 'N'
        LET l_show_space5 = 'N'
        
        #目前已列筆數
        LET l_lineno = l_lineno + 1
        PRINTX l_lineno
         
        #五筆跳頁
        IF l_lineno MOD 5 = 0 THEN
           IF g_tot_cnt <= 5 THEN  #若總筆數小於等於5,不用跳頁
              LET l_skip ='N'      #不用跳頁
           ELSE                    
              LET l_skip ='Y'      #跳頁
           END IF
           LET l_show_space5 = 'Y' 
        END IF
        
        #如果是最後一筆,補空格
        IF l_lineno = g_tot_cnt THEN
           CASE (l_lineno MOD 5)
              WHEN 1 #補4個
                 LET l_show_space1 = 'Y'
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 2 #補3個
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 3 #補2個
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 4 #補1個
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
           END CASE
        END IF
        
        PRINTX l_skip
        PRINTX l_show_space1
        PRINTX l_show_space2
        PRINTX l_show_space3
        PRINTX l_show_space4
        PRINTX l_show_space5          
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114
          

        IF l_skip ='Y' THEN 
           LET l_sum_isah113 = 0
           LET l_sum_isah114 = 0
        END IF
        PRINTX sr4.*                    
        
     AFTER GROUP OF sr4.isafdocno
END REPORT

################################################################################
# Descriptions...: 非套表第四聯
# Memo...........: #160902-00040#1
# Usage..........: CALL aisp350_g01_subrep07(sr5)
# Input parameter: sr5
# Date & Author..: 20160914 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aisp350_g01_subrep07(sr5)
DEFINE sr5 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_isah113  LIKE isah_t.isah113 #總計金額
DEFINE l_sum_isah114  LIKE isah_t.isah114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1  
DEFINE l_cmd          STRING
DEFINE l_year_h            STRING 
DEFINE l_mon_h           STRING 
DEFINE l_day_h             STRING

ORDER BY sr5.isafdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr5.isafdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr5.isafdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isafent=' ,sr5.isafent,'{+}isafcomp=' ,sr5.isafcomp,'{+}isafdocno=' ,sr5.isafdocno         
        CALL cl_gr_init_apr(sr5.isafdocno)
        LET l_lineno = 0        
        LET l_sum_isah113 = 0
        LET l_sum_isah114 = 0
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114

     ON EVERY ROW
        LET l_year_h = (YEAR(sr5.isafdocdt))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr5.isafdocdt) USING "&&"   #月
        LET l_day_h  = DAY(sr5.isafdocdt)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_isah113 = l_sum_isah113 + sr5.isah113
        LET l_sum_isah114 = l_sum_isah114 + sr5.isah114
        
        #補空格flag
        LET l_show_space1 = 'N'
        LET l_show_space2 = 'N'
        LET l_show_space3 = 'N'
        LET l_show_space4 = 'N'
        LET l_show_space5 = 'N'
        
        #目前已列筆數
        LET l_lineno = l_lineno + 1
        PRINTX l_lineno
         
        #五筆跳頁
        IF l_lineno MOD 5 = 0 THEN
           IF g_tot_cnt <= 5 THEN  #若總筆數小於等於5,不用跳頁
              LET l_skip ='N'      #不用跳頁
           ELSE                    
              LET l_skip ='Y'      #跳頁
           END IF
           LET l_show_space5 = 'Y' 
        END IF
        
        #如果是最後一筆,補空格
        IF l_lineno = g_tot_cnt THEN
           CASE (l_lineno MOD 5)
              WHEN 1 #補4個
                 LET l_show_space1 = 'Y'
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 2 #補3個
                 LET l_show_space2 = 'Y'
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 3 #補2個
                 LET l_show_space3 = 'Y'
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
              WHEN 4 #補1個
                 LET l_show_space4 = 'Y'
                 LET l_show_space5 = 'Y' 
           END CASE
        END IF
        
        PRINTX l_skip
        PRINTX l_show_space1
        PRINTX l_show_space2
        PRINTX l_show_space3
        PRINTX l_show_space4
        PRINTX l_show_space5          
        PRINTX l_sum_isah113
        PRINTX l_sum_isah114
          

        IF l_skip ='Y' THEN 
           LET l_sum_isah113 = 0
           LET l_sum_isah114 = 0
        END IF
        PRINTX sr5.*                    
        
     AFTER GROUP OF sr5.isafdocno
END REPORT

 
{</section>}
 
