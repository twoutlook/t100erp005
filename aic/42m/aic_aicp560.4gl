#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp560.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-05-14 17:05:55), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: aicp560
#+ Description: 多角銷售應收付拋轉還原作業
#+ Creator....: 05384(2014-11-11 13:52:11)
#+ Modifier...: 04543 -SD/PR- 00000
 
{</section>}
 
{<section id="aicp560.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
   xrcadocno         LIKE xrca_t.xrcadocno,  #應收憑單單號
   xrcadocdt         LIKE xrca_t.xrcadocdt,  #立帳日期
   xrca004           LIKE xrca_t.xrca004,    #帳款對象
   xrca004_desc      LIKE type_t.chr500,
   xrca047           LIKE xrca_t.xrca047,  #交易序號
   xrcaownid         LIKE xrca_t.xrcaownid,  #資料所有者
   xrcaownid_desc    LIKE type_t.chr500,
   xrcacrtid         LIKE xrca_t.xrcacrtid,  #資料建立者
   xrcacrtid_desc    LIKE type_t.chr500
                     END RECORD
DEFINE g_detail_d_t      type_g_detail_d

TYPE type_g_detail2_d RECORD
   xrcbseq            LIKE xrcb_t.xrcbseq,
   xrcb002            LIKE xrcb_t.xrcb002,
   xrcb003            LIKE xrcb_t.xrcb003,
   xrcb004            LIKE xrcb_t.xrcb004,
   xrcb004_desc       LIKE type_t.chr500,
   xrcb004_desc_1     LIKE type_t.chr500,
   xrcb007            LIKE xrcb_t.xrcb007,
   xrcb101            LIKE xrcb_t.xrcb101,
   xrcb103            LIKE xrcb_t.xrcb103,
   xrcb105            LIKE xrcb_t.xrcb105
                      END RECORD
DEFINE g_detail2_d    DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt  LIKE type_t.num5
DEFINE g_rec_b        LIKE type_t.num5

TYPE type_g_detail3_d RECORD
   xrcadocno1         LIKE xrca_t.xrcadocno,  #應收憑單單號
   xrcadocdt1         LIKE xrca_t.xrcadocdt,  #立帳日期
   xrca0041           LIKE xrca_t.xrca004,    #帳款對象
   xrca0041_desc      LIKE type_t.chr500,
   xrca0471           LIKE xrca_t.xrca047,  #交易序號
   xrcaownid1         LIKE xrca_t.xrcaownid,  #資料所有者
   xrcaownid1_desc    LIKE type_t.chr500,
   xrcacrtid1         LIKE xrca_t.xrcacrtid,  #資料建立者
   xrcacrtid1_desc    LIKE type_t.chr500
                      END RECORD
DEFINE g_detail3_d       DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt     LIKE type_t.num5

TYPE type_g_detail4_d RECORD
   xrcadocno2         LIKE xrca_t.xrcadocno,  #應收憑單單號
   xrcadocdt2         LIKE xrca_t.xrcadocdt,  #立帳日期
   xrca0042           LIKE xrca_t.xrca004,    #帳款對象
   xrca0042_desc      LIKE type_t.chr500,
   xrca0472           LIKE xrca_t.xrca047,  #交易序號
   xrcaownid2         LIKE xrca_t.xrcaownid,  #資料所有者
   xrcaownid2_desc    LIKE type_t.chr500,
   xrcacrtid2         LIKE xrca_t.xrcacrtid,  #資料建立者
   xrcacrtid2_desc    LIKE type_t.chr500,
   reason             LIKE type_t.chr80
                      END RECORD
DEFINE g_detail4_d    DYNAMIC ARRAY OF type_g_detail4_d
TYPE type_g_xrca_d RECORD
   xrcald            LIKE xrca_t.xrcald
                      END RECORD
DEFINE g_xrca_d    DYNAMIC ARRAY OF type_g_xrca_d
DEFINE g_detail4_cnt  LIKE type_t.num5
DEFINE g_icab003      LIKE icab_t.icab003   #多角流程代碼最終站的營運據點 
DEFINE g_success_cnt  LIKE type_t.num5
DEFINE g_fail_cnt     LIKE type_t.num5        
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp560.main" >}
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
   CALL aicp560_create_temp_table()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xrcadocno = '",g_argv[1],"' "
         CALL aicp560_query()
         UPDATE aicp560_tmp 
            SET sel = 'Y'
#         CALL aicp560_process()
      END IF
      #end add-p
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp560 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp560_init()   
 
      #進入選單 Menu (="N")
      CALL aicp560_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp560
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aicp560_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp560.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp560_init()
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
 
{<section id="aicp560.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp560_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt       LIKE type_t.num5
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
         CALL aicp560_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON xrcadocno,xrcadocdt,xrca004,xrca047,xrcaownid,xrcacrtid

            BEFORE CONSTRUCT
#            出貨單單頭"多角流程代碼"xmdk044於aici100 "流程類型"欄位(icaa003)='1'
#            且aici100 [流程定義]頁籤設定之第0站營運據點=g_site 或 出貨單單身之"訂單類型"欄位='3'統銷統收
#            出貨單單頭"多角流程代碼xmdk044"於aici100 "流程類型"欄位(icaa003)='1' 
#            且aici100 [流程定義]頁籤設定之第0站營運據點=g_site 或 出貨單單身"訂單多角性質xmdl086"='3'統銷統收
            ON ACTION controlp INFIELD xrcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #因目前多角尚未完善 多角序號幾乎為空，若加入下行mark掉的條件會完全沒有資料，所以先行mark以確認其他條件是否正確
               LET g_qryparam.where = #"     xrca047 IS NOT NULL ", 
                                    "  (EXISTS (SELECT icaa001 FROM icaa_t,icab_t ",
                                    "               WHERE icabent = icaaent ",
                                    "                 AND icab001 = icaa001 ",
                                    "                 AND icaa001 = xmdk044 ",
                                    "                 AND icaa003 = 1 ",
                                    "                 AND icab002 = 0 ",
                                    "                 AND icab003 = '",g_site,"')",
                                    "   OR EXISTS (SELECT xmdadocno FROM xmda_t ",
                                    "               WHERE xmdaent = xmdkent ",
                                    "                 AND xmdadocno = xmdl003 ",
                                    "                 AND xmda006 = '3' ))"
               CALL q_xrcadocno_9()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcadocno  #顯示到畫面上
               NEXT FIELD xrcadocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD xrca004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()
               DISPLAY g_qryparam.return1 TO xrca004
               NEXT FIELD xrca004
               
            ON ACTION controlp INFIELD xrca047
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_xrca047()
               DISPLAY g_qryparam.return1 TO xrca047
               NEXT FIELD xrca047                     #返回原欄位
               
            ON ACTION controlp INFIELD xrcaownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcaownid  #顯示到畫面上
               NEXT FIELD xrcaownid
               
            ON ACTION controlp INFIELD xrcacrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcacrtid  #顯示到畫面上
               NEXT FIELD xrcacrtid                     #返回原欄位

         END CONSTRUCT
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
               CALL aicp560_fetch()       
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               
            ON ROW CHANGE
               UPDATE aicp560_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xrcadocno = g_detail_d[l_ac].xrcadocno
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
            UPDATE aicp560_tmp 
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
            UPDATE aicp560_tmp 
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
                  UPDATE aicp560_tmp 
                     SET sel = 'Y' 
                    WHERE xrcadocno = g_detail_d[li_idx].xrcadocno
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
                  UPDATE aicp560_tmp 
                     SET sel = 'N' 
                    WHERE xrcadocno = g_detail_d[li_idx].xrcadocno
               END IF
            END FOR 
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp560_filter()
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
            CALL aicp560_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp560_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            UPDATE aicp560_tmp
               SET sel = g_detail_d[l_ac].sel
             WHERE xrcadocno = g_detail_d[l_ac].xrcadocno
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp560_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            ELSE
#               CALL aicp560_process()
               CALL aicp560_query()
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
 
{<section id="aicp560.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp560_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
DELETE FROM aicp560_tmp;

   LET g_sql = "SELECT DISTINCT xrcaent,xrcald,'N',xrcadocno,xrcadocdt,xrca004,xrca047,xrcaownid,xrcacrtid ",
               "  FROM xrca_t,xrcb_t,xmdl_t,xmdk_t ",
               " WHERE xrcaent = '",g_enterprise,"' ",
               "   AND xrcbent = xrcaent ",
               "   AND xrcbld = xrcald ",
               "   AND xrcbdocno = xrcadocno ",
               "   AND xmdldocno = xrcb002 ",
               "   AND xmdlseq = xrcb003 ",
               "   AND xmdlent = xrcbent ",
               "   AND xmdkent = xmdlent ",
               "   AND xmdkdocno = xmdldocno ",
               "   AND ",g_wc,
               #因目前多角尚未完善 多角序號幾乎為空，若加入下行mark掉的條件會完全沒有資料，所以先行mark以確認其他條件是否正確
               #"     xrca047 IS NOT NULL ",
               "   AND (EXISTS (SELECT icaa001 FROM icaa_t,icab_t ",
               "                 WHERE icabent = icaaent ",
               "                   AND icab001 = icaa001 ",
               "                   AND icaa001 = xmdk044 ",
               "                   AND icaa003 = 1 ",
               "                   AND icab002 = 0 ",
               "                   AND icab003 = '",g_site,"')",
               "     OR EXISTS (SELECT xmdadocno FROM xmda_t ",
               "                 WHERE xmdaent = xmdkent ",
               "                   AND xmdadocno = xmdl003 ",
               "                 AND xmda006 = '3' ))"
   LET g_sql = "INSERT INTO aicp560_tmp ",
               "   (xrcaent,xrcald,sel,xrcadocno,xrcadocdt,xrca004,xrca047,xrcaownid,xrcacrtid) ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp560_b_fill()
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
 
{<section id="aicp560.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp560_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT 'N',xrcadocno,xrcadocdt,xrca004,a1.pmaal004,xrca047, ",
               "                    xrcaownid,b1.ooag011,xrcacrtid,b2.ooag011,xrcald ",
               "  FROM aicp560_tmp ",
               "       LEFT OUTER JOIN pmaal_t a1 ON a1.pmaalent = '",g_enterprise,"' AND a1.pmaal001 = xrca004 AND a1.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN ooag_t  b1 ON b1.ooagent  = '",g_enterprise,"' AND b1.ooag001 = xrcaownid ",
               "       LEFT OUTER JOIN ooag_t  b2 ON b2.ooagent  = '",g_enterprise,"' AND b2.ooag001 = xrcacrtid ",
               " WHERE xrcaent = ? AND ",g_wc_filter,
               " ORDER BY xrcadocno "
   #end add-point
 
   PREPARE aicp560_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp560_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].xrcadocno,g_detail_d[l_ac].xrcadocdt,
   g_detail_d[l_ac].xrca004,g_detail_d[l_ac].xrca004_desc,g_detail_d[l_ac].xrca047,
   g_detail_d[l_ac].xrcaownid,g_detail_d[l_ac].xrcaownid_desc,
   g_detail_d[l_ac].xrcacrtid,g_detail_d[l_ac].xrcacrtid_desc,g_xrca_d[l_ac].xrcald
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
      
      CALL aicp560_detail_show()      
 
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
   FREE aicp560_sel
   
   LET l_ac = 1
   CALL aicp560_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp560.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp560_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_xmdldocno     LIKE xmdl_t.xmdldocno
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_icaa003       LIKE icaa_t.icaa003
   DEFINE l_site          LIKE icab_t.icab003
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT xrcbseq,xrcb002,xrcb003,xrcb004,imaal003,imaal004, ",
               "       xrcb007,xrcb101,xrcb103,xrcb105 ",
               "  FROM xrcb_t ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = xmdlent AND imaal001 = xrcb004 AND imaal002 = '",g_dlang,"' ",
               " WHERE xrcbent = '",g_enterprise,"'",
               "   AND xrcbdocno = '",g_detail_d[g_master_idx].xrcadocno,"' ",
               "   AND xrcbld = '",g_xrca_d[g_master_idx].xrcald,"' ",
               " ORDER BY xrcbseq "
   PREPARE xrcb_fill_pre FROM g_sql
   DECLARE xrcb_fill_cur CURSOR FOR xrcb_fill_pre
   
   FOREACH xrcb_fill_cur INTO 
      g_detail2_d[l_ac].xrcbseq,g_detail2_d[l_ac].xrcb002,g_detail2_d[l_ac].xrcb003,
      g_detail2_d[l_ac].xrcb004,g_detail2_d[l_ac].xrcb004_desc,g_detail2_d[l_ac].xrcb004_desc_1,
      g_detail2_d[l_ac].xrcb007,g_detail2_d[l_ac].xrcb101,g_detail2_d[l_ac].xrcb103,
      g_detail2_d[l_ac].xrcb105
   
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
 
{<section id="aicp560.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp560_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp560.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp560_filter()
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
   #shiun a
   CONSTRUCT g_wc_filter ON xrcadocno,xrcadocdt,xrca004,xrca047,xrcaownid,xrcacrtid
        FROM s_detail1[1].b_xrcadocno,s_detail1[1].b_xrcadocdt,s_detail1[1].b_xrca004,
             s_detail1[1].b_xrca047,s_detail1[1].b_xrcaownid,s_detail1[1].b_xrcacrtid
           
      BEFORE CONSTRUCT
      
            ON ACTION controlp INFIELD b_xrcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = #"     xrca047 IS NOT NULL ",
                                    " AND (EXISTS (SELECT icaa001 FROM icaa_t,icab_t ",
                                    "               WHERE icabent = icaaent ",
                                    "                 AND icab001 = icaa001 ",
                                    "                 AND icaa001 = xmdk044 ",
                                    "                 AND icaa003 = 1 ",
                                    "                 AND icab002 = 0 ",
                                    "                 AND icab003 = '",g_site,"')",
                                    "   OR EXISTS (SELECT xmdadocno FROM xmda_t ",
                                    "               WHERE xmdaent = xmdkent ",
                                    "                 AND xmdadocno = xmdl003 ",
                                    "                 AND xmda006 = '3' ))"
               CALL q_xrcadocno_9()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcadocno  #顯示到畫面上
               NEXT FIELD b_xrcadocno                   #返回原欄位    
               
            ON ACTION controlp INFIELD b_xrca004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca004  #顯示到畫面上
               NEXT FIELD b_xrca004                   #返回原欄位
               
            ON ACTION controlp INFIELD b_xrca047
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xrca047()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk004  #顯示到畫面上
               NEXT FIELD b_xmdk004                   #返回原欄位
               
            ON ACTION controlp INFIELD b_xrcaownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcaownid  #顯示到畫面上
               NEXT FIELD b_xrcaownid                   #返回原欄位
   
            ON ACTION controlp INFIELD b_xrcacrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcacrtid   #顯示到畫面上
               NEXT FIELD b_xrcacrtid                    #返回原欄位

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp560_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp560.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp560_filter_parser(ps_field)
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
 
{<section id="aicp560.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp560_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp560_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp560.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: create_temp_table
# Memo...........:
# Usage..........:
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/11/04 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp560_create_temp_table()
   DROP TABLE aicp560_tmp;
   CREATE TEMP TABLE aicp560_tmp(
       xrcaent     SMALLINT,
       xrcald      VARCHAR(5),       
       sel         VARCHAR(1),
       xrcadocno   VARCHAR(20),
       xrcadocdt   DATE,
       xrca004     VARCHAR(10),
       xrca047     VARCHAR(20),
       xrcaownid   VARCHAR(20),
       xrcacrtid   VARCHAR(20)
       );
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp560_process()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/11/06 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp560_process()
DEFINE l_xrca            type_g_detail_d
DEFINE l_xrcald          LIKE xrca_t.xrcald
DEFINE l_xmdkdocno       LIKE xmdk_t.xmdkdocno
DEFINE l_xmdk044         LIKE xmdk_t.xmdk044   #多角代碼
DEFINE l_icab002_now     LIKE icab_t.icab002   #當站站別
DEFINE l_icab003_now     LIKE icab_t.icab003   #當站營運據點
DEFINE l_icab004_now     LIKE icab_t.icab004   #當站委外工單開立點否
DEFINE l_icab002_next    LIKE icab_t.icab002   #下站站別
DEFINE l_icab003_next    LIKE icab_t.icab003   #下站營運據點 
DEFINE l_success         LIKE type_t.num5      #回傳執行結果
DEFINE l_success1        LIKE type_t.num5
DEFINE l_date            LIKE type_t.dat
#   #有選擇的應收單據
#   LET g_sql = "SELECT xrcadocno,xrcadocdt,xrca004,xrca047,xrcald ",
#               "  FROM aicp560_tmp ",
#               " WHERE sel = 'Y' ",
#               " ORDER BY xrcadocno "
#   PREPARE aicp560_process_pre FROM g_sql
#   DECLARE aicp560_process_cur CURSOR WITH HOLD FOR aicp560_process_pre
#   
#   #當站多角貿易營運據點
#   LET g_sql = "SELECT icab002,icab003,icab004",
#               "  FROM icab_t",
#               " WHERE icabent = '",g_enterprise,"'",
#               "   AND icab001 = ?",
#               " ORDER BY icab002"
#   PREPARE aicp560_process_icab_pre FROM g_sql
#   DECLARE aicp560_process_icab_cur CURSOR FOR aicp560_process_icab_pre
#   
#   #下站多角貿易營運據點
#   LET g_sql = "SELECT icab002,icab003",
#               "  FROM icab_t",
#               " WHERE icabent = '",g_enterprise,"'",
#               "   AND icab001 = ?",
#               "   AND icab002 > ?",
#               " ORDER BY icab002"
#   PREPARE aicp560_process_icab_next_pre FROM g_sql
#   DECLARE aicp560_process_icab_next_cur CURSOR FOR aicp560_process_icab_next_pre
#   
#   LET l_success = TRUE
#   CALL s_aic_carry_create_temp_table_xmd()
#        RETURNING l_success
#   IF NOT l_success THEN
#      RETURN
#   END IF
#   CALL s_aic_carry_create_temp_table_order()
#        RETURNING l_success
#   IF NOT l_success THEN
#      RETURN
#   END IF
#
#   LET g_success_cnt = 1
#   LET g_fail_cnt = 0
#   CALL g_detail3_d.clear()
#   CALL g_detail4_d.clear()
#   CALL cl_showmsg_init()
#   
#   FOREACH aicp560_process_cur INTO l_xrca.xrcadocno,l_xrca.xrcadocdt,l_xrca.xrca004,l_xrca.xrca047,l_xrcald   
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'process_cur'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         EXIT FOREACH
#      END IF
#      #以下皆為複製後內容未修改
#      CALL s_transaction_begin()
#      LET g_fail_cnt = g_err_msg.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
#      LET l_success = TRUE
#      LET l_xmdk035 = ''
#      
#      IF cl_null(l_xmdk044) THEN
#         CALL cl_errmsg('pmdldocno',l_pmdldocno,'','aic-00026',1)#多角流程代碼不能為空
#         LET l_success = FALSE
#         CALL s_transaction_end('N',0)
#         #失敗記錄
#         CALL aicp560_fail(l_xmdkdocno,l_xmdkdocdt,l_xmdk007,l_xmdk003,l_xmdk004,l_xmdk035)
#         CONTINUE FOREACH
#      END IF
#      
##      IF l_pmdl006 = '3' AND cl_null(l_pmdl052) THEN
##         CALL cl_errmsg('pmdldocno',l_pmdldocno,'','aic-00086',1)#當多角性質為3.代採購指定供應商時，最終供應商不可為空
##         LET l_success = FALSE
##         CALL s_transaction_end('N',0)
##         #失敗記錄
##         CALL aicp5600_fail(l_pmdldocno,l_pmdldocdt,l_pmdl004,l_pmdl002,l_pmdl003,l_trino,l_pmdl052)
##         CONTINUE FOREACH
##      END IF
#      
#      #呼叫產生多角序號元件取得多角流程序號，並回寫採購單單頭pmdl031
#      CALL s_aic_carry_gettrino(l_pmdl051,'1',g_today,g_site)
#           RETURNING l_success1,l_trino
#      IF NOT l_success1 THEN
#         CALL cl_errmsg('pmdldocno',l_pmdldocno,'','amm-00001',1)
#         LET l_success = FALSE
#         CALL s_transaction_end('N',0)
#         #失敗記錄
#         CALL aicp200_fail(l_pmdldocno,l_pmdldocdt,l_pmdl004,l_pmdl002,l_pmdl003,l_trino,l_pmdl052)
#         CONTINUE FOREACH
#      END IF
#      
#      #回寫採購單頭多角流程序號、多角流程代碼、最終供應商
#      UPDATE pmdl_t SET pmdl030 = 'Y',
#                        pmdl031 = l_trino,
#                        pmdl051 = l_pmdl051,
#                        pmdl052 = l_pmdl052
#       WHERE pmdlent = g_enterprise
#         AND pmdldocno = l_pmdldocno
#      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('pmdldocno',l_pmdldocno,'',SQLCA.sqlcode,1)
#         LET l_success = FALSE
#         CALL s_transaction_end('N',0)
#         #失敗記錄
#         CALL aicp200_fail(l_pmdldocno,l_pmdldocdt,l_pmdl004,l_pmdl002,l_pmdl003,l_trino,l_pmdl052)
#         CONTINUE FOREACH
#      END IF
#      
#      LET l_site = g_site
#      
#      #跑站(當站)
#      OPEN aicp200_process_icab_cur USING l_pmdl051
#      FOREACH aicp200_process_icab_cur INTO l_icab002_now,l_icab003_now,l_icab004_now
#         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('pmdldocno',l_pmdldocno,'',SQLCA.sqlcode,1)
#            LET l_success = FALSE
#            EXIT FOREACH
#         END IF
#         
#         #若站別為第0站，不做處理
#         IF l_icab002_now = 0 THEN
#            LET l_returndocno = l_pmdldocno
#            CONTINUE FOREACH
#         END IF
#         
#         #取下站
#         LET l_icab002_next = ''
#         LET l_icab003_next = ''
#         OPEN aicp200_process_icab_next_cur USING l_pmdl051,l_icab002_now
#         FOREACH aicp200_process_icab_next_cur INTO l_icab002_next,l_icab003_next
#            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('pmdldocno',l_pmdldocno,'',SQLCA.sqlcode,1)
#               LET l_success = FALSE
#               EXIT FOREACH
#            END IF            
#            EXIT FOREACH
#         END FOREACH
#         
#         IF NOT l_success THEN
#            EXIT FOREACH
#         END IF
#         
#         #若站別為中間站(即不是第0站也不是最終站)，呼叫 s_aic_carry_gen_tri_so,產生中間站之多角訂單
#         IF NOT cl_null(l_icab002_next) THEN
#            LET l_pmdldocdt = NULL
#            SELECT pmdldocdt INTO l_pmdldocdt_1
#              FROM pmdl_t
#             WHERE pmdlent = g_enterprise
#               AND pmdldocno = l_returndocno
#            CALL s_aic_carry_gen_tri_so(l_site,l_returndocno,'N',l_pmdldocdt_1,l_pmdl051,l_icab002_now,'')
#                 RETURNING l_success,l_returndocno
#         
#            IF l_success THEN
#               LET l_xmdadocdt = NULL
#               SELECT xmdadocdt INTO l_xmdadocdt 
#                 FROM xmda_t
#                WHERE xmdaent = g_enterprise
#                  AND xmdadocno = l_returndocno
#                  
#               #委外工單開立點
#               IF l_icab004_now = 'Y' THEN
#                  #產生來源站之委外工單及多角採購單
#                  CALL s_aic_carry_gen_tri_wo(l_returndocno,l_icab003_next,'N',l_xmdadocdt,l_pmdl051,l_icab002_now)
#                       RETURNING l_success,l_returndocno
#               ELSE
#                  #產生來源站之委外多角採購單
#                  CALL s_aic_carry_gen_tri_po(l_pmdldocno,'',l_returndocno,l_icab003_next,'N',l_xmdadocdt,l_pmdl051,l_icab002_now)
#                       RETURNING l_success,l_returndocno
#               END IF
#            END IF
#            
#            LET l_site = l_icab003_now
#            
#         ELSE   #若為最終站
#            LET l_pmdldocdt = NULL
#            SELECT pmdldocdt INTO l_pmdldocdt_1
#              FROM pmdl_t
#             WHERE pmdlent = g_enterprise
#               AND pmdldocno = l_returndocno
#            
#            #產生最終站之多角訂單
#            CALL s_aic_carry_gen_tri_so(l_site,l_returndocno,'Y',l_pmdldocdt_1,l_pmdl051,l_icab002_now,'')
#                 RETURNING l_success,l_returndocno
#               
#            #若"多角性質"=3.代採購指定供應商，呼叫 s_aic_carry_gen_last_po 產生最終供應商之一般採購單
#            IF l_success AND l_pmdl006 = '3' THEN
#               LET l_xmdadocdt = NULL
#               SELECT xmdadocdt INTO l_xmdadocdt 
#                 FROM xmda_t
#                WHERE xmdaent = g_enterprise
#                  AND xmdadocno = l_returndocno
#                  
#               CALL s_aic_carry_gen_last_po(l_returndocno,l_pmdl052,l_xmdadocdt,l_pmdl051,l_icab002_now)
#                    RETURNING l_success,l_returndocno
#            END IF
#         END IF
#         
#         IF NOT l_success THEN
#            EXIT FOREACH
#         END IF
#      END FOREACH
#      
#      IF l_success THEN
#         CALL s_transaction_end('Y',0)
#         #成功記錄
#         CALL aicp200_success(l_pmdldocno,l_pmdldocdt,l_pmdl004,l_pmdl002,l_pmdl003,l_trino)
#      ELSE
#         CALL s_transaction_end('N',0)
#         #失敗記錄
#         CALL aicp200_fail(l_pmdldocno,l_pmdldocdt,l_pmdl004,l_pmdl002,l_pmdl003,l_trino,l_pmdl052)
#      END IF
#   END FOREACH
#   
#   IF g_bgjob = 'N' THEN
#      CALL cl_ask_pressanykey("std-00012")
#   END IF
END FUNCTION

################################################################################
# Descriptions...: 成功記錄
# Memo...........:
# Usage..........: CALL aicp560_success (p_xrca)
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/11/12 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp560_success(p_xrca)
DEFINE p_xrca            type_g_detail_d

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF

   LET g_detail3_d[g_success_cnt].xrcadocno1 = p_xrca.xrcadocno
   LET g_detail3_d[g_success_cnt].xrcadocdt1 = p_xrca.xrcadocdt
   LET g_detail3_d[g_success_cnt].xrca0041 = p_xrca.xrca004
   LET g_detail3_d[g_success_cnt].xrca0471 = p_xrca.xrca047
   LET g_detail3_d[g_success_cnt].xrcaownid1 = p_xrca.xrcaownid
   LET g_detail3_d[g_success_cnt].xrcacrtid1 = p_xrca.xrcacrtid
   
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xrca0041) 
        RETURNING g_detail3_d[g_success_cnt].xrca0041_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xrcaownid1)
        RETURNING g_detail3_d[g_success_cnt].xrcaownid1_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xrcacrtid1)
        RETURNING g_detail3_d[g_success_cnt].xrcacrtid1_desc
        
   LET g_success_cnt = g_success_cnt +  1
END FUNCTION

################################################################################
# Descriptions...: 失敗記錄
# Memo...........:
# Usage..........: CALL aicp560_fail(p_xrca)
# Input parameter:
# Return code....:
# Date & Author..: 2014/11/12 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp560_fail(p_xrca)
DEFINE p_xrca            type_g_detail_d
DEFINE l_errcode         LIKE gzze_t.gzze001
DEFINE l_i               LIKE type_t.num5

   IF cl_null(g_fail_cnt) THEN
      LET g_fail_cnt = 0
   END IF
   
   FOR l_i = g_fail_cnt+1 TO g_err_msg.getLength()
      LET g_detail4_d[l_i].xrcadocno2 = p_xrca.xrcadocno
      LET g_detail4_d[l_i].xrcadocdt2 = p_xrca.xrcadocdt
      LET g_detail4_d[l_i].xrca0042 = p_xrca.xrca004
      LET g_detail4_d[l_i].xrca0472 = p_xrca.xrca047
      LET g_detail4_d[l_i].xrcaownid2 = p_xrca.xrcaownid
      LET g_detail4_d[l_i].xrcacrtid2 = p_xrca.xrcacrtid

      
      #錯誤訊息
      LET l_errcode = g_err_msg[l_i].fld4
      LET g_detail4_d[l_i].reason = cl_getmsg(l_errcode,g_dlang)
      
      CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[l_i].xrca0041) 
        RETURNING g_detail3_d[l_i].xrca0041_desc
      CALL s_desc_get_person_desc(g_detail3_d[l_i].xrcaownid1)
           RETURNING g_detail3_d[l_i].xrcaownid1_desc
      CALL s_desc_get_person_desc(g_detail3_d[l_i].xrcacrtid1)
           RETURNING g_detail3_d[l_i].xrcacrtid1_desc
   END FOR
END FUNCTION

#end add-point
 
{</section>}
 
