#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp970.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-10-27 17:51:01), PR版次:0007(2016-10-12 14:35:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000091
#+ Filename...: aapp970
#+ Description: 月結還原作業
#+ Creator....: 03080(2014-10-27 10:10:38)
#+ Modifier...: 03080 -SD/PR- 08732
 
{</section>}
 
{<section id="aapp970.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
# Modify...: 150114           By albireo  1.修改錯誤訊息
#                                         2.執行段也作年度期別符合條件的檢查
#            150115           By albireo  月結程式操作風格統一調整
#150205           2015/02/05  By Belle    刪除分錄底稿
#150319-00006#1   2015/04/08  By albireo  process處理段搬到sub處理
#150602-00063#1   2015/06/02  By Reanna   修正傳入參數bug
#160812-00027#3   2016/08/16  By 06821    全面盤點應付程式帳套權限控管
#161006-00005#3   2016/10/12  By 08732    組織類型與職能開窗調整
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
        xreasite         LIKE xrea_t.xreasite,
        xrea001          LIKE xrea_t.xrea001,
        xrea002          LIKE xrea_t.xrea002,
        xreasite_desc    LIKE type_t.chr100,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel              LIKE type_t.chr1,
        xreald           LIKE xrea_t.xreald,
        xreald_desc      LIKE type_t.chr1000,
        xreacomp         LIKE xrea_t.xreacomp,
        xreacomp_desc    LIKE type_t.chr1000
                     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE tm            type_parameter
#end add-point
 
{</section>}
 
{<section id="aapp970.main" >}
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
      OPEN WINDOW w_aapp970 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp970_init()   
 
      #進入選單 Menu (="N")
      CALL aapp970_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp970
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp970.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp970_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_set_comp_scc('xrea001','43')   #年度
   CALL s_fin_set_comp_scc('xrea002','111')  #期別
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp970.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp970_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_para_data   LIKE type_t.dat
   DEFINE l_ooef017     LIKE ooef_t.ooef017
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aapp970_clear_qbe()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp970_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.xreasite,tm.xrea001,tm.xrea002
            ATTRIBUTE(WITHOUT DEFAULTS) 
            
            AFTER FIELD xreasite
               #LET g_master.xrebsite_desc = ' '
               #DISPLAY BY NAME g_master.xrebsite_desc
               IF NOT cl_null(tm.xreasite) THEN
                  CALL s_fin_account_center_with_ld_chk(tm.xreasite,'','','3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD xreasite
                  END IF               
                  #141215:取得帳務中心所屬法人
                  SELECT ooef017 INTO l_ooef017
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = tm.xreasite
                  CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-3007') RETURNING l_para_data
                 #CALL cl_get_para(g_enterprise,tm.xreasite,'S-FIN-3007') RETURNING l_para_data
                  LET tm.xrea001 = YEAR(l_para_data)
                  LET tm.xrea002 = MONTH(l_para_data)
                  CALL aapp970_query() #141215
                  ##預設關帳之年月
                  #LET l_xreb001 = g_master.xreb001                  
                  #LET l_xreb002 = g_master.xreb002
               END IF           
               LET tm.xreasite_desc = s_desc_get_department_desc(tm.xreasite)
               DISPLAY BY NAME tm.xreasite_desc
               
            ON CHANGE xrea001   #albireo 150115 AFTER FIELD> ON CHANGE
               IF NOT cl_null(tm.xrea001) AND NOT cl_null(tm.xrea002)THEN
                  CALL cl_get_para(g_enterprise,tm.xreasite,'S-FIN-3007') RETURNING l_para_data
                  #LET tm.xrea001 = YEAR(l_para_data)
                  #LET tm.xrea002 = MONTH(l_para_data)
                  IF YEAR(l_para_data) > tm.xrea001 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00248'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET tm.xrea001 = YEAR(l_para_data)
                     NEXT FIELD CURRENT  
                  END IF                  
               END IF
 
            ON CHANGE xrea002    #albireo 150115 AFTER FIELD> ON CHANGE
               IF NOT cl_null(tm.xrea001) AND NOT cl_null(tm.xrea002)THEN
                  CALL cl_get_para(g_enterprise,tm.xreasite,'S-FIN-3007') RETURNING l_para_data
                  #LET tm.xrea001 = YEAR(l_para_data)
                  #LET tm.xrea002 = MONTH(l_para_data)
                  IF (YEAR(l_para_data)*12+MONTH(l_para_data)) > (tm.xrea001*12 + tm.xrea002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00249'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup =TRUE
                     CALL cl_err()
                     LET tm.xrea002 = MONTH(l_para_data)
                     LET tm.xrea001 = YEAR(l_para_data)
                     NEXT FIELD CURRENT  
                  END IF                  
                  CALL aapp970_query() #141215
               END IF
            
            ON ACTION controlp INFIELD xreasite
              INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.xreasite       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' "   #160812-00027#3 mark
               #CALL q_ooef001()     #161006-00005#3  mark
               CALL q_ooef001_46()   #161006-00005#3  add                               #呼叫開窗
               LET tm.xreasite = g_qryparam.return1        #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(tm.xreasite) RETURNING tm.xreasite_desc
               DISPLAY BY NAME tm.xreasite,tm.xreasite_desc
               NEXT FIELD xreasite                 
         END INPUT
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
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
               CALL cl_err_collect_init()
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  CALL aapp970_chk_ld_comp(l_ac)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_detail_d[l_ac].sel = 'N'
                  END IF
               END IF
               CALL cl_err_collect_show()

         END INPUT
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
            CALL cl_err_collect_init() 
            FOR li_idx = 1 TO g_detail_d.getLength()               
               CALL aapp970_chk_ld_comp(li_idx)
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  LET g_detail_d[l_ac].sel = 'N'
               END IF
            END FOR
            CALL cl_err_collect_show()
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
            CALL cl_err_collect_init() 
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  CALL aapp970_chk_ld_comp(li_idx)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_detail_d[l_ac].sel = 'N'
                  END IF
               END IF
            END FOR
            CALL cl_err_collect_show() 
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
            CALL aapp970_filter()
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
            CALL aapp970_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            #150127-00007#1
            CALL aapp970_clear_qbe()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp970_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
        ON ACTION batch_execute
            #先檢核是否有選取資料的提示   #albireo 150115----s
            #檢核單身是否有資料
            IF cl_null(g_detail_d.getLength()) OR g_detail_d.getLength() <= 0 THEN
               #albireo 150114------------------------s
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'std-00003'
               LET g_errparam.popup  = TRUE
               CALL cl_err() 
               #albireo 150114------------------------e    
               NEXT FIELD xreasite
            END IF   
   
            LET g_sub_success = FALSE
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = "Y" THEN
                  LET g_sub_success = TRUE
               END IF
            END FOR
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'abm-00098'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD xreasite
            END IF
            #albireo 150115--------------------------------e
            
            CALL s_transaction_begin()
            CALL cl_err_collect_init()
            CALL aapp970_process()
               RETURNING g_sub_success
            IF g_sub_success THEN
               CALL s_transaction_end('Y',0)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00222'   #單據還原成功
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()               
            ELSE
               CALL s_transaction_end('N',0)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00223'   #單據還原失敗
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()     
            END IF
            CALL cl_err_collect_show()
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
 
{<section id="aapp970.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp970_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL aapp970_b_fill()
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
 
{<section id="aapp970.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp970_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #先跑組織bom展算
   CALL s_fin_account_center_sons_query('3',tm.xreasite,g_today,'1')
   
   LET g_sql = " SELECT DISTINCT 'N',glaald,comp FROM s_fin_tmp1 ",
               "  WHERE ",g_enterprise," = ?  AND glaald IS NOT NULL"
   #end add-point
 
   PREPARE aapp970_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp970_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
  
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].xreald,g_detail_d[l_ac].xreacomp
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
      LET g_detail_d[l_ac].xreald_desc = s_desc_get_ld_desc(g_detail_d[l_ac].xreald)
      LET g_detail_d[l_ac].xreacomp_desc = s_desc_get_department_desc(g_detail_d[l_ac].xreacomp)
      #end add-point
      
      CALL aapp970_detail_show()      
 
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
   FREE aapp970_sel
   
   LET l_ac = 1
   CALL aapp970_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index #150127-00007#1
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp970.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp970_fetch()
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
 
{<section id="aapp970.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp970_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp970.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp970_filter()
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
   
   CALL aapp970_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp970.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp970_filter_parser(ps_field)
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
 
{<section id="aapp970.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp970_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapp970_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp970.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 檢核勾選項次是否有問題
# Memo...........:
# Date & Author..: 141027 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapp970_chk_ld_comp(p_ac)
   DEFINE p_ac      LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   DEFINE r_errno   LIKE gzze_t.gzze001
   DEFINE l_count   LIKE type_t.num10    #有傳票
   DEFINE l_msg     STRING

   LET r_success = TRUE
   LET r_errno   = NULL
   IF cl_null(p_ac) OR p_ac <= 0 THEN
      RETURN r_success,r_errno
   END IF
   
   #檢查是否有暫估傳票(xrem005) 及壞帳提列傳票(xrej005) 
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM xrem_t
    WHERE xrement = g_enterprise
      AND xremld  = g_detail_d[p_ac].xreald
      AND xrem001 = tm.xrea001
      AND xrem002 = tm.xrea002
      AND xrem003 = 'AP'
      AND xrem005 IS NOT NULL
   IF cl_null(l_count)THEN LET l_count = 0 END IF      
   IF l_count <> 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET l_msg = "ld:",g_detail_d[p_ac].xreald," "
      LET g_errparam.extend = l_msg CLIPPED
      LET g_errparam.code   = "aap-00220"
      LET g_errparam.replace[1] = tm.xrea001
      LET g_errparam.replace[2] = tm.xrea002
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM xrej_t
    WHERE xrejent = g_enterprise
      AND xrejld  = g_detail_d[p_ac].xreald
      AND xrej001 = tm.xrea001
      AND xrej002 = tm.xrea002
      AND xrej003 = 'AP'
      AND xrej005 IS NOT NULL
   IF cl_null(l_count)THEN LET l_count = 0 END IF      
   IF l_count <> 0 THEN
      INITIALIZE g_errparam TO NULL
      LET l_msg = "ld:",g_detail_d[p_ac].xreald," "
      LET g_errparam.extend = l_msg CLIPPED
      LET g_errparam.code   = "aap-00221"
      LET g_errparam.replace[1] = tm.xrea001
      LET g_errparam.replace[2] = tm.xrea002
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 跑array把有勾的都跑刪除
# Memo...........:
# Date & Author..: 141027 by albireo
# Modify.........: 150114 by albireo 修改錯誤訊息;把年度期別檢核搬入
################################################################################
PUBLIC FUNCTION aapp970_process()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_index       LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_para_data   LIKE type_t.dat      #albireo 150114
   DEFINE l_glaa121     LIKE glaa_t.glaa121  #Belle 150205
   DEFINE l_docno       LIKE apca_t.apcadocno
   #前面檢核都沒問題才勾的起來  所以這邊不檢核合理性
   #會失敗只有語法問題等等的
   DEFINE l_sql         STRING
   DEFINE l_cnt2        LIKE type_t.num5     #150319-00006#1
   LET r_success = TRUE
   
   #albireo 150114---------------------------s
   CALL cl_get_para(g_enterprise,tm.xreasite,'S-FIN-3007') RETURNING l_para_data

   IF (YEAR(l_para_data)*12+MONTH(l_para_data)) > (tm.xrea001*12 + tm.xrea002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00249'
      LET g_errparam.extend = ''
      LET g_errparam.popup =TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #albireo 150114---------------------------e
   
   ##############################################################   
   #   if 有則不可以還原
   #else 
   #    delete from xrem   # 暫估主檔
   #    delete from xren   # 暫估明細檔
   #    delete from xrej_t # 帳齡主檔
   #    delete from xrek_t # 帳齡明細檔
   #      where 單身選擇的帳套
   #        and 會計年度+期別 
   #
   #    delete from xrea 
   #        where 單身選擇的帳套
   #          and 會科年度+期別 
   #end if 
   #上述為規格內容
   ##############################################################
   #150205
   
   CALL s_aapp970_prepare_declare()   #150319-00006#1 add
   #150205
   FOR l_index = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_index].sel = 'Y' THEN
         
         #150319-00006#1 搬入sub-----s
        #CALL s_aapp970_do_process(g_detail_d[l_index].xreald,tm.xrea001,tm.xrea001) #150602-00063#1 mark
         CALL s_aapp970_do_process(g_detail_d[l_index].xreald,tm.xrea001,tm.xrea002) #150602-00063#1
            RETURNING g_sub_success,l_cnt2
            
         IF l_cnt2 > 0 THEN
            LET l_cnt = 1
         END IF
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
         #150319-00006#1 搬入sub-----e
         
         LET g_detail_d[l_index].sel = 'N'   #150115 albireo 必免殘存資料做了重複處理
      END IF
   END FOR
   #若沒有刪到任何資料 表示月結沒有處理
   IF l_cnt = 0 THEN
      LET r_success = FALSE
      #albireo 150114------------------------s
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'aap-00313'
      LET g_errparam.popup  = TRUE
      CALL cl_err() 
      #albireo 150114------------------------e
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# 等add_point有就放進去qbe_clear的 ON ACTION
# By 141027 albireo
################################################################################
PUBLIC FUNCTION aapp970_clear_qbe()
DEFINE l_para_data    LIKE type_t.dat
DEFINE l_ooef017 LIKE ooef_t.ooef017
   
   #150127-00007#1 add---
   CLEAR FORM
   INITIALIZE tm.* TO NULL
   CALL g_detail_d.clear()
   #150127-00007#1 add end---
   
   LET tm.xreasite = g_site
   LET tm.xreasite_desc = s_desc_get_department_desc(tm.xreasite)
   DISPLAY BY NAME tm.xreasite_desc
   #141215:取得帳務中心所屬法人
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-3007') RETURNING l_para_data   #預設年度/期別
  #CALL cl_get_para(g_enterprise,tm.xreasite,'S-FIN-3007') RETURNING l_para_data
   LET tm.xrea001 = YEAR(l_para_data)
   LET tm.xrea002 = MONTH(l_para_data) 
   
END FUNCTION

#end add-point
 
{</section>}
 
