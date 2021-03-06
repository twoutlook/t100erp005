#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp960.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-10-28 16:28:57), PR版次:0007(2016-10-12 14:35:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000129
#+ Filename...: aapp960
#+ Description: 應付帳款重評價還原作業
#+ Creator....: 04152(2014-08-20 18:43:25)
#+ Modifier...: 04152 -SD/PR- 08732
 
{</section>}
 
{<section id="aapp960.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1 15/02/24 By Reanna  掃把清空&給預設值&筆數顯示異常處理
#160812-00027#3 16/08/16 By 06821   全面盤點應付程式帳套權限控管
#161006-00005#3 16/10/12 By 08732   組織類型與職能開窗調整
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
     sel           LIKE type_t.chr1,
     xrebld        LIKE xreb_t.xrebld,
     glaal002      LIKE glaal_t.glaal002,
     glaacomp      LIKE glaa_t.glaacomp,
     ooefl003      LIKE ooefl_t.ooefl003,
     glaa001       LIKE glaa_t.glaa001,
     glav004_1     LIKE glav_t.glav004,
     glav004_2     LIKE glav_t.glav004,
     glca002       LIKE glca_t.glca002,
     glca003       LIKE glca_t.glca003,
     xreb023       LIKE xreb_t.xreb023
END RECORD
TYPE type_master RECORD
     xrebsite      LIKE xreb_t.xrebsite,
     xrebsite_desc LIKE type_t.chr80,
     xreb001       LIKE xreb_t.xreb001,
     xreb002       LIKE xreb_t.xreb002
END RECORD
DEFINE g_master      type_master
DEFINE l_para_data LIKE type_t.chr80
DEFINE l_xreb001   LIKE xreb_t.xreb001
DEFINE l_xreb002   LIKE xreb_t.xreb002
DEFINE g_flag      LIKE type_t.chr1    #條件範圍是否有資料
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp960.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp960 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp960_init()   
 
      #進入選單 Menu (="N")
      CALL aapp960_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp960
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp960.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp960_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_array DYNAMIC ARRAY OF RECORD
                  value       STRING,
                  label_tag   STRING,
                  label       STRING
              END RECORD
   DEFINE i       LIKE type_t.num5
   DEFINE l_ooef017     LIKE ooef_t.ooef017
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_glca002','8317')
   CALL cl_set_combo_scc('b_glca003','40')   
   CALL s_fin_set_comp_scc('xreb001','43')   #年度
   CALL s_fin_set_comp_scc('xreb002','111')  #期別
   #(單頭以帳務中心角度抓其下帳別範圍,因此會對應到多個帳別,故無法依照個別會計週期設定為12或13期,因此預設下拉到13期)

   #150127-00007#1 mark---
   #為了掃把清空時給預設所以移至 aapp930_qbe_clear()裡面
   #LET g_master.xrebsite = g_site
   ##141215:取得帳務中心所屬法人
   #SELECT ooef017 INTO l_ooef017
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_master.xrebsite
   #CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-3007') RETURNING l_para_data     
   ##預設年度/期別
   #CALL cl_get_para(g_enterprise,g_master.xrebsite,'S-FIN-3007') RETURNING l_para_data
   #LET g_master.xreb001 = YEAR(l_para_data)
   #LET g_master.xreb002 = MONTH(l_para_data)
   ##150119byReanna:預設關帳之年月
   #LET l_xreb001 = g_master.xreb001
   #LET l_xreb002 = g_master.xreb002
   #150127-00007#1 mark end---
   
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp960.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp960_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_para_data_b LIKE type_t.chr80
   DEFINE l_ooef017     LIKE ooef_t.ooef017
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #150127-00007#1
   CALL aapp960_qbe_clear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp960_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.xrebsite,g_master.xreb001,g_master.xreb002
            ATTRIBUTE(WITHOUT DEFAULTS) 
            

            AFTER FIELD xrebsite

               LET g_master.xrebsite_desc = ' '
               DISPLAY BY NAME g_master.xrebsite_desc
               IF NOT cl_null(g_master.xrebsite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.xrebsite,'','','3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD xrebsite
                  END IF
                  #141215:取得帳務中心所屬法人
                  SELECT ooef017 INTO l_ooef017
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_master.xrebsite
                  CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-3007') RETURNING l_para_data
                 #CALL cl_get_para(g_enterprise,g_master.xrebsite,'S-FIN-3007') RETURNING l_para_data
                  LET g_master.xreb001 = YEAR(l_para_data)
                  LET g_master.xreb002 = MONTH(l_para_data)
                  #預設關帳之年月
                  LET l_xreb001 = g_master.xreb001
                  LET l_xreb002 = g_master.xreb002
                  CALL aapp960_query() #141215
               END IF           
               LET g_master.xrebsite_desc = s_desc_get_department_desc(g_master.xrebsite)
               DISPLAY BY NAME g_master.xrebsite_desc
               
            ON CHANGE xreb001
               IF g_master.xreb001 < l_xreb001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00248'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.xreb001 = l_xreb001
                  NEXT FIELD CURRENT
               END IF
               
            ON CHANGE xreb002
               IF g_master.xreb001 = l_xreb001 AND g_master.xreb002 < l_xreb002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00249'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.xreb002 = l_xreb002
                  NEXT FIELD CURRENT
               END IF
               CALL aapp960_query() #141215

            ON ACTION controlp INFIELD xrebsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrebsite       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' "         #160812-00027#3 mark
               #CALL q_ooef001()     #161006-00005#3  mark
               CALL q_ooef001_46()   #161006-00005#3  add                                #呼叫開窗
               LET g_master.xrebsite = g_qryparam.return1        #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(g_master.xrebsite) RETURNING g_master.xrebsite_desc
               DISPLAY BY NAME g_master.xrebsite,g_master.xrebsite_desc
               NEXT FIELD xrebsite
         END INPUT
         
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
            #150127-00007#1
            BEFORE ROW
              LET l_ac = ARR_CURR()
              DISPLAY l_ac TO FORMONLY.h_index

            ON CHANGE b_sel
               LET l_ac = ARR_CURR()
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  #已產生傳票者不可還原
                  IF NOT cl_null(g_detail_d[l_ac].xreb023) THEN
                     LET g_detail_d[l_ac].sel = 'N'
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00129'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                  END IF
                  #150825--02097--(S)
                  CALL s_aap_evaluation_chk('2','AP',g_detail_d[l_ac].xrebld,g_detail_d[l_ac].glaacomp,g_master.xreb001,g_master.xreb002) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_detail_d[l_ac].sel = 'N'
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()               
                  END IF
                  ##取所屬法人關帳日
                  #CALL cl_get_para(g_enterprise,g_detail_d[l_ac].glaacomp,'S-FIN-3007') RETURNING l_para_data_b
                  ##所屬法人關帳日期單頭年度期別不同
                  #IF g_master.xreb001 <> YEAR(l_para_data_b) OR g_master.xreb002 <> MONTH(l_para_data_b) THEN
                  #   LET g_detail_d[l_ac].sel = 'N'
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'aap-00138'
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = FALSE
                  #   CALL cl_err()
                  #END IF
                  #150825--02097--(E)
               END IF

         END INPUT         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
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
            #已有重評傳票不可勾選
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF NOT cl_null(g_detail_d[li_idx].xreb023) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
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
            CALL aapp960_filter()
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
            CALL aapp960_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            #150127-00007#1
            CALL aapp960_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp960_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL aapp960_process()
            #IF g_success ='N' THEN
            #   CONTINUE DIALOG
            #END IF
            #   
            #IF g_bgjob = "N" THEN            
            #   CALL cl_ask_confirm3("std-00012","")
            #END IF
            NEXT FIELD xrebsite   
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
 
{<section id="aapp960.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp960_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF g_master.xreb001 < l_xreb001 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00248'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET g_master.xreb001 = l_xreb001
      RETURN  
   END IF 

   IF g_master.xreb001 = l_xreb001 AND g_master.xreb002 < l_xreb002 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00249'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET g_master.xreb002 = l_xreb002
      RETURN
   END IF   
   #end add-point
        
   LET g_error_show = 1
   CALL aapp960_b_fill()
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
 
{<section id="aapp960.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp960_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_flag           LIKE type_t.chr1      #檢核狀態
   DEFINE l_errno          LIKE type_t.chr100    #錯誤訊息
   DEFINE l_glav002        LIKE glav_t.glav002   #會計年度
   DEFINE l_glav005        LIKE glav_t.glav005   #歸屬季別
   DEFINE l_sdate_s        LIKE glav_t.glav004   #當季起始日
   DEFINE l_sdate_e        LIKE glav_t.glav004   #當季截止日
   DEFINE l_glav006        LIKE glav_t.glav006   #歸屬期別
   DEFINE l_pdate_s        LIKE glav_t.glav004   #當期起始日
   DEFINE l_pdate_e        LIKE glav_t.glav004   #當期截止日
   DEFINE l_glav007        LIKE glav_t.glav007   #歸屬週別
   DEFINE l_wdate_s        LIKE glav_t.glav004   #當週起始日
   DEFINE l_wdate_e        LIKE glav_t.glav004   #當週截止日
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.xrebsite,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_ld_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
   

   LET g_sql =" SELECT 'N',glaald,'',glaacomp,'','','','',glca002,glca003,'' ",
              "   FROM glaa_t,glca_t ",
              "  WHERE glaaent = ? ",
              "    AND glaaent = glcaent ",
              "    AND glaald = glcald ",
              "    AND glca001 = 'AP' ",
              "    AND glca002 <> '1' ",    #無重評不撈出           
              "    AND glaald IN ",ls_wc,    
              "  ORDER BY glaald,glaacomp "       


   #end add-point
 
   PREPARE aapp960_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp960_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].*
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

      LET l_glaa003 = ''   
      #取得會計週期參照表
      CALL s_ld_sel_glaa(g_detail_d[l_ac].xrebld,'glaa001|glaa003')
       RETURNING  g_sub_success,g_detail_d[l_ac].glaa001,l_glaa003

      #依年度+期別取得會計週期起迄日
      CALL s_get_accdate(l_glaa003,'',g_master.xreb001,g_master.xreb002)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e    
      LET g_detail_d[l_ac].glav004_1 = l_pdate_s
      LET g_detail_d[l_ac].glav004_2 = l_pdate_e
      #帳套名稱
      LET g_detail_d[l_ac].glaal002 = s_desc_get_ld_desc(g_detail_d[l_ac].xrebld)
      #法人名稱
      LET g_detail_d[l_ac].ooefl003 = s_desc_get_department_desc(g_detail_d[l_ac].glaacomp)      
      
     #重評價傳票號碼 2015/08/23      
      SELECT UNIQUE xreg005 INTO g_detail_d[l_ac].xreb023 FROM xreg_t
       WHERE xregent = g_enterprise
         AND xregld = g_detail_d[l_ac].xrebld
         AND xreg001 = g_master.xreb001
         AND xreg002 = g_master.xreb002
         AND xreg003 = 'AP'      
      
#      SELECT UNIQUE xreb023 INTO g_detail_d[l_ac].xreb023
#        FROM xreb_t 
#       WHERE xrebld  = g_detail_d[l_ac].xrebld
#         AND xreb001 = g_master.xreb001 
#         AND xreb002 = g_master.xreb002
      #end add-point
      
      CALL aapp960_detail_show()      
 
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
   IF g_detail_d.getLength() > 0 THEN
      CALL g_detail_d.deleteElement(g_detail_d.getLength())
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapp960_sel
   
   LET l_ac = 1
   CALL aapp960_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index #150127-00007#1
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp960.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp960_fetch()
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
 
{<section id="aapp960.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp960_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp960.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp960_filter()
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
   
   CALL aapp960_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp960.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp960_filter_parser(ps_field)
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
 
{<section id="aapp960.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp960_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapp960_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp960.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aapp960_process()
DEFINE l_i         LIKE type_t.num5
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_xreg005   LIKE xreg_t.xreg005
DEFINE l_error     LIKE type_t.chr1
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_sum       LIKE type_t.num5

   LET l_error = 'Y'
   LET l_sum = 0
   #check有沒有勾選
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'Y' THEN
         LET l_flag = "Y"
      END IF
   END FOR
   IF l_flag = "N" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('aapp960',"lbl_xrebld")    RETURNING g_coll_title[1],g_coll_title[1]  #帳別
   CALL s_azzi902_get_gzzd('aapp960',"lbl_xreb005")   RETURNING g_coll_title[2],g_coll_title[2]  #單據號碼
   #取得有勾選的帳套條件
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'Y' THEN
         LET l_xreg005 = ''
         #已有傳票號碼不可還原
         SELECT xreg005 INTO l_xreg005
           FROM xreg_t
          WHERE xregent = g_enterprise
            AND xregld = g_detail_d[l_i].xrebld
            AND xreg001 = g_master.xreb001
            AND xreg002 = g_master.xreb002
            AND xreg003 = 'AP'
         
         IF NOT cl_null(l_xreg005) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00235'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1]  = g_detail_d[l_i].xrebld
            LET g_errparam.coll_vals[2]  = '' #單據號碼
            CALL cl_err()
            LET l_error = "N"
            CONTINUE FOR
         ELSE
            SELECT count(*) INTO l_cnt
              FROM xreb_t
             WHERE xrebent = g_enterprise
               AND xrebld  = g_detail_d[l_i].xrebld
               AND xreb001 = g_master.xreb001 AND xreb002 = g_master.xreb002
               AND xreb003 = 'AP'
            IF l_cnt > 0 THEN
               #開始update資訊
               CALL s_aapp960_upd(g_master.xrebsite,g_detail_d[l_i].xrebld,g_master.xreb001,g_master.xreb002) RETURNING g_sub_success
               
               IF g_sub_success THEN
                  #刪除月結資料
                  CALL s_aapp960_del(g_master.xrebsite,g_detail_d[l_i].xrebld,g_master.xreb001,g_master.xreb002) RETURNING g_sub_success
                  
                  IF NOT g_sub_success THEN
                     LET l_error = "N"
                  ELSE
                     LET l_sum = 1
                  END IF
               ELSE
                  LET l_error = "N"
                  CONTINUE FOR
               END IF
            END IF
         END IF
      END IF
   END FOR
   CALL cl_err_collect_show()
   IF l_sum = 0 AND l_error = 'Y' THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
     #LET g_errparam.code = 'axr-00159'  #150302apo mark
      LET g_errparam.code = 'sub-00491'  #150302apo
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      #顯示執行成功的訊息
      IF l_error = 'Y' THEN
         CALL s_transaction_end('Y','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00217'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         #執行失敗
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00218'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   CALL aapp960_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 清空&給預設 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapp960_qbe_clear()
# Date & Author..: 2015/02/24 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp960_qbe_clear()
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_detail_d.clear()
   
   LET g_master.xrebsite = g_site
   CALL s_desc_get_department_desc(g_master.xrebsite) RETURNING g_master.xrebsite_desc
   DISPLAY BY NAME g_master.xrebsite_desc
   #預設年度/期別
   CALL cl_get_para(g_enterprise,g_master.xrebsite,'S-FIN-3007') RETURNING l_para_data
   LET g_master.xreb001 = YEAR(l_para_data)
   LET g_master.xreb002 = MONTH(l_para_data)
   #150119byReanna:預設關帳之年月
   LET l_xreb001 = g_master.xreb001
   LET l_xreb002 = g_master.xreb002
   
END FUNCTION

#end add-point
 
{</section>}
 
