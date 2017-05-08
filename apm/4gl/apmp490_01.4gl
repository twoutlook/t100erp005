#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp490_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2017-02-20 16:22:58), PR版次:0016(2017-02-23 16:39:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000202
#+ Filename...: apmp490_01
#+ Description: 引導式請購轉採購作業_選擇範圍
#+ Creator....: 03079(2014-04-11 16:53:48)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="apmp490_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160105-00013#1.....2016/01/05 By ming..........#不再lock請購單頭，註解相關程式碼 
#160202-00006#1.....2016/02/02 By ming..........#增加aooi210，限制前後單別
#160318-00025#1.....2016/04/05 By 07675.........#將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160706-00037#1.....2016/07/07 By 03079         移除沒有需求單號的註解
#                                               處理lock的問題 
#160801-00004#3    2016/08/01  By lixiang  庫存管理特微有值時，需帶入到採購單上，且有值時，請購資料不合併
#160727-00019#11   16/08/03 By 08734       临时表长度超过15码的减少到15码以下 p490_01_lock_b_t ——> p490_lock_t
#160913-00055#3    2016/09/18  By lixiang  供应商栏位开窗调整为q_pmaa001，去掉手动加的限定条件
#161124-00048#8    2016/12/15  By zhujing  .*整批调整
#161220-00010#1    2016/12/21  By dujuan   apmp490 在進行第2步分配處理，在點選產生分配資料後點選下一步,會有尚未產生採購底稿的錯誤訊息
#161230-00019#1    2017/02/03  By shiun    供應商排除一次性交易對象，如有需求使用apmt500打單
#161031-00025#6    2017/02/17  By shiun    同原單身備註，依單別參數帶入來源單據長備註
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
GLOBALS "../../apm/4gl/apmp490_01.inc"
#end add-point
 
{</section>}
 
{<section id="apmp490_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_pmdb_d RECORD
                              sel_01             LIKE type_t.chr1,          #選擇  
                              pmdbdocno_01       LIKE pmdb_t.pmdbdocno,     #請購單號  
                              pmdbseq_01         LIKE pmdb_t.pmdbseq,       #項次 
                              pmdb004_01         LIKE pmdb_t.pmdb004,       #料號 
                              imaal003_01        LIKE imaal_t.imaal003,     #品名 
                              imaal004_01        LIKE imaal_t.imaal004,     #規格 
                              pmdb005_01         LIKE pmdb_t.pmdb005,       #產品特徵  
                              pmdb005_01_desc    LIKE type_t.chr500,        #產品特徵說明  
                              pmdb007_01         LIKE pmdb_t.pmdb007,       #單位 
                              pmdb006_01         LIKE pmdb_t.pmdb006,       #需求數量 
                              qty_01             LIKE pmdb_t.pmdb006,       #未轉採購數量 
                              pmdb030_01         LIKE pmdb_t.pmdb030,       #需求日期 
                              pmdb033_01         LIKE pmdb_t.pmdb033,       #緊急度 
                              pmdb014_01         LIKE pmdb_t.pmdb014,       #供應商選擇 
                              pmdb015_01         LIKE pmdb_t.pmdb015,       #供應商編號(指定的供應商)   
                              pmda024_01         LIKE pmda_t.pmda024,       #送貨地址 
                              pmda024_01_desc    LIKE type_t.chr500,        #地址說明 
                              pmda024_01_oofb017 LIKE oofb_t.oofb017,       #地址 
                              pmda025_01         LIKE pmda_t.pmda025,       #帳款地址 
                              pmda025_01_desc    LIKE type_t.chr500,        #地址說明 
                              pmda025_01_oofb017 LIKE oofb_t.oofb017,       #地址 
                              pmdb053_01         LIKE pmdb_t.pmdb053,       #預算科目 
                              pmdb053_01_desc    LIKE type_t.chr500,        #預算科目說明  
                              pmdb034_01         LIKE pmdb_t.pmdb034,       #專案編號 
                              pmdb034_01_desc    LIKE type_t.chr500,        #專案編號說明 
                              pmdb035_01         LIKE pmdb_t.pmdb035,       #WBS 
                              pmdb035_01_desc    LIKE type_t.chr500,        #WBS說明 
                              pmdb036_01         LIKE pmdb_t.pmdb036,       #活動編號 
                              pmdb036_01_desc    LIKE type_t.chr500,        #活動編號說明 
                              #160801-00004#3--s
                              pmdb038_01         LIKE pmdb_t.pmdb038,       #庫位
                              pmdb038_01_desc    LIKE type_t.chr500,        #庫位說明 
                              pmdb039_01         LIKE pmdb_t.pmdb039,       #儲位
                              pmdb039_01_desc    LIKE type_t.chr500,        #儲位說明 
                              pmdb054_01         LIKE pmdb_t.pmdb054,       #庫存管理特徵
                              #160801-00004#3--e                              
                              pmdb050_01         LIKE pmdb_t.pmdb050,       #備註 
                              ooff013_01         LIKE ooff_t.ooff013,       #長備註   #161031-00025#6
                              ooff014_01         LIKE ooff_t.ooff014,       #失效日期 #161031-00025#6
                              pmdbent_01         LIKE pmdb_t.pmdbent,
                              pmdbsite_01        LIKE pmdb_t.pmdbsite
                           END RECORD
DEFINE g_pmdb_d            DYNAMIC ARRAY OF type_g_pmdb_d
DEFINE g_pmdb_d_t          type_g_pmdb_d 
DEFINE l_ac                LIKE type_t.num5
DEFINE g_ref_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列 
DEFINE g_rec_b             LIKE type_t.num5
DEFINE g_detail_idx        LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apmp490_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apmp490_01.other_dialog" >}

DIALOG apmp490_01_input01()
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5 
   DEFINE l_ooef004  LIKE ooef_t.ooef004        #單據別參照表號 
   DEFINE l_budget_t LIKE type_t.chr1
   
   INPUT BY NAME g_apmp490_01_input.pmdldocno,g_apmp490_01_input.imaf142,
                 g_apmp490_01_input.cb01
                 ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT

      AFTER INPUT

      AFTER FIELD pmdldocno
         #利用aooi200的元件取得說明 
         CALL s_aooi200_get_slip_desc(g_apmp490_01_input.pmdldocno)
              RETURNING g_apmp490_01_input.pmdldocno_desc
         DISPLAY BY NAME g_apmp490_01_input.pmdldocno_desc

         IF NOT cl_null(g_apmp490_01_input.pmdldocno) THEN
            #檢核輸入的單據別是否可以被key人員對應的控制組使用,'4' 為採購控制組類型
            CALL s_control_chk_doc('1',g_apmp490_01_input.pmdldocno,'4',g_user,g_dept,'','')
                 RETURNING l_success,l_flag
            IF l_success THEN
               IF NOT l_flag THEN
                  NEXT FIELD CURRENT
               END IF
            ELSE
               NEXT FIELD CURRENT 
            END IF

            IF NOT s_aooi200_chk_slip(g_site,'',g_apmp490_01_input.pmdldocno,'apmt500') THEN
               CALL s_aooi200_get_slip_desc(g_apmp490_01_input.pmdldocno)
                    RETURNING g_apmp490_01_input.pmdldocno_desc
               DISPLAY BY NAME g_apmp490_01_input.pmdldocno_desc
               NEXT FIELD CURRENT
            END IF
         END IF
         
         #判斷此user是否有控制組，如果有存在多組控制組，就開窗讓user挑選 
         LET g_controlno = ''
         CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,g_controlno 

         #取單別參數，此單別是否走預算控制 
         LET l_budget_t = g_budget_control
         CALL cl_get_doc_para(g_enterprise,g_site,g_apmp490_01_input.pmdldocno,'D-FIN-5002')
              RETURNING g_budget_control
         
         IF g_budget_control != l_budget_t AND NOT cl_null(l_budget_t) THEN
            #新的單別是不走預算控制的，所以應該刪掉底稿中的資料 
            IF cl_ask_confirm_parm("adz-00165","") THEN   #請問是否要刪除底稿資料？ 
               CALL apmp490_01_del_tmp()
               CALL apmp490_01_b_fill_tmp(' 1=1')
            ELSE
               LET g_budget_control = l_budget_t
               LET g_apmp490_01_input.pmdldocno = g_pmdldocno_t
            END IF
         END IF

         IF NOT cl_null(g_apmp490_01_input.pmdldocno) THEN 
            CALL apmp490_01_get_col_default()   #取得欄位預設值  
         END IF 
         
         LET g_pmdldocno_t = g_apmp490_01_input.pmdldocno

      AFTER FIELD imaf142
         CALL apmp490_01_imaf142_ref(g_apmp490_01_input.imaf142)
              RETURNING g_apmp490_01_input.imaf142_desc
         DISPLAY BY NAME g_apmp490_01_input.imaf142_desc

         IF NOT cl_null(g_apmp490_01_input.imaf142) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_apmp490_01_input.imaf142
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
            #160318-00025#1--add--end
            IF NOT cl_chk_exist("v_ooag001") THEN
               NEXT FIELD CURRENT
            END IF

         END IF

         CALL apmp490_01_imaf142_ref(g_apmp490_01_input.imaf142)
              RETURNING g_apmp490_01_input.imaf142_desc
         DISPLAY BY NAME g_apmp490_01_input.imaf142_desc 
         
      ON ACTION controlp INFIELD pmdldocno
         #開窗i段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_apmp490_01_input.pmdldocno         #給予default值

         #給予arg
         LET l_ooef004 = ''             #單據別參照表號 
         SELECT ooef004 INTO l_ooef004
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site
         LET g_qryparam.arg1 = l_ooef004
         LET g_qryparam.arg2 = 'apmt500'

         CALL q_ooba002_1()                                             #呼叫開窗

         LET g_apmp490_01_input.pmdldocno = g_qryparam.return1          #將開窗取得的值回傳到變數
         DISPLAY g_apmp490_01_input.pmdldocno TO pmdldocno              #顯示到畫面上
         CALL s_aooi200_get_slip_desc(g_apmp490_01_input.pmdldocno)
              RETURNING g_apmp490_01_input.pmdldocno_desc
         DISPLAY BY NAME g_apmp490_01_input.pmdldocno_desc

         NEXT FIELD pmdldocno                                           #返回原欄位 

      ON ACTION controlp INFIELD imaf142
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE

         LET g_qryparam.default1 = g_apmp490_01_input.imaf142           #給予default值

         CALL q_ooag001()                                               #呼叫開窗 
         LET g_apmp490_01_input.imaf142 = g_qryparam.return1            #將開窗取得的值回傳到變數
         DISPLAY g_apmp490_01_input.imaf142 TO imaf142                  #顯示到畫面上
         CALL apmp490_01_imaf142_ref(g_apmp490_01_input.imaf142)
              RETURNING g_apmp490_01_input.imaf142_desc
         DISPLAY BY NAME g_apmp490_01_input.imaf142_desc

         NEXT FIELD imaf142                                             #返回原欄位 

   END INPUT
END DIALOG

DIALOG apmp490_01_construct()
   DEFINE l_sql     STRING
   DEFINE l_success LIKE type_t.num5
   #160202-00006#1 20160202 add -----(S) 
   DEFINE l_where   STRING
   #160202-00006#1 20160202 add -----(E) 

   CONSTRUCT BY NAME g_apmp490_01_wc ON pmdadocno,pmdadocdt,pmdb030,pmdb004,imaf153,imaf141

      ON ACTION controlp INFIELD pmdadocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE 
         #160202-00006#1 20160202 add -----(S) 
         CALL s_aooi210_get_check_sql(g_site,'',g_apmp490_01_input.pmdldocno,'4','','pmdadocno')
              RETURNING l_success,l_where
         IF cl_null(l_where) THEN
            LET l_where = " 1=1 "
         END IF
         #160202-00006#1 20160202 add -----(E) 
         LET g_qryparam.where = "pmdastus = 'Y' ", 
                                #160202-00006#1 20160202 add by ming -----(S) 
                                " AND ",l_where,
                                #160202-00006#1 20160202 add by ming -----(E) 
                                " AND pmdadocno IN (SELECT DISTINCT pmdbdocno ",
                                "                     FROM pmdb_t ",
                                "                    WHERE pmdbent = '",g_enterprise,"' ",
                                "                      AND pmdbsite = '",g_site,"' ",
                                "                      AND pmdb032 = '1' ",      #一般狀態下的單身才可以拋轉，已經結案的不可拋轉採購
                                "                      AND pmdb049 < pmdb006) "

         CALL q_pmdadocno()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmdadocno  #顯示到畫面上
         NEXT FIELD pmdadocno                     #返回原欄位 

      ON ACTION controlp INFIELD pmdb004
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = "1=1 "

         LET l_sql = ''
         CALL s_control_get_sql("imaa001",'6','3',g_user,g_dept) RETURNING l_success,l_sql
         IF l_success THEN 
            IF cl_null(l_sql) THEN 
               LET l_sql = " 1=1 " 
            END IF 
            LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
         END IF
         
         CALL q_imaf001_15()                    #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmdb004  #顯示到畫面上

         NEXT FIELD pmdb004                     #返回原欄位 
      ON ACTION controlp INFIELD imaf153
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         
         #查詢時開窗，只查詢供應商或交易對象(pmaa002='1'或'3')的資料 
         #LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "   #160913-00055#3
         LET g_qryparam.where = " pmaa004 <> '2' "   #161230-00019#1
         CALL q_pmaa001()
         DISPLAY g_qryparam.return1 TO imaf153
         NEXT FIELD imaf153

      ON ACTION controlp INFIELD imaf141
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE

         CALL q_imce141()
         DISPLAY g_qryparam.return1 TO imaf141
         NEXT FIELD imaf141
   END CONSTRUCT 
END DIALOG

DIALOG apmp490_01_display()
   #修改成可直接勾選 不必再點擊進入 但上方dialog function還是保留 以免日後規格變更
   DISPLAY ARRAY g_pmdb_d TO s_apmp490_01_detail1.* ATTRIBUTE(COUNT=g_d_cnt_p49001)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_p49001)
   
         BEFORE ROW
         LET g_d_idx_p49001 = DIALOG.getCurrentRow("s_apmp490_01_detail1")
         LET g_appoint_idx = g_d_idx_p49001
   END DISPLAY
END DIALOG

DIALOG apmp490_01_body_input()
   DEFINE l_ac1     LIKE type_t.num5

   INPUT ARRAY g_pmdb_d FROM s_apmp490_01_detail1.*
         ATTRIBUTE(COUNT = g_d_cnt_p49001,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
      BEFORE INPUT

      BEFORE ROW
         LET l_ac1 = ARR_CURR()

      ON CHANGE sel_01
         DISPLAY BY NAME g_pmdb_d[l_ac1].pmdbent_01

   END INPUT
END DIALOG

 
{</section>}
 
{<section id="apmp490_01.other_function" readonly="Y" >}

PUBLIC FUNCTION apmp490_01(--)

   #add-point:input段變數傳入

   #end add-point
   )

END FUNCTION

################################################################################
# Descriptions...: 依construct條件填充單身資料
# Memo...........:
# Usage..........: CALL apmp490_01_b_fill(p_wc)
# Input parameter: p_wc
# Date & Author..: 2014/06/17 By ming
# Modify.........: 151211-00012#1 2015/12/11 add by ming 增加功能：查資料時會略過被lock的資料
#                :                2015/12/21 modiby by ming 移除2014年的註解
#                : 160105-00013#1 2016/01/06 modify by ming 多個使用者無法同時在第一步查詢資料 
#                :                                          所以要改變寫法
################################################################################
PUBLIC FUNCTION apmp490_01_b_fill(p_wc)
   DEFINE p_wc      STRING
   DEFINE l_sql     STRING
   DEFINE l_ac1     LIKE type_t.num5
   DEFINE l_pmdb_d  type_g_pmdb_d
   DEFINE l_count   LIKE type_t.num5 
   DEFINE l_success LIKE type_t.num5 
   DEFINE l_pmdb049 LIKE pmdb_t.pmdb049
   DEFINE l_pmdp024 LIKE pmdp_t.pmdp024
   DEFINE l_imaa004 LIKE imaa_t.imaa004     #料件類別  
   DEFINE l_oofa001 LIKE oofa_t.oofa001
   DEFINE l_errno   LIKE gzze_t.gzze001
   DEFINE l_bgaf016 LIKE bgaf_t.bgaf016
   DEFINE l_pmdb053 LIKE pmdb_t.pmdb053
   DEFINE l_pmdb053_desc LIKE type_t.chr80
   DEFINE l_code_s_bas_0036 LIKE type_t.chr80     #是否使用產品特徵  
   DEFINE l_code_d_bas_0098 LIKE type_t.chr80     #是否帶入來源單據短備註 
   #160105-00013#1 20160106 add by ming -----(S) 
   DEFINE l_pmdbdocno       LIKE pmdb_t.pmdbdocno #請購單號 
   DEFINE l_pmdbseq         LIKE pmdb_t.pmdbseq   #請購項次 
   #160105-00013#1 20160106 add by ming -----(E) 
   #160202-00006#1 20160202 add by ming -----(S) 
   DEFINE l_where           STRING
   #160202-00006#1 20160202 add by ming -----(E) 
   
   WHENEVER ERROR CONTINUE 
   
   #如果沒有輸入單別的話就不用做  
   IF cl_null(g_apmp490_01_input.pmdldocno) THEN
      RETURN
   END IF 
   
   #取得此據點是否使用產品特徵的參數設定值 
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0036') RETURNING l_code_s_bas_0036
   
   #取得此單別是否帶入來源單據的短備註 
   CALL cl_get_doc_para(g_enterprise,g_site,g_apmp490_01_input.pmdldocno,'D-BAS-0098')
        RETURNING l_code_d_bas_0098

   IF cl_null(p_wc) THEN
      LET p_wc = ' 1=1'
   END IF

   LET l_sql = "SELECT 'N',pmdbdocno,pmdbseq,pmdb004, ",
               "       (SELECT imaal003 ",
               "          FROM imaal_t ",
               "         WHERE imaalent = '",g_enterprise,"' ",
               "           AND imaal001 = pmdb004 ",
               "           AND imaal002 = '",g_dlang,"'), ",
               "       (SELECT imaal004 ",
               "          FROM imaal_t ",
               "         WHERE imaalent = '",g_enterprise,"' ",
               "           AND imaal001 = pmdb004 ",
               "           AND imaal002 = '",g_dlang,"') , ",
               "       pmdb005,'',pmdb007,pmdb006, ",
               "       (pmdb006-NVL(pmdb049,0)),pmdb030,pmdb033,",
               "       pmdb014,pmdb015,pmda024,'','',pmda025,'','', ",
               "       pmdb053,'',pmdb034, ",
               "       (SELECT pjbal003 FROM pjbal_t ",
               "         WHERE pjbalent = '",g_enterprise,"' ",
               "           AND pjbal001 = pmdb034 ",
               "           AND pjbal002 = '",g_dlang,"'),pmdb035, ",
               "       (SELECT pjbbl004 FROM pjbbl_t ",
               "         WHERE pjbblent = '",g_enterprise,"' ",
               "           AND pjbbl001 = pmdb034 ",
               "           AND pjbbl002 = pmdb035 ",
               "           AND pjbbl003 = '",g_dlang,"'),pmdb036, ",
               "       (SELECT pjbml004 FROM pjbml_t ",
               "         WHERE pjbmlent = '",g_enterprise,"' ",
               "           AND pjbml001 = pmdb034 ",
               "           AND pjbml002 = pmdb036 ",
               "           AND pjbml003 = '",g_dlang,"'),",
               #160801-00004#3--s
               "       pmdb038,",
               "      (SELECT inayl003 FROM inayl_t WHERE inaylent = '",g_enterprise,"' AND inayl001 = pmdb038 AND inayl002 = '",g_dlang,"'),",
               "       pmdb039,",
               "      (SELECT inab003 FROM inab_t WHERE inabent = '",g_enterprise,"' AND inabsite = '",g_site,"' AND inab001 = pmdb038 AND inab002 = pmdb039),",
               "      pmdb054,",
               #160801-00004#3--e
               "       pmdb050, ",
               "       (SELECT ooff013 FROM ooff_t WHERE ooffent = ",g_enterprise," AND ooff001 = '7' AND ooff002 = 'apmt400' AND ooff003 = pmdbdocno AND ooff004 = pmdbseq AND ooff012 = '1' AND (to_char(ooff014,'yyyy/mm/dd') < '",g_today,"' OR ooff014 IS NULL )), ",   #161031-00025#6
               "       (SELECT ooff014 FROM ooff_t WHERE ooffent = ",g_enterprise," AND ooff001 = '7' AND ooff002 = 'apmt400' AND ooff003 = pmdbdocno AND ooff004 = pmdbseq AND ooff012 = '1' AND (to_char(ooff014,'yyyy/mm/dd') < '",g_today,"' OR ooff014 IS NULL )), ",   #161031-00025#6
               "       pmdbent,pmdbsite, ",
               "       pmdb049",
               #161230-00019#1-s-mod
#               "  FROM pmda_t,pmdb_t,imaf_t ",
               "  FROM pmda_t,pmdb_t LEFT OUTER JOIN pmaa_t ON pmaaent = pmdbent AND pmaa001 = pmdb015,imaf_t ",
               #161230-00019#1-e-mod
               " WHERE pmdaent = '",g_enterprise,"' ",
               "   AND pmdasite ='",g_site,"' ",
               "   AND pmdaent = pmdbent ",
               "   AND pmdasite = pmdbsite ",
               "   AND pmdadocno = pmdbdocno ",
               "   AND pmdbent = imafent ",
               "   AND pmdasite = imafsite ", 
               "   AND pmdb004 = imaf001 ",
               "   AND pmdastus = 'Y' ",                   #已確認的請購單才能轉採購單   
               "   AND pmdb032 = '1' ",                    #一般狀態下的單身才可以拋轉，已經結案的不可拋轉採購
               "   AND pmdb049 < pmdb006 ",                #如果未轉採購量小於等於0的話就不顯示出來  
               "   AND ",p_wc,
               #161230-00019#1-s-add
               "   AND (pmaa004 <> '2' OR pmdb015 IS NULL) "
               #161230-00019#1-e-add

   IF NOT cl_null(g_apmp490_01_input.imaf142) THEN
      LET l_sql = l_sql, " AND imaf142 = '",g_apmp490_01_input.imaf142,"' "
   END IF
   
   #預算控制   
   IF g_budget_control = 'N' THEN
      LET l_sql = l_sql," AND pmdb053 IS NULL " 
   END IF
   
   #160202-00006#1 20160202 add by ming -----(S) 
   CALL s_aooi210_get_check_sql(g_site,'',g_apmp490_01_input.pmdldocno,'4','','pmdadocno')
        RETURNING l_success,l_where
   IF NOT cl_null(l_where) THEN
      LET l_sql = l_sql," AND ",l_where
   END IF
   #160202-00006#1 20160202 add by ming -----(E) 

   LET l_sql = l_sql, " ORDER BY pmdbdocno,pmdbseq " 
   
   #160105-00013#1 20160106 mark by ming -----(S) 
   #不在外層過濾，改在內層檢查 
   ##151211-00012#1 20151211 add by ming -----(S) 
   #LET l_sql = l_sql, " FOR UPDATE SKIP LOCKED "     #略過被lock的資料，並且把查出來的資料lock 
   ##151211-00012#1 20151211 add by ming -----(E) 
   #160105-00013#1 20160106 mark by ming -----(E) 

   PREPARE p490_01_prep FROM l_sql
   DECLARE p490_01_curs CURSOR FOR p490_01_prep

   CALL g_pmdb_d.clear()

   LET l_ac1 = 1
   INITIALIZE l_pmdb_d.* TO NULL

   FOREACH p490_01_curs INTO l_pmdb_d.*,l_pmdb049
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      
      #160105-00013#1 20160106 add by ming -----(S) 
      #檢查請購單的資料是否已經被lock 
      LET l_pmdbdocno = '' 
      LET l_pmdbseq   = '' 
      LET l_sql = "SELECT pmdbdocno,pmdbseq ", 
                  "  FROM pmdb_t ", 
                  " WHERE pmdbent   = '",g_enterprise,"' ", 
                  "   AND pmdbdocno = '",l_pmdb_d.pmdbdocno_01,"' ", 
                  "   AND pmdbseq   = '",l_pmdb_d.pmdbseq_01,"' ", 
                  "   FOR UPDATE SKIP LOCKED " 
      PREPARE apmp490_01_chk_locked_prep FROM l_sql 
      EXECUTE apmp490_01_chk_locked_prep INTO l_pmdbdocno,l_pmdbseq 
      IF cl_null(l_pmdbdocno) AND cl_null(l_pmdbseq) THEN 
         CONTINUE FOREACH 
      END IF 
      #160105-00013#1 20160106 add by ming -----(E) 
      #161124-00048#8 mod-S
      IF l_code_s_bas_0036 =  'N' THEN
         LET l_pmdb_d.pmdb005_01 = ' '
      END IF
      #161124-00048#8 mod-E
      #檢查此資料是否已經存在請購底稿之中了，如果已經存在了，那就不再顯示 
      LET l_count = 0
      SELECT COUNT(*) INTO l_count
        FROM p490_01_pmdb_t
       WHERE pmdbdocno = l_pmdb_d.pmdbdocno_01
         AND pmdbseq = l_pmdb_d.pmdbseq_01
         AND NVL(pmdb004,' ') = NVL(l_pmdb_d.pmdb004_01,' ')
         AND NVL(pmdb005,' ') = NVL(l_pmdb_d.pmdb005_01,' ')
         AND NVL(pmdb007,' ') = NVL(l_pmdb_d.pmdb007_01,' ')
         AND NVL(pmdb006,'0') = NVL(l_pmdb_d.pmdb006_01,'0')
         AND pmdb030 = l_pmdb_d.pmdb030_01
         AND NVL(pmdb033,' ') = NVL(l_pmdb_d.pmdb033_01,' ')

      IF l_count > 0 THEN
         INITIALIZE l_pmdb_d.* TO NULL
         CONTINUE FOREACH
      END IF

      #做採購料件的基本檢查  
      #雖然第一頁都是請購單的資料，而第二頁還可以修改採購料件 
      #但是那是有做替代才可以換 所以大多數請購料都會等於採購料 
      #故在此就要先做檢查  
      IF NOT apmp490_01_pmdn001_chk(l_pmdb_d.pmdb004_01) THEN
         CONTINUE FOREACH
      END IF
      
      #161124-00048#8 marked-S
      IF l_code_s_bas_0036 =  'N' THEN
         LET l_pmdb_d.pmdb005_01 = ' '
      END IF
      #161124-00048#8 marked-E

      #取得產品特徵說明 
      IF NOT cl_null(l_pmdb_d.pmdb005_01) THEN
         CALL s_feature_description(l_pmdb_d.pmdb004_01,l_pmdb_d.pmdb005_01)
              RETURNING l_success,l_pmdb_d.pmdb005_01_desc
      END IF
           
      LET l_imaa004 = ''     #料件類別 
      SELECT imaa004 INTO l_imaa004
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_pmdb_d.pmdb004_01
      
      IF l_imaa004 != 'E' THEN     #如果不是費用料件的時候，才需要考慮單別參數的設定是否保留  
         IF l_code_d_bas_0098 != 'Y' OR cl_null(l_code_d_bas_0098) THEN
            #如果不是費用料件，且單別參數設定為不保留時 
            #備註就應該被合併清掉不出現 
            LET l_pmdb_d.pmdb050_01 = ''
            #161031-00025#6-s-add
            LET l_pmdb_d.ooff013_01 = ''
            LET l_pmdb_d.ooff014_01 = ''
            #161031-00025#6-e-add
         END IF
      END IF
      
      #161220-00010#1 add  --begin--
      #送貨地址
      IF cl_null(l_pmdb_d.pmda024_01) THEN
         CALL apmp490_01_get_pmdl025_pmdl026('3') RETURNING l_pmdb_d.pmda024_01
      END IF
      #161220-00010#1 add  --end--
      
      #送貨地址 
      IF NOT cl_null(l_pmdb_d.pmda024_01) THEN
         CALL s_apmp490_get_address('3',l_pmdb_d.pmda024_01)
              RETURNING l_pmdb_d.pmda024_01_desc,l_pmdb_d.pmda024_01_oofb017
      END IF
       
      #161220-00010#1 add  --begin-- 
      #帳款地址      
      IF cl_null(l_pmdb_d.pmda025_01) THEN
         CALL apmp490_01_get_pmdl025_pmdl026('5') RETURNING l_pmdb_d.pmda025_01
      END IF
      #161220-00010#1 add  --end--

      #帳款地址 
      IF NOT cl_null(l_pmdb_d.pmda025_01) THEN
         CALL s_apmp490_get_address('5',l_pmdb_d.pmda025_01)
              RETURNING l_pmdb_d.pmda025_01_desc,l_pmdb_d.pmda025_01_oofb017
      END IF
      
      #預算科目說明  
      CALL apmp490_01_detail_abg(l_pmdb_d.pmdbdocno_01,l_pmdb_d.pmdbseq_01,'3')
           RETURNING l_success,l_errno,l_bgaf016,l_pmdb053,l_pmdb053_desc
      LET l_pmdb_d.pmdb053_01_desc = l_pmdb053_desc

      LET g_pmdb_d[l_ac1].* = l_pmdb_d.*

      LET l_ac1 = l_ac1 + 1
      INITIALIZE l_pmdb_d.* TO NULL

      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   LET g_rec_b = l_ac1

END FUNCTION

################################################################################
# Descriptions...: 建立請購底稿的temp table 
# Memo...........:
# Usage..........: CALL apmp490_01_create_temp_table()
# Date & Author..: 2014/06/17 By ming
# Modify.........: #160105-00013#1 2016/01/05 by ming 註解掉lock請購單頭的table 
################################################################################
PUBLIC FUNCTION apmp490_01_create_temp_table()

   WHENEVER ERROR CONTINUE 

   CREATE TEMP TABLE p490_01_pmdb_t(
      pmdbdocno     LIKE pmdb_t.pmdbdocno,      #請購單號   
      pmdbseq       LIKE pmdb_t.pmdbseq,        #項次  
      pmdb004       LIKE pmdb_t.pmdb004,        #料號  
      pmdb005       LIKE pmdb_t.pmdb005,        #產品特徵  
      pmdb007       LIKE pmdb_t.pmdb007,        #單位   
      pmdb006       LIKE pmdb_t.pmdb006,        #需求數量  
      qty           LIKE pmdb_t.pmdb006,        #未轉採購量  
      pmdb030       LIKE pmdb_t.pmdb030,        #需求日期  
      pmdb033       LIKE pmdb_t.pmdb033,        #緊急度 
      pmdb014       LIKE pmdb_t.pmdb014,        #供應商選擇 
      pmdb015       LIKE pmdb_t.pmdb015,        #供應商編號 
      pmda024       LIKE pmda_t.pmda024,        #送貨地址       
      pmda025       LIKE pmda_t.pmda025,        #帳款地址      
      pmdb053       LIKE pmdb_t.pmdb053,        #預算科目   
      pmdb034       LIKE pmdb_t.pmdb034,        #專案編號     
      pmdb035       LIKE pmdb_t.pmdb035,        #WBS   
      pmdb036       LIKE pmdb_t.pmdb036,        #活動編號
      #160801-00004#3--s
      pmdb038       LIKE pmdb_t.pmdb038,       #庫位
      pmdb039       LIKE pmdb_t.pmdb039,       #儲位
      pmdb054       LIKE pmdb_t.pmdb054,       #庫存管理特徵
      #160801-00004#3--e                                  
      pmdb050       LIKE pmdb_t.pmdb050,        #備註  
      ooff013       LIKE ooff_t.ooff013,        #長備註   #161031-00025#6
      ooff014       LIKE ooff_t.ooff014,        #失效日期 #161031-00025#6
      pmdbent       LIKE pmdb_t.pmdbent,        #
      pmdbsite      LIKE pmdb_t.pmdbsite,       #
      applied_qty   LIKE pmdb_t.pmdb006)        #已分配數量 
      
   #資料lock的temp table 
   #160105-00013#1 20160105 mark by ming -----(S) 
   #不再lock請購單頭 
   #CREATE TEMP TABLE p490_01_lock_h_t(
   #   pmdadocno      LIKE pmda_t.pmdadocno      #請購單號 
   #)
   #160105-00013#1 20160105 mark by ming -----(E) 

   CREATE TEMP TABLE p490_lock_t(   #160727-00019#11   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p490_01_lock_b_t ——> p490_lock_t
      pmdbdocno      LIKE pmdb_t.pmdbdocno,     #請購單號 
      pmdbseq        LIKE pmdb_t.pmdbseq        #請購項次 
   )
END FUNCTION

################################################################################
# Descriptions...: 將選取的資料寫入請購底稿
# Memo...........:
# Usage..........: CALL apmp490_01_save()
# Date & Author..: 2014/06/17 By ming
# Modify.........: #160105-00013#1 2016/01/05 by ming 不再lock請購單頭，註解相關程式碼 
################################################################################
PUBLIC FUNCTION apmp490_01_save()
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.chr1 
   DEFINE l_sql       STRING
   DEFINE l_pmdbdocno LIKE pmdb_t.pmdbdocno
   DEFINE l_pmdbseq   LIKE pmdb_t.pmdbseq
   DEFINE l_where     STRING

   WHENEVER ERROR CONTINUE 

   #用來判斷是否有資料被寫入 
   LET l_flag = 'N'

   #如果畫面上沒有資料的話，就不必實做寫入底稿的動作 
   IF g_pmdb_d.getLength() = 0 THEN
      RETURN
   END IF

   FOR l_i = 1 TO g_pmdb_d.getLength()
      #只要單身中的資料沒有被勾選，就直接下一筆 
      IF g_pmdb_d[l_i].sel_01 = 'N' THEN
         CONTINUE FOR
      END IF

      #檢查此請購單資料是否已經存在底稿之前  
      #已經存在底稿的就不用重覆寫入 
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM p490_01_pmdb_t
       WHERE pmdbdocno = g_pmdb_d[l_i].pmdbdocno_01
         AND pmdbseq = g_pmdb_d[l_i].pmdbseq_01
         AND pmdb004 = g_pmdb_d[l_i].pmdb004_01
         AND pmdb005 = g_pmdb_d[l_i].pmdb005_01
         AND pmdb007 = g_pmdb_d[l_i].pmdb007_01
         AND pmdb006 = g_pmdb_d[l_i].pmdb006_01 
         AND pmdb030 = g_pmdb_d[l_i].pmdb030_01
         AND pmdb033 = g_pmdb_d[l_i].pmdb033_01
      IF l_cnt > 0 THEN
         CONTINUE FOR
      END IF

      #將勾選的資料寫入請購底稿中                               
      INSERT INTO p490_01_pmdb_t(pmdbdocno,pmdbseq,pmdb004,pmdb005,
                                 pmdb007,pmdb006,qty,pmdb030,pmdb033,
                                 pmdb014,pmdb015,pmda024,pmda025,pmdb053,
                                 pmdb034,pmdb035,pmdb036,
                                 pmdb038,pmdb039,pmdb054,   #160801-00004#3 add
                                 pmdb050,
                                 ooff013,ooff014,   #161031-00025#6
                                 pmdbent,pmdbsite,applied_qty)
                          VALUES(g_pmdb_d[l_i].pmdbdocno_01,g_pmdb_d[l_i].pmdbseq_01,
                                 g_pmdb_d[l_i].pmdb004_01,g_pmdb_d[l_i].pmdb005_01,
                                 g_pmdb_d[l_i].pmdb007_01,g_pmdb_d[l_i].pmdb006_01,
                                 g_pmdb_d[l_i].qty_01,g_pmdb_d[l_i].pmdb030_01,
                                 g_pmdb_d[l_i].pmdb033_01,g_pmdb_d[l_i].pmdb014_01,
                                 g_pmdb_d[l_i].pmdb015_01,g_pmdb_d[l_i].pmda024_01,
                                 g_pmdb_d[l_i].pmda025_01,g_pmdb_d[l_i].pmdb053_01,
                                 g_pmdb_d[l_i].pmdb034_01,g_pmdb_d[l_i].pmdb035_01,
                                 g_pmdb_d[l_i].pmdb036_01,
                                 g_pmdb_d[l_i].pmdb038_01,g_pmdb_d[l_i].pmdb039_01,g_pmdb_d[l_i].pmdb054_01,  #160801-00004#3 add
                                 g_pmdb_d[l_i].pmdb050_01,
                                 g_pmdb_d[l_i].ooff013_01,g_pmdb_d[l_i].ooff014_01,   #161031-00025#6
                                 g_pmdb_d[l_i].pmdbent_01,g_pmdb_d[l_i].pmdbsite_01,'0') 
                                 
      #160105-00013#1 20160105 mark by ming -----(S) 
      #不再lock請購單頭
      #LET l_cnt = 0
      #SELECT COUNT(*) INTO l_cnt
      #  FROM p490_01_lock_h_t
      # WHERE pmdadocno = g_pmdb_d[l_i].pmdbdocno_01
      #IF cl_null(l_cnt) OR l_cnt = 0 THEN
      #   INSERT INTO p490_01_lock_h_t VALUES(g_pmdb_d[l_i].pmdbdocno_01)
      #END IF
      #160105-00013#1 20160105 mark by ming -----(E) 

      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM p490_lock_t  #160727-00019#11   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p490_01_lock_b_t ——> p490_lock_t
       WHERE pmdbdocno = g_pmdb_d[l_i].pmdbdocno_01
         AND pmdbseq   = g_pmdb_d[l_i].pmdbseq_01
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         INSERT INTO p490_lock_t VALUES(g_pmdb_d[l_i].pmdbdocno_01,g_pmdb_d[l_i].pmdbseq_01)  #160727-00019#11   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p490_01_lock_b_t ——> p490_lock_t
      END IF

      LET l_flag = 'Y'
   END FOR 
   
   #160105-00013#1 20160105 mark by ming -----(S) 
   #不再lock請購單頭 
   #LET l_sql = "SELECT pmdadocno ",
   #            "  FROM pmda_t ",
   #            " WHERE pmdadocno IN (SELECT pmdadocno ",
   #            "                      FROM p490_01_lock_h_t) ",
   #            "   FOR UPDATE "
   #PREPARE apmp490_lock_head_prep FROM l_sql
   #DECLARE apmp490_lock_head_curs CURSOR FOR apmp490_lock_head_prep
   #160105-00013#1 20160105 mark by ming -----(E) 

   #160706-00037#1 20160707 -----(S) 
   #LET l_sql = "SELECT pmdbdocno,pmdbseq ",
   #            "  FROM p490_01_lock_b_t ",
   #            " ORDER BY pmdbdocno,pmdbseq "
   #PREPARE apmp490_lock_prep FROM l_sql
   #DECLARE apmp490_lock_curs CURSOR FOR apmp490_lock_prep
   #
   #LET l_sql = "SELECT pmdbdocno,pmdbseq ",
   #            "  FROM pmdb_t ",
   #            " WHERE "
   #
   #LET l_where = ''
   #FOREACH apmp490_lock_curs INTO l_pmdbdocno,l_pmdbseq
   #   IF cl_null(l_where) THEN
   #      LET l_where = "(pmdbdocno = '",l_pmdbdocno,"' AND pmdbseq = '",l_pmdbseq,"') "
   #   ELSE
   #      LET l_where = l_where," OR ","(pmdbdocno = '",l_pmdbdocno,"' AND pmdbseq = '",l_pmdbseq,"') "
   #   END IF
   #END FOREACH
   #
   #LET l_sql = l_sql,l_where," FOR UPDATE "
   #PREPARE apmp490_lock_body_prep FROM l_sql 
   #DECLARE apmp490_lock_body_curs CURSOR FOR apmp490_lock_body_prep
   #160706-00037#1 20160707 -----(E) 

   #160105-00013#1 20160105 mark by ming -----(S) 
   #不再lock請購單頭 
   #OPEN apmp490_lock_head_curs
   #160105-00013#1 20160105 mark by ming -----(E) 
   
   #160706-00037#1 20160707 -----(S) 
   #OPEN apmp490_lock_body_curs  
   #160706-00037#1 20160707 -----(E) 

   #有資料寫入 要提示 user資料寫入底稿成功 
   IF l_flag = 'Y' THEN
      CALL cl_ask_pressanykey("apm-00527")   #請購底稿寫入成功  
   END IF
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table 
# Memo...........:
# Usage..........: CALL apmp490_01_drop_temp_table()
# Date & Author..: 2014/06/17 By ming
# Modify.........: #160105-00013#1 2016/01/05 by ming 不再lock請購單頭，註解相關程式碼
################################################################################
PUBLIC FUNCTION apmp490_01_drop_temp_table()
   WHENEVER ERROR CONTINUE 

   DROP TABLE p490_01_pmdb_t; 
   
   #160105-00013#1 20160105 mark by ming -----(S) 
   #不再lock請購單頭 
   #DROP TABLE p490_01_lock_h_t;
   #160105-00013#1 20160105 mark by ming -----(E) 
   DROP TABLE p490_lock_t;  #160727-00019#11   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p490_01_lock_b_t ——> p490_lock_t

END FUNCTION

PUBLIC FUNCTION apmp490_01_imaf142_ref(p_imaf142)
   DEFINE p_imaf142      LIKE imaf_t.imaf142
   DEFINE r_imaf142_desc LIKE oofa_t.oofa011

   WHENEVER ERROR CONTINUE 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imaf142
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ",
                      "")
        RETURNING g_rtn_fields
   LET r_imaf142_desc = '', g_rtn_fields[1] , ''
   RETURN r_imaf142_desc
END FUNCTION

################################################################################
# Descriptions...: 頁面初始化設定
# Memo...........:
# Usage..........: CALL apmp490_01_init()
# Date & Author..: 2014/06/17 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_init()
   WHENEVER ERROR CONTINUE 

   CALL cl_set_combo_scc("pmdb033_01","2036")
   CALL cl_set_combo_scc("pmdb014_01","2037")

   #畫面預設值 
   LET g_apmp490_01_input.cb01 = 'N'

   LET g_pmdadocno = ''
   LET g_pmdadocdt = ''
   LET g_pmdb030 = ''
   LET g_pmdb004 = ''
   LET g_imaf153 = ''
   LET g_imaf141 = '' 
   
   #不使用產品特徵，則將產品特徵及說明隱藏 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdb005_01,pmdb005_01_desc",FALSE)
   END IF 
   
   #讓畫面上的數字是「整數」 
   #CALL cl_set_comp_format("pmdb006_01",'---,---,---,--&')
   
   CALL g_pmdb_d.clear()
END FUNCTION

################################################################################
# Descriptions...: 以單別取得欄位預設值 
# Memo...........:
# Usage..........: CALL apmp490_01_get_col_default()
# Date & Author..: 2017/06/17 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_get_col_default()
   
   WHENEVER ERROR CONTINUE 
   
   #以單別取得欄位預設值 
   #目前無作用 

   INITIALIZE g_apmp490_01_pmdl.* TO NULL

   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdldocdt',g_apmp490_01_pmdl.pmdldocdt)
        RETURNING g_apmp490_01_pmdl.pmdldocdt
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl001',g_apmp490_01_pmdl.pmdl001)
        RETURNING g_apmp490_01_pmdl.pmdl001
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl002',g_apmp490_01_pmdl.pmdl002)
        RETURNING g_apmp490_01_pmdl.pmdl002
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl003',g_apmp490_01_pmdl.pmdl003)
        RETURNING g_apmp490_01_pmdl.pmdl003
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl004',g_apmp490_01_pmdl.pmdl004)
        RETURNING g_apmp490_01_pmdl.pmdl004
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl005',g_apmp490_01_pmdl.pmdl005)
        RETURNING g_apmp490_01_pmdl.pmdl005
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl006',g_apmp490_01_pmdl.pmdl006)
        RETURNING g_apmp490_01_pmdl.pmdl006
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl007',g_apmp490_01_pmdl.pmdl007)
        RETURNING g_apmp490_01_pmdl.pmdl007
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl008',g_apmp490_01_pmdl.pmdl008)
        RETURNING g_apmp490_01_pmdl.pmdl008
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl009',g_apmp490_01_pmdl.pmdl009)
        RETURNING g_apmp490_01_pmdl.pmdl009
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl010',g_apmp490_01_pmdl.pmdl010)
        RETURNING g_apmp490_01_pmdl.pmdl010
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl011',g_apmp490_01_pmdl.pmdl011)
        RETURNING g_apmp490_01_pmdl.pmdl011
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl012',g_apmp490_01_pmdl.pmdl012)
        RETURNING g_apmp490_01_pmdl.pmdl012
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl013',g_apmp490_01_pmdl.pmdl013)
        RETURNING g_apmp490_01_pmdl.pmdl013
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl015',g_apmp490_01_pmdl.pmdl015)
        RETURNING g_apmp490_01_pmdl.pmdl015
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl016',g_apmp490_01_pmdl.pmdl016)
        RETURNING g_apmp490_01_pmdl.pmdl016
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl017',g_apmp490_01_pmdl.pmdl017)
        RETURNING g_apmp490_01_pmdl.pmdl017
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl018',g_apmp490_01_pmdl.pmdl018)
        RETURNING g_apmp490_01_pmdl.pmdl018
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl019',g_apmp490_01_pmdl.pmdl019)
        RETURNING g_apmp490_01_pmdl.pmdl019
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl020',g_apmp490_01_pmdl.pmdl020)
        RETURNING g_apmp490_01_pmdl.pmdl020
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl021',g_apmp490_01_pmdl.pmdl021)
        RETURNING g_apmp490_01_pmdl.pmdl021
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl022',g_apmp490_01_pmdl.pmdl022)
        RETURNING g_apmp490_01_pmdl.pmdl022
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl023',g_apmp490_01_pmdl.pmdl023)
        RETURNING g_apmp490_01_pmdl.pmdl023
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl024',g_apmp490_01_pmdl.pmdl024)
        RETURNING g_apmp490_01_pmdl.pmdl024
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl025',g_apmp490_01_pmdl.pmdl025)
        RETURNING g_apmp490_01_pmdl.pmdl025
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl026',g_apmp490_01_pmdl.pmdl026)
        RETURNING g_apmp490_01_pmdl.pmdl026 
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl027',g_apmp490_01_pmdl.pmdl027)
        RETURNING g_apmp490_01_pmdl.pmdl027
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl028',g_apmp490_01_pmdl.pmdl028)
        RETURNING g_apmp490_01_pmdl.pmdl028
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl029',g_apmp490_01_pmdl.pmdl029)
        RETURNING g_apmp490_01_pmdl.pmdl029
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl030',g_apmp490_01_pmdl.pmdl030)
        RETURNING g_apmp490_01_pmdl.pmdl030
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl031',g_apmp490_01_pmdl.pmdl031)
        RETURNING g_apmp490_01_pmdl.pmdl031
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl032',g_apmp490_01_pmdl.pmdl032)
        RETURNING g_apmp490_01_pmdl.pmdl032
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl033',g_apmp490_01_pmdl.pmdl033)
        RETURNING g_apmp490_01_pmdl.pmdl033
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl040',g_apmp490_01_pmdl.pmdl040)
        RETURNING g_apmp490_01_pmdl.pmdl040
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl041',g_apmp490_01_pmdl.pmdl041)
        RETURNING g_apmp490_01_pmdl.pmdl041
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl042',g_apmp490_01_pmdl.pmdl042)
        RETURNING g_apmp490_01_pmdl.pmdl042
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl043',g_apmp490_01_pmdl.pmdl043)
        RETURNING g_apmp490_01_pmdl.pmdl043
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl044',g_apmp490_01_pmdl.pmdl044)
        RETURNING g_apmp490_01_pmdl.pmdl044
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl046',g_apmp490_01_pmdl.pmdl046)
        RETURNING g_apmp490_01_pmdl.pmdl046 
        
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl047',g_apmp490_01_pmdl.pmdl047)
        RETURNING g_apmp490_01_pmdl.pmdl047
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl048',g_apmp490_01_pmdl.pmdl048)
        RETURNING g_apmp490_01_pmdl.pmdl048
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl049',g_apmp490_01_pmdl.pmdl049)
        RETURNING g_apmp490_01_pmdl.pmdl049
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl050',g_apmp490_01_pmdl.pmdl050)
        RETURNING g_apmp490_01_pmdl.pmdl050
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl051',g_apmp490_01_pmdl.pmdl051)
        RETURNING g_apmp490_01_pmdl.pmdl051
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl052',g_apmp490_01_pmdl.pmdl052)
        RETURNING g_apmp490_01_pmdl.pmdl052
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl053',g_apmp490_01_pmdl.pmdl053)
        RETURNING g_apmp490_01_pmdl.pmdl053
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl054',g_apmp490_01_pmdl.pmdl054)
        RETURNING g_apmp490_01_pmdl.pmdl054
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl055',g_apmp490_01_pmdl.pmdl055)
        RETURNING g_apmp490_01_pmdl.pmdl055
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl200',g_apmp490_01_pmdl.pmdl200)
        RETURNING g_apmp490_01_pmdl.pmdl200
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl201',g_apmp490_01_pmdl.pmdl201)
        RETURNING g_apmp490_01_pmdl.pmdl201
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl202',g_apmp490_01_pmdl.pmdl202)
        RETURNING g_apmp490_01_pmdl.pmdl202
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl203',g_apmp490_01_pmdl.pmdl203)
        RETURNING g_apmp490_01_pmdl.pmdl203
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl204',g_apmp490_01_pmdl.pmdl204)
        RETURNING g_apmp490_01_pmdl.pmdl204 
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl900',g_apmp490_01_pmdl.pmdl900)
        RETURNING g_apmp490_01_pmdl.pmdl900
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl999',g_apmp490_01_pmdl.pmdl999)
        RETURNING g_apmp490_01_pmdl.pmdl999
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl205',g_apmp490_01_pmdl.pmdl205)
        RETURNING g_apmp490_01_pmdl.pmdl205
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl206',g_apmp490_01_pmdl.pmdl206)
        RETURNING g_apmp490_01_pmdl.pmdl206
   CALL s_aooi200_get_doc_default(g_site,'1',g_apmp490_01_input.pmdldocno,'pmdl207',g_apmp490_01_pmdl.pmdl207)
        RETURNING g_apmp490_01_pmdl.pmdl207

   CALL cl_set_comp_entry("pmdl009_03_01,pmdl010_03_01,pmdl011_03_01,pmdl015_03_01",TRUE)
   CALL cl_set_comp_entry("pmdl017_03_01,pmdl023_03_01,pmdl054_03_01,pmdl033_03_01,pmdl055_03_01",TRUE)

   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl009') THEN
      CALL cl_set_comp_entry("pmdl009_03_01",FALSE)
   END IF
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl010') THEN
      CALL cl_set_comp_entry("pmdl010_03_01",FALSE)
   END IF
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl011') THEN
      CALL cl_set_comp_entry("pmdl011_03_01",FALSE)
   END IF
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl015') THEN
      CALL cl_set_comp_entry("pmdl015_03_01",FALSE)
   END IF
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl017') THEN
      CALL cl_set_comp_entry("pmdl017_03_01",FALSE)
   END IF 
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl023') THEN
      CALL cl_set_comp_entry("pmdl023_03_01",FALSE)
   END IF
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl054') THEN
      CALL cl_set_comp_entry("pmdl054_03_01",FALSE)
   END IF
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl033') THEN
      CALL cl_set_comp_entry("pmdl033_03_01",FALSE)
   END IF
   IF NOT s_apmp490_set_fields_entry(g_apmp490_01_input.pmdldocno,'pmdl055') THEN
      CALL cl_set_comp_entry("pmdl055_03_01",FALSE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 料件檢查
# Memo...........:
# Usage..........: CALL apmp490_01_pmdn001_chk(p_pmdn001)
# Input parameter: p_pmdn001：料號
# Date & Author..: 2014/06/17 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_pmdn001_chk(p_pmdn001)
   DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
   DEFINE l_flag        LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_pmdp007     LIKE pmdp_t.pmdp007
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_imaastus    LIKE imaa_t.imaastus

   WHENEVER ERROR CONTINUE 

   LET r_success = TRUE
   LET g_errno = ''

   IF NOT cl_null(p_pmdn001) THEN
      #參考v_imaa001的檢查  

      LET l_imaastus = ''
      SELECT imaastus INTO l_imaastus
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = p_pmdn001

      CASE
         WHEN SQLCA.sqlcode = 100     LET g_errno = 'aim-00001'     #輸入的資料不存在料件主檔中  
         WHEN l_imaastus <> 'Y'       LET g_errno = 'aim-00101'     #輸入的資料狀態不是已確認！ 
         OTHERWISE                    LET g_errno = SQLCA.sqlcode USING '------'
      END CASE 
      
      #如果有錯誤訊息的話就回去 
      IF NOT cl_null(g_errno) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #參考v_imaf001_1 
      LET l_imaastus = ''
      SELECT imaastus INTO l_imaastus
        FROM imaf_t,imaa_t
       WHERE imafent = imaaent
         AND imaf001 = imaa001
         AND imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = p_pmdn001

      CASE
         WHEN SQLCA.sqlcode = 100      LET g_errno = 'aim-00066'
         WHEN l_imaastus <> 'Y'        LET g_errno = 'aim-00101'    #輸入的資料狀態不是已確認！ 
         OTHERWISE                     LET g_errno = SQLCA.sqlcode USING '------'
      END CASE

      #如果有錯誤訊息就跳回去  
      IF NOT cl_null(g_errno) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #判斷輸入的料件編號是否在控制組限制的產品範圍內，若不在限制內則不允許請購此料 
      CALL s_control_chk_group('3','4',g_user,g_dept,p_pmdn001,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success THEN      #處理狀態  
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET g_errno = 'apm-00265'           #該料件編號不在當前人員和部門的採購控制組限制的產品範圍內！ 
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF

      #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
      CALL s_control_chk_doc('4',g_apmp490_01_input.pmdldocno,p_pmdn001,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success THEN      #處理狀態  
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET g_errno = 'ain-00015'       #輸入的料件的生命週期不在單據別限制範圍內！  
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF 
      
      #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
      CALL s_control_chk_doc('5',g_apmp490_01_input.pmdldocno,p_pmdn001,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success THEN      #處理狀態  
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF

   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 反向選取
# Memo...........:
# Usage..........: CALL apmp490_01_change_sel()
# Date & Author..: 2014/06/17 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_change_sel()
   DEFINE l_i     LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   FOR l_i = 1 TO g_pmdb_d.getLength()
      IF g_pmdb_d[l_i].sel_01 = 'Y' THEN
         LET g_pmdb_d[l_i].sel_01 = 'N'
      ELSE
         LET g_pmdb_d[l_i].sel_01 = 'Y'
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 進入單身選取資料
# Memo...........:
# Usage..........: CALL apmp490_01_data_check()
# Date & Author..: 2014/06/17 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_data_check()
   DEFINE l_ac1     LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   INPUT ARRAY g_pmdb_d FROM s_apmp490_01_detail1.*
         ATTRIBUTE(COUNT = g_d_cnt_p49001,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = FALSE,
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
      BEFORE INPUT

      BEFORE ROW
         LET l_ac1 = ARR_CURR()

      ON CHANGE sel_01
         DISPLAY BY NAME g_pmdb_d[l_ac1].pmdbent_01

      ON ACTION CLOSE
         EXIT INPUT

      ON ACTION EXIT
         EXIT INPUT
   END INPUT
END FUNCTION

################################################################################
# Descriptions...: 請購底稿資料檢視
# Memo...........:
# Usage..........: CALL apmp490_01_b_fill_tmp(p_wc)
# Input parameter: p_wc
# Date & Author..: 2014/06/17 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_b_fill_tmp(p_wc)
   DEFINE p_wc     STRING
   DEFINE l_sql    STRING
   DEFINE l_cnt    LIKE type_t.num5 
   DEFINE l_oofa001     LIKE oofa_t.oofa001
   DEFINE l_success     LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   IF cl_null(p_wc) THEN
      LET p_wc = ' 1=1'
   END IF

   LET l_sql = "SELECT 'N',pmdbdocno,pmdbseq,pmdb004, ",
               "       (SELECT imaal003 FROM imaal_t ",
               "         WHERE imaalent = '",g_enterprise,"' ",
               "           AND imaal001 = pmdb004 ",
               "           AND imaal002 = '",g_dlang,"'), ",
               "       (SELECT imaal004 FROM imaal_t ",
               "        WHERE imaalent = '",g_enterprise,"' ",
               "          AND imaal001 = pmdb004 ",
               "          AND imaal002 = '",g_dlang,"'),pmdb005,'',pmdb007,pmdb006, ",
               "       qty,pmdb030,pmdb033,pmdb014,pmdb015,pmda024,'','',pmda025,'','', ", 
               "       pmdb053,'', ",
               "       pmdb034,(SELECT pjbal003 FROM pjbal_t ",
               "                 WHERE pjbalent = '",g_enterprise,"' ",
               "                   AND pjbal001 = pmdb034 ",
               "                   AND pjbal002 = '",g_dlang,"'), ",
               "       pmdb035,(SELECT pjbbl004 FROM pjbbl_t ",
               "                 WHERE pjbblent = '",g_enterprise,"' ",
               "                   AND pjbbl001 = pmdb034 ",
               "                   AND pjbbl002 = pmdb035 ",
               "                   AND pjbbl003 = '",g_dlang,"'), ",
               "       pmdb036,(SELECT pjbml004 FROM pjbml_t ",
               "                 WHERE pjbmlent = '",g_enterprise,"' ",
               "                   AND pjbml001 = pmdb034 ",
               "                   AND pjbml002 = pmdb036 ",
               "                   AND pjbml003 = '",g_dlang,"'), ",
               #160801-00004#3--s
               "       pmdb038,",
               "      (SELECT inayl003 FROM inayl_t WHERE inaylent = '",g_enterprise,"' AND inayl001 = pmdb038 AND inayl002 = '",g_dlang,"'),",
               "       pmdb039,",
               "      (SELECT inab003 FROM inab_t WHERE inabent = '",g_enterprise,"' AND inabsite = '",g_site,"' AND inab001 = pmdb038 AND inab002 = pmdb039),",
               "      pmdb054,",
               #161031-00025#6-s-mod
#               "       pmdb050,pmdbent,pmdbsite ",
               "       pmdb050,ooff013,ooff014,pmdbent,pmdbsite ",
               #161031-00025#6-e-mod
               "  FROM p490_01_pmdb_t ",
               " WHERE ",p_wc
   PREPARE p490_01_tmp_prep FROM l_sql
   DECLARE p490_01_tmp_curs CURSOR FOR p490_01_tmp_prep

   CALL g_pmdb_d.clear()

   LET l_cnt = 1
   FOREACH p490_01_tmp_curs INTO g_pmdb_d[l_cnt].*
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #161220-00010#1 add  --begin--
      #送貨地址
      IF cl_null(g_pmdb_d[l_cnt].pmda024_01) THEN
         CALL apmp490_01_get_pmdl025_pmdl026('3') RETURNING g_pmdb_d[l_cnt].pmda024_01
      END IF
      #161220-00010#1 add  --end--
                    
      #送貨地址 
      IF NOT cl_null(g_pmdb_d[l_cnt].pmda024_01) THEN
         CALL s_apmp490_get_address('3',g_pmdb_d[l_cnt].pmda024_01)
              RETURNING g_pmdb_d[l_cnt].pmda024_01_desc,g_pmdb_d[l_cnt].pmda024_01_oofb017
      END IF
      
      #161220-00010#1 add  --begin--
      #帳款地址      
      IF cl_null(g_pmdb_d[l_cnt].pmda025_01) THEN
         CALL apmp490_01_get_pmdl025_pmdl026('5') RETURNING g_pmdb_d[l_cnt].pmda025_01
      END IF
      #161220-00010#1 add  --end--


      #帳款地址 
      IF NOT cl_null(g_pmdb_d[l_cnt].pmda025_01) THEN
         CALL s_apmp490_get_address('5',g_pmdb_d[l_cnt].pmda025_01)
              RETURNING g_pmdb_d[l_cnt].pmda025_01_desc,g_pmdb_d[l_cnt].pmda025_01_oofb017
      END IF

      LET l_cnt = l_cnt + 1

      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_pmdb_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
END FUNCTION

################################################################################
# Descriptions...: 刪除請購底稿資料
# Memo...........:
# Usage..........: CALL apmp490_01_del_tmp()
# Date & Author..: 2014/06/17 By ming
# Modify.........: #160105-00013#1 2016/01/05 by ming 不再lock請購單頭，註解相關程式碼
################################################################################
PUBLIC FUNCTION apmp490_01_del_tmp()
   DEFINE l_i     LIKE type_t.num5 
   DEFINE l_cnt   LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   FOR l_i = 1 TO g_pmdb_d.getLength()
      IF g_pmdb_d[l_i].sel_01 = 'Y' THEN
         DELETE FROM p490_01_pmdb_t
          WHERE pmdbdocno = g_pmdb_d[l_i].pmdbdocno_01
            AND pmdbseq   = g_pmdb_d[l_i].pmdbseq_01
            AND pmdb004   = g_pmdb_d[l_i].pmdb004_01
            AND pmdb005   = g_pmdb_d[l_i].pmdb005_01
            AND pmdb007   = g_pmdb_d[l_i].pmdb007_01
            AND pmdb006   = g_pmdb_d[l_i].pmdb006_01
            AND pmdb030   = g_pmdb_d[l_i].pmdb030_01
            AND pmdb033   = g_pmdb_d[l_i].pmdb033_01 
      
         DELETE FROM p490_lock_t  #160727-00019#11   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 p490_01_lock_b_t ——> p490_lock_t
          WHERE pmdbdocno = g_pmdb_d[l_i].pmdbdocno_01
            AND pmdbseq   = g_pmdb_d[l_i].pmdbseq_01

         #160105-00013#1 20160105 mark by ming -----(S) 
         #不再lock請購單頭，所以此段已無用 
         #LET l_cnt = 0
         #SELECT COUNT(*) INTO l_cnt
         #  FROM p490_01_lock_b_t
         # WHERE pmdbdocno = g_pmdb_d[l_i].pmdbdocno_01
         #IF cl_null(l_cnt) OR l_cnt = 0 THEN
         #   DELETE FROM p490_01_lock_h_t
         #    WHERE pmdadocno = g_pmdb_d[l_i].pmdbdocno_01
         #END IF
         #160105-00013#1 20160105 mark by ming -----(E) 
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 執行全選或全不選功能
# Memo...........:
# Usage..........: CALL apmp490_01_sel_all(p_flag)
# Input parameter: p_flag：Y(全選)/N(全不選
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_sel_all(p_flag)
   DEFINE p_flag  LIKE type_t.chr1 
   DEFINE l_i     LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   FOR l_i = 1 TO g_pmdb_d.getLength()
      LET g_pmdb_d[l_i].sel_01 = p_flag 
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 設定右方button的顯示與隱藏
# Memo...........:
# Usage..........: CALL apmp490_01_set_act_visible(p_mode)
# Input parameter: p_mode：i(輸入)/d(檢視底稿)
# Date & Author..: 2014/06/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmp490_01_set_act_visible(p_mode)
  DEFINE p_mode     LIKE type_t.chr1 
  
  WHENEVER ERROR CONTINUE 
  
  CALL cl_set_comp_visible("sel_all",FALSE) 
  CALL cl_set_comp_visible("change_sel",FALSE) 
  CALL cl_set_comp_visible("see_pmdb_tmp",FALSE) 
  CALL cl_set_comp_visible("del_pmdb_tmp",FALSE) 
  CALL cl_set_comp_visible("sel_mode",FALSE) 
  
  CASE p_mode 
     WHEN 'i' 
        CALL cl_set_comp_visible("sel_all",TRUE)
        CALL cl_set_comp_visible("nosel_all",TRUE)
        CALL cl_set_comp_visible("change_sel",TRUE)
        CALL cl_set_comp_visible("see_pmdb_tmp",TRUE)
     WHEN 'd'  
        #檢視底稿模式，也要加入全選/全不選 
        CALL cl_set_comp_visible("sel_all",TRUE)
        CALL cl_set_comp_visible("nosel_all",TRUE)
        CALL cl_set_comp_visible("del_pmdb_tmp",TRUE)
        CALL cl_set_comp_visible("sel_mode",TRUE)
  END  CASE 
END FUNCTION

################################################################################
# Descriptions...: 取得料件的品名 規格
# Memo...........:
# Usage..........: CALL apmp490_01_get_imaal(p_imaal001)
#                  RETURNING r_imaal003,r_imaal004
# Input parameter: p_imaal001：料號 
# Return code....: r_imaal003：品名
#                : r_imaal004：規格
# Date & Author..: 2014/06/21 By ming
# Modify.........: 2015/12/21 By ming 本次無修改，但先前為了加速執行速度 
#                                     已經把多語言的資料抓取移到了主SQL中 
#                                     所以此function已無實質效果
################################################################################
PUBLIC FUNCTION apmp490_01_get_imaal(p_imaal001)
   DEFINE p_imaal001     LIKE imaal_t.imaal001
   DEFINE r_imaal003     LIKE imaal_t.imaal003
   DEFINE r_imaal004     LIKE imaal_t.imaal004

   WHENEVER ERROR CONTINUE 

   LET r_imaal003 = ''
   LET r_imaal004 = ''

   #取得料件的品名 規格 
   SELECT imaal003,imaal004 INTO r_imaal003,r_imaal004
     FROM imaal_t
    WHERE imaalent = g_enterprise
      AND imaal001 = p_imaal001
      AND imaal002 = g_dlang 

   RETURN r_imaal003,r_imaal004
END FUNCTION

################################################################################
# Descriptions...: 科目預算的處理
# Memo...........:
# Usage..........: CALL apmp490_01_detail_abg(p_pmdadocno,p_pmdbseq,p_type)
#                  RETURNING r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
# Input parameter: p_pmdadocno    單號 
#                  p_pmdbseq      項次 
#                : p_type         1.預算項目開窗
#                                 2.預算項目檢核
#                                 3.預算項目說明
#                                 4.檢核金額
# Return code....: r_success      TRUE/FALSE
#                : r_errno        錯誤訊息
#                : r_bgaf016      錯誤處理方式
#                : r_bgae001      預算項目
#                : r_bgae001_desc 說明
# Date & Author..: 2015/09/07 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp490_01_detail_abg(p_pmdadocno,p_pmdbseq,p_type)
   DEFINE p_pmdadocno    LIKE pmda_t.pmdadocno
   DEFINE p_pmdbseq      LIKE pmdb_t.pmdbseq
   DEFINE p_type         LIKE type_t.chr10
   DEFINE r_success      LIKE type_t.num5
   DEFINE r_errno        LIKE gzze_t.gzze001
   DEFINE r_bgaf016      LIKE bgaf_t.bgaf016
   DEFINE r_bgae001      LIKE bgae_t.bgae001
   DEFINE r_bgae001_desc LIKE type_t.chr80
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_slip         LIKE pmda_t.pmdadocno
   DEFINE l_imaa009      LIKE imaa_t.imaa009
   DEFINE l_tran         RECORD
                            act              LIKE type_t.chr10,   #[1].chr 動作
                            site             LIKE ooef_t.ooef001, #[2].chr 預算組織
                            dat              LIKE type_t.dat,     #[3].dat 日期
                            bgae001          LIKE bgae_t.bgae001, #[4].chr 預算項目
                            bgbd013          LIKE bgbd_t.bgbd013, #[5].chr 部門
                            bgbd014          LIKE bgbd_t.bgbd014, #[6].chr 利潤成本中心
                            bgbd015          LIKE bgbd_t.bgbd015, #[7].chr 區域
                            bgbd016          LIKE bgbd_t.bgbd016, #[8].chr 交易客商
                            bgbd017          LIKE bgbd_t.bgbd017, #[9].chr 收款客商
                            bgbd018          LIKE bgbd_t.bgbd018, #[10].chr 客群
                            bgbd019          LIKE bgbd_t.bgbd019, #[11].chr 產品類別
                            bgbd020          LIKE bgbd_t.bgbd020, #[12].chr 人員
                            bgbd021          LIKE bgbd_t.bgbd021, #[13].chr 專案
                            bgbd022          LIKE bgbd_t.bgbd022, #[14].chr WBS
                            bgbd023          LIKE bgbd_t.bgbd023, #[15].chr 經營方式
                            bgbd024          LIKE bgbd_t.bgbd024, #[16].chr 自由核算項一
                            bgbd025          LIKE bgbd_t.bgbd025, #[17].chr 自由核算項二
                            bgbd026          LIKE bgbd_t.bgbd026, #[18].chr 自由核算項三 
                            bgbd027          LIKE bgbd_t.bgbd027, #[19].chr 自由核算項四
                            bgbd028          LIKE bgbd_t.bgbd028, #[20].chr 自由核算項五
                            bgbd029          LIKE bgbd_t.bgbd029, #[21].chr 自由核算項六
                            bgbd030          LIKE bgbd_t.bgbd030, #[22].chr 自由核算項七
                            bgbd031          LIKE bgbd_t.bgbd031, #[23].chr 自由核算項八
                            bgbd032          LIKE bgbd_t.bgbd032, #[24].chr 自由核算項九
                            bgbd033          LIKE bgbd_t.bgbd033, #[25].chr 自由核算項十
                            bgbd042          LIKE bgbd_t.bgbd042, #[26].chr 渠道
                            bgbd043          LIKE bgbd_t.bgbd043, #[27].chr 品牌
                            used036          LIKE bgbd_t.bgbd036, #[28].chr 使用程式
                            used037          LIKE bgbd_t.bgbd037, #[29].chr 使用單號 
                            used038          LIKE bgbd_t.bgbd038, #[30].chr 使用項次
                            sour036          LIKE bgbd_t.bgbd036, #[31].chr 轉出程式
                            sour037          LIKE bgbd_t.bgbd037, #[32].chr 轉出單號
                            sour038          LIKE bgbd_t.bgbd038, #[33].chr 轉出項次
                            curr             LIKE ooai_t.ooai001, #[34].chr 幣別
                            account          LIKE type_t.num20_6 #[35].chr 金額
                         END RECORD
   DEFINE ls_js          STRING
   #161124-00048#8 mod-S
#   DEFINE l_pmda         RECORD LIKE pmda_t.*
#   DEFINE l_pmdb         RECORD LIKE pmdb_t.*
   DEFINE l_pmda RECORD  #請購單單頭頭檔
          pmdaent LIKE pmda_t.pmdaent, #企业编号
          pmdaownid LIKE pmda_t.pmdaownid, #资料所有者
          pmdaowndp LIKE pmda_t.pmdaowndp, #资料所有部门
          pmdacrtid LIKE pmda_t.pmdacrtid, #资料录入者
          pmdacrtdp LIKE pmda_t.pmdacrtdp, #资料录入部门
          pmdacrtdt LIKE pmda_t.pmdacrtdt, #资料创建日
          pmdamodid LIKE pmda_t.pmdamodid, #资料更改者
          pmdamoddt LIKE pmda_t.pmdamoddt, #最近更改日
          pmdacnfid LIKE pmda_t.pmdacnfid, #资料审核者
          pmdacnfdt LIKE pmda_t.pmdacnfdt, #数据审核日
          pmdapstid LIKE pmda_t.pmdapstid, #资料过账者
          pmdapstdt LIKE pmda_t.pmdapstdt, #资料过账日
          pmdastus LIKE pmda_t.pmdastus, #状态码
          pmdasite LIKE pmda_t.pmdasite, #营运据点
          pmdadocno LIKE pmda_t.pmdadocno, #请购单号
          pmdadocdt LIKE pmda_t.pmdadocdt, #请购日期
          pmda001 LIKE pmda_t.pmda001, #版次
          pmda002 LIKE pmda_t.pmda002, #请购人员
          pmda003 LIKE pmda_t.pmda003, #请购部门
          pmda004 LIKE pmda_t.pmda004, #单价为必要录入
          pmda005 LIKE pmda_t.pmda005, #币种
          pmda006 LIKE pmda_t.pmda006, #No Use
          pmda007 LIKE pmda_t.pmda007, #费用部门
          pmda008 LIKE pmda_t.pmda008, #请购总税前金额
          pmda009 LIKE pmda_t.pmda009, #请购总含税金额
          pmda010 LIKE pmda_t.pmda010, #税种
          pmda011 LIKE pmda_t.pmda011, #税率
          pmda012 LIKE pmda_t.pmda012, #单价含税否
          pmda020 LIKE pmda_t.pmda020, #纳入APS计算
          pmda021 LIKE pmda_t.pmda021, #运送方式
          pmda022 LIKE pmda_t.pmda022, #备注
          pmda200 LIKE pmda_t.pmda200, #来源类型
          pmda201 LIKE pmda_t.pmda201, #采购方式
          pmda202 LIKE pmda_t.pmda202, #所属品类
          pmda203 LIKE pmda_t.pmda203, #需求组织
          pmda204 LIKE pmda_t.pmda204, #采购中心
          pmda205 LIKE pmda_t.pmda205, #配送中心
          pmda206 LIKE pmda_t.pmda206, #配送仓
          pmda207 LIKE pmda_t.pmda207, #到货日期
          pmda208 LIKE pmda_t.pmda208, #包装总数量
          pmda900 LIKE pmda_t.pmda900, #保留字段str
          pmda999 LIKE pmda_t.pmda999, #保留字段end
          pmda023 LIKE pmda_t.pmda023, #留置原因
          pmda024 LIKE pmda_t.pmda024, #送货地址
          pmda025 LIKE pmda_t.pmda025, #账款地址
          pmda209 LIKE pmda_t.pmda209, #包装总金额
          pmda210 LIKE pmda_t.pmda210, #品种数
          pmda211 LIKE pmda_t.pmda211, #需求时间
          pmda027 LIKE pmda_t.pmda027, #前端单号
          pmda028 LIKE pmda_t.pmda028  #前端类型
   END RECORD
   DEFINE l_pmdb RECORD  #請購單明細檔
          pmdbent LIKE pmdb_t.pmdbent, #企业编号
          pmdbsite LIKE pmdb_t.pmdbsite, #营运据点
          pmdbdocno LIKE pmdb_t.pmdbdocno, #请购单号
          pmdbseq LIKE pmdb_t.pmdbseq, #项次
          pmdb001 LIKE pmdb_t.pmdb001, #来源单号
          pmdb002 LIKE pmdb_t.pmdb002, #来源项次
          pmdb003 LIKE pmdb_t.pmdb003, #来源项序
          pmdb004 LIKE pmdb_t.pmdb004, #料件编号
          pmdb005 LIKE pmdb_t.pmdb005, #产品特征
          pmdb006 LIKE pmdb_t.pmdb006, #需求数量
          pmdb007 LIKE pmdb_t.pmdb007, #单位
          pmdb008 LIKE pmdb_t.pmdb008, #参考数量
          pmdb009 LIKE pmdb_t.pmdb009, #参考单位
          pmdb010 LIKE pmdb_t.pmdb010, #计价数量
          pmdb011 LIKE pmdb_t.pmdb011, #计价单位
          pmdb012 LIKE pmdb_t.pmdb012, #包装容器
          pmdb014 LIKE pmdb_t.pmdb014, #供应商选择
          pmdb015 LIKE pmdb_t.pmdb015, #供应商编号
          pmdb016 LIKE pmdb_t.pmdb016, #付款条件
          pmdb017 LIKE pmdb_t.pmdb017, #交易条件
          pmdb018 LIKE pmdb_t.pmdb018, #税率
          pmdb019 LIKE pmdb_t.pmdb019, #参考单价
          pmdb020 LIKE pmdb_t.pmdb020, #参考税前金额
          pmdb021 LIKE pmdb_t.pmdb021, #参考含税金额
          pmdb030 LIKE pmdb_t.pmdb030, #需求日期
          pmdb031 LIKE pmdb_t.pmdb031, #理由码
          pmdb032 LIKE pmdb_t.pmdb032, #行状态
          pmdb033 LIKE pmdb_t.pmdb033, #紧急度
          pmdb034 LIKE pmdb_t.pmdb034, #项目编号
          pmdb035 LIKE pmdb_t.pmdb035, #WBS
          pmdb036 LIKE pmdb_t.pmdb036, #活动编号
          pmdb037 LIKE pmdb_t.pmdb037, #收货据点
          pmdb038 LIKE pmdb_t.pmdb038, #收货库位
          pmdb039 LIKE pmdb_t.pmdb039, #收货储位
          pmdb040 LIKE pmdb_t.pmdb040, #no use
          pmdb041 LIKE pmdb_t.pmdb041, #允许部份交货
          pmdb042 LIKE pmdb_t.pmdb042, #允许提前交货
          pmdb043 LIKE pmdb_t.pmdb043, #保税
          pmdb044 LIKE pmdb_t.pmdb044, #纳入APS
          pmdb045 LIKE pmdb_t.pmdb045, #交期冻结否
          pmdb046 LIKE pmdb_t.pmdb046, #费用部门
          pmdb048 LIKE pmdb_t.pmdb048, #收货时段
          pmdb049 LIKE pmdb_t.pmdb049, #已转采购量
          pmdb050 LIKE pmdb_t.pmdb050, #备注
          pmdb051 LIKE pmdb_t.pmdb051, #结案/留置理由码
          pmdb200 LIKE pmdb_t.pmdb200, #商品条码
          pmdb201 LIKE pmdb_t.pmdb201, #包装单位
          pmdb202 LIKE pmdb_t.pmdb202, #件装数
          pmdb203 LIKE pmdb_t.pmdb203, #配送中心
          pmdb204 LIKE pmdb_t.pmdb204, #配送仓库
          pmdb205 LIKE pmdb_t.pmdb205, #采购中心
          pmdb206 LIKE pmdb_t.pmdb206, #采购员
          pmdb207 LIKE pmdb_t.pmdb207, #采购方式
          pmdb208 LIKE pmdb_t.pmdb208, #经营方式
          pmdb209 LIKE pmdb_t.pmdb209, #结算方式
          pmdb210 LIKE pmdb_t.pmdb210, #促销开始日
          pmdb211 LIKE pmdb_t.pmdb211, #促销结束日
          pmdb212 LIKE pmdb_t.pmdb212, #要货件数
          pmdb250 LIKE pmdb_t.pmdb250, #合理库存
          pmdb251 LIKE pmdb_t.pmdb251, #最高库存
          pmdb252 LIKE pmdb_t.pmdb252, #现有库存
          pmdb253 LIKE pmdb_t.pmdb253, #入库在途量
          pmdb254 LIKE pmdb_t.pmdb254, #前一周销量
          pmdb255 LIKE pmdb_t.pmdb255, #前二周销量
          pmdb256 LIKE pmdb_t.pmdb256, #前三周销量
          pmdb257 LIKE pmdb_t.pmdb257, #前四周销量
          pmdb258 LIKE pmdb_t.pmdb258, #要货在途量
          pmdb259 LIKE pmdb_t.pmdb259, #周平均销量
          pmdb900 LIKE pmdb_t.pmdb900, #保留字段str
          pmdb999 LIKE pmdb_t.pmdb999, #保留字段end
          pmdb260 LIKE pmdb_t.pmdb260, #收货部门
          pmdb052 LIKE pmdb_t.pmdb052, #来源分批序
          pmdb227 LIKE pmdb_t.pmdb227, #补货规格说明
          pmdb053 LIKE pmdb_t.pmdb053, #预算细项
          pmdb213 LIKE pmdb_t.pmdb213, #参考进价
          pmdb054 LIKE pmdb_t.pmdb054, #库存管理特征
          pmdb214 LIKE pmdb_t.pmdb214  #需求时间
   END RECORD
   #161124-00048#8 mod-E

   LET r_success      = TRUE
   LET r_errno        = ''
   LET r_bgaf016      = ''
   LET r_bgae001      = ''
   LET r_bgae001_desc = ''

   #161124-00048#8 mod-S
   INITIALIZE l_pmda.* TO NULL 
#   SELECT * INTO l_pmda.*
#     FROM pmda_t
#    WHERE pmdaent   = g_enterprise
#      AND pmdadocno = p_pmdadocno
   SELECT pmdaent,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,
          pmdacrtdt,pmdamodid,pmdamoddt,pmdacnfid,pmdacnfdt,
          pmdapstid,pmdapstdt,pmdastus,pmdasite,pmdadocno,
          pmdadocdt,pmda001,pmda002,pmda003,pmda004,
          pmda005,pmda006,pmda007,pmda008,pmda009,
          pmda010,pmda011,pmda012,pmda020,pmda021,
          pmda022,pmda200,pmda201,pmda202,pmda203,
          pmda204,pmda205,pmda206,pmda207,pmda208,
          pmda900,pmda999,pmda023,pmda024,pmda025,
          pmda209,pmda210,pmda211,pmda027,pmda028
     INTO l_pmda.*
     FROM pmda_t
    WHERE pmdaent   = g_enterprise
      AND pmdadocno = p_pmdadocno
      
   INITIALIZE l_pmdb.* TO NULL
#   SELECT * INTO l_pmdb.*
#     FROM pmdb_t
#    WHERE pmdbent   = g_enterprise
#      AND pmdbdocno = p_pmdadocno
#      AND pmdbseq   = p_pmdbseq
   SELECT pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,
          pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,
          pmdb007,pmdb008,pmdb009,pmdb010,pmdb011,
          pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,
          pmdb018,pmdb019,pmdb020,pmdb021,pmdb030,
          pmdb031,pmdb032,pmdb033,pmdb034,pmdb035,
          pmdb036,pmdb037,pmdb038,pmdb039,pmdb040,
          pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,
          pmdb046,pmdb048,pmdb049,pmdb050,pmdb051,
          pmdb200,pmdb201,pmdb202,pmdb203,pmdb204,
          pmdb205,pmdb206,pmdb207,pmdb208,pmdb209,
          pmdb210,pmdb211,pmdb212,pmdb250,pmdb251,
          pmdb252,pmdb253,pmdb254,pmdb255,pmdb256,
          pmdb257,pmdb258,pmdb259,pmdb900,pmdb999,
          pmdb260,pmdb052,pmdb227,pmdb053,pmdb213,
          pmdb054,pmdb214
     INTO l_pmdb.*
     FROM pmdb_t
    WHERE pmdbent   = g_enterprise
      AND pmdbdocno = p_pmdadocno
      AND pmdbseq   = p_pmdbseq
   #161124-00048#8 mod-E

   CALL s_aooi200_get_slip(p_pmdadocno)
        RETURNING l_success,l_slip
   IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'N' THEN
      RETURN r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
   END IF

   SELECT imaa009 INTO l_imaa009
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = l_pmdb.pmdb004

   INITIALIZE l_tran.* TO NULL
   LET l_tran.site = g_site
   LET l_tran.dat  = l_pmda.pmdadocdt
   LET l_tran.bgae001 = l_pmdb.pmdb053
   LET l_tran.bgbd013 = l_pmda.pmda003
   LET l_tran.bgbd016 = l_pmdb.pmdb015
   LET l_tran.bgbd019 = l_imaa009 
   LET l_tran.bgbd020 = l_pmda.pmda002
   LET l_tran.bgbd021 = l_pmdb.pmdb034
   LET l_tran.bgbd022 = l_pmdb.pmdb035
   LET l_tran.used036 = 'apmt400'
   LET l_tran.used037 = p_pmdadocno
   LET l_tran.used038 = p_pmdbseq
   LET l_tran.curr    = l_pmda.pmda005
   LET l_tran.account = l_pmdb.pmdb020

   LET ls_js = util.JSON.stringify(l_tran)

   #1.預算項目開窗
   #2.預算項目檢核
   #3.預算項目說明
   #4.檢核金額

   CASE p_type
      WHEN '1'
           CALL s_abg_bgae001_query2(ls_js)
                RETURNING r_bgae001

           LET l_tran.bgae001 = r_bgae001
           LET ls_js = util.JSON.stringify(l_tran) 
           CALL s_abg_bgae001_desc2(ls_js)
                RETURNING r_bgae001_desc
      WHEN '2'
           CALL s_abg_bgae001_chk2(ls_js)
                RETURNING r_success,r_errno
           IF r_success THEN
              CALL s_abg_bgae001_desc2(ls_js)
                   RETURNING r_bgae001_desc
           END IF
      WHEN '3'
           CALL s_abg_bgae001_desc2(ls_js)
                RETURNING r_bgae001_desc
      WHEN '4'
           CALL s_abg_bg_used_chk(ls_js)
                RETURNING r_success,r_errno,r_bgaf016
   END CASE

   RETURN r_success,r_errno,r_bgaf016,r_bgae001,r_bgae001_desc
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明:根据据点取得送货地址和账款地址
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
PUBLIC FUNCTION apmp490_01_get_pmdl025_pmdl026(p_oofb008)
DEFINE p_oofb008         LIKE oofb_t.oofb008
DEFINE l_oofa001         LIKE oofa_t.oofa001
DEFINE l_oofb001         LIKE oofb_t.oofb001
DEFINE l_oofb019         LIKE oofb_t.oofb019
   
   SELECT oofa001 INTO l_oofa001 FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa002 = '1'
      AND oofa003 = g_site
   #先抓主要地址
   SELECT oofb001,oofb019 INTO l_oofb001,l_oofb019 FROM  oofb_t   
    WHERE oofbent = g_enterprise 
      AND oofb002 = l_oofa001 AND oofb008 = p_oofb008
      AND oofb010 = 'Y' AND oofbstus = 'Y'
   #抓不到就抓第一笔
   IF cl_null(l_oofb001) THEN
      DECLARE apmp490_01_get_pmdl025_pmdl026_cs CURSOR FOR
         SELECT oofb001,oofb019
           FROM oofb_t
          WHERE oofbent = g_enterprise
            AND oofb002 = l_oofa001
            AND oofb008 = p_oofb008   #聯絡地址
            AND oofbstus = 'Y'  #有效資料
          ORDER BY oofb001
      FOREACH apmp490_01_get_pmdl025_pmdl026_cs INTO l_oofb001,l_oofb019
         IF NOT cl_null(l_oofb001) THEN
            EXIT FOREACH
         END IF
      END FOREACH
   END IF
   
   RETURN l_oofb019
END FUNCTION

 
{</section>}
 
