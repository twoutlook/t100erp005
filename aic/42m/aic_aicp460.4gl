#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp460.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-11-07 15:03:00), PR版次:0002(2017-01-12 10:01:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: aicp460
#+ Description: 代採買應收付拋轉還原作業
#+ Creator....: 04441(2014-11-07 09:16:09)
#+ Modifier...: 04441 -SD/PR- 08992
 
{</section>}
 
{<section id="aicp460.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161231-00013#1  2016/01/11 By 08992   增加azzi850 部門權限控管
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
    sel                LIKE type_t.chr1,
    apcadocno          LIKE apca_t.apcadocno,
    apcadocdt          LIKE apca_t.apcadocdt,
    apca004            LIKE apca_t.apca004,
    apca004_desc       LIKE type_t.chr80,
    apca047            LIKE apca_t.apca047,
    apcaownid          LIKE apca_t.apcaownid,
    apcaownid_desc     LIKE type_t.chr80,
    apcacrtid          LIKE apca_t.apcacrtid,
    apcacrtid_desc     LIKE type_t.chr80
                   END RECORD

TYPE type_g_detail2_d  RECORD
    apcb002            LIKE apcb_t.apcb002,
    apcb003            LIKE apcb_t.apcb003,
    apcb004            LIKE apcb_t.apcb004,
    apcb004_desc       LIKE type_t.chr80,
    apcb004_desc_desc  LIKE type_t.chr80,
    apcb007            LIKE apcb_t.apcb007,
    apcb101            LIKE apcb_t.apcb101,
    apcb103            LIKE apcb_t.apcb103,
    apcb105            LIKE apcb_t.apcb105
                   END RECORD

TYPE type_g_detail3_d  RECORD
    apcadocno1         LIKE apca_t.apcadocno,
    apcadocdt1         LIKE apca_t.apcadocdt,
    apca0041           LIKE apca_t.apca004,
    apca0041_desc      LIKE type_t.chr80,
    apca0471           LIKE apca_t.apca047,
    apcaownid1         LIKE apca_t.apcaownid,
    apcaownid1_desc    LIKE type_t.chr80,
    apcacrtid1         LIKE apca_t.apcacrtid,
    apcacrtid1_desc    LIKE type_t.chr80
                   END RECORD

TYPE type_g_detail4_d  RECORD
    apcadocno2         LIKE apca_t.apcadocno,
    apcadocdt2         LIKE apca_t.apcadocdt,
    apca0042           LIKE apca_t.apca004,
    apca0042_desc      LIKE type_t.chr80,
    apca0472           LIKE apca_t.apca047,
    reason             LIKE type_t.chr500
                      END RECORD

DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail4_d  DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail2_idx     LIKE type_t.num5
DEFINE g_detail3_idx     LIKE type_t.num5
DEFINE g_detail4_idx     LIKE type_t.num5
DEFINE g_detail2_cnt     LIKE type_t.num5
DEFINE g_detail3_cnt     LIKE type_t.num5
DEFINE g_detail4_cnt     LIKE type_t.num5

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp460.main" >}
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
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp460 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp460_init()   
 
      #進入選單 Menu (="N")
      CALL aicp460_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE aicp460_tmp
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp460
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp460.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp460_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   CREATE TEMP TABLE aicp460_tmp( 
       sel         VARCHAR(1),
       apcaent     SMALLINT,
       apcadocno   VARCHAR(20),
       apcadocdt   DATE,
       apca004     VARCHAR(10),
       apca047     VARCHAR(20),
       apcaownid   VARCHAR(20),
       apcacrtid   VARCHAR(20))
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp460.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp460_ui_dialog()
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
   LET g_wc = "1=1"
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aicp460_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"

         CONSTRUCT BY NAME g_wc ON apcadocno,apcadocdt,apca004,apca047,apcaownid,apcacrtid

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD apcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_apcadocno()
               DISPLAY g_qryparam.return1 TO apcadocno
               NEXT FIELD apcadocno
               
            ON ACTION controlp INFIELD apca004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001()
               DISPLAY g_qryparam.return1 TO apca004
               NEXT FIELD apca004

            ON ACTION controlp INFIELD apcaownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO apcaownid
               NEXT FIELD apcaownid

            ON ACTION controlp INFIELD apcacrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO apcacrtid
               NEXT FIELD apcacrtid
   
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)

            BEFORE INPUT
               LET g_detail_cnt = g_detail_d.getLength()

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL aicp460_fetch()               

            ON CHANGE b_sel
               UPDATE aicp460_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE apcadocno = g_detail_d[l_ac].apcadocno
                  
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
              
         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")
              
         END DISPLAY

         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail4_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET g_detail4_idx = DIALOG.getCurrentRow("s_detail4")
              
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
            UPDATE aicp460_tmp 
               SET sel = 'Y'
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
            UPDATE aicp460_tmp 
               SET sel = 'N'
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp460_tmp 
                     SET sel = 'Y' 
                   WHERE apcadocno = g_detail_d[li_idx].apcadocno
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
                  UPDATE aicp460_tmp 
                     SET sel = 'N' 
                   WHERE apcadocno = g_detail_d[li_idx].apcadocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp460_filter()
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
            CALL aicp460_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp460_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp460_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            ELSE
               CALL aicp460_process()
               CALL aicp460_query()
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
 
{<section id="aicp460.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp460_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM aicp460_tmp

   #將符合條件之aapt300且單頭"交易序號"不為空白
   #入庫單單身"多角流程代碼"於aici100 "流程類型"欄位(icaa003)='2' or '3'
   #且aici100 [流程定義]頁籤設定之第0站營運據點=g_site 或 入庫單單身"採購多角性質"='4'統購統付
   LET g_sql = "SELECT DISTINCT 'N',apcaent,apcadocno,apcadocdt,apca004,apca047,apcaownid,apcacrtid ",
               "  FROM apca_t,apcb_t,pmdt_t,icaa_t,icab_t ",
              #" WHERE apcaent = '",g_enterprise,"' AND apca047 IS NOT NULL AND ",g_wc,                                          #161231-00013#1 mark
               " WHERE apcaent = '",g_enterprise,"' AND apca047 IS NOT NULL AND ",g_wc,g_enterprise,cl_sql_add_filter("apca_t"), #161231-00013#1 add
               "   AND apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
               "   AND apcb001='11' ",
               "   AND apcbent=pmdtent AND apcb002=pmdtdocno AND apcb003=pmdtseq ",
               "   AND icaaent=pmdtent AND icaa001=pmdt085 AND icaa003 IN ('2','3') ",
               "   AND (icabent=icaaent AND icab001=icaa001 AND icab002='0' AND icab003='",g_site,"' OR pmdt086='4') "
   LET g_sql = "INSERT INTO aicp460_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre

   LET g_wc_filter = " 1=1"
   
   #end add-point
        
   LET g_error_show = 1
   CALL aicp460_b_fill()
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
 
{<section id="aicp460.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp460_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT sel,apcadocno,apcadocdt,apca004,pmaal003,apca047,apcaownid,a.ooag011,apcacrtid,b.ooag011 ",
               "  FROM aicp460_tmp ",
               "       LEFT OUTER JOIN pmaal_t ON pmaalent = '",g_enterprise,"' AND pmaal001 = apca004 AND pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN ooag_t a ON a.ooagent = '",g_enterprise,"' AND a.ooag001 = apcaownid ",
               "       LEFT OUTER JOIN ooag_t b ON b.ooagent = '",g_enterprise,"' AND b.ooag001 = apcacrtid ",
               " WHERE apcaent=? AND ",g_wc_filter,
               " ORDER BY apcadocno,apcadocdt "

   #end add-point
 
   PREPARE aicp460_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp460_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_master_idx = 1
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].apcadocno,g_detail_d[l_ac].apcadocdt,g_detail_d[l_ac].apca004,
   g_detail_d[l_ac].apca047,g_detail_d[l_ac].apcaownid,g_detail_d[l_ac].apcacrtid
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
      
      CALL aicp460_detail_show()      
 
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
   FREE aicp460_sel
   
   LET l_ac = 1
   CALL aicp460_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp460.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp460_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   
   LET g_sql = "SELECT apcb002,apcb003,apcb004,imaal003,imaal004,apcb007,apcb101,apcb103,apcb105 ",
               "  FROM apcb_t ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = apcbent AND imaal001 = apcb004 AND imaal002 = '",g_dlang,"' ",
               " WHERE apcbent = '",g_enterprise,"' ",
               "   AND apcbdocno = '",g_detail_d[g_master_idx].apcadocno,"' "
   PREPARE apcb_fill_pre FROM g_sql
   DECLARE apcb_fill_cur CURSOR FOR apcb_fill_pre
   
   CALL g_detail2_d.clear()
   LET l_ac = 1
   
   FOREACH apcb_fill_cur INTO g_detail2_d[l_ac].apcb002,g_detail2_d[l_ac].apcb003,
      g_detail2_d[l_ac].apcb004,g_detail2_d[l_ac].apcb004_desc,g_detail2_d[l_ac].apcb004_desc_desc,
      g_detail2_d[l_ac].apcb007,g_detail2_d[l_ac].apcb101,g_detail2_d[l_ac].apcb103,g_detail2_d[l_ac].apcb105
   
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
   LET g_detail2_cnt = l_ac - 1 

   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp460.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp460_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp460.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp460_filter()
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
   
   CONSTRUCT g_wc_filter ON apcadocno,apcadocdt,apca004,apca047,apcaownid,apcacrtid
        FROM s_detail1[1].b_apcadocno,s_detail1[1].b_apcadocdt,s_detail1[1].b_apca004,
             s_detail1[1].b_apca047,s_detail1[1].b_apcaownid,s_detail1[1].b_apcacrtid
      
      BEFORE CONSTRUCT
   
      ON ACTION controlp INFIELD apcadocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_apcadocno()
         DISPLAY g_qryparam.return1 TO apcadocno
         NEXT FIELD apcadocno
         
      ON ACTION controlp INFIELD apca004
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pmaa001()
         DISPLAY g_qryparam.return1 TO apca004
         NEXT FIELD apca004
   
      ON ACTION controlp INFIELD apcaownid
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()
         DISPLAY g_qryparam.return1 TO apcaownid
         NEXT FIELD apcaownid
   
      ON ACTION controlp INFIELD apcacrtid
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()
         DISPLAY g_qryparam.return1 TO apcacrtid
         NEXT FIELD apcacrtid
   
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp460_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp460.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp460_filter_parser(ps_field)
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
 
{<section id="aicp460.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp460_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp460_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp460.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 將來源據點之多角入庫單產生各站之應收付單據取消確認並刪除
# Memo...........:
# Usage..........: CALL aicp460_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 141107 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp460_process()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_apca  RECORD
    apcadocno  LIKE apca_t.apcadocno,
    apcadocdt  LIKE apca_t.apcadocdt,
    apca004    LIKE apca_t.apca004,
    apca047    LIKE apca_t.apca047,
    apcaownid  LIKE apca_t.apcaownid,
    apcacrtid  LIKE apca_t.apcacrtid
           END RECORD
DEFINE l_apcald       LIKE apca_t.apcald     #帳別
DEFINE l_apcadocno    LIKE apca_t.apcadocno  #應付憑單單號
DEFINE l_xrcald       LIKE xrca_t.xrcald     #帳別
DEFINE l_xrcadocno    LIKE xrca_t.xrcadocno  #應收憑單單號

   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
   END IF

   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('aicp460',"lbl_apca.apca047") RETURNING g_coll_title[1],g_coll_title[1]    #交易序號
   CALL s_azzi902_get_gzzd('aicp460',"lbl_apcadocno") RETURNING g_coll_title[2],g_coll_title[2]  #應付憑單單號
   CALL s_azzi902_get_gzzd('axrt300',"lbl_xrcadocno") RETURNING g_coll_title[3],g_coll_title[3]  #應收單號
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()

   LET g_success_cnt = 1
   LET g_fail_cnt = 0

   #有選擇的應付帳款單單頭"交易序號"
   LET g_sql = " SELECT apcadocno,apcadocdt,apca004,apca047,apcaownid,apcacrtid ",
               "   FROM aicp460_tmp ",
               "  WHERE sel = 'Y' "
   PREPARE aicp460_process_pre FROM g_sql
   DECLARE aicp460_process_cur CURSOR WITH HOLD FOR aicp460_process_pre

   #各站之應付憑單符合上述之"交易序號"者
   LET g_sql = " SELECT apcald,apcadocno ",
               "   FROM apca_t ",
               "  WHERE apcaent = '",g_enterprise,"' ",
               "    AND apca047 = ? "
   PREPARE aicp460_process_apca_pre FROM g_sql
   DECLARE aicp460_process_apca_cur CURSOR WITH HOLD FOR aicp460_process_apca_pre

   #各站之應收憑單單頭符合上述之"交易序號"者
   LET g_sql = " SELECT xrcald,xrcadocno ",
               "   FROM xrca_t ",
               "  WHERE xrcaent = '",g_enterprise,"' ",
               "    AND xrca047 = ? "
   PREPARE aicp460_process_xrca_pre FROM g_sql
   DECLARE aicp460_process_xrca_cur CURSOR WITH HOLD FOR aicp460_process_xrca_pre

   #將各站之應付憑單及應收憑單單頭符合"交易序號"者,進行取消確認並刪除
   INITIALIZE l_apca.* TO NULL
   FOREACH aicp460_process_cur INTO l_apca.apcadocno,l_apca.apcadocdt,l_apca.apca004,
                                    l_apca.apca047,l_apca.apcaownid,l_apca.apcacrtid
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET g_fail_cnt = g_errcollect.getLength()
      LET l_tot_success = TRUE
      LET l_success = TRUE
      CALL s_transaction_begin()

      LET l_apcald = ''
      LET l_apcadocno = ''
      FOREACH aicp460_process_apca_cur USING l_apca.apca047 INTO l_apcald,l_apcadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'process_cur'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_apca.apca047
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         CALL s_aapt300_unconf_chk(l_apcald,l_apcadocno) RETURNING l_success
         IF l_success THEN
            CALL s_aapt300_unconf_upd(l_apcald,l_apcadocno) RETURNING l_success
            IF l_success THEN
               CALL aicp460_del_apca(l_apcald,l_apcadocno) RETURNING l_success
            END IF
         END IF

         LET l_apcald = ''
         LET l_apcadocno = ''
      END FOREACH

      IF NOT l_success THEN
         LET l_tot_success = FALSE
         LET l_success = TRUE
      END IF

      LET l_xrcald = ''
      LET l_xrcadocno = ''
      FOREACH aicp460_process_xrca_cur USING l_apca.apca047 INTO l_xrcald,l_xrcadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'process_cur'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_apca.apca047
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         CALL s_axrt300_confirm(l_xrcald,l_xrcadocno) RETURNING l_success
         IF l_success THEN
            CALL aicp460_del_xrca(l_apcald,l_apcadocno) RETURNING l_success
         END IF

         LET l_xrcald = ''
         LET l_xrcadocno = ''
      END FOREACH

      IF NOT l_success THEN
         LET l_tot_success = FALSE
      END IF

      IF l_tot_success THEN
         CALL s_transaction_end('Y',0)
         CALL aicp460_success(l_apca.apcadocno,l_apca.apcadocdt,l_apca.apca004,l_apca.apca047,l_apca.apcaownid,l_apca.apcacrtid)
      ELSE
         CALL s_transaction_end('N',0)
         CALL aicp460_fail(l_apca.apcadocno,l_apca.apcadocdt,l_apca.apca004,l_apca.apca047)
      END IF
      
      INITIALIZE l_apca.* TO NULL
   END FOREACH
   
   CALL cl_err_collect_show()

   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF

END FUNCTION

################################################################################
# Descriptions...: 刪除應付憑單
# Memo...........:
# Usage..........: CALL aicp460_del_apca(p_apcald,p_apcadocno)
#                  RETURNING r_success
# Input parameter: p_apcald      帳別
#                : p_apcadocno   應付帳款單號碼
# Return code....: TRUE OR FALSE
# Date & Author..: 141107 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp460_del_apca(p_apcald,p_apcadocno)
DEFINE p_apcald     LIKE apca_t.apcald
DEFINE p_apcadocno  LIKE apca_t.apcadocno
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

   DELETE FROM apca_t WHERE apcaent = g_enterprise AND apcald = p_apcald AND apcadocno = p_apcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete apca_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[2] = p_apcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM apcb_t WHERE apcbent = g_enterprise AND apcbld = p_apcald AND apcbdocno = p_apcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete apcb_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[2] = p_apcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM apcc_t WHERE apccent = g_enterprise AND apccld = p_apcald AND apccdocno = p_apcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete apcc_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[2] = p_apcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM apce_t WHERE apceent = g_enterprise AND apceld = p_apcald AND apcedocno = p_apcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete apce_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[2] = p_apcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM apcf_t WHERE apcfent = g_enterprise AND apcfld = p_apcald AND apcfdocno = p_apcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete apcf_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[2] = p_apcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 刪除應收憑單
# Memo...........:
# Usage..........: CALL aicp460_del_xrca(p_xrcald,p_xrcadocno)
#                  RETURNING r_success
# Input parameter: p_xrcald      帳別
#                : p_xrcadocno   應付帳款單號碼
# Return code....: TRUE OR FALSE
# Date & Author..: 141107 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp460_del_xrca(p_xrcald,p_xrcadocno)
DEFINE p_xrcald     LIKE xrca_t.xrcald
DEFINE p_xrcadocno  LIKE xrca_t.xrcadocno
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

   DELETE FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = p_xrcald AND xrcadocno = p_xrcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete xrca_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[3] = p_xrcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM xrcb_t WHERE xrcbent = g_enterprise AND xrcbld = p_xrcald AND xrcbdocno = p_xrcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete xrcb_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[3] = p_xrcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM xrcc_t WHERE xrccent = g_enterprise AND xrccld = p_xrcald AND xrccdocno = p_xrcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete xrcc_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[3] = p_xrcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
     
   DELETE FROM xrcd_t WHERE xrcdent = g_enterprise AND xrcdld = p_xrcald AND xrcddocno = p_xrcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete xrcd_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[3] = p_xrcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
 
   DELETE FROM xrce_t WHERE xrceent = g_enterprise AND xrceld = p_xrcald AND xrcedocno = p_xrcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete xrce_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[3] = p_xrcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM xrcf_t WHERE xrcfent = g_enterprise AND xrcfld = p_xrcald AND xrcfdocno = p_xrcadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete xrcf_t'
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[3] = p_xrcadocno
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 將順利產生成功之單據資料顯示於執行成功頁籤
# Memo...........:
# Usage..........: CALL aicp460_success(p_apcadocno,p_apcadocdt,p_apca004,p_apca047,p_apcaownid,p_apcacrtid)
# Input parameter: 
# Return code....: 
# Date & Author..: 141107 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp460_success(p_apcadocno,p_apcadocdt,p_apca004,p_apca047,p_apcaownid,p_apcacrtid)
DEFINE p_apcadocno  LIKE apca_t.apcadocno
DEFINE p_apcadocdt  LIKE apca_t.apcadocdt
DEFINE p_apca004    LIKE apca_t.apca004
DEFINE p_apca047    LIKE apca_t.apca047
DEFINE p_apcaownid  LIKE apca_t.apcaownid
DEFINE p_apcacrtid  LIKE apca_t.apcacrtid

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF

   LET g_detail3_d[g_success_cnt].apcadocno1 = p_apcadocno
   LET g_detail3_d[g_success_cnt].apcadocdt1 = p_apcadocdt
   LET g_detail3_d[g_success_cnt].apca0041   = p_apca004  
   LET g_detail3_d[g_success_cnt].apca0471   = p_apca047  
   LET g_detail3_d[g_success_cnt].apcaownid1 = p_apcaownid
   LET g_detail3_d[g_success_cnt].apcacrtid1 = p_apcacrtid
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].apca0041)
        RETURNING g_detail3_d[g_success_cnt].apca0041_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].apcaownid1)
        RETURNING g_detail3_d[g_success_cnt].apcaownid1_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].apcacrtid1)
        RETURNING g_detail3_d[g_success_cnt].apcacrtid1_desc
   
   LET g_success_cnt = g_success_cnt +  1

END FUNCTION

################################################################################
# Descriptions...: 將產生失敗之單據及原因顯示於執行失敗頁籤
# Memo...........:
# Usage..........: CALL aicp460_fail(p_apcadocno,p_apcadocdt,p_apca004,p_apca047)
# Input parameter: 
# Return code....: 
# Date & Author..: 141107 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp460_fail(p_apcadocno,p_apcadocdt,p_apca004,p_apca047)
DEFINE p_apcadocno  LIKE apca_t.apcadocno
DEFINE p_apcadocdt  LIKE apca_t.apcadocdt
DEFINE p_apca004    LIKE apca_t.apca004
DEFINE p_apca047    LIKE apca_t.apca047
DEFINE l_errcode    LIKE gzze_t.gzze001
DEFINE l_i          LIKE type_t.num5

   IF cl_null(g_fail_cnt) THEN
      LET g_fail_cnt = 0
   END IF

   FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
      LET g_detail4_d[l_i].apcadocno2 = p_apcadocno
      LET g_detail4_d[l_i].apcadocdt2 = p_apcadocdt
      LET g_detail4_d[l_i].apca0042   = p_apca004  
      LET g_detail4_d[l_i].apca0472   = p_apca047  

      #錯誤訊息
#      LET l_errcode = g_errcollect[l_i].code
#      LET g_detail4_d[l_i].reason = cl_getmsg(l_errcode,g_dlang)
      LET g_detail4_d[l_i].reason = g_errcollect[l_i].message

      #說明
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].apca0042)
           RETURNING g_detail4_d[l_i].apca0042_desc
   END FOR

END FUNCTION

#end add-point
 
{</section>}
 
