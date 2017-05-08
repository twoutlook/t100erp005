#r 程式版本......: T6 Version 1.00.00 Build-0001 at 12/10/12
#
#+ 程式代碼......: adzi210
#+ 設計人員......: Jay,Benson,cch
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzi210.4gl
# Description    : 開窗程式資料建立
# Memo           :
# Modify.........: 31/10/12 By Henry 因應兆家要修改表格，mark掉共用欄位的部分
#                  2013/01/29 by Hiko 調整畫面與對應程式
#                  2013/02/01 By benson 調整操作方式與異動資料庫的時機 
#                  2013/10/11 By Hiko 增加ooaa_t的條件(g_enterprise)
#                  2014/03/14 By madey 增加欄位dzca006記錄是否hard code,並允許建立hard code資料
#                  2014/03/25 By madey 檢查是否在使用中,增加判斷dzbb_t;並調整訊息顯示格式
#                  2014/04/16 By madey query clob語法由like改用DBMS_LOB.INSTR (like有錯)
#                  2014/05/29 By madey 支持二次開發及行業別: 
#                                      1.adzi210_generate_qry由PRIVATE改為PUBLIC
#                  2014/06/17 By madey adzi210_sql_verify()增加參數是否要彈窗，不彈窗則DISPLAY在背景(for rebuild_all_qry)
#                  2014/07/03 By madey insert完gzzn_t後,增加呼叫s_azzi070_gen_qry 重產q_total
#                  2014/07/10 By madey adzi210_generate_qry()停用,搬到新建立的sadzp210_generate_qry()
#                  2014/08/06 By madey adzp210僅編譯不連結,連結由後續呼叫產生q_total(s_azzi070_gen_qry)一併做
#                  2014/09/03 by madey 透過g_gen42s_flag決定要不要做42s關聯
#                  2014/09/05 by madey 1.dzcbl004.設為可輸可不輸(4gl,4fd都要調整)
#                                      2.dzcbl_t,dzcal_t新增時自動補入中文語系資料(輸繁體時補簡體,反之)
#                                      3.bug fix
#                  2014/09/17 by madey 1.delete qry時呼叫q_total(s_azzi070_gen_qry)
#                  2014/09/22 by madey 1.因應版次欄物型態改變而調整(varchar -> number)
#                                      2.bug fix
#                                      3.欄位名稱由抓dzeb003改抓dzebl003
#                  2014/09/30 by madey 檢查使用中獨立出來一個action 
#                  2014/10/07 by madey 增加PK:客製否欄位dzca002,dzcb004,dzcc009
#                  2014/11/11 by madey 連資料庫由CONNECT TO改用cl_db_connect
#                  2014/12/30 by madey 視g_qry_gen_qtotal決定要不要重新連結,並增加progress bar
#                  2015/01/07 by madey 調整qry rebuild
#                  2015/01/13 by madey 檢核輸入語系資料吻合g_lang
#                  2015/01/14 by madey 新增行業別欄位(dzca007)
#                  2015/04/15 by Hiko  畫面調整:KEY WORD為BEAUTY
#                  2015/04/23 by Hiko  1.rebuild_all_qry改成debug mode(以ARG(3)判斷)
#                                      2.adzi210_chk_using改在修改按下就檢查
#                                      3.簡化delete,modify的程式段
#                  2015/06/16 by Hiko  資料大小寫:從adzi150(dzep023)預設到r.q(dzcc006),再由開發人員調整. g_auto_genqry可以不用.
#                  2015/07/01 by madey 支持qry透過設計器開發內容(hardcode),dzca006=Y
#                  2015/08/04 by madey 1.調整多處INT_FLAG
#                                      2.標準環境下不可挑選自定義欄位
#                                      3.topstd帳號無法修改/刪除客製資料
#                                      4.拿掉q_total,僅作r.l qry
#                                      5.微調rebuild_all_qry()彈窗順序
#                  2015/08/17 by madey 1.調整整批重產的提示訊息
#                                      2.開窗停用g_gen42s_flag,重產時一律不產生42s
#                                      3.使用中清單get_using_list()改抓gzzl_t
#                  2015/10/05 by madey 1.顯示格式(dzcc010):從adzi150(dzep021)預設到r.q,再由開發人員調整
#                                      2.檢查:sql指令一定要包含ORDER BY
#                                      3.增加欄位:不共用主程式多語言
#                  2015/10/23 by madey 1.微調使用中程式相關訊息
#                                      2.標準轉客製or客製還原標準時, 提醒要做r.l xxx ALL
#                                      3.調整chk_usging_list判斷agli041,azzi650規則
#                  2015/12/04 by madey 調整sql驗證時arg的預設值,統一將arg換成單引號
#                  2015/12/29 by madey 公用變數TODAY給值改為帶TO_DATE格式，解決DBDATE變更及資料型態為timestamp時sql出錯
#                  20160223 160223-00028 by madey :patch優化專案
#                                        1.新增一個functon處理gzzn_t的更新
#                                        2.調整r.l qry cqry的時機點
#                                        3.調整外部參數(測試qry與god mode共用參數1);god mode下不檢查是否使用，可強制刪除qry
#                  20160325 160325-00022 by madey :取得參數E-SYS-0002改用cl_get_para()
#                  20160406 160419-00007 by elena :行業卡控(與此單相依之單號160406-00012)
#                  20160428 160428-00021 by madey :1.sql檢核cartesian
#                                                  2.god mode增加功能:整批sql驗證
#                  20160707 160707-00013 by madey :1.bug修正:insert時,after field就該判斷是否已存在
#                                                  2.insert時,檢查已存在的where條件微調，不需要判斷客製否
#                  20160902 160902-00041 by madey :修正r.q查詢使用中程式時，匯出excel會出現lib-00190的錯
#                  20161104 161104-00041 by madey :sql檢核錯誤時增加顯示SQLERRMESSAGE
#                  20161215 161215-00007 by madey :修正在英文語系下存檔會crash
 
IMPORT os
SCHEMA ds 

&include "../4gl/sadzp200_type.inc"

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzi888_global.inc"   #用g_gen42s_flag
GLOBALS
     DEFINE g_qry_gen_qtotal STRING  
     DEFINE g_compile_flag   LIKE type_t.chr1 #是否自動編譯
     DEFINE g_qry_gen_errmsg    STRING    #20150804
END GLOBALS

CONSTANT g_std_module = "qry"                   #標準qry開窗程式所在路徑
CONSTANT g_cust_module = "cqry"                 #客製qry開窗程式所在路徑
 
{<Module define>}
 
#單頭 type 宣告
PRIVATE type type_g_dzca_m        RECORD
   dzca001 LIKE dzca_t.dzca001, 
   dzcal003 LIKE dzcal_t.dzcal003, 
   dzca002 LIKE dzca_t.dzca002, #客製否
   dzca006 LIKE dzca_t.dzca006, #hard code  
   dzca003 LIKE dzca_t.dzca003,
   dzca004 LIKE dzca_t.dzca004,
   dzca005 LIKE dzca_t.dzca005,  
   #dzcastus LIKE dzca_t.dzcastus,#忽略狀態碼 
   dzcamodid LIKE dzca_t.dzcamodid, 
   modid_desc LIKE type_t.chr500, 
   dzcamoddt DATETIME YEAR TO SECOND, 
   dzcaownid LIKE dzca_t.dzcaownid, 
   ownid_desc LIKE type_t.chr500, 
   dzcaowndp LIKE dzca_t.dzcaowndp, 
   owndp_desc LIKE type_t.chr500, 
   dzcacrtid LIKE dzca_t.dzcacrtid, 
   crtid_desc LIKE type_t.chr500, 
   dzcacrtdp LIKE dzca_t.dzcacrtdp, 
   crtdp_desc LIKE type_t.chr500, 
   dzcacrtdt DATETIME YEAR TO SECOND,
   dzca007 LIKE dzca_t.dzca007, 
   dzca008 LIKE dzca_t.dzca008 
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dzcc_d        RECORD
   dzcc002 LIKE dzcc_t.dzcc002, 
   dzcc003 LIKE dzcc_t.dzcc003,
   dzebl003 LIKE dzebl_T.dzebl003,
   dzcc004 LIKE dzcc_t.dzcc004, 
   dzcc005 LIKE dzcc_t.dzcc005, 
   dzcc006 LIKE dzcc_t.dzcc006, #2015/06/16 by Hiko:資料大小寫
   dzcc007 LIKE dzcc_t.dzcc007,
   dzcc010 LIKE dzcc_t.dzcc010, #20151005:顯示格式
   dzcc008 LIKE dzcc_t.dzcc008,
   dzcc009 LIKE dzcc_t.dzcc009
       END RECORD

#單身 type 宣告 
PRIVATE TYPE type_g_dzcb_d        RECORD
   dzcb002 LIKE dzcb_t.dzcb002, 
   dzcb003 LIKE dzcb_t.dzcb003,
   dzcbl004 LIKE dzcbl_t.dzcbl004,
   dzcb004 LIKE dzcb_t.dzcb004
       END RECORD

#功能 type 宣告
PRIVATE TYPE type_using_d        RECORD
     prog_id       LIKE gzzl_t.gzzl001,    #程式id
     prog_name     LIKE gzzal_t.gzzal003   #程式name
       END RECORD
################################################################################
#定義SQL語法中使用的tag名稱常數
CONSTANT G_FIELD_START = "<field>"     #欄位代碼開始符   
CONSTANT G_FIELD_END   = "</field>"    #欄位代碼結束符
CONSTANT G_TABLE_START = "<table>"     #資料表代碼開始符  
CONSTANT G_TABLE_END   = "</table>"    #資料表代碼結束符
CONSTANT G_WHERE_START = "<wc>"        #Where條件開始符  
CONSTANT G_WHERE_END   = "</wc>"       #Where條件結束符
CONSTANT G_INWC_START  = "<inwc>"      #input段要加入的條件開始符
CONSTANT G_INWC_END    = "</inwc>"     #input段要加入的條件結束符

#130221 By benson
################################################################################
## Define Combobox related SQLs
DEFINE ms_SQL_Sample         STRING
DEFINE ms_SQL_Global_var     STRING
################################################################################
 
#模組變數(Module Variables)
DEFINE g_dzca_m              type_g_dzca_m                     #DB目前record最新狀態
DEFINE g_dzca_m_t            type_g_dzca_m                     #單頭record舊值備份
DEFINE g_dzca001_t           LIKE dzca_t.dzca001               #key值備份
DEFINE g_dzca002_t           LIKE dzca_t.dzca002               #key值備份 
DEFINE g_dzcc_d              DYNAMIC ARRAY OF type_g_dzcc_d    #開窗畫面顯示設定
DEFINE g_dzcc_d_t            type_g_dzcc_d                     #單身record舊值備份
DEFINE g_dzcb_d              DYNAMIC ARRAY OF type_g_dzcb_d    #外部變數設定
DEFINE g_dzcb_d_t            type_g_dzcb_d                     #單身record舊值備份
DEFINE g_browser             DYNAMIC ARRAY OF RECORD                #資料瀏覽之欄位 
         #b_statepic     LIKE type_t.chr50,#忽略狀態碼 
         b_dzca001              LIKE dzca_t.dzca001,
         b_dzcal003              LIKE dzcal_t.dzcal003,
         rank                   LIKE type_t.num10,
	 b_dzca002              LIKE dzca_t.dzca002
                             END RECORD

DEFINE g_dzca003_t           LIKE dzca_t.dzca003                #UI上的SQL結果暫存
DEFINE g_wc                  STRING
DEFINE g_wc2                 STRING                             #單身CONSTRUCT結果
DEFINE g_sql                 STRING
DEFINE g_before_input_done   LIKE type_t.num5 
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num5              #
DEFINE g_rec_b2              LIKE type_t.num5              #            
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
DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500)
DEFINE tok                   base.StringTokenizer
DEFINE g_auto_genqry         LIKE type_t.chr1              #130201 By benson #2015/06/16 by Hiko:這個變數可以不用了
DEFINE g_sqlcode             LIKE type_t.chr10             #暫存sqlcode的值

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_wc_table1           STRING                        #第1個單身gzcc_t所使用的g_wc
DEFINE g_wc_table2           STRING                        #第2個單身gzcb_t所使用的g_wc
DEFINE g_dzca004_info        STRING
DEFINE g_q_prog_test         LIKE dzca_t.dzca001
DEFINE g_global_var          STRING
DEFINE g_dgenv               STRING                        
DEFINE g_god_mode            BOOLEAN #2015/04/23 by Hiko:固定為"DEBUG"
DEFINE g_rebuild_all_qry     BOOLEAN #20150804
DEFINE g_topind              STRING  #160419-00007 行業別

 
{</Module define>}
 
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

   DEFINE l_temp_dzca006 LIKE dzca_t.dzca006 
   DEFINE ls_tmp_arg STRING

   CALL cl_tool_init()

   #201511110 
   LET ls_tmp_arg = DOWNSHIFT(ARG_VAL(2)) 
   LET ls_tmp_arg = ls_tmp_arg.trim()
   IF ls_tmp_arg = "debug" THEN 
      DISPLAY "God Mode:ON"
      LET g_god_mode = TRUE
   ELSE
      LET g_q_prog_test = ls_tmp_arg
      IF NOT cl_null(g_q_prog_test) THEN #測試qry
         DISPLAY "Test Qry Mode:ON , qry id = ",g_q_prog_test
         CALL adzi210_test_query_prog(g_q_prog_test)
         CALL cl_ap_exitprogram("0") #離開
      END IF
   END IF

   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi210 WITH FORM cl_ap_formpath("adz",g_prog)

   CLOSE WINDOW screen

   #程式初始化
   CALL adzi210_init()
 
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

   #Begin:2015/04/23 by Hiko
   IF g_god_mode THEN
      CALL lf_form.setElementHidden("lbl_rebuild_all_qry", FALSE)
      CALL lf_form.setElementHidden("lbl_chk_sql_all_qry", FALSE) #160428-00021
   END IF
   #End:2015/04/23 by Hiko

   #進入選單 Menu (='N')
   CALL adzi210_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_adzi210
      
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
    
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi210_init()
   #130201 By benson --- S
   DEFINE lo_Combobox  ui.ComboBox,
         #l_ooaa002    LIKE ooaa_t.ooaa002, #160325-00022 mark
          l_gzze003    LIKE gzze_t.gzze003

   #給第一個單身更改順序後，下面的sql select 欄位的順序可以同步所建立的 
   TRY
      DROP TABLE adzi210_tmp
   CATCH
     #DISPLAY "DROP TABLE adzi210_tmp error, but don't worry." #20150415 by Hiko
   END TRY
   CREATE TEMP TABLE adzi210_tmp(
    dzcc002   SMALLINT,
    dzcc003   VARCHAR(15),
    dzcc008   VARCHAR(15))

   #動態產生comboBox內容
   CALL adzi210_initial_combobox_sql()
   
   LET lo_Combobox = ui.ComboBox.forName("formonly.l_sql_sample")
   CALL adzi210_fill_combobox(lo_Combobox,ms_SQL_Sample)

   #CALL adzi210_fill_combobox(lo_Combobox,ms_SQL_Global_var) #2015/04/23 by Hiko

   CALL cl_set_combo_scc("cbo_exe","211") #2015/04/23 by Hiko

  #SELECT ooaa002 INTO l_ooaa002 FROM dsdemo.ooaa_t WHERE ooaa001 = "E-SYS-0002" AND ooaaent = g_enterprise #2013/10/11 by Hiko #160325-00022 mark

   #DISPLAY "l_ooaa002 = ",l_ooaa002
   SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001="adz-00185" AND gzze002=g_lang

   #每頁顯示資料筆數的欄位說明
  #Begin: 160325-00022
  #LET g_dzca004_info = l_gzze003,"(",l_ooaa002,")"
   LET g_dzca004_info = l_gzze003,"(",cl_get_para(g_enterprise, "", "E-SYS-0002"),")"
  #End: 160325-00022

   #取得DGENV 
   LET g_dgenv = FGL_GETENV("DGENV")
   IF cl_null(g_dgenv) THEN
      LET g_dgenv="c"
   END IF

   #20160329 取得TOPIND
   LET g_topind = FGL_GETENV("TOPIND")
   IF cl_null(g_topind) THEN
      LET g_topind = 'sd'
   END IF

   CALL cl_set_combo_industry("dzca007") #20150114
   
   LET g_wc = " 1=1"
   CALL adzi210_browser_fill("")
END FUNCTION
 
 
#+ 選單功能實際執行處
PRIVATE FUNCTION adzi210_ui_dialog()
DEFINE lb_result BOOLEAN  #20160329

   WHILE TRUE
      LET INT_FLAG=0     #20150804   
      CALL adzi210_bp()

      CASE g_action_choice
      WHEN "query"
            CALL adzi210_query()

      WHEN "modify"
            #Begin:160419-00007 新增行業判斷，行業環境不可修改標準資料
            CALL sadzp060_ind_check_modify_permissions(g_dzca_m.dzca007,'u', true) RETURNING lb_result
            IF lb_result THEN
               CALL adzi210_modify()
            END IF
            #End:160419-00007            

      WHEN "insert"
            CALL adzi210_insert()

      WHEN "delete"
            #Begin:160419-00007 新增行業判斷，行業環境不可修改標準資料
            CALL sadzp060_ind_check_modify_permissions(g_dzca_m.dzca007,'d', true) RETURNING lb_result
            IF lb_result THEN
               CALL adzi210_delete()
            END IF
            #End:160419-00007

      WHEN "reproduce"
            CALL adzi210_reproduce()
 
      WHEN "exit"
         EXIT WHILE

      WHEN "bw_first"     
         CALL adzi210_browser_fill("first") 
         
      WHEN "bw_prev" 
         CALL adzi210_browser_fill("prev")
         
      WHEN "bw_next" 
         CALL adzi210_browser_fill("next")
         
      WHEN "bw_last"             
         CALL adzi210_browser_fill("last")

     #20150701 -Bebin-
      WHEN "sql_verify" #sql驗證
         IF g_dzca_m.dzca003 IS NOT NULL THEN
            IF adzi210_sql_verify(g_dzca_m.dzca003,TRUE) THEN
               IF adzi210_chk_cartesian(g_dzca_m.dzca003,TRUE) THEN END IF #160428-00021
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
      WHEN "std_to_cust" #標準轉客製            
         CALL adzi210_std_to_cust() 

      WHEN "cust_to_std" #客製還原標準
         CALL adzi210_cust_to_std() 
     #20150701 -End-
 

      END CASE
      
   END WHILE
   
END FUNCTION
 
 
#+ 功能選單
PRIVATE FUNCTION adzi210_bp()
   DEFINE lb_result   BOOLEAN
   DEFINE ls_err_msg  STRING
   DEFINE l_sql_b    LIKE dzca_t.dzca003
   DEFINE ls_cmd     STRING 
   DEFINE ls_exe_item STRING #2015/04/23 by Hiko
  
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("worksheet",1)
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   CALL adzi210_browser_fill("dialog")

   DISPLAY g_dzca004_info TO s_dzca004_info
   #DISPLAY g_global_var TO s_global_var #20150415 by Hiko
   
   DIALOG ATTRIBUTES(UNBUFFERED)
 
      #左側瀏覽頁簽
      DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
      
         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            #MESSAGE ''     #130201 By benson
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
            
            CALL adzi210_fetch('') # reload data

            #控制上下筆的按鈕是否啟動
            CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            LET g_detail_idx = 1
            CALL adzi210_ui_detailshow() #Setting the current row

            CALL adzi210_set_disable_for_hardcode() #20150701
            
      END DISPLAY
     
      DISPLAY ARRAY g_dzcc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx

            CALL adzi210_ui_detailshow()

      END DISPLAY

      DISPLAY ARRAY g_dzcb_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
      
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx2

            CALL adzi210_ui_detailshow()
            
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
            CALL adzi210_fetch('') # reload data
         END IF

         #控制上下筆的按鈕是否啟動
         CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
         LET g_detail_idx = 1
         CALL adzi210_ui_detailshow() #Setting the current row 
         
         #若無資料則關閉相關功能
         IF g_browser_cnt = 0 THEN
            CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
         ELSE
            CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
         END IF
          
         CALL adzi210_set_disable_for_hardcode() #20150701
         
      #Browser用Action
 
      #一般搜尋
      ON ACTION searchdata
         #取得搜尋關鍵字
         INITIALIZE g_wc TO NULL
         INITIALIZE g_wc2 TO NULL
         
         IF NOT adzi210_browser_search("normal") THEN
            CONTINUE DIALOG
         END IF
         LET g_current_idx = 1
         #EXIT DIALOG


     #ON ACTION verify  #驗證sql 
     #   IF g_dzca_m.dzca003 IS NOT NULL THEN
     #      IF adzi210_sql_verify(g_dzca_m.dzca003,TRUE) THEN
     #         CALL cl_ask_pressanykey('adz-00477')
     #      END IF
     #   ELSE
     #      #CALL FGL_WINMESSAGE("Warn", "The SQL is null!", "stop")           
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.code =  "adz-00022" 
     #      LET g_errparam.extend = NULL
     #      LET g_errparam.popup = TRUE
     #      LET g_errparam.replace[1] =  " SQL is null "
     #      CALL cl_err()
     #   END IF

      #Begin:2015/04/23 by Hiko:改在btn_exe執行
      #ON ACTION generate_qry #產生 動態開窗查詢函式

      #將qry轉成free style #20150701
      #ON ACTION gen_hardcode

      #將qry由標準轉成客製 #20150701
      #ON ACTION std_to_cust
         
      #將qry由客製轉成標準 #20150701
      #ON ACTION cust_to_std
      #End:2015/04/23 by Hiko

      ON ACTION lbl_rebuild_all_qry #重產所有qry
         #20150804 -Modify-
         LET g_rebuild_all_qry = TRUE
        #CALL cl_ask_confirm_parm('adz-00505',"") RETURNING g_compile_flag
         LET ls_err_msg=cl_getmsg('adz-00683',g_lang),ASCII 10,
                        cl_getmsg('adz-00684',g_lang),ASCII 10,
                        cl_getmsg('adz-00685',g_lang),ASCII 10,
                        cl_getmsg('adz-00686',g_lang)
         CALL cl_ask_promp(ls_err_msg) RETURNING g_compile_flag
         IF cl_ask_confirm_parm("adz-00396","") THEN  
            CALL adzi210_rebuild_all_qry()
         END IF
         LET g_rebuild_all_qry = FALSE
         #20150804 -Modify-

      #Bebin: 160428-00021
      ON ACTION lbl_chk_sql_all_qry #驗證所有qry sql
         IF cl_ask_confirm_parm("adz-00396","") THEN  
            CALL adzi210_chk_sql_all_qry()
         END IF
      #End: 160428-00021
       
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
            #DISPLAY "lbl_sql_edit"
           #CALL adzi210_run_prog("r.r","adzi230",g_prog)
            IF adzi210_run_prog("r.r","adzi230",g_prog) THEN END IF
            #CALL sadzi220_sql_sample_edit(g_prog) 

      ON ACTION lbl_sql_builder
         LET ls_cmd = " adzp190 ",g_prog
         CALL cl_cmdrun(ls_cmd)
         
      #Begin:2015/04/23 by Hiko
      ON ACTION btn_exe
         
         #防呆，要選到某筆資料才能往下走
         IF ls_exe_item = "2" THEN
         ELSE
            IF cl_null(g_dzca_m.dzca001) OR cl_null(g_dzca_m.dzca002) THEN
               CALL cl_ask_pressanykey("adz-00564") #請先選取資料
               RETURN
            END IF
         END IF

         CASE ls_exe_item
            WHEN "1" #查詢使用中程式
              #IF cl_ask_confirm_parm("adz-00396","") THEN  
                  CALL adzi210_get_using_list()
              #END IF
            WHEN "2" #查詢可用變數
              #CALL adzi210_run_prog("r.r","adzq221",'')
              IF adzi210_run_prog("r.r","adzq221",'') THEN END IF
            WHEN "3" #重新產生開窗程式
               IF cl_ask_sure() THEN
                  CASE
                    WHEN g_dzca_m.dzca006 = 'Y' 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code =  "adz-00542" #20150701 Hard Code 開窗無法透過r.q(adzi210)自動產生開窗查詢函式。
                       LET g_errparam.extend = NULL
                       LET g_errparam.popup = TRUE
                       LET g_errparam.replace[1] =  ''
                       CALL cl_err()
               
                    WHEN cl_null(g_dzca_m.dzca003) 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code =  "adz-00022"
                       LET g_errparam.extend = NULL
                       LET g_errparam.popup = TRUE
                       LET g_errparam.replace[1] =  " The dzca003 is null "
                       CALL cl_err()
                       
                    OTHERWISE
                       IF adzi210_sql_verify(g_dzca_m.dzca003,TRUE) THEN
                          IF adzi210_arg_verify(g_dzca_m.dzca003)  AND adzi210_column_verify(g_dzca_m.dzca003) THEN
                             #IF g_auto_genqry = 'Y' THEN          #130201 By benson 
                               #LET g_gen42s_flag = TRUE #透過r.q建立qry需要關聯42s
                                LET g_qry_gen_qtotal = "N"  #修改時不需要重新link及gen q_total
                                CALL cl_progress_bar(2)
                                CALL cl_progress_ing("[Message] gen qry")
                                IF NOT sadzp210_generate_qry(g_dzca_m.dzca001) THEN 
                                   CALL cl_progress_bar_close()
                                   INITIALIZE g_errparam TO NULL
                                   LET g_errparam.code = "adz-00125"
                                   LET g_errparam.extend =  g_qry_gen_errmsg
                                   LET g_errparam.popup = TRUE
                                   CALL cl_err()
                                ELSE
                                   CALL cl_progress_ing("[Message] gen qry")
                                   CALL cl_ask_pressanykey('lib-026') #作業結束,請按任何鍵繼續
                                END IF
                             #END IF
                          END IF
                       END IF
                  END CASE
               END IF
            WHEN "4" #sql驗證
               LET g_action_choice="sql_verify"
               EXIT DIALOG
            WHEN "5" #標準轉客製
               LET g_action_choice="std_to_cust"
               EXIT DIALOG 
            WHEN "6" #客製還原標準
               LET g_action_choice="cust_to_std"
               EXIT DIALOG 
         END CASE
      #End:2015/04/23 by Hiko

      #啟動開窗測試工具
      ON ACTION lbl_test_q_prog
         CALL adzi210_test_query_prog(g_dzca_m.dzca001)

      #Begin:2015/04/23 by Hiko
      ##檢查使用中程式 #20140930
      #ON ACTION lbl_get_using_list
      #   IF cl_ask_confirm_parm("adz-00396","") THEN  
      #      CALL adzi210_get_using_list()
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

#+ 啟動開窗測試工具 
PRIVATE FUNCTION adzi210_test_query_prog(ps_call_q_id)
   DEFINE ps_call_q_id   STRING
   DEFINE ls_call_q_id   STRING
   DEFINE l_ch_out       base.Channel
   DEFINE ls_file_path   STRING
   DEFINE lb_chrwx_return LIKE type_t.num5
   DEFINE ls_msg         STRING,                
          l_dzca001      LIKE dzca_t.dzca001,   
          l_dzca002      LIKE dzca_t.dzca002,   
          l_dzca006      LIKE dzca_t.dzca006,   
          lb_have_cust   BOOLEAN,
          li_cnt         LIKE type_t.num5   


   #防呆，要選到某筆資料才能往下走
   IF cl_null(ps_call_q_id) THEN
      CALL cl_ask_pressanykey("adz-00564") #請先選取資料
      RETURN
   END IF

   #確認是否有被客製 -Begin-
   CALL sadzp210_check_qry_have_cust(ps_call_q_id) RETURNING li_cnt,lb_have_cust
   IF li_cnt > 0 THEN
      IF lb_have_cust THEN
         DISPLAY "adzi210_test_query_prog: 此qry已客製"
         LET l_dzca002 = "c"
       ELSE
         LET l_dzca002 = "s"
       END IF
     
     ##20150701:mark掉,hardcode仍然可以被測試
     ###hard-code 無法被測試,離開
     ##LET l_dzca006 = ''
     ##LET l_dzca001 = ps_call_q_id CLIPPED
     ##SELECT dzca006 INTO l_dzca006
     ##   FROM dzca_t WHERE dzca001 = l_dzca001
     ##                 AND dzca002 = l_dzca002
     ##IF l_dzca006 = 'Y' THEN
     ##   LET ls_msg = "Sorry ! This is Hard Code qry, can not use this funciton !"
     ##   DISPLAY ls_msg
     ##   INITIALIZE g_errparam TO NULL
     ##   LET g_errparam.code =  "adz-00022"
     ##   LET g_errparam.EXTEND = NULL
     ##   LET g_errparam.popup = TRUE
     ##   LET g_errparam.replace[1] =  ls_msg
     ##   CALL cl_err() 
     ##   RETURN
     ##END IF

       #標準轉客製時,提示此qry有被客製,將導向客製過的qry
       IF lb_have_cust AND li_cnt > 1  AND g_dzca_m.dzca002='s' THEN
          IF cl_ask_confirm('adz-00403') THEN
          ELSE
             RETURN
          END IF
       END IF
   ELSE
      #沒資料, 離開
      LET ls_msg = "no data in dzca_t"
      DISPLAY ls_msg
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00025"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   #確認是否有被客製 -End-

   
   #要換置呼叫開窗程式的檔案路徑
   LET ls_file_path = os.path.join(os.path.join(FGL_GETENV("COM"),"inc"),"query_prog.4gl")

   #組合呼叫開窗的字串
   LET  ls_call_q_id = "CALL ",ps_call_q_id,"()"

   #置換要呼叫的開窗識別碼 
   LET l_ch_out = base.Channel.create()
   CALL l_ch_out.setDelimiter("%")

   #指定寫入路徑
   CALL l_ch_out.openFile(ls_file_path,"w")

   #指定寫入內容
   CALL l_ch_out.writeLine(ls_call_q_id)

   CALL l_ch_out.close()

   CALL os.Path.chrwx(ls_file_path, 511) RETURNING lb_chrwx_return

   #切換路徑到ADZ模組底下的4gl  
   IF os.Path.chdir(os.path.join(FGL_GETENV("ADZ"),"4gl")) THEN
      IF adzi210_run_prog("r.c","adzp260","") THEN 
         IF adzi210_run_prog("r.l","adzp260","") THEN 
            IF adzi210_run_prog("r.r","azzp191","adzp260 "||g_lang) THEN END IF
            IF adzi210_run_prog("r.r","adzp260",ps_call_q_id) THEN END IF
         END IF
      END IF
   END IF
END FUNCTION

 
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adzi210_browser_search(p_type)
   DEFINE p_type     LIKE type_t.chr10
   DEFINE l_str_buf  base.StringBuffer

   LET l_str_buf = base.StringBuffer.create()
   CALL l_str_buf.append(g_searchstr)
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00005"
      LET g_errparam.extend = "searchcol"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN FALSE 
   END IF 
  
   IF NOT cl_null(g_searchstr) THEN
   
      #解決"_"字元會被SQL當作"%的情況",將其當作跳脫字元來處理
      IF l_str_buf.getIndexOf("_",1) THEN
         CALL l_str_buf.replace("_","#_",0) #將"_"字元前面加入自訂跳脫字元"#"的符號
         LET g_wc = " lower(", g_searchcol, ") LIKE '%", l_str_buf.toString(), "%' escape '#'"#若搜尋的字串含有"_",將其當作跳脫字元
      ELSE
         LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      END IF
      
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1 "
   END IF         
   
   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY dzca001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   #DISPLAY  " g_wc = ", g_wc
    
   CALL adzi210_browser_fill("first")
   CALL ui.Interface.refresh()
   RETURN TRUE
 
END FUNCTION
 
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi210_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE l_num_in_page     LIKE type_t.num5 #每頁筆數
 
   LET l_num_in_page = 30
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzca_m.* TO NULL
   CALL g_dzcc_d.clear()
   CALL g_dzcb_d.clear()   
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "dzca001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()

   #DISPLAY "#############################################"
   #DISPLAY "g_wc = ",g_wc
   #DISPLAY "#############################################"
   #DISPLAY "g_wc2 = ",g_wc2
   
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE dzca001,dzca002 ",
                      " FROM dzca_t ",
                      " INNER JOIN ", 
                          "(SELECT DISTINCT ca1.dzca001 AS dzca001_1,                         ",
                          "       CASE                                                        ", #標準跟客製都有,只顯示客製
                          "         WHEN EXISTS (SELECT 1                                     ",
                          "                 FROM dzca_t ca2                                   ",
                          "                WHERE ca2.dzca001 = ca1.dzca001                    ",
                          "                  AND ca2.dzca002 = 'c') THEN                      ",
                          "          'c'                                                      ",
                          "         ELSE                                                      ",
                          "          's'                                                      ",
                          "       END AS dzca002_1                                            ",
                          "  FROM (SELECT ca0.dzca001, ca0.dzca002 FROM dzca_t ca0) ca1) ca2  ",
                      " ON dzca001 = ca2.dzca001_1 AND dzca002 = ca2.dzca002_1                ",
		      " LEFT JOIN dzcc_t ON dzca001 = dzcc001 AND dzca002 = dzcc009", 
		      " LEFT JOIN dzcb_t ON dzca001 = dzcb001 AND dzca002 = dzcb004",
                      " LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= '",g_lang,"'",
                      " LEFT JOIN dzcbl_t ON dzca001 = dzcbl001 AND dzcbl003= '",g_lang,"'",
                      " WHERE ",l_wc, " AND ", l_wc2    
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE dzca001,dzca002 ",
                      " FROM dzca_t ",
                      " INNER JOIN  ", 
                          "(SELECT DISTINCT ca1.dzca001 AS dzca001_1,                         ",
                          "       CASE                                                        ",
                          "         WHEN EXISTS (SELECT 1                                     ",#標準跟客製都有,只顯示客製
                          "                 FROM dzca_t ca2                                   ",
                          "                WHERE ca2.dzca001 = ca1.dzca001                    ",
                          "                  AND ca2.dzca002 = 'c') THEN                      ",
                          "          'c'                                                      ",
                          "         ELSE                                                      ",
                          "          's'                                                      ",
                          "       END AS dzca002_1                                            ",
                          "  FROM (SELECT ca0.dzca001, ca0.dzca002 FROM dzca_t ca0) ca1) ca2  ",
                      " ON dzca001 = ca2.dzca001_1 AND dzca002 = ca2.dzca002_1                ",
                      " LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= '",g_lang,"'",
                      " WHERE ",l_wc CLIPPED 
   END IF

   #Begin:160419-00007
   #標準環境只能查詢標準資料，行業環境只能查詢標準資料與該行業資料
   IF sadzp060_ind_check_area() THEN 
     LET l_sub_sql = l_sub_sql, " and dzca007 in ('sd','", g_topind ,"') "
   ELSE
     ##標準環境只能看到標準程式，客製環境可以看到標準和所有行業程式
     IF g_dgenv = 's' THEN
        LET l_sub_sql = l_sub_sql, " and dzca007 ='sd' "
     END IF
   END IF
   #End:160419-00007

   #DISPLAY "#############################################"
   #DISPLAY "l_sub_sql = ",l_sub_sql
   
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
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照dzca001,dzcal003 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT dzca001,dzcal003,RANK() OVER(ORDER BY dzca001,dzca002 ",g_order,") AS RANK ,dzca002",
                       " FROM dzca_t ",
                       " INNER JOIN  ", #20150114 調整sql 
                          "(SELECT DISTINCT ca1.dzca001 AS dzca001_1,                        ",
                          "       CASE                                                       ",
                          "         WHEN EXISTS (SELECT 1                                    ",#標準跟客製都有,只顯示客製
                          "                 FROM dzca_t ca2                                  ",
                          "                WHERE ca2.dzca001 = ca1.dzca001                   ",
                          "                  AND ca2.dzca002 = 'c') THEN                     ",
                          "          'c'                                                     ",
                          "         ELSE                                                     ",
                          "          's'                                                     ",
                          "       END AS dzca002_1                                           ",
                          "  FROM (SELECT ca0.dzca001, ca0.dzca002 FROM dzca_t ca0) ca1) ca2 ",
                       " ON dzca001 = ca2.dzca001_1 AND dzca002 = ca2.dzca002_1           ",
         	       " LEFT JOIN dzcc_t ON dzca001 = dzcc001 AND dzca002 = dzcc009", 
		       " LEFT JOIN dzcb_t ON dzca001 = dzcb001 AND dzca002 = dzcb004",
                       " LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= '",g_lang,"'",
                       " LEFT JOIN dzcbl_t ON dzca001 = dzcbl001 AND dzcbl003= '",g_lang,"'",
                       " WHERE ",g_wc," AND ",g_wc2

       #Begin:160419-00007
       #標準環境只能查詢標準資料，行業環境只能查詢標準資料與該行業資料
       IF sadzp060_ind_check_area() THEN
         LET l_sql_rank = l_sql_rank, " and dzca007 in ('sd','" , g_topind , "') "
       ELSE 
         #標準環境只能看到標準程式，客製環境可以看到標準和所有行業程式
         IF g_dgenv = 's' THEN
            LET l_sql_rank = l_sql_rank, " and dzca007 ='sd' "
         END IF
       END IF
       #End:160419-00007

					   
       LET g_sql= "SELECT dzca001,dzcal003,RANK,dzca002 FROM (SELECT dzca001,dzcal003,ROWNUM AS RANK, dzca002 FROM(",l_sql_rank,")) WHERE RANK>=",g_pagestart,
           " AND RANK<",g_pagestart+l_num_in_page,
           " ORDER BY ",l_searchcol," ",g_order
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT dzca001,dzcal003,RANK() OVER(ORDER BY dzca001 ",g_order,") AS RANK, dzca002",
                       " FROM dzca_t ",
                       " INNER JOIN  ",
                          "(SELECT DISTINCT ca1.dzca001 AS dzca001_1,                        ",
                          "       CASE                                                       ",
                          "         WHEN EXISTS (SELECT 1                                    ",#標準跟客製都有,只顯示客製
                          "                 FROM dzca_t ca2                                  ",
                          "                WHERE ca2.dzca001 = ca1.dzca001                   ",
                          "                  AND ca2.dzca002 = 'c') THEN                     ",
                          "          'c'                                                     ",
                          "         ELSE                                                     ",
                          "          's'                                                     ",
                          "       END AS dzca002_1                                           ",
                          "  FROM (SELECT ca0.dzca001, ca0.dzca002 FROM dzca_t ca0) ca1) ca2 ",
                       " ON dzca001 = ca2.dzca001_1 AND dzca002 = ca2.dzca002_1              ",
                       " LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= '",g_lang,"'",
                       " WHERE  ", g_wc

      #Begin:160419-00007
      #標準環境只能查詢標準資料，行業環境只能查詢標準資料與該行業資料
      IF sadzp060_ind_check_area() THEN
        LET l_sql_rank = l_sql_rank, " and dzca007 in ('sd','", g_topind ,"') "
      ELSE
        #標準環境只能看到標準程式，客製環境可以看到標準和所有行業程式
        IF g_dgenv = 's' THEN
           LET l_sql_rank = l_sql_rank, " and dzca007 ='sd' "
        END IF
      END IF
      #End:160419-00007
					   
      LET g_sql= "SELECT dzca001,dzcal003,RANK,dzca002 FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
           " AND RANK<",g_pagestart+l_num_in_page,
           " ORDER BY ",l_searchcol," ",g_order
   END IF
   

   #定義翻頁CURSOR          
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   
  #FOREACH browse_cur INTO g_browser[g_cnt].b_dzca001,g_browser[g_cnt].b_dzcal003    
   FOREACH browse_cur INTO g_browser[g_cnt].b_dzca001,g_browser[g_cnt].b_dzcal003, g_browser[g_cnt].rank, g_browser[g_cnt].b_dzca002 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #SELECT dzcal003 INTO g_browser[g_cnt].b_dzcal003 FROM dzcal_t WHERE dzcal001 = g_browser[g_cnt].b_dzca001 AND dzcal002 = g_lang
         #DISPLAY "g_browser[g_cnt].b_dzcal003 = ",g_browser[g_cnt].b_dzcal003

	  
      #LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic)#忽略狀態碼 
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
PRIVATE FUNCTION adzi210_ui_headershow()
   LET g_dzca_m.dzca001 = g_browser[g_current_idx].b_dzca001
   LET g_dzca_m.dzca002 = g_browser[g_current_idx].b_dzca002 
 
   #20140314:madey
   SELECT UNIQUE dzca001,dzcal003,dzca002,dzca006,dzca003,dzca004,dzca005,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008
      INTO g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008
      FROM dzca_t
      LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= g_lang
      WHERE dzca001 = g_dzca_m.dzca001 AND dzca002 = g_dzca_m.dzca002

   CALL adzi210_show()
   
END FUNCTION
 
 
#+ 單身資料重新顯示
PRIVATE FUNCTION adzi210_ui_detailshow()

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
END FUNCTION
 
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi210_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzca001 = g_dzca_m.dzca001 AND 
         g_browser[l_i].b_dzca002 = g_dzca_m.dzca002 
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
PRIVATE FUNCTION adzi210_construct()

   DEFINE lc_qbe_sn   LIKE type_t.num10

   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzca_m.* TO NULL
   CALL g_dzcc_d.clear()
   CALL g_dzcb_d.clear()   
 
   
   LET g_current_idx = 1
   LET g_action_choice = ""

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc_table1 TO NULL
   INITIALIZE g_wc_table2 TO NULL
    
   LET g_qryparam.state = 'c'

   DISPLAY g_dzca004_info TO s_dzca004_info
   #DISPLAY g_global_var TO s_global_var #20150415 by Hiko
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED)
      
      #單頭
      CONSTRUCT g_wc ON dzca001,dzcal003,dzca002,dzca006,dzca003,dzca004,dzca005,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008
         FROM dzca_t.dzca001,dzcal_t.dzcal003,dzca_t.dzca002,dzca_t.dzca006,dzca_t.dzca003,dzca_t.dzca004,dzca_t.dzca005,dzca_t.dzcamodid,dzca_t.dzcamoddt,dzca_t.dzcaownid,dzca_t.dzcaowndp,dzca_t.dzcacrtid,dzca_t.dzcacrtdp,dzca_t.dzcacrtdt,dzca_t.dzca007,dzca_t.dzca008

         ON ACTION update_item INFIELD dzcal003
            ### 用於開窗識別碼的模糊查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzcal003( )
            LET g_dzca_m.dzcal003 = g_qryparam.return1
            DISPLAY g_dzca_m.dzcal003 TO dzcal_t.dzcal003
            ### 用於開窗識別碼的模糊查詢### end ###

         
         BEFORE CONSTRUCT
            CALL adzi210_set_disable_for_hardcode() #20150701
  
      END CONSTRUCT
 
      #單身可以混搭多頁簽
      CONSTRUCT g_wc_table1 ON dzcc002,dzcc003,dzcc004,dzcc005,dzcc006,dzcc007,dzcc010,dzcc008
         FROM s_detail1[1].dzcc002,s_detail1[1].dzcc003,s_detail1[1].dzcc004,s_detail1[1].dzcc005,s_detail1[1].dzcc006,s_detail1[1].dzcc007,s_detail1[1].dzcc010,s_detail1[1].dzcc008
 
                      
         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)
         
         --<<dzcc003>>----
         ON ACTION controlp INFIELD dzcc003
            ### 開窗設計器欄位代號### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzeb002( )
            LET g_dzcc_d[1].dzcc003 = g_qryparam.return1
            DISPLAY g_dzcc_d[1].dzcc003 TO s_detail1[1].dzcc003
            ### 開窗設計器欄位代號### end ###

         
      END CONSTRUCT


     #單身可以混搭多頁簽
      CONSTRUCT g_wc_table2 ON dzcb002,dzcb003,dzcbl004
         FROM s_detail2[1].dzcb002,s_detail2[1].dzcb003,s_detail2[1].dzcbl004
 
         BEFORE CONSTRUCT
          #  CALL cl_qbe_display_condition(lc_qbe_sn)

         ON ACTION update_item INFIELD dzcbl004
            ### 用於開窗識別碼的模糊查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = TRUE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzcbl004( )
            LET g_dzcb_d[1].dzcbl004 = g_qryparam.return1
            DISPLAY g_dzcb_d[1].dzcbl004 TO s_detail2[1].dzcbl004
            ### 用於開窗識別碼的模糊查詢### end ###

 
      END CONSTRUCT

      AFTER DIALOG
         #DISPLAY "@@@@@@@@@@@@@@@@@@@"
         #DISPLAY "g_wc = ",g_wc
      
      ON ACTION qbe_select     #條件查詢
         #CALL cl_qbe_list() RETURNING lc_qbe_sn
         #CALL cl_qbe_display_condition(lc_qbe_sn)
 
      ON ACTION qbe_save       #條件儲存
        # CALL cl_qbe_save() cch: saki修改中,先mark
 
      ON ACTION accept
         LET INT_FLAG = 0            #20150804
         #DISPLAY "g_wc = ",g_wc
         #DISPLAY "g_wc2 = ",g_wc2
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
   END DIALOG

   #DISPLAY "g_wc = ",g_wc
   #DISPLAY "g_wc2 = ",g_wc2
   
   #組合g_wc2
   LET g_wc2 = g_wc_table1
   IF g_wc_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc_table2
   END IF
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
 
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi210_query()
  
   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   #MESSAGE ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_dzcc_d.clear()
   CALL g_dzcb_d.clear()
   CALL g_logc.clear() 
 
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   
   CALL adzi210_construct()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_dzca_m.* TO NULL
      RETURN
   END IF
 
   CALL adzi210_browser_fill("first")
 
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi210_fetch(p_flag)
   {<Local define>}
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
   IF cl_null(g_browser[g_current_idx].b_dzca001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF   
   
   #CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引 #20150415 by Hiko
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
   
   LET g_dzca_m.dzca001 = g_browser[g_current_idx].b_dzca001
   LET g_dzca_m.dzca002 = g_browser[g_current_idx].b_dzca002
 
   
   #重讀DB,因TEMP有不被更新特性
 SELECT UNIQUE dzca001,dzcal003,dzca002,dzca006,dzca003,dzca004,dzca005,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008
 INTO g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008
 FROM dzca_t
 LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= g_lang
 WHERE dzca001 = g_dzca_m.dzca001 
   AND dzca002 = g_dzca_m.dzca002
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "lib-00103"
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = ""
       LET g_errparam.replace[2] ="dzca_t"
       LET g_errparam.extend = ""
       LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
       CALL cl_err()
       INITIALIZE g_dzca_m.* TO NULL
       RETURN
   END IF
   
   LET g_data_owner = g_dzca_m.dzcacrtid      
   LET g_data_group = g_dzca_m.dzcacrtdp  
   
   #重新顯示   
   CALL adzi210_show()
 
END FUNCTION
 
 
#+ 資料新增
PRIVATE FUNCTION adzi210_insert()
  
   CLEAR FORM                    #清畫面欄位內容
   CALL g_dzcc_d.clear()    #清除陣列
   CALL g_dzcb_d.clear()    #清除陣列
 
   INITIALIZE g_dzca_m.* LIKE dzca_t.*             #DEFAULT 設定
   LET g_dzca001_t = NULL
   LET g_dzca002_t = NULL 
 
 
   WHILE TRUE

      #一般欄位給值
      LET g_dzca_m.dzcacrtid = g_user
      LET g_dzca_m.dzcacrtdp = g_dept
      LET g_dzca_m.dzcacrtdt = cl_get_current()
      LET g_dzca_m.dzcaownid = g_user 
      LET g_dzca_m.dzcaowndp = g_dept 
      LET g_dzca_m.dzcamodid = g_user
      LET g_dzca_m.dzcamoddt = cl_get_current()
      #LET g_dzca_m.dzcastus = 'Y'#忽略狀態碼 
      #Begin:160419-00007 (行業別)標準：sd、行業：該行業代號 (ex:ph)
      #IF sadzp060_ind_check_area() THEN 
      #   LET g_dzca_m.dzca007 = g_topind
      #ELSE
      #   LET g_dzca_m.dzca007   = 'sd' 
      #END IF
      LET g_dzca_m.dzca007 = g_topind
      #End:160419-00007
      LET g_dzca_m.dzca006   = 'N' #20150701
      
     
      #單頭預設值
      INITIALIZE g_dzca_m_t TO NULL #新增時本來就不該有舊值 #160707-00013
      
      BEGIN WORK #20150415 by Hiko
      CALL adzi210_input("a")
      
      IF INT_FLAG OR SQLCA.SQLCODE OR STATUS THEN #2015/06/16 by Hiko:增加SQLCA.SQLCODE OR STATUS的條件
          LET INT_FLAG = 0
          LET g_dzca_m.* = g_dzca_m_t.*
          CALL adzi210_show()
          ROLLBACK WORK #20150415 by Hiko
          EXIT WHILE
      END IF
      
      COMMIT WORK #20150415 by Hiko

      #Begin:2015/06/16 by Hiko:產生4gl/4fd的動作從adzi210_input改放在這邊.
     #LET g_gen42s_flag = TRUE #20140903:透過r.q建立qry需要關聯42s
      LET g_qry_gen_qtotal = "Y"
      CALL cl_progress_bar(2) #20141230
     #CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
      CALL cl_progress_ing("[Message] gen qry、link qry")
      
      IF NOT sadzp210_generate_qry(g_dzca_m.dzca001) THEN #20140710:madey
         CALL cl_progress_bar_close() #20141230
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00125"
         LET g_errparam.extend = g_qry_gen_errmsg
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
        #CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
         CALL cl_progress_ing("[Message] gen qry、link qry")
      END IF
      #End:2015/06/16 by Hiko

      CALL g_dzcc_d.clear()
      CALL g_dzcb_d.clear()
 
      LET g_rec_b = 0
      EXIT WHILE
        
   END WHILE
   
END FUNCTION
 
 
#+ 資料修改
PRIVATE FUNCTION adzi210_modify()
   
   IF cl_null(g_dzca_m.dzca001) OR cl_null(g_dzca_m.dzca002) 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   SELECT UNIQUE dzca001,dzcal003,dzca002,dzca006,dzca003,dzca004,dzca005,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008
     INTO g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008
     FROM dzca_t
     LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= g_lang
     WHERE dzca001 = g_dzca_m.dzca001 
       AND dzca002 = g_dzca_m.dzca002
 

   #20150804 -Begin-
   #topstd帳號不允許異動客製資料
   IF g_account="topstd" AND g_dzca_m_t.dzca002 = "c" THEN
      CALL cl_ask_pressanykey("adz-00676") 
      RETURN
   END IF
   #20150804 -End-

   #客製環境下不允許修改標準qry,提示僅能執行"標準轉客製功能"後才能修改
   IF g_dgenv = "c" AND g_dzca_m_t.dzca002 = "s" THEN
      CALL cl_ask_pressanykey("adz-00402")
      RETURN
   END IF

   #hard code qry無法透過r.q刪除,或是變更成N, 只能刪掉重來,不然整個程序控制會很複雜
   IF g_god_mode THEN
     #不擋
   ELSE
      IF g_dzca_m.dzca006 = 'Y' THEN
         #不允許這樣操作
         CALL cl_ask_pressanykey("adz-00532") #已轉Hard Code的開窗無法修改
         RETURN
      END IF
   END IF

   LET g_dzca001_t = g_dzca_m.dzca001
   LET g_dzca002_t = g_dzca_m.dzca002
  
   #Begin:2015/04/23 by Hiko
   IF NOT adzi210_chk_using('u') THEN
      RETURN
   END IF

   BEGIN WORK
   
   WHILE TRUE
      LET g_dzca001_t = g_dzca_m.dzca001
      LET g_dzca002_t = g_dzca_m.dzca002
 
      LET g_dzca_m.dzcamodid = g_user
      LET g_dzca_m.dzcamoddt = cl_get_current()
 
      CALL adzi210_input("u")     #欄位更改
 
      IF INT_FLAG OR SQLCA.SQLCODE OR STATUS THEN #2015/06/16 by Hiko:增加SQLCA.SQLCODE OR STATUS的條件
         #LET INT_FLAG = 0
          LET g_dzca_m.* = g_dzca_m_t.*
          CALL adzi210_show()
         #CALL cl_err('',9001,0)  #130201 By benson
          EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_dzca_m.dzca001 != g_dzca001_t OR g_dzca_m.dzca002 != g_dzca002_t THEN 

         #更新單頭key值
         UPDATE dzca_t SET dzca001 = g_dzca_m.dzca001, dzca002 = g_dzca_m.dzca002
          WHERE  dzca001 = g_dzca001_t AND dzca002 = g_dzca002_t 

         UPDATE dzcal_t SET dzcal001 = g_dzca_m.dzca001
            WHERE  dzcal001 = g_dzca001_t
         
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = "lib-00101"
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = g_dzca001_t
             LET g_errparam.replace[2] ="dzca_t"
             LET g_errparam.extend = ""
             LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
             CALL cl_err()
             #ROLLBACK WORK #2015/06/16 by Hiko
             CONTINUE WHILE
         END IF
         
         #更新單身key值
         UPDATE dzcc_t SET dzcc001 = g_dzca_m.dzca001 , dzcc009 = g_dzca_m.dzca002
          WHERE  dzcc001 = g_dzca001_t AND dzcc009 = g_dzca002_t
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = "lib-00101"
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = g_dzca001_t
             LET g_errparam.replace[2] ="dzcc_t"
             LET g_errparam.extend = ""
             LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
             CALL cl_err()
             #ROLLBACK WORK #2015/06/16 by Hiko
             CONTINUE WHILE
         END IF

         #130201 By benson --- S
         #更新單身key值
         UPDATE dzcb_t SET dzcb001 = g_dzca_m.dzca001, dzcb004 = g_dzca_m.dzca002
            WHERE  dzcb001 = g_dzca001_t AND dzcb004 = g_dzca002_t 

         UPDATE dzcbl_t SET dzcbl001 = g_dzca_m.dzca001
            WHERE  dzcbl001 = g_dzca001_t
          
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = "lib-00101"
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = g_dzca001_t
             LET g_errparam.replace[2] ="dzcb_t"
             LET g_errparam.extend = ""
             LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
             CALL cl_err()
             #ROLLBACK WORK #2015/06/16 by Hiko
             CONTINUE WHILE
         END IF
         #130201 By benson --- E
         
         #COMMIT WORK #2015/06/16 by Hiko:整批COMMIT就不用在這邊COMMIT
         
      END IF
      
      EXIT WHILE
   END WHILE
 

   IF INT_FLAG OR SQLCA.SQLCODE OR STATUS THEN #2015/06/16 by Hiko:增加SQLCA.SQLCODE OR STATUS的條件
      ROLLBACK WORK #20150415 by Hiko
   ELSE
      COMMIT WORK

      #Begin:2015/06/16 by Hiko:產生4gl/4fd的動作從adzi210_input改放在這邊.
     #LET g_gen42s_flag = TRUE #20140903:透過r.q建立qry需要關聯42s
      LET g_qry_gen_qtotal = "N"
      CALL cl_progress_bar(2) #20141230
     #CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
      CALL cl_progress_ing("[Message] gen qry、link qry")
      
      IF NOT sadzp210_generate_qry(g_dzca_m.dzca001) THEN #20140710:madey
         CALL cl_progress_bar_close() #20141230
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00125"
         LET g_errparam.extend = g_qry_gen_errmsg
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
        #CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
         CALL cl_progress_ing("[Message] gen qry、link qry")
      END IF
      #End:2015/06/16 by Hiko
   END IF
 
   CALL adzi210_b_fill("1=1")
   
END FUNCTION   
 
#+ 資料輸入
PRIVATE FUNCTION adzi210_input(p_cmd)
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1                #單身的狀態
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
   DEFINE  l_global_var    LIKE type_t.chr10                #可以使用的公用變數
   DEFINE  l_result        LIKE type_t.chr1
   DEFINE  l_flag          BOOLEAN
   DEFINE  ls_dzca001      STRING                          #暫存dzca001的字串
   DEFINE  ls_dzca007      STRING                          #暫存dzca007的字串 20150114
   DEFINE  ls_return       STRING                          #130201 By benson  
   DEFINE  l_detail_cnt    LIKE type_t.num5                #130201 By benson  
   DEFINE  l_dzcc003       LIKE type_t.chr20               #130201 By benson 
   DEFINE  l_sql_sample_o  LIKE type_t.chr1                #130201 By benson 
   DEFINE  lo_Combobox     ui.ComboBox
   DEFINE  l_dzep011       LIKE dzep_t.dzep011
   DEFINE  l_prog_name     LIKE type_t.chr100
   DEFINE  l_sql_b         LIKE dzca_t.dzca003
   DEFINE  ls_cmd          STRING 
   DEFINE  li_dzaf_cnt     LIKE type_t.num5                #20150701
   DEFINE  li_dzax_cnt     LIKE type_t.num5                #20150701
   DEFINE  lb_recover      BOOLEAN                         #20150701
   DEFINE  ls_dzeb022_condition STRING                     #20150804
   DEFINE  ls_sql          STRING                          #20150804
   DEFINE  ls_where        STRING                          #20150804
   DEFINE  l_table         LIKE dzep_t.dzep001             #20151005

   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
   LET g_qryparam.state = 'i'

 
   DISPLAY BY NAME g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,
                   g_dzca_m.dzcaownid,g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008

   DISPLAY g_dzca004_info TO s_dzca004_info
   #DISPLAY g_global_var TO s_global_var #20150415 by Hiko
   
   DIALOG ATTRIBUTE(UNBUFFERED)

      #單頭段
      INPUT BY NAME g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca002,g_dzca_m.dzca006,l_sql_sample,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,
                    g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,g_dzca_m.dzcaowndp,
                    g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL adzi210_set_entry(p_cmd)
            CALL adzi210_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE
            #130201 By benson --- S
            #維護狀態時，不讓使用者再去更改l_sql_sample的資料
            IF p_cmd = 'a' THEN
               IF cl_null(g_dzca_m.dzca006) THEN 
                  LET g_dzca_m.dzca006 = 'N'
               END IF

               #標準環境下:預設dzca002=s
               #客製環境下:預設dzca002=c
               IF g_dgenv = "s" THEN
                  IF cl_null(g_dzca_m.dzca002) THEN 
                     LET g_dzca_m.dzca002 = "s"
                  END IF
               ELSE
                  LET g_dzca_m.dzca002 = "c"
               END IF
			   
               IF cl_null(l_sql_sample) THEN 
                  LET l_sql_sample = "9"
                  LET l_sql_sample_o = "9"
                  CALL adzi210_sql_sample(p_cmd, l_sql_sample,l_sql_sample_o)
                  LET g_dzca_m_t.dzca003 = g_dzca_m.dzca003
               END IF
               CALL DIALOG.setFieldActive("l_sql_sample",1)
            ELSE
               CALL DIALOG.setFieldActive("l_sql_sample",0)
            END IF
            #130201 By benson --- E

            CALL adzi210_set_disable_for_hardcode() #20150701
   
           ##客製環境下 & 修改模式下 & 標準qry : 可以被打勾
           #IF p_cmd = 'u' AND g_dgenv = 'c' AND g_dzca_m.dzca002 = 's' THEN
           #   CALL cl_set_comp_entry("dzca002",TRUE) 
           #END IF
          
            #---------------------------<  Master  >---------------------------
         #----<<dzca001>>----
         BEFORE FIELD dzca001
 

         AFTER FIELD dzca001

            #Key值不為空值時,才進行Key值重覆性檢查
            IF g_dzca_m.dzca001 IS NOT NULL THEN 
               IF g_dzca_m.dzca001 != g_dzca_m_t.dzca001 OR g_dzca_m_t.dzca001 IS NULL THEN   #130201 By TSD.benson
                  LET ls_dzca001 =  g_dzca_m.dzca001 
                  LET ls_dzca007 =  g_dzca_m.dzca007 
                  IF NOT adzi210_chk_dzca001(ls_dzca001,ls_dzca007) THEN 
                     LET g_dzca_m.dzca001 = g_dzca001_t
                     NEXT FIELD dzca001
                  END IF    
               END IF
          
               #如果為新輸入或更改Key,則檢查重覆性
               IF p_cmd = "a" OR (p_cmd = "u" AND g_dzca_m.dzca001 != g_dzca001_t) THEN

                  #[檢查輸入字串是否符合格式]
                  #N: Numeric 0123456789
                  #U: 大寫的 A-Z
                  #L:  小寫的 a-z
                  #_:  底線 underline
                  #若檢查NL_,則檢查字串是否只包含數字,小寫的 a-z,底斜線
                  IF  NOT cl_chk_num(g_dzca_m.dzca001,"NL_") THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00130"
                     LET g_errparam.extend = g_dzca_m.dzca001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD dzca001
                  END IF
                 #Begin: 160707-00013 modify     
                 #SELECT COUNT(*) INTO l_n FROM dzca_t WHERE dzca001 = g_dzca_m.dzca001
                 #      	                         AND dzca002 = g_dzca_m.dzca002 
                 #IF l_n > 0 THEN
                 #   LET g_dzca_m.dzca001 = g_dzca001_t
                 #   LET g_dzca_m.dzca002 = g_dzca002_t 
                 #   DISPLAY BY NAME g_dzca_m.dzca001,g_dzca_m.dzca002
                 #   NEXT FIELD dzca001
                 #END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzca_t WHERE "||"dzca001 = '"||g_dzca_m.dzca001 ||"'",'std-00004',0) THEN
                     NEXT FIELD dzca001
                  END IF
                 #End: 160707-00013 modify     
                  
               END IF
            END IF

         AFTER FIELD dzca007
            IF NOT cl_null(g_dzca_m.dzca001) THEN
              IF NOT adzi210_chk_dzca001(g_dzca_m.dzca001,g_dzca_m.dzca007) THEN 
                 NEXT FIELD dzca001
              END IF
            END IF

         #ON ACTION btn_add_sql
            ##雛型開發階段,目前先限制新增可以選SQL type,細節部份之後再詳做
            #IF p_cmd = "a" THEN
            #   LET l_sql = "SELECT <FIELD_NAME> ", ASCII 10, 
            #               "  FROM TABLE_NAME ", ASCII 10,  
            #               "  WHERE WC ",  ASCII 10, 
            #               "ORDER BY FIELD_LIST "
            #   LET g_dzca_m.dzca003 = l_sql
            #END IF
         ON CHANGE l_sql_sample    #2013/01/29 by Hiko
            CALL adzi210_sql_sample(p_cmd, l_sql_sample,l_sql_sample_o)
            DISPLAY BY NAME g_dzca_m.dzca003

            #130221 By benson --- S
            #有維護欄位時，才呼叫同步下面sql語句的field欄位
            IF g_dzcc_d.getLength() > 0 THEN
               IF NOT cl_null(g_dzcc_d[1].dzcc002) THEN
                  CALL adzi210_dzca003_field_list_replace()
               END IF
            END IF

            IF g_dzca_m_t.dzca003 != g_dzca_m.dzca003 THEN
               LET l_sql_sample_o = l_sql_sample
               LET g_dzca_m_t.dzca003 = g_dzca_m.dzca003
            ELSE 
               LET l_sql_sample = l_sql_sample_o
            END IF
            #130221 By benson --- E

         #----<<dzcal003>>----
         BEFORE FIELD dzcal003
 
         AFTER FIELD dzcal003
             #20150113 -Begin-
             IF NOT cl_null(g_dzca_m.dzcal003) THEN
                IF NOT cl_chk_tworcn(g_lang,g_dzca_m.dzcal003,20) THEN
                   NEXT FIELD dzcal003
                END IF
             END IF 
             #20150113 -End-

         #----<<dzca006>>----
         BEFORE FIELD dzca006

         ON CHANGE dzca006

         ##20150701: -Begin-
          #修改模式下:
          #     若由N變Y,則提示:勾選Hard Code後，此開窗必須透過下載程式(adzp050)簽出規格及程式，並透過設計器開發，請問是否確定?
          #     不允許由Y變N, 前面擋
          IF p_cmd = "u"  THEN
            #LET lb_recover = FALSE #還原

            ##由N變Y
            #IF g_dzca_m.dzca006 = 'Y' AND g_dzca_m_t.dzca006 = 'N' THEN
            #   IF cl_ask_confirm_parm("adz-00531","") THEN  
            #      #do nothing
            #   ELSE 
            #     LET lb_recover = TRUE #還原
            #   END IF
            #END IF

            #IF lb_recover THEN
            #   LET g_dzca_m.dzca006 = g_dzca_m_t.dzca006
            #   DISPLAY BY NAME g_dzca_m.dzca006
            #END IF

            IF g_dzca_m.dzca006 = 'Y' AND g_dzca_m_t.dzca006 = 'N' THEN
               CALL cl_ask_pressanykey('adz-00531') 
            END IF
          
          END IF
          #20150701: -End-

          CALL adzi210_set_disable_for_hardcode() 

         AFTER FIELD dzca006
         #20140314:madey -end-


         AFTER FIELD dzca008 #20151005
           IF g_dzca_m.dzca008 = 'Y' THEN
              CALL cl_ask_pressanykey('adz-00716') 
           END IF

         ON ACTION update_item INFIELD dzcal003
                IF  NOT cl_null(g_dzca_m.dzca001) THEN
                  CALL n_dzcal(g_dzca_m.dzca001) 
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_dzca_m.dzca001
                  CALL ap_ref_array2(g_ref_fields," SELECT dzcal003 FROM dzcal_t WHERE dzcal001 = ? AND dzcal002 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_dzca_m.dzcal003 = g_rtn_fields[1]
                  DISPLAY BY NAME g_dzca_m.dzcal003
               END IF 

         ON ACTION controlp INFIELD dzca005
            ### 程式代號查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            CALL q_gzzz001_5()
            LET g_dzca_m.dzca005 = g_qryparam.return1
            LET l_prog_name = g_qryparam.return2
            DISPLAY BY NAME g_dzca_m.dzca005
            DISPLAY l_prog_name TO s_dzca005
            ### 程式代號查詢### end ###


         #----<<dzca003>>----
         BEFORE FIELD dzca003
            IF g_dzcc_d.getLength() > 0 THEN
               IF NOT cl_null(g_dzcc_d[1].dzcc002) THEN
                  CALL adzi210_dzca003_field_list_replace()
               END IF
            END IF

             

         AFTER FIELD dzca004
            IF NOT cl_null(g_dzca_m.dzca004) THEN
               IF g_dzca_m.dzca004 < 10 THEN
                  LET g_dzca_m.dzca004 = 10
               END IF
            END IF

         AFTER FIELD dzca005
            IF NOT cl_null(g_dzca_m.dzca005) THEN
	       SELECT COUNT(1) INTO l_cnt FROM gzzz_t 
		WHERE gzzz001=g_dzca_m.dzca005 AND gzzzstus = 'Y'  		
    
               # IF NOT sadzp168_1_prog_chk(g_dzca_m.dzca005,"M") THEN
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00050"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzca_m.dzca005
                  CALL cl_err()
                  NEXT FIELD dzca005
               ELSE

                  SELECT DISTINCT gzzal003 INTO l_prog_name
                    FROM gzzz_t 
                    LEFT JOIN gzzal_t ON gzzz001 = gzzal001 AND gzzal002 = g_lang
                    WHERE gzzz001 = g_dzca_m.dzca005
  
                  DISPLAY l_prog_name TO s_dzca005
               END IF
            END IF

 
         #Begin:2015/04/01 by Hiko
         #BEFORE FIELD l_sql_sample
         #   LET lo_Combobox = ui.ComboBox.forName("formonly.l_sql_sample")
         #   CALL adzi210_fill_combobox(lo_Combobox,ms_SQL_Sample)
         #End:2015/04/01 by Hiko
         #欄位檢查
         AFTER INPUT
            #DISPLAY "Hiko:AFTER INPUT"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            DISPLAY BY NAME g_dzca_m.dzca001,g_dzca_m.dzca002
 
         #controlp

      END INPUT
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzcc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
        #自訂ACTION
        #AFTER INPUT
        #   DISPLAY "Hiko : s_detail1 AFTER INPUT"
        #   #henry:確保單身的AFTER INPUT時一定是修改狀態'u'，避免單頭發生錯誤
        #   LET p_cmd = 'u'
        #   CALL adzi210_dzca003_field_list_replace()

         AFTER INPUT
            #檢查回傳值的勾選是否大於10的
            LET l_cnt = 0
            FOR l_i = 1 TO g_dzcc_d.getLength()
               IF g_dzcc_d[l_i ].dzcc005 = "Y" THEN
                  LET l_cnt = l_cnt +1
               END IF
            END FOR
            IF l_cnt > 10 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00022"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  " The number of return value must be <= 10"
               CALL cl_err()
               NEXT FIELD dzcc005
            END IF

         
         BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_before_input_done = FALSE  
            LET g_before_input_done = TRUE
            #LET g_dzcc_d_t.* = g_dzcc_d[l_ac].*  #BACKUP

         BEFORE ROW
            LET l_insert = FALSE
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_dzcc_d_t.* = g_dzcc_d[l_ac].*     #新輸入資料

           #DISPLAY "g_rec_b = ",g_rec_b
           #DISPLAY "l_ac = ",l_ac
        
         BEFORE INSERT
           #DISPLAY "dzcc_t BEFORE INSERT"
            
            #henry:當"新增"狀態時,沒有鍵盤需輸入時,此判斷用來觸發AFTER INSERT_to do
            #IF l_flag = TRUE THEN
               #LET l_flag = FALSE
               #CALL FGL_DIALOG_SETCURRLINE( l_ac-1, l_ac-1 )
            #END IF
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            INITIALIZE g_dzcc_d[l_ac].* TO NULL
            LET g_dzcc_d[l_ac].dzcc002 = adzi210_max_value()    #130201 By benson 
            LET g_dzcc_d_t.* = g_dzcc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzi210_set_entry_b()
            CALL adzi210_set_no_entry_b()
            

         AFTER INSERT
            #DISPLAY "dzcc_t AFTER INSERT"
            #DISPLAY "p_cmd =",p_cmd

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
            IF NOT cl_null(g_dzcc_d_t.dzcc002) THEN
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
               LET l_count = g_dzcc_d.getLength()
            END IF 
              
         AFTER DELETE
            #DISPLAY "AFTER DELETE "
            CALL adzi210_delete_b(l_count)
            CALL adzi210_dzca003_field_list_replace()
 
          #---------------------<  Detail: page     1  >---------------------
         #----<<dzcc002>>----
         BEFORE FIELD dzcc002
 
         AFTER FIELD dzcc002
            #130201 By benson --- S
            #檢查欄位順序代碼是否重複
            IF NOT cl_null(g_dzca_m.dzca001) AND NOT cl_null(g_dzcc_d[l_ac].dzcc002)  THEN 
               IF  p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dzca_m.dzca001 != g_dzca001_t  OR g_dzcc_d[l_ac].dzcc002 != g_dzcc_d_t.dzcc002)) THEN 
                  CALL adzi210_chk_dzcc002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_dzcc_d[l_ac].dzcc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_dzcc_d[l_ac].dzcc002 = g_dzcc_d_t.dzcc002
                     NEXT FIELD dzcc002
                  END IF
               END IF
            END IF

            #改變順序後，動態更改下方SQL的欄位順序
            IF g_dzcc_d.getLength() > 0 THEN
               IF NOT cl_null(g_dzcc_d[1].dzcc003) THEN
                  CALL adzi210_dzca003_field_list_replace() #當滑鼠直接移到dzca003 這個欄位
               END IF
            END IF
            #130201 By benson --- E

         #----<<dzcc003>>----
         BEFORE FIELD dzcc003
 
         AFTER FIELD dzcc003
           #DISPLAY "AFTER FIELD  dzcc003"
             
            #檢查輸入之欄位代碼資料是否已建立
            IF g_dzcc_d[l_ac].dzcc003 IS NOT NULL THEN 
               LET ls_sql = "SELECT COUNT(*) FROM dzeb_t"
               LET ls_where = " WHERE dzeb002 ='",g_dzcc_d[l_ac].dzcc003 CLIPPED,"'"
               LET ls_sql= ls_sql,ls_where
               LET l_n=0
               PREPARE dzeb_cnt_pre1 FROM ls_sql  
               EXECUTE dzeb_cnt_pre1 INTO l_n
               FREE dzeb_cnt_pre1
               IF l_n = 0 THEN
                  #CALL FGL_WINMESSAGE("Error", "Field code not found!", "stop") 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = -100
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD dzcc003 
               END IF

               #20150804 -Begin-
               #標準環境下，不能挑選自定義欄位
               IF g_dgenv="s" THEN
                  LET ls_dzeb022_condition= " AND dzeb022 NOT LIKE '%cdfUserDefine%'"
                  LET ls_sql = ls_sql,ls_dzeb022_condition
                  LET l_n=0
                  PREPARE dzeb_cnt_pre2 FROM ls_sql  
                  EXECUTE dzeb_cnt_pre2 INTO l_n
                  FREE dzeb_cnt_pre2
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "adz-00670"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD dzcc003 
                  END IF
               END IF
               #20150804 -End-
               
               IF g_dzcc_d[l_ac].dzcc003 != g_dzcc_d_t.dzcc003 OR g_dzcc_d_t.dzcc003 IS NULL THEN

                  #CALL adzi210_chk_dzcc003()#檢查欄位資料是否重複
                  #IF NOT cl_null(g_errno) THEN
                     #CALL cl_err(g_dzcc_d[l_ac].dzcc003,g_errno,1)
                     #LET g_dzcc_d[l_ac].dzcc003 = g_dzcc_d_t.dzcc003
                     #NEXT FIELD dzcc003
                  #END IF

                  SELECT dzebl003 INTO g_dzcc_d[l_ac].dzebl003 FROM dzebl_t 
                    WHERE dzebl001 = g_dzcc_d[l_ac].dzcc003 
                      AND dzebl002 = g_lang

                  #帶出此欄位的顯示控件(default值)
                  LET g_dzcc_d[l_ac].dzcc004 = adzi210_widget_type(g_dzcc_d[l_ac].dzcc003)
                  #自動填入顯示順序的最大值
                  IF cl_null(g_dzcc_d[l_ac].dzcc002) THEN    #130201 By benson
                     LET g_dzcc_d[l_ac].dzcc002 = adzi210_max_value()
                  END IF
                  #自動填入是否回傳,預設"是"
                  IF cl_null(g_dzcc_d[l_ac].dzcc005) THEN    #130201 By benson
                     LET g_dzcc_d[l_ac].dzcc005 = "Y"
                  END IF
                  #Begin:2015/06/16 by Hiko
                  #自動填入[資料大小寫],預設adzi150的dzep023.  顯示格式dzep021->dzcc010
                  LET l_table = sadzp210_define_table_name(g_dzcc_d[l_ac].dzcc003) #20151005
                  IF NOT cl_null(l_table) THEN
                     SELECT dzep023,dzep021 INTO g_dzcc_d[l_ac].dzcc006,g_dzcc_d[l_ac].dzcc010
                       FROM dzep_t WHERE dzep001=l_table AND dzep002=g_dzcc_d[l_ac].dzcc003
                  END IF
                  #End:2015/06/16 by Hiko

                 #20151005:mark
                 ##自動填入是否為rank欄位,預設"是"
                 #IF cl_null(g_dzcc_d[l_ac].dzcc007) THEN    #130201 By benson
                 #   LET g_dzcc_d[l_ac].dzcc007 = "Y"
                 #END IF
               END IF
            END IF 
            #130201 By benson --- S
            IF g_dzcc_d.getLength() > 0 THEN
               IF NOT cl_null(g_dzcc_d[1].dzcc003) THEN
                  CALL adzi210_dzca003_field_list_replace() #當滑鼠直接移到dzca003 這個欄位
               END IF
            END IF
            #130201 By benson --- E

         ON ACTION controlp INFIELD dzcc003
            #開窗  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            #20150804 -Begin-
            #標準環境下，不能挑選自定義欄位
            IF g_dgenv="s" THEN
               LET ls_dzeb022_condition = " dzeb022 NOT LIKE '%cdfUserDefine%'"
            ELSE
               LET ls_dzeb022_condition = NULL
            END IF
            LET g_qryparam.where = g_qryparam.where ,ls_dzeb022_condition
            #20150804 -End-

            CALL q_dzeb002( )
            LET ls_return = g_qryparam.return1

            #130201 By benson --- S
            #欄位開窗後，可以多選回傳，回傳後自動填滿適當的位置
            IF NOT cl_null(ls_return) THEN 
               LET l_count = 0
               LET tok = base.StringTokenizer.create(ls_return,"|")
               LET l_detail_cnt = g_dzcc_d.getLength()
               LET l_ac_t = l_ac
               WHILE tok.hasMoreTokens()
                  LET l_dzcc003  = tok.nextToken()
                  FOR l_i = 1 TO g_dzcc_d.getLength() 
                     IF g_dzcc_d[l_i].dzcc003 = l_dzcc003 THEN
                        IF g_dzcc_d[l_ac].dzcc003 = l_dzcc003 THEN LET l_count = 1 END IF
                        CONTINUE WHILE
                     END IF
                  END FOR
                  LET l_count = l_count + 1
                  IF l_count = 1 THEN
                     LET g_dzcc_d[l_ac].dzcc003 = l_dzcc003
                     #帶此欄位代碼的對應欄位名稱
                     SELECT dzebl003 INTO g_dzcc_d[l_ac].dzebl003 FROM dzebl_t 
                        WHERE dzebl001 = g_dzcc_d[l_ac].dzcc003
                          AND dzebl002 = g_lang
                     
                     #帶出此欄位的顯示控件(default值)
                     LET g_dzcc_d[l_ac].dzcc004 = adzi210_widget_type(g_dzcc_d[l_ac].dzcc003)
                     
                     #自動填入顯示順序的最大值
                     IF cl_null(g_dzcc_d[l_ac].dzcc002) THEN  
                        LET g_dzcc_d[l_ac].dzcc002 = adzi210_max_value()
                     END IF
                     
                     #自動填入是否回傳,預設"是"
                     LET g_dzcc_d[l_ac].dzcc005 = "Y"
                     
                    #20151005:mark
                    ##自動填入是否為rank欄位,預設"是"
                    #LET g_dzcc_d[l_ac].dzcc007 = "Y"
                  ELSE 
                     LET l_ac = l_detail_cnt + l_count - 1
                     LET g_dzcc_d[l_ac].dzcc003 = l_dzcc003
                     #帶此欄位代碼的對應欄位名稱
                     SELECT dzebl003 INTO g_dzcc_d[l_ac].dzebl003 FROM dzebl_t 
                      WHERE dzebl001 = g_dzcc_d[l_ac].dzcc003
                        AND dzebl002 = g_lang
                     
                     #帶出此欄位的顯示控件(default值)
                     LET g_dzcc_d[l_ac].dzcc004 = adzi210_widget_type(g_dzcc_d[l_ac].dzcc003)
                     
                     #自動填入顯示順序的最大值
                     IF cl_null(g_dzcc_d[l_ac].dzcc002) THEN  
                        LET g_dzcc_d[l_ac].dzcc002 = adzi210_max_value()
                     END IF
                     
                     #自動填入是否回傳,預設"否"
                     LET g_dzcc_d[l_ac].dzcc005 = "N"
                     
                    #20151005:mark
                    ##自動填入是否為rank欄位,預設"是"
                    #LET g_dzcc_d[l_ac].dzcc007 = "Y"
                  END IF
                  #Begin:2015/06/16 by Hiko
                  #自動填入[資料大小寫],預設adzi150的dzep023.  顯示格式dzep021->dzcc010
                  LET l_table = sadzp210_define_table_name(g_dzcc_d[l_ac].dzcc003) #20151005
                  IF NOT cl_null(l_table) THEN
                     SELECT dzep023,dzep021 INTO g_dzcc_d[l_ac].dzcc006,g_dzcc_d[l_ac].dzcc010
                       FROM dzep_t WHERE dzep001=l_table AND dzep002=g_dzcc_d[l_ac].dzcc003
                  END IF
                  #End:2015/06/16 by Hiko
                  LET l_ac = l_ac_t
               END WHILE
            END IF
            IF INT_FLAG THEN
               LET INT_FLAG = 0
            END IF
            #130201 By benson --- E

            #取代用鍵盤輸入的方式去觸發AFTER INSERT 和 ON ROW CHANGE
            CALL DIALOG.setFieldTouched("s_detail1.dzcc003",TRUE)

         AFTER FIELD dzcc004
            #當控件為comboBox檢查是否有設定狀態碼
            IF g_dzcc_d[l_ac].dzcc004 = "03" THEN
               IF g_dzcc_d[l_ac].dzcc003 MATCHES "*stus" THEN
                  SELECT DISTINCT gzcc003 INTO l_dzep011 FROM gzcc_t WHERE gzcc002 = g_dzcc_d[l_ac].dzcc003
               ELSE
                  SELECT dzep011 INTO l_dzep011 FROM dzep_t WHERE  dzep002 = g_dzcc_d[l_ac].dzcc003
               END IF
               IF cl_null(l_dzep011) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "adz-00166"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzcc_d[l_ac].dzcc003
                  CALL cl_err()
                  NEXT FIELD dzcc004
               END IF
            END IF

 
         ON ROW CHANGE
            #DISPLAY "ON ROW CHANGE"
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzcc_d[l_ac].* = g_dzcc_d_t.*
               #ROLLBACK WORK #20150415 by Hiko
               EXIT DIALOG 
            END IF

      END INPUT

      #Page1 預設值產生於此處
      INPUT ARRAY g_dzcb_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         
         BEFORE INPUT
            IF g_rec_b2 != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_before_input_done = FALSE  
            LET g_before_input_done = TRUE
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET g_dzcb_d_t.* = g_dzcb_d[l_ac].*     #新輸入資料
            LET l_n = ARR_COUNT()
         
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()

            INITIALIZE g_dzcb_d[l_ac].* TO NULL 
            LET g_dzcb_d[l_ac].dzcb002 = adzi210_max_value2()   #130201 By benson
            LET g_dzcb_d_t.* = g_dzcb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzi210_set_entry_b()
            CALL adzi210_set_no_entry_b()
            
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
            IF NOT cl_null(g_dzcb_d_t.dzcb002) THEN
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
               LET l_count = g_dzcb_d.getLength()
            END IF 
              
         AFTER DELETE 
            CALL adzi210_delete_b2(l_count) 
 
          #---------------------<  Detail: page     1  >---------------------
 
         #----<<dzcb003>>----
         BEFORE FIELD dzcb003
 
         AFTER FIELD dzcb003
            IF  NOT cl_null(g_dzca_m.dzca001) AND NOT cl_null(g_dzcb_d[l_ac].dzcb003)  THEN 
               IF  p_cmd = 'a'  OR ( p_cmd = 'u' AND (g_dzca_m.dzca001 != g_dzca001_t OR g_dzcb_d[l_ac].dzcb003 != g_dzcb_d_t.dzcb003 OR g_dzcb_d_t.dzcb003 IS NULL)) THEN  #130201 By benson
                  #130201 By benson --- S
                  CALL adzi210_chk_dzcb003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_dzcb_d[l_ac].dzcb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_dzcb_d[l_ac].dzcb003 = g_dzcb_d_t.dzcb003
                     NEXT FIELD dzcb003
                  END IF
                  #130201 By benson --- E
               END IF
            END IF
 
         #----<<dzcbl004>>----
         BEFORE FIELD dzcbl004
            IF cl_null(g_dzcb_d[l_ac].dzcb002) THEN
               ##自動填入單身順序(dzcb002)的最大值
               LET g_dzcb_d[l_ac].dzcb002 = adzi210_max_value2()
            END IF
 
         AFTER FIELD dzcbl004
             IF NOT cl_null(g_dzcb_d[l_ac].dzcbl004) THEN
                IF NOT cl_chk_tworcn(g_lang,g_dzcb_d[l_ac].dzcbl004,20) THEN
                   NEXT FIELD dzcbl004
                END IF
             END IF 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzcb_d[l_ac].* = g_dzcb_d_t.*
              #CLOSE adzi210_bcl2 #20140922:mark
               #ROLLBACK WORK #20150415 by Hiko
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dzcb_d[l_ac].dzcb002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzcb_d[l_ac].* = g_dzcb_d_t.*
            END IF

         ON ACTION update_item INFIELD dzcbl004
                IF  NOT cl_null(g_dzcb_d[l_ac].dzcb003) THEN
                  CALL n_dzcbl(g_dzca_m.dzca001,g_dzcb_d[l_ac].dzcb002) 
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_dzca_m.dzca001
                  LET g_ref_fields[2] = g_dzcb_d[l_ac].dzcb002
                  CALL ap_ref_array2(g_ref_fields," SELECT dzcbl004 FROM dzcbl_t WHERE dzcbl001 = ? AND dzcbl002 = ? AND dzcbl003 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_dzcb_d[l_ac].dzcbl004 = g_rtn_fields[1]
                  DISPLAY BY NAME g_dzcb_d[l_ac].dzcbl004
               END IF 
              
      END INPUT
      
      #130219 By benson --- S
      #將ON ACCEPT的資料，移至這邊，讓資料可以先經過AFTER FIELD 的控卡後，再進行資料INSERT的動作
      AFTER DIALOG

         #20140314:madey 
         #hard code的開窗不需要特別驗證
         IF g_dzca_m.dzca006 = 'Y' THEN #hard code
            IF adzi210_check_file_exists() THEN #20150701 add
               CALL adzi210_accept_data(p_cmd) 
               CALL cl_ask_pressanykey('adz-00544') #提醒: 請記得同時簽出規格及程式後，再回到r.q(adzi210)執行"產生Hard Code程式" 功能，才可以下載。
               LET g_action_choice = ""
            END IF
         ELSE 
            CALL adzi210_dzca003_field_list_replace()
            #修改前檢查是否有程式已使用此Qry
           #IF adzi210_chk_using('u') THEN #2015/04/23 by Hiko:改在修改按下去就提醒
               #sql_verify驗證沒成功，就不進行arg_verify和column_verify  By benson
               IF adzi210_sql_verify(g_dzca_m.dzca003,TRUE) THEN
                  IF adzi210_arg_verify(g_dzca_m.dzca003) AND adzi210_column_verify(g_dzca_m.dzca003) THEN 
                     IF adzi210_order_by_verify(g_dzca_m.dzca003) THEN #20151005
                        IF adzi210_chk_cartesian(g_dzca_m.dzca003,TRUE) THEN END IF #160428-00021
                       #CALL adzi210_dzca003_field_list_replace() #20150817 mark by madey:因為重覆了
                        
                        CALL adzi210_accept_data(p_cmd)    #130201 By benson
                        
                        LET g_action_choice = ""
                        
                        #Begin:2015/06/16 by Hiko:搬到執行adzi210_input之後.
                        #IF g_auto_genqry = 'Y' THEN          #130201 By benson 
                        #   #CALL adzi210_generate_qry(g_dzca_m.dzca001)
                        #  #IF NOT adzi210_generate_qry(g_dzca_m.dzca001) THEN  #20140710:madey
                        #   LET g_gen42s_flag = TRUE #20140903:透過r.q建立qry需要關聯42s
                        #
                        #   #20141230 -Begin-
                        #   IF p_cmd='a' THEN 
                        #      LET g_qry_gen_qtotal = "Y"
                        #   ELSE
                        #      LET g_qry_gen_qtotal = "N"  #修改時不需要重新link及gen q_total
                        #   END IF
                        #   CALL cl_progress_bar(2) #20141230
                        #   CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
                        #   #20141230 -End-
                        #   
                        #   IF NOT sadzp210_generate_qry(g_dzca_m.dzca001) THEN #20140710:madey
                        #      CALL cl_progress_bar_close() #20141230
                        #      #MESSAGE 'Error!'
                        #      INITIALIZE g_errparam TO NULL
                        #      LET g_errparam.code = "adz-00125"
                        #      LET g_errparam.extend =  ""
                        #      LET g_errparam.popup = TRUE
                        #      CALL cl_err()
                        #     #NEXT FIELD dzcal003
		        #     #bug fix:若是走新增流程,到此處時已insert成功,不需要NEXT FIELD dzca003了,當做流程結束,
                        #     #如果又NEXT FIELD dzcal003,由於p_cmd仍是a,會造成後續異動資料庫錯誤
                        #   ELSE
                        #      CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
                        #      #MESSAGE 'Success!'
                        #   END IF
                        #END IF
                        #End:2015/06/16 by Hiko
                     ELSE
                        NEXT FIELD dzca003
                     END IF
                  ELSE
                     NEXT FIELD dzca003
                  END IF
               ELSE
                  NEXT FIELD dzca003
               END IF
           #ELSE
           #  #NEXT FIELD dzca003
           #   EXIT DIALOG           #20140930 modify
           #END IF
         END IF
      #130219 By benson --- E
   
      #ON ACTION controlf
         #CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         #CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      #ON ACTION controlr
         #CALL cl_show_req_fields()

      ON ACTION lbl_sql_edit
        #CALL adzi210_run_prog("r.r","adzi230",g_prog)
         IF adzi210_run_prog("r.r","adzi230",g_prog) THEN END IF
         NEXT FIELD dzca003

      ON ACTION lbl_sql_builder
         LET ls_cmd = " adzp190 ",g_prog
         CALL cl_cmdrun(ls_cmd)
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

    #Begin: 160428-00021 mark :根本走不到這裡
    # ON ACTION verify  #驗證sql 
    #    IF g_dzca_m.dzca003 IS NOT NULL THEN
    #       CALL adzi210_sql_verify(g_dzca_m.dzca003,TRUE) RETURNING l_result
    #    ELSE
    #       #CALL FGL_WINMESSAGE("Warn", "The SQL is null!", "stop")
    #       INITIALIZE g_errparam TO NULL
    #       LET g_errparam.code =  "adz-00022"
    #       LET g_errparam.extend = NULL
    #       LET g_errparam.popup = TRUE
    #       LET g_errparam.replace[1] =  " SQL is null "
    #       CALL cl_err()
    #       NEXT FIELD dzca003
    #    END IF
    #End: 160428-00021 mark
         
      ON ACTION ACCEPT
         LET INT_FLAG = 0   #20150804
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = 1   #20150804
         LET g_action_choice=""
         #ROLLBACK WORK #20150415 by Hiko
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = 1   #20150804
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = 1   #20150804
         LET g_action_choice="exit"
         EXIT DIALOG
    
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG

    
END FUNCTION

#130201 By benson --- S
#資料的新增、修改、刪除後的結果，都在這個function完成與資料庫的互動
PRIVATE FUNCTION adzi210_accept_data(p_cmd)
   DEFINE  p_cmd    LIKE type_t.chr1
   DEFINE  l_count  LIKE type_t.num5
   DEFINE  l_i      LIKE type_t.num5
   DEFINE  l_cnt    LIKE type_t.num5

   #20140905 -Begin-
   DEFINE  li_cnt   LIKE type_t.num5,
           lt_dzcal002 LIKE dzcal_t.dzcal002,
           lt_dzcal003 LIKE dzcal_t.dzcal003,
           lt_dzcbl003 LIKE dzcbl_t.dzcbl003,
           lt_dzcbl004 LIKE dzcbl_t.dzcbl004
   #20140905 -End- 

   #20151005 -Begin-
   #因為dzca008是後來才拿來用的欄位,現有patch機制無法自動讓已出貨的開窗資料此欄位set init value=N,
   #為了避免不必要麻煩(充斥NULL與N),此處統一update為NULL
   IF g_dzca_m.dzca008 = 'Y' THEN
      #do nothing
   ELSE
      LET g_dzca_m.dzca008 = NULL
   END IF
   #20151005 -End-

   #BEGIN WORK #20150415 by Hiko
   IF p_cmd <> 'u' THEN
      LET l_count = 1  
      SELECT COUNT(*) INTO l_count FROM dzca_t
       WHERE dzca001 = g_dzca_m.dzca001
         AND dzca002 = g_dzca_m.dzca002 
      IF l_count = 0 THEN
         INSERT INTO dzca_t (dzca001,dzca003,dzca004,dzca005,dzca002,dzca006,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008)
         VALUES (g_dzca_m.dzca001,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,
                 g_dzca_m.dzcaownid,g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008) 
         #20140905 -Begin-
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "lib-00100"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_dzca_m.dzca001
            LET g_errparam.replace[2] ="dzca_t"
            LET g_errparam.extend = ""
            LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            #ROLLBACK WORK #20150415 by Hiko
            LET g_auto_genqry ="N" 
            RETURN
         END IF
         #20140905 -End-
         
        #20140905:mark 因為n_dzcbl()即時把資料insert進資料庫了,改下面寫法,否則很難判斷簡繁自動補資料的條件
        #SELECT COUNT(*) INTO l_cnt FROM dzcal_t WHERE dzcal001 = g_dzca_m.dzca001
        #IF l_cnt = 0 THEN
        #   INSERT INTO dzcal_t (dzcal001,dzcal002,dzcal003,dzcal004) 
        #   VALUES (g_dzca_m.dzca001,g_lang,g_dzca_m.dzcal003,"")
        #END IF 

         #20140905 -Begin-
         DELETE FROM dzcal_t WHERE dzcal001 = g_dzca_m.dzca001 #20140905
         INSERT INTO dzcal_t (dzcal001,dzcal002,dzcal003,dzcal004) 
         VALUES (g_dzca_m.dzca001,g_lang,g_dzca_m.dzcal003,"")
         IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00007 modify
            CASE g_lang
               WHEN "zh_TW" LET lt_dzcal002 = "zh_CN" CLIPPED
               WHEN "zh_CN" LET lt_dzcal002 = "zh_TW" CLIPPED
            END CASE
            LET lt_dzcal003 = cl_trans_code_tw_cn(lt_dzcal002, g_dzca_m.dzcal003) CLIPPED
            INSERT INTO dzcal_t (dzcal001,dzcal002,dzcal003,dzcal004) 
            VALUES (g_dzca_m.dzca001,lt_dzcal002,lt_dzcal003,"")
         END IF
         #20140905 -End-
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "lib-00100"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_dzca_m.dzca001
            LET g_errparam.replace[2] ="dzcal_t"
            LET g_errparam.extend = ""
            LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            #ROLLBACK WORK #20150415 by Hiko
            LET g_auto_genqry ="N" #20140905
         ELSE
          IF g_dzca_m.dzca006 = 'Y' THEN  #20140314:madey
            #COMMIT WORK #20140314:madey
          ELSE #20140314:madey
            DELETE FROM dzcb_t WHERE dzcb001 = g_dzca_m.dzca001
	                         AND dzcb004 = g_dzca_m.dzca002
            DELETE FROM dzcbl_t WHERE  dzcbl001 = g_dzca_m.dzca001
            FOR l_i = 1 TO g_dzcb_d.getLength() 
               IF NOT cl_null(g_dzcb_d[l_i].dzcb003) THEN 

                  INSERT INTO dzcb_t (dzcb001,dzcb002,dzcb003,dzcb004)
                       VALUES(g_dzca_m.dzca001,l_i,g_dzcb_d[l_i].dzcb003,g_dzca_m.dzca002)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "lib-00100"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_dzca_m.dzca001
                     LET g_errparam.replace[2] ="dzcb_t"
                     LET g_errparam.EXTEND = ""
                     LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                     CALL cl_err()
                     EXIT FOR 
                  END IF

                  INSERT INTO dzcbl_t (dzcbl001,dzcbl002,dzcbl003,dzcbl004,dzcbl005) 
                       VALUES(g_dzca_m.dzca001,g_dzcb_d[l_i].dzcb002,g_lang,g_dzcb_d[l_i].dzcbl004,"")                       
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "lib-00100"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_dzca_m.dzca001
                    #LET g_errparam.replace[2] ="dzcb_t"
                     LET g_errparam.replace[2] ="dzcbl_t" #20140905
                     LET g_errparam.extend = ""
                     LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                     CALL cl_err()
                     EXIT FOR 
                  END IF
                  
                  #20140905 -Begin-
                  #此處是走新增qry流程, 上面已經刪除掉舊資料了,所以可以直接新增
                  IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00007 modify
                     CASE g_lang
                        WHEN "zh_TW" 
                           LET lt_dzcbl003 = "zh_CN" CLIPPED
                        WHEN "zh_CN"
                           LET lt_dzcbl003 = "zh_TW" CLIPPED
                     END CASE
                     LET lt_dzcbl004 = cl_trans_code_tw_cn(lt_dzcbl003, g_dzcb_d[l_i].dzcbl004) CLIPPED
                     INSERT INTO dzcbl_t (dzcbl001,dzcbl002,dzcbl003,dzcbl004,dzcbl005) 
                          VALUES(g_dzca_m.dzca001,g_dzcb_d[l_i].dzcb002,lt_dzcbl003,lt_dzcbl004,"")                       
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "lib-00100"
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = g_dzca_m.dzca001
                        LET g_errparam.replace[2] ="dzcbl_t"
                        LET g_errparam.extend = ""
                        LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                        CALL cl_err()
                        EXIT FOR 
                     END IF
                  END IF
                  #20140905 -End-

               END IF
            END FOR
            IF NOT SQLCA.sqlcode THEN
               DELETE FROM dzcc_t WHERE dzcc001 = g_dzca_m.dzca001
			            AND dzcc009 = g_dzca_m.dzca002
               FOR l_i = 1 TO g_dzcc_d.getLength() 
                  IF NOT cl_null(g_dzcc_d[l_i].dzcc003) AND NOT cl_null(g_dzcc_d[l_i].dzcc005) THEN
                     INSERT INTO dzcc_t (dzcc001,dzcc002,dzcc003,dzcc004,dzcc005,dzcc006,dzcc007,dzcc010,dzcc008,dzcc009)
                          VALUES(g_dzca_m.dzca001,g_dzcc_d[l_i].dzcc002,g_dzcc_d[l_i].dzcc003,g_dzcc_d[l_i].dzcc004,
                                 g_dzcc_d[l_i].dzcc005,g_dzcc_d[l_i].dzcc006,g_dzcc_d[l_i].dzcc007,g_dzcc_d[l_i].dzcc010,g_dzcc_d[l_i].dzcc008,g_dzca_m.dzca002)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "lib-00100"
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = g_dzca_m.dzca001
                        LET g_errparam.replace[2] ="dzcc_t"
                        LET g_errparam.extend = ""
                        LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                        CALL cl_err()
                        EXIT FOR 
                     ELSE 
                   #    COMMIT WORK
                     END IF
                  END IF
               END FOR
            ELSE
               #ROLLBACK WORK #20150415 by Hiko
               LET g_auto_genqry ="N" #20140905
            END IF
          END IF #20140314:madey
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'std-00004'
         LET g_errparam.extend =  g_dzca_m.dzca001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #ROLLBACK WORK #20150415 by Hiko
         LET g_auto_genqry ="N" #20140905
      END IF 
   ELSE
      UPDATE dzca_t SET (dzca001,dzca003,dzca004,dzca005,dzca006,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008) =
                        (g_dzca_m.dzca001,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzca006,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,
                         g_dzca_m.dzcaownid,g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008)
       WHERE dzca001 = g_dzca_m_t.dzca001
         AND dzca002 = g_dzca_m.dzca002

      SELECT COUNT(*) INTO l_count FROM dzcal_t WHERE  dzcal001 = g_dzca_m_t.dzca001 AND dzcal002 = g_lang
      IF l_count > 0 THEN
         UPDATE dzcal_t SET (dzcal001,dzcal002,dzcal003,dzcal004) =
                           (g_dzca_m.dzca001,g_lang,g_dzca_m.dzcal003,"")
            WHERE  dzcal001 = g_dzca_m_t.dzca001 AND dzcal002 = g_lang
      ELSE
         INSERT INTO dzcal_t (dzcal001,dzcal002,dzcal003,dzcal004) 
            VALUES (g_dzca_m.dzca001,g_lang,g_dzca_m.dzcal003,"")
      END IF

      IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00007 modify
         CASE g_lang
            WHEN "zh_TW" LET lt_dzcal002 = "zh_CN" CLIPPED
            WHEN "zh_CN" LET lt_dzcal002 = "zh_TW" CLIPPED
         END CASE
         SELECT COUNT(*) INTO l_count FROM dzcal_t WHERE  dzcal001 = g_dzca_m_t.dzca001 AND dzcal002 = lt_dzcal002
         IF l_count > 0 THEN
            #do nothing
         ELSE
            LET lt_dzcal003 = cl_trans_code_tw_cn(lt_dzcal002, g_dzca_m.dzcal003) CLIPPED
            INSERT INTO dzcal_t (dzcal001,dzcal002,dzcal003,dzcal004) 
            VALUES (g_dzca_m.dzca001,lt_dzcal002,lt_dzcal003,"")
         END IF
      END IF
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "lib-00101"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_dzca_m.dzca001
         LET g_errparam.replace[2] ="dzcal_t"
         LET g_errparam.extend = ""
         LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
         CALL cl_err()
         #ROLLBACK WORK #20150415 by Hiko
         LET g_auto_genqry ="N" #20140905
      ELSE
       IF g_dzca_m.dzca006 = 'Y' THEN  #20140314:madey
         #COMMIT WORK #20140314:madey
          LET g_dzca001_t = g_dzca_m.dzca001  
	  LET g_dzca002_t = g_dzca_m.dzca002 
       ELSE
         DELETE FROM dzcb_t WHERE dzcb001 = g_dzca_m_t.dzca001
		              AND dzcb004 = g_dzca_m_t.dzca002
         DELETE FROM dzcb_t WHERE dzcb001 = g_dzca_m.dzca001
		              AND dzcb004 = g_dzca_m.dzca002 
       
         FOR l_i = 1 TO g_dzcb_d.getLength() 
            IF NOT cl_null(g_dzcb_d[l_i].dzcb003) THEN
               INSERT INTO dzcb_t (dzcb001,dzcb002,dzcb003,dzcb004)
                    VALUES(g_dzca_m.dzca001,l_i,g_dzcb_d[l_i].dzcb003,g_dzca_m.dzca002)

               DELETE FROM dzcbl_t WHERE  dzcbl001 = g_dzca_m.dzca001 
                                      AND dzcbl002 = g_dzcb_d[l_i].dzcb002 
                                      AND dzcbl003 = g_lang
                    
               INSERT INTO dzcbl_t (dzcbl001,dzcbl002,dzcbl003,dzcbl004,dzcbl005) 
                    VALUES(g_dzca_m.dzca001,g_dzcb_d[l_i].dzcb002,g_lang,g_dzcb_d[l_i].dzcbl004,"")                     
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "lib-00100"
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzca_m.dzca001
                  LET g_errparam.replace[2] ="dzcbl_t"
                  LET g_errparam.extend = ""
                  LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                  CALL cl_err()
                  EXIT FOR 
               END IF

               #20140905 -Begin-
               #此處是走更新qry流程, 上面只刪除掉單一語系的舊資料,要過濾舊資料是否存在,存在的話就不做了
               IF g_lang = "zh_TW" OR g_lang = "zh_CN" THEN #161215-00007 modify
                  CASE g_lang
                     WHEN "zh_TW" 
                        LET lt_dzcbl003 = "zh_CN" CLIPPED
                     WHEN "zh_CN"
                        LET lt_dzcbl003 = "zh_TW" CLIPPED
                  END CASE
                  LET lt_dzcbl004 = cl_trans_code_tw_cn(lt_dzcbl003, g_dzcb_d[l_i].dzcbl004) CLIPPED
                  LET li_cnt = 0
                  SELECT COUNT(1) INTO li_cnt FROM dzcbl_t
                   WHERE dzcbl001 = g_dzca_m.dzca001 
                     AND dzcbl002 = g_dzcb_d[l_i].dzcb002 
                     AND dzcbl003 = lt_dzcbl003
                  IF li_cnt = 0 THEN
                     INSERT INTO dzcbl_t (dzcbl001,dzcbl002,dzcbl003,dzcbl004,dzcbl005) 
                          VALUES(g_dzca_m.dzca001,g_dzcb_d[l_i].dzcb002,lt_dzcbl003,lt_dzcbl004,"")                       
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "lib-00100"
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = g_dzca_m.dzca001
                        LET g_errparam.replace[2] ="dzcbl_t"
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
         IF NOT SQLCA.sqlcode THEN
            DELETE FROM dzcc_t WHERE dzcc001 = g_dzca_m_t.dzca001
			         AND dzcc009 = g_dzca_m_t.dzca002
            DELETE FROM dzcc_t WHERE dzcc001 = g_dzca_m.dzca001
			         AND dzcc009 = g_dzca_m.dzca002 
            FOR l_i = 1 TO g_dzcc_d.getLength() 
               IF NOT cl_null(g_dzcc_d[l_i].dzcc003) AND NOT cl_null(g_dzcc_d[l_i].dzcc005) THEN
                  INSERT INTO dzcc_t (dzcc001,dzcc002,dzcc003,dzcc004,dzcc005,dzcc006,dzcc007,dzcc010,dzcc008,dzcc009)
                       VALUES(g_dzca_m.dzca001,g_dzcc_d[l_i].dzcc002,g_dzcc_d[l_i].dzcc003,g_dzcc_d[l_i].dzcc004,
                              g_dzcc_d[l_i].dzcc005,g_dzcc_d[l_i].dzcc006,g_dzcc_d[l_i].dzcc007,g_dzcc_d[l_i].dzcc010,g_dzcc_d[l_i].dzcc008,g_dzca_m.dzca002)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "lib-00100"
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_dzca_m.dzca001
                     LET g_errparam.replace[2] ="dzcc_t"
                     LET g_errparam.extend = ""
                     LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
                     CALL cl_err()
                     EXIT FOR 
                  ELSE 
                    #COMMIT WORK
                     LET g_dzca001_t = g_dzca_m.dzca001
		     LET g_dzca002_t = g_dzca_m.dzca002 
                   END IF
               END IF 
            END FOR
         ELSE
            #ROLLBACK WORK #20150415 by Hiko
            LET g_auto_genqry ="N" #20140905
         END IF
       END IF #20140314:madey
      END IF
   END IF
   #COMMIT WORK #20150415 by Hiko

END FUNCTION
#130201 By benson --- E
 
 
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzi210_show()
   DEFINE l_ac_t    LIKE type_t.num5
   DEFINE l_prog_name LIKE type_t.chr20
   
   LET g_dzca_m_t.* = g_dzca_m.*      #保存單頭舊值
   
   CALL adzi210_b_fill("1=1")  #單身填充
     
   #帶出預設欄位之值
   LET g_dzca_m.modid_desc = cl_get_username(g_dzca_m.dzcamodid)
   LET g_dzca_m.ownid_desc = cl_get_username(g_dzca_m.dzcaownid)
   LET g_dzca_m.crtid_desc = cl_get_username(g_dzca_m.dzcacrtid)
   LET g_dzca_m.crtdp_desc = cl_get_deptname(g_dzca_m.dzcacrtdp)
   LET g_dzca_m.owndp_desc = cl_get_deptname(g_dzca_m.dzcaowndp)
 
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dzcc_d.getLength()
       
   END FOR

   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dzcb_d.getLength()
       
   END FOR
 
   LET l_ac = l_ac_t

   #SELECT dzcal003 INTO g_dzca_m.dzcal003 FROM dzcal_t WHERE dzcal001 = g_dzca_m.dzca001 AND dzcal002 = g_lang
   
  #20140314:madey
  #DISPLAY BY NAME g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzcamodid,g_dzca_m.modid_desc,
  #DISPLAY BY NAME g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca006,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzcamodid,g_dzca_m.modid_desc,
   DISPLAY BY NAME g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzcamodid,g_dzca_m.modid_desc,
                   g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,g_dzca_m.ownid_desc,g_dzca_m.dzcaowndp,g_dzca_m.owndp_desc,
                   g_dzca_m.dzcacrtid,g_dzca_m.crtid_desc,g_dzca_m.dzcacrtdp,g_dzca_m.crtdp_desc,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008

   SELECT DISTINCT gzzal003 INTO l_prog_name
     FROM gzza_t LEFT OUTER JOIN gzzal_t ON gzza001 = gzzal001 AND gzzal002 = g_lang
     WHERE gzza001 = g_dzca_m.dzca005 AND gzzastus = 'Y' 

   DISPLAY l_prog_name TO s_dzca005

   DISPLAY g_dzca004_info TO s_dzca004_info
   #DISPLAY g_global_var TO s_global_var #20150415 by Hiko

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
END FUNCTION
 
 
#+ 資料複製
PRIVATE FUNCTION adzi210_reproduce()
   DEFINE l_newno     LIKE dzca_t.dzca001 
   DEFINE l_oldno     LIKE dzca_t.dzca001 
   
   DEFINE l_old_cust_flag LIKE dzca_t.dzca002 
   DEFINE l_new_cust_flag LIKE dzca_t.dzca002
   
   DEFINE l_master    RECORD LIKE dzca_t.*
   DEFINE l_detail    RECORD LIKE dzcc_t.*
   DEFINE l_detail2   RECORD LIKE dzcb_t.*
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5    

   DEFINE l_new_industry   LIKE dzca_t.dzca007  #20150114

   DEFINE l_new_hardcode   LIKE dzca_t.dzca006  #20150701
  
   IF cl_null(g_dzca_m.dzca001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF

   #Begin:160419-00007
   IF sadzp060_ind_check_area() THEN 
      LET g_dzca_m.dzca007 = g_topind
   END IF
   #End:160419-00007   

   LET g_before_input_done = FALSE
   CALL adzi210_set_entry('a')
   CALL adzi210_set_no_entry('a') #20150114
   LET g_before_input_done = TRUE
 
   CALL cl_set_head_visible("","YES")
 
   INPUT l_newno,l_new_industry FROM dzca001,dzca007
 
      BEFORE INPUT
         #20150114  -Begin-
         LET l_new_industry = g_dzca_m.dzca007 #預設跟複製來源一樣
         IF g_dgenv=="c" THEN LET l_new_industry = "sd" END IF #客戶環境下複製,行業別固定為sd
         DISPLAY l_new_industry TO dzca_t.dzca007

         LET l_new_cust_flag = IIF(g_dgenv=="c","c","s") 
         DISPLAY l_new_cust_flag TO dzca_t.dzca002 
         #20150114  -End-

         #20150701 -Begin-
         LET l_new_hardcode = g_dzca_m.dzca006
         DISPLAY l_new_hardcode TO dzca_t.dzca006 
         #20150701 -End-
 
      AFTER FIELD dzca001 
         IF l_newno IS NULL THEN
     #      NEXT FIELD CURRENT #20150114 mark
         #120221 By benson --- S
         ELSE
            IF NOT adzi210_chk_dzca001(l_newno,l_new_industry) THEN
               LET l_newno = ''
               NEXT FIELD CURRENT
            END IF

            LET l_n = 0
                
            SELECT COUNT(*) INTO l_n FROM dzca_t WHERE dzca001 = l_newno
	                                           AND dzca002 = l_new_cust_flag
            IF l_n > 0 THEN
               #DISPLAY "l_newno = ",l_newno
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
       AFTER FIELD dzca007
          IF NOT cl_null(l_newno) THEN
            IF NOT adzi210_chk_dzca001(l_newno,l_new_industry) THEN 
               NEXT FIELD dzca001
            END IF
          END IF
      #20150114 -End-
            
      AFTER INPUT
         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM dzca_t 
          WHERE dzca001 = l_newno
	    AND dzca002 = l_new_cust_flag
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
           #LET g_errparam.extend = "Reproduce"
            LET g_errparam.extend = l_newno #20140905
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #NEXT FIELD dzca001 
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
 
   SELECT * INTO l_master.* FROM dzca_t 
      WHERE dzca001 = g_dzca_m.dzca001
        AND dzca002 = g_dzca_m.dzca002
 
   LET l_master.dzca001  = l_newno
   LET l_master.dzca002  = l_new_cust_flag
   LET l_master.dzcacrtid = g_user
   LET l_master.dzcacrtdp = g_dept
   LET l_master.dzcacrtdt = cl_get_current()
   LET l_master.dzcaownid = g_user 
   LET l_master.dzcaowndp = g_dept 
   LET l_master.dzcamodid = g_user
   LET l_master.dzcamoddt = cl_get_current()
   #LET l_master.dzcastus = 'Y'#忽略狀態碼 
   LET l_master.dzca007  = l_new_industry #20150114
   #20150701: 複製時,一律先給N,等到產生4gl/4fd後，若來源是Y的話,再更新資料庫為Y,不然的話,會無法重產
   #         (即時是hard code qry,也要保留一版樣版的4gl/4fd)
   LET l_master.dzca006  = 'N' 
   
   INSERT INTO dzca_t VALUES (l_master.*) #複製單頭

   DELETE FROM dzcal_t WHERE dzcal001 = l_master.dzca001 #20140905
   LET l_cnt=0
   SELECT COUNT(*) INTO l_cnt FROM dzcal_t WHERE dzcal001 =  g_dzca_m.dzca001
   IF l_cnt > 0 THEN
      INSERT INTO dzcal_t (dzcal001,dzcal002,dzcal003,dzcal004)
         SELECT l_master.dzca001 dzcal001,dzcal002,dzcal003,dzcal004 FROM dzcal_t 
            WHERE dzcal001 = g_dzca_m.dzca001
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "lib-00100"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_newno
         LET g_errparam.replace[2] ="dzcal_t"
         LET g_errparam.extend = ""
         LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
         CALL cl_err()
         ROLLBACK WORK
         RETURN
      END IF
   END IF

  
   DELETE FROM dzcc_t WHERE dzcc001 = l_master.dzca001
                        AND dzcc009 = l_master.dzca002
   LET g_sql = "SELECT * FROM dzcc_t WHERE  ",
               " dzcc001 = '",g_dzca_m.dzca001,"'",
   	       " AND dzcc009 ='",g_dzca_m.dzca002,"'"
 
   DECLARE adzi210_reproduce CURSOR FROM g_sql
 
   FOREACH adzi210_reproduce INTO l_detail.*
      LET l_detail.dzcc001 = l_newno
      LET l_detail.dzcc009 = l_new_cust_flag
      
      INSERT INTO dzcc_t VALUES (l_detail.*) #複製單身
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!dzcc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN
      END IF
      
   END FOREACH

   DELETE FROM dzcb_t WHERE dzcb001 = l_master.dzca001
                        AND dzcb004 = l_master.dzca002
   LET g_sql = "SELECT * FROM dzcb_t WHERE  ",
               " dzcb001 = '",g_dzca_m.dzca001,"'",
	       " AND dzcb004 ='",g_dzca_m.dzca002,"'" 
 
   DECLARE adzi210_reproduce2 CURSOR FROM g_sql
 
   FOREACH adzi210_reproduce2 INTO l_detail2.*
      LET l_detail2.dzcb001 = l_newno
      LET l_detail2.dzcb004 = l_new_cust_flag 
      
      INSERT INTO dzcb_t VALUES (l_detail2.*) #複製單身
      IF SQLCA.sqlcode THEN
         #DISPLAY "l_detail2.dzcb001 = ",l_detail2.dzcb001
         #DISPLAY "g_dzca_m.dzca001 = ",g_dzca_m.dzca001
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
        #LET g_errparam.extend = 'Insert error!dzcb_t dzcbl_t'
         LET g_errparam.extend = 'Insert error!dzcb_t' #20140905
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN
      END IF
      
   END FOREACH

   DELETE FROM dzcbl_t WHERE dzcbl001 = l_master.dzca001 #20140905
   LET l_cnt=0
   SELECT COUNT(*) INTO l_cnt FROM dzcbl_t WHERE dzcbl001 =  g_dzca_m.dzca001
   IF l_cnt > 0 THEN
      INSERT INTO dzcbl_t (dzcbl001,dzcbl002,dzcbl003,dzcbl004,dzcbl005) 
         SELECT l_master.dzca001 dzcbl001,dzcbl002,dzcbl003,dzcbl004,dzcbl005 FROM dzcbl_t
            WHERE dzcbl001 = g_dzca_m.dzca001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "lib-00100"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_newno
         LET g_errparam.replace[2] ="dzcbl_t"
         LET g_errparam.extend = ""
         LET g_errparam. sqlerr = SQLCA.SQLERRD[2]
         CALL cl_err()
         ROLLBACK WORK
         RETURN
      END IF
   END IF
      
   COMMIT WORK
   #MESSAGE 'ROW(',l_newno,') O.K'

   #20141230 -Begin-
   #複製時應該要順便產生qry實體並gen q_total ,這樣修改時才能夠一致skip gen q_total
  #LET g_gen42s_flag = TRUE 
   LET g_qry_gen_qtotal = "Y"
   CALL cl_progress_bar(2) 
  #CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
   CALL cl_progress_ing("[Message] gen qry、link qry")
   IF NOT sadzp210_generate_qry(l_newno) THEN
      CALL cl_progress_bar_close()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00125"
      LET g_errparam.extend =  g_qry_gen_errmsg
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
     #CALL cl_progress_ing("[Message] gen qry、gen q_total、link qry")
      CALL cl_progress_ing("[Message] gen qry、link qry")
   END IF
   #20141230 -End-

   #20150701 - Begin-
   #補設定hardcode註記
   IF l_new_hardcode = 'Y' THEN
      UPDATE dzca_t SET dzca006=l_new_hardcode 
         WHERE dzca001 = l_newno
           AND dzca002 = l_new_cust_flag
   END IF
   #20150701 - End-

   LET l_oldno = g_dzca_m.dzca001
   LET l_old_cust_flag = g_dzca_m.dzca002
   
   SELECT dzca001,dzcal003,dzca003,dzca004,dzca005,dzca002,dzca006,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008
     INTO g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,
          g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008
     FROM dzca_t
     LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= g_lang
     WHERE dzca001 = l_newno AND dzca002 = l_new_cust_flag 
 
   CALL adzi210_show()
  
 #20150701 mark: 應該show複製後的資料就可以了,把show舊資料的這段註解掉
 ##LET g_dzca_m.dzca001 = l_oldno
 ##LET g_dzca_m.dzca002 = l_old_cust_flag 
 ##
 ##SELECT dzca001,dzcal003,dzca003,dzca004,dzca005,dzca002,dzca006,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007
 ##  INTO g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,
 ##       g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007
 ##  FROM dzca_t 
 ##  LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= g_lang
 ## WHERE  dzca001 = g_dzca_m.dzca001 AND dzca002 = g_dzca_m.dzca002
 
 ##CALL adzi210_show()
   DISPLAY BY NAME g_dzca_m.dzca001,g_dzca_m.dzca002 

   #20150701 -Begin-
   CALL cl_ask_pressanykey('adz-00550') #複製完成
   IF l_new_hardcode='Y' THEN
      CALL cl_ask_pressanykey('adz-00544') #提醒: 請記得同時簽出規格及程式後，再回到r.q(adzi210)執行"產生Hard Code程式" 功能，才可以下載。
      CALL cl_ask_pressanykey('adz-00545') #提醒: r.q(adzi210)的複製功能僅能拷貝開窗設計資料，若要複製實際hard cod程式內容，請接著透過複製工具(adzp270)達成。
   END IF
   #20150701 -End-
   
END FUNCTION
 

#+ 資料刪除
PRIVATE FUNCTION adzi210_delete()
   DEFINE ls_cmd    STRING,
          ls_path   STRING
   DEFINE li_dzca_cnt SMALLINT,       #有幾筆dzca資料
          lb_have_cust BOOLEAN,       #此開窗是否客製
          lb_std_to_cust BOOLEAN,     #此開窗為標準轉客製
          l_str     STRING
   DEFINE lb_result      BOOLEAN,
          ls_err_msg     STRING,
          l_regen_type   LIKE type_t.chr1
   DEFINE li_cnt     SMALLINT,
          l_dzaf001  LIKE dzaf_t.dzaf001,
          l_dzaf010  LIKE dzaf_t.dzaf010
          
   
   IF cl_null(g_dzca_m.dzca001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF


   #確認此qry是否客製,是否由標準轉客製
   CALL sadzp210_check_qry_have_cust(g_dzca_m.dzca001) RETURNING li_dzca_cnt,lb_have_cust
   IF lb_have_cust AND li_dzca_cnt > 1 THEN
      LET lb_std_to_cust = TRUE
   ELSE
      LET lb_std_to_cust = FALSE
   END IF

   #20150804 -Begin-
   #topstd帳號不允許異動客製資料
   IF g_account="topstd" AND g_dzca_m_t.dzca002 = "c" THEN
      CALL cl_ask_pressanykey("adz-00676") 
      RETURN
   END IF
   #20150804 -End-

   #客製環境下,標準qry無法刪除!要擋下來
   IF g_dgenv = "c" AND g_dzca_m.dzca002 = "s" THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00409"
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
   END IF

   #標準轉客製:無法被刪除，僅能執行 "客製還原標準" 功能
   IF lb_std_to_cust THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00558"
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
   END IF
 
   #20150701 -Begin-
   #標準轉客製的qry比較複雜,Hard Code要擋下來,透過adzp063刪除
   #可能情況:標準  --客製
   #          s:n  -- c:n
   #          s:n  -- c:y
   #          s:y  -- c:y
   #          s:y  -- c:n (由操作面直接擋掉,不可能有這種情況)
   IF g_dzca_m.dzca006 = 'Y' THEN
      LET li_cnt=0
      LET l_dzaf001=g_dzca_m.dzca001
      LET l_dzaf010=g_dzca_m.dzca002
      SELECT COUNT(*) INTO li_cnt FROM dzaf_t WHERE dzaf001=l_dzaf001 AND dzaf010=l_dzaf010
      IF li_cnt > 0 THEN
         CALL cl_ask_pressanykey("adz-00533")
         RETURN
      END IF
   END IF
   #20150701 -End-

   SELECT UNIQUE dzca001,dzcal003,dzca003,dzca004,dzca005,dzca002,dzca006,dzcamodid,dzcamoddt,dzcaownid,dzcaowndp,dzcacrtid,dzcacrtdp,dzcacrtdt,dzca007,dzca008
     INTO g_dzca_m.dzca001,g_dzca_m.dzcal003,g_dzca_m.dzca003,g_dzca_m.dzca004,g_dzca_m.dzca005,g_dzca_m.dzca002,g_dzca_m.dzca006,g_dzca_m.dzcamodid,g_dzca_m.dzcamoddt,g_dzca_m.dzcaownid,
          g_dzca_m.dzcaowndp,g_dzca_m.dzcacrtid,g_dzca_m.dzcacrtdp,g_dzca_m.dzcacrtdt,g_dzca_m.dzca007,g_dzca_m.dzca008
     FROM dzca_t
     LEFT JOIN dzcal_t ON dzca001 = dzcal001 AND dzcal002= g_lang
     WHERE dzca001 = g_dzca_m.dzca001 AND dzca002 = g_dzca_m.dzca002

 
   IF g_god_mode THEN #160223-00028
      DISPLAY "skip adzi210_chk_using('d')" # god mode下不檢查是否使用，可強制刪除
      #do nothing 
   ELSE
      IF NOT adzi210_chk_using('d') THEN
         RETURN
      END IF
   END IF

   IF cl_ask_del_master() THEN              #確認一下
      BEGIN WORK #2015/04/23 by Hiko

      CALL sadzp210_del_qry_design_data(g_dzca_m.dzca001,g_dzca_m.dzca002) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
        ROLLBACK WORK
        RETURN
      END IF

      #刪除gzzn_t
      IF sadzp210_maintain_gzzn_t(g_dzca_m.dzca001,"","delete") THEN #160223-00028
        #do nothing,暫時by pass
      END IF

      #刪除實體檔案:標準目錄跟客製目錄都試著砍(可能是標準轉客製後,整支不要)
      CALL sadzp210_del_qry_file(g_dzca_m.dzca001,'')

      COMMIT WORK #2015/04/23 by Hiko

      CALL cl_progress_bar(2)
      CALL cl_progress_ing("[Message] link qry")  
      #刪除某個qry,此處只要重新做q_total及r.l即可

      #Begin: 160223-00028
      IF lb_have_cust THEN #純客製
         RUN 'r.l cqry'
      ELSE                 #純標準
         RUN 'r.l qry'   
      END IF
      #End: 160223-00028

      CALL cl_progress_ing("[Message] link qry")  

      CLEAR FORM
      CALL g_dzcc_d.clear()
      CALL g_dzcb_d.clear()
     
      CALL adzi210_ui_browser_refresh()  
      CALL adzi210_ui_headershow()  
      #CALL adzi210_ui_detailshow() #20150415 by Hiko
       
      IF g_browser_cnt > 0 THEN 
         CALL adzi210_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         CALL adzi210_browser_fill("first")
      END IF

   END IF

   #COMMIT WORK #2015/04/23 by Hiko
END FUNCTION
 
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi210_b_fill(p_wc2)
   DEFINE p_wc2      STRING

   CALL g_dzcc_d.clear()    #g_dzcc_d 單頭及單身 
   LET g_sql = "SELECT DISTINCT dzcc002, dzcc003, dzebl003, dzcc004, dzcc005, dzcc006, dzcc007, dzcc010 ,dzcc008,dzcc009", 
               "  FROM dzcc_t LEFT OUTER JOIN dzebl_t ON dzcc003 = dzebl001 ", 
               "  WHERE dzcc001 = ? ",
	       "    AND dzcc009 = ? ",
               "    AND dzebl002 ='",g_lang,"'"
   
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF

   LET g_sql = g_sql,"  ORDER BY dzcc002"

   #DISPLAY "g_sql for dzcc_t = ",g_sql
 
   PREPARE adzi210_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR adzi210_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs USING g_dzca_m.dzca001,g_dzca_m.dzca002
   FOREACH b_fill_cs INTO g_dzcc_d[l_ac].dzcc002,g_dzcc_d[l_ac].dzcc003,g_dzcc_d[l_ac].dzebl003,g_dzcc_d[l_ac].dzcc004,g_dzcc_d[l_ac].dzcc005,g_dzcc_d[l_ac].dzcc006,g_dzcc_d[l_ac].dzcc007,g_dzcc_d[l_ac].dzcc010,g_dzcc_d[l_ac].dzcc008,g_dzcc_d[l_ac].dzcc009
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
   
   CALL g_dzcc_d.deleteElement(l_ac)
 
 
   LET g_rec_b=l_ac-1
   LET l_ac = g_cnt
   LET g_cnt = 0

#############################################################################
   CALL g_dzcb_d.clear()    #g_dzcb_d 單頭及單身
   LET g_sql = "SELECT DISTINCT dzcb002,dzcb003,dzcb004,dzcbl004 ",
               " FROM dzcb_t ",
               " LEFT JOIN dzcbl_t ON dzcbl001=dzcb001 AND dzcbl002 = dzcb002 AND dzcbl003 = '",g_lang,"' ",
               " WHERE dzcb001=?",
               " AND dzcb004=?"
 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF

   LET g_sql = g_sql,"  ORDER BY dzcb002"

   #DISPLAY "g_sql for dzcb_t = ",g_sql
 
   PREPARE adzi210_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR adzi210_pb2
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs2 USING g_dzca_m.dzca001,g_dzca_m.dzca002
   FOREACH b_fill_cs2 INTO g_dzcb_d[l_ac].dzcb002,g_dzcb_d[l_ac].dzcb003,g_dzcb_d[l_ac].dzcb004,g_dzcb_d[l_ac].dzcbl004
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

   CALL g_dzcb_d.deleteElement(l_ac)
 
 
   LET g_rec_b2=l_ac-1
   LET l_ac = g_cnt
   LET g_cnt = 0
   
END FUNCTION
 
 
#+ 刪除單身1db資料後畫面頁簽連動
PRIVATE FUNCTION adzi210_delete_b(p_total)
   DEFINE p_total LIKE type_t.num5
 
   IF p_total = g_dzcc_d.getLength() THEN
      CALL g_dzcc_d.deleteElement(l_ac)
   END IF
END FUNCTION

#+ 刪除單身2db資料後畫面頁簽連動
PRIVATE FUNCTION adzi210_delete_b2(p_total)
   DEFINE p_total LIKE type_t.num5
 
   IF p_total = g_dzcb_d.getLength() THEN
      CALL g_dzcb_d.deleteElement(l_ac)
   END IF
END FUNCTION
 
 
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi210_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  

   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("dzca001",TRUE)

      #20150114 -Begin-
      IF g_dgenv='s' THEN
         CALL cl_set_comp_entry("dzca007",TRUE)
      END IF
      #20150114 -End-
   END IF

   #20140314:madey -start-
  #IF p_cmd = 'a' THEN 
   IF p_cmd = 'u' THEN  #20150701:修改時可以異動此欄位
      CALL cl_set_comp_entry("dzca006",TRUE)
   END IF
   #20140314:madey -end-
   
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi210_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   

   IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("dzca001,dzca007",FALSE)
   END IF
   
   #20140314:madey -start-
 ##IF p_cmd = 'u' THEN
   IF p_cmd = 'a' THEN #20150701:新增時不可異動此欄位
      CALL cl_set_comp_entry("dzca006",FALSE)
   END IF
   #20140314:madey -end-

   CALL cl_set_comp_entry("dzca002",FALSE) #dzca002這個值應該自動給 

   #20150114 -Begin-
   #客製環境下,新增時不允許異動行業別欄位
   IF p_cmd = 'a' AND g_dgenv='c' THEN
      CALL cl_set_comp_entry("dzca007",FALSE)
   END IF
   #20150114 -End-

   #Begin:160419-00007  
   #行業環境下不可異動行業別欄位
   IF p_cmd = 'a' AND g_dgenv = 's' AND sadzp060_ind_check_area() THEN
      CALL cl_set_comp_entry("dzca007",FALSE)
   END IF
   #End:160419-00007
END FUNCTION
 
 
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzi210_set_entry_b()
     
END FUNCTION
 
 
#+ 單身欄位關閉設定
PRIVATE FUNCTION adzi210_set_no_entry_b()
     
END FUNCTION
 
#確認碼變更
PRIVATE FUNCTION adzi210_statechange()
   DEFINE lc_state LIKE type_t.chr5
   
   #MESSAGE ""
 
   IF cl_null(g_dzca_m.dzca001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         #CASE g_dzca_m.dzcastus #忽略狀態碼 
            #WHEN "Y"
               #HIDE OPTION "valid"
            #WHEN "N"
               #HIDE OPTION "void"
			#WHEN "X"
			   #HIDE OPTION "invalid"
         #END CASE
         IF g_template_type <> "t" THEN
            HIDE OPTION "invalid"
         END IF
      ON ACTION valid
         LET lc_state = "Y"
         EXIT MENU
      ON ACTION void
         LET lc_state = "N"
         EXIT MENU
      ON ACTION invalid
         LET lc_state = "X"
         EXIT MENU
   END MENU
   
  
   #UPDATE dzca_t SET dzcastus = lc_state #忽略狀態碼 
      #WHERE  dzca001 = g_dzca_m.dzca001
 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "authstatus/void.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "authstatus/invalid.png")
      END CASE
   END IF
 
END FUNCTION

################################################################################
 
PRIVATE FUNCTION adzi210_sql_sample(p_cmd, p_sql_sample,p_sql_sample_o) 
   DEFINE p_cmd          LIKE type_t.chr1     #目前是進行新增或更新作業
   DEFINE p_sql_sample   LIKE type_t.chr1     #SQL指令type
   DEFINE l_sql          STRING 
   #130221 By benson --- S
   DEFINE p_sql_sample_o LIKE type_t.chr1   
   DEFINE l_dzej004      LIKE dzej_t.dzej004 
   DEFINE l_str1         base.StringBuffer
   DEFINE l_spos1        LIKE type_t.num5      #'<field>'字元位置
   DEFINE l_epos1        LIKE type_t.num5      #'</field>'字元位置
   DEFINE l_str2         base.StringBuffer
   DEFINE l_spos2        LIKE type_t.num5      #'<field>'字元位置
   DEFINE l_epos2        LIKE type_t.num5      #'</field>'字元位置
   DEFINE l_string1      STRING
   DEFINE l_string2      STRING
   #130221 By benson --- E

   
   LET l_sql = ""

   IF p_cmd = "a" THEN
     #130221 By benson ---- S
     #CASE p_sql_sample
     #   WHEN "1"
     #      LET l_sql = "SELECT DISTINCT ", G_FIELD_START, "aaaa001, aaaa002", G_FIELD_END, ASCII 10,  
     #                  "  FROM ", G_TABLE_START, "aaaa_t", G_TABLE_END, ASCII 10,  
     #                  "  WHERE ", G_WHERE_START, "1=1", G_WHERE_END, ASCII 10,  
     #                  "  ORDER BY aaaa001 "
     #   WHEN "2"
     #      LET l_sql = "SELECT DISTINCT ", G_FIELD_START, "aaaa001, aaab002", G_FIELD_END, ASCII 10,  
     #                  "  FROM ", G_TABLE_START, "aaaa_t, ", ASCII 10, 
     #                  "                          aaab_t", G_TABLE_END, ASCII 10,  
     #                  "  WHERE ", G_WHERE_START, "aaaa001 = aaab001", G_WHERE_END, ASCII 10,  
     #                  "  ORDER BY aaaa001 "
     #   WHEN "3"
     #      LET l_sql = "SELECT DISTINCT ", G_FIELD_START, "aaaa001, aaab002", G_FIELD_END, ASCII 10,  
     #                  "  FROM ", G_TABLE_START, "aaaa_t LEFT OUTER JOIN aaab_t ON aaaa001 = aaab001", G_TABLE_END, ASCII 10,  
     #                  "  WHERE ", G_WHERE_START, "1=1", G_WHERE_END, ASCII 10,  
     #                  "  ORDER BY aaaa001 "
     #   OTHERWISE
     #      LET l_sql = "SELECT ", G_FIELD_START, G_FIELD_END, ASCII 10, 
     #                  "  FROM ", G_TABLE_START, G_TABLE_END, ASCII 10,  
     #                  "  WHERE ", G_WHERE_START, "1=1", G_WHERE_END, ASCII 10
     #END CASE      
     #LET g_dzca_m.dzca003 = l_sql  

      #顯示 SQL sample 改由抓資料庫的方式
      IF p_sql_sample != p_sql_sample_o OR cl_null(g_dzca_m.dzca003) THEN
         SELECT dzej004 INTO l_dzej004 FROM dzej_t
          WHERE dzej001 = 'qry_sql_sample'
            AND dzej002 = p_sql_sample_o

         LET l_spos1 = 0 LET l_epos1 = 0
         LET l_spos2 = 0 LET l_epos2 = 0

         #忽略欄<field>...</field>之間的維護
         LET l_str1 = base.StringBuffer.create() 
         CALL l_str1.append(l_dzej004)
         LET l_spos1= l_str1.getIndexOf(G_FIELD_START, 1)
         LET l_epos1= l_str1.getIndexOf(G_FIELD_END, 1)
         LET l_epos1 = l_epos1 - l_spos1
         CALL l_str1.replaceAt(l_spos1,l_epos1,"xxx")
         LET l_string1 = l_str1.toString() CLIPPED

         LET l_str2 = base.StringBuffer.create() 
         CALL l_str2.append(g_dzca_m.dzca003)
         LET l_spos2= l_str2.getIndexOf(G_FIELD_START, 1)
         LET l_epos2= l_str2.getIndexOf(G_FIELD_END, 1) 
         LET l_epos2 = l_epos2 - l_spos2
         CALL l_str2.replaceAt(l_spos2,l_epos2,"xxx")
         LET l_string2 = l_str2.toString() CLIPPED
         
         IF l_string1 = l_string2 OR cl_null(g_dzca_m.dzca003) THEN
            SELECT dzej004 INTO l_dzej004 FROM dzej_t
             WHERE dzej001 = 'qry_sql_sample'
               AND dzej002 = p_sql_sample 

            LET g_dzca_m.dzca003 = l_dzej004
         ELSE
            IF cl_ask_confirm('adz-00060') THEN
               SELECT dzej004 INTO l_dzej004 FROM dzej_t
                WHERE dzej001 = 'qry_sql_sample'
                  AND dzej002 = p_sql_sample 
               LET g_dzca_m.dzca003 = l_dzej004
            END IF
         END IF
      END IF

     #130221 By benson ---- E
   END IF
END FUNCTION

#+ 進行欄位的驗證
PRIVATE FUNCTION adzi210_column_verify(p_dzca003)
   DEFINE p_dzca003      STRING
   DEFINE l_dzca003      base.StringBuffer
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_pass_cnt     LIKE type_t.num5 #計算在sql敘述中欄位的個數
   DEFINE l_not_null_cnt LIKE type_t.num5 #設定欄位的個數
   DEFINE r_value        BOOLEAN

   LET  r_value = FALSE
   LET l_dzca003 = base.StringBuffer.create() 
   CALL l_dzca003.append(p_dzca003)

   #驗證所有設定的外部數是否全部包含在sql敘述中
   FOR l_cnt = 1 TO g_dzcc_d.getLength()

      #計算設定外部變數的個數
      IF g_dzcc_d[l_cnt].dzcc003 IS NOT NULL THEN
         LET l_not_null_cnt = l_not_null_cnt + 1
      END IF
   
      LET l_index = 0
      LET l_index = l_dzca003.getIndexOf(g_dzcc_d[l_cnt].dzcc003, 1)

      #計算在sql敘述符合設定外部變數的個數
      IF l_index >0 THEN
         LET l_pass_cnt = l_pass_cnt + 1
      END IF

      #取代預設的argx的字串
      CALL l_dzca003.replace(g_dzcc_d[l_cnt].dzcc003, "''", 1)
     
   END FOR

   #to do
   #LET l_index = 0 
#
   #驗證sql指令中的所有參數是否全部包含設定的參數
   #LET l_index = l_dzca003.getIndexOf("arg", 1)
  
   #IF l_pass_cnt = l_not_null_cnt THEN
      #LET r_value = TRUE
   #ELSE
      #
      #CALL cl_err_msg(NULL,"adz-00025","", 1)
      #LET r_value = FALSE
   #END IF
#
   #DISPLAY "設定外部變數筆數 = ",l_not_null_cnt
   #DISPLAY "SQL敘述中外部變數比數 = ",l_pass_cnt
   #
   #RETURN r_value
   RETURN TRUE
END FUNCTION

#+ 進行外部變數的驗證
PRIVATE FUNCTION adzi210_arg_verify(p_dzca003)
   DEFINE p_dzca003      STRING
   DEFINE l_dzca003      base.StringBuffer
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_pass_cnt     LIKE type_t.num5 ##計算在sql敘述中外部變數的個數
   DEFINE l_not_null_cnt LIKE type_t.num5 #設定外部變數的個數
   DEFINE r_value        BOOLEAN
   DEFINE l_flag         BOOLEAN

   LET g_auto_genqry = 'Y'                  #130201 By benson 
   LET  r_value = FALSE
   LET l_dzca003 = base.StringBuffer.create() 
   CALL l_dzca003.append(p_dzca003)

   #驗證所有設定的外部數是否全部包含在sql敘述中
   FOR l_cnt = 1 TO g_dzcb_d.getLength()

      #計算設定外部變數的個數
      IF g_dzcb_d[l_cnt].dzcb003 IS NOT NULL THEN
         LET l_not_null_cnt = l_not_null_cnt + 1
      #130201 By benson --- S
      #欄位數不要限制的那麼緊 
      ELSE
         CONTINUE FOR
      #130201 By benson --- E
      END IF
   
      LET l_index = 0
      LET l_index = l_dzca003.getIndexOf("arg"||g_dzcb_d[l_cnt].dzcb003, 1)

      #DISPLAY "l_index = ",l_index

      #計算在sql敘述符合設定外部變數的個數
      IF l_index >0 THEN
         LET l_pass_cnt = l_pass_cnt + 1
      END IF

      #取代預設的argx的字串
      CALL l_dzca003.replace("arg"||g_dzcb_d[l_cnt].dzcb003, "''", 0)  #130201 By benson 
     
   END FOR

   #驗證sql指令中的所有參數是否全部包含設定的參數
   LET l_flag = FALSE
   FOR l_cnt = 1 TO 9
      LET l_index = 0
      LET l_index = l_dzca003.getIndexOf("arg"||l_cnt, 1)

      IF l_index > 0 THEN
         LET l_flag = TRUE
      END IF
      
   END FOR
  #20130522 By cch 
  #SQL指令和參數設定的參數種類的個數完全相同才回傳TRUE
   IF l_pass_cnt = l_not_null_cnt AND l_flag = FALSE THEN    

      LET r_value = TRUE
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00025"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_value = FALSE
   END IF

   #DISPLAY "設定外部變數筆數 = ",l_not_null_cnt
   #DISPLAY "SQL敘述中外部變數比數 = ",l_pass_cnt
   
   RETURN r_value
END FUNCTION

#+ 進行SQL驗證
PRIVATE FUNCTION adzi210_sql_verify(p_dzca003,p_alert)
   DEFINE p_dzca003      STRING
   DEFINE p_alert        BOOLEAN          #TRUE:錯誤訊息彈窗  FALSE:錯誤訊息顯示在背景
   DEFINE l_dzca003      base.StringBuffer
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_err          STRING
   DEFINE r_value        BOOLEAN
   DEFINE l_arg          STRING #20151204
   DEFINE l_today        STRING #20151229
   DEFINE ls_SQLERRMESSAGE STRING #161104-00041

   
   #SQL指令必須是由SELECT 語法開始
   LET p_dzca003 = p_dzca003.trim()
   IF NOT p_dzca003 MATCHES "SELECT *" AND NOT p_dzca003 MATCHES "select *"  THEN
      IF p_alert THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00022"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  " SQL must be 「SELECT xxxxxx」 ! "
         CALL cl_err()
      ELSE 
        #Begin: #160428-00021 modify
        #DISPLAY "ERROR:","adz-00022 ", " SQL must be 「SELECT xxxxxx」 ! "
         LET g_qry_gen_errmsg = "ERROR:","adz-00022 ", " SQL must be 「SELECT xxxxxx」 ! "
         DISPLAY g_qry_gen_errmsg
        #End: #160428-00021 modify
      END IF
      RETURN FALSE
   END IF
   
   #檢查相關tag是否已存在SQL中,避免下面一連串的判斷錯誤
   LET l_err = adzi210_tag_exist(p_dzca003)
   IF l_err IS NOT NULL THEN
      #CALL FGL_WINMESSAGE("ERROR", l_err, "stop")
      IF p_alert THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00022"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_err 
         CALL cl_err()
      ELSE
        #Begin: #160428-00021 modify
        #DISPLAY "ERROR:","adz-00022 ", l_err 
         LET g_qry_gen_errmsg = "ERROR:","adz-00022 ", l_err
         DISPLAY g_qry_gen_errmsg
        #End: #160428-00021 modify
      END IF
      #CALL cl_err('',SQLCA.sqlcode,0)
      RETURN FALSE
   END IF
   
   TRY
 #Begin: 160428-00021 mark & 移到獨立function adzi210_trans_pure_sql()
 ##   LET l_dzca003 = base.StringBuffer.create() 
 ##   CALL l_dzca003.append(p_dzca003)

 ##   LET  r_value = FALSE

 ##   #因為可提供使用者不輸入where條件的開窗SQL,如:
 ##   #SELECT DISTINCT <field>dzeb001</field>
 ##   #  FROM <table>dzeb_t</table>
 ##   #  WHERE <wc></wc>
 ##   #而目前又要求一定要留WHERE <wc></wc>這行字和標籤,以方便後面產生開窗4GL時的判斷
 ##   #所以這裡的驗證SQL就必須要將WHERE <wc></wc>這行字變成空白
 ##   #以免將SQL驗證時,發生 WHERE 後面沒有加條件式的錯誤情況發生
 ##   LET l_index = l_dzca003.getIndexOf(G_WHERE_END.trim(), 1)
 ##   IF l_index > 0 THEN
 ##      #判斷一下開窗SQL是否有WHERE <wc></wc>裡沒有where條件的情況
 ##      #如果有條件會像:WHERE <wc>1=1</wc>
 ##      #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
 ##      IF (l_index - l_dzca003.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
 ##         #因為ls_where是個變數,所以在q_xxx的4gl程式中,加入字串為:[", ls_where CLIPPED, "]
 ##         #這樣產生回開窗程式時字串相加才不會錯,ls_where也才會有作用
 ##         CALL l_dzca003.replace("WHERE", "", 1)
 ##      END IF 
 ##   END IF
 ##
 ##   #為了要進行SQL驗證,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
 ##   CALL l_dzca003.replace(G_FIELD_START, " ", 1)
 ##   CALL l_dzca003.replace(G_FIELD_END, " ", 1) 
 ##   CALL l_dzca003.replace(G_TABLE_START, " ", 1)
 ##   CALL l_dzca003.replace(G_TABLE_END, " ", 1) 
 ##   CALL l_dzca003.replace(G_WHERE_START, " ", 1)
 ##   CALL l_dzca003.replace(G_WHERE_END, " ", 1)
 ##   CALL l_dzca003.replace(G_INWC_START, " ", 1)
 ##   CALL l_dzca003.replace(G_INWC_END, " ", 1)
 ##   
 ##   #henry:替換掉預設的外部變數名稱，避免影響SQL指令的執行
 ##   #20151204 -modify-
 ##   #CALL l_dzca003.replace("arg1", "1", 0)
 ##   #CALL l_dzca003.replace("arg2", "1", 0)
 ##   #CALL l_dzca003.replace("arg3", "1", 0)
 ##   #CALL l_dzca003.replace("arg4", "1", 0)
 ##   #CALL l_dzca003.replace("arg5", "1", 0)
 ##   #CALL l_dzca003.replace("arg6", "1", 0)
 ##   #CALL l_dzca003.replace("arg7", "1", 0)
 ##   #CALL l_dzca003.replace("arg8", "1", 0)
 ##   #CALL l_dzca003.replace("arg9", "1", 0)

 ##   #先將'arg1'   換成 ''
 ##   #再將 arg1 也 換成 ''
 ##   #統一換成''的目的:是解決原本欄位型態NUMBER不能加單引號,VARCHAR要加單引號,但是如果套到IN時,實際上運用有問題
 ##   #                 結論是在sql_verify時統一換成''讓語法檢核ok,實際上用時由開發者在傳遞外部參數時自行決定要不要帶單引號
 ##   FOR l_index = 1 TO 9 
 ##     LET l_arg = "'","arg",l_index USING "<<<<<","'"
 ##     IF l_dzca003.getIndexOf(l_arg, 1) THEN
 ##        CALL l_dzca003.replace(l_arg, "''", 0)
 ##     END IF
 ##     LET l_arg = "arg",l_index USING "<<<<<"
 ##     IF l_dzca003.getIndexOf(l_arg, 1) THEN
 ##        CALL l_dzca003.replace(l_arg, "''", 0)
 ##     END IF
 ##   END FOR
 ##   #20151204 -modify-

 ##   #SQL允許使用的公用變數代碼
 ##   CALL l_dzca003.replace(":DLANG", "'1'", 0)
 ##   CALL l_dzca003.replace(":LANG", "'1'", 0) 
 ##   CALL l_dzca003.replace(":LEGAL", "'1'", 0)
 ##   CALL l_dzca003.replace(":SITE", "'1'", 0)
 ##   CALL l_dzca003.replace(":USER", "'1'", 0)
 ##   CALL l_dzca003.replace(":DEPT", "'1'", 0)
 ##   CALL l_dzca003.replace(":ENT", "'1'", 0)
 ##  #20151229 by madey -modify-
 ##  #CALL l_dzca003.replace(":TODAY", " TO_DATE('2013/11/20','yyyy/mm/dd') ", 0)
 ##  #CALL l_dzca003.replace(":TODAY", "'2013/11/20'", 0)
 ##   LET l_today = cl_get_today_with_format() #ex TO_DATE('2015/01/23','YYYY/MM/DD') 
 ##   CALL l_dzca003.replace(":TODAY",l_today, 0)
 ##  #20151229 by madey -modify-
 ##   
 ##   #另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
 ##   CALL l_dzca003.replace(";", "", 1)
 ##   
 ##   #因為只是為了要驗證SQL是否可以執行正常而已,所以只SELECT第一筆資料
 ##   #這行以後應該要為了支援多種DB TOOL,要進行不同DB TOOL的語法改寫(CASE...WHEN)
 ##   #LET p_dzca003 = "SELECT * FROM (", l_dzca003.toString(), ") WHERE ROWNUM = 1"
 ##   #LET p_dzca003 = "SELECT COUNT(1) FROM (", l_dzca003.toString(), ") "

 ##   LET p_dzca003 = l_dzca003.toString()

 ##   DISPLAY "sql_verify:", p_dzca003
 #End: 160428-00021 mark & 移到獨立function adzi210_trans_pure_sql()

      #Begin: 160428-00021 add
      LET  r_value = FALSE
      LET p_dzca003 = adzi210_trans_pure_sql(p_dzca003)
      #End: 160428-00021 add

      PREPARE chk_sql_pre FROM  p_dzca003
      DECLARE chk_sql_cs CURSOR FOR chk_sql_pre

      OPEN chk_sql_cs
      #實際進行驗證
      #EXECUTE IMMEDIATE p_dzca003

      #MESSAGE 'Verify OK!'                    #130201 By benson 
      
      LET r_value = TRUE

   CATCH
      #todo : 這段程式之後要改.
      LET ls_SQLERRMESSAGE = SQLERRMESSAGE #161104-00041
      LET g_sqlcode = SQLCA.SQLCODE
      IF SQLCA.SQLCODE THEN
         LET g_qry_gen_errmsg = cl_getmsg(SQLCA.SQLCODE,g_lang)," :",ls_SQLERRMESSAGE  #161104-00041 modify
         IF p_alert THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00024"
            LET g_errparam.extend = g_qry_gen_errmsg
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = p_dzca003
            CALL cl_err()
         ELSE
           #DISPLAY "ERROR:","adz-00024 ",p_dzca003
            DISPLAY g_qry_gen_errmsg #160428-00021
         END IF
      ELSE
         IF p_alert THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00023"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  "Please notify administrator." 
            CALL cl_err()
         ELSE
           #DISPLAY "ERROR:","adz-00023", "Please notify administrator." || ";SQL:" || l_dzca003.toString()
            LET g_qry_gen_errmsg = "ERROR:","adz-00023", "Please notify administrator." || ";SQL:" || p_dzca003 #160428-00021
            DISPLAY g_qry_gen_errmsg #160428-00021
         END IF
      END IF
     #DISPLAY "sql for chk = ",p_dzca003 #160428-00021 mark
      LET r_value = FALSE
   END TRY

   FREE chk_sql_cs
   FREE chk_sql_pre 

   RETURN r_value
END FUNCTION

#+ 判斷相關tag,是否存在SQL語句中
PRIVATE FUNCTION adzi210_tag_exist(p_dzca003)    
   DEFINE p_dzca003           LIKE dzca_t.dzca003
   DEFINE lsb_dzca003         base.StringBuffer
   DEFINE l_index             LIKE type_t.num5
   DEFINE ls_err              STRING
   
   LET ls_err = ""
   
   #取得開窗設計器原始SQL
   LET lsb_dzca003 = base.StringBuffer.create() 
   CALL lsb_dzca003.append(p_dzca003 CLIPPED) 

   LET l_index = 0
   LET l_index = lsb_dzca003.getIndexOf(G_FIELD_START, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_FIELD_START, " is not exist!", ASCII 10 END IF

   LET l_index = 0
   LET l_index = lsb_dzca003.getIndexOf(G_FIELD_END, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_FIELD_END, " is not exist!", ASCII 10 END IF

   LET l_index = 0 
   LET l_index = lsb_dzca003.getIndexOf(G_TABLE_START, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_TABLE_START, " is not exist!", ASCII 10 END IF

   LET l_index = 0 
   LET l_index = lsb_dzca003.getIndexOf(G_TABLE_END, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_TABLE_END, " is not exist!", ASCII 10 END IF

   LET l_index = 0 
   LET l_index = lsb_dzca003.getIndexOf(G_WHERE_START, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_WHERE_START, " is not exist!", ASCII 10 END IF

   LET l_index = 0
   LET l_index = lsb_dzca003.getIndexOf(G_WHERE_END, 1)
   IF l_index = 0 THEN LET ls_err = ls_err, G_WHERE_END, " is not exist!", ASCII 10 END IF

   IF ls_err IS NOT NULL THEN
      LET ls_err = "Necessary tag: ", ASCII 10, ls_err
   END IF
   
   RETURN ls_err
END FUNCTION


#+ 進行 command line 的程式執行
PRIVATE FUNCTION adzi210_run_prog(p_shell,p_prog_id,p_arg_str)
   DEFINE p_prog_id      STRING
   DEFINE p_shell        STRING
   DEFINE p_arg_str      STRING
   DEFINE l_cmd          STRING    
   DEFINE l_msg          STRING
   DEFINE l_chk          LIKE type_t.num5

   LET l_cmd = p_shell," ",p_prog_id," ",p_arg_str
   CALL cl_cmdrun_openpipe(p_shell,l_cmd,FALSE) RETURNING l_chk,l_msg
   IF l_chk THEN
      RETURN TRUE
   ELSE 
      LET l_msg = l_cmd , " ",cl_getmsg("adz-00218", g_lang) || "\n"  || l_msg
      IF g_rebuild_all_qry THEN
         LET g_qry_gen_errmsg = l_msg
      ELSE
         CALL sadzi140_rev_view_logresult(l_msg)
      END IF
      RETURN FALSE
   END IF
END FUNCTION

#+ 批次進行rebuild全部的q_xxx開窗程式的4gl和4fd檔的
PRIVATE FUNCTION adzi210_rebuild_all_qry()
   DEFINE  l_dzca001_arr  DYNAMIC ARRAY OF RECORD
           dzca001        LIKE dzca_t.dzca001,
	   dzca002        LIKE dzca_t.dzca002,
           dzca003        LIKE dzca_t.dzca003
   END RECORD
   DEFINE  l_cnt          LIKE type_t.num5,
           li_i           LIKE type_t.num5
   DEFINE  p_dzca001      STRING
   DEFINE  l_err_list     DYNAMIC ARRAY OF RECORD
           err_q_id       LIKE dzca_t.dzca001,
	   err_q_cust_flag  LIKE dzca_t.dzca002,
           err_status     STRING
   END RECORD
   DEFINE  ld_total_s     DATETIME YEAR TO SECOND,#FRACTION(4)
           ld_total_e     DATETIME YEAR TO SECOND #FRACTION(4)
                
   DEFINE  ls_msg         STRING
   DEFINE  ls_cmd         STRING

   LET ld_total_s = cl_get_current()

   #重產qry時:排除hard code,且標準和客製都有時,先抓客製
   LET g_sql = " SELECT UNIQUE dzca001,dzca002,dzca003 ", 
                      " FROM dzca_t ",
                      " INNER JOIN ", 
                          "(SELECT DISTINCT ca1.dzca001 AS dzca001_1,                         ",
                          "       CASE                                                        ",
                          "         WHEN EXISTS (SELECT 1                                     ",#標準跟客製都有,只顯示客製
                          "                 FROM dzca_t ca2                                   ",
                          "                WHERE ca2.dzca001 = ca1.dzca001                    ",
                          "                  AND ca2.dzca002 = 'c') THEN                      ",
                          "          'c'                                                      ",
                          "         ELSE                                                      ",
                          "          's'                                                      ",
                          "       END AS dzca002_1                                            ",
                          "  FROM (SELECT ca0.dzca001, ca0.dzca002 FROM dzca_t ca0) ca1) ca2  ",
                      " ON dzca001 = ca2.dzca001_1 AND dzca002 = ca2.dzca002_1                ",
                      " WHERE dzca006 <>'Y'"
   PREPARE dzca001_pre FROM g_sql   #組合SQL條件

   DECLARE dzca001_curs CURSOR FOR dzca001_pre   #指標指向PREPARE
   CALL l_dzca001_arr.clear()
   LET l_cnt = 1

   LET g_errshow = FALSE
   

   #將dzca001全部的開窗識別碼載入array，每載入一個執行馬上執行rebuild
   FOREACH dzca001_curs INTO l_dzca001_arr[l_cnt].dzca001,l_dzca001_arr[l_cnt].dzca002,l_dzca001_arr[l_cnt].dzca003    #指標依序抓取資料到陣列
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_dzca001_arr.deleteElement(l_cnt)   #刪除內容為空的元素
   LET l_cnt =l_cnt-1

   CALL cl_progress_bar(l_dzca001_arr.getLength() + 1 ) # 加1的原因是最後要加上一個步驟:call s_azzi070_gen_qry
   FOR li_i = 1 TO l_dzca001_arr.getLength()
      CALL cl_progress_ing("[Message] re-gen all qry")

      DISPLAY "call adzi210_sql_verify('",l_dzca001_arr[li_i].dzca001,"')"
      LET g_qry_gen_errmsg = NULL
      IF adzi210_sql_verify(l_dzca001_arr[li_i].dzca003,FALSE) THEN
         LET p_dzca001 = l_dzca001_arr[li_i].dzca001
         IF p_dzca001.getLength() > 0 THEN
            LET ls_cmd = p_dzca001.trim()," ","''"         ," ",g_compile_flag
            IF adzi210_run_prog("r.r","adzp210",ls_cmd) THEN
               #正常
            ELSE
               #異常
               CALL l_err_list.appendElement()
               LET l_err_list[l_err_list.getLength()].err_q_id = l_dzca001_arr[li_i].dzca001
               LET l_err_list[l_err_list.getLength()].err_q_cust_flag = l_dzca001_arr[li_i].dzca002 
               LET l_err_list[l_err_list.getLength()].err_status = "gen qry fail:",g_qry_gen_errmsg
            END IF
         END IF
      ELSE
         CALL l_err_list.appendElement()
         LET l_err_list[l_err_list.getLength()].err_q_id = l_dzca001_arr[li_i].dzca001
         LET l_err_list[l_err_list.getLength()].err_q_cust_flag = l_dzca001_arr[li_i].dzca002 
         LET l_err_list[l_err_list.getLength()].err_status = "sql verify fail:",g_qry_gen_errmsg
      END IF
   END FOR

   IF g_compile_flag THEN
      RUN 'r.l qry'   
      RUN 'r.l cqry'
   END IF
   CALL cl_progress_ing("[Message] re-gen all qry")

   LET ld_total_e = cl_get_current()

   LET g_errshow = TRUE
   IF l_err_list.getLength() > 1 THEN
      LET ls_msg = "process finish with some error"
      LET ls_msg = ls_msg , ASCII  10,"###### SQL ERROR LIST FOR q_*: ######"
      
      FOR li_i = 1 TO l_err_list.getLength()
        #LET ls_msg = ls_msg, ASCII 10, l_err_list[li_i].err_q_id,": SQLCA.SQLCODE = ",l_err_list[li_i].err_status
         LET ls_msg = ls_msg, ASCII 10, l_err_list[li_i].err_q_id,": ",l_err_list[li_i].err_status #160428-00021
      END FOR
   ELSE
      LET ls_msg = "process finish "
   END IF
   LET ls_msg = ls_msg , ASCII  10,ASCII 10,'total qry cnt: ',l_cnt
   LET ls_msg = ls_msg , ASCII  10,'total time used: ',ld_total_s, ' - ',ld_total_e, ' ',ld_total_e - ld_total_s
   DISPLAY ls_msg
   CALL sadzi140_rev_view_logresult(ls_msg)
  
   
END FUNCTION

#+ 取得此欄位的顯示控件
PRIVATE FUNCTION adzi210_widget_type(p_dzcc003)    
   DEFINE p_dzcc003           LIKE dzca_t.dzca003
   DEFINE l_gztd005           LIKE gztd_t.gztd005             #欄位顯示控件
   DEFINE ls_gztd005          STRING
   DEFINE r_dzcc004           LIKE dzcc_t.dzcc004
   
   #帶出此欄位的顯示控件(default值)
   SELECT dzep010 INTO l_gztd005
     FROM dzep_t WHERE dzep002 = p_dzcc003
                        
   LET ls_gztd005 = l_gztd005 CLIPPED

   IF ls_gztd005.getLength()=0 THEN
      LET ls_gztd005 = "05"
   END IF

   #LET ls_gztd005 = ls_gztd005.toLowerCase() 
   
   #目前開窗(sadzp210_4fd)產生4fd還沒有產生 ButtonEdit 和 TextEdit 二種元件
   #所以這裡先把ButtonEdit 和 TextEdit 歸類成Edit(05)
   CASE ls_gztd005
      WHEN "05"
         LET r_dzcc004 = "05" #Edit
      WHEN "02" 
         LET r_dzcc004 = "02" #checkBox
      WHEN "04" 
         LET r_dzcc004 = "04" #DateEdit
      WHEN "03" 
         LET r_dzcc004 = "03" #ComboBox
      OTHERWISE
         LET r_dzcc004 = "05" #Edit
   END CASE

   RETURN r_dzcc004
END FUNCTION

#+ 檢查動態開窗的查詢代碼的以q_開頭
PRIVATE FUNCTION adzi210_chk_dzca001(ps_dzca001,ps_dzca007) #20150114
   DEFINE ps_dzca001 STRING 

   #20150114 -Begin-
   DEFINE ps_dzca007 STRING  #20150114
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
         LET ls_match_cond = 'cq_*' # 開頭必須為cq_xxx
         IF ps_dzca001 MATCHES ls_match_cond THEN 
            #do nothing
         ELSE
            LET lb_chk_header = FALSE
            #adz-00509:命名必須以c%1_xxx開頭
            LET ls_err_header = cl_replace_err_msg(cl_getmsg("adz-00509", g_lang), 'q')
         END IF

         #經討論:客製環境下，新增時:不檢查結尾規則,行業別欄位dzca007固定給sd,且不能改

      OTHERWISE #標準環境
         #檢查開頭
         LET ls_match_cond = 'q_*' # 開頭必須為q_xxx
         IF ps_dzca001 MATCHES ls_match_cond THEN 
            #do nothing
         ELSE
            LET lb_chk_header = FALSE
            #adz-00508:命名必須以%1_xxx開頭
            LET ls_err_header = cl_replace_err_msg(cl_getmsg("adz-00508", g_lang), 'q')
         END IF

         #檢查結尾
         LET ld_industry_data = sadzp210_get_industry_data()
         CASE ps_dzca007
            WHEN 'sd'#標準行業
               FOR li_i = 1 TO ld_industry_data.getLength()
                  IF ld_industry_data[li_i].gzoistus = 'Y' AND ld_industry_data[li_i].gzoi001 <> 'sd' THEN
                     LET ls_match_cond = '*_',ld_industry_data[li_i].gzoi001 # 結尾不可以是xxx_行業別,例如xxx_ph
                     IF ps_dzca001 MATCHES ls_match_cond THEN 
                        LET lb_chk_footer = FALSE
                        #adz-00510:行業別欄位為%1，命名不可以是xxx_%2為結尾
                        LET ls_err_footer = cl_replace_err_msg(cl_getmsg("adz-00510", g_lang), ps_dzca007||'|'||ld_industry_data[li_i].gzoi001)
                        EXIT FOR
                     ELSE
                        #do nothing
                     END IF
                  END IF
               END FOR 
            OTHERWISE #其他行業
               #檢查結尾
               LET ls_match_cond = '*_',ps_dzca007 # 結尾必須是xxx_行業別,例如xxx_ph
               IF ps_dzca001 MATCHES ls_match_cond THEN 
                  #do nothing
               ELSE
                  LET lb_chk_footer = FALSE
                  #adz-00511:行業別欄位為%1，命名必須是xxx_%2為結尾
                  LET ls_err_footer = cl_replace_err_msg(cl_getmsg("adz-00511", g_lang), ps_dzca007||'|'||ps_dzca007)
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
      LET g_errparam.extend = NULL
      LET g_errparam.replace[1] = ls_err_all
      CALL cl_err()
      RETURN FALSE
   END IF

END FUNCTION 


#回傳單身順序(dzcc002)的最大值
PRIVATE FUNCTION adzi210_max_value() 
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE r_max_value  LIKE type_t.num5
   
   FOR l_cnt = 1 TO g_dzcc_d.getLength()
      IF g_dzcc_d[l_cnt].dzcc002 > r_max_value THEN
         LET r_max_value = g_dzcc_d[l_cnt].dzcc002
      END IF
   END FOR

   LET r_max_value = r_max_value + 1
   
   RETURN r_max_value
END FUNCTION

#+ 回傳單身順序(dzcb002)的最大值
PRIVATE FUNCTION adzi210_max_value2() 
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE r_max_value  LIKE type_t.num5
   
   FOR l_cnt = 1 TO g_dzcb_d.getLength()
      IF g_dzcb_d[l_cnt].dzcb002 > r_max_value THEN
         LET r_max_value = g_dzcb_d[l_cnt].dzcb002
      END IF
   END FOR

   LET r_max_value = r_max_value + 1
   
   RETURN r_max_value
END FUNCTION
 
#+ 組合單身開窗畫面顯示的欄位有那些,然後取替代現行的SQL語法中的欄位List
PRIVATE FUNCTION adzi210_dzca003_field_list_replace() 
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_field_list   STRING                #欄位List
   DEFINE l_dzca003      base.StringBuffer
   DEFINE l_spos         LIKE type_t.num5      #'<field>'字元位置
   DEFINE l_epos         LIKE type_t.num5      #'</field>'字元位置
   DEFINE l_replace_str  STRING                #要被取代的字串 
   DEFINE l_dzcc003      LIKE dzcc_t.dzcc003   #暫存欄位代號
   DEFINE l_dzcc008      LIKE dzcc_t.dzcc008   #暫存對應表格別名
   
   LET l_field_list = ""
   LET l_spos = 0
   LET l_epos = 0
   
   #依單身順序將每個欄位組合起來,準備當成SELECT SQL的欄位 LIST
  #130201 By benson --- S
  #換寫法
  #FOR l_i = 1 TO g_dzcc_d.getLength() 
  #    #DISPLAY  "dzcc003:",g_dzcc_d[l_i].dzcc003
  #    IF g_dzcc_d[l_i].dzcc003 IS NOT NULL THEN
  #       LET l_field_list = l_field_list, g_dzcc_d[l_i].dzcc003, ","
  #    END IF
  #END FOR
   DELETE FROM adzi210_tmp
   FOR l_i = 1 TO g_dzcc_d.getLength() 
      IF g_dzcc_d[l_i].dzcc003 IS NOT NULL THEN
         INSERT INTO adzi210_tmp VALUES(g_dzcc_d[l_i].dzcc002,g_dzcc_d[l_i].dzcc003,g_dzcc_d[l_i].dzcc008)
      END IF
   END FOR

   DECLARE adzi210_tmp_cs CURSOR FOR
    SELECT dzcc003,dzcc008 FROM adzi210_tmp
     ORDER BY dzcc002 
   FOREACH adzi210_tmp_cs INTO l_dzcc003, l_dzcc008
      IF cl_null(l_dzcc008) THEN
         LET l_field_list = l_field_list CLIPPED,l_dzcc003,","
      ELSE
         LET l_field_list = l_field_list CLIPPED,l_dzcc008 CLIPPED,".",l_dzcc003,","
      END IF
   END FOREACH

  #130201 By benson --- E
   
   #去除最後一個逗號,欄位用<field></field>這個tag包起來,目前只能判斷小寫,之後應該要做不分大小寫的判斷
   #範例: "<field>dzcc001,dzcc002</field>"
   LET l_field_list = l_field_list.subString(1, l_field_list.getLength() - 1) 
   LET l_field_list = G_FIELD_START, l_field_list.toLowerCase(), G_FIELD_END
   
   #將UI上的SQL語法轉成StringBuffer型態,方便作字串的取替代功能
   LET l_dzca003 = base.StringBuffer.create() 
   CALL l_dzca003.append(g_dzca_m.dzca003)

   #130201 By benson --- S
   #如果<field></field>不成對的話，不做replace的動作
   IF NOT (l_dzca003.getIndexOf(G_FIELD_START, 1) AND l_dzca003.getIndexOf(G_FIELD_END,1)) THEN
      RETURN
   END IF
   #130201 By benson --- E

   #欄位目前是用"<field>", "</field>"的tag包起來的,所以先找出SELECT的欄位開始和結束位置
   LET l_spos = l_dzca003.getIndexOf(G_FIELD_START, 1)
   LET l_epos = l_dzca003.getIndexOf(G_FIELD_END, 1) + G_FIELD_END.getLength() - 1
   
   #有需要被取代和要取代的字串才進行取代動作
   IF l_spos <> 0 AND l_epos <> 0 AND l_field_list IS NOT NULL THEN
      #先找出要被取代的字串
      LET l_replace_str = l_dzca003.subString(l_spos, l_epos) 
      
      #進行取替代動作
      CALL l_dzca003.replace(l_replace_str, l_field_list, 1) 
      LET g_dzca_m.dzca003 = l_dzca003.toString() 
      
      #目前SQL結果暫存,以利繼續使用
      LET g_dzca003_t = g_dzca_m.dzca003
      
      #回饋到UI上
      DISPLAY BY NAME g_dzca_m.dzca003
   END IF
   
END FUNCTION

#130201 By benson --- S
#確認欄位順序代號是否重複
FUNCTION adzi210_chk_dzcc002()
   DEFINE l_i     LIKE type_t.num5

   LET g_errno = ''

   FOR l_i = 1 TO g_dzcc_d.getLength() 
      IF l_i != l_ac THEN
         IF g_dzcc_d[l_ac].dzcc002 = g_dzcc_d[l_i].dzcc002 THEN
            LET g_errno = 'std-00004'
            EXIT FOR
         END IF
      END IF
   END FOR
END FUNCTION

#檢查欄位順序是否重複
FUNCTION adzi210_chk_dzcc003()
   DEFINE l_i     LIKE type_t.num5

   LET g_errno = ''

   FOR l_i = 1 TO g_dzcc_d.getLength() 
      IF l_i != l_ac THEN
         IF g_dzcc_d[l_ac].dzcc003 = g_dzcc_d[l_i].dzcc003 THEN
            LET g_errno = 'adz-00042'
            EXIT FOR
         END IF
      END IF
   END FOR
END FUNCTION

#欄位外部參數是否重複
FUNCTION adzi210_chk_dzcb003()
   DEFINE l_i     LIKE type_t.num5

   LET g_errno = ''

   FOR l_i = 1 TO g_dzcb_d.getLength() 
      IF l_i != l_ac THEN
         IF g_dzcb_d[l_ac].dzcb003 = g_dzcb_d[l_i].dzcb003 THEN
            LET g_errno = 'adz-00041'
            EXIT FOR
         END IF
      END IF
   END FOR
END FUNCTION

#檢查開窗資料是否有程式已使用
FUNCTION adzi210_chk_using(p_cmd)
   DEFINE p_cmd         LIKE type_t.chr1
   DEFINE li_result     LIKE type_t.num5
   DEFINE li_cnt        LIKE type_t.num10
   DEFINE ls_sql        STRING
   DEFINE ls_tag        STRING
   DEFINE ls_msg        STRING
   
   LET li_result = TRUE

   LET li_cnt = adzi210_get_using_cnt(g_dzca_m.dzca001) #20151023 筆數
   IF li_cnt > 0 THEN
      CASE p_cmd
         WHEN "u"
            #CALL cl_ask_confirm_parm('adz-00058',g_dzca_m.dzca001) RETURNING li_result
             LET ls_tag= g_dzca_m.dzca001,'|',li_cnt USING '<<<<<<' #20151023
             LET ls_msg=  cl_replace_err_msg(cl_getmsg('adz-00058',g_lang),ls_tag)
             CALL cl_ask_type1(ls_msg,'') RETURNING li_result
         WHEN "d"
            INITIALIZE g_errparam TO NULL                                                             
            LET g_errparam.code = "adz-00059"
            LET g_errparam.popup = TRUE
            LET g_errparam.TYPE = 1
            LET g_errparam.replace[1]= g_dzca_m.dzca001
            LET g_errparam.replace[2]= li_cnt
            CALL cl_err()
            LET li_result = FALSE
         OTHERWISE #none
      END CASE
   END IF
   RETURN li_result

END FUNCTION

#20150804:此function重寫
###取得使用中的程式清單 #20140930
#FUNCTION adzi210_get_using_list_old()
#   DEFINE p_cmd         LIKE type_t.chr1
#   DEFINE l_dzac001     LIKE dzac_t.dzac001
#   DEFINE l_dzac003     LIKE dzac_t.dzac001
#   DEFINE l_dzac004     LIKE dzac_t.dzac001
#   DEFINE l_dzep001     LIKE dzep_t.dzep001
#   DEFINE l_dzep002     LIKE dzep_t.dzep002
#   DEFINE l_msg         STRING
#   DEFINE l_msg1        STRING
#   DEFINE l_msg2        STRING
#   DEFINE li_result     LIKE type_t.num5
#   DEFINE li_cnt        LIKE type_t.num5
#   DEFINE l_like_dzac099 LIKE type_t.chr100
#   DEFINE ls_sql        STRING
#   DEFINE l_dzbb001     LIKE dzbb_t.dzbb001
#   DEFINE l_like_dzbb098 LIKE type_t.chr100
#   DEFINE l_msg3        STRING
#   
#
#      LET l_msg = ""
#      LET l_msg2 = ""
#      LET l_msg1 = ""
#      LET l_msg3 = ""
#      
#      #20140314:madey:刪除qry時,要檢查dzac_t,dzep_t有沒有人在使用
#      #               修改qry時,不需要檢查dzep_t,因為dzep_t是r.a階段使用,修改qry對此階段來說沒影響
#      
#      #dzac_t:設計資料
#      LET l_like_dzac099 = "%",g_dzca_m.dzca001,"%"
#      LET ls_sql = "SELECT DISTINCT ac1.dzac001",
#                   " FROM dzac_t ac1 ",
#                   "INNER JOIN (SELECT dzaa001,dzaa002,dzaa003,dzaa004,dzaa006",
#                   "              FROM dzaa_t aa3",
#                   "              WHERE aa3.dzaa002 =",
#                   "                    (SELECT MAX(CAST(NVL(TRIM(aa2.dzaa002_01),'0') AS INTEGER))", #20140922 add
#                   "                       FROM (SELECT dzaa001,dzaa002,dzaa003,dzaa004,dzaa006,",
#                   "                                    NVL2(af3.dzaf001,af3.dzaf003,'1') dzaa002_01",
#                   "                               FROM dzaa_t aa1",
#                   "                               LEFT OUTER JOIN (SELECT af1.dzaf001,af1.dzaf003",
#                   "                                                 FROM dzaf_t af1",
#                   "                                                WHERE af1.dzaf002 =",
#                   "                                                      (SELECT MAX(CAST(NVL(TRIM(af2.dzaf002),'0') AS INTEGER)) MAX_var", #20140922 add
#                   "                                                         FROM dzaf_t af2",
#                   "                                                        WHERE af2.dzaf001 =",
#                   "                                                              af1.dzaf001)) af3",
#                   "                                 ON aa1.dzaa001 = af3.dzaf001",
#                   "                                AND aa1.dzaa002 = af3.dzaf003",
#                   "                              WHERE aa1.dzaastus = 'Y'",
#                   "                                AND aa1.dzaa005 = '1') aa2",
#                   "                     WHERE aa2.dzaa001 = aa3.dzaa001)",
#                   "               AND aa3.dzaa005 = '1') aa4",
#                   "    ON aa4.dzaa001 = ac1.dzac001",
#                   "   AND aa4.dzaa003 = ac1.dzac003",
#                   "   AND aa4.dzaa004 = ac1.dzac004",
#                   "   AND aa4.dzaa006 = ac1.dzac012",
#                   " WHERE ac1.dzac009 = '",g_dzca_m.dzca001,"'",
#                   "    OR ac1.dzac010 = '",g_dzca_m.dzca001,"'",
#                   "    OR DBMS_LOB.INSTR(ac1.dzac099,'",g_dzca_m.dzca001,"',1,1) > 0",
#                   " ORDER BY ac1.dzac001"
#      
#      DECLARE adzi210_dzac_cs CURSOR FROM ls_sql
#      FOREACH adzi210_dzac_cs INTO l_dzac001
#         IF cl_null(l_msg1) THEN
#            LET l_msg1 = ASCII 10,"### spec data (dzac_t)###",ASCII 10,l_dzac001 CLIPPED,ASCII 10
#         ELSE
#            LET l_msg1 = l_msg1 CLIPPED,l_dzac001 CLIPPED,ASCII 10
#         END IF
#      END FOREACH
#      FREE adzi210_dzac_cs
#      
#      
#      #dzep_t:adzi150設計資料
#      DECLARE adzi210_dzep_cs CURSOR FOR
#       SELECT DISTINCT dzep001 FROM ds.dzep_t
#        WHERE dzep017 = g_dzca_m.dzca001 OR  dzep018 = g_dzca_m.dzca001
#        ORDER BY dzep001
#      
#      FOREACH adzi210_dzep_cs INTO l_dzep001
#         IF cl_null(l_msg2) THEN
#             LET l_msg2 = ASCII 10,"### adzi150 data (dzep_t) ###",ASCII 10,l_dzep001 CLIPPED,ASCII 10
#         ELSE
#            LET l_msg2 = l_msg2 CLIPPED,l_dzep001 CLIPPED,ASCII 10
#         END IF
#      END FOREACH
#      FREE adzi210_dzep_cs
#      
#      
#      #dzbb_t:add point資料
#      LET ls_sql = "SELECT DISTINCT bb1.dzbb001",
#                   " FROM dzbb_t bb1 ",
#                   "INNER JOIN (SELECT dzba001,dzba002,dzba003,dzba004,dzba005",
#                   "              FROM dzba_t ba3",
#                   "             WHERE ba3.dzba002 =",
#                   "                   (SELECT MAX(CAST(NVL(TRIM(ba2.dzba002_01),'0') AS INTEGER))", #20140922 add
#                   "                      FROM (SELECT dzba001,dzba002,dzba003,dzba004,dzba005,",
#                   "                                   NVL2(af3.dzaf001, af3.dzaf004, '1') dzba002_01",
#                   "                              FROM dzba_t ba1",
#                   "                              LEFT OUTER JOIN (SELECT af1.dzaf001,af1.dzaf004",
#                   "                                                FROM dzaf_t af1",
#                   "                                               WHERE af1.dzaf002 =",
#                   "                                                     (SELECT MAX(CAST(NVL(TRIM(af2.dzaf002),'0') AS INTEGER)) MAX_var", #20140922 add
#                   "                                                        FROM dzaf_t af2",
#                   "                                                       WHERE af2.dzaf001 =",
#                   "                                                             af1.dzaf001)) af3",
#                   "                                ON ba1.dzba001 = af3.dzaf001",
#                   "                               AND ba1.dzba002 = af3.dzaf004",
#                   "                             WHERE ba1.dzbastus = 'Y') ba2",
#                   "                     WHERE ba2.dzba001 = ba3.dzba001)) ba4",
#                   "   ON ba4.dzba001 = bb1.dzbb001",
#                   "  AND ba4.dzba003 = bb1.dzbb002",
#                   "  AND ba4.dzba004 = bb1.dzbb003",
#                   "  AND ba4.dzba005 = bb1.dzbb004",
#                   " WHERE DBMS_LOB.INSTR(bb1.dzbb098,'",g_dzca_m.dzca001,"(',1,1) > 0", #20140930 modify
#                   " ORDER BY bb1.dzbb001"
#      
#      DECLARE adzi210_dzbb_cs CURSOR FROM ls_sql
#      FOREACH adzi210_dzbb_cs INTO l_dzbb001
#         IF cl_null(l_msg3) THEN
#            LET l_msg3 = ASCII 10,"### add-point data (dzbb_t) ###",ASCII 10,l_dzbb001 CLIPPED,ASCII 10
#         ELSE
#            LET l_msg3 = l_msg3 CLIPPED,l_dzbb001 CLIPPED,ASCII 10
#         END IF
#      END FOREACH
#      FREE adzi210_dzbb_cs
#      
#      LET l_msg = l_msg2,l_msg1,l_msg3
#
#      #顯示訊息
#      INITIALIZE g_errparam TO NULL                                                             
#      LET g_errparam.popup = TRUE
#      IF NOT cl_null(l_msg) THEN
#         LET g_errparam.code = "adz-00395"
#         LET g_errparam.EXTEND = "== Using Prog List ==", ASCII 10, l_msg
#      ELSE
#         LET g_errparam.code = "lib-00196"
#      END IF
#      CALL cl_err()
#
#
#END FUNCTION


#取得使用中的程式清單 #20150817
FUNCTION adzi210_get_using_list()
    DEFINE ga_using_list DYNAMIC ARRAY OF type_using_d
    DEFINE ls_sql        STRING
    DEFINE l_gzzl001     LIKE gzzl_t.gzzl001
    DEFINE li_cnt        INTEGER
    DEFINE ls_agli041_flag LIKE type_t.chr1 #是否被agli041使用
    DEFINE ls_azzi650_flag LIKE type_t.chr1 #是否被azzi650使用
    DEFINE l_gzga002       LIKE gzga_t.gzga002
    DEFINE l_gzad007       LIKE gzad_t.gzad007


  TRY

    
    #是否被agli041使用 
    LET ls_sql = "SELECT COUNT (*)                  ",
                 "  FROM (SELECT UNIQUE gzag002 FROM dsdata.gzag_t WHERE gzag002 IS NOT NULL)",
                 " WHERE gzag002 =?"
    LET l_gzga002 = g_dzca_m.dzca001
    LET li_cnt=0
    PREPARE adzi210_chk_agli041 FROM ls_sql                                                                           
    EXECUTE adzi210_chk_agli041 USING l_gzga002 INTO li_cnt
    FREE adzi210_chk_agli041
    IF li_cnt > 0 THEN
       LET ls_agli041_flag = 'Y'
    ELSE
       LET ls_agli041_flag = 'N'
    END IF

    #是否被azzi650使用
    LET ls_sql = "SELECT COUNT (*)                  ",
                 "  FROM (SELECT UNIQUE gzad007 FROM gzad_t WHERE gzad007 IS NOT NULL UNION SELECT UNIQUE gzaj007 FROM gzaj_t WHERE gzaj007 IS NOT NULL)",
                 " WHERE gzad007 =?"
    LET l_gzad007 = g_dzca_m.dzca001
    LET li_cnt=0
    PREPARE adzi210_chk_azzi650 FROM ls_sql                                                                           
    EXECUTE adzi210_chk_azzi650 USING l_gzad007 INTO li_cnt
    FREE adzi210_chk_azzi650
    IF li_cnt > 0 THEN
       LET ls_azzi650_flag = 'Y'
    ELSE
       LET ls_azzi650_flag = 'N'
    END IF
    
    LET ls_sql = "SELECT gz1.gzzl001,                                      ",
                 "       DECODE(gzzal003, NULL, gzjal003, gzzal003) AS bbb ",
                 "  FROM gzzl_t gz1                                        ",
                 "  LEFT JOIN gzza_t                                       ",
                 "    ON gzza001 = gz1.gzzl001                             ",
                 "  LEFT JOIN gzja_t                                       ",
                 "    ON gzja001 = gz1.gzzl001                             ",
                 "  LEFT JOIN gzzal_t                                      ",
                 "    ON gzzal001 = gz1.gzzl001                            ",
                 "   AND gzzal002 = '",g_dlang,                           "'",
                 "  LEFT JOIN gzjal_t                                      ",
                 "    ON gzjal001 = gz1.gzzl001                            ",
                 "   AND gzjal002 = '",g_dlang,                           "'",
                 " WHERE gz1.gzzl002 = ?                                    ",
                 "   AND gz1.gzzl001 <> 'adzp260'                           ",
                 " ORDER by gz1.gzzl001                                     "
      DECLARE adzi210_gzzl_cs CURSOR FROM ls_sql
     
      LET li_cnt=1
      CALL ga_using_list.CLEAR()
      FOREACH adzi210_gzzl_cs USING g_dzca_m.dzca001 INTO ga_using_list[li_cnt].*
        LET li_cnt= li_cnt +1
      END FOREACH
      CALL ga_using_list.deleteElement(li_cnt) 
      LET li_cnt= li_cnt - 1

      ##顯示
      IF ga_using_list.getlength() >0 THEN 
         OPEN WINDOW w_using_list WITH FORM cl_ap_formpath("adz","adzi210_s01")
             #ATTRIBUTE(STYLE="viewer")
         CALL cl_ui_init()
         
         DISPLAY g_dzca_m.dzca001, ls_agli041_flag, ls_azzi650_flag TO s_q_id, s_agli041_flag , s_azzi650_flag
         DISPLAY li_cnt TO formonly.count    #顯示總筆數 #20151023
         
         DISPLAY ARRAY ga_using_list TO s_adzi210_using.* ATTRIBUTE(COUNT=li_cnt,UNBUFFERED)
         
            ON ACTION EXIT
               EXIT DISPLAY
         
            ON ACTION exporttoexcel
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(ga_using_list)
               LET g_export_id[1] = "s_adzi210_using"
               CALL cl_export_to_excel_getpage() #160902-00041
               CALL cl_export_to_excel()
         
            #交談指令共用ACTION
            &include "common_action.4gl" 
               CONTINUE DISPLAY 
         END DISPLAY
         
         CLOSE WINDOW w_using_list
      ELSE
         CALL cl_ask_pressanykey("lib-00196")#無資料
      END IF
  

  CATCH
      DISPLAY "sqlca.sqlcode=",sqlca.sqlcode

  END TRY


END FUNCTION


FUNCTION adzi210_initial_combobox_sql()
  LET ms_SQL_Sample = "SELECT ZO.DZEJL002  MODULE_NAME,     ",
                      "       ZO.DZEJL004  MODULE_DESC      ",
                      "  FROM DZEJL_T ZO                    ",
                      #" WHERE ZO.DZEJL001 = 'sql_sample'    ",
                      " WHERE ZO.DZEJL001 = 'qry_sql_sample'    ", #2015/04/23 by Hiko
                      "   AND ZO.DZEJL003 = '",g_lang,"'   ",
                      " ORDER BY ZO.DZEJL002                "

  #Begin:2015/04/23 by Hiko
  #LET ms_SQL_Global_var = "SELECT ZO.DZEJL002  MODULE_NAME,     ",
  #                        "       ZO.DZEJL004  MODULE_DESC      ",
  #                        "  FROM DZEJL_T ZO                    ",
  #                        " WHERE ZO.DZEJL001 = 'global_var'    ",
  #                        "   AND ZO.DZEJL003 = '",g_lang,"'   ",
  #                        " ORDER BY ZO.DZEJL002                "
  #End:2015/04/23 by Hiko:改用scc

END FUNCTION

FUNCTION adzi210_fill_combobox(p_Combobox,p_SQL)
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
    CALL p_Combobox.addItem(ls_Combobox.Combobox_NAME,ls_Combobox.Combobox_DESC)
    LET li_Count = li_Count + 1
  END FOREACH  

  FREE lcur_Combobox
  FREE lpre_Combobox

END FUNCTION
#130201 By benson --- E


#+ 確認實體4gl及4fd檔案必須存在                 #20150701 add
PRIVATE FUNCTION adzi210_check_file_exists()
   DEFINE l_str         STRING
   DEFINE l_dzca002     LIKE dzca_t.dzca002                                                                   
   DEFINE l_gzzn001     LIKE gzzn_t.gzzn001
   DEFINE l_4fd_file    STRING
   DEFINE l_4gl_file    STRING
   DEFINE lb_return     BOOLEAN
   DEFINE lb_result     BOOLEAN
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE lb_have_cust  BOOLEAN
   DEFINE l_extend_msg  STRING

   LET lb_return = TRUE
  
   #確認4fd及4gl確實存在
   #若有客製資料,則模組指定為cqry,否則為qry
    CALL sadzp210_check_qry_have_cust(g_dzca_m.dzca001) RETURNING li_cnt ,lb_have_cust
    IF lb_have_cust THEN
       LET l_str = g_cust_module
       LET l_dzca002 = 'c'
    ELSE
       LET l_str = g_std_module
       LET l_dzca002 = 's'
    END IF
    LET l_gzzn001 = l_str.toUpperCase()
    LET l_4fd_file = os.Path.JOIN(os.Path.JOIN(FGL_GETENV(l_gzzn001),'4fd'),g_dzca_m.dzca001||'.4fd')
    LET l_4gl_file = os.Path.JOIN(os.Path.JOIN(FGL_GETENV(l_gzzn001),'4gl'),g_dzca_m.dzca001||'.4gl')
    IF NOT os.path.EXISTS(l_4fd_file) THEN
       LET l_extend_msg = cl_getmsg('adz-00539',g_lang) #請先在非Hard Code的情況下，讓r.q(adzi210)正常產生開窗查詢函式，才可轉成Hard Code。
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code =  "adz-00339" #  %1檔案不存在.
       LET g_errparam.extend = l_extend_msg
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = l_4fd_file 
       CALL cl_err()
       LET lb_return = FALSE
       GOTO _RETURN_FLAG 
    END IF

    IF NOT os.path.EXISTS(l_4gl_file) THEN
       LET l_extend_msg = cl_getmsg('adz-00539',g_lang) #請先在非Hard Code的情況下，讓r.q(adzi210)正常產生開窗查詢函式，才可轉成Hard Code。
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code =  "adz-00339" # %1檔案不存在.
       LET g_errparam.extend = l_extend_msg
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = l_4gl_file 
       CALL cl_err()
       LET lb_return = FALSE
       GOTO _RETURN_FLAG 
    END IF


  LABEL _RETURN_FLAG :
   RETURN lb_return

END FUNCTION 


#+ 依據hard code或非hard code，控制某些欄位可否輸入 #20150701
PRIVATE FUNCTION adzi210_set_disable_for_hardcode()

  ###除了hard code=Y要隱藏外，其餘情況要打開
  ###20140314:madey -start-
  ##IF g_dzca_m.dzca006="Y" THEN 
  ##   CALL cl_set_comp_visible("grid2,grid4,grid6,grid7",FALSE)
  ##   CALL cl_set_act_visible("gen_hardcode",TRUE) 
  ##ELSE 
  ##   CALL cl_set_comp_visible("grid2,grid4,grid6,grid7",TRUE)
  ##   CALL cl_set_act_visible("gen_hardcode", FALSE) 
  ##END IF
  ###20140314:madey -end-
END FUNCTION



#20150701
#+ 將qry由客製還原標準
PRIVATE FUNCTION adzi210_cust_to_std()
   DEFINE li_dzca_cnt    SMALLINT,    #有幾筆dzca資料
          lb_have_cust   BOOLEAN,     #此開窗是否客製
          lb_std_to_cust BOOLEAN,     #此開窗為標準轉客製
          l_str          STRING
   DEFINE ls_cmd         STRING,
          ls_path        STRING
   DEFINE lb_result      BOOLEAN,
          ls_err_msg     STRING,
          l_regen_type   LIKE type_t.chr1
   DEFINE ls_tag         STRING
   DEFINE ls_msg         STRING
   DEFINE li_cnt         LIKE type_t.num10


   #客製環境下，才可執行此功能
   IF g_dgenv = "c" THEN
      #do noghing
   ELSE
      CALL cl_ask_pressanykey("adz-00599") 
      RETURN
   END IF

   #確認此qry是否客製,是否由標準轉客製
   CALL sadzp210_check_qry_have_cust(g_dzca_m.dzca001) RETURNING li_dzca_cnt,lb_have_cust
   IF lb_have_cust AND li_dzca_cnt > 1 THEN
      LET lb_std_to_cust = TRUE 
   ELSE
      LET lb_std_to_cust = FALSE 
   END IF

   #非標準轉客製，擋下來
   IF NOT lb_std_to_cust THEN 
      CALL cl_ask_pressanykey("adz-00546") 
      RETURN
   END IF

   #Hard Code=Y ,擋下來,由adzp063處理
   IF g_dzca_m.dzca006 = 'Y' THEN
      CALL cl_ask_pressanykey("adz-00560")
      RETURN
   END IF

   LET li_cnt = adzi210_get_using_cnt(g_dzca_m.dzca001) #20151023 筆數
   LET ls_tag= g_dzca_m.dzca001,'|',li_cnt USING '<<<<<<'
   LET ls_msg=  cl_replace_err_msg(cl_getmsg('adz-00719',g_lang),ls_tag)
   IF cl_ask_type1(ls_msg,'') THEN
      BEGIN WORK
      #刪除r.q設計資料
      CALL sadzp210_del_qry_design_data(g_dzca_m.dzca001,g_dzca_m.dzca002) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
        ROLLBACK WORK
        RETURN
      ELSE
        COMMIT WORK
      END IF
         
      #刪除實體檔案 (只刪客製)
      CALL sadzp210_del_qry_file(g_dzca_m.dzca001,'c')

      #重產qry相關檔案
      #1.重新產生一份4gl,4fd到標準目錄下並r.c
      #2.重新呼叫gen q_total:因為會檢查42m在不在並重產q_total,最後再做r.l qry cqry
      CALL cl_progress_bar(2)
      CALL cl_progress_ing("[Message] gen qry、link qry")  

      LET g_qry_gen_qtotal = "Y"
      IF NOT sadzp210_generate_qry(g_dzca_m.dzca001) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00125"
         LET g_errparam.extend = g_qry_gen_errmsg
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         DISPLAY 'call sadzp210_generate_qry() Success!'
      END IF
      RUN 'r.l cqry' #160223-00028  #補做cqry ,在sadzp210_generate_qry已經有call r.l qry
      CALL cl_progress_ing("[Message] gen qry、link qry")  
      
      #彈窗顯示成功 #20151023
      LET ls_msg = cl_getmsg('adz-00579',g_lang), #客製還原標準完成
                   ASCII 10,
                   cl_replace_err_msg(cl_getmsg('adz-00720',g_lang),g_dzca_m.dzca001)  #r.l xxx ALL
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00023"
      LET g_errparam.replace[1] = ls_msg
      LET g_errparam.popup = TRUE
      LET g_errparam.type = 2
      CALL cl_err()
   END IF

END FUNCTION

#20150701
#+ r.q由標準 -> 客製
PRIVATE FUNCTION adzi210_std_to_cust()
   DEFINE l_newno     LIKE dzca_t.dzca001 
   DEFINE l_oldno     LIKE dzca_t.dzca001 
   
   DEFINE l_old_cust_flag LIKE dzca_t.dzca002
   DEFINE l_new_cust_flag LIKE dzca_t.dzca002
   
   DEFINE l_master    RECORD LIKE dzca_t.*
   DEFINE l_detail    RECORD LIKE dzcc_t.*
   DEFINE l_detail2   RECORD LIKE dzcb_t.*
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5    
   DEFINE l_new_hardcode   LIKE dzca_t.dzca006  #20150701
   DEFINE l_old_hardcode   LIKE dzca_t.dzca006  #20150701
   DEFINE lb_result   BOOLEAN
   DEFINE ls_err_msg  STRING
   DEFINE ls_tag      STRING
   DEFINE ls_msg      STRING
   DEFINE li_cnt      LIKE type_t.num10


   #客製環境下，才可執行此功能
   IF g_dgenv = "c" THEN
      #do noghing
   ELSE
      CALL cl_ask_pressanykey("adz-00599") 
      RETURN
   END IF

   IF g_dzca_m_t.dzca006 = "Y" THEN
     CALL cl_ask_pressanykey("adz-00557") #此開窗已Hard Code，若要標準轉客製，請透過下載程式(adzp050)簽出
     RETURN
   END IF

   LET l_new_cust_flag = "c"
   LET l_newno = g_dzca_m.dzca001

   SELECT COUNT(*) INTO l_n FROM dzca_t WHERE dzca001 = l_newno
                                          AND dzca002 = l_new_cust_flag
   #客製資料已存在
   IF l_n > 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code =  "std-00006"
       LET g_errparam.extend = l_newno
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
   END IF

   LET li_cnt = adzi210_get_using_cnt(g_dzca_m.dzca001)   #20151023 筆數
   LET ls_tag= g_dzca_m.dzca001,'|',li_cnt USING '<<<<<<'
   LET ls_msg=  cl_replace_err_msg(cl_getmsg('adz-00719',g_lang),ls_tag)
   IF cl_ask_type1(ls_msg,'') THEN
      #複製r.q設計資料
      BEGIN WORK
      CALL sadzp210_copy_qry_from_std_to_cust(g_dzca_m.dzca001) RETURNING lb_result,ls_err_msg
      IF NOT lb_result THEN
        ROLLBACK WORK
        RETURN
      ELSE
        COMMIT WORK
      END IF
      
      #重產qry相關檔案
      #1.重新產生一份4gl,4fd到客製目錄下並r.c
      #2.重新呼叫gen q_total:因為會檢查42m在不在並重產q_total,最後再做r.l qry cqry
      CALL cl_progress_bar(2) 
      CALL cl_progress_ing("[Message] gen qry、link qry")  

      LET g_qry_gen_qtotal = "Y"
      IF NOT sadzp210_generate_qry(l_newno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00125"
         LET g_errparam.extend = g_qry_gen_errmsg
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         DISPLAY 'call sadzp210_generate_qry() Success!'
      END IF
      RUN 'r.l qry' #160223-00028 #補做qry ,在sadzp210_generate_qry已經有call r.l cqry
      CALL cl_progress_ing("[Message] gen qry、link qry")  
      
      #彈窗顯示成功 #20151023
      LET ls_msg = cl_getmsg('adz-00549',g_lang), #標準轉客製完成
                   ASCII 10,
                   cl_replace_err_msg(cl_getmsg('adz-00720',g_lang),g_dzca_m.dzca001)  #r.l xxx ALL
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00023"
      LET g_errparam.replace[1] = ls_msg
      LET g_errparam.popup = TRUE
      LET g_errparam.type = 2
      CALL cl_err()
      
   END IF
   
END FUNCTION

#+ 確認是否有order by語法 #20151005
PRIVATE FUNCTION adzi210_order_by_verify(p_dzca003)
  DEFINE p_dzca003    LIKE dzca_t.dzca003
  DEFINE ls_str       STRING
  DEFINE lb_result    BOOLEAN

  LET lb_result = TRUE
  LET ls_str = p_dzca003
  LET ls_str = ls_str.trim()
  LET ls_str = ls_str.toUpperCase()
  IF ls_str MATCHES "*ORDER*BY*" THEN
     #do nothing
  ELSE
    CALL cl_ask_pressanykey('adz-00715')
    LET lb_result = FALSE
  END IF

  RETURN lb_result

END FUNCTION

#取得開窗資料被幾支程式使用 #20151023
FUNCTION adzi210_get_using_cnt(p_dzca001)
   DEFINE p_dzca001     LIKE dzca_t.dzca001
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE ls_sql        STRING
   

  TRY
   LET li_cnt=0
   LET ls_sql  = "SELECT COUNT(1) FROM gzzl_t gz1",
                 " WHERE gz1.gzzl002='",p_dzca001,"'",
                 "   AND gz1.gzzl001 <> 'adzp260'"
                #"   AND NOT EXISTS(",                              #剔除q_total()
                #"            SELECT gz2.gzzl001 FROM gzzl_t gz2",
                #"             WHERE gz2.gzzl001 = gz1.gzzl001",
                #"               AND gz2.gzzl002 in ('q_total','q_agli041','q_azzi650'))"  

   PREPARE adzi210_gzzl_cnt FROM ls_sql
   EXECUTE adzi210_gzzl_cnt INTO li_cnt
   FREE adzi210_gzzl_cnt
   RETURN li_cnt


  CATCH
      DISPLAY 'ERROR: CALL adzi210_get_using_cnt() fail, sql=',ls_sql,' err=',cl_getmsg(SQLCA.sqlcode,g_lang)
      RETURN 0

  END TRY

END FUNCTION

#160428-00021 #此段落從原本adzi210_sql_verify()獨立出來
#+ 把sql中的tag都拿掉
PRIVATE FUNCTION adzi210_trans_pure_sql(p_dzca003)
   DEFINE p_dzca003      STRING
   DEFINE r_dzca003      STRING
   DEFINE l_dzca003      base.StringBuffer
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_err          STRING
   DEFINE r_value        BOOLEAN
   DEFINE l_arg          STRING
   DEFINE l_today        STRING 
   

   LET l_dzca003 = base.StringBuffer.create() 
   CALL l_dzca003.append(p_dzca003)

   LET  r_value = FALSE

   #因為可提供使用者不輸入where條件的開窗SQL,如:
   #SELECT DISTINCT <field>dzeb001</field>
   #  FROM <table>dzeb_t</table>
   #  WHERE <wc></wc>
   #而目前又要求一定要留WHERE <wc></wc>這行字和標籤,以方便後面產生開窗4GL時的判斷
   #所以這裡的驗證SQL就必須要將WHERE <wc></wc>這行字變成空白
   #以免將SQL驗證時,發生 WHERE 後面沒有加條件式的錯誤情況發生
   LET l_index = l_dzca003.getIndexOf(G_WHERE_END.trim(), 1)
   IF l_index > 0 THEN
      #判斷一下開窗SQL是否有WHERE <wc></wc>裡沒有where條件的情況
      #如果有條件會像:WHERE <wc>1=1</wc>
      #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
      IF (l_index - l_dzca003.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
         #因為ls_where是個變數,所以在q_xxx的4gl程式中,加入字串為:[", ls_where CLIPPED, "]
         #這樣產生回開窗程式時字串相加才不會錯,ls_where也才會有作用
         CALL l_dzca003.replace("WHERE", "", 1)
      END IF 
   END IF
   
   #為了要進行SQL驗證,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
   CALL l_dzca003.replace(G_FIELD_START, " ", 1)
   CALL l_dzca003.replace(G_FIELD_END, " ", 1) 
   CALL l_dzca003.replace(G_TABLE_START, " ", 1)
   CALL l_dzca003.replace(G_TABLE_END, " ", 1) 
   CALL l_dzca003.replace(G_WHERE_START, " ", 1)
   CALL l_dzca003.replace(G_WHERE_END, " ", 1)
   CALL l_dzca003.replace(G_INWC_START, " ", 1)
   CALL l_dzca003.replace(G_INWC_END, " ", 1)
   
   #henry:替換掉預設的外部變數名稱，避免影響SQL指令的執行
   #20151204 -modify-
   #先將'arg1'   換成 ''
   #再將 arg1 也 換成 ''
   #統一換成''的目的:是解決原本欄位型態NUMBER不能加單引號,VARCHAR要加單引號,但是如果套到IN時,實際上運用有問題
   #                 結論是在sql_verify時統一換成''讓語法檢核ok,實際上用時由開發者在傳遞外部參數時自行決定要不要帶單引號
   FOR l_index = 1 TO 9 
     LET l_arg = "'","arg",l_index USING "<<<<<","'"
     IF l_dzca003.getIndexOf(l_arg, 1) THEN
        CALL l_dzca003.replace(l_arg, "''", 0)
     END IF
     LET l_arg = "arg",l_index USING "<<<<<"
     IF l_dzca003.getIndexOf(l_arg, 1) THEN
        CALL l_dzca003.replace(l_arg, "''", 0)
     END IF
   END FOR
   #20151204 -modify-

   #SQL允許使用的公用變數代碼
   CALL l_dzca003.replace(":DLANG", "'1'", 0)
   CALL l_dzca003.replace(":LANG", "'1'", 0) 
   CALL l_dzca003.replace(":LEGAL", "'1'", 0)
   CALL l_dzca003.replace(":SITE", "'1'", 0)
   CALL l_dzca003.replace(":USER", "'1'", 0)
   CALL l_dzca003.replace(":DEPT", "'1'", 0)
   CALL l_dzca003.replace(":ENT", "'1'", 0)
  #20151229 by madey -modify-
   LET l_today = cl_get_today_with_format() #ex TO_DATE('2015/01/23','YYYY/MM/DD') 
   CALL l_dzca003.replace(":TODAY",l_today, 0)
  #20151229 by madey -modify-
   
   #另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
   CALL l_dzca003.replace(";", "", 1)
   
   #因為只是為了要驗證SQL是否可以執行正常而已,所以只SELECT第一筆資料
   #這行以後應該要為了支援多種DB TOOL,要進行不同DB TOOL的語法改寫(CASE...WHEN)
   #LET p_dzca003 = "SELECT * FROM (", l_dzca003.toString(), ") WHERE ROWNUM = 1"
   #LET p_dzca003 = "SELECT COUNT(1) FROM (", l_dzca003.toString(), ") "

   LET r_dzca003 = l_dzca003.toString()

   DISPLAY "trans_pure_sql=",ASCII 10, r_dzca003
   RETURN r_dzca003

END FUNCTION


#160428-00021
#新增此function而沒有直接放進去adzi210_sql_verify()的原因:
#是有幾個功能都會呼叫到sql_verify，不是每個功能都要提示cartesian,綁在一起不彈性
#+ 進行cartesian 驗證
PRIVATE FUNCTION adzi210_chk_cartesian(p_dzca003,p_alert)
   DEFINE p_dzca003      STRING
   DEFINE p_alert        BOOLEAN          #TRUE:錯誤訊息彈窗  FALSE:錯誤訊息顯示在背景
   DEFINE l_index        LIKE type_t.num5
   DEFINE l_err          STRING
   DEFINE r_value        BOOLEAN
   DEFINE l_arg          STRING 
   DEFINE l_today        STRING
   DEFINE l_sql          STRING

   
   LET p_dzca003 = p_dzca003.trim()

   IF p_dzca003.getIndexOf("arg", 1) THEN
      #有帶arg參數的，因為預設驗證是給'',有可能會導致驗證不準，所以先by pass當作ok
      LET r_value = FALSE
   ELSE
      LET l_sql = adzi210_trans_pure_sql(p_dzca003)
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
PRIVATE FUNCTION adzi210_chk_sql_all_qry()
   DEFINE  l_dzca001_arr  DYNAMIC ARRAY OF RECORD
           dzca001        LIKE dzca_t.dzca001,
	   dzca002        LIKE dzca_t.dzca002,
           dzca003        LIKE dzca_t.dzca003
   END RECORD
   DEFINE  l_cnt          LIKE type_t.num5,
           li_i           LIKE type_t.num5
   DEFINE  p_dzca001      STRING
   DEFINE  l_err_list     DYNAMIC ARRAY OF RECORD
           err_q_id       LIKE dzca_t.dzca001,
	   err_q_cust_flag  LIKE dzca_t.dzca002,
           err_status     STRING
   END RECORD
   DEFINE  ld_total_s     DATETIME YEAR TO SECOND,#FRACTION(4)
           ld_total_e     DATETIME YEAR TO SECOND #FRACTION(4)
                
   DEFINE  ls_msg         STRING
   DEFINE  ls_cmd         STRING

   LET ld_total_s = cl_get_current()

   #排除hard code,且標準和客製都有時,先抓客製
   LET g_sql = " SELECT UNIQUE dzca001,dzca002,dzca003 ", 
                      " FROM dzca_t ",
                      " INNER JOIN ", 
                          "(SELECT DISTINCT ca1.dzca001 AS dzca001_1,                         ",
                          "       CASE                                                        ",
                          "         WHEN EXISTS (SELECT 1                                     ",#標準跟客製都有,只顯示客製
                          "                 FROM dzca_t ca2                                   ",
                          "                WHERE ca2.dzca001 = ca1.dzca001                    ",
                          "                  AND ca2.dzca002 = 'c') THEN                      ",
                          "          'c'                                                      ",
                          "         ELSE                                                      ",
                          "          's'                                                      ",
                          "       END AS dzca002_1                                            ",
                          "  FROM (SELECT ca0.dzca001, ca0.dzca002 FROM dzca_t ca0) ca1) ca2  ",
                      " ON dzca001 = ca2.dzca001_1 AND dzca002 = ca2.dzca002_1                ",
                      " WHERE dzca006 <>'Y'"
   PREPARE dzca001_pre01 FROM g_sql   #組合SQL條件

   DECLARE dzca001_curs01 CURSOR FOR dzca001_pre01   #指標指向PREPARE
   CALL l_dzca001_arr.clear()
   LET l_cnt = 1

   LET g_errshow = FALSE
   

   #將dzca001全部的開窗識別碼載入array，每載入一個執行馬上執行
   FOREACH dzca001_curs01 INTO l_dzca001_arr[l_cnt].dzca001,l_dzca001_arr[l_cnt].dzca002,l_dzca001_arr[l_cnt].dzca003    #指標依序抓取資料到陣列
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_dzca001_arr.deleteElement(l_cnt)   #刪除內容為空的元素
   LET l_cnt =l_cnt-1

   CALL cl_progress_bar(l_dzca001_arr.getLength()) 
   FOR li_i = 1 TO l_dzca001_arr.getLength()
      CALL cl_progress_ing("[Message] chk sql for all qry")

      DISPLAY "call adzi210_sql_verify('",l_dzca001_arr[li_i].dzca001,"')"
      LET g_qry_gen_errmsg = NULL
      IF NOT adzi210_sql_verify(l_dzca001_arr[li_i].dzca003,FALSE) THEN
         CALL l_err_list.appendElement()
         LET l_err_list[l_err_list.getLength()].err_q_id = l_dzca001_arr[li_i].dzca001
         LET l_err_list[l_err_list.getLength()].err_q_cust_flag = l_dzca001_arr[li_i].dzca002 
         LET l_err_list[l_err_list.getLength()].err_status = "sql verify fail:",g_qry_gen_errmsg
         CONTINUE FOR
      END IF
      IF adzi210_chk_cartesian(l_dzca001_arr[li_i].dzca003,FALSE) THEN 
         CALL l_err_list.appendElement()
         LET l_err_list[l_err_list.getLength()].err_q_id = l_dzca001_arr[li_i].dzca001
         LET l_err_list[l_err_list.getLength()].err_q_cust_flag = l_dzca001_arr[li_i].dzca002 
         LET l_err_list[l_err_list.getLength()].err_status = "chk_cartesian fail"
         CONTINUE FOR
      END IF
      DISPLAY "chk sql ok:",l_dzca001_arr[li_i].dzca001
   END FOR


   LET ld_total_e = cl_get_current()

   LET g_errshow = TRUE
   IF l_err_list.getLength() > 1 THEN
      LET ls_msg = "process finish with some error"
      LET ls_msg = ls_msg , ASCII  10,"###### SQL ERROR LIST FOR q_*: ######"
      
      FOR li_i = 1 TO l_err_list.getLength()
         LET ls_msg = ls_msg, ASCII 10, l_err_list[li_i].err_q_id,": ",l_err_list[li_i].err_status
      END FOR
   ELSE
      LET ls_msg = "process finish "
   END IF
   LET ls_msg = ls_msg , ASCII  10,ASCII 10,'total qry cnt: ',l_cnt
   LET ls_msg = ls_msg , ASCII  10,'total time used: ',ld_total_s, ' - ',ld_total_e, ' ',ld_total_e - ld_total_s
   DISPLAY ls_msg
   CALL sadzi140_rev_view_logresult(ls_msg)
END FUNCTION
