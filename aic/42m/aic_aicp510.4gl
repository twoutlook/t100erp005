#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-05-27 18:19:12), PR版次:0007(2017-02-15 17:52:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000076
#+ Filename...: aicp510
#+ Description: 多角貿易出貨單拋轉還原作業
#+ Creator....: 01588(2014-11-13 10:02:08)
#+ Modifier...: 04543 -SD/PR- 08171
 
{</section>}
 
{<section id="aicp510.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150917-00001#3  2016/01/19 By earl         多角中斷調整為可拆單功能
#161231-00013#1  2016/01/11 By 08992   增加azzi850 部門權限控管
#170213-00043#1  2017/02/15 By 08171   若拋轉成功後已無符合的資料則不提示[指定的資料無法查詢到，....] 
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
        sel              LIKE type_t.chr1,
        xmdkdocno        LIKE xmdk_t.xmdkdocno,   #出貨單號
        xmdkdocdt        LIKE xmdk_t.xmdkdocdt,   #出貨日期
        xmdk045          LIKE xmdk_t.xmdk045,     #訂單多角性質
        xmdk007          LIKE xmdk_t.xmdk007,     #客戶編號
        xmdk007_desc     LIKE type_t.chr500,      #客戶名稱
        xmdk009          LIKE xmdk_t.xmdk009,     #收貨客戶
        xmdk009_desc     LIKE type_t.chr500,      #客戶名稱
        xmdk008          LIKE xmdk_t.xmdk008,     #收款客戶
        xmdk008_desc     LIKE type_t.chr500,      #客戶名稱
        xmdk003          LIKE xmdk_t.xmdk003,     #業務人員
        xmdk003_desc     LIKE type_t.chr500,      #姓名
        xmdk004          LIKE xmdk_t.xmdk004,     #業務部門
        xmdk004_desc     LIKE type_t.chr500,      #說明
        xmdkownid        LIKE xmdk_t.xmdkownid,   #資料所有者
        xmdkownid_desc   LIKE type_t.chr500,      #姓名
        xmdkcrtid        LIKE xmdk_t.xmdkcrtid,   #資料建立者
        xmdkcrtid_desc   LIKE type_t.chr500,      #姓名
        xmdk002          LIKE xmdk_t.xmdk002,     #出貨性質
        xmdk000          LIKE xmdk_t.xmdk000,     #單據性質
        xmdk044          LIKE xmdk_t.xmdk044,     #多角流程代碼
        xmdk044_desc     LIKE type_t.chr500,      #說明
        break            LIKE type_t.chr1,        #中斷續拋
        xmdk035          LIKE xmdk_t.xmdk035      #多角序號
                         END RECORD

#出貨明細
TYPE type_g_detail2_d    RECORD
        xmdlseq          LIKE xmdl_t.xmdlseq,     #項次
        xmdl003          LIKE xmdl_t.xmdl003,     #訂單單號
        xmdl004          LIKE xmdl_t.xmdl004,     #訂單項次
        xmdl005          LIKE xmdl_t.xmdl005,     #訂單項序
        xmdl006          LIKE xmdl_t.xmdl006,     #分批序
        xmdl007          LIKE xmdl_t.xmdl007,     #子件特性
        xmdl008          LIKE xmdl_t.xmdl008,     #料件編號
        xmdl008_desc     LIKE type_t.chr500,      #品名
        xmdl008_desc_1   LIKE type_t.chr500,      #規格
        xmdl009          LIKE xmdl_t.xmdl009,     #產品特徵
        xmdl009_desc     LIKE type_t.chr500,      #特徵值說明
        xmdl033          LIKE xmdl_t.xmdl033,     #客戶料號
        xmdl017          LIKE xmdl_t.xmdl017,     #出貨單位
        xmdl017_desc     LIKE type_t.chr500,      #說明
        xmdl018          LIKE xmdl_t.xmdl018,     #申請出貨數量
        xmdl019          LIKE xmdl_t.xmdl019,     #參考單位
        xmdl019_desc     LIKE type_t.chr500,      #說明
        xmdl020          LIKE xmdl_t.xmdl020,     #參考數量
        xmdl010          LIKE xmdl_t.xmdl010      #包裝容器
                         END RECORD
DEFINE g_detail2_cnt     LIKE type_t.num5
DEFINE g_detail2_d       DYNAMIC ARRAY OF type_g_detail2_d

#執行成功
TYPE type_g_detail3_d    RECORD
        xmdkdocno1       LIKE xmdk_t.xmdkdocno,   #出貨單號
        xmdkdocdt1       LIKE xmdk_t.xmdkdocdt,   #出貨日期
        xmdk0071         LIKE xmdk_t.xmdk007,     #客戶編號
        xmdk0071_desc    LIKE type_t.chr500,      #客戶名稱
        xmdk0031         LIKE xmdk_t.xmdk003,     #業務人員
        xmdk0031_desc    LIKE type_t.chr500,      #姓名
        xmdk0041         LIKE xmdk_t.xmdk004,     #業務部門
        xmdk0041_desc    LIKE type_t.chr500       #說明
                         END RECORD
DEFINE g_detail3_cnt     LIKE type_t.num5
DEFINE g_detail3_d       DYNAMIC ARRAY OF type_g_detail3_d

#執行失敗
TYPE type_g_detail4_d    RECORD
        xmdkdocno2       LIKE xmdk_t.xmdkdocno,   #出貨單號
        xmdkdocdt2       LIKE xmdk_t.xmdkdocdt,   #出貨日期
        xmdk0072         LIKE xmdk_t.xmdk007,     #客戶編號
        xmdk0072_desc    LIKE type_t.chr500,      #客戶名稱
        xmdk0032         LIKE xmdk_t.xmdk003,     #業務人員
        xmdk0032_desc    LIKE type_t.chr500,      #姓名
        xmdk0042         LIKE xmdk_t.xmdk004,     #業務部門
        xmdk0042_desc    LIKE type_t.chr500,      #說明
        xmdkownid2       LIKE xmdk_t.xmdkownid,   #資料所有者
        xmdkownid2_desc  LIKE type_t.chr500,      #姓名
        xmdkcrtid2       LIKE xmdk_t.xmdkcrtid,   #資料建立者
        xmdkcrtid2_desc  LIKE type_t.chr500,      #姓名
        xmdk0352         LIKE xmdk_t.xmdk035,     #多角序號
        xmdksite2        LIKE xmdk_t.xmdksite,    #營運據點
        xmdksite2_desc   LIKE type_t.chr500,      #營運據點名稱
        reason           LIKE type_t.chr1000      #失敗原因
                         END RECORD
DEFINE g_detail4_cnt     LIKE type_t.num5
DEFINE g_detail4_d       DYNAMIC ARRAY OF type_g_detail4_d

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

DEFINE g_aicp510_sel     STRING           #符合之SQL條件

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp510.main" >}
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
   CALL cl_ap_init("aic","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   IF NOT aicp510_create_temp_table() THEN
      CALL cl_ap_exitprogram("0")
      #dorislai-20150914-modify----(S)
#      EXIT PROGRAM
      CALL cl_ap_exitprogram("1")
      #dorislai-20150914-modify----(E)
   END IF
   
   CALL aicp510_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdkdocno = '",g_argv[1],"' "
         CALL aicp510_query()
         UPDATE aicp510_tmp 
            SET sel = 'Y'
         CALL aicp510_process() 
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp510 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp510_init()   
 
      #進入選單 Menu (="N")
      CALL aicp510_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp510
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aicp510_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   

   LET g_errshow = 1
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   CALL cl_set_combo_scc('b_xmdk045','2064')
   CALL cl_set_combo_scc('b_xmdk002','2063')
   CALL cl_set_combo_scc('b_xmdk000','2077')
   CALL cl_set_combo_scc('b_xmdl007','2055')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp510_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_wc = " 1=1"
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aicp510_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,xmdk007,xmdk003,xmdk004,
                                   xmdkownid,xmdkcrtid,xmdk044,xmdk035
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = g_aicp510_sel
               
               CALL q_xmdkdocno_9()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上
               NEXT FIELD xmdkdocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD xmdk007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               
               CALL q_pmaa001_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk007  #顯示到畫面上
               NEXT FIELD xmdk007                     #返回原欄位

            ON ACTION controlp INFIELD xmdk003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003  #顯示到畫面上
               NEXT FIELD xmdk003                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk004  #顯示到畫面上
               NEXT FIELD xmdk004                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdkownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkownid  #顯示到畫面上
               NEXT FIELD xmdkownid                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdkcrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkcrtid  #顯示到畫面上
               NEXT FIELD xmdkcrtid                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk044
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_icaa001()
               DISPLAY g_qryparam.return1 TO xmdk044
               NEXT FIELD xmdk044
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
             
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL aicp510_fetch()       
               
            ON ROW CHANGE
               UPDATE aicp510_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
         END INPUT 
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               DISPLAY l_ac TO FORMONLY.idx
              
         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
            BEFORE DISPLAY

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac TO FORMONLY.idx

         END DISPLAY

         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail4_cnt)
            BEFORE DISPLAY

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               DISPLAY l_ac TO FORMONLY.idx

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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            
            CALL aicp510_sel()
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
            UPDATE aicp510_tmp 
               SET sel = 'Y'
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
            UPDATE aicp510_tmp 
               SET sel = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp510_tmp 
                     SET sel = 'Y' 
                    WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR 
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp510_tmp 
                     SET sel = 'N' 
                    WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR  
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp510_filter()
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
            CALL aicp510_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp510_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp510_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
            END IF
            #-----
            
            #判斷是否有至少選擇一筆資料做處理
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp510_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               
               CALL cl_err()
            ELSE
               CALL aicp510_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp510_query()
               LET INT_FLAG = FALSE    #170213-00043#1 17/02/15 By 08171 add
            END IF
            ACCEPT DIALOG
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
 
{<section id="aicp510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM aicp510_tmp;
   
   LET g_sql = "SELECT DISTINCT 'N',xmdkent,xmdkdocno,xmdkdocdt,xmdk045,",
               "                xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,",
               "                xmdkownid,xmdkcrtid,",
               "                xmdk002,xmdk000,xmdk044,xmdk035,",
               "          CASE xmdksite",
               "          WHEN (SELECT b.icab003 ",
               "                  FROM icaa_t a,icab_t b",
               "                 WHERE a.icaaent = b.icabent AND b.icabent = ",g_enterprise,
               "                   AND a.icaa001 = b.icab001 AND b.icab001 = xmdk044",
               "                   AND a.icaa004 = '2'",
               "                   AND b.icab002 = 0) THEN 'Y'",
               "          ELSE 'N'",
               "          END",
               "  FROM xmdk_t",
               " WHERE ",g_aicp510_sel,
               "   AND ",g_wc CLIPPED
   LET g_sql = "INSERT INTO aicp510_tmp ",g_sql CLIPPED
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp510_b_fill()
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
 
{<section id="aicp510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT 'N',xmdkdocno,xmdkdocdt,",
               "                xmdk007,b1.pmaal004,",
               "                xmdk009,b2.pmaal004,",
               "                xmdk008,b3.pmaal004,",
               "                xmdk003,a1.ooag011,",
               "                xmdk004,ooefl003,",
               "                xmdkownid,a2.ooag011,",
               "                xmdkcrtid,a3.ooag011,",
               "                xmdk002,xmdk000,",
               "                xmdk044,icaal003,",
               "                xmdk035,break,xmdk045",
               "  FROM aicp510_tmp ",
               "       LEFT OUTER JOIN pmaal_t b1 ON b1.pmaalent = '",g_enterprise,"' AND b1.pmaal001 = xmdk007 AND b1.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t b2 ON b2.pmaalent = '",g_enterprise,"' AND b2.pmaal001 = xmdk009 AND b2.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t b3 ON b3.pmaalent = '",g_enterprise,"' AND b3.pmaal001 = xmdk008 AND b3.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN ooag_t a1 ON a1.ooagent = '",g_enterprise,"' AND a1.ooag001 = xmdk003 ",
               "       LEFT OUTER JOIN ooag_t a2 ON a2.ooagent = '",g_enterprise,"' AND a2.ooag001 = xmdkownid ",
               "       LEFT OUTER JOIN ooag_t a3 ON a3.ooagent = '",g_enterprise,"' AND a3.ooag001 = xmdkcrtid ",
               "       LEFT OUTER JOIN ooefl_t ON ooeflent = '",g_enterprise,"' AND ooefl001 = xmdk004 AND ooefl002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN icaal_t ON icaalent = '",g_enterprise,"' AND icaal001 = xmdk044 AND icaal002 = '",g_dlang,"' ",
               " WHERE xmdkent = ? ",
               "   AND ",g_wc_filter,
               " ORDER BY xmdkdocno "
   #end add-point
 
   PREPARE aicp510_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp510_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()  
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdkdocno,g_detail_d[l_ac].xmdkdocdt,
      g_detail_d[l_ac].xmdk007,g_detail_d[l_ac].xmdk007_desc,
      g_detail_d[l_ac].xmdk009,g_detail_d[l_ac].xmdk009_desc,
      g_detail_d[l_ac].xmdk008,g_detail_d[l_ac].xmdk008_desc,
      g_detail_d[l_ac].xmdk003,g_detail_d[l_ac].xmdk003_desc,
      g_detail_d[l_ac].xmdk004,g_detail_d[l_ac].xmdk004_desc,
      g_detail_d[l_ac].xmdkownid,g_detail_d[l_ac].xmdkownid_desc,
      g_detail_d[l_ac].xmdkcrtid,g_detail_d[l_ac].xmdkcrtid_desc,
      g_detail_d[l_ac].xmdk002,g_detail_d[l_ac].xmdk000,
      g_detail_d[l_ac].xmdk044,g_detail_d[l_ac].xmdk044_desc,
      g_detail_d[l_ac].xmdk035,g_detail_d[l_ac].break,g_detail_d[l_ac].xmdk045
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
      
      CALL aicp510_detail_show()      
 
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
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   IF g_detail_d.getLength() > 0 THEN
      LET g_master_idx = 1
   ELSE
      LET g_master_idx = 0
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aicp510_sel
   
   LET l_ac = 1
   CALL aicp510_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp510_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   
   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT xmdlseq,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007,xmdl008,imaal003,imaal004, ",
               "       xmdl009,'',xmdl033,xmdl017,a1.oocal003,xmdl018,xmdl019,a2.oocal003,xmdl020, ",
               "       xmdl010 ",
               "  FROM xmdl_t ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = xmdlent AND imaal001 = xmdl008 AND imaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t a1 ON a1.oocalent = xmdlent AND a1.oocal001 = xmdl017 AND a1.oocal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t a2 ON a2.oocalent = xmdlent AND a2.oocal001 = xmdl019 AND a2.oocal002 = '",g_dlang,"' ",
               " WHERE xmdlent = '",g_enterprise,"'",
               "   AND xmdldocno = '",g_detail_d[g_master_idx].xmdkdocno,"' ",
               " ORDER BY xmdlseq "
   PREPARE xmdl_fill_pre FROM g_sql
   DECLARE xmdl_fill_cur CURSOR FOR xmdl_fill_pre
   
   FOREACH xmdl_fill_cur INTO 
      g_detail2_d[l_ac].xmdlseq,g_detail2_d[l_ac].xmdl003,g_detail2_d[l_ac].xmdl004,
      g_detail2_d[l_ac].xmdl005,g_detail2_d[l_ac].xmdl006,g_detail2_d[l_ac].xmdl007,
      g_detail2_d[l_ac].xmdl008,g_detail2_d[l_ac].xmdl008_desc,g_detail2_d[l_ac].xmdl008_desc_1,
      g_detail2_d[l_ac].xmdl009,g_detail2_d[l_ac].xmdl009_desc,g_detail2_d[l_ac].xmdl033,
      g_detail2_d[l_ac].xmdl017,g_detail2_d[l_ac].xmdl017_desc,g_detail2_d[l_ac].xmdl018,
      g_detail2_d[l_ac].xmdl019,g_detail2_d[l_ac].xmdl019_desc,g_detail2_d[l_ac].xmdl020,
      g_detail2_d[l_ac].xmdl010
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH xmdl:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
         
      #產品特徵的說明
      CALL s_feature_description(g_detail2_d[l_ac].xmdl008,g_detail2_d[l_ac].xmdl009)
           RETURNING l_success,g_detail2_d[l_ac].xmdl009_desc 
           
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   LET g_detail2_cnt = l_ac - 1 
   DISPLAY g_detail2_cnt TO FORMONLY.cnt 
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp510_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp510_filter()
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
  
   CLEAR FORM 
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   
   CONSTRUCT g_wc_filter ON xmdkdocno,xmdkdocdt,
                            xmdk007,xmdk009,xmdk008,
                            xmdk003,xmdk004,
                            xmdkownid,xmdkcrtid,
                            xmdk002,xmdk000,
                            xmdk044,xmdk035
        FROM s_detail1[1].b_xmdkdocno,s_detail1[1].b_xmdkdocdt,
             s_detail1[1].b_xmdk007,s_detail1[1].b_xmdk009,s_detail1[1].b_xmdk008,
             s_detail1[1].b_xmdk003,s_detail1[1].b_xmdk004,
             s_detail1[1].b_xmdkownid,s_detail1[1].b_xmdkcrtid,
             s_detail1[1].b_xmdk002,s_detail1[1].b_xmdk000,
             s_detail1[1].b_xmdk044,s_detail1[1].b_xmdk035
           
      BEFORE CONSTRUCT
      
       ON ACTION controlp INFIELD b_xmdkdocno
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.where = g_aicp510_sel
          
          CALL q_xmdkdocno_9()                       #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdkdocno  #顯示到畫面上
          NEXT FIELD b_xmdkdocno                     #返回原欄位    
               
       ON ACTION controlp INFIELD b_xmdk007
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.arg1 = g_site
          
          CALL q_pmaa001_6()                       #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdk007  #顯示到畫面上
          NEXT FIELD b_xmdk007                     #返回原欄位

       ON ACTION controlp INFIELD b_xmdk009
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.arg1 = g_site
          
          CALL q_pmaa001_6()                       #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdk009  #顯示到畫面上
          NEXT FIELD b_xmdk009                     #返回原欄位

       ON ACTION controlp INFIELD b_xmdk008
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.arg1 = g_site
          
          CALL q_pmaa001_6()                       #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdk008  #顯示到畫面上
          NEXT FIELD b_xmdk008                     #返回原欄位
          
       ON ACTION controlp INFIELD b_xmdk003
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooag001()                         #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdk003  #顯示到畫面上
          NEXT FIELD b_xmdk003                     #返回原欄位
               
       ON ACTION controlp INFIELD b_xmdk004
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooeg001()                         #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdk004  #顯示到畫面上
          NEXT FIELD b_xmdk004                     #返回原欄位
               
       ON ACTION controlp INFIELD b_xmdkownid
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooag001()                           #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdkownid  #顯示到畫面上
          NEXT FIELD b_xmdkownid                     #返回原欄位
   
       ON ACTION controlp INFIELD b_xmdkcrtid
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooag001()                           #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_xmdkcrtid  #顯示到畫面上
          NEXT FIELD b_xmdkcrtid                     #返回原欄位
       
       ON ACTION controlp INFIELD b_xmdk044
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_icaa001()
          DISPLAY g_qryparam.return1 TO b_xmdk044
          NEXT FIELD b_xmdk044
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp510_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp510_filter_parser(ps_field)
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
 
{<section id="aicp510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp510_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL aicp510_create_temp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/11/10 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp510_create_temp_table()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE aicp510_tmp;
   CREATE TEMP TABLE aicp510_tmp(
      sel             VARCHAR(1),
      xmdkent         SMALLINT,
      xmdkdocno       VARCHAR(20),
      xmdkdocdt       DATE,
      xmdk045         VARCHAR(10),
      xmdk007         VARCHAR(10),
      xmdk009         VARCHAR(10),
      xmdk008         VARCHAR(10),
      xmdk003         VARCHAR(20),
      xmdk004         VARCHAR(10),
      xmdkownid       VARCHAR(20),
      xmdkcrtid       VARCHAR(20),
      xmdk002         VARCHAR(10),
      xmdk000         VARCHAR(10),
      xmdk044         VARCHAR(10),
      xmdk035         VARCHAR(20),
      break           VARCHAR(1)
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create aicp510_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 批次執行
# Memo...........:
# Usage..........: CALL aicp510_process()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/11/10 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp510_process()
DEFINE l_xmdk            type_g_detail_d
DEFINE l_success         LIKE type_t.num5
DEFINE l_icab_now     RECORD
          icab002               LIKE icab_t.icab002,   #站別
          icab003               LIKE icab_t.icab003,   #營運據點
          icab004               LIKE icab_t.icab004,   #委外工單開立點
          icab005               LIKE icab_t.icab005,   #中斷點否
          icab008               LIKE icab_t.icab008    #實體庫存否
                      END RECORD
DEFINE l_xmdl085         LIKE xmdl_t.xmdl085

   #有選擇的出貨單
   LET g_sql = "SELECT xmdkdocno,xmdkdocdt,xmdk045,",
               "       xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,",
               "       xmdkownid,xmdkcrtid,",
               "       xmdk002,xmdk000,",
               "       xmdk044,break,xmdk035",
               "  FROM aicp510_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY xmdkdocno "
   PREPARE aicp510_process_pre FROM g_sql
   DECLARE aicp510_process_cur CURSOR WITH HOLD FOR aicp510_process_pre
   
   #該流程多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003,icab004,",
               "       COALESCE(icab005,'N'),COALESCE(icab008,'N')",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               " ORDER BY icab002"
   PREPARE aicp510_process_icab_pre FROM g_sql
   DECLARE aicp510_process_icab_cur CURSOR FOR aicp510_process_icab_pre

   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化
   
   FOREACH aicp510_process_cur INTO l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk045,
                                    l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,
                                    l_xmdk.xmdkownid,l_xmdk.xmdkcrtid,
                                    l_xmdk.xmdk002,l_xmdk.xmdk000,
                                    l_xmdk.xmdk044,l_xmdk.break,l_xmdk.xmdk035
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         #失敗記錄
         CALL aicp510_fail(l_xmdk.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      
      #多角序號為空白時，錯誤
      IF cl_null(l_xmdk.xmdk035) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00099'   #該筆資料之多角序號為空！
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp510_fail(l_xmdk.*,'')
         CONTINUE FOREACH
      END IF
      
      IF l_xmdk.xmdk045 <> '3' THEN
      #多角性質非"統銷統收"
      
         #多角流程代碼為空白時，錯誤
         IF cl_null(l_xmdk.xmdk044) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aic-00026'   #多角流程代碼不可為空
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp510_fail(l_xmdk.*,'')
            CONTINUE FOREACH
         END IF
      
         #跑站(當站)
         INITIALIZE l_icab_now.* TO NULL
         OPEN aicp510_process_icab_cur USING l_xmdk.xmdk044
         FOREACH aicp510_process_icab_cur INTO l_icab_now.icab002,l_icab_now.icab003,l_icab_now.icab004,
                                               l_icab_now.icab005,l_icab_now.icab008
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
                  
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF

            #用多角序號抓取該站的出貨單，並做處理
            CALL aicp510_xmdk(l_icab_now.icab003,l_xmdk.xmdk035,l_xmdk.xmdk044,1,l_xmdk.break)
                 RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF

            #150917-00001#3  2016/01/19 By earl mark s
#            #中斷續拋，中斷點且實體庫存，只處理到出貨單
#            IF l_xmdk.break = 'Y' AND l_icab_now.icab005 = 'Y' AND l_icab_now.icab008 = 'Y' THEN
#               EXIT FOREACH
#            END IF
            #150917-00001#3  2016/01/19 By earl mark e

            #用多角序號抓取該站的入庫單，並做處理
            CALL aicp510_pmds(l_icab_now.icab003,l_xmdk.xmdk035)
                 RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF

            #150917-00001#3  2016/01/19 By earl mark s
#            #中斷續拋，中斷點且無實體庫存，處理到出貨單、入庫單
#            IF l_xmdk.break = 'Y' AND l_icab_now.icab005 = 'Y' THEN
#               EXIT FOREACH
#            END IF
            #150917-00001#3  2016/01/19 By earl mark e
            
         END FOREACH
      END IF
      
      #更新"多角貿易拋轉否"='N'及清空"多角流程序號"
      IF l_success THEN
         #150917-00001#3  2016/01/19 By earl mod s
#         #中斷續拋
#         IF l_xmdk.break = 'Y' THEN
#            UPDATE xmdk_t SET xmdk083 = 'N'
#             WHERE xmdkent = g_enterprise
#               AND xmdkdocno = l_xmdk.xmdkdocno
#         ELSE
            UPDATE xmdk_t SET xmdk035 = NULL,
                              xmdk083 = 'N'
             WHERE xmdkent = g_enterprise
               AND xmdkdocno = l_xmdk.xmdkdocno
#         END IF
         #150917-00001#3  2016/01/19 By earl mod e
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
                        
            CALL cl_err()
            LET l_success = FALSE
            #失敗記錄
            CALL aicp510_fail(l_xmdk.*,'')
         END IF
                  
      END IF
            
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_xmdk.xmdk035,'4')
              RETURNING l_success
      END IF
      
      IF g_bgjob = 'N' THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            #成功記錄
            CALL aicp510_success(l_xmdk.*)
         ELSE
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp510_fail(l_xmdk.*,l_icab_now.icab003)
         END IF
      ELSE
         IF l_success THEN
            #成功
            CALL s_transaction_end('Y',0)
            CALL cl_ask_pressanykey("aic-00178")    #多角流程拋轉還原成功！
         ELSE
            #失敗
            CALL s_transaction_end('N',0)
            CALL cl_ask_pressanykey("aic-00179")    #多角流程拋轉還原失敗！
         END IF
      END IF
      
   END FOREACH
   
   #清空錯誤訊息的array，並且之後的訊息不以array記錄
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF
END FUNCTION

################################################################################
# Descriptions...: 抓取該站的出貨單，過帳還原、取消確認並刪除所有資料
# Memo...........:
# Usage..........: CALL aicp510_xmdk(p_site,p_xmdk035,p_xmdk044,p_unpost,p_break)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_xmdk035      多角序號
#                : p_xmdk044      多角流程代碼
#                : p_unpost       是否做過帳還原
#                : p_break        中斷續拋
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/11/10 By stellar
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp510_xmdk(p_site,p_xmdk035,p_xmdk044,p_unpost,p_break)
DEFINE p_site            LIKE xmdk_t.xmdksite
DEFINE p_xmdk035         LIKE xmdk_t.xmdk035
DEFINE p_xmdk044         LIKE xmdk_t.xmdk044
DEFINE p_unpost          LIKE type_t.num5
DEFINE p_break           LIKE type_t.chr1
DEFINE r_success         LIKE type_t.num5
DEFINE l_xmdkdocno       LIKE xmdk_t.xmdkdocno
DEFINE l_xmdkdocdt       LIKE xmdk_t.xmdkdocdt
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001
DEFINE l_xmdk045         LIKE xmdk_t.xmdk045
DEFINE l_xmdk083         LIKE xmdk_t.xmdk083
DEFINE l_icaa003         LIKE icaa_t.icaa003
DEFINE l_icaa004         LIKE icaa_t.icaa004
DEFINE l_icab003_first   LIKE icab_t.icab003
DEFINE l_icab003_last    LIKE icab_t.icab003
DEFINE l_sql             STRING

   LET r_success = TRUE
  
   LET l_icaa003 = ''
   LET l_icaa004 = ''
   SELECT icaa003,icaa004
     INTO l_icaa003,l_icaa004
     FROM icaa_t
    WHERE icaaent = g_enterprise
      AND icaa001 = p_xmdk044

   #中斷續拋視為正拋
   IF p_break = 'Y' THEN
      LET l_icaa004 = '1'
   END IF

   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_xmdk044,"'",
               " ORDER BY icab002"
   PREPARE sel_icab003_first_pre FROM l_sql
   DECLARE sel_icab003_first_cs SCROLL CURSOR FOR sel_icab003_first_pre

   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_xmdk044,"'",
               " ORDER BY icab002 DESC"
   PREPARE sel_icab003_last_pre FROM l_sql
   DECLARE sel_icab003_last_cs SCROLL CURSOR FOR sel_icab003_last_pre

   LET l_icab003_first = ''
   OPEN sel_icab003_first_cs
   FETCH FIRST sel_icab003_first_cs INTO l_icab003_first
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'FETCH:sel_icab003_first_cs'
      LET g_errparam.popup = TRUE

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_icab003_last = ''
   OPEN sel_icab003_last_cs
   FETCH FIRST sel_icab003_last_cs INTO l_icab003_last
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'FETCH:sel_icab003_last_cs'
      LET g_errparam.popup = TRUE

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #正拋初始站，不做處理
   IF l_icaa004 = '1' AND l_icab003_first = p_site THEN
      RETURN r_success
   END IF

   #逆拋最終站，不做處理
   IF l_icaa004 = '2' AND l_icab003_last = p_site THEN
      RETURN r_success
   END IF

   LET l_xmdkdocno = ''
   LET l_xmdkdocdt = ''
   LET l_xmdk045 = ''
   LET l_xmdk083 = ''
   SELECT xmdkdocno,xmdkdocdt,xmdk045,xmdk083
     INTO l_xmdkdocno,l_xmdkdocdt,l_xmdk045,l_xmdk083
     FROM xmdk_t
    WHERE xmdkent = g_enterprise
      AND xmdksite = p_site
      AND xmdk000 = '1'   #出貨單
      AND xmdk035 = p_xmdk035
      AND xmdkstus <> 'X'
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
                  
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
            
   IF cl_null(l_xmdkdocno) THEN
      RETURN r_success
   END IF
   
   UPDATE xmdk_t SET xmdk035 = NULL,
                     xmdk083 = 'N'
    WHERE xmdkent = g_enterprise
      AND xmdkdocno = l_xmdkdocno
   
   LET l_prog = g_prog
   LET l_site = g_site
   LET g_prog = 'axmt540'
   LET g_site = p_site
   
   #過帳還原
   IF p_unpost THEN
      CALL s_axmt540_unpost_chk(l_xmdkdocno) 
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      CALL s_axmt540_unpost_upd(l_xmdkdocno) 
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   END IF
               
   #取消確認
   CALL s_axmt540_unconf_chk(l_xmdkdocno) 
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_axmt540_unconf_upd(l_xmdkdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   
   #2015/03/17 by stellar add ----- (S)
   IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
      #多角單據流水號保持一致='N'時，做作廢處理
      CALL s_axmt540_invalid_chk(l_xmdkdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      CALL s_axmt540_invalid_upd(l_xmdkdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   ELSE
   #2015/03/17 by stellar add ----- (E)      
      #刪除所有資料
      #1.出貨單單頭
      DELETE FROM xmdk_t
       WHERE xmdkent = g_enterprise
         AND xmdkdocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
                     
      #2.出貨單明細
      DELETE FROM xmdl_t
       WHERE xmdlent = g_enterprise
         AND xmdldocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
                  
      #3.多庫儲批明細
      DELETE FROM xmdm_t
       WHERE xmdment = g_enterprise
         AND xmdmdocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #150917-00001#4 151123 earl s
      #製造批序號
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise
         AND inaodocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      #150917-00001#4 151123 earl e
      
      #4.單號處理
      IF NOT s_aooi200_del_docno(l_xmdkdocno,l_xmdkdocdt) THEN
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   
      #稅額xrcd
      CALL s_axmt540_tax_delete(l_xmdkdocno,'','1') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   
      #刪除備註
      CALL s_aooi360_del('6',g_prog,l_xmdkdocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
                  
      #相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_xmdkdocno
      LET g_pk_array[1].column = 'xmdkdocno'
      CALL cl_doc_remove()
   END IF   #2015/03/17 by stellar add
   
   LET g_prog = l_prog
   LET g_site = l_site
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aicp510_success(p_xmdk)
DEFINE p_xmdk            type_g_detail_d
   
   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
   
   LET g_detail3_d[g_success_cnt].xmdkdocno1 = p_xmdk.xmdkdocno
   LET g_detail3_d[g_success_cnt].xmdkdocdt1 = p_xmdk.xmdkdocdt
   LET g_detail3_d[g_success_cnt].xmdk0071 = p_xmdk.xmdk007
   LET g_detail3_d[g_success_cnt].xmdk0031 = p_xmdk.xmdk003
   LET g_detail3_d[g_success_cnt].xmdk0041 = p_xmdk.xmdk004
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdk0071)
        RETURNING g_detail3_d[g_success_cnt].xmdk0071_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmdk0031)
        RETURNING g_detail3_d[g_success_cnt].xmdk0031_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmdk0041)
        RETURNING g_detail3_d[g_success_cnt].xmdk0041_desc
   
   LET g_success_cnt = g_success_cnt +  1
   
END FUNCTION

PRIVATE FUNCTION aicp510_fail(p_xmdk,p_xmdksite)
DEFINE p_xmdk            type_g_detail_d
DEFINE p_xmdksite        LIKE xmdk_t.xmdksite
DEFINE l_errcode         LIKE gzze_t.gzze001
DEFINE l_i               LIKE type_t.num5

   IF g_bgjob = 'N' THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
          LET g_detail4_d[l_i].xmdkdocno2 = p_xmdk.xmdkdocno
          LET g_detail4_d[l_i].xmdkdocdt2 = p_xmdk.xmdkdocdt
          LET g_detail4_d[l_i].xmdk0072 = p_xmdk.xmdk007
          LET g_detail4_d[l_i].xmdk0032 = p_xmdk.xmdk003
          LET g_detail4_d[l_i].xmdk0042 = p_xmdk.xmdk004
          LET g_detail4_d[l_i].xmdkownid2 = p_xmdk.xmdkownid
          LET g_detail4_d[l_i].xmdkcrtid2 = p_xmdk.xmdkcrtid
          LET g_detail4_d[l_i].xmdk0352 = p_xmdk.xmdk035
          LET g_detail4_d[l_i].xmdksite2 = p_xmdksite
         
         #錯誤訊息
         LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
         
         #說明
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdk0072)
              RETURNING g_detail4_d[l_i].xmdk0072_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdk0032)
              RETURNING g_detail4_d[l_i].xmdk0032_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdk0042)
              RETURNING g_detail4_d[l_i].xmdk0042_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdkownid2)
              RETURNING g_detail4_d[l_i].xmdkownid2_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdkcrtid2)
              RETURNING g_detail4_d[l_i].xmdkcrtid2_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdksite2)
              RETURNING g_detail4_d[l_i].xmdksite2_desc
              
      END FOR
      
      LET g_fail_cnt = g_errcollect.getLength()
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 抓取該站的入庫單，過帳還原、取消確認並刪除所有資料
# Memo...........:
# Usage..........: CALL aicp510_pmds(p_site,p_pmds041)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_pmds041      多角序號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/11/13 By stellar
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp510_pmds(p_site,p_pmds041)
DEFINE p_site            LIKE pmds_t.pmdssite
DEFINE p_pmds041         LIKE pmds_t.pmds041
DEFINE r_success         LIKE type_t.num5
DEFINE l_pmdsdocno       LIKE pmds_t.pmdsdocno
DEFINE l_pmdsdocdt       LIKE pmds_t.pmdsdocdt
DEFINE l_pmds000         LIKE pmds_t.pmds000
DEFINE l_pmds050         LIKE pmds_t.pmds050
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001
DEFINE l_argv1           LIKE type_t.chr10

   LET r_success = TRUE
   
   LET l_pmdsdocno = ''
   LET l_pmdsdocdt = ''
   LET l_pmds000 = ''
   LET l_pmds050 = ''
   SELECT pmdsdocno,pmdsdocdt,pmds000
     INTO l_pmdsdocno,l_pmdsdocdt,l_pmds000
     FROM pmds_t
    WHERE pmdsent = g_enterprise
      AND pmdssite = p_site
      AND pmds000 IN ('3','20','6','12')   #3採購收貨入庫單,20委外採購收貨入庫,6採購入庫,12委外採購入庫
      AND pmds041 = p_pmds041
      AND pmdsstus <> 'X'   #2015/03/17 by stellar add
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
                  
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(l_pmdsdocno) THEN
      RETURN r_success
   END IF
   
   UPDATE pmds_t SET pmds041 = NULL,
                     pmds050 = 'N'
    WHERE pmdsent = g_enterprise
      AND pmdsdocno = l_pmdsdocno
   
   LET l_prog = g_prog
   LET l_argv1 = g_argv[1]
   LET l_site = g_site
   LET g_site = p_site
   
   CASE l_pmds000
      WHEN '3'   #採購收貨入庫單維護作業
         LET g_prog = 'apmt530'
         LET g_argv[1] = '3'
      WHEN '20'  #委外採購收貨入庫單維護作業
         LET g_prog = 'apmt531'
         LET g_argv[1] = '20'
      WHEN '12'  #委外採購入庫作業
         LET g_prog = 'apmt571'
         LET g_argv[1] = '12'
      OTHERWISE  #採購入庫維護作業
         LET g_prog = 'apmt570'
         LET g_argv[1] = '6'
   END CASE
   
   #過帳還原
   CALL s_apmt520_unposted_chk(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_apmt520_unposted_upd(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   
   #取消確認
   CALL s_apmt520_unconf_chk(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_apmt520_unconf_upd(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   
   #2015/03/17 by stellar add ----- (S)
   IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
      #多角單據流水號保持一致='N'時，做作廢處理
      CALL s_apmt520_invalid_chk(l_pmdsdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      CALL s_apmt520_invalid_upd(l_pmdsdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
   ELSE
   #2015/03/17 by stellar add ----- (E)
      #刪除所有資料
      #1.入庫單單頭
      DELETE FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
         
      #2.入庫單明細
      DELETE FROM pmdt_t
       WHERE pmdtent = g_enterprise
         AND pmdtdocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
         
      #3.多庫儲批明細
      DELETE FROM pmdu_t
       WHERE pmduent = g_enterprise
         AND pmdudocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #150917-00001#4 151123 earl s
      #製造批序號
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise
         AND inaodocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      #150917-00001#4 151123 earl e
      
      #需求分配明細
      DELETE FROM pmdv_t
       WHERE pmdvent = g_enterprise
         AND pmdvdocno = l_pmdsdocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #4.單號處理
      IF NOT s_aooi200_del_docno(l_pmdsdocno,l_pmdsdocdt) THEN
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF

      #稅額xrcd
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_pmdsdocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF

      #刪除備註
      CALL s_aooi360_del('6',g_prog,l_pmdsdocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
                     
      #相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_pmdsdocno
      LET g_pk_array[1].column = 'pmdsdocno'
      CALL cl_doc_remove()
   END IF   #2015/03/17 by stellar add
   
   LET g_prog = l_prog
   LET g_argv[1] = l_argv1
   LET g_site = l_site
   
   RETURN r_success
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp510_sel()
   #設定出貨單限制條件
  #LET g_aicp510_sel = " xmdkent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp510_sel = " xmdkent = ",g_enterprise,cl_sql_add_filter("xmdk_t"),     #161231-00013#1 add 
                       " AND xmdksite = '",g_site,"'",
                       " AND xmdk044 IS NOT NULL",      #多角序號
                       " AND xmdk083 = 'Y'",            #多角貿易已拋轉
                       " AND xmdk035 IS NOT NULL ",     #多角序號
                       " AND xmdk045 IN ('2','7')",
                       " AND ((xmdk000 = '1' AND xmdk002 <> '3' AND xmdkstus = 'S') OR",
                       "      (xmdk000 = '4' AND xmdk002 = '3' AND xmdkstus = 'Y' ))",
                       
                       #多角流程代碼為"1:销售、2:代采购"
                       " AND EXISTS (SELECT 1 ",
                       "               FROM icaa_t",
                       "              WHERE icaaent = ",g_enterprise,
                       "                AND icaa001 = xmdk044",
                       "                AND (icaa003 = '1' OR icaa003 = '2'))",
                       
                       #正拋初始站
                       " AND (EXISTS (SELECT 1 ",
                       "                FROM icaa_t,icab_t",
                       "               WHERE icaaent = icabent AND icabent = ",g_enterprise,
                       "                 AND icaa001 = icab001 AND icab001 = xmdk044",
                       "                 AND icaa004 = '1'",
                       "                 AND icab002 = 0",
                       "                 AND icab003 = '",g_site,"')",
                       
                       #150917-00001#3  2016/01/19 By earl mod s
                       #簽收量為0的出貨單(代表初始站無續拋)
                       "      OR (SELECT SUM(xmdl035) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0)",
                       
#                       #過濾已存在正向的出貨單(排除中斷)
#                       #過濾已存在正向的收貨入庫單(排除中斷)
#                       "      OR NOT xmdk035 IN (SELECT xmdk035",
#                       "                           FROM xmdk_t",
#                       "                          WHERE xmdkent = ",g_enterprise,
#                       "                            AND xmdk045 <> '5'",   #排除中間交易
#                       "                            AND xmdk035 IS NOT NULL",
#                       "                            AND xmdkstus <> 'X'",
#                       "                            AND xmdksite <> '",g_site,"'",
#                       "                            AND xmdksite = (SELECT icab003 FROM icab_t",
#                       "                                             WHERE icabent = ",g_enterprise,
#                       "                                               AND icab001 = xmdk044",
#                       "                                               AND icab002 = 0)",
#                       "                          UNION",
#                       "                         SELECT pmds041",
#                       "                           FROM pmds_t",
#                       "                          WHERE pmdsent = ",g_enterprise,
#                       "                            AND pmds014 <> '6'",   #排除中間交易
#                       "                            AND pmds041 IS NOT NULL",
#                       "                            AND pmdsstus <> 'X'",
#                       "                            AND pmdssite <> '",g_site,"'",
#                       "                            AND pmdssite = (SELECT icab003 FROM icab_t",
#                       "                                             WHERE icabent = ",g_enterprise,
#                       "                                               AND icab001 = pmds053",
#                       "                                               AND icab002 = 0)))",
                       #150917-00001#3  2016/01/19 By earl mod e

                       #" AND NOT EXISTS (SELECT xrcb002 FROM xrcb_t WHERE xrcbent = xmdkent AND xrcb002 = xmdkdocno) "
                       " AND (SELECT SUM(xmdl038) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0",  #主帳套已立帳量
                       " AND (SELECT SUM(xmdl039) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0",  #帳套二已立帳量
                       " AND (SELECT SUM(xmdl040) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0",  #帳套三已立帳量
                       " AND (SELECT SUM(xmdl053) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0",  #主帳套暫估數量
                       " AND (SELECT SUM(xmdl054) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0",  #帳套二暫估數量
                       " AND (SELECT SUM(xmdl055) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0",  #帳套三暫估數量
                       " AND (SELECT SUM(xmdl047) FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno) = 0"   #已開發票數量
END FUNCTION

#end add-point
 
{</section>}
 
