#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp600.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-10-24 16:04:38), PR版次:0003(2016-12-30 16:56:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: asfp600
#+ Description: 工單製程期末結存產生作業
#+ Creator....: 01258(2014-10-24 14:52:54)
#+ Modifier...: 01258 -SD/PR- 08992
 
{</section>}
 
{<section id="asfp600.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161109-00085#41 2016/11/17 By lienjunqi    整批調整系統星號寫法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
       sel                  LIKE type_t.chr1,
       sfpa002              LIKE sfpa_t.sfpa002,
       sfpa003              LIKE sfpa_t.sfpa003,
       sfaa010              LIKE sfaa_t.sfaa010,
       sfaa010_desc         LIKE imaal_t.imaal003,
       sfaa010_desc_1       LIKE imaal_t.imaal004,
       sfca003              LIKE sfca_t.sfca003,
       sfca004              LIKE sfca_t.sfca004,
       sfaa017              LIKE sfaa_t.sfaa017,      
       sfaa017_desc         LIKE ooefl_t.ooefl003,
       sfaa019              LIKE sfaa_t.sfaa019
                     END RECORD   
TYPE type_g_sfpa_d   RECORD
       sfpa004              LIKE sfpa_t.sfpa004,
       sfpa005              LIKE sfpa_t.sfpa005,
       sfpa018_p            LIKE sfpa_t.sfpa018,
       sfpa006              LIKE sfpa_t.sfpa006,
       sfpa007              LIKE sfpa_t.sfpa007,
       sfpa008              LIKE sfpa_t.sfpa008,
       sfpa009              LIKE sfpa_t.sfpa009,
       sfpa010              LIKE sfpa_t.sfpa010,
       sfpa011              LIKE sfpa_t.sfpa011,
       sfpa012              LIKE sfpa_t.sfpa012,
       sfpa013              LIKE sfpa_t.sfpa013,
       sfpa014              LIKE sfpa_t.sfpa014,
       sfpa015              LIKE sfpa_t.sfpa015,
       sfpa016              LIKE sfpa_t.sfpa016,
       sfpa017              LIKE sfpa_t.sfpa017,
       sfpa018              LIKE sfpa_t.sfpa018
                     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_sfpa_d    DYNAMIC ARRAY OF type_g_sfpa_d
DEFINE l_ac2       LIKE type_t.num5
DEFINE g_cnt2      LIKE type_t.num5
DEFINE g_detail_cnt2         LIKE type_t.num5 
DEFINE g_sfpa_m    RECORD
       sfpa000     LIKE sfpa_t.sfpa000,
       sfpa001     LIKE sfpa_t.sfpa001
                   END RECORD
DEFINE g_sfpa000   LIKE sfpa_t.sfpa000
DEFINE g_sfpa001   LIKE sfpa_t.sfpa001
DEFINE g_glav001   LIKE glav_t.glav001
#end add-point
 
{</section>}
 
{<section id="asfp600.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asf","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp600 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfp600_init()   
 
      #進入選單 Menu (="N")
      CALL asfp600_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp600
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="asfp600.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asfp600_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp600.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp600_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE  l_close_dd            LIKE type_t.dat
   DEFINE  l_ld                  LIKE glaa_t.glaald
   DEFINE  l_yy                  LIKE glav_t.glav002
   DEFINE  l_ss                  LIKE glav_t.glav005
   DEFINE  l_mm                  LIKE glav_t.glav006
   DEFINE  l_ww                  LIKE glav_t.glav007
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_comp                LIKE ooef_t.ooef017
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL cl_set_act_visible("selall,selnone,sel,unsel,filter,qbeclear",FALSE)
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asfp600_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_sfpa_m.sfpa000,g_sfpa_m.sfpa001
         
             BEFORE INPUT 
                LET g_sfpa_m.sfpa000 = cl_get_para(g_enterprise,g_site,'S-FIN-6010')
                LET g_sfpa_m.sfpa001 = cl_get_para(g_enterprise,g_site,'S-FIN-6011')
                DISPLAY BY NAME g_sfpa_m.sfpa000,g_sfpa_m.sfpa001
                LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-FIN-6012')
                
                #先找出成本关账日期所在年期
                SELECT ooef017 INTO l_comp FROM ooef_t 
                 WHERE ooefent = g_enterprise
                   AND ooef001 = g_site
                   
                SELECT glaald,glaa003 INTO l_ld,g_glav001 FROM glaa_t
                 WHERE glaaent  = g_enterprise
                   AND glaacomp = l_comp   
                   AND glaa014 = 'Y'
                   
                CALL s_fin_date_get_yspw('',l_ld,l_close_dd) RETURNING l_success,l_yy,l_ss,l_mm,l_ww       
                
             AFTER FIELD sfpa000
                IF NOT cl_null(g_sfpa_m.sfpa000) AND NOT cl_null(l_close_dd) THEN
                   IF g_sfpa_m.sfpa000 < l_yy THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_sfpa_m.sfpa000 
                      LET g_errparam.code   = "asf-00449"
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      NEXT FIELD sfpa000
                   END IF   
                   IF NOT cl_null(g_sfpa_m.sfpa001) THEN
                      IF g_sfpa_m.sfpa000 = l_yy AND g_sfpa_m.sfpa001 <= l_mm THEN
                         LET g_errparam.extend = g_sfpa_m.sfpa000 
                         LET g_errparam.code   = "asf-00449"
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         NEXT FIELD sfpa000
                      END IF
                   END IF
                END IF
                IF cl_null(g_sfpa_m.sfpa000) THEN
                   NEXT FIELD sfpa000
                END IF
                
             AFTER FIELD sfpa001
                IF NOT cl_null(g_sfpa_m.sfpa001) AND NOT cl_null(l_close_dd) THEN
                   IF NOT cl_null(g_sfpa_m.sfpa000) THEN 
                      IF g_sfpa_m.sfpa000 < l_yy THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = g_sfpa_m.sfpa000 
                         LET g_errparam.code   = "asf-00449"
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         NEXT FIELD sfpa000
                      END IF                      
                      IF g_sfpa_m.sfpa000 = l_yy AND g_sfpa_m.sfpa001 <= l_mm THEN
                         LET g_errparam.extend = g_sfpa_m.sfpa001
                         LET g_errparam.code   = "asf-00449"
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         NEXT FIELD sfpa001
                      END IF
                   END IF
                END IF
                IF cl_null(g_sfpa_m.sfpa001) THEN
                   NEXT FIELD sfpa001
                END IF
                      
             AFTER INPUT         
                IF cl_null(g_sfpa_m.sfpa000) THEN
                   NEXT FIELD sfpa000
                END IF
                IF cl_null(g_sfpa_m.sfpa001) THEN
                   NEXT FIELD sfpa001
                END IF    
                CALL s_fin_date_get_last_period('',l_ld,g_sfpa_m.sfpa000,g_sfpa_m.sfpa001) RETURNING l_success,g_sfpa000,g_sfpa001            
                IF g_sfpa_m.sfpa001 = 1 THEN
                   LET g_sfpa000 = g_sfpa_m.sfpa000 - 1
                   LET g_sfpa001 = 12
                ELSE
                   LET g_sfpa000 = g_sfpa_m.sfpa000
                   LET g_sfpa001 = g_sfpa_m.sfpa001 - 1
                END IF
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(l_ac)
               
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               DISPLAY l_ac TO FORMONLY.h_index
               CALL cl_show_fld_cont() 
               CALL asfp600_b2_fill(l_ac)             
         END DISPLAY
         
         DISPLAY ARRAY g_sfpa_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
      
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(l_ac2)
               
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")             
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfp600_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL asfp600_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL asfp600_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION gen_sfpa
            IF NOT cl_null(g_sfpa_m.sfpa000) AND NOT cl_null(l_close_dd) THEN
               IF g_sfpa_m.sfpa000 < l_yy THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_sfpa_m.sfpa000 
                  LET g_errparam.code   = "asf-00449"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD sfpa000
               END IF   
               IF NOT cl_null(g_sfpa_m.sfpa001) THEN
                  IF g_sfpa_m.sfpa000 = l_yy AND g_sfpa_m.sfpa001 <= l_mm THEN
                     LET g_errparam.extend = g_sfpa_m.sfpa000 
                     LET g_errparam.code   = "asf-00449"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD sfpa000
                  END IF
               END IF
            END IF
            IF cl_null(g_sfpa_m.sfpa000) THEN
               NEXT FIELD sfpa000
            END IF
            
            IF NOT cl_null(g_sfpa_m.sfpa001) AND NOT cl_null(l_close_dd) THEN
               IF NOT cl_null(g_sfpa_m.sfpa000) THEN                     
                  IF g_sfpa_m.sfpa000 = l_yy AND g_sfpa_m.sfpa001 <= l_mm THEN
                     LET g_errparam.extend = g_sfpa_m.sfpa001
                     LET g_errparam.code   = "asf-00449"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD sfpa001
                  END IF
               END IF
            END IF
            IF cl_null(g_sfpa_m.sfpa001) THEN
               NEXT FIELD sfpa001
            END IF
            
            CALL asfp600_query()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfp600.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asfp600_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_sfpa_m.sfpa000) OR cl_null(g_sfpa_m.sfpa001) THEN
      RETURN
   END IF
   
   IF g_sfpa_m.sfpa001 = 1 THEN
      LET g_sfpa000 = g_sfpa_m.sfpa000 - 1
      LET g_sfpa001 = 12
   ELSE
      LET g_sfpa000 = g_sfpa_m.sfpa000
      LET g_sfpa001 = g_sfpa_m.sfpa001 - 1
   END IF
                
   SELECT COUNT(*) INTO l_n FROM sfpa_t
    WHERE sfpaent = g_enterprise AND sfpasite = g_site 
      AND sfpa000 = g_sfpa_m.sfpa000 AND sfpa001 = g_sfpa_m.sfpa001
      
   CALL s_transaction_begin()
   LET l_success = TRUE
   IF l_n > 0 THEN
      IF cl_ask_confirm('asf-00448') THEN
         CALL asfp600_gen() RETURNING l_success
      END IF
   ELSE
      CALL asfp600_gen() RETURNING l_success
   END IF
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL asfp600_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp600.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfp600_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = " SELECT unique sfpa002,sfpa003 FROM sfpa_t ",
               "  WHERE sfpaent = ? AND sfpasite = '",g_site,"'",
               "    AND sfpa000 = ",g_sfpa_m.sfpa000," AND sfpa001 = ",g_sfpa_m.sfpa001,
               "  ORDER BY sfpa002,sfpa003"
   #end add-point
 
   PREPARE asfp600_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfp600_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sfpa002,g_detail_d[l_ac].sfpa003
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
 
      #end add-point
      
      CALL asfp600_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE asfp600_sel
   
   LET l_ac = 1
   CALL asfp600_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL asfp600_b2_fill(l_ac)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp600.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfp600_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="asfp600.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfp600_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
DEFINE l_sfaa057           LIKE sfaa_t.sfaa057
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   SELECT sfaa010,sfaa017,sfaa019,sfaa057 
     INTO g_detail_d[l_ac].sfaa010,g_detail_d[l_ac].sfaa017,g_detail_d[l_ac].sfaa019,l_sfaa057
     FROM sfaa_t
    WHERE sfaaent = g_enterprise AND sfaasite = g_site
      AND sfaadocno = g_detail_d[l_ac].sfpa002
      
   SELECT imaal003,imaal004 INTO g_detail_d[l_ac].sfaa010_desc,g_detail_d[l_ac].sfaa010_desc_1 FROM imaal_t
    WHERE imaalent = g_enterprise AND imaal001 = g_detail_d[l_ac].sfaa010 AND imaal002 = g_lang
         
   IF l_sfaa057 = '2' THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_detail_d[l_ac].sfaa017
      CALL cl_ref_val("v_pmaal004")
      LET g_detail_d[l_ac].sfaa017_desc = g_chkparam.return1
   ELSE
      CALL s_desc_get_department_desc(g_detail_d[l_ac].sfaa017) RETURNING g_detail_d[l_ac].sfaa017_desc
   END IF
   
   SELECT sfca003,sfca004 INTO g_detail_d[l_ac].sfca003,g_detail_d[l_ac].sfca004 FROM sfca_t
    WHERE sfcaent = g_enterprise AND sfcasite = g_site 
      AND sfcadocno = g_detail_d[l_ac].sfpa002 AND sfca001 = g_detail_d[l_ac].sfpa003
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp600.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION asfp600_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL asfp600_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="asfp600.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION asfp600_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{</section>}
 
{<section id="asfp600.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION asfp600_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = asfp600_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asfp600.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#单身2资料显示
PRIVATE FUNCTION asfp600_b2_fill(p_ac)
DEFINE p_ac              LIKE type_t.num5

   IF cl_null(p_ac) OR p_ac = 0 THEN
      RETURN
   END IF
   
   LET g_sql = " SELECT sfpa004,sfpa005,'',sfpa006,sfpa007,sfpa008,sfpa009,sfpa010,sfpa011,sfpa012,", 
               "        sfpa013,sfpa014,sfpa015,sfpa016,sfpa017,sfpa018",
               "   FROM sfpa_t",
               "  WHERE sfpaent = ",g_enterprise," AND sfpasite = '",g_site,"'",
               "    AND sfpa000 = ",g_sfpa_m.sfpa000," AND sfpa001 = ",g_sfpa_m.sfpa001,
               "    AND sfpa002 = '",g_detail_d[p_ac].sfpa002,"' AND sfpa003 = ",g_detail_d[p_ac].sfpa003,
               "  ORDER BY sfpa004,sfpa005"
   PREPARE asfp600_sel2 FROM g_sql
   DECLARE b2_fill_curs CURSOR FOR asfp600_sel2
   
   CALL g_sfpa_d.clear()

   LET g_cnt2 = l_ac2
   LET l_ac2 = 1   
   ERROR "Searching!" 
 
   FOREACH b2_fill_curs INTO g_sfpa_d[l_ac2].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      SELECT sfpa018 INTO g_sfpa_d[l_ac2].sfpa018_p FROM sfpa_t      
       WHERE sfpaent = g_enterprise AND sfpasite = g_site
         AND sfpa000 = g_sfpa000 AND sfpa001 = g_sfpa001
         AND sfpa002 = g_detail_d[p_ac].sfpa002 AND sfpa003 = g_detail_d[p_ac].sfpa003
         AND sfpa004 = g_sfpa_d[l_ac2].sfpa004 AND sfpa005 = g_sfpa_d[l_ac2].sfpa005
      IF cl_null(g_sfpa_d[l_ac2].sfpa018_p) THEN
         LET g_sfpa_d[l_ac2].sfpa018_p = 0
      END IF
 
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   LET g_detail_cnt2 = l_ac2 - 1
   LET l_ac2 = g_cnt2
   LET g_cnt2 = 0
   
   CLOSE b2_fill_curs
   FREE asfp600_sel2
               
END FUNCTION

#根据input条件产生本期期末结存档资料
PRIVATE FUNCTION asfp600_gen()
DEFINE r_success               LIKE type_t.num5
#161109-00085#41-s
#DEFINE l_sfcb                  RECORD LIKE sfcb_t.*
DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       sfcb055 LIKE sfcb_t.sfcb055  #回收站
END RECORD
#161109-00085#41-e
#161109-00085#41-s
#DEFINE l_sfpa                  RECORD LIKE sfpa_t.*
DEFINE l_sfpa RECORD  #製程期末結存狀況檔
       sfpaent LIKE sfpa_t.sfpaent, #企業編號
       sfpasite LIKE sfpa_t.sfpasite, #營運據點
       sfpa000 LIKE sfpa_t.sfpa000, #年度
       sfpa001 LIKE sfpa_t.sfpa001, #期別
       sfpa002 LIKE sfpa_t.sfpa002, #工單單號
       sfpa003 LIKE sfpa_t.sfpa003, #RunCard
       sfpa004 LIKE sfpa_t.sfpa004, #作業編號
       sfpa005 LIKE sfpa_t.sfpa005, #作業序
       sfpa006 LIKE sfpa_t.sfpa006, #良品轉入
       sfpa007 LIKE sfpa_t.sfpa007, #重工轉入
       sfpa008 LIKE sfpa_t.sfpa008, #回收轉入
       sfpa009 LIKE sfpa_t.sfpa009, #分割轉入
       sfpa010 LIKE sfpa_t.sfpa010, #合併轉入
       sfpa011 LIKE sfpa_t.sfpa011, #良品轉出
       sfpa012 LIKE sfpa_t.sfpa012, #重工轉出
       sfpa013 LIKE sfpa_t.sfpa013, #工單轉出
       sfpa014 LIKE sfpa_t.sfpa014, #當站報廢
       sfpa015 LIKE sfpa_t.sfpa015, #當站下線
       sfpa016 LIKE sfpa_t.sfpa016, #分割轉出
       sfpa017 LIKE sfpa_t.sfpa017, #合併轉出
       sfpa018 LIKE sfpa_t.sfpa018  #期末結存
END RECORD
#161109-00085#41-e
DEFINE l_bdate                 LIKE sfaa_t.sfaa047
DEFINE l_edate                 LIKE sfaa_t.sfaa047

   LET r_success = FALSE
   
   #已经存在本期资料，先删除
   DELETE FROM sfpa_t
    WHERE sfpaent = g_enterprise AND sfpasite = g_site
      AND sfpa000 = g_sfpa_m.sfpa000 AND sfpa001 = g_sfpa_m.sfpa001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE sfpa_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN r_success
   END IF 
   
   CALL s_fin_date_get_period_range(g_glav001,g_sfpa_m.sfpa000,g_sfpa_m.sfpa001)
        RETURNING l_bdate,l_edate
   #161109-00085#41-s
   #LET g_sql = "SELECT sfcb_t.* FROM sfaa_t,sfcb_t ",
   LET g_sql = "SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
                       sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
                       sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
                       sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
                       sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
                       sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
                       sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
                       sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
                       sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
                       sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
                       sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
                       sfcb053,sfcb054,sfcb055
                  FROM sfaa_t,sfcb_t ",
   #161109-00085#41-e
               " WHERE sfaaent = sfcbent AND sfaasite = sfcbsite AND sfaadocno = sfcbdocno ",
               "   AND (sfaa047 IS NULL OR sfaa047 BETWEEN '",l_bdate,"' AND '",l_edate,"')",
               "   AND sfaadocdt <= '",l_edate,"'",
               "   AND sfaaent = ",g_enterprise," AND sfaasite = '",g_site,"'",
               " ORDER BY sfcb_t.sfcbdocno,sfcb_t.sfcb001,sfcb_t.sfcb002"
   PREPARE asfp600_gen_pre FROM g_sql
   DECLARE asfp600_gen_cs CURSOR FOR asfp600_gen_pre
   #FOREACH asfp600_gen_cs INTO l_sfcb.*  #161109-00085#41 MARK
   #161109-00085#41-s
   FOREACH asfp600_gen_cs 
      INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
           l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
           l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
           l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
           l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
           l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
           l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
           l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
           l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
           l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
           l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
           l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055
   #161109-00085#41-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN r_success
      END IF
      
      #取前期结存档累计数量
      SELECT SUM(sfpa006),SUM(sfpa007),SUM(sfpa008),SUM(sfpa009),SUM(sfpa010),SUM(sfpa011),
             SUM(sfpa012),SUM(sfpa013),SUM(sfpa014),SUM(sfpa015),SUM(sfpa016),SUM(sfpa017)      
        INTO l_sfpa.sfpa006,l_sfpa.sfpa007,l_sfpa.sfpa008,l_sfpa.sfpa009,l_sfpa.sfpa010,l_sfpa.sfpa011,
             l_sfpa.sfpa012,l_sfpa.sfpa013,l_sfpa.sfpa014,l_sfpa.sfpa015,l_sfpa.sfpa016,l_sfpa.sfpa017
        FROM sfpa_t
       WHERE sfpaent = g_enterprise AND sfpasite = g_site
         AND (sfpa000 = g_sfpa_m.sfpa000 AND sfpa001 < g_sfpa_m.sfpa001 OR sfpa000 < g_sfpa_m.sfpa000)
         AND sfpa002 = l_sfcb.sfcbdocno AND sfpa003 = l_sfcb.sfcb001
         AND sfpa004 = l_sfcb.sfcb003 AND sfpa005 = l_sfcb.sfcb004
      IF cl_null(l_sfpa.sfpa006) THEN
         LET l_sfpa.sfpa006 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa007) THEN
         LET l_sfpa.sfpa007 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa008) THEN
         LET l_sfpa.sfpa008 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa009) THEN
         LET l_sfpa.sfpa009 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa010) THEN
         LET l_sfpa.sfpa010 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa011) THEN
         LET l_sfpa.sfpa011 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa012) THEN
         LET l_sfpa.sfpa012 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa013) THEN
         LET l_sfpa.sfpa013 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa014) THEN
         LET l_sfpa.sfpa014 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa015) THEN
         LET l_sfpa.sfpa015 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa016) THEN
         LET l_sfpa.sfpa016 = 0 
      END IF
      IF cl_null(l_sfpa.sfpa017) THEN
         LET l_sfpa.sfpa017 = 0 
      END IF
      LET l_sfpa.sfpaent = g_enterprise 
      LET l_sfpa.sfpasite = g_site
      LET l_sfpa.sfpa000 = g_sfpa_m.sfpa000
      LET l_sfpa.sfpa001 = g_sfpa_m.sfpa001
      LET l_sfpa.sfpa002 = l_sfcb.sfcbdocno
      LET l_sfpa.sfpa003 = l_sfcb.sfcb001
      LET l_sfpa.sfpa004 = l_sfcb.sfcb003
      LET l_sfpa.sfpa005 = l_sfcb.sfcb004
      LET l_sfpa.sfpa006 = l_sfcb.sfcb028 - l_sfpa.sfpa006
      LET l_sfpa.sfpa007 = l_sfcb.sfcb029 - l_sfpa.sfpa007
      LET l_sfpa.sfpa008 = l_sfcb.sfcb030 - l_sfpa.sfpa008
      LET l_sfpa.sfpa009 = l_sfcb.sfcb031 - l_sfpa.sfpa009
      LET l_sfpa.sfpa010 = l_sfcb.sfcb032 - l_sfpa.sfpa010
      LET l_sfpa.sfpa011 = l_sfcb.sfcb033 - l_sfpa.sfpa011
      LET l_sfpa.sfpa012 = l_sfcb.sfcb034 - l_sfpa.sfpa012
      LET l_sfpa.sfpa013 = l_sfcb.sfcb035 - l_sfpa.sfpa013
      LET l_sfpa.sfpa014 = l_sfcb.sfcb036 - l_sfpa.sfpa014
      LET l_sfpa.sfpa015 = l_sfcb.sfcb037 - l_sfpa.sfpa015
      LET l_sfpa.sfpa016 = l_sfcb.sfcb038 - l_sfpa.sfpa016
      LET l_sfpa.sfpa017 = l_sfcb.sfcb039 - l_sfpa.sfpa017
      
      #取上期期末结存
      SELECT sfpa018 INTO l_sfpa.sfpa018 FROM sfpa_t
       WHERE sfpaent = g_enterprise AND sfpasite = g_site
         AND sfpa000 = g_sfpa000 AND sfpa001 = g_sfpa001
         AND sfpa002 = l_sfcb.sfcbdocno AND sfpa003 = l_sfcb.sfcb001
         AND sfpa004 = l_sfcb.sfcb003 AND sfpa005 = l_sfcb.sfcb004
      IF cl_null(l_sfpa.sfpa018) THEN
         LET l_sfpa.sfpa018 = 0
      END IF      
      #本期期末结存 = 上期期末结存 + 本期入项 - 本期出项      
      LET l_sfpa.sfpa018 = l_sfpa.sfpa018 + l_sfpa.sfpa006 + l_sfpa.sfpa007 + l_sfpa.sfpa008 + l_sfpa.sfpa009 + l_sfpa.sfpa010
                         - l_sfpa.sfpa011 - l_sfpa.sfpa012 - l_sfpa.sfpa013 - l_sfpa.sfpa014 - l_sfpa.sfpa015 - l_sfpa.sfpa016
                         - l_sfpa.sfpa017

      IF cl_null(l_sfpa.sfpa004) THEN
         LET l_sfpa.sfpa004 = ' '
      END IF
      IF cl_null(l_sfpa.sfpa005) THEN
         LET l_sfpa.sfpa005 = ' '
      END IF
      #161109-00085#41-s
      #INSERT INTO sfpa_t VALUES l_sfpa.*
      INSERT INTO sfpa_t 
                        (sfpaent,sfpasite,sfpa000,sfpa001,sfpa002,
                         sfpa003,sfpa004,sfpa005,sfpa006,sfpa007,
                         sfpa008,sfpa009,sfpa010,sfpa011,sfpa012,
                         sfpa013,sfpa014,sfpa015,sfpa016,sfpa017,
                         sfpa018)
      VALUES (l_sfpa.sfpaent,l_sfpa.sfpasite,l_sfpa.sfpa000,l_sfpa.sfpa001,l_sfpa.sfpa002,
              l_sfpa.sfpa003,l_sfpa.sfpa004,l_sfpa.sfpa005,l_sfpa.sfpa006,l_sfpa.sfpa007,
              l_sfpa.sfpa008,l_sfpa.sfpa009,l_sfpa.sfpa010,l_sfpa.sfpa011,l_sfpa.sfpa012,
              l_sfpa.sfpa013,l_sfpa.sfpa014,l_sfpa.sfpa015,l_sfpa.sfpa016,l_sfpa.sfpa017,
              l_sfpa.sfpa018)
      #161109-00085#41-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT sfpa_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN r_success
      END IF 

      INITIALIZE l_sfpa.* TO NULL
      INITIALIZE l_sfcb.* TO NULL
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
