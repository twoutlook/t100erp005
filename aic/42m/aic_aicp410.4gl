#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-05-29 18:12:04), PR版次:0008(2017-02-15 17:51:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000071
#+ Filename...: aicp410
#+ Description: 多角貿易收貨入庫單拋轉還原作業
#+ Creator....: 01588(2014-11-05 11:24:12)
#+ Modifier...: 04543 -SD/PR- 08171
 
{</section>}
 
{<section id="aicp410.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150917-00001#3  2016/01/19 By earl         多角中斷調整為可拆單功能
#161231-00013#1  2016/01/11 By 08992   增加azzi850 部門權限控管
#170120-00028#1  2017/01/22 By wuxja   SQL抓取SUM值时加上NVL判断，防止空的情况
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
        pmdsdocno        LIKE pmds_t.pmdsdocno,   #入庫單號
        pmdsdocdt        LIKE pmds_t.pmdsdocdt,   #入庫日期
        pmds007          LIKE pmds_t.pmds007,     #供應商編號
        pmds007_desc     LIKE type_t.chr500,      #供應商名稱
        pmds009          LIKE pmds_t.pmds009,     #送貨供應商
        pmds009_desc     LIKE type_t.chr500,      #送貨供應商名稱
        pmds008          LIKE pmds_t.pmds008,     #帳款供應商
        pmds008_desc     LIKE type_t.chr500,      #帳款供應商名稱
        pmds002          LIKE pmds_t.pmds002,     #申請人員
        pmds002_desc     LIKE type_t.chr500,      #姓名
        pmds003          LIKE pmds_t.pmds003,     #申請部門
        pmds003_desc     LIKE type_t.chr500,      #說明
        pmdsownid        LIKE pmds_t.pmdsownid,   #資料所有者
        pmdsownid_desc   LIKE type_t.chr500,      #姓名
        pmdscrtid        LIKE pmds_t.pmdscrtid,   #資料建立者
        pmdscrtid_desc   LIKE type_t.chr500,      #姓名
        pmds011          LIKE pmds_t.pmds011,     #採購性質
        pmds014          LIKE pmds_t.pmds014,     #多角性質
        pmds053          LIKE pmds_t.pmds053,     #多角流程代碼
        pmds053_desc     LIKE type_t.chr500,      #多角流程代碼說明
        break            LIKE type_t.chr1,        #中斷續拋
        pmdl052          LIKE pmdl_t.pmdl052,     #最終供應商
        pmdl052_desc     LIKE type_t.chr500,      #最終供應商名稱
        pmds041          LIKE pmds_t.pmds041      #多角序號
                         END RECORD

#入庫明細
TYPE type_g_detail2_d    RECORD
        pmdtseq          LIKE pmdt_t.pmdtseq,     #項次
        pmdt001          LIKE pmdt_t.pmdt001,     #採購單號
        pmdt002          LIKE pmdt_t.pmdt002,     #採購單項次
        pmdn027          LIKE pmdn_t.pmdn027,     #供應商料號
        pmdt006          LIKE pmdt_t.pmdt006,     #料件編號
        pmdt006_desc     LIKE type_t.chr500,      #品名
        pmdt006_desc_1   LIKE type_t.chr500,      #規格
        pmdt007          LIKE pmdt_t.pmdt007,     #產品特徵
        pmdt007_desc     LIKE type_t.chr500,      #特徵值說明
        pmdt020          LIKE pmdt_t.pmdt020,     #數量
        pmdt036          LIKE pmdt_t.pmdt036,     #單價
        pmdt038          LIKE pmdt_t.pmdt038,     #未稅金額
        pmdt039          LIKE pmdt_t.pmdt039      #含稅金額
                         END RECORD
DEFINE g_detail2_cnt     LIKE type_t.num5
DEFINE g_detail2_d       DYNAMIC ARRAY OF type_g_detail2_d

#執行成功
TYPE type_g_detail3_d    RECORD
        pmdsdocno1       LIKE pmds_t.pmdsdocno,   #入庫單號
        pmdsdocdt1       LIKE pmds_t.pmdsdocdt,   #入庫日期
        pmds0071         LIKE pmds_t.pmds007,     #供應商編號
        pmds0071_desc    LIKE type_t.chr500,      #供應商名稱
        pmds0021         LIKE pmds_t.pmds002,     #申請人員
        pmds0021_desc    LIKE type_t.chr500,      #姓名
        pmds0031         LIKE pmds_t.pmds003,     #申請部門
        pmds0031_desc    LIKE type_t.chr500       #說明
                         END RECORD
DEFINE g_detail3_cnt     LIKE type_t.num5
DEFINE g_detail3_d       DYNAMIC ARRAY OF type_g_detail3_d

#執行失敗
TYPE type_g_detail4_d    RECORD
        pmdsdocno2       LIKE pmds_t.pmdsdocno,   #入庫單號
        pmdsdocdt2       LIKE pmds_t.pmdsdocdt,   #入庫日期
        pmds0072         LIKE pmds_t.pmds007,     #供應商編號
        pmds0072_desc    LIKE type_t.chr500,      #供應商名稱
        pmds0022         LIKE pmds_t.pmds002,     #申請人員
        pmds0022_desc    LIKE type_t.chr500,      #姓名
        pmds0032         LIKE pmds_t.pmds003,     #申請部門
        pmds0032_desc    LIKE type_t.chr500,      #說明
        pmdsownid2       LIKE pmds_t.pmdsownid,   #資料所有者
        pmdsownid2_desc  LIKE type_t.chr500,      #姓名
        pmdscrtid2       LIKE pmds_t.pmdscrtid,   #資料建立者
        pmdscrtid2_desc  LIKE type_t.chr500,      #姓名
        pmds0412         LIKE pmds_t.pmds041,     #多角序號
        pmdssite2        LIKE pmds_t.pmdssite,    #營運據點
        pmdssite2_desc   LIKE type_t.chr500,      #營運據點名稱
        reason           LIKE type_t.chr1000       #失敗原因
                         END RECORD
DEFINE g_detail4_cnt     LIKE type_t.num5
DEFINE g_detail4_d       DYNAMIC ARRAY OF type_g_detail4_d

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

DEFINE g_aicp410_sel     STRING           #符合之SQL條件

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp410.main" >}
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
   IF NOT aicp410_create_temp_table() THEN
      CALL cl_ap_exitprogram("0")
      #dorislai-20150914-modify----(S)
#      EXIT PROGRAM
      CALL cl_ap_exitprogram("1")
      #dorislai-20150914-modify----(E)
   END IF
   
   CALL aicp410_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " pmdsdocno = '",g_argv[1],"' "
         CALL aicp410_query()
         UPDATE aicp410_tmp 
            SET sel = 'Y'
         CALL aicp410_process() 
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp410 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp410_init()   
 
      #進入選單 Menu (="N")
      CALL aicp410_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp410
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aicp410_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp410.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp410_init()
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
   
   CALL cl_set_combo_scc('b_pmds011','2061')
   CALL cl_set_combo_scc('b_pmds014','2053')
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp410.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp410_ui_dialog()
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
         CALL aicp410_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdsdocno,pmdsdocdt,pmds007,pmds002,pmds003,
                                   pmdsownid,pmdscrtid,pmds041
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "('3','20','6','12')"
               LET g_qryparam.where = g_aicp410_sel
               
               CALL q_pmdsdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsdocno  #顯示到畫面上
               NEXT FIELD pmdsdocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD pmds007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_pmaa001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds007  #顯示到畫面上
               NEXT FIELD pmds007                     #返回原欄位
   
            ON ACTION controlp INFIELD pmds002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds002  #顯示到畫面上
               NEXT FIELD pmds002                     #返回原欄位
               
            ON ACTION controlp INFIELD pmds003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds003  #顯示到畫面上
               NEXT FIELD pmds003                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdsownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsownid  #顯示到畫面上
               NEXT FIELD pmdsownid                     #返回原欄位
   
            ON ACTION controlp INFIELD pmdscrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdscrtid  #顯示到畫面上
               NEXT FIELD pmdscrtid                     #返回原欄位
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
               CALL aicp410_fetch()
               
            ON ROW CHANGE
               UPDATE aicp410_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno
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
            
            CALL aicp410_sel()
            
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
            UPDATE aicp410_tmp 
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
            UPDATE aicp410_tmp 
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
                  UPDATE aicp410_tmp 
                     SET sel = 'Y' 
                    WHERE pmdsdocno = g_detail_d[li_idx].pmdsdocno
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
                  UPDATE aicp410_tmp 
                     SET sel = 'N' 
                    WHERE pmdsdocno = g_detail_d[li_idx].pmdsdocno
               END IF
            END FOR  
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp410_filter()
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
            CALL aicp410_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp410_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp410_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno
            END IF
            #-----
            
            #判斷是否有至少選擇一筆資料做處理
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp410_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               
               CALL cl_err()
            ELSE
               CALL aicp410_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp410_query()
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
 
{<section id="aicp410.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp410_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM aicp410_tmp;
   LET g_sql = "SELECT DISTINCT 'N',pmdsent,pmdsdocno,pmdsdocdt,",
               "                pmds007,pmds009,pmds008,",
               "                pmds002,pmds003, ",
               "                pmdsownid,pmdscrtid,",
               "                pmds011,pmds014,pmds053,'',pmds041,",
               "          CASE pmdssite",
               "          WHEN (SELECT b.icab003 ",
               "                  FROM icaa_t a,icab_t b",
               "                 WHERE a.icaaent = b.icabent AND b.icabent = ",g_enterprise,
               "                   AND a.icaa001 = b.icab001 AND b.icab001 = pmds053",
               "                   AND a.icaa004 = '2'",
               "                   AND b.icab002 = 0) THEN 'Y'",
               "          ELSE 'N'",
               "          END",
               "  FROM pmds_t ",
               " WHERE ",g_aicp410_sel,
               "   AND ",g_wc CLIPPED
   LET g_sql = "INSERT INTO aicp410_tmp ",g_sql CLIPPED
   
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp410_b_fill()
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
 
{<section id="aicp410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp410_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_pmdldocno     LIKE pmdl_t.pmdldocno
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT 'N',pmdsdocno,pmdsdocdt,",
               "                pmds007,b1.pmaal004,",
               "                pmds009,b2.pmaal004,",
               "                pmds008,b3.pmaal004,",
               "                pmds002,a1.ooag011, ",
               "                pmds003,ooefl003,",
               "                pmdsownid,a2.ooag011,",
               "                pmdscrtid,a3.ooag011,",
               "                pmds011,pmds014,",
               "                pmds053,icaal003,",
               "                break,",
               "                pmdl052,b4.pmaal004,",
               "                pmds041 ",
               "  FROM aicp410_tmp ",
               "       LEFT OUTER JOIN pmaal_t b1 ON b1.pmaalent = '",g_enterprise,"' AND b1.pmaal001 = pmds007 AND b1.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t b2 ON b2.pmaalent = '",g_enterprise,"' AND b2.pmaal001 = pmds009 AND b2.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t b3 ON b3.pmaalent = '",g_enterprise,"' AND b3.pmaal001 = pmds008 AND b3.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t b4 ON b4.pmaalent = '",g_enterprise,"' AND b4.pmaal001 = pmdl052 AND b4.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN ooag_t a1 ON a1.ooagent = '",g_enterprise,"' AND a1.ooag001 = pmds002 ",
               "       LEFT OUTER JOIN ooag_t a2 ON a2.ooagent = '",g_enterprise,"' AND a2.ooag001 = pmdsownid ",
               "       LEFT OUTER JOIN ooag_t a3 ON a3.ooagent = '",g_enterprise,"' AND a3.ooag001 = pmdscrtid ",
               "       LEFT OUTER JOIN ooefl_t ON ooeflent = '",g_enterprise,"' AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN icaal_t ON icaalent = '",g_enterprise,"' AND icaal001 = pmds053 AND icaal002 = '",g_dlang,"' ",
               " WHERE pmdsent = ? ",
               "   AND ",g_wc_filter,
               " ORDER BY pmdsdocno "
   #end add-point
 
   PREPARE aicp410_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp410_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()
   
   #採購單號
   LET g_sql = "SELECT pmdt001 FROM pmdt_t ",
               " WHERE pmdtent = ",g_enterprise,
               "   AND pmdtdocno = ? "
   PREPARE sel_pmdt001_pre FROM g_sql
   DECLARE sel_pmdt001_cs SCROLL CURSOR FOR sel_pmdt001_pre
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].pmdsdocno,g_detail_d[l_ac].pmdsdocdt,
      g_detail_d[l_ac].pmds007,g_detail_d[l_ac].pmds007_desc,
      g_detail_d[l_ac].pmds009,g_detail_d[l_ac].pmds009_desc,
      g_detail_d[l_ac].pmds008,g_detail_d[l_ac].pmds008_desc,
      g_detail_d[l_ac].pmds002,g_detail_d[l_ac].pmds002_desc,
      g_detail_d[l_ac].pmds003,g_detail_d[l_ac].pmds003_desc,
      g_detail_d[l_ac].pmdsownid,g_detail_d[l_ac].pmdsownid_desc,
      g_detail_d[l_ac].pmdscrtid,g_detail_d[l_ac].pmdscrtid_desc,
      g_detail_d[l_ac].pmds011,g_detail_d[l_ac].pmds014,
      g_detail_d[l_ac].pmds053,g_detail_d[l_ac].pmds053_desc,
      g_detail_d[l_ac].break,
      g_detail_d[l_ac].pmdl052,g_detail_d[l_ac].pmdl052_desc,
      g_detail_d[l_ac].pmds041
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


      #抓單身第一筆採購單號
      OPEN sel_pmdt001_cs USING g_detail_d[l_ac].pmdsdocno
      FETCH FIRST sel_pmdt001_cs INTO l_pmdldocno
      CLOSE sel_pmdt001_cs

      #用來源單號抓取採購單資料
      SELECT pmdl052,pmaal004
        INTO g_detail_d[l_ac].pmdl052,g_detail_d[l_ac].pmdl052_desc
        FROM pmdl_t LEFT OUTER JOIN pmaal_t ON pmaalent = pmdlent AND pmaal001 = pmdl052 AND pmaal002 = g_dlang
       WHERE pmdlent = g_enterprise
         AND pmdldocno = l_pmdldocno

      UPDATE aicp410_tmp SET pmdl052 = g_detail_d[l_ac].pmdl052
       WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno

      #end add-point
      
      CALL aicp410_detail_show()      
 
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
   FREE aicp410_sel
   
   LET l_ac = 1
   CALL aicp410_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp410.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp410_fetch()
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
   LET g_sql = "SELECT pmdtseq,pmdt001,pmdt002,'',pmdt006,imaal003,imaal004, ",
               "       pmdt007,'',pmdt020,pmdt036,pmdt038,pmdt039 ",
               "  FROM pmdt_t ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"' ",
               " WHERE pmdtent = '",g_enterprise,"'",
               "   AND pmdtdocno = '",g_detail_d[g_master_idx].pmdsdocno,"' ",
               " ORDER BY pmdtseq "
   PREPARE pmdt_fill_pre FROM g_sql
   DECLARE pmdt_fill_cur CURSOR FOR pmdt_fill_pre
   
   FOREACH pmdt_fill_cur INTO 
      g_detail2_d[l_ac].pmdtseq,g_detail2_d[l_ac].pmdt001,g_detail2_d[l_ac].pmdt002,
      g_detail2_d[l_ac].pmdn027,g_detail2_d[l_ac].pmdt006,g_detail2_d[l_ac].pmdt006_desc,
      g_detail2_d[l_ac].pmdt006_desc_1,g_detail2_d[l_ac].pmdt007,g_detail2_d[l_ac].pmdt007_desc,
      g_detail2_d[l_ac].pmdt020,g_detail2_d[l_ac].pmdt036,g_detail2_d[l_ac].pmdt038,
      g_detail2_d[l_ac].pmdt039
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH pmdt:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #供應商料號
      SELECT pmdn027 
        INTO g_detail2_d[l_ac].pmdn027
        FROM pmdn_t
       WHERE pmdnent = g_enterprise
         AND pmdndocno = g_detail2_d[l_ac].pmdt001
         AND pmdnseq = g_detail2_d[l_ac].pmdt002
         
      #產品特徵的說明
      CALL s_feature_description(g_detail2_d[l_ac].pmdt006,g_detail2_d[l_ac].pmdt007)
           RETURNING l_success,g_detail2_d[l_ac].pmdt007_desc 
           
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = '9035'
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
 
{<section id="aicp410.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp410_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp410.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp410_filter()
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
   
   CONSTRUCT g_wc_filter ON pmdsdocno,pmdsdocdt,
                            pmds007,pmds009,pmds008,
                            pmds002,pmds003,
                            pmdsownid,pmdscrtid,
                            pmds011,pmds014,pmds053,
                            pmds041
        FROM s_detail1[1].b_pmdsdocno,s_detail1[1].b_pmdsdocdt,
             s_detail1[1].b_pmds007,s_detail1[1].b_pmds009,s_detail1[1].b_pmds008,
             s_detail1[1].b_pmds002,s_detail1[1].b_pmds003,
             s_detail1[1].b_pmdsownid,s_detail1[1].b_pmdscrtid,
             s_detail1[1].b_pmds011,s_detail1[1].b_pmds014,s_detail1[1].b_pmds053,
             s_detail1[1].b_pmds041
           
      BEFORE CONSTRUCT
      
       ON ACTION controlp INFIELD b_pmdsdocno
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.arg1 = "('3','20','6','12')"
          LET g_qryparam.where = g_aicp410_sel
          
          CALL q_pmdsdocno()                         #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmdsdocno  #顯示到畫面上
          NEXT FIELD b_pmdsdocno                     #返回原欄位    
               
       ON ACTION controlp INFIELD b_pmds007
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_pmaa001_3()                       #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmds007  #顯示到畫面上
          NEXT FIELD b_pmds007                     #返回原欄位

       ON ACTION controlp INFIELD b_pmds009
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_pmaa001_3()                       #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmds009  #顯示到畫面上
          NEXT FIELD b_pmds009                     #返回原欄位

       ON ACTION controlp INFIELD b_pmds008
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_pmaa001_3()                       #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmds008  #顯示到畫面上
          NEXT FIELD b_pmds008                     #返回原欄位

       ON ACTION controlp INFIELD b_pmds002
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooag001()                         #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmds002  #顯示到畫面上
          NEXT FIELD b_pmds002                     #返回原欄位
               
       ON ACTION controlp INFIELD b_pmds003
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooeg001()                         #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmds003  #顯示到畫面上
          NEXT FIELD b_pmds003                     #返回原欄位
               
       ON ACTION controlp INFIELD b_pmdsownid
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooag001()                           #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmdsownid  #顯示到畫面上
          NEXT FIELD b_pmdsownid                     #返回原欄位
   
       ON ACTION controlp INFIELD b_pmdscrtid
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          
          CALL q_ooag001()                           #呼叫開窗
          DISPLAY g_qryparam.return1 TO b_pmdscrtid  #顯示到畫面上
          NEXT FIELD b_pmdscrtid                     #返回原欄位
          
       ON ACTION controlp INFIELD b_pmds053
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          CALL q_icaa001()
          DISPLAY g_qryparam.return1 TO b_pmds053
          NEXT FIELD b_pmds053
          
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp410_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp410.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp410_filter_parser(ps_field)
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
 
{<section id="aicp410.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp410_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp410.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL aicp410_create_temp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/11/10 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp410_create_temp_table()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE aicp410_tmp;
   CREATE TEMP TABLE aicp410_tmp( 
      sel             VARCHAR(1),
      pmdsent         SMALLINT,
      pmdsdocno       VARCHAR(20),
      pmdsdocdt       DATE,
      pmds007         VARCHAR(10),
      pmds009         VARCHAR(10),
      pmds008         VARCHAR(10),
      pmds002         VARCHAR(20),
      pmds003         VARCHAR(10),
      pmdsownid       VARCHAR(20),
      pmdscrtid       VARCHAR(20),
      pmds011         VARCHAR(10),
      pmds014         VARCHAR(10),
      pmds053         VARCHAR(10),
      pmdl052         VARCHAR(10),
      pmds041         VARCHAR(20),
      break           VARCHAR(1)
      )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create aicp410_tmp'
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
# Usage..........: CALL aicp410_process()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/11/10 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp410_process()
DEFINE l_pmds            type_g_detail_d
DEFINE l_success         LIKE type_t.num5
DEFINE l_icab_now     RECORD
          icab002        LIKE icab_t.icab002,   #站別
          icab003        LIKE icab_t.icab003,   #營運據點
          icab004        LIKE icab_t.icab004,   #委外工單開立點
          icab005        LIKE icab_t.icab005,   #中斷點否
          icab008        LIKE icab_t.icab008    #實體庫存否
                      END RECORD
DEFINE l_pmds000         LIKE pmds_t.pmds000
DEFINE l_pmdt087         LIKE pmdt_t.pmdt087

   #有選擇的入庫單
   LET g_sql = "SELECT pmdsdocno,pmdsdocdt,",
               "       pmds007,pmds009,pmds008,",
               "       pmds002,pmds003, ",
               "       pmdsownid,pmdscrtid,",
               "       pmds011,pmds014,pmds053,",
               "       break,pmdl052,pmds041 ",
               "  FROM aicp410_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY pmdsdocno "
   PREPARE aicp410_process_pre FROM g_sql
   DECLARE aicp410_process_cur CURSOR WITH HOLD FOR aicp410_process_pre
   
   #該流程多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003,icab004,",
               "       icab005,icab008",
               "  FROM icab_t",
               " WHERE icabent = ?",
               "   AND icab001 = ?",
               " ORDER BY icab002"
   PREPARE aicp410_process_icab_pre FROM g_sql
   DECLARE aicp410_process_icab_cur CURSOR FOR aicp410_process_icab_pre
   
   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化
   
   FOREACH aicp410_process_cur INTO l_pmds.pmdsdocno,l_pmds.pmdsdocdt,
                                    l_pmds.pmds007,l_pmds.pmds009,l_pmds.pmds008,
                                    l_pmds.pmds002,l_pmds.pmds003,
                                    l_pmds.pmdsownid,l_pmds.pmdscrtid,
                                    l_pmds.pmds011,l_pmds.pmds014,l_pmds.pmds053,
                                    l_pmds.break,l_pmds.pmdl052,l_pmds.pmds041
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         #失敗記錄
         CALL aicp410_fail(l_pmds.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      
      #多角序號為空白時，錯誤
      IF cl_null(l_pmds.pmds041) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code = 'aic-00099'   #該筆資料之多角序號為空！
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp410_fail(l_pmds.*,'')
         CONTINUE FOREACH
      END IF
      
      #單據性質、多角性質、多角流程代碼
      LET l_pmds000 = ''
      SELECT pmds000
        INTO l_pmds000
        FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_pmds.pmdsdocno
         
      IF l_pmds.pmds014 <> '4' THEN
      #採購多角性質非"統購統付"
      
         #多角流程代碼為空白時，錯誤
         IF cl_null(l_pmds.pmds053) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aic-00026'   #多角流程代碼不可為空
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp410_fail(l_pmds.*,'')
            CONTINUE FOREACH
         END IF
      
         #跑站(當站)
         OPEN aicp410_process_icab_cur USING g_enterprise,l_pmds.pmds053
         FOREACH aicp410_process_icab_cur INTO l_icab_now.icab002,l_icab_now.icab003,l_icab_now.icab004,
                                               l_icab_now.icab005,l_icab_now.icab008
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
                  
               CALL cl_err()
               LET l_success = FALSE
               #失敗記錄
               CALL aicp410_fail(l_pmds.*,'')
               EXIT FOREACH
            END IF
               
            #用多角序號抓取該站的出貨單，並做處理
            CALL aicp410_xmdk(l_icab_now.icab003,l_pmds.pmds041)
                 RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
            
            #150917-00001#3  2016/01/19 By earl mark s
#            #中斷續拋，中斷點且實體庫存，只處理到出貨單
#            IF l_pmds.break = 'Y' AND l_icab_now.icab005 = 'Y' AND l_icab_now.icab008 = 'Y' THEN
#               EXIT FOREACH
#            END IF
            #150917-00001#3  2016/01/19 By earl mark e
            
            #用多角序號抓取該站的入庫單，並做處理
            CALL aicp410_pmds(l_icab_now.icab003,l_pmds.pmds041,l_pmds.pmds053,1,l_pmds.break)
                 RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
            
            #150917-00001#3  2016/01/19 By earl mark s
#            #中斷續拋，中斷點且無實體庫存，處理到出貨單、入庫單
#            IF l_pmds.break = 'Y' AND l_icab_now.icab005 = 'Y' THEN
#               EXIT FOREACH
#            END IF
            #150917-00001#3  2016/01/19 By earl mark s
            
         END FOREACH
      END IF
           
      #更新"多角貿易拋轉否"='N'及清空"多角流程序號"
      IF l_success THEN
         #150917-00001#3  2016/01/19 By earl mod s
#         #中斷續拋
#         IF l_pmds.break = 'Y' THEN
#            UPDATE pmds_t SET pmds050 = 'N'
#             WHERE pmdsent = g_enterprise
#               AND pmdsdocno = l_pmds.pmdsdocno
#         ELSE
            UPDATE pmds_t SET pmds041 = NULL,
                              pmds050 = 'N'
             WHERE pmdsent = g_enterprise
               AND pmdsdocno = l_pmds.pmdsdocno
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
            CALL aicp410_fail(l_pmds.*,'')
         END IF
                  
      END IF
      
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_pmds.pmds041,'4')
              RETURNING l_success
      END IF
      
      IF g_bgjob = 'N' THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            #成功記錄
            CALL aicp410_success(l_pmds.*)
         ELSE
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp410_fail(l_pmds.*,l_icab_now.icab003)
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
# Usage..........: CALL aicp410_xmdk(p_site,p_xmdk035)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_xmdk035      多角序號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/11/10 By stellar
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp410_xmdk(p_site,p_xmdk035)
DEFINE p_site            LIKE xmdk_t.xmdksite
DEFINE p_xmdk035         LIKE xmdk_t.xmdk035
DEFINE r_success         LIKE type_t.num5
DEFINE l_xmdkdocno       LIKE xmdk_t.xmdkdocno
DEFINE l_xmdkdocdt       LIKE xmdk_t.xmdkdocdt
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001

   LET r_success = TRUE
   
   LET l_xmdkdocno = ''
   LET l_xmdkdocdt = ''
   SELECT xmdkdocno,xmdkdocdt INTO l_xmdkdocno,l_xmdkdocdt
     FROM xmdk_t
    WHERE xmdkent = g_enterprise
      AND xmdksite = p_site
      AND xmdk000 = '1'   #出貨單
      AND xmdk035 = p_xmdk035
      AND xmdkstus <> 'X'   #2015/03/17 by stellar add
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

PRIVATE FUNCTION aicp410_success(p_pmds)
DEFINE p_pmds            type_g_detail_d
   
   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
   
   LET g_detail3_d[g_success_cnt].pmdsdocno1 = p_pmds.pmdsdocno
   LET g_detail3_d[g_success_cnt].pmdsdocdt1 = p_pmds.pmdsdocdt
   LET g_detail3_d[g_success_cnt].pmds0071 = p_pmds.pmds007
   LET g_detail3_d[g_success_cnt].pmds0021 = p_pmds.pmds002
   LET g_detail3_d[g_success_cnt].pmds0031 = p_pmds.pmds003
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].pmds0071)
        RETURNING g_detail3_d[g_success_cnt].pmds0071_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].pmds0021)
        RETURNING g_detail3_d[g_success_cnt].pmds0021_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].pmds0031)
        RETURNING g_detail3_d[g_success_cnt].pmds0031_desc
   
   LET g_success_cnt = g_success_cnt +  1
   
END FUNCTION

PRIVATE FUNCTION aicp410_fail(p_pmds,p_pmdssite)
DEFINE p_pmds            type_g_detail_d
DEFINE p_pmdssite        LIKE pmds_t.pmdssite
DEFINE l_errcode         LIKE gzze_t.gzze001
DEFINE l_i               LIKE type_t.num5

   IF g_bgjob = 'N' THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
          LET g_detail4_d[l_i].pmdsdocno2 = p_pmds.pmdsdocno
          LET g_detail4_d[l_i].pmdsdocdt2 = p_pmds.pmdsdocdt
          LET g_detail4_d[l_i].pmds0072 = p_pmds.pmds007
          LET g_detail4_d[l_i].pmds0022 = p_pmds.pmds002
          LET g_detail4_d[l_i].pmds0032 = p_pmds.pmds003
          LET g_detail4_d[l_i].pmdsownid2 = p_pmds.pmdsownid
          LET g_detail4_d[l_i].pmdscrtid2 = p_pmds.pmdscrtid
          LET g_detail4_d[l_i].pmds0412 = p_pmds.pmds041
          LET g_detail4_d[l_i].pmdssite2 = p_pmdssite
         
         #錯誤訊息
         LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
         
         #說明
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].pmds0072)
              RETURNING g_detail4_d[l_i].pmds0072_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].pmds0022)
              RETURNING g_detail4_d[l_i].pmds0022_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].pmds0032)
              RETURNING g_detail4_d[l_i].pmds0032_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].pmdsownid2)
              RETURNING g_detail4_d[l_i].pmdsownid2_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].pmdscrtid2)
              RETURNING g_detail4_d[l_i].pmdscrtid2_desc
              
         #pmdssite_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].pmdssite2)
              RETURNING g_detail4_d[l_i].pmdssite2_desc
              
      END FOR
      
      LET g_fail_cnt = g_errcollect.getLength()
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 抓取該站的入庫單，過帳還原、取消確認並刪除所有資料
# Memo...........:
# Usage..........: CALL aicp410_pmds(p_site,p_pmds041,p_pmds053,p_unpost,p_break)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_pmds041      多角序號
#                : p_pmds053      多角代碼
#                : p_unpost       是否要處理過帳還原
#                : p_break        中斷續拋
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/11/11 By stellar
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp410_pmds(p_site,p_pmds041,p_pmds053,p_unpost,p_break)
DEFINE p_site            LIKE pmds_t.pmdssite
DEFINE p_pmds041         LIKE pmds_t.pmds041
DEFINE p_pmds053         LIKE pmds_t.pmds053
DEFINE p_unpost          LIKE type_t.num5
DEFINE p_break           LIKE type_t.chr1
DEFINE r_success         LIKE type_t.num5
DEFINE l_pmdsstus        LIKE pmds_t.pmdsstus
DEFINE l_pmdsdocno       LIKE pmds_t.pmdsdocno
DEFINE l_pmdsdocdt       LIKE pmds_t.pmdsdocdt
DEFINE l_pmds000         LIKE pmds_t.pmds000
DEFINE l_pmds014         LIKE pmds_t.pmds014
DEFINE l_pmds050         LIKE pmds_t.pmds050
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001
DEFINE l_argv1           LIKE type_t.chr10
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
      AND icaa001 = p_pmds053

   #中斷續拋視為正拋
   IF p_break = 'Y' THEN
      LET l_icaa004 = '1'
   END IF

   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_pmds053,"'",
               " ORDER BY icab002"
   PREPARE sel_icab003_first_pre FROM l_sql
   DECLARE sel_icab003_first_cs SCROLL CURSOR FOR sel_icab003_first_pre

   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_pmds053,"'",
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

   #採購指定最終供應商，逆拋最終站，不做處理
   IF l_icaa003 = '3' AND l_icaa004 = '2' AND l_icab003_last = p_site THEN
      RETURN r_success
   END IF

   LET l_pmdsdocno = ''
   LET l_pmdsdocdt = ''
   LET l_pmdsstus = ''
   LET l_pmds000 = ''
   LET l_pmds014 = ''
   LET l_pmds050 = ''
   
   SELECT pmdsdocno,pmdsdocdt,pmdsstus,pmds000,pmds014,pmds050
     INTO l_pmdsdocno,l_pmdsdocdt,l_pmdsstus,l_pmds000,l_pmds014,l_pmds050
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
   
   IF p_unpost THEN
      IF l_pmdsstus = 'S' THEN
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
         
         LET l_pmdsstus = 'Y'
      END IF
   END IF
   
   IF l_pmdsstus = 'Y' THEN
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
PRIVATE FUNCTION aicp410_sel()
  #LET g_aicp410_sel = " pmdsent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp410_sel = " pmdsent = ",g_enterprise,cl_sql_add_filter("pmds_t"),     #161231-00013#1 add   
                       " AND pmdssite = '",g_site,"'",
                       " AND pmds000 IN ('3','20','6','12') ",   #3採購收貨入庫單,20委外採購收貨入庫,6採購入庫,12委外採購入庫
                       " AND pmds011 IN ('1','2') ",
                       " AND pmdsstus = 'S' ",
                       " AND pmds053 IS NOT NULL ",   #多角流程代碼
                       " AND pmds041 IS NOT NULL ",   #多角序號
                       " AND pmds050 = 'Y'",          #多角已拋轉否
                       " AND pmds014 IN ('1','2','3','8') ",
                       
                       #多角流程代碼為"2:代采购、3:采购指定最终供应商"
                       " AND EXISTS (SELECT 1 ",
                       "               FROM icaa_t",
                       "              WHERE icaaent = ",g_enterprise,
                       "                AND icaa001 = pmds053",
                       "                AND (icaa003 = '2' OR icaa003 = '3'))",
                       
                       #正拋初始站
                       " AND (EXISTS (SELECT 1 ",
                       "                FROM icaa_t,icab_t",
                       "               WHERE icaaent = icabent AND icabent = ",g_enterprise,
                       "                 AND icaa001 = icab001 AND icab001 = pmds053",
                       "                 AND icaa004 = '1'",
                       "                 AND icab002 = 0",
                       "                 AND icab003 = '",g_site,"')",
                       
                       #150917-00001#3  2016/01/19 By earl mod s
                       #簽收量為0的出貨單(代表初始站無續拋)
                      #"      OR (SELECT SUM(xmdl035)",      #170120-00028#1 mark
                       "      OR NVL((SELECT SUM(xmdl035)",  #170120-00028#1 add
                       "            FROM xmdk_t,xmdl_t",
                       "           WHERE xmdkent = xmdlent AND xmdlent = ",g_enterprise,
                       "             AND xmdkdocno = xmdldocno",
                       "             AND xmdksite = pmdssite",
                      #"             AND xmdk035 = pmds041) = 0)",      #170120-00028#1 mark
                       "             AND xmdk035 = pmds041),0) = 0)",   #170120-00028#1 add
#                       #過濾已存在正向的出貨單(排除中斷)
#                       #過濾已存在正向的收貨入庫單(排除中斷)
#                       "      OR NOT pmds041 IN (SELECT xmdk035",
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

                       #" AND NOT EXISTS (SELECT apcb002 FROM apcb_t WHERE apcbent = pmdsent AND apcb002 = pmdsdocno) "
                       " AND NVL((SELECT SUM(pmdt056) FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno),0) = 0",  #主帳套已請款數量   #170120-00028#1 add NVL
                       " AND NVL((SELECT SUM(pmdt057) FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno),0) = 0",  #帳套二已請款數量   #170120-00028#1 add NVL
                       " AND NVL((SELECT SUM(pmdt058) FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno),0) = 0",  #帳套三已請款數量   #170120-00028#1 add NVL
                       " AND NVL((SELECT SUM(pmdt066) FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno),0) = 0",  #主帳套暫估數量     #170120-00028#1 add NVL
                       " AND NVL((SELECT SUM(pmdt067) FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno),0) = 0",  #帳套二暫估數量     #170120-00028#1 add NVL
                       " AND NVL((SELECT SUM(pmdt068) FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno),0) = 0",  #帳套三暫估數量     #170120-00028#1 add NVL
                       " AND NVL((SELECT SUM(pmdt069) FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno),0) = 0"   #已開發票數量       #170120-00028#1 add NVL
END FUNCTION

#end add-point
 
{</section>}
 
