#該程式未解開Section, 採用最新樣板產出!
{<section id="adbt201.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2015-05-06 12:52:58), PR版次:0021(2016-12-15 15:58:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000303
#+ Filename...: adbt201
#+ Description: 經銷商網點准入及變更維護作業
#+ Creator....: 01752(2014-03-05 00:00:00)
#+ Modifier...: 06815 -SD/PR- 00700
 
{</section>}
 
{<section id="adbt201.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#36  2016/04/19 BY pengxin     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160818-00017#6   2016/08/24 by 08172       修改删除时重新检查状态
#160908-00032#1   2016/09/08 by rainy       網點開窗q_pmaa001()改為 q_pmaa001_18()
#161108-00027#1   2016/11/08 By lori        調整g_browser_cnt長度變數定義為num10
#161117-00022#1   2016/11/18 By lori        筆數相關變數型態定義改為NUM10
#161122-00006#1   2016/11/22 by sakura      單據狀態,作廢應置於最後
#161215-00045#1   2016/12/15 By Rainy      browser_fill()增加呼叫權限過濾器lib
IMPORT util
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
#嵌入
IMPORT FGL aoo_aooi350_01
IMPORT FGL aoo_aooi350_02
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 TYPE type_g_pmba_m RECORD
   pmba095 LIKE pmba_t.pmba095,
   pmba095_desc LIKE type_t.chr80,
   pmba000 LIKE pmba_t.pmba000,
   pmbadocdt LIKE pmba_t.pmbadocdt,
   pmbadocno LIKE pmba_t.pmbadocno,
   pmba001 LIKE pmba_t.pmba001,
   pmbaacti LIKE pmba_t.pmbaacti,
   pmbal003 LIKE pmbal_t.pmbal003,
   pmbal002 LIKE pmbal_t.pmbal002,
   pmbal004 LIKE pmbal_t.pmbal004,
   pmba005 LIKE pmba_t.pmba005,
   pmba005_desc LIKE type_t.chr80,
   pmba006 LIKE pmba_t.pmba006,
   pmba006_desc LIKE type_t.chr80,
   pmba090 LIKE pmba_t.pmba090,
   pmba090_desc LIKE type_t.chr80,
   pmba026 LIKE pmba_t.pmba026,
   pmba026_desc LIKE type_t.chr80,
   pmba221 LIKE pmba_t.pmba221,
   pmba221_desc LIKE type_t.chr80,
   pmba232 LIKE pmba_t.pmba232,
   pmba232_desc LIKE type_t.chr80,
   pmba200 LIKE pmba_t.pmba200,
   pmba201 LIKE pmba_t.pmba201,
   pmba027 LIKE pmba_t.pmba027,
   pmba002 LIKE pmba_t.pmba002,
   pmba230 LIKE pmba_t.pmba230,
   pmba004 LIKE pmba_t.pmba004,
   pmba241 LIKE pmba_t.pmba241,
   pmba241_desc LIKE type_t.chr80,
   pmba242 LIKE pmba_t.pmba242,
   pmba242_desc LIKE type_t.chr80,
   pmba243 LIKE pmba_t.pmba243,
   pmba243_desc LIKE type_t.chr80,
   pmba244 LIKE pmba_t.pmba244,
   pmba244_desc LIKE type_t.chr80,
   pmbastus LIKE pmba_t.pmbastus,
   pmbaownid LIKE pmba_t.pmbaownid,
   pmbaownid_desc LIKE type_t.chr80,
   pmbaowndp LIKE pmba_t.pmbaowndp,
   pmbaowndp_desc LIKE type_t.chr80,
   pmbacrtid LIKE pmba_t.pmbacrtid,
   pmbacrtid_desc LIKE type_t.chr80,
   pmbacrtdp LIKE pmba_t.pmbacrtdp,
   pmbacrtdp_desc LIKE type_t.chr80,
   pmbacrtdt DATETIME YEAR TO SECOND,
   pmbamodid LIKE pmba_t.pmbamodid,
   pmbamodid_desc LIKE type_t.chr80,
   pmbamoddt DATETIME YEAR TO SECOND,
   pmbacnfid LIKE pmba_t.pmbacnfid,
   pmbacnfid_desc LIKE type_t.chr80,
   pmbacnfdt DATETIME YEAR TO SECOND,
   pmba017 LIKE pmba_t.pmba017,
   pmba016 LIKE pmba_t.pmba016,
   pmba018 LIKE pmba_t.pmba018,
   pmba019 LIKE pmba_t.pmba019,
   pmba019_desc LIKE type_t.chr80,
   pmba021 LIKE pmba_t.pmba021,
   pmba022 LIKE pmba_t.pmba022,
   pmba022_desc LIKE type_t.chr80,
   pmba020 LIKE pmba_t.pmba020,
   ooff013 LIKE ooff_t.ooff013,
   pmba291 LIKE pmba_t.pmba291,
   pmba291_desc LIKE type_t.chr80,
   pmba292 LIKE pmba_t.pmba292,
   pmba292_desc LIKE type_t.chr80,
   pmba293 LIKE pmba_t.pmba293,
   pmba293_desc LIKE type_t.chr80,
   pmba294 LIKE pmba_t.pmba294,
   pmba294_desc LIKE type_t.chr80,
   pmba295 LIKE pmba_t.pmba295,
   pmba295_desc LIKE type_t.chr80,
   pmba296 LIKE pmba_t.pmba296,
   pmba296_desc LIKE type_t.chr80,
   pmba297 LIKE pmba_t.pmba297,
   pmba297_desc LIKE type_t.chr80,
   pmba298 LIKE pmba_t.pmba298,
   pmba298_desc LIKE type_t.chr80,
   pmba299 LIKE pmba_t.pmba299,
   pmba299_desc LIKE type_t.chr80,
   pmba300 LIKE pmba_t.pmba300,
   pmba300_desc LIKE type_t.chr80
       END RECORD

#模組變數(Module Variables)
DEFINE g_pmba_m        type_g_pmba_m
DEFINE g_pmba_m_t      type_g_pmba_m                #備份舊值
DEFINE g_pmbadocno_t LIKE pmba_t.pmbadocno


DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位
   b_statepic                 LIKE type_t.chr50,
   b_pmba095                  LIKE pmba_t.pmba095,
   b_pmba095_desc             LIKE type_t.chr80,
   b_pmba000                  LIKE pmba_t.pmba000,
   b_pmbadocdt                LIKE pmba_t.pmbadocdt,
   b_pmbadocno                LIKE pmba_t.pmbadocno,
   b_pmba001                  LIKE pmba_t.pmba001,
   b_pmbadocno_desc           LIKE type_t.chr80,
   b_pmbadocno_desc_desc      LIKE type_t.chr80,
   b_pmbadocno_desc_desc_desc LIKE type_t.chr80
   #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_master_multi_table_t    RECORD
      pmbaldocno LIKE pmbal_t.pmbaldocno,
      pmbal003 LIKE pmbal_t.pmbal003,
      pmbal002 LIKE pmbal_t.pmbal002,
      pmbal004 LIKE pmbal_t.pmbal004
      END RECORD

DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING                        #組 sql 用
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數              #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT   #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數          #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_aw                  STRING             #確定當下點擊的單身

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num10  #Browser 所在筆數(當下page)   #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_current_row         LIKE type_t.num10  #Browser 所在筆數(暫存用)     #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)     #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_browser_idx         LIKE type_t.num5   #Browser 所在筆數(所有資料)   #161117-00022#1 161118 by lori mod:num5 to num10
#DEFINE g_browser_cnt         LIKE type_t.num5   #Browser 總筆數(所有資料)    #161108-00027#1 161108 by lori mark
DEFINE g_browser_cnt         LIKE type_t.num10  #Browser 總筆數(所有資料)     #161108-00027#1 161108 by lori add
DEFINE g_tmp_page            LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_chk                 BOOLEAN
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_pmba_m_o      type_g_pmba_m
DEFINE g_ooef004       LIKE ooef_t.ooef004
DEFINE g_ooef005       LIKE ooef_t.ooef005
GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
   DEFINE g_wc2_i35002      STRING             #通訊方式QBE條件
   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #通訊方式所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #通訊方式總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   
#ken---add---s 需求單號：150107-00009 項次：4
 TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus,
   oofb001 LIKE oofb_t.oofb001,
   oofb019 LIKE oofb_t.oofb019,
   oofb011 LIKE oofb_t.oofb011,
   oofb008 LIKE oofb_t.oofb008,
   oofb009 LIKE oofb_t.oofb009,
   oofb009_desc LIKE type_t.chr500,
   oofb010 LIKE oofb_t.oofb010,
   oofb012 LIKE oofb_t.oofb012,
   oofb012_desc LIKE type_t.chr500,
   oofb013 LIKE oofb_t.oofb013,
   oofb014 LIKE oofb_t.oofb014,
   oofb014_desc LIKE type_t.chr500,
   oofb015 LIKE oofb_t.oofb015,
   oofb015_desc LIKE type_t.chr500,
   oofb016 LIKE oofb_t.oofb016,
   oofb016_desc LIKE type_t.chr500,
   oofb017 LIKE oofb_t.oofb017,
   oofb022 LIKE oofb_t.oofb022,
   oofb022_desc LIKE type_t.chr500,
   oofb020 LIKE oofb_t.oofb020,
   oofb021 LIKE oofb_t.oofb021,
   oofb018 LIKE oofb_t.oofb018
       END RECORD
DEFINE g_pmba_d          DYNAMIC ARRAY OF type_g_oofb_d

 TYPE type_g_oofc_d        RECORD
       oofcstus LIKE oofc_t.oofcstus,
   oofc001 LIKE oofc_t.oofc001,
   oofc008 LIKE oofc_t.oofc008,
   oofc009 LIKE oofc_t.oofc009,
   oofc009_desc LIKE type_t.chr500,
   oofc012 LIKE oofc_t.oofc012,
   oofc010 LIKE oofc_t.oofc010,
   oofc014 LIKE oofc_t.oofc014,
   oofc011 LIKE oofc_t.oofc011,
   oofc015 LIKE oofc_t.oofc015,
   oofc013 LIKE oofc_t.oofc013
       END RECORD
DEFINE g_pmba2_d          DYNAMIC ARRAY OF type_g_oofc_d
#ken---add---e  
END GLOBALS
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="adbt201.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309                              
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化 name="main.init"
   #150424-00018#1 150529 add by beckxie---S
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0025')='N' THEN
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00427'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      CALL cl_ap_exitprogram("0")
   END IF
   #150424-00018#1 150529 add by beckxie---E
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT pmba095,'',pmba000,pmbadocdt,pmbadocno,pmba001,pmbaacti,'','','',pmba005,'',pmba006,'',pmba090,'',
                                 pmba026,'', pmba221,'',pmba232,'',pmba200,pmba201,pmba027,pmba004,
                                 pmba241,'',pmba242,'',pmba243,'',pmba244,'',pmbastus,pmbaownid,'',
                                 pmbaowndp,'',pmbacrtid,'',pmbacrtdp,'',pmbacrtdt,pmbamodid,'',pmbamoddt,pmbacnfid,'',
                                 pmbacnfdt,pmba017,pmba016,pmba018, pmba019,'',pmba021,pmba022,'',pmba020,'',pmba291,'',
                                 pmba292,'',pmba293,'',pmba294,'',pmba295, '',pmba296,'',pmba297,'',pmba298,'',pmba299,'',
                                 pmba300,''",
                           "FROM pmba_t WHERE pmbaent= ? AND pmbadocno=? AND pmba002 = '2' AND pmba230 = '2' FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE adbt201_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
                                                            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbt201 WITH FORM cl_ap_formpath("adb",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adbt201_init()
 
      #進入選單 Menu (='N')
      CALL adbt201_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_adbt201
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309                              
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="adbt201.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION adbt201_init()
   #add-point:init段define
             {#ADP版次:1#}
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309             
   #end add-point

   CALL cl_set_combo_scc_part('pmbastus','13','N,X,Y')


   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   #add-point:畫面資料初始化
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL cl_set_combo_scc('pmba000','32') 
   CALL cl_set_combo_scc('b_pmba000','32')
   CALL cl_set_combo_scc('oofb008','9')
   CALL cl_set_combo_scc('oofc008','6')
   
   LET g_ooef004 = ''
   LET g_ooef005 = ''
   SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF  
   
   LET g_errshow = 1
   #嵌入
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_2", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_3", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型
   {#ADP版次:1#}
   #end add-point

   CALL adbt201_default_search()

END FUNCTION

PRIVATE FUNCTION adbt201_ui_dialog()
   {<Local define>}
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
             {#ADP版次:1#}
   #end add-point

   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png")

   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF

   #action default動作
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL adbt201_insert()
            #add-point:ON ACTION insert
                      {#ADP版次:1#}
            #END add-point
         END IF

      #add-point:action default自訂
                {#ADP版次:1#}
      #end add-point
      OTHERWISE

   END CASE



   #add-point:ui_dialog段before dialog
             {#ADP版次:1#}
   #end add-point

   WHILE li_exit = FALSE

      CALL adbt201_browser_fill(g_wc,"")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_pmbadocno = g_pmbadocno_t

               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
 
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_idx = 0 THEN
                  LET g_current_idx = 1
               END IF
               LET g_current_row = g_current_idx  #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont()

               #當每次點任一筆資料都會需要用到
               CALL adbt201_fetch("")


            ON COLLAPSE (g_row_index)
               #樹關閉

         END DISPLAY
         
         SUBDIALOG aoo_aooi350_01.aooi350_01_display
         SUBDIALOG aoo_aooi350_02.aooi350_02_display
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
         BEFORE DIALOG

            CALL cl_navigator_setting(g_current_idx, g_current_cnt)

            #還原為原本指定筆數
            IF g_current_row > 0 THEN
               LET g_current_idx = g_current_row
            END IF

            #當每次點任一筆資料都會需要用到
            IF g_browser_cnt > 0 THEN
               CALL adbt201_fetch("")
            END IF

         ON ACTION statechange
            CALL adbt201_statechange()
            LET g_action_choice="statechange"

         ON ACTION first
            CALL adbt201_fetch("F")
            LET g_current_row = g_current_idx

         ON ACTION next
            CALL adbt201_fetch("N")
            LET g_current_row = g_current_idx

         ON ACTION jump
            CALL adbt201_fetch("/")
            LET g_current_row = g_current_idx

         ON ACTION previous
            CALL adbt201_fetch("P")
            LET g_current_row = g_current_idx

         ON ACTION last
            CALL adbt201_fetch("L")
            #CALL cl_navigator_setting(g_current_idx, g_current_cnt)
            #CALL fgl_set_arr_curr(g_current_idx)
            LET g_current_row = g_current_idx

         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            EXIT DIALOG

         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            EXIT DIALOG

         #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
        ON ACTION controls
           IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               #CALL gfrm_curr.setElementHidden("worksheet_detail",0)   #150414-00003#1 2015/05/06 by s983961 mark
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")              
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               #CALL gfrm_curr.setElementHidden("worksheet_detail",1)   #150414-00003#1 2015/05/06 by s983961 mark
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden
            END IF



         ON ACTION delete
	   
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adbt201_delete()
               #add-point:ON ACTION delete
                         {#ADP版次:1#}
               #160818-00017#6 -s by 08172
               IF g_pmba_m.pmbastus MATCHES "[NDR]" THEN
                  CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
               END IF
               #160818-00017#6 -e by 08172
               #END add-point
            END IF
	   
	   
         ON ACTION insert
	   
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adbt201_insert()
               #add-point:ON ACTION insert
                         {#ADP版次:1#}
               #END add-point
               EXIT DIALOG
            END IF
	   
	   
         ON ACTION modify
	   
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL adbt201_modify()
               #add-point:ON ACTION modify
                         {#ADP版次:1#}
               #160818-00017#6 -s by 08172
               IF g_pmba_m.pmbastus MATCHES "[NDR]" THEN
                  CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
               ELSE
                  CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
               END IF
               #160818-00017#6 -e by 08172
               #END add-point
               EXIT DIALOG
            END IF
	   
	   
         ON ACTION output
	   
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
                         {#ADP版次:1#}
               #END add-point
               EXIT DIALOG
            END IF
	   
	   
         ON ACTION query
	   
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adbt201_query()
               #add-point:ON ACTION query
                         {#ADP版次:1#}
               #END add-point
            END IF
	   
	   
         ON ACTION reproduce
	   
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL adbt201_reproduce()
               #add-point:ON ACTION reproduce
                         {#ADP版次:1#}
               #END add-point
               EXIT DIALOG
            END IF
            
         #ken---add---s 需求單號：150107-00009 項次：4
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_pmba_d)
                  LET g_export_id[1]   = "s_detail1_aooi350_01"
                  LET g_export_node[2] = base.typeInfo.create(g_pmba2_d)
                  LET g_export_id[2]   = "s_detail1_aooi350_02"

                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF            
         #ken---add---e               
        

         ON ACTION modify_pmba001

            LET g_action_choice="modify_pmba001"
            IF cl_auth_chk_act("modify_pmba001") THEN
               #add-point:ON ACTION modify_pmba001
               CALL adbt201_upd_pmba001()        {#ADP版次:1#}
               #END add-point
               EXIT DIALOG
            END IF


         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

      END DIALOG

   END WHILE

END FUNCTION

PRIVATE FUNCTION adbt201_browser_fill(p_wc,ps_page_action)
   {<Local define>}
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_sub_sql         STRING
   {</Local define>}
   #add-point:browser_fill段define
             {#ADP版次:1#}
   #end add-point

   CLEAR FORM
   INITIALIZE g_pmba_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "pmbadocno"
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 "
   END IF

   #add-point:browser_fill段wc控制
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()          {#ADP版次:1#}
   #end add-point
   LET g_sql = " SELECT COUNT(DISTINCT pmbadocno) FROM pmba_t ",
               "  LEFT JOIN pmbal_t ON pmbadocno = pmbaldocno AND pmbal001 = '",g_lang,"' ",
               "  LEFT JOIN oofb_t ON oofbent = pmaaent AND pmba027 = oofb002",
               "  LEFT JOIN oofc_t ON oofcent = pmaaent AND pmba027 = oofc002",
               " WHERE pmbaent = '" ||g_enterprise|| "' AND pmba002 = '2' AND pmba230 = '2' AND ",
               p_wc CLIPPED
               , cl_sql_add_filter("pmba_t")   #161215-00045#1 add by rainy
   #add-point:browser_fill段cnt_sql
             {#ADP版次:1#}
   #end add-point
				
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre

   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF

      LET g_error_show = 0

   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count

   LET g_wc = p_wc
   #LET g_page_action = ps_page_action          # Keep Action

   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF

   CASE ps_page_action

      WHEN "F"
         LET g_pagestart = 1

      WHEN "P"
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE

      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-998'
            LET g_errparam.extend = g_jump
            LET g_errparam.popup = FALSE
            CALL cl_err()

         END IF

      OTHERWISE

   END CASE
   LET l_sql_rank = "SELECT DISTINCT pmbastus,pmba095,'',pmba000,pmbadocdt,pmbadocno,pmba001,'','','',",
                    "       '',RANK() OVER(ORDER BY pmbadocno ",g_order,") AS RANK ",
                    " FROM pmba_t ",
                    " LEFT JOIN pmbal_t ON pmbadocno = pmbaldocno AND pmbal001 = '",g_lang,"' ",
                    " LEFT JOIN oofb_t ON oofbent = pmbaent AND pmba027 = oofb002", 
                    " LEFT JOIN oofc_t ON oofcent = pmbaent AND pmba027 = oofc002", 
                    " WHERE pmbaent = '" ||g_enterprise|| "' AND pmba002 = '2' AND pmba230 = '2' AND ", g_wc
                    , cl_sql_add_filter("pmba_t")   #161215-00045#1 add by rainy
   #add-point:browser_fill段before_pre
             {#ADP版次:1#}
   #end add-point					
					
   #定義翻頁CURSOR
   LET g_sql= " SELECT pmbastus,pmba095,'',pmba000,pmbadocdt,pmbadocno,pmba001,'','',''",
              "   FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) ,
              "  ORDER BY ",l_searchcol," ",g_order

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmba095,g_browser[g_cnt].b_pmba095_desc,
                           g_browser[g_cnt].b_pmba000,g_browser[g_cnt].b_pmbadocdt,g_browser[g_cnt].b_pmbadocno,
                           g_browser[g_cnt].b_pmba001,g_browser[g_cnt].b_pmbadocno_desc,g_browser[g_cnt].b_pmbadocno_desc_desc,
                           g_browser[g_cnt].b_pmbadocno_desc_desc_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmba095
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmba095_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmba095_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmbadocno
      CALL ap_ref_array2(g_ref_fields,"SELECT pmbal003 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno=? AND pmbal001='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmbadocno_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmbadocno_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmbadocno
      CALL ap_ref_array2(g_ref_fields,"SELECT pmbal002 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno=? AND pmbal001='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmbadocno_desc_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmbadocno_desc_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_pmbadocno
      CALL ap_ref_array2(g_ref_fields,"SELECT pmbal004 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno=? AND pmbal001='"||g_lang||"'",
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_pmbadocno_desc_desc_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_pmbadocno_desc_desc_desc

      #add-point:browser_fill段reference
                {#ADP版次:1#}
      #end add-point

      #browser段落顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
      END CASE

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_rec_b
   LET g_cnt = 0

   CALL adbt201_fetch("")

   FREE browse_pre

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

END FUNCTION

PRIVATE FUNCTION adbt201_construct()
   {<Local define>}
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING
   {</Local define>}
   #add-point:cs段define
             {#ADP版次:1#}
   #end add-point

   CLEAR FORM
   INITIALIZE g_pmba_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1

   LET g_qryparam.state = "c"

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON pmba095,pmba000,pmbadocdt,pmbadocno,pmba001,pmbaacti,pmbal003,pmbal002,pmbal004,pmba005,
          pmba006,pmba090,pmba026,pmba221,pmba232,pmba200,pmba201,pmba027,pmba004,pmba241,pmba242,pmba243,pmba244,
          pmbastus,pmbaownid,pmbaowndp,pmbacrtid,pmbacrtdp,pmbacrtdt,pmbamodid,pmbamoddt,pmbacnfid,pmbacnfdt,
          pmba017,pmba016,pmba018,pmba019,pmba021,pmba022,pmba020,ooff013,pmba291,pmba292,pmba293,pmba294,pmba295,
          pmba296,pmba297,pmba298,pmba299,pmba300

         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
            #add-point:cs段more_construct
                      {#ADP版次:1#}
            #end add-point

         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<pmbaownid>>----
         #ON ACTION controlp INFIELD pmbaownid
         #   CALL q_common('pmba_t','pmbaownid',TRUE,FALSE,g_pmba_m.pmbaownid) RETURNING ls_return
         #   DISPLAY ls_return TO pmbaownid
         #   NEXT FIELD pmbaownid
         #
         ##----<<pmbaowndp>>----
         #ON ACTION controlp INFIELD pmbaowndp
         #   CALL q_common('pmba_t','pmbaowndp',TRUE,FALSE,g_pmba_m.pmbaowndp) RETURNING ls_return
         #   DISPLAY ls_return TO pmbaowndp
         #   NEXT FIELD pmbaowndp
         #
         ##----<<pmbacrtid>>----
         #ON ACTION controlp INFIELD pmbacrtid
         #   CALL q_common('pmba_t','pmbacrtid',TRUE,FALSE,g_pmba_m.pmbacrtid) RETURNING ls_return
         #   DISPLAY ls_return TO pmbacrtid
         #   NEXT FIELD pmbacrtid
         #
         ##----<<pmbacrtdp>>----
         #ON ACTION controlp INFIELD pmbacrtdp
         #   CALL q_common('pmba_t','pmbacrtdp',TRUE,FALSE,g_pmba_m.pmbacrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO pmbacrtdp
         #   NEXT FIELD pmbacrtdp
         #
         ##----<<pmbamodid>>----
         #ON ACTION controlp INFIELD pmbamodid
         #   CALL q_common('pmba_t','pmbamodid',TRUE,FALSE,g_pmba_m.pmbamodid) RETURNING ls_return
         #   DISPLAY ls_return TO pmbamodid
         #   NEXT FIELD pmbamodid
         #
         ##----<<pmbacnfid>>----
         #ON ACTION controlp INFIELD pmbacnfid
         #   CALL q_common('pmba_t','pmbacnfid',TRUE,FALSE,g_pmba_m.pmbacnfid) RETURNING ls_return
         #   DISPLAY ls_return TO pmbacnfid
         #   NEXT FIELD pmbacnfid
         #
         ##----<<pmaapstid>>----
         ##ON ACTION controlp INFIELD pmaapstid
         ##   CALL q_common('pmba_t','pmaapstid',TRUE,FALSE,g_pmba_m.pmaapstid) RETURNING ls_return
         ##   DISPLAY ls_return TO pmaapstid
         ##   NEXT FIELD pmaapstid

         ##----<<pmbacrtdt>>----
         AFTER FIELD pmbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<pmbamoddt>>----
         AFTER FIELD pmbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<pmbacnfdt>>----
         AFTER FIELD pmbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<pmaapstdt>>----
         #AFTER FIELD pmaapstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)



         #一般欄位
         #---------------------------<  Master  >---------------------------
         #----<<pmba095>>----
         #Ctrlp:construct.c.pmba095
         ON ACTION controlp INFIELD pmba095
            #add-point:ON ACTION controlp INFIELD pmba095
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmbaunit',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba095  #顯示到畫面上
            NEXT FIELD pmba095                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba095
            #add-point:BEFORE FIELD pmba095
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba095

            #add-point:AFTER FIELD pmba095
                      {#ADP版次:1#}
            #END add-point
            
         #----<<pmba000>>----
         #Ctrlp:construct.c.pmba000
         ON ACTION controlp INFIELD pmba000
            #add-point:ON ACTION controlp INFIELD pmba000
            
          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba000
            #add-point:BEFORE FIELD pmba000
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba000

            #add-point:AFTER FIELD pmba000
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbadocdt>>----
         #Ctrlp:construct.c.pmbadocdt
         ON ACTION controlp INFIELD pmbadocdt
            #add-point:ON ACTION controlp INFIELD pmbadocdt
            
          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbadocdt
            #add-point:BEFORE FIELD pmbadocdt
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbadocdt

            #add-point:AFTER FIELD pmbadocdt
                      {#ADP版次:1#}
            #END add-point
            
         #----<<pmbadocno>>----
         #Ctrlp:construct.c.pmbadocdt
         ON ACTION controlp INFIELD pmbadocno
            #add-point:ON ACTION controlp INFIELD pmbadocno
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmbadocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbadocno  #顯示到畫面上
            NEXT FIELD pmbadocno                     #返回原欄位
          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbadocno
            #add-point:BEFORE FIELD pmbadocno
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbadocno

            #add-point:AFTER FIELD pmbadocno
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba001>>----
         #Ctrlp:construct.c.pmba001
         ON ACTION controlp INFIELD pmba001
            #add-point:ON ACTION controlp INFIELD pmba001
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
		   #160908-00032#1 --b  160908 modify by rainy 開窗改為q_pmaa001_18()
			   #LET g_qryparam.where = " pmaa002 ='2' AND pmaa230 = '2'"
            #CALL q_pmaa001()                           #呼叫開窗
            CALL q_pmaa001_18()                           #呼叫開窗
         #160908-00032#1 --e

            DISPLAY g_qryparam.return1 TO pmba001  #顯示到畫面上
            NEXT FIELD pmba001                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba001
            #add-point:BEFORE FIELD pmba001
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba001

            #add-point:AFTER FIELD pmba001
                      {#ADP版次:1#}
            #END add-point


         #----<<pmbal003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbal003
            #add-point:BEFORE FIELD pmbal003
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbal003

            #add-point:AFTER FIELD pmbal003
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmbal003
#         ON ACTION controlp INFIELD pmbal003
            #add-point:ON ACTION controlp INFIELD pmbal003
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbal002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbal002
            #add-point:BEFORE FIELD pmbal002
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbal002

            #add-point:AFTER FIELD pmbal002
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmbal002
#         ON ACTION controlp INFIELD pmbal002
            #add-point:ON ACTION controlp INFIELD pmbal002
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbal004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbal004
            #add-point:BEFORE FIELD pmbal004
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbal004

            #add-point:AFTER FIELD pmbal004
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmbal004
#         ON ACTION controlp INFIELD pmbal004
            #add-point:ON ACTION controlp INFIELD pmbal004
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba005>>----
         #Ctrlp:construct.c.pmba005
         ON ACTION controlp INFIELD pmba005
            #add-point:ON ACTION controlp INFIELD pmba005
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_14()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba005  #顯示到畫面上

            NEXT FIELD pmba005                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba005
            #add-point:BEFORE FIELD pmba005
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba005

            #add-point:AFTER FIELD pmba005
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba006>>----
         #Ctrlp:construct.c.pmba006
         ON ACTION controlp INFIELD pmba006
            #add-point:ON ACTION controlp INFIELD pmba006
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "1" #客戶性質
            LET g_qryparam.arg2 = "2" #客戶經營類別
            CALL q_pmaa001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba006  #顯示到畫面上

            NEXT FIELD pmba006                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba006
            #add-point:BEFORE FIELD pmba006
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba006

            #add-point:AFTER FIELD pmba006
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba090>>----
         #Ctrlp:construct.c.pmba090
         ON ACTION controlp INFIELD pmba090
            #add-point:ON ACTION controlp INFIELD pmba090
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba090  #顯示到畫面上

            NEXT FIELD pmba090                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba090
            #add-point:BEFORE FIELD pmba090
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba090

            #add-point:AFTER FIELD pmba090
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba026>>----
         #Ctrlp:construct.c.pmba026
         ON ACTION controlp INFIELD pmba026
            #add-point:ON ACTION controlp INFIELD pmba026
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '250'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba026  #顯示到畫面上

            NEXT FIELD pmba026                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba026
            #add-point:BEFORE FIELD pmba026
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba026

            #add-point:AFTER FIELD pmba026
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba221>>----
         #Ctrlp:construct.c.pmba221
         ON ACTION controlp INFIELD pmba221
            #add-point:ON ACTION controlp INFIELD pmba221
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba221  #顯示到畫面上

            NEXT FIELD pmba221                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba221
            #add-point:BEFORE FIELD pmba221
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba221

            #add-point:AFTER FIELD pmba221
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba232>>----
         #Ctrlp:construct.c.pmba232
         ON ACTION controlp INFIELD pmba232
            #add-point:ON ACTION controlp INFIELD pmba232
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2072'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba232  #顯示到畫面上

            NEXT FIELD pmba232                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba232
            #add-point:BEFORE FIELD pmba232
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba232

            #add-point:AFTER FIELD pmba232
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba200>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba200
            #add-point:BEFORE FIELD pmba200
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba200

            #add-point:AFTER FIELD pmba200
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba200
#         ON ACTION controlp INFIELD pmba200
            #add-point:ON ACTION controlp INFIELD pmba200
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba201>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba201
            #add-point:BEFORE FIELD pmba201
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba201

            #add-point:AFTER FIELD pmba201
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba201
#         ON ACTION controlp INFIELD pmba201
            #add-point:ON ACTION controlp INFIELD pmba201
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba027
            #add-point:BEFORE FIELD pmba027
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba027

            #add-point:AFTER FIELD pmba027
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba027
#         ON ACTION controlp INFIELD pmba027
            #add-point:ON ACTION controlp INFIELD pmba027
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba004
            #add-point:BEFORE FIELD pmba004
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba004

            #add-point:AFTER FIELD pmba004
            
            #END add-point


         #Ctrlp:construct.c.pmba004
#         ON ACTION controlp INFIELD pmba004
            #add-point:ON ACTION controlp INFIELD pmba004
            
            #END add-point

         #Ctrlp:construct.c.pmba241
         ON ACTION controlp INFIELD pmba241
            #add-point:ON ACTION controlp INFIELD pmba241
                                                                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1"
            CALL q_dbaa001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba241  #顯示到畫面上
            NEXT FIELD pmba241                     #返回原欄位
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba241
            #add-point:BEFORE FIELD pmba241

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba241

            #add-point:AFTER FIELD pmba241

            #END add-point


         #Ctrlp:construct.c.pmba242
         ON ACTION controlp INFIELD pmba242
            #add-point:ON ACTION controlp INFIELD pmba242
                                                                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2"
            CALL q_dbaa001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba242  #顯示到畫面上
            NEXT FIELD pmba242                     #返回原欄位
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba242
            #add-point:BEFORE FIELD pmba242

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba242

            #add-point:AFTER FIELD pmba242

            #END add-point


         #Ctrlp:construct.c.pmba243
         ON ACTION controlp INFIELD pmba243
            #add-point:ON ACTION controlp INFIELD pmba243
                                                                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3"
            CALL q_dbaa001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba243  #顯示到畫面上
            NEXT FIELD pmba243                     #返回原欄位
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba243
            #add-point:BEFORE FIELD pmba243

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba243

            #add-point:AFTER FIELD pmba243

            #END add-point


         #Ctrlp:construct.c.pmba244
         ON ACTION controlp INFIELD pmba244
            #add-point:ON ACTION controlp INFIELD pmba244
                                                                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "4"
            CALL q_dbaa001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba244  #顯示到畫面上
            NEXT FIELD pmba244                     #返回原欄位
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba244
            #add-point:BEFORE FIELD pmba244

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba244

            #add-point:AFTER FIELD pmba244

            #END add-point

         #----<<pmbastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbastus
            #add-point:BEFORE FIELD pmbastus
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbastus

            #add-point:AFTER FIELD pmbastus
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmbastus
#         ON ACTION controlp INFIELD pmbastus
            #add-point:ON ACTION controlp INFIELD pmbastus
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbaownid>>----
         #Ctrlp:construct.c.pmbaownid
         ON ACTION controlp INFIELD pmbaownid
            #add-point:ON ACTION controlp INFIELD pmbaownid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbaownid  #顯示到畫面上

            NEXT FIELD pmbaownid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbaownid
            #add-point:BEFORE FIELD pmbaownid
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbaownid

            #add-point:AFTER FIELD pmbaownid
                      {#ADP版次:1#}
            #END add-point


         #----<<pmbaowndp>>----
         #Ctrlp:construct.c.pmbaowndp
         ON ACTION controlp INFIELD pmbaowndp
            #add-point:ON ACTION controlp INFIELD pmbaowndp
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbaowndp  #顯示到畫面上

            NEXT FIELD pmbaowndp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbaowndp
            #add-point:BEFORE FIELD pmbaowndp
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbaowndp

            #add-point:AFTER FIELD pmbaowndp
                      {#ADP版次:1#}
            #END add-point


         #----<<pmbacrtid>>----
         #Ctrlp:construct.c.pmbacrtid
         ON ACTION controlp INFIELD pmbacrtid
            #add-point:ON ACTION controlp INFIELD pmbacrtid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbacrtid  #顯示到畫面上

            NEXT FIELD pmbacrtid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbacrtid
            #add-point:BEFORE FIELD pmbacrtid
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbacrtid

            #add-point:AFTER FIELD pmbacrtid
                      {#ADP版次:1#}
            #END add-point


         #----<<pmbacrtdp>>----
         #Ctrlp:construct.c.pmbacrtdp
         ON ACTION controlp INFIELD pmbacrtdp
            #add-point:ON ACTION controlp INFIELD pmbacrtdp
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbacrtdp  #顯示到畫面上

            NEXT FIELD pmbacrtdp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbacrtdp
            #add-point:BEFORE FIELD pmbacrtdp
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbacrtdp

            #add-point:AFTER FIELD pmbacrtdp
                      {#ADP版次:1#}
            #END add-point


         #----<<pmbacrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbacrtdt
            #add-point:BEFORE FIELD pmbacrtdt
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbamodid>>----
         #Ctrlp:construct.c.pmbamodid
         ON ACTION controlp INFIELD pmbamodid
            #add-point:ON ACTION controlp INFIELD pmbamodid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbamodid  #顯示到畫面上

            NEXT FIELD pmbamodid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbamodid
            #add-point:BEFORE FIELD pmbamodid
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbamodid

            #add-point:AFTER FIELD pmbamodid
                      {#ADP版次:1#}
            #END add-point


         #----<<pmbamoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbamoddt
            #add-point:BEFORE FIELD pmbamoddt
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbacnfid>>----
         #Ctrlp:construct.c.pmbacnfid
         ON ACTION controlp INFIELD pmbacnfid
            #add-point:ON ACTION controlp INFIELD pmbacnfid
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbacnfid  #顯示到畫面上

            NEXT FIELD pmbacnfid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmbacnfid
            #add-point:BEFORE FIELD pmbacnfid
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbacnfid

            #add-point:AFTER FIELD pmbacnfid
                      {#ADP版次:1#}
            #END add-point


         #----<<pmbacnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbacnfdt
            #add-point:BEFORE FIELD pmbacnfdt
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba017
            #add-point:BEFORE FIELD pmba017
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba017

            #add-point:AFTER FIELD pmba017
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba017
#         ON ACTION controlp INFIELD pmba017
            #add-point:ON ACTION controlp INFIELD pmba017
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba016
            #add-point:BEFORE FIELD pmba016
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba016

            #add-point:AFTER FIELD pmba016
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba016
#         ON ACTION controlp INFIELD pmba016
            #add-point:ON ACTION controlp INFIELD pmba016
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba018
            #add-point:BEFORE FIELD pmba018
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba018

            #add-point:AFTER FIELD pmba018
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba018
#         ON ACTION controlp INFIELD pmba018
            #add-point:ON ACTION controlp INFIELD pmba018
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba019>>----
         #Ctrlp:construct.c.pmba019
         ON ACTION controlp INFIELD pmba019
            #add-point:ON ACTION controlp INFIELD pmba019
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba019  #顯示到畫面上

            NEXT FIELD pmba019                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba019
            #add-point:BEFORE FIELD pmba019
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba019

            #add-point:AFTER FIELD pmba019
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba021
            #add-point:BEFORE FIELD pmba021
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba021

            #add-point:AFTER FIELD pmba021
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba021
#         ON ACTION controlp INFIELD pmba021
            #add-point:ON ACTION controlp INFIELD pmba021
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba022>>----
         #Ctrlp:construct.c.pmba022
         ON ACTION controlp INFIELD pmba022
            #add-point:ON ACTION controlp INFIELD pmba022
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba022  #顯示到畫面上

            NEXT FIELD pmba022                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba022
            #add-point:BEFORE FIELD pmba022
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba022

            #add-point:AFTER FIELD pmba022
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba020
            #add-point:BEFORE FIELD pmba020
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba020

            #add-point:AFTER FIELD pmba020
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.pmba020
#         ON ACTION controlp INFIELD pmba020
            #add-point:ON ACTION controlp INFIELD pmba020
                      {#ADP版次:1#}
            #END add-point

         #----<<ooff013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooff013

            #add-point:AFTER FIELD ooff013
                      {#ADP版次:1#}
            #END add-point


         #Ctrlp:construct.c.ooff013
#         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba291>>----
         #Ctrlp:construct.c.pmba291
         ON ACTION controlp INFIELD pmba291
            #add-point:ON ACTION controlp INFIELD pmba291
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2061'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba291  #顯示到畫面上

            NEXT FIELD pmba291                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba291
            #add-point:BEFORE FIELD pmba291
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba291

            #add-point:AFTER FIELD pmba291
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba292>>----
         #Ctrlp:construct.c.pmba292
         ON ACTION controlp INFIELD pmba292
            #add-point:ON ACTION controlp INFIELD pmba292
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2062'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba292  #顯示到畫面上

            NEXT FIELD pmba292                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba292
            #add-point:BEFORE FIELD pmba292
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba292

            #add-point:AFTER FIELD pmba292
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba293>>----
         #Ctrlp:construct.c.pmba293
         ON ACTION controlp INFIELD pmba293
            #add-point:ON ACTION controlp INFIELD pmba293
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2063'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba293  #顯示到畫面上

            NEXT FIELD pmba293                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba293
            #add-point:BEFORE FIELD pmba293
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba293

            #add-point:AFTER FIELD pmba293
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba294>>----
         #Ctrlp:construct.c.pmba294
         ON ACTION controlp INFIELD pmba294
            #add-point:ON ACTION controlp INFIELD pmba294
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2064'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba294  #顯示到畫面上

            NEXT FIELD pmba294                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba294
            #add-point:BEFORE FIELD pmba294
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba294

            #add-point:AFTER FIELD pmba294
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba295>>----
         #Ctrlp:construct.c.pmba295
         ON ACTION controlp INFIELD pmba295
            #add-point:ON ACTION controlp INFIELD pmba295
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2065'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba295  #顯示到畫面上

            NEXT FIELD pmba295                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba295
            #add-point:BEFORE FIELD pmba295
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba295

            #add-point:AFTER FIELD pmba295
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba296>>----
         #Ctrlp:construct.c.pmba296
         ON ACTION controlp INFIELD pmba296
            #add-point:ON ACTION controlp INFIELD pmba296
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2066'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba296  #顯示到畫面上

            NEXT FIELD pmba296                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba296
            #add-point:BEFORE FIELD pmba296
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba296

            #add-point:AFTER FIELD pmba296
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba297>>----
         #Ctrlp:construct.c.pmba297
         ON ACTION controlp INFIELD pmba297
            #add-point:ON ACTION controlp INFIELD pmba297
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2067'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba297  #顯示到畫面上

            NEXT FIELD pmba297                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba297
            #add-point:BEFORE FIELD pmba297
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba297

            #add-point:AFTER FIELD pmba297
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba298>>----
         #Ctrlp:construct.c.pmba298
         ON ACTION controlp INFIELD pmba298
            #add-point:ON ACTION controlp INFIELD pmba298
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2068'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba298  #顯示到畫面上

            NEXT FIELD pmba298                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba298
            #add-point:BEFORE FIELD pmba298
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba298

            #add-point:AFTER FIELD pmba298
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba299>>----
         #Ctrlp:construct.c.pmba299
         ON ACTION controlp INFIELD pmba299
            #add-point:ON ACTION controlp INFIELD pmba299
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2069'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba299  #顯示到畫面上

            NEXT FIELD pmba299                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba299
            #add-point:BEFORE FIELD pmba299
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba299

            #add-point:AFTER FIELD pmba299
                      {#ADP版次:1#}
            #END add-point


         #----<<pmba300>>----
         #Ctrlp:construct.c.pmba300
         ON ACTION controlp INFIELD pmba300
            #add-point:ON ACTION controlp INFIELD pmba300
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '2070'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba300  #顯示到畫面上

            NEXT FIELD pmba300                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pmba300
            #add-point:BEFORE FIELD pmba300
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba300

            #add-point:AFTER FIELD pmba300
                      {#ADP版次:1#}
            #END add-point




      END CONSTRUCT

      #add-point:cs段more_construct
      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      SUBDIALOG aoo_aooi350_02.aooi350_02_construct 
      {#ADP版次:1#}
      #end add-point

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   #add-point:cs段after_construct
   LET g_wc = g_wc CLIPPED , " AND ",g_wc2_i35001 ," AND ",g_wc2_i35002
   {#ADP版次:1#}
   #end add-point

   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")

END FUNCTION

PRIVATE FUNCTION adbt201_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define
             {#ADP版次:1#}
   #end add-point

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON pmba095,pmba000,pmbadocdt,pmbadocno,pmba001
                          FROM s_browse[1].b_pmba095,s_browse[1].b_pmba000,s_browse[1].b_pmbadocdt,
                               s_browse[1].b_pmbadocno,s_browse[1].b_pmba001

         BEFORE CONSTRUCT
#saki             CALL cl_qbe_init()
            DISPLAY adbt201_filter_parser('pmba095') TO s_browse[1].b_pmba095
            DISPLAY adbt201_filter_parser('pmba000') TO s_browse[1].b_pmba000
            DISPLAY adbt201_filter_parser('pmbadocdt') TO s_browse[1].b_pmbadocdt
            DISPLAY adbt201_filter_parser('pmbadocno') TO s_browse[1].b_pmbadocno
            DISPLAY adbt201_filter_parser('pmba001') TO s_browse[1].b_pmba001
            

      END CONSTRUCT

      #add-point:filter段add_cs
                {#ADP版次:1#}
      #end add-point

      BEFORE DIALOG
         #add-point:filter段b_dialog
                   {#ADP版次:1#}
         #end add-point

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF

END FUNCTION

PRIVATE FUNCTION adbt201_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
             {#ADP版次:1#}
   #end add-point

   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF

   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF

   RETURN ls_var

END FUNCTION

PRIVATE FUNCTION adbt201_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {#ADP版次:1#}
   #end add-point

   LET INT_FLAG = 0
   LET ls_wc = g_wc

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL g_browser.clear()

   IF g_worksheet_hidden THEN  #browser panel 單身折疊
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      CALL gfrm_curr.setElementHidden("worksheet_detail",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF

   INITIALIZE g_pmba_m.* TO NULL
   ERROR ""

   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL adbt201_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adbt201_browser_fill(g_wc,"F")
      CALL adbt201_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF

   LET g_error_show = 1
   CALL adbt201_browser_fill(g_wc,"F")   # 移到第一頁

   #備份搜尋條件
   LET ls_wc = g_wc

   #第一層模糊搜尋
   IF g_browser.getLength() = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL adbt201_browser_fill(g_wc,"F")
   END IF

   #第二層助記碼搜尋
   IF g_browser.getLength() = 0 THEN

      LET g_wc = cl_mcode_parser(ls_wc,'pmbal_t','pmbal003','pmba_t','pmbadocno','1','')

      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL adbt201_browser_fill(g_wc,"F")
      END IF

   END IF

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL adbt201_fetch("F")
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION adbt201_fetch(p_fl)
   {<Local define>}
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}

   #add-point:fetch段define
   {#ADP版次:1#}
   #end add-point

   CASE p_fl
      WHEN "F" LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF
      WHEN "L"
         LET g_current_idx = g_header_cnt
      WHEN "/"
         IF (NOT g_no_ask) THEN
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE
   END CASE

   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   CALL ui.Interface.refresh()

   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數



   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)

   CALL cl_navigator_setting(g_browser_idx, g_current_cnt)

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   LET g_pmba_m.pmbadocno = g_browser[g_current_idx].b_pmbadocno


   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE pmba095,pmba000,pmbadocdt,pmbadocno,pmba001,pmbaacti,pmba005,pmba006,pmba090,pmba026,pmba221,
                  pmba232,pmba200,pmba201,pmba027,pmba004,pmba241,pmba242,pmba243,pmba244,pmbastus,pmbaownid,pmbaowndp,pmbacrtid,
                  pmbacrtdp,pmbacrtdt,pmbamodid,pmbamoddt,pmbacnfid,pmbacnfdt,pmba017,pmba016,pmba018,
                  pmba019,pmba021,pmba022,pmba020,pmba291,pmba292,pmba293,pmba294,pmba295,pmba296,
                  pmba297,pmba298,pmba299,pmba300
      INTO g_pmba_m.pmba095,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,g_pmba_m.pmbadocno,g_pmba_m.pmba001,g_pmba_m.pmbaacti,
           g_pmba_m.pmba005,g_pmba_m.pmba006,g_pmba_m.pmba090,g_pmba_m.pmba026,g_pmba_m.pmba221,
           g_pmba_m.pmba232,g_pmba_m.pmba200,g_pmba_m.pmba201,g_pmba_m.pmba027,g_pmba_m.pmba004,
           g_pmba_m.pmba241,g_pmba_m.pmba242,g_pmba_m.pmba243,g_pmba_m.pmba244,
           g_pmba_m.pmbastus,g_pmba_m.pmbaownid,g_pmba_m.pmbaowndp,g_pmba_m.pmbacrtid,g_pmba_m.pmbacrtdp,
           g_pmba_m.pmbacrtdt,g_pmba_m.pmbamodid,g_pmba_m.pmbamoddt,g_pmba_m.pmbacnfid,g_pmba_m.pmbacnfdt,
           g_pmba_m.pmba017,g_pmba_m.pmba016,g_pmba_m.pmba018,g_pmba_m.pmba019,g_pmba_m.pmba021,
           g_pmba_m.pmba022,g_pmba_m.pmba020,g_pmba_m.pmba291,g_pmba_m.pmba292,g_pmba_m.pmba293,
           g_pmba_m.pmba294,g_pmba_m.pmba295,g_pmba_m.pmba296,g_pmba_m.pmba297,g_pmba_m.pmba298,
           g_pmba_m.pmba299,g_pmba_m.pmba300
      FROM pmba_t
     WHERE pmbaent = g_enterprise AND pmbadocno = g_pmba_m.pmbadocno AND pmba002 = '2' AND pmba230 = '2'
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pmba_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      INITIALIZE g_pmba_m.* TO NULL
      RETURN
   END IF

   #add-point:fetch段action控制
   IF cl_null(g_pmba_m.pmbadocno) THEN
      CALL cl_set_act_visible("modify_pmba001",FALSE)
   ELSE
      CALL cl_set_act_visible("modify_pmba001",TRUE)
   END IF

   IF g_pmba_m.pmba000 = 'I' AND g_pmba_m.pmbastus = 'N' THEN
      CALL cl_set_act_visible("modify_pmba001",TRUE)
   ELSE
      CALL cl_set_act_visible("modify_pmba001",FALSE)
   END IF
   
   IF g_pmba_m.pmbastus MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF          {#ADP版次:1#}
   #end add-point


   #重新顯示
   CALL adbt201_show()

END FUNCTION

PRIVATE FUNCTION adbt201_insert()
   #add-point:insert段define
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doctype       LIKE rtai_t.rtai004
   DEFINE l_insert        LIKE type_t.num5   {#ADP版次:1#}
   #end add-point

   CLEAR FORM                    #清畫面欄位內容

   INITIALIZE g_pmba_m.* LIKE pmba_t.*             #DEFAULT 設定
   
   LET g_pmbadocno_t = NULL


   CALL s_transaction_begin()

   WHILE TRUE
      #六階樹狀給值


      #公用欄位給值
      #此段落由子樣板a14產生
      LET g_pmba_m.pmbaownid = g_user
      LET g_pmba_m.pmbaowndp = g_dept
      LET g_pmba_m.pmbacrtid = g_user
      LET g_pmba_m.pmbacrtdp = g_dept
      LET g_pmba_m.pmbacrtdt = cl_get_current()
      LET g_pmba_m.pmbamodid = ""
      LET g_pmba_m.pmbamoddt = ""
      #LET g_pmba_m.pmbastus = ""



      #append欄位給值


      #一般欄位給值
      LET g_pmba_m.pmba004 = "1"
      LET g_pmba_m.pmbastus = "N"


      #add-point:單頭預設值
      LET g_pmba_m.pmba027 = ''
      LET g_pmaa027_d = ''
      CALL aooi350_01_clear_detail()
      CALL aooi350_02_clear_detail()
      CALL s_aooi500_default(g_prog,'pmbaunit',g_site)
         RETURNING l_insert,g_pmba_m.pmba095
      IF NOT l_insert THEN
        RETURN
      END IF
      CALL s_desc_get_department_desc(g_pmba_m.pmba095)
         RETURNING g_pmba_m.pmba095_desc
      DISPLAY BY NAME g_pmba_m.pmba095_desc
      #交易對象類型pmba002 = '2.供應商' 且 客戶性質pmba230 = '2.間接客戶'
      LET g_pmba_m.pmba002 = '2'
      LET g_pmba_m.pmba230 = '2'
      LET g_pmba_m.pmbadocdt = g_today
      LET g_pmba_m.pmba000 = 'I'
      LET g_pmba_m.pmba004 = '3'
      LET g_pmba_m.pmbaacti = 'Y'
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_pmba_m.pmba095,g_prog,'1')
         RETURNING l_success,l_doctype
      LET g_pmba_m.pmbadocno = l_doctype
      
      #For 單據別開窗時可以在 營運中心切換時，開出正確的資料
      LET g_ooef004 = ''
      SELECT ooef004 INTO g_ooef004 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      IF cl_null(g_ooef004) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00007'
         LET g_errparam.extend = g_site
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
      
      LET g_pmba_m_t.* = g_pmba_m.*
      LET g_pmba_m_o.* = g_pmba_m.*
      {#ADP版次:1#}
      #end add-point

      CALL adbt201_input("a")

      #add-point:單頭輸入後
                {#ADP版次:1#}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_pmba_m.* = g_pmba_m_t.*
         CALL adbt201_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      LET g_rec_b = 0
      EXIT WHILE
   END WHILE

   LET g_pmbadocno_t = g_pmba_m.pmbadocno


   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR ( pmbaent = '" ||g_enterprise|| "' AND",
              " pmbadocno = '", g_pmba_m.pmbadocno CLIPPED, "' "

              , ") "

END FUNCTION

PRIVATE FUNCTION adbt201_modify()
   #add-point:modify段define
             {#ADP版次:1#}
   #end add-point

   IF g_pmba_m.pmbadocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   SELECT UNIQUE pmba095,pmba000,pmbadocdt,pmbadocno,pmba001,pmbaacti,pmba005,pmba006,pmba090,pmba026,pmba221,
                  pmba232,pmba200,pmba201,pmba027,pmba004,pmba241,pmba242,pmba243,pmba244,pmbastus,pmbaownid,pmbaowndp,pmbacrtid,
                  pmbacrtdp,pmbacrtdt,pmbamodid,pmbamoddt,pmbacnfid,pmbacnfdt,pmba017,pmba016,pmba018,
                  pmba019,pmba021,pmba022,pmba020,pmba291,pmba292,pmba293,pmba294,pmba295,pmba296,
                  pmba297,pmba298,pmba299,pmba300
      INTO g_pmba_m.pmba095,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,g_pmba_m.pmbadocno,g_pmba_m.pmba001,g_pmba_m.pmbaacti,
           g_pmba_m.pmba005,g_pmba_m.pmba006,g_pmba_m.pmba090,g_pmba_m.pmba026,g_pmba_m.pmba221,
           g_pmba_m.pmba232,g_pmba_m.pmba200,g_pmba_m.pmba201,g_pmba_m.pmba027,g_pmba_m.pmba004,
           g_pmba_m.pmba241,g_pmba_m.pmba242,g_pmba_m.pmba243,g_pmba_m.pmba244,
           g_pmba_m.pmbastus,g_pmba_m.pmbaownid,g_pmba_m.pmbaowndp,g_pmba_m.pmbacrtid,g_pmba_m.pmbacrtdp,
           g_pmba_m.pmbacrtdt,g_pmba_m.pmbamodid,g_pmba_m.pmbamoddt,g_pmba_m.pmbacnfid,g_pmba_m.pmbacnfdt,
           g_pmba_m.pmba017,g_pmba_m.pmba016,g_pmba_m.pmba018,g_pmba_m.pmba019,g_pmba_m.pmba021,
           g_pmba_m.pmba022,g_pmba_m.pmba020,g_pmba_m.pmba291,g_pmba_m.pmba292,g_pmba_m.pmba293,
           g_pmba_m.pmba294,g_pmba_m.pmba295,g_pmba_m.pmba296,g_pmba_m.pmba297,g_pmba_m.pmba298,
           g_pmba_m.pmba299,g_pmba_m.pmba300
      FROM pmba_t
     WHERE pmbaent = g_enterprise AND pmbadocno = g_pmba_m.pmbadocno AND pmba002 = '2' AND pmba230 = '2'

   ERROR ""

   LET g_pmbadocno_t = g_pmba_m.pmbadocno


   CALL s_transaction_begin()

   OPEN adbt201_cl USING g_enterprise,g_pmba_m.pmbadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adbt201_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE adbt201_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH adbt201_cl INTO g_pmba_m.pmba095,g_pmba_m.pmba095_desc,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,
       g_pmba_m.pmbadocno,g_pmba_m.pmba001,g_pmba_m.pmbaacti,g_pmba_m.pmbal003,g_pmba_m.pmbal002,
       g_pmba_m.pmbal004,g_pmba_m.pmba005,g_pmba_m.pmba005_desc,g_pmba_m.pmba006,g_pmba_m.pmba006_desc,
       g_pmba_m.pmba090,g_pmba_m.pmba090_desc,g_pmba_m.pmba026,g_pmba_m.pmba026_desc,g_pmba_m.pmba221,
       g_pmba_m.pmba221_desc,g_pmba_m.pmba232,g_pmba_m.pmba232_desc,g_pmba_m.pmba200,g_pmba_m.pmba201,
       g_pmba_m.pmba027,g_pmba_m.pmba004,g_pmba_m.pmba241,g_pmba_m.pmba241_desc,g_pmba_m.pmba242,
       g_pmba_m.pmba242_desc,g_pmba_m.pmba243,g_pmba_m.pmba243_desc,g_pmba_m.pmba244,g_pmba_m.pmba244_desc,
       g_pmba_m.pmbastus,g_pmba_m.pmbaownid,
       g_pmba_m.pmbaownid_desc,g_pmba_m.pmbaowndp,g_pmba_m.pmbaowndp_desc,g_pmba_m.pmbacrtid,
       g_pmba_m.pmbacrtid_desc,g_pmba_m.pmbacrtdp,g_pmba_m.pmbacrtdp_desc,g_pmba_m.pmbacrtdt,g_pmba_m.pmbamodid,
       g_pmba_m.pmbamodid_desc,g_pmba_m.pmbamoddt,g_pmba_m.pmbacnfid,g_pmba_m.pmbacnfid_desc,g_pmba_m.pmbacnfdt,
       g_pmba_m.pmba017,g_pmba_m.pmba016,g_pmba_m.pmba018,g_pmba_m.pmba019,g_pmba_m.pmba019_desc,g_pmba_m.pmba021,
       g_pmba_m.pmba022,g_pmba_m.pmba022_desc,g_pmba_m.pmba020,g_pmba_m.ooff013,g_pmba_m.pmba291,
       g_pmba_m.pmba291_desc,g_pmba_m.pmba292,g_pmba_m.pmba292_desc,g_pmba_m.pmba293,g_pmba_m.pmba293_desc,
       g_pmba_m.pmba294,g_pmba_m.pmba294_desc,g_pmba_m.pmba295,g_pmba_m.pmba295_desc,g_pmba_m.pmba296,
       g_pmba_m.pmba296_desc,g_pmba_m.pmba297,g_pmba_m.pmba297_desc,g_pmba_m.pmba298,g_pmba_m.pmba298_desc,
       g_pmba_m.pmba299,g_pmba_m.pmba299_desc,g_pmba_m.pmba300,g_pmba_m.pmba300_desc

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pmba_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE adbt201_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#6 -s by 08172
   #檢查是否允許此動作
   IF NOT adbt201_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#6 -e by 08172


   CALL adbt201_show()

   WHILE TRUE
      LET g_pmba_m.pmbadocno = g_pmbadocno_t


      #寫入修改者/修改日期資訊
      LET g_pmba_m.pmbamodid = g_user
LET g_pmba_m.pmbamoddt = cl_get_current()


      #add-point:modify段修改前
            LET g_pmba_m_o.* = g_pmba_m.*          {#ADP版次:1#}
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_pmba_m.pmbastus MATCHES "[DR]" THEN
         LET g_pmba_m.pmbastus = "N"
      END IF
      #end add-point

      CALL adbt201_input("u")     #欄位更改

      #add-point:modify段修改後
                {#ADP版次:1#}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_pmba_m.* = g_pmba_m_t.*
         CALL adbt201_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      EXIT WHILE

   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_pmba_m.pmbadocno,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE adbt201_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_pmba_m.pmbadocno,"U")

   LET g_worksheet_hidden = 0

END FUNCTION

PRIVATE FUNCTION adbt201_input(p_cmd)
   {<Local define>}
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT   #161117-00022#1 161118 by lori mod:num5 to num10
   DEFINE l_n             LIKE type_t.num5        #檢查重複用
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:input段define
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         LIKE type_t.chr10{#ADP版次:1#}
   DEFINE l_bkdocno       LIKE pmba_t.pmbadocno   #160704-00026#1 20160711 add by beckxie
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL cl_set_head_visible("","YES")

   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF

   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   #控制key欄位可否輸入
   CALL adbt201_set_entry(p_cmd)
   #add-point:set_entry後
   CALL adbt201_set_no_required(p_cmd)
   CALL adbt201_set_required(p_cmd)           {#ADP版次:1#}
   #end add-point
   CALL adbt201_set_no_entry(p_cmd)
   #add-point:資料輸入前
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete{#ADP版次:1#}
   #end add-point

   DISPLAY BY NAME g_pmba_m.pmba095,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,g_pmba_m.pmbadocno,
                   g_pmba_m.pmba001,g_pmba_m.pmbaacti,g_pmba_m.pmbal003,g_pmba_m.pmbal002,
                   g_pmba_m.pmbal004,g_pmba_m.pmba005,g_pmba_m.pmba006,g_pmba_m.pmba090,
                   g_pmba_m.pmba026,g_pmba_m.pmba221,g_pmba_m.pmba232,g_pmba_m.pmba200,
                   g_pmba_m.pmba201,g_pmba_m.pmba027,g_pmba_m.pmba004,g_pmba_m.pmba241,
                   g_pmba_m.pmba242,g_pmba_m.pmba243,g_pmba_m.pmba244,g_pmba_m.pmbastus,
                   g_pmba_m.pmba017,g_pmba_m.pmba016,g_pmba_m.pmba018,g_pmba_m.pmba019,
                   g_pmba_m.pmba021,g_pmba_m.pmba022,g_pmba_m.pmba020,g_pmba_m.ooff013,
                   g_pmba_m.pmba291,g_pmba_m.pmba292,g_pmba_m.pmba293,g_pmba_m.pmba294,
                   g_pmba_m.pmba295,g_pmba_m.pmba296,g_pmba_m.pmba297,g_pmba_m.pmba298,
                   g_pmba_m.pmba299,g_pmba_m.pmba300

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_pmba_m.pmba095,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,g_pmba_m.pmbadocno,
                    g_pmba_m.pmba001,g_pmba_m.pmbaacti,g_pmba_m.pmbal003,g_pmba_m.pmbal002,
                    g_pmba_m.pmbal004,g_pmba_m.pmba005,g_pmba_m.pmba006,g_pmba_m.pmba090,
                    g_pmba_m.pmba026,g_pmba_m.pmba221,g_pmba_m.pmba232,g_pmba_m.pmba200,
                    g_pmba_m.pmba201,g_pmba_m.pmba027,g_pmba_m.pmba004,g_pmba_m.pmba241,
                    g_pmba_m.pmba242,g_pmba_m.pmba243,g_pmba_m.pmba244,g_pmba_m.pmbastus,
                    g_pmba_m.pmba017,g_pmba_m.pmba016,g_pmba_m.pmba018,g_pmba_m.pmba019,
                    g_pmba_m.pmba021,g_pmba_m.pmba022,g_pmba_m.pmba020,g_pmba_m.ooff013,
                    g_pmba_m.pmba291,g_pmba_m.pmba292,g_pmba_m.pmba293,g_pmba_m.pmba294,
                    g_pmba_m.pmba295,g_pmba_m.pmba296,g_pmba_m.pmba297,g_pmba_m.pmba298,
                    g_pmba_m.pmba299,g_pmba_m.pmba300
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         ON ACTION update_item
            IF cl_auth_chk_act("update_item") THEN   #151027-00016#2 20151111 add by beckxie
               #add-point:ON ACTION update_item
               IF NOT cl_null(g_pmba_m.pmbadocno)  THEN
                  CALL n_pmbal(g_pmba_m.pmbadocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_pmba_m.pmbadocno
                  CALL ap_ref_array2(g_ref_fields," SELECT pmbal002,pmbal003,pmbal004 FROM pmbal_t WHERE pmbalent = '"||g_enterprise||"' AND pmbaldocno = ? AND pmbal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_pmba_m.pmbal002 = g_rtn_fields[1]
                  LET g_pmba_m.pmbal003 = g_rtn_fields[2]
                  LET g_pmba_m.pmbal004 = g_rtn_fields[3]
                  DISPLAY BY NAME g_pmba_m.pmbal002,g_pmba_m.pmbal003,g_pmba_m.pmbal004
               END IF            {#ADP版次:1#}
               #END add-point
            END IF   #151027-00016#2 20151111 add by beckxie


         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.pmbaldocno = g_pmba_m.pmbadocno
            LET g_master_multi_table_t.pmbal003 = g_pmba_m.pmbal003
            LET g_master_multi_table_t.pmbal002 = g_pmba_m.pmbal002
            LET g_master_multi_table_t.pmbal004 = g_pmba_m.pmbal004

            #add-point:input開始前
                      {#ADP版次:1#}
            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<pmba095>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba095

            #add-point:AFTER FIELD pmba095
            LET g_pmba_m.pmba095_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba095_desc
            IF NOT cl_null(g_pmba_m.pmba095) THEN
              IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba095 != g_pmba_m_t.pmba095 OR g_pmba_m_t.pmba095 IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'pmbaunit',g_pmba_m.pmba095,g_site)
                      RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     LET g_pmba_m.pmba095 = g_pmba_m_t.pmba095
                     CALL s_desc_get_department_desc(g_pmba_m.pmba095)
                        RETURNING g_pmba_m.pmba095_desc
                     DISPLAY BY NAME g_pmba_m.pmba095_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_pmba_m.pmba095)
               RETURNING g_pmba_m.pmba095_desc
            DISPLAY BY NAME g_pmba_m.pmba095_desc         {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba095
            #add-point:BEFORE FIELD pmba095
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba095
            #add-point:ON CHANGE pmba095
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba000>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba000
            #add-point:BEFORE FIELD pmba000
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba000

            #add-point:AFTER FIELD pmba000
            IF g_pmba_m.pmba000 = 'I' THEN
               LET g_pmba_m.pmbaacti = 'Y'
            END IF
            DISPLAY BY NAME g_pmba_m.pmbaacti
            CALL adbt201_set_entry(p_cmd)
            CALL adbt201_set_no_required(p_cmd)
            CALL adbt201_set_required(p_cmd) 
            CALL adbt201_set_no_entry(p_cmd)               {#ADP版次:1#}
            #END add-point
            
         #----<<pmbadocdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbadocdt
            #add-point:BEFORE FIELD pmbadocdt
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbadocdt

            #add-point:AFTER FIELD pmbadocdt
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmbadocdt
            #add-point:ON CHANGE pmbadocdt
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbadocno>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbadocno
            #add-point:BEFORE FIELD pmbadocno
                      {#ADP版次:1#}
            #END add-point
            
         #此段落由子樣板a02產生
         AFTER FIELD pmbadocno

            #add-point:AFTER FIELD pmbadocno
            #此段落由子樣板a05產生
            IF NOT s_aooi200_chk_slip(g_site,'',g_pmba_m.pmbadocno,g_prog) THEN
               LET g_pmba_m.pmbadocno = g_pmba_m_t.pmbadocno
               NEXT FIELD CURRENT
            END IF           {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmbadocno
            #add-point:ON CHANGE pmbadocno
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba000
            #add-point:ON CHANGE pmba000
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba001
            #add-point:BEFORE FIELD pmba001
            #IF cl_null(g_pmba_m.pmba001) THEN
            #   CALL s_aooi390('2') RETURNING l_success,g_pmba_m.pmba001
            #   DISPLAY BY NAME g_pmba_m.pmba001
            #   NEXT FIELD pmba001
            #END IF          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba001

            #add-point:AFTER FIELD pmba001
            #此段落由子樣板a05產生
            IF NOT cl_null(g_pmba_m.pmba001) THEN
               #150427-00012#2 20150504 by BeckXie--mark
#               IF g_pmba_m.pmba001 != g_pmba_m_o.pmba001 OR g_pmba_m_o.pmba001 IS NULL THEN
               #150427-00012#2 20150504 by BeckXie--add---S
               IF g_pmba_m.pmba001 != g_pmba_m_o.pmba001 OR cl_null(g_pmba_m_o.pmba001) THEN
               #150427-00012#2 20150504 by BeckXie--add---E
                  CALL adbt201_chk_pmba001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_pmba_m.pmba001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pmba_m.pmba001 = g_pmba_m_o.pmba001
                     NEXT FIELD CURRENT
                  ELSE
                     IF g_pmba_m.pmba000 = 'U' THEN
                        CALL adbt201_carry_pmaa()
                     END IF
                  END IF
               END IF
            END IF
            LET g_pmba_m_o.pmba001 = g_pmba_m.pmba001
            CALL adbt201_set_entry(p_cmd)
            CALL adbt201_set_no_required(p_cmd)
            CALL adbt201_set_required(p_cmd) 
            CALL adbt201_set_no_entry(p_cmd)
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba001
            #add-point:ON CHANGE pmba001
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbal003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbal003
            #add-point:BEFORE FIELD pmbal003
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbal003

            #add-point:AFTER FIELD pmbal003
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmbal003
            #add-point:ON CHANGE pmbal003
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbal002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbal002
            #add-point:BEFORE FIELD pmbal002
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbal002

            #add-point:AFTER FIELD pmbal002
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmbal002
            #add-point:ON CHANGE pmbal002
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbal004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbal004
            #add-point:BEFORE FIELD pmbal004
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbal004

            #add-point:AFTER FIELD pmbal004
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmbal004
            #add-point:ON CHANGE pmbal004
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba005>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba005

            #add-point:AFTER FIELD pmba005
            LET g_pmba_m.pmba005_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba005_desc
            IF NOT cl_null(g_pmba_m.pmba005) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba005 != g_pmba_m_o.pmba005 OR g_pmba_m_o.pmba005 IS NULL )) THEN
               IF g_pmba_m.pmba005 != g_pmba_m_o.pmba005 OR cl_null(g_pmba_m_o.pmba005) THEN   #150427-00012#2 20150504 by BeckXie--add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmba_m.pmba005
                  IF NOT cl_chk_exist("v_pmaa001_11") THEN
                     LET g_pmba_m.pmba005 = g_pmba_m_o.pmba005
                     CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba005)
                        RETURNING g_pmba_m.pmba005_desc
                     DISPLAY BY NAME g_pmba_m.pmba005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba005)
               RETURNING g_pmba_m.pmba005_desc
            DISPLAY BY NAME g_pmba_m.pmba005_desc
            LET g_pmba_m_o.pmba005 = g_pmba_m.pmba005
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba005
            #add-point:BEFORE FIELD pmba005
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba005
            #add-point:ON CHANGE pmba005
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba006>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba006

            #add-point:AFTER FIELD pmba006
            LET g_pmba_m.pmba006_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba006_desc
            IF NOT cl_null(g_pmba_m.pmba006) THEN
               #150427-00012#2 20150504 by BeckXie--mark
#               IF g_pmba_m.pmba006 != g_pmba_m_o.pmba006 OR g_pmba_m_o.pmba006 IS NULL THEN
               #150427-00012#2 20150504 by BeckXie--add---S
               IF g_pmba_m.pmba006 != g_pmba_m_o.pmba006 OR cl_null(g_pmba_m_o.pmba006) THEN
               #150427-00012#2 20150504 by BeckXie--add---E
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmba_m.pmba006
                  IF NOT cl_chk_exist("v_pmaa001_9") THEN
                     LET g_pmba_m.pmba006 = g_pmba_m_o.pmba006
                     CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba006)
                        RETURNING g_pmba_m.pmba006_desc
                     DISPLAY BY NAME g_pmba_m.pmba006_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL adbt201_pmba006_values()
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba006)
               RETURNING g_pmba_m.pmba006_desc
            DISPLAY BY NAME g_pmba_m.pmba006_desc
            LET g_pmba_m_o.pmba006 = g_pmba_m.pmba006
            LET g_pmba_m_o.pmba244 = g_pmba_m.pmba244
            LET g_pmba_m_o.pmba243 = g_pmba_m.pmba243
            LET g_pmba_m_o.pmba242 = g_pmba_m.pmba242
            LET g_pmba_m_o.pmba241 = g_pmba_m.pmba241
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba006
            #add-point:BEFORE FIELD pmba006
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba006
            #add-point:ON CHANGE pmba006
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba090>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba090

            #add-point:AFTER FIELD pmba090
            LET g_pmba_m.pmba090_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba090_desc
            IF NOT cl_null(g_pmba_m.pmba090) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba090 != g_pmba_m_o.pmba090 OR g_pmba_m_o.pmba090 IS NULL )) THEN
                IF g_pmba_m.pmba090 != g_pmba_m_o.pmba090 OR cl_null(g_pmba_m_o.pmba090) THEN   #150427-00012#2 20150504 by BeckXie--
                    IF NOT s_azzi650_chk_exist('281',g_pmba_m.pmba090) THEN
                     LET g_pmba_m.pmba090 = g_pmba_m_o.pmba090
                     CALL s_desc_get_acc_desc('281',g_pmba_m.pmba090)
                        RETURNING g_pmba_m.pmba090_desc
                     DISPLAY BY NAME g_pmba_m.pmba090_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('281',g_pmba_m.pmba090)
               RETURNING g_pmba_m.pmba090_desc
            DISPLAY BY NAME g_pmba_m.pmba090_desc
            LET g_pmba_m_o.pmba090 = g_pmba_m.pmba090
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba090
            #add-point:BEFORE FIELD pmba090
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba090
            #add-point:ON CHANGE pmba090
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba026>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba026

            #add-point:AFTER FIELD pmba026
            LET g_pmba_m.pmba026_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba026_desc
            IF NOT cl_null(g_pmba_m.pmba026) THEN
              #150427-00012#2 20150504 by BeckXie--mark
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba026 != g_pmba_m_o.pmba026 OR g_pmba_m_o.pmba026 IS NULL )) THEN
               IF g_pmba_m.pmba026 != g_pmba_m_o.pmba026 OR cl_null(g_pmba_m_o.pmba026) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('250',g_pmba_m.pmba026) THEN
                     LET g_pmba_m.pmba026 = g_pmba_m_o.pmba026
                     CALL s_desc_get_acc_desc('250',g_pmba_m.pmba026)
                        RETURNING g_pmba_m.pmba026_desc
                     DISPLAY BY NAME g_pmba_m.pmba026_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('250',g_pmba_m.pmba026)
               RETURNING g_pmba_m.pmba026_desc
            DISPLAY BY NAME g_pmba_m.pmba026_desc
            LET g_pmba_m_o.pmba026 = g_pmba_m.pmba026
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba026
            #add-point:BEFORE FIELD pmba026
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba026
            #add-point:ON CHANGE pmba026
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba221>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba221

            #add-point:AFTER FIELD pmba221
            LET g_pmba_m.pmba221_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba221_desc
            IF NOT cl_null(g_pmba_m.pmba221) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba221 != g_pmba_m_o.pmba221 OR g_pmba_m_o.pmba221 IS NULL )) THEN
               IF g_pmba_m.pmba221 != g_pmba_m_o.pmba221 OR cl_null(g_pmba_m_o.pmba221) THEN   #150427-00012#2 20150504 by BeckXie--add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmba_m.pmba221
                  LET g_chkparam.arg2 = '1'
                  IF NOT cl_chk_exist("v_oojd001") THEN
                     LET g_pmba_m.pmba221 = g_pmba_m_o.pmba221
                     CALL s_desc_get_oojdl003_desc(g_pmba_m.pmba221)
                        RETURNING g_pmba_m.pmba221_desc
                     DISPLAY BY NAME g_pmba_m.pmba221_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_oojdl003_desc(g_pmba_m.pmba221)
               RETURNING g_pmba_m.pmba221_desc
            DISPLAY BY NAME g_pmba_m.pmba221_desc
            LET g_pmba_m_o.pmba221 = g_pmba_m.pmba221
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba221
            #add-point:BEFORE FIELD pmba221
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba221
            #add-point:ON CHANGE pmba221
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba232>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba232

            #add-point:AFTER FIELD pmba232
            LET g_pmba_m.pmba232_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba232_desc
            IF NOT cl_null(g_pmba_m.pmba232) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba232 != g_pmba_m_o.pmba232 OR g_pmba_m_o.pmba232 IS NULL )) THEN
                IF g_pmba_m.pmba232 != g_pmba_m_o.pmba232 OR cl_null(g_pmba_m_o.pmba232) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2072',g_pmba_m.pmba232) THEN
                     LET g_pmba_m.pmba232 = g_pmba_m_o.pmba232
                     CALL s_desc_get_acc_desc('2072',g_pmba_m.pmba232)
                        RETURNING g_pmba_m.pmba232_desc
                     DISPLAY BY NAME g_pmba_m.pmba232_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2072',g_pmba_m.pmba232)
               RETURNING g_pmba_m.pmba232_desc
            DISPLAY BY NAME g_pmba_m.pmba232_desc
            LET g_pmba_m_o.pmba232 = g_pmba_m.pmba232
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba232
            #add-point:BEFORE FIELD pmba232
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba232
            #add-point:ON CHANGE pmba232
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba200>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba200
            #add-point:BEFORE FIELD pmba200
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba200

            #add-point:AFTER FIELD pmba200
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba200
            #add-point:ON CHANGE pmba200
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba201>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba201
            #add-point:BEFORE FIELD pmba201
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba201

            #add-point:AFTER FIELD pmba201
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba201
            #add-point:ON CHANGE pmba201
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba027
            #add-point:BEFORE FIELD pmba027
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba027

            #add-point:AFTER FIELD pmba027
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba027
            #add-point:ON CHANGE pmba027
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba004
            #add-point:BEFORE FIELD pmba004
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba004

            #add-point:AFTER FIELD pmba004
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba004
            #add-point:ON CHANGE pmba004
            
            #END add-point

         #----<<pmba241>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba241
            #add-point:BEFORE FIELD pmba241
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba241

            #add-point:AFTER FIELD pmba241
            LET g_pmba_m.pmba241_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba241_desc
            IF NOT cl_null(g_pmba_m.pmba241) THEN
               #150427-00012#2 20150504 by BeckXie--mark
#               IF g_pmba_m.pmba241 != g_pmba_m_o.pmba241 OR g_pmba_m_o.pmba241 IS NULL THEN
                #150427-00012#2 20150504 by BeckXie--add---S
                IF g_pmba_m.pmba241 != g_pmba_m_o.pmba241 OR cl_null(g_pmba_m_o.pmba241) THEN
                #150427-00012#2 20150504 by BeckXie--add---E
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmba_m.pmba241
                  LET g_chkparam.arg2 = '1'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_pmba_m.pmba241 = g_pmba_m_o.pmba241
                     LET g_pmba_m.pmba241_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
                     DISPLAY BY NAME g_pmba_m.pmba241_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_pmba_m.pmba242 = ''
                  LET g_pmba_m.pmba243 = ''
                  LET g_pmba_m.pmba244 = ''
                  LET g_pmba_m.pmba242_desc = ''
                  LET g_pmba_m.pmba243_desc = ''
                  LET g_pmba_m.pmba244_desc = ''
                  DISPLAY BY NAME g_pmba_m.pmba242_desc,g_pmba_m.pmba243_desc,g_pmba_m.pmba244_desc
               END IF
            END IF
            LET g_pmba_m_o.pmba244 = g_pmba_m.pmba244
            LET g_pmba_m_o.pmba243 = g_pmba_m.pmba243
            LET g_pmba_m_o.pmba242 = g_pmba_m.pmba242
            LET g_pmba_m_o.pmba241 = g_pmba_m.pmba241
            LET g_pmba_m.pmba241_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
            DISPLAY BY NAME g_pmba_m.pmba241_desc
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba241
            #add-point:ON CHANGE pmba241
            
            #END add-point

         #----<<pmba242>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba242
            #add-point:BEFORE FIELD pmba242
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba242

            #add-point:AFTER FIELD pmba242
            LET g_pmba_m.pmba242_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba242_desc
            IF NOT cl_null(g_pmba_m.pmba242) THEN
               #150427-00012#2 20150504 by BeckXie--mark
#               IF g_pmba_m.pmba242 != g_pmba_m_o.pmba242 OR g_pmba_m_o.pmba242 IS NULL THEN
               #150427-00012#2 20150504 by BeckXie--add---S
               IF g_pmba_m.pmba242 != g_pmba_m_o.pmba242 OR cl_null(g_pmba_m_o.pmba242) THEN
               #150427-00012#2 20150504 by BeckXie--add---E
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmba_m.pmba242
                  LET g_chkparam.arg2 = '2'
                  LET g_chkparam.err_str[1] = "acr-00004|",'2'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_pmba_m.pmba242 = g_pmba_m_o.pmba242
                     LET g_pmba_m.pmba242_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba242)
                     DISPLAY BY NAME g_pmba_m.pmba242_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_pmba_m.pmba241) THEN
                     CALL s_adb_get_dbaa003(g_pmba_m.pmba242,'2') RETURNING g_pmba_m.pmba241
                     LET g_pmba_m.pmba241_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
                     DISPLAY BY NAME g_pmba_m.pmba241_desc
                  END IF
                  LET g_pmba_m.pmba243 = ''
                  LET g_pmba_m.pmba244 = ''
                  LET g_pmba_m.pmba243_desc = ''
                  LET g_pmba_m.pmba244_desc = ''
                  DISPLAY BY NAME g_pmba_m.pmba243_desc,g_pmba_m.pmba244_desc
               END IF
            END IF
            LET g_pmba_m_o.pmba244 = g_pmba_m.pmba244
            LET g_pmba_m_o.pmba243 = g_pmba_m.pmba243
            LET g_pmba_m_o.pmba242 = g_pmba_m.pmba242
            LET g_pmba_m_o.pmba241 = g_pmba_m.pmba241
            LET g_pmba_m.pmba242_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba242)
            DISPLAY BY NAME g_pmba_m.pmba242_desc
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba242
            #add-point:ON CHANGE pmba242
            
            #END add-point

         #----<<pmba243>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba243
            #add-point:BEFORE FIELD pmba243
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba243

            #add-point:AFTER FIELD pmba243
            LET g_pmba_m.pmba243_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba243_desc
            IF NOT cl_null(g_pmba_m.pmba243) THEN
               #150427-00012#2 20150504 by BeckXie--mark
#               IF g_pmba_m.pmba243 != g_pmba_m_o.pmba243 OR g_pmba_m_o.pmba243 IS NULL THEN
               #150427-00012#2 20150504 by BeckXie--add---S
               IF g_pmba_m.pmba243 != g_pmba_m_o.pmba243 OR cl_null(g_pmba_m_o.pmba243) THEN
               #150427-00012#2 20150504 by BeckXie--add---E
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmba_m.pmba243
                  LET g_chkparam.arg2 = '3'
                  LET g_chkparam.err_str[1] = "acr-00004|",'3'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_pmba_m.pmba243 = g_pmba_m_o.pmba243
                     LET g_pmba_m.pmba243_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba243)
                     DISPLAY BY NAME g_pmba_m.pmba243_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_pmba_m.pmba242) THEN
                     CALL s_adb_get_dbaa003(g_pmba_m.pmba243,'3') RETURNING g_pmba_m.pmba242
                     CALL s_adb_get_dbaa003(g_pmba_m.pmba242,'2') RETURNING g_pmba_m.pmba241
                     LET g_pmba_m.pmba242_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba242)
                     DISPLAY BY NAME g_pmba_m.pmba242_desc
                     LET g_pmba_m.pmba241_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
                     DISPLAY BY NAME g_pmba_m.pmba241_desc
                  END IF
                  LET g_pmba_m.pmba244 = ''
                  LET g_pmba_m.pmba244_desc = ''
                  DISPLAY BY NAME g_pmba_m.pmba244_desc
               END IF
            END IF
            LET g_pmba_m_o.pmba244 = g_pmba_m.pmba244
            LET g_pmba_m_o.pmba243 = g_pmba_m.pmba243
            LET g_pmba_m_o.pmba242 = g_pmba_m.pmba242
            LET g_pmba_m_o.pmba241 = g_pmba_m.pmba241
            LET g_pmba_m.pmba243_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba243)
            DISPLAY BY NAME g_pmba_m.pmba243_desc
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba243
            #add-point:ON CHANGE pmba243
            
            #END add-point
            
         #----<<pmba244>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba244
            #add-point:BEFORE FIELD pmba244
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba244

            #add-point:AFTER FIELD pmba244
            LET g_pmba_m.pmba244_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba244_desc
            IF NOT cl_null(g_pmba_m.pmba244) THEN
               #150427-00012#2 20150504 by BeckXie--mark
#               IF g_pmba_m.pmba244 != g_pmba_m_o.pmba244 OR g_pmba_m_o.pmba244 IS NULL THEN
               #150427-00012#2 20150504 by BeckXie--add---S
               IF g_pmba_m.pmba244 != g_pmba_m_o.pmba244 OR cl_null(g_pmba_m_o.pmba244) THEN
               #150427-00012#2 20150504 by BeckXie--add---E
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmba_m.pmba244
                  LET g_chkparam.arg2 = '4'
                  LET g_chkparam.err_str[1] = "acr-00004|",'4'
                  IF NOT cl_chk_exist("v_dbaa001_1") THEN
                     LET g_pmba_m.pmba244 = g_pmba_m_o.pmba244
                     LET g_pmba_m.pmba244_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba244)
                     DISPLAY BY NAME g_pmba_m.pmba244_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_pmba_m.pmba243) THEN
                     CALL s_adb_get_dbaa003(g_pmba_m.pmba244,'4') RETURNING g_pmba_m.pmba243
                     CALL s_adb_get_dbaa003(g_pmba_m.pmba243,'3') RETURNING g_pmba_m.pmba242
                     CALL s_adb_get_dbaa003(g_pmba_m.pmba242,'2') RETURNING g_pmba_m.pmba241
                     LET g_pmba_m.pmba243_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba243)
                     DISPLAY BY NAME g_pmba_m.pmba243_desc
                     LET g_pmba_m.pmba242_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba242)
                     DISPLAY BY NAME g_pmba_m.pmba242_desc
                     LET g_pmba_m.pmba241_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
                     DISPLAY BY NAME g_pmba_m.pmba241_desc
                  END IF
               END IF
            END IF
            LET g_pmba_m_o.pmba244 = g_pmba_m.pmba244
            LET g_pmba_m_o.pmba243 = g_pmba_m.pmba243
            LET g_pmba_m_o.pmba242 = g_pmba_m.pmba242
            LET g_pmba_m_o.pmba241 = g_pmba_m.pmba241
            LET g_pmba_m.pmba244_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba244)
            DISPLAY BY NAME g_pmba_m.pmba244_desc
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba244
            #add-point:ON CHANGE pmba244
            
            #END add-point

         #----<<pmbastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmbastus
            #add-point:BEFORE FIELD pmbastus
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmbastus

            #add-point:AFTER FIELD pmbastus
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmbastus
            #add-point:ON CHANGE pmbastus
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbaownid>>----
         #----<<pmbaowndp>>----
         #----<<pmbacrtid>>----
         #----<<pmbacrtdp>>----
         #----<<pmbacrtdt>>----
         #----<<pmbamodid>>----
         #----<<pmbamoddt>>----
         #----<<pmbacnfid>>----
         #----<<pmbacnfdt>>----
         #----<<pmba017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba017
            #add-point:BEFORE FIELD pmba017
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba017

            #add-point:AFTER FIELD pmba017
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba017
            #add-point:ON CHANGE pmba017
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pmba016
            #add-point:BEFORE FIELD pmba016
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pmba016

            #add-point:AFTER FIELD pmba016
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pmba016
            #add-point:ON CHANGE pmba016
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba018>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba018
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pmba_m.pmba018,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmba018
            END IF


            #add-point:AFTER FIELD pmba018
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba018
            #add-point:BEFORE FIELD pmba018
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba018
            #add-point:ON CHANGE pmba018
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba019>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba019

            #add-point:AFTER FIELD pmba019
            LET g_pmba_m.pmba019_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba019_desc
            IF NOT cl_null(g_pmba_m.pmba019) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba019 != g_pmba_m_o.pmba019 OR g_pmba_m_o.pmba019 IS NULL )) THEN
               IF g_pmba_m.pmba019 != g_pmba_m_o.pmba019 OR cl_null(g_pmba_m_o.pmba019) THEN   #150427-00012#2 20150504 by BeckXie--add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_pmba_m.pmba019
                  #160318-00025#36  2016/04/19  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#36  2016/04/19  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_pmba_m.pmba019 = g_pmba_m_o.pmba019
                     CALL s_desc_get_currency_desc(g_pmba_m.pmba019)
                        RETURNING g_pmba_m.pmba019_desc
                     DISPLAY BY NAME g_pmba_m.pmba019_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_currency_desc(g_pmba_m.pmba019)
               RETURNING g_pmba_m.pmba019_desc
            DISPLAY BY NAME g_pmba_m.pmba019_desc
            LET g_pmba_m_o.pmba019 = g_pmba_m.pmba019          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba019
            #add-point:BEFORE FIELD pmba019
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba019
            #add-point:ON CHANGE pmba019
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba021>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba021
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pmba_m.pmba021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmba021
            END IF


            #add-point:AFTER FIELD pmba021
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba021
            #add-point:BEFORE FIELD pmba021
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba021
            #add-point:ON CHANGE pmba021
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba022>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba022

            #add-point:AFTER FIELD pmba022
            LET g_pmba_m.pmba022_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba022_desc
            IF NOT cl_null(g_pmba_m.pmba022) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba022 != g_pmba_m_o.pmba022 OR g_pmba_m_o.pmba022 IS NULL )) THEN
               IF g_pmba_m.pmba022 != g_pmba_m_o.pmba022 OR cl_null(g_pmba_m_o.pmba022) THEN   #150427-00012#2 20150504 by BeckXie--add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_pmba_m.pmba022
                  #160318-00025#36  2016/04/19  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#36  2016/04/19  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_pmba_m.pmba022 = g_pmba_m_o.pmba022
                     CALL s_desc_get_currency_desc(g_pmba_m.pmba022)
                        RETURNING g_pmba_m.pmba022_desc
                     DISPLAY BY NAME g_pmba_m.pmba022_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_currency_desc(g_pmba_m.pmba022)
               RETURNING g_pmba_m.pmba022_desc
            DISPLAY BY NAME g_pmba_m.pmba022_desc
            LET g_pmba_m_o.pmba022 = g_pmba_m.pmba022
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba022
            #add-point:BEFORE FIELD pmba022
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba022
            #add-point:ON CHANGE pmba022
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba020>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba020
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pmba_m.pmba020,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmba020
            END IF


            #add-point:AFTER FIELD pmba020
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba020
            #add-point:BEFORE FIELD pmba020
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba020
            #add-point:ON CHANGE pmba020
                      {#ADP版次:1#}
            #END add-point

         #----<<ooff013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooff013

            #add-point:AFTER FIELD ooff013
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba291>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba291

            #add-point:AFTER FIELD pmba291
            LET g_pmba_m.pmba291_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba291_desc
            IF NOT cl_null(g_pmba_m.pmba291) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba291 != g_pmba_m_o.pmba291 OR g_pmba_m_o.pmba291 IS NULL )) THEN
               IF g_pmba_m.pmba291 != g_pmba_m_o.pmba291 OR cl_null(g_pmba_m_o.pmba291) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2061',g_pmba_m.pmba291) THEN
                     LET g_pmba_m.pmba291 = g_pmba_m_o.pmba291
                     CALL s_desc_get_acc_desc('2061',g_pmba_m.pmba291)
                        RETURNING g_pmba_m.pmba291_desc
                     DISPLAY BY NAME g_pmba_m.pmba291_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2061',g_pmba_m.pmba291)
               RETURNING g_pmba_m.pmba291_desc
            DISPLAY BY NAME g_pmba_m.pmba291_desc
            LET g_pmba_m_o.pmba291 = g_pmba_m.pmba291
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba291
            #add-point:BEFORE FIELD pmba291
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba291
            #add-point:ON CHANGE pmba291
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba292>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba292

            #add-point:AFTER FIELD pmba292
            LET g_pmba_m.pmba292_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba292_desc
            IF NOT cl_null(g_pmba_m.pmba292) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba292 != g_pmba_m_o.pmba292 OR g_pmba_m_o.pmba292 IS NULL )) THEN
               IF g_pmba_m.pmba292 != g_pmba_m_o.pmba292 OR cl_null(g_pmba_m_o.pmba292) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2062',g_pmba_m.pmba292) THEN
                     LET g_pmba_m.pmba292 = g_pmba_m_o.pmba292
                     CALL s_desc_get_acc_desc('2062',g_pmba_m.pmba292)
                        RETURNING g_pmba_m.pmba292_desc
                     DISPLAY BY NAME g_pmba_m.pmba292_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2062',g_pmba_m.pmba292)
               RETURNING g_pmba_m.pmba292_desc
            DISPLAY BY NAME g_pmba_m.pmba292_desc
            LET g_pmba_m_o.pmba292 = g_pmba_m.pmba292
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba292
            #add-point:BEFORE FIELD pmba292
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba292
            #add-point:ON CHANGE pmba292
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba293>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba293

            #add-point:AFTER FIELD pmba293
            LET g_pmba_m.pmba293_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba293_desc
            IF NOT cl_null(g_pmba_m.pmba293) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba293 != g_pmba_m_o.pmba293 OR g_pmba_m_o.pmba293 IS NULL )) THEN
               IF g_pmba_m.pmba293 != g_pmba_m_o.pmba293 OR cl_null(g_pmba_m_o.pmba293) THEN   #150427-00012#2 20150504 by BeckXie--
                  IF NOT s_azzi650_chk_exist('2063',g_pmba_m.pmba293) THEN
                     LET g_pmba_m.pmba293 = g_pmba_m_o.pmba293
                     CALL s_desc_get_acc_desc('2063',g_pmba_m.pmba293)
                        RETURNING g_pmba_m.pmba293_desc
                     DISPLAY BY NAME g_pmba_m.pmba293_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2063',g_pmba_m.pmba293)
               RETURNING g_pmba_m.pmba293_desc
            DISPLAY BY NAME g_pmba_m.pmba293_desc
            LET g_pmba_m_o.pmba293 = g_pmba_m.pmba293
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba293
            #add-point:BEFORE FIELD pmba293
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba293
            #add-point:ON CHANGE pmba293
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba294>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba294

            #add-point:AFTER FIELD pmba294
            LET g_pmba_m.pmba294_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba294_desc
            IF NOT cl_null(g_pmba_m.pmba294) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba294 != g_pmba_m_o.pmba294 OR g_pmba_m_o.pmba294 IS NULL )) THEN
               IF g_pmba_m.pmba294 != g_pmba_m_o.pmba294 OR cl_null(g_pmba_m_o.pmba294) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2064',g_pmba_m.pmba294) THEN
                     LET g_pmba_m.pmba294 = g_pmba_m_o.pmba294
                     CALL s_desc_get_acc_desc('2064',g_pmba_m.pmba294)
                        RETURNING g_pmba_m.pmba294_desc
                     DISPLAY BY NAME g_pmba_m.pmba294_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2064',g_pmba_m.pmba294)
               RETURNING g_pmba_m.pmba294_desc
            DISPLAY BY NAME g_pmba_m.pmba294_desc
            LET g_pmba_m_o.pmba294 = g_pmba_m.pmba294
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba294
            #add-point:BEFORE FIELD pmba294
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba294
            #add-point:ON CHANGE pmba294
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba295>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba295

            #add-point:AFTER FIELD pmba295
            LET g_pmba_m.pmba295_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba295_desc
            IF NOT cl_null(g_pmba_m.pmba295) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba295 != g_pmba_m_o.pmba295 OR g_pmba_m_o.pmba295 IS NULL )) THEN
               IF g_pmba_m.pmba295 != g_pmba_m_o.pmba295 OR cl_null(g_pmba_m_o.pmba295) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2065',g_pmba_m.pmba295) THEN
                     LET g_pmba_m.pmba295 = g_pmba_m_o.pmba295
                     CALL s_desc_get_acc_desc('2065',g_pmba_m.pmba295)
                        RETURNING g_pmba_m.pmba295_desc
                     DISPLAY BY NAME g_pmba_m.pmba295_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2065',g_pmba_m.pmba295)
               RETURNING g_pmba_m.pmba295_desc
            DISPLAY BY NAME g_pmba_m.pmba295_desc
            LET g_pmba_m_o.pmba295 = g_pmba_m.pmba295
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba295
            #add-point:BEFORE FIELD pmba295
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba295
            #add-point:ON CHANGE pmba295
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba296>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba296

            #add-point:AFTER FIELD pmba296
            LET g_pmba_m.pmba296_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba296_desc
            IF NOT cl_null(g_pmba_m.pmba296) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba296 != g_pmba_m_o.pmba296 OR g_pmba_m_o.pmba296 IS NULL )) THEN
               IF g_pmba_m.pmba296 != g_pmba_m_o.pmba296 OR cl_null(g_pmba_m_o.pmba296) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2066',g_pmba_m.pmba296) THEN
                     LET g_pmba_m.pmba296 = g_pmba_m_o.pmba296
                     CALL s_desc_get_acc_desc('2066',g_pmba_m.pmba296)
                        RETURNING g_pmba_m.pmba296_desc
                     DISPLAY BY NAME g_pmba_m.pmba296_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2066',g_pmba_m.pmba296)
               RETURNING g_pmba_m.pmba296_desc
            DISPLAY BY NAME g_pmba_m.pmba296_desc
            LET g_pmba_m_o.pmba296 = g_pmba_m.pmba296
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba296
            #add-point:BEFORE FIELD pmba296
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba296
            #add-point:ON CHANGE pmba296
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba297>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba297

            #add-point:AFTER FIELD pmba297
            LET g_pmba_m.pmba297_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba297_desc
            IF NOT cl_null(g_pmba_m.pmba297) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba297 != g_pmba_m_o.pmba297 OR g_pmba_m_o.pmba297 IS NULL )) THEN
               IF g_pmba_m.pmba297 != g_pmba_m_o.pmba297 OR cl_null(g_pmba_m_o.pmba297) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2067',g_pmba_m.pmba297) THEN
                     LET g_pmba_m.pmba297 = g_pmba_m_o.pmba297
                     CALL s_desc_get_acc_desc('2067',g_pmba_m.pmba297)
                        RETURNING g_pmba_m.pmba297_desc
                     DISPLAY BY NAME g_pmba_m.pmba297_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2067',g_pmba_m.pmba297)
               RETURNING g_pmba_m.pmba297_desc
            DISPLAY BY NAME g_pmba_m.pmba297_desc
            LET g_pmba_m_o.pmba297 = g_pmba_m.pmba297
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba297
            #add-point:BEFORE FIELD pmba297
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba297
            #add-point:ON CHANGE pmba297
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba298>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba298

            #add-point:AFTER FIELD pmba298
            LET g_pmba_m.pmba298_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba298_desc
            IF NOT cl_null(g_pmba_m.pmba298) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba298 != g_pmba_m_o.pmba298 OR g_pmba_m_o.pmba298 IS NULL )) THEN
               IF g_pmba_m.pmba298 != g_pmba_m_o.pmba298 OR cl_null(g_pmba_m_o.pmba298) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2068',g_pmba_m.pmba298) THEN
                     LET g_pmba_m.pmba298 = g_pmba_m_o.pmba298
                     CALL s_desc_get_acc_desc('2068',g_pmba_m.pmba298)
                        RETURNING g_pmba_m.pmba298_desc
                     DISPLAY BY NAME g_pmba_m.pmba298_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2068',g_pmba_m.pmba298)
               RETURNING g_pmba_m.pmba298_desc
            DISPLAY BY NAME g_pmba_m.pmba298_desc
            LET g_pmba_m_o.pmba298 = g_pmba_m.pmba298
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba298
            #add-point:BEFORE FIELD pmba298
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba298
            #add-point:ON CHANGE pmba298
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba299>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba299

            #add-point:AFTER FIELD pmba299
            LET g_pmba_m.pmba299_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba299_desc
            IF NOT cl_null(g_pmba_m.pmba299) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba299 != g_pmba_m_o.pmba299 OR g_pmba_m_o.pmba299 IS NULL )) THEN
               IF g_pmba_m.pmba299 != g_pmba_m_o.pmba299 OR cl_null(g_pmba_m_o.pmba299) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2069',g_pmba_m.pmba299) THEN
                     LET g_pmba_m.pmba299 = g_pmba_m_o.pmba299
                     CALL s_desc_get_acc_desc('2069',g_pmba_m.pmba299)
                        RETURNING g_pmba_m.pmba299_desc
                     DISPLAY BY NAME g_pmba_m.pmba299_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2069',g_pmba_m.pmba299)
               RETURNING g_pmba_m.pmba299_desc
            DISPLAY BY NAME g_pmba_m.pmba299_desc
            LET g_pmba_m_o.pmba299 = g_pmba_m.pmba299
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba299
            #add-point:BEFORE FIELD pmba299
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba299
            #add-point:ON CHANGE pmba299
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba300>>----
         #此段落由子樣板a02產生
         AFTER FIELD pmba300

            #add-point:AFTER FIELD pmba300
            LET g_pmba_m.pmba300_desc = ' '
            DISPLAY BY NAME g_pmba_m.pmba300_desc
            IF NOT cl_null(g_pmba_m.pmba300) THEN
               #150427-00012#2 20150504 by BeckXie--mark
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmba_m.pmba300 != g_pmba_m_o.pmba293 OR g_pmba_m_o.pmba293 IS NULL )) THEN
               IF g_pmba_m.pmba300 != g_pmba_m_o.pmba293 OR cl_null(g_pmba_m_o.pmba293) THEN   #150427-00012#2 20150504 by BeckXie--add
                  IF NOT s_azzi650_chk_exist('2070',g_pmba_m.pmba300) THEN
                     LET g_pmba_m.pmba300 = g_pmba_m_o.pmba300
                     CALL s_desc_get_acc_desc('2070',g_pmba_m.pmba300)
                        RETURNING g_pmba_m.pmba300_desc
                     DISPLAY BY NAME g_pmba_m.pmba300_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2070',g_pmba_m.pmba300)
               RETURNING g_pmba_m.pmba300_desc
            DISPLAY BY NAME g_pmba_m.pmba300_desc
            LET g_pmba_m_o.pmba300 = g_pmba_m.pmba300
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pmba300
            #add-point:BEFORE FIELD pmba300
                      {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pmba300
            #add-point:ON CHANGE pmba300
                      {#ADP版次:1#}
            #END add-point

 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<pmba095>>----
         #Ctrlp:input.c.pmba095
         ON ACTION controlp INFIELD pmba095
            #add-point:ON ACTION controlp INFIELD pmba095
            #此段落由子樣板a07產生
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba095             #給予default值

            #給予arg
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmbaunit',g_site,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_pmba_m.pmba095 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba095 TO pmba095              #顯示到畫面上
            CALL s_desc_get_department_desc(g_pmba_m.pmba095)
               RETURNING g_pmba_m.pmba095_desc
            DISPLAY BY NAME g_pmba_m.pmba095_desc
            NEXT FIELD pmba095                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmbadocno>>----
         #Ctrlp:input.c.pmba001
         ON ACTION controlp INFIELD pmbadocno
            #add-point:ON ACTION controlp INFIELD pmbadocno
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmbadocno             #給予default值

            LET g_qryparam.arg1 = g_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog    #單據性質

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_pmba_m.pmbadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmbadocno TO pmbadocno              #顯示到畫面上

            NEXT FIELD pmbadocno  
               {#ADP版次:1#}
            #END add-point

         #----<<pmba001>>----
         #Ctrlp:input.c.pmba001
         ON ACTION controlp INFIELD pmba001
            #add-point:ON ACTION controlp INFIELD pmba001
            #此段落由子樣板a07產生            
            #開窗i段
            IF g_pmba_m.pmba000 = 'U' THEN
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_pmba_m.pmba001     #給予default值
              #160908-00032#1 --b  160908 modify by rainy 開窗改為q_pmaa001_18()
			      #LET g_qryparam.where = " pmaa002 = '2' AND pmaa230 = '2'"
               #CALL q_pmaa001_5()    
               CALL q_pmaa001_18()                           #呼叫開窗
              #160908-00032#1 --e
                                        #呼叫開窗
               LET g_pmba_m.pmba001 = g_qryparam.return1      #將開窗取得的值回傳到變數
               DISPLAY g_pmba_m.pmba001 TO pmba001            #顯示到畫面上
               NEXT FIELD pmba001
            END IF
               {#ADP版次:1#}
            #END add-point

         #----<<pmbal003>>----
         #Ctrlp:input.c.pmbal003
#         ON ACTION controlp INFIELD pmbal003
            #add-point:ON ACTION controlp INFIELD pmbal003
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbal002>>----
         #Ctrlp:input.c.pmbal002
#         ON ACTION controlp INFIELD pmbal002
            #add-point:ON ACTION controlp INFIELD pmbal002
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbal004>>----
         #Ctrlp:input.c.pmbal004
#         ON ACTION controlp INFIELD pmbal004
            #add-point:ON ACTION controlp INFIELD pmbal004
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba005>>----
         #Ctrlp:input.c.pmba005
         ON ACTION controlp INFIELD pmba005
            #add-point:ON ACTION controlp INFIELD pmba005
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba005             #給予default值

            #給予arg
            CALL q_pmaa001_14()                                #呼叫開窗

            LET g_pmba_m.pmba005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba005 TO pmba005              #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba005)
               RETURNING g_pmba_m.pmba005_desc
            DISPLAY BY NAME g_pmba_m.pmba005_desc
            NEXT FIELD pmba005                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba006>>----
         #Ctrlp:input.c.pmba006
         ON ACTION controlp INFIELD pmba006
            #add-point:ON ACTION controlp INFIELD pmba006
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #客戶性質
            LET g_qryparam.arg2 = "2" #客戶經營類別

            CALL q_pmaa001_12()                                #呼叫開窗

            LET g_pmba_m.pmba006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba006 TO pmba006              #顯示到畫面上
            CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba006)
               RETURNING g_pmba_m.pmba006_desc
            DISPLAY BY NAME g_pmba_m.pmba006_desc
            NEXT FIELD pmba006                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba090>>----
         #Ctrlp:input.c.pmba090
         ON ACTION controlp INFIELD pmba090
            #add-point:ON ACTION controlp INFIELD pmba090
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba090             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "281" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba090 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba090 TO pmba090              #顯示到畫面上
            CALL s_desc_get_acc_desc('281',g_pmba_m.pmba090)
               RETURNING g_pmba_m.pmba090_desc
            DISPLAY BY NAME g_pmba_m.pmba090_desc
            NEXT FIELD pmba090                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba026>>----
         #Ctrlp:input.c.pmba026
         ON ACTION controlp INFIELD pmba026
            #add-point:ON ACTION controlp INFIELD pmba026
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "250" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba026 TO pmba026              #顯示到畫面上
            CALL s_desc_get_acc_desc('250',g_pmba_m.pmba026)
               RETURNING g_pmba_m.pmba026_desc
            DISPLAY BY NAME g_pmba_m.pmba026_desc
            NEXT FIELD pmba026                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba221>>----
         #Ctrlp:input.c.pmba221
         ON ACTION controlp INFIELD pmba221
            #add-point:ON ACTION controlp INFIELD pmba221
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba221             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #

            CALL q_oojd001_1()                                #呼叫開窗

            LET g_pmba_m.pmba221 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba221 TO pmba221              #顯示到畫面上
            CALL s_desc_get_oojdl003_desc(g_pmba_m.pmba221)
               RETURNING g_pmba_m.pmba221_desc
            DISPLAY BY NAME g_pmba_m.pmba221_desc
            NEXT FIELD pmba221                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba232>>----
         #Ctrlp:input.c.pmba232
         ON ACTION controlp INFIELD pmba232
            #add-point:ON ACTION controlp INFIELD pmba232
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba232             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2072" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba232 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba232 TO pmba232              #顯示到畫面上
            CALL s_desc_get_acc_desc('2072',g_pmba_m.pmba232)
               RETURNING g_pmba_m.pmba232_desc
            DISPLAY BY NAME g_pmba_m.pmba232_desc
            NEXT FIELD pmba232                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba241>>----
         #Ctrlp:input.c.pmba241
         ON ACTION controlp INFIELD pmba241
            #add-point:ON ACTION controlp INFIELD pmba241
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmba_m.pmba241      #給予default值
            #給予arg
            LET g_qryparam.arg1 = "1"
            CALL q_dbaa001_1()                                #呼叫開窗
            LET g_pmba_m.pmba241 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmba_m.pmba241 TO pmba241             #顯示到畫面上
            LET g_pmba_m.pmba241_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
            DISPLAY BY NAME g_pmba_m.pmba241_desc
            NEXT FIELD pmba241                              #返回原欄位
            {#ADP版次:1#}
            #END add-point
         
         #Ctrlp:input.c.pmba242
         ON ACTION controlp INFIELD pmba242
            #add-point:ON ACTION controlp INFIELD pmba242
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmba_m.pmba242      #給予default值
            IF NOT cl_null(g_pmba_m.pmba241) THEN
               LET g_qryparam.arg1 = "2"
               LET g_qryparam.arg2 = g_pmba_m.pmba241
               CALL q_dbaa001_2()                                #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = "2"
               CALL q_dbaa001_1()
            END IF
            LET g_pmba_m.pmba242 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmba_m.pmba242 TO pmba242             #顯示到畫面上
            LET g_pmba_m.pmba242_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba242)
            DISPLAY BY NAME g_pmba_m.pmba242_desc
            NEXT FIELD pmba242                              #返回原欄位
            #END add-point

         #Ctrlp:input.c.pmba243
         ON ACTION controlp INFIELD pmba243
            #add-point:ON ACTION controlp INFIELD pmba243
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmba_m.pmba243      #給予default值
            IF NOT cl_null(g_pmba_m.pmba242) THEN
               LET g_qryparam.arg1 = "3"
               LET g_qryparam.arg2 = g_pmba_m.pmba242
               CALL  q_dbaa001_2()                                #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = "3"
               CALL  q_dbaa001_1()                                #呼叫開窗
            END IF
            LET g_pmba_m.pmba243 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmba_m.pmba243 TO pmba243             #顯示到畫面上
            LET g_pmba_m.pmba243_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba243)
            DISPLAY BY NAME g_pmba_m.pmba243_desc
            NEXT FIELD pmba243                              #返回原欄位
            #END add-point

         #Ctrlp:input.c.pmba244
         ON ACTION controlp INFIELD pmba244
            #add-point:ON ACTION controlp INFIELD pmba244
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmba_m.pmba244      #給予default值
            IF NOT cl_null(g_pmba_m.pmba243) THEN
               LET g_qryparam.arg1 = "4"
               LET g_qryparam.arg2 = g_pmba_m.pmba243
               CALL q_dbaa001_2()                                #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = "4"
               CALL q_dbaa001_1()                                #呼叫開窗
            END IF
            LET g_pmba_m.pmba244 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_pmba_m.pmba244 TO pmba244             #顯示到畫面上
            LET g_pmba_m.pmba244_desc = s_desc_get_dbaa001_desc(g_pmba_m.pmba244)
            DISPLAY BY NAME g_pmba_m.pmba244_desc
            NEXT FIELD pmba244                              #返回原欄位
            #END add-point

         #----<<pmba200>>----
         #Ctrlp:input.c.pmba200
#         ON ACTION controlp INFIELD pmba200
            #add-point:ON ACTION controlp INFIELD pmba200
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba201>>----
         #Ctrlp:input.c.pmba201
#         ON ACTION controlp INFIELD pmba201
            #add-point:ON ACTION controlp INFIELD pmba201
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba027>>----
         #Ctrlp:input.c.pmba027
#         ON ACTION controlp INFIELD pmba027
            #add-point:ON ACTION controlp INFIELD pmba027
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba004>>----
         #Ctrlp:input.c.pmba004
#         ON ACTION controlp INFIELD pmba004
            #add-point:ON ACTION controlp INFIELD pmba004
            
            #END add-point

         #----<<pmbastus>>----
         #Ctrlp:input.c.pmbastus
#         ON ACTION controlp INFIELD pmbastus
            #add-point:ON ACTION controlp INFIELD pmbastus
                      {#ADP版次:1#}
            #END add-point

         #----<<pmbaownid>>----
         #----<<pmbaowndp>>----
         #----<<pmbacrtid>>----
         #----<<pmbacrtdp>>----
         #----<<pmbacrtdt>>----
         #----<<pmbamodid>>----
         #----<<pmbamoddt>>----
         #----<<pmbacnfid>>----
         #----<<pmbacnfdt>>----
         #----<<pmba017>>----
         #Ctrlp:input.c.pmba017
#         ON ACTION controlp INFIELD pmba017
            #add-point:ON ACTION controlp INFIELD pmba017
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba016>>----
         #Ctrlp:input.c.pmba016
#         ON ACTION controlp INFIELD pmba016
            #add-point:ON ACTION controlp INFIELD pmba016
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba018>>----
         #Ctrlp:input.c.pmba018
#         ON ACTION controlp INFIELD pmba018
            #add-point:ON ACTION controlp INFIELD pmba018
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba019>>----
         #Ctrlp:input.c.pmba019
         ON ACTION controlp INFIELD pmba019
            #add-point:ON ACTION controlp INFIELD pmba019
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #營運據點

            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_pmba_m.pmba019 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba019 TO pmba019              #顯示到畫面上
            CALL s_desc_get_currency_desc(g_pmba_m.pmba019)
               RETURNING g_pmba_m.pmba019_desc
            DISPLAY BY NAME g_pmba_m.pmba019_desc
            NEXT FIELD pmba019                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba021>>----
         #Ctrlp:input.c.pmba021
#         ON ACTION controlp INFIELD pmba021
            #add-point:ON ACTION controlp INFIELD pmba021
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba022>>----
         #Ctrlp:input.c.pmba022
         ON ACTION controlp INFIELD pmba022
            #add-point:ON ACTION controlp INFIELD pmba022
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #營運據點

            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_pmba_m.pmba022 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba022 TO pmba022              #顯示到畫面上
            CALL s_desc_get_currency_desc(g_pmba_m.pmba022)
               RETURNING g_pmba_m.pmba022_desc
            DISPLAY BY NAME g_pmba_m.pmba022_desc
            NEXT FIELD pmba022                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba020>>----
         #Ctrlp:input.c.pmba020
#         ON ACTION controlp INFIELD pmba020
            #add-point:ON ACTION controlp INFIELD pmba020
                      {#ADP版次:1#}
            #END add-point

         #----<<ooff013>>----
         #Ctrlp:input.c.ooff013
#         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013
                      {#ADP版次:1#}
            #END add-point

         #----<<pmba291>>----
         #Ctrlp:input.c.pmba291
         ON ACTION controlp INFIELD pmba291
            #add-point:ON ACTION controlp INFIELD pmba291
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba291             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2061" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba291 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba291 TO pmba291              #顯示到畫面上
            CALL s_desc_get_acc_desc('2061',g_pmba_m.pmba291)
               RETURNING g_pmba_m.pmba291_desc
            DISPLAY BY NAME g_pmba_m.pmba291_desc
            NEXT FIELD pmba291                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba292>>----
         #Ctrlp:input.c.pmba292
         ON ACTION controlp INFIELD pmba292
            #add-point:ON ACTION controlp INFIELD pmba292
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba292             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2062" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba292 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba292 TO pmba292              #顯示到畫面上
            CALL s_desc_get_acc_desc('2062',g_pmba_m.pmba292)
               RETURNING g_pmba_m.pmba292_desc
            DISPLAY BY NAME g_pmba_m.pmba292_desc
            NEXT FIELD pmba292                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba293>>----
         #Ctrlp:input.c.pmba293
         ON ACTION controlp INFIELD pmba293
            #add-point:ON ACTION controlp INFIELD pmba293
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba293             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2063" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba293 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba293 TO pmba293              #顯示到畫面上
            CALL s_desc_get_acc_desc('2063',g_pmba_m.pmba293)
               RETURNING g_pmba_m.pmba293_desc
            DISPLAY BY NAME g_pmba_m.pmba293_desc
            NEXT FIELD pmba293                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba294>>----
         #Ctrlp:input.c.pmba294
         ON ACTION controlp INFIELD pmba294
            #add-point:ON ACTION controlp INFIELD pmba294
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba294             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2064" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba294 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba294 TO pmba294              #顯示到畫面上
            CALL s_desc_get_acc_desc('2064',g_pmba_m.pmba294)
               RETURNING g_pmba_m.pmba294_desc
            DISPLAY BY NAME g_pmba_m.pmba294_desc
            NEXT FIELD pmba294                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba295>>----
         #Ctrlp:input.c.pmba295
         ON ACTION controlp INFIELD pmba295
            #add-point:ON ACTION controlp INFIELD pmba295
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba295             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2065" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba295 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba295 TO pmba295              #顯示到畫面上
            CALL s_desc_get_acc_desc('2065',g_pmba_m.pmba295)
               RETURNING g_pmba_m.pmba295_desc
            DISPLAY BY NAME g_pmba_m.pmba295_desc
            NEXT FIELD pmba295                          #返回原欄位

          {#ADP版次:1#}
            #END add-point
         #----<<pmba296>>----
         #Ctrlp:input.c.pmba296
         ON ACTION controlp INFIELD pmba296
            #add-point:ON ACTION controlp INFIELD pmba296
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba296             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2066" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba296 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba296 TO pmba296              #顯示到畫面上
            CALL s_desc_get_acc_desc('2066',g_pmba_m.pmba296)
               RETURNING g_pmba_m.pmba296_desc
            DISPLAY BY NAME g_pmba_m.pmba296_desc
            NEXT FIELD pmba296                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba297>>----
         #Ctrlp:input.c.pmba297
         ON ACTION controlp INFIELD pmba297
            #add-point:ON ACTION controlp INFIELD pmba297
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba297             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2067" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba297 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba297 TO pmba297              #顯示到畫面上
            CALL s_desc_get_acc_desc('2067',g_pmba_m.pmba297)
               RETURNING g_pmba_m.pmba297_desc
            DISPLAY BY NAME g_pmba_m.pmba297_desc
            NEXT FIELD pmba297                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba298>>----
         #Ctrlp:input.c.pmba298
         ON ACTION controlp INFIELD pmba298
            #add-point:ON ACTION controlp INFIELD pmba298
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba298             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2068" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba298 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba298 TO pmba298              #顯示到畫面上
            CALL s_desc_get_acc_desc('2068',g_pmba_m.pmba298)
               RETURNING g_pmba_m.pmba298_desc
            DISPLAY BY NAME g_pmba_m.pmba298_desc
            NEXT FIELD pmba298                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba299>>----
         #Ctrlp:input.c.pmba299
         ON ACTION controlp INFIELD pmba299
            #add-point:ON ACTION controlp INFIELD pmba299
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba299             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2069" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba299 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba299 TO pmba299              #顯示到畫面上
            CALL s_desc_get_acc_desc('2069',g_pmba_m.pmba299)
               RETURNING g_pmba_m.pmba299_desc
            DISPLAY BY NAME g_pmba_m.pmba299_desc
            NEXT FIELD pmba299                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pmba300>>----
         #Ctrlp:input.c.pmba300
         ON ACTION controlp INFIELD pmba300
            #add-point:ON ACTION controlp INFIELD pmba300
            #此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmba_m.pmba300             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2070" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmba_m.pmba300 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmba_m.pmba300 TO pmba300              #顯示到畫面上
            CALL s_desc_get_acc_desc('2070',g_pmba_m.pmba300)
               RETURNING g_pmba_m.pmba300_desc
            DISPLAY BY NAME g_pmba_m.pmba300_desc
            NEXT FIELD pmba300                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

 #欄位開窗

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()   #錯誤訊息統整顯示

            IF p_cmd <> "u" THEN
               LET l_count = 1

               SELECT COUNT(*) INTO l_count FROM pmba_t
                WHERE pmbaent = g_enterprise AND pmbadocno = g_pmba_m.pmbadocno

               IF l_count = 0 THEN

                  #add-point:單頭新增前
                  IF NOT s_aooi200_chk_slip(g_site,'',g_pmba_m.pmbadocno,g_prog) THEN
                     LET g_pmba_m.pmbadocno = ''
                     NEXT FIELD pmbadocno
                  END IF
                  
                  #160704-00026#1 20160711 add by beckxie---S
                  #備份單據別
                  LET l_bkdocno = g_pmba_m.pmbadocno
                  #160704-00026#1 20160711 add by beckxie---E
                  
                  #單據編號(pmbadocno)自動編號
                  CALL s_aooi200_gen_docno(g_site,g_pmba_m.pmbadocno,g_pmba_m.pmbadocdt,g_prog)
                     RETURNING l_flag,g_pmba_m.pmbadocno
                  IF NOT l_flag THEN
                     NEXT FIELD pmbadocno
                  END IF
                  
                  #160704-00026#1 20160711 add by beckxie---S
                  #更新開窗維護多語言單號key值 
                  UPDATE pmbal_t SET pmbaldocno = g_pmba_m.pmbadocno
                   WHERE pmbalent = g_enterprise
                     AND pmbaldocno = l_bkdocno
                  LET g_master_multi_table_t.pmbaldocno = g_pmba_m.pmbadocno
                  #160704-00026#1 20160711 add by beckxie---E
                  
                  #聯絡對象識別碼(pmba027)自動編號
                  IF cl_null(g_pmba_m.pmba027) THEN
                     CALL s_transaction_begin()
                     CALL s_aooi350_ins_oofa('3',g_pmba_m.pmbadocno,'') RETURNING l_success,g_pmba_m.pmba027
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD pmbadocno
                     END IF
                  END IF                  {#ADP版次:1#}
                  #end add-point

                  INSERT INTO pmba_t (pmbaent,pmba095,pmba000,pmbadocdt,pmbadocno,pmba001,pmbaacti,pmba005,
                                      pmba006,pmba090,pmba026,pmba221,pmba232,pmba200,pmba201,
                                      pmba027,pmba004,pmba241,pmba242,pmba243,pmba244,pmba002,
                                      pmba230,pmbastus,pmbaownid,pmbaowndp,
                                      pmbacrtid,pmbacrtdp,pmbacrtdt,pmbamodid,pmbamoddt,pmbacnfid,pmbacnfdt,
                                      pmba017,pmba016,pmba018,pmba019,pmba021,pmba022,pmba020,pmba291,
                                      pmba292,pmba293,pmba294,pmba295,pmba296,pmba297,pmba298,pmba299,pmba300)
                  VALUES (g_enterprise,g_pmba_m.pmba095,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,g_pmba_m.pmbadocno,
                          g_pmba_m.pmba001,g_pmba_m.pmbaacti,g_pmba_m.pmba005,g_pmba_m.pmba006,g_pmba_m.pmba090,
                          g_pmba_m.pmba026,g_pmba_m.pmba221,g_pmba_m.pmba232,g_pmba_m.pmba200,g_pmba_m.pmba201,
                          g_pmba_m.pmba027,g_pmba_m.pmba004,g_pmba_m.pmba241,g_pmba_m.pmba242,g_pmba_m.pmba243,
                          g_pmba_m.pmba244,g_pmba_m.pmba002,g_pmba_m.pmba230,g_pmba_m.pmbastus,
                          g_pmba_m.pmbaownid,g_pmba_m.pmbaowndp,g_pmba_m.pmbacrtid,g_pmba_m.pmbacrtdp,
                          g_pmba_m.pmbacrtdt,g_pmba_m.pmbamodid,g_pmba_m.pmbamoddt,g_pmba_m.pmbacnfid,
                          g_pmba_m.pmbacnfdt,g_pmba_m.pmba017,g_pmba_m.pmba016,g_pmba_m.pmba018,g_pmba_m.pmba019,
                          g_pmba_m.pmba021,g_pmba_m.pmba022,g_pmba_m.pmba020,g_pmba_m.pmba291,g_pmba_m.pmba292,
                          g_pmba_m.pmba293,g_pmba_m.pmba294,g_pmba_m.pmba295,g_pmba_m.pmba296,g_pmba_m.pmba297,
                          g_pmba_m.pmba298,g_pmba_m.pmba299,g_pmba_m.pmba300)


                  #add-point:單頭新增中
                  
                  {#ADP版次:1#}
                  #end add-point

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmba_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF



                  #資料多語言用-增/改
                  INITIALIZE l_var_keys TO NULL
                  INITIALIZE l_field_keys TO NULL
                  INITIALIZE l_vars TO NULL
                  INITIALIZE l_fields TO NULL
                  IF g_pmba_m.pmbadocno = g_master_multi_table_t.pmbaldocno AND
                  g_pmba_m.pmbal003 = g_master_multi_table_t.pmbal003 AND
                  g_pmba_m.pmbal002 = g_master_multi_table_t.pmbal002 AND
                  g_pmba_m.pmbal004 = g_master_multi_table_t.pmbal004  THEN
               ELSE
                  LET l_var_keys[01] = g_pmba_m.pmbadocno
                  LET l_field_keys[01] = 'pmbaldocno'
                  LET l_var_keys_bak[01] = g_master_multi_table_t.pmbaldocno
                  LET l_var_keys[02] = g_dlang
                  LET l_field_keys[02] = 'pmbal001'
                  LET l_var_keys_bak[02] = g_dlang
                  LET l_vars[01] = g_pmba_m.pmbal003
                  LET l_fields[01] = 'pmbal003'
                  LET l_vars[02] = g_pmba_m.pmbal002
                  LET l_fields[02] = 'pmbal002'
                  LET l_vars[03] = g_pmba_m.pmbal004
                  LET l_fields[03] = 'pmbal004'
                  LET l_vars[04] = g_enterprise
                  LET l_fields[04] = 'pmbalent'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pmbal_t')
               END IF


                  #add-point:單頭新增後
                  #更新ooff_t 備註
                  IF NOT cl_null(g_pmba_m.pmbadocno) THEN
                     IF NOT cl_null(g_pmba_m.ooff013) THEN
                        LET l_success = ''
                        CALL s_aooi360_gen('2',g_pmba_m.pmbadocno,'','','','','','','','','','4',g_pmba_m.ooff013) RETURNING l_success
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooff_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CONTINUE DIALOG
                        END IF
                     ELSE
                        CALL s_aooi360_del('2',g_pmba_m.pmbadocno,'','','','','','','','','','4') RETURNING l_success
                        IF NOT l_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooff_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CONTINUE DIALOG
                        END IF
                     END IF
                  END IF
                  IF NOT cl_null(g_pmba_m.pmba027) THEN
                     LET g_pmaa027_d = g_pmba_m.pmba027
                     CALL aooi350_01_b_fill(g_pmaa027_d)
                     CALL aooi350_02_b_fill(g_pmaa027_d)
                  END IF                    
                  IF g_pmba_m.pmba000 = 'U' THEN
                     CALL adbt201_carry_detail()
                     IF NOT cl_null(g_errno) THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
                  LET p_cmd = 'u'                  {#ADP版次:1#}
                  #end add-point

                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_pmba_m.pmbadocno"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               END IF
            ELSE
               #add-point:單頭修改前
               IF cl_null(g_pmba_m.pmba027) THEN
                  CALL s_aooi350_ins_oofa('3',g_pmba_m.pmbadocno,'') RETURNING l_success,g_pmba_m.pmba027
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF          {#ADP版次:1#}
               #end add-point
               UPDATE pmba_t SET (pmba095,pmba000,pmbadocdt,pmbadocno,pmba001,pmbaacti,pmba005,pmba006,pmba090,
                                  pmba026,pmba221,pmba232,pmba200,pmba201,pmba027,pmba004,pmba241,pmba242,pmba243,pmba244,pmbastus,
                                  pmbaownid,pmbaowndp,pmbacrtid,pmbacrtdp,pmbacrtdt,pmbamodid,pmbamoddt,
                                  pmbacnfid,pmbacnfdt,pmba017,pmba016,pmba018,pmba019,pmba021,pmba022,
                                  pmba020,pmba291,pmba292,pmba293,pmba294,pmba295,pmba296,pmba297,pmba298,
                                  pmba299,pmba300) = 
                                 (g_pmba_m.pmba095,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,g_pmba_m.pmbadocno,
                                 g_pmba_m.pmba001,g_pmba_m.pmbaacti,g_pmba_m.pmba005,g_pmba_m.pmba006,
                                 g_pmba_m.pmba090,g_pmba_m.pmba026,g_pmba_m.pmba221,g_pmba_m.pmba232,
                                 g_pmba_m.pmba200,g_pmba_m.pmba201,g_pmba_m.pmba027,g_pmba_m.pmba004,
                                 g_pmba_m.pmba241,g_pmba_m.pmba242,g_pmba_m.pmba243,g_pmba_m.pmba244,
                                 g_pmba_m.pmbastus,g_pmba_m.pmbaownid,g_pmba_m.pmbaowndp,g_pmba_m.pmbacrtid,
                                 g_pmba_m.pmbacrtdp,g_pmba_m.pmbacrtdt,g_pmba_m.pmbamodid,g_pmba_m.pmbamoddt,
                                 g_pmba_m.pmbacnfid,g_pmba_m.pmbacnfdt,g_pmba_m.pmba017,g_pmba_m.pmba016,
                                 g_pmba_m.pmba018,g_pmba_m.pmba019,g_pmba_m.pmba021,g_pmba_m.pmba022,
                                 g_pmba_m.pmba020,g_pmba_m.pmba291,g_pmba_m.pmba292,g_pmba_m.pmba293,
                                 g_pmba_m.pmba294,g_pmba_m.pmba295,g_pmba_m.pmba296,g_pmba_m.pmba297,
                                 g_pmba_m.pmba298,g_pmba_m.pmba299,g_pmba_m.pmba300)
                WHERE pmbaent = g_enterprise AND pmbadocno = g_pmbadocno_t #

               #add-point:單頭修改中
                         {#ADP版次:1#}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pmba_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmba_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  OTHERWISE

                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL
         INITIALIZE l_field_keys TO NULL
         INITIALIZE l_vars TO NULL
         INITIALIZE l_fields TO NULL
         IF g_pmba_m.pmbadocno = g_master_multi_table_t.pmbaldocno AND
         g_pmba_m.pmbal003 = g_master_multi_table_t.pmbal003 AND
         g_pmba_m.pmbal002 = g_master_multi_table_t.pmbal002 AND
         g_pmba_m.pmbal004 = g_master_multi_table_t.pmbal004  THEN
         ELSE
            LET l_var_keys[01] = g_pmba_m.pmbadocno
            LET l_field_keys[01] = 'pmbaldocno'
            LET l_var_keys_bak[01] = g_master_multi_table_t.pmbaldocno
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'pmbal001'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_pmba_m.pmbal003
            LET l_fields[01] = 'pmbal003'
            LET l_vars[02] = g_pmba_m.pmbal002
            LET l_fields[02] = 'pmbal002'
            LET l_vars[03] = g_pmba_m.pmbal004
            LET l_fields[03] = 'pmbal004'
            LET l_vars[04] = g_enterprise
            LET l_fields[04] = 'pmbalent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pmbal_t')
         END IF

                     #add-point:單頭修改後
                     #更新ooff_t 備註
                     IF NOT cl_null(g_pmba_m.pmbadocno) THEN
                        IF NOT cl_null(g_pmba_m.ooff013) THEN
                           LET l_success = ''
                           CALL s_aooi360_gen('2',g_pmba_m.pmbadocno,'','','','','','','','','','4',g_pmba_m.ooff013) RETURNING l_success
                           IF NOT l_success THEN
                              INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooff_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                              CALL s_transaction_end('N','0')
                              CONTINUE DIALOG
                           END IF
                        ELSE
                           CALL s_aooi360_del('2',g_pmba_m.pmbadocno,'','','','','','','','','','4') RETURNING l_success
                           IF NOT l_success THEN
                              INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooff_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                              CALL s_transaction_end('N','0')
                              CONTINUE DIALOG
                           END IF
                        END IF
                     END IF
                    #sakura---mark---str
                    #IF g_pmba_m.pmba000 = 'U' THEN
                    #   CALL adbt201_carry_detail()
                    #   IF NOT cl_null(g_errno) THEN
                    #      CALL s_transaction_end('N','0')
                    #      CONTINUE DIALOG
                    #   END IF
                    #END IF
                    #sakura---mark---str
                     {#ADP版次:1#}
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE
            END IF
            LET g_pmbadocno_t = g_pmba_m.pmbadocno
           #controlp
      END INPUT

      #add-point:input段more input
      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      SUBDIALOG aoo_aooi350_02.aooi350_02_input
      
      BEFORE DIALOG
         #為了修改功能doubleClick可以直接進入單身,需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi350_01"
                  NEXT FIELD oofbstus
               WHEN "s_detail1_aooi350_02"
                  NEXT FIELD oofcstus
               OTHERWISE
                  NEXT FIELD pmba095
            END CASE
         END IF

         IF p_cmd = 'a' THEN
            NEXT FIELD pmba095
         END IF
         {#ADP版次:1#}
      #end add-point

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls 
        #CALL cl_set_head_visible("","AUTO")
        #150414-00003#1 2015/05/06 by s983961--s
       IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
      #150414-00003#1 2015/05/06 by s983961--e   
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:input段after input
             {#ADP版次:1#}
   #end add-point
      
END FUNCTION

PRIVATE FUNCTION adbt201_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE pmba_t.pmbadocno
   DEFINE l_oldno     LIKE pmba_t.pmbadocno

   DEFINE l_master    RECORD LIKE pmba_t.*
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}

   #add-point:reproduce段define
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_doctype       LIKE rtai_t.rtai004          {#ADP版次:1#}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   IF g_pmba_m.pmbadocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_pmbadocno_t = g_pmba_m.pmbadocno


   LET g_pmba_m.pmbadocno = ""

   CALL cl_set_head_visible("","YES")    #150414-00003#1 2015/05/06 by s983961
   CALL adbt201_set_entry("a")
   CALL adbt201_set_no_required("a")
   CALL adbt201_set_required("a") 
   CALL adbt201_set_no_entry("a")

   #公用欄位給予預設值
   #此段落由子樣板a14產生
      LET g_pmba_m.pmbaownid = g_user
      LET g_pmba_m.pmbaowndp = g_dept
      LET g_pmba_m.pmbacrtid = g_user
      LET g_pmba_m.pmbacrtdp = g_dept
      LET g_pmba_m.pmbacrtdt = cl_get_current()
      LET g_pmba_m.pmbamodid = ""
      LET g_pmba_m.pmbamoddt = ""
      #LET g_pmba_m.pmbastus = ""



   #add-point:複製輸入前
   LET g_pmba_m.pmbacnfid = ""
   LET g_pmba_m.pmbacnfdt = ""
   LET g_pmba_m.pmba095 = g_site
   LET g_pmba_m.pmbastus = 'N'
   LET g_pmba_m.pmbacnfid = ''
   LET g_pmba_m.pmbacnfdt = ''
   LET g_pmba_m.pmba002 = '2'
   LET g_pmba_m.pmba230 = '2'
   LET g_pmba_m.pmba001 = ''
   
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_pmba_m.pmba095,g_prog,'1')
      RETURNING r_success,r_doctype
   LET g_pmba_m.pmbadocno = r_doctype
   
   #For 單據別開窗時可以在 營運中心切換時，開出正確的資料
   LET g_ooef004 = ''
   SELECT ooef004 INTO g_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
   LET g_pmba_m_t.* = g_pmba_m.*
   LET g_pmba_m_o.* = g_pmba_m.* 
   #把單身的資料清掉
   LET g_pmba_m.pmba027 = ''
   LET g_pmaa027_d = ''
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()
   {#ADP版次:1#}
   #end add-point

   CALL adbt201_input("r")



   IF INT_FLAG  THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL s_transaction_begin()

   #add-point:單頭複製前
             {#ADP版次:1#}
   #end add-point

   #add-point:單頭複製中
             {#ADP版次:1#}
   #end add-point

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pmba_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #add-point:單頭複製後
             {#ADP版次:1#}
   #end add-point

   CALL s_transaction_end('Y','0')

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " pmbadocno = '", g_pmba_m.pmbadocno CLIPPED, "' "

              , ") "

   LET g_pmbadocno_t = g_pmba_m.pmbadocno


   #add-point:完成複製段落後
             {#ADP版次:1#}
   #end add-point

END FUNCTION

PRIVATE FUNCTION adbt201_show()
   #add-point:show段define
   DEFINE l_ac_t   LIKE type_t.num10   #161117-00022#1 161118 by lori mod:num5 to num10
   {#ADP版次:1#}
   #end add-point

   #add-point:show段之前
   LET g_pmba_m.ooff013 = ''
   SELECT ooff013 INTO g_pmba_m.ooff013
     FROM ooff_t
    WHERE ooffent = g_enterprise
      AND ooff001 = '2'
      AND ooff002 = g_pmba_m.pmbadocno
      AND ooff012 = '4'
   DISPLAY BY NAME g_pmba_m.ooff013          {#ADP版次:1#}
   #end add-point



   LET g_pmba_m_t.* = g_pmba_m.*      #保存單頭舊值

   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_pmba_m.pmbaownid_desc = cl_get_username(g_pmba_m.pmbaownid)
      #LET g_pmba_m.pmbaowndp_desc = cl_get_deptname(g_pmba_m.pmbaowndp)
      #LET g_pmba_m.pmbacrtid_desc = cl_get_username(g_pmba_m.pmbacrtid)
      #LET g_pmba_m.pmbacrtdp_desc = cl_get_deptname(g_pmba_m.pmbacrtdp)
      #LET g_pmba_m.pmbamodid_desc = cl_get_username(g_pmba_m.pmbamodid)
      #LET g_pmba_m.pmbacnfid_desc = cl_get_deptname(g_pmba_m.pmbacnfid)
      ##LET g_pmba_m.pmaapstid_desc = cl_get_deptname(g_pmba_m.pmaapstid)




   #讀入ref值(單頭)
   #add-point:show段reference
   LET l_ac_t = l_ac
   CALL s_desc_get_department_desc(g_pmba_m.pmba095)
      RETURNING g_pmba_m.pmba095_desc
   DISPLAY BY NAME g_pmba_m.pmba095_desc
   CALL adbt201_pmbadocno_ref()
   CALL s_desc_get_oojdl003_desc(g_pmba_m.pmba221)
      RETURNING g_pmba_m.pmba221_desc
   DISPLAY BY NAME g_pmba_m.pmba221_desc
   CALL s_desc_get_acc_desc('2072',g_pmba_m.pmba232)
      RETURNING g_pmba_m.pmba232_desc
   DISPLAY BY NAME g_pmba_m.pmba232_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba005)
      RETURNING g_pmba_m.pmba005_desc
   DISPLAY BY NAME g_pmba_m.pmba005_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba006)
      RETURNING g_pmba_m.pmba006_desc
   DISPLAY BY NAME g_pmba_m.pmba006_desc
   CALL s_desc_get_acc_desc('281',g_pmba_m.pmba090)
      RETURNING g_pmba_m.pmba090_desc
   DISPLAY BY NAME g_pmba_m.pmba090_desc
   CALL s_desc_get_acc_desc('250',g_pmba_m.pmba026)
      RETURNING g_pmba_m.pmba026_desc
   DISPLAY BY NAME g_pmba_m.pmba026_desc
   CALL s_desc_get_currency_desc(g_pmba_m.pmba019)
      RETURNING g_pmba_m.pmba019_desc
   DISPLAY BY NAME g_pmba_m.pmba019_desc
   CALL s_desc_get_currency_desc(g_pmba_m.pmba022)
      RETURNING g_pmba_m.pmba022_desc
   DISPLAY BY NAME g_pmba_m.pmba022_desc
   CALL s_desc_get_acc_desc('2061',g_pmba_m.pmba291)
      RETURNING g_pmba_m.pmba291_desc
   DISPLAY BY NAME g_pmba_m.pmba291_desc
   CALL s_desc_get_acc_desc('2062',g_pmba_m.pmba292)
      RETURNING g_pmba_m.pmba292_desc
   DISPLAY BY NAME g_pmba_m.pmba292_desc
   CALL s_desc_get_acc_desc('2063',g_pmba_m.pmba293)
      RETURNING g_pmba_m.pmba293_desc
   DISPLAY BY NAME g_pmba_m.pmba293_desc
   CALL s_desc_get_acc_desc('2064',g_pmba_m.pmba294)
      RETURNING g_pmba_m.pmba294_desc
   DISPLAY BY NAME g_pmba_m.pmba294_desc
   CALL s_desc_get_acc_desc('2065',g_pmba_m.pmba295)
      RETURNING g_pmba_m.pmba295_desc
   DISPLAY BY NAME g_pmba_m.pmba295_desc
   CALL s_desc_get_acc_desc('2066',g_pmba_m.pmba296)
      RETURNING g_pmba_m.pmba296_desc
   DISPLAY BY NAME g_pmba_m.pmba296_desc
   CALL s_desc_get_acc_desc('2067',g_pmba_m.pmba297)
      RETURNING g_pmba_m.pmba297_desc
   DISPLAY BY NAME g_pmba_m.pmba297_desc
   CALL s_desc_get_acc_desc('2068',g_pmba_m.pmba298)
      RETURNING g_pmba_m.pmba298_desc
   DISPLAY BY NAME g_pmba_m.pmba298_desc
   CALL s_desc_get_acc_desc('2069',g_pmba_m.pmba299)
      RETURNING g_pmba_m.pmba299_desc
   DISPLAY BY NAME g_pmba_m.pmba299_desc
   CALL s_desc_get_acc_desc('2070',g_pmba_m.pmba300)
      RETURNING g_pmba_m.pmba300_desc
   DISPLAY BY NAME g_pmba_m.pmba300_desc

   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
      RETURNING g_pmba_m.pmba241_desc
   DISPLAY BY NAME g_pmba_m.pmba241_desc
   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba242)
      RETURNING g_pmba_m.pmba242_desc
   DISPLAY BY NAME g_pmba_m.pmba242_desc
   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba243)
      RETURNING g_pmba_m.pmba243_desc
   DISPLAY BY NAME g_pmba_m.pmba243_desc
   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba244)
      RETURNING g_pmba_m.pmba244_desc
   DISPLAY BY NAME g_pmba_m.pmba244_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmba_m.pmbaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_pmba_m.pmbaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmba_m.pmbaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmba_m.pmbaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmba_m.pmbaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmba_m.pmbaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmba_m.pmbacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_pmba_m.pmbacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmba_m.pmbacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmba_m.pmbacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmba_m.pmbacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmba_m.pmbacrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmba_m.pmbamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_pmba_m.pmbamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmba_m.pmbamodid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmba_m.pmbacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_pmba_m.pmbacnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmba_m.pmbacnfid_desc
          {#ADP版次:1#}
   #end add-point

   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmba_m.pmba095,g_pmba_m.pmba095_desc,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,
                   g_pmba_m.pmbadocno,g_pmba_m.pmba001,g_pmba_m.pmbaacti,g_pmba_m.pmbal003,g_pmba_m.pmbal002,
                   g_pmba_m.pmbal004,g_pmba_m.pmba005,g_pmba_m.pmba005_desc,g_pmba_m.pmba006,g_pmba_m.pmba006_desc,
                   g_pmba_m.pmba090,g_pmba_m.pmba090_desc,g_pmba_m.pmba026,g_pmba_m.pmba026_desc,g_pmba_m.pmba221,
                   g_pmba_m.pmba221_desc,g_pmba_m.pmba232,g_pmba_m.pmba232_desc,g_pmba_m.pmba200,g_pmba_m.pmba201,
                   g_pmba_m.pmba027,g_pmba_m.pmba004,g_pmba_m.pmba241,g_pmba_m.pmba241_desc,g_pmba_m.pmba242,g_pmba_m.pmba242_desc,
                   g_pmba_m.pmba243,g_pmba_m.pmba243_desc,g_pmba_m.pmba244,g_pmba_m.pmba244_desc,
                   g_pmba_m.pmbastus,g_pmba_m.pmbaownid,g_pmba_m.pmbaownid_desc,
                   g_pmba_m.pmbaowndp,g_pmba_m.pmbaowndp_desc,g_pmba_m.pmbacrtid,g_pmba_m.pmbacrtid_desc,g_pmba_m.pmbacrtdp,
                   g_pmba_m.pmbacrtdp_desc,g_pmba_m.pmbacrtdt,g_pmba_m.pmbamodid,g_pmba_m.pmbamodid_desc,g_pmba_m.pmbamoddt,
                   g_pmba_m.pmbacnfid,g_pmba_m.pmbacnfid_desc,g_pmba_m.pmbacnfdt,g_pmba_m.pmba017,g_pmba_m.pmba016,
                   g_pmba_m.pmba018,g_pmba_m.pmba019,g_pmba_m.pmba019_desc,g_pmba_m.pmba021,g_pmba_m.pmba022,g_pmba_m.pmba022_desc,
                   g_pmba_m.pmba020,g_pmba_m.ooff013,g_pmba_m.pmba291,g_pmba_m.pmba291_desc,g_pmba_m.pmba292,g_pmba_m.pmba292_desc,
                   g_pmba_m.pmba293,g_pmba_m.pmba293_desc,g_pmba_m.pmba294,g_pmba_m.pmba294_desc,g_pmba_m.pmba295,
                   g_pmba_m.pmba295_desc,g_pmba_m.pmba296,g_pmba_m.pmba296_desc,g_pmba_m.pmba297,g_pmba_m.pmba297_desc,
                   g_pmba_m.pmba298,g_pmba_m.pmba298_desc,g_pmba_m.pmba299,g_pmba_m.pmba299_desc,g_pmba_m.pmba300,
                   g_pmba_m.pmba300_desc

   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_pmba_m.pmbastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")

      END CASE



   #add-point:show段之後
   IF NOT cl_null(g_pmba_m.pmba027) THEN
      LET g_pmaa027_d = g_pmba_m.pmba027
      CALL aooi350_01_b_fill(g_pmaa027_d)
      CALL aooi350_02_b_fill(g_pmaa027_d)
   END IF
   LET l_ac = l_ac_t   {#ADP版次:1#}
   #end add-point

END FUNCTION

PRIVATE FUNCTION adbt201_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
      DEFINE  l_success       LIKE type_t.chr1          {#ADP版次:1#}
   #end add-point

   IF g_pmba_m.pmbadocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   CALL adbt201_show()

   CALL s_transaction_begin()

   LET g_pmbadocno_t = g_pmba_m.pmbadocno


   LET g_master_multi_table_t.pmbaldocno = g_pmba_m.pmbadocno
LET g_master_multi_table_t.pmbal003 = g_pmba_m.pmbal003
LET g_master_multi_table_t.pmbal002 = g_pmba_m.pmbal002
LET g_master_multi_table_t.pmbal004 = g_pmba_m.pmbal004


   OPEN adbt201_cl USING g_enterprise,g_pmba_m.pmbadocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adbt201_cl:"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE adbt201_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   FETCH adbt201_cl INTO g_pmba_m.pmba095,g_pmba_m.pmba095_desc,g_pmba_m.pmba000,g_pmba_m.pmbadocdt,
                         g_pmba_m.pmbadocno,g_pmba_m.pmba001,g_pmba_m.pmbaacti,g_pmba_m.pmbal003,g_pmba_m.pmbal002,
                         g_pmba_m.pmbal004,g_pmba_m.pmba005,g_pmba_m.pmba005_desc,g_pmba_m.pmba006,
                         g_pmba_m.pmba006_desc,g_pmba_m.pmba090,g_pmba_m.pmba090_desc,g_pmba_m.pmba026,
                         g_pmba_m.pmba026_desc,g_pmba_m.pmba221,g_pmba_m.pmba221_desc,g_pmba_m.pmba232,
                         g_pmba_m.pmba232_desc,g_pmba_m.pmba200,g_pmba_m.pmba201,g_pmba_m.pmba027,
                         g_pmba_m.pmba004,g_pmba_m.pmba241,g_pmba_m.pmba241_desc,g_pmba_m.pmba242,g_pmba_m.pmba242_desc,
                         g_pmba_m.pmba243,g_pmba_m.pmba243_desc,g_pmba_m.pmba244,g_pmba_m.pmba244_desc,
                         g_pmba_m.pmbastus,g_pmba_m.pmbaownid,g_pmba_m.pmbaownid_desc,
                         g_pmba_m.pmbaowndp,g_pmba_m.pmbaowndp_desc,g_pmba_m.pmbacrtid,g_pmba_m.pmbacrtid_desc,g_pmba_m.pmbacrtdp,
                         g_pmba_m.pmbacrtdp_desc,g_pmba_m.pmbacrtdt,g_pmba_m.pmbamodid,g_pmba_m.pmbamodid_desc,g_pmba_m.pmbamoddt,
                         g_pmba_m.pmbacnfid,g_pmba_m.pmbacnfid_desc,g_pmba_m.pmbacnfdt,g_pmba_m.pmba017,g_pmba_m.pmba016,
                         g_pmba_m.pmba018,g_pmba_m.pmba019,g_pmba_m.pmba019_desc,g_pmba_m.pmba021,
                         g_pmba_m.pmba022,g_pmba_m.pmba022_desc,g_pmba_m.pmba020,g_pmba_m.ooff013,
                         g_pmba_m.pmba291,g_pmba_m.pmba291_desc,g_pmba_m.pmba292,g_pmba_m.pmba292_desc,
                         g_pmba_m.pmba293,g_pmba_m.pmba293_desc,g_pmba_m.pmba294,g_pmba_m.pmba294_desc,
                         g_pmba_m.pmba295,g_pmba_m.pmba295_desc,g_pmba_m.pmba296,g_pmba_m.pmba296_desc,
                         g_pmba_m.pmba297,g_pmba_m.pmba297_desc,g_pmba_m.pmba298,g_pmba_m.pmba298_desc,
                         g_pmba_m.pmba299,g_pmba_m.pmba299_desc,g_pmba_m.pmba300,g_pmba_m.pmba300_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_pmba_m.pmbadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   #160818-00017#6 -s by 08172
   #檢查是否允許此動作
   IF NOT adbt201_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#6 -e by 08172
    IF cl_ask_del_master() THEN 
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "pmbadocno"
      LET g_doc.value1 = g_pmba_m.pmbadocno
      CALL cl_doc_remove()   

      #add-point:單頭刪除前
          {#ADP版次:1#}
      #end add-point

      DELETE FROM pmba_t
       WHERE pmbaent = g_enterprise AND pmbadocno = g_pmba_m.pmbadocno


      #add-point:單頭刪除中
                {#ADP版次:1#}
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmba_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF

      INITIALIZE l_var_keys_bak TO NULL
      INITIALIZE l_field_keys   TO NULL
      LET l_var_keys_bak[01] = g_master_multi_table_t.pmbaldocno
      LET l_field_keys[01] = 'pmbaldocno'
      LET l_var_keys_bak[02] = g_dlang
      LET l_field_keys[02] = 'pmbal001'
      CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'pmbal_t')


      #add-point:單頭刪除後
      IF NOT s_aooi200_del_docno(g_pmba_m.pmbadocno,g_pmba_m.pmbadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      DELETE FROM pmbal_t
       WHERE pmbalent = g_enterprise AND pmbaldocno = g_pmba_m.pmbadocno

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del pmbal_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #刪除ooff_t備註
      LET l_success = ''
      CALL s_aooi360_del('2',g_pmba_m.pmbadocno,'','','','','','','','','','4') RETURNING l_success
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooff_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      IF g_pmba_m.pmba000 = 'I' AND NOT cl_null(g_pmba_m.pmba027) THEN
         IF NOT s_aooi350_del(g_pmba_m.pmba027) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "del oofa_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF           {#ADP版次:1#}
      #end add-point



      CLEAR FORM
      CALL adbt201_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL adbt201_fetch("P")
      ELSE
         CALL adbt201_browser_fill(" 1=1 ","F")
      END IF

   END IF

   CLOSE adbt201_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_pmba_m.pmbadocno,"D")

END FUNCTION

PRIVATE FUNCTION adbt201_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}

   #add-point:ui_browser_refresh段define
             {#ADP版次:1#}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_pmbadocno = g_pmba_m.pmbadocno THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR

   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF

END FUNCTION

PRIVATE FUNCTION adbt201_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
             {#ADP版次:1#}
   #end add-point

   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("pmbadocno",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_entry("pmba095",TRUE)
      CALL cl_set_comp_entry("pmbadocdt",TRUE)
            {#ADP版次:1#}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("pmbaacti,pmba000,pmba001",TRUE)
   {#ADP版次:1#}
   #end add-point

END FUNCTION

PRIVATE FUNCTION adbt201_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
             {#ADP版次:1#}
   #end add-point

   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("pmbadocno",FALSE)
      #add-point:set_no_entry段欄位控制
      CALL cl_set_comp_entry("pmba095",FALSE)
      CALL cl_set_comp_entry("pmbadocdt",FALSE)
      
      IF g_pmba_m.pmba000 = 'U' AND NOT cl_null(g_pmba_m.pmba001)THEN
         CALL cl_set_comp_entry("pmba001",FALSE)
      END IF
            {#ADP版次:1#}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   IF NOT cl_null(g_pmba_m.pmba001) THEN
      CALL cl_set_comp_entry("pmba000",FALSE)
   END IF
   IF g_pmba_m.pmba000 = 'I' THEN
      CALL cl_set_comp_entry("pmbaacti",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'pmbaunit') THEN
      CALL cl_set_comp_entry("pmba095",FALSE)
   END IF
   {#ADP版次:1#}
   #end add-point

END FUNCTION

PRIVATE FUNCTION adbt201_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
             {#ADP版次:1#}
   #end add-point

   #add-point:default_search段開始前
             {#ADP版次:1#}
   #end add-point

   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " pmbadocno = '", g_argv[1], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF

   #add-point:default_search段結束前
             {#ADP版次:1#}
   #end add-point
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
END FUNCTION

PRIVATE FUNCTION adbt201_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
      DEFINE l_success   LIKE type_t.num5          {#ADP版次:1#}
   #end add-point

   #add-point:statechange段開始前
   IF g_pmba_m.pmbastus = 'X' OR g_pmba_m.pmbastus = 'Y' THEN
      RETURN
   END IF          {#ADP版次:1#}
   #end add-point

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_pmba_m.pmbadocno IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   #160818-00017#6 -s by 08172
   #檢查是否允許此動作
   IF NOT adbt201_action_chk() THEN
      CLOSE adbt201_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#6 -e by 08172
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_pmba_m.pmbastus
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"

         END CASE

      #add-point:menu前
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_pmba_m.pmbastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,closed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,closed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,closed",FALSE)

         WHEN "C"
            CALL cl_set_act_visible("confirmed,invalid,unconfirmed,closed",FALSE)
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
      END CASE
      {#ADP版次:1#}
      #end add-point

      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN   #151027-00016#2 20151111 add by beckxie
            LET lc_state = "N"
            #add-point:action控制
            
            #end add-point
         END IF   #151027-00016#2 20151111 add by beckxie
         EXIT MENU
         
      #161122-00006#1 by sakura mark(S)
      #ON ACTION invalid
      #   IF cl_auth_chk_act("invalid") THEN   #151027-00016#2 20151111 add by beckxie
      #      LET lc_state = "X"
      #      #add-point:action控制
      #      
      #      #end add-point
      #   END IF   #151027-00016#2 20151111 add by beckxie
      #   EXIT MENU
      #161122-00006#1 by sakura mark(E)
         
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN   #151027-00016#2 20151111 add by beckxie
            LET lc_state = "Y"
            #add-point:action控制
            
            #end add-point
         END IF   #151027-00016#2 20151111 add by beckxie
         EXIT MENU
      
      #161122-00006#1 by sakura add(S) #調整位置
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
         END IF   
         EXIT MENU
      #161122-00006#1 by sakura add(E) #調整位置
         
      #add-point:stus控制
                {#ADP版次:1#}
      #end add-point

   END MENU

   IF (lc_state <> "N"
      AND lc_state <> "X"

      AND lc_state <> "Y"


      ) OR
      cl_null(lc_state) THEN
      RETURN
   END IF

   #add-point:stus修改前
   CASE lc_state
      WHEN 'Y'
         CALL s_adbt201_conf_chk(g_pmba_m.pmbadocno) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('apm-00348') THEN
               CALL s_transaction_begin()
               CALL s_adbt201_carry_upd(g_pmba_m.pmbadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_adbt201_conf_upd(g_pmba_m.pmbadocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     #160511-00037#5 20160519 add by beckxie---S
                     IF cl_ask_confirm('apm-01111') THEN
                        CALL s_pmab_ins_pmab()
                     END IF
                     #160511-00037#5 20160519 add by beckxie---E
                     CALL s_transaction_end('Y','1')
                  END IF
               END IF
            ELSE
               RETURN
            END IF
         ELSE
            RETURN
         END IF
         
      WHEN 'X'
         CALL s_adbt201_void_chk(g_pmba_m.pmbadocno) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_adbt201_void_upd(g_pmba_m.pmbadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN
            END IF
         ELSE
            RETURN
         END IF
   END CASE         {#ADP版次:1#}
   #end add-point

   UPDATE pmba_t SET pmbastus = lc_state
    WHERE pmbaent = g_enterprise AND pmbadocno = g_pmba_m.pmbadocno


   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")

      END CASE
      LET g_pmba_m.pmbastus = lc_state
      DISPLAY BY NAME g_pmba_m.pmbastus
   END IF

   #add-point:stus修改後
             {#ADP版次:1#}
   #end add-point

   #add-point:statechange段結束前
   CALL adbt201_fetch("")          {#ADP版次:1#}
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 單據編號(pmbadocno)帶出簡稱.全名.助記碼
# Memo...........:
# Usage..........: CALL adbt201_pmbadocno_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/26 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_pmbadocno_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmba_m.pmbadocno
   CALL ap_ref_array2(g_ref_fields,"SELECT pmbal002,pmbal003,pmbal004 FROM pmbal_t WHERE pmbalent='"||g_enterprise||"' AND pmbaldocno=? AND pmbal001='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_pmba_m.pmbal002 = '', g_rtn_fields[1] , ''
   LET g_pmba_m.pmbal003 = '', g_rtn_fields[2] , ''
   LET g_pmba_m.pmbal004 = '', g_rtn_fields[3] , ''
END FUNCTION
################################################################################
# Descriptions...: 當申請類型(pmba000)='I'新增，不存在交易對象主檔(pmaa_t)中且不存在交易對象准入檔(pmba_t)中
#                  當申請類型(pmba000)='U'修改，不存在交易對象主檔(pmaa_t)中且不可存在為拋轉的交易對象准入單(pmba_t)中
# Memo...........:
# Usage..........: CALL adbt201_chk_pmba001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_chk_pmba001()
DEFINE l_cnt    LIKE type_t.num5
DEFINE l_pmaa002   LIKE pmaa_t.pmaa002
DEFINE l_pmaa230   LIKE pmba_t.pmba230
   
   LET g_errno = ''
   CASE g_pmba_m.pmba000
      WHEN 'I'
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = g_pmba_m.pmba001
         IF l_cnt > 0 THEN
            #輸入的交易對象編號已存在 交易對象主檔 中
            LET g_errno = 'apm-00240'
            RETURN
         END IF

         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM pmba_t
          WHERE pmbaent = g_enterprise
            AND pmba001 = g_pmba_m.pmba001
            AND pmbastus != 'X'
         IF l_cnt > 0 THEN
            #輸入的交易對象編號已存在 交易對象准入檔 中
            LET g_errno = 'apm-00241'
            RETURN
         END IF

      WHEN 'U'
         LET l_pmaa002 = ''
         LET l_pmaa230 = ''
         SELECT pmaa002,pmaa230 INTO l_pmaa002,l_pmaa230
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = g_pmba_m.pmba001
         CASE
            WHEN SQLCA.SQLCODE = 100
               #輸入的交易對象編號不存在 交易對象主檔 中
               LET g_errno = 'apm-00242'
               RETURN
            WHEN l_pmaa002 != '2'
               #輸入的交易對象編號　交易對象類型不屬於2.'客戶'
               LET g_errno = 'adb-00019'
               RETURN
            WHEN l_pmaa230 != '2'
               #輸入的交易對象編號　客戶性質不屬於 2.'間接客戶'
               LET g_errno = 'adb-00020'
               RETURN
         END CASE
         

         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM pmba_t
          WHERE pmbaent = g_enterprise
            AND pmbadocno != g_pmba_m.pmbadocno
            AND pmba001 = g_pmba_m.pmba001
            AND pmbastus = 'N'
         IF l_cnt > 0 THEN
            #已存在一張相同交易對象編號,但未拋轉的交易對象准入單!
            LET g_errno = 'apm-00243'
         END IF

      OTHERWISE
         LET g_errno = 'art-00013'
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 當申請類型='U'修改時，帶出交易對象主檔(pmaa_t)中的值
# Memo...........:
# Usage..........: CALL adbt201_carry_pmaa()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_carry_pmaa()
DEFINE l_pmaa RECORD
       pmaa095   LIKE pmaa_t.pmaa095,
       pmaa001   LIKE pmaa_t.pmaa001,
       pmaa005   LIKE pmaa_t.pmaa005,
       pmaa006   LIKE pmaa_t.pmaa006,
       pmaa090   LIKE pmaa_t.pmaa090,
       pmaa026   LIKE pmaa_t.pmaa026,
       pmaa221   LIKE pmaa_t.pmaa221,
       pmaa232   LIKE pmaa_t.pmaa232,
       pmaa200   LIKE pmaa_t.pmaa200,
       pmaa201   LIKE pmaa_t.pmaa201,
       pmaa027   LIKE pmaa_t.pmaa027,
       pmaa002   LIKE pmaa_t.pmaa002,
       pmaa230   LIKE pmaa_t.pmaa230,
       pmaa004   LIKE pmaa_t.pmaa004,
       pmaa241   LIKE pmaa_t.pmaa241,
       pmaa242   LIKE pmaa_t.pmaa242,
       pmaa243   LIKE pmaa_t.pmaa243,
       pmaa244   LIKE pmaa_t.pmaa244,
       pmaa017   LIKE pmaa_t.pmaa017,
       pmaa016   LIKE pmaa_t.pmaa016,
       pmaa018   LIKE pmaa_t.pmaa018,
       pmaa019   LIKE pmaa_t.pmaa019,
       pmaa021   LIKE pmaa_t.pmaa021,
       pmaa022   LIKE pmaa_t.pmaa022,
       pmaa020   LIKE pmaa_t.pmaa020,
       pmaa291   LIKE pmaa_t.pmaa291,
       pmaa292   LIKE pmaa_t.pmaa292,
       pmaa293   LIKE pmaa_t.pmaa293,
       pmaa294   LIKE pmaa_t.pmaa294,
       pmaa295   LIKE pmaa_t.pmaa295,
       pmaa296   LIKE pmaa_t.pmaa296,
       pmaa297   LIKE pmaa_t.pmaa297,
       pmaa298   LIKE pmaa_t.pmaa298,
       pmaa299   LIKE pmaa_t.pmaa299,
       pmaa300   LIKE pmaa_t.pmaa300,
       pmaastus  LIKE pmaa_t.pmaastus
                 END RECORD
DEFINE l_pmaal   RECORD
       pmaal003  LIKE pmaal_t.pmaal003,
       pmaal004  LIKE pmaal_t.pmaal004,
       pmaal005  LIKE pmaal_t.pmaal005
                 END RECORD
DEFINE l_num     LIKE type_t.num5

   INITIALIZE l_pmaa.* TO NULL
   #撈出交易對象主檔(pmaa_t)的值
   SELECT pmaa095,pmaa001,pmaa005,pmaa006,pmaa090,pmaa026,pmaa221,pmaa232,
          pmaa200,pmaa201,pmaa027,pmaa002,pmaa230,pmaa004,pmaa017,pmaa016,
          pmaa018,pmaa019,pmaa021,pmaa022,pmaa020,pmaa291,pmaa292,pmaa293,
          pmaa294,pmaa295,pmaa296,pmaa297,pmaa298,pmaa299,pmaa300,pmaastus
     INTO l_pmaa.*
     FROM pmaa_t
    WHERE pmaa001 = g_pmba_m.pmba001
      AND pmaaent = g_enterprise
   
   LET g_pmaa027_d = l_pmaa.pmaa027   
   #把撈出交易對象主檔(pmaa_t)的值丟給g_pmba_m陣列
   #LET g_pmba_m.pmba095 = l_pmaa.pmaa095
   LET g_pmba_m.pmba001 = l_pmaa.pmaa001
   LET g_pmba_m.pmba005 = l_pmaa.pmaa005
   LET g_pmba_m.pmba006 = l_pmaa.pmaa006
   LET g_pmba_m.pmba090 = l_pmaa.pmaa090
   LET g_pmba_m.pmba026 = l_pmaa.pmaa026
   LET g_pmba_m.pmba221 = l_pmaa.pmaa221
   LET g_pmba_m.pmba232 = l_pmaa.pmaa232
   LET g_pmba_m.pmba200 = l_pmaa.pmaa200
   LET g_pmba_m.pmba201 = l_pmaa.pmaa201
   #LET g_pmba_m.pmba027 = l_pmaa.pmaa027
   LET g_pmba_m.pmba002 = l_pmaa.pmaa002
   LET g_pmba_m.pmba230 = l_pmaa.pmaa230
   LET g_pmba_m.pmba004 = l_pmaa.pmaa004
   LET g_pmba_m.pmba241 = l_pmaa.pmaa241
   LET g_pmba_m.pmba242 = l_pmaa.pmaa242
   LET g_pmba_m.pmba243 = l_pmaa.pmaa243
   LET g_pmba_m.pmba244 = l_pmaa.pmaa244
   LET g_pmba_m.pmba017 = l_pmaa.pmaa017
   LET g_pmba_m.pmba016 = l_pmaa.pmaa016
   LET g_pmba_m.pmba018 = l_pmaa.pmaa018
   LET g_pmba_m.pmba019 = l_pmaa.pmaa019
   LET g_pmba_m.pmba021 = l_pmaa.pmaa021
   LET g_pmba_m.pmba022 = l_pmaa.pmaa022
   LET g_pmba_m.pmba020 = l_pmaa.pmaa020
   LET g_pmba_m.pmba291 = l_pmaa.pmaa291
   LET g_pmba_m.pmba292 = l_pmaa.pmaa292
   LET g_pmba_m.pmba293 = l_pmaa.pmaa293
   LET g_pmba_m.pmba294 = l_pmaa.pmaa294
   LET g_pmba_m.pmba295 = l_pmaa.pmaa295
   LET g_pmba_m.pmba296 = l_pmaa.pmaa296
   LET g_pmba_m.pmba297 = l_pmaa.pmaa297
   LET g_pmba_m.pmba298 = l_pmaa.pmaa298
   LET g_pmba_m.pmba299 = l_pmaa.pmaa299
   LET g_pmba_m.pmba300 = l_pmaa.pmaa300
   
   #把撈出交易對象主檔(pmaa_t)的值丟給g_pmba_m_t陣列(舊值)
   #LET g_pmba_m_t.pmba095 = l_pmaa.pmaa095
   LET g_pmba_m_t.pmba001 = l_pmaa.pmaa001
   LET g_pmba_m_t.pmba005 = l_pmaa.pmaa005
   LET g_pmba_m_t.pmba006 = l_pmaa.pmaa006
   LET g_pmba_m_t.pmba090 = l_pmaa.pmaa090
   LET g_pmba_m_t.pmba026 = l_pmaa.pmaa026
   LET g_pmba_m_t.pmba221 = l_pmaa.pmaa221
   LET g_pmba_m_t.pmba232 = l_pmaa.pmaa232
   LET g_pmba_m_t.pmba200 = l_pmaa.pmaa200
   LET g_pmba_m_t.pmba201 = l_pmaa.pmaa201
   #LET g_pmba_m_t.pmba027 = l_pmaa.pmaa027
   LET g_pmba_m_t.pmba002 = l_pmaa.pmaa002
   LET g_pmba_m_t.pmba230 = l_pmaa.pmaa230
   LET g_pmba_m_t.pmba004 = l_pmaa.pmaa004
   LET g_pmba_m_t.pmba241 = l_pmaa.pmaa241
   LET g_pmba_m_t.pmba242 = l_pmaa.pmaa242
   LET g_pmba_m_t.pmba243 = l_pmaa.pmaa243
   LET g_pmba_m_t.pmba244 = l_pmaa.pmaa244
   LET g_pmba_m_t.pmba017 = l_pmaa.pmaa017
   LET g_pmba_m_t.pmba016 = l_pmaa.pmaa016
   LET g_pmba_m_t.pmba018 = l_pmaa.pmaa018
   LET g_pmba_m_t.pmba019 = l_pmaa.pmaa019
   LET g_pmba_m_t.pmba021 = l_pmaa.pmaa021
   LET g_pmba_m_t.pmba022 = l_pmaa.pmaa022
   LET g_pmba_m_t.pmba020 = l_pmaa.pmaa020
   LET g_pmba_m_t.pmba291 = l_pmaa.pmaa291
   LET g_pmba_m_t.pmba292 = l_pmaa.pmaa292
   LET g_pmba_m_t.pmba293 = l_pmaa.pmaa293
   LET g_pmba_m_t.pmba294 = l_pmaa.pmaa294
   LET g_pmba_m_t.pmba295 = l_pmaa.pmaa295
   LET g_pmba_m_t.pmba296 = l_pmaa.pmaa296
   LET g_pmba_m_t.pmba297 = l_pmaa.pmaa297
   LET g_pmba_m_t.pmba298 = l_pmaa.pmaa298
   LET g_pmba_m_t.pmba299 = l_pmaa.pmaa299
   LET g_pmba_m_t.pmba300 = l_pmaa.pmaa300
   
   #(1)當交易對象主檔(pmaa_t)的狀態碼(pmbaastus)為作廢(X)，
   #   交易對象准入檔(pmba_t)的資料有效(pmbaacti)='N'
   #(2)當交易對象主檔(pmaa_t)的狀態碼(pmbaastus)為未確認(N)或確認(Y)，
   #   交易對象准入檔(pmba_t)的資料有效(pmbaacti)='Y'
   IF l_pmaa.pmaastus = 'X' THEN
      LET g_pmba_m.pmbaacti = 'N'
      LET g_pmba_m_t.pmbaacti = 'N'
   ELSE
      LET g_pmba_m.pmbaacti = 'Y'
      LET g_pmba_m_t.pmbaacti = 'Y'
   END IF
   
   LET g_pmba_m_o.* = g_pmba_m_t.*
   
   DISPLAY BY NAME g_pmba_m.pmba095, g_pmba_m.pmba001, g_pmba_m.pmba005, g_pmba_m.pmba006,
                   g_pmba_m.pmba090, g_pmba_m.pmba026, g_pmba_m.pmba221, g_pmba_m.pmba232,
                   g_pmba_m.pmba200, g_pmba_m.pmba201, g_pmba_m.pmba027, g_pmba_m.pmba002,
                   g_pmba_m.pmba230, g_pmba_m.pmba004, g_pmba_m.pmba241, g_pmba_m.pmba242,
                   g_pmba_m.pmba243, g_pmba_m.pmba244, g_pmba_m.pmba017, g_pmba_m.pmba016,
                   g_pmba_m.pmba018, g_pmba_m.pmba019, g_pmba_m.pmba021, g_pmba_m.pmba022,
                   g_pmba_m.pmba020, g_pmba_m.pmba291, g_pmba_m.pmba292, g_pmba_m.pmba293,
                   g_pmba_m.pmba294, g_pmba_m.pmba295, g_pmba_m.pmba296, g_pmba_m.pmba297,
                   g_pmba_m.pmba298, g_pmba_m.pmba299, g_pmba_m.pmba300, g_pmba_m.pmbastus
   CALL s_desc_get_department_desc(g_pmba_m.pmba095)
      RETURNING g_pmba_m.pmba095_desc
   DISPLAY BY NAME g_pmba_m.pmba095_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba005)
      RETURNING g_pmba_m.pmba005_desc
   DISPLAY BY NAME g_pmba_m.pmba005_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba006)
      RETURNING g_pmba_m.pmba006_desc
   DISPLAY BY NAME g_pmba_m.pmba006_desc
   CALL s_desc_get_acc_desc('281',g_pmba_m.pmba090)
      RETURNING g_pmba_m.pmba090_desc
   DISPLAY BY NAME g_pmba_m.pmba090_desc
   CALL s_desc_get_acc_desc('250',g_pmba_m.pmba026)
      RETURNING g_pmba_m.pmba026_desc
   DISPLAY BY NAME g_pmba_m.pmba026_desc
   CALL s_desc_get_oojdl003_desc(g_pmba_m.pmba221)
      RETURNING g_pmba_m.pmba221_desc
   DISPLAY BY NAME g_pmba_m.pmba221_desc
   CALL s_desc_get_acc_desc('2072',g_pmba_m.pmba232)
      RETURNING g_pmba_m.pmba232_desc
   DISPLAY BY NAME g_pmba_m.pmba232_desc
   CALL s_desc_get_currency_desc(g_pmba_m.pmba019)
      RETURNING g_pmba_m.pmba019_desc
   DISPLAY BY NAME g_pmba_m.pmba019_desc
   CALL s_desc_get_currency_desc(g_pmba_m.pmba022)
      RETURNING g_pmba_m.pmba022_desc
   DISPLAY BY NAME g_pmba_m.pmba022_desc
   CALL s_desc_get_acc_desc('2061',g_pmba_m.pmba291)
      RETURNING g_pmba_m.pmba291_desc
   DISPLAY BY NAME g_pmba_m.pmba291_desc
   CALL s_desc_get_acc_desc('2062',g_pmba_m.pmba292)
      RETURNING g_pmba_m.pmba292_desc
   DISPLAY BY NAME g_pmba_m.pmba292_desc
   CALL s_desc_get_acc_desc('2063',g_pmba_m.pmba293)
      RETURNING g_pmba_m.pmba293_desc
   DISPLAY BY NAME g_pmba_m.pmba293_desc
   CALL s_desc_get_acc_desc('2064',g_pmba_m.pmba294)
      RETURNING g_pmba_m.pmba294_desc
   DISPLAY BY NAME g_pmba_m.pmba294_desc
   CALL s_desc_get_acc_desc('2065',g_pmba_m.pmba295)
      RETURNING g_pmba_m.pmba295_desc
   DISPLAY BY NAME g_pmba_m.pmba295_desc
   CALL s_desc_get_acc_desc('2066',g_pmba_m.pmba296)
      RETURNING g_pmba_m.pmba296_desc
   DISPLAY BY NAME g_pmba_m.pmba296_desc
   CALL s_desc_get_acc_desc('2067',g_pmba_m.pmba297)
      RETURNING g_pmba_m.pmba297_desc
   DISPLAY BY NAME g_pmba_m.pmba297_desc
   CALL s_desc_get_acc_desc('2068',g_pmba_m.pmba298)
      RETURNING g_pmba_m.pmba298_desc
   DISPLAY BY NAME g_pmba_m.pmba298_desc
   CALL s_desc_get_acc_desc('2069',g_pmba_m.pmba299)
      RETURNING g_pmba_m.pmba299_desc
   DISPLAY BY NAME g_pmba_m.pmba299_desc
   CALL s_desc_get_acc_desc('2070',g_pmba_m.pmba300)
      RETURNING g_pmba_m.pmba300_desc
   DISPLAY BY NAME g_pmba_m.pmba300_desc
   #抓取交易對象主檔(pmaa_t)的多語言檔(pmaal_t)   
   INITIALIZE l_pmaal.* TO NULL

   SELECT pmaal003,pmaal004,pmaal005 INTO l_pmaal.*
     FROM pmaal_t
    WHERE pmaal001 = g_pmba_m.pmba001
      AND pmaal002 = g_dlang
      AND pmaalent = g_enterprise

   LET  g_pmba_m.pmbal002 = l_pmaal.pmaal003
   LET  g_pmba_m.pmbal003 = l_pmaal.pmaal004
   LET  g_pmba_m.pmbal004 = l_pmaal.pmaal005

   DISPLAY BY NAME g_pmba_m.pmbal002,g_pmba_m.pmbal003,g_pmba_m.pmbal004
END FUNCTION
################################################################################
# Descriptions...: 必要輸入欄位打開
# Memo...........:
# Usage..........: CALL adbt201_set_required(p_cmd)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/10 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_set_required(p_cmd)
DEFINE p_cmd    LIKE type_t.chr1

   IF g_pmba_m.pmba000 = 'U' THEN
      CALL cl_set_comp_required("pmba001",TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 必要輸入欄位關閉
# Memo...........:
# Usage..........: CALL adbt201_set_no_required(p_cmd)
# Input parameter: p_cmd    狀態
# Return code....: 無
# Date & Author..: 2014/03/10 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_set_no_required(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1

   CALL cl_set_comp_required("pmba001",FALSE)
END FUNCTION
################################################################################
# Descriptions...: 當新增狀態時，由action修改
# Memo...........:
# Usage..........: CALL adbt201_upd_pmba001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/10 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_upd_pmba001()
   IF cl_null(g_pmba_m.pmbadocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00015'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   IF g_pmba_m.pmba000 = 'U' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00014'
      LET g_errparam.extend = g_pmba_m.pmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   LET g_pmba_m_o.* = g_pmba_m.*
   LET g_pmba_m.pmbamodid = g_user
   LET g_pmba_m.pmbamoddt = cl_get_current()

   DISPLAY BY NAME g_pmba_m.pmba001
   CALL s_transaction_begin()
   INPUT BY NAME g_pmba_m.pmba001 WITHOUT DEFAULTS
      BEFORE INPUT

      AFTER FIELD pmba001
         IF NOT cl_null(g_pmba_m.pmba001) THEN
            #150427-00012#2 20150504 by BeckXie--mark
#            IF g_pmba_m.pmba001 != g_pmba_m_o.pmba001 OR g_pmba_m_o.pmba001 IS NULL THEN
            #150427-00012#2 20150504 by BeckXie--add---S
            IF g_pmba_m.pmba001 != g_pmba_m_o.pmba001 OR cl_null(g_pmba_m_o.pmba001) THEN
            #150427-00012#2 20150504 by BeckXie--add---E
               CALL adbt201_chk_pmba001()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_pmba_m.pmba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmba_m.pmba001 = g_pmba_m_o.pmba001
                  NEXT FIELD CURRENT
               END IF
            END IF
         END IF

      AFTER INPUT
         IF INT_FLAG THEN
            EXIT INPUT
         END IF
		 
         UPDATE pmba_t SET pmba001   = g_pmba_m.pmba001,
                           pmbamodid = g_pmba_m.pmbamodid,
                           pmbamoddt = g_pmba_m.pmbamoddt
          WHERE pmbaent = g_enterprise
            AND pmbadocno = g_pmba_m.pmbadocno
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pmba_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE INPUT
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmba_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE INPUT
         END CASE

         CALL s_transaction_end('Y','0')

   END INPUT
END FUNCTION

################################################################################
# Descriptions...: 帶出主檔單身資料
# Memo...........:
# Usage..........: CALL adbt201_carry_detail()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/05 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_carry_detail()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_wc         STRING
   DEFINE l_oofb001    LIKE oofb_t.oofb001
   DEFINE l_oofb001_t  LIKE oofb_t.oofb001
   DEFINE l_oofc001    LIKE oofc_t.oofc001
   DEFINE l_oofc001_t  LIKE oofc_t.oofc001
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_pmaa027    LIKE pmaa_t.pmaa027 #sakura add

   LET g_errno = ''
   IF g_pmba_m.pmba000 = 'I' THEN
      RETURN
   END IF
   
   IF NOT cl_null(g_pmaa027_d) THEN
      #sakura---add---str
      SELECT pmaa027 INTO l_pmaa027
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = g_pmba_m.pmba001        
      #sakura---add---end      
      DECLARE adbt200_oofb_cl CURSOR FOR
         SELECT oofb001
           FROM oofb_t
          WHERE oofbent = g_enterprise
           #AND oofb002 = g_pmaa027_d #sakura mark
            AND oofb002 = l_pmaa027 #sakura add
      
      FOREACH adbt200_oofb_cl INTO l_oofb001_t

         LET l_wc = " oofbent = ",g_enterprise
         CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc)
            RETURNING l_success,l_oofb001
         IF NOT l_success THEN
            LET g_errno = 'oofb001'
            RETURN
         END IF

         LET l_cnt = 1  
         SELECT COUNT(*) INTO l_cnt FROM oofb_t 
          WHERE oofbent = g_enterprise 
            AND oofb001 = l_oofb001
           #AND oofb002 = g_pmba_m.pmba027 #sakura mark
            AND oofb002 = l_pmaa027 #sakura add
 
             
         #資料未重複, 插入新增資料
         IF l_cnt = 0 THEN 
            LET l_sql = " INSERT INTO oofb_t( ",
                        "        oofbstus, oofbent, oofb001, oofb002, oofb003, oofb004, oofb005, oofb006, ",
                        "        oofb007, oofb008, oofb009, oofb010, oofb011, oofb012, oofb013, oofb014, ",
                        "        oofb015, oofb016, oofb017, oofb018, oofbownid, oofbowndp, oofbcrtid, ",
                        "        oofbcrtdp, oofbcrtdt, oofbmodid, oofbmoddt, oofb019 ",
                        "        )",
                        " SELECT oofbstus, oofbent, '",l_oofb001,"','",g_pmba_m.pmba027,"', oofb003, oofb004, oofb005, oofb006, ",
                        "        oofb007, oofb008, oofb009, oofb010, oofb011, oofb012, oofb013, oofb014, ",
                        "        oofb015, oofb016, oofb017, oofb018, oofbownid, oofbowndp, oofbcrtid, ",
                        "        oofbcrtdp, oofbcrtdt, oofbmodid, oofbmoddt, oofb019 ",
                        "   FROM oofb_t ",
                       #"  WHERE oofbent = ",g_enterprise," AND oofb001 = '",l_oofb001_t,"' AND oofb002 = '",g_pmaa027_d,"'" #sakura mark
                        "  WHERE oofbent = ",g_enterprise," AND oofb001 = '",l_oofb001_t,"' AND oofb002 = '",l_pmaa027,"'" #sakura add                        
            PREPARE ins_oofb_pre FROM l_sql
            EXECUTE ins_oofb_pre  
            
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins oofb_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_errno = SQLCA.sqlcode
            END IF
         ELSE    
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = 'INSERT'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_errno = "std-00006"
         END IF
         
         IF NOT cl_null(g_errno) THEN
            RETURN
         END IF
      END FOREACH
      
      DECLARE adbt200_oofc_cl CURSOR FOR
         SELECT oofc001
           FROM oofc_t
          WHERE oofcent = g_enterprise
           #AND oofc002 = g_pmaa027 #sakura mark
            AND oofc002 = l_pmaa027 #sakura add
      
      FOREACH adbt200_oofc_cl INTO l_oofc001_t
                                                         
         LET l_wc = " oofcent = ",g_enterprise
         CALL s_aooi350_get_idno('oofc001','oofc_t',l_wc)
            RETURNING l_success,l_oofc001
         IF NOT l_success THEN
            LET g_errno = 'oofc001'
            RETURN
         END IF

         LET l_cnt = 1  
         SELECT COUNT(*) INTO l_cnt FROM oofc_t 
          WHERE oofcent = g_enterprise 
            AND oofc001 = l_oofc001
           #AND oofc002 = g_pmba_m.pmba027 #sakura mark
            AND oofc002 = l_pmaa027 #sakura add
 
             
         #資料未重複, 插入新增資料
         IF l_cnt = 0 THEN 
            LET l_sql = " INSERT INTO oofc_t( ",
                        "        oofcstus, oofcent, oofc001, oofc002, oofc003, oofc004, oofc005, oofc006, ",
                        "         oofc007, oofc008, oofc009, oofc010, oofc011, oofc012, oofc013, oofcownid, ",
                        "         oofcowndp, oofccrtid, oofccrtdp, oofccrtdt, oofcmodid, oofcmoddt, oofc014 ",
                        "        )",
                        " SELECT oofcstus, oofcent,'",l_oofc001,"','",g_pmba_m.pmba027,"', oofc003, oofc004, oofc005, oofc006, ",
                        "        oofc007, oofc008, oofc009, oofc010, oofc011, oofc012, oofc013, oofcownid, ",
                        "        oofcowndp, oofccrtid, oofccrtdp, oofccrtdt, oofcmodid, oofcmoddt, oofc014 ",
                        "   FROM oofc_t ",
                       #"  WHERE oofcent = ",g_enterprise," AND oofc001 = '",l_oofc001_t,"' AND oofc002 = '",g_pmaa027_d,"'" #sakura mark
                        "  WHERE oofcent = ",g_enterprise," AND oofc001 = '",l_oofc001_t,"' AND oofc002 = '",l_pmaa027,"'" #sakura add
            PREPARE ins_oofc_pre FROM l_sql
            EXECUTE ins_oofc_pre  
            
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins oofc_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_errno = SQLCA.sqlcode
            END IF
         ELSE    
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = 'INSERT'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_errno = "std-00006"
         END IF     
         IF NOT cl_null(g_errno) THEN
            RETURN
         END IF
      END FOREACH
      #sakura---add---str
      IF NOT cl_null(g_pmba_m.pmba027) THEN
         LET g_pmaa027_d = g_pmba_m.pmba027
         CALL aooi350_01_b_fill(g_pmaa027_d)
         CALL aooi350_02_b_fill(g_pmaa027_d)
      END IF     
      #sakura---add---end
     #LET g_pmaa027_d = NULL #sakura mark
   END IF
END FUNCTION

################################################################################
# Descriptions...: 帶出此經銷商的所屬法人
# Memo...........:
# Usage..........: CALL adbt201_pmba006_values()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/31 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbt201_pmba006_values()

   SELECT pmaa005,pmaa241,pmaa242,pmaa243,pmaa244
     INTO g_pmba_m.pmba005,g_pmba_m.pmba241,g_pmba_m.pmba242,
          g_pmba_m.pmba243,g_pmba_m.pmba244
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_pmba_m.pmba006
      
   CALL s_desc_get_trading_partner_abbr_desc(g_pmba_m.pmba005)
      RETURNING g_pmba_m.pmba005_desc
   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba241)
      RETURNING g_pmba_m.pmba241_desc
   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba242)
      RETURNING g_pmba_m.pmba242_desc
   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba243)
      RETURNING g_pmba_m.pmba243_desc
   CALL s_desc_get_dbaa001_desc(g_pmba_m.pmba244)
      RETURNING g_pmba_m.pmba244_desc
   DISPLAY BY NAME g_pmba_m.pmba005,g_pmba_m.pmba005_desc,
                   g_pmba_m.pmba241,g_pmba_m.pmba241_desc,
                   g_pmba_m.pmba242,g_pmba_m.pmba242_desc,
                   g_pmba_m.pmba243,g_pmba_m.pmba243_desc,
                   g_pmba_m.pmba244,g_pmba_m.pmba244_desc
END FUNCTION
#BPM提交
PRIVATE FUNCTION adbt201_send()

   #add-point:send段define
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   #add-point:send段define(客製用)

   #end add-point 

   CALL adbt201_show()
   CALL adbt201_set_pk_array()
   
   #add-point: 提交前的ADP
   CALL s_adbt201_conf_chk(g_pmba_m.pmbadocno) RETURNING l_success
   IF NOT l_success THEN
      CLOSE adbt201_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_pmba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
#   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_sffb_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP

   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL adbt201_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
#   CALL adbt201_ui_headershow()
#   CALL adbt201_ui_detailshow()
   CALL adbt201_show()
 
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION adbt201_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_pmba_m.pmbadocno
   LET g_pk_array[1].column = 'pmbadocno'
 
   
   #add-point:set_pk_array段之後

   #end add-point  
END FUNCTION

################################################################################
# Descriptions...: 修改，删除时重新检查状态
# Date & Author..: #160818-00017#5 2016/08/22 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt201_action_chk()
   SELECT pmbastus  INTO g_pmba_m.pmbastus
     FROM pmba_t
    WHERE pmbaent = g_enterprise
      AND pmbadocno = g_pmba_m.pmbadocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_pmba_m.pmbastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_pmba_m.pmbadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adbt201_show()
        RETURN FALSE
     END IF
   END IF
   RETURN TRUE
END FUNCTION

#end add-point
 
{</section>}
 
