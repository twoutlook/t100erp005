#該程式未解開Section, 採用最新樣板產出!
{<section id="awsi013.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2015-11-24 15:56:17), PR版次:0015(2016-12-20 12:48:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000479
#+ Filename...: awsi013
#+ Description: 單據性質簽核設定
#+ Creator....: 01375(2013-12-10 10:35:19)
#+ Modifier...: 07375 -SD/PR- 07556
 
{</section>}
 
{<section id="awsi013.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151105-00002#20 2016/05/30 By nikoybeat  取得bpm相關參數方式調整
#160902-00024#1  2016/09/05 By Jessica    單身控卡調整:
#                                         1.AFTER FIELD wsab004，原本控卡wsab005為空值時報錯aws-00010，請移除此檢查。
#                                         2.AFTER FIELD wsab005，原本控卡wsab005為空值時報錯aws-00010，請移除此檢查，並改成:
#                                           若wsab005有值但wsab006無值，則提示: aws-00011 是否建立簽核流程，按是則建立流程。
#                                         3.單身儲存時，需檢查wsab006(簽核流程編號)為必填。
#160902-00024#11 2016/12/14 By Jessica    1.單頭、單身的[wsab006簽核流程編號]改為不可編輯
#                                         2.MENU明細操作，針對單身-營運據點流程，增加功能:
#                                         (1)刪除營運據點簽核流程 
#                                         (2)BPM簽核流程設計師
#                                         3.刪除流程，BPM回覆失敗，卻把[wsab006簽核流程編號]清空了，請修正
#                                         4.單頭建立流程應為據點ALL卻帶入g_site(操作:修改->整單操作.建立簽核流程)
#                                         5.原本參考到單據性質: gzcbl_t(系統分類值多語言檔) gzcbl002=24(單據性質)，改成: gzzal_t(程式名稱多語言記錄表)
#                                         6.查詢頁的樹狀資料來源(參照表+單別)，需join參照表資料檔ooal_t
#                                         7.cl_bpm_flow_delete 增加return值
#161102-00047#14 2016/12/16 By nikoybeat  新增調整權限過濾段落
#160902-00024#12 2016/12/19 By Jessica    1.執行以下功能時，若未啟用BPM整合，則提示 aws-00081 "未啟用BPM協同!"
#                                         (1)整單操作: 建立流程、刪除流程、工作流程設計師、簽核流程設計師
#                                         (2)明細操作: 建立流程、刪除流程、簽核流程設計師
#                                         2.單頭、單身的簽核流程編號若為空值，儲存及AFTER FIELD原本會詢問 aws-00011 "是否建立簽核流程"
#                                           在此之前加入檢查，若未啟用BPM整合，則直接返回(不出現aws-00011)
#                                         3.取得簽核流程代號與名稱 cl_bpm_process_list_get()，若未啟用BPM整合，則不執行
#                                         4.預先取回所有的模版名稱 cl_bpm_flow_template_get()，若未啟用BPM整合，則不執行
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_wsab_m        RECORD
       wsaa001          LIKE wsaa_t.wsaa001,
       wsab001_desc     LIKE type_t.chr80,
       wsab002          LIKE wsab_t.wsab002,
       wsab003          LIKE wsab_t.wsab003,
       wsab003_desc     LIKE type_t.chr80,
       wsab005_m        LIKE wsab_t.wsab005,
       wsab005_m_desc   LIKE type_t.chr80,
       wsab006_m        LIKE wsab_t.wsab006,
       wsab006_m_desc   LIKE type_t.chr80,
       wsab007          LIKE wsab_t.wsab006
       END RECORD

#單身 type 宣告
 TYPE type_g_wsab_d        RECORD
       wsab004           LIKE wsab_t.wsab004,
       wsab004_desc      LIKE type_t.chr80,
       wsab005           LIKE wsab_t.wsab005,
       wsab005_desc      LIKE type_t.chr80,
       wsab006           LIKE wsab_t.wsab006,
       wsab006_desc      LIKE type_t.chr80,       
       wsab006_img       LIKE type_t.chr200
       END RECORD

#BPM簽核流程設定開單所需資訊
TYPE type_g_flow_wsab RECORD  
       wsab001           LIKE wsab_t.wsab001,   #單據性質
       wsab003           LIKE wsab_t.wsab003,   #單據別
       wsab004           LIKE wsab_t.wsab004,   #營運據點
       wsab005           LIKE wsab_t.wsab005    #參考簽核模版
       END RECORD

#無單頭append欄位定義
#無單身append欄位定義

#模組變數(Module Variables)
DEFINE g_wsab_m          type_g_wsab_m
DEFINE g_wsab_m_t        type_g_wsab_m

DEFINE g_wsab001_t       LIKE wsab_t.wsab001
DEFINE g_wsab002_t       LIKE wsab_t.wsab002
DEFINE g_wsab003_t       LIKE wsab_t.wsab003
DEFINE g_wsab_d          DYNAMIC ARRAY OF type_g_wsab_d
DEFINE g_wsab_d_t        type_g_wsab_d

      
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_show          LIKE type_t.chr100,     #(外顯欄位)
       b_pid           LIKE type_t.chr100,     #父節點id
       b_id            LIKE type_t.chr100,     #本身節點id
       b_exp           LIKE type_t.chr100,     #是否已展開
       b_hasC          LIKE type_t.num5,       #是否有子節點
       b_isExp         LIKE type_t.num5,       # 
       b_expcode       LIKE type_t.num5,       #展開值
       b_wsab001       LIKE wsab_t.wsab001,
       b_wsab002       LIKE wsab_t.wsab002,
       b_wsab003       LIKE wsab_t.wsab003             
      END RECORD      

DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING


DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
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
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身

DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE l_wsab                type_g_flow_wsab

###TYPE type_g_wsab_tree RECORD    #單據性質-營運據點-單別 tree
###       wsab_show        STRING,                #節點顯示文字
###       wsab_pid         STRING,                #父節點id
###       wsab_id          STRING,                #節點id
###       wsab_hasc        BOOLEAN,               #TRUE:有子節點, FALSE:無子節點
###       wsab_exp         BOOLEAN,               #TRUE:展開, FALSE:不展開
###       wsab_level       LIKE type_t.num5,      #階層
###       wsab_desc        STRING,                #說明文字
###       wsab_ooba001     LIKE ooba_t.ooba001,   #參照表編號
###       #wsab_ooba005     LIKE ooba_t.ooba005,   #作業編號
###       wsab_id_num      LIKE type_t.num5,      #編號(流水號)
###       wsab_pid_num     LIKE type_t.num5,      #父節點編號
###       wsab_name        LIKE type_t.chr20      #節點代碼
###       END RECORD
       
####單據性質-營運據點-單別 tree用(s_wsab_tree)
###DEFINE g_wsab_tree           DYNAMIC ARRAY OF type_g_wsab_tree
###DEFINE g_wsab_tree_idx       LIKE type_t.num5
DEFINE g_wsab_idx            LIKE type_t.num5
DEFINE g_wsab_cnt            LIKE type_t.num5
DEFINE g_wsab_current_idx    LIKE type_t.num5   #s_wsab_tree所在筆數
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_qbe_wsab002         LIKE wsab_t.wsab002
DEFINE g_qbe_wsab003         LIKE wsab_t.wsab003
#
TYPE type_flow_template RECORD         
         flow_template_id            STRING,
         flow_template_name          STRING,
         flow_template_image_url     STRING         
       END RECORD
DEFINE g_flow_tpl                    DYNAMIC ARRAY OF type_flow_template     

TYPE type_proc_list RECORD         
         process_id                  STRING,
         process_name                STRING,
         process_image_url           STRING         
       END RECORD
DEFINE g_proc_list                   DYNAMIC ARRAY OF type_proc_list 
DEFINE g_wsab001_p                   LIKE wsab_t.wsab001
DEFINE g_bpm_url                     LIKE ooaa_t.ooaa002 
DEFINE g_t100_debug                  SMALLINT
DEFINE g_data_found                  BOOLEAN

{</Module define>}          {#ADP版次:1#}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_data_insert          STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="awsi013.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化 name="main.init"
   LET g_wsab001_p = g_argv[1]
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT wsab001,'',wsab002,wsab003,'',wsab005,wsab007 FROM wsab_t WHERE wsabent= ? AND wsab001=? AND wsab002=? AND wsab003=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE awsi013_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsi013 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsi013_init()
 
      #進入選單 Menu (='N')
      CALL awsi013_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_awsi013
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="awsi013.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION awsi013_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point

   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1


   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   LET g_t100_debug =  FGL_GETENV("T100DEBUG")

   #add-point:畫面資料初始化
   {<point name="init.init"/>}   
   #end add-point

   CALL awsi013_default_search()

END FUNCTION

PRIVATE FUNCTION awsi013_ui_dialog()
   {<Local define>}
   DEFINE li_idx            LIKE type_t.num5
   DEFINE l_url             STRING
   DEFINE l_ssokey          STRING 
   DEFINE l_site            STRING
   DEFINE l_wsab006_m_img   STRING
   #160902-00024#11-S
   DEFINE l_flow_wsab       type_g_flow_wsab
   DEFINE l_wsab006_img     STRING
   DEFINE g_detail_curr     LIKE type_t.num5              #單身目前所在筆數
   DEFINE g_curr            LIKE type_t.num5
   #160902-00024#11-E
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point

   LET g_current_row = 0
   LET g_current_idx = 1
   #CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png")

   IF g_wc.trim() <> "1=1" THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF

   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #預先取回所有的模版名稱       
   IF awsi013_chk_bpm() THEN  #160902-00024#12
      LET g_flow_tpl = cl_bpm_flow_template_get()
   END IF                     #160902-00024#12
   
   #160909 by nikoybeat mark start
   #SELECT ooaa002 INTO g_bpm_url                             #151105-00002#20 by nikoybeat mod start 
   #  FROM ooaa_t 
   # WHERE ooaaent = g_enterprise  AND ooaa001 = 'E-SYS-0701' #151105-00002#20 by nikoybeat mod end
   #160909 by nikoybeat mark start
   LET g_bpm_url = cl_aws_prod_para(g_enterprise,"bpm-0002")  #151105-00002#20 by nikoybeat add    #160909 by nikoybeat remark
   #end add-point

   WHILE TRUE

      CALL awsi013_browser_fill("")

      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #左側瀏覽browser tree
         
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
                  LET g_current_idx = g_browser.getLength()
               END IF
              
               IF cl_null(g_browser[g_current_idx].b_wsab001) THEN                  
               ELSE
                  CALL awsi013_fetch('') # reload data                               
               END IF
               IF cl_null(g_browser[g_current_idx].b_wsab003) THEN
                  CALL cl_set_act_visible("bpm_flow_redo", FALSE)
               ELSE
                  CALL cl_set_act_visible("bpm_flow_redo", TRUE)
               END IF
               LET g_detail_idx = 1
               CALL awsi013_ui_detailshow() #Setting the current row
               
            #ON EXPAND (g_current_idx)
            #   CALL gfrm_curr.setElementHidden("mainlayout",0)
            #   CALL gfrm_curr.setElementHidden("worksheet",1)
            #   LET g_main_hidden = 0
            
         END DISPLAY
         
         
         ####單據性質-營運據點-單別 tree用(s_wsab_tree)
         ###DISPLAY ARRAY g_wsab_tree TO s_wsab_tree.* ATTRIBUTE(COUNT=g_wsab_cnt)

         ###      BEFORE ROW
         ###         #回歸舊筆數位置 (回到當時異動的筆數)
         ###         LET g_wsab_current_idx = DIALOG.getCurrentRow("s_wsab_tree")

         ###         IF g_wsab_current_idx = 0 THEN
         ###            LET g_wsab_current_idx = 1
         ###         END IF

         ###         IF g_wsab_tree[g_wsab_current_idx].wsab_level = "1" THEN
         ###            INITIALIZE g_wsab_m.* TO NULL
         ###         ELSE
         ###            INITIALIZE g_wsab_m.* TO NULL

         ###            #BPM簽核流程關聯設定
         ###            #SELECT wsab001, wsab002, wsab003, wsab004, wsab005, wsab006
         ###            #    INTO g_wsab_m.wsaa001, g_wsab_m.wsab002, g_wsab_m.wsab003,  g_wsab_m.wsab004, g_wsab_m.wsab005, g_wsab_m.wsab006
         ###            #  FROM wsab_t
         ###            #  WHERE wsabent = g_enterprise
         ###            #    AND wsab001 = g_wsab_m.wsaa001
                         
         ###         END IF
         ###END DISPLAY              

         DISPLAY ARRAY g_wsab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL awsi013_ui_detailshow()
             
               #160902-00024#11-S
               IF g_curr > 1 THEN
                  LET g_detail_curr = g_detail_idx
               END IF
               IF cl_null(g_wsab_d[g_detail_curr].wsab006) THEN
                  CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", FALSE)
                  CALL cl_set_act_visible("bpm_flow_create", TRUE)
               ELSE   
                  CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", TRUE)
                  CALL cl_set_act_visible("bpm_flow_create", FALSE)
               END IF
               LET g_curr = g_curr + 1
               #160902-00024#11-E 
               
               #預覽流程圖片
               IF NOT cl_null(g_wsab_d[g_detail_idx].wsab006_img) THEN
                  DISPLAY g_wsab_d[g_detail_idx].wsab006_img TO wsab006_img_pre
               ELSE
                  DISPLAY "" TO wsab006_img_pre
               END IF


            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               #160902-00024#11-S
               LET g_curr = 1
               LET g_detail_curr = l_ac      
               #160902-00024#11-E 
                                 
               #控制stus哪個按鈕可以按 
         END DISPLAY



         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point

         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps

         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)
            LET g_page = "first"
            LET g_current_sw = FALSE
            
            IF g_data_found = FALSE THEN     
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "-100"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)               
               CONTINUE DIALOG              
            END IF
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE

            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF

            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1
            END IF

            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL awsi013_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL awsi013_ui_detailshow() #Setting the current row

            
            #若無資料則關閉相關功能            
            IF g_browser_cnt = 0 THEN
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
            ELSE
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
            END IF

            #add-point:ui_dialog段before dialog2
            {<point name="ui_dialog.before_dialog2"/>}
            #end add-point

         #ACTION表單列
         ON ACTION filter
            CALL awsi013_filter()
            EXIT DIALOG

         ON ACTION first
            CALL awsi013_fetch('F')
            LET g_current_row = g_current_idx

         ON ACTION previous
            CALL awsi013_fetch('P')
            LET g_current_row = g_current_idx

         ON ACTION jump
            CALL awsi013_fetch('/')
            LET g_current_row = g_current_idx

         ON ACTION next
            CALL awsi013_fetch('N')            
            LET g_current_row = g_current_idx

         ON ACTION last
            CALL awsi013_fetch('L')
            LET g_current_row = g_current_idx

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
            #重設光棒位置          
            CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
            
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF

         ON ACTION worksheethidden   #瀏覽頁折疊
            IF cl_null(g_browser[g_current_idx].b_wsab001) OR
               cl_null(g_browser[g_current_idx].b_wsab002) THEN 
               CONTINUE DIALOG
            END IF
            
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF

         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden
            END IF

       
         ###ON ACTION reproduce

         ###   LET g_action_choice="reproduce"
         ###   IF cl_auth_chk_act("reproduce") THEN
         ###      CALL awsi013_reproduce()
         ###      #add-point:ON ACTION reproduce
         ###      {<point name="menu.reproduce" />}
         ###      #END add-point
         ###       EXIT DIALOG
         ###   END IF


         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION modify

            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL awsi013_modify()              
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION modify_detail

            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               CALL awsi013_modify()
               #add-point:ON ACTION modify_detail
               {<point name="menu.modify_detail" />}
               #END add-point
                EXIT DIALOG
            END IF

         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL awsi013_query()
               IF g_browser_cnt = 0 THEN
                  CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
               ELSE
                  CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               END IF
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF

         ON ACTION bpm_flow_redo
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E    
               CALL awsi013_flow_create("ALL" , "Y")
            END IF   #160902-00024#12
            
         ON ACTION bmp_flow_designer         
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E 
               LET g_action_choice="bmp_flow_designer"
               LET l_url = g_bpm_url CLIPPED,"GP/ToolSuite?hdnMethod=openDesigner&hdnAppType=nana-bpm-designer"
               LET l_ssokey = cl_bpm_get_ssokey()
               
               IF g_wsab_d[g_current_idx].wsab004 IS NULL THEN
                  LET l_site = "ALL"
               ELSE
                  LET l_site = g_wsab_d[g_current_idx].wsab004
               END IF
               
               IF cl_null(g_wsab_m.wsab003) THEN               
                  LET l_url = l_url, "&hdnSSOKey=", l_ssokey , "&lang=", g_lang CLIPPED, "&companyId=", l_site, "&docPropId=", g_wsab_m.wsaa001 CLIPPED,"&designerType=signatureFlowDesigner"
               ELSE               
                  LET l_url = l_url, "&hdnSSOKey=", l_ssokey ,"&lang=", g_lang CLIPPED, "&companyId=", l_site, "&docPropId=", g_wsab_m.wsaa001 CLIPPED,"&formId=", g_wsab_m.wsab003,"&designerType=signatureFlowDesigner"
               END IF            
               DISPLAY "bpm_designer:", l_url, ";"
               CALL ui.Interface.frontCall( "standard", "launchurl", [l_url], [] )
            END IF   #160902-00024#12
               
         ON ACTION bmp_work_designer
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E 
               LET g_action_choice="bmp_work_designer"
               LET l_url = g_bpm_url CLIPPED,"GP/ToolSuite?hdnMethod=openDesigner&hdnAppType=nana-bpm-designer"
               LET l_ssokey = cl_bpm_get_ssokey()
               
               #LET l_url = l_url, "&userId=", g_account CLIPPED , "&lang=", g_lang CLIPPED ,"&designerType=workFlowDesigner"
               LET l_url = l_url, "&hdnSSOKey=" , l_ssokey ,"&lang=", g_lang CLIPPED ,"&designerType=workFlowDesigner"
               DISPLAY "work_designer:", l_url, ";"
               CALL ui.Interface.frontCall( "standard", "launchurl", [l_url], [] ) 
            END IF   #160902-00024#12
            
         ON ACTION bpm_export
            CALL awsi013_04()
         
         ON ACTION bpm_import
            CALL awsi013_05()
            
         ON ACTION bpm_flow_delete
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E 
               LET l_wsab.wsab001 = g_wsab_m.wsaa001
               LET l_wsab.wsab003 = g_wsab_m.wsab003
               LET l_wsab.wsab004 = "*"       #表示所有的營運據點
               LET l_wsab.wsab005 = g_wsab_m.wsab005_m    
               #160902-00024#11-S   
               #CALL cl_bpm_flow_delete(l_wsab.*, g_wsab_m.wsab006_m)              
               IF cl_bpm_flow_delete(l_wsab.*, g_wsab_m.wsab006_m) THEN
               #160902-00024#11-E              
                  LET g_wsab_m.wsab006_m = ""
                  LET g_wsab_m.wsab006_m_desc = ""
                  UPDATE wsab_t SET wsab006 = g_wsab_m.wsab006_m
                      WHERE wsabent = g_enterprise 
                        AND wsab001 = g_wsab_m.wsaa001
                        AND wsab002 = g_wsab_m.wsab002
                        AND wsab003 = g_wsab_m.wsab003
                        AND wsab005 = g_wsab_m.wsab005_m
                  DISPLAY BY NAME g_wsab_m.wsab006_m, g_wsab_m.wsab006_m_desc
                  LET l_wsab006_m_img = ""
                  DISPLAY l_wsab006_m_img TO wsab006_m_img
               END IF #160902-00024#11
            END IF #160902-00024#12
            
         #160902-00024#11-S
         ON ACTION bpm_flow_create
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E           
               #詢問是否建立流程
               IF cl_ask_confirm("aws-00011") THEN
                  LET l_flow_wsab.wsab001 = g_wsab_m.wsaa001
                  LET l_flow_wsab.wsab003 = g_wsab_m.wsab003
                  LET l_flow_wsab.wsab004 = g_wsab_d[g_detail_curr].wsab004
                  LET l_flow_wsab.wsab005 = g_wsab_d[g_detail_curr].wsab005
   
                  #建立單據簽核流程,取得簽核流程代號
                  CALL cl_bpm_flow_create(l_flow_wsab.*)
                     RETURNING g_wsab_d[g_detail_curr].wsab006, g_wsab_d[g_detail_curr].wsab006_desc, g_wsab_d[g_detail_curr].wsab006_img
                  
                  #顯示流程圖片
                  LET g_wsab_d[g_detail_curr].wsab006_img = g_bpm_url ,g_wsab_d[g_detail_curr].wsab006_img                            
                  DISPLAY BY NAME g_wsab_d[g_detail_curr].wsab006, g_wsab_d[g_detail_curr].wsab006_desc,g_wsab_d[g_detail_curr].wsab006_img    
                  CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", TRUE)
                  CALL cl_set_act_visible("bpm_flow_create", FALSE)
               END IF 
            END IF   #160902-00024#12
            
         ON ACTION bpm_flow_site_delete
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E
               LET l_wsab.wsab001 = g_wsab_m.wsaa001
               LET l_wsab.wsab003 = g_wsab_m.wsab003
               LET l_wsab.wsab004 = g_wsab_d[g_detail_curr].wsab004
               LET l_wsab.wsab005 = g_wsab_d[g_detail_curr].wsab005     
               IF cl_bpm_flow_delete(l_wsab.*, g_wsab_d[g_detail_curr].wsab006) THEN
                  LET g_wsab_d[g_detail_curr].wsab006 = ""
                  LET g_wsab_d[g_detail_curr].wsab006_desc = ""
                  UPDATE wsab_t SET wsab006 = g_wsab_d[g_detail_curr].wsab006
                      WHERE wsabent = g_enterprise 
                        AND wsab001 = g_wsab_m.wsaa001
                        AND wsab002 = g_wsab_m.wsab002
                        AND wsab003 = g_wsab_m.wsab003
                        AND wsab004 = g_wsab_d[g_detail_curr].wsab004
                        AND wsab005 = g_wsab_d[g_detail_curr].wsab005
                  DISPLAY BY NAME g_wsab_d[g_detail_curr].wsab006, g_wsab_d[g_detail_curr].wsab006_desc
                  LET g_wsab_d[g_detail_curr].wsab006_img = ""
                  DISPLAY BY NAME g_wsab_d[g_detail_curr].wsab006, g_wsab_d[g_detail_curr].wsab006_desc,g_wsab_d[g_detail_curr].wsab006_img 
                  CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", FALSE)
                  CALL cl_set_act_visible("bpm_flow_create", TRUE)
               END IF 
            END IF     #160902-00024#12
            
         ON ACTION bmp_flow_site_designer
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E 
               LET g_action_choice="bmp_flow_designer"
               LET l_url = g_bpm_url CLIPPED,"GP/ToolSuite?hdnMethod=openDesigner&hdnAppType=nana-bpm-designer"
               LET l_ssokey = cl_bpm_get_ssokey()            
               LET l_site = g_wsab_d[g_detail_curr].wsab004
               
               IF cl_null(g_wsab_m.wsab003) THEN               
                  LET l_url = l_url, "&hdnSSOKey=", l_ssokey , "&lang=", g_lang CLIPPED, "&companyId=", l_site, "&docPropId=", g_wsab_m.wsaa001 CLIPPED,"&designerType=signatureFlowDesigner"
               ELSE               
                  LET l_url = l_url, "&hdnSSOKey=", l_ssokey ,"&lang=", g_lang CLIPPED, "&companyId=", l_site, "&docPropId=", g_wsab_m.wsaa001 CLIPPED,"&formId=", g_wsab_m.wsab003,"&designerType=signatureFlowDesigner"
               END IF            
               DISPLAY "bpm_designer:", l_url, ";"
               CALL ui.Interface.frontCall( "standard", "launchurl", [l_url], [] ) 
            END IF  #160902-00024#12            
         #160902-00024#11-E   
         
         #ON ACTION insert
         #   LET g_action_choice="insert"
         #   IF cl_auth_chk_act("insert") THEN
         #      CALL awsi013_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
         #       EXIT DIALOG
         #   END IF

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG

      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION awsi013_browser_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #end add-point

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
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1"
   END IF

   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY wsaa001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF

   CALL awsi013_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE

END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsi013_browser_expand (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsi013_browser_expand(pi_id)
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_type_list     STRING
   DEFINE ls_sql           STRING
   
   DEFINE l_parent         STRING
   DEFINE l_newdata        BOOLEAN
   DEFINE l_oobal004       LIKE oobal_t.oobal004
   DEFINE l_wsaa009        LIKE wsaa_t.wsaa009
   DEFINE l_wsab002        LIKE wsab_t.wsab002
   DEFINE l_data_wsaa009   DYNAMIC ARRAY OF STRING
   DEFINE l_i              INTEGER
   
  
   LET l_wsaa009 = ""
   LET l_i = 1
   
   #取單別資料時，需先以 wsaa009 的設定為主
   SELECT wsaa009 INTO l_wsaa009 FROM wsaa_t
    WHERE wsaa001 = g_browser[pi_id].b_wsab001
   
   IF cl_null(l_wsaa009) THEN
      LET l_wsaa009 = g_browser[pi_id].b_wsab001       
   END IF
   
   LET l_data_wsaa009 = awsi013_splite(l_wsaa009)
   
   LET ls_wc = ""
   IF NOT cl_null(g_qbe_wsab002) THEN
      LET ls_wc = " AND ooba001 = '", g_qbe_wsab002 ,"'"
   END IF
   
   IF NOT cl_null(g_qbe_wsab003) THEN
      LET ls_wc =  ls_wc , " AND ooba002 = '", g_qbe_wsab003 ,"'"
   END IF
   
   LET ls_sql = " SELECT UNIQUE ooba001, ooba002, oobxl003 ",
                "   FROM ooba_t LEFT JOIN oobxl_t ON oobaent = oobxlent AND ooba002 = oobxl001 AND oobxl002 = '",g_lang,"'",  
                "               JOIN ooal_t ON oobaent = ooalent AND ooba001 = ooal002 AND ooal001 = '3' AND ooalstus = 'Y' ", #160902-00024#11                
                "               JOIN oobx_t ON oobaent = oobxent AND ooba002 = oobx001 AND oobx003 in ("
                IF NOT cl_null(l_data_wsaa009[1]) THEN
                   WHILE l_data_wsaa009[l_i] IS NOT NULL
                      IF l_data_wsaa009[l_i + 1] IS NOT NULL THEN         #單別不為最後一項
                         LET ls_sql = ls_sql, "'",l_data_wsaa009[l_i],"',"
                      ELSE
                         LET ls_sql = ls_sql, "'",l_data_wsaa009[l_i],"' )"  #單別最後一項
                      END IF
                      LET l_i = l_i + 1
                   END WHILE
                END IF
   LET ls_sql = ls_sql," WHERE oobaent = ?  AND oobastus = 'Y' ", ls_wc ,
                "     ORDER BY ooba001"                

   PREPARE expand_pre FROM ls_sql
   DECLARE expand_cur CURSOR FOR expand_pre
   
   LET g_browser[pi_id].b_isExp = TRUE

   LET l_wsab002 = ""
   LET g_cnt = pi_id + 1
   
   FOREACH expand_cur USING  {l_wsaa009 ,}g_enterprise INTO g_browser[g_cnt].b_wsab002, g_browser[g_cnt].b_wsab003, l_oobal004
   
      LET g_data_found = TRUE
      #第二層 參照表
      IF cl_null(l_wsab002) OR l_wsab002 <> g_browser[g_cnt].b_wsab002 THEN    
         LET g_browser[g_cnt].b_pid     = g_browser[pi_id].b_id     
         LET l_parent = g_browser[pi_id].b_id , ".", g_cnt USING "<<<" 
         LET g_browser[g_cnt].b_id      = l_parent
         
         LET g_browser[g_cnt].b_exp     = TRUE      
         LET g_browser[g_cnt].b_hasC    = TRUE
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_browser[g_cnt].b_wsab002
         CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
          
         LET g_browser[g_cnt].b_show    = g_browser[g_cnt].b_wsab002 CLIPPED , "(", g_rtn_fields[1]  ,")"
         LET g_browser[g_cnt].b_expcode = 1
         
         LET l_wsab002 = g_browser[g_cnt].b_wsab002
         LET l_newdata = TRUE
         LET g_cnt = g_cnt + 1
      END IF
      
      #第三層
      LET g_browser[g_cnt].b_pid     = l_parent   #g_browser[pi_id].b_id
      LET g_browser[g_cnt].b_id      = l_parent , ".", g_cnt USING "<<<"
      LET g_browser[g_cnt].b_exp     = FALSE      
      LET g_browser[g_cnt].b_hasC    = FALSE
      
      IF l_newdata = TRUE THEN
         LET g_browser[g_cnt].b_wsab002 = g_browser[g_cnt-1].b_wsab002          
         LET g_browser[g_cnt].b_wsab003 = g_browser[g_cnt-1].b_wsab003
         LET g_browser[g_cnt].b_show    = g_browser[g_cnt-1].b_wsab003 CLIPPED, "(", l_oobal004 CLIPPED, ")"        
         LET g_browser[g_cnt].b_wsab001 = g_browser[pi_id].b_wsab001         
      ELSE
         LET g_browser[g_cnt].b_show    = g_browser[g_cnt].b_wsab003 CLIPPED, "(", l_oobal004 CLIPPED, ")"        
         LET g_browser[g_cnt].b_wsab001 = g_browser[pi_id].b_wsab001
      END IF
      
      LET l_newdata = FALSE      
      LET g_cnt = g_cnt + 1      
   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   LET g_cnt = g_cnt - 1
   
   LET g_browser_cnt = g_browser.getLength()
   
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   
END FUNCTION

PRIVATE FUNCTION awsi013_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE li_idx            LIKE type_t.num10
   DEFINE l_gzcbl004        LIKE gzcbl_t.gzcbl004
   
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point

   #add-point:browser_fill段動作開始前
   {<point name="browser_fill.before_browser_fill"/>}
   #end add-point

   CALL g_browser.clear()

   ###IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
   ###   #單身有輸入搜尋條件
   ###   LET l_sub_sql = " SELECT UNIQUE wsab001, wsab002, wsab003 ",
   ###                   " FROM wsab_t ",
   ###                   " WHERE wsabent = '", g_enterprise, "' AND ", g_wc, " AND ", g_wc2
   ###ELSE
   ###   #單身未輸入搜尋條件
   ###   LET l_sub_sql = " SELECT UNIQUE wsab001, wsab002, wsab003 ",
   ###                   " FROM wsab_t ",
   ###                   " WHERE wsabent = '", g_enterprise, "' AND ", g_wc CLIPPED
   ###END IF

   ###LET g_sql = " SELECT COUNT(*) FROM (", l_sub_sql, ")"

   ###PREPARE header_cnt_pre FROM g_sql
   ###EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   ###FREE header_cnt_pre

   ####若超過最大顯示筆數
   ###IF g_browser_cnt > g_max_browse AND g_error_show = 1THEN
   ###   CALL cl_err(g_browser_cnt,'9035',1)
   ###END IF
   LET g_error_show = 0

   ###DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   ###DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示

   
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      #依照 Browser欄位定義(取代原本bs_sql功能)
      #160902-00024#11-S
      #LET g_sql= " SELECT DISTINCT wsaa001, wsab002, '', gzcbl004 ",
      #           "   FROM wsaa_t LEFT JOIN wsab_t ON wsaa001 = wsab001 AND wsabent = ? ",
      #           "               LEFT JOIN gzcbl_t ON gzcbl001 = '24' AND wsaa001 = gzcbl002 AND gzcbl003 = ? ",
      #           "   WHERE ", g_wc, " AND ", g_wc2  
      LET g_sql= " SELECT DISTINCT wsaa001, wsab002, '', gzzal003 ",
                 "   FROM wsaa_t LEFT JOIN wsab_t ON wsaa001 = wsab001 AND wsabent = ? ",
                 "               LEFT JOIN gzzal_t ON wsaa001 = gzzal001 AND gzzal002 = ? ",
                 "   WHERE ", g_wc, " AND ", g_wc2  
      #160902-00024#11-E                 
   ELSE
      #單身無輸入資料
      
      IF NOT cl_null(g_qbe_wsab003) THEN
         #LET  g_sql= " SELECT DISTINCT wsaa001, '', '' , gzcbl004 ",
         #            " LEFT JOIN ooba_t  ON ooba001='031' and ooba002 = 'CFX'  ",
         #            "               LEFT JOIN gzcbl_t ON gzcbl001 = '24' AND wsaa001 = gzcbl002 AND gzcbl003 = ? ",
                     #ls_wc =  ls_wc , " AND ooba002 = '", g_qbe_wsab003 ,"'"
      END IF
      
      #160902-00024#11-S                   
      #LET g_sql= " SELECT DISTINCT wsaa001, '', '' , gzcbl004 ",
      #           "   FROM wsaa_t LEFT JOIN wsab_t ON wsaa001 = wsab001 AND wsabent = ? ",
      #           "               LEFT JOIN gzcbl_t ON gzcbl001 = '24' AND wsaa001 = gzcbl002 AND gzcbl003 = ? ",
      #           "   WHERE ", g_wc  
      LET g_sql= " SELECT DISTINCT wsaa001, '', '' , gzzal003 ",
                 "   FROM wsaa_t LEFT JOIN wsab_t ON wsaa001 = wsab001 AND wsabent = ? ",
                 "               LEFT JOIN gzzal_t ON wsaa001 = gzzal001 AND gzzal002 = ? ",
                 "   WHERE ", g_wc   
      #160902-00024#11-E                   
   END IF
   LET g_sql = g_sql , cl_sql_add_filter("wsab_t")         #161102-00047#14 by nikoybeat add
   LET g_sql = g_sql , " ORDER BY wsaa001"
   IF g_t100_debug = 9 THEN display "sql:", g_sql END IF

   #定義CURSOR for Browser TREE  
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   LET li_idx = 1
   LET g_data_found = FALSE
   FOREACH browse_cur USING g_enterprise, g_lang INTO g_browser[g_cnt].b_wsab001, g_browser[g_cnt].b_wsab002, g_browser[g_cnt].b_wsab003, l_gzcbl004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_browser[g_cnt].b_pid     = 0      
      LET g_browser[g_cnt].b_id      = g_cnt
      LET g_browser[g_cnt].b_exp     = TRUE      
      LET g_browser[g_cnt].b_hasC    = TRUE
      LET g_browser[g_cnt].b_show    = g_browser[g_cnt].b_wsab001 CLIPPED, "(", l_gzcbl004 CLIPPED, ")"
      LET g_browser[g_cnt].b_expcode = 1
            
      call awsi013_browser_expand(g_cnt)

      LET g_cnt = g_cnt + 1
      LET li_idx = li_idx + 1
      
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   IF g_data_found = FALSE THEN     
      RETURN
   END IF 
   
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND g_wc THEN
      INITIALIZE g_wsab_m.* TO NULL
      CALL g_wsab_d.clear()
      CLEAR FORM
   END IF

   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0

   CALL awsi013_fetch('')

   FREE browse_pre

END FUNCTION

PRIVATE FUNCTION awsi013_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point

   LET g_wsab_m.wsaa001 = g_browser[g_current_idx].b_wsab001
   LET g_wsab_m.wsab002 = g_browser[g_current_idx].b_wsab002
   LET g_wsab_m.wsab003 = g_browser[g_current_idx].b_wsab003

    SELECT UNIQUE wsab001,wsab002,wsab003,wsab005
    INTO g_wsab_m.wsaa001,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_m.wsab005_m
    FROM wsab_t
    WHERE wsabent = g_enterprise 
      AND wsab001 = g_wsab_m.wsaa001 
      AND wsab002 = g_wsab_m.wsab002 
      AND wsab003 = g_wsab_m.wsab003
      AND wsab004 = 'ALL'
      
    CALL awsi013_show()

END FUNCTION

PRIVATE FUNCTION awsi013_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point

   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1", g_detail_idx)

   END IF

   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_wsab001 = g_wsab_m.wsaa001
         AND g_browser[l_i].b_wsab002 = g_wsab_m.wsab002
         AND g_browser[l_i].b_wsab003 = g_wsab_m.wsab003
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
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示

END FUNCTION

PRIVATE FUNCTION awsi013_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define
   {<point name="filter.define"/>}
   #end add-point

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON wsaa001, wsab002, wsab003
                          FROM s_browse[1].b_wsab001,s_browse[1].b_wsab002,s_browse[1].b_wsab003

         BEFORE CONSTRUCT
            #CALL cl_qbe_init()
            DISPLAY awsi013_filter_parser('wsaa001') TO s_browse[1].b_wsab001
            DISPLAY awsi013_filter_parser('wsab002') TO s_browse[1].b_wsab002
            DISPLAY awsi013_filter_parser('wsab003') TO s_browse[1].b_wsab003

      END CONSTRUCT

      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
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

PRIVATE FUNCTION awsi013_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   {<point name="filter_parser.define"/>}
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

PRIVATE FUNCTION awsi013_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   #add-point:query開始前
   {<point name="query.befroe_query"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   LET ls_wc = g_wc

   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""

   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()
   CALL g_wsab_d.clear()

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   CALL awsi013_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL awsi013_browser_fill(g_wc)
      CALL awsi013_fetch("")
      RETURN
   END IF

   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1

   LET g_error_show = 1
   CALL awsi013_browser_fill("F")
   
   IF g_data_found = FALSE THEN     
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLEAR FORM
      RETURN
   END IF 

   #備份搜尋條件
   LET ls_wc = g_wc

   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL awsi013_browser_fill("F")
   END IF

   #第二層助記碼搜尋
   IF g_browser_cnt = 0 THEN

      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL awsi013_browser_fill("F")
      END IF

   END IF

   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLEAR FORM
   ELSE
      CALL awsi013_fetch("F")
   END IF

END FUNCTION

PRIVATE FUNCTION awsi013_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define   
   {<point name="fetch.define"/>}
   DEFINE li_cnt    LIKE type_t.num5
   #end add-point

   #add-point:fetch段動作開始前
   {<point name="fetch.before_fetch"/>}
   #end add-point

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
      
   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   CALL ui.Interface.refresh()
   
   
   #該樣板不需此段落CALL awsi013_browser_fill(p_flag)
   
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   # 設定browse索引
   ###CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   LET g_detail_cnt = g_header_cnt

   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF

   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   #參照欄位為空 自動取下一筆 
   IF cl_null(g_browser[g_current_idx].b_wsab001) OR
      cl_null(g_browser[g_current_idx].b_wsab002) THEN      
      IF g_current_idx = 1  THEN
         CALL awsi013_fetch("N")
         RETURN
      END IF
      IF p_flag="N" OR p_flag="P" THEN         
         CALL awsi013_fetch(p_flag) 
         RETURN
      END IF      
   END IF
   
    LET g_wsab_m.wsaa001 = g_browser[g_current_idx].b_wsab001
    LET g_wsab_m.wsab002 = g_browser[g_current_idx].b_wsab002
    LET g_wsab_m.wsab003 = g_browser[g_current_idx].b_wsab003
      
    SELECT COUNT(*) INTO li_cnt FROM wsab_t
    WHERE wsabent = g_enterprise 
      AND wsab001 = g_wsab_m.wsaa001      
      AND wsab002 = g_wsab_m.wsab002
      AND wsab003 = g_wsab_m.wsab003      
 

   LET g_wsab_m.wsab007 = "N"
   #重讀單頭
   IF li_cnt > 0 THEN   
      
     SELECT COUNT(*) INTO li_cnt FROM wsab_t
      WHERE wsabent = g_enterprise 
        AND wsab001 = g_wsab_m.wsaa001      
        AND wsab002 = g_wsab_m.wsab002
        AND wsab003 = g_wsab_m.wsab003
        AND wsab004 = 'ALL'        
        
      IF li_cnt > 0 THEN 
         SELECT UNIQUE wsab001,wsab002,wsab003,wsab005,wsab006,wsab007
           INTO g_wsab_m.wsaa001,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_m.wsab005_m,g_wsab_m.wsab006_m,g_wsab_m.wsab007
           FROM wsab_t
          WHERE wsabent = g_enterprise 
            AND wsab001 = g_wsab_m.wsaa001 
            AND wsab002 = g_wsab_m.wsab002 
            AND wsab003 = g_wsab_m.wsab003
            AND wsab004 = 'ALL'
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "wsab_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            INITIALIZE g_wsab_m.* TO NULL
            RETURN
         END IF
      END IF      
      LET g_data_insert ='N'
   ELSE
      LET g_data_insert ='Y'
      LET g_wsab_m.wsab005_m = ''
      LET g_wsab_m.wsab006_m = ''       
   END IF

   IF g_wsab_m.wsab005_m IS NULL THEN    #若為空值補上預設樣版
      SELECT UNIQUE wsaa002 INTO g_wsab_m.wsab005_m 
        FROM wsaa_t
       WHERE wsaa001 = g_wsab_m.wsaa001       
   END IF
    
   IF cl_null(g_wsab_m.wsab006_m) THEN               
      CALL cl_set_act_visible("bpm_flow_redo", TRUE)
   ELSE      
      CALL cl_set_act_visible("bpm_flow_redo", FALSE)            
   END IF        
  
   #重新顯示
   CALL awsi013_show()

END FUNCTION

PRIVATE FUNCTION awsi013_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point

   #清除相關資料
   CLEAR FORM
   CALL g_wsab_d.clear()

   INITIALIZE g_wsab_m.* LIKE wsab_t.*             #DEFAULT 設定
   LET g_wsab001_t = NULL
   LET g_wsab002_t = NULL
   LET g_wsab003_t = NULL

   CALL s_transaction_begin()
   WHILE TRUE

      #單頭預設值
      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point

      CALL awsi013_input("a")

      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_wsab_m.* = g_wsab_m_t.*
         CALL awsi013_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      CALL g_wsab_d.clear()

      LET g_rec_b = 0
      EXIT WHILE

   END WHILE

   LET g_state = "Y"

   LET g_wsab001_t = g_wsab_m.wsaa001
   LET g_wsab002_t = g_wsab_m.wsab002
   LET g_wsab003_t = g_wsab_m.wsab003

   LET g_wc = g_wc,
              " OR ( wsabent = '" ||g_enterprise|| "' AND ",
              " wsab001 = '", g_wsab_m.wsaa001 CLIPPED, "' "
              ," AND wsab002 = '", g_wsab_m.wsab002 CLIPPED, "' "
              ," AND wsab003 = '", g_wsab_m.wsab003 CLIPPED, "' "
              , ") "

END FUNCTION

PRIVATE FUNCTION awsi013_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point

   IF g_wsab_m.wsaa001 IS NULL
   OR g_wsab_m.wsab002 IS NULL
   OR g_wsab_m.wsab003 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   IF g_data_insert ='N' THEN  #修改前置作業
      SELECT UNIQUE wsab001,wsab002,wsab003,wsab005,wsab007
      INTO g_wsab_m.wsaa001,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_m.wsab005_m,g_wsab_m.wsab007
      FROM wsab_t
      WHERE wsabent = g_enterprise AND wsab001 = g_wsab_m.wsaa001 AND wsab002 = g_wsab_m.wsab002 AND wsab003 = g_wsab_m.wsab003
    

      ERROR ""

      LET g_wsab001_t = g_wsab_m.wsaa001
      LET g_wsab002_t = g_wsab_m.wsab002
      LET g_wsab003_t = g_wsab_m.wsab003


      CALL s_transaction_begin()

      OPEN awsi013_cl USING g_enterprise,g_wsab_m.wsaa001
                                     ,g_wsab_m.wsab002
                                     ,g_wsab_m.wsab003


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN awsi013_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE awsi013_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH awsi013_cl INTO g_wsab_m.wsaa001,g_wsab_m.wsab001_desc,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_m.wsab003_desc,g_wsab_m.wsab005_m,g_wsab_m.wsab007

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_wsab_m.wsaa001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE awsi013_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL s_transaction_end('Y','0')
   
   END IF

   CALL awsi013_show()
   
      
   WHILE TRUE
      LET g_wsab001_t = g_wsab_m.wsaa001
      LET g_wsab002_t = g_wsab_m.wsab002
      LET g_wsab003_t = g_wsab_m.wsab003

      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point

      CALL awsi013_input("u")     #欄位更改

      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_wsab_m.* = g_wsab_m_t.*
         CALL awsi013_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      #若單頭key欄位有變更
      IF g_wsab_m.wsaa001 != g_wsab001_t
      OR g_wsab_m.wsab002 != g_wsab002_t
      OR g_wsab_m.wsab003 != g_wsab003_t
      THEN
         CALL s_transaction_begin()

         #add-point:單頭(偽)修改前
         {<point name="modify.b_key_update" mark="Y"/>}
         #end add-point

         #更新單頭key值
         UPDATE wsab_t SET wsab001 = g_wsab_m.wsaa001
                          ,wsab002 = g_wsab_m.wsab002
                          ,wsab003 = g_wsab_m.wsab003                          
          WHERE wsabent = g_enterprise 
            AND wsab001 = g_wsab001_t
            AND wsab002 = g_wsab002_t
            AND wsab003 = g_wsab003_t

         #add-point:單頭(偽)修改中
         {<point name="modify.m_key_update"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "wsab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "wsab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單頭(偽)修改後
         {<point name="modify.a_key_update"/>}
         #end add-point

      END IF

      EXIT WHILE

   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_wsab_m.wsaa001,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE awsi013_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_wsab_m.wsaa001,'U')

   CALL awsi013_b_fill("1=1")

END FUNCTION

PRIVATE FUNCTION awsi013_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd_t         LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num5                #未取消的ARRAY CNT
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING   
   
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   DEFINE l_flow_wsab      type_g_flow_wsab
   DEFINE l_wsab004_m      LIKE wsab_t.wsab004
   DEFINE l_wsab006_m_img  STRING
   DEFINE l_wsab006_img    STRING
   #160902-00024#11-S
   DEFINE l_url            STRING
   DEFINE l_ssokey         STRING 
   DEFINE l_site           STRING
   #160902-00024#11-E
   #end add-point

   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF
   
   IF g_data_insert='Y' THEN  
      LET p_cmd   = 'a'
   END IF

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   #add-point:input段define_sql
   {<point name="input.define_sql" mark="Y"/>}
   #end add-point
   LET g_forupd_sql = "SELECT wsab004,'',wsab006 FROM wsab_t WHERE wsabent=? AND wsab001=? AND wsab002=? AND wsab003=? AND wsab004=? FOR UPDATE"
   #add-point:input段define_sql
   {<point name="input.after_define_sql"/>}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE awsi013_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   #控制key欄位可否輸入
   CALL awsi013_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL awsi013_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   {<point name="input.after_set_no_entry"/>}
   #end add-point

   DISPLAY BY NAME g_wsab_m.wsaa001,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_m.wsab005_m,g_wsab_m.wsab006_m,g_wsab_m.wsab007

   #add-point:進入修改段前
   {<point name="input.before_input"/>}
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      #160902-00024#11-S
      #INPUT BY NAME g_wsab_m.wsab005_m, g_wsab_m.wsab006_m,g_wsab_m.wsab007
      INPUT BY NAME g_wsab_m.wsab005_m, g_wsab_m.wsab007
      #160902-00024#11-E
                       
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂單頭ACTION
         BEFORE INPUT
            IF NOT cl_null(g_wsab_m.wsab006_m) THEN               
               CALL cl_set_act_visible("bpm_flow_redo", FALSE)            
            END IF
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF

            IF l_cmd_t = 'r' THEN

            END IF
            #add-point:單頭input前
            {<point name="input.head.b_input"/>}
            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<wsaa001>>----
         #此段落由子樣板a02產生
         AFTER FIELD wsaa001

            #add-point:AFTER FIELD wsaa001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_wsab_m.wsaa001) AND NOT cl_null(g_wsab_m.wsab002) AND NOT cl_null(g_wsab_m.wsab003) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_wsab_m.wsaa001 != g_wsab001_t  OR g_wsab_m.wsab002 != g_wsab002_t  OR g_wsab_m.wsab003 != g_wsab003_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM wsab_t WHERE "||"wsabent = '" ||g_enterprise|| "' AND "||"wsab001 = '"||g_wsab_m.wsaa001 ||"' AND "|| "wsab002 = '"||g_wsab_m.wsab002 ||"' AND "|| "wsab003 = '"||g_wsab_m.wsab003 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_wsab_m.wsaa001
            #160902-00024#11-S       
            #CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='24' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields      
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields 
            #160902-00024#11-E        
            LET g_wsab_m.wsab001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_wsab_m.wsab001_desc
            {#ADP版次:1#}
            SELECT COUNT(*) INTO l_cnt FROM ooba_t WHERE ooba004 = g_wsab_m.wsaa001
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "aws-00002"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD wsaa001
            END IF
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD wsaa001
            #add-point:BEFORE FIELD wsaa001
            {<point name="input.b.wsab001" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE wsaa001
            #add-point:ON CHANGE wsaa001
            {<point name="input.g.wsab001" />}
            #END add-point

         #----<<wsab002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsab002
            #add-point:BEFORE FIELD wsab002
            {<point name="input.b.wsab002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsab002

            #add-point:AFTER FIELD wsab002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_wsab_m.wsaa001) AND NOT cl_null(g_wsab_m.wsab002) AND NOT cl_null(g_wsab_m.wsab003) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_wsab_m.wsaa001 != g_wsab001_t  OR g_wsab_m.wsab002 != g_wsab002_t  OR g_wsab_m.wsab003 != g_wsab003_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM wsab_t WHERE "||"wsabent = '" ||g_enterprise|| "' AND "||"wsab001 = '"||g_wsab_m.wsaa001 ||"' AND "|| "wsab002 = '"||g_wsab_m.wsab002 ||"' AND "|| "wsab003 = '"||g_wsab_m.wsab003 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE wsab002
            #add-point:ON CHANGE wsab002
            {<point name="input.g.wsab002" />}
            #END add-point

         #----<<wsab003>>----
         #此段落由子樣板a02產生
         AFTER FIELD wsab003

            #add-point:AFTER FIELD wsab003
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_wsab_m.wsaa001) AND NOT cl_null(g_wsab_m.wsab002) AND NOT cl_null(g_wsab_m.wsab003) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_wsab_m.wsaa001 != g_wsab001_t  OR g_wsab_m.wsab002 != g_wsab002_t  OR g_wsab_m.wsab003 != g_wsab003_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM wsab_t WHERE "||"wsabent = '" ||g_enterprise|| "' AND "||"wsab001 = '"||g_wsab_m.wsaa001 ||"' AND "|| "wsab002 = '"||g_wsab_m.wsab002 ||"' AND "|| "wsab003 = '"||g_wsab_m.wsab003 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_wsab_m.wsab002
            LET g_ref_fields[2] = g_wsab_m.wsab003
            CALL ap_ref_array2(g_ref_fields,"SELECT oobal004 FROM oobal_t WHERE oobalent='"||g_enterprise||"' AND oobal001=? AND oobal002=? AND oobal003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_wsab_m.wsab003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_wsab_m.wsab003_desc
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD wsab003
            #add-point:BEFORE FIELD wsab003
            {<point name="input.b.wsab003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE wsab003
            #add-point:ON CHANGE wsab003
            {<point name="input.g.wsab003" />}
            #END add-point

         #----<<wsab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsab005
            #add-point:BEFORE FIELD wsab005
            {<point name="input.b.wsab005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsab005_m
            #add-point:AFTER FIELD wsab005_m
            {<point name="input.a.wsab005_m" />}
            IF NOT cl_null(g_wsab_m.wsab005_m) THEN               
               #簽核模版名稱   
               LET g_wsab_m.wsab005_m_desc = ""
               FOR l_i = 1 TO g_flow_tpl.getLength()
                   IF g_wsab_m.wsab005_m = g_flow_tpl[l_i].flow_template_id THEN
                      LET g_wsab_m.wsab005_m_desc = g_flow_tpl[l_i].flow_template_name          
                   END IF
               END FOR 
               
               DISPLAY BY NAME g_wsab_m.wsab005_m_desc
               
            END IF
            
            #END add-point
            
         #此段落由子樣板a04產生
         ON CHANGE wsab005
            #add-point:ON CHANGE wsab005
            {<point name="input.g.wsab005" />}
            #END add-point

         #欄位檢查
         
         #---------------------------<  Master  >---------------------------
         #----<<wsaa001>>----
         #Ctrlp:input.c.wsab001
#         ON ACTION controlp INFIELD wsaa001
            #add-point:ON ACTION controlp INFIELD wsaa001
            {<point name="input.c.wsab001" />}
            
            #END add-point

         #----<<wsab002>>----
         #Ctrlp:input.c.wsab002
#         ON ACTION controlp INFIELD wsab002
            #add-point:ON ACTION controlp INFIELD wsab002
            {<point name="input.c.wsab002" />}
            #END add-point

         #----<<wsab003>>----
         #Ctrlp:input.c.wsab003
#         ON ACTION controlp INFIELD wsab003
            #add-point:ON ACTION controlp INFIELD wsab003
            {<point name="input.c.wsab003" />}
            #END add-point

         #----<<wsab005>>----
         #Ctrlp:input.c.wsab005
         ON ACTION controlp INFIELD wsab005
            #add-point:ON ACTION controlp INFIELD wsab005
            {<point name="input.c.wsab005" />}            
            #END add-point

         ON ACTION controlp INFIELD wsab005_m
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E 
               LET g_qryparam.reqry = FALSE
               CALL awsi011_01()
               LET g_wsab_m.wsab005_m = g_qryparam.return1
               LET g_wsab_m.wsab005_m_desc = g_qryparam.return2 
   
               DISPLAY BY NAME g_wsab_m.wsab005_m, g_wsab_m.wsab005_m_desc  
            END IF    #160902-00024#12                          
            
         ON ACTION bpm_flow_redo
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E
               #160902-00024#11-S
               #CALL awsi013_flow_create(l_wsab004_m , "N")  
               CALL awsi013_flow_create("ALL" , "Y")
               #160902-00024#11-E     
            END IF    #160902-00024#12           
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF

            #多語言處理


            CALL cl_showmsg()
            DISPLAY BY NAME g_wsab_m.wsaa001, g_wsab_m.wsab002, g_wsab_m.wsab003

            #預設此單據性質下的所有營運據點都採用此簽核模版
            LET l_wsab004_m = "ALL"

            #重新建立單據簽核流程(取得新[BPM 流程代號])            
            IF  (g_wsab_m.wsab005_m <> g_wsab_m_t.wsab005_m) OR               
                cl_null(g_wsab_m.wsab006_m) THEN
                              
               CALL awsi013_flow_create(l_wsab004_m , "N")               
            END IF
            
            IF cl_null(g_wsab_m.wsab006_m) THEN
               CALL s_transaction_end('N', '0') #ROLLBACK
            ELSE                  
               DISPLAY BY NAME g_wsab_m.wsab006_m, g_wsab_m.wsab006_m_desc                  
               #顯示流程圖片
               LET l_wsab006_m_img = g_bpm_url,l_wsab006_m_img
               DISPLAY l_wsab006_m_img TO wsab006_m_img
            END IF
            
            SELECT COUNT(*) INTO l_count FROM wsab_t
             WHERE wsabent = g_enterprise 
               AND wsab001 = g_wsab_m.wsaa001
               AND wsab002 = g_wsab_m.wsab002
               AND wsab003 = g_wsab_m.wsab003
               AND wsab004 = l_wsab004_m              #'*'


            #資料未重複, 插入新增資料
            IF l_count = 0 THEN              
               INSERT INTO wsab_t
                           (wsabent,
                            wsab001,wsab002,wsab003,
                            wsab004,
                            wsab005,
                            wsab006,
                            wsab007)
                     VALUES(g_enterprise,
                            g_wsab_m.wsaa001,
                            g_wsab_m.wsab002,
                            g_wsab_m.wsab003,
                            l_wsab004_m,
                            g_wsab_m.wsab005_m,                            
                            g_wsab_m.wsab006_m,
                            g_wsab_m.wsab007)
             ELSE
             
              { IF cl_null(g_wsab_m.wsab006_m) THEN
                  IF cl_ask_confirm("aws-00011") THEN
                     LET l_flow_wsab.wsab001 = g_wsab_m.wsaa001
                     LET l_flow_wsab.wsab003 = g_wsab_m.wsab003
                     LET l_flow_wsab.wsab004 = g_site
                     LET l_flow_wsab.wsab005 = g_wsab_m.wsab005_m
                     #建立單據簽核流程,取得簽核流程代號
                     CALL cl_bpm_flow_create(l_flow_wsab.*)
                     RETURNING g_wsab_m.wsab006_m, g_wsab_m.wsab006_m_desc, l_wsab006_m_img                  
                  END IF
               END IF 
               }
               
               UPDATE wsab_t SET (wsab005,wsab006,wsab007) = (g_wsab_m.wsab005_m,g_wsab_m.wsab006_m,g_wsab_m.wsab007)
                WHERE wsabent = g_enterprise 
                  AND wsab001 = g_wsab001_t
                  AND wsab002 = g_wsab002_t
                  AND wsab003 = g_wsab003_t
                  AND wsab004 = l_wsab004_m

               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "std-00009"
                     LET g_errparam.extend = "wsab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N', '0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "wsab_t" 
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N', '0')
                  OTHERWISE
                     #資料多語言用-增/改
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_wsab_m.wsaa001
                     LET gs_keys_bak[1] = g_wsab001_t
                     LET gs_keys[2] = g_wsab_m.wsab002
                     LET gs_keys_bak[2] = g_wsab002_t
                     LET gs_keys[3] = g_wsab_m.wsab003
                     LET gs_keys_bak[3] = g_wsab003_t
                     LET gs_keys[4] = g_wsab_d[g_detail_idx].wsab004
                     LET gs_keys_bak[4] = g_wsab_d_t.wsab004
                     CALL awsi013_update_b('wsab_t',gs_keys,gs_keys_bak,"'1'")

                     LET g_wsab001_t = g_wsab_m.wsaa001
                     LET g_wsab002_t = g_wsab_m.wsab002
                     LET g_wsab003_t = g_wsab_m.wsab003


                     #add-point:單頭修改後
                     {<point name="input.head.a_update"/>}
                     #end add-point
                     CALL s_transaction_end('Y', '0')
               END CASE

             END IF
           
             LET g_wsab001_t = g_wsab_m.wsaa001
             LET g_wsab002_t = g_wsab_m.wsab002
             LET g_wsab003_t = g_wsab_m.wsab003

             #若單身還沒有輸入資料, 強制切換至單身
             #IF cl_null(g_wsab_d[1].wsab004) THEN
             #   CALL g_wsab_d.deleteElement(1)
             #   NEXT FIELD wsab004
             #END IF

      END INPUT

      #Page1 預設值產生於此處      
      INPUT ARRAY g_wsab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         #自訂單身ACTION

         BEFORE INPUT
            
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_wsab_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL awsi013_b_fill(g_wc2)
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF

         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            #160902-00024#11-S
            IF cl_null(g_wsab_d[l_ac].wsab006) THEN
               CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", FALSE)
               CALL cl_set_act_visible("bpm_flow_create", TRUE)
            ELSE   
               CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", TRUE)
               CALL cl_set_act_visible("bpm_flow_create", FALSE)
            END IF
            #160902-00024#11-E 

            CALL s_transaction_begin()

            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN awsi013_cl USING g_enterprise,g_wsab_m.wsaa001
                                               ,g_wsab_m.wsab002
                                               ,g_wsab_m.wsab003

               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN awsi013_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE awsi013_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF

            LET l_cmd = ''
           
             
            IF g_rec_b >= l_ac
               AND g_wsab_d[l_ac].wsab004 IS NOT NULL

            THEN
               LET l_cmd='u'
               LET g_wsab_d_t.* = g_wsab_d[l_ac].*  #BACKUP
               OPEN awsi013_bcl USING g_enterprise,g_wsab_m.wsaa001,
                                                g_wsab_m.wsab002,
                                                g_wsab_m.wsab003,
                                                g_wsab_d_t.wsab004

               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN awsi013_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH awsi013_bcl INTO g_wsab_d[l_ac].wsab004,g_wsab_d[l_ac].wsab004_desc,g_wsab_d[l_ac].wsab006
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_wsab_d_t.wsab004
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF

                  CALL awsi013_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'               
            END IF
            #add-point:modify段before row
            {<point name="input.body.before_row"/>}
            CALL awsi013_set_entry_b(l_cmd)
            CALL awsi013_set_no_entry_b(l_cmd)
            #end add-point


         BEFORE INSERT

            INITIALIZE g_wsab_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_wsab_d[l_ac].* TO NULL

            #公用欄位預設值
            #一般欄位預設值
            LET g_wsab_d_t.* = g_wsab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL awsi013_set_entry_b(l_cmd)
            CALL awsi013_set_no_entry_b(l_cmd)

            #add-point:modify段before insert
            {<point name="input.body.before_insert"/>}
            #end add-point

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
            
            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM wsab_t
             WHERE wsabent = g_enterprise 
               AND wsab001 = g_wsab_m.wsaa001
               AND wsab002 = g_wsab_m.wsab002
               AND wsab003 = g_wsab_m.wsab003
               AND wsab004 = g_wsab_d[l_ac].wsab004
            
            IF NOT cl_null(g_wsab_d[l_ac].wsab005) AND cl_null(g_wsab_d[l_ac].wsab006) THEN  #160902-00024#1 add           
               IF awsi013_chk_bpm() THEN                                                     #160902-00024#12
                  IF cl_ask_confirm("aws-00011") THEN
                     LET l_flow_wsab.wsab001 = g_wsab_m.wsaa001
                     LET l_flow_wsab.wsab003 = g_wsab_m.wsab003
                     LET l_flow_wsab.wsab004 = g_wsab_d[l_ac].wsab004
                     LET l_flow_wsab.wsab005 = g_wsab_d[l_ac].wsab005
      
                     #建立單據簽核流程,取得簽核流程代號
                     CALL cl_bpm_flow_create(l_flow_wsab.*)
                        RETURNING g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc, g_wsab_d[l_ac].wsab006_img
                     
                     #顯示流程圖片
                     LET g_wsab_d[l_ac].wsab006_img = g_bpm_url ,g_wsab_d[l_ac].wsab006_img               
                     DISPLAY BY NAME g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc,g_wsab_d[l_ac].wsab006_img 
                  END IF
               END IF                                                                        #160902-00024#12
            END IF                                                                           #160902-00024#1 add


            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               CALL s_transaction_begin()
               #add-point:單身新增前
               {<point name="input.body.b_insert" mark="Y"/>}
               #end add-point
               INSERT INTO wsab_t
                           (wsabent,
                            wsab001,wsab002,wsab003,
                            wsab004,
                            wsab005,                            
                            wsab006,
                            wsab007)
                     VALUES(g_enterprise,
                            g_wsab_m.wsaa001,
                            g_wsab_m.wsab002,
                            g_wsab_m.wsab003,
                            g_wsab_d[l_ac].wsab004,
                            g_wsab_d[l_ac].wsab005,                            
                            g_wsab_d[l_ac].wsab006,
                            'N')
               #add-point:單身新增中
               {<point name="input.body.m_insert"/>}
               #end add-point
               LET p_cmd = 'u'
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_wsab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF

            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "wsab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改

               #add-point:input段-after_insert
               {<point name="input.body.a_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF

            #add-point:單身新增後
            {<point name="input.body.after_insert"/>}
            #end add-point

         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_wsab_d.deleteElement(l_ac)
               NEXT FIELD wsab004
            END IF
            IF g_wsab_d_t.wsab004 IS NOT NULL
               THEN

               #add-point:單身刪除前
               {<point name="input.body.b_delete"/>}
               #end add-point

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
               IF awsi013_before_delete() THEN
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               CLOSE awsi013_bcl
               LET l_count = g_wsab_d.getLength() - 1
            END IF

            #add-point:單身刪除後
            {<point name="input.body.a_delete"/>}
            #end add-point

         AFTER DELETE
            #add-point:單身AFTER DELETE
            {<point name="input.body.after_delete"/>}
            
            IF l_count = 0 THEN
               EXIT DIALOG
            END IF
            #end add-point

         #---------------------<  Detail: page1  >---------------------
         #----<<wsab004>>----
         #此段落由子樣板a02產生
         AFTER FIELD wsab004
            #add-point:AFTER FIELD wsab004
            
            
            SELECT COUNT(*) INTO l_cnt FROM wsae_t 
             WHERE wsae001 = g_wsab_d[l_ac].wsab004
               AND wsae002 = 'Y'
             
            IF g_wsab_d[l_ac].wsab004  IS NOT NULL AND l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "aws-00001"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD wsab004
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_wsab_d[l_ac].wsab004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_wsab_d[l_ac].wsab004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_wsab_d[l_ac].wsab004_desc

            #此段落由子樣板a05產生
            IF  g_wsab_m.wsaa001 IS NOT NULL AND g_wsab_m.wsab002 IS NOT NULL AND g_wsab_m.wsab003 IS NOT NULL AND g_wsab_d[g_detail_idx].wsab004 IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_wsab_m.wsaa001 != g_wsab001_t OR g_wsab_m.wsab002 != g_wsab002_t OR g_wsab_m.wsab003 != g_wsab003_t OR g_wsab_d[g_detail_idx].wsab004 != g_wsab_d_t.wsab004)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM wsab_t WHERE "||"wsabent = '" ||g_enterprise|| "' AND "||"wsab001 = '"||g_wsab_m.wsaa001 ||"' AND "|| "wsab002 = '"||g_wsab_m.wsab002 ||"' AND "|| "wsab003 = '"||g_wsab_m.wsab003 ||"' AND "|| "wsab004 = '"||g_wsab_d[g_detail_idx].wsab004 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #160902-00024#1-S
            #IF cl_null(g_wsab_d[l_ac].wsab005) THEN           
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code =  "aws-00010"
            #   LET g_errparam.extend = ""
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #
            #   NEXT FIELD wsab005
            #END IF
            #160902-00024#1-E

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD wsab004
            #add-point:BEFORE FIELD wsab004
            {<point name="input.b.page1.wsab004" />}
            IF awsi013_chk_bpm() THEN       #160902-00024#12
               IF cl_null(g_wsab_m.wsab006_m) THEN           
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "aws-00017"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()   
                  EXIT DIALOG
               END IF        
            END IF                          #160902-00024#12

            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE wsab004
            #add-point:ON CHANGE wsab004
            {<point name="input.g.page1.wsab004" />}
            #END add-point

         AFTER FIELD wsab005
            #160902-00024#1-S
            #IF cl_null(g_wsab_d[l_ac].wsab005) THEN           
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code =  "aws-00010"
            #   LET g_errparam.extend = ""
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #
            #   NEXT FIELD wsab005
            #END IF
            
            IF NOT cl_null(g_wsab_d[l_ac].wsab005) AND cl_null(g_wsab_d[l_ac].wsab006) THEN         
               IF NOT awsi013_chk_bpm() THEN    #160902-00024#12-E 
                  #詢問是否建立流程
                  IF cl_ask_confirm("aws-00011") THEN
                     LET l_flow_wsab.wsab001 = g_wsab_m.wsaa001
                     LET l_flow_wsab.wsab003 = g_wsab_m.wsab003
                     LET l_flow_wsab.wsab004 = g_wsab_d[l_ac].wsab004
                     LET l_flow_wsab.wsab005 = g_wsab_d[l_ac].wsab005
                  
                     #建立單據簽核流程,取得簽核流程代號
                     CALL cl_bpm_flow_create(l_flow_wsab.*)
                        RETURNING g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc, g_wsab_d[l_ac].wsab006_img
                     
                     #顯示流程圖片
                     LET g_wsab_d[l_ac].wsab006_img = g_bpm_url ,g_wsab_d[l_ac].wsab006_img                
                     
                     DISPLAY BY NAME g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc,g_wsab_d[l_ac].wsab006_img 
                  ELSE   
                     NEXT FIELD wsab005
                  END IF 
               END IF                           #160902-00024#12
            #160902-00024#11-S
            #ELSE          
            #   NEXT FIELD wsab006    
            #160902-00024#11-E
            END IF
            #160902-00024#1-E
            
          #----<<wsab006>>----
          #160902-00024#11-S
          ##此段落由子樣板a01產生
          #BEFORE FIELD wsab006
          #   #add-point:BEFORE FIELD wsab006
          #   {<point name="input.b.page1.wsab006" />}
          #   #END add-point
          #
          ##此段落由子樣板a02產生
          #AFTER FIELD wsab006
          #
          #   #add-point:AFTER FIELD wsab006
          #   {<point name="input.a.page1.wsab006" />}
          #   #160902-00024#1-S
          #   IF cl_null(g_wsab_d[l_ac].wsab006) THEN           
          #      INITIALIZE g_errparam TO NULL
          #      LET g_errparam.code   =  "aws-00075"
          #      LET g_errparam.popup  = FALSE
          #      CALL cl_err()   
          #      NEXT FIELD wsab005
          #   END IF
          #   #160902-00024#1-E
          #   #END add-point
          #
          #
          ##此段落由子樣板a04產生
          #ON CHANGE wsab006
          #   #add-point:ON CHANGE wsab006
          #   {<point name="input.g.page1.wsab006" />}
          #   #END add-point
          #160902-00024#11-E
       
        
         #---------------------<  Detail: page1  >---------------------
         #----<<wsab004>>----
         #Ctrlp:input.c.page1.wsab004
         ON ACTION controlp INFIELD wsab004            
            LET g_qryparam.reqry = FALSE
            CALL q_wsae002()                           #呼叫開窗
            LET g_wsab_d[l_ac].wsab004 = g_qryparam.return1
            LET g_wsab_d[l_ac].wsab004_desc = g_qryparam.return2
            DISPLAY BY NAME g_wsab_d[l_ac].wsab004
         
         #----<<wsab005>>----
         #Ctrlp:input.c.page1.wsab005
         ON ACTION controlp INFIELD wsab005
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E 
               LET g_qryparam.reqry = FALSE
               CALL awsi011_01()
               LET g_wsab_d[l_ac].wsab005 = g_qryparam.return1
               LET g_wsab_d[l_ac].wsab005_desc = g_qryparam.return2
               DISPLAY BY NAME g_wsab_d[l_ac].wsab005,g_wsab_d[l_ac].wsab005_desc
            END IF      #160902-00024#12
            
            
         #----<<wsab006>>----
         #Ctrlp:input.c.page1.wsab006
#         ON ACTION controlp INFIELD wsab006
            #add-point:ON ACTION controlp INFIELD wsab006
            {<point name="input.c.page1.wsab006" />}
            #END add-point     

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_wsab_d[l_ac].* = g_wsab_d_t.*
               CLOSE awsi013_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_wsab_d[l_ac].wsab004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_wsab_d[l_ac].* = g_wsab_d_t.*
            ELSE
               #寫入修改者/修改日期資訊

               #add-point:單身修改前
               {<point name="input.body.b_update" mark="Y"/>}
               #end add-point

               UPDATE wsab_t SET (wsab001,wsab002,wsab003,wsab004,wsab005,wsab006) = (g_wsab_m.wsaa001,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_d[l_ac].wsab004,g_wsab_d[l_ac].wsab005,g_wsab_d[l_ac].wsab006)
                WHERE wsabent = g_enterprise 
                 AND wsab001 = g_wsab_m.wsaa001
                 AND wsab002 = g_wsab_m.wsab002
                 AND wsab003 = g_wsab_m.wsab003
                 AND wsab004 = g_wsab_d_t.wsab004 #項次


               #add-point:單身修改中
               {<point name="input.body.m_update"/>}
               #end add-point

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "wsab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "wsab_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_wsab_m.wsaa001
                     LET gs_keys_bak[1] = g_wsab001_t
                     LET gs_keys[2] = g_wsab_m.wsab002
                     LET gs_keys_bak[2] = g_wsab002_t
                     LET gs_keys[3] = g_wsab_m.wsab003
                     LET gs_keys_bak[3] = g_wsab003_t
                     LET gs_keys[4] = g_wsab_d[g_detail_idx].wsab004
                     LET gs_keys_bak[4] = g_wsab_d_t.wsab004
                     CALL awsi013_update_b('wsab_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改

               END CASE

               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
            END IF

         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF cl_null(g_wsab_d[1].wsab004) THEN
               CALL g_wsab_d.deleteElement(1)
               NEXT FIELD wsab004
            END IF
            #add-point:input段after input
            {<point name="input.body.after_input"/>}
            #end add-point            
            
         ON ACTION bpm_flow_create
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E
               #詢問是否建立流程
               IF cl_ask_confirm("aws-00011") THEN
                  LET l_flow_wsab.wsab001 = g_wsab_m.wsaa001
                  LET l_flow_wsab.wsab003 = g_wsab_m.wsab003
                  LET l_flow_wsab.wsab004 = g_wsab_d[l_ac].wsab004
                  LET l_flow_wsab.wsab005 = g_wsab_d[l_ac].wsab005
   
                  #建立單據簽核流程,取得簽核流程代號
                  CALL cl_bpm_flow_create(l_flow_wsab.*)
                     RETURNING g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc, g_wsab_d[l_ac].wsab006_img
                  
                  #顯示流程圖片
                  LET g_wsab_d[l_ac].wsab006_img = g_bpm_url ,g_wsab_d[l_ac].wsab006_img               
                  
                  DISPLAY BY NAME g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc,g_wsab_d[l_ac].wsab006_img                
                  #160902-00024#11-S
                  CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", TRUE)
                  CALL cl_set_act_visible("bpm_flow_create", FALSE)
         #160902-00024#11-E    
               END IF     
            END IF     #160902-00024#12
         
         #160902-00024#11-S
         ON ACTION bpm_flow_site_delete
            #160902-00024#12-S              
            IF NOT awsi013_chk_bpm() THEN
               LET g_errparam.code = "aws-00081"   #未啟用BPM協同!
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE  
            #160902-00024#12-E
               LET l_wsab.wsab001 = g_wsab_m.wsaa001
               LET l_wsab.wsab003 = g_wsab_m.wsab003
               LET l_wsab.wsab004 = g_wsab_d[l_ac].wsab004
               LET l_wsab.wsab005 = g_wsab_d[l_ac].wsab005     
               IF cl_bpm_flow_delete(l_wsab.*, g_wsab_d[l_ac].wsab006) THEN
                  LET g_wsab_d[l_ac].wsab006 = ""
                  LET g_wsab_d[l_ac].wsab006_desc = ""
                  UPDATE wsab_t SET wsab006 = g_wsab_d[l_ac].wsab006
                      WHERE wsabent = g_enterprise 
                        AND wsab001 = g_wsab_m.wsaa001
                        AND wsab002 = g_wsab_m.wsab002
                        AND wsab003 = g_wsab_m.wsab003
                        AND wsab004 = g_wsab_d[l_ac].wsab004
                        AND wsab005 = g_wsab_d[l_ac].wsab005
                  DISPLAY BY NAME g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc
                  LET g_wsab_d[l_ac].wsab006_img = ""
                  DISPLAY BY NAME g_wsab_d[l_ac].wsab006, g_wsab_d[l_ac].wsab006_desc,g_wsab_d[l_ac].wsab006_img 
                  CALL cl_set_act_visible("bpm_flow_site_delete,bmp_flow_designer", FALSE)
                  CALL cl_set_act_visible("bpm_flow_create", TRUE)
               END IF
            END IF     #160902-00024#12
            
         ON ACTION bmp_flow_site_designer
            LET g_action_choice="bmp_flow_designer"
            LET l_url = g_bpm_url CLIPPED,"GP/ToolSuite?hdnMethod=openDesigner&hdnAppType=nana-bpm-designer"
            LET l_ssokey = cl_bpm_get_ssokey()            
            LET l_site = g_wsab_d[l_ac].wsab004
            
            IF cl_null(g_wsab_m.wsab003) THEN               
               LET l_url = l_url, "&hdnSSOKey=", l_ssokey , "&lang=", g_lang CLIPPED, "&companyId=", l_site, "&docPropId=", g_wsab_m.wsaa001 CLIPPED,"&designerType=signatureFlowDesigner"
            ELSE               
               LET l_url = l_url, "&hdnSSOKey=", l_ssokey ,"&lang=", g_lang CLIPPED, "&companyId=", l_site, "&docPropId=", g_wsab_m.wsaa001 CLIPPED,"&formId=", g_wsab_m.wsab003,"&designerType=signatureFlowDesigner"
            END IF            
            DISPLAY "bpm_designer:", l_url, ";"
            CALL ui.Interface.frontCall( "standard", "launchurl", [l_url], [] )
               
         #160902-00024#11-E            
      END INPUT


      #add-point:input段more_input
      {<point name="input.more_inputarray"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:input段before_dialog
         {<point name="input.before_dialog"/>}
         #end add-point
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD wsab005_m
         END IF

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

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

   #add-point:input段after_input
   {<point name="input.after_input"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_show()
   #add-point:show段define
   {<point name="show.define"/>}
   DEFINE l_wsab006_m_img     STRING   
   
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
  
   #end add-point

   IF g_bfill = "Y" THEN
      CALL awsi013_b_fill(g_wc2) #單身填充
      CALL awsi013_b_fill2('0') #單身填充
   END IF

   LET g_wsab_m_t.* = g_wsab_m.*      #保存單頭舊值

   
   DISPLAY BY NAME g_wsab_m.wsaa001,g_wsab_m.wsab001_desc,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_m.wsab003_desc,g_wsab_m.wsab005_m,g_wsab_m.wsab006_m,g_wsab_m.wsab007
        
      
   CALL awsi013_b_fill(g_wc2_table1)                 #單身
   CALL awsi013_b_fill2('0') #單身填充

   CALL awsi013_ref_show()

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_ref_show()
   {<Local define>}
   DEFINE l_ac_t  LIKE type_t.num10 #l_ac暫存用
   DEFINE l_i               LIKE type_t.num5 
   DEFINE l_wsab            type_g_flow_wsab 
   DEFINE l_wsab006_m_img   STRING
   
   {</Local define>}
   #add-point:ref_show段define
   {<point name="ref_show.define"/>}
   #end add-point

   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:ref_show段m_reference

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_wsab_m.wsaa001
   #160902-00024#11-S        
   #CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='24' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields
   CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields 
   #160902-00024#11-E        
   LET g_wsab_m.wsab001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_wsab_m.wsab001_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_wsab_m.wsab002
   LET g_ref_fields[2] = g_wsab_m.wsab003
   CALL ap_ref_array2(g_ref_fields,"SELECT oobal004 FROM oobal_t WHERE oobalent='"||g_enterprise||"' AND oobal001=? AND oobal002=? AND oobal003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_wsab_m.wsab003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_wsab_m.wsab003_desc
   
   #簽核模版名稱   
   LET g_wsab_m.wsab005_m_desc = ""
   FOR l_i = 1 TO g_flow_tpl.getLength()
       IF g_wsab_m.wsab005_m = g_flow_tpl[l_i].flow_template_id THEN
          LET g_wsab_m.wsab005_m_desc = g_flow_tpl[l_i].flow_template_name          
       END IF
   END FOR 
   DISPLAY BY NAME g_wsab_m.wsab005_m_desc
   
   #簽核流程名稱
   LET l_wsab.wsab001 = g_wsab_m.wsaa001
   LET l_wsab.wsab003 = g_wsab_m.wsab003
   LET l_wsab.wsab004 = "*"       #表示所有的營運據點         
   IF awsi013_chk_bpm() THEN  #160902-00024#12
      LET g_proc_list = cl_bpm_process_list_get(l_wsab.*)  
   END IF                     #160902-00024#12
   
   LET g_wsab_m.wsab006_m_desc = ""
   FOR l_i = 1 TO g_proc_list.getLength()
       IF g_wsab_m.wsab006_m = g_proc_list[l_i].process_id THEN
          LET l_wsab006_m_img = g_bpm_url , g_proc_list[l_i].process_image_url  
          LET g_wsab_m.wsab006_m_desc = g_proc_list[l_i].process_name
       END IF
   END FOR
   DISPLAY l_wsab006_m_img TO wsab006_m_img      
   DISPLAY BY NAME g_wsab_m.wsab006_m_desc
   {#ADP版次:1#}
   #end add-point

   #讀入ref值(單身)
   FOR l_ac = 1 TO g_wsab_d.getLength()
      #add-point:ref_show段d_reference
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_wsab_d[l_ac].wsab004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_wsab_d[l_ac].wsab004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_wsab_d[l_ac].wsab004_desc
      
      LET g_wsab_d[l_ac].wsab005_desc = ""
      FOR l_i = 1 TO g_flow_tpl.getLength()
       IF g_wsab_d[l_ac].wsab005 = g_flow_tpl[l_i].flow_template_id THEN
          LET g_wsab_d[l_ac].wsab005_desc = g_flow_tpl[l_i].flow_template_name
       END IF
      END FOR
      DISPLAY BY NAME g_wsab_d[l_ac].wsab005_desc
      
      FOR l_i = 1 TO g_proc_list.getLength()
          IF g_wsab_d[l_ac].wsab006 = g_proc_list[l_i].process_id THEN
             LET g_wsab_d[l_ac].wsab006_img = g_bpm_url , g_proc_list[l_i].process_image_url
             LET g_wsab_d[l_ac].wsab006_desc = g_proc_list[l_i].process_name
          END IF
      END FOR
         
      DISPLAY BY NAME g_wsab_d[l_ac].wsab006_desc,g_wsab_d[l_ac].wsab006_img
      
      {#ADP版次:1#}
      #end add-point
   END FOR

   LET l_ac = l_ac_t

END FUNCTION

PRIVATE FUNCTION awsi013_reproduce()
   {<Local define>}
   DEFINE l_newno       LIKE wsab_t.wsab001
   DEFINE l_oldno       LIKE wsab_t.wsab001
   DEFINE l_newno02     LIKE wsab_t.wsab002
   DEFINE l_oldno02     LIKE wsab_t.wsab002

   DEFINE l_newno03     LIKE wsab_t.wsab003
   DEFINE l_oldno03     LIKE wsab_t.wsab003


   DEFINE l_master    RECORD LIKE wsab_t.*
   DEFINE l_detail    RECORD LIKE wsab_t.*

   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   IF g_wsab_m.wsaa001 IS NULL OR g_wsab_m.wsab002 IS NULL OR g_wsab_m.wsab003 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_wsab001_t = g_wsab_m.wsaa001
   LET g_wsab002_t = g_wsab_m.wsab002

   LET g_wsab003_t = g_wsab_m.wsab003



   CALL awsi013_set_entry('a')
   CALL awsi013_set_no_entry('a')

   CALL cl_set_head_visible("","YES")

   CALL awsi013_input("r")

   LET g_wsab_m.wsab001_desc = ''
   DISPLAY BY NAME g_wsab_m.wsab001_desc
   LET g_wsab_m.wsab003_desc = ''
   DISPLAY BY NAME g_wsab_m.wsab003_desc


   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " wsab001 = '", l_newno CLIPPED, "' "
              ," AND wsab002 = '", l_newno02 CLIPPED, "' "
              ," AND wsab003 = '", l_newno03 CLIPPED, "' "
              , ") "

   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_detail_reproduce()
   {<Local define>}
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE wsab_t.*


   {</Local define>}
   #add-point:delete段define
   {<point name="detail_reproduce.define"/>}
   #end add-point

   CALL s_transaction_begin()

   LET ld_date = cl_get_current()

   DROP TABLE awsi013_detail

   #add-point:單身複製前1
   {<point name="detail_reproduce.body.table1.b_insert" mark="Y"/>}
   #end add-point

   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE awsi013_detail AS ",
                "SELECT * FROM wsab_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO awsi013_detail SELECT * FROM wsab_t
                                         WHERE wsabent = g_enterprise AND wsab001 = g_wsab001_t
                                         AND wsab002 = g_wsab002_t
                                         AND wsab003 = g_wsab003_t

   #將key修正為調整後
   UPDATE awsi013_detail
      #更新key欄位
      SET wsab001 = g_wsab_m.wsaa001, wsab002 = g_wsab_m.wsab002, wsab003 = g_wsab_m.wsab003

   #將資料塞回原table
   INSERT INTO wsab_t SELECT * FROM awsi013_detail

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   #add-point:單身複製中1
   {<point name="detail_reproduce.body.table1.m_insert"/>}
   #end add-point

   #刪除TEMP TABLE
   DROP TABLE awsi013_detail

   #add-point:單身複製後1
   {<point name="detail_reproduce.body.table1.a_insert"/>}
   #end add-point

   #多語言複製段落

   CALL s_transaction_end('Y','0')

   #已新增完, 調整資料內容(修改時使用)
   LET g_wsab001_t = g_wsab_m.wsaa001
   LET g_wsab002_t = g_wsab_m.wsab002
   LET g_wsab003_t = g_wsab_m.wsab003

   DROP TABLE awsi013_detail

END FUNCTION

PRIVATE FUNCTION awsi013_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   #end add-point

   IF g_wsab_m.wsaa001 IS NULL OR g_wsab_m.wsab002 IS NULL OR g_wsab_m.wsab003 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE wsab001,wsab002,wsab003,wsab005
      INTO g_wsab_m.wsaa001,g_wsab_m.wsab002,g_wsab_m.wsab003,g_wsab_m.wsab005_m
      FROM wsab_t
     WHERE wsabent = g_enterprise AND wsab001 = g_wsab_m.wsaa001 AND wsab002 = g_wsab_m.wsab002 AND wsab003 = g_wsab_m.wsab003
     
   CALL s_transaction_begin()

   OPEN awsi013_cl USING g_enterprise,g_wsab_m.wsaa001, g_wsab_m.wsab002, g_wsab_m.wsab003

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN awsi013_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE awsi013_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH awsi013_cl INTO g_wsab_m.wsaa001, g_wsab_m.wsab001_desc, g_wsab_m.wsab002, g_wsab_m.wsab003, g_wsab_m.wsab003_desc, g_wsab_m.wsab005_m

   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_wsab_m.wsaa001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL awsi013_show()

   IF cl_ask_del_master() THEN              #確認一下
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "wsab001"
      LET g_doc.value1 = g_wsab_m.wsaa001
      CALL cl_doc_remove()

      #add-point:單身刪除前
      {<point name="delete.body.b_delete" mark="Y"/>}
      #end add-point

      DELETE FROM wsab_t WHERE wsabent = g_enterprise AND wsab001 = g_wsab_m.wsaa001
                                                      AND wsab002 = g_wsab_m.wsab002
                                                      AND wsab003 = g_wsab_m.wsab003
                                                   

      #add-point:單身刪除中
      {<point name="delete.body.m_delete"/>}
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "wsab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF

      #add-point:單身刪除後
      {<point name="delete.body.a_delete"/>}
      #end add-point

      CLEAR FORM
      CALL g_wsab_d.clear()

      CALL awsi013_ui_browser_refresh()
      CALL awsi013_ui_headershow()
      CALL awsi013_ui_detailshow()

      IF g_browser_cnt > 0 THEN
         CALL awsi013_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL awsi013_browser_fill("F")
      END IF

   END IF

   CLOSE awsi013_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_wsab_m.wsaa001,'D')

END FUNCTION

PRIVATE FUNCTION awsi013_b_fill(p_wc2)
   {<Local define>}
   DEFINE p_wc2      STRING
   DEFINE l_i               LIKE type_t.num5
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point

   #先清空單身變數內容
   CALL g_wsab_d.clear()

   #add-point:b_fill段define
   {<point name="b_fill.sql_before"/>}
   #取消原有圖片預覽
   DISPLAY "" TO wsab006_img_pre
   #end add-point

   LET g_sql = "SELECT  UNIQUE wsab004,'',wsab005,wsab006 FROM wsab_t",      
               "  WHERE wsabent= ? AND wsab001=? AND wsab002=? AND wsab003=? AND wsab004 <> 'ALL' "

   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF

   #子單身的WC


   #判斷是否填充
   IF awsi013_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY wsab004"

      PREPARE awsi013_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR awsi013_pb

      LET g_cnt = l_ac
      LET l_ac = 1

      OPEN b_fill_cs USING g_enterprise, g_wsab_m.wsaa001, g_wsab_m.wsab002, g_wsab_m.wsab003

      FOREACH b_fill_cs INTO g_wsab_d[l_ac].wsab004, g_wsab_d[l_ac].wsab004_desc, g_wsab_d[l_ac].wsab005, g_wsab_d[l_ac].wsab006

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         #add-point:b_fill段資料填充
         {<point name="b_fill.fill"/>}
         
         #預覽流程圖片
         IF NOT cl_null(g_wsab_d[l_ac].wsab006) THEN
            FOR l_i = 1 TO g_flow_tpl.getLength()
                IF g_wsab_d[l_ac].wsab006 = g_proc_list[l_i].process_id THEN
                  LET g_wsab_d[l_ac].wsab006_img = g_bpm_url , g_proc_list[l_i].process_image_url
                  LET g_wsab_d[l_ac].wsab006_desc = g_proc_list[l_i].process_name
                END IF
            END FOR            
         END IF
   
         #end add-point

         #帶出公用欄位reference值

         #add-point:單身資料抓取
         {<point name="bfill.foreach"/>}
         
         
         #end add-point

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF

      END FOREACH

      CALL g_wsab_d.deleteElement(g_wsab_d.getLength())

   END IF

   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE awsi013_pb

END FUNCTION

PRIVATE FUNCTION awsi013_b_fill2(pi_idx)
   {<Local define>}
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:b_fill2段define
   {<point name="b_fill2.define"/>}
   #end add-point

   LET li_ac = l_ac

   #add-point:單身填充後
   {<point name="b_fill2.after_fill" />}
   #end add-point

   LET l_ac = li_ac

END FUNCTION

PRIVATE FUNCTION awsi013_before_delete()
   #add-point:before_delete段define
   {<point name="before_delete.define"/>}
   #end add-point

   #add-point:單筆刪除前
   {<point name="delete.body.b_single_delete" mark="Y"/>}
   #end add-point

   DELETE FROM wsab_t
     WHERE wsabent = g_enterprise 
       AND wsab001 = g_wsab_m.wsaa001 
       AND wsab002 = g_wsab_m.wsab002 
       AND wsab003 = g_wsab_m.wsab003 
       AND wsab004 = g_wsab_d_t.wsab004

   #add-point:單筆刪除中
   {<point name="delete.body.m_single_delete"/>}
   #end add-point

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "wsab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF

   #add-point:單筆刪除後
   {<point name="delete.body.a_single_delete"/>}
   #end add-point

   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt

   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION awsi013_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point


   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION awsi013_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point



END FUNCTION

PRIVATE FUNCTION awsi013_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   {<point name="update_b.define"/>}
   #end add-point

   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR

   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF

END FUNCTION

PRIVATE FUNCTION awsi013_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point

   #先刷新資料
   #CALL awsi013_b_fill()

   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION awsi013_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("wsaa001,wsab002,wsab003",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("wsaa001,wsab002,wsab003",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
     
   
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point

   #add-point:set_entry_b段
   {<point name="set_entry_b.set_entry_b"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   CALL cl_set_comp_entry("wsab006",FALSE)
   #end add-point

   #add-point:set_no_entry_b段
   {<point name="set_no_entry_b.set_no_entry_b段"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point

   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point

   LET g_pagestart = 1

   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " wsaa001 = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " wsab002 = '", g_argv[02], "' AND "
   END IF

   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " wsab003 = '", g_argv[03], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION awsi013_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING

   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      RETURN TRUE
   END IF

   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   #根據wc判定是否需要填充

   RETURN TRUE

END FUNCTION

################################################################################
# Descriptions...: 建立單據簽核流程
# Memo...........:
# Usage..........: CALL awsi013_flow_create(p_wsab004,p_upd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsi013_flow_create(p_wsab004,p_upd)
   DEFINE p_wsab004         LIKE wsab_t.wsab004
   DEFINE p_upd             STRING
   
   DEFINE l_wsab006_m_img   STRING
   DEFINE l_flow_wsab       type_g_flow_wsab
   DEFINE li_cnt    LIKE type_t.num5
   
   #160902-00024#12-S              
   IF NOT awsi013_chk_bpm() THEN
      RETURN
   ELSE     
   #160902-00024#12-E 
      IF cl_ask_confirm("aws-00011") THEN
         IF cl_null(g_wsab_m.wsab005_m) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "aws-00010"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN
         END IF
         
         LET l_flow_wsab.wsab001 = g_wsab_m.wsaa001
         LET l_flow_wsab.wsab003 = g_wsab_m.wsab003
         LET l_flow_wsab.wsab004 = p_wsab004
         LET l_flow_wsab.wsab005 = g_wsab_m.wsab005_m
   
         #建立單據簽核流程,取得簽核流程代號
         CALL cl_bpm_flow_create(l_flow_wsab.*)
              RETURNING g_wsab_m.wsab006_m, g_wsab_m.wsab006_m_desc, l_wsab006_m_img
                     
         DISPLAY BY NAME g_wsab_m.wsab006_m, g_wsab_m.wsab006_m_desc
         LET l_wsab006_m_img = g_bpm_url,l_wsab006_m_img
         DISPLAY l_wsab006_m_img TO wsab006_m_img     
                  
         IF p_upd = "Y" THEN
            SELECT COUNT(*) INTO li_cnt FROM wsab_t
             WHERE wsabent = g_enterprise
               AND wsab001 = g_wsab_m.wsaa001      
               AND wsab002 = g_wsab_m.wsab002
               AND wsab003 = g_wsab_m.wsab003  
               
            IF li_cnt > 0 THEN
               UPDATE wsab_t SET (wsab006) = (g_wsab_m.wsab006_m)
               WHERE wsabent = g_enterprise 
                 AND wsab001 = g_wsab_m.wsaa001
                 AND wsab002 = g_wsab_m.wsab002
                 AND wsab003 = g_wsab_m.wsab003
                 AND wsab004 = "ALL"    
            ELSE           
               INSERT INTO wsab_t(wsabent,wsab001,wsab002,wsab003,
                               wsab004,wsab005,wsab006,wsab007)
                        VALUES(g_enterprise,
                               g_wsab_m.wsaa001,
                               g_wsab_m.wsab002,
                               g_wsab_m.wsab003,
                               'ALL',
                               g_wsab_m.wsab005_m,                            
                               g_wsab_m.wsab006_m,
                               g_wsab_m.wsab007)         
            END IF
   
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'UPDATE:'
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
               RETURN
            END IF
         END IF
   
      END IF
   END IF   #160902-00024#12
END FUNCTION

PRIVATE FUNCTION awsi013_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   #清除畫面上相關資料
   CLEAR FORM
   INITIALIZE g_wsab_m.* TO NULL
   CALL g_wsab_d.clear()

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""

   LET g_qryparam.state = 'c'

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc ON wsaa001, wsab002, wsab003, wsab005, wsab006
                   FROM wsaa001, wsab002, wsab003, wsab005_m ,wsab006_m
         BEFORE CONSTRUCT
            #CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.head.before_construct"/>}
            LET g_qbe_wsab002 = ""
            LET g_qbe_wsab003 = ""
            #end add-point

        #---------------------------<  Master  >---------------------------
         #----<<wsab001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsaa001
            #add-point:BEFORE FIELD wsaa001
            {<point name="construct.b.wsab001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsaa001

            #add-point:AFTER FIELD wsaa001
            {<point name="construct.a.wsab001" />}
            #END add-point


         #Ctrlp:construct.c.wsab001
         ON ACTION controlp INFIELD wsaa001
            #add-point:ON ACTION controlp INFIELD wsaa001
            {<point name="construct.c.wsab001" />}
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_wsaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO wsaa001      #顯示到畫面上
            #END add-point

         #----<<wsab002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsab002
            #add-point:BEFORE FIELD wsab002
            {<point name="construct.b.wsab002" />}
           
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsab002

            #add-point:AFTER FIELD wsab002
            {<point name="construct.a.wsab002" />}
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               LET g_qbe_wsab002 = ls_result
            END IF
            #END add-point


         #Ctrlp:construct.c.wsab002
#         ON ACTION controlp INFIELD wsab002
            #add-point:ON ACTION controlp INFIELD wsab002
            {<point name="construct.c.wsab002" />}
            #END add-point

         #----<<wsab003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsab003
            #add-point:BEFORE FIELD wsab003
            {<point name="construct.b.wsab003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsab003

            #add-point:AFTER FIELD wsab003
            {<point name="construct.a.wsab003" />}
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               LET g_qbe_wsab003 = ls_result
            END IF
            #END add-point


         #Ctrlp:construct.c.wsab003
#         ON ACTION controlp INFIELD wsab003
            #add-point:ON ACTION controlp INFIELD wsab003
            {<point name="construct.c.wsab003" />}
            #END add-point

         #----<<wsab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsab005
            #add-point:BEFORE FIELD wsab005
            {<point name="construct.b.wsab005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsab005

            #add-point:AFTER FIELD wsab005
            {<point name="construct.a.wsab005" />}
            #END add-point


         #Ctrlp:construct.c.wsab005
         ON ACTION controlp INFIELD wsab005_m
            #add-point:ON ACTION controlp INFIELD wsab005
            {<point name="construct.c.wsab005" />}
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL awsi011_01()
            LET g_wsab_m.wsab005_m = g_qryparam.return1
            LET g_wsab_m.wsab005_m_desc = g_qryparam.return2 

            DISPLAY BY NAME g_wsab_m.wsab005_m, g_wsab_m.wsab005_m_desc
            #END add-point



      END CONSTRUCT

      CONSTRUCT g_wc2_table1 ON wsab004,wsab006
           FROM s_detail1[1].wsab004,s_detail1[1].wsab006

         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point

         #單身公用欄位開窗相關處理


         #單身一般欄位開窗相關處理
         #---------------------<  Detail: page1  >---------------------
         #----<<wsab004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsab004
            #add-point:BEFORE FIELD wsab004
            {<point name="construct.b.page1.wsab004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsab004

            #add-point:AFTER FIELD wsab004
            {<point name="construct.a.page1.wsab004" />}
            #END add-point


         #Ctrlp:construct.c.page1.wsab004
#         ON ACTION controlp INFIELD wsab004
            #add-point:ON ACTION controlp INFIELD wsab004
            {<point name="construct.c.page1.wsab004" />}
            #END add-point

         #----<<wsab006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD wsab006
            #add-point:BEFORE FIELD wsab006
            {<point name="construct.b.page1.wsab006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD wsab006

            #add-point:AFTER FIELD wsab006
            {<point name="construct.a.page1.wsab006" />}
            #END add-point


         #Ctrlp:construct.c.page1.wsab006
#         ON ACTION controlp INFIELD wsab006
            #add-point:ON ACTION controlp INFIELD wsab006
            {<point name="construct.c.page1.wsab006" />}
            #END add-point

         
      END CONSTRUCT



      #add-point:cs段more_construct
      {<point name="cs.more_construct"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:ui_dialog段b_dialog
         {<point name="cs.before_dialog"/>}
         #end add-point

      ON ACTION qbe_select     #條件查詢
         #CALL cl_qbe_list() RETURNING lc_qbe_sn
         #CALL cl_qbe_display_condition(lc_qbe_sn)

      ON ACTION qbe_save       #條件儲存
         #CALL cl_qbe_save()

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:cs段after_construct
   {<point name="cs.after_construct"/>}
   #end add-point

   #組合g_wc2
   LET g_wc2 = g_wc2_table1




   LET g_current_row = 1

   IF INT_FLAG THEN
      RETURN
   END IF

   LET g_wc_filter = ""

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsi03_splite(p_str)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsi013_splite(p_str)
    DEFINE p_str       STRING
    DEFINE l_tok       base.StringTokenizer
    DEFINE l_tok_key   base.StringTokenizer
    DEFINE l_wc        DYNAMIC ARRAY OF STRING 
    DEFINE l_str       STRING
    DEFINE l_str2      STRING
    DEFINE l_cnt       LIKE type_t.num10
    DEFINE l_cnt2      LIKE type_t.num10
    DEFINE l_key_str   STRING
    DEFINE buf         base.StringBuffer
            
    LET l_wc = ""
    LET l_str = ""
    LET l_cnt = 1

    LET l_tok = base.StringTokenizer.createExt(p_str CLIPPED,"|","",TRUE)
    WHILE l_tok.hasMoreTokens()
         LET l_str = l_tok.nextToken()
         LET l_wc[l_cnt] = l_str
         LET l_cnt = l_cnt + 1
    END WHILE

    RETURN l_wc
END FUNCTION

#160902-00024#12
# 是否啟用BPM協同
PRIVATE FUNCTION awsi013_chk_bpm()
   IF cl_aws_prod_para(g_enterprise,"bpm-0001")  != "Y" THEN  
      RETURN FALSE
   END IF   
   RETURN TRUE
END FUNCTION

#end add-point
 
{</section>}
 
