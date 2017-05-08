#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp570.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-05-14 17:15:31), PR版次:0004(2016-10-18 10:30:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: aicp570
#+ Description: 在途存貨應收付拋轉作業
#+ Creator....: 00593(2014-11-10 10:43:29)
#+ Modifier...: 00000 -SD/PR- 05384
 
{</section>}
 
{<section id="aicp570.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160909-00080#1   2016/09/13  By 02097    修改開窗
#161013-00051#1   2016/10/18  By shiun    整批調整據點組織開窗
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
       sel               LIKE type_t.chr1,
       datatype          LIKE type_t.chr4,        #類別
       xmdk000           LIKE xmdk_t.xmdk000,     #單據性質
       xmdkent           LIKE xmdk_t.xmdkent,     #ENT
       xmdksite          LIKE xmdk_t.xmdksite,    #營運據點
       xmdksite_desc     LIKE ooefl_t.ooefl003,   #營運據點名稱
       xmdkdocno         LIKE xmdk_t.xmdkdocno,   #單據編號
       xmdkdocdt         LIKE xmdk_t.xmdkdocdt,   #到庫日
       xmdk007           LIKE xmdk_t.xmdk007,     #交易對象編號
       xmdk007_desc      LIKE type_t.chr500,      #交易對象簡稱
       xmdk035           LIKE xmdk_t.xmdk035,     #多角序號
       xmdk044           LIKE xmdk_t.xmdk044,     #多角流程代碼
       xmdkownid         LIKE xmdk_t.xmdkownid,   #資料所有者
       xmdkownid_desc    LIKE type_t.chr500,      #全名
       xmdkcrtid         LIKE xmdk_t.xmdkcrtid,   #資料建立者
       xmdkcrtid_desc    LIKE type_t.chr500       #全名
                         END RECORD
DEFINE g_detail_d_t      type_g_detail_d

TYPE type_g_detail2_d    RECORD
       xmdlseq           LIKE xmdl_t.xmdlseq,     #項次
       xmdl003           LIKE xmdl_t.xmdl003,     #採購單號
       xmdl004           LIKE xmdl_t.xmdl004,     #採購單項次
       xmdl008           LIKE xmdl_t.xmdl008,     #料件編號
       xmdl008_desc      LIKE type_t.chr500,      #品名
       xmdl008_desc_1    LIKE type_t.chr500,      #規格
       xmdl009           LIKE xmdl_t.xmdl009,     #產品特徵
       xmdl009_desc      LIKE type_t.chr500,      #產品特徵說明
       xmdl017           LIKE xmdl_t.xmdl017,     #單位
       xmdl018           LIKE xmdl_t.xmdl018,     #數量
       xmdl021           LIKE xmdl_t.xmdl021,     #計價單位
       xmdl022           LIKE xmdl_t.xmdl022,     #計價數量
       xmdl024           LIKE xmdl_t.xmdl024,     #單價
       xmdl027           LIKE xmdl_t.xmdl027,     #未稅金額
       xmdl028           LIKE xmdl_t.xmdl028      #含稅金額
                         END RECORD
DEFINE g_detail2_d       DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt     LIKE type_t.num5
DEFINE g_rec_b           LIKE type_t.num5

TYPE type_g_detail3_d    RECORD
       xmdksite1         LIKE xmdk_t.xmdksite,    #營運據點
       xmdksite1_desc    LIKE ooefl_t.ooefl003,   #營運據點名稱
       xmdkdocno1        LIKE xmdk_t.xmdkdocno,   #單據編號
       xmdkdocdt1        LIKE xmdk_t.xmdkdocdt,   #到庫日
       xmdk0071          LIKE xmdk_t.xmdk007,     #交易對象編號
       xmdk0071_desc     LIKE type_t.chr500,      #交易對象簡稱       
       xmdkownid1        LIKE xmdk_t.xmdkownid,   #資料所有者
       xmdkownid1_desc   LIKE type_t.chr500,      #全名
       xmdkcrtid1        LIKE xmdk_t.xmdkcrtid,   #資料建立者
       xmdkcrtid1_desc   LIKE type_t.chr500,      #全名
       xrca0471          LIKE xrca_t.xrca047      #拋轉應收付的多角序號
                         END RECORD
DEFINE g_detail3_d       DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt     LIKE type_t.num5

TYPE type_g_detail4_d    RECORD
       xmdksite2         LIKE xmdk_t.xmdksite,    #營運據點
       xmdksite2_desc    LIKE ooefl_t.ooefl003,   #營運據點名稱
       xmdkdocno2        LIKE xmdk_t.xmdkdocno,   #單據編號
       xmdkdocdt2        LIKE xmdk_t.xmdkdocdt,   #到庫日
       xmdk0072          LIKE xmdk_t.xmdk007,     #交易對象編號
       xmdk0072_desc     LIKE type_t.chr500,      #交易對象簡稱       
       xmdkownid2        LIKE xmdk_t.xmdkownid,   #資料所有者
       xmdkownid2_desc   LIKE type_t.chr500,      #全名
       xmdkcrtid2        LIKE xmdk_t.xmdkcrtid,   #資料建立者
       xmdkcrtid2_desc   LIKE type_t.chr500,      #全名
       xrca0472          LIKE xrca_t.xrca047,     #拋轉應收付的多角序號
       reason            LIKE type_t.chr500       #失敗原因
                         END RECORD
DEFINE g_detail4_d       DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt     LIKE type_t.num5

DEFINE g_icab003         LIKE icab_t.icab003      #多角流程代碼最終站的營運據點 
DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5
TYPE type_input   RECORD
       docdt_chk         LIKE type_t.chr1,
       acct_date         LIKE type_t.dat,
       sum_acct_date     LIKE type_t.dat
                  END RECORD
DEFINE g_input   type_input
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp570.main" >}
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
   CALL aicp570_create_temp_table()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdkdocno = '",g_argv[1],"' "
         CALL aicp570_query()
         UPDATE aicp570_tmp 
            SET sel = 'Y'
         CALL aicp570_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp570 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp570_init()   
 
      #進入選單 Menu (="N")
      CALL aicp570_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp570
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aicp570_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp570.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp570_init()
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
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp570.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp570_ui_dialog()
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
   LET g_input.docdt_chk = 'Y'
   LET g_input.acct_date = ''
   LET g_input.sum_acct_date = ''
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aicp570_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON xmdksite,xmdkdocno,xmdkdocdt,xmdk007,xmdk035,xmdkownid,xmdkcrtid

            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD xmdksite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #mod--161013-00051#1 By shiun--(S)
#               CALL q_ooef001_12()                     #呼叫開窗
               CALL q_ooef001_1()
               #mod--161013-00051#1 By shiun--(E)
               DISPLAY g_qryparam.return1 TO xmdksite  #顯示到畫面上
               NEXT FIELD xmdksite                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmdsdocno_5()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上
               NEXT FIELD xmdkdocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD xmdk007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001()       #160909-00080#1 mark
               CALL q_pmaa001_6()     #160909-00080#1   
               DISPLAY g_qryparam.return1 TO xmdk007
               NEXT FIELD xmdk007
               
            ON ACTION controlp INFIELD xmdk035
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmds041_1()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk035  #顯示到畫面上
               NEXT FIELD xmdk035                     #返回原欄位
   
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
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkcrtid  #顯示到畫面上
               NEXT FIELD xmdkcrtid                     #返回原欄位
         END CONSTRUCT

         INPUT BY NAME g_input.docdt_chk,g_input.acct_date,g_input.sum_acct_date 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               CALL aicp570_set_no_required()
               CALL aicp570_set_required()
               
            ON CHANGE docdt_chk
               CALL aicp570_set_no_required()
               CALL aicp570_set_required()
         END INPUT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
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
               CALL aicp570_fetch()       
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               
            ON ROW CHANGE
               UPDATE aicp570_tmp
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
            #為了讓畫面Focus停留在"查詢條件"這一頁，所以找一個欄位當標的顯示它
            CALL gfrm_curr.ensureFieldVisible("xmdk_t.xmdksite")
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
            UPDATE aicp570_tmp 
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
            UPDATE aicp570_tmp 
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
                  UPDATE aicp570_tmp 
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
                  UPDATE aicp570_tmp 
                     SET sel = 'N' 
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp570_filter()
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
            CALL aicp570_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp570_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            UPDATE aicp570_tmp
               SET sel = g_detail_d[l_ac].sel
             WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp570_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               CALL aicp570_process()
               CALL aicp570_query()
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
 
{<section id="aicp570.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp570_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM aicp570_tmp;

   #QBE條件組出來的欄位都是xmdk的，需轉換成pmds的才能用來抓採購段資料
   LET ls_wc = g_wc
   LET ls_wc = cl_replace_str(ls_wc,'xmdksite','pmdsdite') 
   LET ls_wc = cl_replace_str(ls_wc,'xmdkdocno','pmdsdocno') 
   LET ls_wc = cl_replace_str(ls_wc,'xmdkdocdt','pmdsdocdt') 
   LET ls_wc = cl_replace_str(ls_wc,'xmdk007','pmds007') 
   LET ls_wc = cl_replace_str(ls_wc,'xmdk035','pmds041') 
   LET ls_wc = cl_replace_str(ls_wc,'xmdkownid','pmdsownid') 
   LET ls_wc = cl_replace_str(ls_wc,'xmdkcrtid','pmdscrtid')

   #SQL的where條件：
   #狀態碼 xmdkstus / pmdtstus = 'S'
   #單據性質 xmdk000 = '6' / pmds000 IN ('3','4','6','7','12','14')
   #多角序號 xmdk035 / pmds041不為NULL
   #單身已立帳數量 xmdl038 / 已請款數量pmdt056 = 0
   #據點入庫單單身多角流程代碼 xmdk044 / pmds053 於aici100 [流程定義]頁籤之中斷否 icab005 = 'Y'
   LET g_sql = "SELECT DISTINCT 'N','AXM',xmdk000,xmdkent,xmdksite,xmdkdocno,xmdkdocdt,",
               "                xmdk007,xmdk035,xmdk044,xmdkownid,xmdkcrtid",
               "  FROM xmdk_t",
               " INNER JOIN xmdl_t ON xmdkent = xmdlent AND xmdkdocno = xmdldocno AND xmdl038 = 0",               
               " WHERE ",g_wc,
               "   AND xmdkent = ",g_enterprise,
               "   AND xmdk000 = '6'",
               "   AND xmdkstus = 'S'",
               "   AND xmdk035 IS NOT NULL",
               " UNION ",
               "SELECT DISTINCT 'N','APM',pmds000,pmdsent,pmdssite,pmdsdocno,pmdsdocdt,",
               "                pmds007,pmds041,pmds053,pmdsownid,pmdscrtid",
               "  FROM pmds_t",
               " INNER JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdt056 = 0",
               " INNER JOIN icab_t ON pmdtent = icabent AND pmds053 = icab001 AND icab005 = 'Y'",
               " WHERE ",ls_wc,
               "   AND pmdsent = ",g_enterprise,
               "   AND pmds000 IN ('3','4','6','7','12','14')",
               "   AND pmdsstus = 'S'",
               "   AND pmds041 IS NOT NULL"
   LET g_sql = "INSERT INTO aicp570_tmp ",
               "(sel,datatype,xmdk000,xmdkent,xmdksite,xmdkdocno,xmdkdocdt,",
               " xmdk007,xmdk035,xmdk044,xmdkownid,xmdkcrtid) ",
               g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp570_b_fill()
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
 
{<section id="aicp570.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp570_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT 'N',datatype,xmdk000,xmdkent,xmdksite,a.ooefl003,xmdkdocno,xmdkdocdt,xmdk007,b.pmaal004,",
               "                xmdk035,xmdk044,xmdkownid,c.ooag011,xmdkcrtid,d.ooag011 ",
               "  FROM aicp570_tmp ",
               "  LEFT OUTER JOIN ooefl_t a ON a.ooeflent = ",g_enterprise," AND xmdksite = a.ooefl001 AND a.ooefl002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN pmaal_t b ON b.pmaalent = ",g_enterprise," AND xmdk007 = b.pmaal001 AND b.pmaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN ooag_t c ON c.ooagent = ",g_enterprise," AND xmdkownid = c.ooag001",
               "  LEFT OUTER JOIN ooag_t d ON d.ooagent = ",g_enterprise," AND xmdkcrtid = d.ooag001",               
               " WHERE xmdkent = ? AND ",g_wc_filter,
               " ORDER BY xmdksite,xmdkdocno"
   #end add-point
 
   PREPARE aicp570_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp570_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()  
   LET g_master_idx = 1 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].datatype,g_detail_d[l_ac].xmdk000,
      g_detail_d[l_ac].xmdkent,g_detail_d[l_ac].xmdksite,g_detail_d[l_ac].xmdksite_desc,
      g_detail_d[l_ac].xmdkdocno,g_detail_d[l_ac].xmdkdocdt,
      g_detail_d[l_ac].xmdk007,g_detail_d[l_ac].xmdk007_desc,
      g_detail_d[l_ac].xmdk035,g_detail_d[l_ac].xmdk044,
      g_detail_d[l_ac].xmdkownid,g_detail_d[l_ac].xmdkownid_desc,
      g_detail_d[l_ac].xmdkcrtid,g_detail_d[l_ac].xmdkcrtid_desc
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
      
      CALL aicp570_detail_show()      
 
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
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aicp570_sel
   
   LET l_ac = 1
   CALL aicp570_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp570.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp570_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT xmdlseq,xmdl003,xmdl004,xmdl008,imaal003,imaal004,xmdl009,'',",
               "       xmdl017,xmdl018,xmdl021,xmdl022,xmdl024,xmdl027,xmdl028",
               "  FROM xmdl_t ",
               "  LEFT OUTER JOIN imaal_t ON xmdlent = imaalent AND xmdl008 = imaal001 AND imaal002 = '",g_dlang,"'",
               " WHERE xmdlent = ",g_enterprise,
               "   AND xmdldocno = '",g_detail_d[g_master_idx].xmdkdocno,"'",
               " UNION ",               
               "SELECT pmdtseq,pmdt001,pmdt002,pmdt006,imaal003,imaal004,pmdt007,'',",
               "       pmdt019,pmdt020,pmdt023,pmdt024,pmdt036,pmdt038,pmdt039",
               "  FROM pmdt_t ",
               "  LEFT OUTER JOIN imaal_t ON pmdtent = imaalent AND pmdt006 = imaal001 AND imaal002 = '",g_dlang,"'",
               " WHERE pmdtent = ",g_enterprise,
               "   AND pmdtdocno = '",g_detail_d[g_master_idx].xmdkdocno,"'",               
               " ORDER BY xmdlseq "
   PREPARE xmdl_fill_pre FROM g_sql
   DECLARE xmdl_fill_cur CURSOR FOR xmdl_fill_pre
   
   FOREACH xmdl_fill_cur INTO 
      g_detail2_d[l_ac].xmdlseq,g_detail2_d[l_ac].xmdl003,g_detail2_d[l_ac].xmdl004,
      g_detail2_d[l_ac].xmdl008,g_detail2_d[l_ac].xmdl008_desc,g_detail2_d[l_ac].xmdl008_desc_1,
      g_detail2_d[l_ac].xmdl009,g_detail2_d[l_ac].xmdl009_desc,g_detail2_d[l_ac].xmdl017,
      g_detail2_d[l_ac].xmdl018,g_detail2_d[l_ac].xmdl021,g_detail2_d[l_ac].xmdl022,
      g_detail2_d[l_ac].xmdl024,g_detail2_d[l_ac].xmdl027,g_detail2_d[l_ac].xmdl028
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
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
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp570.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp570_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp570.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp570_filter()
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
   
   CONSTRUCT g_wc_filter ON xmdksite,xmdkdocno,xmdkdocdt,xmdk007,xmdk035,xmdk044,xmdkownid,xmdkcrtid
        FROM s_detail1[1].b_xmdksite,s_detail1[1].b_xmdkdocno,s_detail1[1].b_xmdkdocdt,
             s_detail1[1].b_xmdk007,s_detail1[1].b_xmdk035,s_detail1[1].b_xmdk044,
             s_detail1[1].b_xmdkownid,s_detail1[1].b_xmdkcrtid
           
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_xmdksite
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooed004()                          #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdksite  #顯示到畫面上
         NEXT FIELD b_xmdksite                     #返回原欄位
         
      ON ACTION controlp INFIELD b_xmdkdocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pmdsdocno_5()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdkdocno  #顯示到畫面上
         NEXT FIELD b_xmdkdocno                     #返回原欄位    
         
      ON ACTION controlp INFIELD b_xmdk007
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
        #CALL q_pmaa001()       #160909-00080#1 mark
         CALL q_pmaa001_6()     #160909-00080#1         
         DISPLAY g_qryparam.return1 TO b_xmdk007
         NEXT FIELD b_xmdk007
         
      ON ACTION controlp INFIELD b_xmdk035
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pmds041_1()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdk035  #顯示到畫面上
         NEXT FIELD b_xmdk035                     #返回原欄位

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
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp570_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp570.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp570_filter_parser(ps_field)
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
 
{<section id="aicp570.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp570_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp570_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp570.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL aicp570_create_temp_table()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/17 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp570_create_temp_table()

   DROP TABLE aicp570_tmp;
   CREATE TEMP TABLE aicp570_tmp( 
       sel            LIKE type_t.chr1,
       datatype       LIKE type_t.chr4,
       xmdk000        LIKE xmdk_t.xmdk000,
       xmdkent        LIKE xmdk_t.xmdkent,
       xmdksite       LIKE xmdk_t.xmdksite,
       xmdkdocno      LIKE xmdk_t.xmdkdocno,
       xmdkdocdt      LIKE xmdk_t.xmdkdocdt,
       xmdk007        LIKE xmdk_t.xmdk007,
       xmdk035        LIKE xmdk_t.xmdk035,
       xmdk044        LIKE xmdk_t.xmdk044,
       xmdkownid      LIKE xmdk_t.xmdkownid,
       xmdkcrtid      LIKE xmdk_t.xmdkcrtid
       );

END FUNCTION

################################################################################
# Descriptions...: 批次拋轉實際執行
# Memo...........:
# Usage..........: CALL aicp570_process()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/20 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp570_process()
DEFINE l_xmdk            type_g_detail_d
DEFINE l_xmdk1           type_g_detail_d
DEFINE l_xmdk2           type_g_detail_d
DEFINE l_trino           LIKE xrca_t.xrca047
DEFINE l_icab002         LIKE icab_t.icab002
DEFINE l_icab003         LIKE icab_t.icab003
DEFINE l_icaa012         LIKE icaa_t.icaa012
DEFINE l_success         LIKE type_t.num5
DEFINE l_success1        LIKE type_t.num5
DEFINE l_apcadocno       LIKE apca_t.apcadocno
DEFINE l_xrcadocno       LIKE xrca_t.xrcadocno
DEFINE l_date            LIKE xmdk_t.xmdkdocdt

   #有選擇的入庫單/銷退單/倉退單
   LET g_sql = "SELECT datatype,xmdk000,xmdksite,xmdkdocno,xmdkdocdt,",
               "       xmdk007,xmdk035,xmdk044,xmdkownid,xmdkcrtid",
               "  FROM aicp570_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY datatype,xmdk000,xmdksite,xmdkdocno "
   PREPARE aicp570_process_pre FROM g_sql
   DECLARE aicp570_process_cur CURSOR WITH HOLD FOR aicp570_process_pre

   #多角應收/應付開立方式
   LET g_sql = "SELECT icaa012 ",
               "  FROM icaa_t",
               " WHERE icaaent = ",g_enterprise,
               "   AND icaa001 = ?"
   PREPARE aicp570_process_icaa_pre FROM g_sql
   DECLARE aicp570_process_icaa_cur CURSOR FOR aicp570_process_icaa_pre
   
   #下站多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               "   AND icab002 >= (SELECT icab002 FROM icab_t WHERE icabent=",g_enterprise," AND icab003=?)",
               " ORDER BY icab002"
   PREPARE aicp570_process_icab_next_pre FROM g_sql
   DECLARE aicp570_process_icab_next_cur CURSOR FOR aicp570_process_icab_next_pre
   
   #多角下站的銷退單/倉退單
   LET g_sql = "SELECT 'AXM',xmdk000,xmdksite,xmdkdocno,xmdkdocdt,",
               "       xmdk007,xmdk035,xmdk044,xmdkownid,xmdkcrtid",
               "  FROM xmdk_t ",
               " WHERE xmdksite = ? AND xmdk035 = ? "
   PREPARE aicp570_process_next_axm_pre FROM g_sql
   DECLARE aicp570_process_next_axm_cur CURSOR WITH HOLD FOR aicp570_process_next_axm_pre

   #多角下站的入庫單
   LET g_sql = "SELECT 'APM',pmds000,pmdssite,pmdsdocno,pmdsdocdt,",
               "       pmds007,pmds041,pmds053,pmdsownid,pmdscrtid",
               "  FROM pmds_t ",
               " WHERE pmdssite = ? AND pmds041 = ? "
   PREPARE aicp570_process_next_apm_pre FROM g_sql
   DECLARE aicp570_process_next_apm_cur CURSOR WITH HOLD FOR aicp570_process_next_apm_pre
   
   LET l_success = TRUE
   
   CALL s_aic_carry_create_temp_table_ship()
        RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   
   CALL s_aic_carry_create_temp_table_storage()
        RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF

   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化
   
   FOREACH aicp570_process_cur INTO l_xmdk.datatype,l_xmdk.xmdk000,l_xmdk.xmdksite,l_xmdk.xmdkdocno,
                                    l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk035,l_xmdk.xmdk044,
                                    l_xmdk.xmdkownid,l_xmdk.xmdkcrtid
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      LET l_trino = ''
     
      #多角流程代碼為空白時，錯誤
      IF cl_null(l_xmdk.xmdk044) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00026'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success = FALSE
         CALL s_transaction_end('N',0)
         CALL aicp570_fail(l_xmdk.*,l_trino)
         CONTINUE FOREACH
      END IF
       
      #l_date:
      #1.若"多角流程代碼" xmdk044於aici100"多角應收/應付開立方式"icaa012='1'
      #  1.1若"依單據日期立帳"g_input.docdt_chk='Y'，則為出貨單單據日期xmdkdocdt
      #  1.2若"依單據日期立帳"g_input.docdt_chk='N'，則為一對一產生帳款"帳款日期"g_input.acct_date
      #2.若"多角流程代碼"xmdk044於aici100"多角應收/應付開立方式"icaa012='2'，
      #  則為查詢條件彙總產生帳款"帳款日期"g_input.sum_acct_date      
      LET l_icaa012 = ''
      LET l_date = ''
      OPEN aicp570_process_icaa_cur USING l_xmdk.xmdk044
      FETCH aicp570_process_icaa_cur INTO l_icaa012
      CASE l_icaa012
         WHEN "1"
            IF g_input.docdt_chk='Y' THEN
               LET l_date = l_xmdk.xmdkdocdt
            ELSE
               LET l_date = g_input.acct_date
            END IF
         WHEN "2"
            LET l_date = g_input.sum_acct_date
      END CASE

      #呼叫產生多角序號元件取得多角流程序號
      CALL s_aic_carry_gettrino(l_xmdk.xmdk044,'5',l_date,g_site)
           RETURNING l_success1,l_trino
      IF NOT l_success1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00001'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success = FALSE
         CALL s_transaction_end('N',0)
         CALL aicp570_fail(l_xmdk.*,l_trino)
         CONTINUE FOREACH
      END IF
                 
      #依出貨單單頭之"多角流程序號"(xmdk035),取出各站符合"多角流程序號"(xmdk035)之多角出貨單,
      #將各站之多角出貨單依axrp130邏輯產生多角應收帳款
      #依入庫單單頭之"多角流程序號"(pmds041),取出各站符合"多角流程序號"(pmds041)之多角入庫單,
      #將各站之多角入庫單依aapp130邏輯產生多角應收帳款
      OPEN aicp570_process_icab_next_cur USING l_xmdk.xmdk044,l_xmdk.xmdksite
      FOREACH aicp570_process_icab_next_cur INTO l_icab002,l_icab003
         IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'icab_next_cur'
           LET g_errparam.popup = TRUE
           CALL cl_err()
           
           EXIT FOREACH
         END IF

         OPEN aicp570_process_next_axm_cur USING l_icab003,l_xmdk.xmdk035
         FETCH aicp570_process_next_axm_cur INTO l_xmdk1.datatype,l_xmdk1.xmdk000,l_xmdk1.xmdksite,
                                                 l_xmdk1.xmdkdocno,l_xmdk1.xmdkdocdt,l_xmdk1.xmdk007,
                                                 l_xmdk1.xmdk035,l_xmdk1.xmdk044,l_xmdk1.xmdkownid,
                                                 l_xmdk1.xmdkcrtid
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ' next_axm_cur'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            EXIT FOREACH
         END IF

#         #產生多角應收帳款
#         CALL s_aic_carry_gen_ar(?)
#              RETURNING l_success,l_xrcadocno
#         IF NOT l_success THEN
#            EXIT FOREACH
#         END IF
#
#         #回寫應收帳款多角序號
#         UPDATE xrca_t SET xrca047 = l_trino
#          WHERE xrcaent = g_enterprise
#            AND xrcadocno = l_xrcadocno
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#             
#            CALL cl_err()
#            LET l_success = FALSE
#            CALL s_transaction_end('N',0)
#            CALL aicp570_fail(l_xmdk1.*,l_trino)
#            CONTINUE FOREACH
#         ELSE
#            CALL s_transaction_end('Y',0)
#            CALL aicp570_success(l_xmdk1.*,l_trino)
#         END IF

         OPEN aicp570_process_next_apm_cur USING l_icab003,l_xmdk.xmdk035
         FETCH aicp570_process_next_apm_cur INTO l_xmdk2.datatype,l_xmdk2.xmdk000,l_xmdk2.xmdksite,
                                                 l_xmdk2.xmdkdocno,l_xmdk2.xmdkdocdt,l_xmdk2.xmdk007,
                                                 l_xmdk2.xmdk035,l_xmdk2.xmdk044,l_xmdk2.xmdkownid,
                                                 l_xmdk2.xmdkcrtid
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'next_apm_cur'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            EXIT FOREACH
         END IF

#         #產生多角應付帳款
#         CALL s_aic_carry_gen_ap(?)
#              RETURNING l_success,l_apcadocno
#         IF NOT l_success THEN
#            EXIT FOREACH
#         END IF
#
#         #回寫應付帳款多角序號
#         UPDATE apca_t SET apca047 = l_trino
#          WHERE apcaent = g_enterprise
#            AND apcadocno = l_apcadocno
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#             
#            CALL cl_err()
#            LET l_success = FALSE
#            CALL s_transaction_end('N',0)
#            CALL aicp570_fail(l_xmdk2.*,l_trino)
#            CONTINUE FOREACH
#         ELSE
#            CALL s_transaction_end('Y',0)
#            CALL aicp570_success(l_xmdk1.*,l_trino)
#         END IF

      END FOREACH
   END FOREACH
   
   #清空錯誤訊息的array，並且之後的訊息不以array記錄
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   #drop table
   CALL s_aic_carry_drop_temp_table_ship()
   CALL s_aic_carry_drop_temp_table_storage()
   
   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF

END FUNCTION

################################################################################
# Descriptions...: 將帳款日期設為非必輸
# Memo...........:
# Usage..........: CALL aicp570_set_no_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/20 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp570_set_no_required()

   CALL cl_set_comp_required("acct_date",FALSE)

END FUNCTION

################################################################################
# Descriptions...: 判斷符合條件後將帳款日期設為必輸
# Memo...........:
# Usage..........: CALL aicp570_set_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/11/20 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp570_set_required()

   IF g_input.docdt_chk = 'N' THEN
      CALL cl_set_comp_required("acct_date",TRUE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 成功記錄
# Memo...........:
# Usage..........: CALL aicp570_success(p_xmdk,p_xrca047)
# Input parameter: p_xmdk         單身一record
#                : p_xrca047      多角序號
# Return code....: 無
# Date & Author..: 2014/11/20 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp570_success(p_xmdk,p_xrca047)
DEFINE p_xmdk          type_g_detail_d
DEFINE p_xrca047       LIKE xrca_t.xrca047
DEFINE l_success       LIKE type_t.num5

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
   
   LET g_detail3_d[g_success_cnt].xmdksite1 = p_xmdk.xmdksite
   LET g_detail3_d[g_success_cnt].xmdkdocno1 = p_xmdk.xmdkdocno
   LET g_detail3_d[g_success_cnt].xmdkdocdt1 = p_xmdk.xmdkdocdt
   LET g_detail3_d[g_success_cnt].xmdk0071 = p_xmdk.xmdk007
   LET g_detail3_d[g_success_cnt].xmdkownid1 = p_xmdk.xmdkownid
   LET g_detail3_d[g_success_cnt].xmdkcrtid1 = p_xmdk.xmdkcrtid
   LET g_detail3_d[g_success_cnt].xrca0471 = p_xrca047 
   
   #說明
   CALL s_aooi100_get_name(g_detail3_d[g_success_cnt].xmdksite1,g_dlang)
        RETURNING l_success,g_detail3_d[g_success_cnt].xmdksite1_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdk0071)
        RETURNING g_detail3_d[g_success_cnt].xmdk0071_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmdkownid1)
        RETURNING g_detail3_d[g_success_cnt].xmdkownid1_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmdkcrtid1)
        RETURNING g_detail3_d[g_success_cnt].xmdkcrtid1_desc
   
   LET g_success_cnt = g_success_cnt + 1

END FUNCTION

################################################################################
# Descriptions...: 失敗記錄
# Memo...........:
# Usage..........: CALL aicp570_fail(p_xmdk, p_xrca047)
# Input parameter: p_xmdk         單身一record
#                : p_xrca047      多角序號
# Return code....: 無
# Date & Author..: 2014/11/20 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp570_fail(p_xmdk,p_xrca047)
DEFINE p_xmdk          type_g_detail_d
DEFINE p_xrca047       LIKE xrca_t. xrca047
DEFINE l_errcode       LIKE gzze_t.gzze001
DEFINE l_i             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5

   IF cl_null(g_fail_cnt) THEN
      LET g_fail_cnt = 0
   END IF
   
   FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
      LET g_detail4_d[l_i].xmdksite2 = p_xmdk.xmdksite
      LET g_detail4_d[l_i].xmdkdocno2 = p_xmdk.xmdkdocno
      LET g_detail4_d[l_i].xmdkdocdt2 = p_xmdk.xmdkdocdt
      LET g_detail4_d[l_i].xmdk0072 = p_xmdk.xmdk007
      LET g_detail4_d[l_i].xmdkownid2 = p_xmdk.xmdkownid
      LET g_detail4_d[l_i].xmdkcrtid2 = p_xmdk.xmdkcrtid
      LET g_detail4_d[l_i].xrca0472 = p_xrca047
      
      #錯誤訊息
      LET l_errcode = g_errcollect[l_i].code
      LET g_detail4_d[l_i].reason = cl_getmsg(l_errcode,g_dlang)
      
      #說明
      CALL s_aooi100_get_name(g_detail4_d[l_i].xmdksite2,g_dlang)
           RETURNING l_success,g_detail4_d[l_i].xmdksite2_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdk0072)
           RETURNING g_detail4_d[l_i].xmdk0072_desc
      CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdkownid2)
           RETURNING g_detail4_d[l_i].xmdkownid2_desc
      CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdkcrtid2)
           RETURNING g_detail4_d[l_i].xmdkcrtid2_desc

   END FOR

END FUNCTION

#end add-point
 
{</section>}
 
