#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr320_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-05-16 14:36:51), PR版次:0002(2016-05-17 09:22:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: aisr320_g01
#+ Description: ...
#+ Creator....: 05016(2014-07-02 14:04:54)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aisr320_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160414-00018#30 160516 albireo 效能調整
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
   isaf051 LIKE isaf_t.isaf051, 
   isaf008 LIKE isaf_t.isaf008, 
   isaf010 LIKE isaf_t.isaf010, 
   isaf009 LIKE isaf_t.isaf009, 
   isaf004 LIKE isaf_t.isaf004, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isaf011 LIKE isaf_t.isaf011, 
   isaf002 LIKE isaf_t.isaf002, 
   isaf016 LIKE isaf_t.isaf016, 
   isaf018 LIKE isaf_t.isaf018, 
   isaf017 LIKE isaf_t.isaf017, 
   isaf006 LIKE isaf_t.isaf006, 
   isaf036 LIKE isaf_t.isaf036, 
   isaf103 LIKE isaf_t.isaf103, 
   isaf104 LIKE isaf_t.isaf104, 
   isaf105 LIKE isaf_t.isaf105, 
   isaf106 LIKE isaf_t.isaf106, 
   isafcomp LIKE isaf_t.isafcomp, 
   isafstus LIKE isaf_t.isafstus, 
   isaf052 LIKE isaf_t.isaf052, 
   l_isaf052_ooefl003 LIKE type_t.chr100, 
   l_isaf008_desc LIKE type_t.chr100, 
   l_isaf004_ooefl003 LIKE type_t.chr100, 
   l_isaf002_pmaal004 LIKE type_t.chr100, 
   l_isaf036_gzcbl004 LIKE type_t.chr100, 
   isafdocno LIKE isaf_t.isafdocno, 
   l_isaf006_ooefl003 LIKE type_t.chr100, 
   isafent LIKE isaf_t.isafent, 
   l_isaf103_sum LIKE type_t.num20_6, 
   l_isaf104_sum LIKE type_t.num20_6, 
   l_isaf105_sum LIKE type_t.num20_6, 
   l_isaf106_sum LIKE type_t.num20_6, 
   isaf021 LIKE isaf_t.isaf021
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
 
#end add-point
 
{</section>}
 
{<section id="aisr320_g01.main" readonly="Y" >}
PUBLIC FUNCTION aisr320_g01(p_arg1)
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
   
   LET g_rep_code = "aisr320_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aisr320_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aisr320_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aisr320_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisr320_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr320_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT isaf051,isaf008,isaf010,isaf009,isaf004,isafdocdt,isaf011,isaf002,isaf016, 
       isaf018,isaf017,isaf006,isaf036,isaf103,isaf104,isaf105,isaf106,isafcomp,isafstus,isaf052,",
       "(SELECT tf52.ooefl003 FROM ooefl_t tf52 WHERE tf52.ooeflent = isafent AND tf52.ooefl001 = isaf052 AND tf52.ooefl002 = '",g_dlang,"'),",
       "(SELECT tf08.isacl004 FROM isacl_t tf08 WHERE tf08.isaclent = isafent AND tf08.isacl002 = isaf008 AND isacl003 = '",g_dlang,"' AND isacl001 = (SELECT ooef019 FROM ooef_t WHERE ooefent = isafent AND ooef001 = isafcomp) ),",
       "(SELECT tf04.ooefl003 FROM ooefl_t tf04 WHERE tf04.ooeflent = isafent AND tf04.ooefl001 = isaf004 AND tf04.ooefl002 = '",g_dlang,"'),",
       "'',",
       "(SELECT tf36.gzcbl004 FROM gzcbl_t tf36 WHERE tf36.gzcbl001 = '9716' AND tf36.gzcbl002 = isaf036 AND tf36.gzcbl003 = '",g_dlang,"'),",
       "isafdocno,",
       "(SELECT tf06.ooefl003 FROM ooefl_t tf06 WHERE tf06.ooeflent = isafent AND tf06.ooefl001 = isaf006 AND tf06.ooefl002 = '",g_dlang,"'),",
       "isafent,",
       "NULL,",
       "NULL,",
       "'',",
       "NULL,",
       "isaf021"
#   #end add-point
#   LET g_select = " SELECT isaf051,isaf008,isaf010,isaf009,isaf004,isafdocdt,isaf011,isaf002,isaf016, 
#       isaf018,isaf017,isaf006,isaf036,isaf103,isaf104,isaf105,isaf106,isafcomp,isafstus,isaf052,'', 
#       '','','','',isafdocno,'',isafent,NULL,NULL,'',NULL,isaf021"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM isaf_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
 
   #end add-point
    LET g_order = " ORDER BY isaf051,isaf004"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("isaf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aisr320_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aisr320_g01_curs CURSOR FOR aisr320_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisr320_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisr320_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   isaf051 LIKE isaf_t.isaf051, 
   isaf008 LIKE isaf_t.isaf008, 
   isaf010 LIKE isaf_t.isaf010, 
   isaf009 LIKE isaf_t.isaf009, 
   isaf004 LIKE isaf_t.isaf004, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isaf011 LIKE isaf_t.isaf011, 
   isaf002 LIKE isaf_t.isaf002, 
   isaf016 LIKE isaf_t.isaf016, 
   isaf018 LIKE isaf_t.isaf018, 
   isaf017 LIKE isaf_t.isaf017, 
   isaf006 LIKE isaf_t.isaf006, 
   isaf036 LIKE isaf_t.isaf036, 
   isaf103 LIKE isaf_t.isaf103, 
   isaf104 LIKE isaf_t.isaf104, 
   isaf105 LIKE isaf_t.isaf105, 
   isaf106 LIKE isaf_t.isaf106, 
   isafcomp LIKE isaf_t.isafcomp, 
   isafstus LIKE isaf_t.isafstus, 
   isaf052 LIKE isaf_t.isaf052, 
   l_isaf052_ooefl003 LIKE type_t.chr100, 
   l_isaf008_desc LIKE type_t.chr100, 
   l_isaf004_ooefl003 LIKE type_t.chr100, 
   l_isaf002_pmaal004 LIKE type_t.chr100, 
   l_isaf036_gzcbl004 LIKE type_t.chr100, 
   isafdocno LIKE isaf_t.isafdocno, 
   l_isaf006_ooefl003 LIKE type_t.chr100, 
   isafent LIKE isaf_t.isafent, 
   l_isaf103_sum LIKE type_t.num20_6, 
   l_isaf104_sum LIKE type_t.num20_6, 
   l_isaf105_sum LIKE type_t.num20_6, 
   l_isaf106_sum LIKE type_t.num20_6, 
   isaf021 LIKE isaf_t.isaf021
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooef019    LIKE ooef_t.ooef019   #稅區
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aisr320_g01_curs INTO sr_s.*
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
       #營運據點說明
       #160414-00018#30 mark-----s
       #SELECT ooefl003 INTO sr_s.l_isaf052_ooefl003
       #  FROM ooefl_t  
       # WHERE ooeflent = g_enterprise
       #   AND ooefl001 = sr_s.isaf052
       #   AND ooefl002 = g_dlang
       #160414-00018#30 mark-----e
       LET sr_s.l_isaf052_ooefl003 = sr_s.isaf052 ,'.', sr_s.l_isaf052_ooefl003
       
       #160414-00018#30 mark-----s
       ##歸屬法人稅區   
       #SELECT ooef019 INTO l_ooef019
       #  FROM ooef_t
       # WHERE ooef001 = sr_s.isafcomp
       #   AND ooefent = g_enterprise       
       #
       ##發票類型說明
       #
       #SELECT isacl004 INTO  sr_s.l_isaf008_desc
       #  FROM isacl_t
       # WHERE isaclent = g_enterprise
       #   AND isacl001 = l_ooef019       
       #   AND isacl002 = sr_s.isaf008
       #   AND isacl003 = g_dlang
       #160414-00018#30 mark-----e
      
       #業務組織說明
       #160414-00018#30 mark----s
       #SELECT ooefl003 INTO  sr_s.l_isaf004_ooefl003
       #  FROM ooefl_t  
       # WHERE ooeflent = g_enterprise
       #   AND ooefl001 = sr_s.isaf004
       #   AND ooefl002 = g_dlang
       #160414-00018#30 mark-----e
       LET  sr_s.l_isaf004_ooefl003 = sr_s.isaf004 ,'.', sr_s.l_isaf004_ooefl003
       
       # 業務部門
       #160414-00018#30-----s
       #SELECT ooefl003 INTO  sr_s.l_isaf006_ooefl003
       #  FROM ooefl_t  
       # WHERE ooeflent = g_enterprise
       #   AND ooefl001 = sr_s.isaf006
       #   AND ooefl002 = g_dlang
       #160414-00018#30-----e
       LET  sr_s.l_isaf006_ooefl003 = sr_s.isaf006 ,'.', sr_s.l_isaf006_ooefl003
       
       #異動狀態
       #160414-00018#30-----s
       #SELECT gzcbl004 INTO sr_s.l_isaf036_gzcbl004
       #  FROM gzcbl_t      
       # WHERE gzcbl001 = '9716'
       #   AND gzcbl002 = sr_s.isaf036
       #   AND gzcbl003 = g_dlang
       #160414-00018#30-----e
   
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].isaf051 = sr_s.isaf051
       LET sr[l_cnt].isaf008 = sr_s.isaf008
       LET sr[l_cnt].isaf010 = sr_s.isaf010
       LET sr[l_cnt].isaf009 = sr_s.isaf009
       LET sr[l_cnt].isaf004 = sr_s.isaf004
       LET sr[l_cnt].isafdocdt = sr_s.isafdocdt
       LET sr[l_cnt].isaf011 = sr_s.isaf011
       LET sr[l_cnt].isaf002 = sr_s.isaf002
       LET sr[l_cnt].isaf016 = sr_s.isaf016
       LET sr[l_cnt].isaf018 = sr_s.isaf018
       LET sr[l_cnt].isaf017 = sr_s.isaf017
       LET sr[l_cnt].isaf006 = sr_s.isaf006
       LET sr[l_cnt].isaf036 = sr_s.isaf036
       LET sr[l_cnt].isaf103 = sr_s.isaf103
       LET sr[l_cnt].isaf104 = sr_s.isaf104
       LET sr[l_cnt].isaf105 = sr_s.isaf105
       LET sr[l_cnt].isaf106 = sr_s.isaf106
       LET sr[l_cnt].isafcomp = sr_s.isafcomp
       LET sr[l_cnt].isafstus = sr_s.isafstus
       LET sr[l_cnt].isaf052 = sr_s.isaf052
       LET sr[l_cnt].l_isaf052_ooefl003 = sr_s.l_isaf052_ooefl003
       LET sr[l_cnt].l_isaf008_desc = sr_s.l_isaf008_desc
       LET sr[l_cnt].l_isaf004_ooefl003 = sr_s.l_isaf004_ooefl003
       LET sr[l_cnt].l_isaf002_pmaal004 = sr_s.l_isaf002_pmaal004
       LET sr[l_cnt].l_isaf036_gzcbl004 = sr_s.l_isaf036_gzcbl004
       LET sr[l_cnt].isafdocno = sr_s.isafdocno
       LET sr[l_cnt].l_isaf006_ooefl003 = sr_s.l_isaf006_ooefl003
       LET sr[l_cnt].isafent = sr_s.isafent
       LET sr[l_cnt].l_isaf103_sum = sr_s.l_isaf103_sum
       LET sr[l_cnt].l_isaf104_sum = sr_s.l_isaf104_sum
       LET sr[l_cnt].l_isaf105_sum = sr_s.l_isaf105_sum
       LET sr[l_cnt].l_isaf106_sum = sr_s.l_isaf106_sum
       LET sr[l_cnt].isaf021 = sr_s.isaf021
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr320_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisr320_g01_rep_data()
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
          START REPORT aisr320_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aisr320_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aisr320_g01_rep
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
 
{<section id="aisr320_g01.rep" readonly="Y" >}
PRIVATE REPORT aisr320_g01_rep(sr1)
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
DEFINE l_isaf103_sum     LIKE type_t.num20_6
DEFINE l_isaf104_sum     LIKE type_t.num20_6
DEFINE l_isaf105_sum     LIKE type_t.num20_6
DEFINE l_isaf106_sum     LIKE type_t.num20_6

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.isaf051,sr1.isaf004
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
        BEFORE GROUP OF sr1.isaf051
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.isaf051
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'isafent=' ,sr1.isafent,'{+}isafcomp=' ,sr1.isafcomp,'{+}isafdocno=' ,sr1.isafdocno         
            CALL cl_gr_init_apr(sr1.isaf051)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.isaf051.before name="rep.b_group.isaf051.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaf051 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr320_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aisr320_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aisr320_g01_subrep01
           DECLARE aisr320_g01_repcur01 CURSOR FROM g_sql
           FOREACH aisr320_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr320_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aisr320_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aisr320_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.isaf051.after name="rep.b_group.isaf051.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.isaf004
 
           #add-point:rep.b_group.isaf004.before name="rep.b_group.isaf004.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.isaf004.after name="rep.b_group.isaf004.after"
           
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
                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaf051 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.isaf004 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr320_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aisr320_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aisr320_g01_subrep02
           DECLARE aisr320_g01_repcur02 CURSOR FROM g_sql
           FOREACH aisr320_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr320_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aisr320_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aisr320_g01_subrep02
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
                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaf051 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.isaf004 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr320_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aisr320_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aisr320_g01_subrep03
           DECLARE aisr320_g01_repcur03 CURSOR FROM g_sql
           FOREACH aisr320_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr320_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aisr320_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aisr320_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isaf051
 
           #add-point:rep.a_group.isaf051.before name="rep.a_group.isaf051.before"
            
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.isafent CLIPPED ,"'", " AND  ooff003 = '", sr1.isaf051 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisr320_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aisr320_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aisr320_g01_subrep04
           DECLARE aisr320_g01_repcur04 CURSOR FROM g_sql
           FOREACH aisr320_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisr320_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aisr320_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aisr320_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.isaf051.after name="rep.a_group.isaf051.after"
           LET l_isaf103_sum = GROUP SUM(sr1.isaf103)
           LET l_isaf104_sum = GROUP SUM(sr1.isaf104)
           LET l_isaf105_sum = GROUP SUM(sr1.isaf105)
           LET l_isaf106_sum = GROUP SUM(sr1.isaf106)
           PRINTX l_isaf103_sum
           PRINTX l_isaf104_sum
           PRINTX l_isaf105_sum
           PRINTX l_isaf106_sum
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isaf004
 
           #add-point:rep.a_group.isaf004.before name="rep.a_group.isaf004.before"
       
           #end add-point:
 
 
           #add-point:rep.a_group.isaf004.after name="rep.a_group.isaf004.after"
     
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
        
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
 
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aisr320_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisr320_g01_subrep01(sr2)
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
PRIVATE REPORT aisr320_g01_subrep02(sr2)
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
PRIVATE REPORT aisr320_g01_subrep03(sr2)
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
PRIVATE REPORT aisr320_g01_subrep04(sr2)
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
 
{<section id="aisr320_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aisr320_g01.other_report" readonly="Y" >}

 
{</section>}
 
