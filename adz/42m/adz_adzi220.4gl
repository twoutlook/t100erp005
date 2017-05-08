
#+ 程式版本......: T6 Version 1.00.00 Build-0002 at 12/12/11
#
#+ 程式代碼......: adzi220
#+ 設計人員......: hiko,cch
# Modify.........: No.000001 2013/02/21 By benson 調整操作方式與異動資料庫的時機 
#                : 2014/04/10 By madey 檢查是否在使用中,增加判斷dzbb_t;並調整訊息顯示格式
#                : 2014/04/16 By madey query clob語法由like改用DBMS_LOB.INSTR (like有錯)
#                  2014/09/05 by madey 1.dzcel004.設為可輸可不輸(4gl,4fd都要調整)
#                                      2.dzcel_t,dzcdl_t新增時自動補入中文語系資料(輸繁體時補簡體,反之)
#                                      3.bug fidelete,modify的程式段
#                  2015/07/29 by madey 標準轉客製相關功能移到下方combobox
#                  2015/08/04 by madey 1.調整多處INT_FLAG
#                                      2.topstd帳號無法修改/刪除客製資料
#                  2015/08/17 by madey 使用中清單get_using_list()改僅提供搜尋指令
#                  2015/12/04 by madey 1.調整sql驗證時arg的預設值,統一將arg換成單引號
#                                      2.明細操作增加sql_verify
#                  2015/12/29 by madey 公用變數TODAY給值改為帶TO_DATE格式，解決DBDATE變更及資料型態為timestamp>時sql出錯
#                  20160428 160428-00021 by madey :1.sql檢核cartesian
#                                                  2.增加god mode
#                                                  3.god mode:可以整批sql驗證
#                  20160707 160707-00014 by madey :insert時,檢查已存在的where條件微調，不需要判斷客製否
#                  20161104 161104-00043 by madey :sql檢核錯誤時增加顯示SQLERRMESSAGE
#                  20161215 161215-00066 by madey :修正在英文語系下存檔會crash
 
IMPORT os
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#單頭 type 宣告
PRIVATE type type_g_dzcd_m        RECORD
          dzcd001 LIKE dzcd_t.dzcd001, 
          dzcdl003 LIKE dzcdl_t.dzcdl003,
          dzcd002 LIKE dzcd_t.dzcd002,  #20141007
          dzcd003 LIKE dzcd_t.dzcd003, 
          dzcd004 LIKE dzcd_t.dzcd004, 
          dzcd005 LIKE dzcd_t.dzcd005, 
          error_description LIKE type_t.chr200,
          #dzcdstus LIKE dzcd_t.dzcdstus, #忽略狀態碼 
          dzcdmodid LIKE dzcd_t.dzcdmodid, 
          modid_desc LIKE type_t.chr500, 
          dzcdmoddt DATETIME YEAR TO SECOND, 
          dzcdownid LIKE dzcd_t.dzcdownid, 
          ownid_desc LIKE type_t.chr500, 
          dzcdowndp LIKE dzcd_t.dzcdowndp, 
          owndp_desc LIKE type_t.chr500, 
          dzcdcrtid LIKE dzcd_t.dzcdcrtid, 
          crtid_desc LIKE type_t.chr500, 
          dzcdcrtdp LIKE dzcd_t.dzcdcrtdp, 
          crtdp_desc LIKE type_t.chr500, 
          dzcdcrtdt DATETIME YEAR TO SECOND,
          dzcd006 LIKE dzcd_t.dzcd006 #20150114
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dzce_d        RECORD
          dzce002 LIKE dzce_t.dzce002, 
          dzce004 LIKE dzce_t.dzce004, 
          dzcel004 LIKE dzcel_t.dzcel004,
	  dzce003 LIKE dzce_t.dzce003#20141007
       END RECORD

#單身 type 宣告
PRIVATE TYPE type_g_dzch_d        RECORD
          dzch002 LIKE dzch_t.dzch002, 
          dzch003 LIKE dzch_t.dzch003, 
          dzch004 LIKE dzch_t.dzch004,
          gzze003 LIKE gzze_t.gzze003,
	  dzch005 LIKE dzch_t.dzch005  #20141007
       END RECORD

################################################################################
#定義SQL語法中使用的tag名稱常數
CONSTANT G_COUNT_START = "<count>"     #count開始符   
CONSTANT G_COUNT_END   = "</count>"    #count結束符
CONSTANT G_FIELD_START = "<field>"     #欄位代碼開始符   
CONSTANT G_FIELD_END   = "</field>"    #欄位代碼結束符
CONSTANT G_TABLE_START = "<table>"     #資料表代碼開始符  
CONSTANT G_TABLE_END   = "</table>"    #資料表代碼結束符
CONSTANT G_WHERE_START = "<wc>"        #Where條件開始符  
CONSTANT G_WHERE_END   = "</wc>"       #Where條件結束符 

#130221 By benson
################################################################################
## Define Combobox related SQLs
DEFINE ms_SQL_Chk_type       STRING
DEFINE ms_SQL_Sample         STRING
DEFINE ms_SQL_Global_var     STRING
################################################################################
 
#模組變數(Module Variables)
DEFINE g_dzcd_m          type_g_dzcd_m
DEFINE g_dzcd_m_t        type_g_dzcd_m
 
DEFINE g_dzcd001_t       LIKE dzcd_t.dzcd001
DEFINE g_dzcd002_t       LIKE dzcd_t.dzcd002 #20141007
 
DEFINE g_dzce_d          DYNAMIC ARRAY OF type_g_dzce_d
DEFINE g_dzce_d_t        type_g_dzce_d

DEFINE g_dzch_d          DYNAMIC ARRAY OF type_g_dzch_d
DEFINE g_dzch_d_t        type_g_dzch_d
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         #b_statepic     LIKE type_t.chr50, #忽略狀態碼 
         b_dzcd001       LIKE dzcd_t.dzcd001,
         b_dzcdl003       LIKE dzcdl_t.dzcdl003,
         rank            LIKE type_t.num10,
	 b_dzcd002       LIKE dzcd_t.dzcd002  #20141007
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc3                 STRING                          #單身CONSTRUCT結果
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_before_input_done   LIKE type_t.num5 
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_argv1               STRING
DEFINE g_field_var_asign     LIKE gzze_t.gzze003

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_v_prog_test         LIKE dzcd_t.dzcd001
DEFINE g_global_var          STRING
DEFINE g_dgenv               STRING                        #20141007
DEFINE g_topind              STRING                        #20160329 行業別
DEFINE g_god_mode            BOOLEAN #160428-00021
DEFINE ls_tmp_arg            STRING  #160428-00021
DEFINE g_v_errmsg      STRING  #160428-00021
 
#+ 作業開始
MAIN
   #Begin:modify by Hiko
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_4tb_path STRING,
          ls_img_path STRING
   #End

   #定義在其他link的程式則無效
   #WHENEVER ERROR CALL cl_err_msg_log #2015/04/01 by Hiko:避免訊息被吃掉

   #LET g_argv1 = ARG_VAL(2)  #20141007 mark: bug fix
 
   CALL cl_tool_init()

   #Begin: 160428-00021 modify
   #End: 160428-00021 modify
  #LET g_v_prog_test = ARG_VAL(2)
   LET ls_tmp_arg = DOWNSHIFT(ARG_VAL(2))
   IF ls_tmp_arg = "debug" THEN 
      DISPLAY "God Mode:ON"
      LET g_god_mode = TRUE
   ELSE
      LET g_v_prog_test = ls_tmp_arg
      #20141007
      IF NOT cl_null(g_v_prog_test) THEN
         DISPLAY "g_v_prog_test = ",g_v_prog_test
         CALL adzi220_test_verify_prog(g_v_prog_test)
         EXIT PROGRAM
      END IF
   END IF
	  
   #LOCK CURSOR
   LET g_forupd_sql = "SELECT dzcd001,dzcdl003,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,'',dzcdmoddt,dzcdownid,'',dzcdowndp,'',dzcdcrtid,'',dzcdcrtdp,'',dzcdcrtdt,dzcd006 ",
                      " FROM dzcd_t ",
                      " LEFT JOIN dzcdl_t ON dzcdl001 = dzcd001 AND dzcdl002 = '",g_lang,"' ",
                      " WHERE dzcd001=? AND dzcd002=? FOR UPDATE "					  
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE adzi220_cl CURSOR FROM g_forupd_sql   #cursor lock 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi220 WITH FORM cl_ap_formpath("adz",g_prog)
 
   CLOSE WINDOW screen

   #程式初始化
   CALL adzi220_init()
 
   #Begin:modify by Hiko
   CALL cl_ui_wintitle(1) #工具抬頭名稱

   #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
   CALL cl_load_4ad_interface(NULL) 

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET lf_form = lw_window.getForm()
   LET ls_4tb_path = os.Path.join(os.Path.join(ls_cfg_path, "4tb"), "toolbar_designer.4tb")
   CALL lf_form.loadToolBar(ls_4tb_path)
   #End

   #Begin: 160428-00021
   IF g_god_mode THEN
      CALL lf_form.setElementHidden("lbl_chk_sql_all_v", FALSE) 
   END IF
   #End: 160428-00021

   #進入選單 Menu (='N')
   CALL adzi220_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_adzi220
      
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
    
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi220_init()
   #130221 By benson --- S
   DEFINE lo_Combobox ui.ComboBox 
   DEFINE l_dzcd001    STRING

   #動態產生comboBox內容
   CALL adzi220_initial_combobox_sql()

   #Begin:2015/04/01 by Hiko
   #LET lo_Combobox = ui.ComboBox.forName("dzcd_t.dzcd005")
   #CALL adzi220_fill_combobox(lo_Combobox,ms_SQL_Chk_Type)
   CALL cl_set_combo_scc("dzcd_t.dzcd005","220")

   LET lo_Combobox = ui.ComboBox.forName("formonly.l_sql_sample")
   CALL adzi220_fill_combobox(lo_Combobox,ms_SQL_Sample)

   #LET lo_Combobox = ui.ComboBox.forName("formonly.l_global_var")
   #CALL adzi220_fill_combobox(lo_Combobox,ms_SQL_Global_var) 

   CALL cl_set_combo_scc("cbo_exe","221")
   #End:2015/04/01 by Hiko

   SELECT gzze003 INTO g_field_var_asign 
      FROM gzze_t 
      WHERE gzze001="adz-00187" AND gzze002 = g_lang
   
   #LET g_field_var_asign = "<- ### 預設欄位變數指定到arg1 ###"
   
   #20141007 :bug fix: g_argv1有值時會走test prog流程,不會再進到此處
   #IF NOT cl_null(g_argv1) THEN
   #   LET g_wc = "dzcd001 IN (",g_argv1,")"
   #ELSE
   #   LET g_wc = " 1=1"
   #END IF 
   #130221 By benson --- E

   LET g_wc = " 1=1" #20141007
   #取得DGENV #20141007
   LET g_dgenv = FGL_GETENV("DGENV")
  
   #取得TOPIND #20160329
   LET g_topind = FGL_GETENV("TOPIND")
   IF cl_null(g_topind) THEN
      LET g_topind = 'sd'
   END IF

   CALL cl_set_combo_industry("dzcd006") #20150114
  
   CALL adzi220_browser_fill("")
END FUNCTION
 
 
#+ 選單功能實際執行處
PRIVATE FUNCTION adzi220_ui_dialog()
DEFINE lb_result BOOLEAN  #20160329

   WHILE TRUE
      LET INT_FLAG=0     #20150804
      CALL adzi220_bp()
        
      CASE g_action_choice

         WHEN "query"
               CALL adzi220_query()
         WHEN "modify"
               #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
               CALL sadzp060_ind_check_modify_permissions(g_dzcd_m.dzcd006,'u', true) RETURNING lb_result
               IF lb_result THEN
                  CALL adzi220_modify()
               END IF
               #End:20160329 by elena
         WHEN "insert"
               CALL adzi220_insert()
         WHEN "delete"
               #Begin:20160329 by elena 新增行業判斷，行業環境不可修改標準資料
               CALL sadzp060_ind_check_modify_permissions(g_dzcd_m.dzcd006,'d', true) RETURNING lb_result
               IF lb_result THEN
                  CALL adzi220_delete()
               END IF
               #End:20160329 by elena
         WHEN "reproduce"
               CALL adzi220_reproduce()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "bw_first"     
            CALL adzi220_browser_fill("first") 
            
         WHEN "bw_prev" 
            CALL adzi220_browser_fill("prev")
            
         WHEN "bw_next" 
            CALL adzi220_browser_fill("next")
            
         WHEN "bw_last"             
            CALL adzi220_browser_fill("last")

         WHEN "std_to_cust" #標準轉客製 #20150729    
            CALL adzi220_std_to_cust() 
         
         WHEN "cust_to_std" #客製還原標準 #2050729
            CALL adzi220_cust_to_std() 

         #20151204 -Begin-
         WHEN "sql_verify" #sql驗證
            IF g_dzcd_m.dzcd003 IS NOT NULL THEN
              #IF adzi220_sql_verify(g_dzcd_m.dzcd003) THEN
               IF adzi220_sql_verify(g_dzcd_m.dzcd003,g_dzcd_m.dzcd005,TRUE) THEN   #160428-00021
                  IF adzi220_chk_cartesian(g_dzcd_m.dzcd003,TRUE) THEN END IF       #160428-00021
                  CALL cl_ask_pressanykey('adz-00477')
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00022" 
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  " SQL is null "
               CALL cl_err()
            END IF
         #20151204 -End-
 
      END CASE
      
   END WHILE
   
END FUNCTION
 
 
#+ 功能選單
PRIVATE FUNCTION adzi220_bp()
   DEFINE ls_cmd     STRING 
   DEFINE ls_exe_item STRING #2015/04/23 by Hiko
  
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("worksheet",1)
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   CALL adzi220_browser_fill("dialog")

   #Begin:2015/04/01 by Hiko
   #DISPLAY g_field_var_asign TO s_field_var_asign
   #DISPLAY g_global_var TO s_global_var
   #End:2015/04/01 by Hiko
   
   DIALOG ATTRIBUTES(UNBUFFERED)
 
      #左側瀏覽頁簽
      DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
      
         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            CALL adzi220_fetch('') # reload data

            #控制上下筆的按鈕是否啟動
            CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            LET g_detail_idx = 1
            CALL adzi220_ui_detailshow() #Setting the current row

           IF g_dzcd_m.dzcd005 = "2" THEN
               CALL cl_set_comp_visible("grid_exist_err",FALSE)#隱藏
               #CALL cl_set_comp_visible("grid_non_exist_err",FALSE)#隱藏 #2015/04/01 by Hiko
            ELSE
               CALL cl_set_comp_visible("grid_exist_err",TRUE)#出現
               #CALL cl_set_comp_visible("grid_non_exist_err",TRUE)#出現 #2015/04/01 by Hiko
            END IF
          
      END DISPLAY
     
      DISPLAY ARRAY g_dzce_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) 
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            
            CALL adzi220_ui_detailshow()
      END DISPLAY
     
      DISPLAY ARRAY g_dzch_d TO s_err_detail.* ATTRIBUTES(COUNT=g_rec_b) 
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_err_detail")
            LET l_ac = g_detail_idx
            
            CALL adzi220_ui_detailshow()
      END DISPLAY
 
      #Begin:2015/04/23 by Hiko
      INPUT ls_exe_item FROM cbo_exe ATTRIBUTE(WITHOUT DEFAULTS)
      END INPUT
      #End:2015/04/23 by Hiko

      BEFORE DIALOG

         CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
         LET g_curr_diag = ui.DIALOG.getCurrent()         
         LET g_page = "first"
         LET g_current_sw = FALSE
         #回歸舊筆數位置 (回到當時異動的筆數)
         LET g_current_idx = DIALOG.getCurrentRow("s_browse")
         IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
            CALL DIALOG.setCurrentRow("s_browse",g_current_row)
            LET g_current_idx = g_current_row
         END IF
         LET g_current_row = g_current_idx #目前指標
         LET g_current_sw = TRUE
         
         IF g_current_idx > g_browser.getLength() THEN
            LEt g_current_idx = g_browser.getLength()
         END IF 
         
         #有資料才進行fetch
         IF g_current_idx <> 0 THEN
            CALL adzi220_fetch('') # reload data
         END IF

         #控制上下筆的按鈕是否啟動
         CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
         LET g_detail_idx = 1
         CALL adzi220_ui_detailshow() #Setting the current row 
         
         #若無資料則關閉相關功能
         IF g_browser_cnt = 0 THEN
            CALL cl_set_act_visible("modify,delete,reproduce", FALSE)
         ELSE
            CALL cl_set_act_visible("modify,delete,reproduce", TRUE)
         END IF

         IF g_dzcd_m.dzcd005 = "2" THEN
            CALL cl_set_comp_visible("grid_exist_err",FALSE)#隱藏
            #CALL cl_set_comp_visible("grid_non_exist_err",FALSE)#隱藏 #2015/04/01 by Hiko
         ELSE
            CALL cl_set_comp_visible("grid_exist_err",TRUE)#出現
            #CALL cl_set_comp_visible("grid_non_exist_err",TRUE)#出現 #2015/04/01 by Hiko
         END IF
         
      ON ACTION close
         LET g_action_choice = "exit"
         EXIT DIALOG     
       
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
       
      ON ACTION bw_first               #page first 
         LET g_action_choice = "bw_first"   
         EXIT DIALOG
 
      ON ACTION bw_prev                #page previous
         LET g_action_choice = "bw_prev"     
         EXIT DIALOG
 
      ON ACTION bw_next                #page next
         LET g_action_choice = "bw_next"     
         EXIT DIALOG
       
      ON ACTION bw_last                #page last 
         LET g_action_choice = "bw_last"     
         EXIT DIALOG
 
      
      ON ACTION query
            LET g_action_choice="query"
            EXIT DIALOG 
 
      ON ACTION modify
            LET g_action_choice="modify"
            EXIT DIALOG 
 
      ON ACTION insert
            LET g_action_choice="insert"
            EXIT DIALOG 
 
      ON ACTION delete
            LET g_action_choice="delete"
            EXIT DIALOG 
 
      ON ACTION reproduce
            LET g_action_choice="reproduce"
            EXIT DIALOG 
 
      ON ACTION lbl_sql_edit
            CALL adzi220_run_prog("r.r","adzi230",g_prog)

      ON ACTION lbl_sql_builder
            LET ls_cmd = " adzp190 ",g_prog
            CALL cl_cmdrun(ls_cmd)
            
      #Begin:2015/04/23 by Hiko
      ON ACTION btn_exe
         #防呆，要選到某筆資料才能往下走
         IF ls_exe_item = "2" THEN
         ELSE
            IF cl_null(g_dzcd_m.dzcd001) OR cl_null(g_dzcd_m.dzcd002) THEN
               CALL cl_ask_pressanykey("adz-00564") #請先選取資料
               RETURN
            END IF
         END IF

         CASE ls_exe_item
            WHEN "1"  #查詢使用中程式
              #IF cl_ask_confirm_parm("adz-00396","") THEN  
                  CALL adzi220_get_using_list()
              #END IF
            WHEN "2"  #查詢可用變數
               CALL adzi220_run_prog("r.r","adzq221",'')
            WHEN "3" #標準轉客製  #20150729
               LET g_action_choice="std_to_cust"
               EXIT DIALOG 
            WHEN "4" #客製還原標準 #20150729
               LET g_action_choice="cust_to_std"
               EXIT DIALOG 
            #20151204 -Begin-
            WHEN "5" #sql驗證
               LET g_action_choice="sql_verify"
               EXIT DIALOG
            #20151204 -End-
         END CASE
      #End:2015/04/23 by Hiko

      #Bebin: 160428-00021
      ON ACTION lbl_chk_sql_all_v #驗證所有v sql
         IF cl_ask_confirm_parm("adz-00396","") THEN  
            CALL adzi220_chk_sql_all_v()
         END IF
      #End: 160428-00021

      #啟動校驗帶值測試工具
      ON ACTION lbl_test_v_prog
         CALL adzi220_test_verify_prog(g_dzcd_m.dzcd001)

      #Begin:2015/04/23 by Hiko:改在btn_exe呼叫
      #檢查使用中程式 #20140930                                                                                
      #ON ACTION lbl_get_using_list
      #   IF cl_ask_confirm_parm("adz-00396","") THEN  
      #      CALL adzi220_get_using_list()
      #   END IF
      #End:2015/04/23 by Hiko
         
      #主選單用ACTION
      #&include "main_menu.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl" 
      CONTINUE DIALOG
   END DIALOG
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

#+ 啟動校驗帶值測試工具
PRIVATE FUNCTION adzi220_test_verify_prog(ps_call_v_id)
   DEFINE ps_call_v_id   LIKE dzcd_t.dzcd001
   DEFINE ps_call_v_id_cust_flag  LIKE dzcd_t.dzcd002 #20141007
   DEFINE ls_call_v_id   STRING   
   DEFINE l_ch_out       base.Channel
   DEFINE ls_file_path   STRING
   DEFINE lb_chrwx_return LIKE type_t.num5
   DEFINE l_dzcd005       LIKE dzcd_t.dzcd005
   #20141007 -Begin-
   DEFINE lb_have_cust   BOOLEAN,
          li_cnt         LIKE type_t.num5   
   #20141007 -End-

   #20141007:確認是否有被客製 -Begin-
   CALL cl_chk_validate_chk_have_cust(ps_call_v_id) RETURNING li_cnt,lb_have_cust
   IF li_cnt > 0 THEN
       IF lb_have_cust THEN
          DISPLAY "adzi220_test_verify_prog: 此v_xxx已客製"
          LET ps_call_v_id_cust_flag = 'c'
       ELSE
          LET ps_call_v_id_cust_flag = 's'
       END IF

       #標準轉客製時,提示此v有被客製,將導向客製過的v
       IF lb_have_cust AND li_cnt > 1  AND g_dzcd_m.dzcd002='s' THEN
          IF cl_ask_confirm('adz-00405') THEN
          ELSE
             RETURN
          END IF
       END IF
   ELSE
      #沒資料, 離開
      DISPLAY "no data in dzcd_t"
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00027"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   #20141007:確認是否有被客製 -End-
   
   #要換置呼叫校驗帶值程式的檔案路徑
   LET ls_file_path = os.path.join(os.path.join(FGL_GETENV("COM"),"inc"),"chk_and_ref_prog.4gl")

   #SELECT dzcd005 INTO l_dzcd005
   #   FROM dzcd_t WHERE dzcd001=ps_call_v_id
   #20141007
   SELECT dzcd005 INTO l_dzcd005
      FROM dzcd_t WHERE dzcd001=ps_call_v_id AND dzcd002=ps_call_v_id_cust_flag   
   
   #組合呼叫校驗帶值識別碼的字串
   CASE l_dzcd005
      WHEN 1 #檢查存在
          LET  ls_call_v_id = 
            "IF NOT cl_chk_exist(\"",ps_call_v_id,"\") THEN",ASCII 10,
            "   #Not exist OR SQL error!",ASCII 10,
            "END IF"
   
      WHEN 2 #帶值
         LET  ls_call_v_id = 
             "CALL cl_ref_val(\"",ps_call_v_id,"\")"

      WHEN 3 #檢查存在與帶值
         LET  ls_call_v_id =
             "IF NOT cl_chk_exist_and_ref_val(\"",ps_call_v_id,"\") THEN",ASCII 10,
            "   #Not exist or Not unique or SQL error!",ASCII 10,
            "END IF"
   END CASE
   

   #置換要呼叫的校驗帶值識別碼
   LET l_ch_out = base.Channel.create()
   CALL l_ch_out.setDelimiter("%")

   #指定寫入路徑
   CALL l_ch_out.openFile(ls_file_path,"w")

   DISPLAY "##################################"
   DISPLAY "ls_call_v_id = ",ls_call_v_id
   
   #指定寫入內容
   CALL l_ch_out.writeLine(ls_call_v_id)

   CALL l_ch_out.close()

   CALL os.Path.chrwx(ls_file_path, 511) RETURNING lb_chrwx_return

   #切換路徑到ADZ模組底下的4gl  
   IF os.Path.chdir(os.path.join(FGL_GETENV("ADZ"),"4gl")) THEN
      CALL adzi220_run_prog("r.c","adzp290","")
      CALL adzi220_run_prog("r.l","adzp290","")
      CALL adzi220_run_prog("r.r","azzp191","adzp290 "||g_lang)
      CALL adzi220_run_prog("r.r","adzp290",ps_call_v_id)
      #DISPLAY "執行完程"
   END IF
END FUNCTION

#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi220_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_wc3             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE l_num_in_page     LIKE type_t.num5 #每頁筆數
 
   LET l_num_in_page = 30
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzcd_m.* TO NULL
   CALL g_dzce_d.clear()        
   CALL g_dzch_d.clear()
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "dzcd001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   LET l_wc3 = g_wc3.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) OR g_wc3 <> " 1=1" OR NOT cl_null(g_wc3) THEN
      #單身有輸入搜尋條件                      
       LET l_sub_sql = " SELECT UNIQUE dzcd001,dzcd002 ", #20141007
                      " FROM dzcd_t ",
                      " INNER JOIN ",    #20150114 調整sql
                          "(SELECT DISTINCT cd1.dzcd001 AS dzcd001_1,                        ",
                          "       CASE                                                       ",
                          "         WHEN EXISTS (SELECT 1                                    ", #標準跟客製都有,只顯示客製
                          "                 FROM dzcd_t cd2                                  ",
                          "                WHERE cd2.dzcd001 = cd1.dzcd001                   ",
                          "                  AND cd2.dzcd002 = 'c') THEN                     ",
                          "          'c'                                                     ",
                          "         ELSE                                                     ",
                          "          's'                                                     ",
                          "       END AS dzcd002_1                                           ",
                          "  FROM (SELECT cd0.dzcd001, cd0.dzcd002 FROM dzcd_t cd0) cd1) cd2 ",
                      " ON dzcd001 = cd2.dzcd001_1 AND dzcd002 = cd2.dzcd002_1               ",
                      " LEFT JOIN dzce_t ON dzcd001 = dzce001 AND dzcd002 = dzce003", #20141007 
                      " LEFT JOIN dzch_t ON dzcd001 = dzch001 AND dzcd002 = dzch005", #20141007
                      " LEFT JOIN dzcdl_t ON dzcd001 = dzcdl001 AND dzcdl002= '",g_lang,"'", 
                      " LEFT JOIN dzcel_t ON dzcd001 = dzcel001 AND dzcel003= '",g_lang,"'",
                      " WHERE ",l_wc, " AND ", l_wc2, " AND ", l_wc3
 
   ELSE
      #單身未輸入搜尋條件
       LET l_sub_sql = " SELECT UNIQUE dzcd001,dzcd002 ", #20141007
                      " FROM dzcd_t ",
                      " INNER JOIN ",    #20150114 調整sql
                          "(SELECT DISTINCT cd1.dzcd001 AS dzcd001_1,                        ",
                          "       CASE                                                       ",
                          "         WHEN EXISTS (SELECT 1                                    ", #標準跟客製都有,只顯示客製
                          "                 FROM dzcd_t cd2                                  ",
                          "                WHERE cd2.dzcd001 = cd1.dzcd001                   ",
                          "                  AND cd2.dzcd002 = 'c') THEN                     ",
                          "          'c'                                                     ",
                          "         ELSE                                                     ",
                          "          's'                                                     ",
                          "       END AS dzcd002_1                                           ",
                          "  FROM (SELECT cd0.dzcd001, cd0.dzcd002 FROM dzcd_t cd0) cd1) cd2 ",
                      " ON dzcd001 = cd2.dzcd001_1 AND dzcd002 = cd2.dzcd002_1               ",
                      " LEFT JOIN dzcdl_t ON dzcd001 = dzcdl001 AND dzcdl002= '",g_lang,"'", 
                      " WHERE ",l_wc CLIPPED
 
   END IF
 
   #Begin:20160329 by elena
   #標準環境只能查詢標準資料，行業環境只能查詢標準資料與該行業資料
   IF sadzp060_ind_check_area() THEN
     LET l_sub_sql = l_sub_sql, " and dzcd006 in ('sd','", g_topind ,"') "
   ELSE
     #標準環境只能看到標準程式，客製環境可以看到標準和所有行業程式
     IF g_dgenv = 's' THEN
        LET l_sub_sql = l_sub_sql, " and dzcd006 ='sd' "
     END IF
   END IF
   #End:20160329 by elena  

 
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"

   #DISPLAY "g_sql = ",g_sql
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
 
   LET g_page_action = ps_page_action          # Keep Action
   
   CASE g_page_action
      WHEN "first" 
          LET g_pagestart = 1
          
      WHEN "prev"  
          LET g_pagestart = g_pagestart - l_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
          
      WHEN "next"  
         LET g_pagestart = g_pagestart + l_num_in_page
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod l_num_in_page) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - l_num_in_page
            END WHILE
         END IF
      
      WHEN "last"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod l_num_in_page) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - l_num_in_page
         END WHILE
         
      WHEN "dialog"
      
      OTHERWISE
         LET g_pagestart = 1
          
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) OR g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN 
      #依照dzcd001,dzcdl003 Browser欄位定義(取代原本bs_sql功能)
       LET l_sql_rank = "SELECT DISTINCT dzcd001,dzcdl003,RANK() OVER(ORDER BY dzcd001 ",g_order,") AS RANK ,dzcd002", #20141007
                       " FROM dzcd_t ",
                       " INNER JOIN ",    #20150114 調整sql
                          "(SELECT DISTINCT cd1.dzcd001 AS dzcd001_1,                                  ",
                          "       CASE                                                       ",
                          "         WHEN EXISTS (SELECT 1                                    ", #標準跟客製都有,只顯示客製
                          "                 FROM dzcd_t cd2                                  ",
                          "                WHERE cd2.dzcd001 = cd1.dzcd001                   ",
                          "                  AND cd2.dzcd002 = 'c') THEN                     ",
                          "          'c'                                                     ",
                          "         ELSE                                                     ",
                          "          's'                                                     ",
                          "       END AS dzcd002_1                                           ",
                          "  FROM (SELECT cd0.dzcd001, cd0.dzcd002 FROM dzcd_t cd0) cd1) cd2 ",
                       " ON dzcd001 = cd2.dzcd001_1 AND dzcd002 = cd2.dzcd002_1              ",
                       " LEFT JOIN dzce_t ON dzcd001 = dzce001 AND dzcd002 = dzce003", #20141007
                       " LEFT JOIN dzch_t ON dzcd001 = dzch001 AND dzcd002 = dzch005", #20141007
                       " LEFT JOIN dzcdl_t ON dzcd001 = dzcdl001 AND dzcdl002= '",g_lang,"'",
                       " LEFT JOIN dzcel_t ON dzcd001 = dzcel001 AND dzcel003= '",g_lang,"'",
                       " WHERE ",g_wc," AND ",g_wc2," AND ",g_wc3

       #Begin:20160329 by elena
       #標準環境只能查詢標準資料，行業環境只能查詢標準資料與該行業資料
       IF sadzp060_ind_check_area() THEN
         LET l_sql_rank = l_sql_rank, " and dzcd006 in ('sd','" , g_topind , "') "
       ELSE
         #標準環境只能看到標準程式，客製環境可以看到標準和所有行業程式
         IF g_dgenv = 's' THEN
            LET l_sql_rank = l_sql_rank, " and dzcd006 ='sd' "
         END IF
       END IF
       #End:20160329 by elena     

 
      #LET g_sql= "SELECT dzcd001,dzcdl003,RANK FROM (SELECT dzcd001,dzcdl003,ROWNUM AS RANK FROM(",l_sql_rank,")) WHERE RANK>=",g_pagestart,
       LET g_sql= "SELECT dzcd001,dzcdl003,RANK,dzcd002 FROM (SELECT dzcd001,dzcdl003,ROWNUM AS RANK ,dzcd002 FROM(",l_sql_rank,")) WHERE RANK>=",g_pagestart, #20141007
           " AND RANK<",g_pagestart+l_num_in_page,
           " ORDER BY ",l_searchcol," ",g_order
   ELSE
      #單身無輸入資料
       LET l_sql_rank = "SELECT DISTINCT dzcd001,dzcdl003,RANK() OVER(ORDER BY dzcd001 ",g_order,") AS RANK ,dzcd002", #20141007
                       " FROM dzcd_t ",
                       " INNER JOIN ",    #20150114 調整sql
                          "(SELECT DISTINCT cd1.dzcd001 AS dzcd001_1,                                  ",
                          "       CASE                                                       ",
                          "         WHEN EXISTS (SELECT 1                                    ", #標準跟客製都有,只顯示客製
                          "                 FROM dzcd_t cd2                                  ",
                          "                WHERE cd2.dzcd001 = cd1.dzcd001                   ",
                          "                  AND cd2.dzcd002 = 'c') THEN                     ",
                          "          'c'                                                     ",
                          "         ELSE                                                     ",
                          "          's'                                                     ",
                          "       END AS dzcd002_1                                           ",
                          "  FROM (SELECT cd0.dzcd001, cd0.dzcd002 FROM dzcd_t cd0) cd1) cd2 ",
                       " ON dzcd001 = cd2.dzcd001_1 AND dzcd002 = cd2.dzcd002_1              ",
                       " LEFT JOIN dzcdl_t ON dzcd001 = dzcdl001 AND dzcdl002= '",g_lang,"'", 
                       " WHERE  ", g_wc

       #Begin:20160329 by elena
       #標準環境只能查詢標準資料，行業環境只能查詢標準資料與該行業資料
       IF sadzp060_ind_check_area() THEN
         LET l_sql_rank = l_sql_rank, " and dzcd006 in ('sd','" , g_topind , "') "
       ELSE
         #標準環境只能看到標準程式，客製環境可以看到標準和所有行業程式
         IF g_dgenv = 's' THEN
            LET l_sql_rank = l_sql_rank, " and dzcd006 ='sd' "
         END IF
       END IF
       #End:20160329 by elena

       LET g_sql= "SELECT dzcd001,dzcdl003,RANK,dzcd002 FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart, #20141007
           " AND RANK<",g_pagestart+l_num_in_page,
           " ORDER BY ",l_searchcol," ",g_order
   END IF

   #DISPLAY "g_sql = ",g_sql

   #定義翻頁CURSOR
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
  #FOREACH browse_cur INTO g_browser[g_cnt].b_dzcd001,g_browser[g_cnt].b_dzcdl003    
   FOREACH browse_cur INTO g_browser[g_cnt].b_dzcd001,g_browser[g_cnt].b_dzcdl003,g_browser[g_cnt].rank,g_browser[g_cnt].b_dzcd002 #20141007   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #SELECT dzcdl003 INTO g_browser[g_cnt].b_dzcdl003 FROM dzcdl_t WHERE dzcdl001 = g_browser[g_cnt].b_dzcd001 AND dzcdl002 = g_lang
      
      #LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic) #忽略狀態碼 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()

   #LET g_browser_cnt = g_browser.getLength()
   #IF g_browser_cnt = 0 AND ps_page_action <> "dialog" THEN
      #CALL cl_err('',-100,1)
   #END IF
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
END FUNCTION
 
 
#+ 單頭資料重新顯示
PRIVATE FUNCTION adzi220_ui_headershow()
   LET g_dzcd_m.dzcd001 = g_browser[g_current_idx].b_dzcd001   
   LET g_dzcd_m.dzcd002 = g_browser[g_current_idx].b_dzcd002  #20141007  
 
   SELECT UNIQUE dzcd001,dzcdl003,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006
      INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
      FROM dzcd_t
      LEFT JOIN dzcdl_t ON dzcdl001=dzcd001 AND dzcdl002=g_lang
      WHERE dzcd001 = g_dzcd_m.dzcd001 AND dzcd002 = g_dzcd_m.dzcd002  

   #SELECT dzcdl003 INTO g_dzcd_m.dzcdl003 
      #FROM dzcdl_t 
      #WHERE dzcdl001 = g_dzcd_m.dzcd001 AND dzcdl002 = g_lang
 
   CALL adzi220_show()
   
END FUNCTION
 
 
#+ 單身資料重新顯示
PRIVATE FUNCTION adzi220_ui_detailshow()
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_err_detail",g_detail_idx)      
   END IF
   
END FUNCTION
 
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi220_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   
   FOR l_i =1 TO g_browser.getLength()
     #IF g_browser[l_i].b_dzcd001 = g_dzcd_m.dzcd001 
     IF g_browser[l_i].b_dzcd001 = g_dzcd_m.dzcd001 AND 
        g_browser[l_i].b_dzcd002 = g_dzcd_m.dzcd002 #20141007
     THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
 
#+ QBE資料查詢
PRIVATE FUNCTION adzi220_construct()
   DEFINE lc_qbe_sn   LIKE type_t.num10
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzcd_m.* TO NULL
   CALL g_dzce_d.clear()    
   CALL g_dzch_d.clear()   
   
   LET g_current_idx = 1
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc3 TO NULL
    
   LET g_qryparam.state = 'c'

   #Begin:2015/04/01 by Hiko
   #DISPLAY g_field_var_asign TO s_field_var_asign
   #DISPLAY g_global_var TO s_global_var 
   #End:2015/04/01 by Hiko

   CALL cl_set_comp_visible("grid_exist_err",TRUE)#出現
   #CALL cl_set_comp_visible("grid_non_exist_err",TRUE)#出現 #2015/04/01 by Hiko
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED)
      
      #單頭
      CONSTRUCT g_wc ON dzcd001,dzcd005,dzcdl003,dzcd002,dzcd003,dzcd004,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006
         FROM dzcd_t.dzcd001,dzcd_t.dzcd005,dzcdl_t.dzcdl003,dzcd_t.dzcd002,dzcd_t.dzcd003,dzcd_t.dzcd004,dzcd_t.dzcdmodid,dzcd_t.dzcdmoddt,dzcd_t.dzcdownid,dzcd_t.dzcdowndp,dzcd_t.dzcdcrtid,dzcd_t.dzcdcrtdp,dzcd_t.dzcdcrtdt,dzcd_t.dzcd006

         
         ON ACTION update_item INFIELD dzcdl003
            ### 用於校驗帶值識別碼的模糊查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzcdl003( )
            LET g_dzcd_m.dzcdl003 = g_qryparam.return1
            DISPLAY g_dzcd_m.dzcdl003 TO dzcdl_t.dzcdl003
            ### 用於校驗帶值識別碼的模糊查詢### end ###

         ON ACTION controlp INFIELD dzcd004
            ### 校驗帶值設計器開窗2-提示訊息### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_gzze001( )
            LET g_dzcd_m.dzcd004 = g_qryparam.return1
            DISPLAY g_dzcd_m.dzcd004 TO dzcd_t.dzcd004
            ### 校驗帶值設計器開窗2-提示訊息### end ###

         BEFORE CONSTRUCT
           # CALL cl_qbe_init()cch: saki修改中,先mark
      END CONSTRUCT

      #單身可以混搭多頁簽
      CONSTRUCT g_wc3 ON dzch002,dzch003,dzch004
         FROM s_err_detail[1].dzch002,s_err_detail[1].dzch003,s_err_detail[1].dzch004
         BEFORE CONSTRUCT
           # CALL cl_qbe_display_condition(lc_qbe_sn)cch: saki修改中,先mark

         ON ACTION controlp INFIELD dzch004
            ### 校驗帶值設計器開窗2-提示訊息### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_gzze001( )
            LET g_dzch_d[1].dzch004 = g_qryparam.return1
            DISPLAY g_dzch_d[1].dzch004 TO s_err_detail[1].dzch004
            ### 校驗帶值設計器開窗2-提示訊息### end ###
      END CONSTRUCT      
 
      #單身可以混搭多頁簽
      CONSTRUCT g_wc2 ON dzce002,dzce004,dzcel004
         FROM s_detail2[1].dzce002,s_detail2[1].dzce004,s_detail2[1].dzcel004
         BEFORE CONSTRUCT
           # CALL cl_qbe_display_condition(lc_qbe_sn)cch: saki修改中,先mark

         ON ACTION update_item INFIELD dzcel004
            ### 用於開窗識別碼的模糊查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzcel004( )
            LET g_dzce_d[1].dzcel004 = g_qryparam.return1
            DISPLAY g_dzce_d[1].dzcel004 TO s_detail2[1].dzcel004
            ### 用於開窗識別碼的模糊查詢### end ###
      END CONSTRUCT

      ON ACTION accept
         LET INT_FLAG = 0 #20150804 
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1 #20150804 
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
   END DIALOG
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
 
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi220_query()
   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_dzce_d.clear()
   CALL g_dzch_d.clear()
 
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   
   CALL adzi220_construct()

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_dzcd_m.* TO NULL
      RETURN
   END IF
 
   CALL adzi220_browser_fill("first")
 
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi220_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
 
   #若無資料則離開
   IF g_current_idx = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF   
   IF cl_null(g_browser[g_current_idx].b_dzcd001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF   
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
   ELSE
      LET g_detail_idx = 0
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   LET g_dzcd_m.dzcd001 = g_browser[g_current_idx].b_dzcd001
   LET g_dzcd_m.dzcd002 = g_browser[g_current_idx].b_dzcd002 #20141007
   
   #重讀DB,因TEMP有不被更新特性
  SELECT UNIQUE dzcd001,dzcdl003,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006
    INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
    FROM dzcd_t
    LEFT JOIN dzcdl_t ON dzcdl001=dzcd001 AND dzcdl002=g_lang
    WHERE dzcd001 = g_dzcd_m.dzcd001 AND dzcd002 = g_dzcd_m.dzcd002 

   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "lib-00103"
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = ""
       LET g_errparam.replace[2] ="dzcd_t"
       LET g_errparam.extend = ""
       LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
       CALL cl_err()
       INITIALIZE g_dzcd_m.* TO NULL
       RETURN
   END IF
   
   LET g_data_owner = g_dzcd_m.dzcdcrtid      
   LET g_data_group = g_dzcd_m.dzcdcrtdp  
   
   #重新顯示   
   CALL adzi220_show()
 
END FUNCTION
 
 
#+ 資料新增
PRIVATE FUNCTION adzi220_insert()
   CLEAR FORM                    #清畫面欄位內容
   CALL g_dzce_d.clear()    #清除陣列
   CALL g_dzch_d.clear()    #清除陣列
 
 
   INITIALIZE g_dzcd_m.* LIKE dzcd_t.*             #DEFAULT 設定
   LET g_dzcd001_t = NULL
   LET g_dzcd002_t = NULL #20141007
 
   WHILE TRUE
       
      #一般欄位給值
      LET g_dzcd_m.dzcdcrtid = g_user
      LET g_dzcd_m.dzcdcrtdp = g_dept
      LET g_dzcd_m.dzcdcrtdt = cl_get_current()
      LET g_dzcd_m.dzcdownid = g_user 
      LET g_dzcd_m.dzcdowndp = g_dept 
      LET g_dzcd_m.dzcdmodid = g_user
      LET g_dzcd_m.dzcdmoddt = cl_get_current()
      #LET g_dzcd_m.dzcdstus = 'Y'#忽略狀態碼 
      #Begin:20160329 by elena (行業別)標準：sd、行業：該行業代號 (ex:ph)
      LET g_dzcd_m.dzcd006 = g_topind
      #End:20160329 by elena

      #單頭預設值
      LET g_dzcd_m_t.* = g_dzcd_m.*
     
      BEGIN WORK #2015/04/01 by Hiko
      CALL adzi220_input("a")
      
      IF INT_FLAG OR SQLCA.SQLCODE OR STATUS THEN #20150729:增加SQLCA.SQLCODE OR STATUS的條件
          LET INT_FLAG = 0
          LET g_dzcd_m.* = g_dzcd_m_t.*
          CALL adzi220_show()
          ROLLBACK WORK #2015/04/01 by Hiko
          EXIT WHILE
      END IF
      
      COMMIT WORK #2015/04/01 by Hiko

      CALL g_dzce_d.clear()
      CALL g_dzch_d.clear()
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
END FUNCTION
 
 
#+ 資料修改
PRIVATE FUNCTION adzi220_modify()

   IF cl_null(g_dzcd_m.dzcd001) OR 
      cl_null(g_dzcd_m.dzcd002)
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   SELECT UNIQUE dzcd001,dzcdl003,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006
    INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
    FROM dzcd_t
    LEFT JOIN dzcdl_t ON dzcdl001=dzcd001 AND dzcdl002=g_lang
    WHERE dzcd001 = g_dzcd_m.dzcd001 AND dzcd002 = g_dzcd_m.dzcd002

   #20150804 -Begin-
   #topstd帳號不允許異動客製資料
   IF g_account="topstd" AND g_dzcd_m_t.dzcd002 = "c" THEN
      CALL cl_ask_pressanykey("adz-00676") 
      RETURN
   END IF
   #20150804 -End-
	
   #20150729
   #標準校驗帶值不允許被修改，若要修改請先執行 "標準轉客製"功能後再進行客製調整
   IF g_dgenv = "c" AND g_dzcd_m_t.dzcd002 = "s" THEN
      CALL cl_ask_pressanykey("adz-00403")
      RETURN       
   END IF
  
   LET g_dzcd001_t = g_dzcd_m.dzcd001
   LET g_dzcd002_t = g_dzcd_m.dzcd002 #20141007
 
   #Begin:2015/04/23 by Hiko
   IF NOT adzi220_chk_using('u') THEN
      RETURN
   END IF

   BEGIN WORK
   #
   ##OPEN adzi220_cl USING g_dzcd_m.dzcd001
   #OPEN adzi220_cl USING g_dzcd_m.dzcd001,g_dzcd_m.dzcd002 #20141007
   #
   #IF STATUS THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code =  STATUS
   #   LET g_errparam.extend = "OPEN adzi220_cl:"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE adzi220_cl
   #   ROLLBACK WORK #   RETURN
   #END IF
   #
   ##鎖住將被更改或取消的資料
   #FETCH adzi220_cl INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.modid_desc,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.ownid_desc,g_dzcd_m.dzcdowndp,g_dzcd_m.owndp_desc,g_dzcd_m.dzcdcrtid,g_dzcd_m.crtid_desc,g_dzcd_m.dzcdcrtdp,g_dzcd_m.crtdp_desc,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
   ##資料被他人LOCK, 或是sql執行時出現錯誤
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = g_dzcd_m.dzcd001
   #   LET g_errparam.popup = FALSE
   #   CALL cl_err()
   #   CLOSE adzi220_cl
   #   ROLLBACK WORK
   #   RETURN
   #END IF
   #
   #CALL adzi220_show()
   #End:2015/04/23 by Hiko

   WHILE TRUE
      LET g_dzcd001_t = g_dzcd_m.dzcd001
      LET g_dzcd002_t = g_dzcd_m.dzcd002 #20141007
	  
      LET g_dzcd_m.dzcdmodid = g_user
      LET g_dzcd_m.dzcdmoddt = cl_get_current()
 
      CALL adzi220_input("u")     #欄位更改
 
      IF INT_FLAG OR SQLCA.SQLCODE OR STATUS THEN #20150729:增加SQLCA.SQLCODE OR STATUS的條件
         #LET INT_FLAG = 0
          LET g_dzcd_m.* = g_dzcd_m_t.*
          CALL adzi220_show()
         #CALL cl_err('',9001,0)   #130221 By benson 
          EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
     #IF g_dzcd_m.dzcd001 != g_dzcd001_t THEN
     #20141007:此程式的key值應該不能改才是,待確認madeyq  
      IF g_dzcd_m.dzcd001 != g_dzcd001_t OR g_dzcd_m.dzcd002 != g_dzcd002_t THEN 
         
         #更新單頭key值
        #UPDATE dzcd_t SET dzcd001 = g_dzcd_m.dzcd001
        #   WHERE  dzcd001 = g_dzcd001_t
         UPDATE dzcd_t SET dzcd001 = g_dzcd_m.dzcd001,dzcd002 = g_dzcd_m.dzcd002
            WHERE  dzcd001 = g_dzcd001_t AND dzcd002 = g_dzcd002_t #20141007
			
         UPDATE dzcdl_t SET dzcdl001 = g_dzcd_m.dzcd001
            WHERE  dzcdl001 = g_dzcd001_t

         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = "lib-00101"
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = g_dzcd001_t
             LET g_errparam.replace[2] ="dzcd_t"
             LET g_errparam.extend = ""
             LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
             CALL cl_err()
            #ROLLBACK WORK  #20150729
             CONTINUE WHILE
         END IF
         
         #更新單身key值
        #UPDATE dzce_t SET dzce001 = g_dzcd_m.dzcd001
        #   WHERE  dzce001 = g_dzcd001_t
         UPDATE dzce_t SET dzce001 = g_dzcd_m.dzcd001 ,dzce003 = g_dzcd_m.dzcd002
            WHERE  dzce001 = g_dzcd001_t AND dzce003 = g_dzcd002_t #20141007
			
         UPDATE dzcel_t SET dzcel001 = g_dzcd_m.dzcd001
            WHERE  dzcel001 = g_dzcd001_t
 
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = "lib-00101"
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = g_dzcd001_t
             LET g_errparam.replace[2] ="dzce_t"
             LET g_errparam.extend = ""
             LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
             CALL cl_err()
            #ROLLBACK WORK #20150729 
             CONTINUE WHILE
         END IF
       
        #20141007 bug fix -Begin-
         UPDATE dzch_t SET dzch001 = g_dzcd_m.dzcd001 ,dzch005 = g_dzcd_m.dzcd002
            WHERE  dzch001 = g_dzcd001_t AND dzch005 = g_dzcd002_t #20141007
 
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = "lib-00101"
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = g_dzcd001_t
             LET g_errparam.replace[2] ="dzch_t"
             LET g_errparam.extend = ""
             LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
             CALL cl_err()
            #ROLLBACK WORK #20150729
             CONTINUE WHILE
         END IF
        #20141007 bug fix -End-
         
        #COMMIT WORK #20150729
         
      END IF
      
      EXIT WHILE
   END WHILE
 
  #20140930:mark
  ##修改歷程記錄
  #IF NOT cl_used_modified_record(g_dzcd_m.dzcd001,g_site) THEN 
  #   ROLLBACK WORK
  #END IF
 
   CLOSE adzi220_cl

   IF INT_FLAG OR SQLCA.SQLCODE OR STATUS THEN #20150729:增加SQLCA.SQLCODE OR STATUS的條件
      ROLLBACK WORK #2015/04/10 by Hiko
   ELSE
      COMMIT WORK
   END IF
 
   CALL adzi220_b_fill("1=1")
   
END FUNCTION   
 
 
#+ 資料輸入
PRIVATE FUNCTION adzi220_input(p_cmd)
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  l_insert        BOOLEAN
   DEFINE  l_sql_sample    LIKE type_t.chr1                #SQL指令樣版
   DEFINE  l_sql_sample_o  LIKE type_t.chr1                #SQL指令樣版 舊值
   DEFINE  l_result        LIKE type_t.chr1
   DEFINE  ls_dzcd001      STRING                          #暫存dzcd001的字串
   DEFINE  ls_dzcd006      STRING                          #暫存dzcd006的字串 20150114
   DEFINE  l_global_var    LIKE type_t.chr10                #可以使用的公用變數
   DEFINE  lo_Combobox ui.ComboBox
   DEFINE  l_dzcd003       base.StringBuffer
   DEFINE  l_sql_b         LIKE dzcd_t.dzcd003
   DEFINE  ls_cmd          STRING 
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_forupd_sql = "SELECT dzce002,dzce003,dzce004,dzcel004 ",
                      " FROM dzce_t ",
                      " LEFT JOIN dzcel_t ON dzcel001 = dzce001 AND dzcel002 = dzce002 AND dzcel003= '",g_lang,"' ",
                      " WHERE dzce001=? AND dzce002=? AND dzce003=? FOR UPDATE"
  
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE adzi220_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   #DISPLAY g_global_var TO s_global_var #2015/04/01 by Hiko
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
  #20141007
   DISPLAY BY NAME g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
   DIALOG ATTRIBUTE(UNBUFFERED)
   
      #單頭段
      #INPUT BY NAME g_dzcd_m.dzcd005,g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,l_sql_sample,l_global_var,g_dzcd_m.dzcd003, #2015/04/01 by Hiko
      INPUT BY NAME g_dzcd_m.dzcd005,g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,l_sql_sample,g_dzcd_m.dzcd003,
                    g_dzcd_m.dzcd004,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,
                    g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION

         BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL adzi220_set_entry(p_cmd)
            CALL adzi220_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE

            #130221 By benson --- S
            #維護狀態時，不讓使用者再去更改l_sql_sample的資料
            IF p_cmd = 'a' THEN
               IF cl_null(g_dzcd_m.dzcd005) THEN
                  LET g_dzcd_m.dzcd005 = '1'
               END IF
               IF cl_null(l_sql_sample) THEN 
                  LET l_sql_sample = "1"
                  LET l_sql_sample_o = "1"
                  CALL adzi220_sql_sample(p_cmd,l_sql_sample,l_sql_sample_o)
                  LET g_dzcd_m_t.dzcd003 = g_dzcd_m.dzcd003
               END IF
               CALL DIALOG.setFieldActive("l_sql_sample",1)

               #20141007 -Begin-
               #標準環境下:預設dzcd002=s
               #客製環境下:預設dzcd002=c
               IF g_dgenv = "s" THEN
                  IF cl_null(g_dzcd_m.dzcd002) THEN
                     LET g_dzcd_m.dzcd002 = "s"
                  END IF
               ELSE
                  LET g_dzcd_m.dzcd002 = "c"
               END IF
               #20141007 -End-

            ELSE
               CALL DIALOG.setFieldActive("l_sql_sample",0)
            END IF
            #130221 By benson --- E

           ##20141007:客製環境下 & 修改模式下 & 標準v : 可以被打勾                                                 
           #IF p_cmd = 'u' AND g_dgenv = 'c' AND g_dzcd_m.dzcd002 = 's' THEN
           #   CALL cl_set_comp_entry("dzcd002",TRUE) 
           #END IF
          
         #---------------------------<  Master  >---------------------------
         #----<<dzcd001>>----
 
         AFTER FIELD dzcd001
            IF NOT cl_null(g_dzcd_m.dzcd001)  THEN
               IF g_dzcd_m.dzcd001 != g_dzcd_m_t.dzcd001 OR g_dzcd_m_t.dzcd001 IS NULL THEN   #130221 By TSD.benson 
                  #12/12/22 檢查開頭必為v_開頭,先統一
                  LET ls_dzcd001 =  g_dzcd_m.dzcd001
                  LET ls_dzcd006 =  g_dzcd_m.dzcd006
                  IF NOT adzi220_chk_dzcd001(ls_dzcd001,ls_dzcd006) THEN 
                    
                    #20141007:mark -Begin- 移到adzi220_chk_dzcd001()內
                    #INITIALIZE g_errparam TO NULL
                    #LET g_errparam.code =  "adz-00022"
                    #LET g_errparam.extend = NULL
                    #LET g_errparam.popup = TRUE
                    #LET g_errparam.replace[1] =  "Verify id must be 「v_ 」start ! "
                    #CALL cl_err()
                    #20141007:mark -End-

                    #LET g_dzcd_m.dzcd001 = g_dzcd001_t
                     NEXT FIELD dzcd001
                  END IF 
               END IF

               IF p_cmd = 'a'  OR ( p_cmd = 'u' AND (g_dzcd_m.dzcd001 != g_dzcd001_t )) THEN 

                  #[檢查輸入字串是否符合格式]
                  #N: Numeric 0123456789
                  #U: 大寫的 A-Z
                  #L:  小寫的 a-z
                  #_:  底線 underline
                  #若檢查NL_,則檢查字串是否只包含數字,小寫的 a-z,底斜線
                  IF  NOT cl_chk_num(g_dzcd_m.dzcd001,"NL_") THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00130"
                     LET g_errparam.extend = g_dzcd_m.dzcd001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD dzcd001
                  END IF
               
                 #Begin: 160707-00014 modify
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzcd_t WHERE "||"dzcd001 = '"||g_dzcd_m.dzcd001 ||"'",'std-00004',0) THEN  #還原
 		 #IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzcd_t WHERE "||"dzcd001 = '"||g_dzcd_m.dzcd001 ||"' AND dzcd002='"||g_dzcd_m.dzcd002||"'",'std-00004',0) THEN  #20141007
                 #End: 160707-00014 modify
                     #LET g_dzcd_m.dzcd001 = g_dzcd001_t
                     NEXT FIELD dzcd001
                  END IF
               END IF
            END IF

        #20150114 -Begin-
         AFTER FIELD dzcd006
            IF NOT cl_null(g_dzcd_m.dzcd001) THEN
              IF NOT adzi220_chk_dzcd001(g_dzcd_m.dzcd001,g_dzcd_m.dzcd006) THEN 
                 NEXT FIELD dzcd001
              END IF
            END IF
        #20150114 -End-


       #20150113 -Begin-
         #----<<dzcdl003>>----
         BEFORE FIELD dzcdl003
 
         AFTER FIELD dzcdl003
             IF NOT cl_null(g_dzcd_m.dzcdl003) THEN
                IF NOT cl_chk_tworcn(g_lang,g_dzcd_m.dzcdl003,20) THEN
                   NEXT FIELD dzcdl003
                END IF
             END IF 
       #20150113 -End-

        #Begin:2015/04/01 by Hiko
        #BEFORE FIELD l_sql_sample
        #   LET lo_Combobox = ui.ComboBox.forName("formonly.l_sql_sample")
        #   CALL adzi220_fill_combobox(lo_Combobox,ms_SQL_Sample)
        #End:2015/04/01 by Hiko
         
         ON CHANGE l_sql_sample
            CALL adzi220_sql_sample(p_cmd,l_sql_sample,l_sql_sample_o)
            DISPLAY BY NAME g_dzcd_m.dzcd003
            IF g_dzcd_m_t.dzcd003 != g_dzcd_m.dzcd003 THEN
               LET l_sql_sample_o = l_sql_sample
               LET g_dzcd_m_t.dzcd003 = g_dzcd_m.dzcd003
            ELSE 
               LET l_sql_sample = l_sql_sample_o
            END IF

         ON ACTION update_item INFIELD dzcdl003
                IF  NOT cl_null(g_dzcd_m.dzcd001) THEN
                  #BEGIN WORK  #20150113 解決有時呼叫n_xx會發生open cursor error #2015/04/02 by Hiko:呼叫input段已經有BEGIN WORK
                  CALL n_dzcdl(g_dzcd_m.dzcd001) 
                  #COMMIT WORK #20150113 #2015/04/02 by Hiko
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_dzcd_m.dzcd001
                  CALL ap_ref_array2(g_ref_fields," SELECT dzcdl003 FROM dzcdl_t WHERE dzcdl001 = ? AND dzcdl002 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_dzcd_m.dzcdl003 = g_rtn_fields[1]
                  DISPLAY BY NAME g_dzcd_m.dzcdl003
               END IF 

         AFTER FIELD dzcd003 
            LET g_dzcd_m_t.dzcd003 = g_dzcd_m.dzcd003

         AFTER FIELD dzcd004 
            IF NOT cl_null(g_dzcd_m.dzcd004) THEN
               CALL adzi220_chk_err_msg(g_dzcd_m.dzcd004)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_dzcd_m.dzcd004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_dzcd_m.dzcd004 = g_dzcd_m_t.dzcd004
                  LET g_dzcd_m.error_description = g_dzcd_m_t.error_description
                  DISPLAY g_dzcd_m.error_description TO s_error_description
                  NEXT FIELD dzcd004
               END IF
               SELECT gzze003 INTO g_dzcd_m.error_description FROM gzze_t 
                WHERE gzze001 = g_dzcd_m.dzcd004 AND gzze002 = g_lang
               DISPLAY g_dzcd_m.error_description TO s_error_description
            ELSE
               LET g_dzcd_m.error_description = ""
            END IF
            DISPLAY g_dzcd_m.dzcd004

         ON ACTION controlp INFIELD dzcd004
            #130221 By benson --- S
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzcd_m.dzcd004 
            LET g_qryparam.default2 = g_dzcd_m.error_description 
            CALL q_gzze001()
            LET g_dzcd_m.dzcd004 = g_qryparam.return1
            LET g_dzcd_m.error_description = g_qryparam.return2
            DISPLAY g_dzcd_m.error_description TO s_error_description
            NEXT FIELD dzcd004
            #130221 By benson --- E

         AFTER FIELD dzcd005 
            IF p_cmd = 'a' THEN
               LET l_sql_sample = g_dzcd_m.dzcd005
               CALL adzi220_sql_sample(p_cmd,l_sql_sample,l_sql_sample_o)
               IF g_dzcd_m_t.dzcd003 != g_dzcd_m.dzcd003 THEN
                  LET l_sql_sample_o = l_sql_sample
                  LET g_dzcd_m_t.dzcd003 = g_dzcd_m.dzcd003
               ELSE
                  LET l_sql_sample = l_sql_sample_o
               END IF
               DISPLAY BY NAME l_sql_sample
               DISPLAY BY NAME g_dzcd_m.dzcd003
            END IF

         ON CHANGE dzcd005
            IF g_dzcd_m.dzcd005 = "2" THEN
               CALL cl_set_comp_visible("grid_exist_err",FALSE)#隱藏
               #CALL cl_set_comp_visible("grid_non_exist_err",FALSE)#隱藏 #2015/04/01 by Hiko
            ELSE
               CALL cl_set_comp_visible("grid_exist_err",TRUE)#出現
               #CALL cl_set_comp_visible("grid_non_exist_err",TRUE)#出現 #2015/04/01 by Hiko
            END IF
            
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            DISPLAY BY NAME g_dzcd_m.dzcd001             
 
      END INPUT

     #Page1 預設值產生於此處
      INPUT ARRAY g_dzch_d FROM s_err_detail.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
        #自訂ACTION
         AFTER INPUT
         
         BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_before_input_done = FALSE  
            LET g_before_input_done = TRUE
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
         
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            INITIALIZE g_dzch_d[l_ac].* TO NULL 
            LET g_dzch_d[l_ac].dzch002 = adzi220_max_value("dzch_t") 
            LET g_dzch_d_t.* = g_dzch_d[l_ac].*     #新輸入資料
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_dzch_d_t.dzch002) THEN
               IF NOT cl_ask_del_detail() THEN
                   CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code =  -263
                   LET g_errparam.extend = ""
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   CANCEL DELETE
               END IF
               LET l_count = g_dzch_d.getLength()
            END IF 
              
         AFTER DELETE 
            CALL adzi220_delete_b(l_count,"dzch_t")

         AFTER FIELD dzch003
            #驗證輸入的判斷條件有無合法
            IF NOT cl_null(g_dzch_d[l_ac].dzch003) THEN
                LET l_dzcd003 = base.StringBuffer.create() 
                CALL l_dzcd003.append(g_dzcd_m.dzcd003)
                CALL l_dzcd003.replace(G_WHERE_END," AND "||g_dzch_d[l_ac].dzch003||" "||G_WHERE_END,1)
                #Begin:2015/04/23 by Hiko
                #IF NOT adzi220_sql_verify(l_dzcd003.toString()) THEN
                #  NEXT FIELD dzch003
                #END IF
                #End:2015/04/23 by Hiko
            END IF
            
         AFTER FIELD dzch004
            IF NOT cl_null(g_dzch_d[l_ac].dzch004) THEN
               CALL adzi220_chk_err_msg(g_dzch_d[l_ac].dzch004)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_dzch_d[l_ac].dzch004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD dzch004
               END IF
               SELECT gzze003 INTO g_dzch_d[l_ac].gzze003 FROM gzze_t 
                WHERE gzze001 = g_dzch_d[l_ac].dzch004 AND gzze002 = g_lang
            ELSE
               LET g_dzch_d[l_ac].gzze003 = ""
            END IF
 

         ON ACTION controlp INFIELD dzch004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzch_d[l_ac].dzch004 
            LET g_qryparam.default2 = g_dzch_d[l_ac].gzze003 
            CALL q_gzze001()
            LET g_dzch_d[l_ac].dzch004 = g_qryparam.return1
            LET g_dzch_d[l_ac].gzze003 = g_qryparam.return2
            NEXT FIELD dzch004

      END INPUT
      
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzce_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION
         AFTER INPUT
         
         BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_before_input_done = FALSE  
            LET g_before_input_done = TRUE
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
         
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            INITIALIZE g_dzce_d[l_ac].* TO NULL 
            LET g_dzce_d[l_ac].dzce002 = adzi220_max_value("dzce_t")     #130221 By benson 
            LET g_dzce_d_t.* = g_dzce_d[l_ac].*     #新輸入資料
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_dzce_d_t.dzce002) THEN
               IF NOT cl_ask_del_detail() THEN
                   CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code =  -263
                   LET g_errparam.extend = ""
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   CANCEL DELETE
               END IF
               LET l_count = g_dzce_d.getLength()
            END IF 
              
         AFTER DELETE 
            CALL adzi220_delete_b(l_count,"dzce_t") 
 
          #---------------------<  Detail: page     1  >---------------------

         AFTER FIELD dzce004
            IF  NOT cl_null(g_dzcd_m.dzcd001) AND NOT cl_null(g_dzce_d[l_ac].dzce004)  THEN 
               IF  p_cmd = 'a'  OR ( p_cmd = 'u' AND (g_dzcd_m.dzcd001 != g_dzcd001_t  OR g_dzce_d[l_ac].dzce004 != g_dzce_d_t.dzce004 OR g_dzce_d_t.dzce004 IS NULL)) THEN 
                  #130221 By benson --- S
                  CALL adzi220_chk_dzce004()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_dzce_d[l_ac].dzce004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_dzce_d[l_ac].dzce004 = g_dzce_d_t.dzce004
                     NEXT FIELD dzce004
                  END IF
                  #130221 By benson --- E
               END IF
            END IF

       #20150113 -Begin-
         #----<<dzcel004>>----
         AFTER FIELD dzcel004
             IF NOT cl_null(g_dzce_d[l_ac].dzcel004) THEN
                IF NOT cl_chk_tworcn(g_lang,g_dzce_d[l_ac].dzcel004,20) THEN
                   NEXT FIELD dzcel004
                END IF
             END IF 
       #20150113 -End-

         ON ACTION update_item INFIELD dzcel004
                IF  NOT cl_null(g_dzce_d[l_ac].dzce004) THEN
                  #BEGIN WORK  #20150113 add 解決有時呼叫n_xxx時因為open cursor fail #2015/04/02 by Hiko:呼叫input段已經有BEGIN WORK
                  CALL n_dzcel(g_dzcd_m.dzcd001,g_dzce_d[l_ac].dzce002) 
                  #COMMIT WORK #20150113 #2015/04/02 by Hiko
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_dzcd_m.dzcd001
                  LET g_ref_fields[2] = g_dzce_d[l_ac].dzce002
                  CALL ap_ref_array2(g_ref_fields," SELECT dzcel004 FROM dzcel_t WHERE dzcel001 = ? AND dzcel002 = ? AND dzcel003 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_dzce_d[l_ac].dzcel004 = g_rtn_fields[1]
                  #DISPLAY "g_dzce_d[l_ac].dzcel004 = ",g_dzce_d[l_ac].dzcel004

                  DISPLAY BY NAME g_dzce_d[l_ac].dzcel004
               END IF 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzce_d[l_ac].* = g_dzce_d_t.*
               CLOSE adzi220_bcl
               #ROLLBACK WORK #2015/04/02 by Hiko
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dzce_d[l_ac].dzce002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzce_d[l_ac].* = g_dzce_d_t.*
            END IF
              
      END INPUT

      BEFORE DIALOG
         IF g_dzcd_m.dzcd005 = "2" THEN
            CALL cl_set_comp_visible("grid_exist_err",FALSE)#隱藏
            #CALL cl_set_comp_visible("grid_non_exist_err",FALSE)#隱藏 #2015/04/01 by Hiko
         ELSE
            CALL cl_set_comp_visible("grid_exist_err",TRUE)#出現
            #CALL cl_set_comp_visible("grid_non_exist_err",TRUE)#出現 #2015/04/01 by Hiko
         END IF
      
      #130221 By benson --- S
      AFTER DIALOG
         #修改前檢查是否有程式已使用此校驗資料 
        #IF adzi220_chk_using('u') THEN #2015/04/23 by Hiko:改在修改按下去就提醒
           #IF adzi220_sql_verify(g_dzcd_m.dzcd003) THEN
            IF adzi220_sql_verify(g_dzcd_m.dzcd003,g_dzcd_m.dzcd005,TRUE) THEN #160428-00021
               IF adzi220_arg_verify(g_dzcd_m.dzcd003) THEN
                  IF adzi220_chk_cartesian(g_dzcd_m.dzcd003,TRUE) THEN END IF #160428-00021
                  CALL adzi220_accept_data(p_cmd) 
                  LET g_action_choice = ""
               ELSE
                  NEXT FIELD dzcd003
               END IF
            ELSE
               NEXT FIELD dzcd003
            END IF
        #ELSE
        #  #NEXT FIELD dzcd003
        #  EXIT DIALOG             #20140930 modify          
        #END IF

      #130221 By benson --- E
      ON ACTION lbl_sql_edit
         CALL adzi220_run_prog("r.r","adzi230",g_prog)
         NEXT FIELD dzcd003

      ON ACTION lbl_sql_builder
         LET ls_cmd = " adzp190 ",g_prog
         CALL cl_cmdrun(ls_cmd)
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
      ON ACTION ACCEPT
         LET INT_FLAG=0 #20150804 
         ACCEPT DIALOG

     #Begin: 160428-00021 mark
     #ON ACTION VERIFY  #驗證sql  根本走不到這裡
     #   IF g_dzcd_m.dzcd003 IS NOT NULL THEN
     #      CALL adzi220_sql_verify(g_dzcd_m.dzcd003) RETURNING l_result
     #   ELSE
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.code =  "adz-00022"
     #      LET g_errparam.extend = NULL
     #      LET g_errparam.popup = TRUE
     #      LET g_errparam.replace[1] =  " SQL is null "
     #      CALL cl_err()
     #      NEXT FIELD dzcd003
     #   END IF
     #End: 160428-00021 mark
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG=1     #20150804
         LET g_action_choice=""
         #ROLLBACK WORK #2015/04/02 by Hiko
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG=1     #20150804 
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG=1     #20150804 
         LET g_action_choice="exit"
         EXIT DIALOG
    
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
    
END FUNCTION
 
 
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzi220_show()
   DEFINE l_ac_t    LIKE type_t.num5
   DEFINE l_gzze003 LIKE gzze_t.gzze003
   
   LET g_dzcd_m_t.* = g_dzcd_m.*      #保存單頭舊值
   
   CALL adzi220_b_fill("1=1")                 #單身
     
   #帶出預設欄位之值
   LET g_dzcd_m.modid_desc = cl_get_username(g_dzcd_m.dzcdmodid)
   LET g_dzcd_m.ownid_desc = cl_get_username(g_dzcd_m.dzcdownid)
   LET g_dzcd_m.crtid_desc = cl_get_username(g_dzcd_m.dzcdcrtid)
   LET g_dzcd_m.crtdp_desc = cl_get_deptname(g_dzcd_m.dzcdcrtdp)
   LET g_dzcd_m.owndp_desc = cl_get_deptname(g_dzcd_m.dzcdowndp)
 
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   
   #讀入ref值(單身)
   #FOR l_ac = 1 TO g_dzce_d.getLength()
       #
   #END FOR
 
   
   LET l_ac = l_ac_t

   #SELECT dzcdl003 INTO g_dzcd_m.dzcdl003 FROM dzcdl_t WHERE dzcdl001 = g_dzcd_m.dzcd001 AND dzcdl002 = g_lang

   
  #20141007
   DISPLAY BY NAME g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.modid_desc,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.ownid_desc,g_dzcd_m.dzcdowndp,g_dzcd_m.owndp_desc,g_dzcd_m.dzcdcrtid,g_dzcd_m.crtid_desc,g_dzcd_m.dzcdcrtdp,g_dzcd_m.crtdp_desc,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
   #顯示提示訊息的說明
   SELECT gzze003 INTO g_dzcd_m.error_description FROM gzze_t 
      WHERE gzze001 = g_dzcd_m.dzcd004 AND gzze002 = g_lang
   DISPLAY g_dzcd_m.error_description TO s_error_description

   #DISPLAY g_global_var TO s_global_var #2015/04/01 by Hiko

   #移動上下筆可以連動切換資料
   #CALL cl_show_fld_cont() #2015/04/01 by Hiko     
   
END FUNCTION
 
 
#+ 資料複製
PRIVATE FUNCTION adzi220_reproduce()
   DEFINE l_newno        LIKE dzcd_t.dzcd001 
   DEFINE l_oldno        LIKE dzcd_t.dzcd001 

   DEFINE l_old_cust_flag LIKE dzcd_t.dzcd002 #20141007
   DEFINE l_new_cust_flag LIKE dzcd_t.dzcd002 #20141007   
   
   DEFINE l_master       RECORD LIKE dzcd_t.*
   DEFINE l_detail       RECORD LIKE dzce_t.*
   DEFINE l_err_detail   RECORD LIKE dzch_t.*
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_n            LIKE type_t.num5

   DEFINE l_new_industry   LIKE dzcd_t.dzcd006  #2015014
 
   IF cl_null(g_dzcd_m.dzcd001) 
 
      THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   #Begin:20160329 by elena
   IF sadzp060_ind_check_area() THEN
      LET g_dzcd_m.dzcd006 = g_topind
   END IF
   #End:20160329 by elena
 
   LET g_before_input_done = FALSE
   CALL adzi220_set_entry('a')
   CALL adzi220_set_no_entry('a') #20150114
   LET g_before_input_done = TRUE
 
   CALL cl_set_head_visible("","YES")
 
   INPUT l_newno,l_new_industry FROM dzcd001,dzcd006 
 
      BEFORE INPUT
         #20150114  -Begin-
         LET l_new_industry = g_dzcd_m.dzcd006 #預設跟複製來源一樣
         IF g_dgenv=="c" THEN LET l_new_industry = "sd" END IF #客戶環境下複製,行業別固定為sd
         DISPLAY l_new_industry TO dzcd_t.dzcd006

         LET l_new_cust_flag = IIF(g_dgenv=="c","c","s") #20141007
         DISPLAY l_new_cust_flag TO dzcd_t.dzcd002 
         #20150114  -End-
 
      AFTER FIELD dzcd001 
         IF l_newno IS NULL THEN
           #NEXT FIELD CURRENT #20150114 mark
         #120221 By benson --- S
         ELSE
            IF NOT adzi220_chk_dzcd001(l_newno,l_new_industry) THEN  #20150114
              #INITIALIZE g_errparam TO NULL
              #LET g_errparam.code =  "adz-00022"
              #LET g_errparam.extend = NULL
              #LET g_errparam.popup = TRUE
              #LET g_errparam.replace[1] =  " Query id must be 「q_ 」start ! "
              #LET g_errparam.replace[1] =  " check id must be 「v_ 」start ! " #20141007:bug fix
              #CALL cl_err()
               LET l_newno = ''
               NEXT FIELD CURRENT
            END IF    
           #SELECT COUNT(*) INTO l_n FROM dzcd_t WHERE dzcd001 = l_newno
            SELECT COUNT(*) INTO l_n FROM dzcd_t WHERE dzcd001 = l_newno  AND dzcd002 = l_new_cust_flag #20141007
            IF l_n > 0 THEN
               #20140905 -Begin-
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "std-00006"
               LET g_errparam.extend = l_newno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #20140905 -End-
               LET l_newno = ''
               NEXT FIELD CURRENT
            END IF

            #[檢查輸入字串是否符合格式]
            #N: Numeric 0123456789
            #U: 大寫的 A-Z
            #L:  小寫的 a-z
            #_:  底線 underline
            #若檢查NL_,則檢查字串是否只包含數字,小寫的 a-z,底斜線
            IF  NOT cl_chk_num(l_newno,"NL_") THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "adz-00130"
               LET g_errparam.extend = l_newno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
         #120221 By benson --- E
         END IF

      #20150114 -Begin-
       AFTER FIELD dzcd006
          IF NOT cl_null(l_newno) THEN
            IF NOT adzi220_chk_dzcd001(l_newno,l_new_industry) THEN 
               NEXT FIELD dzcd001
            END IF
          END IF
      #20150114 -End-

      AFTER INPUT
         #確定該key值是否有重複定義
         LET l_cnt = 0
        #SELECT COUNT(*) INTO l_cnt FROM dzcd_t 
        # WHERE  dzcd001 = l_newno
          SELECT COUNT(*) INTO l_cnt FROM dzcd_t 
           WHERE  dzcd001 = l_newno AND dzcd002 = l_new_cust_flag #20141007
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
           #LET g_errparam.extend = "Reproduce"
            LET g_errparam.extend = l_newno #20140905
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #NEXT FIELD dzcd001 
         END IF
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT
   END INPUT
   
   IF INT_FLAG OR l_newno IS NULL THEN
       LET INT_FLAG = 0
       RETURN
   END IF
   
   BEGIN WORK
 
   SELECT * INTO l_master.* FROM dzcd_t 
     WHERE  dzcd001 = g_dzcd_m.dzcd001
       AND dzcd002 = g_dzcd_m.dzcd002 #20141007
 
   LET l_master.dzcd001 = l_newno
   LET l_master.dzcd002  = l_new_cust_flag #20141007
   
   LET l_master.dzcdcrtid = g_user
   LET l_master.dzcdcrtdp = g_dept
   LET l_master.dzcdcrtdt = cl_get_current()
   LET l_master.dzcdownid = g_user 
   LET l_master.dzcdowndp = g_dept 
   LET l_master.dzcdmodid = g_user
   LET l_master.dzcdmoddt = cl_get_current()
  #LET l_master.dzcdstus = 'Y'#忽略狀態碼 
   LET l_master.dzcd006  = l_new_industry #20150114
   
   INSERT INTO dzcd_t VALUES (l_master.*) #複製單頭

   DELETE FROM dzcdl_t WHERE dzcdl001 = l_master.dzcd001 #20140905
   INSERT INTO dzcdl_t (dzcdl001,dzcdl002,dzcdl003,dzcdl004)
      SELECT l_master.dzcd001 dzcdl001,dzcdl002,dzcdl003,dzcdl004 FROM dzcdl_t
         WHERE dzcdl001 = g_dzcd_m.dzcd001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_newno
      LET g_errparam.replace[2] ="dzcd_t"
      LET g_errparam.extend = ""
      LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
      CALL cl_err()
      ROLLBACK WORK
      RETURN
   END IF

    #複製dzce_t單身
   DELETE FROM dzce_t WHERE dzce001 = l_master.dzcd001 #20140905
                        AND dzce003=l_master.dzcd002 #20141007
						
   LET g_sql = "SELECT * FROM dzce_t WHERE  ",
              #" dzce001 = '",g_dzcd_m.dzcd001,"'"
               " dzce001 = '",g_dzcd_m.dzcd001,"' AND dzce003='",g_dzcd_m.dzcd002,"'"#20141007
 
   DECLARE adzi220_reproduce CURSOR FROM g_sql
 
   FOREACH adzi220_reproduce INTO l_detail.*
      LET l_detail.dzce001 = l_newno
      LET l_detail.dzce003 = l_new_cust_flag #20141007
	  
      INSERT INTO dzce_t VALUES (l_detail.*) #複製單身

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'reproduce dzce_t error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN
      END IF
   END FOREACH

   DELETE FROM dzcel_t WHERE dzcel001 = l_master.dzcd001 #20140905
   #複製單身多語言
   INSERT INTO dzcel_t (dzcel001, dzcel002, dzcel003, dzcel004, dzcel005)
      SELECT l_detail.dzce001 dzcel001, dzcel002, dzcel003, dzcel004, dzcel005 FROM dzcel_t
         WHERE dzcel001 = g_dzcd_m.dzcd001

   DELETE FROM dzch_t WHERE dzch001 = l_master.dzcd001 #20140905
                        AND dzch005 = l_master.dzcd002 #20141007
   #複製dzch_t單身      
   LET g_sql = "SELECT * FROM dzch_t WHERE  ",
              #" dzch001 = '",g_dzcd_m.dzcd001,"'"
               " dzch001 = '",g_dzcd_m.dzcd001,"' AND dzch005='",g_dzcd_m.dzcd002,"'"#20141007
 
   DECLARE adzi220_reproduce2 CURSOR FROM g_sql
 
   FOREACH adzi220_reproduce2 INTO l_err_detail.*
      LET l_err_detail.dzch001 = l_newno
      LET l_err_detail.dzch005 = l_new_cust_flag #20141007
	  
      INSERT INTO dzch_t VALUES (l_err_detail.*) #複製單身
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'reproduce dzch_t error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN
      END IF
   END FOREACH
      
   COMMIT WORK
   LET l_oldno = g_dzcd_m.dzcd001
   LET l_old_cust_flag = g_dzcd_m.dzcd002 #20141007
   
   SELECT dzcd001,dzcdl003,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006
    INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
    FROM dzcd_t 
    LEFT JOIN dzcdl_t ON dzcdl001=dzcd001 AND dzcdl002=g_lang
    WHERE  dzcd001 = l_newno AND dzcd002 = l_new_cust_flag   
      
   CALL adzi220_show()
   LET g_dzcd_m.dzcd001 = l_oldno
   LET g_dzcd_m.dzcd002 = l_old_cust_flag #20141007
   
   SELECT dzcd001,dzcdl003,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006 
    INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
    FROM dzcd_t 
    LEFT JOIN dzcdl_t ON dzcdl001=dzcd001 AND dzcdl002=g_lang
    WHERE  dzcd001 = g_dzcd_m.dzcd001 AND dzcd002 = g_dzcd_m.dzcd002
	
   #SELECT dzcdl003 INTO g_dzcd_m.dzcdl003 FROM dzcdl_t WHERE dzcdl001 = g_dzcd_m.dzcd001 AND dzcdl002 = g_lang

   CALL adzi220_show()
 
  #DISPLAY BY NAME g_dzcd_m.dzcd001
   DISPLAY BY NAME g_dzcd_m.dzcd001,g_dzcd_m.dzcd002 #20141007
   
END FUNCTION
 
#+ 資料刪除
PRIVATE FUNCTION adzi220_delete()
   DEFINE li_dzcd_cnt SMALLINT,       #有幾筆dzcd資料
          lb_std_to_cust BOOLEAN,     #是否標準轉客製
          lb_have_cust BOOLEAN        #是否客製

   DEFINE lb_result      BOOLEAN,
          ls_err_msg     STRING

   IF cl_null(g_dzcd_m.dzcd001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF

   #確認此v是否客製,是否由標準轉客製
   CALL cl_chk_validate_chk_have_cust(g_dzcd_m.dzcd001) RETURNING li_dzcd_cnt,lb_have_cust
   IF lb_have_cust AND li_dzcd_cnt > 1 THEN
       LET lb_std_to_cust = TRUE
   ELSE
       LET lb_std_to_cust = FALSE
   END IF

   #20150804 -Begin-
   #topstd帳號不允許異動客製資料
   IF g_account="topstd" AND g_dzcd_m_t.dzcd002 = "c" THEN
      CALL cl_ask_pressanykey("adz-00676") 
      RETURN
   END IF
   #20150804 -End-
   
   #標準v無法刪除!
   IF g_dgenv = "c" AND g_dzcd_m.dzcd002 = "s" THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00410"
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
   END IF

   #20150729
   #標準轉客製:無法被刪除，僅能執行 "客製還原標準" 功能
   IF lb_std_to_cust THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00663"
       LET g_errparam.EXTEND = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
   END IF

   SELECT UNIQUE dzcd001,dzcdl003,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006
    INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006
    FROM dzcd_t
    LEFT JOIN dzcdl_t ON dzcdl001=dzcd001 AND dzcdl002=g_lang
    WHERE dzcd001 = g_dzcd_m.dzcd001 AND dzcd002 = g_dzcd_m.dzcd002  

   #Begin:2015/04/23 by Hiko
   #BEGIN WORK
   #
   ##OPEN adzi220_cl USING g_dzcd_m.dzcd001
   #OPEN adzi220_cl USING g_dzcd_m.dzcd001, g_dzcd_m.dzcd002 #20141007
   #     
   #IF STATUS THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code =  STATUS
   #   LET g_errparam.extend = "OPEN adzi220_cl:"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE adzi220_cl
   #   #ROLLBACK WORK #2015/04/23 by Hiko
   #   RETURN
   #END IF
   #End:2015/04/23 by Hiko

   #刪除前檢查是否有程式已使用此校驗資料 
   IF NOT adzi220_chk_using('d') THEN
      RETURN
   END IF

   #130221 By benson --- E
   #Begin:2015/04/23 by Hiko
   ##20141007 
   #FETCH adzi220_cl INTO g_dzcd_m.dzcd001,g_dzcd_m.dzcdl003,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,g_dzcd_m.dzcdmodid,g_dzcd_m.modid_desc,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.ownid_desc,g_dzcd_m.dzcdowndp,g_dzcd_m.owndp_desc,g_dzcd_m.dzcdcrtid,g_dzcd_m.crtid_desc,g_dzcd_m.dzcdcrtdp,g_dzcd_m.crtdp_desc,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006  # 鎖住將被更改或取消的資料 
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = g_dzcd_m.dzcd001
   #   LET g_errparam.popup = FALSE
   #   CALL cl_err()
   #   #ROLLBACK WORK #2015/04/23 by Hiko
   #   RETURN
   #END IF
   #
   #CALL adzi220_show()
   #End:2015/04/23 by Hiko
  
   IF cl_ask_del_master() THEN              #確認一下
      BEGIN WORK
      #刪除r.v設計資料
      CALL adzi220_del_v_design_data(g_dzcd_m.dzcd001,g_dzcd_m.dzcd002) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
        ROLLBACK WORK
        RETURN
      ELSE
        COMMIT WORK
      END IF

      CLEAR FORM
      CALL g_dzce_d.clear()
      CALL g_dzch_d.clear() 

      CALL adzi220_ui_browser_refresh()  
      CALL adzi220_ui_headershow()  
      #CALL adzi220_ui_detailshow() #2015/04/01 by Hiko
       
      IF g_browser_cnt > 0 THEN 
         CALL adzi220_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         CALL adzi220_browser_fill("first")
      END IF
       
   END IF
    
END FUNCTION
 
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi220_b_fill(p_wc2)
   DEFINE p_wc2      STRING
 
   CALL g_dzce_d.clear()    #g_dzce_d 單頭及單身 
 
 
  #LET g_sql = "SELECT dzce002,dzce004,dzcel004 ",
  #            " FROM dzce_t ",
  #            " LEFT JOIN dzcel_t ON dzcel001=dzce001 AND dzcel002 = dzce002 AND dzcel003 = '",g_lang,"' ",
  #            " WHERE dzce001=? "   
  #20141007
   LET g_sql = "SELECT dzce002,dzce003,dzce004,dzcel004 ",
               " FROM dzce_t ",
               " LEFT JOIN dzcel_t ON dzcel001=dzce001 AND dzcel002 = dzce002 AND dzcel003 = '",g_lang,"' ",
               " WHERE dzce001=? AND dzce003=? "

   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF
 
   PREPARE adzi220_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR adzi220_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
  #OPEN b_fill_cs USING g_dzcd_m.dzcd001
   OPEN b_fill_cs USING g_dzcd_m.dzcd001,g_dzcd_m.dzcd002 #20141007
                                            
  #FOREACH b_fill_cs INTO g_dzce_d[l_ac].dzce002,g_dzce_d[l_ac].dzce004,g_dzce_d[l_ac].dzcel004
  #20141007
  FOREACH b_fill_cs INTO g_dzce_d[l_ac].dzce002,g_dzce_d[l_ac].dzce003,g_dzce_d[l_ac].dzce004,g_dzce_d[l_ac].dzcel004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #SELECT dzcel004 INTO g_dzce_d[l_ac].dzcel004 FROM dzcel_t WHERE dzcel001 = g_dzcd_m.dzcd001 AND dzcel002 = g_dzce_d[l_ac].dzce002 AND dzcel003 = g_lang
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_dzce_d.deleteElement(l_ac)
 
 
   LET g_rec_b=l_ac-1
   #DISPLAY g_rec_b TO FORMONLY.cnt #2015/04/01 by Hiko 
   LET l_ac = g_cnt
   LET g_cnt = 0  

   CALL g_dzch_d.clear()    #g_dzch_d 單頭及單身 
 
 
  #LET g_sql = "SELECT dzch002,dzch003,dzch004,gzze003 ",
  #            " FROM dzch_t ",
  #            " LEFT JOIN gzze_t ON gzze001=dzch004 AND gzze002 ='",g_lang,"'",
  #            " WHERE dzch001=? " 
   #20141007
   LET g_sql = "SELECT dzch002,dzch003,dzch004,dzch005,gzze003 ",
               " FROM dzch_t ",
               " LEFT JOIN gzze_t ON gzze001=dzch004 AND gzze002 ='",g_lang,"'",
               " WHERE dzch001=? AND dzch005=? "    
 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF
 
   PREPARE adzi220_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR adzi220_pb2
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
  #OPEN b_fill_cs2 USING g_dzcd_m.dzcd001
   OPEN b_fill_cs2 USING g_dzcd_m.dzcd001,g_dzcd_m.dzcd002 #20141007
 
                                            
  #FOREACH b_fill_cs2 INTO g_dzch_d[l_ac].dzch002,g_dzch_d[l_ac].dzch003,g_dzch_d[l_ac].dzch004,g_dzch_d[l_ac].gzze003
   #20141007
   FOREACH b_fill_cs2 INTO g_dzch_d[l_ac].dzch002,g_dzch_d[l_ac].dzch003,g_dzch_d[l_ac].dzch004,g_dzch_d[l_ac].dzch005,g_dzch_d[l_ac].gzze003   
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF


      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_dzch_d.deleteElement(l_ac)

   LET g_rec_b=l_ac-1
   #DISPLAY g_rec_b TO FORMONLY.cnt #2015/04/01 by Hiko 
   LET l_ac = g_cnt
   LET g_cnt = 0 
   
END FUNCTION
 
 
 
#+ 刪除單身db資料後畫面頁簽連動
PRIVATE FUNCTION adzi220_delete_b(p_total,p_table_id)
   DEFINE p_table_id LIKE dzea_t.dzea001
   DEFINE p_total    LIKE type_t.num5

   IF p_table_id = "dzce_t" THEN
      IF p_total = g_dzce_d.getLength() THEN
         CALL g_dzce_d.deleteElement(l_ac)
      END IF
   END IF

   IF p_table_id = "dzch_t" THEN   
      IF p_total = g_dzch_d.getLength() THEN
         CALL g_dzch_d.deleteElement(l_ac)
      END IF
   END IF 
   
END FUNCTION
 
 
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi220_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
 
   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("dzcd001,dzcd005",TRUE)

      #20150114 -Begin-
      IF g_dgenv='s' THEN
         CALL cl_set_comp_entry("dzcd006",TRUE)
      END IF
      #20150114 -End-
   END IF
   
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi220_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
 
   IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("dzcd001,dzcd005,dzcd006",FALSE)
   END IF

   CALL cl_set_comp_entry("dzcd002",FALSE) #20141007 這個值應該自動給

   #20150114 -Begin-
   #客製環境下,新增時不允許異動行業別欄位
   IF p_cmd = 'a' AND g_dgenv='c' THEN
      CALL cl_set_comp_entry("dzcd006",FALSE)
   END IF
   #20150114 -End-


   #Begin:20160329 by elena
   #行業環境下不可異動行業別欄位
   IF p_cmd = 'a' AND g_dgenv = 's' AND sadzp060_ind_check_area() THEN
      CALL cl_set_comp_entry("dzcd006",FALSE)
   END IF
   #End:20160329 by elena   
END FUNCTION
 
#回傳單身順序(dzce002)的最大值
PRIVATE FUNCTION adzi220_max_value(p_table_id)
   DEFINE p_table_id   LIKE dzea_t.dzea001
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE r_max_value  LIKE type_t.num5

   IF p_table_id = "dzce_t" THEN
      FOR l_cnt = 1 TO g_dzce_d.getLength()
         IF g_dzce_d[l_cnt].dzce002 > r_max_value THEN
            LET r_max_value = g_dzce_d[l_cnt].dzce002
         END IF
      END FOR
   END IF

   IF p_table_id = "dzch_t" THEN
      FOR l_cnt = 1 TO g_dzch_d.getLength()
         IF g_dzch_d[l_cnt].dzch002 > r_max_value THEN
            LET r_max_value = g_dzch_d[l_cnt].dzch002
         END IF
      END FOR
   END IF   
   
   LET r_max_value = r_max_value + 1
   
   RETURN r_max_value
END FUNCTION

#+ 進行外部變數的驗證
PRIVATE FUNCTION adzi220_arg_verify(p_dzcd003)
   DEFINE p_dzcd003      STRING
   DEFINE l_dzcd003      base.StringBuffer
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_i_str        STRING
   DEFINE r_value        BOOLEAN

   LET  r_value = FALSE
   LET l_dzcd003 = base.StringBuffer.create() 
   CALL l_dzcd003.append(p_dzcd003)

   #將判斷條件一併加入SQL語法
   FOR l_i = 1 TO g_dzch_d.getLength()
      CALL l_dzcd003.append(" "||g_dzch_d[l_i].dzch003||" ")
   END FOR

   #DISPLAY "l_dzcd003.toString()111 = ",l_dzcd003.toString()
   
   LET l_cnt = 0

   #判斷SQL語法中有無全部參數名稱
   FOR l_i = 1 TO g_dzce_d.getLength()
      IF l_dzcd003.getIndexOf(g_dzce_d[l_i].dzce004,1) THEN
         #若有登記的參數名稱存在於SQL語法中則消除
         CALL l_dzcd003.replace("arg"||g_dzce_d[l_i].dzce004,"",0)
         LET l_cnt = l_cnt + 1
      END IF
   END FOR

   #如果符合的數量和SQL語法中參數名稱數量一致,則回傳TRUE
   IF l_cnt = g_dzce_d.getLength() THEN
      LET  r_value = TRUE
   END IF

   #檢查SQL語法中還有無有無arg1~arg9的字串,若有回傳FALSE
   FOR l_i = 1 TO 9 
      LET l_i_str = l_i
      LET l_i_str = l_i_str.trim()
      IF l_dzcd003.getIndexOf("arg"||l_i_str,1) THEN
         LET r_value = FALSE
         EXIT FOR
      END IF
   END FOR

   IF r_value = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00025"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   RETURN r_value
END FUNCTION

#+ 進行SQL指令驗證
#PRIVATE FUNCTION adzi220_sql_verify(p_dzcd003)
PRIVATE FUNCTION adzi220_sql_verify(p_dzcd003,p_dzcd005,p_alert) #160428-00021 增加參數2,3
   DEFINE p_dzcd003      STRING
   DEFINE p_dzcd005      STRING
   DEFINE l_dzcd003      base.StringBuffer
   DEFINE r_value        BOOLEAN
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_err          STRING
   DEFINE l_arg          STRING #20151204
   DEFINE l_today        STRING #20151229
   DEFINE p_alert        BOOLEAN #160428-00021 #TRUE:錯誤訊息彈窗  FALSE:錯誤訊息顯示在背景
   DEFINE ls_SQLERRMESSAGE STRING #161104-00041
   
   #檢查相關tag是否已存在SQL中,避免下面一連串的判斷錯誤
   #LET l_err = adzi220_tag_exist(p_dzcd003)
    LET l_err = adzi220_tag_exist(p_dzcd003,p_dzcd005) #160428-00021
    IF l_err IS NOT NULL THEN
       IF p_alert THEN #160428-00021
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  "adz-00022"
          LET g_errparam.extend = NULL
          LET g_errparam.popup = TRUE
          LET g_errparam.replace[1] =  l_err
          CALL cl_err()
       ELSE
         #Begin: #160428-00021 modify
         #DISPLAY "ERROR:","adz-00022 ", l_err
          LET g_v_errmsg = "ERROR:","adz-00022 ", l_err
          DISPLAY g_v_errmsg
         #End: #160428-00021 modify
       END IF
       RETURN FALSE
      
    END IF
    
   #130221 By benson --- S
   #檢查tag的順序
    CALL adzi220_tag_sort(p_dzcd003)
    IF NOT cl_null(g_errno) THEN
       IF p_alert THEN #160428-00021
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = g_errno
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
       ELSE
         #Begin: #160428-00021 modify
          LET g_v_errmsg = "ERROR:",g_errno
          DISPLAY g_v_errmsg
         #End: #160428-00021 modify
       END IF
       RETURN FALSE
    END IF
   #130221 By benson --- E
   
   TRY
 #Begin: 160428-00021 mark & 移到獨立function adzi220_trans_pure_sql()
 ##   LET l_dzcd003 = base.StringBuffer.create() 
 ##   CALL l_dzcd003.append(p_dzcd003)
 ##   
 ##   LET  r_value = FALSE

 ##   #因為可提供使用者不輸入where條件的SQL,如:
 ##   #SELECT DISTINCT <field>dzeb001</field>
 ##   #  FROM <table>dzeb_t</table>
 ##   #  WHERE <wc></wc>
 ##   #而目前又要求一定要留WHERE <wc></wc>這行字和標籤,以方便後面校驗SQL的 g_verify.where加入
 ##   #所以這裡的驗證SQL就必須要將WHERE <wc></wc>這行字變成空白
 ##   #以免將SQL驗證時,發生 WHERE 後面沒有加條件式的錯誤情況發生
 ##   LET l_index = l_dzcd003.getIndexOf(G_WHERE_END.trim(), 1)
 ##   IF l_index > 0 THEN
 ##      #判斷一下SQL是否有WHERE <wc></wc>裡沒有where條件的情況
 ##      #如果有條件會像:WHERE <wc>1=1</wc>
 ##      #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
 ##      IF (l_index - l_dzcd003.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
 ##         CALL l_dzcd003.replace("WHERE", "", 1)
 ##      END IF 
 ##   END IF

 ##   #為了要進行SQL驗證,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
 ##   CALL l_dzcd003.replace(G_COUNT_START, "", 1)
 ##   CALL l_dzcd003.replace(G_COUNT_END, "", 1)
 ##   CALL l_dzcd003.replace(G_FIELD_START, "", 1)
 ##   CALL l_dzcd003.replace(G_FIELD_END, "", 1) 
 ##   CALL l_dzcd003.replace(G_TABLE_START, "", 1)
 ##   CALL l_dzcd003.replace(G_TABLE_END, "", 1) 
 ##   CALL l_dzcd003.replace(G_WHERE_START, "", 1)
 ##   CALL l_dzcd003.replace(G_WHERE_END, "", 1) 
 ##   
 ##   #替換掉預設的外部參數名稱，避免影響SQL指令的執行
 ##   #20151204 -modify-
 ##   #CALL l_dzcd003.replace("arg1", "1", 0)
 ##   #CALL l_dzcd003.replace("arg2", "1", 0)
 ##   #CALL l_dzcd003.replace("arg3", "1", 0)
 ##   #CALL l_dzcd003.replace("arg4", "1", 0)
 ##   #CALL l_dzcd003.replace("arg5", "1", 0)
 ##   #CALL l_dzcd003.replace("arg6", "1", 0)
 ##   #CALL l_dzcd003.replace("arg7", "1", 0)
 ##   #CALL l_dzcd003.replace("arg8", "1", 0)
 ##   #CALL l_dzcd003.replace("arg9", "1", 0)

 ##   #先將'arg1'   換成 ''
 ##   #再將 arg1 也 換成 ''
 ##   #統一換成''的目的:是解決原本欄位型態NUMBER不能加單引號,VARCHAR要加單引號,但是如果套到IN時,實際上運用有問題
 ##   #                 結論是在sql_verify時統一換成''讓語法檢核ok,實際上用時由開發者在傳遞外部參數時自行決定要不要帶單引號
 ##   FOR l_index = 1 TO 9 
 ##     LET l_arg = "'","arg",l_index USING "<<<<<","'"
 ##     IF l_dzcd003.getIndexOf(l_arg, 1) THEN
 ##        CALL l_dzcd003.replace(l_arg, "''", 0)
 ##     END IF
 ##     LET l_arg = "arg",l_index USING "<<<<<"
 ##     IF l_dzcd003.getIndexOf(l_arg, 1) THEN
 ##        CALL l_dzcd003.replace(l_arg, "''", 0)
 ##     END IF
 ##   END FOR
 ##   #20151204 -modify-

 ##   CALL l_dzcd003.replace(":DLANG", "'1'", 0)
 ##   CALL l_dzcd003.replace(":LANG", "'1'", 0)
 ##   CALL l_dzcd003.replace(":LEGAL", "'1'", 0)
 ##   CALL l_dzcd003.replace(":SITE", "'1'", 0)
 ##   CALL l_dzcd003.replace(":USER", "'1'", 0)
 ##   CALL l_dzcd003.replace(":DEPT", "'1'", 0)
 ##   CALL l_dzcd003.replace(":ENT", "'1'", 0)
 ##  #20151229 by madey -modify-
 ##  #CALL l_dzcd003.replace(":TODAY", " TO_DATE('2013/11/20','yyyy/mm/dd') ", 0)
 ##  #CALL l_dzcd003.replace(":TODAY", "'2013/11/20'", 0)
 ##   LET l_today = cl_get_today_with_format() #ex TO_DATE('2015/01/23','YYYY/MM/DD') 
 ##   CALL l_dzcd003.replace(":TODAY", l_today, 0)
 ##  #20151229 by madey -modify-

 ##   #另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
 ##   CALL l_dzcd003.replace(";", "", 1)
 ##
 ##   #因為只是為了要驗證SQL是否可以執行正常而已,所以只SELECT第一筆資料
 ##   #這行以後應該要為了支援多種DB TOOL,要進行不同DB TOOL的語法改寫(CASE...WHEN)
 ##   #LET p_dzcd003 = "SELECT COUNT(1) FROM (", l_dzcd003.toString(), ") "

 ##   LET p_dzcd003 =  l_dzcd003.toString()
 ##   DISPLAY "sql_verify:", p_dzcd003, ";"
 #End: 160428-00021 mark & 移到獨立function adzi220_trans_pure_sql()

      #Begin: 160428-00021 add
      LET r_value = FALSE
      LET p_dzcd003 = adzi220_trans_pure_sql(p_dzcd003)
      #End: 160428-00021 add

      PREPARE chk_sql_pre FROM  p_dzcd003
      DECLARE chk_sql_cs CURSOR FOR chk_sql_pre

      OPEN chk_sql_cs
      
      #實際進行驗證
      #EXECUTE IMMEDIATE p_dzcd003

      LET r_value = TRUE
   CATCH 
      #todo : 這段程式之後要改.
      IF SQLCA.SQLCODE THEN
         LET ls_SQLERRMESSAGE = SQLERRMESSAGE #161104-00043
         LET g_v_errmsg = cl_getmsg(SQLCA.SQLCODE,g_lang)," :",ls_SQLERRMESSAGE #160428-00021 #161104-00043 modify
         IF p_alert THEN #160428-00021
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00024"
           #LET g_errparam.extend = "sql error:"
            LET g_errparam.extend = g_v_errmsg #160428-00021
            LET g_errparam.popup = TRUE
           #LET g_errparam.replace[1] = ""
            LET g_errparam.replace[1] = p_dzcd003 #160428-00021
            CALL cl_err()
         ELSE
           #DISPLAY "ERROR:","adz-00024 ",p_dzcd003
            DISPLAY g_v_errmsg #160428-00021
         END IF
      ELSE
         IF p_alert THEN #160428-00021
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00023"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  "Please notify administrator." 
            CALL cl_err()
         ELSE
            LET g_v_errmsg = "ERROR:","adz-00023", "Please notify administrator." || ";SQL:" || p_dzcd003 #160428-00021
            DISPLAY g_v_errmsg #160428-00021
         END IF
      END IF
     #DISPLAY "sql for chk = ",p_dzcd003 #160428-00021 mark
      LET r_value = FALSE
   END TRY 

   FREE chk_sql_cs
   FREE chk_sql_pre
   
   RETURN r_value
END FUNCTION

#+ 檢查動態開窗的查詢代碼的以q_開頭
PRIVATE FUNCTION adzi220_chk_dzcd001(ps_dzcd001,ps_dzcd006) #20150114
   DEFINE ps_dzcd001 STRING 

   #20150114 -Begin-
   DEFINE ps_dzcd006 STRING  #20150114
   DEFINE ld_industry_data DYNAMIC ARRAY OF RECORD 
       gzoi001  LIKE gzoi_t.gzoi001,
       gzoi002  LIKE gzoi_t.gzoi002,
       gzoistus LIKE gzoi_t.gzoistus
   END RECORD  
   DEFINE lb_chk_header BOOLEAN,
          lb_chk_footer BOOLEAN,
          li_i  LIKE TYPE_t.num5,
          ls_match_cond STRING,
          ls_err_header STRING,
          ls_err_footer STRING,
          ls_err_all    STRING
   #20150114 -End-


  #20150114:整段邏輯重寫

   LET lb_chk_header = TRUE
   LET lb_chk_footer = TRUE

   CASE g_dgenv
      WHEN "c"  #客製環境
         #檢查開頭
         LET ls_match_cond = 'cv_*' # 開頭必須為cv_xxx
         IF ps_dzcd001 MATCHES ls_match_cond THEN 
            #do nothing
         ELSE
            LET lb_chk_header = FALSE
            #adz-00509:命名必須以c%1_xxx開頭
            LET ls_err_header = cl_replace_err_msg(cl_getmsg("adz-00509", g_lang), 'v')
         END IF

         #經討論:客製環境下，新增時:不檢查結尾規則,行業別欄位dzcd006固定給sd,且不能改

      OTHERWISE #標準環境
         #檢查開頭
         LET ls_match_cond = 'v_*' # 開頭必須為q_xxx
         IF ps_dzcd001 MATCHES ls_match_cond THEN 
            #do nothing
         ELSE
            LET lb_chk_header = FALSE
            #adz-00508:命名必須以%1_xxx開頭
            LET ls_err_header = cl_replace_err_msg(cl_getmsg("adz-00508", g_lang), 'v')
         END IF

         #檢查結尾
         LET ld_industry_data = sadzp210_get_industry_data()
         CASE ps_dzcd006
            WHEN 'sd' #標準行業
               FOR li_i = 1 TO ld_industry_data.getLength()
                  IF ld_industry_data[li_i].gzoistus = 'Y' AND ld_industry_data[li_i].gzoi001 <> 'sd' THEN
                     LET ls_match_cond = '*_',ld_industry_data[li_i].gzoi001 # 結尾不可以是xxx_行業別,例如xxx_ph
                     IF ps_dzcd001 MATCHES ls_match_cond THEN 
                        LET lb_chk_footer = FALSE
                        #adz-00510:行業別欄位為%1，命名不可以是xxx_%2為結尾
                        LET ls_err_footer = cl_replace_err_msg(cl_getmsg("adz-00510", g_lang), ps_dzcd006||'|'||ld_industry_data[li_i].gzoi001)
                        EXIT FOR
                     ELSE
                        #do nothing
                     END IF
                  END IF
               END FOR 

            OTHERWISE #其他行業
               #檢查結尾
               LET ls_match_cond = '*_',ps_dzcd006 # 結尾必須是xxx_行業別,例如xxx_ph
               IF ps_dzcd001 MATCHES ls_match_cond THEN 
                  #do nothing
               ELSE
                  LET lb_chk_footer = FALSE
                  #adz-00511:行業別欄位為%1，命名必須是xxx_%2為結尾
                  LET ls_err_footer = cl_replace_err_msg(cl_getmsg("adz-00511", g_lang), ps_dzcd006||'|'||ps_dzcd006)
               END IF
         END CASE

   END CASE

   IF lb_chk_header AND lb_chk_footer THEN
      RETURN TRUE
   ELSE
      LET ls_err_all = cl_getmsg("adz-00126", g_lang), ':' #輸入名稱不符合命名原則
      IF NOT cl_null(ls_err_header) THEN
         LET ls_err_all = ls_err_all ,ASCII 10, '---',ls_err_header
      END IF
      IF NOT cl_null(ls_err_footer) THEN
         LET ls_err_all = ls_err_all ,ASCII 10, '---',ls_err_footer
      END IF

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00022" # % 
      LET g_errparam.popup = TRUE
      LET g_errparam.EXTEND = NULL
      LET g_errparam.replace[1] = ls_err_all
      CALL cl_err()
      RETURN FALSE
   END IF
   
END FUNCTION 

#+ UI上的SQL指令樣版(comboBox)樣版選擇
PRIVATE FUNCTION adzi220_sql_sample(p_cmd,p_sql_sample,p_sql_sample_o) 
   DEFINE p_cmd          LIKE type_t.chr1
   DEFINE p_sql_sample   LIKE type_t.chr1   #SQL指令type
   DEFINE p_sql_sample_o LIKE type_t.chr1   #SQL指令type
   DEFINE r_sql          STRING 
   DEFINE l_dzej004      LIKE dzej_t.dzej004
   
   IF p_cmd = 'a' THEN
      #顯示 SQL sample 改由抓資料庫的方式
      IF p_sql_sample != p_sql_sample_o OR cl_null(g_dzcd_m.dzcd003) THEN
         SELECT dzej004 INTO l_dzej004 FROM dzej_t
          WHERE dzej001 = 'verify_sql_sample'
            AND dzej002 = p_sql_sample_o
         IF l_dzej004 = g_dzcd_m.dzcd003 OR cl_null(g_dzcd_m.dzcd003) THEN
            SELECT dzej004 INTO l_dzej004 FROM dzej_t
             WHERE dzej001 = 'verify_sql_sample'
               AND dzej002 = p_sql_sample 
            LET g_dzcd_m.dzcd003 = l_dzej004
         ELSE
            IF cl_ask_confirm('adz-00060') THEN
               SELECT dzej004 INTO l_dzej004 FROM dzej_t
                WHERE dzej001 = 'verify_sql_sample'
                  AND dzej002 = p_sql_sample 
               LET g_dzcd_m.dzcd003 = l_dzej004
            END IF
         END IF
      END IF
   END IF
  #130221 By benson --- E
END FUNCTION

#+ 判斷相關tag,是否存在SQL語句中
#PRIVATE FUNCTION adzi220_tag_exist(p_dzcd003)    
PRIVATE FUNCTION adzi220_tag_exist(p_dzcd003,p_dzcd005) #160428-00021     
   DEFINE p_dzcd003           LIKE dzcd_t.dzcd003
   DEFINE p_dzcd005           LIKE dzcd_t.dzcd005 #160428-00021 
   DEFINE lsb_dzcd003         base.StringBuffer
   DEFINE l_index             LIKE type_t.num5
   DEFINE ls_err              STRING
   
   LET ls_err = ""
   
   #取得原始SQL
   LET lsb_dzcd003 = base.StringBuffer.create() 
   CALL lsb_dzcd003.append(p_dzcd003 CLIPPED) 

  #IF g_dzcd_m.dzcd005 MATCHES '[13]' THEN
   IF p_dzcd005 MATCHES '[13]' THEN #160428-00021 
      LET l_index = 0
      LET l_index = lsb_dzcd003.getIndexOf(G_COUNT_START, 1)
      IF l_index = 0 THEN LET ls_err = ls_err, G_COUNT_START, "is not exist!",ASCII 10 END IF

      LET l_index = 0
      LET l_index = lsb_dzcd003.getIndexOf(G_COUNT_END, 1)
      IF l_index = 0 THEN LET ls_err = ls_err, G_COUNT_END, "is not exist!",ASCII 10 END IF
   ELSE
     #IF g_dzcd_m.dzcd005 != '9' THEN
      IF p_dzcd005 != '9' THEN #160428-00021 
         LET l_index = 0
         LET l_index = lsb_dzcd003.getIndexOf(G_COUNT_START, 1)
         IF l_index > 0 THEN LET ls_err = ls_err, G_COUNT_START, "should not exist!",ASCII 10 END IF
         
         LET l_index = 0
         LET l_index = lsb_dzcd003.getIndexOf(G_COUNT_END, 1)
         IF l_index > 0 THEN LET ls_err = ls_err, G_COUNT_END, "should not exist!",ASCII 10 END IF
      END IF
   END IF

  #IF g_dzcd_m.dzcd005 MATCHES '[23]' THEN
   IF p_dzcd005 MATCHES '[23]' THEN #160428-00021 
      LET l_index = 0
      LET l_index = lsb_dzcd003.getIndexOf(G_FIELD_START, 1)
      IF l_index = 0 THEN LET ls_err = ls_err, G_FIELD_START, "is not exist!",ASCII 10 END IF
      
      LET l_index = 0
      LET l_index = lsb_dzcd003.getIndexOf(G_FIELD_END, 1)
      IF l_index = 0 THEN LET ls_err = ls_err, G_FIELD_END, "is not exist!",ASCII 10 END IF
   ELSE
     #IF g_dzcd_m.dzcd005 != '9' THEN
      IF p_dzcd005 != '9' THEN #160428-00021 
         LET l_index = 0
         LET l_index = lsb_dzcd003.getIndexOf(G_FIELD_START, 1)
         IF l_index > 0 THEN LET ls_err = ls_err, G_FIELD_START, "should not exist!",ASCII 10 END IF
         
         LET l_index = 0
         LET l_index = lsb_dzcd003.getIndexOf(G_FIELD_END, 1)
         IF l_index > 0 THEN LET ls_err = ls_err, G_FIELD_END, "should not exist!",ASCII 10 END IF
      END IF
   END IF

   LET l_index = 0 
   LET l_index = lsb_dzcd003.getIndexOf(G_TABLE_START, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_TABLE_START, "is not exist! ",ASCII 10 END IF

   LET l_index = 0 
   LET l_index = lsb_dzcd003.getIndexOf(G_TABLE_END, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_TABLE_END, "is not exist! ",ASCII 10 END IF

   LET l_index = 0 
   LET l_index = lsb_dzcd003.getIndexOf(G_WHERE_START, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_WHERE_START, "is not exist! ",ASCII 10 END IF

   LET l_index = 0
   LET l_index = lsb_dzcd003.getIndexOf(G_WHERE_END, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_WHERE_END, "is not exist! ",ASCII 10 END IF

   IF ls_err IS NOT NULL THEN
      LET ls_err = "Error tag: ", ASCII 10, ls_err
   END IF
   
   RETURN ls_err
END FUNCTION  

#130221 By benson --- S
#資料的新增、修改、刪除後的結果，都在這個function完成與資料庫的互動
PRIVATE FUNCTION adzi220_accept_data(p_cmd)
   DEFINE  p_cmd    LIKE type_t.chr1
   DEFINE  l_count  LIKE type_t.num5
   DEFINE  l_i      LIKE type_t.num5
   DEFINE  l_cnt    LIKE type_t.num5

   #20140905 -Begin-
   DEFINE  li_cnt   LIKE type_t.num5,
           lt_dzcdl002 LIKE dzcdl_t.dzcdl002,
           lt_dzcdl003 LIKE dzcdl_t.dzcdl003,
           lt_dzcel003 LIKE dzcel_t.dzcel003,
           lt_dzcel004 LIKE dzcel_t.dzcel004
   #20140905 -End- 

   IF p_cmd <> 'u' THEN
      #BEGIN WORK #2015/04/01 by Hiko
      LET l_count = 1  
      SELECT COUNT(*) INTO l_count FROM dzcd_t
       WHERE  dzcd001 = g_dzcd_m.dzcd001
         AND dzcd002 = g_dzcd_m.dzcd002 #20141007
      IF l_count = 0 THEN
		#20141007
         INSERT INTO dzcd_t (dzcd001,dzcd002,dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,
                             dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006)
          VALUES (g_dzcd_m.dzcd001,g_dzcd_m.dzcd002,g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,
                  g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,
                  g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006)
				  
         #20140905 -Begin-
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "lib-00100"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_dzcd_m.dzcd001
            LET g_errparam.replace[2] ="dzcd_t"
            LET g_errparam.extend = ""
            LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            #ROLLBACK WORK #2015/04/01 by Hiko
            RETURN
         END IF
         #20140905 -End-

        #20140905:mark 因為n_dzcdl()即時把資料insert進資料庫了,改下面寫法,否則很難判斷簡繁自動補資料的條件
        #SELECT COUNT(*) INTO l_cnt FROM dzcdl_t WHERE dzcdl001 = g_dzcd_m.dzcd001
        #IF l_cnt = 0 THEN
        #   INSERT INTO dzcdl_t (dzcdl001,dzcdl002,dzcdl003,dzcdl004)
        #      VALUES (g_dzcd_m.dzcd001,g_lang,g_dzcd_m.dzcdl003,'');
        #END IF

         #20140905 -Begin-
         DELETE FROM dzcdl_t WHERE dzcdl001 = g_dzcd_m.dzcd001 #20140905
         INSERT INTO dzcdl_t (dzcdl001,dzcdl002,dzcdl003,dzcdl004)
            VALUES (g_dzcd_m.dzcd001,g_lang,g_dzcd_m.dzcdl003,'');
         IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00066 modify
            CASE g_lang
               WHEN "zh_TW" LET lt_dzcdl002 = "zh_CN" CLIPPED
               WHEN "zh_CN" LET lt_dzcdl002 = "zh_TW" CLIPPED
            END CASE
            LET lt_dzcdl003 = cl_trans_code_tw_cn(lt_dzcdl002, g_dzcd_m.dzcdl003) CLIPPED
            INSERT INTO dzcdl_t (dzcdl001,dzcdl002,dzcdl003,dzcdl004) 
            VALUES (g_dzcd_m.dzcd001,lt_dzcdl002,lt_dzcdl003,"")
         END IF
         #20140905 -End-
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "lib-00100"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_dzcd_m.dzcd001
           #LET g_errparam.replace[2] ="g_dzcdl_m"
            LET g_errparam.replace[2] ="dzcdl_t" #20140905
            LET g_errparam.extend = ""
            LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            #ROLLBACK WORK #2015/04/01 by Hiko
         ELSE
            DELETE FROM dzce_t WHERE dzce001 = g_dzcd_m.dzcd001
                                 AND dzce003 = g_dzcd_m.dzcd002 #20141007 #2015/04/10 by Hiko:改了bug
            DELETE FROM dzcel_t WHERE dzcel001 = g_dzcd_m.dzcd001
            FOR l_i = 1 TO g_dzce_d.getLength() 
              #IF NOT cl_null(g_dzce_d[l_i].dzce004) AND NOT cl_null(g_dzce_d[l_i].dzcel004) THEN
               IF NOT cl_null(g_dzce_d[l_i].dzce004) THEN #20140905

                 #INSERT INTO dzce_t (dzce001,dzce002,dzce004) 
                 #     VALUES(g_dzcd_m.dzcd001,l_i,g_dzce_d[l_i].dzce004)
	          #20141007
                  INSERT INTO dzce_t (dzce001,dzce002,dzce003,dzce004) 
                       VALUES(g_dzcd_m.dzcd001,l_i,g_dzcd_m.dzcd002,g_dzce_d[l_i].dzce004)
                  #20140905 -Begin-
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "lib-00100"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_dzcd_m.dzcd001
                     LET g_errparam.replace[2] ="dzce_t"
                     LET g_errparam.extend = ""
                     LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                     CALL cl_err()
                     EXIT FOR 
                  END IF
                  #20140905 -End-

                  INSERT INTO dzcel_t (dzcel001, dzcel002, dzcel003, dzcel004, dzcel005)
                       VALUES (g_dzcd_m.dzcd001,g_dzce_d[l_i].dzce002,g_lang,g_dzce_d[l_i].dzcel004,'')
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "lib-00100"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_dzcd_m.dzcd001
                    #LET g_errparam.replace[2] ="g_dzce_d or dzcel"
                     LET g_errparam.replace[2] ="dzcel_t" #20140905
                     LET g_errparam.extend = ""
                     LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                     CALL cl_err()
                     EXIT FOR 
                 #ELSE              #20140905 mark
                 #   COMMIT WORK    #20140905 mark
                  END IF

                  #20140905 -Begin-
                  #此處是走新增v流程, 上面已經刪除掉舊資料了,所以可以直接新增
                  IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00066 modify
                     CASE g_lang
                        WHEN "zh_TW" 
                           LET lt_dzcel003 = "zh_CN" CLIPPED
                        WHEN "zh_CN"
                           LET lt_dzcel003 = "zh_TW" CLIPPED
                     END CASE
                     LET lt_dzcel004 = cl_trans_code_tw_cn(lt_dzcel003, g_dzce_d[l_i].dzcel004) CLIPPED
                     INSERT INTO dzcel_t (dzcel001,dzcel002,dzcel003,dzcel004,dzcel005) 
                          VALUES(g_dzcd_m.dzcd001,g_dzce_d[l_i].dzce002,lt_dzcel003,lt_dzcel004,"")                       
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "lib-00100"
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = g_dzcd_m.dzcd001
                        LET g_errparam.replace[2] ="dzcel_t"
                        LET g_errparam.extend = ""
                        LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                        CALL cl_err()
                        EXIT FOR 
                     END IF
                  END IF
                  #20140905 -End-

               END IF
            END FOR
            
            DELETE FROM dzch_t WHERE dzch001 = g_dzcd_m.dzcd001
                                 AND dzch005 = g_dzcd_m.dzcd002 #20141007
            FOR l_i = 1 TO g_dzch_d.getLength() 
               IF NOT cl_null(g_dzce_d[l_i].dzce002) THEN

                 #INSERT INTO dzch_t (dzch001,dzch002,dzch003,dzch004) 
                 #     VALUES(g_dzcd_m.dzcd001,l_i,g_dzch_d[l_i].dzch003,g_dzch_d[l_i].dzch004)
		 #20141007	   
                  INSERT INTO dzch_t (dzch001,dzch002,dzch003,dzch004,dzch005) 
                       VALUES(g_dzcd_m.dzcd001,l_i,g_dzch_d[l_i].dzch003,g_dzch_d[l_i].dzch004,g_dzcd_m.dzcd002)					   
                
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "lib-00100"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_dzcd_m.dzcd001
                     LET g_errparam.replace[2] ="g_dzch_d"
                     LET g_errparam.extend = ""
                     LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                     CALL cl_err()
                     EXIT FOR 
                  ELSE 
                #    COMMIT WORK
                  END IF
               END IF
            END FOR
            
            IF SQLCA.sqlcode THEN 
               #ROLLBACK WORK #2015/04/01 by Hiko
            END IF
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'std-00004'
         LET g_errparam.extend =  g_dzcd_m.dzcd001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #ROLLBACK WORK #2015/04/01 by Hiko
      END IF 
      #COMMIT WORK #2015/04/01 by Hiko
   ELSE
      #BEGIN WORK #2015/04/01 by Hiko
     #20141007
      UPDATE dzcd_t SET (dzcd003,dzcd004,dzcd005,dzcdmodid,dzcdmoddt,dzcdownid,dzcdowndp,
                         dzcdcrtid,dzcdcrtdp,dzcdcrtdt,dzcd006) = 
                        (g_dzcd_m.dzcd003,g_dzcd_m.dzcd004,g_dzcd_m.dzcd005,
                         g_dzcd_m.dzcdmodid,g_dzcd_m.dzcdmoddt,g_dzcd_m.dzcdownid,g_dzcd_m.dzcdowndp,g_dzcd_m.dzcdcrtid,
                         g_dzcd_m.dzcdcrtdp,g_dzcd_m.dzcdcrtdt,g_dzcd_m.dzcd006)
         WHERE  dzcd001 = g_dzcd_m_t.dzcd001 AND dzcd002 = g_dzcd_m.dzcd002

		 
      SELECT COUNT(*) INTO l_count FROM dzcdl_t WHERE dzcdl001 = g_dzcd_m.dzcd001 AND dzcdl002 = g_lang
      IF l_count > 0 THEN
         UPDATE dzcdl_t SET (dzcdl001,dzcdl002,dzcdl003,dzcdl004) = 
            (g_dzcd_m.dzcd001,g_lang,g_dzcd_m.dzcdl003,"")
            WHERE dzcdl001 = g_dzcd_m.dzcd001 AND dzcdl002 = g_lang
      ELSE
         INSERT INTO dzcdl_t (dzcdl001,dzcdl002,dzcdl003,dzcdl004)
            VALUES (g_dzcd_m.dzcd001,g_lang,g_dzcd_m.dzcdl003,'')
      END IF

      #20140905 -Begin-
      IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00066 modify
         CASE g_lang
            WHEN "zh_TW" LET lt_dzcdl002 = "zh_CN" CLIPPED
            WHEN "zh_CN" LET lt_dzcdl002 = "zh_TW" CLIPPED
         END CASE
         SELECT COUNT(*) INTO l_count FROM dzcdl_t WHERE dzcdl001 = g_dzcd_m.dzcd001 AND dzcdl002 = lt_dzcdl002
         IF l_count > 0 THEN
            #do nothing
         ELSE
            LET lt_dzcdl003 = cl_trans_code_tw_cn(lt_dzcdl002, g_dzcd_m.dzcdl003) CLIPPED
            INSERT INTO dzcdl_t (dzcdl001,dzcdl002,dzcdl003,dzcdl004) 
            VALUES (g_dzcd_m.dzcd001,lt_dzcdl002,lt_dzcdl003,"")
         END IF
      END IF
      #20140905 -End-

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "lib-00101"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_dzcd_m.dzcd001
        #LET g_errparam.replace[2] ="g_dzcd_m"
         LET g_errparam.replace[2] ="dzcdl_t" #20140905
         LET g_errparam.extend = ""
         LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
         CALL cl_err()
         #ROLLBACK WORK #2015/04/01 by Hiko
      ELSE
         DELETE FROM dzce_t WHERE  dzce001 = g_dzcd_m_t.dzcd001
	                      AND dzce003 = g_dzcd_m_t.dzcd002 #20141007
         DELETE FROM dzce_t WHERE  dzce001 = g_dzcd_m.dzcd001
	                      AND dzce003 = g_dzcd_m.dzcd002 #20141007

         FOR l_i = 1 TO g_dzce_d.getLength() 
           #IF NOT cl_null(g_dzce_d[l_i].dzce004) AND NOT cl_null(g_dzce_d[l_i].dzcel004) THEN
            IF NOT cl_null(g_dzce_d[l_i].dzce004) THEN #20140905
              #INSERT INTO dzce_t (dzce001,dzce002,dzce004) 
              #     VALUES(g_dzcd_m.dzcd001,l_i,g_dzce_d[l_i].dzce004)
              #20141007
   	       INSERT INTO dzce_t (dzce001,dzce002,dzce003,dzce004) 
                    VALUES(g_dzcd_m.dzcd001,l_i,g_dzcd_m.dzcd002,g_dzce_d[l_i].dzce004)
					

               DELETE FROM dzcel_t WHERE  dzcel001 = g_dzcd_m.dzcd001 
                                      AND dzcel002 = g_dzce_d[l_i].dzce002
                                      AND dzcel003 = g_lang
                    
               INSERT INTO dzcel_t (dzcel001, dzcel002, dzcel003, dzcel004, dzcel005)
                  VALUES (g_dzcd_m.dzcd001,g_dzce_d[l_i].dzce002,g_lang,g_dzce_d[l_i].dzcel004,'')

               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "lib-00100"
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzcd_m.dzcd001
                 #LET g_errparam.replace[2] ="g_dzce_d"
                  LET g_errparam.replace[2] ="dzcel_t" #20140905
                  LET g_errparam.extend = ""
                  LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                  CALL cl_err()
                  EXIT FOR 
               ELSE
              #   COMMIT WORK #20140905 mark
                  LET g_dzcd001_t = g_dzcd_m.dzcd001
		  LET g_dzcd002_t = g_dzcd_m.dzcd002 #20141007
               END IF

               #20140905 -Begin-
               #此處是走更新v流程, 上面只刪除掉單一語系的舊資料,要過濾舊資料是否存在,存在的話就不做了
               IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00066 modify
                  CASE g_lang
                     WHEN "zh_TW" 
                        LET lt_dzcel003 = "zh_CN" CLIPPED
                     WHEN "zh_CN"
                        LET lt_dzcel003 = "zh_TW" CLIPPED
                  END CASE
                  LET lt_dzcel004 = cl_trans_code_tw_cn(lt_dzcel003, g_dzce_d[l_i].dzcel004) CLIPPED
                  LET li_cnt = 0
                  SELECT COUNT(1) INTO li_cnt FROM dzcel_t
                   WHERE dzcel001 = g_dzcd_m.dzcd001 
                     AND dzcel002 = g_dzce_d[l_i].dzce002 
                     AND dzcel003 = lt_dzcel003
                  IF li_cnt = 0 THEN
                     INSERT INTO dzcel_t (dzcel001,dzcel002,dzcel003,dzcel004,dzcel005) 
                          VALUES(g_dzcd_m.dzcd001,g_dzce_d[l_i].dzce002,lt_dzcel003,lt_dzcel004,"")                       
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "lib-00100"
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = g_dzcd_m.dzcd001
                        LET g_errparam.replace[2] ="dzcel_t"
                        LET g_errparam.extend = ""
                        LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                        CALL cl_err()
                        EXIT FOR 
                     END IF
                  END IF
               END IF
               #20140905 -End-
            END IF
         END FOR

         DELETE FROM dzch_t WHERE  dzch001 = g_dzcd_m_t.dzcd001
	                      AND dzch005 = g_dzcd_m_t.dzcd002 #20141007
         DELETE FROM dzch_t WHERE  dzch001 = g_dzcd_m.dzcd001
	                      AND dzch005 = g_dzcd_m.dzcd002   #20141007

         FOR l_i = 1 TO g_dzch_d.getLength() 
            IF NOT cl_null(g_dzch_d[l_i].dzch002) THEN
              #INSERT INTO dzch_t (dzch001,dzch002,dzch003,dzch004) 
              #     VALUES(g_dzcd_m.dzcd001,l_i,g_dzch_d[l_i].dzch003,g_dzch_d[l_i].dzch004)
              #20141007
               INSERT INTO dzch_t (dzch001,dzch002,dzch003,dzch004,dzch005) 
                    VALUES(g_dzcd_m.dzcd001,l_i,g_dzch_d[l_i].dzch003,g_dzch_d[l_i].dzch004,g_dzcd_m.dzcd002)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "lib-00100"
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzcd_m.dzcd001
                  LET g_errparam.replace[2] ="g_dzch_d"
                  LET g_errparam.extend = ""
                  LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                  CALL cl_err()
                  EXIT FOR 
               ELSE
              #   COMMIT WORK
                  LET g_dzcd001_t = g_dzcd_m.dzcd001
		  LET g_dzcd002_t = g_dzcd_m.dzcd002 #20141007
               END IF
            END IF
         END FOR
         
         IF SQLCA.sqlcode THEN
            #ROLLBACK WORK #2015/04/01 by Hiko
         END IF
      END IF
      #COMMIT WORK #2015/04/01 by Hiko
   END IF
END FUNCTION


#檢查tag的順序
FUNCTION adzi220_tag_sort(p_dzcd003)
   DEFINE p_dzcd003           LIKE dzcd_t.dzcd003
   DEFINE lsb_dzcd003         base.StringBuffer
   DEFINE l_index             LIKE type_t.num5
   DEFINE l_index2            LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   
   LET g_errno = ""
   
   #取得原始SQL
   LET lsb_dzcd003 = base.StringBuffer.create() 
   CALL lsb_dzcd003.append(p_dzcd003 CLIPPED) 

   LET l_index = 0
   LET l_index = lsb_dzcd003.getIndexOf(G_COUNT_START, 1)

   LET l_index2 = 0
   LET l_index2 = lsb_dzcd003.getIndexOf(G_FIELD_START, 1)

   IF l_index > 0 AND l_index2 > 0 THEN
      IF l_index > l_index2 THEN
         LET g_errno = 'adz-00046'
      ELSE
         #檢查</count>和<field>之間 是否存在一個逗號
         LET l_cnt = lsb_dzcd003.getIndexOf(G_COUNT_END,1)
         LET l_index = lsb_dzcd003.getIndexOf(',',l_cnt)
         LET l_index2 = lsb_dzcd003.getIndexOf(G_FIELD_START,l_index)
         IF l_index2 = 0 THEN
            LET g_errno = 'adz-00047'
         END IF
      END IF
   END IF

END FUNCTION

#檢查錯誤訊息正確性
FUNCTION adzi220_chk_err_msg(p_err_id)
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE p_err_id LIKE gzze_t.gzze001

   LET p_err_id = p_err_id CLIPPED
   
   LET g_errno = ''
   SELECT COUNT(*) INTO l_cnt FROM gzze_t
    WHERE gzze001 = p_err_id

   IF l_cnt = 0 THEN
      LET g_errno = 'adz-00048'
   END IF
END FUNCTION

#欄位外部參數是否重複
FUNCTION adzi220_chk_dzce004()
   DEFINE l_i     LIKE type_t.num5

   LET g_errno = ''

   FOR l_i = 1 TO g_dzce_d.getLength() 
      IF l_i != l_ac THEN
         IF g_dzce_d[l_ac].dzce004 = g_dzce_d[l_i].dzce004 THEN
            LET g_errno = 'adz-00041'
            EXIT FOR
         END IF
      END IF
   END FOR
END FUNCTION

#檢查校驗資料是否有程式已使用
FUNCTION adzi220_chk_using(p_cmd)
   DEFINE p_cmd         LIKE type_t.chr1
   DEFINE l_dzac001     LIKE dzac_t.dzac001
   DEFINE l_dzac003     LIKE dzac_t.dzac001
   DEFINE l_dzac004     LIKE dzac_t.dzac001
   DEFINE l_dzep001     LIKE dzep_t.dzep001
   DEFINE l_dzep002     LIKE dzep_t.dzep002
   DEFINE l_msg         STRING
   DEFINE l_msg1        STRING
   DEFINE l_msg2        STRING
   DEFINE li_result     LIKE type_t.num5
   DEFINE l_like_dzac099 LIKE type_t.chr100
  #20140410:madey -start-
   DEFINE ls_sql        STRING
   DEFINE l_dzbb001     LIKE dzbb_t.dzbb001
   DEFINE l_like_dzbb098 LIKE type_t.chr100
   DEFINE l_msg3        STRING
  #20140410:madey -end-
   

 #20140930:整段內容移到get_using_list() ,因為太耗時了，
 #         此處改為僅提示要自行去點選get_using_list,然後回傳TRUE

  IF cl_ask_confirm_parm("adz-00397",g_dzcd_m.dzcd001) THEN
     LET li_result = TRUE  #繼續 
  ELSE
     LET li_result = FALSE #離開
  END IF
  RETURN li_result
END FUNCTION

#20150817:mark for 重寫
####取得使用中的程式清單 #20140930
##FUNCTION adzi220_get_using_list()
##   DEFINE p_cmd         LIKE type_t.chr1
##   DEFINE l_dzac001     LIKE dzac_t.dzac001
##   DEFINE l_dzac003     LIKE dzac_t.dzac001
##   DEFINE l_dzac004     LIKE dzac_t.dzac001
##   DEFINE l_dzep001     LIKE dzep_t.dzep001
##   DEFINE l_dzep002     LIKE dzep_t.dzep002
##   DEFINE l_msg         STRING
##   DEFINE l_msg1        STRING
##   DEFINE l_msg2        STRING
##   DEFINE li_result     LIKE type_t.num5
##   DEFINE l_like_dzac099 LIKE type_t.chr100
##  #20140410:madey -start-
##   DEFINE ls_sql        STRING
##   DEFINE l_dzbb001     LIKE dzbb_t.dzbb001
##   DEFINE l_like_dzbb098 LIKE type_t.chr100
##   DEFINE l_msg3        STRING
##  #20140410:madey -end-
##   
##   LET li_result = TRUE
##   LET l_msg = ""
##   LET l_msg2 = ""
##   LET l_msg1 = ""
##   LET l_msg3 = "" #20140410:madey
##
##   #20140410:madey:刪除時,要檢查dzac_t,dzep_t有沒有人在使用
##   #               修改時,不需要檢查dzep_t,因為dzep_t是r.a階段使用,修改校驗帶值對此階段來說沒影響
##
##   #dzac_t:設計資料
##   LET l_like_dzac099 = "%",g_dzcd_m.dzcd001,"%"
##   LET ls_sql = "SELECT DISTINCT ac1.dzac001",
##                " FROM dzac_t ac1 ",
##                "INNER JOIN (SELECT dzaa001,dzaa002,dzaa003,dzaa004,dzaa006",
##                "              FROM dzaa_t aa3",
##                "              WHERE aa3.dzaa002 =",
##               #"                    (SELECT MAX(aa2.dzaa002_01)",                                 #20140922 mark
##                "                    (SELECT MAX(CAST(NVL(TRIM(aa2.dzaa002_01),'0') AS INTEGER))", #20140922 add
##                "                       FROM (SELECT dzaa001,dzaa002,dzaa003,dzaa004,dzaa006,",
##                "                                    NVL2(af3.dzaf001,af3.dzaf003,'1') dzaa002_01",
##                "                               FROM dzaa_t aa1",
##                "                               LEFT OUTER JOIN (SELECT af1.dzaf001,af1.dzaf003",
##                "                                                 FROM dzaf_t af1",
##                "                                                WHERE af1.dzaf002 =",
##               #"                                                      (SELECT MAX(af2.dzaf002) MAX_var",                                 #20140922 mark
##                "                                                      (SELECT MAX(CAST(NVL(TRIM(af2.dzaf002),'0') AS INTEGER)) MAX_var", #20140922 add
##                "                                                         FROM dzaf_t af2",
##                "                                                        WHERE af2.dzaf001 =",
##                "                                                              af1.dzaf001)) af3",
##                "                                 ON aa1.dzaa001 = af3.dzaf001",
##                "                                AND aa1.dzaa002 = af3.dzaf003",
##                "                              WHERE aa1.dzaastus = 'Y'",
##                "                                AND aa1.dzaa005 = '1') aa2",
##                "                     WHERE aa2.dzaa001 = aa3.dzaa001)",
##                "               AND aa3.dzaa005 = '1') aa4",
##                "    ON aa4.dzaa001 = ac1.dzac001",
##                "   AND aa4.dzaa003 = ac1.dzac003",
##                "   AND aa4.dzaa004 = ac1.dzac004",
##                "   AND aa4.dzaa006 = ac1.dzac012",
##                " WHERE ac1.dzac011 = '",g_dzcd_m.dzcd001,"'",
##               #"    OR ac1.dzac099 LIKE '",l_like_dzac099,"'", #20140416:madey
##                "    OR DBMS_LOB.INSTR(ac1.dzac099,'",g_dzcd_m.dzcd001,"',1,1) > 0",
##                " ORDER BY ac1.dzac001"
##
##   DECLARE adzi210_dzac_cs CURSOR FROM ls_sql
##   FOREACH adzi210_dzac_cs INTO l_dzac001
##      IF cl_null(l_msg1) THEN
##         LET l_msg1 = ASCII 10,"### spec data (dzac_t) ###",ASCII 10,l_dzac001 CLIPPED,ASCII 10
##      ELSE
##         LET l_msg1 = l_msg1 CLIPPED,l_dzac001 CLIPPED,ASCII 10
##      END IF
##   END FOREACH
##   FREE adzi210_dzac_cs
##
##
##   #dzep_t:adzi150設計資料
##   DECLARE adzi210_dzep_cs CURSOR FOR
##    SELECT DISTINCT dzep001 FROM ds.dzep_t
##     WHERE dzep019 = g_dzcd_m.dzcd001
##     ORDER BY dzep001
##   
##   FOREACH adzi210_dzep_cs INTO l_dzep001
##      IF cl_null(l_msg2) THEN
##          LET l_msg2 = ASCII 10,"### adzi150 data (dzep_t) ###",ASCII 10,l_dzep001 CLIPPED,ASCII 10
##      ELSE
##         LET l_msg2 = l_msg2 CLIPPED,l_dzep001 CLIPPED,ASCII 10
##      END IF
##   END FOREACH
##   FREE adzi210_dzep_cs
##
##
##   #dzbb_t:add point資料
##   LET ls_sql = "SELECT DISTINCT bb1.dzbb001",
##                " FROM dzbb_t bb1 ",
##                "INNER JOIN (SELECT dzba001,dzba002,dzba003,dzba004,dzba005",
##                "              FROM dzba_t ba3",
##                "             WHERE ba3.dzba002 =",
##               #"                   (SELECT MAX(ba2.dzba002_01)",                                 #20140922 mark
##                "                   (SELECT MAX(CAST(NVL(TRIM(ba2.dzba002_01),'0') AS INTEGER))", #20140922 add
##                "                      FROM (SELECT dzba001,dzba002,dzba003,dzba004,dzba005,",
##                "                                   NVL2(af3.dzaf001, af3.dzaf004, '1') dzba002_01",
##                "                              FROM dzba_t ba1",
##                "                              LEFT OUTER JOIN (SELECT af1.dzaf001,af1.dzaf004",
##                "                                                FROM dzaf_t af1",
##                "                                               WHERE af1.dzaf002 =",
##               #"                                                     (SELECT MAX(af2.dzaf002) MAX_var",                                 #20140922 mark
##                "                                                     (SELECT MAX(CAST(NVL(TRIM(af2.dzaf002),'0') AS INTEGER)) MAX_var", #20140922 add
##                "                                                        FROM dzaf_t af2",
##                "                                                       WHERE af2.dzaf001 =",
##                "                                                             af1.dzaf001)) af3",
##                "                                ON ba1.dzba001 = af3.dzaf001",
##                "                               AND ba1.dzba002 = af3.dzaf004",
##                "                             WHERE ba1.dzbastus = 'Y') ba2",
##                "                     WHERE ba2.dzba001 = ba3.dzba001)) ba4",
##                "   ON ba4.dzba001 = bb1.dzbb001",
##                "  AND ba4.dzba003 = bb1.dzbb002",
##                "  AND ba4.dzba004 = bb1.dzbb003",
##                "  AND ba4.dzba005 = bb1.dzbb004",
##                " WHERE DBMS_LOB.INSTR(bb1.dzbb098,'",g_dzcd_m.dzcd001,"""',1,1) > 0",
##                " ORDER BY bb1.dzbb001"
##   DECLARE adzi210_dzbb_cs CURSOR FROM ls_sql
##   FOREACH adzi210_dzbb_cs INTO l_dzbb001
##      IF cl_null(l_msg3) THEN
##         LET l_msg3 = ASCII 10,"### add-pointe data (dzbb_t) ###",ASCII 10,l_dzbb001 CLIPPED,ASCII 10
##      ELSE
##         LET l_msg3 = l_msg3 CLIPPED,l_dzbb001 CLIPPED,ASCII 10
##      END IF
##   END FOREACH
##   FREE adzi210_dzbb_cs
##
##   LET l_msg = l_msg2,l_msg1,l_msg3
##
##   #顯示訊息
##   INITIALIZE g_errparam TO NULL                                                                            
##   LET g_errparam.popup = TRUE
##   IF NOT cl_null(l_msg) THEN
##      LET g_errparam.code = "adz-00395"
##      LET g_errparam.EXTEND = "== Using Prog List ==", ASCII 10, l_msg
##   ELSE
##      LET g_errparam.code = "lib-00196"
##   END IF
##   CALL cl_err()
##
##END FUNCTION

##取得使用中的程式清單 #20140817:重寫
FUNCTION adzi220_get_using_list()
   DEFINE ls_msg STRING

  #LET ls_msg = ASCII 10,
  #             "cd $ERP" , ASCII 10,
  #             "grep -iE ", 
  #             "'cl_chk_exist\\(","|",
  #             "cl_ref_val\\("   ,"|",
  #             "cl_chk_exist_and_ref_val\\('",
  #             " */4gl/*.4gl",
  #             "|",
  #             "grep '", g_dzcd_m.dzcd001,"'"

   LET ls_msg = cl_getmsg('adz-00696',g_lang),ASCII 10
   LET ls_msg =  ls_msg,ASCII 10,
                "grep -ilE ", 
                "'cl_chk_exist\\(""",g_dzcd_m.dzcd001,"""\\)","|",
                "cl_ref_val\\(""",g_dzcd_m.dzcd001,"""\\)","|",
                "cl_chk_exist_and_ref_val\\(""",g_dzcd_m.dzcd001,"""\\)'",
                " $ERP/*/4gl/*.4gl"," $COM/*/4gl/*.4gl"

   LET ls_msg =  ls_msg,ASCII 10,
                "grep -ilE ", 
                '"cl_chk_exist\\(''',g_dzcd_m.dzcd001,'''\\)',"|",
                'cl_ref_val\\(''',g_dzcd_m.dzcd001,'''\\)',"|",
                'cl_chk_exist_and_ref_val\\(''',g_dzcd_m.dzcd001,'''\\)"',
                " $ERP/*/4gl/*.4gl"," $COM/*/4gl/*.4gl"
   CALL sadzi140_rev_view_logresult(ls_msg)

END FUNCTION

FUNCTION adzi220_initial_combobox_sql()
  #Begin:2015/04/23 by Hiko:改用scc
  #LET ms_SQL_Chk_Type = "SELECT ZO.DZEJL002  MODULE_NAME,     ",
  #                      "       ZO.DZEJL004  MODULE_DESC      ",
  #                      "  FROM DZEJL_T ZO                    ",
  #                      " WHERE ZO.DZEJL001 = 'chk_type'    ",
  #                      "   AND ZO.DZEJL003 = '",g_lang,"'   ",
  #                      " ORDER BY ZO.DZEJL002                "
  #End:2015/04/23 by Hiko

  LET ms_SQL_Sample = "SELECT ZO.DZEJL002  MODULE_NAME,     ",
                      "       ZO.DZEJL004  MODULE_DESC      ",
                      "  FROM DZEJL_T ZO                    ",
                      #" WHERE ZO.DZEJL001 = 'sql_sample2'    ",
                      " WHERE ZO.DZEJL001 = 'verify_sql_sample'    ", #2015/04/23 by Hiko
                      "   AND ZO.DZEJL003 = '",g_lang,"'   ",
                      " ORDER BY TO_NUMBER(ZO.DZEJL002)     " #cch 要為數值的排序
END FUNCTION

FUNCTION adzi220_fill_combobox(p_Combobox,p_SQL)
 DEFINE p_Combobox  ui.ComboBox,
        p_SQL       STRING
 DEFINE ls_SQL      STRING,
        li_Index    INTEGER,
        li_Count    INTEGER,
        ls_Combobox RECORD
           Combobox_NAME VARCHAR(50),
           Combobox_DESC VARCHAR(255)
               END RECORD

   LET li_Index = 0
   LET ls_SQL = p_SQL
   
   PREPARE lpre_Combobox FROM ls_SQL
   DECLARE lcur_Combobox SCROLL CURSOR FOR lpre_Combobox
   
   CALL p_Combobox.clear()
   
   LET li_Count = 1
   
   FOREACH lcur_Combobox INTO ls_Combobox.*
     IF SQLCA.sqlcode THEN
       EXIT FOREACH
     END IF
     #cch 因為combox的item順序一定要連續,不能跳號
     LET ls_Combobox.Combobox_NAME = li_Count
     CALL p_Combobox.addItem(ls_Combobox.Combobox_NAME,ls_Combobox.Combobox_DESC)
     LET li_Count = li_Count + 1

   END FOREACH
   
   FREE lcur_Combobox
   FREE lpre_Combobox

END FUNCTION
#130221 By benson --- E

#+ 進行 command line 的程式執行 
PRIVATE FUNCTION adzi220_run_prog(p_shell,p_prog_id,p_arg_str)
   DEFINE p_prog_id      STRING
   DEFINE p_shell        STRING
   DEFINE p_arg_str      STRING
   DEFINE l_cmd          STRING    
   DEFINE l_msg          STRING
   DEFINE l_chk          LIKE type_t.num5

   LET l_cmd = p_shell," ",p_prog_id," ",p_arg_str
   CALL cl_cmdrun_openpipe(p_shell,l_cmd,FALSE) RETURNING l_chk,l_msg
END FUNCTION

#20150729
#+ r.v由標準 -> 客製
PRIVATE FUNCTION adzi220_std_to_cust()
   DEFINE l_newno        LIKE dzcd_t.dzcd001 
   DEFINE l_oldno        LIKE dzcd_t.dzcd001 

   DEFINE l_old_cust_flag LIKE dzcd_t.dzcd002
   DEFINE l_new_cust_flag LIKE dzcd_t.dzcd002
   
   DEFINE l_master       RECORD LIKE dzcd_t.*
   DEFINE l_detail       RECORD LIKE dzce_t.*
   DEFINE l_err_detail   RECORD LIKE dzch_t.*
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_n            LIKE type_t.num5
   DEFINE lb_result      BOOLEAN



   #客製環境下，才可執行此功能
   IF g_dgenv = "c" THEN
      #do noghing
   ELSE
      CALL cl_ask_pressanykey("adz-00599") 
      RETURN
   END IF
 
   LET l_new_cust_flag = 'c'
   LET l_newno = g_dzcd_m.dzcd001

   SELECT COUNT(*) INTO l_n FROM dzcd_t WHERE dzcd001 = l_newno
                                          AND dzcd002 = l_new_cust_flag
   #客製資料已存在
   IF l_n > 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code =  "std-00006"
       LET g_errparam.EXTEND = l_newno
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
   END IF

   IF cl_ask_sure() THEN
      #複製r.v設計資料
      BEGIN WORK

      LET lb_result=TRUE
    
      SELECT * INTO l_master.* FROM dzcd_t 
        WHERE  dzcd001 = g_dzcd_m.dzcd001
          AND dzcd002 = "s"
    
      LET l_master.dzcd001 = l_newno
      LET l_master.dzcd002  = l_new_cust_flag 
      LET l_master.dzcdcrtid = g_user
      LET l_master.dzcdcrtdp = g_dept
      LET l_master.dzcdcrtdt = cl_get_current()
      LET l_master.dzcdownid = g_user 
      LET l_master.dzcdowndp = g_dept 
      LET l_master.dzcdmodid = g_user
      LET l_master.dzcdmoddt = cl_get_current()
      
      INSERT INTO dzcd_t VALUES (l_master.*) #複製單頭
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.EXTEND = 'Insert ERROR! dzcd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         LET lb_result=FALSE
         GOTO _return
      END IF
   
      #dzcdl_t不處理 :標準及客製的多語言資料是共用的,此處不需要額外進行拷貝
   
      #複製dzce_t單身
      DELETE FROM dzce_t WHERE dzce001 = l_master.dzcd001
                           AND dzce003=l_master.dzcd002 
      LET g_sql = "SELECT * FROM dzce_t WHERE  ",
                  " dzce001 = '",g_dzcd_m.dzcd001,"' AND dzce003='s'"
    
      DECLARE adzi220_copy_std CURSOR FROM g_sql
    
      FOREACH adzi220_copy_std INTO l_detail.*
         LET l_detail.dzce001 = l_newno
         LET l_detail.dzce003 = l_new_cust_flag
             
         INSERT INTO dzce_t VALUES (l_detail.*) #複製單身
   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'Insert dzce_t error!'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET lb_result = FALSE
            GOTO _return
         END IF
      END FOREACH
   
      DELETE FROM dzch_t WHERE dzch001 = l_master.dzcd001
                           AND dzch005 = l_master.dzcd002
      #複製dzch_t單身      
      LET g_sql = "SELECT * FROM dzch_t WHERE  ",
                  " dzch001 = '",g_dzcd_m.dzcd001,"' AND dzch005='s'"
      DECLARE adzi220_copy_std2 CURSOR FROM g_sql
    
      FOREACH adzi220_copy_std2 INTO l_err_detail.*
         LET l_err_detail.dzch001 = l_newno
         LET l_err_detail.dzch005 = l_new_cust_flag
             
         INSERT INTO dzch_t VALUES (l_err_detail.*) #複製單身
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'reproduce dzch_t error!'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET lb_result = FALSE
            GOTO _return
         END IF
      END FOREACH
   
     LABEL _return:
      IF NOT lb_result THEN
         ROLLBACK WORK
         RETURN
      ELSE
         COMMIT WORK
      END IF
   
      #彈窗顯示成功
      CALL cl_ask_pressanykey("adz-00549")#標準轉客製完成
   END IF

END FUNCTION

#20150729
#+ r.v由客製 -> 標準
PRIVATE FUNCTION adzi220_cust_to_std()
   DEFINE li_dzcd_cnt    SMALLINT,    #有幾筆dzcd資料
          lb_have_cust   BOOLEAN,     #是否客製
          lb_std_to_cust BOOLEAN,     #是否標準轉客製
          l_str          STRING
   DEFINE lb_result      BOOLEAN,
          ls_err_msg     STRING


   #客製環境下，才可執行此功能
   IF g_dgenv = "c" THEN
      #do noghing
   ELSE
      CALL cl_ask_pressanykey("adz-00599") 
      RETURN
   END IF

   CALL cl_chk_validate_chk_have_cust(g_dzcd_m.dzcd001) RETURNING li_dzcd_cnt,lb_have_cust
   IF lb_have_cust AND li_dzcd_cnt > 1 THEN
      LET lb_std_to_cust = TRUE 
   ELSE
      LET lb_std_to_cust = FALSE 
   END IF

   #非標準轉客製，擋下來
   IF NOT lb_std_to_cust THEN 
      CALL cl_ask_pressanykey("adz-00664") 
      RETURN
   END IF

   IF cl_ask_sure() THEN  #確認一下
      BEGIN WORK
      #刪除r.v設計資料
      CALL adzi220_del_v_design_data(g_dzcd_m.dzcd001,g_dzcd_m.dzcd002) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
        ROLLBACK WORK
        RETURN
      ELSE
        COMMIT WORK
      END IF
      
      #彈窗顯示成功
      CALL cl_ask_pressanykey("adz-00579") #客製還原標準完成
   END IF

END FUNCTION

#+刪除r.v設計資料
PRIVATE FUNCTION adzi220_del_v_design_data(p_dzcd001,p_dzcd002)
   DEFINE p_dzcd001      LIKE dzcd_t.dzcd001
   DEFINE p_dzcd002      LIKE dzcd_t.dzcd002
 
   DEFINE lb_result      BOOLEAN
   DEFINE ls_err_msg     STRING

   DEFINE ls_sql         STRING
   DEFINE ls_where_cond_dzcd  STRING
   DEFINE ls_where_cond_dzce  STRING
   DEFINE ls_where_cond_dzch  STRING

   DEFINE li_dzcd_cnt      LIKE type_t.num5,
          lb_have_cust     BOOLEAN,
          lb_std_to_cust   BOOLEAN

   CALL cl_chk_validate_chk_have_cust(p_dzcd001) RETURNING li_dzcd_cnt,lb_have_cust
   IF li_dzcd_cnt = 0 THEN
      DISPLAY "Warning: no r.v design data!"
      RETURN TRUE,NULL
   END IF
   IF lb_have_cust AND li_dzcd_cnt > 1 THEN
      LET lb_std_to_cust = TRUE 
   ELSE
      LET lb_std_to_cust = FALSE 
   END IF

   #p_dzcd002為空表示 不管s,c都做
   IF NOT cl_null(p_dzcd002) THEN
     LET ls_where_cond_dzcd = " AND dzcd002='",p_dzcd002,"'"
     LET ls_where_cond_dzce = " AND dzce003='",p_dzcd002,"'"
     LET ls_where_cond_dzch = " AND dzch005='",p_dzcd002,"'"
   ELSE
     LET ls_where_cond_dzcd = NULL
     LET ls_where_cond_dzce = NULL
     LET ls_where_cond_dzch = NULL
   END IF

   TRY

       #刪除dzcd_t, dzce_t, dzch_t
       LET ls_sql = "DELETE FROM dzcd_t  WHERE dzcd001 = '",p_dzcd001,"'"
       LET ls_sql = ls_sql , ls_where_cond_dzcd
       PREPARE del_dzcd_pre FROM ls_sql
       
       LET ls_sql = "DELETE FROM dzce_t  WHERE dzce001 = '",p_dzcd001,"'"
       LET ls_sql = ls_sql , ls_where_cond_dzce
       PREPARE del_dzce_pre FROM ls_sql
       
       LET ls_sql = "DELETE FROM dzch_t  WHERE dzch001 = '",p_dzcd001,"'"
       LET ls_sql = ls_sql , ls_where_cond_dzch
       PREPARE del_dzch_pre FROM ls_sql
       
       EXECUTE del_dzcd_pre
       EXECUTE del_dzce_pre
       EXECUTE del_dzch_pre

       #刪除多語言檔
       IF p_dzcd002 = 'c' AND lb_std_to_cust THEN
          #表示屬於標準轉客製的開窗,且現在是要做還原標準的動作，因為多語言是標準及客製共用的,此情境下不可刪除
          #do nothing
       ELSE
          LET ls_sql = "DELETE FROM dzcdl_t  WHERE dzcdl001 = '",p_dzcd001,"'"
          PREPARE del_dzcdl_pre FROM ls_sql
          
          LET ls_sql = "DELETE FROM dzcel_t  WHERE dzcel001 = '",p_dzcd001,"'"
          PREPARE del_dzcel_pre FROM ls_sql
          
          EXECUTE del_dzcdl_pre
          EXECUTE del_dzcel_pre
       END IF

       RETURN TRUE,NULL
   

   CATCH
     
       LET ls_err_msg = "Error: delete r.v design data fail,SQLCA.sqlcode=",SQLCA.sqlcode
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code =  "adz-00023"
       LET g_errparam.EXTEND = ""
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] =  ls_err_msg
       CALL cl_err()
       RETURN FALSE,ls_err_msg
   
   END TRY

END FUNCTION

#160428-00021 #此段落從原本adzi220_sql_verify()獨立出來
#+ 把sql中的tag都拿掉
PRIVATE FUNCTION adzi220_trans_pure_sql(p_dzcd003)
   DEFINE p_dzcd003      STRING
   DEFINE r_dzcd003      STRING
   DEFINE l_dzcd003      base.StringBuffer
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_err          STRING
   DEFINE r_value        BOOLEAN
   DEFINE l_arg          STRING
   DEFINE l_today        STRING 

   LET l_dzcd003 = base.StringBuffer.create() 
   CALL l_dzcd003.append(p_dzcd003)
   
   LET  r_value = FALSE

   #因為可提供使用者不輸入where條件的SQL,如:
   #SELECT DISTINCT <field>dzeb001</field>
   #  FROM <table>dzeb_t</table>
   #  WHERE <wc></wc>
   #而目前又要求一定要留WHERE <wc></wc>這行字和標籤,以方便後面校驗SQL的 g_verify.where加入
   #所以這裡的驗證SQL就必須要將WHERE <wc></wc>這行字變成空白
   #以免將SQL驗證時,發生 WHERE 後面沒有加條件式的錯誤情況發生
   LET l_index = l_dzcd003.getIndexOf(G_WHERE_END.trim(), 1)
   IF l_index > 0 THEN
      #判斷一下SQL是否有WHERE <wc></wc>裡沒有where條件的情況
      #如果有條件會像:WHERE <wc>1=1</wc>
      #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
      IF (l_index - l_dzcd003.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
         CALL l_dzcd003.replace("WHERE", "", 1)
      END IF 
   END IF

   #為了要進行SQL驗證,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
   CALL l_dzcd003.replace(G_COUNT_START, "", 1)
   CALL l_dzcd003.replace(G_COUNT_END, "", 1)
   CALL l_dzcd003.replace(G_FIELD_START, "", 1)
   CALL l_dzcd003.replace(G_FIELD_END, "", 1) 
   CALL l_dzcd003.replace(G_TABLE_START, "", 1)
   CALL l_dzcd003.replace(G_TABLE_END, "", 1) 
   CALL l_dzcd003.replace(G_WHERE_START, "", 1)
   CALL l_dzcd003.replace(G_WHERE_END, "", 1) 
   
   #替換掉預設的外部參數名稱，避免影響SQL指令的執行
   #20151204 -modify-
   #先將'arg1'   換成 ''
   #再將 arg1 也 換成 ''
   #統一換成''的目的:是解決原本欄位型態NUMBER不能加單引號,VARCHAR要加單引號,但是如果套到IN時,實際上運用有問題
   #                 結論是在sql_verify時統一換成''讓語法檢核ok,實際上用時由開發者在傳遞外部參數時自行決定要不要帶單引號
   FOR l_index = 1 TO 9 
     LET l_arg = "'","arg",l_index USING "<<<<<","'"
     IF l_dzcd003.getIndexOf(l_arg, 1) THEN
        CALL l_dzcd003.replace(l_arg, "''", 0)
     END IF
     LET l_arg = "arg",l_index USING "<<<<<"
     IF l_dzcd003.getIndexOf(l_arg, 1) THEN
        CALL l_dzcd003.replace(l_arg, "''", 0)
     END IF
   END FOR
   #20151204 -modify-

   CALL l_dzcd003.replace(":DLANG", "'1'", 0)
   CALL l_dzcd003.replace(":LANG", "'1'", 0)
   CALL l_dzcd003.replace(":LEGAL", "'1'", 0)
   CALL l_dzcd003.replace(":SITE", "'1'", 0)
   CALL l_dzcd003.replace(":USER", "'1'", 0)
   CALL l_dzcd003.replace(":DEPT", "'1'", 0)
   CALL l_dzcd003.replace(":ENT", "'1'", 0)
   #20151229 by madey -modify-
   #CALL l_dzcd003.replace(":TODAY", " TO_DATE('2013/11/20','yyyy/mm/dd') ", 0)
   #CALL l_dzcd003.replace(":TODAY", "'2013/11/20'", 0)
    LET l_today = cl_get_today_with_format() #ex TO_DATE('2015/01/23','YYYY/MM/DD') 
    CALL l_dzcd003.replace(":TODAY", l_today, 0)
   #20151229 by madey -modify-

    #另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
    CALL l_dzcd003.replace(";", "", 1)
   
    #因為只是為了要驗證SQL是否可以執行正常而已,所以只SELECT第一筆資料
    #這行以後應該要為了支援多種DB TOOL,要進行不同DB TOOL的語法改寫(CASE...WHEN)
    #LET p_dzcd003 = "SELECT COUNT(1) FROM (", l_dzcd003.toString(), ") "

    LET r_dzcd003 =  l_dzcd003.toString()
    DISPLAY "trans_pure_sql=",ASCII 10 , r_dzcd003
    RETURN r_dzcd003
 
END FUNCTION

#160428-00021
#新增此function而沒有直接放進去adzi220_sql_verify()的原因:
#是比照adzi210,維護上比較一致
#+ 進行cartesian 驗證
PRIVATE FUNCTION adzi220_chk_cartesian(p_dzcd003,p_alert)
   DEFINE p_dzcd003      STRING
   DEFINE p_alert        BOOLEAN          #TRUE:錯誤訊息彈窗  FALSE:錯誤訊息顯示在背景
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_err          STRING
   DEFINE r_value        BOOLEAN
   DEFINE l_arg          STRING 
   DEFINE l_today        STRING
   DEFINE l_sql          STRING

   
   LET p_dzcd003 = p_dzcd003.trim()
   IF p_dzcd003.getIndexOf("arg", 1) THEN
      #有帶arg參數的，因為預設驗證是給'',有可能會導致驗證不準，所以先by pass當作ok
      LET r_value = FALSE
   ELSE
      LET l_sql = adzi220_trans_pure_sql(p_dzcd003)
      LET r_value = sadzp007_uti_chk_cartesian(l_sql)   
      
      IF r_value AND p_alert THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.type = 0
         LET g_errparam.code =  "adz-01003"
        #LET g_errparam.extend = l_sql
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   
   RETURN r_value
END FUNCTION

#160428-00021
#+ 批次進行chk sql for 全部開窗程式
PRIVATE FUNCTION adzi220_chk_sql_all_v()
   DEFINE  l_dzcd001_arr  DYNAMIC ARRAY OF RECORD
           dzcd001        LIKE dzcd_t.dzcd001,
	   dzcd002        LIKE dzcd_t.dzcd002,
           dzcd003        LIKE dzcd_t.dzcd003,
           dzcd005        LIKE dzcd_t.dzcd005
   END RECORD
   DEFINE  l_cnt          LIKE type_t.num5,
           li_i           LIKE type_t.num5
   DEFINE  p_dzcd001      STRING
   DEFINE  l_err_list     DYNAMIC ARRAY OF RECORD
           err_v_id       LIKE dzcd_t.dzcd001,
	   err_v_cust_flag  LIKE dzcd_t.dzcd002,
           err_status     STRING
   END RECORD
   DEFINE  ld_total_s     DATETIME YEAR TO SECOND,#FRACTION(4)
           ld_total_e     DATETIME YEAR TO SECOND #FRACTION(4)
                
   DEFINE  ls_msg         STRING
   DEFINE  ls_cmd         STRING

   LET ld_total_s = cl_get_current()

   #標準和客製都有時,先抓客製
   LET g_sql = " SELECT UNIQUE dzcd001,dzcd002,dzcd003,dzcd005 ", 
                      " FROM dzcd_t ",
                      " INNER JOIN ", 
                          "(SELECT DISTINCT cd1.dzcd001 AS dzcd001_1,                         ",
                          "       CASE                                                        ",
                          "         WHEN EXISTS (SELECT 1                                     ",#標準跟客製都有,只顯示客製
                          "                 FROM dzcd_t cd2                                   ",
                          "                WHERE cd2.dzcd001 = cd1.dzcd001                    ",
                          "                  AND cd2.dzcd002 = 'c') THEN                      ",
                          "          'c'                                                      ",
                          "         ELSE                                                      ",
                          "          's'                                                      ",
                          "       END AS dzcd002_1                                            ",
                          "  FROM (SELECT cd0.dzcd001, cd0.dzcd002 FROM dzcd_t cd0) cd1) cd2  ",
                      " ON dzcd001 = cd2.dzcd001_1 AND dzcd002 = cd2.dzcd002_1                "
   PREPARE dzcd001_pre01 FROM g_sql   #組合SQL條件

   DECLARE dzcd001_curs01 CURSOR FOR dzcd001_pre01   #指標指向PREPARE
   CALL l_dzcd001_arr.clear()
   LET l_cnt = 1

   LET g_errshow = FALSE
   

   #將dzcd001全部的v識別碼載入array，每載入一個執行馬上執行
   FOREACH dzcd001_curs01 INTO l_dzcd001_arr[l_cnt].dzcd001,l_dzcd001_arr[l_cnt].dzcd002,l_dzcd001_arr[l_cnt].dzcd003,l_dzcd001_arr[l_cnt].dzcd005    #指標依序抓取資料到陣列
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_dzcd001_arr.deleteElement(l_cnt)   #刪除內容為空的元素
   LET l_cnt =l_cnt-1

   CALL cl_progress_bar(l_dzcd001_arr.getLength()) 
   FOR li_i = 1 TO l_dzcd001_arr.getLength()
      CALL cl_progress_ing("[Message] chk sql for all v")

      DISPLAY "call adzi220_sql_verify('",l_dzcd001_arr[li_i].dzcd001,"')"
      LET g_v_errmsg = NULL
      IF NOT adzi220_sql_verify(l_dzcd001_arr[li_i].dzcd003,l_dzcd001_arr[li_i].dzcd005,FALSE) THEN
         CALL l_err_list.appendElement()
         LET l_err_list[l_err_list.getLength()].err_v_id = l_dzcd001_arr[li_i].dzcd001
         LET l_err_list[l_err_list.getLength()].err_v_cust_flag = l_dzcd001_arr[li_i].dzcd002 
         LET l_err_list[l_err_list.getLength()].err_status = "sql verify fail:",g_v_errmsg
         CONTINUE FOR
      END IF
      IF adzi220_chk_cartesian(l_dzcd001_arr[li_i].dzcd003,FALSE) THEN 
         CALL l_err_list.appendElement()
         LET l_err_list[l_err_list.getLength()].err_v_id = l_dzcd001_arr[li_i].dzcd001
         LET l_err_list[l_err_list.getLength()].err_v_cust_flag = l_dzcd001_arr[li_i].dzcd002 
         LET l_err_list[l_err_list.getLength()].err_status = "chk_cartesian fail"
         CONTINUE FOR
      END IF
      DISPLAY "chk sql ok:",l_dzcd001_arr[li_i].dzcd001
   END FOR


   LET ld_total_e = cl_get_current()

   LET g_errshow = TRUE
   IF l_err_list.getLength() > 1 THEN
      LET ls_msg = "process finish with some error"
      LET ls_msg = ls_msg , ASCII  10,"###### SQL ERROR LIST FOR v_*: ######"
      
      FOR li_i = 1 TO l_err_list.getLength()
         LET ls_msg = ls_msg, ASCII 10, l_err_list[li_i].err_v_id,": ",l_err_list[li_i].err_status
      END FOR
   ELSE
      LET ls_msg = "process finish "
   END IF
   LET ls_msg = ls_msg , ASCII  10,ASCII 10,'total v cnt: ',l_cnt
   LET ls_msg = ls_msg , ASCII  10,'total time used: ',ld_total_s, ' - ',ld_total_e, ' ',ld_total_e - ld_total_s
   DISPLAY ls_msg
   CALL sadzi140_rev_view_logresult(ls_msg)
END FUNCTION
