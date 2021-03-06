#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr080_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2017-01-10 17:33:35), PR版次:0002(2017-01-10 17:35:40)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: apmr080_x01
#+ Description: ...
#+ Creator....: 06821(2016-05-03 09:41:37)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="apmr080_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#161221-00064#11  2017/01/10  By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmr080_x01.main" readonly="Y" >}
PUBLIC FUNCTION apmr080_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apmr080_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apmr080_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apmr080_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apmr080_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apmr080_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apmr080_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apmr080_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apmr080_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "pmdxdocno.pmdx_t.pmdxdocno,pmdxdocdt.pmdx_t.pmdxdocdt,pmdxstus.pmdx_t.pmdxstus,l_pmdxstus_desc.type_t.chr500,pmdx002.pmdx_t.pmdx002,l_pmdx002_desc.type_t.chr500,pmdx003.pmdx_t.pmdx003,l_pmdx003_desc.type_t.chr500,pmdx004.pmdx_t.pmdx004,l_pmdx004_desc.type_t.chr500,pmdx005.pmdx_t.pmdx005,l_pmdx005_desc.type_t.chr500,pmdx006.pmdx_t.pmdx006,l_pmdx006_desc.type_t.chr500,pmdx007.pmdx_t.pmdx007,pmdx008.pmdx_t.pmdx008,pmdx009.pmdx_t.pmdx009,l_pmdx009_desc.type_t.chr500,pmdx011.pmdx_t.pmdx011,l_pmdx011_desc.type_t.chr500,pmdx018.pmdx_t.pmdx018,l_pmdx018_desc.type_t.chr500,pmdx014.pmdx_t.pmdx014,pmdx015.pmdx_t.pmdx015,pmdyseq.pmdy_t.pmdyseq,pmdy002.pmdy_t.pmdy002,l_pmdy002_desc.type_t.chr500,l_pmdy002_desc_desc.type_t.chr500,pmdy003.pmdy_t.pmdy003,l_pmdy003_desc.type_t.chr500,pmdy005.pmdy_t.pmdy005,l_pmdy005_desc.type_t.chr500,l_pmdy005_desc_desc.type_t.chr500,pmdy008.pmdy_t.pmdy008,l_pmdy008_desc.type_t.chr500,pmdy009.pmdy_t.pmdy009,pmdy010.pmdy_t.pmdy010,pmdy017.pmdy_t.pmdy017,pmdy019.pmdy_t.pmdy019,pmdy018.pmdy_t.pmdy018,pmdysite.pmdy_t.pmdysite,pmdxsite.pmdx_t.pmdxsite,pmdyent.pmdy_t.pmdyent,pmdxent.pmdx_t.pmdxent" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   #子報表
   LET g_sql =" pmdzent.pmdz_t.pmdzent, ",
              " pmdzdocno.pmdz_t.pmdzdocno,",
              " pmdzseq.pmdz_t.pmdzseq, ",
              " pmdzseq1.pmdz_t.pmdzseq1, ",
              " pmdz001.pmdz_t.pmdz001, ",
              " pmdz002.pmdz_t.pmdz002, ",
              " pmdz003.pmdz_t.pmdz003  "
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'
   END IF 
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apmr080_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apmr080_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         #子報表
         WHEN 2
            LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED,
                        " VALUES(?,?,?,?,?,?,?)"
            PREPARE insert_prep1 FROM g_sql
            IF STATUS THEN
               LET l_prep_str = "insert_prep1",i
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_prep_str
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               CALL cl_xg_drop_tmptable()
               LET g_rep_success = 'N'
            END IF
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="apmr080_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr080_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select =  " SELECT pmdxdocno,pmdxdocdt,pmdxstus,  ",
                   " (SELECT pmdxstus||'.'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = pmdxstus AND gzcbl003= '",g_dlang,"' ),    ",
                   "  pmdx002,(SELECT ooag011  FROM ooag_t WHERE ooagent = pmdxent AND ooag001 = pmdx002),                                        ",
                   "  pmdx003,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = pmdxent AND ooefl001 = pmdx003 AND ooefl002 = '",g_dlang,"' ),       ",
                   "  pmdx004,(SELECT pmaal003 FROM pmaal_t WHERE pmaalent = pmdxent AND pmaal001 = pmdx004 AND pmaal002 = '",g_dlang,"' ),       ",
                   "  pmdx005,(SELECT ooail003 FROM ooail_t WHERE ooailent = pmdxent AND ooail001 = pmdx005 AND ooail002 = '",g_dlang,"' ),       ",
                   "  pmdx006,(SELECT oodbl004 FROM oodbl_t,ooef_t WHERE oodblent = pmdxent AND oodblent = ooefent AND ooef001 = pmdxsite         ", 
                   "                                                AND ooef019 = oodbl001 AND oodbl002 = pmdx006 AND oodbl003 = '",g_dlang,"'),  ",
                   "  pmdx007/100,pmdx008,                                                                                                            ",
                   "  pmdx009,(SELECT ooibl004 FROM ooibl_t WHERE ooiblent = pmdxent AND ooibl002 = pmdx009 AND ooibl003 = '",g_dlang,"' ) ,      ",
                   "  pmdx011,(SELECT oocql004 FROM oocql_t WHERE oocqlent = pmdxent AND oocql001 = '238' AND oocql002 = pmdx011 AND oocql003= '",g_dlang,"' ), ",
                   "  pmdx018,(SELECT pmdx018||':'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2066' AND gzcbl002 = pmdx018 AND gzcbl003= '",g_dlang,"' ), ", #管制方式
                   "  pmdx014,pmdx015,pmdyseq,  ",
                   "  pmdy002,(SELECT imaal003 FROM imaal_t WHERE imaalent = pmdyent AND imaal001 = pmdy002 AND imaal002 = '",g_dlang,"' ),   ",
                   "          (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdyent AND imaal001 = pmdy002 AND imaal002 = '",g_dlang,"' ),   ",
                   "  pmdy003,'',  ",
                   "  pmdy005, ",
                   #161221-00064#11 mod-S
#                   "  (SELECT pmao009 FROM pmao_t WHERE pmaoent = pmdyent AND pmao001 = pmdx004 AND pmao002 = pmdy002 AND pmao003 = pmdy003 AND pmao004 = pmdy005), ",
#                   "  (SELECT pmao010 FROM pmao_t WHERE pmaoent = pmdyent AND pmao001 = pmdx004 AND pmao002 = pmdy002 AND pmao003 = pmdy003 AND pmao004 = pmdy005), ",
                   "  (SELECT pmao009 FROM pmao_t WHERE pmaoent = pmdyent AND pmao000 = '1' AND pmao001 = pmdx004 AND pmao002 = pmdy002 AND pmao003 = pmdy003 AND pmao004 = pmdy005), ",
                   "  (SELECT pmao010 FROM pmao_t WHERE pmaoent = pmdyent AND pmao000 = '1' AND pmao001 = pmdx004 AND pmao002 = pmdy002 AND pmao003 = pmdy003 AND pmao004 = pmdy005), ",
                   #161221-00064#11 mod-E
                   "  pmdy008,(SELECT oocal003 FROM oocal_t WHERE oocalent = pmdyent AND oocal001 = pmdy008 AND oocal002 = '",g_dlang,"'),     ",
                   "  pmdy009,pmdy010,pmdy017,pmdy019,pmdy018, ",
                   "  pmdysite,pmdxsite,pmdyent,pmdxent "
#   #end add-point
#   LET g_select = " SELECT pmdxdocno,pmdxdocdt,pmdxstus,'',pmdx002,'',pmdx003,'',pmdx004,'',pmdx005, 
#       '',pmdx006,'',pmdx007,pmdx008,pmdx009,'',pmdx011,'',pmdx018,'',pmdx014,pmdx015,pmdyseq,pmdy002, 
#       '','',pmdy003,'',pmdy005,'','',pmdy008,'',pmdy009,pmdy010,pmdy017,pmdy019,pmdy018,pmdysite,pmdxsite, 
#       pmdyent,pmdxent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from  =  " FROM pmdx_t                                                       ",
                  "      LEFT JOIN pmaa_t ON pmaa001 = pmdx004 AND pmaaent = pmdxent  ",
                  "      ,pmdy_t                                                      ",
                  "      LEFT JOIN imaa_t ON imaaent = pmdyent AND imaa001 = pmdy002  ",
                  "      LEFT JOIN imaf_t ON imafent = pmdyent AND imafsite = pmdysite AND imaf001 = pmdy002 " 
#   #end add-point
#    LET g_from = " FROM pmdx_t,pmdy_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = "  WHERE pmdxent = pmdyent AND pmdxdocno = pmdydocno AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("pmdx_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE apmr080_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apmr080_x01_curs CURSOR FOR apmr080_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apmr080_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION apmr080_x01_ins_data()
DEFINE sr RECORD 
   pmdxdocno LIKE pmdx_t.pmdxdocno, 
   pmdxdocdt LIKE pmdx_t.pmdxdocdt, 
   pmdxstus LIKE pmdx_t.pmdxstus, 
   l_pmdxstus_desc LIKE type_t.chr500, 
   pmdx002 LIKE pmdx_t.pmdx002, 
   l_pmdx002_desc LIKE type_t.chr500, 
   pmdx003 LIKE pmdx_t.pmdx003, 
   l_pmdx003_desc LIKE type_t.chr500, 
   pmdx004 LIKE pmdx_t.pmdx004, 
   l_pmdx004_desc LIKE type_t.chr500, 
   pmdx005 LIKE pmdx_t.pmdx005, 
   l_pmdx005_desc LIKE type_t.chr500, 
   pmdx006 LIKE pmdx_t.pmdx006, 
   l_pmdx006_desc LIKE type_t.chr500, 
   pmdx007 LIKE pmdx_t.pmdx007, 
   pmdx008 LIKE pmdx_t.pmdx008, 
   pmdx009 LIKE pmdx_t.pmdx009, 
   l_pmdx009_desc LIKE type_t.chr500, 
   pmdx011 LIKE pmdx_t.pmdx011, 
   l_pmdx011_desc LIKE type_t.chr500, 
   pmdx018 LIKE pmdx_t.pmdx018, 
   l_pmdx018_desc LIKE type_t.chr500, 
   pmdx014 LIKE pmdx_t.pmdx014, 
   pmdx015 LIKE pmdx_t.pmdx015, 
   pmdyseq LIKE pmdy_t.pmdyseq, 
   pmdy002 LIKE pmdy_t.pmdy002, 
   l_pmdy002_desc LIKE type_t.chr500, 
   l_pmdy002_desc_desc LIKE type_t.chr500, 
   pmdy003 LIKE pmdy_t.pmdy003, 
   l_pmdy003_desc LIKE type_t.chr500, 
   pmdy005 LIKE pmdy_t.pmdy005, 
   l_pmdy005_desc LIKE type_t.chr500, 
   l_pmdy005_desc_desc LIKE type_t.chr500, 
   pmdy008 LIKE pmdy_t.pmdy008, 
   l_pmdy008_desc LIKE type_t.chr500, 
   pmdy009 LIKE pmdy_t.pmdy009, 
   pmdy010 LIKE pmdy_t.pmdy010, 
   pmdy017 LIKE pmdy_t.pmdy017, 
   pmdy019 LIKE pmdy_t.pmdy019, 
   pmdy018 LIKE pmdy_t.pmdy018, 
   pmdysite LIKE pmdy_t.pmdysite, 
   pmdxsite LIKE pmdx_t.pmdxsite, 
   pmdyent LIKE pmdy_t.pmdyent, 
   pmdxent LIKE pmdx_t.pmdxent
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#子報表
DEFINE sr1 RECORD 
   pmdzent       LIKE pmdz_t.pmdzent,  
   pmdzdocno     LIKE pmdz_t.pmdzdocno,
   pmdzseq       LIKE pmdz_t.pmdzseq,  
   pmdzseq1      LIKE pmdz_t.pmdzseq1, 
   pmdz001       LIKE pmdz_t.pmdz001,  
   pmdz002       LIKE pmdz_t.pmdz002,  
   pmdz003       LIKE pmdz_t.pmdz003  
END RECORD
DEFINE l_sql     STRING

    LET l_sql = "SELECT pmdzent,pmdzdocno,pmdzseq,pmdzseq1,pmdz001,pmdz002,pmdz003 ",
                "  FROM pmdz_t ",
                " WHERE pmdzent = ",g_enterprise," ",
                "   AND pmdzdocno = ?  ",
                "   AND pmdzseq = ? "
    PREPARE apmr080_x01_subprep FROM l_sql
    DECLARE apmr080_x01_subcurs CURSOR FOR apmr080_x01_subprep
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apmr080_x01_curs INTO sr.*                               
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
       #產品特徵說明
       LET sr.l_pmdy003_desc = ''
       IF NOT cl_null(sr.pmdy002) AND NOT cl_null(sr.pmdy003) THEN
          CALL s_feature_description(sr.pmdy002,sr.pmdy003) RETURNING g_sub_success,sr.l_pmdy003_desc
       END IF  
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.pmdxdocno,sr.pmdxdocdt,sr.pmdxstus,sr.l_pmdxstus_desc,sr.pmdx002,sr.l_pmdx002_desc,sr.pmdx003,sr.l_pmdx003_desc,sr.pmdx004,sr.l_pmdx004_desc,sr.pmdx005,sr.l_pmdx005_desc,sr.pmdx006,sr.l_pmdx006_desc,sr.pmdx007,sr.pmdx008,sr.pmdx009,sr.l_pmdx009_desc,sr.pmdx011,sr.l_pmdx011_desc,sr.pmdx018,sr.l_pmdx018_desc,sr.pmdx014,sr.pmdx015,sr.pmdyseq,sr.pmdy002,sr.l_pmdy002_desc,sr.l_pmdy002_desc_desc,sr.pmdy003,sr.l_pmdy003_desc,sr.pmdy005,sr.l_pmdy005_desc,sr.l_pmdy005_desc_desc,sr.pmdy008,sr.l_pmdy008_desc,sr.pmdy009,sr.pmdy010,sr.pmdy017,sr.pmdy019,sr.pmdy018,sr.pmdysite,sr.pmdxsite,sr.pmdyent,sr.pmdxent
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apmr080_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       #子報表
       OPEN apmr080_x01_subcurs USING sr.pmdxdocno,sr.pmdyseq
       FOREACH apmr080_x01_subcurs INTO sr1.*        
          EXECUTE insert_prep1 USING sr1.pmdzent,sr1.pmdzdocno,sr1.pmdzseq,sr1.pmdzseq1,
                                     sr1.pmdz001,sr1.pmdz002,sr1.pmdz003
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "apmr080_x01_subcurs"
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = FALSE
             CALL cl_err()        
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END FOREACH
       CLOSE apmr080_x01_subcurs
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmr080_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION apmr080_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="apmr080_x01.other_function" readonly="Y" >}

 
{</section>}
 
