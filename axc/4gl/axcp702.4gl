#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp702.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-06-03 14:39:51), PR版次:0007(2017-01-20 11:27:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000149
#+ Filename...: axcp702
#+ Description: 成本憑證產生傳票還原作業
#+ Creator....: 02114(2014-05-27 14:04:17)
#+ Modifier...: 02114 -SD/PR- 02040
 
{</section>}
 
{<section id="axcp702.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#8   2016/04/21 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160328-00022#10  2016/06/28 By 02040       增加progressbar顯示計算進度條
#161109-00085#25  2016/11/17 By 08993       整批調整系統星號寫法
#161109-00085#65  2016/12/07 By 08171       整批調整系統星號寫法
#170103-00019#21  2017/01/20 By 02040       科目若有做細項立沖帳，還原時需刪除傳票項次立帳異動檔(glax_t)
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
        xceald           LIKE xcea_t.xceald,
        xceald_desc      LIKE type_t.chr80,
        glaacomp         LIKE glaa_t.glaacomp,
        glaacomp_desc    LIKE type_t.chr80,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel           LIKE type_t.chr1,
        glapdocno     LIKE glap_t.glapdocno,
        glapdocdt     LIKE glap_t.glapdocdt,
        type          LIKE type_t.chr80,
        glap007       LIKE glap_t.glap007,
        xceadocno     LIKE xcea_t.xceadocno
        END RECORD
DEFINE g_rec_b          LIKE type_t.num5
DEFINE g_xcea_m         type_parameter
DEFINE g_wc_glapdocdt   STRING
DEFINE g_wc3                STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="axcp702.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   IF NOT cl_null(g_argv[1])  THEN
      LET g_bgjob = "Y"
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      CALL axcp702_create_tmp() RETURNING l_success
      IF NOT l_success THEN
         RETURN
      END IF
      LET g_xcea_m.xceald = g_argv[1]
      LET g_wc            = g_argv[2]
      IF cl_null(g_wc) THEN RETURN END IF
      CALL axcp702_query()
      CALL axcp702_process()
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp702 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcp702_init()   
 
      #進入選單 Menu (="N")
      CALL axcp702_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp702
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp702.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcp702_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glap007','8007')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp702.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp702_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success      LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcp702_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_xcea_m.xceald ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD xceald
               CALL axcp702_ref_show(g_xcea_m.xceald)
               IF NOT cl_null(g_xcea_m.xceald) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcea_m.xceald
                  #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#8--add--end   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_glaald") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     CALL s_ld_chk_authorization(g_user,g_xcea_m.xceald) RETURNING l_success
                     IF l_success = FALSE THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axr-00022'
                        LET g_errparam.extend = g_xcea_m.xceald
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xcea_m.xceald = ''
                        CALL axcp702_ref_show(g_xcea_m.xceald)
                        NEXT FIELD CURRENT
                     END IF 
                     
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcea_m.xceald = ''
                     CALL axcp702_ref_show(g_xcea_m.xceald)
                     NEXT FIELD CURRENT
                  END IF
               
               END IF 

            ON ACTION controlp INFIELD xceald
	  	         INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'i'
	  	           LET g_qryparam.reqry = FALSE
                 LET g_qryparam.default1 = g_xcea_m.xceald      #給予default值
                 LET g_qryparam.arg1 = g_user
                 LET g_qryparam.arg2 = g_dept
                 CALL  q_authorised_ld()                                  #呼叫開窗
                 LET g_xcea_m.xceald = g_qryparam.return1       #將開窗取得的值回傳到變數
                 DISPLAY g_xcea_m.xceald TO xceald              #顯示到畫面上
                 CALL axcp702_ref_show(g_xcea_m.xceald)
                 NEXT FIELD xceald                              #返回原欄位 

            AFTER INPUT
               #CALL axrp340_b_fill()

         END INPUT
         
         
         #螢幕上取條件
         CONSTRUCT BY NAME g_wc ON xceadocno,xcea001,xcea101
         
            BEFORE CONSTRUCT
               
         
            #----<<xceadocno>>----
            ON ACTION controlp INFIELD xceadocno
               #add-point:ON ACTION controlp INFIELD xceadocno
               #此段落由子樣板a08產生
               #開窗c段
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.where = " xceald = '",g_xcea_m.xceald,"'"
		   	                          #"   AND xceastus = 'Y'",
		   	                          #"   AND xcea101 IS NOT NULL"
               CALL q_xceadocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xceadocno  #顯示到畫面上
         
               NEXT FIELD xceadocno                     #返回原欄位
               
               
            #----<<xcea101>>----
            #Ctrlp:construct.c.xcea101
            ON ACTION controlp INFIELD xcea101
               #add-point:ON ACTION controlp INFIELD xcea101
               #此段落由子樣板a08產生
               #開窗c段
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.where = " xceald = '",g_xcea_m.xceald,"'",
		   	                          "   AND xceastus = 'Y'"
               CALL q_xcea101()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xcea101  #顯示到畫面上
         
               NEXT FIELD xcea101                     #返回原欄位 
         
            

         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc2 ON glapdocdt
         
            BEFORE CONSTRUCT
               

         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_wc3 ON xcea006
         
            BEFORE CONSTRUCT
               
            #----<<xcea006>>----
            #Ctrlp:construct.c.xcea006
            ON ACTION controlp INFIELD xcea006
               #add-point:ON ACTION controlp INFIELD xcea006
               #此段落由子樣板a08產生
               #開窗c段
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xcea006  #顯示到畫面上
         
               NEXT FIELD xcea006                     #返回原欄位 
         END CONSTRUCT 
         
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
               #LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL axcp702_fetch()               
               
            ON CHANGE sel
               UPDATE axcp702_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE glapdocno = g_detail_d[l_ac].glapdocno 
                  
         END INPUT  
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
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
            CALL axcp702_filter()
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
            CALL axcp702_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axcp702_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL axcp702_process()
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
 
{<section id="axcp702.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcp702_query()
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
   CALL axcp702_b_fill()
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
 
{<section id="axcp702.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcp702_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE r_success       LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axcp702_create_tmp() RETURNING r_success
   DELETE FROM axcp702_tmp
   
   IF cl_null(g_wc) THEN 
      LET g_wc = "1=1"
   END IF
   
   IF cl_null(g_wc2) THEN 
      LET g_wc2 = "1=1"
   END IF
   
   IF cl_null(g_wc3) THEN 
      LET g_wc3 = "1=1"
   END IF
   
   LET g_sql = "SELECT 'Y',glapdocno,glapdocdt,'',glap007,'' ",
               "  FROM glap_t ",
               " WHERE glapent = ? ",
               "   AND ",g_wc2,
               "   AND glapdocno IN (SELECT xcea101 FROM xcea_t ",
               " WHERE xceaent = '",g_enterprise,"'",
               "   AND xceald = '",g_xcea_m.xceald,"'",
               "   AND ",g_wc,
               "   AND ",g_wc3,
               ")"
   #end add-point
 
   PREPARE axcp702_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcp702_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      #g_detail_d[l_ac].* #161109-00085#65 mark
      #161109-00085#65 --s add
      g_detail_d[l_ac].sel,g_detail_d[l_ac].glapdocno,g_detail_d[l_ac].glapdocdt,g_detail_d[l_ac].type,g_detail_d[l_ac].glap007,
      g_detail_d[l_ac].xceadocno
      #161109-00085#65 --e add
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
      SELECT xceadocno INTO g_detail_d[l_ac].xceadocno
        FROM xcea_t
       WHERE xceaent = g_enterprise
         AND xceald = g_xcea_m.xceald
         AND xcea101 = g_detail_d[l_ac].glapdocno
      
      SELECT gzcbl004 INTO g_detail_d[l_ac].type
        FROM gzcbl_t
       WHERE gzcbl001 = '8007'
         AND gzcbl002 = g_detail_d[l_ac].glap007
         
      #161109-00085#25-s mod   
#      INSERT INTO axcp702_tmp VALUES(g_detail_d[l_ac].*)   #161109-00085#25-s mark
      INSERT INTO axcp702_tmp(sel,glapdocno,glapdocdt,type,glap007,xceadocno) 
                       VALUES(g_detail_d[l_ac].sel,g_detail_d[l_ac].glapdocno,g_detail_d[l_ac].glapdocdt,
                              g_detail_d[l_ac].type,g_detail_d[l_ac].glap007,g_detail_d[l_ac].xceadocno) 
      #161109-00085#25-e mod
      #end add-point
      
      CALL axcp702_detail_show()      
 
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
   FREE axcp702_sel
   
   LET l_ac = 1
   CALL axcp702_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcp702.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcp702_fetch()
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
 
{<section id="axcp702.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcp702_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcp702.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcp702_filter()
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
   
   CALL axcp702_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axcp702.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcp702_filter_parser(ps_field)
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
 
{<section id="axcp702.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcp702_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcp702_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcp702.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 參考欄位帶值
PRIVATE FUNCTION axcp702_ref_show(p_xceald)
   DEFINE p_xceald         LIKE xcea_t.xceald
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xceald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcea_m.xceald_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xcea_m.xceald_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xceald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_xcea_m.glaacomp = g_rtn_fields[1]
   DISPLAY BY NAME g_xcea_m.glaacomp

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcea_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcea_m.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xcea_m.glaacomp_desc
END FUNCTION
# 批處理邏輯
PRIVATE FUNCTION axcp702_process()
   DEFINE l_glapdocno   LIKE glap_t.glapdocno
   DEFINE l_glapdocdt   LIKE glap_t.glapdocdt
   DEFINE l_xceadocno   LIKE xcea_t.xceadocno
   DEFINE l_glapstus    LIKE glap_t.glapstus
  #160328-00022#10-s-add
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_msg   STRING
  #160328-00022#10-e-add  
  #170103-00019#21-s-add
   DEFINE l_glapcomp  LIKE glap_t.glapcomp
   DEFINE l_scom0002  LIKE type_t.chr10
   DEFINE l_success   LIKE type_t.num5
  #170103-00019#21-e-add
   
  #160328-00022#10-s-add
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM axcp702_tmp WHERE sel = 'Y'  
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      RETURN
   END IF   
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_bar_no_window(l_cnt)   
   END IF       
  #160328-00022#10-e-add    
   
   
   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   LET g_sql = "SELECT glapdocno,glapdocdt,xceadocno FROM axcp702_tmp WHERE sel = 'Y'"
   PREPARE axcp702_pre FROM g_sql
   DECLARE axcp702_cur CURSOR FOR axcp702_pre
   FOREACH axcp702_cur INTO l_glapdocno,l_glapdocdt,l_xceadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
     #160328-00022#10-s-add
      IF g_bgjob <> "Y" THEN 
         LET l_msg = cl_getmsg_parm("axc-00779",g_lang,l_xceadocno)             
         CALL cl_progress_no_window_ing(l_msg)          
      END IF      
     #160328-00022#10-e-add       
      
     #SELECT glapstus INTO l_glapstus                       #170103-00019#21 mark
      SELECT glapstus,glapcomp INTO l_glapstus,l_glapcomp   #170103-00019#21 add 
        FROM glap_t
       WHERE glapent = g_enterprise
         AND glapld = g_xcea_m.xceald
         AND glapdocno = l_glapdocno
         
      IF l_glapstus = 'Y' OR l_glapstus = 'S' THEN 
         CALL cl_errmsg(l_xceadocno,l_glapdocno,'','axr-00076',1)
         LET g_success = 'N' 
         CONTINUE FOREACH 
      END IF 
     #170103-00019#21-s-add
      #更新相关的细项立冲账资料
      LET l_success = TRUE
      CALL cl_get_para(g_enterprise,l_glapcomp,'S-COM-0002') RETURNING l_scom0002
      CALL s_pre_voucher_delete_glax(g_xcea_m.xceald,l_glapdocno,'',l_scom0002) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_success = 'N' 
         CONTINUE FOREACH 
      END IF
      IF l_scom0002 = 'Y' THEN
         #凭证作废处理
         UPDATE glap_t SET glapstus = 'X'
          WHERE glapent = g_enterprise
            AND glapld = g_xcea_m.xceald
            AND glapdocno = l_glapdocno
         IF SQLCA.SQLCODE THEN
            CALL cl_errmsg('UPDATE glap_t',l_glapdocno,'',SQLCA.SQLCODE,1)
            LET g_success = 'N' 
            CONTINUE FOREACH
         END IF
      ELSE 
     #170103-00019#21-e-add 
         #刪除憑證單頭
         DELETE FROM glap_t 
          WHERE glapent = g_enterprise
            AND glapld = g_xcea_m.xceald
            AND glapdocno = l_glapdocno
         
         IF SQLCA.SQLCODE THEN
            CALL cl_errmsg('DELETE glap_t',l_glapdocno,'',SQLCA.SQLCODE,1)
            LET g_success = 'N' 
            CONTINUE FOREACH
         END IF
         
         LET g_prog = 'aglt310'
         IF NOT s_aooi200_fin_del_docno(g_xcea_m.xceald,l_glapdocno,l_glapdocdt) THEN 
            LET g_success = 'N' 
            CONTINUE FOREACH
         END IF   
         LET g_prog = 'axcp702'   
         
         #刪除憑證單身
         DELETE FROM glaq_t 
          WHERE glaqent = g_enterprise
            AND glaqld = g_xcea_m.xceald
            AND glaqdocno = l_glapdocno 
         
         IF SQLCA.SQLCODE THEN
            CALL cl_errmsg('DELETE glaq_t',l_glapdocno,'',SQLCA.SQLCODE,1)
            LET g_success = 'N' 
            CONTINUE FOREACH
         END IF
      END IF       #170103-00019#21 add
      UPDATE xcea_t SET xcea101 = NULL
       WHERE xceaent = g_enterprise
         AND xceald = g_xcea_m.xceald
         AND xcea101 = l_glapdocno 
         
      IF SQLCA.SQLCODE THEN
         CALL cl_errmsg('update xcea_t',l_glapdocno,'',SQLCA.SQLCODE,1)
         LET g_success = 'N' 
         CONTINUE FOREACH
      END IF
      
   END FOREACH 
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
   ELSE
      CALL cl_err_showmsg() 
      CALL s_transaction_end('N','1')
   END IF
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION axcp702_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF 
   
   DROP TABLE axcp702_tmp;
   CREATE TEMP TABLE axcp702_tmp(
   sel         LIKE type_t.chr1,
   glapdocno   LIKE glap_t.glapdocno,
   glapdocdt   LIKE glap_t.glapdocdt,
   type        LIKE type_t.chr80,
   glap007     LIKE glap_t.glap007,
   xceadocno   LIKE xcea_t.xceadocno
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
