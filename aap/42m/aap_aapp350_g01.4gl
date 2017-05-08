#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp350_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-11-01 10:19:44), PR版次:0002(2016-11-01 10:47:07)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000005
#+ Filename...: aapp350_g01
#+ Description: ...
#+ Creator....: 08171(2016-09-20 11:40:34)
#+ Modifier...: 08171 -SD/PR- 08171
 
{</section>}
 
{<section id="aapp350_g01.global" readonly="Y" >}
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
   l_apbaseq LIKE apba_t.apbaseq, 
   l_apbbcomp LIKE apbb_t.apbbcomp, 
   l_apbb004 LIKE apbb_t.apbb004, 
   l_apbb029 LIKE apbb_t.apbb029, 
   l_apbb030 LIKE apbb_t.apbb030, 
   l_apbb031 LIKE apbb_t.apbb031, 
   l_apbbdocdt LIKE apbb_t.apbbdocdt, 
   isamdocno LIKE isam_t.isamdocno, 
   isament LIKE isam_t.isament, 
   l_isac008 LIKE type_t.chr30, 
   l_isam010_e LIKE type_t.chr30, 
   l_apba008 LIKE apba_t.apba008, 
   l_apba010 LIKE apba_t.apba010, 
   l_apba014 LIKE type_t.num20, 
   l_apbb016 LIKE apbb_t.apbb016, 
   l_apbb017 LIKE apbb_t.apbb017, 
   l_apbb018 LIKE apbb_t.apbb018, 
   l_apba113 LIKE type_t.num20, 
   l_apba114 LIKE type_t.num20, 
   l_apbb015 LIKE apbb_t.apbb015, 
   l_isam010_s LIKE type_t.chr30, 
   l_day LIKE type_t.chr30, 
   isam010 LIKE isam_t.isam010, 
   l_mon LIKE type_t.chr30, 
   l_year LIKE type_t.chr10, 
   l_apbb012 LIKE type_t.chr30, 
   isam011 LIKE isam_t.isam011, 
   l_apbb008 LIKE apbb_t.apbb008, 
   l_apba015 LIKE apba_t.apba015
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

DEFINE g_tmp_table  STRING  
TYPE sr3_r RECORD  #第一二三四聯
   l_apbaseq LIKE apba_t.apbaseq, 
   l_apbbcomp LIKE apbb_t.apbbcomp, 
   l_apbb004 LIKE apbb_t.apbb004, 
   l_apbb029 LIKE apbb_t.apbb029, 
   l_apbb030 LIKE apbb_t.apbb030, 
   l_apbb031 LIKE apbb_t.apbb031, 
   l_apbbdocdt LIKE apbb_t.apbbdocdt, 
   isamdocno LIKE isam_t.isamdocno, 
   isament LIKE isam_t.isament, 
   l_isac008 LIKE type_t.chr30, 
   l_isam010_e LIKE type_t.chr30, 
   l_apba008 LIKE apba_t.apba008, 
   l_apba010 LIKE apba_t.apba010, 
   l_apba014 LIKE type_t.num20, 
   l_apbb016 LIKE apbb_t.apbb016, 
   l_apbb017 LIKE apbb_t.apbb017, 
   l_apbb018 LIKE apbb_t.apbb018, 
   l_apba113 LIKE type_t.num20, 
   l_apba114 LIKE type_t.num20, 
   l_apbb015 LIKE apbb_t.apbb015, 
   l_isam010_s LIKE type_t.chr30, 
   l_day LIKE type_t.chr30, 
   isam010 LIKE isam_t.isam010, 
   l_mon LIKE type_t.chr30, 
   l_year LIKE type_t.chr10, 
   l_apbb012 LIKE type_t.chr30, 
   isam011 LIKE isam_t.isam011, 
   l_apbb008 LIKE apbb_t.apbb008
END RECORD
#end add-point
 
{</section>}
 
{<section id="aapp350_g01.main" readonly="Y" >}
PUBLIC FUNCTION aapp350_g01(p_arg1,p_arg2)
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
         LET g_template ="aapp350_g01"
         
      WHEN '2' #非套表
         LET g_template ="aapp350_g01_01"
   END CASE
   
   CALL aapp350_g01_create_tmp()  
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aapp350_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aapp350_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aapp350_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aapp350_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp350_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp350_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET g_select = " SELECT DISTINCT apbaseq,apbbcomp,apbb004,apbb029,apbb030,apbb031,apbbdocdt,apbadocno,isament,'','',apba008,apba010,apba014, ",
                  " apbb016,apbb017,apbb018,apba113,apba114,apbb015,'','',apba017,'','',apba012,isam011,apbb008,apba015 "
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT '','','','','','','',isamdocno,isament,'','','','','','','','','','','','', 
#       '',isam010,'','','',isam011,'',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
     LET g_from = " FROM apbb_t ",  
                  " LEFT JOIN apba_t ON apbaent = apbbent AND apbbdocno = apbadocno ",     
                  " LEFT JOIN isam_t ON apbbent = isament AND apbbdocno = isamdocno "
#   #end add-point
#    LET g_from = " FROM isam_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = g_where CLIPPED," AND apbbent = ",g_enterprise," AND apbaent = apbbent AND apbadocno = apbbdocno "
   #end add-point
    LET g_order = " ORDER BY isamdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY apbadocno,apbaseq"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("isam_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aapp350_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aapp350_g01_curs CURSOR FOR aapp350_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapp350_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapp350_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_apbaseq LIKE apba_t.apbaseq, 
   l_apbbcomp LIKE apbb_t.apbbcomp, 
   l_apbb004 LIKE apbb_t.apbb004, 
   l_apbb029 LIKE apbb_t.apbb029, 
   l_apbb030 LIKE apbb_t.apbb030, 
   l_apbb031 LIKE apbb_t.apbb031, 
   l_apbbdocdt LIKE apbb_t.apbbdocdt, 
   isamdocno LIKE isam_t.isamdocno, 
   isament LIKE isam_t.isament, 
   l_isac008 LIKE type_t.chr30, 
   l_isam010_e LIKE type_t.chr30, 
   l_apba008 LIKE apba_t.apba008, 
   l_apba010 LIKE apba_t.apba010, 
   l_apba014 LIKE type_t.num20, 
   l_apbb016 LIKE apbb_t.apbb016, 
   l_apbb017 LIKE apbb_t.apbb017, 
   l_apbb018 LIKE apbb_t.apbb018, 
   l_apba113 LIKE type_t.num20, 
   l_apba114 LIKE type_t.num20, 
   l_apbb015 LIKE apbb_t.apbb015, 
   l_isam010_s LIKE type_t.chr30, 
   l_day LIKE type_t.chr30, 
   isam010 LIKE isam_t.isam010, 
   l_mon LIKE type_t.chr30, 
   l_year LIKE type_t.chr10, 
   l_apbb012 LIKE type_t.chr30, 
   isam011 LIKE isam_t.isam011, 
   l_apbb008 LIKE apbb_t.apbb008, 
   l_apba015 LIKE apba_t.apba015
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_isam010 STRING
   DEFINE l_comp    LIKE glaa_t.glaacomp
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_ooef019 LIKE ooef_t.ooef019
   DEFINE l_isai005 LIKE isai_t.isai005  #編碼長度
   DEFINE l_c       LIKE type_t.num5
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    DELETE FROM aapp350_g01_tmp
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aapp350_g01_curs INTO sr_s.*
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
       SELECT isam011 INTO sr_s.isam011
         FROM isam_t
        WHERE isament = g_enterprise
          AND isamdocno = sr_s.isamdocno
          AND iasm010 = sr_s.isam010
          AND isam036 <> 22
       
       #民國年 
       LET sr_s.l_year = (YEAR(sr_s.isam011))-1911
       LET sr_s.l_year = sr_s.l_year USING "&&&"
       #月
       LET sr_s.l_mon  = MONTH(sr_s.isam011) USING "&&"
       #日
       LET sr_s.l_day  = DAY(sr_s.isam011) USING "&&"

       #取得稅區
       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = sr_s.l_apbbcomp AND ooefstus = 'Y'
       #字軌編碼長度
       SELECT isai005 INTO l_isai005 FROM isai_t WHERE isaient = g_enterprise AND isai001 = l_ooef019
       #字軌號碼
       LET l_isam010 = sr_s.isam010
       LET sr_s.l_isam010_s = l_isam010.substring(1,l_isai005)
       LET sr_s.l_isam010_e = l_isam010.substring(l_isai005+1,l_isam010.getLength())

       #帳套
       CALL s_fin_orga_get_comp_ld(sr_s.l_apbb004) RETURNING g_sub_success,g_errno,l_comp,g_glaald
       #本幣
       SELECT glaa001 INTO l_glaa001 
         FROM glaa_t 
        WHERE glaaent = g_enterprise AND glaald = g_glaald  
       #計算單價
       LET sr_s.l_apba014 = sr_s.l_apba014 * sr_s.l_apbb015
       CALL s_curr_round_ld('1',g_glaald,l_glaa001,sr_s.l_apba014,2) RETURNING g_sub_success,g_errno,sr_s.l_apba014
       IF cl_null(sr_s.l_apba014) THEN
          LET sr_s.l_apba014 = 0
       END IF         
         
      #聯別
      SELECT gzcb005 INTO sr_s.l_isac008   #系統應用碼三
        FROM gzcb_t  
       WHERE gzcb001 = '9734' 
         AND gzcb002 IN ( SELECT DISTINCT isac008
                            FROM isac_t
                            LEFT JOIN ooef_t ON ooefent = isacent AND ooef019 = isac001
                           WHERE isacent = g_enterprise
                             AND ooef001 = sr_s.l_apbbcomp
                             AND isac002 = sr_s.l_apbb008)
                              
       #課稅別(取原發票的課稅別)
       SELECT oodb004 INTO sr_s.l_apbb012
         FROM oodb_t
        WHERE oodbent = g_enterprise
          AND oodb001 = l_ooef019       #稅區
          AND oodb002 = sr_s.l_apba015  #稅別編號
          
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_apbaseq = sr_s.l_apbaseq
       LET sr[l_cnt].l_apbbcomp = sr_s.l_apbbcomp
       LET sr[l_cnt].l_apbb004 = sr_s.l_apbb004
       LET sr[l_cnt].l_apbb029 = sr_s.l_apbb029
       LET sr[l_cnt].l_apbb030 = sr_s.l_apbb030
       LET sr[l_cnt].l_apbb031 = sr_s.l_apbb031
       LET sr[l_cnt].l_apbbdocdt = sr_s.l_apbbdocdt
       LET sr[l_cnt].isamdocno = sr_s.isamdocno
       LET sr[l_cnt].isament = sr_s.isament
       LET sr[l_cnt].l_isac008 = sr_s.l_isac008
       LET sr[l_cnt].l_isam010_e = sr_s.l_isam010_e
       LET sr[l_cnt].l_apba008 = sr_s.l_apba008
       LET sr[l_cnt].l_apba010 = sr_s.l_apba010
       LET sr[l_cnt].l_apba014 = sr_s.l_apba014
       LET sr[l_cnt].l_apbb016 = sr_s.l_apbb016
       LET sr[l_cnt].l_apbb017 = sr_s.l_apbb017
       LET sr[l_cnt].l_apbb018 = sr_s.l_apbb018
       LET sr[l_cnt].l_apba113 = sr_s.l_apba113
       LET sr[l_cnt].l_apba114 = sr_s.l_apba114
       LET sr[l_cnt].l_apbb015 = sr_s.l_apbb015
       LET sr[l_cnt].l_isam010_s = sr_s.l_isam010_s
       LET sr[l_cnt].l_day = sr_s.l_day
       LET sr[l_cnt].isam010 = sr_s.isam010
       LET sr[l_cnt].l_mon = sr_s.l_mon
       LET sr[l_cnt].l_year = sr_s.l_year
       LET sr[l_cnt].l_apbb012 = sr_s.l_apbb012
       LET sr[l_cnt].isam011 = sr_s.isam011
       LET sr[l_cnt].l_apbb008 = sr_s.l_apbb008
       LET sr[l_cnt].l_apba015 = sr_s.l_apba015
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       INSERT INTO aapp350_g01_tmp
       VALUES(sr_s.l_apbaseq,
              sr_s.l_apbbcomp,
              sr_s.l_apbb004,
              sr_s.l_apbb029,
              sr_s.l_apbb030,
              sr_s.l_apbb031,
              sr_s.l_apbbdocdt,
              sr_s.isamdocno,
              sr_s.isament,
              sr_s.l_isac008,
              sr_s.l_isam010_e,
              sr_s.l_apba008,
              sr_s.l_apba010,
              sr_s.l_apba014,
              sr_s.l_apbb016,
              sr_s.l_apbb017,
              sr_s.l_apbb018,
              sr_s.l_apba113,
              sr_s.l_apba114,
              sr_s.l_apbb015,
              sr_s.l_isam010_s,
              sr_s.l_day,
              sr_s.isam010,
              sr_s.l_mon,
              sr_s.l_year,
              sr_s.l_apbb012,
              sr_s.isam011,
              sr_s.l_apbb008
                  )
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
 
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp350_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapp350_g01_rep_data()
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
          START REPORT aapp350_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aapp350_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aapp350_g01_rep
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
 
{<section id="aapp350_g01.rep" readonly="Y" >}
PRIVATE REPORT aapp350_g01_rep(sr1)
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
DEFINE sr3            sr3_r               #第一聯
DEFINE sr4            sr3_r               #第二聯
DEFINE sr5            sr3_r               #第三聯
DEFINE sr6            sr3_r               #第四聯
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_apba113  LIKE apba_t.apba113 #總計金額
DEFINE l_sum_apba114  LIKE apba_t.apba114 #總計金額 
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
    ORDER  BY sr1.isamdocno
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
        BEFORE GROUP OF sr1.isamdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
       
            #end add-point:rep.header 
            LET g_rep_docno = sr1.isamdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'isament=' ,sr1.isament,'{+}isamdocno=' ,sr1.isamdocno         
            CALL cl_gr_init_apr(sr1.isamdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            LET l_lineno = 0        
            
            #單頭顯示當頁合計   
            LET l_sum_apba113 = 0
            LET l_sum_apba114 = 0
            PRINTX l_sum_apba113
            PRINTX l_sum_apba114
            
            #單身總筆數           
            LET l_cmd = " SELECT COUNT(*)  ",
                        "   FROM apba_t  ",
                        "   LEFT JOIN apbb_t ON apbbent = apbaent AND apbbdocno = apbadocno ",
                        "  WHERE apbbent = ",g_enterprise," AND apbbdocno = '",sr1.isamdocno,"' "
                        
            PREPARE aapp350_g01_body_cnt_pr FROM l_cmd
            EXECUTE aapp350_g01_body_cnt_pr INTO g_tot_cnt
            
           
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.isamdocno.before name="rep.b_group.isamdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.isament CLIPPED ,"'", " AND  ooff003 = '", sr1.isamdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapp350_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aapp350_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aapp350_g01_subrep01
           DECLARE aapp350_g01_repcur01 CURSOR FROM g_sql
           FOREACH aapp350_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapp350_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aapp350_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aapp350_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.isamdocno.after name="rep.b_group.isamdocno.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          #民國年 
          LET l_year_h = (YEAR(sr1.l_apbbdocdt))-1911
          LET l_year_h = l_year_h USING "&&&"
          LET l_mon_h  = MONTH(sr1.l_apbbdocdt) USING "&&"   #月
          LET l_day_h  = DAY(sr1.l_apbbdocdt)  USING "&&"    #日
          
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
                sr1.isament CLIPPED ,"'", " AND  ooff003 = '", sr1.isamdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapp350_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aapp350_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aapp350_g01_subrep02
           DECLARE aapp350_g01_repcur02 CURSOR FROM g_sql
           FOREACH aapp350_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapp350_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aapp350_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aapp350_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #目前已列筆數
          LET l_lineno = l_lineno + 1
          PRINTX l_lineno
          
          #合計
          LET l_sum_apba113 = l_sum_apba113 + sr1.l_apba113
          LET l_sum_apba114 = l_sum_apba114 + sr1.l_apba114
          
          #跳頁flag
          LET l_skip ='N' 
          
          #補空格flag
          LET l_show_space1 = 'N'
          LET l_show_space2 = 'N'
          LET l_show_space3 = 'N'
          LET l_show_space4 = 'N'
          LET l_show_space5 = 'N' #160328  add
          
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
          PRINTX l_sum_apba113
          PRINTX l_sum_apba114
          
          IF l_skip ='Y' THEN 
             LET l_sum_apba113 = 0
             LET l_sum_apba114 = 0
          END IF
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
                sr1.isament CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapp350_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aapp350_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aapp350_g01_subrep03
           DECLARE aapp350_g01_repcur03 CURSOR FROM g_sql
           FOREACH aapp350_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapp350_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aapp350_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aapp350_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isamdocno
 
           #add-point:rep.a_group.isamdocno.before name="rep.a_group.isamdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.isament CLIPPED ,"'", " AND  ooff003 = '", sr1.isamdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapp350_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aapp350_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aapp350_g01_subrep04
           DECLARE aapp350_g01_repcur04 CURSOR FROM g_sql
           FOREACH aapp350_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapp350_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aapp350_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aapp350_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.isamdocno.after name="rep.a_group.isamdocno.after"
           LET g_tmp_table = "SELECT * FROM aapp350_g01_tmp ORDER BY l_apbaseq "
           #第一聯    
           START REPORT aapp350_g01_subrep05
              DECLARE aapp350_g01_repcur05 CURSOR FROM g_tmp_table
                 FOREACH aapp350_g01_repcur05 INTO sr3.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aapp350_g01_repcur05:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aapp350_g01_subrep05(sr3.*)
                 END FOREACH   
           FINISH REPORT aapp350_g01_subrep05
           
           #第二聯    
           START REPORT aapp350_g01_subrep06
              DECLARE aapp350_g01_repcur06 CURSOR FROM g_tmp_table
                 FOREACH aapp350_g01_repcur06 INTO sr4.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aapp350_g01_repcur06:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aapp350_g01_subrep06(sr4.*)
                 END FOREACH   
           FINISH REPORT aapp350_g01_subrep06
           
           #第三聯    
           START REPORT aapp350_g01_subrep07
              DECLARE aapp350_g01_repcur07 CURSOR FROM g_tmp_table
                 FOREACH aapp350_g01_repcur07 INTO sr5.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aapp350_g01_repcur07:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aapp350_g01_subrep07(sr5.*)
                 END FOREACH   
           FINISH REPORT aapp350_g01_subrep07
           
           #第四聯    
           START REPORT aapp350_g01_subrep08
              DECLARE aapp350_g01_repcur08 CURSOR FROM g_tmp_table
                 FOREACH aapp350_g01_repcur08 INTO sr6.*
                    IF STATUS THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.extend = "aapp350_g01_repcur08:"
                       LET g_errparam.code   = SQLCA.sqlcode
                       LET g_errparam.popup  = FALSE
                       CALL cl_err()                  
                       EXIT FOREACH 
                    END IF
                 OUTPUT TO REPORT aapp350_g01_subrep08(sr6.*)
                 END FOREACH   
           FINISH REPORT aapp350_g01_subrep08
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aapp350_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapp350_g01_subrep01(sr2)
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
PRIVATE REPORT aapp350_g01_subrep02(sr2)
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
PRIVATE REPORT aapp350_g01_subrep03(sr2)
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
PRIVATE REPORT aapp350_g01_subrep04(sr2)
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
 
{<section id="aapp350_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 四聯單資料的臨時表
# Memo...........:
# Usage..........: CALL aapp350_g01_create_tmp()
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160919 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp350_g01_create_tmp()
   DROP TABLE aapp350_g01_tmp;
   CREATE TEMP TABLE aapp350_g01_tmp(  
     l_apbaseq  INTEGER, 
     l_apbbcomp  VARCHAR(10), 
     l_apbb004  VARCHAR(10), 
     l_apbb029  VARCHAR(255), 
     l_apbb030  VARCHAR(20), 
     l_apbb031  VARCHAR(4000), 
     l_apbbdocdt  DATE, 
     isamdocno  VARCHAR(20), 
     isament  SMALLINT, 
     l_isac008  VARCHAR(30), 
     l_isam010_e  VARCHAR(30), 
     l_apba008  VARCHAR(255), 
     l_apba010  DECIMAL(20,6), 
     l_apba014  DECIMAL(20,0), 
     l_apbb016  VARCHAR(255), 
     l_apbb017  VARCHAR(20), 
     l_apbb018  VARCHAR(4000), 
     l_apba113  DECIMAL(20,0), 
     l_apba114  DECIMAL(20,0), 
     l_apbb015  DECIMAL(20,10), 
     l_isam010_s  VARCHAR(30), 
     l_day  VARCHAR(30), 
     isam010  VARCHAR(20), 
     l_mon  VARCHAR(30), 
     l_year  VARCHAR(10), 
     l_apbb012  VARCHAR(30), 
     isam011  DATE, 
     l_apbb008  VARCHAR(2)
     )
END FUNCTION

 
{</section>}
 
{<section id="aapp350_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 非套表第一聯
# Memo...........:
# Usage..........: CALL aapp350_g01_g01_subrep05(sr3)
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160922 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aapp350_g01_subrep05(sr3)
DEFINE sr3 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_apba113  LIKE apba_t.apba113 #總計金額
DEFINE l_sum_apba114  LIKE apba_t.apba114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1
DEFINE l_year_h       STRING 
DEFINE l_mon_h        STRING 
DEFINE l_day_h        STRING

ORDER BY sr3.isamdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr3.isamdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr3.isamdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isament=' ,sr3.isament,'{+}isamdocno=' ,sr3.isamdocno
        CALL cl_gr_init_apr(sr3.isamdocno)
        LET l_lineno = 0        
        #單頭顯示當頁合計   
        LET l_sum_apba113 = 0
        LET l_sum_apba114 = 0
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
               
     ON EVERY ROW
        #民國年 
        LET l_year_h = (YEAR(sr3.isam011))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr3.isam011) USING "&&"   #月
        LET l_day_h  = DAY(sr3.isam011)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_apba113 = l_sum_apba113 + sr3.l_apba113
        LET l_sum_apba114 = l_sum_apba114 + sr3.l_apba114
        
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
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
          

        IF l_skip ='Y' THEN 
           LET l_sum_apba113 = 0
           LET l_sum_apba114 = 0
        END IF
        PRINTX sr3.*                    
        
     AFTER GROUP OF sr3.isamdocno
END REPORT

################################################################################
# Descriptions...: 非套表第二聯
# Memo...........:
# Usage..........: CALL aapp350_g01_subrep06(sr4)
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160922 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aapp350_g01_subrep06(sr4)
DEFINE sr4 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_apba113  LIKE apba_t.apba113 #總計金額
DEFINE l_sum_apba114  LIKE apba_t.apba114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1
DEFINE l_year_h       STRING 
DEFINE l_mon_h        STRING 
DEFINE l_day_h        STRING

ORDER BY sr4.isamdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr4.isamdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr4.isamdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isament=' ,sr4.isament,'{+}isamdocno=' ,sr4.isamdocno
        CALL cl_gr_init_apr(sr4.isamdocno)
        LET l_lineno = 0        
        #單頭顯示當頁合計   
        LET l_sum_apba113 = 0
        LET l_sum_apba114 = 0
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
               
     ON EVERY ROW
        #民國年 
        LET l_year_h = (YEAR(sr4.isam011))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr4.isam011) USING "&&"   #月
        LET l_day_h  = DAY(sr4.isam011)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_apba113 = l_sum_apba113 + sr4.l_apba113
        LET l_sum_apba114 = l_sum_apba114 + sr4.l_apba114
        
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
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
          

        IF l_skip ='Y' THEN 
           LET l_sum_apba113 = 0
           LET l_sum_apba114 = 0
        END IF
        PRINTX sr4.*                    
        
     AFTER GROUP OF sr4.isamdocno
END REPORT

################################################################################
# Descriptions...: 非套表第三聯
# Memo...........:
# Usage..........: CALL aapp350_g01_subrep07(sr5)
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160922 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aapp350_g01_subrep07(sr5)
DEFINE sr5 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_apba113  LIKE apba_t.apba113 #總計金額
DEFINE l_sum_apba114  LIKE apba_t.apba114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1
DEFINE l_year_h       STRING 
DEFINE l_mon_h        STRING 
DEFINE l_day_h        STRING

ORDER BY sr5.isamdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr5.isamdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr5.isamdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isament=' ,sr5.isament,'{+}isamdocno=' ,sr5.isamdocno
        CALL cl_gr_init_apr(sr5.isamdocno)
        LET l_lineno = 0        
        #單頭顯示當頁合計   
        LET l_sum_apba113 = 0
        LET l_sum_apba114 = 0
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
               
     ON EVERY ROW
        #民國年 
        LET l_year_h = (YEAR(sr5.isam011))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr5.isam011) USING "&&"   #月
        LET l_day_h  = DAY(sr5.isam011)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_apba113 = l_sum_apba113 + sr5.l_apba113
        LET l_sum_apba114 = l_sum_apba114 + sr5.l_apba114
        
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
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
          

        IF l_skip ='Y' THEN 
           LET l_sum_apba113 = 0
           LET l_sum_apba114 = 0
        END IF
        PRINTX sr5.*                    
        
     AFTER GROUP OF sr5.isamdocno
END REPORT

################################################################################
# Descriptions...: 非套表第四聯
# Memo...........:
# Usage..........: CALL aapp350_g01_subrep08(sr6)
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160922 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT aapp350_g01_subrep08(sr6)
DEFINE sr6 sr3_r              
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_sum_apba113  LIKE apba_t.apba113 #總計金額
DEFINE l_sum_apba114  LIKE apba_t.apba114 #總計金額
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1
DEFINE l_year_h       STRING 
DEFINE l_mon_h        STRING 
DEFINE l_day_h        STRING

ORDER BY sr6.isamdocno
 
  FORMAT
     FIRST PAGE HEADER   
         PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
         PRINTX tm.*
         PRINTX g_grNumFmt.*
         PRINTX g_rep_wcchp
        
     BEFORE GROUP OF sr6.isamdocno
        CALL cl_gr_title_clear()  #清除title變數值  
        LET g_rep_docno = sr6.isamdocno
        CALL cl_gr_init_pageheader() #表頭資訊
        PRINTX g_grPageHeader.*
        PRINTX g_grPageFooter.* 
        LET g_doc_key = 'isament=' ,sr6.isament,'{+}isamdocno=' ,sr6.isamdocno
        CALL cl_gr_init_apr(sr6.isamdocno)
        LET l_lineno = 0        
        #單頭顯示當頁合計   
        LET l_sum_apba113 = 0
        LET l_sum_apba114 = 0
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
               
     ON EVERY ROW
        #民國年 
        LET l_year_h = (YEAR(sr6.isam011))-1911
        LET l_year_h = l_year_h USING "&&&"
        LET l_mon_h  = MONTH(sr6.isam011) USING "&&"   #月
        LET l_day_h  = DAY(sr6.isam011)  USING "&&"    #日
        
        PRINTX l_year_h
        PRINTX l_mon_h
        PRINTX l_day_h
        
        #跳頁flag
        LET l_skip ='N' 
        
        #合計
        LET l_sum_apba113 = l_sum_apba113 + sr6.l_apba113
        LET l_sum_apba114 = l_sum_apba114 + sr6.l_apba114
        
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
        PRINTX l_sum_apba113
        PRINTX l_sum_apba114
          

        IF l_skip ='Y' THEN 
           LET l_sum_apba113 = 0
           LET l_sum_apba114 = 0
        END IF
        PRINTX sr6.*                    
        
     AFTER GROUP OF sr6.isamdocno
END REPORT

 
{</section>}
 
