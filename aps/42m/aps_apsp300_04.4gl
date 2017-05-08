#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp300_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-05-24 14:06:56), PR版次:0010(2017-01-19 19:44:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: apsp300_04
#+ Description: 獨立需求轉工單作業 – 工單資料調整
#+ Creator....: 03079(2015-07-07 11:26:18)
#+ Modifier...: 03079 -SD/PR- 07024
 
{</section>}
 
{<section id="apsp300_04.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00005#41  2016/03/28  by pengxin  修正azzi920重复定义之错误讯息 
#160512-00016#1   2016/05/24  by ming     增加欄位 保稅否 
#160530-00038#1   2016/06/07  By ming     產生工單時，沒有更新獨立需求(apst300)的已耗數量，導致工單(asft300)刪除時，會使得獨立需求的已耗數量被扣為負數
#160727-00019#14  2016/08/02  By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                         Mod   apsp300_03_temp_d1 -->apsp300_tmp01
#                                         Mod   apsp300_03_temp_d2 -->apsp300_tmp02
#                                         Mod   apsp300_04_temp_d1 -->apsp300_tmp03
#160706-00037#7   2016/08/25  By shiun    引導式作業調整的作法:最後一步拋轉前，檢查來源單據的狀態碼，若為不可拋轉的資料提示"單據編號OOO單據狀態碼非Y.已確認不可拋轉"
#161024-00057#19  2016/10/26  By Whitney  刪除insert into sfae_t相關程式
#161109-00085#13  2016/11/14  By 08993    整批調整系統星號寫法
#161104-00037#1   2016/12/05  By ywtsai   修改(1)併單依照料號時，若獨立需求單有料件特徵，則產生工單的生產料件明細也需拆分料件特徵
#                                         (2)開啟工單時，傳入參數工單範圍應傳入為第三個參數
#170101-00012#1   2017/01/04  By ywtsai   在ON ACTION accept時沒有ACCEPT DIALOG造成無法離開DIALOG迴圈
#170104-00066#1  2017/01/04 By Rainy   筆數相關變數由num5放大至num10
#170103-00052#1   2017/01/19  By dorislai 修正獨立需求單合併時，sfac的數量多寫入一次
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../aps/4gl/apsp300.inc"
#end add-point
 
{</section>}
 
{<section id="apsp300_04.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
#單身 type 宣告
#170104-00066#1 (B)  17/01/05 modify by rainy 
#DEFINE l_ac              LIKE type_t.num5
#DEFINE l_ac2             LIKE type_t.num5
#DEFINE g_master_idx      LIKE type_t.num5
#
#DEFINE g_rec_b           LIKE type_t.num5
#DEFINE g_rec_b2          LIKE type_t.num5
DEFINE l_ac              LIKE type_t.num10
DEFINE l_ac2             LIKE type_t.num10
DEFINE g_master_idx      LIKE type_t.num10

DEFINE g_rec_b           LIKE type_t.num10
DEFINE g_rec_b2          LIKE type_t.num10
#170104-00066#1 (E)  17/01/05 modify by rainy 
DEFINE g_success         LIKE type_t.chr1
DEFINE g_result_str      LIKE type_t.chr1000
TYPE type_g_sfaa_d       RECORD
                         keyno              LIKE type_t.num5,
                         sfaa005            LIKE sfaa_t.sfaa005,
                         sfaa006            LIKE sfaa_t.sfaa006,
                         sfaa007            LIKE sfaa_t.sfaa007,
                         sfaa009            LIKE sfaa_t.sfaa009,
                         sfaa009_desc       LIKE type_t.chr500,
                         sfaa010            LIKE sfaa_t.sfaa010,
                         sfaa011            LIKE sfaa_t.sfaa011, #160214-00005#5-add
                         sfaa010_desc       LIKE type_t.chr500,
                         sfaa010_desc_desc  LIKE type_t.chr500,
#                         sfaa011            LIKE sfaa_t.sfaa011, #160214-00005#5-mark
                         sfac006            LIKE sfac_t.sfac006,
                         sfac006_desc       LIKE imefl_t.imefl005, 
                         #160512-00016#1 20160524 add by ming -----(S) 
                         sfaa072            LIKE sfaa_t.sfaa072,  #保稅否  
                         #160512-00016#1 20160524 add by ming -----(E) 
                         sfaa012            LIKE sfaa_t.sfaa012,
                         sfaa013            LIKE sfaa_t.sfaa013,
                         sfaa013_desc       LIKE type_t.chr500,
                         sfaadocno          LIKE sfaa_t.sfaadocno,
                         sfaadocno_desc     LIKE oobxl_t.oobxl003,
                         sfaa003            LIKE sfaa_t.sfaa003,
                         sfaa057            LIKE sfaa_t.sfaa057,
                         sfaa017            LIKE sfaa_t.sfaa017,
                         sfaa017_desc       LIKE ooefl_t.ooefl003,
                         sfaa019            LIKE sfaa_t.sfaa019,
                         sfaa020            LIKE sfaa_t.sfaa020,
                         sfaa061            LIKE sfaa_t.sfaa061,
                         sfaa016            LIKE sfaa_t.sfaa016
                         END RECORD

TYPE type_g_psab_d       RECORD
                            keyno             LIKE type_t.num5,
                            psabdocno         LIKE psab_t.psabdocno,
                            sfbaseq           LIKE sfba_t.sfbaseq,
                            sfbaseq1          LIKE sfba_t.sfbaseq1,
                            psab001           LIKE psab_t.psab001,
                            psab012           LIKE psab_t.psab012, #160214-00005#5-add
                            psab001_desc      LIKE imaal_t.imaal003,
                            psab001_desc_desc LIKE imaal_t.imaal004,
                            psab002           LIKE psab_t.psab002,
                            psab002_desc      LIKE imefl_t.imefl005, 
                            #160512-00016#1 20160524 add by ming -----(S) 
                            psab013           LIKE psab_t.psab013,   
                            #160512-00016#1 20160524 add by ming -----(E) 
                            psab005           LIKE psab_t.psab005,
                            psab004           LIKE psab_t.psab004,
                            psab004_desc      LIKE type_t.chr500,
                            qty               LIKE psab_t.psab005,
                            psab003           LIKE psab_t.psab003
                         END RECORD
DEFINE g_sfaa_d          DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_sfaa_d_t        type_g_sfaa_d
DEFINE g_psab_d          DYNAMIC ARRAY OF type_g_psab_d
DEFINE g_psab_d_t        type_g_psab_d
DEFINE g_04_i            LIKE type_t.num5       #161104-00037#1 add


#end add-point
 
{</section>}
 
{<section id="apsp300_04.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsp300_04.other_dialog" >}

DIALOG apsp300_04_display()
   DEFINE l_success        LIKE type_t.num5
   #modify--151118-00029#7-- By shiun--(E)
#   DISPLAY ARRAY g_psab_d TO s_detail2_apsp300_04.* ATTRIBUTE(COUNT = g_rec_b2)
   DISPLAY ARRAY g_sfaa_d TO s_detail1_apsp300_04.* ATTRIBUTE(COUNT = g_rec_b)
   #modify--151118-00029#7-- By shiun--(E)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail1_apsp300_04")
        LET g_master_idx = l_ac
        CALL apsp300_04_fetch()
        
   END DISPLAY
END DIALOG

DIALOG apsp300_04_display2()
   DEFINE l_success        LIKE type_t.num5
   
   DISPLAY ARRAY g_psab_d TO s_detail2_apsp300_04.* ATTRIBUTE(COUNT = g_rec_b2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac2)

      BEFORE ROW
        LET l_ac2 = DIALOG.getCurrentRow("s_detail2_apsp300_04")

   END DISPLAY
END DIALOG

DIALOG apsp300_04_input()
   DEFINE l_imae032       LIKE imae_t.imae032
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_success       LIKE type_t.num5
   
   INPUT ARRAY g_sfaa_d FROM s_detail1_apsp300_04.*
      ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
                
      BEFORE INPUT
      
      BEFORE ROW
         LET l_ac = ARR_CURR()      
         LET g_sfaa_d_t.* = g_sfaa_d[l_ac].*
         CALL apsp300_04_set_entry_b()
         CALL apsp300_04_set_no_entry_b()
         CALL apsp300_04_set_no_required_b()
         CALL apsp300_04_set_required_b()
         LET l_ac = DIALOG.getCurrentRow("s_detail1_apsp300_04")
         LET g_master_idx = l_ac
         CALL apsp300_04_fetch()
         
         
      AFTER FIELD sfaa011_d1_04
         IF g_sfaa_d[l_ac].sfaa011 IS NULL THEN
            LET g_sfaa_d[l_ac].sfaa011 = ' '
         END IF   
         IF g_sfaa_d[l_ac].sfaa011 IS NOT NULL AND 
           (g_sfaa_d_t.sfaa011 IS NULL OR g_sfaa_d[l_ac].sfaa011 != g_sfaa_d_t.sfaa011) THEN
            CALL apsp300_04_chk_sfaa011()
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD sfaa011_d1_04
            END IF
         END IF
         LET g_sfaa_d_t.sfaa011 = g_sfaa_d[l_ac].sfaa011
         
      BEFORE FIELD sfaadocno_d1_04
         CALL apsp300_04_set_entry_b()
         CALL apsp300_04_set_no_required_b()
         
      AFTER FIELD sfaadocno_d1_04
         IF g_sfaa_d[l_ac].sfaadocno IS NULL THEN
            LET g_sfaa_d[l_ac].sfaadocno = g_sfaadocno
         END IF   
         IF g_sfaa_d[l_ac].sfaadocno IS NOT NULL AND 
           (g_sfaa_d_t.sfaadocno IS NULL OR g_sfaa_d[l_ac].sfaadocno != g_sfaa_d_t.sfaadocno) THEN
            CALL apsp300_04_chk_sfaadocno()
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD sfaadocno_d1_04
            END IF
            #单别带出单据名称
            CALL s_aooi200_get_slip_desc(g_sfaa_d[l_ac].sfaadocno)
                 RETURNING g_sfaa_d[l_ac].sfaadocno_desc
            CALL apsp300_04_get_doc_default()
         END IF
         LET g_sfaa_d_t.sfaadocno = g_sfaa_d[l_ac].sfaadocno 
         CALL apsp300_04_set_no_entry_b()     
         CALL apsp300_04_set_required_b()
         
      AFTER FIELD sfaa003_d1_04 
         IF g_sfaa_d[l_ac].sfaa003 IS NOT NULL AND 
           (g_sfaa_d_t.sfaa003 IS NULL OR g_sfaa_d[l_ac].sfaa003 != g_sfaa_d_t.sfaa003) THEN
            CALL apsp300_04_chk_sfaa011()
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD sfaa003_d1_04
            END IF
         END IF
         LET g_sfaa_d_t.sfaa003 = g_sfaa_d[l_ac].sfaa003      
         
      AFTER FIELD sfaa017_d1_04
         IF g_sfaa_d[l_ac].sfaa017 IS NOT NULL AND 
           (g_sfaa_d_t.sfaa017 IS NULL OR g_sfaa_d[l_ac].sfaa017 != g_sfaa_d_t.sfaa017) THEN
            CALL apsp300_04_chk_sfaa017()
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD sfaa017_d1_04
            END IF
         END IF
         LET g_sfaa_d_t.sfaa017 = g_sfaa_d[l_ac].sfaa017   
         
      BEFORE FIELD sfaa061_d1_04
         CALL apsp300_04_set_entry_b()   
         
      AFTER FIELD sfaa061_d1_04
         CALL apsp300_04_set_no_entry_b()                         
         
      AFTER FIELD sfaa016_d1_04 
         IF g_sfaa_d[l_ac].sfaa016 IS NOT NULL AND 
           (g_sfaa_d_t.sfaa016 IS NULL OR g_sfaa_d[l_ac].sfaa016 != g_sfaa_d_t.sfaa016) THEN
            CALL apsp300_04_chk_sfaa016()
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD sfaa016_d1_04
            END IF
         END IF
         LET g_sfaa_d_t.sfaa016 = g_sfaa_d[l_ac].sfaa016    
         
      ON ROW CHANGE 
         CALL apsp300_04_upd_sfaa(g_sfaa_d[l_ac].*)
              RETURNING l_success
         IF NOT l_success THEN
            
         END IF         
         
      ON ACTION controlp
         CASE
            WHEN INFIELD(sfaa011_d1_04)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaa011 
               #給予arg
               IF NOT cl_null(g_sfaa_d[l_ac].sfaa010) THEN
                  LET g_qryparam.where = " bmaa001 = '",g_sfaa_d[l_ac].sfaa010,"' "
               END IF
               CALL q_bmaa002()                                
               LET g_sfaa_d[l_ac].sfaa011 = g_qryparam.return1   
               NEXT FIELD sfaa011_d1_04   
            WHEN INFIELD(sfaadocno_d1_04)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaadocno
               #給予arg
               SELECT ooef004 INTO l_ooef004 FROM ooef_t
                WHERE ooef001 = g_site
                  AND ooefent  = g_enterprise
               LET g_qryparam.arg1 = l_ooef004 #參照表編號
               LET g_qryparam.arg2 = 'asft300' #作业代号
               CALL q_ooba002_1()                                  
               LET g_sfaa_d[l_ac].sfaadocno = g_qryparam.return1   
               NEXT FIELD sfaadocno_d1_04                         

            WHEN INFIELD(sfaa017_d1_04)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaa017
               IF g_sfaa_d[l_ac].sfaa057 = '2' THEN
                  LET g_qryparam.where = "pmaa002 = '1' OR pmaa002 ='3'"
                  CALL q_pmaa001()
               ELSE
                  LET g_qryparam.arg1 = g_today
                  CALL q_ooeg001()
               END IF           
               LET g_sfaa_d[l_ac].sfaa017 = g_qryparam.return1   
               NEXT FIELD sfaa017_d1_04  
               
            WHEN INFIELD(sfaa016_d1_04)
               SELECT imae032 INTO l_imae032 FROM imae_t 
                WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_sfaa_d[l_ac].sfaa010
               IF cl_null(l_imae032) THEN
                  LET l_imae032 = g_sfaa_d[l_ac].sfaa010
               END IF
            
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaa016
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = l_imae032
               CALL q_ecba002_3()
               LET g_sfaa_d[l_ac].sfaa016 = g_qryparam.return1   
               NEXT FIELD sfaa016_d1_04                                        
         END CASE               
         
   END INPUT
END DIALOG

 
{</section>}
 
{<section id="apsp300_04.other_function" readonly="Y" >}

PUBLIC FUNCTION apsp300_04(--)
   #add-point:input段變數傳入

   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define
   #end add-point

END FUNCTION

PUBLIC FUNCTION apsp300_04_init()
   CALL cl_set_combo_scc('sfaa005_d1_04','4009')
   CALL cl_set_combo_scc('sfaa003_d1_04','4007')
   CALL cl_set_combo_scc('sfaa057_d1_04','4010')

END FUNCTION

PUBLIC FUNCTION apsp300_04_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT apsp300_04_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE apsp300_tmp03(        #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03
          keyno               SMALLINT,
          sfaa005             VARCHAR(20),
          sfaa006             VARCHAR(20),
          sfaa007             INTEGER,
          sfaa009             VARCHAR(10),
          sfaa010             VARCHAR(40),
          sfaa011             VARCHAR(30),
          sfac006             VARCHAR(256), 
          sfaa072             VARCHAR(1),       #160512-00016#1 20160524 add by ming 保稅否 
          sfaa012             DECIMAL(20,6),
          sfaa013             VARCHAR(10),
          sfaadocno           VARCHAR(20),
          sfaa003             VARCHAR(1),
          sfaa057             VARCHAR(1),
          sfaa017             VARCHAR(10),
          sfaa019             DATE,
          sfaa020             DATE,
          sfaa061             VARCHAR(1),
          sfaa016             VARCHAR(10)
      )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create apsp300_tmp03'         #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apsp300_04_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE apsp300_tmp03              #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop apsp300_tmp03'      #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apsp300_04_fetch()
   DEFINE l_i         LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_sql       STRING

   CALL g_psab_d.clear()

   IF g_master_idx <=0 THEN
      LET g_rec_b2 = 0
      RETURN
   END IF
   
   LET l_sql = " SELECT keyno   , psabdocno, psabseq, '',",
               "        psab001 ,psab012,", #160214-00005#5-add-'psab012' 
               #160512-00016#1 20160524 modify by ming -----(S) 
               #"        ''      , ''       , psab002, ''      , psab005 ,", 
               "        ''      , ''       , psab002, ''      , ", 
               "        psab013 ,", 
               "        psab005 ,", 
               #160512-00016#1 20160524 modify by ming -----(E) 
               "        psab004 , ''       , qty    , psab003  ",
               "  FROM apsp300_tmp02",       #160727-00019#14 Mod   apsp300_03_temp_d2 -->apsp300_tmp02
               " WHERE keyno = ",g_sfaa_d[g_master_idx].keyno CLIPPED

   PREPARE apsp300_04_temp_d2_sel FROM l_sql
   DECLARE apsp300_04_temp_d2_b_fill_curs CURSOR FOR apsp300_04_temp_d2_sel

   LET l_i = 1
   
   #161109-00085#13-s mod
#   FOREACH apsp300_04_temp_d2_b_fill_curs INTO g_psab_d[l_i].*   #161109-00085#13-s mark
   FOREACH apsp300_04_temp_d2_b_fill_curs INTO g_psab_d[l_i].keyno,g_psab_d[l_i].psabdocno,g_psab_d[l_i].sfbaseq,g_psab_d[l_i].sfbaseq1,g_psab_d[l_i].psab001,
                                               g_psab_d[l_i].psab012,g_psab_d[l_i].psab001_desc,g_psab_d[l_i].psab001_desc_desc,g_psab_d[l_i].psab002,
                                               g_psab_d[l_i].psab002_desc,g_psab_d[l_i].psab013,g_psab_d[l_i].psab005,g_psab_d[l_i].psab004,
                                               g_psab_d[l_i].psab004_desc,g_psab_d[l_i].qty,g_psab_d[l_i].psab003
   #161109-00085#13-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp300_04_temp_d2_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL apsp300_04_detail_show(2,l_i)

      LET l_i = l_i + 1
      IF l_i > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b2 = l_i - 1
   CALL g_psab_d.deleteElement(l_i)
   CLOSE apsp300_04_temp_d2_b_fill_curs
   FREE apsp300_04_temp_d2_sel

END FUNCTION

PUBLIC FUNCTION apsp300_04_b_fill()
   DEFINE l_sql        STRING
   DEFINE l_i          LIKE type_t.num10   #170104-00066#1 num5->num10  17/01/05 mod by rainy 

   LET l_sql = " SELECT keyno    ,sfaa005  ,sfaa006  ,sfaa007  ,",
               #160214-00005#5-mod-(S)
#               "        sfaa009  ,''       ,sfaa010  ,''       ,",
#               "        ''       ,sfaa011  ,sfac006  ,''       ,sfaa012  ,sfaa013  ,",
               "        sfaa009  ,''       ,sfaa010  ,sfaa011,", 
               #160512-00016#1 20160524 modify by ming -----(S) 
               #"        ''       ,''       ,sfac006  ,''       ,sfaa012  ,sfaa013  ,", 
               "        ''       ,''       ,sfac006  ,''       , ", 
               "        sfaa072  ,sfaa012  ,sfaa013  ,", 
               #160512-00016#1 20160524 modify by ming -----(E) 
               #160214-00005#5-mod-(E)
               "        ''       ,sfaadocno,''       ,sfaa003  ,sfaa057  ,",
               "        sfaa017  ,''       ,sfaa019  ,sfaa020  ,sfaa061  ,",
               "        sfaa016                                           ",
               "  FROM apsp300_tmp03",           #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03
               " ORDER BY keyno"

   PREPARE apsp300_04_temp_d1_sel FROM l_sql
   DECLARE apsp300_04_temp_d1_b_fill_curs CURSOR FOR apsp300_04_temp_d1_sel
   
   CALL g_sfaa_d.clear()
   LET l_i = 1
   ERROR "Searching!"
   
   #161109-00085#13-s mod
#   FOREACH apsp300_04_temp_d1_b_fill_curs INTO g_sfaa_d[l_i].*   #161109-00085#13-s mark
   FOREACH apsp300_04_temp_d1_b_fill_curs INTO g_sfaa_d[l_i].keyno,g_sfaa_d[l_i].sfaa005,g_sfaa_d[l_i].sfaa006,
                                               g_sfaa_d[l_i].sfaa007,g_sfaa_d[l_i].sfaa009,g_sfaa_d[l_i].sfaa009_desc,g_sfaa_d[l_i].sfaa010,
                                               g_sfaa_d[l_i].sfaa011,g_sfaa_d[l_i].sfaa010_desc,g_sfaa_d[l_i].sfaa010_desc_desc,
                                               g_sfaa_d[l_i].sfac006,g_sfaa_d[l_i].sfac006_desc,g_sfaa_d[l_i].sfaa072,
                                               g_sfaa_d[l_i].sfaa012,g_sfaa_d[l_i].sfaa013,g_sfaa_d[l_i].sfaa013_desc,
                                               g_sfaa_d[l_i].sfaadocno,g_sfaa_d[l_i].sfaadocno_desc,
                                               g_sfaa_d[l_i].sfaa003,g_sfaa_d[l_i].sfaa057,g_sfaa_d[l_i].sfaa017,
                                               g_sfaa_d[l_i].sfaa017_desc,
                                               g_sfaa_d[l_i].sfaa019,g_sfaa_d[l_i].sfaa020,g_sfaa_d[l_i].sfaa061,
                                               g_sfaa_d[l_i].sfaa016
   #161109-00085#13-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apsp300_04_temp_d1_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      CALL apsp300_04_detail_show(1,l_i)
      
      LET l_i = l_i + 1
      IF l_i > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b = l_i - 1
   CALL g_sfaa_d.deleteElement(l_i)
   CLOSE apsp300_04_temp_d1_b_fill_curs
   FREE apsp300_04_temp_d1_sel
   
   LET g_master_idx = 1
  
   CALL apsp300_04_fetch()

END FUNCTION

PUBLIC FUNCTION apsp300_04_detail_show(p_i,p_idx)
   DEFINE p_i            LIKE type_t.num5
   DEFINE p_idx          LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_success      LIKE type_t.num5
   
   IF p_i = 1 THEN
      CALL s_desc_get_trading_partner_abbr_desc(g_sfaa_d[p_idx].sfaa009)
           RETURNING g_sfaa_d[p_idx].sfaa009_desc

      CALL s_desc_get_item_desc(g_sfaa_d[p_idx].sfaa010)
           RETURNING g_sfaa_d[p_idx].sfaa010_desc,g_sfaa_d[p_idx].sfaa010_desc_desc

      CALL s_desc_get_unit_desc(g_sfaa_d[p_idx].sfaa013)
           RETURNING g_sfaa_d[p_idx].sfaa013_desc
       
      CALL s_aooi200_get_slip_desc(g_sfaa_d[p_idx].sfaadocno)
           RETURNING g_sfaa_d[p_idx].sfaadocno_desc

      IF g_sfaa_d[p_idx].sfaa057 = '2'  THEN  #客户
         CALL s_desc_get_trading_partner_abbr_desc(g_sfaa_d[p_idx].sfaa017) 
              RETURNING g_sfaa_d[p_idx].sfaa017_desc        
      ELSE                             #部门
         CALL s_desc_get_department_desc(g_sfaa_d[p_idx].sfaa017) 
              RETURNING g_sfaa_d[p_idx].sfaa017_desc      
      END IF
      CALL s_feature_description(g_sfaa_d[p_idx].sfaa010,g_sfaa_d[p_idx].sfac006)
           RETURNING l_success,g_sfaa_d[p_idx].sfac006_desc      
   END IF
   

   IF p_i = 2 THEN          
      CALL s_desc_get_item_desc(g_psab_d[p_idx].psab001)
           RETURNING g_psab_d[p_idx].psab001_desc,g_psab_d[p_idx].psab001_desc_desc

      CALL s_desc_get_unit_desc(g_psab_d[p_idx].psab004)
           RETURNING g_psab_d[p_idx].psab004_desc
           
      CALL s_feature_description(g_psab_d[p_idx].psab001,g_psab_d[p_idx].psab002)
           RETURNING l_success,g_psab_d[p_idx].psab002_desc      
   END IF
   
END FUNCTION

PUBLIC FUNCTION apsp300_04_delete_temp_table()
   DELETE FROM apsp300_tmp03;      #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp300_04_gen_data()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success
# Date & Author..: 2014-07-11 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_gen_data()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_tmp            type_g_sfaa_d
   DEFINE l_imae033        LIKE imae_t.imae033                 

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   #将临时表清除
   CALL apsp300_04_delete_temp_table()

   #取BOM特性
   LET l_sql = " SELECT UNIQUE bmaa002 FROM bmaa_t ",
               "  WHERE bmaaent  = ",g_enterprise,
               "    AND bmaasite = '",g_site,"'",
               "    AND bmaa001  = ?",
               "    AND bmaastus = 'Y' ",
               "  ORDER BY bmaa002 "
               
   PREPARE apsp300_04_gen_data_p2 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare apsp300_04_gen_data_p2'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DECLARE apsp300_04_gen_data_cs2 SCROLL CURSOR FOR apsp300_04_gen_data_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare apsp300_04_gen_data_cs2'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

           
   #取STEP3的资料
   LET l_sql = " SELECT keyno    ,sfaa005  ,sfaa006  ,sfaa007  ,",
#               "        ''       ,''       ,sfaa010  ,''       ,", #160214-00005#5-mod-(S)
               "        ''       ,''       ,sfaa010  ,sfaa011  ,",  #160214-00005#5-mod-(E) 
               #160512-00016#1 20160524 modify by ming -----(S) 
               #"        ''       ,''       ,sfac006  ,''       ,sfaa012  ,sfaa013  ,", 
               "        ''       ,''       ,sfac006  ,''       , ", 
               "        sfaa072  ,sfaa012  ,sfaa013  ,", 
               #160512-00016#1 20160524 modify by ming -----(E) 
               "        ''       ,''       ,''       ,''       ,''       ,",
               "        ''       ,''       ,sfaa019  ,sfaa020  ,''       ,",
               "        ''                                                ",
               "  FROM apsp300_tmp01",        #160727-00019#14 Mod   apsp300_03_temp_d1 -->apsp300_tmp01
               " ORDER BY keyno"
               
   PREPARE apsp300_04_gen_data_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare apsp300_04_gen_data_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DECLARE apsp300_04_gen_data_cs1 CURSOR FOR apsp300_04_gen_data_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare apsp300_04_gen_data_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #161109-00085#13-s mod
#   FOREACH apsp300_04_gen_data_cs1 INTO l_tmp.*  #161109-00085#13-s mark
   FOREACH apsp300_04_gen_data_cs1 INTO l_tmp.keyno,l_tmp.sfaa005,l_tmp.sfaa006,l_tmp.sfaa007,l_tmp.sfaa009,l_tmp.sfaa009_desc,l_tmp.sfaa010,
                                        l_tmp.sfaa011,l_tmp.sfaa010_desc,l_tmp.sfaa010_desc_desc,l_tmp.sfac006,l_tmp.sfac006_desc,
                                        l_tmp.sfaa072,l_tmp.sfaa012,l_tmp.sfaa013,l_tmp.sfaa013_desc,l_tmp.sfaadocno,l_tmp.sfaadocno_desc,
                                        l_tmp.sfaa003,l_tmp.sfaa057,l_tmp.sfaa017,l_tmp.sfaa017_desc,l_tmp.sfaa019,l_tmp.sfaa020,
                                        l_tmp.sfaa061,l_tmp.sfaa016
   #161109-00085#13-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach apsp300_04_gen_data_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      
      #BOM特性,部门/厂商,制程
      #160214-00005#5-mod-(S)
#      SELECT imae037,imae034,imae033 INTO l_tmp.sfaa011,l_tmp.sfaa017,l_imae033 FROM imae_t
#       WHERE imaeent  = g_enterprise
#         AND imaesite = g_site
#         AND imae001  = l_tmp.sfaa010 
      IF cl_null(l_tmp.sfaa011) THEN
         SELECT imae037,imae034,imae033 INTO l_tmp.sfaa011,l_tmp.sfaa017,l_imae033 FROM imae_t
          WHERE imaeent  = g_enterprise
            AND imaesite = g_site
            AND imae001  = l_tmp.sfaa010 
      ELSE
         SELECT imae034,imae033 INTO l_tmp.sfaa017,l_imae033 FROM imae_t
          WHERE imaeent  = g_enterprise
            AND imaesite = g_site
            AND imae001  = l_tmp.sfaa010 
      END IF
      #160214-00005#5-mod-(E)   
      IF l_tmp.sfaa011 IS NULL THEN
         OPEN apsp300_04_gen_data_cs2 USING l_tmp.sfaa010
         FETCH apsp300_04_gen_data_cs2 INTO l_tmp.sfaa011
      END IF
      
      LET l_tmp.sfaadocno = g_sfaadocno
      #工单类型
      LET l_tmp.sfaa003   = '1'
      #厂内外
      LET l_tmp.sfaa057   = '1'      
      #制程否
      LET l_tmp.sfaa061 = 'N'
      #制程
      LET l_tmp.sfaa016 = ''
      
      LET l_tmp.sfaa011 = s_aooi200_get_doc_default(g_site,'1',l_tmp.sfaadocno,'sfaa011',l_tmp.sfaa011  )
      LET l_tmp.sfaa003 = s_aooi200_get_doc_default(g_site,'1',l_tmp.sfaadocno,'sfaa003',l_tmp.sfaa003  )
      LET l_tmp.sfaa057 = s_aooi200_get_doc_default(g_site,'1',l_tmp.sfaadocno,'sfaa057',l_tmp.sfaa057  )
      LET l_tmp.sfaa017 = s_aooi200_get_doc_default(g_site,'1',l_tmp.sfaadocno,'sfaa017',l_tmp.sfaa017  )
      LET l_tmp.sfaa061 = s_aooi200_get_doc_default(g_site,'1',l_tmp.sfaadocno,'sfaa061',l_tmp.sfaa061  )
      LET l_tmp.sfaa016 = s_aooi200_get_doc_default(g_site,'1',l_tmp.sfaadocno,'sfaa016',l_tmp.sfaa016  )
      IF cl_null(l_tmp.sfaa016) AND l_tmp.sfaa061 = 'Y' THEN
         LET l_tmp.sfaa016 = l_imae033
      END IF
      
      #161109-00085#13-s mod
#      INSERT INTO apsp300_tmp03            #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03   #161109-00085#13-s mark
      INSERT INTO apsp300_tmp03(keyno,sfaa005,sfaa006,sfaa007,sfaa009,sfaa010,sfaa011,sfac006,sfaa072,sfaa012,
                                sfaa013,sfaadocno,sfaa003,sfaa057,sfaa017,sfaa019,sfaa020,sfaa061,sfaa016)
      #161109-00085#13-e mod
             VALUES(l_tmp.keyno    ,l_tmp.sfaa005  ,l_tmp.sfaa006  ,l_tmp.sfaa007  ,
                    l_tmp.sfaa009  ,l_tmp.sfaa010  ,l_tmp.sfaa011  ,l_tmp.sfac006  , 
                    #160512-00016#1 20160524 add by ming -----(S) 
                    l_tmp.sfaa072  , 
                    #160512-00016#1 20160524 add by ming -----(E) 
                    l_tmp.sfaa012  ,l_tmp.sfaa013  ,l_tmp.sfaadocno,l_tmp.sfaa003  ,l_tmp.sfaa057,
                    l_tmp.sfaa017  ,l_tmp.sfaa019  ,l_tmp.sfaa020  ,l_tmp.sfaa061  ,l_tmp.sfaa016)
                    
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert apsp300_tmp03'    #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF           

   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: update sfaa
# Memo...........:
# Usage..........: CALL apsp300_04_upd_sfaa(p_sfaa)
#                       RETURNING r_success
# Input parameter: p_sfaa         sfaa资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-11 By Carier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_upd_sfaa(p_sfaa)
   DEFINE p_sfaa           type_g_sfaa_d
   DEFINE r_success        LIKE type_t.num5

   LET r_success = FALSE
   
   UPDATE apsp300_tmp03 SET sfaa011   = p_sfaa.sfaa011  ,        #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03 
                                 sfaadocno = p_sfaa.sfaadocno,      
                                 sfaa003   = p_sfaa.sfaa003  ,      
                                 sfaa057   = p_sfaa.sfaa057  ,      
                                 sfaa017   = p_sfaa.sfaa017  ,      
                                 sfaa061   = p_sfaa.sfaa061  ,      
                                 sfaa016   = p_sfaa.sfaa016  
    WHERE keyno = p_sfaa.keyno   
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'update apsp300_tmp03'             #160727-00019#14 Mod   apsp300_04_temp_d1 -->apsp300_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apsp300_04_set_entry_b()
   DEFINE l_fields      STRING
   
   CALL cl_set_comp_entry("sfaa016_d1_04",TRUE)
   IF NOT cl_null(g_sfaa_d[l_ac].sfaadocno) THEN
      LET l_fields = s_aooi200_get_doc_fields(g_site,'1',g_sfaa_d[l_ac].sfaadocno)
      CALL cl_set_comp_entry(l_fields,TRUE)
   END IF
   
END FUNCTION

PUBLIC FUNCTION apsp300_04_set_no_entry_b()
   DEFINE l_fields      STRING
   
   IF g_sfaa_d[l_ac].sfaa061 = 'N' THEN
      CALL cl_set_comp_entry("sfaa016_d1_04",FALSE)
      LET g_sfaa_d[l_ac].sfaa016 = ''
   END IF
   
   IF NOT cl_null(g_sfaa_d[l_ac].sfaadocno) THEN
      LET l_fields = s_aooi200_get_doc_fields(g_site,'1',g_sfaa_d[l_ac].sfaadocno)
      CALL cl_set_comp_entry(l_fields,FALSE)
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 检查BOM特性
# Memo...........:
# Usage..........: CALL apsp300_04_chk_sfaa011()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-14 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_chk_sfaa011()
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_errno           LIKE gzze_t.gzze001
   DEFINE l_msg             STRING
   DEFINE l_bmaastus        LIKE bmaa_t.bmaastus
   
   LET r_success = FALSE
   IF g_sfaa_d[l_ac].sfaa003 NOT MATCHES '[145]' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF

   LET l_bmaastus = ''
   
   SELECT bmaastus INTO l_bmaastus FROM bmaa_t
    WHERE bmaaent  = g_enterprise
      AND bmaasite = g_site
      AND bmaa001  = g_sfaa_d[l_ac].sfaa010
      AND bmaa002  = g_sfaa_d[l_ac].sfaa011
      
   CASE
      WHEN SQLCA.sqlcode = 100  LET l_errno = 'abm-00085'   #输入的主件料号+特性代码不存在BOM数据里(bmaa_t)
#      WHEN l_bmaastus = 'X'     LET l_errno = 'aim-00127'   #输入的数据不是已确认状态！      #160318-00005#41  mark
      WHEN l_bmaastus = 'X'     LET l_errno = 'sub-01302'   #输入的数据不是已确认状态！    #160318-00005#41  add
      OTHERWISE                 LET l_errno = SQLCA.SQLCODE USING '-----'  
   END CASE

   IF NOT cl_null(l_errno) THEN
      LET l_msg = g_sfaa_d[l_ac].sfaa010,'-',g_sfaa_d[l_ac].sfaa011
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = l_msg
      #160318-00005#41 --s add
      CASE l_errno
         WHEN 'sub-01302'
            LET g_errparam.replace[1] = 'abmm200'
            LET g_errparam.replace[2] = cl_get_progname('abmm200',g_lang,"2")
            LET g_errparam.exeprog = 'abmm200'
      END CASE
      #160318-00005#41 --e add
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
               
   LET r_success = TRUE
   RETURN r_success   
   
END FUNCTION

################################################################################
# Descriptions...: 检查部门/厂商
# Memo...........:
# Usage..........: CALL apsp300_04_chk_sfaa017()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-14 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_chk_sfaa017()
   DEFINE r_success         LIKE type_t.num5
   
   LET r_success = FALSE

   INITIALIZE g_chkparam.* TO NULL
   IF g_sfaa_d[l_ac].sfaa057 = '2' THEN
      LET g_chkparam.arg1 = g_sfaa_d[l_ac].sfaa017
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_pmaa001_1") THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_sfaa_d[l_ac].sfaa017) 
              RETURNING g_sfaa_d[l_ac].sfaa017_desc     
      ELSE
         RETURN r_success
      END IF
   ELSE
      LET g_chkparam.arg1 = g_sfaa_d[l_ac].sfaa017
      LET g_chkparam.arg2 = g_today
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooeg001_2") THEN
         CALL s_desc_get_department_desc(g_sfaa_d[l_ac].sfaa017) RETURNING g_sfaa_d[l_ac].sfaa017_desc
      ELSE
         RETURN r_success
      END IF
   END IF
               
   LET r_success = TRUE
   RETURN r_success   
   
END FUNCTION

################################################################################
# Descriptions...: 检查制程编号
# Memo...........:
# Usage..........: CALL apsp300_04_chk_sfaa016()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-14 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_chk_sfaa016()
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_imae032         LIKE imae_t.imae032
   
   LET r_success = FALSE

   #抓制程料号
   SELECT imae032 INTO l_imae032 FROM imae_t 
    WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_sfaa_d[l_ac].sfaa010
   IF cl_null(l_imae032) THEN
      LET l_imae032 = g_sfaa_d[l_ac].sfaa010
   END IF
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_site
   LET g_chkparam.arg2 = l_imae032
   LET g_chkparam.arg3 = g_sfaa_d[l_ac].sfaa016
   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_ecba002_1") THEN
      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success   
   
END FUNCTION

################################################################################
# Descriptions...: 取aooi200中BY单据别设定的栏位预设值
# Memo...........:
# Usage..........: CALL apsp300_04_get_doc_default()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-07-14 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_get_doc_default()
   DEFINE l_imae033        LIKE imae_t.imae033
   
   LET g_sfaa_d[l_ac].sfaa011    = s_aooi200_get_doc_default(g_site,'1',g_sfaa_d[l_ac].sfaadocno,'sfaa011'  ,g_sfaa_d[l_ac].sfaa011  )
   LET g_sfaa_d[l_ac].sfaa003    = s_aooi200_get_doc_default(g_site,'1',g_sfaa_d[l_ac].sfaadocno,'sfaa003'  ,g_sfaa_d[l_ac].sfaa003  )
   LET g_sfaa_d[l_ac].sfaa057    = s_aooi200_get_doc_default(g_site,'1',g_sfaa_d[l_ac].sfaadocno,'sfaa057'  ,g_sfaa_d[l_ac].sfaa057  )
   LET g_sfaa_d[l_ac].sfaa017    = s_aooi200_get_doc_default(g_site,'1',g_sfaa_d[l_ac].sfaadocno,'sfaa017'  ,g_sfaa_d[l_ac].sfaa017  )
   LET g_sfaa_d[l_ac].sfaa061    = s_aooi200_get_doc_default(g_site,'1',g_sfaa_d[l_ac].sfaadocno,'sfaa061'  ,g_sfaa_d[l_ac].sfaa061  )
   LET g_sfaa_d[l_ac].sfaa016    = s_aooi200_get_doc_default(g_site,'1',g_sfaa_d[l_ac].sfaadocno,'sfaa016'  ,g_sfaa_d[l_ac].sfaa016  )
   #制程
   IF g_sfaa_d[l_ac].sfaa061 = 'Y' AND cl_null(g_sfaa_d[l_ac].sfaa016) THEN
      SELECT imae033 INTO l_imae033 FROM imae_t
       WHERE imaeent  = g_enterprise
         AND imaesite = g_site
         AND imae001  = g_sfaa_d[l_ac].sfaa010    
      LET g_sfaa_d[l_ac].sfaa016 = l_imae033
   END IF
END FUNCTION

################################################################################
# Descriptions...: 新增工单资料
# Memo...........:
# Usage..........: CALL apsp300_04_done()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success
# Date & Author..: 2014-07-15 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_done()
   DEFINE r_success             LIKE type_t.num5
   DEFINE l_start_no            LIKE sfaa_t.sfaadocno
   DEFINE l_end_no              LIKE sfaa_t.sfaadocno
   DEFINE l_i                   LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   #161109-00085#13-mod-s
#   DEFINE l_sfaa                RECORD LIKE sfaa_t.*   #161109-00085#13   mark
   DEFINE l_sfaa                RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       sfaaud001 LIKE sfaa_t.sfaaud001, #自定義欄位(文字)001
       sfaaud002 LIKE sfaa_t.sfaaud002, #自定義欄位(文字)002
       sfaaud003 LIKE sfaa_t.sfaaud003, #自定義欄位(文字)003
       sfaaud004 LIKE sfaa_t.sfaaud004, #自定義欄位(文字)004
       sfaaud005 LIKE sfaa_t.sfaaud005, #自定義欄位(文字)005
       sfaaud006 LIKE sfaa_t.sfaaud006, #自定義欄位(文字)006
       sfaaud007 LIKE sfaa_t.sfaaud007, #自定義欄位(文字)007
       sfaaud008 LIKE sfaa_t.sfaaud008, #自定義欄位(文字)008
       sfaaud009 LIKE sfaa_t.sfaaud009, #自定義欄位(文字)009
       sfaaud010 LIKE sfaa_t.sfaaud010, #自定義欄位(文字)010
       sfaaud011 LIKE sfaa_t.sfaaud011, #自定義欄位(數字)011
       sfaaud012 LIKE sfaa_t.sfaaud012, #自定義欄位(數字)012
       sfaaud013 LIKE sfaa_t.sfaaud013, #自定義欄位(數字)013
       sfaaud014 LIKE sfaa_t.sfaaud014, #自定義欄位(數字)014
       sfaaud015 LIKE sfaa_t.sfaaud015, #自定義欄位(數字)015
       sfaaud016 LIKE sfaa_t.sfaaud016, #自定義欄位(數字)016
       sfaaud017 LIKE sfaa_t.sfaaud017, #自定義欄位(數字)017
       sfaaud018 LIKE sfaa_t.sfaaud018, #自定義欄位(數字)018
       sfaaud019 LIKE sfaa_t.sfaaud019, #自定義欄位(數字)019
       sfaaud020 LIKE sfaa_t.sfaaud020, #自定義欄位(數字)020
       sfaaud021 LIKE sfaa_t.sfaaud021, #自定義欄位(日期時間)021
       sfaaud022 LIKE sfaa_t.sfaaud022, #自定義欄位(日期時間)022
       sfaaud023 LIKE sfaa_t.sfaaud023, #自定義欄位(日期時間)023
       sfaaud024 LIKE sfaa_t.sfaaud024, #自定義欄位(日期時間)024
       sfaaud025 LIKE sfaa_t.sfaaud025, #自定義欄位(日期時間)025
       sfaaud026 LIKE sfaa_t.sfaaud026, #自定義欄位(日期時間)026
       sfaaud027 LIKE sfaa_t.sfaaud027, #自定義欄位(日期時間)027
       sfaaud028 LIKE sfaa_t.sfaaud028, #自定義欄位(日期時間)028
       sfaaud029 LIKE sfaa_t.sfaaud029, #自定義欄位(日期時間)029
       sfaaud030 LIKE sfaa_t.sfaaud030, #自定義欄位(日期時間)030
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
               END RECORD
   #161109-00085#13-mod-e
   #161109-00085#13-mod-s
#   DEFINE l_sfab                RECORD LIKE sfab_t.*   mark
   DEFINE l_sfab            RECORD  #工單來源檔
       sfabent LIKE sfab_t.sfabent, #企業編號
       sfabsite LIKE sfab_t.sfabsite, #營運據點
       sfabdocno LIKE sfab_t.sfabdocno, #單號
       sfab001 LIKE sfab_t.sfab001, #來源
       sfab002 LIKE sfab_t.sfab002, #來源單號
       sfab003 LIKE sfab_t.sfab003, #來源項次
       sfab004 LIKE sfab_t.sfab004, #來源項序
       sfab005 LIKE sfab_t.sfab005, #分批序
       sfab006 LIKE sfab_t.sfab006, #分配優先序
       sfab007 LIKE sfab_t.sfab007, #本次轉開工單量
       sfabseq LIKE sfab_t.sfabseq, #項次
       sfabud001 LIKE sfab_t.sfabud001, #自定義欄位(文字)001
       sfabud002 LIKE sfab_t.sfabud002, #自定義欄位(文字)002
       sfabud003 LIKE sfab_t.sfabud003, #自定義欄位(文字)003
       sfabud004 LIKE sfab_t.sfabud004, #自定義欄位(文字)004
       sfabud005 LIKE sfab_t.sfabud005, #自定義欄位(文字)005
       sfabud006 LIKE sfab_t.sfabud006, #自定義欄位(文字)006
       sfabud007 LIKE sfab_t.sfabud007, #自定義欄位(文字)007
       sfabud008 LIKE sfab_t.sfabud008, #自定義欄位(文字)008
       sfabud009 LIKE sfab_t.sfabud009, #自定義欄位(文字)009
       sfabud010 LIKE sfab_t.sfabud010, #自定義欄位(文字)010
       sfabud011 LIKE sfab_t.sfabud011, #自定義欄位(數字)011
       sfabud012 LIKE sfab_t.sfabud012, #自定義欄位(數字)012
       sfabud013 LIKE sfab_t.sfabud013, #自定義欄位(數字)013
       sfabud014 LIKE sfab_t.sfabud014, #自定義欄位(數字)014
       sfabud015 LIKE sfab_t.sfabud015, #自定義欄位(數字)015
       sfabud016 LIKE sfab_t.sfabud016, #自定義欄位(數字)016
       sfabud017 LIKE sfab_t.sfabud017, #自定義欄位(數字)017
       sfabud018 LIKE sfab_t.sfabud018, #自定義欄位(數字)018
       sfabud019 LIKE sfab_t.sfabud019, #自定義欄位(數字)019
       sfabud020 LIKE sfab_t.sfabud020, #自定義欄位(數字)020
       sfabud021 LIKE sfab_t.sfabud021, #自定義欄位(日期時間)021
       sfabud022 LIKE sfab_t.sfabud022, #自定義欄位(日期時間)022
       sfabud023 LIKE sfab_t.sfabud023, #自定義欄位(日期時間)023
       sfabud024 LIKE sfab_t.sfabud024, #自定義欄位(日期時間)024
       sfabud025 LIKE sfab_t.sfabud025, #自定義欄位(日期時間)025
       sfabud026 LIKE sfab_t.sfabud026, #自定義欄位(日期時間)026
       sfabud027 LIKE sfab_t.sfabud027, #自定義欄位(日期時間)027
       sfabud028 LIKE sfab_t.sfabud028, #自定義欄位(日期時間)028
       sfabud029 LIKE sfab_t.sfabud029, #自定義欄位(日期時間)029
       sfabud030 LIKE sfab_t.sfabud030  #自定義欄位(日期時間)030
                 END RECORD
   #161109-00085#13-mod-e
   DEFINE l_success             LIKE type_t.num5
   DEFINE l_sfaadocno           LIKE sfaa_t.sfaadocno
   DEFINE l_sql                 STRING
   DEFINE l_psab_d              type_g_psab_d
   DEFINE l_imaf015             LIKE imaf_t.imaf015
   DEFINE l_rate                LIKE inaj_t.inaj014 
   DEFINE l_num                 LIKE type_t.num5
   DEFINE l_flag                LIKE type_t.chr1
   DEFINE l_wc                  STRING
   DEFINE l_choice              LIKE type_t.num5
   DEFINE la_param              RECORD
                                prog   STRING,
                                param  DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE l_psab003             LIKE psab_t.psab003
   DEFINE l_qty                 LIKE sfaa_t.sfaa012
   #161109-00085#13-mod-s
#   DEFINE l_sfae                RECORD LIKE sfae_t.*   mark
   DEFINE l_sfae            RECORD  #工單計劃完工日期檔
       sfaeent LIKE sfae_t.sfaeent, #企業編號
       sfaesite LIKE sfae_t.sfaesite, #營運據點
       sfaedocno LIKE sfae_t.sfaedocno, #單號
       sfaeseq LIKE sfae_t.sfaeseq, #項次
       sfae001 LIKE sfae_t.sfae001, #數量
       sfae002 LIKE sfae_t.sfae002, #預計完工日期
       sfae003 LIKE sfae_t.sfae003, #累計數量達成日
       sfae004 LIKE sfae_t.sfae004, #修正次數
       sfae005 LIKE sfae_t.sfae005, #修改人員
       sfae006 LIKE sfae_t.sfae006, #修改日期
       sfaeud001 LIKE sfae_t.sfaeud001, #自定義欄位(文字)001
       sfaeud002 LIKE sfae_t.sfaeud002, #自定義欄位(文字)002
       sfaeud003 LIKE sfae_t.sfaeud003, #自定義欄位(文字)003
       sfaeud004 LIKE sfae_t.sfaeud004, #自定義欄位(文字)004
       sfaeud005 LIKE sfae_t.sfaeud005, #自定義欄位(文字)005
       sfaeud006 LIKE sfae_t.sfaeud006, #自定義欄位(文字)006
       sfaeud007 LIKE sfae_t.sfaeud007, #自定義欄位(文字)007
       sfaeud008 LIKE sfae_t.sfaeud008, #自定義欄位(文字)008
       sfaeud009 LIKE sfae_t.sfaeud009, #自定義欄位(文字)009
       sfaeud010 LIKE sfae_t.sfaeud010, #自定義欄位(文字)010
       sfaeud011 LIKE sfae_t.sfaeud011, #自定義欄位(數字)011
       sfaeud012 LIKE sfae_t.sfaeud012, #自定義欄位(數字)012
       sfaeud013 LIKE sfae_t.sfaeud013, #自定義欄位(數字)013
       sfaeud014 LIKE sfae_t.sfaeud014, #自定義欄位(數字)014
       sfaeud015 LIKE sfae_t.sfaeud015, #自定義欄位(數字)015
       sfaeud016 LIKE sfae_t.sfaeud016, #自定義欄位(數字)016
       sfaeud017 LIKE sfae_t.sfaeud017, #自定義欄位(數字)017
       sfaeud018 LIKE sfae_t.sfaeud018, #自定義欄位(數字)018
       sfaeud019 LIKE sfae_t.sfaeud019, #自定義欄位(數字)019
       sfaeud020 LIKE sfae_t.sfaeud020, #自定義欄位(數字)020
       sfaeud021 LIKE sfae_t.sfaeud021, #自定義欄位(日期時間)021
       sfaeud022 LIKE sfae_t.sfaeud022, #自定義欄位(日期時間)022
       sfaeud023 LIKE sfae_t.sfaeud023, #自定義欄位(日期時間)023
       sfaeud024 LIKE sfae_t.sfaeud024, #自定義欄位(日期時間)024
       sfaeud025 LIKE sfae_t.sfaeud025, #自定義欄位(日期時間)025
       sfaeud026 LIKE sfae_t.sfaeud026, #自定義欄位(日期時間)026
       sfaeud027 LIKE sfae_t.sfaeud027, #自定義欄位(日期時間)027
       sfaeud028 LIKE sfae_t.sfaeud028, #自定義欄位(日期時間)028
       sfaeud029 LIKE sfae_t.sfaeud029, #自定義欄位(日期時間)029
       sfaeud030 LIKE sfae_t.sfaeud030  #自定義欄位(日期時間)030
                 END RECORD
   #161109-00085#13-mod-e
   DEFINE l_ooff013_1           LIKE ooff_t.ooff013
   DEFINE l_ooff013_2           LIKE ooff_t.ooff013
   DEFINE l_ooff013_3           LIKE ooff_t.ooff013
   DEFINE l_ooff013             LIKE ooff_t.ooff013
   #161109-00085#13-mod-s
#   DEFINE l_sfqa                RECORD LIKE sfqa_t.*   mark
   DEFINE l_sfqa            RECORD  #PBI單頭檔
          sfqaent LIKE sfqa_t.sfqaent, #企業編號
          sfqasite LIKE sfqa_t.sfqasite, #營運據點
          sfqadocno LIKE sfqa_t.sfqadocno, #PBI單號
          sfqadocdt LIKE sfqa_t.sfqadocdt, #單據日期
          sfqa001 LIKE sfqa_t.sfqa001, #備註
          sfqaownid LIKE sfqa_t.sfqaownid, #資料所有者
          sfqaowndp LIKE sfqa_t.sfqaowndp, #資料所屬部門
          sfqacrtid LIKE sfqa_t.sfqacrtid, #資料建立者
          sfqacrtdp LIKE sfqa_t.sfqacrtdp, #資料建立部門
          sfqacrtdt LIKE sfqa_t.sfqacrtdt, #資料創建日
          sfqamodid LIKE sfqa_t.sfqamodid, #資料修改者
          sfqamoddt LIKE sfqa_t.sfqamoddt, #最近修改日
          sfqacnfid LIKE sfqa_t.sfqacnfid, #資料確認者
          sfqacnfdt LIKE sfqa_t.sfqacnfdt, #資料確認日
          sfqapstid LIKE sfqa_t.sfqapstid, #資料過帳者
          sfqapstdt LIKE sfqa_t.sfqapstdt, #資料過帳日
          sfqastus LIKE sfqa_t.sfqastus, #狀態碼
          sfqaud001 LIKE sfqa_t.sfqaud001, #自定義欄位(文字)001
          sfqaud002 LIKE sfqa_t.sfqaud002, #自定義欄位(文字)002
          sfqaud003 LIKE sfqa_t.sfqaud003, #自定義欄位(文字)003
          sfqaud004 LIKE sfqa_t.sfqaud004, #自定義欄位(文字)004
          sfqaud005 LIKE sfqa_t.sfqaud005, #自定義欄位(文字)005
          sfqaud006 LIKE sfqa_t.sfqaud006, #自定義欄位(文字)006
          sfqaud007 LIKE sfqa_t.sfqaud007, #自定義欄位(文字)007
          sfqaud008 LIKE sfqa_t.sfqaud008, #自定義欄位(文字)008
          sfqaud009 LIKE sfqa_t.sfqaud009, #自定義欄位(文字)009
          sfqaud010 LIKE sfqa_t.sfqaud010, #自定義欄位(文字)010
          sfqaud011 LIKE sfqa_t.sfqaud011, #自定義欄位(數字)011
          sfqaud012 LIKE sfqa_t.sfqaud012, #自定義欄位(數字)012
          sfqaud013 LIKE sfqa_t.sfqaud013, #自定義欄位(數字)013
          sfqaud014 LIKE sfqa_t.sfqaud014, #自定義欄位(數字)014
          sfqaud015 LIKE sfqa_t.sfqaud015, #自定義欄位(數字)015
          sfqaud016 LIKE sfqa_t.sfqaud016, #自定義欄位(數字)016
          sfqaud017 LIKE sfqa_t.sfqaud017, #自定義欄位(數字)017
          sfqaud018 LIKE sfqa_t.sfqaud018, #自定義欄位(數字)018
          sfqaud019 LIKE sfqa_t.sfqaud019, #自定義欄位(數字)019
          sfqaud020 LIKE sfqa_t.sfqaud020, #自定義欄位(數字)020
          sfqaud021 LIKE sfqa_t.sfqaud021, #自定義欄位(日期時間)021
          sfqaud022 LIKE sfqa_t.sfqaud022, #自定義欄位(日期時間)022
          sfqaud023 LIKE sfqa_t.sfqaud023, #自定義欄位(日期時間)023
          sfqaud024 LIKE sfqa_t.sfqaud024, #自定義欄位(日期時間)024
          sfqaud025 LIKE sfqa_t.sfqaud025, #自定義欄位(日期時間)025
          sfqaud026 LIKE sfqa_t.sfqaud026, #自定義欄位(日期時間)026
          sfqaud027 LIKE sfqa_t.sfqaud027, #自定義欄位(日期時間)027
          sfqaud028 LIKE sfqa_t.sfqaud028, #自定義欄位(日期時間)028
          sfqaud029 LIKE sfqa_t.sfqaud029, #自定義欄位(日期時間)029
          sfqaud030 LIKE sfqa_t.sfqaud030  #自定義欄位(日期時間)030
                    END RECORD
   #161109-00085#13-mod-e
   #161109-00085#13-mod-s
#   DEFINE l_sfqb                RECORD LIKE sfqb_t.*   mark
   DEFINE l_sfqb           RECORD  #PBI單身檔
       sfqbent LIKE sfqb_t.sfqbent, #企業編號
       sfqbsite LIKE sfqb_t.sfqbsite, #營運據點
       sfqbdocno LIKE sfqb_t.sfqbdocno, #PBI單號
       sfqb001 LIKE sfqb_t.sfqb001, #工單單號
       sfqbud001 LIKE sfqb_t.sfqbud001, #自定義欄位(文字)001
       sfqbud002 LIKE sfqb_t.sfqbud002, #自定義欄位(文字)002
       sfqbud003 LIKE sfqb_t.sfqbud003, #自定義欄位(文字)003
       sfqbud004 LIKE sfqb_t.sfqbud004, #自定義欄位(文字)004
       sfqbud005 LIKE sfqb_t.sfqbud005, #自定義欄位(文字)005
       sfqbud006 LIKE sfqb_t.sfqbud006, #自定義欄位(文字)006
       sfqbud007 LIKE sfqb_t.sfqbud007, #自定義欄位(文字)007
       sfqbud008 LIKE sfqb_t.sfqbud008, #自定義欄位(文字)008
       sfqbud009 LIKE sfqb_t.sfqbud009, #自定義欄位(文字)009
       sfqbud010 LIKE sfqb_t.sfqbud010, #自定義欄位(文字)010
       sfqbud011 LIKE sfqb_t.sfqbud011, #自定義欄位(數字)011
       sfqbud012 LIKE sfqb_t.sfqbud012, #自定義欄位(數字)012
       sfqbud013 LIKE sfqb_t.sfqbud013, #自定義欄位(數字)013
       sfqbud014 LIKE sfqb_t.sfqbud014, #自定義欄位(數字)014
       sfqbud015 LIKE sfqb_t.sfqbud015, #自定義欄位(數字)015
       sfqbud016 LIKE sfqb_t.sfqbud016, #自定義欄位(數字)016
       sfqbud017 LIKE sfqb_t.sfqbud017, #自定義欄位(數字)017
       sfqbud018 LIKE sfqb_t.sfqbud018, #自定義欄位(數字)018
       sfqbud019 LIKE sfqb_t.sfqbud019, #自定義欄位(數字)019
       sfqbud020 LIKE sfqb_t.sfqbud020, #自定義欄位(數字)020
       sfqbud021 LIKE sfqb_t.sfqbud021, #自定義欄位(日期時間)021
       sfqbud022 LIKE sfqb_t.sfqbud022, #自定義欄位(日期時間)022
       sfqbud023 LIKE sfqb_t.sfqbud023, #自定義欄位(日期時間)023
       sfqbud024 LIKE sfqb_t.sfqbud024, #自定義欄位(日期時間)024
       sfqbud025 LIKE sfqb_t.sfqbud025, #自定義欄位(日期時間)025
       sfqbud026 LIKE sfqb_t.sfqbud026, #自定義欄位(日期時間)026
       sfqbud027 LIKE sfqb_t.sfqbud027, #自定義欄位(日期時間)027
       sfqbud028 LIKE sfqb_t.sfqbud028, #自定義欄位(日期時間)028
       sfqbud029 LIKE sfqb_t.sfqbud029, #自定義欄位(日期時間)029
       sfqbud030 LIKE sfqb_t.sfqbud030  #自定義欄位(日期時間)030
                 END RECORD
   #161109-00085#13-mod-e
   DEFINE l_cnt                 LIKE type_t.num5
   DEFINE l_psaastus            LIKE psaa_t.psaastus   #add--160706-00037#7 By shiun
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   #检查:不应在事物中的
   IF NOT s_transaction_chk('N','0') THEN
      RETURN r_success
   END IF
   LET l_flag = 'Y'
   
   LET l_sql = " SELECT keyno   , psabdocno, psabseq,'', ",
               "        psab001 ,psab012,", #160214-00005#5-add-'psab012'
               #160512-00016#1 20160524 modify by ming -----(S) 
               #"        ''      , ''       , psab002, ''      , psab005 ,",
               "        ''      , ''       , psab002, ''      , ", 
               "        psab013 ,psab005 ,",
               #160512-00016#1 20160524 modify by ming -----(E) 
               "        psab004 , ''       , qty    , psab003  ",
               "  FROM apsp300_tmp02",       #160727-00019#14 Mod   apsp300_03_temp_d2 -->apsp300_tmp02
               " WHERE keyno = ? "
   PREPARE apsp300_04_done_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare apsp300_04_done_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   DECLARE apsp300_04_done_cs1 CURSOR FOR apsp300_04_done_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare apsp300_04_done_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF   

   #160512-00016#1 20160524 modify by ming -----(S) 
   #LET l_sql = " SELECT xmdd011,SUM(qty)", 
   #            "  FROM asfp301_03_temp_d2",
   #            " WHERE keyno = ? ",
   #            " GROUP BY xmdd011"
   LET l_sql = " SELECT psab003,SUM(qty)", 
               "  FROM apsp300_tmp02",        #160727-00019#14 Mod   apsp300_03_temp_d2 -->apsp300_tmp02
               " WHERE keyno = ? ",
               " GROUP BY psab003"
   #160512-00016#1 20160524 modify by ming -----(E) 
   PREPARE apsp300_04_done_p2 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare apsp300_04_done_p2'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   DECLARE apsp300_04_done_cs2 CURSOR FOR apsp300_04_done_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare apsp300_04_done_cs2'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF   

   CALL cl_err_collect_init()
   INITIALIZE l_sfqa.* TO NULL
   IF g_setting.choice5 = 'Y' THEN
      LET l_cnt = g_sfaa_d.getLength()
      IF l_cnt > 0 THEN
         CALL s_transaction_begin()
         INITIALIZE l_sfqa.* TO NULL
         INITIALIZE l_sfqb.* TO NULL
         LET l_sfqa.sfqaent   = g_enterprise        #企業代碼    
         LET l_sfqa.sfqasite  = g_site              #營運據點 
         #PBI單號     
         CALL s_aooi200_gen_docno(g_site,g_setting.choice6,g_sfaadocdt,'asft303')
              RETURNING l_success,l_sfqa.sfqadocno
         IF NOT l_success THEN
            LET l_flag = 'N'
         END IF                      
         LET l_sfqa.sfqadocdt = g_sfaadocdt         #單據日期    
         LET l_sfqa.sfqa001   = ''                  #備註        
         LET l_sfqa.sfqaownid = g_user              #資料所有者  
         LET l_sfqa.sfqaowndp = g_dept              #資料所屬部門
         LET l_sfqa.sfqacrtid = g_user              #資料建立者  
         LET l_sfqa.sfqacrtdp = g_dept              #資料建立部門
         LET l_sfqa.sfqacrtdt = cl_get_current()    #資料創建日  
         LET l_sfqa.sfqamodid = ''                  #資料修改者  
         LET l_sfqa.sfqamoddt = ''                  #最近修改日  
         LET l_sfqa.sfqacnfid = ''                  #資料確認者  
         LET l_sfqa.sfqacnfdt = ''                  #資料確認日  
         LET l_sfqa.sfqapstid = ''                  #資料過帳者  
         LET l_sfqa.sfqapstdt = ''                  #資料過帳日  
         LET l_sfqa.sfqastus = 'N'                  #狀態碼
         #161109-00085#13-mod-s
#         INSERT INTO sfqa_t VALUES(l_sfqa.*)
         INSERT INTO sfqa_t(sfqaent,sfqasite,sfqadocno,sfqadocdt,sfqa001,sfqaownid,sfqaowndp,sfqacrtid,sfqacrtdp,sfqacrtdt,
                            sfqamodid,sfqamoddt,sfqacnfid,sfqacnfdt,sfqapstid,sfqapstdt,sfqastus,sfqaud001,sfqaud002,sfqaud003,
                            sfqaud004,sfqaud005,sfqaud006,sfqaud007,sfqaud008,sfqaud009,sfqaud010,sfqaud011,sfqaud012,sfqaud013,
                            sfqaud014,sfqaud015,sfqaud016,sfqaud017,sfqaud018,sfqaud019,sfqaud020,sfqaud021,sfqaud022,sfqaud023,
                            sfqaud024,sfqaud025,sfqaud026,sfqaud027,sfqaud028,sfqaud029,sfqaud030) 
                     VALUES(l_sfqa.sfqaent,l_sfqa.sfqasite,l_sfqa.sfqadocno,l_sfqa.sfqadocdt,l_sfqa.sfqa001,
                            l_sfqa.sfqaownid,l_sfqa.sfqaowndp,l_sfqa.sfqacrtid,l_sfqa.sfqacrtdp,l_sfqa.sfqacrtdt,
                            l_sfqa.sfqamodid,l_sfqa.sfqamoddt,l_sfqa.sfqacnfid,l_sfqa.sfqacnfdt,l_sfqa.sfqapstid,
                            l_sfqa.sfqapstdt,l_sfqa.sfqastus,l_sfqa.sfqaud001,l_sfqa.sfqaud002,l_sfqa.sfqaud003,
                            l_sfqa.sfqaud004,l_sfqa.sfqaud005,l_sfqa.sfqaud006,l_sfqa.sfqaud007,l_sfqa.sfqaud008,
                            l_sfqa.sfqaud009,l_sfqa.sfqaud010,l_sfqa.sfqaud011,l_sfqa.sfqaud012,l_sfqa.sfqaud013,
                            l_sfqa.sfqaud014,l_sfqa.sfqaud015,l_sfqa.sfqaud016,l_sfqa.sfqaud017,l_sfqa.sfqaud018,
                            l_sfqa.sfqaud019,l_sfqa.sfqaud020,l_sfqa.sfqaud021,l_sfqa.sfqaud022,l_sfqa.sfqaud023,
                            l_sfqa.sfqaud024,l_sfqa.sfqaud025,l_sfqa.sfqaud026,l_sfqa.sfqaud027,l_sfqa.sfqaud028,
                            l_sfqa.sfqaud029,l_sfqa.sfqaud030)
         #161109-00085#13-mod-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert sfqa'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_flag = 'N'
         END IF 
         IF l_flag = 'N' THEN
            CALL s_transaction_end('N','0')
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
      END IF
   END IF
   
   
   FOR l_i = 1 TO g_sfaa_d.getLength()
      #add--160706-00037#7 By shiun--(S)
      #檢查來源單據的狀態碼(例如可拋轉的單據狀態碼應該是Y.已確認)，若為不可拋轉的資料提示"單據編號OOO單據狀態碼非Y.已確認不可拋轉"
      SELECT psaastus INTO l_psaastus
        FROM psaa_t
       WHERE psaaent   = g_enterprise
         AND psaadocno = g_sfaa_d[l_i].sfaa006
      IF l_psaastus <> 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01119'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = g_sfaa_d[l_i].sfaa006
         CALL cl_err()
         CONTINUE FOR
      END IF
      #add--160706-00037#7 By shiun--(E)
       CALL s_transaction_begin()
       INITIALIZE l_sfaa.* TO NULL
       LET l_sfaa.sfaaent   = g_enterprise                        #企業編號
       LET l_sfaa.sfaaownid = g_user                              #資料所有者
       LET l_sfaa.sfaaowndp = g_dept                              #資料所屬部門
       LET l_sfaa.sfaacrtid = g_user                              #資料建立者
       LET l_sfaa.sfaacrtdp = g_dept                              #資料建立部門
       LET l_sfaa.sfaacrtdt = cl_get_current()                    #資料創建日
       LET l_sfaa.sfaamodid = ''                                  #資料修改者
       LET l_sfaa.sfaamoddt = ''                                  #最近修改日
       LET l_sfaa.sfaacnfid = ''                                  #資料確認者
       LET l_sfaa.sfaacnfdt = ''                                  #資料確認日
       LET l_sfaa.sfaapstid = ''                                  #資料過帳者
       LET l_sfaa.sfaapstdt = ''                                  #資料過帳日
       LET l_sfaa.sfaastus  = 'N'                                 #狀態碼
       LET l_sfaa.sfaasite  = g_site                              #營運據點
       CALL s_aooi200_gen_docno(g_site,g_sfaa_d[l_i].sfaadocno,g_sfaadocdt,'asft300')
            RETURNING l_success,l_sfaadocno
       IF NOT l_success THEN
          LET l_flag = 'N'
          CONTINUE FOR
       END IF
       
       LET l_sfaa.sfaadocno = l_sfaadocno                         #單號
       LET l_sfaa.sfaadocdt = g_sfaadocdt                         #單據日期
       LET l_sfaa.sfaa001   = 0                                   #變更版本
       LET l_sfaa.sfaa002   = g_user                              #生管人員
       LET l_sfaa.sfaa003   = g_sfaa_d[l_i].sfaa003               #工單類型
       LET l_sfaa.sfaa004   = '1'                                 #發料制度
       LET l_sfaa.sfaa005   = g_sfaa_d[l_i].sfaa005               #工單來源
       LET l_sfaa.sfaa006   = g_sfaa_d[l_i].sfaa006               #來源單號
       LET l_sfaa.sfaa007   = g_sfaa_d[l_i].sfaa007               #來源項次
       
       LET l_sfaa.sfaa009   = g_sfaa_d[l_i].sfaa009               #參考客戶
       LET l_sfaa.sfaa010   = g_sfaa_d[l_i].sfaa010               #生產料號
       LET l_sfaa.sfaa011   = g_sfaa_d[l_i].sfaa011               #特性
       LET l_sfaa.sfaa012   = g_sfaa_d[l_i].sfaa012               #生產數量
       LET l_sfaa.sfaa013   = g_sfaa_d[l_i].sfaa013               #生產單位
       LET l_sfaa.sfaa014   = ''                                  #BOM版本
       LET l_sfaa.sfaa015   = ''                                  #BOM有效日期
       LET l_sfaa.sfaa016   = g_sfaa_d[l_i].sfaa016               #製程編號
       LET l_sfaa.sfaa017   = g_sfaa_d[l_i].sfaa017               #部門廠商
       LET l_sfaa.sfaa018   = ''                                  #協作據點
       LET l_sfaa.sfaa019   = g_sfaa_d[l_i].sfaa019               #預計開工日
       LET l_sfaa.sfaa020   = g_sfaa_d[l_i].sfaa020               #預計完工日
       LET l_sfaa.sfaa021   = ''                                  #母工單單號
       LET l_sfaa.sfaa022   = ''                                  #參考原始單號
       LET l_sfaa.sfaa023   = ''                                  #參考原始項次
       LET l_sfaa.sfaa024   = ''                                  #參考原始項序
       LET l_sfaa.sfaa025   = ''                                  #前工單單號
       LET l_sfaa.sfaa026   = l_sfqa.sfqadocno                    #料表批號(PBI)
       LET l_sfaa.sfaa027   = ''                                  #No Use
       LET l_sfaa.sfaa028   = ''                                  #專案代號
       LET l_sfaa.sfaa029   =''                                   #WBS
       LET l_sfaa.sfaa030   =''                                   #活動
       LET l_sfaa.sfaa031   =''                                   #理由碼
       LET l_sfaa.sfaa032   = ''                                  #緊急比率
       LET l_sfaa.sfaa033   = ''                                  #優先順序
       LET l_sfaa.sfaa034   = ''                                  #預計入庫庫位
       LET l_sfaa.sfaa035   = ''                                  #預計入庫儲位
       LET l_sfaa.sfaa036   = ''                                  #手冊編號
       LET l_sfaa.sfaa037   = ''                                  #保稅核准文號
       LET l_sfaa.sfaa038   = 'N'                                 #保稅核銷
       LET l_sfaa.sfaa039   = 'N'                                 #備料已產生
       LET l_sfaa.sfaa040   = 'N'                                 #生產途程已確認
       LET l_sfaa.sfaa041   = 'N'                                 #凍結
       LET l_sfaa.sfaa042   = 'N'                                 #重工
       LET l_sfaa.sfaa043   = 'N'                                 #備置
       LET l_sfaa.sfaa044   = 'N'                                 #FQC
       LET l_sfaa.sfaa045   = ''                                  #實際開始發料日
       LET l_sfaa.sfaa046   = ''                                  #最後入庫日
       LET l_sfaa.sfaa047   = ''                                  #生管結案日
       LET l_sfaa.sfaa048   = ''                                  #成本結案日
       LET l_sfaa.sfaa049   = 0                                   #已發料套數
       LET l_sfaa.sfaa050   = 0                                   #已入庫合格量
       LET l_sfaa.sfaa051   = 0                                   #已入庫不合格量
       LET l_sfaa.sfaa052   = 0                                   #Bouns
       LET l_sfaa.sfaa053   = 0                                   #工單轉入數量
       LET l_sfaa.sfaa054   = 0                                   #工單轉出數量
       LET l_sfaa.sfaa055   = 0                                   #下線數量
       LET l_sfaa.sfaa056   = 0                                   #報廢數量
       LET l_sfaa.sfaa057   = g_sfaa_d[l_i].sfaa057               #委外類型

       LET l_imaf015 = NULL
       SELECT imaf015 INTO l_imaf015 FROM imaf_t
        WHERE imafent  = g_enterprise
          AND imafsite = g_site
          AND imaf001  = l_sfaa.sfaa010
       LET l_sfaa.sfaa060 = l_imaf015                             #參考單位
       
       #參考數量 
       #若没有参考单位时,参考数量DEFAULT NULL
       IF cl_null(l_sfaa.sfaa060) THEN
          LET l_sfaa.sfaa058 = NULL
       END IF
       
       LET l_sfaa.sfaa058 = l_sfaa.sfaa012
       
       IF NOT cl_null(l_sfaa.sfaa013) AND NOT cl_null(l_sfaa.sfaa060) THEN
#          CALL s_aimi190_get_convert(l_sfaa.sfaa010,l_sfaa.sfaa013,l_sfaa.sfaa060)
#               RETURNING l_success,l_rate
#          IF NOT l_success THEN
#             LET l_rate = 1
#          END IF
          CALL s_aooi250_convert_qty(l_sfaa.sfaa010,l_sfaa.sfaa013,l_sfaa.sfaa060,l_sfaa.sfaa012)
               RETURNING l_success,l_sfaa.sfaa058
          IF NOT l_success THEN
             LET l_sfaa.sfaa058 = l_sfaa.sfaa012
          END IF          
       END IF
       
#       LET l_sfaa.sfaa058 = l_sfaa.sfaa012 * l_rate
   
       LET l_sfaa.sfaa059   = ''                                  #預計入庫批號
           
       LET l_sfaa.sfaa061   = g_sfaa_d[l_i].sfaa061               #製程
       IF l_sfaa.sfaa061 = 'Y' AND cl_null(l_sfaa.sfaa016) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'asf-00190'
          LET g_errparam.extend = l_sfaa.sfaa010
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CALL s_transaction_end('N','0')
          LET l_flag = 'N'
          CONTINUE FOR       
       END IF
       LET l_sfaa.sfaa062   = 'Y'                                 #納入APS計算
       
       LET l_sfaa.sfaa064   = ''                                  #參考原始分批序
       LET l_sfaa.sfaa065   = '0'                                 #生管結案狀態--未结案
       LET l_sfaa.sfaa066   = ''                                  #多角流程代碼
       LET l_sfaa.sfaa067   = ''                                  #多角流程序號
       
       LET l_sfaa.sfaa071   = 0                                   #160425-00019 by whitney add 齊料套數 
       
       #160512-00016#1 20160524 add by ming -----(S) 
       LET l_sfaa.sfaa072   = g_sfaa_d[l_i].sfaa072 
       #160512-00016#1 20160524 add by ming -----(E) 
       #161109-00085#13-mod-s
#       INSERT INTO sfaa_t VALUES(l_sfaa.*)   #161109-00085#13  mark  
       INSERT INTO sfaa_t(sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
                          sfaapstid,sfaapstdt,sfaastus,sfaasite,sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,
                          sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,
                          sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,
                          sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,
                          sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,
                          sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,
                          sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
                          sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,sfaa070,sfaaud001,sfaaud002,sfaaud003,sfaaud004,
                          sfaaud005,sfaaud006,sfaaud007,sfaaud008,sfaaud009,sfaaud010,sfaaud011,sfaaud012,sfaaud013,sfaaud014,
                          sfaaud015,sfaaud016,sfaaud017,sfaaud018,sfaaud019,sfaaud020,sfaaud021,sfaaud022,sfaaud023,sfaaud024,
                          sfaaud025,sfaaud026,sfaaud027,sfaaud028,sfaaud029,sfaaud030,sfaa071,sfaa072) 
                   VALUES(l_sfaa.sfaaent,l_sfaa.sfaaownid,l_sfaa.sfaaowndp,l_sfaa.sfaacrtid,l_sfaa.sfaacrtdp,
                          l_sfaa.sfaacrtdt,l_sfaa.sfaamodid,l_sfaa.sfaamoddt,l_sfaa.sfaacnfid,l_sfaa.sfaacnfdt,
                          l_sfaa.sfaapstid,l_sfaa.sfaapstdt,l_sfaa.sfaastus,l_sfaa.sfaasite,l_sfaa.sfaadocno,
                          l_sfaa.sfaadocdt,l_sfaa.sfaa001,l_sfaa.sfaa002,l_sfaa.sfaa003,l_sfaa.sfaa004,
                          l_sfaa.sfaa005,l_sfaa.sfaa006,l_sfaa.sfaa007,l_sfaa.sfaa008,l_sfaa.sfaa009,
                          l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa014,
                          l_sfaa.sfaa015,l_sfaa.sfaa016,l_sfaa.sfaa017,l_sfaa.sfaa018,l_sfaa.sfaa019,
                          l_sfaa.sfaa020,l_sfaa.sfaa021,l_sfaa.sfaa022,l_sfaa.sfaa023,l_sfaa.sfaa024,
                          l_sfaa.sfaa025,l_sfaa.sfaa026,l_sfaa.sfaa027,l_sfaa.sfaa028,l_sfaa.sfaa029,
                          l_sfaa.sfaa030,l_sfaa.sfaa031,l_sfaa.sfaa032,l_sfaa.sfaa033,l_sfaa.sfaa034,
                          l_sfaa.sfaa035,l_sfaa.sfaa036,l_sfaa.sfaa037,l_sfaa.sfaa038,l_sfaa.sfaa039,
                          l_sfaa.sfaa040,l_sfaa.sfaa041,l_sfaa.sfaa042,l_sfaa.sfaa043,l_sfaa.sfaa044,
                          l_sfaa.sfaa045,l_sfaa.sfaa046,l_sfaa.sfaa047,l_sfaa.sfaa048,l_sfaa.sfaa049,
                          l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa052,l_sfaa.sfaa053,l_sfaa.sfaa054,
                          l_sfaa.sfaa055,l_sfaa.sfaa056,l_sfaa.sfaa057,l_sfaa.sfaa058,l_sfaa.sfaa059,
                          l_sfaa.sfaa060,l_sfaa.sfaa061,l_sfaa.sfaa062,l_sfaa.sfaa063,l_sfaa.sfaa064,
                          l_sfaa.sfaa065,l_sfaa.sfaa066,l_sfaa.sfaa067,l_sfaa.sfaa068,l_sfaa.sfaa069,
                          l_sfaa.sfaa070,l_sfaa.sfaaud001,l_sfaa.sfaaud002,l_sfaa.sfaaud003,l_sfaa.sfaaud004,
                          l_sfaa.sfaaud005,l_sfaa.sfaaud006,l_sfaa.sfaaud007,l_sfaa.sfaaud008,l_sfaa.sfaaud009,
                          l_sfaa.sfaaud010,l_sfaa.sfaaud011,l_sfaa.sfaaud012,l_sfaa.sfaaud013,l_sfaa.sfaaud014,
                          l_sfaa.sfaaud015,l_sfaa.sfaaud016,l_sfaa.sfaaud017,l_sfaa.sfaaud018,l_sfaa.sfaaud019,
                          l_sfaa.sfaaud020,l_sfaa.sfaaud021,l_sfaa.sfaaud022,l_sfaa.sfaaud023,l_sfaa.sfaaud024,
                          l_sfaa.sfaaud025,l_sfaa.sfaaud026,l_sfaa.sfaaud027,l_sfaa.sfaaud028,l_sfaa.sfaaud029,
                          l_sfaa.sfaaud030,l_sfaa.sfaa071,l_sfaa.sfaa072)
       #161109-00085#13-mod-e
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert sfaa'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CALL s_transaction_end('N','0')
          LET l_flag = 'N'
          CONTINUE FOR
       END IF 
                   
       #订单的单身长备注设置为ooff015='Y'(内部信息传递)时,要把订单长备注带至工单备注中
       #仅当sfaa006(来源单号),sfaa007(来源项次)有具体值时,才处理
       IF NOT cl_null(l_sfaa.sfaa006) AND NOT cl_null(l_sfaa.sfaa007) THEN
          SELECT ooff013 INTO l_ooff013_1 FROM ooff_t
           WHERE ooffent = g_enterprise
             AND ooff001 = '7'
             AND ooff002 = l_sfaa.sfaa006
             AND ooff003 = l_sfaa.sfaa007
             AND ooff012 = '1'
             AND ooff015 = 'Y'
             
          SELECT ooff013 INTO l_ooff013_2 FROM ooff_t
           WHERE ooffent = g_enterprise
             AND ooff001 = '7'
             AND ooff002 = l_sfaa.sfaa006
             AND ooff003 = l_sfaa.sfaa007
             AND ooff012 = '2'
             AND ooff015 = 'Y'
             
          SELECT ooff013 INTO l_ooff013_3 FROM ooff_t
           WHERE ooffent = g_enterprise
             AND ooff001 = '7'
             AND ooff002 = l_sfaa.sfaa006
             AND ooff003 = l_sfaa.sfaa007
             AND ooff012 = '4'
             AND ooff015 = 'Y'
             
          LET l_ooff013 = ''
          IF NOT cl_null(l_ooff013_1) THEN
             LET l_ooff013 = l_ooff013_1
          END IF
          
          IF NOT cl_null(l_ooff013_2) THEN
             IF NOT cl_null(l_ooff013) THEN
                LET l_ooff013 = l_ooff013 CLIPPED,'\n',l_ooff013_2
             ELSE
                LET l_ooff013 = l_ooff013_2
             END IF
          END IF

          IF NOT cl_null(l_ooff013_3) THEN
             IF NOT cl_null(l_ooff013) THEN
                LET l_ooff013 = l_ooff013 CLIPPED,'\n',l_ooff013_3
             ELSE
                LET l_ooff013 = l_ooff013_3
             END IF
          END IF
          
          IF NOT cl_null(l_ooff013) THEN
             CALL s_aooi360_gen('6',l_sfaa.sfaadocno,' ',' ',' ',' ',' ',' ',' ',' ',' ','1',l_ooff013)
                  RETURNING l_success
          END IF
       END IF
       
       FOREACH apsp300_04_done_cs1 USING g_sfaa_d[l_i].keyno
                                    INTO l_psab_d.*
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach apsp300_04_done_cs1'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             CALL s_transaction_end('N','0')
             LET l_flag = 'N'
             CONTINUE FOR
          END IF
          
          LET l_sfab.sfabent   = g_enterprise           #企業編號  
          LET l_sfab.sfabsite  = g_site                 #營運據點
          LET l_sfab.sfabdocno = l_sfaa.sfaadocno       #單號    
          LET l_sfab.sfab001   = '6'                    #來源        
          LET l_sfab.sfab002   = l_psab_d.psabdocno     #來源單號  
          LET l_sfab.sfab003   = l_psab_d.sfbaseq       #來源項次  
  
          #分配優先序
          SELECT MAX(sfab006) INTO l_sfab.sfab006 FROM sfab_t 
           WHERE sfabent   = g_enterprise 
             AND sfabsite  = g_site
             AND sfabdocno = l_sfab.sfabdocno
          IF cl_null(l_sfab.sfab006) THEN
             LET l_sfab.sfab006 = 10
          ELSE
             LET l_sfab.sfab006 = l_sfab.sfab006 + 10
          END IF
          LET l_sfab.sfab007   = l_psab_d.qty           #本次轉開工單量
          #項次
          SELECT MAX(sfabseq)+1 INTO l_sfab.sfabseq FROM sfab_t
           WHERE sfabent = g_enterprise AND sfabsite = g_site
             AND sfabdocno = l_sfab.sfabdocno
          IF cl_null(l_sfab.sfabseq) THEN
             LET l_sfab.sfabseq = 1   
          END IF                    
          #161109-00085#13-mod-s
#          INSERT INTO sfab_t VALUES(l_sfab.*)   #161109-00085#13   mark
          INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfab001,sfab002,sfab003,sfab004,sfab005,sfab006,sfab007,
                             sfabseq,sfabud001,sfabud002,sfabud003,sfabud004,sfabud005,sfabud006,sfabud007,sfabud008,sfabud009,
                             sfabud010,sfabud011,sfabud012,sfabud013,sfabud014,sfabud015,sfabud016,sfabud017,sfabud018,sfabud019,
                             sfabud020,sfabud021,sfabud022,sfabud023,sfabud024,sfabud025,sfabud026,sfabud027,sfabud028,sfabud029,
                             sfabud030) 
                      VALUES(l_sfab.sfabent,l_sfab.sfabsite,l_sfab.sfabdocno,l_sfab.sfab001,l_sfab.sfab002,
                             l_sfab.sfab003,l_sfab.sfab004,l_sfab.sfab005,l_sfab.sfab006,l_sfab.sfab007,
                             l_sfab.sfabseq,l_sfab.sfabud001,l_sfab.sfabud002,l_sfab.sfabud003,l_sfab.sfabud004,
                             l_sfab.sfabud005,l_sfab.sfabud006,l_sfab.sfabud007,l_sfab.sfabud008,l_sfab.sfabud009,
                             l_sfab.sfabud010,l_sfab.sfabud011,l_sfab.sfabud012,l_sfab.sfabud013,l_sfab.sfabud014,
                             l_sfab.sfabud015,l_sfab.sfabud016,l_sfab.sfabud017,l_sfab.sfabud018,l_sfab.sfabud019,
                             l_sfab.sfabud020,l_sfab.sfabud021,l_sfab.sfabud022,l_sfab.sfabud023,l_sfab.sfabud024,
                             l_sfab.sfabud025,l_sfab.sfabud026,l_sfab.sfabud027,l_sfab.sfabud028,l_sfab.sfabud029,
                             l_sfab.sfabud030)
          #161109-00085#13-mod-e
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert sfab_t'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             CALL s_transaction_end('N','0')
             LET l_flag = 'N'
             CONTINUE FOR
          END IF 
          
          #160530-00038#1 20160607 add by ming -----(S) 
          #更新獨立需求的已耗數量
          UPDATE psab_t SET psab006 = psab006 + l_psab_d.psab005 
           WHERE psabent   = g_enterprise 
             AND psabdocno = l_psab_d.psabdocno 
             AND psabseq   = l_psab_d.sfbaseq 
          IF SQLCA.sqlcode THEN 
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = 'update psab_t' 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err() 
             CALL s_transaction_end('N','0') 
             LET l_flag = 'N' 
             CONTINUE FOR 
          END IF 
          #160530-00038#1 20160607 add by ming -----(E) 
          
          #170103-00052#1-s-mark  移至外圈，放這裡，當單據合併時，會多寫入資料
          ##161104-00037#1 add---start---
          #LET g_04_i = l_i
          #CALL apsp300_04_ins_sfac(l_sfaa.sfaadocno,l_psab_d.psab002)
          #   RETURNING l_success
          #IF NOT l_success THEN
          #   CALL s_transaction_end('N','0')
          #   LET l_flag = 'N'
          #   CONTINUE FOR
          #END IF
          ##161104-00037#1 add---end---
          #170103-00052#1-e-mark
       END FOREACH
       #170103-00052#1-s-add
       LET g_04_i = l_i
       CALL apsp300_04_ins_sfac(l_sfaa.sfaadocno,l_psab_d.psab002)
          RETURNING l_success
       IF NOT l_success THEN
          CALL s_transaction_end('N','0')
          LET l_flag = 'N'
          CONTINUE FOR
       END IF
       #170103-00052#1-e-add
#161024-00057#19-s
#       FOREACH apsp300_04_done_cs2 USING g_sfaa_d[l_i].keyno
#                                    INTO l_psab003,l_qty
#          IF SQLCA.sqlcode THEN
#             INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = SQLCA.sqlcode
#             LET g_errparam.extend = 'foreach apsp300_04_done_cs2'
#             LET g_errparam.popup = TRUE
#             CALL cl_err()
#             CALL s_transaction_end('N','0')
#             LET l_flag = 'N'
#             CONTINUE FOR
#          END IF
#          
#          INITIALIZE l_sfae.* TO NULL
#          LET l_sfae.sfaeent   = g_enterprise        #企業編號                 
#          LET l_sfae.sfaesite  = g_site              #營運據點        
#          LET l_sfae.sfaedocno = l_sfaa.sfaadocno    #單號   
#          #項次
#          SELECT MAX(sfaeseq) + 1 INTO l_sfae.sfaeseq FROM sfae_t 
#           WHERE sfaeent   = g_enterprise 
#             AND sfaesite  = g_site
#             AND sfaedocno = l_sfae.sfaedocno
#          IF cl_null(l_sfae.sfaeseq) THEN
#             LET l_sfae.sfaeseq = 1
#          END IF                                     
#          LET l_sfae.sfae001   = l_qty              #數量            
#          LET l_sfae.sfae002   = l_psab003          #預計完工日期   
#          LET l_sfae.sfae003   = ''                 #累計數量達成日  
#          LET l_sfae.sfae004   = 0                  #修正次數        
#          LET l_sfae.sfae005   = ''                 #修改人員        
#          LET l_sfae.sfae006   = ''                 #修改日期                  
#          INSERT INTO sfae_t VALUES(l_sfae.*)
#          IF SQLCA.sqlcode THEN
#             INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = SQLCA.sqlcode
#             LET g_errparam.extend = 'insert sfae_t'
#             LET g_errparam.popup = TRUE
#             CALL cl_err()
#             CALL s_transaction_end('N','0')
#             LET l_flag = 'N'
#             CONTINUE FOR
#          END IF
#
#       END FOREACH
#
#161024-00057#19-e

       #161104-00037#1 mark---start---
       #CALL apsp300_04_ins_sfac(l_sfaa.sfaadocno,g_sfaa_d[l_i].sfac006)
       #     RETURNING l_success
       #IF NOT l_success THEN
       #   CALL s_transaction_end('N','0')
       #   LET l_flag = 'N'
       #   CONTINUE FOR
       #END IF       
       #161104-00037#1 mark---end---       
       CALL s_asft300_02(l_sfaa.sfaadocno,l_sfaa.sfaa003,l_sfaa.sfaa010,
                         l_sfaa.sfaa011,l_sfaa.sfaa015,l_sfaa.sfaa012,'N') 
            RETURNING l_success,l_num
       IF NOT l_success THEN
          CALL s_transaction_end('N','0')
          LET l_flag = 'N'
          CONTINUE FOR
       END IF
       
       IF g_setting.choice5 = 'Y' THEN
          INITIALIZE l_sfqb.* TO NULL
          LET l_sfqb.sfqbent   = g_enterprise         #企業代碼
          LET l_sfqb.sfqbsite  = g_site               #營運據點
          LET l_sfqb.sfqbdocno = l_sfqa.sfqadocno     #PBI單號 
          LET l_sfqb.sfqb001   = l_sfaa.sfaadocno     #工單單號
          #161109-00085#13-mod-s
#          INSERT INTO sfqb_t VALUES(l_sfqb.*)   #161109-00085#13   mark
          INSERT INTO sfqb_t(sfqbent,sfqbsite,sfqbdocno,sfqb001,sfqbud001,sfqbud002,sfqbud003,sfqbud004,sfqbud005,sfqbud006,
                             sfqbud007,sfqbud008,sfqbud009,sfqbud010,sfqbud011,sfqbud012,sfqbud013,sfqbud014,sfqbud015,sfqbud016,
                             sfqbud017,sfqbud018,sfqbud019,sfqbud020,sfqbud021,sfqbud022,sfqbud023,sfqbud024,sfqbud025,sfqbud026,
                             sfqbud027,sfqbud028,sfqbud029,sfqbud030) 
                      VALUES(l_sfqb.sfqbent,l_sfqb.sfqbsite,l_sfqb.sfqbdocno,l_sfqb.sfqb001,l_sfqb.sfqbud001,
                             l_sfqb.sfqbud002,l_sfqb.sfqbud003,l_sfqb.sfqbud004,l_sfqb.sfqbud005,l_sfqb.sfqbud006,
                             l_sfqb.sfqbud007,l_sfqb.sfqbud008,l_sfqb.sfqbud009,l_sfqb.sfqbud010,l_sfqb.sfqbud011,
                             l_sfqb.sfqbud012,l_sfqb.sfqbud013,l_sfqb.sfqbud014,l_sfqb.sfqbud015,l_sfqb.sfqbud016,
                             l_sfqb.sfqbud017,l_sfqb.sfqbud018,l_sfqb.sfqbud019,l_sfqb.sfqbud020,l_sfqb.sfqbud021,
                             l_sfqb.sfqbud022,l_sfqb.sfqbud023,l_sfqb.sfqbud024,l_sfqb.sfqbud025,l_sfqb.sfqbud026,
                             l_sfqb.sfqbud027,l_sfqb.sfqbud028,l_sfqb.sfqbud029,l_sfqb.sfqbud030)
          #161109-00085#13-mod-e
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert sfqb_t'
             LET g_errparam.popup = TRUE
             CALL cl_err()
             CALL s_transaction_end('N','0')
             LET l_flag = 'N'
             CONTINUE FOR
          END IF          
       END IF
       
       #数据产生成功
       CALL cl_errmsg('sfaadocno','',l_sfaa.sfaadocno,'axm-00088',2)    
       CALL s_transaction_end('Y','0')
       IF cl_null(l_wc) THEN
          LET l_wc = l_wc CLIPPED,"'",l_sfaa.sfaadocno,"'"
       ELSE
          LET l_wc = l_wc CLIPPED,",'",l_sfaa.sfaadocno,"'"
       END IF
   END FOR

   CALL cl_err_collect_show()
   LET r_success = TRUE
   IF l_flag = 'N' THEN
      LET r_success = FALSE
   END IF
   
   IF NOT cl_null(l_wc) THEN
      #是否要运行asft300查看生成的工单信息[Y/N]?
      LET l_choice = cl_ask_promp('asf-00377')
      IF l_choice = TRUE THEN
          LET la_param.prog     = "asft300"
          #LET la_param.param[2] = "sfaadocno IN (",l_wc CLIPPED,")"      #161104-00037#1 mark
          LET la_param.param[3] = "sfaadocno IN (",l_wc CLIPPED,")"       #161104-00037#1 add
          LET ls_js = util.JSON.stringify( la_param )
          CALL cl_cmdrun(ls_js)
      END IF
   END IF
                  
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 按工单单别进行预设
# Memo...........:
# Usage..........: CALL apsp300_04_get_doc_default1(p_sfaa)
#                       RETURNING r_sfaa
# Input parameter: p_sfaa         来源
# Return code....: r_sfaa         结果
# Date & Author..: 2014-07-15 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp300_04_get_doc_default1(p_sfaa)
#161109-00085#13-mod-s
#   DEFINE p_sfaa            RECORD LIKE sfaa_t.*   #161109-00085#13   mark
   DEFINE p_sfaa                RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
          END RECORD
   #161109-00085#13-mod-e
   #161109-00085#13-mod-s
#   DEFINE r_sfaa            RECORD LIKE sfaa_t.*   #161109-00085#13   mark
   DEFINE r_sfaa                RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
          END RECORD
   #161109-00085#13-mod-e
   
   LET r_sfaa.sfaa001   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa001',p_sfaa.sfaa001)
   LET r_sfaa.sfaa002   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa002',p_sfaa.sfaa002)
   LET r_sfaa.sfaa004   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa004',p_sfaa.sfaa004)
   LET r_sfaa.sfaa009   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa009',p_sfaa.sfaa009)
   LET r_sfaa.sfaa022   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa022',p_sfaa.sfaa022)
   LET r_sfaa.sfaa023   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa023',p_sfaa.sfaa023)
   LET r_sfaa.sfaa024   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa024',p_sfaa.sfaa024)
   LET r_sfaa.sfaa064   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa064',p_sfaa.sfaa064)
   LET r_sfaa.sfaa021   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa021',p_sfaa.sfaa021)
   LET r_sfaa.sfaa025   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa025',p_sfaa.sfaa025)
   LET r_sfaa.sfaa058   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa058',p_sfaa.sfaa058)
   LET r_sfaa.sfaa060   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa060',p_sfaa.sfaa060)
   LET r_sfaa.sfaa018   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa018',p_sfaa.sfaa018)
   LET r_sfaa.sfaa014   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa014',p_sfaa.sfaa014)
   LET r_sfaa.sfaa028   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa028',p_sfaa.sfaa028)
   LET r_sfaa.sfaa015   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa015',p_sfaa.sfaa015)
   LET r_sfaa.sfaa029   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa029',p_sfaa.sfaa029)
   LET r_sfaa.sfaa026   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa026',p_sfaa.sfaa026)
   LET r_sfaa.sfaa030   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa030',p_sfaa.sfaa030)
   LET r_sfaa.sfaa031   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa031',p_sfaa.sfaa031)
   LET r_sfaa.sfaa062   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa062',p_sfaa.sfaa062)
   LET r_sfaa.sfaa032   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa032',p_sfaa.sfaa032)
   LET r_sfaa.sfaa033   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa033',p_sfaa.sfaa033)
   LET r_sfaa.sfaa034   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa034',p_sfaa.sfaa034)
   LET r_sfaa.sfaa035   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa035',p_sfaa.sfaa035)
   LET r_sfaa.sfaa059   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa059',p_sfaa.sfaa059)
   LET r_sfaa.sfaa036   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa036',p_sfaa.sfaa036)
   LET r_sfaa.sfaa037   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa037',p_sfaa.sfaa037)
   LET r_sfaa.sfaa038   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa038',p_sfaa.sfaa038)
   LET r_sfaa.sfaa039   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa039',p_sfaa.sfaa039)
   LET r_sfaa.sfaa040   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa040',p_sfaa.sfaa040)
   LET r_sfaa.sfaa041   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa041',p_sfaa.sfaa041)
   LET r_sfaa.sfaa042   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa042',p_sfaa.sfaa042)
   LET r_sfaa.sfaa043   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa043',p_sfaa.sfaa043)
   LET r_sfaa.sfaa044   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa044',p_sfaa.sfaa044)
   LET r_sfaa.sfaa045   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa045',p_sfaa.sfaa045)
   LET r_sfaa.sfaa046   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa046',p_sfaa.sfaa046)
   LET r_sfaa.sfaa049   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa049',p_sfaa.sfaa049)
   LET r_sfaa.sfaa050   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa050',p_sfaa.sfaa050)
   LET r_sfaa.sfaa047   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa047',p_sfaa.sfaa047)
   LET r_sfaa.sfaa051   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa051',p_sfaa.sfaa051)
   LET r_sfaa.sfaa048   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa048',p_sfaa.sfaa048)
   LET r_sfaa.sfaa055   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa055',p_sfaa.sfaa055)
   LET r_sfaa.sfaa056   = s_aooi200_get_doc_default(g_site,'1',p_sfaa.sfaadocno,'sfaa056',p_sfaa.sfaa056)
   
   RETURN r_sfaa.*
END FUNCTION

################################################################################
# Descriptions...: 检查工单单别
# Memo...........:
# Usage..........: CALL apsp300_04_chk_sfaadocno()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-15 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_chk_sfaadocno()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_psab001      LIKE psab_t.psab001
   DEFINE l_imae033      LIKE imae_t.imae033
   
   LET r_success = FALSE
   CALL s_aooi200_chk_slip(g_site,'',g_sfaa_d[l_ac].sfaadocno,'asft300')
        RETURNING l_success   
   IF NOT l_success THEN
      RETURN r_success
   END IF   
   
   DECLARE apsp300_04_chk_sfaadocno_cs1 CURSOR FOR
    SELECT psab001 FROM apsp300_tmp02       #160727-00019#14 Mod   apsp300_03_temp_d2 -->apsp300_tmp02
     WHERE keyno = g_sfaa_d[l_ac].keyno
   FOREACH apsp300_04_chk_sfaadocno_cs1 INTO l_psab001
      #检查控制组相关的料件设定
      CALL s_control_check_item(l_psab001,'6',g_site,g_user,g_dept,g_sfaadocno)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF

   END FOREACH
  
#   #制程否
#   LET g_sfaa_d[l_ac].sfaa061 = cl_get_doc_para(g_enterprise,g_site,g_sfaa_d[l_ac].sfaadocno,'D-MFG-0041')
#   IF cl_null(g_sfaa_d[l_ac].sfaa061) THEN
#      LET g_sfaa_d[l_ac].sfaa061 = 'N'
#      LET g_sfaa_d[l_ac].sfaa016 = ''
#   END IF

      
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

PUBLIC FUNCTION apsp300_04_set_no_required_b()
   CALL cl_set_comp_required("sfaa016_d1_04",FALSE)
END FUNCTION

PUBLIC FUNCTION apsp300_04_set_required_b()
   IF g_sfaa_d[l_ac].sfaa061 = 'Y' THEN
      CALL cl_set_comp_required("sfaa016_d1_04",TRUE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: INSERT工单的sfac_t
# Memo...........:
# Usage..........: CALL apsp300_04_ins_sfac(p_sfaadocno,p_sfac006)
#                       RETURNING r_success
# Input parameter: p_sfaadocno    工单单号
#                : p_sfac006      特征
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-07-15 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_ins_sfac(p_sfaadocno,p_sfac006)
   DEFINE p_sfaadocno      LIKE sfaa_t.sfaadocno
   DEFINE p_sfac006        LIKE sfac_t.sfac006
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_sql1           STRING
   DEFINE l_sql2           STRING
   DEFINE l_sql3           STRING
   DEFINE l_sql            STRING
   DEFINE l_n              LIKE type_t.num10    #170104-00066#1 num5->num10  17/01/05 mod by rainy 
   DEFINE l_j              LIKE type_t.num5
   DEFINE l_sfac001        LIKE sfac_t.sfac001
   DEFINE l_sfac003        LIKE sfac_t.sfac003
   DEFINE l_sfac004        LIKE sfac_t.sfac004
   #161109-00085#13-mod-s
#   DEFINE l_sfaa            RECORD LIKE sfaa_t.*   #161109-00085#13   mark
   DEFINE l_sfaa                 RECORD  #工單單頭檔
          sfaaent LIKE sfaa_t.sfaaent, #企業編號
          sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
          sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
          sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
          sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
          sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
          sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
          sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
          sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
          sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
          sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
          sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
          sfaastus LIKE sfaa_t.sfaastus, #狀態碼
          sfaasite LIKE sfaa_t.sfaasite, #營運據點
          sfaadocno LIKE sfaa_t.sfaadocno, #單號
          sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
          sfaa001 LIKE sfaa_t.sfaa001, #變更版本
          sfaa002 LIKE sfaa_t.sfaa002, #生管人員
          sfaa003 LIKE sfaa_t.sfaa003, #工單類型
          sfaa004 LIKE sfaa_t.sfaa004, #發料制度
          sfaa005 LIKE sfaa_t.sfaa005, #工單來源
          sfaa006 LIKE sfaa_t.sfaa006, #來源單號
          sfaa007 LIKE sfaa_t.sfaa007, #來源項次
          sfaa008 LIKE sfaa_t.sfaa008, #來源項序
          sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
          sfaa010 LIKE sfaa_t.sfaa010, #生產料號
          sfaa011 LIKE sfaa_t.sfaa011, #特性
          sfaa012 LIKE sfaa_t.sfaa012, #生產數量
          sfaa013 LIKE sfaa_t.sfaa013, #生產單位
          sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
          sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
          sfaa016 LIKE sfaa_t.sfaa016, #製程編號
          sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
          sfaa018 LIKE sfaa_t.sfaa018, #協作據點
          sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
          sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
          sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
          sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
          sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
          sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
          sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
          sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
          sfaa027 LIKE sfaa_t.sfaa027, #No Use
          sfaa028 LIKE sfaa_t.sfaa028, #專案編號
          sfaa029 LIKE sfaa_t.sfaa029, #WBS
          sfaa030 LIKE sfaa_t.sfaa030, #活動
          sfaa031 LIKE sfaa_t.sfaa031, #理由碼
          sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
          sfaa033 LIKE sfaa_t.sfaa033, #優先順序
          sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
          sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
          sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
          sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
          sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
          sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
          sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
          sfaa041 LIKE sfaa_t.sfaa041, #凍結
          sfaa042 LIKE sfaa_t.sfaa042, #重工
          sfaa043 LIKE sfaa_t.sfaa043, #備置
          sfaa044 LIKE sfaa_t.sfaa044, #FQC
          sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
          sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
          sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
          sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
          sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
          sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
          sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
          sfaa052 LIKE sfaa_t.sfaa052, #Bouns
          sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
          sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
          sfaa055 LIKE sfaa_t.sfaa055, #下線數量
          sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
          sfaa057 LIKE sfaa_t.sfaa057, #委外類型
          sfaa058 LIKE sfaa_t.sfaa058, #參考數量
          sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
          sfaa060 LIKE sfaa_t.sfaa060, #參考單位
          sfaa061 LIKE sfaa_t.sfaa061, #製程
          sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
          sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
          sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
          sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
          sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
          sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
          sfaa068 LIKE sfaa_t.sfaa068, #成本中心
          sfaa069 LIKE sfaa_t.sfaa069, #可供給量
          sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
          sfaaud001 LIKE sfaa_t.sfaaud001, #自定義欄位(文字)001
          sfaaud002 LIKE sfaa_t.sfaaud002, #自定義欄位(文字)002
          sfaaud003 LIKE sfaa_t.sfaaud003, #自定義欄位(文字)003
          sfaaud004 LIKE sfaa_t.sfaaud004, #自定義欄位(文字)004
          sfaaud005 LIKE sfaa_t.sfaaud005, #自定義欄位(文字)005
          sfaaud006 LIKE sfaa_t.sfaaud006, #自定義欄位(文字)006
          sfaaud007 LIKE sfaa_t.sfaaud007, #自定義欄位(文字)007
          sfaaud008 LIKE sfaa_t.sfaaud008, #自定義欄位(文字)008
          sfaaud009 LIKE sfaa_t.sfaaud009, #自定義欄位(文字)009
          sfaaud010 LIKE sfaa_t.sfaaud010, #自定義欄位(文字)010
          sfaaud011 LIKE sfaa_t.sfaaud011, #自定義欄位(數字)011
          sfaaud012 LIKE sfaa_t.sfaaud012, #自定義欄位(數字)012
          sfaaud013 LIKE sfaa_t.sfaaud013, #自定義欄位(數字)013
          sfaaud014 LIKE sfaa_t.sfaaud014, #自定義欄位(數字)014
          sfaaud015 LIKE sfaa_t.sfaaud015, #自定義欄位(數字)015
          sfaaud016 LIKE sfaa_t.sfaaud016, #自定義欄位(數字)016
          sfaaud017 LIKE sfaa_t.sfaaud017, #自定義欄位(數字)017
          sfaaud018 LIKE sfaa_t.sfaaud018, #自定義欄位(數字)018
          sfaaud019 LIKE sfaa_t.sfaaud019, #自定義欄位(數字)019
          sfaaud020 LIKE sfaa_t.sfaaud020, #自定義欄位(數字)020
          sfaaud021 LIKE sfaa_t.sfaaud021, #自定義欄位(日期時間)021
          sfaaud022 LIKE sfaa_t.sfaaud022, #自定義欄位(日期時間)022
          sfaaud023 LIKE sfaa_t.sfaaud023, #自定義欄位(日期時間)023
          sfaaud024 LIKE sfaa_t.sfaaud024, #自定義欄位(日期時間)024
          sfaaud025 LIKE sfaa_t.sfaaud025, #自定義欄位(日期時間)025
          sfaaud026 LIKE sfaa_t.sfaaud026, #自定義欄位(日期時間)026
          sfaaud027 LIKE sfaa_t.sfaaud027, #自定義欄位(日期時間)027
          sfaaud028 LIKE sfaa_t.sfaaud028, #自定義欄位(日期時間)028
          sfaaud029 LIKE sfaa_t.sfaaud029, #自定義欄位(日期時間)029
          sfaaud030 LIKE sfaa_t.sfaaud030, #自定義欄位(日期時間)030
          sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
          sfaa072 LIKE sfaa_t.sfaa072  #保稅否
                  END RECORD
   #161109-00085#13-mod-e
   DEFINE l_i              LIKE type_t.num5
   #161109-00085#13-mod-s
#   DEFINE l_sfac           RECORD LIKE sfac_t.*   mark
   DEFINE l_sfac           RECORD  #工單聯產品檔
       sfacent LIKE sfac_t.sfacent, #企業編號
       sfacsite LIKE sfac_t.sfacsite, #營運據點
       sfacdocno LIKE sfac_t.sfacdocno, #單號
       sfac001 LIKE sfac_t.sfac001, #料件編號
       sfac002 LIKE sfac_t.sfac002, #類型
       sfac003 LIKE sfac_t.sfac003, #預計產出量
       sfac004 LIKE sfac_t.sfac004, #單位
       sfac005 LIKE sfac_t.sfac005, #實際產出數量
       sfacseq LIKE sfac_t.sfacseq, #項次
       sfac006 LIKE sfac_t.sfac006, #產品特徵
       sfac007 LIKE sfac_t.sfac007  #保稅否
          END RECORD
   #161109-00085#13-mod-e
   
   LET r_success = FALSE
   #161109-00085#13-mod-s
#   SELECT * INTO l_sfaa.* FROM sfaa_t   #161109-00085#13-mark
   SELECT sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,sfaapstid,
          sfaapstdt,sfaastus,sfaasite,sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,sfaa005,sfaa006,sfaa007,sfaa008,
          sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,
          sfaa023,sfaa024,sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,sfaa035,sfaa036,
          sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,
          sfaa051,sfaa052,sfaa053,sfaa054,sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
          sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,sfaa070,sfaa071,sfaa072 
      INTO l_sfaa.sfaaent,l_sfaa.sfaaownid,l_sfaa.sfaaowndp,l_sfaa.sfaacrtid,l_sfaa.sfaacrtdp,l_sfaa.sfaacrtdt,l_sfaa.sfaamodid,
           l_sfaa.sfaamoddt,l_sfaa.sfaacnfid,l_sfaa.sfaacnfdt,l_sfaa.sfaapstid,l_sfaa.sfaapstdt,l_sfaa.sfaastus,l_sfaa.sfaasite,
           l_sfaa.sfaadocno,l_sfaa.sfaadocdt,l_sfaa.sfaa001,l_sfaa.sfaa002,l_sfaa.sfaa003,l_sfaa.sfaa004,l_sfaa.sfaa005,l_sfaa.sfaa006,
           l_sfaa.sfaa007,l_sfaa.sfaa008,l_sfaa.sfaa009,l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa014,
           l_sfaa.sfaa015,l_sfaa.sfaa016,l_sfaa.sfaa017,l_sfaa.sfaa018,l_sfaa.sfaa019,l_sfaa.sfaa020,l_sfaa.sfaa021,l_sfaa.sfaa022,
           l_sfaa.sfaa023,l_sfaa.sfaa024,l_sfaa.sfaa025,l_sfaa.sfaa026,l_sfaa.sfaa027,l_sfaa.sfaa028,l_sfaa.sfaa029,l_sfaa.sfaa030,
           l_sfaa.sfaa031,l_sfaa.sfaa032,l_sfaa.sfaa033,l_sfaa.sfaa034,l_sfaa.sfaa035,l_sfaa.sfaa036,l_sfaa.sfaa037,l_sfaa.sfaa038,
           l_sfaa.sfaa039,l_sfaa.sfaa040,l_sfaa.sfaa041,l_sfaa.sfaa042,l_sfaa.sfaa043,l_sfaa.sfaa044,l_sfaa.sfaa045,l_sfaa.sfaa046,
           l_sfaa.sfaa047,l_sfaa.sfaa048,l_sfaa.sfaa049,l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa052,l_sfaa.sfaa053,l_sfaa.sfaa054,
           l_sfaa.sfaa055,l_sfaa.sfaa056,l_sfaa.sfaa057,l_sfaa.sfaa058,l_sfaa.sfaa059,l_sfaa.sfaa060,l_sfaa.sfaa061,l_sfaa.sfaa062,
           l_sfaa.sfaa063,l_sfaa.sfaa064,l_sfaa.sfaa065,l_sfaa.sfaa066,l_sfaa.sfaa067,l_sfaa.sfaa068,l_sfaa.sfaa069,l_sfaa.sfaa070,
           l_sfaa.sfaa071,l_sfaa.sfaa072 
      FROM sfaa_t
   #161109-00085#13-mod-e
    WHERE sfaaent   = g_enterprise
      AND sfaadocno = p_sfaadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'select sfaa'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #160512-00016#1 20160524 modify by ming -----(S) 
   #LET l_sql1 = "SELECT UNIQUE '','2',bmab003,'','','',bmab004*",l_sfaa.sfaa012/100,",'','',0 FROM bmab_t WHERE bmabent = '",g_enterprise,"'",
   #             "   AND bmabsite = '",g_site,"' AND bmab001 = '",l_sfaa.sfaa010,"' AND bmab002 = '",l_sfaa.sfaa011,"'"
   #LET l_sql2 = "SELECT UNIQUE '','3',bmad003,'','','',bmad004*",l_sfaa.sfaa012,",bmad005,'',0 FROM bmad_t WHERE bmadent='",g_enterprise,"'",
   #             "   AND bmadsite='",g_site,"' AND bmad001='",l_sfaa.sfaa010,"' AND bmad002 = '",l_sfaa.sfaa011,"'"
   #LET l_sql3 = "SELECT UNIQUE '','5',bmac003,'','','',bmac005/bmac006*",l_sfaa.sfaa012,",bmac004,'',0 FROM bmac_t WHERE bmacent='",g_enterprise,"'",
   #             "   AND bmacsite='",g_site,"' AND bmac001='",l_sfaa.sfaa010,"' AND bmac002 = '",l_sfaa.sfaa011,"'"
   
   LET l_sql1 = "SELECT UNIQUE '','','',bmab003,'2',bmab004*",l_sfaa.sfaa012/100,",'','',0 FROM bmab_t WHERE bmabent = '",g_enterprise,"'",
                "   AND bmabsite = '",g_site,"' AND bmab001 = '",l_sfaa.sfaa010,"' AND bmab002 = '",l_sfaa.sfaa011,"'"
   LET l_sql2 = "SELECT UNIQUE '','','',bmad003,'3',bmad004*",l_sfaa.sfaa012,",bmad005,'',0 FROM bmad_t WHERE bmadent='",g_enterprise,"'",
                "   AND bmadsite='",g_site,"' AND bmad001='",l_sfaa.sfaa010,"' AND bmad002 = '",l_sfaa.sfaa011,"'"
   LET l_sql3 = "SELECT UNIQUE '','','',bmac003,'5',bmac005/bmac006*",l_sfaa.sfaa012,",bmac004,'',0 FROM bmac_t WHERE bmacent='",g_enterprise,"'",
                "   AND bmacsite='",g_site,"' AND bmac001='",l_sfaa.sfaa010,"' AND bmac002 = '",l_sfaa.sfaa011,"'"
   #160512-00016#1 20160524 modify by ming -----(E) 
   LET l_sql = l_sql1," UNION ",l_sql2," UNION ",l_sql3
   PREPARE apsp300_04_ins_sfac_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare apsp300_04_ins_sfac_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   DECLARE apsp300_04_ins_sfac_cs1 CURSOR FOR apsp300_04_ins_sfac_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare apsp300_04_ins_sfac_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF 
   
   SELECT COUNT(*) INTO l_n FROM bmad_t 
    WHERE bmadent = g_enterprise 
      AND bmadsite= g_site 
      AND bmad001 = l_sfaa.sfaa010 
      AND bmad002 = l_sfaa.sfaa011
   IF l_n = 0 THEN
      SELECT MAX(sfacseq)+1 INTO l_sfac.sfacseq FROM sfac_t 
       WHERE sfacent = g_enterprise AND sfacsite = g_site AND sfacdocno= l_sfaa.sfaadocno
      IF cl_null(l_sfac.sfacseq) THEN
         LET l_sfac.sfacseq = 1
      END IF
      LET l_sfac.sfac002 = '1'
      LET l_sfac.sfac001 = l_sfaa.sfaa010
      #LET l_sfac.sfac003 = l_sfaa.sfaa012      #161104-00037#1 mark
      #161104-00037#1 add---start---
      SELECT SUM(qty) INTO l_sfac.sfac003
        FROM apsp300_tmp02
       WHERE keyno = g_sfaa_d[g_04_i].keyno
         AND psab002 = p_sfac006
      IF cl_null(l_sfac.sfac003) THEN
         LET l_sfac.sfac003 = 0
      END IF
      #161104-00037#1 add---end---
      LET l_sfac.sfac004 = l_sfaa.sfaa013
      LET l_sfac.sfac005 = 0
      LET l_sfac.sfac006 = p_sfac006 
      
      #160512-00016#1 20160524 add by ming -----(S) 
      LET l_sfac.sfac007 = l_sfaa.sfaa072 
      #160512-00016#1 20160524 add by ming -----(E) 
      
      #160512-00016#1 20160524 modify by ming -----(S) 
      #INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,sfac002,sfac003,sfac004,sfac005,sfac006)
      #       VALUES(g_enterprise,g_site,l_sfaa.sfaadocno,l_sfac.sfacseq,l_sfac.sfac001,
      #              l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006)
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,sfac002, 
                         sfac003,sfac004,sfac005,sfac006,sfac007)
                  VALUES(g_enterprise,g_site,l_sfaa.sfaadocno,l_sfac.sfacseq,l_sfac.sfac001,
                         l_sfac.sfac002,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006, 
                         l_sfac.sfac007)
      #160512-00016#1 20160524 modify by ming -----(E) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert sfac_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF                     
   END IF
   #161109-00085#13-s mod
#   FOREACH apsp300_04_ins_sfac_cs1 INTO l_sfac.*   #161109-00085#13-s mark
   FOREACH apsp300_04_ins_sfac_cs1 INTO l_sfac.sfacent,l_sfac.sfacsite,l_sfac.sfacdocno,l_sfac.sfac001,l_sfac.sfac002,
                                        l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfacseq,l_sfac.sfac006,
                                        l_sfac.sfac007
   #161109-00085#13-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF cl_null(l_sfac.sfac001) THEN
         CONTINUE FOREACH
      END IF
      SELECT MAX(sfacseq)+1 INTO l_sfac.sfacseq FROM sfac_t 
       WHERE sfacent = g_enterprise AND sfacsite = g_site AND sfacdocno= l_sfaa.sfaadocno
      IF cl_null(l_sfac.sfacseq) THEN
         LET l_sfac.sfacseq = 1
      END IF
      IF cl_null(l_sfac.sfac004) THEN
         SELECT bmaa004 INTO l_sfac.sfac004 FROM bmaa_t 
          WHERE bmaaent = g_enterprise AND bmaasite = g_site AND bmaa001 = l_sfaa.sfaa010 AND bmaa002=l_sfaa.sfaa011
      END IF
      
      #160512-00016#1 20160524 add by ming -----(S) 
      LET l_sfac.sfac007 = 'N' 
      #160512-00016#1 20160524 add by ming -----(E) 
      
      #160512-00016#1 20160524 modify by ming -----(S) 
      #INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,sfac002,sfac003,sfac004,sfac005,sfac006)
      #       VALUES(g_enterprise,g_site,l_sfaa.sfaadocno,l_sfac.sfacseq,l_sfac.sfac001,l_sfac.sfac002,
      #              l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006)
      INSERT INTO sfac_t(sfacent,sfacsite,sfacdocno,sfacseq,sfac001,sfac002,
                         sfac003,sfac004,sfac005,sfac006,sfac007)
             VALUES(g_enterprise,g_site,l_sfaa.sfaadocno,l_sfac.sfacseq,l_sfac.sfac001,l_sfac.sfac002,
                    l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac005,l_sfac.sfac006, 
                    l_sfac.sfac007)
      #160512-00016#1 20160524 modify by ming -----(E) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert sfac_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF                     
      IF l_sfac.sfac002 = '2' THEN
         UPDATE sfac_t SET sfac003=sfac003-l_sfac.sfac003
          WHERE sfacent  = g_enterprise
            AND sfacsite = g_site AND sfacdocno= l_sfaa.sfaadocno AND sfac002='1'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'update sfac_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF                     
      END IF
  
   END FOREACH   
   
   
   LET r_success = TRUE
   RETURN r_success

   
END FUNCTION

################################################################################
# Descriptions...: 工單調整input
# Memo...........:
# Usage..........: CALL apsp300_04_b()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/03/29 By shiun #151118-00029#7
# Modify.........:
################################################################################
PUBLIC FUNCTION apsp300_04_b()
DEFINE l_imae032       LIKE imae_t.imae032
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   DEFINE l_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE 

   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY g_sfaa_d FROM s_detail1_apsp300_04.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
                   
         BEFORE INPUT
         
         BEFORE ROW
            LET l_ac = ARR_CURR()      
            LET g_sfaa_d_t.* = g_sfaa_d[l_ac].*
            CALL apsp300_04_set_entry_b()
            CALL apsp300_04_set_no_entry_b()
            CALL apsp300_04_set_no_required_b()
            CALL apsp300_04_set_required_b()
            LET l_ac = DIALOG.getCurrentRow("s_detail1_apsp300_04")
            LET g_master_idx = l_ac
            CALL apsp300_04_fetch()
            
            
         AFTER FIELD sfaa011_d1_04
            IF g_sfaa_d[l_ac].sfaa011 IS NULL THEN
               LET g_sfaa_d[l_ac].sfaa011 = ' '
            END IF   
            IF g_sfaa_d[l_ac].sfaa011 IS NOT NULL AND 
              (g_sfaa_d_t.sfaa011 IS NULL OR g_sfaa_d[l_ac].sfaa011 != g_sfaa_d_t.sfaa011) THEN
               CALL apsp300_04_chk_sfaa011()
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD sfaa011_d1_04
               END IF
            END IF
#            LET g_sfaa_d_t.sfaa011 = g_sfaa_d[l_ac].sfaa011
            
         BEFORE FIELD sfaadocno_d1_04
            CALL apsp300_04_set_entry_b()
            CALL apsp300_04_set_no_required_b()
            
         AFTER FIELD sfaadocno_d1_04
            IF g_sfaa_d[l_ac].sfaadocno IS NULL THEN
               LET g_sfaa_d[l_ac].sfaadocno = g_sfaadocno
            END IF   
            IF g_sfaa_d[l_ac].sfaadocno IS NOT NULL AND 
              (g_sfaa_d_t.sfaadocno IS NULL OR g_sfaa_d[l_ac].sfaadocno != g_sfaa_d_t.sfaadocno) THEN
               CALL apsp300_04_chk_sfaadocno()
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD sfaadocno_d1_04
               END IF
               #单别带出单据名称
               CALL s_aooi200_get_slip_desc(g_sfaa_d[l_ac].sfaadocno)
                    RETURNING g_sfaa_d[l_ac].sfaadocno_desc
               CALL apsp300_04_get_doc_default()
            END IF
#            LET g_sfaa_d_t.sfaadocno = g_sfaa_d[l_ac].sfaadocno 
            CALL apsp300_04_set_no_entry_b()     
            CALL apsp300_04_set_required_b()
            
         AFTER FIELD sfaa003_d1_04 
            IF g_sfaa_d[l_ac].sfaa003 IS NOT NULL AND 
              (g_sfaa_d_t.sfaa003 IS NULL OR g_sfaa_d[l_ac].sfaa003 != g_sfaa_d_t.sfaa003) THEN
               CALL apsp300_04_chk_sfaa011()
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD sfaa003_d1_04
               END IF
            END IF
#            LET g_sfaa_d_t.sfaa003 = g_sfaa_d[l_ac].sfaa003      
            
         AFTER FIELD sfaa017_d1_04
            IF g_sfaa_d[l_ac].sfaa017 IS NOT NULL AND 
              (g_sfaa_d_t.sfaa017 IS NULL OR g_sfaa_d[l_ac].sfaa017 != g_sfaa_d_t.sfaa017) THEN
               CALL apsp300_04_chk_sfaa017()
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD sfaa017_d1_04
               END IF
            END IF
#            LET g_sfaa_d_t.sfaa017 = g_sfaa_d[l_ac].sfaa017   
            
         BEFORE FIELD sfaa061_d1_04
            CALL apsp300_04_set_entry_b()   
            
         AFTER FIELD sfaa061_d1_04
            CALL apsp300_04_set_no_entry_b()                         
            
         AFTER FIELD sfaa016_d1_04 
            IF g_sfaa_d[l_ac].sfaa016 IS NOT NULL AND 
              (g_sfaa_d_t.sfaa016 IS NULL OR g_sfaa_d[l_ac].sfaa016 != g_sfaa_d_t.sfaa016) THEN
               CALL apsp300_04_chk_sfaa016()
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD sfaa016_d1_04
               END IF
            END IF
#            LET g_sfaa_d_t.sfaa016 = g_sfaa_d[l_ac].sfaa016    
            
         ON ROW CHANGE 
            CALL apsp300_04_upd_sfaa(g_sfaa_d[l_ac].*)
                 RETURNING l_success
            IF NOT l_success THEN
               
            END IF         
            
         ON ACTION controlp
            CASE
               WHEN INFIELD(sfaa011_d1_04)
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaa011 
                  #給予arg
                  IF NOT cl_null(g_sfaa_d[l_ac].sfaa010) THEN
                     LET g_qryparam.where = " bmaa001 = '",g_sfaa_d[l_ac].sfaa010,"' "
                  END IF
                  CALL q_bmaa002()                                
                  LET g_sfaa_d[l_ac].sfaa011 = g_qryparam.return1   
                  NEXT FIELD sfaa011_d1_04   
               WHEN INFIELD(sfaadocno_d1_04)
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaadocno
                  #給予arg
                  SELECT ooef004 INTO l_ooef004 FROM ooef_t
                   WHERE ooef001 = g_site
                     AND ooefent  = g_enterprise
                  LET g_qryparam.arg1 = l_ooef004 #參照表編號
                  LET g_qryparam.arg2 = 'asft300' #作业代号
                  CALL q_ooba002_1()                                  
                  LET g_sfaa_d[l_ac].sfaadocno = g_qryparam.return1   
                  NEXT FIELD sfaadocno_d1_04                         
      
               WHEN INFIELD(sfaa017_d1_04)
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaa017
                  IF g_sfaa_d[l_ac].sfaa057 = '2' THEN
                     LET g_qryparam.where = "pmaa002 = '1' OR pmaa002 ='3'"
                     CALL q_pmaa001()
                  ELSE
                     LET g_qryparam.arg1 = g_today
                     CALL q_ooeg001()
                  END IF           
                  LET g_sfaa_d[l_ac].sfaa017 = g_qryparam.return1   
                  NEXT FIELD sfaa017_d1_04  
                  
               WHEN INFIELD(sfaa016_d1_04)
                  SELECT imae032 INTO l_imae032 FROM imae_t 
                   WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_sfaa_d[l_ac].sfaa010
                  IF cl_null(l_imae032) THEN
                     LET l_imae032 = g_sfaa_d[l_ac].sfaa010
                  END IF
               
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_sfaa_d[l_ac].sfaa016
                  LET g_qryparam.arg1 = g_site
                  LET g_qryparam.arg2 = l_imae032
                  CALL q_ecba002_3()
                  LET g_sfaa_d[l_ac].sfaa016 = g_qryparam.return1   
                  NEXT FIELD sfaa016_d1_04                                        
            END CASE               
            
            ON ACTION accept
               IF g_sfaa_d[l_ac].sfaa011 IS NULL THEN
                  LET g_sfaa_d[l_ac].sfaa011 = ' '
               END IF   
               IF g_sfaa_d[l_ac].sfaa011 IS NOT NULL AND 
                 (g_sfaa_d_t.sfaa011 IS NULL OR g_sfaa_d[l_ac].sfaa011 != g_sfaa_d_t.sfaa011) THEN
                  CALL apsp300_04_chk_sfaa011()
                       RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD sfaa011_d1_04
                  END IF
               END IF
               LET g_sfaa_d_t.sfaa011 = g_sfaa_d[l_ac].sfaa011
            
            
               IF g_sfaa_d[l_ac].sfaadocno IS NULL THEN
                  LET g_sfaa_d[l_ac].sfaadocno = g_sfaadocno
               END IF   
               IF g_sfaa_d[l_ac].sfaadocno IS NOT NULL AND 
                 (g_sfaa_d_t.sfaadocno IS NULL OR g_sfaa_d[l_ac].sfaadocno != g_sfaa_d_t.sfaadocno) THEN
                  CALL apsp300_04_chk_sfaadocno()
                       RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD sfaadocno_d1_04
                  END IF
                  #单别带出单据名称
                  CALL s_aooi200_get_slip_desc(g_sfaa_d[l_ac].sfaadocno)
                       RETURNING g_sfaa_d[l_ac].sfaadocno_desc
                  CALL apsp300_04_get_doc_default()
               END IF
               LET g_sfaa_d_t.sfaadocno = g_sfaa_d[l_ac].sfaadocno 
               CALL apsp300_04_set_no_entry_b()     
               CALL apsp300_04_set_required_b()
            
            
               IF g_sfaa_d[l_ac].sfaa003 IS NOT NULL AND 
                 (g_sfaa_d_t.sfaa003 IS NULL OR g_sfaa_d[l_ac].sfaa003 != g_sfaa_d_t.sfaa003) THEN
                  CALL apsp300_04_chk_sfaa011()
                       RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD sfaa003_d1_04
                  END IF
               END IF
               LET g_sfaa_d_t.sfaa003 = g_sfaa_d[l_ac].sfaa003      
            

               IF g_sfaa_d[l_ac].sfaa017 IS NOT NULL AND 
                 (g_sfaa_d_t.sfaa017 IS NULL OR g_sfaa_d[l_ac].sfaa017 != g_sfaa_d_t.sfaa017) THEN
                  CALL apsp300_04_chk_sfaa017()
                       RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD sfaa017_d1_04
                  END IF
               END IF
               LET g_sfaa_d_t.sfaa017 = g_sfaa_d[l_ac].sfaa017   
            

               IF g_sfaa_d[l_ac].sfaa016 IS NOT NULL AND 
                 (g_sfaa_d_t.sfaa016 IS NULL OR g_sfaa_d[l_ac].sfaa016 != g_sfaa_d_t.sfaa016) THEN
                  CALL apsp300_04_chk_sfaa016()
                       RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD sfaa016_d1_04
                  END IF
               END IF
               LET g_sfaa_d_t.sfaa016 = g_sfaa_d[l_ac].sfaa016 
               ACCEPT DIALOG       #170101-00012#1 add
               
               
            ON ACTION cancel 
               LET g_sfaa_d[l_ac].*  = g_sfaa_d_t.*               
               EXIT DIALOG
            
      END INPUT
   END DIALOG
END FUNCTION

 
{</section>}
 
