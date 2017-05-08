#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp570_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-11-27 11:05:01), PR版次:0006(2016-12-26 19:13:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: apmp570_04
#+ Description: 引導式入庫維護作業-入庫調整-多倉儲批入庫維護
#+ Creator....: 01588(2014-10-13 09:48:20)
#+ Modifier...: 01588 -SD/PR- 01534
 
{</section>}
 
{<section id="apmp570_04.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#151118-00029#3..........2016/03/28 By ming..........移除transaction，改由外層控制 
#160318-00025#20         2016/04/18 BY 07900         校验代码重复错误讯息的修改
#160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01,apmp570_02_temp_d1 ——> apmp570_tmp02,apmp570_02_temp_d2 ——> apmp570_tmp03,apmp570_02_temp_d3 ——> apmp570_tmp04
#161006-00018#23   2016/12/26  By lixh     增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="apmp570_04.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_pmdt_m          RECORD
         l_pmdtseq       LIKE pmdt_t.pmdtseq,
         l_pmdt006       LIKE pmdt_t.pmdt006,
         l_imaal003      LIKE imaal_t.imaal003,
         l_imaal004      LIKE imaal_t.imaal004,
         l_pmdt007       LIKE pmdt_t.pmdt007,
         l_pmdt007_desc  LIKE type_t.chr500,
         l_pmdt009       LIKE pmdt_t.pmdt009,
         l_pmdt010       LIKE pmdt_t.pmdt010,
         l_pmdt019       LIKE pmdt_t.pmdt019,
         l_pmdt019_desc  LIKE oocal_t.oocal003,
         l_pmdt020       LIKE pmdt_t.pmdt020,
         l_pmdt021       LIKE pmdt_t.pmdt021,
         l_pmdt021_desc  LIKE oocal_t.oocal003,
         l_pmdt022       LIKE pmdt_t.pmdt022
                         END RECORD
                  
TYPE type_g_pmdu_d       RECORD
         keyno           LIKE type_t.num5,
         pmduseq         LIKE pmdu_t.pmduseq, 
         pmduseq1        LIKE pmdu_t.pmduseq1, 
         pmdu001         LIKE pmdu_t.pmdu001,
         pmdu002         LIKE pmdu_t.pmdu002,
         pmdu003         LIKE pmdu_t.pmdu003,
         pmdu004         LIKE pmdu_t.pmdu004,
         pmdu006         LIKE pmdu_t.pmdu006, 
         pmdu006_desc    LIKE type_t.chr500, 
         pmdu007         LIKE pmdu_t.pmdu007, 
         pmdu007_desc    LIKE type_t.chr500, 
         pmdu008         LIKE pmdu_t.pmdu008, 
         pmdu005         LIKE pmdu_t.pmdu005, 
         pmdu009         LIKE pmdu_t.pmdu009, 
         pmdu009_desc    LIKE type_t.chr500, 
         pmdu010         LIKE pmdu_t.pmdu010, 
         pmdu011         LIKE pmdu_t.pmdu011, 
         pmdu011_desc    LIKE type_t.chr500, 
         pmdu012         LIKE pmdu_t.pmdu012, 
         pmdu013         LIKE pmdu_t.pmdu013, 
         pmdu014         LIKE pmdu_t.pmdu014, 
         pmdu015         LIKE pmdu_t.pmdu015
                         END RECORD

DEFINE g_pmdu_d          DYNAMIC ARRAY OF type_g_pmdu_d
DEFINE g_pmdu_d_t        type_g_pmdu_d

DEFINE g_keyno           LIKE type_t.num5
DEFINE g_pmdtseq         LIKE pmdt_t.pmdtseq
DEFINE l_ac              LIKE type_t.num5
DEFINE g_rec_b           LIKE type_t.num5
DEFINE g_detail_idx      LIKE type_t.num5
DEFINE g_detail_cnt      LIKE type_t.num5
DEFINE g_imaa004         LIKE imaa_t.imaa004
DEFINE g_pmdsdocno       LIKE pmds_t.pmdsdocno  #161006-00018#23
#end add-point
 
{</section>}
 
{<section id="apmp570_04.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmp570_04.other_dialog" >}

 
{</section>}
 
{<section id="apmp570_04.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp570_04(--)
   #add-point:input段變數傳入
   p_keyno,p_pmdtseq,p_pmdt020,p_pmdt022
   #end add-point
   )
   DEFINE p_keyno         LIKE type_t.num5
   DEFINE p_pmdtseq       LIKE pmdt_t.pmdtseq  
   DEFINE p_pmdt020       LIKE pmdt_t.pmdt020
   DEFINE p_pmdt022       LIKE pmdt_t.pmdt022   
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_maxseq1       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_qty           LIKE pmdt_t.pmdt020
   DEFINE l_msg           STRING
   DEFINE l_pmdu010       LIKE pmdu_t.pmdu010
   DEFINE l_pmds011       LIKE pmds_t.pmds011
   
   LET r_success = TRUE
   LET g_keyno = p_keyno
   LET g_pmdtseq = p_pmdtseq
   
   IF cl_null(g_keyno) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(g_pmdtseq) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_ac = 0 
   LET g_detail_cnt = 0
   LET g_detail_idx = 0
   LET g_rec_b = 0
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmp570_04 WITH FORM cl_ap_formpath("apm","apmp570_04")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET l_pmds011 = ''
   SELECT pmds011 INTO l_pmds011
     FROM apmp570_tmp01   #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_tmp_master ——> apmp570_tmp01
   CALL cl_set_comp_visible("l_pmdt009,l_pmdt010",TRUE)
   IF l_pmds011 = '1' THEN
      CALL cl_set_comp_visible("l_pmdt009,l_pmdt010",FALSE)
   END IF
   
   LET g_errshow = 1
   LET g_qryparam.state = "i"

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")

   CALL apmp570_04_show()
   LET g_pmdt_m.l_pmdt020 = p_pmdt020
   LET g_pmdt_m.l_pmdt022 = p_pmdt022
   DISPLAY g_pmdt_m.l_pmdt020,g_pmdt_m.l_pmdt022 TO l_pmdt020,l_pmdt022
   
   LET g_imaa004 = ''
   SELECT imaa004 INTO g_imaa004 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_pmdt_m.l_pmdt006
   
   #151118-00029#3 20160328 by ming mark -----(S) 
   #CALL s_transaction_begin()
   #151118-00029#3 20160328 by ming mark -----(E) 
   
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmdu_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT

            SELECT pmdsdocno INTO g_pmdsdocno FROM apmp570_tmp01  #161006-00018#23
            CALL apmp570_04_b_fill()
            CALL apmp570_04_set_entry_b()
            CALL apmp570_04_set_no_required_b()
            CALL apmp570_04_set_required_b()
            CALL apmp570_04_set_no_entry_b()
             
         BEFORE ROW 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            DISPLAY l_ac TO FORMONLY.idx
            IF g_detail_cnt >= l_ac AND g_pmdu_d[l_ac].pmduseq1 IS NOT NULL THEN
               LET l_cmd='u'
               SELECT keyno, pmduseq, pmduseq1,
                      pmdu001, pmdu002, pmdu003, pmdu004, pmdu005, 
                      pmdu006,      '', pmdu007,      '', pmdu008,
                      pmdu009,      '', pmdu010, pmdu011,      '',
                      pmdu012, pmdu013, pmdu014, pmdu015 
                 INTO g_pmdu_d[l_ac].keyno,g_pmdu_d[l_ac].pmduseq,g_pmdu_d[l_ac].pmduseq1,
                      g_pmdu_d[l_ac].pmdu001,g_pmdu_d[l_ac].pmdu002,g_pmdu_d[l_ac].pmdu003,g_pmdu_d[l_ac].pmdu004,g_pmdu_d[l_ac].pmdu005,
                      g_pmdu_d[l_ac].pmdu006,g_pmdu_d[l_ac].pmdu006_desc,g_pmdu_d[l_ac].pmdu007,g_pmdu_d[l_ac].pmdu007_desc,g_pmdu_d[l_ac].pmdu008,
                      g_pmdu_d[l_ac].pmdu009,g_pmdu_d[l_ac].pmdu009_desc,g_pmdu_d[l_ac].pmdu010,g_pmdu_d[l_ac].pmdu011,g_pmdu_d[l_ac].pmdu011_desc,
                      g_pmdu_d[l_ac].pmdu012,g_pmdu_d[l_ac].pmdu013,g_pmdu_d[l_ac].pmdu014,g_pmdu_d[l_ac].pmdu015
                 FROM apmp570_tmp04  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                WHERE keyno = g_keyno 
                  AND pmduseq = g_pmdtseq 
                  AND pmduseq1 = g_pmdu_d[l_ac].pmduseq1
          
               CALL apmp570_04_detail_show("'1'")
               LET g_pmdu_d_t.* = g_pmdu_d[l_ac].*  
            ELSE
               LET l_cmd='a'
            END IF
            CALL apmp570_04_set_entry_b()
            CALL apmp570_04_set_no_required_b()
            CALL apmp570_04_set_required_b()
            CALL apmp570_04_set_no_entry_b()
            
         BEFORE INSERT 
            INITIALIZE g_pmdu_d_t.* TO NULL
            INITIALIZE g_pmdu_d[l_ac].* TO NULL
            
            LET g_pmdu_d[l_ac].keyno = g_keyno
            LET g_pmdu_d[l_ac].pmduseq = g_pmdtseq
            LET l_maxseq1 = ''
            SELECT MAX(pmduseq1) INTO l_maxseq1 FROM apmp570_tmp04  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
             WHERE keyno = g_keyno
               AND pmduseq = g_pmdtseq
            IF cl_null(l_maxseq1) THEN
               LET g_pmdu_d[l_ac].pmduseq1 = 1
            ELSE
               LET g_pmdu_d[l_ac].pmduseq1 = l_maxseq1 + 1
            END IF
            
            LET g_pmdu_d[l_ac].pmdu001 = g_pmdt_m.l_pmdt006
            LET g_pmdu_d[l_ac].pmdu002 = g_pmdt_m.l_pmdt007
            LET g_pmdu_d[l_ac].pmdu003 = g_pmdt_m.l_pmdt009
            LET g_pmdu_d[l_ac].pmdu004 = g_pmdt_m.l_pmdt010
            LET g_pmdu_d[l_ac].pmdu009 = g_pmdt_m.l_pmdt019
            LET g_pmdu_d[l_ac].pmdu010 = ''
            LET g_pmdu_d[l_ac].pmdu011 = g_pmdt_m.l_pmdt021
            LET g_pmdu_d[l_ac].pmdu012 = 0
            CALL apmp570_04_detail_show("'1'")
            CALL apmp570_04_set_entry_b()
            CALL apmp570_04_set_no_required_b()
            CALL apmp570_04_set_required_b()
            CALL apmp570_04_set_no_entry_b()
            LET g_pmdu_d_t.* = g_pmdu_d[l_ac].*
            
         
         AFTER INSERT 
         
            IF NOT cl_null(g_pmdu_d[l_ac].pmdu006) THEN
               IF cl_null(g_pmdu_d[l_ac].pmdu007) THEN
                  LET g_pmdu_d[l_ac].pmdu007 = ' '
               END IF
               
               IF cl_null(g_pmdu_d[l_ac].pmdu008) THEN
                  LET g_pmdu_d[l_ac].pmdu008 = ' '
               END IF
            ELSE
               LET g_pmdu_d[l_ac].pmdu007 = ''            
               IF cl_null(g_pmdu_d[l_ac].pmdu008) THEN
                  LET g_pmdu_d[l_ac].pmdu008 = ''
               END IF
            END IF 
            
            INSERT INTO apmp570_tmp04( keyno,   pmduseq, pmduseq1,  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                                            pmdu001, pmdu002, pmdu003, pmdu004, pmdu005,
                                            pmdu006, pmdu007, pmdu008, pmdu009, pmdu010,
                                            pmdu011, pmdu012, pmdu013, pmdu014, pmdu015 )
                 VALUES(g_pmdu_d[l_ac].keyno,g_pmdu_d[l_ac].pmduseq,g_pmdu_d[l_ac].pmduseq1,
                        g_pmdu_d[l_ac].pmdu001, g_pmdu_d[l_ac].pmdu002, g_pmdu_d[l_ac].pmdu003, g_pmdu_d[l_ac].pmdu004,
                        g_pmdu_d[l_ac].pmdu005, g_pmdu_d[l_ac].pmdu006, g_pmdu_d[l_ac].pmdu007, g_pmdu_d[l_ac].pmdu008,
                        g_pmdu_d[l_ac].pmdu009, g_pmdu_d[l_ac].pmdu010, g_pmdu_d[l_ac].pmdu011, g_pmdu_d[l_ac].pmdu012,
                        g_pmdu_d[l_ac].pmdu013, g_pmdu_d[l_ac].pmdu014, g_pmdu_d[l_ac].pmdu015)
                        
            LET g_detail_cnt = g_detail_cnt + 1
            
         BEFORE DELETE 
            IF l_cmd = 'a' AND g_pmdu_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pmdu_d.deleteElement(l_ac)
               NEXT FIELD l_pmdu005
            END IF

            IF g_pmdu_d[l_ac].pmduseq1 IS NOT NULL THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF

               DELETE FROM apmp570_tmp04  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                WHERE keyno = g_keyno
                  AND pmduseq = g_pmdtseq
                  AND pmduseq1 = g_pmdu_d[l_ac].pmduseq1

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "del apmp570_tmp04"  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmdu_d[l_ac].* = g_pmdu_d_t.*
                  CANCEL DELETE
               END IF
            END IF
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF NOT cl_null(g_pmdu_d[l_ac].pmdu006) THEN
               IF cl_null(g_pmdu_d[l_ac].pmdu007) THEN
                  LET g_pmdu_d[l_ac].pmdu007 = ' '
               END IF
               
               IF cl_null(g_pmdu_d[l_ac].pmdu008) THEN
                  LET g_pmdu_d[l_ac].pmdu008 = ' '
               END IF
            ELSE
               LET g_pmdu_d[l_ac].pmdu007 = ''            
               IF cl_null(g_pmdu_d[l_ac].pmdu008) THEN
                  LET g_pmdu_d[l_ac].pmdu008 = ''
               END IF
            END IF 
            
            UPDATE apmp570_tmp04 SET pmdu005 = g_pmdu_d[l_ac].pmdu005,  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                                          pmdu006 = g_pmdu_d[l_ac].pmdu006,
                                          pmdu007 = g_pmdu_d[l_ac].pmdu007,
                                          pmdu008 = g_pmdu_d[l_ac].pmdu008,
                                          pmdu010 = g_pmdu_d[l_ac].pmdu010,
                                          pmdu012 = g_pmdu_d[l_ac].pmdu012
             WHERE keyno = g_keyno
               AND pmduseq = g_pmdtseq
               AND pmduseq1 = g_pmdu_d[l_ac].pmduseq1
            
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "upd apmp570_tmp04"  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmdu_d[l_ac].* = g_pmdu_d_t.*
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "upd apmp570_tmp04"  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmdu_d[l_ac].* = g_pmdu_d_t.*
            END CASE
            
         AFTER FIELD l_pmdu006
            LET g_pmdu_d[l_ac].pmdu006_desc = ''
            IF NOT cl_null(g_pmdu_d[l_ac].pmdu006) AND g_imaa004 <> 'E' THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_pmdu_d[l_ac].pmdu006
               #160318-00025#20  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#20  by 07900 --add-end
               IF NOT cl_chk_exist("v_inaa001_9") THEN
                  LET g_pmdu_d[l_ac].pmdu006 = g_pmdu_d_t.pmdu006
                  CALL s_desc_get_stock_desc(g_site,g_pmdu_d[l_ac].pmdu006)
                   RETURNING g_pmdu_d[l_ac].pmdu006_desc
                  NEXT FIELD CURRENT
               END IF
               IF g_pmdu_d[l_ac].pmdu006 != g_pmdu_d_t.pmdu006 OR g_pmdu_d_t.pmdu006 IS NULL THEN
                  LET g_pmdu_d[l_ac].pmdu007 = ' '
                  LET g_pmdu_d[l_ac].pmdu007_desc = ''
                  #LET g_pmdu_d[l_ac].pmdu008 = ''
                  LET g_pmdu_d_t.pmdu007 = g_pmdu_d[l_ac].pmdu007
                  #LET g_pmdu_d_t.pmdu008 = g_pmdu_d[l_ac].pmdu008
               END IF
            END IF
            LET g_pmdu_d_t.pmdu006 = g_pmdu_d[l_ac].pmdu006
            CALL s_desc_get_stock_desc(g_site,g_pmdu_d[l_ac].pmdu006)
             RETURNING g_pmdu_d[l_ac].pmdu006_desc
            #161006-00018#23-S 
            CALL apmp570_04_set_entry_b()
            CALL apmp570_04_set_no_required_b()
            CALL apmp570_04_set_required_b()
            CALL apmp570_04_set_no_entry_b() 
            #161006-00018#23-E    
            
         #此段落由子樣板a02產生
         AFTER FIELD l_pmdu007
            IF NOT cl_null(g_pmdu_d[l_ac].pmdu007) AND g_imaa004 <> 'E' THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_pmdu_d[l_ac].pmdu006
               LET g_chkparam.arg3 = g_pmdu_d[l_ac].pmdu007

               IF NOT cl_chk_exist("v_inab002_1") THEN
                  #檢查失敗時後續處理
                  LET g_pmdu_d[l_ac].pmdu007 = g_pmdu_d_t.pmdu007
                  CALL s_desc_get_locator_desc(g_site,g_pmdu_d[l_ac].pmdu006,g_pmdu_d[l_ac].pmdu007)
                   RETURNING  g_pmdu_d[l_ac].pmdu007_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_pmdu_d_t.pmdu007 = g_pmdu_d[l_ac].pmdu007
            CALL s_desc_get_locator_desc(g_site,g_pmdu_d[l_ac].pmdu006,g_pmdu_d[l_ac].pmdu007)
             RETURNING  g_pmdu_d[l_ac].pmdu007_desc 
             
         #此段落由子樣板a02產生
         AFTER FIELD l_pmdu010
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pmdu_d[l_ac].pmdu010,"0.000","0","","","azz-00079",1) THEN
               LET g_pmdu_d[l_ac].pmdu010 = g_pmdu_d_t.pmdu010
               NEXT FIELD CURRENT
            END IF
            
            IF NOT cl_null(g_pmdu_d[l_ac].pmdu010) THEN
               LET l_pmdu010 = 0
               SELECT SUM(pmdu010) INTO l_pmdu010 
                 FROM apmp570_tmp04  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
                WHERE keyno = g_keyno
                  AND pmduseq = g_pmdtseq
               IF cl_null(l_pmdu010) THEN
                  LET l_pmdu010 = 0
               END IF
               IF cl_null(g_pmdu_d_t.pmdu010) THEN
                  LET g_pmdu_d_t.pmdu010 = 0
               END IF
               IF g_pmdu_d[l_ac].pmdu010 > g_pmdt_m.l_pmdt020 - l_pmdu010 + g_pmdu_d_t.pmdu010 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00637'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmdu_d[l_ac].pmdu010 = g_pmdu_d_t.pmdu010
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_pmdu_d[l_ac].pmdu011) THEN
                  CALL s_aooi250_convert_qty(g_pmdu_d[l_ac].pmdu001,g_pmdu_d[l_ac].pmdu009,g_pmdu_d[l_ac].pmdu011,g_pmdu_d[l_ac].pmdu010)
                       RETURNING l_flag,g_pmdu_d[l_ac].pmdu012
               ELSE
                  LET g_pmdu_d[l_ac].pmdu012 = ''
               END IF
            END IF


         ON ACTION controlp INFIELD l_pmdu006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdu_d[l_ac].pmdu006   #給予default值
            LET g_qryparam.arg1 = g_site
            CALL q_inaa001_15()                                #呼叫開窗
            LET g_pmdu_d[l_ac].pmdu006 = g_qryparam.return1
            DISPLAY g_pmdu_d[l_ac].pmdu006 TO l_pmdu006
            CALL s_desc_get_stock_desc(g_site,g_pmdu_d[l_ac].pmdu006)
             RETURNING g_pmdu_d[l_ac].pmdu006_desc
            NEXT FIELD CURRENT                                 #返回原欄位


            #END add-point

         ON ACTION controlp INFIELD l_pmdu007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdu_d[l_ac].pmdu007  #給予default值
            LET g_qryparam.arg1 = g_pmdu_d[l_ac].pmdu006
            CALL q_inab002_3()                                #呼叫開窗
            LET g_pmdu_d[l_ac].pmdu007 = g_qryparam.return1
            DISPLAY g_pmdu_d[l_ac].pmdu007 TO l_pmdu007
            CALL s_desc_get_locator_desc(g_site,g_pmdu_d[l_ac].pmdu006,g_pmdu_d[l_ac].pmdu007)
             RETURNING  g_pmdu_d[l_ac].pmdu007_desc 
            NEXT FIELD CURRENT                                #返回原欄位

         AFTER INPUT
            LET l_qty = 0
            SELECT SUM(COALESCE(pmdu010,0)) INTO l_qty FROM apmp570_tmp04  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
             WHERE keyno = g_keyno
               AND pmduseq = g_pmdtseq
            IF cl_null(l_qty) THEN
               LET l_qty = 0
            END IF            
            
            IF l_qty != g_pmdt_m.l_pmdt020 THEN
               LET l_msg = cl_getmsg('apm-00560',g_dlang)
               #CALL cl_ask_pressanykey(l_msg)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00560'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD l_pmdu006
            END IF 
      END INPUT

      #公用action
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   IF INT_FLAG THEN
      LET r_success = FALSE
      CLOSE WINDOW w_apmp570_04
      #151118-00029#3 20160328 by ming mark -----(S) 
      #CALL s_transaction_end('N','0')
      #151118-00029#3 20160328 by ming mark -----(E) 
      LET INT_FLAG = 0
      RETURN r_success
   END IF

   #畫面關閉
   CLOSE WINDOW w_apmp570_04
   #151118-00029#3 20160328 by ming mark -----(S) 
   #CALL s_transaction_end('Y','0')
   #151118-00029#3 20160328 by ming mark -----(E) 
   RETURN r_success
END FUNCTION

PUBLIC FUNCTION apmp570_04_show()
DEFINE l_success        LIKE type_t.num5

   SELECT pmdtseq,pmdt006,pmdt007,pmdt009,pmdt010,
          pmdt019,pmdt021
     INTO g_pmdt_m.l_pmdtseq, g_pmdt_m.l_pmdt006, g_pmdt_m.l_pmdt007, g_pmdt_m.l_pmdt009,g_pmdt_m.l_pmdt010,
          g_pmdt_m.l_pmdt019, g_pmdt_m.l_pmdt021
     FROM apmp570_tmp03  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d2 ——> apmp570_tmp03
    WHERE keyno = g_keyno
      AND pmdtseq = g_pmdtseq
   
   DISPLAY BY NAME g_pmdt_m.l_pmdtseq, g_pmdt_m.l_pmdt006, g_pmdt_m.l_pmdt007, g_pmdt_m.l_pmdt009,g_pmdt_m.l_pmdt010,
                   g_pmdt_m.l_pmdt019, g_pmdt_m.l_pmdt020, g_pmdt_m.l_pmdt021, g_pmdt_m.l_pmdt022 
   
   CALL s_feature_description(g_pmdt_m.l_pmdt006,g_pmdt_m.l_pmdt007)
        RETURNING l_success,g_pmdt_m.l_pmdt007_desc
   
   CALL s_desc_get_item_desc(g_pmdt_m.l_pmdt006)
    RETURNING g_pmdt_m.l_imaal003,g_pmdt_m.l_imaal004    

   CALL s_desc_get_unit_desc(g_pmdt_m.l_pmdt019)
    RETURNING g_pmdt_m.l_pmdt019_desc

   CALL s_desc_get_unit_desc(g_pmdt_m.l_pmdt021)
    RETURNING g_pmdt_m.l_pmdt021_desc
    
   DISPLAY BY NAME g_pmdt_m.l_imaal003,g_pmdt_m.l_imaal004,g_pmdt_m.l_pmdt007_desc,
                   g_pmdt_m.l_pmdt019_desc,g_pmdt_m.l_pmdt021_desc
   
   CALL apmp570_04_b_fill()
END FUNCTION

PUBLIC FUNCTION apmp570_04_b_fill()
   DEFINE l_sql         STRING
   DEFINE l_ac_t        LIKE type_t.num5
   
   LET l_sql = "SELECT keyno,pmduseq,pmduseq1,",
               "       pmdu001,pmdu002,pmdu003,pmdu004,pmdu006, ",
               "       '', pmdu007,'', pmdu008,pmdu005, ",
               "       pmdu009,'',pmdu010,pmdu011,'', ",
               "       pmdu012,pmdu013,pmdu014,pmdu015 ",
               "  FROM apmp570_tmp04",  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d3 ——> apmp570_tmp04
               " WHERE keyno = ",g_keyno,
               "   AND pmduseq = ",g_pmdtseq 
              
   PREPARE apmp570_04_b_fill_pre FROM l_sql
   DECLARE apmp570_04_b_fill_curs CURSOR FOR apmp570_04_b_fill_pre 
   
   CALL g_pmdu_d.clear()

   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH apmp570_04_b_fill_curs INTO g_pmdu_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:apmp570_04_b_fill_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      CALL apmp570_04_detail_show("'1'")
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_pmdu_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   
   CLOSE apmp570_04_b_fill_curs
   FREE apmp570_04_b_fill_pre
   LET g_rec_b = g_pmdu_d.getLength()
   LET g_detail_cnt = g_pmdu_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
END FUNCTION

PUBLIC FUNCTION apmp570_04_detail_show(p_page)
   DEFINE p_page      STRING

   IF p_page.getIndexOf("'1'",1) > 0 THEN

      CALL s_desc_get_stock_desc(g_site,g_pmdu_d[l_ac].pmdu006)
       RETURNING g_pmdu_d[l_ac].pmdu006_desc
       
      CALL s_desc_get_locator_desc(g_site,g_pmdu_d[l_ac].pmdu006,g_pmdu_d[l_ac].pmdu007)
       RETURNING  g_pmdu_d[l_ac].pmdu007_desc 

      CALL s_desc_get_unit_desc(g_pmdu_d[l_ac].pmdu009)
       RETURNING g_pmdu_d[l_ac].pmdu009_desc 

      CALL s_desc_get_unit_desc(g_pmdu_d[l_ac].pmdu011)
       RETURNING g_pmdu_d[l_ac].pmdu011_desc 
       
   END IF
   
END FUNCTION

PUBLIC FUNCTION apmp570_04_set_entry_b()
   CALL cl_set_comp_entry("l_pmdu006,l_pmdu007,l_pmdu008",TRUE)
   CALL cl_set_comp_entry("l_pmdu005",TRUE)
END FUNCTION

PUBLIC FUNCTION apmp570_04_set_no_entry_b()
DEFINE l_inaa007      LIKE inaa_t.inaa007
DEFINE l_imaf061      LIKE imaf_t.imaf061
DEFINE l_imaf055      LIKE imaf_t.imaf055
DEFINE l_pmds006      LIKE pmds_t.pmds006
DEFINE l_pmdt002      LIKE pmdt_t.pmdt002
DEFINE l_pmdu005      LIKE pmdu_t.pmdu005
DEFINE l_pmdu006      LIKE pmdu_t.pmdu006
DEFINE l_pmdu007      LIKE pmdu_t.pmdu007
DEFINE l_pmdu008      LIKE pmdu_t.pmdu008
#161006-00018#23-S
DEFINE l_flag         LIKE type_t.num5
DEFINE l_ooac002      LIKE ooac_t.ooac002
DEFINE l_ooac004      LIKE ooac_t.ooac004
#161006-00018#23-E

   IF l_ac > 0 THEN      
      LET l_inaa007 = ''
      SELECT inaa007 INTO l_inaa007 FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = g_pmdu_d[l_ac].pmdu006
      IF l_inaa007 = '5' THEN
         #若該庫位設置不做儲位管理時，則儲位欄位不可以維護
          LET g_pmdu_d[l_ac].pmdu007 = ''
         CALL cl_set_comp_entry("l_pmdu007",FALSE)
      END IF
      
      #[T:料件據點進銷存檔].[C:批號控管]=1或3時才可輸入
      LET l_imaf061 = ''
      SELECT imaf061,imaf055 INTO l_imaf061,l_imaf055 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_pmdu_d[l_ac].pmdu001
      IF cl_null(l_imaf061) THEN
         SELECT imaf061 INTO l_imaf061 FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = 'ALL'
            AND imaf001 = g_pmdu_d[l_ac].pmdu001
      END IF
      IF l_imaf061 = '2' THEN
         LET g_pmdu_d[l_ac].pmdu008 = ''
         CALL cl_set_comp_entry("l_pmdu008",FALSE)
      END IF
      
      #料件庫存管理特徵=2.不可
      IF l_imaf055 = '2' THEN
         CALL cl_set_comp_entry("l_pmdu005",FALSE)
      END IF
   
      #來源單據有維護庫儲批時，則不可修改
      LET l_pmds006 = ''
      LET l_pmdt002 = ''
      SELECT pmds006,pmdt002 INTO l_pmds006,l_pmdt002 
        FROM apmp570_tmp02,apmp570_tmp03  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d1 ——> apmp570_tmp02,apmp570_02_temp_d2 ——> apmp570_tmp03
       WHERE apmp570_tmp02.keyno = apmp570_tmp03.keyno  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d1 ——> apmp570_tmp02,apmp570_02_temp_d2 ——> apmp570_tmp03
         AND apmp570_tmp02.keyno = g_pmdu_d[l_ac].keyno  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d1 ——> apmp570_tmp02
         AND apmp570_tmp03.pmdtseq = g_pmdu_d[l_ac].pmduseq  #160727-00019#12   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmp570_02_temp_d2 ——> apmp570_tmp03
         
      LET l_pmdu005 = ''
      LET l_pmdu006 = ''
      LET l_pmdu007 = ''
      LET l_pmdu008 = ''
      SELECT pmdu005,pmdu006,pmdu007,pmdu008 
        INTO l_pmdu005,l_pmdu006,l_pmdu007,l_pmdu008
        FROM pmdu_t
       WHERE pmduent = g_enterprise
         AND pmdudocno = l_pmds006
         AND pmduseq = l_pmdt002
         AND pmduseq1 = g_pmdu_d[l_ac].pmduseq1
      #161006-00018#23-S
      CALL s_aooi200_get_slip(g_pmdsdocno) RETURNING l_flag,l_ooac002
      CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004        
      #161006-00018#23-E           
      IF NOT cl_null(l_pmdu005) THEN
         CALL cl_set_comp_entry("l_pmdu005",FALSE)
      END IF
      
      IF NOT cl_null(l_pmdu006) THEN
         IF l_ooac004 = 'N' THEN   #161006-00018#23
            CALL cl_set_comp_entry("l_pmdu006",FALSE)
         END IF   #161006-00018#23  
      END IF
      
      IF NOT cl_null(l_pmdu006) AND (NOT cl_null(l_pmdu007) OR l_pmdu007 = ' ') THEN
         IF l_ooac004 = 'N' THEN   #161006-00018#23
            CALL cl_set_comp_entry("l_pmdu007",FALSE)
         END IF   #161006-00018#23     
      END IF
      
      IF NOT cl_null(l_pmdu008) THEN
         IF l_ooac004 = 'N' THEN   #161006-00018#23
            CALL cl_set_comp_entry("l_pmdu008",FALSE)
         END IF   #161006-00018#23  
      END IF
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 不必輸
# Memo...........:
# Usage..........: CALL apmp570_04_set_no_required_b()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_04_set_no_required_b()
   
   CALL cl_set_comp_required("l_pmdu005",FALSE)
   CALL cl_set_comp_required("l_pmdu006",FALSE)
   CALL cl_set_comp_required("l_pmdu007",FALSE)  #161006-00018#23
END FUNCTION

################################################################################
# Descriptions...: 必輸
# Memo...........:
# Usage..........: CALL apmp570_04_set_required_b()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/10/15 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp570_04_set_required_b()
DEFINE l_imaf055         LIKE imaf_t.imaf055
DEFINE l_inaa007         LIKE inaa_t.inaa007

   IF l_ac > 0 THEN
      #料件庫存管理特徵=1.必須
      LET l_imaf055 = NULL
      SELECT imaf055 INTO l_imaf055 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_pmdu_d[l_ac].pmdu001
      IF l_imaf055 = '1' THEN
         CALL cl_set_comp_required("l_pmdu005",TRUE)
      END IF
      #161006-00018#23-S
      SELECT inaa007 INTO l_inaa007 FROM inaa_t 
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = g_pmdu_d[l_ac].pmdu006
      IF l_inaa007 <> '5' THEN
         CALL cl_set_comp_required("l_pmdu007",TRUE)
      END IF      
      #161006-00018#23-E
   END IF
   
   IF g_imaa004 <> 'E' THEN
      CALL cl_set_comp_required("l_pmdu006",TRUE)
   END IF
   
END FUNCTION

 
{</section>}
 
