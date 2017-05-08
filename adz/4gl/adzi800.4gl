{<section id="adzi800.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000114
#+ 
#+ Filename...: adzi800
#+ Description: 開發需求單 
#+ Creator....: 02431(2014/12/16)
#+ Modifier...: 02431(2014/12/16)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}

#add-point:填寫註解說明
#141216-00004#2  2016/02/19  By laura 匯入區域不需等待adzp999完成後才更新,直接匯入立即更新成 I:簽入
#161006-00009#1  2016/10/11  By laura 1)匯出 選擇[取消],則會 匯出失敗
#                                     2)匯出最後 下載路徑 選擇[取消],則會 未選擇下載路徑
#161012-00031#1  2016/10/12  By laura 1)打包增加檢核adzi800_pack_chk() 列出打包環境 大於該單建構項版次   訊息提示
#                                     2)增加結案button增加詢問確認,下拉選項無法直接結案
#                                     3)解包檢核調整
#161005-00011#1  2016/11/28  By laura 1)adzi800_db_check_table_lock()  檢核匯入的table在目前系統是是否lock  訊息提示
#                                     2)單身加上construct查詢
#                                     3)排序by 需求單號 desc
#                                     4)q_adzi800挑選作業編號將原本僅讀azzi910調整成azzi910,azzi901,azzi900,azzi700
#161223-00031#1  2016/12/23  By laura 1)匯出及匯入檢核增加r.l xxx ALL的檢核 訊息提示及錯誤控卡
#                                     2)打包及解包log檔名加上時分秒
#170111-00064#1  2017/01/11  By laura 調整查詢控卡 
#170208-00023#1  2017/02/08  By laura 調整dzlr010發起日修改模式不允許修改及不變更值,dzlr010發起日僅在開單給予值
#end add-point

 
    
IMPORT os
IMPORT util
IMPORT security
IMPORT FGL lib_cl_dlg
IMPORT XML

SCHEMA ds 
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp000_type.inc"
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzi800_global.inc"
GLOBALS
   DEFINE g_notneed_labeltag   BOOLEAN
END GLOBALS

#模組變數(Module Variables)
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_forupd_sql          STRING
DEFINE g_sql                 STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500)     #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500)     #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500)     #同步資料用陣列
DEFINE g_insert              LIKE type_t.chr5                  #是否導到其他page
DEFINE g_cnt                 LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num5
DEFINE l_ac2                 LIKE type_t.num5
DEFINE l_ac3                 LIKE type_t.num5
DEFINE l_ac4                 LIKE type_t.num5
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_bfill               LIKE type_t.chr5                  #是否刷新單身
DEFINE g_aw                  STRING                            #確定當下點擊的單身
DEFINE g_current_page        LIKE type_t.num5                  #目前所在頁數
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
DEFINE g_export_flag         LIKE type_t.chr1                  #是否已經註冊資訊匯出              
DEFINE g_order               STRING                            #查詢排序欄位
DEFINE g_default             BOOLEAN                           #是否有外部參數查詢
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                            #單身CONSTRUCT結果
DEFINE g_dzlm_wc             STRING                            #單身dzlm CONSTRUCT結果
DEFINE g_dzld_wc             STRING                            #單身dzld CONSTRUCT結果
DEFINE g_dzlf_wc             STRING                            #單身dzlf CONSTRUCT結果
DEFINE g_browser_cnt         LIKE type_t.num5                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5                  #Browser目前所在筆數
DEFINE g_detail_cnt          LIKE type_t.num5
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_state               STRING
DEFINE g_current_row         LIKE type_t.num5                  #Browser所在筆數
DEFINE g_page_action         STRING                            #page ACTION
DEFINE g_pagestart           LIKE type_t.num5
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5  


DEFINE g_dzlr001_no          LIKE dzlr_t.dzlr001


DEFINE l_pack_dir      STRING
DEFINE l_pack_tar      STRING

#單頭 type 宣告
PRIVATE TYPE type_g_dzlr_m RECORD
       dzlr001      LIKE dzlr_t.dzlr001,     #需求單號
       dzlr008      LIKE dzlr_t.dzlr008,     #發起人 
       dzlr008_desc LIKE type_t.chr500,      #發起人姓名
       dzlr010      LIKE dzlr_t.dzlr010,     #發起日
       dzlr007      LIKE dzlr_t.dzlr007,     #作業代號
       dzlr007_desc LIKE type_t.chr500,      #作業名稱
       dzlr009      LIKE dzlr_t.dzlr009,     #需求摘要
       dzlr011      LIKE dzlr_t.dzlr011,     #承辦人
       dzlr011_desc LIKE type_t.chr500,      #承辦人姓名
       dzlr013      LIKE dzlr_t.dzlr013,     #預完日
       dzlr014      LIKE dzlr_t.dzlr014,     #實完日
       dzlr012      LIKE dzlr_t.dzlr012,     #處理摘要
       dzlr005      LIKE dzlr_t.dzlr005,     #階段
       dzlr006      LIKE dzlr_t.dzlr006,     #前階
       dzlr015      LIKE dzlr_t.dzlr015      #開發日誌
       END RECORD

PRIVATE TYPE type_g_dzlr_browser RECORD
       dzlr001      LIKE dzlr_t.dzlr001      #需求單號
      #dzlr001      LIKE dzlr_t.dzlr001,     #需求單號
      #dzlr008      LIKE dzlr_t.dzlr008,     #發起人 
      #dzlr010      LIKE dzlr_t.dzlr010,     #發起日
      #dzlr007      LIKE dzlr_t.dzlr007,     #作業代號
      #dzlr007_desc LIKE type_t.chr500,      #作業名稱
      #dzlr009      LIKE dzlr_t.dzlr009,     #需求摘要
      #dzlr011      LIKE dzlr_t.dzlr011,     #承辦人
      #dzlr013      LIKE dzlr_t.dzlr013,     #預完日
      #dzlr014      LIKE dzlr_t.dzlr014,     #實完日
      #dzlr012      LIKE dzlr_t.dzlr012,     #處理摘要
      #dzlr005      LIKE dzlr_t.dzlr005,     #階段
      #dzlr006      LIKE dzlr_t.dzlr006,     #前階
      #dzlr015      LIKE dzlr_t.dzlr015      #開發日誌
       END RECORD


#單身 type 宣告
PRIVATE TYPE type_g_dzlg_d RECORD
       dzlg001      LIKE dzlg_t.dzlg001,      #需求單號
       dzlg004      LIKE dzlg_t.dzlg004,      #項次
       dzlg005      LIKE dzlg_t.dzlg005,      #作業代號
       dzlg005_desc LIKE type_t.chr500,       #作業名稱
       dzlg006      LIKE dzlg_t.dzlg006,      #SD
       dzlg006_desc LIKE type_t.chr500,       #SD姓名
#                                      
       dzlg007      LIKE dzlg_t.dzlg007,      #PR
       dzlg007_desc LIKE type_t.chr500,       #PR姓名
       dzlg008      LIKE dzlg_t.dzlg008,      #預完日
       dzlg009      LIKE dzlg_t.dzlg009,      #實完日
       dzlg010      LIKE dzlg_t.dzlg010       #進度%
       END RECORD

PRIVATE TYPE type_g_dzlm_d RECORD
       dzlmseq      LIKE type_t.num5,        #序號
       dzlm001      LIKE type_t.chr10,       #建構類型
       dzlm002      LIKE type_t.chr20,       #建構代號
       dzlm003      LIKE type_t.chr200,      #建構名稱
       dzlm004      LIKE type_t.chr10,       #模組
       dzlm005      LIKE type_t.num10,       #建構版號
       dzlm006      LIKE type_t.num10,       #SD版號
       dzlm009      LIKE type_t.num10,       #PR版號
       dzlm008      LIKE type_t.chr1,        #SD狀態
       dzlm011      LIKE type_t.chr1         #PR狀態
       END RECORD

PRIVATE TYPE type_g_dzld_d RECORD
       dzld002      LIKE type_t.num5,        #序號
       dzld003      LIKE type_t.chr20,       #作業代號
       dzld004      LIKE type_t.chr1,        #匯入動作(1:Merge; 2:Insert; 3:Delete) 
       dzld005      LIKE type_t.chr20,       #維護作業 
       dzld015      LIKE type_t.chr1,        #資料類別(m:單頭主項; d:單身子項)
       dzld006      LIKE type_t.chr50,       #條件式1 
       dzld007      LIKE type_t.chr50        #條件式2
       END RECORD

PRIVATE TYPE type_g_dzlf_d RECORD
       dzlf002      LIKE type_t.num5,        #序號
       dzlf003      LIKE type_t.chr200,      #路徑(exp:/u1/{ZONE}/erp/cfg/4st)
       dzlf004      LIKE type_t.chr1,        #類型(f:檔案; d:整個目錄結構)
       dzlf005      LIKE type_t.chr50        #檔名
       END RECORD

PRIVATE TYPE type_g_dzlr_udzlr RECORD
       dzlr005           LIKE dzlr_t.dzlr005,     #現階
       status_h          LIKE type_t.chr1,        #狀態
       dzlr005_next      LIKE dzlr_t.dzlr005,     #下階
       dzlr015           LIKE dzlr_t.dzlr015      #開發日誌
       END RECORD

PRIVATE TYPE type_g_dzlm_ver RECORD
       dzlm001           LIKE dzlm_t.dzlm001,     #建構類型
       dzlm002           LIKE dzlm_t.dzlm002,     #建構代號
       dzlm004           LIKE dzlm_t.dzlm004      #模組
       END RECORD
#161012-00031#1
PRIVATE TYPE type_l_dzlm_chk RECORD
          dzlm012           LIKE dzlm_t.dzlm012,     #需求單號
          dzlm013           LIKE dzlm_t.dzlm013,     #產品代號
          dzlm014           LIKE dzlm_t.dzlm014,     #產品版本
          dzlm015           LIKE dzlm_t.dzlm015,     #項次
          dzlm001           LIKE dzlm_t.dzlm001,     #建構類型
          dzlm002           LIKE dzlm_t.dzlm002,     #建構代號
          dzlm005           LIKE dzlm_t.dzlm005,     #建構版本
          dzlm007           LIKE dzlm_t.dzlm007,     #SD
          dzlm008           LIKE dzlm_t.dzlm008,     #SD狀態
          dzlm010           LIKE dzlm_t.dzlm010,     #PR
          dzlm011           LIKE dzlm_t.dzlm011      #PR狀態
       END RECORD

DEFINE g_dzlr_udzlr        type_g_dzlr_udzlr

DEFINE g_dzlr_m             type_g_dzlr_m
DEFINE g_dzlr_m_t           type_g_dzlr_m

DEFINE g_dzlg_d             DYNAMIC ARRAY OF type_g_dzlg_d
DEFINE g_dzlg_d_t           type_g_dzlg_d
DEFINE g_dzlm_d             DYNAMIC ARRAY OF type_g_dzlm_d
DEFINE g_dzlm_d_t           type_g_dzlm_d
DEFINE g_dzld_d             DYNAMIC ARRAY OF type_g_dzld_d
DEFINE g_dzld_d_t           type_g_dzld_d
DEFINE g_dzlf_d             DYNAMIC ARRAY OF type_g_dzlf_d
DEFINE g_dzlf_d_t           type_g_dzlf_d
DEFINE g_dzlm_p             DYNAMIC ARRAY OF type_g_dzlm_ver   
DEFINE g_dzlm_t             DYNAMIC ARRAY OF type_g_dzlm_ver  
DEFINE g_dzafs              DYNAMIC ARRAY OF T_DZAF_T


DEFINE g_rec                LIKE type_t.num5 
DEFINE g_rec_b              LIKE type_t.num5 
DEFINE g_rec_b2             LIKE type_t.num5 
DEFINE g_rec_b3             LIKE type_t.num5 
DEFINE g_rec_b4             LIKE type_t.num5 
DEFINE g_detail_idx1        LIKE type_t.num5              #單身1目前所在筆數
DEFINE g_detail_idx2        LIKE type_t.num5              #單身2目前所在筆數
DEFINE g_detail_idx3        LIKE type_t.num5              #單身3目前所在筆數
DEFINE g_detail_idx4        LIKE type_t.num5              #單身4目前所在筆數
DEFINE g_dzlr001_t          LIKE dzlr_t.dzlr001           #需求單號
DEFINE g_dzlr002            LIKE dzlr_t.dzlr002           #產品代號
DEFINE g_dzlr003            LIKE dzlr_t.dzlr003           #產品版本
DEFINE g_dzlr004            LIKE dzlr_t.dzlr004           #客戶代號 
DEFINE g_dzlr_browser       DYNAMIC ARRAY OF type_g_dzlr_browser
DEFINE g_dzlr011_s          STRING
DEFINE g_detail_insert      LIKE type_t.num5                #可新增否 
DEFINE g_detail_delete      LIKE type_t.num5                #可新增否 
DEFINE g_work_dir           STRING
DEFINE g_pack_path          STRING
DEFINE g_pack_path1         STRING
DEFINE g_pack_path2         STRING
DEFINE g_fname              STRING
DEFINE g_fnamer             STRING
DEFINE g_fnameg             STRING
DEFINE g_fnamem             STRING
DEFINE g_fnamed             STRING
DEFINE g_fnamef             STRING
DEFINE g_fname_t            STRING
DEFINE g_dst                STRING
DEFINE g_alm_s              STRING
DEFINE g_cust               STRING
DEFINE g_env                STRING
DEFINE g_file               STRING
DEFINE g_unpack_folder      STRING
DEFINE g_chk                LIKE type_t.chr1
DEFINE g_no                 LIKE dzlr_t.dzlr001

#161223-00031#1 ---s
DEFINE g_dzlm_rl            DYNAMIC ARRAY OF type_g_dzlm_ver     
DEFINE g_result             STRING
DEFINE g_all_result         STRING
DEFINE g_all_log            STRING

DEFINE g_errlog_file        STRING
DEFINE g_log_file           STRING
DEFINE gs_time              STRING

DEFINE g_errlog_path     STRING
DEFINE g_log_path        STRING
#161223-00031#1 ---e

#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN

   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz", "")
   #CALL cl_tool_init()
   #CALL cl_db_connect("ds", FALSE)

   LET g_bgjob = 'N'    #cl_ap_init() 無給g_bgjob 預設值

   #LOCK CURSOR (identifier)
   LET g_forupd_sql = "SELECT dzlr001, dzlr008, dzlr010, dzlr007, dzlr009, ",
                      "       dzlr011, dzlr013, dzlr014, dzlr012, dzlr005, ",
                      "       dzlr006, dzlr015 ",
                      "  FROM dzlr_t ",
                      "  WHERE dzlr001 = ? AND dzlr002 = ? AND dzlr003 = ? FOR UPDATE "
   
   DECLARE adzi800_cl CURSOR FROM g_forupd_sql                   # LOCK CURSOR
 
   LET g_sql = "SELECT dzlr001, dzlr008,'', dzlr010, dzlr007,'', dzlr009, ",
               "       dzlr011,'', dzlr013, dzlr014, dzlr012, dzlr005, ",
               "       dzlr006, dzlr015 ",
               "  FROM dzlr_t ",
               "  WHERE dzlr001 = ? AND dzlr002 = ? AND dzlr003 = ? "

   PREPARE adzi800_dzlr_referesh FROM g_sql
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi800 WITH FORM cl_ap_formpath("adz", g_code)
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   IF NOT adzi800_init() THEN
      RETURN
   END IF

   CALL adzi800_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_adzi800
   
   CLOSE adzi800_cl
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN

#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi800_init()
   DEFINE l_sql             STRING
  


   LET g_alm_s = NULL
   LET g_cust  = NULL
   LET g_env   = NULL
  ##欲啟用開發需求管理, 請先 環境變數TOPALM設定成"Y" !
   LET g_alm_s = FGL_GETENV("TOPALM")   
  #IF g_alm_s = 'Y' THEN
  #ELSE 
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code =  "adz-00503"
  #   LET g_errparam.extend = ""
  #   LET g_errparam.popup = TRUE
  #   LET g_errparam.replace[1] =  g_alm_s
  #   LET g_errparam.replace[2] =  ''
  #   CALL cl_err()
  #   EXIT PROGRAM
  #END IF

   #20160719開發環境變數,用於dzlr001 需求單號第一碼
   LET g_env = FGL_GETENV("DGENV")     

  ##僅能在客戶環境使用(DGENV='c')
  #LET g_cust = FGL_GETENV("DGENV")     
  #IF g_cust <> 'c' OR cl_null(g_cust)  THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code =  "adz-00504"
  #   LET g_errparam.extend = ""
  #   LET g_errparam.popup = TRUE
  #   LET g_errparam.replace[1] =  g_cust
  #   LET g_errparam.replace[2] =  '' 
  #   CALL cl_err()
  #   EXIT PROGRAM
  #END IF

 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   LET g_show_msg = "Y"        #GUI模式操作
   LET g_bfill = "Y"
   LET g_detail_idx1 = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx3 = 1
   LET g_detail_idx4 = 1
   LET g_error_show = 1

   CALL adzi800_01_init()

   #如果為標準環境,需和ALM需求單結合
   IF g_alm_jb = g_dgenv_s THEN
      LET g_export_flag = TRUE
   ELSE
      LET g_export_flag = FALSE
   END IF
   
   #設定程式類型Items(gzca001=138)
   CALL cl_set_combo_scc("master005", 138)

  #CALL adzi800_dzld005_items_fill()

   #階段
   CALL cl_set_combo_scc('dzlr005','1209')   #161012-00031#1
   CALL cl_set_combo_scc('dzlr006','1209')   #161012-00031#1
   IF NOT adzi800_dzld005_items_fill() THEN  #161005-00011#1
      RETURN FALSE
   END IF

   CALL adzi800_refill_combobox(g_lang)

   RETURN TRUE
END FUNCTION


#+ 設定屬於註冊資料的維護作業有那些
#RIVATE FUNCTION adzi800_dzld005_items_fill()
#  DEFINE l_sql             STRING
#  DEFINE l_dzld005_value   STRING
#  DEFINE l_dzld005_label   STRING
#  DEFINE l_gzzal001        LIKE gzzal_t.gzzal001
#  DEFINE l_gzzal003        LIKE gzzal_t.gzzal003

#  LET l_dzld005_value = ""
#  LET l_dzld005_label = ""

#  #設定程式註冊資料來源的維護作業有那些

#  LET l_sql = "SELECT gzzal001, gzzal003 ",
#              "  FROM gzzal_t ",
#              "  WHERE gzzal001 IN (SELECT DISTINCT dzyb001 FROM dzyb_t ",
#              "                       WHERE dzyb001 NOT IN ('adzp444', 'adzp445')) ",
#              "    AND gzzal002 = ? ",
#              "  ORDER BY gzzal001 "

#  #DGENV=c 環境提供設計資料的過單
#  IF g_alm_jb = g_dgenv_c THEN
#     LET l_sql = "SELECT gzzal001, gzzal003 ",
#                 "  FROM gzzal_t ",
#                 "  WHERE (gzzal001 IN (SELECT DISTINCT dzyb001 FROM dzyb_t) OR gzzal001 = 'adzi140')",
#                 "    AND gzzal002 = ? ",
#                 "  ORDER BY gzzal001 "
#  END IF

#  PREPARE adzi800_dzld005_pre FROM l_sql
#  DECLARE adzi800_dzld005_cs CURSOR FOR adzi800_dzld005_pre

#  IF SQLCA.sqlcode THEN
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.code =  SQLCA.sqlcode
#     LET g_errparam.extend = 'PREPARE adzi800_dzld005_cs:'
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#    #RETURN FALSE
#  END IF

#  OPEN adzi800_dzld005_cs USING g_lang
#  IF SQLCA.sqlcode THEN
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.code =  STATUS
#     LET g_errparam.extend = "OPEN adzi800_dzld005_cs:"
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#     CLOSE adzi800_dzld005_cs
#    #RETURN FALSE
#  END IF

#  FOREACH adzi800_dzld005_cs INTO l_gzzal001, l_gzzal003
#     IF SQLCA.sqlcode THEN
#        INITIALIZE g_errparam TO NULL
#        LET g_errparam.code =  SQLCA.sqlcode
#        LET g_errparam.extend = "FOREACH adzi800_dzld005_cs:"
#        LET g_errparam.popup = TRUE
#        CALL cl_err()
#       #RETURN FALSE
#     END IF

#     #維護作業程式代號
#     IF cl_null(l_dzld005_value) THEN
#        LET l_dzld005_value = l_gzzal001
#     ELSE
#        LET l_dzld005_value = l_dzld005_value, ",", l_gzzal001
#     END IF

#     #items說明
#     IF cl_null(l_dzld005_label) THEN
#        LET l_dzld005_label = l_gzzal001, "(", l_gzzal003, ")"
#     ELSE
#        LET l_dzld005_label = l_dzld005_label, ",", l_gzzal001, "(", l_gzzal003, ")"
#     END IF
#  END FOREACH

#  #設定匯入動作
#  CALL cl_set_combo_items("dzld005", l_dzld005_value, l_dzld005_label)

# #RETURN TRUE
#ND FUNCTION  


#+ 功能選單
PRIVATE FUNCTION adzi800_ui_dialog()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_chk_fg            LIKE type_t.chr1   


   CALL cl_set_act_visible("accept,cancel", FALSE)

   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice = "insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL adzi800_insert()
         END IF
         
      OTHERWISE
         
   END CASE
   
   LET lb_first = TRUE

   WHILE TRUE 
   
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_dzlr_browser.getLength()
            IF g_dzlr_browser[li_idx].dzlr001 = g_dzlr001_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         DISPLAY ARRAY g_dzlg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1
            BEFORE ROW
               CALL adzi800_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx1 = l_ac
               CALL adzi800_b_fill2()

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL adzi800_idx_chk()

            ON ACTION modify_detail
               LET g_action_choice = "modify_detail"
               DISPLAY "XXdetail:",g_action_choice
               IF g_dzlr_m.dzlr005 = 'ZZ' THEN
                  EXIT DIALOG
               END IF
               IF cl_auth_chk_act("modify") THEN
                  LET g_aw = g_curr_diag.getCurrentItem()
                  CALL adzi800_modify()
                  EXIT DIALOG
               END IF
         END DISPLAY

         DISPLAY ARRAY g_dzlm_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1
            BEFORE ROW
               CALL adzi800_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               CALL adzi800_idx_chk()
         END DISPLAY

         DISPLAY ARRAY g_dzld_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page1
            BEFORE ROW
               CALL adzi800_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx3 = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx3)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               CALL adzi800_idx_chk()
               
         END DISPLAY

         DISPLAY ARRAY g_dzlf_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b4)  
            BEFORE ROW
               CALL adzi800_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx4 = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx4)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               CALL adzi800_idx_chk()
               
         END DISPLAY

         BEFORE DIALOG
           

           #LET g_curr_diag = ui.DIALOG.getCurrent()
           #CALL DIALOG.setSelectionMode("s_detail1", 1)
           ##如果為標準環境,需和ALM需求單結合
           #IF g_alm_jb = g_dgenv_c THEN
           #   CALL cl_set_comp_visible("GridT_quantity", FALSE)
           #   CALL cl_set_act_visible("query", FALSE)
           #END IF
   
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()

            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_row = g_current_idx #目前指標
            
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            
           #IF g_current_idx > g_dzld_browser.getLength() THEN
           #   LET g_current_idx = g_dzld_browser.getLength()
           #END IF 
            
           ##有資料才進行fetch
           #IF g_current_idx <> 0 THEN
           #   CALL adzi800_fetch('') # reload data
           #END IF
            
            IF g_dzlr_m.dzlr001 IS NOT NULL THEN
               CALL adzi800_show()
            END IF
            
            CALL adzi800_ui_detailshow()

            #筆數顯示
            LET g_current_page = 1
            CALL adzi800_idx_chk()

            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD dzlg004 
            END IF

         ON ACTION CLOSE
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION EXIT
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION INSERT
            LET g_action_choice = "insert"
            IF cl_auth_chk_act("insert") THEN
              #20160719取消g_cust='c'的限制,開放客戶環境以外的也可以建立小型管
              #IF g_alm_s = 'Y'  AND g_cust = 'c' THEN
               IF g_alm_s = 'Y'  THEN
                  CALL adzi800_insert()
                  EXIT DIALOG
               ELSE
                  INITIALIZE g_errparam TO NULL
                 #LET g_errparam.code =  "adz-00650"
                  LET g_errparam.code =  "adz-00651"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  g_alm_s
                  LET g_errparam.replace[2] =  ''
                  CALL cl_err()
                  EXIT DIALOG
               END IF
            END IF

         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               INITIALIZE g_wc TO NULL
               INITIALIZE g_wc2 TO NULL
               CALL adzi800_query()
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
            END IF

         ON ACTION delete

            LET g_action_choice="delete"
            #161012-00031#1
            IF g_dzlr_m.dzlr005 = 'ZZ' THEN
               LET g_errparam.code =  "adz-01017"  #adz-01017 %1已結案不允許異動
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  g_dzlr_m.dzlr001
               CALL cl_err()
               EXIT DIALOG
            END IF
            #161012-00031#1

            IF cl_auth_chk_act("delete") THEN
              #20160719取消g_cust='c'的限制,開放客戶環境以外的也可以建立小型管
              #IF g_alm_s = 'Y'  AND g_cust = 'c' THEN
               IF g_alm_s = 'Y'  THEN
                  IF adzi800_del_chk(g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,'') THEN
                     CALL adzi800_delete()
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "adz-00540"
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                 #LET g_errparam.code =  "adz-00650"
                  LET g_errparam.code =  "adz-00651"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  g_alm_s
                  LET g_errparam.replace[2] =  ''
                  CALL cl_err()
                  EXIT DIALOG
               END IF
            END IF
 
         ON ACTION MODIFY
            LET g_action_choice = "modify"
           #IF g_dzlr_m.dzlr005 = 'ZZ' THEN
           #   EXIT DIALOG
           #END IF
            #161012-00031#1 
            IF g_dzlr_m.dzlr005 = 'ZZ' THEN
               LET g_errparam.code =  "adz-01017"  #adz-01017 %1已結案不允許異動
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  g_dzlr_m.dzlr001
               CALL cl_err()
               EXIT DIALOG
            END IF
            #161012-00031#1 
            IF cl_auth_chk_act("modify") THEN
              #20160719取消g_cust='c'的限制,開放客戶環境以外的也可以建立小型管
              #IF g_alm_s = 'Y'  AND g_cust = 'c' THEN
               IF g_alm_s = 'Y'  THEN
                  LET g_aw = ''
                  CALL adzi800_modify()
                  EXIT DIALOG
               ELSE
                  INITIALIZE g_errparam TO NULL
                 #LET g_errparam.code =  "adz-00650"
                  LET g_errparam.code =  "adz-00651"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  g_alm_s
                  LET g_errparam.replace[2] =  ''
                  CALL cl_err()
                  EXIT DIALOG
               END IF
            END IF
   
         ON ACTION FIRST
            CALL adzi800_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi800_idx_chk()
            
         ON ACTION PREVIOUS
            CALL adzi800_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi800_idx_chk()
            
         ON ACTION jump
            CALL adzi800_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi800_idx_chk()
            
         ON ACTION NEXT
            CALL adzi800_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi800_idx_chk()
            
         ON ACTION LAST
            CALL adzi800_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzi800_idx_chk()

         #匯出設計及設定資料
         ON ACTION pack
           #20160719取消g_cust='c'的限制,開放客戶環境以外的也可以建立小型管
           #IF g_alm_s = 'Y'  AND g_cust = 'c' THEN
            IF g_alm_s = 'Y'  THEN
              #IF NOT cl_null(g_dzlr_m.dzlr001) THEN
                  #161012-00031#1
                  IF NOT adzi800_pack_chk()  THEN  #打包檢核 列出打包環境 大於該單建構項版次   訊息提示    1
                     #檢核出 打包環境 大於該單建構項版次
                     IF NOT  cl_ask_confirm_parm("adz-01019",g_dzlr_m.dzlr001)  THEN   #需求單%1是否繼續打包?
                        EXIT DIALOG
                     END IF
                  END IF
                  #161012-00031#1
                 #CALL adzi800_pack()
                  IF NOT adzi800_pack() THEN
                     LET g_errparam.code =  "adz-00702"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = FALSE 
                     LET g_errparam.replace[1] = g_dzlr_m.dzlr001 
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
              #END IF
            ELSE
               INITIALIZE g_errparam TO NULL
              #LET g_errparam.code =  "adz-00650"
               LET g_errparam.code =  "adz-00651"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  g_alm_s
               LET g_errparam.replace[2] =  ''
               CALL cl_err()
               EXIT DIALOG
            END IF

         #匯入設計及設定資料
         ON ACTION unpack
            LET g_action_choice="unpack"
           #IF cl_auth_chk_act("unpack") THEN
              #IF g_cust = 'c' THEN
                  CALL adzi800_unpack_chk() RETURNING l_chk_fg
                  IF l_chk_fg = 'Y' THEN
                    #CALL adzi800_unpack()
                     IF adzi800_unpack() THEN
                        CALL cl_ask_pressanykey("adz-00217")   ---成功
                     END IF
                     IF NOT cl_null(g_no) THEN
                        LET g_wc = " dzlr001 = '",g_no,"'"
                     END IF
                    #CALL sadzp000_msg_show_info(NULL, 'adz-00703', g_no, 0) -- 匯入成功
                    #LET g_errparam.code =  "adz-00703"
                    #LET g_errparam.extend = ""
                    #LET g_errparam.popup = TRUE
                    #LET g_errparam.replace[1] =  g_no
                    #CALL cl_err()
                     LET g_dzlm_wc = ' 1=1'     #161223-00031#1
                     LET g_dzld_wc = ' 1=1'     #161223-00031#1
                     LET g_dzlf_wc = ' 1=1'     #161223-00031#1
                     CALL adzi800_query()
                     CALL g_curr_diag.setCurrentRow("s_detail1",1)
                     CALL g_curr_diag.setCurrentRow("s_detail2",1)
                     CALL g_curr_diag.setCurrentRow("s_detail3",1)
                     CALL g_curr_diag.setCurrentRow("s_detail4",1)
                  END IF
                  LET g_action_choice = "upload_data"
                  LET g_export_flag = TRUE
              #ELSE
              #   DISPLAY "TEST!!!"
              #   INITIALIZE g_errparam TO NULL
              #   LET g_errparam.code =  "adz-00651"
              #   LET g_errparam.extend = ""
              #   LET g_errparam.popup = TRUE
              #   LET g_errparam.replace[1] =  g_alm_s
              #   LET g_errparam.replace[2] =  ''
              #   CALL cl_err()
              #   EXIT DIALOG
              #END IF
           #END IF

        ##更新階段
        #ON ACTION update_dzlr
        #  #20160719取消g_cust='c'的限制,開放客戶環境以外的也可以建立小型管
        #  #IF g_alm_s = 'Y'  AND g_cust = 'c' THEN
        #   IF g_alm_s = 'Y'  THEN
        #      CALL adzi800_udzlr()
        #   ELSE
        #      INITIALIZE g_errparam TO NULL
        #     #LET g_errparam.code =  "adz-00650"
        #      LET g_errparam.code =  "adz-00651"
        #      LET g_errparam.extend = ""
        #      LET g_errparam.popup = TRUE
        #      LET g_errparam.replace[1] =  g_alm_s
        #      LET g_errparam.replace[2] =  ''
        #      CALL cl_err()
        #      EXIT DIALOG
        #   END IF            

         #161012-00031#1
         ON ACTION update_zz
            IF g_dzlr_m.dzlr005 = 'ZZ' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-01020"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = g_dzlr_m.dzlr001 
               CALL cl_err()
               EXIT DIALOG
            END IF
            IF cl_ask_confirm("adz-01014") THEN   #結案即簽入,確認是否結案?
               CALL s_transaction_begin()
               LET g_dzlr_m.dzlr005 = 'ZZ'
               UPDATE dzlr_t SET dzlr005 = g_dzlr_m.dzlr005
               WHERE dzlr001 = g_dzlr_m.dzlr001 AND dzlr002 = g_dzlr002 AND dzlr003 = g_dzlr003
               #檢核當階段為zz時即更新狀態為[I:簽入]
               CALL adzi800_zz(g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,g_dzlr_m.dzlr005) RETURNING g_chk
               IF g_chk = 'Y' THEN
                  CALL s_transaction_end('Y','0')
                  LET g_errparam.code =  "adz-01016"    #結案(%1)成功
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzlr_m.dzlr001
                  CALL cl_err()
                  DISPLAY BY NAME g_dzlr_m.dzlr005
                  DISPLAY "zz I success!!"
               ELSE
                  CALL s_transaction_end('N', '0')
                  LET g_errparam.code =  "adz-01015"    #結案(%1)失敗
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_dzlr_m.dzlr001
                  CALL cl_err()
                  LET g_dzlr_m.dzlr005 = g_dzlr_m_t.dzlr005 
                  DISPLAY BY NAME g_dzlr_m.dzlr005
                  DISPLAY "NOT zz can't update !!"
               END IF
            END IF
            EXIT DIALOG
         #161012-00031#1

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
               
      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
     #   #尚未將此匯出包資訊做任何存檔(匯出),尋問是否真的放棄此次資訊
     #   IF NOT g_export_flag AND (g_dzlr_m.dzlr001 IS NOT NULL) THEN
     #      IF NOT cl_ask_confirm("adz-00344") THEN
     #         CONTINUE WHILE 
     #      END IF
     #   END IF
     
         EXIT WHILE
      END IF  
   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

#+ 資料新增
PRIVATE FUNCTION adzi800_insert()

   #清畫面欄位內容
   CLEAR FORM
   
   CALL g_dzlg_d.CLEAR()

   INITIALIZE g_dzlr_m TO NULL
   LET g_dzlr001_t = NULL

   LET g_insert = 'Y'
  #20160719需求單號第1碼改參考DGENV
  #LET g_dzlr_m.dzlr001 = g_today USING 'CYYMMDD' CLIPPED,"-"
   LET g_dzlr_m.dzlr001 = g_env,g_today USING 'YYMMDD' CLIPPED,"-"
   LET g_dzlr_m_t.dzlr001 = g_dzlr_m.dzlr001
   CALL cl_get_para("","","A-SYS-0032") RETURNING g_dzlr011_s
   IF cl_null(g_dzlr011_s) THEN
      LET g_dzlr_m.dzlr011 = g_account       #如果找不到系統參數或參數值為NULL, 就預設成 g_account
   ELSE
      LET g_dzlr_m.dzlr011 = g_dzlr011_s
   END IF


   LET g_dzlr_m.dzlr008 = g_account         #指定發起人員
  #LET g_dzlr_m.dzlr010 = g_today           #發起日
   CALL adzi800_master_desc_display()
   LET g_dzlr_m.dzlr005 = 'RI' 

   CALL s_transaction_begin()
   WHILE TRUE
      
      #開始畫面輸入
      CALL adzi800_input("a")

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzlr_m.* = g_dzlr_m_t.*
         CALL adzi800_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_dzlg_d.CLEAR()

      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      
      EXIT WHILE
   END WHILE

   LET g_state = "Y"
   LET g_current_idx = 1
   LET g_dzlr001_t = g_dzlr_m.dzlr001
   
   LET g_wc = g_wc, " OR (dzlg001 = '", g_dzlr_m.dzlr001 CLIPPED, "') "
   
   CLOSE adzi800_cl
END FUNCTION

#+ 資料修改
PRIVATE FUNCTION adzi800_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_zone       LIKE type_t.chr20
   
   IF g_dzlr_m.dzlr001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   EXECUTE adzi800_dzlr_referesh USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003
                                   INTO g_dzlr_m.dzlr001,g_dzlr_m.dzlr008,g_dzlr_m.dzlr008_desc,g_dzlr_m.dzlr010,g_dzlr_m.dzlr007,g_dzlr_m.dzlr007_desc,g_dzlr_m.dzlr009,
                                        g_dzlr_m.dzlr011,g_dzlr_m.dzlr011_desc,g_dzlr_m.dzlr013,g_dzlr_m.dzlr014,g_dzlr_m.dzlr012,
                                        g_dzlr_m.dzlr005,g_dzlr_m.dzlr006,g_dzlr_m.dzlr015 
   ERROR ""

   LET g_dzlr001_t = g_dzlr_m.dzlr001
 
   CALL s_transaction_begin()
   
   OPEN adzi800_cl USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003 

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi800_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi800_cl
      CALL s_transaction_end('N', '0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH adzi800_cl INTO g_dzlr_m.dzlr001,g_dzlr_m.dzlr008,g_dzlr_m.dzlr010,g_dzlr_m.dzlr007,g_dzlr_m.dzlr009, 
                         g_dzlr_m.dzlr011,g_dzlr_m.dzlr013,g_dzlr_m.dzlr014,g_dzlr_m.dzlr012,
                         g_dzlr_m.dzlr005,g_dzlr_m.dzlr006,g_dzlr_m.dzlr015 
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = g_dzlr_m.dzlr001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi800_cl
      CALL s_transaction_end('N', '0')
      RETURN
   END IF

   CALL adzi800_show()
   WHILE TRUE
      LET g_dzlr001_t = g_dzlr_m.dzlr001

      CALL adzi800_input("u")     #欄位更改
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzlr_m.* = g_dzlr_m_t.*
         CALL adzi800_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N', '0')
         EXIT WHILE
      END IF

      EXIT WHILE
   END WHILE
   
   CLOSE adzi800_cl
   CALL s_transaction_end('Y','0')
 
END FUNCTION
  
PRIVATE FUNCTION adzi800_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   DEFINE  l_cnt           LIKE type_t.num5
   #end add-point

   IF g_dzlr_m.dzlr001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   CALL s_transaction_begin()

   LET g_dzlr001_t = g_dzlr_m.dzlr001

   OPEN adzi800_cl USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi800_cl:"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE adzi800_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   EXECUTE adzi800_dzlr_referesh USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003
                                   INTO g_dzlr_m.dzlr001,g_dzlr_m.dzlr008,g_dzlr_m.dzlr008_desc,g_dzlr_m.dzlr010,g_dzlr_m.dzlr007,g_dzlr_m.dzlr007_desc,g_dzlr_m.dzlr009,
                                        g_dzlr_m.dzlr011,g_dzlr_m.dzlr011_desc,g_dzlr_m.dzlr013,g_dzlr_m.dzlr014,g_dzlr_m.dzlr012,
                                        g_dzlr_m.dzlr005,g_dzlr_m.dzlr006,g_dzlr_m.dzlr015
   IF SQLCA.sqlcode THEN
   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzlr_m.dzlr001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL adzi800_show()
   #IF cl_ask_delete() THEN
   IF cl_ask_del_master() THEN
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "dzlr001"
      LET g_doc.value1 = g_dzlr_m.dzlr001
      CALL cl_doc_remove()

      #add-point:單頭刪除前
      {<point name="delete.head.b_delete" mark="Y"/>}
      #end add-point

      DELETE FROM dzlr_t
       WHERE dzlr001 = g_dzlr_m.dzlr001 AND dzlr002 = g_dzlr002 AND dzlr003 = g_dzlr003

      #add-point:單頭刪除中
      {<point name="delete.head.m_delete"/>}
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dzlr_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      ELSE
          DELETE FROM dzlg_t
         WHERE dzlg001 = g_dzlr_m.dzlr001 AND dzlg002 = g_dzlr002 AND dzlg003 = g_dzlr003
      END IF


      CLEAR FORM
      CALL adzi800_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL adzi800_fetch("P")
      ELSE
         LET g_wc = " 1=1 "
         CALL adzi800_browser_fill("F")
         CALL adzi800_fetch("F")
      END IF

   END IF

   CLOSE adzi800_cl
   CALL s_transaction_end('Y','0')


END FUNCTION             


#+ 資料輸入
PRIVATE FUNCTION adzi800_input(p_cmd)
   DEFINE p_cmd                 LIKE type_t.chr1

   DEFINE l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE l_cmd                 LIKE type_t.chr1
   DEFINE l_insert              BOOLEAN
   DEFINE l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE l_count               LIKE type_t.num5
   DEFINE l_cnt                 LIKE type_t.num5
   DEFINE l_i                   LIKE type_t.num5
   DEFINE l_auto_generate       LIKE type_t.chr1                #自動產生註冊資訊清單否
   DEFINE l_dfile003_str        STRING
   
   DEFINE lo_DZAF_T             T_DZAF_T
   DEFINE lo_DZLU_T             DYNAMIC ARRAY OF T_DZLU_T  
   DEFINE lb_dzlm_exist         BOOLEAN
   DEFINE lb_result             BOOLEAN
   DEFINE lo_program_info       DYNAMIC ARRAY OF T_PROGRAM_INFO #程式的動態陣列物件
   DEFINE lo_user_info          T_USER_INFO                     #使用者資訊物件
   DEFINE li_step               LIKE type_t.num5
   DEFINE l_gen_wc              STRING
   DEFINE l_success             LIKE type_t.num5        #檢查是否成功
   DEFINE l_name                LIKE oofa_t.oofa011     #全名
   DEFINE l_title               LIKE oocql_t.oocql004   #職稱


   
   CALL cl_set_head_visible("", "YES")  

   CALL adzi800_set_entry(p_cmd)
   CALL adzi800_set_no_entry(p_cmd)
   CALL adzi800_set_dzlr005_scc(p_cmd)

   LET l_auto_generate = FALSE

   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #adzi800_dzlg Data Lock
   #需求單單身
   LET g_forupd_sql = "SELECT t0.dzlg001,t0.dzlg004, t0.dzlg005, t1.gzzal003, t0.dzlg006, '', ",
                      "       t0.dzlg007, '', t0.dzlg008, t0.dzlg009, t0.dzlg010 ",
                      "  FROM dzlg_t  t0 ",
                      " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.dzlg005 AND t1.gzzal002='"||g_lang||"' ",
                     #" LEFT JOIN ooag_t t1 ON t1.ooag001 = t0.dzlg005    ",
                     #" LEFT JOIN ooag_t t2 ON t2.gzxa003 = t0.ooag001    ",
                     #" LEFT JOIN ooag_t t3 ON t3.gzxa003 = t0.ooag001    ",
                     #" LEFT JOIN ooag_t t2 ON AND t2.ooag001=t0.dzlg006  ",
                     #" LEFT JOIN ooag_t t3 ON AND t3.ooag001=t0.dzlg007  ",
                      "  WHERE dzlg001 = ? AND dzlg002 = ? AND dzlg003 = ? AND dzlg004 = ?  FOR UPDATE "

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adzi800_bcl CURSOR FROM g_forupd_sql
   LET l_allow_insert = TRUE   #cl_auth_detail_input("insert")
   LET l_allow_delete = TRUE   #cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   #控制key欄位可否輸入

   DISPLAY BY NAME g_dzlr_m.dzlr001, g_dzlr_m.dzlr008,g_dzlr_m.dzlr008_desc, g_dzlr_m.dzlr010, g_dzlr_m.dzlr007, g_dzlr_m.dzlr009, 
                   g_dzlr_m.dzlr011, g_dzlr_m.dzlr011_desc, g_dzlr_m.dzlr013, g_dzlr_m.dzlr014, g_dzlr_m.dzlr012,  
                   g_dzlr_m.dzlr005, g_dzlr_m.dzlr006, g_dzlr_m.dzlr015

   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #單頭段
      INPUT BY NAME g_dzlr_m.dzlr001, g_dzlr_m.dzlr008, g_dzlr_m.dzlr010, g_dzlr_m.dzlr007, g_dzlr_m.dzlr009, 
                    g_dzlr_m.dzlr011, g_dzlr_m.dzlr013, g_dzlr_m.dzlr014, g_dzlr_m.dzlr012,
                    g_dzlr_m.dzlr005, g_dzlr_m.dzlr015       
         ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT
            #初始自動產生清單條件欄位編輯狀態
            IF g_alm_jb = g_dgenv_s THEN
               CALL cl_set_comp_required("dzlr008,dzlr010", TRUE)
            END IF
            
            #170208-00023#1 ---start---
            #LET g_dzlr_m.dzlr010 = cl_get_current()
             #新增狀態dzlr010發起日給予值
             IF p_cmd = 'a' THEN
                LET g_dzlr_m.dzlr010 = cl_get_current()
             END IF
            #170208-00023#1 ---end---


         ON CHANGE dzlr005
            #當階段異動則前階記錄現階段
            LET g_dzlr_m.dzlr006 = g_dzlr_m_t.dzlr005
            DISPLAY BY NAME g_dzlr_m.dzlr006
   

        #AFTER FIELD dzlr005
        #   #檢核當階段為zz時即更新狀態為[I:簽入]
        #   CALL adzi800_zz(g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,g_dzlr_m.dzlr005) RETURNING g_result
        #   IF g_result = 'Y' THEN
        #      DISPLAY "zz dzlm I success!!"
        #   ELSE
        #      DISPLAY "NOT zz can't update dzlm!!"
        #   END IF
                        


         AFTER FIELD dzlr007
            IF NOT cl_null(g_dzlr_m.dzlr007) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_dzlr_m.dzlr007 

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_gzza001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

              #ELSE
              #   #檢查失敗時後續處理
              #   INITIALIZE g_errparam TO NULL
              #   LET g_errparam.code = 'azz-00083'
              #   LET g_errparam.extend = ''
              #   LET g_errparam.popup = FALSE
              #   CALL cl_err()

              #   LET g_dzlr_m.dzlr007_desc = ""
              #   NEXT FIELD CURRENT
               END IF


            END IF
           #161005-00011#1
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_dzlr_m.dzlr007 
           #CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
           #LET g_dzlr_m.dzlr007_desc = '', g_rtn_fields[1] , ''

            LET g_sql= " SELECT gzzal003                                         ",   
                       " FROM                                                    ",
                       " (SELECT gzza001 , gzzal003                              ",
                       "           FROM gzza_t                                   ",
                       "           LEFT JOIN gzzal_t                             ",
                       "             ON gzzal001 = gzza001                       ",
                       "            AND gzzal002 ='",g_dlang,"' ", 
                       "         UNION                                           ",
                       "         SELECT gzde001 as gzza001, gzdel003 as gzzal003 ",
                       "           FROM gzde_t                                   ",
                       "           LEFT JOIN gzdel_t                             ",
                       "             ON gzdel001 = gzde001                       ",
                       "            AND gzdel002 = '",g_dlang,"' ",
                       "         UNION                                           ",
                       "         SELECT gzdf002 as gzza001, gzdfl003 as gzzal003 ",
                       "           FROM gzdf_t                                   ",
                       "           LEFT JOIN gzdfl_t                             ",
                       "             ON gzdfl001 = gzdf002                       ",
                       "            AND gzdfl002 =  '",g_dlang,"' ", 
                       "         UNION                                           ",
                       "         SELECT gzja001 as gzza001, gzjal003 as gzzal003 ",
                       "           FROM gzja_t                                   ",
                       "           LEFT JOIN gzjal_t                             ",
                       "             ON gzjal001 = gzja001                       ",
                       "                  AND gzjal002 =  '",g_dlang,"' ", 
                       " )                                                       ",
                       "    WHERE gzza001 ='", g_dzlr_m.dzlr007,"' "             
               
            PREPARE dzlr007_1 FROM g_sql              
            EXECUTE dzlr007_1 INTO g_dzlr_m.dzlr007_desc
           #display "xxxg_sql:",g_sql
            DISPLAY BY NAME g_dzlr_m.dzlr007_desc 
           #161005-00011#1
   
         AFTER FIELD dzlr008
            CALL adzi800_master_desc_display()

         ON ACTION controlp INFIELD dzlr008 
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzlr_m.dzlr008   #給予default值
            #給予arg
            CALL q_gzxa001_2()                            #呼叫開窗
            LET g_dzlr_m.dzlr008 = g_qryparam.return1     #將開窗取得的值回傳到變數
            DISPLAY g_dzlr_m.dzlr008 TO dzlr008           #顯示到畫面上
            NEXT FIELD dzlr008                            #返回原欄位
            #END add-point


         ON ACTION controlp INFIELD dzlr007 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dzlr_m.dzlr007             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #

           #161005-00011#1 
           #CALL q_gzzz001_1()                                #呼叫開窗
            CALL q_adzi800()
           #161005-00011#1           

            LET g_dzlr_m.dzlr007 = g_qryparam.return1
            DISPLAY g_dzlr_m.dzlr007 TO dzlr007              #
            NEXT FIELD dzlr007                          #返回原欄位

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()

            IF p_cmd <> 'u' THEN
               CALL s_transaction_begin()

               LET g_dzlr_m.dzlr001 = g_dzlr_m_t.dzlr001
               CALL adzi800_auto_assign_no()              
               LET g_dzlr_m.dzlr005 = 'SA' 
               LET g_dzlr_m.dzlr006 = 'RI' 
               INSERT INTO dzlr_t(dzlr001, dzlr002, dzlr003, dzlr004, dzlr005, dzlr006, dzlr007,
                                          dzlr008, dzlr009, dzlr010, dzlr011, dzlr012, dzlr013, dzlr014, dzlr015)
                 VALUES (g_dzlr_m.dzlr001, g_dzlr002, g_dzlr003, g_dzlr004, g_dzlr_m.dzlr005, g_dzlr_m.dzlr006, g_dzlr_m.dzlr007, 
                         g_dzlr_m.dzlr008, g_dzlr_m.dzlr009, g_dzlr_m.dzlr010, g_dzlr_m.dzlr011, g_dzlr_m.dzlr012, g_dzlr_m.dzlr013,
                         g_dzlr_m.dzlr014, g_dzlr_m.dzlr015) 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  SQLCA.sqlcode
                  LET g_errparam.extend = "adzi800_dzlr"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N', '0')
                  CONTINUE DIALOG
               END IF

               CALL s_transaction_end('Y', '0')                
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()

               UPDATE dzlr_t SET (dzlr001, dzlr002, dzlr003, dzlr004, dzlr007,
                                          dzlr008, dzlr009, dzlr010, dzlr011, dzlr013, dzlr014, dzlr012, dzlr005, dzlr006, dzlr015) = 
                                         (g_dzlr_m.dzlr001, g_dzlr002, g_dzlr003, g_dzlr004, g_dzlr_m.dzlr007,  
                                          g_dzlr_m.dzlr008, g_dzlr_m.dzlr009, g_dzlr_m.dzlr010, g_dzlr_m.dzlr011,g_dzlr_m.dzlr013, g_dzlr_m.dzlr014,
                                          g_dzlr_m.dzlr012, g_dzlr_m.dzlr005, g_dzlr_m.dzlr006,g_dzlr_m.dzlr015) 
                WHERE dzlr001 = g_dzlr001_t AND dzlr002 = g_dzlr002 AND dzlr003 = g_dzlr003 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  SQLCA.sqlcode
                  LET g_errparam.extend = "adzi800_dzlr"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N', '0')
                  CONTINUE DIALOG
               ELSE
                  #檢核當階段為zz時即更新狀態為[I:簽入]
                  CALL adzi800_zz(g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,g_dzlr_m.dzlr005) RETURNING g_chk
                  IF g_chk = 'Y' THEN
                     DISPLAY "zz dzlm I success!!"
                  ELSE
                     DISPLAY "NOT zz can't update dzlm!!"
                  END IF   
               END IF

               CALL s_transaction_end('Y','0')
            END IF

            LET g_dzlr001_t = g_dzlr_m.dzlr001
            LET p_cmd = ''
      END INPUT


     ##取得自動產生設定資訊清單時的條件
     ##(因這個地方會當成where條件,所以直接利用construct的指令)
     #CONSTRUCT BY NAME l_gen_wc ON dzlr001 
     #   BEFORE CONSTRUCT 
     #      LET g_dzlr_m.dzlr001 = ""
     #      LET l_gen_wc = ""
     #   
     #END CONSTRUCT
     #
      #作業開發資料清單頁籤
      INPUT ARRAY g_dzlg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b, MAXCOUNT = g_max_rec, WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT
            DISPLAY "BEFORE INPUT"
            DISPLAY "g_insert:",g_insert
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
               CALL FGL_SET_ARR_CURR(g_dzlg_d.getLength() + 1) 
               LET g_insert = 'N' 
            END IF 
 
            CALL adzi800_b_fill()
            LET g_rec_b = g_dzlg_d.getLength()

         BEFORE ROW
            DISPLAY "BEFORE ROW"
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx1 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            LET l_auto_generate = FALSE

            CALL s_transaction_begin()
            OPEN adzi800_cl USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN adzi800_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CLOSE adzi800_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_dzlg_d.getLength()
        
            IF g_rec_b >= l_ac AND g_dzlg_d[l_ac].dzlg004 IS NOT NULL THEN
               LET l_cmd = 'u'

               LET g_dzlg_d_t.* = g_dzlg_d[l_ac].*   #BACKUP

               IF NOT adzi800_lock_b("dzlg", "'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi800_bcl INTO g_dzlg_d[l_ac].dzlg001,g_dzlg_d[l_ac].dzlg004, g_dzlg_d[l_ac].dzlg005, g_dzlg_d[l_ac].dzlg005_desc, g_dzlg_d[l_ac].dzlg006, g_dzlg_d[l_ac].dzlg006_desc, 
                                         g_dzlg_d[l_ac].dzlg007, g_dzlg_d[l_ac].dzlg007_desc, g_dzlg_d[l_ac].dzlg008, g_dzlg_d[l_ac].dzlg009, g_dzlg_d[l_ac].dzlg010

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  SQLCA.sqlcode
                     LET g_errparam.extend = 'FETCH adzi800_bcl'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF

              #CALL adzi800_idx_chk()
              #LET l_ac = DIALOG.getCurrentRow("s_detail1")
              #LET g_detail_idx1 = l_ac
              #CALL adzi800_b_fill2()


                  LET g_bfill = "Y"
                  CALL adzi800_show()
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd = 'a'
            END IF


         BEFORE INSERT
            DISPLAY "BEFORE INSERT"
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzlg_d[l_ac].* TO NULL 

            LET g_dzlg_d_t.* = g_dzlg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            
            #項次加1
            SELECT MAX(dzlg004) + 1 INTO g_dzlg_d[l_ac].dzlg004 FROM dzlg_t 
              WHERE dzlg001 = g_dzlr_m.dzlr001 AND dzlg002 = g_dzlr002 
                AND dzlg003 = g_dzlr003
             
            IF cl_null(g_dzlg_d[l_ac].dzlg004) OR g_dzlg_d[l_ac].dzlg004 = 0 THEN
               LET g_dzlg_d[l_ac].dzlg004 = 1
            END IF


         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

            #檢查該筆單身資料是否存在
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dzlg_t 
              WHERE dzlg001 = g_dzlr_m.dzlr001 
                AND dzlg002 = g_dzlr002 
                AND dzlg003 = g_dzlr003 
                AND dzlg004 = g_dzlg_d[l_ac].dzlg004

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzlr_m.dzlr001 
               LET gs_keys[2] = g_dzlg_d[g_detail_idx1].dzlg004

               CALL adzi800_insert_b('dzlg_t', gs_keys, "'1'")
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_dzlg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF

            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = "dzlg"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N', '0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_dzld_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac - 1)
               CALL g_dzlg_d.deleteElement(l_ac)
               NEXT FIELD dzlg001 
            END IF

            IF g_dzlg_d[l_ac].dzlg004 IS NOT NULL THEN
               IF NOT adzi800_del_chk(g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,g_dzlg_d[l_ac].dzlg004) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "adz-00540"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CANCEL DELETE 
               END IF
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

               DELETE FROM dzlg_t 
                WHERE dzlg001 = g_dzlr_m.dzlr001 
                  AND dzlg002 = g_dzlr002
                  AND dzlg003 = g_dzlr003
                  AND dzlg004 = g_dzlg_d[l_ac].dzlg004

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  SQLCA.sqlcode
                  LET g_errparam.extend = "dzlg_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b - 1
                  CALL s_transaction_end('Y', '0')
               END IF 
               CLOSE adzi800_bcl
               LET l_count = g_dzlg_d.getLength()

            END IF

            INITIALIZE gs_keys TO NULL 
            LET gs_keys[1] = g_dzlr_m.dzlr001 
            LET gs_keys[2] = g_dzlg_d[g_detail_idx1].dzlg004



         AFTER FIELD dzlg005

            #add-point:AFTER FIELD gzyb002
            IF NOT cl_null(g_dzlg_d[l_ac].dzlg005) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_dzlg_d[l_ac].dzlg005

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_gzza001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

              #ELSE
              #   #檢查失敗時後續處理
              #   INITIALIZE g_errparam TO NULL
              #   LET g_errparam.code = 'azz-00083'
              #   LET g_errparam.extend = ''
              #   LET g_errparam.popup = FALSE
              #   CALL cl_err()

              #   LET g_dzlg_d[l_ac].dzlg005_desc = ""
              #   NEXT FIELD CURRENT
               END IF

            END IF
           #161005-00011#1
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_dzlg_d[l_ac].dzlg005
           #CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
           #LET g_dzlg_d[l_ac].dzlg005_desc = '', g_rtn_fields[1] , ''
            LET g_sql= " SELECT gzzal003                                         ",   
                       " FROM                                                    ",
                       " (SELECT gzza001 , gzzal003                              ",
                       "           FROM gzza_t                                   ",
                       "           LEFT JOIN gzzal_t                             ",
                       "             ON gzzal001 = gzza001                       ",
                       "            AND gzzal002 = '",g_dlang,"' ", 
                       "         UNION                                           ",
                       "         SELECT gzde001 as gzza001, gzdel003 as gzzal003 ",
                       "           FROM gzde_t                                   ",
                       "           LEFT JOIN gzdel_t                             ",
                       "             ON gzdel001 = gzde001                       ",
                       "            AND gzdel002 = '",g_dlang,"' ",
                       "         UNION                                           ",
                       "         SELECT gzdf002 as gzza001, gzdfl003 as gzzal003 ",
                       "           FROM gzdf_t                                   ",
                       "           LEFT JOIN gzdfl_t                             ",
                       "             ON gzdfl001 = gzdf002                       ",
                       "            AND gzdfl002 =  '",g_dlang,"' ", 
                       "         UNION                                           ",
                       "         SELECT gzja001 as gzza001, gzjal003 as gzzal003 ",
                       "           FROM gzja_t                                   ",
                       "           LEFT JOIN gzjal_t                             ",
                       "             ON gzjal001 = gzja001                       ",
                       "                  AND gzjal002 =  '",g_dlang,"' ", 
                       " )                                                       ",
                       "    WHERE gzza001 ='", g_dzlg_d[l_ac].dzlg005,"' "             
               
            PREPARE dzlg005_1 FROM g_sql              
            EXECUTE dzlg005_1 INTO g_dzlg_d[l_ac].dzlg005_desc 
           #display "xxxg_sql:",g_sql 
            DISPLAY BY NAME g_dzlg_d[l_ac].dzlg005_desc
           #161005-00011#1


            IF  NOT cl_null(g_dzlr_m.dzlr001) AND NOT cl_null(g_dzlg_d[g_detail_idx1].dzlg004) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dzlr_m.dzlr001 != g_dzlr001_t OR g_dzlg_d[g_detail_idx1].dzlg004 != g_dzlg_d_t.dzlg004)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzlg_t WHERE "||"dzlg001 = '"||g_dzlr_m.dzlr001 ||"' AND "|| "dzlg004 = '"||g_dzlg_d[g_detail_idx1].dzlg004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF

                 #SELECT gzzal003
                 #   INTO g_dzlg_d[l_ac].dzlg005_desc
                 # FROM gzzz_t
                 # LEFT JOIN  gzzal_t ON gzzz001 = gzzal001
                 #  AND gzzal002 = g_dlang
                 #   WHERE gzzz001 = g_dzlg_d[l_ac].dzlg004
               END IF

            END IF

         AFTER FIELD dzlg006
            IF NOT cl_null(g_dzlg_d[l_ac].dzlg006) THEN
               CALL s_employee_get_userdata(g_dzlg_d[l_ac].dzlg006,g_lang) RETURNING l_success,l_name,l_title
               IF NOT l_success THEN
                  LET g_dzlg_d[l_ac].dzlg006_desc = l_name
                  DISPLAY BY NAME g_dzlg_d[l_ac].dzlg006_desc
                  NEXT FIELD dzlg006
               END IF
               LET g_dzlg_d[l_ac].dzlg006_desc = l_name
               DISPLAY BY NAME g_dzlg_d[l_ac].dzlg006_desc
            END IF


         AFTER FIELD dzlg007
            IF NOT cl_null(g_dzlg_d[l_ac].dzlg007) THEN
               CALL s_employee_get_userdata(g_dzlg_d[l_ac].dzlg007,g_lang) RETURNING l_success,l_name,l_title
               IF NOT l_success THEN
                  LET g_dzlg_d[l_ac].dzlg007_desc = l_name
                  DISPLAY BY NAME g_dzlg_d[l_ac].dzlg007_desc
                  NEXT FIELD dzlg007
               END IF
               LET g_dzlg_d[l_ac].dzlg007_desc = l_name
               DISPLAY BY NAME g_dzlg_d[l_ac].dzlg007_desc
            END IF

         ON ACTION controlp INFIELD dzlg005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dzlg_d[l_ac].dzlg005             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
           ##161005-00011#1
           #CALL q_gzzz001_1()                                 #呼叫開窗
           #LET g_dzlg_d[l_ac].dzlg005 = g_qryparam.return1    #將開窗取得的值回傳到變數
           #DISPLAY g_dzlg_d[l_ac].dzlg005 TO dzlg005          #顯示到畫面上
   
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_dzlg_d[l_ac].dzlg005
           #CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
           #LET g_dzlg_d[l_ac].dzlg005_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_dzlg_d[l_ac].dzlg005_desc   

            CALL q_adzi800()
            LET g_dzlg_d[l_ac].dzlg005 = g_qryparam.return1         #將開窗取得的值回傳到變數
            LET g_dzlg_d[l_ac].dzlg005_desc = g_qryparam.return2    #將開窗取得的值回傳到變數
            DISPLAY g_dzlg_d[l_ac].dzlg005 TO dzlg005               #顯示到畫面上
            DISPLAY BY NAME g_dzlg_d[l_ac].dzlg005_desc             #顯示到畫面上
            #161005-00011#1 

            NEXT FIELD dzlg005                                 #返回原欄位


         ON ACTION controlp INFIELD dzlg006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzlg_d[l_ac].dzlg006    #給予default值
            #給予arg
            CALL q_gzxa001_2()                                  #呼叫開窗
            LET g_dzlg_d[l_ac].dzlg006 = g_qryparam.return1     #將開窗取得的值回傳到變數
            DISPLAY g_dzlg_d[l_ac].dzlg006 TO dzlg006           #顯示到畫面上

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzlg_d[l_ac].dzlg006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM gzxa_t LEFT JOIN ooag_t ON gzxa003 = ooag001 WHERE gzxa001 = ? AND gzxaent ='"||g_enterprise||"'","") RETURNING g_rtn_fields
            LET g_dzlg_d[l_ac].dzlg006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzlg_d[l_ac].dzlg006_desc
            NEXT FIELD dzlg006                                  #返回原欄位


         ON ACTION controlp INFIELD dzlg007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzlg_d[l_ac].dzlg007    #給予default值
            #給予arg
            CALL q_gzxa001_2()                                  #呼叫開窗
            LET g_dzlg_d[l_ac].dzlg007 = g_qryparam.return1     #將開窗取得的值回傳到變數
            DISPLAY g_dzlg_d[l_ac].dzlg007 TO dzlg007           #顯示到畫面上

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzlg_d[l_ac].dzlg007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM gzxa_t LEFT JOIN ooag_t ON gzxa003 = ooag001 WHERE gzxa001 = ? AND gzxaent ='"||g_enterprise||"'","") RETURNING g_rtn_fields
            LET g_dzlg_d[l_ac].dzlg007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzlg_d[l_ac].dzlg007_desc
            NEXT FIELD dzlg007                                  #返回原欄位



         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzlg_d[l_ac].* = g_dzlg_d_t.*
               CLOSE adzi800_bcl
               CALL s_transaction_end('N', '0')
               EXIT DIALOG 
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  -263
               LET g_errparam.extend = g_dzlg_d[l_ac].dzlg004
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzld_d[l_ac].* = g_dzld_d_t.*
            ELSE
               UPDATE dzlg_t SET (dzlg001, dzlg002, dzlg003, dzlg004, dzlg005, 
                                         dzlg006, dzlg007, dzlg008, dzlg009, dzlg010)=
                                        (g_dzlr_m.dzlr001, g_dzlr002, g_dzlr003, g_dzlg_d[l_ac].dzlg004, g_dzlg_d[l_ac].dzlg005, 
                                         g_dzlg_d[l_ac].dzlg006, g_dzlg_d[l_ac].dzlg007, g_dzlg_d[l_ac].dzlg008, g_dzlg_d[l_ac].dzlg009, g_dzlg_d[l_ac].dzlg010) 
                 WHERE dzlg001 = g_dzlr_m.dzlr001 
                   AND dzlg002 = g_dzlr002
                   AND dzlg003 = g_dzlr003
                   AND dzlg004 = g_dzlg_d_t.dzlg004

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "std-00009"
                     LET g_errparam.extend = "adzi800_dzlg"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N', '0')
                     LET g_dzlg_d[l_ac].* = g_dzlg_d_t.*
                     
                  WHEN SQLCA.sqlcode         #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  SQLCA.sqlcode
                     LET g_errparam.extend = "adzi800_dzlg"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_dzlg_d[l_ac].* = g_dzlg_d_t.*                     
                     CALL s_transaction_end('N','0')
                     
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_dzlr_m.dzlr001 
                     LET gs_keys_bak[1] = g_dzlr_m.dzlr001 
                     LET gs_keys[2] = g_dzlg_d[g_detail_idx1].dzlg004
                     LET gs_keys_bak[2] = g_dzlg_d_t.dzlg004
                     
               END CASE

            END IF

         AFTER ROW
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dzlg_d[l_ac].* = g_dzlg_d_t.*
               END IF
               
               CLOSE adzi800_bcl
               CALL s_transaction_end('N', '0')
               EXIT DIALOG 
            END IF

            CALL adzi800_unlock_b("dzlg", "'1'")
            CALL s_transaction_end('Y', '0')
            
      END INPUT

      DISPLAY ARRAY g_dzlm_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1
         BEFORE ROW
            CALL adzi800_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx1 = l_ac

         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx1)
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_current_page = 2
            CALL adzi800_idx_chk()
      END DISPLAY
      DISPLAY ARRAY g_dzld_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page1
         BEFORE ROW
            CALL adzi800_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx3 = l_ac

         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx3)
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_current_page = 3
            CALL adzi800_idx_chk()

      END DISPLAY

      DISPLAY ARRAY g_dzlf_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b4)
         BEFORE ROW
            CALL adzi800_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            LET g_detail_idx4 = l_ac

         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx4)
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            LET g_current_page = 4
            CALL adzi800_idx_chk()

      END DISPLAY    
      
      BEFORE DIALOG 
         IF p_cmd = 'a' THEN
            NEXT FIELD dzlr001 
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dzlg004 
              #WHEN "s_detail4"
              #   NEXT FIELD dfile002
 
            END CASE
         END IF

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name, g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION ACCEPT
         ACCEPT DIALOG

      ON ACTION CANCEL      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx3  = 1
         LET g_detail_idx4 = 1
         EXIT DIALOG

      ON ACTION CLOSE       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION EXIT        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
     
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG

   IF g_alm_jb = g_dgenv_s THEN
      CALL cl_set_comp_required("dzlr008,dzlr010", TRUE)
   END IF
END FUNCTION

#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi800_query()
   DEFINE ls_wc STRING

   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   #CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   
   CALL g_dzlg_d.CLEAR()
   CALL g_dzlm_d.CLEAR()
   CALL g_dzld_d.CLEAR()
   CALL g_dzlf_d.CLEAR()

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
  
   IF cl_null(g_wc) THEN
      CALL adzi800_construct()
   END IF 


   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adzi800_browser_fill("")
      CALL adzi800_fetch("")
      RETURN
   END IF
   
   #搜尋後資料初始化
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx1  = 1
   LET g_detail_idx2  = 1
   LET g_detail_idx3  = 1
   LET g_detail_idx4 = 1
   LET g_error_show  = 1
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL adzi800_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      CALL adzi800_fetch("F") 
   END IF
 
END FUNCTION

#+ QBE資料查詢
PRIVATE FUNCTION adzi800_construct()
   DEFINE ls_return             STRING
   DEFINE ls_result             STRING 
   DEFINE ls_wc                 STRING 
   DEFINE l_wc2_table1          STRING

   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzlr_m.* TO NULL
   CALL g_dzlg_d.CLEAR()        
   CALL g_dzlm_d.CLEAR()        
   CALL g_dzld_d.CLEAR()        
   CALL g_dzlf_d.CLEAR() 

   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   LET g_qryparam.state = 'c'

   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dzlr001,dzlr008,dzlr010,dzlr007,dzlr009,
                                dzlr011,dzlr013,dzlr014,dzlr012,
                                dzlr005,dzlr006,dzlr015

      #161005-00011#1 ---start---
         #需求單號dzlr001
         ON ACTION controlp INFIELD dzlr001 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlr001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlr001    #顯示到畫面上
            NEXT FIELD dzlr001 
            
         #作業編號dzlr007
         ON ACTION controlp INFIELD dzlr007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlr007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlr007    #顯示到畫面上
            NEXT FIELD dzlr007

         #發起人dzlr008
         ON ACTION controlp INFIELD dzlr008 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlr008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlr008    #顯示到畫面上
            NEXT FIELD dzlr008
 
         #承辦人dzlr011
         ON ACTION controlp INFIELD dzlr011 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlr011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlr011    #顯示到畫面上
            NEXT FIELD dzlr011
      #161005-00011#1 ---end--- 
      END CONSTRUCT

      #161005-00011#1 ---start---
      #單身dzlg
      CONSTRUCT BY NAME g_wc2 ON dzlg005,dzlg006,dzlg007
         #作業編號dzlg005
         ON ACTION controlp INFIELD dzlg005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlg005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlg005    #顯示到畫面上
            NEXT FIELD dzlg005
         #SD dzlg006
         ON ACTION controlp INFIELD dzlg006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlg006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlg006    #顯示到畫面上
            NEXT FIELD dzlg006
         #PR dzlg007
         ON ACTION controlp INFIELD dzlg007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlg007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlg007    #顯示到畫面上
            NEXT FIELD dzlg007

      END CONSTRUCT

      CONSTRUCT  BY NAME g_dzlm_wc ON dzlm001,dzlm002,dzlm004
         #建構代號dzlm002
         ON ACTION controlp INFIELD dzlm002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlm002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlm002    #顯示到畫面上
            NEXT FIELD dzlm002
         #模組dzlm004
         ON ACTION controlp INFIELD dzlm004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dzlr002
            LET g_qryparam.arg2 = g_dzlr003
            CALL q_dzlm004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzlm004    #顯示到畫面上
            NEXT FIELD dzlm004
      END CONSTRUCT

      CONSTRUCT BY NAME g_dzld_wc ON dzld003,dzld004,dzld005,dzld006,dzld007,dzld015

      END CONSTRUCT

      CONSTRUCT BY NAME g_dzlf_wc ON dzlf003,dzlf004,dzlf005

      END CONSTRUCT
      #161005-00011#1 ---start--- 

      BEFORE DIALOG
        #CALL cl_qbe_init()
         NEXT FIELD dzlr001  
 
      ON ACTION ACCEPT
         ACCEPT DIALOG
 
      ON ACTION CANCEL
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc = g_wc, " AND dzlr002 = '", g_dzlr002 CLIPPED, "' AND dzlr003 = '", g_dzlr003 CLIPPED, "' "

   #161005-00011#1 ---start--- 
   IF g_wc2 <> " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_wc2
   END IF
  #display "g_wc=",g_wc
  #display "g_wc2=",g_wc2
   #161005-00011#1 ---end---
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION

#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi800_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE l_wc3             STRING
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzlr_m.* TO NULL
  
   CALL g_dzlg_d.CLEAR()
   CALL g_dzld_d.CLEAR()
   CALL g_dzlf_d.CLEAR()

   CALL g_dzlr_browser.CLEAR()
   
   LET l_wc  = g_wc.trim() 

   LET l_wc2 = g_wc2.trim()
   
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
  #161005-00011#1 ---start--- 
  ## 若單身未輸入條件
  #LET l_sub_sql = "SELECT DISTINCT dzlr001, dzlr008, dzlr010, dzlr007, dzlr009, dzlr011,dzlr013,dzlr014,dzlr012,dzlr005,dzlr006,dzlr015 ",
  #                "    FROM dzlr_t WHERE ", l_wc CLIPPED 
  #  
  #LET g_sql = "SELECT COUNT(*) FROM (", l_sub_sql, ")"
  #IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
  #  #LET l_sub_sql = "SELECT DISTINCT dzlr001, dzlr008, dzlr010, dzlr007, dzlr009, dzlr011,dzlr013,dzlr014,dzlr012,dzlr005,dzlr006,dzlr015 ",
  #   LET l_sub_sql = "SELECT DISTINCT dzlr001 ",
  #                   "    FROM dzlr_t WHERE ", l_wc CLIPPED,
  #                   " ORDER BY dzlr001 DESC "
  #  
  #   LET g_sql = "SELECT COUNT(*) FROM (", l_sub_sql, ")"
  #ELSE
  #  #LET l_sub_sql = "SELECT DISTINCT dzlr001, dzlr008, dzlr010, dzlr007, dzlr009, dzlr011,dzlr013,dzlr014,dzlr012,dzlr005,dzlr006,dzlr015 ",
  #   LET l_sub_sql = "SELECT DISTINCT dzlr001",
  #                   "  FROM dzlr_t INNER JOIN dzlg_t ON dzlr001 = dzlg001 AND dzlr002 = dzlg002 AND dzlr003 = dzlg003 ",
  #                   " WHERE ", l_wc CLIPPED,
  #                   " ORDER BY dzlr001 DESC "
  #  
  #   LET g_sql = "SELECT COUNT(*) FROM (", l_sub_sql, ")"

  #END IF
  #display "l_sub_sql=",l_sub_sql
  #display "g_sql=",g_sql
  #161005-00011#1 ---end--- 

  #PREPARE header_cnt_pre FROM g_sql
  #EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
  #FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   
   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF
   
   CASE ps_page_action
      WHEN "F" 
         LET g_pagestart = 1
          
      WHEN "P"  
         LET g_pagestart = g_pagestart - 1
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
          
      WHEN "N"  
         LET g_pagestart = g_pagestart + 1
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt MOD 1) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - 1
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt MOD 1) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - 1
         END WHILE
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF
         
   END CASE
  
   #161005-00011#1  ---start--- 
  ###單身無輸入資料
  ##定義翻頁CURSOR
  #LET g_sql = "SELECT DISTINCT dzlr001, dzlr008, dzlr010, dzlr007, dzlr009, dzlr011,dzlr013,dzlr014,dzlr012,dzlr005,dzlr006,dzlr015 ",
  #            "    FROM dzlr_t WHERE ", g_wc.trim() 

  ##定義翻頁CURSOR
  #IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
  #  #LET g_sql = "SELECT DISTINCT dzlr001, dzlr008, dzlr010, dzlr007, dzlr009, dzlr011,dzlr013,dzlr014,dzlr012,dzlr005,dzlr006,dzlr015 ",
  #   LET g_sql = "SELECT DISTINCT dzlr001 ",
  #               "    FROM dzlr_t WHERE ", l_wc CLIPPED,
  #               " ORDER BY dzlr001 DESC "
  #ELSE
  #  #LET g_sql = "SELECT DISTINCT dzlr001, dzlr008, dzlr010, dzlr007, dzlr009, dzlr011,dzlr013,dzlr014,dzlr012,dzlr005,dzlr006,dzlr015 ",
  #   LET g_sql = "SELECT DISTINCT dzlr001 ",
  #               "  FROM dzlr_t INNER JOIN dzlg_t ON dzlr001 = dzlg001 AND dzlr002 = dzlg002 AND dzlr003 = dzlg003 ",
  #               " WHERE ", l_wc CLIPPED,
  #               " ORDER BY dzlr001 DESC "
  #END IF

   IF g_dzlm_wc = ' 1=1' AND g_dzld_wc = ' 1=1' AND g_dzlf_wc = ' 1=1' THEN
      IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
         LET g_sql = "SELECT DISTINCT dzlr001 ",
                     "    FROM dzlr_t WHERE ", l_wc CLIPPED 
      ELSE
         LET g_sql = "SELECT DISTINCT dzlr001 ",
                     "  FROM dzlr_t INNER JOIN dzlg_t ON dzlr001 = dzlg001 AND dzlr002 = dzlg002 AND dzlr003 = dzlg003 ",
                     " WHERE ", l_wc CLIPPED 
      END IF
   ELSE
      LET l_sub_sql = ""
      IF g_dzlm_wc <> ' 1=1' THEN
         LET l_sub_sql = l_sub_sql,
                         " SELECT DISTINCT dzlm012 ",
                         " FROM dzlm_t WHERE ",g_dzlm_wc.trim()
      END IF
      IF g_dzld_wc <> ' 1=1' THEN
         IF NOT cl_null(l_sub_sql) THEN
            LET l_sub_sql = l_sub_sql, " INTERSECT "
         END IF
         LET l_sub_sql = l_sub_sql,
                         " SELECT DISTINCT dzld011 ",
                         "   FROM dzld_t WHERE ",g_dzld_wc.trim()
      END IF
      IF g_dzlf_wc <> ' 1=1' THEN
         IF NOT cl_null(l_sub_sql) THEN
            LET l_sub_sql = l_sub_sql, " INTERSECT "
         END IF
         LET l_sub_sql = l_sub_sql,
                         " SELECT DISTINCT dzlf008 ",
                         "   FROM dzlf_t WHERE ",g_dzlf_wc.trim()
      END IF
      IF g_wc2 = " 1=1" THEN                  # 若單身dzlg未輸入條件
         LET g_sql = "SELECT DISTINCT dzlr001 ",
                     " FROM dzlr_t WHERE ", l_wc CLIPPED,
                     "  AND dzlr001 IN (",l_sub_sql," ) " 
      ELSE
         LET g_sql = "SELECT DISTINCT dzlr001 ",
                     "  FROM dzlr_t INNER JOIN dzlg_t ON dzlr001 = dzlg001 AND dzlr002 = dzlg002 AND dzlr003 = dzlg003 ",
                     " WHERE ", l_wc CLIPPED,
                     "   AND dzlr001 IN (",l_sub_sql," ) " 
      END IF
     #DISPLAY g_dzlf_wc
     #DISPLAY g_sql
   END IF
   LET g_sql = g_sql, " ORDER BY dzlr001 DESC "
   #161005-00011#1 ---end--- 
 
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_dzlr_browser.CLEAR()
   LET g_cnt = 1
  
  #161005-00011#1  
  #FOREACH browse_cur INTO g_dzlr_browser[g_cnt].dzlr001, g_dzlr_browser[g_cnt].dzlr008, g_dzlr_browser[g_cnt].dzlr010, g_dzlr_browser[g_cnt].dzlr007, g_dzlr_browser[g_cnt].dzlr009,
  #                        g_dzlr_browser[g_cnt].dzlr011, g_dzlr_browser[g_cnt].dzlr013, g_dzlr_browser[g_cnt].dzlr014,g_dzlr_browser[g_cnt].dzlr012,
  #                        g_dzlr_browser[g_cnt].dzlr005, g_dzlr_browser[g_cnt].dzlr006, g_dzlr_browser[g_cnt].dzlr015
   FOREACH browse_cur INTO g_dzlr_browser[g_cnt].dzlr001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_dzlr_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_dzlr_browser.getLength()
 
   LET g_rec = g_cnt - 1
   LET g_detail_cnt = g_rec
   LET g_cnt = 0
   
   #顯示總筆數
   LET g_browser_cnt = g_dzlr_browser.getLength()   #161005-00011#1 
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #161005-00011#1 

   FREE browse_pre

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange, modify, delete, reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange, modify, delete, reproduce", TRUE)
   END IF
   
END FUNCTION
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi800_fetch(p_flag)
   DEFINE p_flag             LIKE type_t.chr1
   DEFINE ls_msg             STRING
   DEFINE l_dzld_browser     type_g_dzld_browser

   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
  
   #清空第二階單身
   CALL g_dzlg_d.clear()

   CALL cl_ap_performance_next_start() 
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
            CALL cl_getmsg('fetch', g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_dzlr_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   CALL adzi800_browser_fill(p_flag)
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   #LET g_detail_idx3 = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx3 = 1
     #DISPLAY g_detail_idx3 TO FORMONLY.idx  
   ELSE
     #LET g_detail_idx3 = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting(g_pagestart, g_browser_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_dzlr_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_dzlr_browser.getLength() THEN
      LET g_current_idx = g_dzlr_browser.getLength()
   END IF
  #IF g_dzlg_d.getLength() <> 0 AND cl_null(g_dzlg_d[g_current_idx].dzlg004) THEN
  #   IF g_current_idx > g_dzlg_d.getLength() THEN
  #       CALL g_dzlg_d.deleteElement(g_dzlg_d.getLength()) 
  #      LET g_current_idx = g_dzlg_d.getLength()
  #   END IF
  #END IF
  
   LET g_dzlr_m.dzlr001 = g_dzlr_browser[g_current_idx].dzlr001

   #重讀DB,因TEMP有不被更新特性
   EXECUTE adzi800_dzlr_referesh USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003
      INTO g_dzlr_m.dzlr001,g_dzlr_m.dzlr008,g_dzlr_m.dzlr008_desc,g_dzlr_m.dzlr010,g_dzlr_m.dzlr007,g_dzlr_m.dzlr007_desc,g_dzlr_m.dzlr009,
           g_dzlr_m.dzlr011,g_dzlr_m.dzlr011_desc,g_dzlr_m.dzlr013,g_dzlr_m.dzlr014,g_dzlr_m.dzlr012,
           g_dzlr_m.dzlr005,g_dzlr_m.dzlr006,g_dzlr_m.dzlr015
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzlr_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_dzlr_m.* TO NULL

      RETURN
   END IF

 
   #重新顯示   
   LET g_bfill = "Y"
   CALL adzi800_show()
 
END FUNCTION

#+ 單身陣列填充

PRIVATE FUNCTION adzi800_b_fill()

   DEFINE p_wc2      STRING

   CALL g_dzlg_d.CLEAR()
   #需求單單身
   LET g_sql = "SELECT t0.dzlg001,t0.dzlg004, t0.dzlg005, '', t0.dzlg006, '', ",
               "       t0.dzlg007, '', t0.dzlg008, t0.dzlg009, t0.dzlg010 ",
               "  FROM dzlg_t  t0 ",     
               "  WHERE dzlg001 = ? AND dzlg002 = ? AND dzlg003 = ?  "
               
   LET g_sql = g_sql, " ORDER BY dzlg004"

   PREPARE adzi800_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR adzi800_pb1

   LET g_cnt = l_ac
   LET l_ac = 1
      
   OPEN b_fill_cs1 USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "OPEN b_fill_cs1:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   FOREACH b_fill_cs1 INTO g_dzlg_d[l_ac].*

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
     #CALL adzi800_b_fill2()
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF

   END FOREACH

   LET g_error_show = 0     
   IF g_dzlg_d.getLength() > 0 THEN
      CALL g_dzlg_d.deleteElement(g_dzlg_d.getLength())
      LET l_ac = l_ac - 1
   END IF

  #LET l_ac = g_cnt
 
   LET g_cnt = 0



   FREE adzi800_pb1

END FUNCTION

PRIVATE FUNCTION adzi800_b_fill2()
   DEFINE p_wc2      STRING

   CALL g_dzlm_d.CLEAR()
   CALL g_dzld_d.CLEAR()
   CALL g_dzlf_d.CLEAR()


   #建構項清單
   LET g_sql = "SELECT '', dzlm001, dzlm002, dzlm003, dzlm004, ",
               "       dzlm005, dzlm006, dzlm009, dzlm008, dzlm011 ",
               "  FROM dzlm_t ",     #
               "  WHERE dzlm012 = ? AND dzlm013 = ? AND dzlm014 = ?  AND dzlm015 = ? "
               
   LET g_sql = g_sql, " ORDER BY dzlm001"

   PREPARE adzi800_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR adzi800_pb2

   LET l_ac2 = 1

   #170111-00064#1  ---s
   IF g_dzlg_d.getLength() = 0 THEN
      RETURN
   END IF 
   #上一筆的idx比該筆的單身多,則指向該筆的最後一筆資料
   IF g_detail_idx1 > g_dzlg_d.getLength() AND g_dzlg_d.getLength() <> 0 THEN
      LET g_detail_idx1 = 1 
   END IF
   #170111-00064#1  ---e
      
   OPEN b_fill_cs2 USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,g_dzlg_d[g_detail_idx1].dzlg004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "OPEN b_fill_cs2:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   FOREACH b_fill_cs2 INTO g_dzlm_d[l_ac2].*

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET g_dzlm_d[l_ac2].dzlmseq = l_ac2
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF

   END FOREACH

   LET g_error_show = 0  

   LET g_rec_b2 = l_ac2 - 1


   #設計資料匯出清單
   LET g_sql = "SELECT dzld002, dzld003, dzld004, dzld005, dzld015, ", 
               "       dzld006, dzld007 ",
               "  FROM dzld_t ",     
               "  WHERE dzld011 = ? AND dzld012 = ? AND dzld013 = ?  AND dzld014 = ? "

   LET g_sql = g_sql, " ORDER BY dzld002"
   
   PREPARE adzi800_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR adzi800_pb3
   
   LET l_ac3 = 1
      
   OPEN b_fill_cs3 USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,g_dzlg_d[g_detail_idx1].dzlg004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "OPEN b_fill_cs3:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
 
   FOREACH b_fill_cs3 INTO g_dzld_d[l_ac3].*
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET g_error_show = 0
   LET g_rec_b3 = l_ac3 - 1


   #檔案匯出清單
   LET g_sql = "SELECT dzlf002, dzlf003, dzlf004, dzlf005 ", 
               "  FROM dzlf_t ",     
               "  WHERE dzlf008 = ? AND dzlf009 = ? AND dzlf010 = ? AND dzlf011 = ?"   
   
   LET g_sql = g_sql, " ORDER BY dzlf002"
   
   PREPARE adzi800_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR adzi800_pb4
   
   LET l_ac4 = 1
   
   OPEN b_fill_cs4 USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003,g_dzlg_d[g_detail_idx1].dzlg004 
 
                                            
   FOREACH b_fill_cs4 INTO g_dzlf_d[l_ac4].* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_ac4 = l_ac4 + 1
      IF l_ac4 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_rec_b4 = l_ac4 - 1

   IF g_dzlm_d.getLength() > 0 THEN
      CALL g_dzlm_d.deleteElement(g_dzlm_d.getLength())
   END IF

   IF g_dzld_d.getLength() > 0 THEN
      CALL g_dzld_d.deleteElement(g_dzld_d.getLength())
   END IF

   IF g_dzlf_d.getLength() > 0 THEN
      CALL g_dzlf_d.deleteElement(g_dzlf_d.getLength())
   END IF
 
   LET l_ac4 = g_cnt
   LET g_cnt = 0  
   
   FREE adzi800_pb2
   FREE adzi800_pb3
   FREE adzi800_pb4

END FUNCTION

#+ 單身table資料lock
PRIVATE FUNCTION adzi800_lock_b(ps_table, ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING

   #僅鎖定[設計資料匯出清單]table
   LET ls_group = "adzi800_dzlg"
   
   IF ls_group.getIndexOf(ps_table, 1) THEN
      OPEN adzi800_bcl USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003, g_dzlg_d[g_detail_idx1].dzlg004
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adzi800_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   RETURN TRUE
END FUNCTION

#+ 單身table資料unlock
PRIVATE FUNCTION adzi800_unlock_b(ps_table, ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING

   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page, 1) THEN
      CLOSE adzi800_bcl
   END IF
   
END FUNCTION

#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzi800_show()
   DEFINE l_ac_t    LIKE type_t.num5

   LET g_dzlr_m_t.* = g_dzlr_m.*      #保存單頭舊值

   CALL adzi800_set_entry('')
   CALL adzi800_set_no_entry('')
   CALL adzi800_set_dzlr005_scc('')

   IF g_bfill = "Y" THEN
      CALL adzi800_b_fill() #單身填充
      IF g_detail_idx1 > 0 THEN
         CALL adzi800_b_fill2() #單身填充
      END IF
   END IF
 
   LET l_ac_t = l_ac

   #單頭資料顯示
   CALL adzi800_master_desc_display()

  #161005-00011#1
  #INITIALIZE g_ref_fields TO NULL
  #LET g_ref_fields[1] = g_dzlr_m.dzlr007
  #CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
  #LET g_dzlr_m.dzlr007_desc = '', g_rtn_fields[1] , ''
  #161005-00011#1
      LET g_sql= " SELECT gzzal003                                         ",   
                 " FROM                                                    ",
                 " (SELECT gzza001 , gzzal003                              ",
                 "           FROM gzza_t                                   ",
                 "           LEFT JOIN gzzal_t                             ",
                 "             ON gzzal001 = gzza001                       ",
                 "            AND gzzal002 = '",g_dlang,"' ", 
                 "         UNION                                           ",
                 "         SELECT gzde001 as gzza001, gzdel003 as gzzal003 ",
                 "           FROM gzde_t                                   ",
                 "           LEFT JOIN gzdel_t                             ",
                 "             ON gzdel001 = gzde001                       ",
                 "            AND gzdel002 = '",g_dlang,"' ",
                 "         UNION                                           ",
                 "         SELECT gzdf002 as gzza001, gzdfl003 as gzzal003 ",
                 "           FROM gzdf_t                                   ",
                 "           LEFT JOIN gzdfl_t                             ",
                 "             ON gzdfl001 = gzdf002                       ",
                 "            AND gzdfl002 =  '",g_dlang,"' ", 
                 "         UNION                                           ",
                 "         SELECT gzja001 as gzza001, gzjal003 as gzzal003 ",
                 "           FROM gzja_t                                   ",
                 "           LEFT JOIN gzjal_t                             ",
                 "             ON gzjal001 = gzja001                       ",
                 "                  AND gzjal002 =  '",g_dlang,"' ", 
                 " )                                                       ",
                 "    WHERE gzza001 ='", g_dzlr_m.dzlr007,"' "             
         
      PREPARE dzlr007_2 FROM g_sql              
      EXECUTE dzlr007_2 INTO g_dzlr_m.dzlr007_desc
     #display "xxxg_sql:",g_sql
  #161005-00011#1
  #DISPLAY BY NAME g_dzlr_m.dzlr007_desc

   DISPLAY BY NAME g_dzlr_m.dzlr001, g_dzlr_m.dzlr008, g_dzlr_m.dzlr008_desc, g_dzlr_m.dzlr010, g_dzlr_m.dzlr007,g_dzlr_m.dzlr007_desc, g_dzlr_m.dzlr009, 
                   g_dzlr_m.dzlr011, g_dzlr_m.dzlr013, g_dzlr_m.dzlr014, g_dzlr_m.dzlr012, g_dzlr_m.dzlr005, 
                   g_dzlr_m.dzlr006, g_dzlr_m.dzlr015

  

   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dzlg_d.getLength()
     #161005-00011#1
     #SELECT gzzal003
     # INTO g_dzlg_d[l_ac].dzlg005_desc
     # FROM  gzzz_t
     #  LEFT JOIN gzzal_t ON gzzz001 = gzzal001
     #       AND gzzal002 = g_dlang
     #   WHERE gzzz001 = g_dzlg_d[l_ac].dzlg005

      LET g_sql= " SELECT gzzal003                                         ",   
                 " FROM                                                    ",
                 " (SELECT gzza001 , gzzal003                              ",
                 "           FROM gzza_t                                   ",
                 "           LEFT JOIN gzzal_t                             ",
                 "             ON gzzal001 = gzza001                       ",
                 "            AND gzzal002 = '",g_dlang,"' ", 
                 "         UNION                                           ",
                 "         SELECT gzde001 as gzza001, gzdel003 as gzzal003 ",
                 "           FROM gzde_t                                   ",
                 "           LEFT JOIN gzdel_t                             ",
                 "             ON gzdel001 = gzde001                       ",
                 "            AND gzdel002 = '",g_dlang,"' ",
                 "         UNION                                           ",
                 "         SELECT gzdf002 as gzza001, gzdfl003 as gzzal003 ",
                 "           FROM gzdf_t                                   ",
                 "           LEFT JOIN gzdfl_t                             ",
                 "             ON gzdfl001 = gzdf002                       ",
                 "            AND gzdfl002 =  '",g_dlang,"' ", 
                 "         UNION                                           ",
                 "         SELECT gzja001 as gzza001, gzjal003 as gzzal003 ",
                 "           FROM gzja_t                                   ",
                 "           LEFT JOIN gzjal_t                             ",
                 "             ON gzjal001 = gzja001                       ",
                 "                  AND gzjal002 =  '",g_dlang,"' ", 
                 " )                                                       ",
                 "    WHERE gzza001 ='", g_dzlg_d[l_ac].dzlg005,"' "             
         
      PREPARE dzlg005_2 FROM g_sql              
      EXECUTE dzlg005_2 INTO g_dzlg_d[l_ac].dzlg005_desc
     #display "xxxg_sql:",g_sql
     #161005-00011#1

      #SD姓名,PR姓名
      SELECT ooag011
        INTO g_dzlg_d[l_ac].dzlg006_desc
        FROM gzxa_t
        LEFT JOIN ooag_t ON gzxa003 = ooag001
        WHERE gzxaent = g_enterprise
          AND gzxa001 = g_dzlg_d[l_ac].dzlg006

      SELECT ooag011 
        INTO g_dzlg_d[l_ac].dzlg007_desc  
        FROM gzxa_t
        LEFT JOIN ooag_t ON gzxa003 = ooag001
        WHERE gzxaent = g_enterprise
          AND gzxa001 = g_dzlg_d[l_ac].dzlg007

   END FOR

   LET l_ac = l_ac_t
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
   
END FUNCTION

#+ Display人員姓名
PRIVATE FUNCTION adzi800_master_desc_display()

  #INITIALIZE g_ref_fields TO NULL
  #LET g_ref_fields[1] = g_dzlr_m.dzlr008
  #CALL ap_ref_array2(g_ref_fields, "SELECT oofa011 FROM oofa_t WHERE oofaent='" || g_enterprise || "' AND oofa002='2' AND oofa003=? ", "") 
  #   RETURNING g_rtn_fields

  #LET g_dzlr_m.dzlr008_desc =  g_rtn_fields[1]
   INITIALIZE g_dzlr_m.dzlr008_desc TO NULL
   LET g_dzlr_m.dzlr008_desc =  cl_get_accountname(g_dzlr_m.dzlr008) 
   DISPLAY BY NAME g_dzlr_m.dzlr008_desc

  #INITIALIZE g_ref_fields TO NULL
  #LET g_ref_fields[1] = g_dzlr_m.dzlr011
  #CALL ap_ref_array2(g_ref_fields, "SELECT oofa011 FROM oofa_t WHERE oofaent='" || g_enterprise || "' AND oofa002='2' AND oofa003=? ", "")
  #   RETURNING g_rtn_fields

  #LET g_dzlr_m.dzlr011_desc =  g_rtn_fields[1]
  #LET g_dzlr_m.dzlr011_desc =  cl_get_accountname(g_dzlr_m.dzlr011) 
  #DISPLAY BY NAME g_dzlr_m.dzlr011_desc
   INITIALIZE g_dzlr_m.dzlr011_desc TO NULL
   LET g_dzlr_m.dzlr011_desc =  cl_get_accountname(g_dzlr_m.dzlr011) 
   DISPLAY BY NAME g_dzlr_m.dzlr011_desc

END FUNCTION

#+ 新增單身資料
PRIVATE FUNCTION adzi800_insert_b(ps_table, ps_keys, ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING

   #設計資料匯出清單單身新增資料
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page, 1) > 0 THEN
      IF NOT adzi800_insert_adzi800_dzlg(g_dzlg_d[g_detail_idx1].*) THEN
        RETURN
      END IF
   END IF

END FUNCTION

#+ 單身筆數變更
PRIVATE FUNCTION adzi800_idx_chk()
   IF g_current_page = 1 THEN
      LET g_detail_idx1 = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx1 > g_dzlg_d.getLength() THEN
         LET g_detail_idx1 = g_dzlg_d.getLength()
      END IF
      
      IF g_detail_idx1 = 0 AND g_dzlg_d.getLength() <> 0 THEN
         LET g_detail_idx1 = 1
      END IF

      DISPLAY g_detail_idx1 TO FORMONLY.idx
      DISPLAY g_dzlg_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_dzlm_d.getLength() THEN
         LET g_detail_idx2 = g_dzlm_d.getLength()
      END IF
      
      IF g_detail_idx2 = 0 AND g_dzlm_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF

      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_dzlm_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION

#+ 單身資料重新顯示
PRIVATE FUNCTION adzi800_ui_detailshow()
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1", g_detail_idx1)      
      CALL g_curr_diag.setCurrentRow("s_detail2", g_detail_idx2)      
      CALL g_curr_diag.setCurrentRow("s_detail3", g_detail_idx3)      
      CALL g_curr_diag.setCurrentRow("s_detail4", g_detail_idx4)
   END IF
END FUNCTION

#+ 設計資料匯出清單單身新增資料
PRIVATE FUNCTION adzi800_insert_adzi800_dzlg(p_dzlg_d)
   DEFINE p_dzlg_d          type_g_dzlg_d
   DEFINE l_cnt             LIKE type_t.num5

   IF l_cnt > 0 THEN
      RETURN TRUE
   END IF
   
      INSERT INTO dzlg_t(dzlg001, dzlg002, dzlg003, dzlg004, dzlg005, 
                         dzlg006, dzlg007, dzlg008, dzlg009, dzlg010)
        VALUES(g_dzlr_m.dzlr001, g_dzlr002, g_dzlr003, p_dzlg_d.dzlg004, p_dzlg_d.dzlg005, 
               p_dzlg_d.dzlg006, p_dzlg_d.dzlg007, p_dzlg_d.dzlg008, p_dzlg_d.dzlg009, p_dzlg_d.dzlg010)
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "dzlg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   
   RETURN TRUE
END FUNCTION

#+ 初始化
PUBLIC FUNCTION adzi800_01_init()
   DEFINE l_sql             STRING

   LET g_error_message = ""
  #LET g_alm_tar_path = ""
  #LET g_write_log = FALSE
  #LET g_errlog_file = ""
  #INITIALIZE g_channel TO NULL

   LET g_alm_jb = FGL_GETENV("DGENV")
   IF cl_null(g_alm_jb) THEN
      LET g_alm_jb = g_dgenv_c
   END IF

   #是否為背景執行
   IF g_show_msg = "N" THEN
      LET g_bgjob = "Y"
   END IF

   LET g_dzlr002 = FGL_GETENV("ERPID")     #產品代號
   LET g_dzlr003 = FGL_GETENV("ERPVER")    #產品版本
   LET g_dzlr004 = FGL_GETENV("CUST")      #客戶代號


   #取得所有相關註冊資訊資料清單
   LET l_sql = "SELECT dzld002, dzld003, dzld004, dzld005, dzld006, ",
               "       dzld007, dzld008, dzld009, dzld010, dzld015 ",
               "  FROM dzld_t  ",
               "  WHERE dzld001 = ? ",
               "  ORDER BY dzld002 "
   DECLARE adzi800_01_dzld_cs CURSOR WITH HOLD FROM l_sql


   #取得所有相關檔案匯出清單
   LET l_sql = "SELECT dzlf002, dzlf003, dzlf004, dzlf005  ",
               "  FROM dzlf_t ",
               "  WHERE dzlf001 = ? ",
               "  ORDER BY dzlf002 "
   DECLARE adzi800_01_dzlf_cs CURSOR FROM l_sql


   #取得語系清單
   LET l_sql = "SELECT gzzy001 FROM gzzy_t ",
               "  WHERE gzzystus = 'Y' ",
               "    AND gzzy001 IN ('zh_TW', 'zh_CN') "
   DECLARE adzi800_01_gzzy_cs CURSOR FROM l_sql

END FUNCTION  


FUNCTION adzi800_auto_assign_no()
   DEFINE l_sql      STRING

   DEFINE l_max_no   LIKE dzlr_t.dzlr001
   DEFINE l_max_sn   LIKE dzlr_t.dzlr001
   DEFINE l_num      LIKE type_t.num5
   DEFINE l_new_no   LIKE dzlr_t.dzlr001

   LET l_num = 0
   LET l_max_no = ''
   LET l_max_sn = ''
   LET l_new_no = ''
   LET l_sql = "SELECT MAX(dzlr001) FROM dzlr_t",
                " WHERE dzlr001 LIKE '",g_dzlr_m.dzlr001 CLIPPED, "%'"
   PREPARE dzlr_t1 FROM l_sql
   EXECUTE dzlr_t1 INTO l_max_no

   IF NOT cl_null(l_max_no) THEN
      LET l_max_sn = l_max_no[9,11]
      LET l_num = l_max_sn
      LET l_num = l_num + 1
   ELSE
      LET l_num = 1
   END IF

   LET l_new_no = g_dzlr_m.dzlr001 CLIPPED,l_num USING '&&&'
   LET g_dzlr_m.dzlr001 = l_new_no

END FUNCTION

PRIVATE FUNCTION adzi800_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}

   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_dzlr_browser.getLength()
      IF g_dzlr_browser[l_i].dzlr001 = g_dzlr_m.dzlr001 THEN
         CALL g_dzlr_browser.deleteElement(l_i)
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


PRIVATE FUNCTION adzi800_pack()
   DEFINE l_msg               STRING
   DEFINE l_cmd               STRING
   DEFINE l_chk               LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE lo_xml_document     xml.DomDocument 
   DEFINE lo_xml_elements     xml.DomNode 
   DEFINE ls_xml_file         STRING 
  #DEFINE l_pack_dir          STRING
   DEFINE ls_prog             STRING,
          ls_type             STRING 
   DEFINE lo_DZAF_T           T_DZAF_T
   DEFINE ls_err_msg          STRING 
   DEFINE g_dzaf_t            T_DZAF_T
   DEFINE g_fname             STRING
   DEFINE l_file              STRING
   DEFINE l_adzi800_packdir   STRING
  #DEFINE l_pack_tar          STRING
   DEFINE l_pack_dirname      STRING
   #161223-00031#1 ---start---
   DEFINE l_adzi800rl_log     STRING
   DEFINE l_adzi800rl_path    STRING
   DEFINE l_greperrtag        STRING
   DEFINE lch_cmd             base.Channel
   DEFINE ls_str              STRING
   DEFINE ls_result           STRING
   DEFINE l_result            STRING
   DEFINE l_rlcmd             STRING 
   DEFINE l_adzi800rl_file    STRING
   #161223-00031#1 ---end---

   IF g_dzlr_m.dzlr001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   #161223-00031#1 ---start---
   LET gs_time = cl_get_current()
   LET gs_time = cl_str_replace(gs_time,' ','')
   LET gs_time = cl_str_replace(gs_time,':','')
   LET gs_time = cl_str_replace(gs_time,'-','')
   #161223-00031#1 ---end---

   CALL cl_progress_bar(3)
   CALL cl_getmsg("adz-00486",g_lang) RETURNING l_msg
   CALL cl_progress_ing(l_msg)   #打包資料產出清單中

   CALL adzi800_create_temp_table()

   #將程式類清單塞入temptable
   LET l_cnt = 1
   LET g_sql = " SELECT DISTINCT dzlm001,dzlm002,dzlm004 FROM dzlm_t ", 
               "  WHERE dzlm012 = '",g_dzlr_m.dzlr001,"' ",
               "    AND dzlm013 = '",g_dzlr002,"' ",
               "    AND dzlm014 = '",g_dzlr003,"' ",
               "    AND dzlm001 <> 'T' ",
               "  ORDER BY dzlm001,dzlm002 "
   PREPARE adzi800_dzlm FROM g_sql
   DECLARE adzi800_dzlm_curs CURSOR FOR adzi800_dzlm
   FOREACH adzi800_dzlm_curs INTO g_dzlm_p[l_cnt].*
      LET ls_prog = g_dzlm_p[l_cnt].dzlm002 
      LET ls_type = g_dzlm_p[l_cnt].dzlm001 
      CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_type, NULL) RETURNING lo_DZAF_T.*,ls_err_msg
      IF NOT cl_null(ls_err_msg) THEN
         LET ls_err_msg = "ERROR:程式",ls_prog,"取得版次資料錯誤:",ls_err_msg,",中斷此程式的匯入過程","\n"
         DISPLAY ls_err_msg
         CONTINUE FOREACH
      ELSE
         DISPLAY "revision:(",lo_DZAF_T.dzaf002 USING "<<<",",",lo_DZAF_T.dzaf003 USING "<<<",",",lo_DZAF_T.dzaf004 USING "<<<",",",lo_DZAF_T.dzaf010,")"
         INSERT INTO adzi800_pack_scm
                VALUES(lo_DZAF_T.*)
         IF SQLCA.sqlcode THEN          #置入資料庫不成功
            CALL cl_progress_bar_close()
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00024"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_sql
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH


   #將 Table 類清單塞入temptable
   LET l_cnt = 1
   LET g_sql = " SELECT DISTINCT dzlm001,dzlm002,dzlm004 FROM dzlm_t ", 
               "  WHERE dzlm012 = '",g_dzlr_m.dzlr001,"' ",
               "    AND dzlm001 = 'T' ",
               "  ORDER BY dzlm001,dzlm002 "
   PREPARE adzi800_dzlmt FROM g_sql
   DECLARE adzi800_dzlmt_curs CURSOR FOR adzi800_dzlmt
   FOREACH adzi800_dzlmt_curs INTO g_dzlm_t[l_cnt].*
     #LET g_sql = " SELECT * FROM dzaf_t ", 
     #            " WHERE dzaf002 IN SELECT MAX(dzaf002) FROM dzaf_t WHERE dzaf001 = '",g_dzlm_t[l_cnt].dzlm002,"' "," AND dzaf005 = '",g_dzlm_t[l_cnt].dzlm001 "' ",
     #            "   AND dzaf001 = '",g_dzlm_t[l_cnt].dzlm002 "' ",     #建構代號
     #            "   AND dzaf005 = '",g_dzlm_t[l_cnt].dzlm001 "' ",     #建構類型
      #若dzaf_t 同一建構代號 同一版次有s及c時,則取得c為優先
      LET g_sql = " SELECT *                                                                                               ",
                  "   FROM dzaf_t af0                                                                                      ",
                  "  WHERE af0.dzaf001 = '",g_dzlm_t[l_cnt].dzlm002 ,"'                                                    ",#建構代號
                  "    AND af0.dzaf005 = '",g_dzlm_t[l_cnt].dzlm001 ,"'                                                    ",#建構類型
                  "    AND (af0.dzaf002,af0.dzaf010) = (                                                                   ",
                  "                                       SELECT decode(afc.dzaf002,null,afs.dzaf002,afc.dzaf002) dzaf002, ",
                  "                                              decode(afc.dzaf002,null,afs.dzaf010,afc.dzaf010) dzaf010  ",
                  "                                         FROM (                                                         ",
                  "                                                SELECT '",g_dzlm_t[l_cnt].dzlm002,"' dzaf001            ",
                  "                                                  FROM dual                                             ",
                  "                                              ) afo,                                                    ",
                  "                                              (                                                         ",
                  "                                               SELECT af.dzaf001,max(af.dzaf002) dzaf002,af.dzaf010     ",
                  "                                                 FROM dzaf_t af                                         ",
                  "                                                WHERE af.dzaf010 = 's'                                  ",
                  "                                                group by af.dzaf001,af.dzaf010                          ",
                  "                                              ) afs,                                                    ",
                  "                                              (                                                         ",
                  "                                               SELECT af.dzaf001,max(af.dzaf002) dzaf002,af.dzaf010     ",
                  "                                                 FROM dzaf_t af                                         ",
                  "                                                WHERE af.dzaf010 = 'c'                                  ",
                  "                                                group by af.dzaf001,af.dzaf010                          ",
                  "                                              ) afc                                                     ",
                  "                                        WHERE afs.dzaf001 (+)= afo.dzaf001                              ",
                  "                                          AND afc.dzaf001 (+)= afo.dzaf001                              ",
                  "                                     )                                                                  "
      
      PREPARE adzi800_dzaft FROM g_sql
      DECLARE adzi800_dzaft_curs CURSOR FOR adzi800_dzaft
      FOREACH adzi800_dzaft_curs INTO g_dzaf_t.*
         INSERT INTO adzi800_pack_scm
                VALUES(g_dzaf_t.*)
         IF SQLCA.sqlcode THEN          #置入資料庫不成功
            CALL cl_progress_bar_close() 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00024"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_sql
            CALL cl_err()
            RETURN FALSE
         END IF
      END FOREACH
      LET l_cnt = l_cnt + 1
   END FOREACH

   LET l_pack_dirname = g_dzlr_m.dzlr001 CLIPPED,"_p" 
   LET l_adzi800_packdir = os.Path.join(FGL_GETENV("TEMPDIR"),l_pack_dirname)
   LET l_pack_dir = adzi800_get_path(l_adzi800_packdir CLIPPED)
   LET l_pack_tar = l_pack_dir CLIPPED,".tar"
   #先刪除已存在的匯出包目錄和tar檔
   IF NOT adzi800_delete_pack(l_pack_dir, l_pack_tar) THEN
      CALL cl_progress_bar_close()
      RETURN FALSE
   END IF
   #檢查路徑是否存在
   IF NOT os.Path.EXISTS(l_pack_dir) THEN
      LET l_cmd = "mkdir -p ", l_pack_dir.trim()
      RUN l_cmd
   END IF
   LET g_fname = os.Path.join(l_pack_dir, "adzi800_pack.unl")
   UNLOAD TO g_fname  SELECT * FROM adzi800_pack_scm

  #161012-00031#1
   #更新dzlm_t,dzld_t,dzlf_t過單註記

   UPDATE dzlm_t SET dzlm022 = 'Y' 
    WHERE dzlm012 = g_dzlr_m.dzlr001 
      AND dzlm013 = g_dzlr002
      AND dzlm014 = g_dzlr003
   UPDATE dzld_t SET dzld016 = 'Y' 
    WHERE dzld011 = g_dzlr_m.dzlr001 
      AND dzld012 = g_dzlr002
      AND dzld013 = g_dzlr003
   UPDATE dzlf_t SET dzlf012 = 'Y' 
    WHERE dzlf008 = g_dzlr_m.dzlr001 
      AND dzlf009 = g_dzlr002
      AND dzlf010 = g_dzlr003


   #程式及設定檔案打包
   LET g_fname = ''
   LET l_file  = g_dzlr_m.dzlr001 CLIPPED,".unl"
  #LET g_fname = os.Path.join(FGL_GETENV("TEMPDIR"),l_file)
   LET g_fname = os.Path.join(l_pack_dir,l_file)
   UNLOAD TO g_fname  SELECT '',dzlg001,dzlg004,'',dzlg005,'','','','','' FROM dzlg_t WHERE dzlg001 = g_dzlr_m.dzlr001
   DISPLAY "UNLOAD path:",g_fname

   #dzlr_t/dzlg_t/dzlm_t/dzld_t/dzlf_t資料匯出
   LET g_fnamer = os.Path.join(l_pack_dir,"dzlr.unl") 
   UNLOAD TO g_fnamer SELECT * FROM dzlr_t WHERE dzlr001 = g_dzlr_m.dzlr001
   DISPLAY "UNLOAD pathr:",g_fnamer

   LET g_fnameg = os.Path.join(l_pack_dir,"dzlg.unl") 
   UNLOAD TO g_fnameg SELECT * FROM dzlg_t WHERE dzlg001 = g_dzlr_m.dzlr001
   DISPLAY "UNLOAD pathg:",g_fnameg

   LET g_fnamem = os.Path.join(l_pack_dir,"dzlm.unl") 
   UNLOAD TO g_fnamem SELECT * FROM dzlm_t WHERE dzlm012 = g_dzlr_m.dzlr001
   DISPLAY "UNLOAD pathm:",g_fnamem

   LET g_fnamed = os.Path.join(l_pack_dir,"dzld.unl") 
   UNLOAD TO g_fnamed SELECT * FROM dzld_t WHERE dzld011 = g_dzlr_m.dzlr001
   DISPLAY "UNLOAD pathd:",g_fnamed

   LET g_fnamef = os.Path.join(l_pack_dir,"dzlf.unl") 
   UNLOAD TO g_fnamef SELECT * FROM dzlf_t WHERE dzlf008 = g_dzlr_m.dzlr001
   DISPLAY "UNLOAD pathf:",g_fnamef


   CALL cl_getmsg("adz-00487",g_lang) RETURNING l_msg
   CALL cl_progress_ing(l_msg)   #打包資料

   #adzp999 7 C141224-0001 ds /u1/toptst/tmp/C141224-0001.unl
   LET l_cmd = "r.r adzp999 7 " || g_dzlr_m.dzlr001 || " ds " || g_fname CLIPPED 

   DISPLAY l_cmd
   LET g_dzlr001_no = g_dzlr_m.dzlr001
  #161223-00031#1 ---start---  
  #CALL adzi800_openpipe('r.r',l_cmd,FALSE) RETURNING l_chk,g_pack_path1
   CALL adzi800_openpipe('r.r',l_cmd,'pack') RETURNING l_chk,g_pack_path1
  #161223-00031#1 ---end---  
   IF NOT l_chk THEN  #有錯誤
      DISPLAY "PACK ERROR program !!"
     #CALL cl_progress_bar_close() 
      CALL cl_progress_bar_close()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00500"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
     #RETURN
      RETURN FALSE
   END IF

   #161223-00031#1 ---start---
   #元件建構代號B 子程式S
   LET l_adzi800rl_file = 'adzi800-',g_dzlr_m.dzlr001 CLIPPED,'-',gs_time
   LET l_adzi800rl_path = os.Path.join(FGL_GETENV("TEMPDIR"),l_adzi800rl_file CLIPPED)
   LET l_adzi800rl_log  = l_adzi800rl_path CLIPPED,".log" 
   LET g_all_log  = l_adzi800rl_path CLIPPED,"BS.log" 
   LET l_cmd = "rm ",g_all_log
   RUN l_cmd
   LET l_cnt = 1
   LET g_sql = " SELECT DISTINCT dzlm001,dzlm002,dzlm004 FROM dzlm_t ",
               "  WHERE dzlm012 = '",g_dzlr_m.dzlr001,"' ",
               "    AND dzlm013 = '",g_dzlr002,"' ",
               "    AND dzlm014 = '",g_dzlr003,"' ",
               "    AND dzlm001 IN ('B','S') ",
               "  ORDER BY dzlm001,dzlm002 "
   PREPARE adzi800_dzlmrl FROM g_sql
   DECLARE adzi800_dzlmrl_curs CURSOR FOR adzi800_dzlmrl
   FOREACH adzi800_dzlmrl_curs INTO g_dzlm_rl[l_cnt].*
      LET l_cmd = "rm ",l_adzi800rl_log
      RUN l_cmd
      #r.l s_aint310 ALL
      LET l_rlcmd = "r.l ",g_dzlm_rl[l_cnt].dzlm002," ALL ","|tee ",l_adzi800rl_log
      LET l_cmd = "echo ''",l_rlcmd,"'' |tee -a ",g_all_log
      RUN l_cmd
      LET l_cmd = "echo ''",l_rlcmd,"'' |tee -a ",g_log_path
      RUN l_cmd
      LET l_cmd = "echo ''",l_rlcmd,"'' |tee -a ",g_errlog_path
      RUN l_cmd
      RUN l_rlcmd

      LET l_cmd = "cat ",l_adzi800rl_log," |tee -a ",g_all_log
      RUN l_cmd
      display "xxl_cmd:",l_cmd 
      LET l_cmd = "cat ",l_adzi800rl_log," |tee -a ",g_log_path
      RUN l_cmd
      display "xxl_cmd:",l_cmd
      LET l_cmd = "cat ",l_adzi800rl_log," |tee -a ",g_errlog_path
      RUN l_cmd
      display "xxl_cmd:",l_cmd
      LET l_greperrtag = 'ERROR'
      IF adzi800_grep(l_adzi800rl_log,l_greperrtag) THEN
         DISPLAY "PACK ERROR program !!"
         LET lch_cmd = base.Channel.create()
         CALL lch_cmd.openFile(g_all_log, "r")
         LET ls_str=''
         WHILE lch_cmd.read(ls_result)
            LET ls_str = ls_str CLIPPED,ls_result CLIPPED ,'\n'
         END WHILE
         CALL lch_cmd.close()
         LET l_result = g_all_result,'\n',ls_str

         IF NOT cl_null(ls_str) THEN
            #錯誤訊息呈現
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00022"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_result
            CALL cl_err()
            LET g_all_result = NULL
         END IF

         CALL cl_progress_bar_close()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00500"   #打包失敗
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH   
   #161223-00031#1 ---end---

   CALL cl_progress_ing('tgz檔下載client端')
   #tgz檔下載
   CALL adzi800_download_data_pre()
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION adzi800_grep(p_path,p_greptag)
   DEFINE p_path      STRING
   DEFINE p_greptag   STRING
   DEFINE l_cmd       STRING
   DEFINE ls_tmp      STRING
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE li_chk      LIKE type_t.chr1
   DEFINE lch_pipe    base.Channel

   #確認是否成功
   LET l_cmd = "grep '",p_greptag.trim(),"' ",p_path," | wc -l"
   LET lch_pipe = base.Channel.create()
   CALL lch_pipe.openPipe(l_cmd, "r")
   LET ls_tmp = ""
   WHILE lch_pipe.read(ls_tmp)
      IF ls_tmp.trim() IS NULL THEN CONTINUE WHILE END IF
      LET li_cnt = ls_tmp
      IF li_cnt > 0 THEN
         LET li_chk = TRUE
         EXIT WHILE
      ELSE
         EXIT WHILE
      END IF
   END WHILE
   CALL lch_pipe.close()

   IF li_chk THEN
      DISPLAY '成功'
      RETURN TRUE
   ELSE
      DISPLAY '失敗'
      RETURN FALSE
   END IF

END FUNCTION


PRIVATE FUNCTION adzi800_unpack_chk()
   DEFINE lnp_DZAF_T          T_DZAF_T  
   DEFINE lnt_DZAF_T          T_DZAF_T   
   DEFINE lo_DZLM_T           T_DZLM_T
   DEFINE lb_result           BOOLEAN 
   DEFINE l_cnt               LIKE type_t.num5   
   DEFINE ls_prog             STRING,
          ls_type             STRING
   DEFINE ls_err_msg          STRING
   DEFINE l_unpack_path       STRING
   DEFINE l_msg               STRING
   DEFINE ls_filename         STRING
   DEFINE li_h                LIKE type_t.num5   
   DEFINE l_idx1              LIKE type_t.num5
   DEFINE l_chk_fg            LIKE type_t.chr1
   DEFINE l_folder_p          STRING
   DEFINE l_folder_p1         STRING
   DEFINE l_no_s              STRING
   DEFINE l_no                LIKE dzlr_t.dzlr001
   DEFINE l_msg_str1          STRING
   DEFINE l_msg_str2          STRING
   DEFINE l_chk_fg_confirm    LIKE type_t.chr1
   DEFINE lb_table_lock       BOOLEAN 
   DEFINE ls_lock_user_name   STRING 


  #CALL adzi800_upload_data_pre()

   IF NOT adzi800_upload_data_pre() THEN
      LET l_chk_fg = 'N'
      RETURN l_chk_fg  
   END IF 

   LET l_unpack_path = g_unpack_folder
   IF NOT adzi800_change_pack_dir(l_unpack_path) THEN
      RETURN 'N'
   END IF
   #開啟Progressbar
   CALL cl_progress_bar(3)
   CALL cl_getmsg("adz-00501",g_lang) RETURNING l_msg
   CALL cl_progress_ing(l_msg)   #檔案上傳及解開大包

   CALL cl_getmsg("adz-00502",g_lang) RETURNING l_msg
   CALL cl_progress_ing(l_msg)   #解包資料

   LET l_chk_fg = 'Y' 
   #建立temptable
   CALL adzi800_create_temp_table()        

   #匯入來源dzaf_t識別清單
   DISPLAY "l_unpack_path:",l_unpack_path
   DISPLAY "g_file:",g_file
   IF os.Path.exists(l_unpack_path) THEN
      LET li_h = os.Path.diropen(l_unpack_path)
      WHILE li_h > 0
         LET ls_filename = os.Path.dirnext(li_h)
         IF ls_filename IS NULL THEN EXIT WHILE END IF
         IF ls_filename = "." OR ls_filename = ".." THEN CONTINUE WHILE END IF

         LET l_idx1= 0
         IF ls_filename = "adzi800_pack.unl" THEN
            LOAD FROM "adzi800_pack.unl" INSERT INTO adzi800_pack_scm
         END IF
      END WHILE
      CALL os.Path.dirclose(li_h)
      LET l_msg = "匯入來源dzaf_t識別清單!!"
      CALL cl_progress_ing(l_msg)   #匯入來源dzaf_t識別清單
   END IF
                 
   #20161101 禁止檢核
   #將清單temptable讀出                                                                   
   LET l_cnt = 1                                                                                
   LET g_sql = " SELECT * FROM adzi800_pack_scm "                                                    
   PREPARE adzi800_dzafs1 FROM g_sql                                                             
   DECLARE adzi800_dzafs_curs1 CURSOR FOR adzi800_dzafs1                                          
   FOREACH adzi800_dzafs_curs1 INTO g_dzafs[l_cnt].* 
      DISPLAY "g_dzafs:",g_dzafs[l_cnt].*   

      LET g_sql = "SELECT * FROM dzlm_t",
                   " WHERE dzlm002 LIKE '",g_dzafs[l_cnt].dzaf001 CLIPPED ,"' " 
      PREPARE adzi800_dzlmc FROM g_sql
      DECLARE adzi800_dzlmc_curs CURSOR FOR adzi800_dzlmc                                          
      FOREACH adzi800_dzlmc_curs INTO lo_DZLM_T.* 
         DISPLAY "lo_dzlm_t:",lo_DZLM_T.*   
         #檢核DZLM資料是否還有簽出的
         LET lb_result = TRUE
         CALL sadzp200_alm_check_data_valid(lo_DZLM_T.*,cs_check_out) RETURNING lb_result
         DISPLAY "lb_result:",lb_result
         IF lb_result THEN
            DISPLAY "禁止匯入! 原因: 目的區程式簽出中"
            LET l_chk_fg = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00655"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET l_msg_str1 = lo_DZLM_T.dzlm002
            LET g_errparam.replace[1] = l_msg_str1 
            CALL cl_err()
            EXIT FOREACH
         END IF
         INITIALIZE lo_DZLM_T.* TO NULL 
         
      END FOREACH
     
      IF g_dzafs[l_cnt].dzaf005 <> 'T' THEN                                         
         LET ls_prog = g_dzafs[l_cnt].dzaf001
         LET ls_type = g_dzafs[l_cnt].dzaf005    
         CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_type, NULL) RETURNING lnp_DZAF_T.*,ls_err_msg
         IF NOT cl_null(ls_err_msg) THEN
           #20161102 允許的,當新程式的時後就會有取不到版次的
           #LET ls_err_msg = "ERROR:程式",ls_prog,"取得版次資料錯誤:",ls_err_msg,",中斷此程式的匯入過程","\n"
           #DISPLAY ls_err_msg
            CONTINUE FOREACH
         END IF 
         
         IF g_dzafs[l_cnt].dzaf010 = 's' AND lnp_DZAF_T.dzaf010 = 'c' THEN    
            DISPLAY "禁止匯入! 原因: 標準程式不可匯入已客製的程式"
            LET l_chk_fg = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00656"     #adz-00656:禁止匯入! 原因: 標準程式%1不可匯入已客製的程式%2
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET l_msg_str1 = g_dzafs[l_cnt].dzaf001 
            LET l_msg_str2 = lnp_DZAF_T.dzaf001 
            LET g_errparam.replace[1] = l_msg_str1.trim() 
            LET g_errparam.replace[2] = l_msg_str2.trim() 
            CALL cl_err()
            EXIT FOREACH
         END IF  
        
      END IF       
      

      IF g_dzafs[l_cnt].dzaf005 = 'T' THEN 
         CALL adzi800_dzaft(g_dzafs[l_cnt].dzaf001,g_dzafs[l_cnt].dzaf005) RETURNING lnt_DZAF_T.*
         DISPLAY "lnt_DZAF_T:",lnt_DZAF_T.*
         IF g_dzafs[l_cnt].dzaf010 = 's' AND lnt_DZAF_T.dzaf010 = 'c' THEN    
            DISPLAY "禁止匯入! 原因: 標準程式不可匯入已客製的程式"
            LET l_chk_fg = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00656"     #adz-00656:禁止匯入! 原因: 標準程式%1不可匯入已客製的程式%2
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET l_msg_str1 = g_dzafs[l_cnt].dzaf001 
            LET l_msg_str2 = lnt_DZAF_T.dzaf001 
            LET g_errparam.replace[1] = l_msg_str1.trim() 
            LET g_errparam.replace[2] = l_msg_str2.trim() 
            CALL cl_err()
            EXIT FOREACH
         END IF 
        
      END IF       
      
      LET l_cnt = l_cnt + 1                      
   END FOREACH


   IF l_chk_fg = 'Y' THEN
      #警告 檢核訊息搜集
      #將清單temptable讀出 
      CALL cl_err_collect_init()      #錯誤訊息統整顯示                                                                  
      LET l_cnt = 1                                                                                
     #LET g_sql = " SELECT * FROM adzi800_pack_scm "                                                    
     #PREPARE adzi800_dzafs2 FROM g_sql                                                             
     #DECLARE adzi800_dzafs_curs2 CURSOR FOR adzi800_dzafs2                                          
     #FOREACH adzi800_dzafs_curs2 INTO g_dzafs[l_cnt].* 
      FOREACH adzi800_dzafs_curs1 INTO g_dzafs[l_cnt].* 
         DISPLAY "g_dzafs:",g_dzafs[l_cnt].*   
      
         IF g_dzafs[l_cnt].dzaf005 <> 'T' THEN                                         
            LET ls_prog = g_dzafs[l_cnt].dzaf001
            LET ls_type = g_dzafs[l_cnt].dzaf005    
            CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_type, NULL) RETURNING lnp_DZAF_T.*,ls_err_msg
            IF NOT cl_null(ls_err_msg) THEN
              #20161102 允許的,當新程式的時後就會有取不到版次的
              #LET ls_err_msg = "ERROR:程式",ls_prog,"取得版次資料錯誤:",ls_err_msg,",中斷此程式的匯入過程","\n"
              #DISPLAY ls_err_msg
               CONTINUE FOREACH
            END IF 
            
            #來源區版本 < 目的區版本  
            IF NOT cl_null(lnp_DZAF_T.dzaf002) THEN #目標有版次才檢查 (如果是全新的,就不用怕蓋掉目標)
               IF (g_dzafs[l_cnt].dzaf010 = lnp_DZAF_T.dzaf010 ) AND       #識別標示 相同才比較
                  (NVL(g_dzafs[l_cnt].dzaf002,0) < NVL(lnp_DZAF_T.dzaf002,0)) AND  #建構版次
                  (NVL(g_dzafs[l_cnt].dzaf004,0) < NVL(lnp_DZAF_T.dzaf004,0))      #程式版次
               THEN
                  DISPLAY "警告, 自行判斷是否繼續! 原因: 目的區版本 > 來源區版本"
                ##IF cl_ask_confirm("adz-00657") THEN
                 #LET l_msg_str1 = "目的區版本:",lnt_DZAF_T.dzaf002," > 來源區版本:",g_dzafs[l_cnt].dzaf002 
                 #IF cl_ask_confirm_parm("adz-00657",l_msg_str1)  THEN  
                 #   LET l_chk_fg = 'Y'
                 #   CONTINUE FOREACH
                 #ELSE
                 #   LET l_chk_fg = 'N'
                 #   EXIT FOREACH
                 #END IF
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-01021"    #adz-01021:匯入端目前的版次:%1 > 來源版次: %2 
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = lnp_DZAF_T.dzaf002 
                  LET g_errparam.replace[2] = g_dzafs[l_cnt].dzaf002 
                  CALL cl_err()
               END IF
            END IF         
             
         END IF       
         
      
         IF g_dzafs[l_cnt].dzaf005 = 'T' THEN 
            CALL adzi800_dzaft(g_dzafs[l_cnt].dzaf001,g_dzafs[l_cnt].dzaf005) RETURNING lnt_DZAF_T.*
            DISPLAY "lnt_DZAF_T:",lnt_DZAF_T.*
           
            #來源區版本 < 目的區版本 
            IF NOT cl_null(lnt_DZAF_T.dzaf002) THEN #目標有版次才檢查 (如果是全新的,就不用怕蓋掉目標)
               IF (g_dzafs[l_cnt].dzaf010 = lnt_DZAF_T.dzaf010 ) AND       #識別標示 相同才比較
                  (NVL(g_dzafs[l_cnt].dzaf002,0) < NVL(lnt_DZAF_T.dzaf002,0)) AND  #建構版次
                  (NVL(g_dzafs[l_cnt].dzaf003,0) < NVL(lnt_DZAF_T.dzaf003,0))      #規格版次
               THEN
                 #DISPLAY "警告, 自行判斷是否繼續! 原因: 目的區版本 > 來源區版本"
                ##IF cl_ask_confirm("adz-00657") THEN
                 #LET l_msg_str1 = "目的區版本:",lnt_DZAF_T.dzaf002," > 來源區版本:",g_dzafs[l_cnt].dzaf002 
                 #IF cl_ask_confirm_parm("adz-00657",l_msg_str1)  THEN  
                 #   LET l_chk_fg = 'Y'
                 #   CONTINUE FOREACH
                 #ELSE
                 #   LET l_chk_fg = 'N'
                 #   EXIT FOREACH
                 #END IF
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-01021"    #adz-01021:匯入端目前的版次:%1 > 來源版次: %2
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = lnt_DZAF_T.dzaf002
                  LET g_errparam.replace[2] = g_dzafs[l_cnt].dzaf002
                  CALL cl_err()
               END IF
            END IF   
            #161005-00011#1  
            #檢核匯入的table在目前系統是是否lock
            CALL adzi800_db_check_table_lock(g_dzafs[l_cnt].dzaf001) RETURNING lb_table_lock,ls_lock_user_name  
            IF lb_table_lock THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-01025"    #adz-01025:表格%1被鎖定中
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = g_dzafs[l_cnt].dzaf001 
               CALL cl_err()
            END IF
            #161005-00011#1 
         END IF       
        
         #161223-00031#1 ---start---
         #元件建構代號B 子程式S
         IF g_dzafs[l_cnt].dzaf005 = 'B' OR g_dzafs[l_cnt].dzaf005 = 'S' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-01149"     #清單含(B:元件或S:子程式),將執行 r.l %1 ALL
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_dzafs[l_cnt].dzaf001 
            CALL cl_err()
         END IF
         #161223-00031#1 ---end---
 
         LET l_cnt = l_cnt + 1                      
      END FOREACH
      LET l_chk_fg = 'Y'
      CALL cl_err_collect_show()
   END IF



   #檢核出 解包環境 有警告訊息,再次確認 
   IF l_chk_fg = 'Y' THEN
      IF cl_ask_confirm("adz-01023")  THEN   #adz-01023 是否繼續解包?
         LET l_chk_fg = 'Y'
      ELSE 
         LET l_chk_fg = 'N'
      END IF
   END IF
    

   IF l_chk_fg = 'Y' THEN
      LET l_unpack_path = g_unpack_folder
      
      DISPLAY "l_unpack_path:",l_unpack_path
      DISPLAY "g_file:",g_file
      LET l_folder_p = os.Path.basename(l_unpack_path)
      LET l_folder_p1 = l_folder_p.substring(1,l_folder_p.getIndexOf("_p",1)-1)
      LET l_no_s = l_folder_p.substring(1 ,l_folder_p1.getlength())
      DISPLAY "l_no_s:",l_no_s
      
      LET l_no = l_no_s
     #161012-00031#1 
     #LET g_sql = "SELECT count(*) FROM dzlm_t",
     #             " WHERE dzlm012 = '",l_no CLIPPED ,"' "
     #PREPARE adzi800_dzlmno_cnt FROM g_sql
     #EXECUTE adzi800_dzlmno_cnt INTO l_cnt
      LET g_sql = "SELECT count(*) FROM dzlr_t",
                   " WHERE dzlr001 = '",l_no CLIPPED ,"' ",
                   "   AND dzlr002 = '",g_dzlr002 CLIPPED ,"' ",
                   "   AND dzlr003 = '",g_dzlr003 CLIPPED ,"' " 
      PREPARE adzi800_dzlrno_cnt FROM g_sql
      EXECUTE adzi800_dzlrno_cnt INTO l_cnt
     
      #檢核目的端的dzlr_t的需求單是否存在 
      IF l_cnt > 0  THEN  
         IF cl_ask_confirm_parm("adz-00658",l_no) = TRUE THEN   #adzi-00658 需求單%1已存在, 是否重新匯入 ? 
            LET l_chk_fg = 'Y'
         ELSE
            LET l_chk_fg = 'N'
         END IF
      END IF
   END IF

   DISPLAY "l_chk_fg:",l_chk_fg

   RETURN l_chk_fg
   CALL cl_progress_bar_close()
END FUNCTION


 
PRIVATE FUNCTION adzi800_unpack()
   DEFINE l_msg          STRING
   DEFINE l_cmd          STRING
   DEFINE l_chk          LIKE type_t.num5
   DEFINE l_idx          LIKE type_t.num5
   DEFINE l_idx1         LIKE type_t.num5
   DEFINE l_idx2         LIKE type_t.num5
   DEFINE l_folder_path  STRING
   DEFINE l_table_path   STRING
   DEFINE l_prog_path    STRING
   DEFINE li_h           LIKE type_t.num5
   DEFINE ls_filename    STRING
   DEFINE l_unpack_path  STRING
   DEFINE l_folder_p     STRING
   DEFINE l_folder_p1    STRING
   DEFINE l_no_s         STRING
   DEFINE l_no           LIKE dzlr_t.dzlr001 
   DEFINE l_dzlm017      LIKE dzlm_t.dzlm017
   #161223-00031#1 ---start---
   DEFINE l_adzi800rl_log     STRING
   DEFINE l_adzi800rl_path    STRING
   DEFINE l_greperrtag        STRING
   DEFINE lch_cmd             base.Channel
   DEFINE ls_str              STRING
   DEFINE ls_result           STRING
   DEFINE l_result            STRING
   DEFINE l_rlcmd             STRING
   DEFINE l_adzi800rl_file    STRING
   DEFINE l_cnt               LIKE type_t.num5
   #161223-00031#1 ---end--- 



  #CALL adzi800_upload_data_pre()
  #CALL cl_progress_bar(3)
  #CALL cl_getmsg("adz-00501",g_lang) RETURNING l_msg
  #CALL cl_progress_ing(l_msg)   #檔案上傳及解開大包

  #CALL cl_getmsg("adz-00502",g_lang) RETURNING l_msg
  #CALL cl_progress_ing(l_msg)   #解包資料

   LET l_unpack_path = g_unpack_folder
   IF NOT adzi800_change_pack_dir(l_unpack_path) THEN
     #RETURN
      RETURN FALSE
   END IF

   #161223-00031#1 ---start---
   LET gs_time = cl_get_current()
   LET gs_time = cl_str_replace(gs_time,' ','')
   LET gs_time = cl_str_replace(gs_time,':','')
   LET gs_time = cl_str_replace(gs_time,'-','')
   #161223-00031#1 ---end---

   DISPLAY "l_unpack_path:",l_unpack_path
   DISPLAY "g_file:",g_file
   LET l_folder_p = os.Path.basename(l_unpack_path) 
   LET l_folder_p1 = l_folder_p.substring(1,l_folder_p.getIndexOf("_p",1)-1) 
   LET l_no_s = l_folder_p.substring(1 ,l_folder_p1.getlength())
   DISPLAY "l_no_s:",l_no_s
  

   LET l_no = l_no_s
   LET g_no = l_no
   IF os.Path.exists(l_unpack_path) THEN
      LET li_h = os.Path.diropen(l_unpack_path)
      WHILE li_h > 0
         CALL s_transaction_begin()

         LET ls_filename = os.Path.dirnext(li_h)                                
         IF ls_filename IS NULL THEN EXIT WHILE END IF                          
         IF ls_filename = "." OR ls_filename = ".." THEN CONTINUE WHILE END IF  

         LET l_idx1= 0
         LET l_idx1= ls_filename.getIndexOf(".tgz", 1)
         IF l_idx1> 1 THEN
            LET l_prog_path = os.Path.join(l_unpack_path,ls_filename) 
         END IF
         IF ls_filename = "dzlr.unl" THEN
            DELETE FROM dzlr_t WHERE dzlr001= l_no
            LOAD FROM "dzlr.unl" INSERT INTO dzlr_t 
         END IF
         IF ls_filename = "dzlg.unl" THEN
            DELETE FROM dzlg_t WHERE dzlg001= l_no
            LOAD FROM "dzlg.unl" INSERT INTO dzlg_t 
         END IF
         IF ls_filename = "dzlm.unl" THEN
            DELETE FROM dzlm_t WHERE dzlm012= l_no
            LOAD FROM "dzlm.unl" INSERT INTO dzlm_t 
         END IF
         IF ls_filename = "dzld.unl" THEN
            DELETE FROM dzld_t WHERE dzld011= l_no 
            LOAD FROM "dzld.unl" INSERT INTO dzld_t 
         END IF
         IF ls_filename = "dzlf.unl" THEN
            DELETE FROM dzlf_t WHERE dzlf008= l_no
            LOAD FROM "dzlf.unl" INSERT INTO dzlf_t 
         END IF
      END WHILE
      CALL os.Path.dirclose(li_h)
      #141216-00004#2 --- S
      #更新 DZLM_T 簽入狀態與時間
      LET l_dzlm017 = CURRENT YEAR TO MINUTE
      UPDATE dzlm_t
         SET dzlm008 = NVL2(dzlm008,'I',NULL),
             dzlm011 = NVL2(dzlm011,'I',NULL),
             dzlm017 = l_dzlm017
       WHERE dzlm012 = l_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "sub-00052"
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N', '0')
      END IF
      #更新 DZLR_T DZLR005階段='ZZ'
      UPDATE dzlr_t
         SET dzlr005 = 'ZZ'
       WHERE dzlr001 = l_no
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "sub-00052"
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N', '0')
      END IF

      CALL s_transaction_end('Y','0')
      #141216-00004#2 --- E 
   END IF

   #adzp999 6 /u1/topprd/tmp/C141224-0001.tgz ds
   LET l_cmd = "r.r adzp999 6 " || l_prog_path CLIPPED || " ds"  
   DISPLAY l_cmd
   LET g_dzlr001_no = l_no
  #161223-00031#1 ---start---
  #CALL adzi800_openpipe('r.r',l_cmd,FALSE) RETURNING l_chk,g_pack_path
   CALL adzi800_openpipe('r.r',l_cmd,'unpack') RETURNING l_chk,g_pack_path
  #161223-00031#1 ---end---

   IF NOT l_chk THEN
      RETURN FALSE
   END IF

   #161223-00031#1 ---start---
   #元件建構代號B 子程式S
   LET l_adzi800rl_file = 'adzi800-',g_dzlr001_no CLIPPED,'-',gs_time
   LET l_adzi800rl_path = os.Path.join(FGL_GETENV("TEMPDIR"),l_adzi800rl_file CLIPPED)
   LET l_adzi800rl_log  = l_adzi800rl_path CLIPPED,".log"
   LET g_all_log  = l_adzi800rl_path CLIPPED,"BS.log"
   LET l_cmd = "rm ",g_all_log
   RUN l_cmd
   LET l_cnt = 1
   LET g_sql = " SELECT DISTINCT dzlm001,dzlm002,dzlm004 FROM dzlm_t ",
               "  WHERE dzlm012 = '",g_dzlr001_no,"' ",
               "    AND dzlm013 = '",g_dzlr002,"' ",
               "    AND dzlm014 = '",g_dzlr003,"' ",
               "    AND dzlm001 IN ('B','S') ",
               "  ORDER BY dzlm001,dzlm002 "
   PREPARE adzi800_dzlmrl2 FROM g_sql
   DECLARE adzi800_dzlmrl2_curs CURSOR FOR adzi800_dzlmrl2
   FOREACH adzi800_dzlmrl2_curs INTO g_dzlm_rl[l_cnt].*
      LET l_cmd = "rm ",l_adzi800rl_log
      RUN l_cmd
      #r.l s_aint310 ALL
      LET l_rlcmd = "r.l ",g_dzlm_rl[l_cnt].dzlm002," ALL ","|tee ",l_adzi800rl_log
      LET l_cmd = "echo ''",l_rlcmd,"'' |tee -a ",g_all_log
      RUN l_cmd
      LET l_cmd = "echo ''",l_rlcmd,"'' |tee -a ",g_log_path
      RUN l_cmd
      LET l_cmd = "echo ''",l_rlcmd,"'' |tee -a ",g_errlog_path
      RUN l_cmd
      RUN l_rlcmd

      LET l_cmd = "cat ",l_adzi800rl_log," |tee -a ",g_all_log
      RUN l_cmd
      display "xxl_cmd:",l_cmd
      LET l_cmd = "cat ",l_adzi800rl_log," |tee -a ",g_log_path
      RUN l_cmd
      display "xxl_cmd:",l_cmd
      LET l_cmd = "cat ",l_adzi800rl_log," |tee -a ",g_errlog_path
      RUN l_cmd
      display "xxl_cmd:",l_cmd
      LET l_greperrtag = 'ERROR'
      IF adzi800_grep(l_adzi800rl_log,l_greperrtag) THEN
         DISPLAY "UNPACK ERROR program !!"
         LET lch_cmd = base.Channel.create()
         CALL lch_cmd.openFile(g_all_log, "r")
         LET ls_str=''
         WHILE lch_cmd.read(ls_result)
            LET ls_str = ls_str CLIPPED,ls_result CLIPPED ,'\n'
         END WHILE
         CALL lch_cmd.close()
         LET l_result = g_all_result,'\n',ls_str

         IF NOT cl_null(ls_str) THEN
            #錯誤訊息呈現
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00022"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_result
            CALL cl_err()
            LET g_all_result = NULL
            RETURN FALSE
         END IF

      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   #161223-00031#1 ---end---      

   RETURN TRUE
  #141216-00004#2 --- S
  ##更新 DZLM_T 簽入狀態與時間
  #  LET l_dzlm017 = CURRENT YEAR TO MINUTE
  #  UPDATE dzlm_t 
  #     SET dzlm008 = NVL2(dzlm008,'I',NULL), 
  #         dzlm011 = NVL2(dzlm011,'I',NULL), 
  #         dzlm017 = l_dzlm017
  #   WHERE dzlm012 = l_no 
  ##更新 DZLR_T DZLR005階段='ZZ'
  #  UPDATE dzlr_t 
  #     SET dzlr005 = 'ZZ'
  #   WHERE dzlr001 = l_no 
  #141216-00004#2 --- E 

  #IF NOT l_chk THEN  #有錯誤
  #   DISPLAY "UNPACK ERROR !!"
  #   CALL cl_progress_bar_close()
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code =  "adz-00552"
  #   LET g_errparam.extend = ""
  #   LET g_errparam.popup = TRUE
  #   CALL cl_err()
  #   RETURN
  #END IF

  #CALL cl_progress_ing('')

END FUNCTION


#+ 匯出檔下載前置作業
PRIVATE FUNCTION adzi800_download_data_pre()
  #DEFINE l_pack_dir       STRING   #打包檔置放路徑
   DEFINE l_dir1           STRING
   DEFINE l_dir1_name      STRING
   DEFINE l_chk            BOOLEAN
   DEFINE l_tarfile        STRING  
   DEFINE l_str            STRING  
   DEFINE l_str1           STRING  
   DEFINE l_str2           STRING  
   DEFINE l_idx1           SMALLINT 
   DEFINE l_tar_name1      STRING     #匯出包名稱 
   DEFINE l_temp_dir       STRING

  ##切換到$TEMPDIR工作目錄下
  #LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   LET l_temp_dir = FGL_GETENV("TEMPDIR") 

   IF NOT adzi800_change_pack_dir(l_temp_dir) THEN
      RETURN 
   END IF

   #copy 檔案至大目錄裡
   LET l_idx1 = g_pack_path1.getIndexOf(".tgz", 1)
   IF l_idx1 > 1 THEN
      LET l_tar_name1 = os.Path.basename(g_pack_path1)
   END IF

   #檢查程式資料tar是否存在
   IF NOT os.Path.EXISTS(l_tar_name1) THEN
      CALL cl_progress_bar_close()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00328"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_tar_name1.trim()
      CALL cl_err()
      RETURN 
   END IF
   
    LET l_str1 = os.Path.join(l_pack_dir, l_tar_name1)
    IF NOT os.Path.copy(g_pack_path1,l_str1) THEN
       LET l_chk = FALSE
    END IF   
   
  #IF l_chk THEN 
      #匯出檔打包
      CALL adzi800_tar(l_pack_dir,l_pack_tar) RETURNING l_chk,l_str,l_tarfile   #打包成壓縮檔 
  #END IF

   DISPLAY "XXXtarfile:",l_tarfile

   #匯出檔下載
   CALL adzi800_download_data(l_tarfile)
  #CALL adzi800_download_data(g_pack_path1)
 
  ##切換回正確程式執行路徑
  #IF NOT adzi800_change_work_dir() THEN
  #   RETURN
  #END IF
 
END FUNCTION


################################################################################
# Descriptions...: 打包成壓縮檔
# Memo...........:
# Usage..........: CALL adzi800_tar(p_archive,p_file,p_path)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION adzi800_tar(p_archive,p_file)
   DEFINE p_archive        STRING   #打包後的壓縮檔(包含路徑,不包含附檔名)
   DEFINE p_file           STRING   #要打包的目錄或檔案
   DEFINE l_archive        STRING   #打包後的壓縮檔(包含路徑,附檔名)
   DEFINE l_archive_path   STRING   #打包後的壓縮檔路徑
   DEFINE l_archive_folder STRING   #打包目錄
   DEFINE l_str            STRING
   DEFINE l_filetar        STRING   #tar檔案
   DEFINE l_cmd            STRING
   DEFINE l_chk            BOOLEAN

   LET l_archive = p_archive 
   LET l_archive_folder = os.Path.basename(p_archive)
   LET l_archive_path = os.Path.dirname(p_archive)
   LET l_filetar = os.Path.basename(p_file)

   IF NOT adzi800_change_pack_dir(l_archive_path) THEN
      RETURN
   END IF

   DISPLAY "l_archive:",l_archive
   #打包成tar檔範例:tar cvf $FOLDER.tar $FOLDER
   LET l_cmd = "tar cvf ", l_filetar CLIPPED, " ", l_archive_folder CLIPPED
   DISPLAY "l_cmd:",l_cmd
   RUN l_cmd
  #LET l_cmd = "cd ",l_archive_path CLIPPED,";zip -r ", l_archive CLIPPED," ",p_file
  #CALL cl_cmdrun_openpipe("tar zcvf",l_cmd,TRUE) RETURNING l_chk,l_str
  #IF NOT l_chk THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code = "std-00008"
  #   LET g_errparam.extend = l_cmd
  #   LET g_errparam.popup = TRUE
  #   LET g_errparam.replace[1] =  l_str CLIPPED
  #   CALL cl_err()
  #END IF

  #LET l_archive = os.Path.join(l_archive_path,l_archive)
   RETURN l_chk,l_str,p_file
END FUNCTION


################################################################################
# Descriptions...: 刪除目錄或檔案
# Memo...........: rm無法刪除目錄時,因背景訊息無"ERROR"字樣,所以cl_cmdrun_openpipe回傳的l_chk無法得知錯誤,但在建立目錄時就會有錯誤
# Usage..........: CALL adzi800_del_dir(p_dir)
#                  RETURNING l_chk,l_str
# Input parameter: p_dir          要刪除的目錄或檔案
# Return code....: l_chk          是否成功 TRUE/FALSE
#                : l_str          背景訊息
# Date & Author..:  
# Modify.........:
################################################################################
PUBLIC FUNCTION adzi800_del_dir(p_dir)
   DEFINE p_dir         STRING
   DEFINE l_str         STRING
   DEFINE l_cmd         STRING
   DEFINE l_chk         BOOLEAN

   LET l_cmd = "rm -rf ",p_dir CLIPPED
   CALL cl_cmdrun_openpipe("rm -rf",l_cmd,TRUE) RETURNING l_chk,l_str
   IF NOT l_chk THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00008"
      LET g_errparam.extend = l_cmd
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_str CLIPPED
      CALL cl_err()
   END IF

   RETURN l_chk,l_str
END FUNCTION


#+ 切換工作路徑到製造匯出檔的工作目錄下
PUBLIC FUNCTION adzi800_change_pack_dir(p_pack_dir)
   DEFINE p_pack_dir        STRING     #打包檔置放路徑
  

   #記錄目前程式執行路徑
   LET g_work_dir = os.Path.pwd()

   IF NOT os.Path.chdir(p_pack_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_pack_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, p_pack_dir.trim())
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION


#+ 匯出檔下載
PRIVATE FUNCTION adzi800_download_data(p_tar_file)
   DEFINE p_tar_file        STRING 
   DEFINE l_pack_dir        STRING     #打包檔置放路徑
 
   DEFINE l_src             STRING     #來源文件
   DEFINE l_dst             STRING     #目的
   DEFINE l_work_dir        STRING     #目前程式執行路徑
   DEFINE l_folder          STRING     #匯出檔目錄
   DEFINE l_tar_name        STRING     #匯出包名稱
   DEFINE l_tar_file        STRING 
   DEFINE l_cmd             STRING
   DEFINE l_idx          SMALLINT 


   IF g_dzlr_m.dzlr001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   LET l_tar_file = p_tar_file 
   LET l_tar_name = os.Path.basename(l_tar_file)
   LET l_pack_dir = os.Path.dirname(l_tar_file)
  
 
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(l_tar_name) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00328"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_tar_name.trim()
      CALL cl_err()
      RETURN
   END IF
 
   #Server下載檔案路徑/檔名
   LET l_src = os.Path.JOIN(l_pack_dir, l_tar_name)
 
   #選擇本地端下載資料夾
   LET l_dst = cl_client_browse_dir()
 
   IF cl_null(l_dst) THEN
      #未選擇目錄
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00358"
      LET g_errparam.extend = "" 
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   LET l_dst = os.Path.JOIN(l_dst, l_tar_name)
   #下載檔案至Client端
   IF NOT cl_client_download_file(l_src, l_dst) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00329"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   ELSE
      CALL cl_ask_confirm3("adz-00330", l_tar_name.trim())
 
     ##下載成功後,從Server端刪除相關檔案
     ##刪除目錄
     #IF os.Path.EXISTS(l_folder) THEN
     #   LET l_cmd = "rm -rf ", l_folder
     #   RUN l_cmd
     #END IF
 
     ##刪除tar檔
     #IF os.Path.EXISTS(l_tar_name) THEN
     #   LET l_cmd = "rm ", l_tar_name
     #   RUN l_cmd
     #END IF
   END IF
 
   LET g_export_flag = TRUE
END FUNCTION

#+ 匯出檔上傳前置作業
PRIVATE FUNCTION adzi800_upload_data_pre()
   DEFINE l_unpack_dir      STRING     #解包位置需打包檔置放路徑
   DEFINE l_file            STRING
   DEFINE l_cmd             STRING

 
   #切換到$TEMPDIR工作目錄下
   LET l_unpack_dir = FGL_GETENV("TEMPDIR")
 
   IF NOT adzi800_change_pack_dir(l_unpack_dir) THEN
      RETURN FALSE
   END IF
 
   #匯出檔上傳
   CALL adzi800_upload_data(l_unpack_dir) RETURNING l_file

   IF cl_null(l_file) THEN
      RETURN FALSE
   END IF

   
   LET g_unpack_folder = os.Path.rootname(l_file) 
   #刪除目錄
   LET l_cmd = "rm -rf ", g_unpack_folder 
   RUN l_cmd

   #檢查目錄是否存在,檔案存在表示無法覆蓋(寫入權限),可能仍為舊檔
   IF os.Path.EXISTS(g_unpack_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "-816"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  g_unpack_folder.trim()
      CALL cl_err()
      RETURN FALSE
   END IF   

   #匯出檔zip檔解包
   CALL adzi800_unzip(l_file)

   LET g_unpack_folder = os.Path.rootname(l_file) 
   LET g_file = l_file 
   #切換回正確程式執行路徑
   IF NOT adzi800_change_work_dir() THEN
      RETURN FALSE
   END IF
 
   RETURN TRUE 
END FUNCTION

#+ 匯出檔zip解包 
PRIVATE FUNCTION adzi800_unzip(p_file)
   DEFINE p_file   STRING
   DEFINE l_file   STRING
   DEFINE l_cmd    STRING

   LET l_file = p_file

   #解包成tar檔範例:tar xvf $FOLDER.tgz
   LET l_cmd = "tar xvf ", l_file.trim()
   RUN l_cmd


END FUNCTION


#+ 匯出檔上傳
PRIVATE FUNCTION adzi800_upload_data(p_pack_dir)
   DEFINE p_pack_dir        STRING     #打包檔置放路徑
 
   DEFINE l_src             STRING     #來源文件
   DEFINE l_dst             STRING     #目的
   DEFINE l_work_dir        STRING     #目前程式執行路徑
   DEFINE l_folder          STRING     #匯出檔目錄
   DEFINE l_tar_name        STRING     #匯出包名稱
   DEFINE l_idx             LIKE type_t.num5
   DEFINE l_cmd             STRING
   DEFINE l_msg             STRING
 
   #Client選擇上傳匯出檔案
   LET l_src = cl_client_browse_file()
 
   #取得tar檔案名稱
   LET l_tar_name = os.Path.basename(l_src.trim())
 
   #取得匯出檔的目錄名稱
   LET l_idx = l_tar_name.getIndexOf(".tar", 1)
   IF l_idx > 1 THEN
      LET l_folder = l_tar_name.subString(1, l_idx - 1)
   END IF
 
   IF cl_null(l_tar_name) OR cl_null(l_folder) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00331"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_tar_name.trim()
      CALL cl_err()
      RETURN ''
   END IF

   #檢查目錄是否存在
   IF NOT adzi800_delete_pack(l_folder, l_tar_name) THEN
      RETURN
   END IF
 
   #Server上傳檔案路徑/檔名
   LET l_dst = os.Path.JOIN(p_pack_dir, l_tar_name)
 
   #上傳檔案至Server端
   IF NOT cl_client_upload_file(l_src, l_dst) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00332"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      CALL cl_ask_pressanykey("adz-00333")
   END IF
 
   #檢查tar是否存在
   IF NOT os.Path.EXISTS(l_tar_name) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00328"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_tar_name.trim()
      CALL cl_err()
      RETURN ''
   END IF

  #LET g_dst = l_dst CLIPPED 
   RETURN l_dst 
END FUNCTION

#+ 刪除匯出包目錄和tar檔                                          
PRIVATE FUNCTION adzi800_delete_pack(p_folder, p_tar_name)     
   DEFINE p_folder          STRING     #匯出檔目錄                
   DEFINE p_tar_name        STRING     #匯出包名稱                
                                                                  
   DEFINE l_msg             STRING                                
   DEFINE l_cmd             STRING                                
                                                                  
   #檢查目錄是否存在                                              
   IF os.Path.EXISTS(p_folder) THEN                               
      #是否為背景執行                                             
      IF g_show_msg = "Y" THEN                                    
         #詢問一下是否要刪除                                      
         LET l_msg = cl_getmsg_parm("adz-00323", g_lang, p_folder)
                                                                  
         IF NOT cl_ask_type1(l_msg, "Warning") THEN               
            RETURN FALSE                                          
         END IF                                                   
      END IF                                                      
                                                                  
      #刪除目錄                                                   
      LET l_cmd = "rm -rf ", p_folder                             
      RUN l_cmd                                                   
                                                                  
      #刪除tar檔                                                  
      IF os.Path.EXISTS(p_tar_name) THEN                          
         LET l_cmd = "rm ", p_tar_name                            
         RUN l_cmd                                                
      END IF                                                      
   END IF
                                                                                                                                
   #檢查tar是否存在                                                 
   IF os.Path.EXISTS(p_tar_name) THEN                               
       #是否為背景執行                                              
       IF g_show_msg = "Y" THEN                                     
         #詢問一下是否要刪除                                        
         LET l_msg = cl_getmsg_parm("adz-00323", g_lang, p_tar_name)
         IF NOT cl_ask_type1(l_msg, "Warning") THEN                 
            RETURN FALSE                                            
         END IF                                                     
      END IF                                                        
                                                                    
      #刪除tar檔                                                    
      LET l_cmd = "rm ", p_tar_name                                 
      RUN l_cmd                                                     
   END IF                                                           
                                                                    
   RETURN TRUE                                                      
END FUNCTION  

#+ 切換工作路徑到原本程式執行路徑下
PRIVATE FUNCTION adzi800_change_work_dir()

   IF cl_null(g_work_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00350"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg("adz-00350", g_lang)
      RETURN FALSE
   END IF

   #切換回正確程式執行路徑
   IF NOT os.Path.chdir(g_work_dir) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00340"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  g_work_dir.trim()
      CALL cl_err()
      LET g_error_message = "ERROR:", cl_getmsg_parm("adz-00340", g_lang, g_work_dir.trim())
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

############################################################                                                                                                           
#+ @code
#+ 函式目的  執行UNIX執行指令,並截取錯誤訊息
#+ @param    ps_cmd_show  STRING    要顯示於訊息的指令
#+ @param    ps_cmd       STRING    欲執行之指令字串(ex:paooi020 'A009' 'Y')
#+ @param    p_show       BOOLEAN   是否要顯示錯誤訊息
#+
#+ @return   BOOLEAN   是否執行成功
#+ @return   STRING    截取的錯誤訊息
############################################################
PRIVATE FUNCTION adzi800_openpipe(ps_cmd_show,ps_cmd,p_show)
   DEFINE ps_cmd_show       STRING         #要顯示於訊息的指令 ex: r.c
   DEFINE ps_cmd            STRING         #完整指令 ex: r.c prog
  #DEFINE p_show            BOOLEAN        #是否要顯示錯誤訊息
   DEFINE p_show            STRING         #判斷 解包unpack /打包pack 
   DEFINE l_chk             BOOLEAN        #是否執行成功
   DEFINE l_ch              base.Channel
   DEFINE l_buf             STRING
   DEFINE l_str             STRING
   DEFINE l_err_result      STRING
  #DEFINE g_errlog_file     STRING
   DEFINE l_errlog          base.Channel
   DEFINE l_errlog_path     STRING
  #DEFINE g_log_file        STRING
   DEFINE l_log             base.Channel
   DEFINE l_log_path        STRING
   DEFINE g_path            STRING
   DEFINE l_pack_path       STRING
   DEFINE l_dzlr001         LIKE dzlr_t.dzlr001

   IF cl_null(ps_cmd) THEN
      LET l_chk = FALSE
      RETURN l_chk
   ELSE
      LET l_chk = TRUE
   END IF

  #LET g_path = FGL_GETENV('TOP'),'/tmp/'
   LET g_path = FGL_GETENV("TEMPDIR")
   LET l_dzlr001 = g_dzlr001_no
   #161223-00031#1 ---start---
   #LOG
  #LET g_log_file = 'adzi800-',g_dzlr_m.dzlr001 CLIPPED,'-',TODAY USING 'YYYYMMDD','_.log'
  #LET g_log_file = 'adzi800-',l_dzlr001 CLIPPED,'-',TODAY USING 'YYYYMMDD','_.log'

   LET g_log_file = 'adzi800-',l_dzlr001 CLIPPED,'-',gs_time,p_show,'.log'
   LET  l_log_path = os.Path.join(g_path,g_log_file)
   LET  g_log_path = l_log_path
   LET  l_log = base.Channel.create()
   CALL l_log.openFile(l_log_path, "w")
   #ERROR
  #LET g_errlog_file = 'adzi800-',g_dzlr_m.dzlr001 CLIPPED,'-',TODAY USING 'YYYYMMDD','_ERR.log'
  #LET g_errlog_file = 'adzi800-',l_dzlr001 CLIPPED,'-',TODAY USING 'YYYYMMDD','_ERR.log'
   LET g_errlog_file = 'adzi800-',l_dzlr001 CLIPPED,'-',gs_time,p_show,'_ERR.log'
   LET  l_errlog_path = os.Path.join(g_path,g_errlog_file)
   LET  g_errlog_path = l_errlog_path 
   LET  l_errlog = base.Channel.create()
   CALL l_errlog.openFile(l_errlog_path, "w")
   #161223-00031#1 ---end---

   LET g_result = NULL
   LET l_pack_path = NULL
   LET l_err_result = NULL
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
 
  #LET ps_cmd = ps_cmd CLIPPED," 2>&1"
   LET ps_cmd = ps_cmd CLIPPED
 
   CALL l_ch.openPipe(ps_cmd,"r")   #執行指令
   IF STATUS THEN
      LET l_chk = FALSE
   ELSE
      WHILE TRUE
         CALL l_ch.readLine() RETURNING l_buf
         IF l_ch.isEof() THEN
            EXIT WHILE
         END IF

         LET g_result= g_result,l_buf,"\n"       #寫入log檔 
         DISPLAY l_buf   #顯示背景訊息
         #打包路徑
         LET l_str = l_buf.toUpperCase()
         IF l_str.getIndexOf("RQPG_PATH:",1) != 0 THEN
            LET l_pack_path = l_buf.substring(l_buf.getIndexOf("rqpg_path:",1)+10,l_buf.getlength())
         END IF
         IF l_str.getIndexOf("[PACK_FULL_NAME]",1) != 0 THEN
            LET l_pack_path = l_buf.substring(l_buf.getIndexOf("[Pack_Full_Name]",1)+16 ,l_buf.getlength())
         END IF
         #有錯誤訊息
         IF l_str.getIndexOf("BREAK_ERROR",1) != 0 THEN
            LET l_chk = FALSE
            LET l_pack_path = ''
            LET l_err_result = ps_cmd,'\n',g_result CLIPPED
            CALL l_errlog.writeLine(l_err_result)
            EXIT WHILE
         END IF
      END WHILE
   END IF
   LET g_all_result = ps_cmd,'\n',g_result 
   CALL l_log.writeLine(g_all_result)
   CALL l_ch.close()
   IF NOT cl_null(l_err_result) THEN 
      #錯誤訊息呈現
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00022"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_result 
      CALL cl_err()
      LET g_all_result = NULL
   END IF
  #IF p_show AND (NOT cl_null(l_err_result))  THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code =  "adz-00500"
  #   LET g_errparam.extend = ""
  #   LET g_errparam.popup = TRUE
  #   LET g_errparam.replace[1] = ps_cmd_show
  #   LET g_errparam.sqlerr = 0
  #   CALL cl_err()
  #   RETURN
  #END IF

   RETURN l_chk,l_pack_path
   DISPLAY "XXl_pack_path:",l_pack_path
END FUNCTION 


PRIVATE FUNCTION adzi800_get_xml_document(p_xml_document,p_xml_elements)
DEFINE
  p_xml_document  xml.DomDocument,
  p_xml_elements  xml.DomNode
DEFINE
  l_i             LIKE type_t.num5,
  lo_node_xml     xml.DomNode,
  lo_element_xml  xml.DomNode 
DEFINE 
  l_cnt           LIKE type_t.num5


  LET lo_element_xml = p_xml_document.getDocumentElement()
  LET l_i = 1
  FOR l_i = 1 TO g_dzlg_d.getLength() 
    #同一需求單項次多筆dzlm_t型態'T',寫入xml檔僅寫一次需求單#項次
    SELECT count(*) INTO l_cnt FROM dzlm_t
     WHERE dzlm001 = 'T' 
       AND dzlm012 = g_dzlg_d[l_i].dzlg001 
       AND dzlm013 = g_dzlr002
       AND dzlm014 = g_dzlr003
       AND dzlm015 = g_dzlg_d[l_i].dzlg004
    IF l_cnt = 0 THEN
       CONTINUE FOR
    END IF
    
    LET lo_node_xml = lo_element_xml.appendChildElement("request")
    CALL lo_node_xml.setAttribute("no",g_dzlg_d[l_i].dzlg001)
    CALL lo_node_xml.setAttribute("sequence",g_dzlg_d[l_i].dzlg004)

  END FOR

END FUNCTION

#RIVATE FUNCTION adzi800_udzlr()
#  DEFINE lwin_curr      ui.Window
#  DEFINE lfrm_curr      ui.Form
#  DEFINE ls_path        STRING


#  OPEN WINDOW w_adzi800_s01 WITH FORM cl_ap_formpath("adz","adzi800_s01")

#  LET lwin_curr = ui.Window.getCurrent()
#  LET lfrm_curr = lwin_curr.getForm()
#  LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
#  LET ls_path = os.Path.join(ls_path,"toolbar_i.4tb")
#  CALL lfrm_curr.loadToolBar(ls_path)

#  LET g_sql = "SELECT dzlr005, dzlr015  ",
#              "  FROM dzlr_t ",
#              "  WHERE dzlr001 = ? AND dzlr002 = ? AND dzlr003 = ? "

#  PREPARE adzi800_udzlr FROM g_sql   

#  #
#  EXECUTE adzi800_udzlr USING g_dzlr_m.dzlr001,g_dzlr002,g_dzlr003
#     INTO g_dzlr_udzlr.dzlr005,g_dzlr_udzlr.dzlr015
#  IF SQLCA.sqlcode THEN
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.code = SQLCA.sqlcode
#     LET g_errparam.extend = "dzlr_t"
#     LET g_errparam.popup = TRUE
#     CALL cl_err()

#     INITIALIZE g_dzlr_udzlr.* TO NULL

#     RETURN
#  END IF

#  DISPLAY BY NAME g_dzlr_udzlr.dzlr005,g_dzlr_udzlr.dzlr015

#  INPUT BY NAME g_dzlr_udzlr.status_h

#     BEFORE INPUT
#        LET g_dzlr_udzlr.status_h = 'p'
#        DISPLAY BY NAME g_dzlr_udzlr.status_h


#  END INPUT

#  IF INT_FLAG THEN
#     LET INT_FLAG = 0
#     CLOSE WINDOW w_adzi800_s01 
#     RETURN
#  END IF


#  CLOSE WINDOW w_adzi800_s01

#ND FUNCTION

PRIVATE FUNCTION adzi800_del_chk(p_dzlg001,p_dzlg002,p_dzlg003,p_dzlg004)
   DEFINE p_dzlg001        LIKE dzlg_t.dzlg001
   DEFINE p_dzlg002        LIKE dzlg_t.dzlg002
   DEFINE p_dzlg003        LIKE dzlg_t.dzlg003
   DEFINE p_dzlg004        LIKE dzlg_t.dzlg004
   DEFINE l_cntm           LIKE type_t.num5
   DEFINE l_cntd           LIKE type_t.num5
   DEFINE l_cntf           LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE r_success        LIKE type_t.num5


   LET r_success = FALSE 

   LET l_cntm = 0
   LET l_cntd = 0
   LET l_cntf = 0
   LET l_cnt  = 0
   #dzlm
   LET g_sql = "SELECT COUNT(*) FROM dzlm_t ",
               " WHERE dzlm012 = '",p_dzlg001 CLIPPED,"' ",
               "   AND dzlm013 = '",p_dzlg002 CLIPPED,"' ",
               "   AND dzlm014 = '",p_dzlg003 CLIPPED,"' " 
   IF NOT cl_null(p_dzlg004) THEN
      LET g_sql = g_sql," AND dzlm015 = '",p_dzlg004 CLIPPED,"' "
   END IF
   PREPARE chk_p1 FROM g_sql
   EXECUTE chk_p1 INTO l_cntm

   #dzld
   LET g_sql = "SELECT COUNT(*) FROM dzld_t ",
               " WHERE dzld011 = '",p_dzlg001 CLIPPED,"' ",
               "   AND dzld012 = '",p_dzlg002 CLIPPED,"' ",
               "   AND dzld013 = '",p_dzlg003 CLIPPED,"' " 
   IF NOT cl_null(p_dzlg004) THEN
      LET g_sql = g_sql," AND dzld014 = '",p_dzlg004 CLIPPED,"' "
   END IF
   PREPARE chk_p2 FROM g_sql
   EXECUTE chk_p2 INTO l_cntd

   #dzlf
   LET g_sql = "SELECT COUNT(*) FROM dzlf_t ",
               " WHERE dzlf008 = '",p_dzlg001 CLIPPED,"' ",
               "   AND dzlf009 = '",p_dzlg002 CLIPPED,"' ",
               "   AND dzlf010 = '",p_dzlg003 CLIPPED,"' " 
   IF NOT cl_null(p_dzlg004) THEN
      LET g_sql = g_sql," AND dzlf011 = '",p_dzlg004 CLIPPED,"' "
   END IF
   PREPARE chk_p3 FROM g_sql
   EXECUTE chk_p3 INTO l_cntf

   LET l_cnt = l_cntm + l_cntd + l_cntf
 
   IF l_cnt = 0 THEN
      LET r_success = TRUE
   END IF

   RETURN r_success 
END FUNCTION


PRIVATE FUNCTION adzi800_zz(p_dzlr001,p_dzlr002,p_dzlr003,p_dzlr005)

   DEFINE p_dzlr001     LIKE dzlr_t.dzlr001      #需求單號
   DEFINE p_dzlr002     LIKE dzlr_t.dzlr002      #產品代號
   DEFINE p_dzlr003     LIKE dzlr_t.dzlr003      #產品版本
   DEFINE p_dzlr005     LIKE dzlr_t.dzlr005      #階段
   DEFINE l_result      LIKE type_t.chr1
   DEFINE l_dzlm017     DATETIME YEAR TO MINUTE  #簽入時間


   LET l_result = 'N' 

   IF cl_null(p_dzlr001) OR cl_null(p_dzlr002) OR cl_null(p_dzlr003) OR
      cl_null(p_dzlr005) THEN
      RETURN l_result
   END IF

   #非結案狀態,不更新
   IF p_dzlr005 <> 'ZZ' THEN
      RETURN l_result
   END IF

   LET l_result = 'Y'

   #更新dzlm資料,更新簽入時間
   LET l_dzlm017 = CURRENT YEAR TO MINUTE
   UPDATE dzlm_t SET dzlm017 = l_dzlm017
    WHERE dzlm012 = p_dzlr001
      AND dzlm013 = p_dzlr002
      AND dzlm014 = p_dzlr003
      AND (dzlm008 = 'O' OR dzlm011 = 'O')        #針對目前簽出更新簽入時間   #161012-00031#1
   IF SQLCA.sqlcode THEN
      LET l_result = 'N'
   END IF 

   #更新dzlm資料,當該需求單為ZZ則簽出為"I"(簽入)
   UPDATE dzlm_t SET dzlm008 = 'I'
    WHERE dzlm008 IS NOT NULL
      AND dzlm012 = p_dzlr001
      AND dzlm013 = p_dzlr002
      AND dzlm014 = p_dzlr003
      AND (dzlm008 = 'O')                 #針對簽出更新成簽入,已釋出I不異動  #161012-00031#1
   IF SQLCA.sqlcode THEN
      LET l_result = 'N'
   END IF


   #更新dzlm資料,當該需求單為ZZ則簽出為"I"(簽入)
   UPDATE dzlm_t SET dzlm011 = 'I'
    WHERE dzlm011 IS NOT NULL
      AND dzlm012 = p_dzlr001
      AND dzlm013 = p_dzlr002
      AND dzlm014 = p_dzlr003
      AND (dzlm011 = 'O')                #針對簽出更新成簽入,已釋出I不異動  #161012-00031#1
   IF SQLCA.sqlcode THEN
      LET l_result = 'N'
   END IF

  ##更新dzlm資料,更新簽入時間
  #LET l_dzlm017 = CURRENT YEAR TO MINUTE
  #UPDATE dzlm_t SET dzlm017 = l_dzlm017
  # WHERE dzlm012 = p_dzlr001
  #   AND dzlm013 = p_dzlr002
  #   AND dzlm014 = p_dzlr003
  #IF SQLCA.sqlcode THEN
  #   LET l_result = 'N'
  #END IF

   RETURN l_result


END FUNCTION

PRIVATE FUNCTION adzi800_create_temp_table()
   DROP TABLE adzi800_pack_scm
   #Create temp table 程式識別資料匯出
   CREATE TEMP TABLE adzi800_pack_scm
   (
       dzaf001    LIKE dzaf_t.dzaf001,      #建構代號
       dzaf002    LIKE dzaf_t.dzaf002,      #建構版號
       dzaf003    LIKE dzaf_t.dzaf003,      #規格版號
       dzaf004    LIKE dzaf_t.dzaf004,      #代碼版號
       dzaf005    LIKE dzaf_t.dzaf005,      #建構類型
       dzaf006    LIKE dzaf_t.dzaf006,      #模組 
       dzaf007    LIKE dzaf_t.dzaf007,      #產品代號
       dzaf008    LIKE dzaf_t.dzaf008,      #產品版本
       dzaf009    LIKE dzaf_t.dzaf009,      #客戶代號
       dzaf010    LIKE dzaf_t.dzaf010       #識別標示
   )
END FUNCTION

PUBLIC FUNCTION adzi800_get_path(p_path)
   DEFINE p_path            STRING             #檔案路徑
   DEFINE l_idx_start       LIKE type_t.num5
   DEFINE l_idx_end         LIKE type_t.num5
   DEFINE l_var             STRING
   DEFINE l_str             STRING
   DEFINE l_length          LIKE type_t.num5

   #環境變數應該都用"$"字元起頭
   LET l_idx_start = p_path.getIndexOf("$", 1)
   LET l_length = p_path.getLength()

   IF l_idx_start > 0 THEN
      #取得環境變數完整名稱
      LET l_idx_end = p_path.getIndexOf("/", l_idx_start)

      IF l_idx_end > 0 THEN
         LET l_var = p_path.subString(l_idx_start + 1, l_idx_end - 1)
         LET l_str = FGL_GETENV(l_var)

         #取替代字串
         LET l_var = "$", l_var.trim()
         LET p_path = cl_replace_str(p_path, l_var, l_str)

         LET p_path = adzi800_get_path(p_path)
      ELSE
         LET l_var = p_path.subString(l_idx_start + 1, l_length)
         LET l_str = FGL_GETENV(l_var)

         #取替代字串
         LET l_var = "$", l_var.trim()
         LET p_path = cl_replace_str(p_path, l_var, l_str)
         RETURN p_path
      END IF
   END IF

   RETURN p_path
END FUNCTION

PRIVATE FUNCTION adzi800_dzaft(p_table,p_type)
   DEFINE p_table   LIKE dzaf_t.dzaf001 
   DEFINE p_type    LIKE dzaf_t.dzaf005
   DEFINE l_dzaf_t  T_DZAF_T   
   
      #若dzaf_t 同一建構代號(TABLE) 同一版次有s及c時,則取得c為優先
      LET g_sql = " SELECT *                                                                                               ",
                  "   FROM dzaf_t af0                                                                                      ",
                  "  WHERE af0.dzaf001 = '",p_table ,"'                                                                   ",#建構代號
                  "    AND af0.dzaf005 = '",p_type ,"'                                                                    ",#建構類型
                  "    AND (af0.dzaf002,af0.dzaf010) = (                                                                   ",
                  "                                       SELECT decode(afc.dzaf002,null,afs.dzaf002,afc.dzaf002) dzaf002, ",
                  "                                              decode(afc.dzaf002,null,afs.dzaf010,afc.dzaf010) dzaf010  ",
                  "                                         FROM (                                                         ",
                  "                                                SELECT '",p_table,"' dzaf001                           ",
                  "                                                  FROM dual                                             ",
                  "                                              ) afo,                                                    ",
                  "                                              (                                                         ",
                  "                                               SELECT af.dzaf001,max(af.dzaf002) dzaf002,af.dzaf010     ",
                  "                                                 FROM dzaf_t af                                         ",
                  "                                                WHERE af.dzaf010 = 's'                                  ",
                  "                                                group by af.dzaf001,af.dzaf010                          ",
                  "                                              ) afs,                                                    ",
                  "                                              (                                                         ",
                  "                                               SELECT af.dzaf001,max(af.dzaf002) dzaf002,af.dzaf010     ",
                  "                                                 FROM dzaf_t af                                         ",
                  "                                                WHERE af.dzaf010 = 'c'                                  ",
                  "                                                group by af.dzaf001,af.dzaf010                          ",
                  "                                              ) afc                                                     ",
                  "                                        WHERE afs.dzaf001 (+)= afo.dzaf001                              ",
                  "                                          AND afc.dzaf001 (+)= afo.dzaf001                              ",
                  "                                     )                                                                  "

      PREPARE adzi800_dzaft1 FROM g_sql 
      EXECUTE adzi800_dzaft1 INTO l_dzaf_t.*
 
      RETURN l_dzaf_t.*      
END FUNCTION     

#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi800_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   IF p_cmd <> "a" AND p_cmd <> "u" THEN
      CALL cl_set_comp_entry("dzlr001",TRUE)
   END IF

END FUNCTION

#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi800_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1

   IF p_cmd = "a" OR p_cmd = "u" THEN
     #170208-00023#1 ---start---
     #增加dzlr010發起日為不可維護
     #CALL cl_set_comp_entry("dzlr001",FALSE)
      CALL cl_set_comp_entry("dzlr001,dzlr010",FALSE)
     #170208-00023#1 ---end---
   END IF
END FUNCTION
    
#161012-00031#1
#+ 單頭dzlr005 階段欄位關閉設定
PRIVATE FUNCTION adzi800_set_dzlr005_scc(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   IF p_cmd = "a" OR p_cmd = "u" THEN
      CALL adzi800_set_combo_scc_exclude('dzlr005','1209','ZZ')
   ELSE
      CALL cl_set_combo_scc('dzlr005','1209')
   END IF
END FUNCTION 

PRIVATE FUNCTION adzi800_pack_chk()
   DEFINE lnp_DZAF_T          T_DZAF_T  
   DEFINE lc_dzlm             type_l_dzlm_chk  
   DEFINE lc_dzlm2            type_l_dzlm_chk  
   DEFINE l_chk_msg1          STRING
   DEFINE l_chk_msg2          STRING
   DEFINE l_chk_msg           STRING
   DEFINE l_msg_str           STRING
   DEFINE l_chk_fg            BOOLEAN
   DEFINE l_scc_desc          LIKE gzcbl_t.gzcbl004

   CALL cl_err_collect_init()      #錯誤訊息統整顯示
   LET l_chk_fg = TRUE
   LET g_sql = "SELECT dzlm012,dzlm013,dzlm014,dzlm015,dzlm001,dzlm002,dzlm005,dzlm007,dzlm008,dzlm010,dzlm011 FROM dzlm_t",
                " WHERE dzlm012 = '",g_dzlr_m.dzlr001 CLIPPED ,"' " 
   PREPARE adzi800_dzlm_chk FROM g_sql
   DECLARE adzi800_dzlm_chk_curs CURSOR FOR adzi800_dzlm_chk                                          
   FOREACH adzi800_dzlm_chk_curs INTO lc_dzlm.* 
      DISPLAY "lc_dzlm:",lc_dzlm.*   
      #檢核DZLM資料 相同類型建構代號的建構版次比打包的建構版次還要大
      LET g_sql = "SELECT dzlm012,dzlm013,dzlm014,dzlm015,dzlm001,dzlm002,dzlm005,dzlm007,dzlm008,dzlm010,dzlm011 FROM dzlm_t",
                   " WHERE dzlm001 = '",lc_dzlm.dzlm001 CLIPPED ,"' ",
                   "   AND dzlm002 = '",lc_dzlm.dzlm002 CLIPPED ,"' "
      PREPARE adzi800_dzlm2 FROM g_sql
      DECLARE adzi800_dzlm_curs2 CURSOR FOR adzi800_dzlm2                                          
      FOREACH adzi800_dzlm_curs2 INTO lc_dzlm2.* 
         IF lc_dzlm2.dzlm005 > lc_dzlm.dzlm005 THEN
            DISPLAY "相同類型建構代號的建構版次比打包的建構版次還要大"
            LET l_chk_msg1 = ' ' 
            LET l_chk_msg2 = ' ' 
            IF NOT cl_null(lc_dzlm2.dzlm008) THEN
               CALL cl_get_scc_desc('1210',lc_dzlm2.dzlm008) RETURNING l_scc_desc #轉碼    I:簽入  O:簽出   
               LET l_chk_msg1 = cl_getmsg('adb-00385',g_lang),lc_dzlm2.dzlm008,":",l_scc_desc,' '
            END IF
            IF NOT cl_null(lc_dzlm2.dzlm011) THEN   
               CALL cl_get_scc_desc('1210',lc_dzlm2.dzlm011) RETURNING l_scc_desc #轉碼    I:簽入  O:簽出  
               LET l_chk_msg2 = cl_getmsg('adz-01022',g_lang),lc_dzlm2.dzlm011,":",l_scc_desc
            END IF           
            LET l_chk_msg = l_chk_msg1,l_chk_msg2 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-01018"     #建構類型%1的建構代號:%2 建構版次:%3 為需求單:%4(%5)
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = lc_dzlm.dzlm001 
            LET g_errparam.replace[2] = lc_dzlm.dzlm002
            LET g_errparam.replace[3] = lc_dzlm2.dzlm005
            LET g_errparam.replace[4] = lc_dzlm2.dzlm012
            LET g_errparam.replace[5] = l_chk_msg
            CALL cl_err()
            LET l_chk_fg = FALSE 
         END IF
      END FOREACH
      #161223-00031#1 ---start---
      #元件建構代號B 子程式S
      IF lc_dzlm.dzlm001 = 'B' OR lc_dzlm.dzlm001 = 'S' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-01149"     #清單含(B:元件或S:子程式),將執行 r.l %1 ALL
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = lc_dzlm.dzlm002 
         CALL cl_err()
         LET l_chk_fg = FALSE 
      END IF
      #161223-00031#1 ---end---
   END FOREACH
   CALL cl_err_collect_show()
   RETURN l_chk_fg
END FUNCTION  
#161012-00031#1

#161005-00011#1               
#+ 設定屬於註冊資料的維護作業有那些
PRIVATE FUNCTION adzi800_dzld005_items_fill()
   DEFINE l_sql             STRING
   DEFINE l_dzld005_value   STRING
   DEFINE l_dzld005_label   STRING
   DEFINE l_gzzal001        LIKE gzzal_t.gzzal001
   DEFINE l_gzzal003        LIKE gzzal_t.gzzal003

   LET l_dzld005_value = ""
   LET l_dzld005_label = ""

   #設定程式註冊資料來源的維護作業有那些

   LET l_sql = "SELECT gzzal001, gzzal003 ",
               "  FROM gzzal_t ",
               "  WHERE gzzal001 IN (SELECT DISTINCT dzyb001 FROM dzyb_t ",
               "                       WHERE dzyb001 NOT IN ('design_data')) ",
               "    AND gzzal002 = ? ",
               "  ORDER BY gzzal001 "

   PREPARE adzi800_dzld005_pre FROM l_sql
   DECLARE adzi800_dzld005_cs CURSOR FOR adzi800_dzld005_pre

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE adzi800_dzld005_cs:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   OPEN adzi800_dzld005_cs USING g_lang
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi800_dzld005_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi800_dzld005_cs
      RETURN FALSE
   END IF
   

   FOREACH adzi800_dzld005_cs INTO l_gzzal001, l_gzzal003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH adzi800_dzld005_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF

      #維護作業程式代號
      IF cl_null(l_dzld005_value) THEN
         LET l_dzld005_value = l_gzzal001
      ELSE
         LET l_dzld005_value = l_dzld005_value, ",", l_gzzal001
      END IF

      #items說明
      IF cl_null(l_dzld005_label) THEN
         LET l_dzld005_label = l_gzzal001, "(", l_gzzal003, ")"
      ELSE
         LET l_dzld005_label = l_dzld005_label, ",", l_gzzal001, "(", l_gzzal003, ")"
      END IF
   END FOREACH

   #設定維護作業
   CALL cl_set_combo_items("dzld005", l_dzld005_value, l_dzld005_label)

   RETURN TRUE
END FUNCTION   

FUNCTION adzi800_refill_combobox(p_lang)
DEFINE
  p_customize BOOLEAN,
  p_lang      STRING
DEFINE
  lb_customize BOOLEAN,
  ls_lang      STRING,
  ls_sql       STRING,
  ls_customize_sql STRING

  LET lb_customize = p_customize
  LET ls_lang = p_lang
  
  LET ls_sql = "SELECT DISTINCT GZCB002       SPEC_TYPE,      ",
               "       GZCB002||'. '||GZCBL004 SPEC_NAME      ",
               "  FROM GZCB_T CB                              ",
               "  LEFT OUTER JOIN GZCBL_T                     ",
               "               ON GZCB001  = GZCBL001         ",
               "              AND GZCB002  = GZCBL002         ",
               "              AND GZCBL003 = '",ls_lang,"'    ",
               " WHERE CB.GZCB001 = 114 OR CB.GZCB001 = 138   " 

  CALL adzi800_find_and_fill_combobox("formonly.dzlm001",ls_sql)

END FUNCTION
  
FUNCTION adzi800_find_and_fill_combobox(p_component_name,p_sql)
DEFINE
  p_component_name STRING,
  p_sql           STRING
DEFINE
  lo_combobox ui.ComboBox

  LET lo_combobox = ui.ComboBox.forName(p_component_name)
  CALL adzi800_fill_combobox(lo_combobox,p_sql)

END FUNCTION


FUNCTION adzi800_fill_combobox(p_combobox,p_sql)
DEFINE
  p_combobox ui.ComboBox,
  p_sql      STRING
DEFINE
  ls_sql    STRING,
  li_count  INTEGER,
  lo_module RECORD
              combobox_name VARCHAR(50),
              combobox_desc VARCHAR(255)
            END RECORD

  LET ls_sql = p_sql

  PREPARE lpre_combobox FROM ls_sql
  DECLARE lcur_combobox SCROLL CURSOR FOR lpre_combobox

  CALL p_combobox.clear()

  LET li_count = 0

  OPEN lcur_combobox
  FOREACH lcur_combobox INTO lo_module.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    CALL p_combobox.addItem(lo_module.combobox_name,lo_module.combobox_desc)
    LET li_count = li_count + 1
  END FOREACH
  CLOSE lcur_combobox

  FREE lcur_combobox
  FREE lpre_combobox

END FUNCTION  
 
FUNCTION adzi800_db_check_table_lock(p_table_name)
DEFINE
  p_table_name  STRING
DEFINE  
  ls_sql        STRING,
  li_rec_count  INTEGER,
  ls_table_name STRING,
  ls_enterprise STRING,
  lv_user_name  VARCHAR(500)
DEFINE
  lb_return     BOOLEAN,
  ls_user_name  STRING  

  LET ls_table_name = p_table_name.toUpperCase()

  LET ls_enterprise = g_enterprise
  
  #取得資料筆數
  LET ls_sql = "SELECT COUNT(1),L.OS_USER_NAME||'-'||AG.OOAG011 USERNAME     ",                  
               "  FROM GV$LOCKED_OBJECT L                                    ",
               " INNER JOIN DBA_OBJECTS O ON O.OBJECT_ID = L.OBJECT_ID       ",
               " INNER JOIN V$SESSION V ON V.SID = L.SESSION_ID              ",
               " INNER JOIN V$PROCESS P ON P.ADDR= V.PADDR                   ",
               "  LEFT OUTER JOIN (                                          ",   
               "                    SELECT XA.GZXA001,AG.OOAG011             ",   
               "                      FROM DSDEMO.OOAG_T AG,                 ",   
               "                           DSDEMO.GZXA_T XA                  ",   
               "                     WHERE XA.GZXAENT = AG.OOAGENT           ",   
               "                        AND AG.OOAG001 = XA.GZXA003          ",    
               "                        AND XA.GZXAENT = '",ls_enterprise,"' ",
               "                      GROUP BY XA.GZXA001,AG.OOAG011         ",    
               "                      ORDER BY XA.GZXA001                    ",    
               "                  ) AG                                       ",
               "                  ON AG.GZXA001 = L.OS_USER_NAME             ",
               " WHERE 1=1                                                   ",
               "   AND O.OBJECT_NAME = '",ls_table_name.toUpperCase(),"'     ",
               "   AND V.LOCKWAIT IS NULL                                    ",
               " GROUP BY L.OS_USER_NAME||'-'||AG.OOAG011                    ",
               " ORDER BY 2                                                  "

  PREPARE lpre_check_table_lock FROM ls_sql
  DECLARE lcur_check_table_lock CURSOR FOR lpre_check_table_lock
  OPEN lcur_check_table_lock
  FETCH lcur_check_table_lock INTO li_rec_count,lv_user_name
  CLOSE lcur_check_table_lock
  FREE lcur_check_table_lock
  FREE lpre_check_table_lock

  LET ls_user_name = lv_user_name
  IF li_rec_count = 0 THEN
    LET lb_return = FALSE
  ELSE
    LET lb_return = TRUE
  END IF
  
  RETURN lb_return,ls_user_name
  
END FUNCTION
#161005-00011#1     

################################################################################
# Descriptions...: 動態設定排除指定不要的SCC資料,留下剩餘的ComboBox選項
# Memo...........:
# Usage..........: CALL cl_set_combo_scc_exclude()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....:
# Date & Author..: 2016/05/25 By jrg542
# Modify.........: 160525-00015 #1
################################################################################
PUBLIC FUNCTION adzi800_set_combo_scc_exclude(ps_field_name,pc_gzca001,ls_token)
   DEFINE ps_values      STRING
   DEFINE ps_items       STRING
   DEFINE ps_field_name  STRING
   DEFINE pc_gzca001     LIKE gzca_t.gzca001      #系統分類碼
   DEFINE pc_gzcb002     LIKE gzcb_t.gzcb002      #系統分類值
   DEFINE pc_gzcbl004    LIKE gzcbl_t.gzcbl004    #說明
   DEFINE ls_token       STRING
   DEFINE l_token        base.StringTokenizer
   DEFINE li_pos         LIKE type_t.num5
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE l_array  DYNAMIC ARRAY OF STRING
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING,
             label_tag   STRING,
             label       STRING
                   END RECORD

   WHENEVER ERROR CALL cl_err_msg_log

   #優先處理 token
   LET l_token = base.StringTokenizer.create(ls_token,",")
   LET li_cnt = 1
   WHILE l_token.hasMoreTokens()
      LET l_array[li_cnt] = l_token.nextToken()
      LET li_cnt = li_cnt + 1
   END WHILE

   SELECT gzca001 INTO pc_gzca001 FROM gzca_t
    WHERE gzca001 = pc_gzca001 AND gzcastus = "Y"

   IF NOT cl_null(pc_gzca001) THEN
      DECLARE p_scc_iteme_cs CURSOR FOR
       SELECT gzcb002, gzcbl004
         FROM gzcb_t LEFT JOIN gzcbl_t ON gzcb002 = gzcbl002
                                      AND gzcb001 = gzcbl001
                                      AND gzcb001 = pc_gzca001
                                      AND gzcbl003 = g_dlang
        WHERE gzcb001 IN (SELECT gzcb001
                            FROM gzcb_t
                           WHERE gzcb001 = pc_gzca001)
        ORDER BY gzcb012
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "lib-00068"
         LET g_errparam.extend = "gzcb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         LET ps_values = ''
         LET ps_items = ''

         #將選項填入陣列
         LET li_cnt = 1
         FOREACH p_scc_iteme_cs INTO pc_gzcb002, pc_gzcbl004

            LET pa_array[li_cnt].value = pc_gzcb002 CLIPPED
            IF NOT g_notneed_labeltag THEN
               LET pa_array[li_cnt].label_tag = pc_gzcb002 CLIPPED
            END IF
            LET pa_array[li_cnt].label = pc_gzcbl004 CLIPPED
            LET li_cnt = li_cnt + 1
            CONTINUE FOREACH
         END FOREACH

         LET li_pos = 1
         WHILE TRUE
            IF l_array.getLength() < li_pos THEN
               EXIT WHILE
            END IF
            FOR li_cnt = 1 TO pa_array.getLength()
               IF l_array[li_pos] = pa_array[li_cnt].value THEN
                  CALL pa_array.deleteElement(li_cnt)
                  EXIT FOR
               END IF
            END FOR
            LET li_pos = li_pos + 1
         END WHILE

         CALL cl_set_combo_detail(ps_field_name, pa_array)
      END IF
      CLOSE p_scc_iteme_cs
      FREE p_scc_iteme_cs
   END IF
END FUNCTION


############################################################
#+ @code
#+ 函式目的  設定ComboBox的Item (以array形式傳入)
#+ @param    ps_field_name  STRING  ComboBox所對應的欄位名稱
#+ @param    pa_array
#+ @param    value      STRING  value所對應的儲存值字串
#+ @param    value_tag  STRING  tag組成字串1 (可保留為NULL)
#+ @param    tag        STRING  tag組成字串2 (組合為tag1:tag2)
############################################################
PUBLIC FUNCTION adzi800_set_combo_detail(ps_field_name,pa_array)
   DEFINE ps_field_name  STRING
   DEFINE lcbo_target    ui.ComboBox
   DEFINE ls_temp        STRING
   DEFINE lwin_curr      ui.Window
   DEFINE f              ui.form
   DEFINE r              om.DomNode
   DEFINE c              om.domnode
   DEFINE lc_gztz001     LIKE gztz_t.gztz001
   DEFINE lc_gztz002     LIKE gztz_t.gztz002
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING,
             label_tag   STRING,
             label       STRING
                     END RECORD
   DEFINE li_cnt LIKE type_t.num5

   WHENEVER ERROR CALL cl_err_msg_log

   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]" THEN
      RETURN
   END IF

   LET ps_field_name = ps_field_name.trim()
   CALL lcbo_target.clear()
   LET lcbo_target = ui.ComboBox.forName(ps_field_name)
   #判斷是Combobox 或是 RadioGroup (NULL即為RadioGroup)
   IF lcbo_target IS NULL THEN
      #以下是RadioGroup 的處理
      LET lwin_curr = ui.Window.getCurrent()
      LET f = lwin_curr.getForm()
      IF f IS NOT NULL THEN
         LET lc_gztz002 = ps_field_name CLIPPED
         SELECT gztz001 INTO lc_gztz001 FROM gztz_t
          WHERE gztz002 = lc_gztz002
         IF SQLCA.SQLCODE THEN
            IF NOT ps_field_name.getIndexof("formonly",1) THEN
               LET ps_field_name = "formonly.",lc_gztz002
            END IF
         ELSE
            LET ps_field_name = lc_gztz001,".",lc_gztz002
         END IF
         LET r = f.findNode("FormField", ps_field_name)
         LET r = r.getfirstchild()
         FOR li_cnt = 1 TO pa_array.getLength()
            LET c = r.createChild("Item")
            CALL c.setattribute("name", pa_array[li_cnt].value)
            CALL c.setattribute("text", pa_array[li_cnt].label)
         END FOR
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "lib-00070"
         LET g_errparam.extend = ps_field_name
         LET g_errparam.popup = TRUE
         CALL cl_err()
  #欄位不存在此畫面中
      END IF
      RETURN
   ELSE
      CALL lcbo_target.clear()
   END IF
   CALL lcbo_target.clear()
   #以下是Combobox的處理
   FOR li_cnt = 1 TO pa_array.getLength()
       IF cl_null(pa_array[li_cnt].label_tag) THEN
          LET ls_temp = pa_array[li_cnt].label
       ELSE
          LET ls_temp = pa_array[li_cnt].label_tag,":",pa_array[li_cnt].label
       END IF
       #display "combo_detail pa_array[li_cnt].value:",pa_array[li_cnt].value , " li_cnt:",li_cnt
      CALL lcbo_target.addItem(pa_array[li_cnt].value,ls_temp)
   END FOR

END FUNCTION                                                  
