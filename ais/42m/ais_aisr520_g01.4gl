#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr520_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-10-20 15:12:56), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: aisr520_g01
#+ Description: ...
#+ Creator....: 05016(2016-01-19 09:48:32)
#+ Modifier...: 05384 -SD/PR- 00000
 
{</section>}
 
{<section id="aisr520_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#151230-00003#15 2016/02/22 Reanna   新增A4格式的電子發票
#160414-00018#34 2016/05/11 06821    效能調整
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"
IMPORT JAVA com.dsc.t100.qrcode.QRcode
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   l_taxtype LIKE type_t.chr30, 
   isat001 LIKE isat_t.isat001, 
   isatcomp LIKE isat_t.isatcomp, 
   isatent LIKE isat_t.isatent, 
   isat004 LIKE isat_t.isat004, 
   isat009 LIKE isat_t.isat009, 
   isat010 LIKE isat_t.isat010, 
   isat011 LIKE isat_t.isat011, 
   isat012 LIKE isat_t.isat012, 
   isat007 LIKE isat_t.isat007, 
   isat008 LIKE isat_t.isat008, 
   isat006 LIKE isat_t.isat006, 
   isat115 LIKE isat_t.isat115, 
   isat022 LIKE isat_t.isat022, 
   isat113 LIKE isat_t.isat113, 
   isat114 LIKE isat_t.isat114, 
   l_isac004 LIKE type_t.chr30, 
   l_isah006 LIKE isah_t.isah006, 
   l_isah004 LIKE isah_t.isah004, 
   l_isah101 LIKE isah_t.isah010, 
   l_isah115 LIKE isah_t.isah115, 
   l_ooefl006 LIKE ooefl_t.ooefl006, 
   l_isao010 LIKE isao_t.isao010, 
   l_yearmon LIKE type_t.chr100, 
   l_monyear2 LIKE type_t.chr100, 
   l_sum LIKE type_t.num20_6, 
   l_lqrcode LIKE type_t.chr1000, 
   l_rqrcode LIKE type_t.chr1000, 
   l_barcode LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where conditon 
       a1 LIKE type_t.chr100,         #invoice number 
       a2 LIKE type_t.chr1,         #detail_show 
       a3 LIKE type_t.chr1          #補印否
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
DEFINE g_hex_str STRING
DEFINE g_isat026 LIKE isat_t.isat026
#end add-point
 
{</section>}
 
{<section id="aisr520_g01.main" readonly="Y" >}
PUBLIC FUNCTION aisr520_g01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where conditon 
DEFINE  p_arg2 LIKE type_t.chr100         #tm.a1  invoice number 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.a2  detail_show 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.a3  補印否
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #tm.a3 = 2 -->補印
   IF tm.a3 = 2 THEN LET tm.a3 = 'Y' ELSE LET tm.a3 = 'N' END IF
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aisr520_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aisr520_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aisr520_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aisr520_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisr520_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr520_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT '',isat001,isatcomp,isatent,isat004,isat009,isat010,isat011,isat012,isat007, 
#       isat008,isat006,isat115,isat022,isat113,isat114,'','','','','','','','','','','','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #160414-00018#34 --s mark
   #LET g_select = " SELECT '',isat001,isatcomp,isatent,isat004,isat009,isat010,isat011,isat012,isat007,isat008,isat006, 
   #                           isat115,isat022,isat113,isat114,'',isah006,isah004,(isah115/isah006),isah115,
   #                         '','','','','','','',''        "
   #160414-00018#34 --e mark   
   
   #160414-00018#34 --s add
   LET g_select = " SELECT CASE isat022 WHEN '1' THEN 'TX' WHEN '2' THEN 'TZ' WHEN '3' THEN '' END,", #課稅別
                  "        isat001,isatcomp,isatent,isat004,isat009,",
                  "        CASE WHEN isat010 IS NULL THEN '00000000' ELSE isat010 END,",
                  "        isat011,isat012,isat007,isat008,isat006,isat115,isat022,isat113,isat114,",
                  #格式 
                  "        CASE (SELECT isac004 FROM isac_t,ooef_t WHERE isacent = ooefent AND isacent = isatent ",        
                  "                 AND isac001 = ooef019 AND ooef001 = isatcomp AND isac002 = isat001)   ",
                  "                WHEN '31' THEN '21' WHEN '32' THEN '22' WHEN '35' THEN '25'  END , ",
                  "        isah006,isah004,(isah115/isah006),isah115,",
                  #對外全稱
                  "        (SELECT ooefl006 FROM ooefl_t WHERE ooeflent = isatent AND ooefl001 = isatcomp AND ooefl002 = '",g_dlang,"') l_ooefl006,",
                  "        '','','','','','',''        "
   #160414-00018#34 --e add

#   #end add-point
#    LET g_from = " FROM isat_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM isat_t,isah_t"
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = g_where CLIPPED ," AND isatent = isahent AND isah002 = isat004 AND isahdocno = isatdocno AND isat004 = '",tm.a1,"' ",
                                  " AND isatent = '",g_enterprise,"'  AND isat014 = '11' AND isat002 = 'Y'      "
#   #end add-point
#    LET g_order = " ORDER BY isat004"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
    LET g_order = " ORDER BY isahseq "
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("isat_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aisr520_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aisr520_g01_curs CURSOR FOR aisr520_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisr520_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisr520_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_taxtype LIKE type_t.chr30, 
   isat001 LIKE isat_t.isat001, 
   isatcomp LIKE isat_t.isatcomp, 
   isatent LIKE isat_t.isatent, 
   isat004 LIKE isat_t.isat004, 
   isat009 LIKE isat_t.isat009, 
   isat010 LIKE isat_t.isat010, 
   isat011 LIKE isat_t.isat011, 
   isat012 LIKE isat_t.isat012, 
   isat007 LIKE isat_t.isat007, 
   isat008 LIKE isat_t.isat008, 
   isat006 LIKE isat_t.isat006, 
   isat115 LIKE isat_t.isat115, 
   isat022 LIKE isat_t.isat022, 
   isat113 LIKE isat_t.isat113, 
   isat114 LIKE isat_t.isat114, 
   l_isac004 LIKE type_t.chr30, 
   l_isah006 LIKE isah_t.isah006, 
   l_isah004 LIKE isah_t.isah004, 
   l_isah101 LIKE isah_t.isah010, 
   l_isah115 LIKE isah_t.isah115, 
   l_ooefl006 LIKE ooefl_t.ooefl006, 
   l_isao010 LIKE isao_t.isao010, 
   l_yearmon LIKE type_t.chr100, 
   l_monyear2 LIKE type_t.chr100, 
   l_sum LIKE type_t.num20_6, 
   l_lqrcode LIKE type_t.chr1000, 
   l_rqrcode LIKE type_t.chr1000, 
   l_barcode LIKE type_t.chr100
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_yearmon STRING
DEFINE l_year    STRING
DEFINE l_smon    STRING
DEFINE l_emon    STRING
DEFINE l_day     STRING
DEFINE l_mdy     STRiNG
DEFINE l_track   STRING
DEFINE l_num     STRING
#DEFINE l_isac004 LIKE isac_t.isac004  #160414-00018#34 mark

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aisr520_g01_curs INTO sr_s.*
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
       #電子發票類型/開立
       SELECT isat026 INTO g_isat026 FROM isat_t WHERE isatent = g_enterprise AND isat004 = sr_s.isat004
          AND isat014 = '11' AND isat002 = 'Y'

       #160414-00018#34 --s mark
       ##對外全稱
       #SELECT ooefl006 INTO sr_s.l_ooefl006
       #  FROM ooefl_t WHERE ooeflent = g_enterprise
       #   AND ooefl001 = sr_s.isatcomp AND ooefl002 = g_dlang
       #160414-00018#34 --e mark
       
       #發票年月   
       LET l_year = YEAR(sr_s.isat007) - 1911
       LET l_smon  = MONTH(sr_s.isat007)
       IF l_smon MOD 2 = 0 THEN LET l_smon = l_smon - 1 END IF
       LET l_emon = l_smon + 1 
       LET l_smon = l_smon USING '&&'       
       LET l_emon = l_emon USING '&&'
       LET l_yearmon = l_year,'年',l_smon,'-',l_emon,'月'
       LET sr_s.l_yearmon = l_yearmon
       #發票號碼
       LET l_track = sr_s.isat004
       LET l_track = l_track.subString(1,2)
       LET l_num = sr_s.isat004
       LET l_num = l_num.subString(3,10)
       LET l_num = l_track,'-',l_num
       LET sr_s.isat004 = l_num
       #發票日期
       LET l_year = YEAR(sr_s.isat007) LET l_smon  = MONTH(sr_s.isat007) LET l_day = DAY(sr_s.isat007)
       LET l_mdy = l_year CLIPPED,'-',l_smon CLIPPED,'-',l_day
       
       LET sr_s.l_monyear2 = l_year CLIPPED,'-',l_smon USING '&&' CLIPPED,'-',l_day
       #160414-00018#34 --s mark
       ##格式       
       #SELECT isac004 INTO l_isac004
       #  FROM isac_t,ooef_t 
       # WHERE isacent = ooefent AND isacent = g_enterprise           
       #   AND isac001 = ooef019
       #   AND ooef001 = sr_s.isatcomp
       #   AND isac002 = sr_s.isat001 
       #CASE l_isac004 
       #   WHEN '31' LET sr_s.l_isac004 = '21'
       #   WHEN '32' LET sr_s.l_isac004 = '22'
       #   WHEN '35' LET sr_s.l_isac004 = '25'
       #END CASE
       #160414-00018#34 --e mark
       IF cl_null(sr_s.isat010) THEN LET sr_s.isat010 = '00000000' END IF
       #160414-00018#34 --s mark
       ##課稅別
       #CASE sr_s.isat022
       #   WHEN 1 LET sr_s.l_taxtype = 'TX'
       #   WHEN 2 LET sr_s.l_taxtype = 'TZ'
       #   WHEN 3 LET sr_s.l_taxtype = ''
       #END CASE
       #160414-00018#34 --e mark
       #總金額
       LET sr_s.l_sum = sr_s.isat113 + sr_s.isat114
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_taxtype = sr_s.l_taxtype
       LET sr[l_cnt].isat001 = sr_s.isat001
       LET sr[l_cnt].isatcomp = sr_s.isatcomp
       LET sr[l_cnt].isatent = sr_s.isatent
       LET sr[l_cnt].isat004 = sr_s.isat004
       LET sr[l_cnt].isat009 = sr_s.isat009
       LET sr[l_cnt].isat010 = sr_s.isat010
       LET sr[l_cnt].isat011 = sr_s.isat011
       LET sr[l_cnt].isat012 = sr_s.isat012
       LET sr[l_cnt].isat007 = sr_s.isat007
       LET sr[l_cnt].isat008 = sr_s.isat008
       LET sr[l_cnt].isat006 = sr_s.isat006
       LET sr[l_cnt].isat115 = sr_s.isat115
       LET sr[l_cnt].isat022 = sr_s.isat022
       LET sr[l_cnt].isat113 = sr_s.isat113
       LET sr[l_cnt].isat114 = sr_s.isat114
       LET sr[l_cnt].l_isac004 = sr_s.l_isac004
       LET sr[l_cnt].l_isah006 = sr_s.l_isah006
       LET sr[l_cnt].l_isah004 = sr_s.l_isah004
       LET sr[l_cnt].l_isah101 = sr_s.l_isah101
       LET sr[l_cnt].l_isah115 = sr_s.l_isah115
       LET sr[l_cnt].l_ooefl006 = sr_s.l_ooefl006
       LET sr[l_cnt].l_isao010 = sr_s.l_isao010
       LET sr[l_cnt].l_yearmon = sr_s.l_yearmon
       LET sr[l_cnt].l_monyear2 = sr_s.l_monyear2
       LET sr[l_cnt].l_sum = sr_s.l_sum
       LET sr[l_cnt].l_lqrcode = sr_s.l_lqrcode
       LET sr[l_cnt].l_rqrcode = sr_s.l_rqrcode
       LET sr[l_cnt].l_barcode = sr_s.l_barcode
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr520_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisr520_g01_rep_data()
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
          START REPORT aisr520_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aisr520_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aisr520_g01_rep
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
 
{<section id="aisr520_g01.rep" readonly="Y" >}
PRIVATE REPORT aisr520_g01_rep(sr1)
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
DEFINE l_detail_show    LIKE type_t.chr1
DEFINE l_isat010_show   LIKE type_t.chr1
DEFINE l_code39         STRING
DEFINE l_qrcode1        STRING
DEFINE l_qrcode2        STRING
DEFINE l_year           STRING
DEFINE l_mon            STRING
DEFINE l_yearmonth      STRING
DEFINE l_n              LIKE type_t.num5
DEFINE l_isat004        CHAR(10)
DEFINE l_isat006        CHAR(4)
DEFINE l_isat113        CHAR(8)
DEFINE l_isat115        CHAR(8)
DEFINE l_isat010        CHAR(8)
DEFINE l_isat012        CHAR(8)
DEFINE l_ooef002        CHAR(8)
DEFINE l_memo           CHAR(10)
DEFINE l_code           CHAR(1)
DEFINE l_all_row        STRING
DEFINE l_all            CHAR(1)   
DEFINE l_str            STRING
DEFINE l_isah004        LIKE isah_t.isah004
DEFINE l_isah006        LIKE type_t.num5
DEFINE l_isah101        LIKE type_t.num5
DEFINE l_isat113e       STRING
DEFINE l_isat114e       STRING
DEFINE l_isat115e       STRING
DEFINE l_yuan           LIKE type_t.chr30
DEFINE l_num113         LIKE type_t.num10
DEFINE l_num114         LIKE type_t.num10
DEFINE l_title          LIKE gzzd_t.gzzd005
DEFINE l_isao010        LIKE isao_t.isao010 #取金鑰
DEFINE l_aes_key        STRING 
DEFINE l_data           STRING
DEFINE rqrstr           STRING
DEFINE l_isat008        STRING
DEFINE l_hour           STRING
DEFINE l_min            STRING
DEFINE l_sec            STRING
#151230-00003#15 add ------
DEFINE l_title2         LIKE gzzd_t.gzzd005
DEFINE l_tax1           LIKE isat_t.isat022 #應稅
DEFINE l_tax2           LIKE isat_t.isat022 #零稅率
DEFINE l_tax3           LIKE isat_t.isat022 #免稅
DEFINE l_sum_chinese    STRING
DEFINE l_show1          LIKE type_t.chr10
DEFINE l_show2          LIKE type_t.chr10
DEFINE l_show3          LIKE type_t.chr10
DEFINE l_body_cnt       LIKE type_t.num5
DEFINE l_sell_name      LIKE ooefl_t.ooefl004
DEFINE l_sell_address   LIKE oofb_t.oofb017
#151230-00003#15 add end---
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.isat004
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
        BEFORE GROUP OF sr1.isat004
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.isat004
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'isatent=' ,sr1.isatent,'{+}isatcomp=' ,sr1.isatcomp,'{+}isat004=' ,sr1.isat004         
            CALL cl_gr_init_apr(sr1.isat004)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
            LET l_body_cnt = 0  #151230-00003#15
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.isat004.before name="rep.b_group.isat004.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.isatent CLIPPED ,"'", " AND  ooff003 = '", sr1.isat004 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr520_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aisr520_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aisr520_g01_subrep01
           DECLARE aisr520_g01_repcur01 CURSOR FROM g_sql
           FOREACH aisr520_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr520_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aisr520_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aisr520_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.isat004.after name="rep.b_group.isat004.after"
           #組一維條碼/發票期別
           LET l_year = YEAR(sr1.isat007) - 1911 
           LET l_mon = MONTH(sr1.isat007) 
           IF l_mon MOD 2 = 1 THEN LET l_mon = l_mon + 1 END IF 
           LET l_mon = l_mon USING '&&'
           LET l_yearmonth = l_year.trim() CLIPPED,l_mon
           LET l_yearmonth = l_yearmonth.subString(1,5)  
           #一維條碼           
           LET l_code39 = l_yearmonth CLIPPED,tm.a1 CLIPPED,sr1.isat006 CLIPPED
           LET sr1.l_barcode = l_yearmonth CLIPPED,tm.a1 CLIPPED,sr1.isat006 CLIPPED
           #組左邊QRcode
           #發票號碼
           LET l_isat004 = tm.a1
           
           #發票日期           
           LEt l_yearmonth = YEAR(sr1.isat007) - 1911,MONTH(sr1.isat007) USING '&&',DAY(sr1.isat007) USING '&&'
           LET l_yearmonth = l_yearmonth.trim()
           LET l_yearmonth = l_yearmonth.subString(1,7)
           #隨機碼
           LET l_isat006 = sr1.isat006  
           IF cl_null(l_isat006) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'ais-00286'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             RETURN
           END IF
           #銷售額轉16進位
           LET g_hex_str = NULL
           CALL aisr520_g01_switch_hex(sr1.isat113)
           LET l_n = g_hex_str.getLength()
           CALL aisr520_g01_add_zero(l_n,g_hex_str) RETURNING l_isat113
           #含稅總金額轉16進位
           LET g_hex_str = NULL
           CALL aisr520_g01_switch_hex(sr1.isat115)
           LET l_n = g_hex_str.getLength()
           CALL aisr520_g01_add_zero(l_n,g_hex_str) RETURNING l_isat115
           #買方統一編號
           IF cl_null(sr1.isat010) THEN
              LET l_isat010 = '00000000'
           ELSE
              LET l_isat010 = sr1.isat010
           END IF
           #賣方統一編號
           SELECT ooef002 INTO l_ooef002 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = sr1.isatcomp
           #取金鑰
           SELECT isao010 INTO l_isao010 FROM isao_t WHERE isaoent = g_enterprise AND isaosite = sr1.isatcomp
           LET l_str = l_isao010
           LET l_cnt = l_str.getLength() #加密金鑰長度32個字元
           #151230-00003#15 mark ------
           #IF cl_null(l_isao010) OR l_cnt <> 32 THEN
           #  INITIALIZE g_errparam TO NULL
           #  LET g_errparam.code = 'ais-00285'
           #  LET g_errparam.extend = ''
           #  LET g_errparam.popup = TRUE
           #  CALL cl_err()
           #  RETURN
           #END IF
           #151230-00003#15 mark end------
           LET l_data = tm.a1,l_isat006
           
           #AES加密
           IF NOT cl_null(l_isao010) AND l_cnt = 32 THEN #151230-00003#15
              CALL aisr520_g01_get_aeskey(l_isao010,l_data) RETURNING g_sub_success,g_errno,l_aes_key
              IF NOT g_sub_success THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = l_aes_key
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 RETURN
              END IF
           END IF #151230-00003#15
           
           #以下以冒號填入
           
           #營業人自行使用區
           LET l_memo = "**********"
           #交易品項總筆數
           LET l_n = 0
           SELECT COUNT(*) INTO l_n 
             FROM isah_t WHERE isahent = g_enterprise
              AND isah002 = tm.a1
           LET l_all_row = l_n
           
           #記錄左右兩個二維條碼記載消費品目筆數(預設最多4個)
           IF l_all_row >= 4 THEN
              LET l_all = 4 
           ELSE
              LET l_all = l_all_row
           END IF              
           #中文編碼參數--UTF-8
           LET l_code = "1"          
           #品名/數量/單價 4筆
           LET l_n = 1 
           LET l_str = ''          
           LET rqrstr = ''          
           LET g_sql = " SELECT isah004,isah006,isah101        ",
                       "   FROM isah_t                         ",
                       "  WHERE isahent = '",g_enterprise,"'   ",
                       "    AND isah002 = '",tm.a1,"'          "
           PREPARE aisr520_isah_prep01 FROM g_sql
           DECLARE aisr520_isah_curs01 CURSOR FOR aisr520_isah_prep01           
           FOREACH aisr520_isah_curs01 INTO l_isah004,l_isah006,l_isah101
              IF l_n > 4 THEN EXIT FOREACH END IF
              #左邊qrcode 第一個商品
              IF l_n = 1 THEN
                 LET l_str = l_isah004 CLIPPED||':'||l_isah006 CLIPPED||':'||l_isah101 CLIPPED                
              END IF
              #右邊qrcode 2到四個商品
              IF l_n  = 2 THEN
                  LET rqrstr = l_isah004 CLIPPED||':'||l_isah006 CLIPPED||':'||l_isah101 CLIPPED #右邊qrcode 二到四個商品
              END IF
              IF l_n > 2 THEN 
                 LET rqrstr = rqrstr CLIPPED,':',l_isah004 CLIPPED||':'||l_isah006 CLIPPED||':'||l_isah101 CLIPPED #右邊qrcode 二到四個商品
              END IF
              
              LET l_n = l_n + 1                                      
           END FOREACH
                       
           LET l_qrcode1 = l_isat004 CLIPPED,l_yearmonth CLIPPED,l_isat006 CLIPPED,
                           l_isat113 CLIPPED,l_isat115 CLIPPED,l_isat010 CLIPPED,
                           l_ooef002 CLIPPED,l_aes_key CLIPPED,
                           ':',l_memo CLIPPED,':',l_all_row CLIPPED,':',l_all CLIPPED,
                           ':',l_code,':',l_str CLIPPED
                           
           LET sr1.l_lqrcode = l_isat004 CLIPPED,l_yearmonth CLIPPED,l_isat006 CLIPPED,
                               l_isat113 CLIPPED,l_isat115 CLIPPED,l_isat010 CLIPPED,
                               l_ooef002 CLIPPED,l_aes_key CLIPPED,
                               ':',l_memo CLIPPED,':',l_all_row CLIPPED,':',l_all CLIPPED,
                               ':',l_code,':',l_str CLIPPED
  
  
  

           
           LET l_qrcode2 = '**',rqrstr
           LET sr1.l_rqrcode = '**',rqrstr
           
           PRINTX l_code39,l_qrcode1,l_qrcode2
           #取時間
           LET l_isat008 = sr1.isat008
           LET l_hour = l_isat008.subString(12,13)
           LET l_min  = l_isat008.subString(15,16)
           LET l_sec = l_isat008.subString(18,19)
           LET l_isat008 = l_hour CLIPPED||':'|| l_min CLIPPED||':'||l_sec CLIPPED           
           #是否補印
           IF tm.a3 = 'Y' THEN #補印
              SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd003 = 'lbl_title2' AND gzzd002 = g_dlang AND gzzd001 = 'aisr520'
           ELSE
              SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd003 = 'lbl_title'  AND gzzd002 = g_dlang AND gzzd001 = 'aisr520'
           END IF                     
           #是否列印明細
           LET l_detail_show = 'N'
           IF tm.a2 = 'Y' THEN LET l_detail_show = 'Y' END IF
           #判斷l_isat026類型
           LET l_isat010_show = 'N'         
           CASE g_isat026 
              WHEN 6
                 LET l_isat010_show = 'N' 
              OTHERWISE
                 LET l_isat010_show = 'Y'
           END CASE

           PRINTX l_detail_show,l_isat010_show,l_title,l_isat008
           #151230-00003#15 add ------
           #A4格式印第二頁的title
           SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'lbl_title3' AND gzzd002 = g_dlang AND gzzd001 = 'aisr520'
           PRINTX l_title2
           #賣方名稱
           SELECT ooefl006 INTO l_sell_name
             FROM ooefl_t
            WHERE ooeflent = g_enterprise
              AND ooefl001 = sr1.isatcomp
              AND ooefl002 = g_dlang
           #賣方地址
           SELECT oofb017 INTO l_sell_address
             FROM ooef_t
             LEFT JOIN oofb_t ON ooefent=oofbent AND ooef012=oofb002
            WHERE ooefent = g_enterprise
              AND ooef001 = sr1.isatcomp
              AND oofbstus='Y' AND oofb008='1' AND oofb010='Y'
           PRINTX l_sell_name,l_sell_address
           #151230-00003#15 add end---
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
                sr1.isatent CLIPPED ,"'", " AND  ooff003 = '", sr1.isat004 CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr520_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aisr520_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aisr520_g01_subrep02
           DECLARE aisr520_g01_repcur02 CURSOR FROM g_sql
           FOREACH aisr520_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr520_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aisr520_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aisr520_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #151230-00003#15 add ------
          LET l_show1 = "N"
          LET l_show2 = "N"
          LET l_show3 = "N"
          LET l_body_cnt = l_body_cnt + 1
          IF l_body_cnt = 20 OR (l_body_cnt = l_all_row AND l_all_row < 20 ) THEN
             LET l_show1 = "Y"
          END IF
          IF l_body_cnt = l_all_row THEN
             LET l_show2 = "Y"
          END IF
          IF (l_body_cnt = l_all_row AND l_body_cnt > 20) OR (l_body_cnt MOD 20 = 0 AND l_body_cnt > 20) THEN
             LET l_show3 = "Y"
          END IF
          PRINTX l_show1,l_show2,l_show3
          #151230-00003#15 add end---
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
                sr1.isatent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr520_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aisr520_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aisr520_g01_subrep03
           DECLARE aisr520_g01_repcur03 CURSOR FROM g_sql
           FOREACH aisr520_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr520_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aisr520_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aisr520_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isat004
 
           #add-point:rep.a_group.isat004.before name="rep.a_group.isat004.before"
           LET l_yuan = cl_getmsg('-12810',g_dlang)          
           LET l_num113 = sr1.isat113     
           LET l_num114 = sr1.isat114 
           LET l_isat113e = l_num113,l_yuan 
           LET l_isat113e = l_isat113e.trim()
           LET l_isat114e = l_num114,l_yuan  
           LET l_isat114e = l_isat114e.trim()           
           LET l_isat115e = l_num113 + l_num114,l_yuan 
           LET l_isat115e = l_isat115e.trim()   
           PRINTX l_isat113e,l_isat114e,l_isat115e
           
           #151230-00003#15 add ------
           #課稅別
           CASE sr1.isat022
              WHEN 1 #應稅
                 LET l_tax1 = 'V' LET l_tax2 = '' LET l_tax3 = ''
              WHEN 2 #零稅率
                 LET l_tax1 = '' LET l_tax2 = 'V' LET l_tax3 = ''
              WHEN 3 #免稅
                 LET l_tax1 = '' LET l_tax2 = '' LET l_tax3 = 'V'
           END CASE
           PRINTX l_tax1,l_tax2,l_tax3
           #總計金額(中文呈現)
           CALL s_num_to_chinese(sr1.l_sum) RETURNING l_sum_chinese
           PRINTX l_sum_chinese
           #151230-00003#15 add end---
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.isatent CLIPPED ,"'", " AND  ooff003 = '", sr1.isat004 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr520_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aisr520_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aisr520_g01_subrep04
           DECLARE aisr520_g01_repcur04 CURSOR FROM g_sql
           FOREACH aisr520_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr520_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aisr520_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aisr520_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.isat004.after name="rep.a_group.isat004.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aisr520_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisr520_g01_subrep01(sr2)
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
PRIVATE REPORT aisr520_g01_subrep02(sr2)
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
PRIVATE REPORT aisr520_g01_subrep03(sr2)
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
PRIVATE REPORT aisr520_g01_subrep04(sr2)
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
 
{<section id="aisr520_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 轉16進位
# Memo...........:
# Usage..........: CALL aisr520_g01_switch_hex(p_num)
# Date & Author..: 2016/01/19 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_g01_switch_hex(p_num)
DEFINE p_num     LIKE isat_t.isat113   
DEFINE l_num     LIKE type_t.num10
DEFINE l_num1    LIKE type_t.num10
DEFINE l_n1      LIKE type_t.num15_3
DEFINE l_n2      LIKE type_t.num10
DEFINE l_cnt     LIKE type_t.num10
DEFINE l_str     LIKE type_t.chr1

   LET l_num1 = p_num
   LET l_n1 = p_num/16
   LET l_n2 = l_n1
   IF l_n2 <> 0 THEN
      LET l_num = l_n2 * 16
      LET l_cnt = p_num - l_num
      CASE l_cnt
         WHEN "10" LET l_str = "A" 
         WHEN "11" LET l_str = "B"
         WHEN "12" LET l_str = "C"
         WHEN "13" LET l_str = "D"
         WHEN "14" LET l_str = "E"
         WHEN "15" LET l_str = "F"
         OTHERWISE LET l_str = l_cnt  
      END CASE
      IF cl_null(g_hex_str) THEN
         LET g_hex_str = l_str
      ELSE
         LET g_hex_str = l_str,g_hex_str
      END IF
      CALL aisr520_g01_switch_hex(l_n2)
   ELSE
      LET l_cnt = p_num
      CASE l_cnt
         WHEN "10" LET l_str = "A" 
         WHEN "11" LET l_str = "B" 
         WHEN "12" LET l_str = "C"
         WHEN "13" LET l_str = "D"
         WHEN "14" LET l_str = "E"
         WHEN "15" LET l_str = "F"
         OTHERWISE LET l_str = l_cnt 
      END CASE
      IF cl_null(g_hex_str) THEN
         LET g_hex_str = l_str
      ELSE  
         LET g_hex_str = l_str,g_hex_str
      END IF
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 金額補位
# Memo...........:
# Usage..........: CALL aisr520_g01_add_zero(p_num,p_price)
# Date & Author..: 2016/01/19 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_g01_add_zero(p_num,p_price)
DEFINE p_num        LIKE type_t.num5
DEFINE p_price      CHAR(8)
DEFINE i            LIKE type_t.num5
DEFINE r_price_all  STRING
   
   IF p_num > 0 THEN
      FOR i=1 TO (8-p_num)
         IF i=1 THEN
            LET r_price_all = '0'
         ELSE
            LET r_price_all = r_price_all,'0'
         END IF
      END FOR
      LET r_price_all = r_price_all,p_price
   ELSE
      LET r_price_all = '00000000'
   END IF
   RETURN r_price_all
   
END FUNCTION

################################################################################
# Descriptions...: AES加密
# Memo...........:
# Usage..........: CALL aisr520_g01_get_aeskey(p_key,p_data)
# Date & Author..: 2016/01/26 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_g01_get_aeskey(p_key,p_data)
DEFINE p_key          STRING 
DEFINE p_data         STRING
DEFINE r_success      LIKE type_t.num5
DEFINE r_errno        LIKE gzze_t.gzze001       
DEFINE l_qrcode       com.dsc.t100.qrcode.QRcode
DEFINE r_msg          STRING
DEFINE l_err          STRING

   
   LET r_success = TRUE
  
   LET l_qrcode = QRcode.create()
   CALL l_qrcode.doStartQrcode(p_key,p_data) RETURNING r_msg
   LET l_err = r_msg.subString(1,5)
   IF l_err = 'Error' THEN
      LET r_success = FALSE
      LET r_errno = 'ais-00282'   
   END IF
   DISPLAY "l_msg:",r_msg
   
   RETURN r_success,r_errno,r_msg

END FUNCTION

 
{</section>}
 
{<section id="aisr520_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
