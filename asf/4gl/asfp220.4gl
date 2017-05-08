#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp220.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-10-15 14:58:03), PR版次:0004(2017-01-09 16:03:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: asfp220
#+ Description: 工單整批確認作業
#+ Creator....: 02295(2015-10-15 14:58:03)
#+ Modifier...: 02295 -SD/PR- 07025
 
{</section>}
 
{<section id="asfp220.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161109-00085#40 2016/11/17 By lienjunqi 整批調整系統星號寫法
#170109-00017#1  2017/01/09 By catmoon47 連續兩次查詢都勾選同一筆時，不會重給l_ac
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
     sfaadocno        LIKE sfaa_t.sfaadocno,
     sfaadocdt        LIKE sfaa_t.sfaadocdt,
     sfaa003          LIKE sfaa_t.sfaa003,
     sfaa010          LIKE sfaa_t.sfaa010,
     sfaa010_desc     LIKE type_t.chr500,
     sfaa010_desc_1   LIKE type_t.chr500,
     sfaa012          LIKE sfaa_t.sfaa012,
     sfaa019          LIKE sfaa_t.sfaa019,
     sfaa020          LIKE sfaa_t.sfaa020,
     sfaa002          LIKE sfaa_t.sfaa002,
     sfaa002_desc     LIKE type_t.chr500,
     sfaa021          LIKE sfaa_t.sfaa021,
     sfaa025          LIKE sfaa_t.sfaa025
     END RECORD
TYPE type_g_detail2_d RECORD
     sfbaseq        LIKE sfba_t.sfbaseq,          
     sfbaseq1       LIKE sfba_t.sfbaseq1,
     sfba001        LIKE sfba_t.sfba001,
     sfba002        LIKE sfba_t.sfba002,     
     sfba003        LIKE sfba_t.sfba003,         
     sfba003_desc   LIKE type_t.chr500,    
     sfba004        LIKE sfba_t.sfba004,
     sfba005        LIKE sfba_t.sfba005,
     sfba005_desc   LIKE type_t.chr500,
     sfba005_desc_1 LIKE type_t.chr500,
     replace        LIKE type_t.chr80,
     sfba022        LIKE sfba_t.sfba022,
     sfba006        LIKE sfba_t.sfba006,
     sfba006_desc   LIKE type_t.chr500,
     sfba006_desc_1 LIKE type_t.chr500,
     sfba021        LIKE sfba_t.sfba021,
     sfba021_desc   LIKE type_t.chr500,
     sfba009        LIKE sfba_t.sfba009,
     sfba013        LIKE sfba_t.sfba013,
     sfba028        LIKE sfba_t.sfba028
     END RECORD  
TYPE type_g_detail3_d RECORD
     sfabseq      LIKE sfab_t.sfabseq,
     sfab001      LIKE sfab_t.sfab001,
     sfab002      LIKE sfab_t.sfab002,
     sfab003      LIKE sfab_t.sfab003,
     sfab004      LIKE sfab_t.sfab004,
     sfab005      LIKE sfab_t.sfab005,
     sfab006      LIKE sfab_t.sfab006,
     a0           LIKE type_t.chr80,
     a1           LIKE type_t.chr80,
     a2           LIKE type_t.chr80,
     a3           LIKE type_t.chr80,
     a4           LIKE type_t.chr80,
     sfab007      LIKE sfab_t.sfab007,
     a6           LIKE type_t.chr80,
     a6_desc      LIKE type_t.chr500,
     a7           LIKE type_t.chr80,
     a7_desc      LIKE type_t.chr500,
     a8           LIKE type_t.chr80,
     a8_desc      LIKE type_t.chr500
     END RECORD  
TYPE type_g_detail4_d RECORD
     sfacseq        LIKE sfac_t.sfacseq,
     sfac002        LIKE sfac_t.sfac002,
     sfac001        LIKE sfac_t.sfac001,
     sfac001_desc   LIKE type_t.chr500,
     sfac001_desc_1 LIKE type_t.chr500,
     sfac006        LIKE sfac_t.sfac006,
     sfac004        LIKE sfac_t.sfac004,
     sfac004_desc   LIKE type_t.chr500,
     sfac003        LIKE sfac_t.sfac003,
     sfac005        LIKE sfac_t.sfac005
     END RECORD 
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail4_d  DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_count      LIKE type_t.num10
DEFINE g_rec_b      LIKE type_t.num10
DEFINE g_detail_idx LIKE type_t.num10
DEFINE g_extra_cnt   LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfp220.main" >}
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
   CALL cl_ap_init("asf","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp220 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfp220_init()   
 
      #進入選單 Menu (="N")
      CALL asfp220_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp220
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="asfp220.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asfp220_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('sfaa003','4007')
   CALL cl_set_combo_scc('b_sfaa003','4007')
   CALL cl_set_combo_scc('b_sfab001','4009')
   CALL cl_set_combo_scc('b_sfac002','4019')
   CALL cl_set_combo_scc('replace','4011')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp220.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp220_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_count = 0
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asfp220_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON sfaa003,sfaadocno,sfaadocdt,sfaa010,sfaa002,sfaa019,sfaa020
            
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD sfaadocno
	  	 	      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
	    	 	   LET g_qryparam.reqry = FALSE
	    	 	   CASE g_argv[01]
	    	 	      WHEN '1'
	   	 	         LET g_qryparam.where = " sfaastus ='N' "
	   	 	      WHEN '2'
	   	 	         LET g_qryparam.where = " sfaastus ='Y' "
               END CASE	   	 	      
               CALL q_sfaadocno_1()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
               NEXT FIELD sfaadocno                     #返回原欄位

            ON ACTION controlp INFIELD sfaa002
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa002  #顯示到畫面上
               NEXT FIELD sfaa002                     #返回原欄位

            ON ACTION controlp INFIELD sfaa010
		       	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		       	 LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上
               NEXT FIELD sfaa010                     #返回原欄位
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)
            BEFORE INPUT
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.h_index               
               
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.h_index
               CALL asfp220_fetch()

            ON CHANGE b_sel
               #170109-00017#1--add--start--
               IF l_ac=0 THEN
                  LET l_ac = DIALOG.getCurrentRow("s_detail1")
                  LET g_detail_idx = l_ac
               END IF   
               #170109-00017#1--add--end----
               IF g_detail_d[l_ac].sel = "Y" THEN 
                  LET g_count = g_count + 1
               ELSE
                  LET g_count = g_count - 1               
               END IF
    
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               DISPLAY l_ac TO FORMONLY.idx
            BEFORE DISPLAY
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
               DISPLAY l_ac TO FORMONLY.idx
               
         END DISPLAY
         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac TO FORMONLY.idx
            BEFORE DISPLAY
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY g_detail3_d.getLength() TO FORMONLY.cnt
               DISPLAY l_ac TO FORMONLY.idx
               
         END DISPLAY
         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               DISPLAY l_ac TO FORMONLY.idx
            BEFORE DISPLAY
               LET l_ac = DIALOG.getCurrentRow("s_detail4")  
               DISPLAY g_detail4_d.getLength() TO FORMONLY.cnt
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
            LET g_count = g_detail_d.getLength()
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
            LET g_count = 0
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            LET g_count = g_count + 1
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            LET g_count = g_count - 1
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfp220_filter()
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
            CALL asfp220_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL asfp220_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF g_count = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend =  "" 
               LET g_errparam.code   =  'apm-00481'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()    
            ELSE             
               CALL asfp220_process()
               CALL asfp220_query()
            END IF             
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
 
{<section id="asfp220.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asfp220_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"
   END IF
   CASE g_argv[01]
      WHEN '1'
         LET g_wc = g_wc," AND sfaastus = 'N'"
      WHEN '2'
         LET g_wc = g_wc," AND sfaastus = 'Y'"
   END CASE   
   #end add-point
        
   LET g_error_show = 1
   CALL asfp220_b_fill()
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
 
{<section id="asfp220.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfp220_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CLEAR FORM
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   LET g_detail_idx = 0 
   LET g_count = 0    
   LET g_sql = " SELECT 'N',sfaadocno,sfaadocdt,sfaa003,sfaa010,",
               "        imaal003,imaal004,sfaa012,sfaa019,sfaa020, ",
               "        sfaa002,ooag011,sfaa021,sfaa025 ",
               "   FROM sfaa_t ",
               "  LEFT OUTER JOIN imaal_t ON imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN ooag_t ON ooagent = sfaaent AND ooag001 = sfaa002 ",
               "  WHERE sfaaent = ? ",
               "    AND sfaasite = '",g_site,"' AND ",g_wc
               
	CASE g_argv[01]
	   WHEN '1'
	      LET g_sql = g_sql," AND sfaastus ='N' "
	   WHEN '2'
	      LET g_sql = g_sql," AND sfaastus ='Y' "
   END CASE	               
   LET g_sql = g_sql,"  ORDER BY sfaadocdt,sfaadocno"
   #end add-point
 
   PREPARE asfp220_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfp220_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
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
      
      CALL asfp220_detail_show()      
 
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
   IF g_detail_d.getLength() > 0 THEN LET g_detail_idx = 1 END IF   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE asfp220_sel
   
   LET l_ac = 1
   CALL asfp220_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp220.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfp220_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_sfaa011       LIKE sfaa_t.sfaa011
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_idx < 1 OR cl_null(g_detail_idx) THEN RETURN END IF
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   SELECT sfaa011 INTO l_sfaa011
     FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaadocno = g_detail_d[g_detail_idx].sfaadocno
      
   LET g_sql = "SELECT UNIQUE sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,oocql004,sfba004,",
               "              sfba005,a.imaal003,a.imaal004,'',sfba022,",
               "              sfba006,b.imaal003,b.imaal004,sfba021,'',sfba009,",
               "              sfba013,sfba028",
               "  FROM sfba_t ",
               "  LEFT OUTER JOIN oocql_t ON oocqlent = sfbaent AND oocql001 = '221' AND oocql002 = sfba003 AND oocql003 = '",g_dlang,"'",
               "  LEFT OUTER JOIN imaal_t a ON a.imaalent = sfbaent AND a.imaal001 = sfba005 AND a.imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN imaal_t b ON b.imaalent = sfbaent AND b.imaal001 = sfba006 AND b.imaal002 = '",g_dlang,"'",
               " WHERE sfbaent=? AND sfbasite=? AND sfbadocno=? "
   LET g_sql = g_sql," ORDER BY sfbaseq,sfbaseq1"
   PREPARE asfp220_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR asfp220_pb
   LET l_ac = 1
   OPEN b_fill_cs USING g_enterprise,g_site,g_detail_d[g_detail_idx].sfaadocno
   FOREACH b_fill_cs INTO g_detail2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF            
      #取替代建议
      CALL s_abmm201_get_proposal(g_site,g_detail2_d[l_ac].sfba001,l_sfaa011,g_detail2_d[l_ac].sfba005,
                                  g_detail2_d[l_ac].sfba002,g_detail2_d[l_ac].sfba003,g_detail2_d[l_ac].sfba004) RETURNING g_detail2_d[l_ac].replace
                                  
      CALL s_feature_description(g_detail2_d[l_ac].sfba006,g_detail2_d[l_ac].sfba021) RETURNING l_success,g_detail2_d[l_ac].sfba021_desc                            
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   
   LET g_sql = "SELECT UNIQUE sfabseq,sfab001,sfab002,sfab003,sfab004,sfab005,sfab006,'','','','','',sfab007,'','','','','','' ",
               "  FROM sfab_t ",
               " WHERE sfabent=? AND sfabsite=? AND sfabdocno=? "
   LET g_sql = g_sql CLIPPED," ORDER BY sfabseq,sfab001,sfab002,sfab003,sfab004"
   PREPARE asfp220_sfab_pb FROM g_sql
   DECLARE b_fill_sfab_cs CURSOR FOR asfp220_sfab_pb
   LET l_ac = 1
   OPEN b_fill_sfab_cs USING g_enterprise,g_site,g_detail_d[g_detail_idx].sfaadocno
   FOREACH b_fill_sfab_cs INTO g_detail3_d[l_ac].*

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL asfp220_sfab_desc(l_ac)

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF

   END FOREACH
   CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
   
   LET g_sql = "SELECT UNIQUE sfacseq,sfac002,sfac001,imaal003,imaal004,sfac006,sfac004,oocal003,sfac003,sfac005 ",
               "  FROM sfac_t ",
               "  LEFT OUTER JOIN imaal_t ON imaalent = sfacent AND imaal001 = sfac001 AND imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t ON oocalent = sfacent AND oocal001 = sfac004 AND oocal002 = '",g_dlang,"'",
               " WHERE sfacent=? AND sfacsite=? AND sfacdocno=? "
   LET g_sql = g_sql CLIPPED," ORDER BY sfacseq,sfac002,sfac001"
   PREPARE asfp220_sfac_pb FROM g_sql
   DECLARE b_fill_sfac_cs CURSOR FOR asfp220_sfac_pb
   LET l_ac = 1
   OPEN b_fill_sfac_cs USING g_enterprise,g_site,g_detail_d[g_detail_idx].sfaadocno
   FOREACH b_fill_sfac_cs INTO g_detail4_d[l_ac].*
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
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF

   END FOREACH 
   CALL g_detail4_d.deleteElement(g_detail4_d.getLength())   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="asfp220.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfp220_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfp220.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION asfp220_filter()
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
   
   CALL asfp220_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="asfp220.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION asfp220_filter_parser(ps_field)
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
 
{<section id="asfp220.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION asfp220_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfp220_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asfp220.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION asfp220_process()
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE l_i           LIKE type_t.num5
   DEFINE ls_value      STRING
   DEFINE l_sfaa004     LIKE sfaa_t.sfaa004
   DEFINE l_sfaa011     LIKE sfaa_t.sfaa011
   DEFINE l_sfaa015     LIKE sfaa_t.sfaa015
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_num         LIKE type_t.num5
   DEFINE l_success2    LIKE type_t.num5
   
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
      #抓去所需處理資料的總筆數
      LET li_count = g_count
      CALL cl_progress_bar_no_window(li_count) 
   END IF
   LET l_success2 = TRUE
   LET g_extra_cnt = 0
   LET g_coll_title[1] = s_desc_get_error_desc('aap-00153') 
   CALL cl_err_collect_init()
   FOR l_i = 1 TO g_detail_d.getLength() 
      IF g_detail_d[l_i].sel = 'N' THEN CONTINUE FOR END IF 
      
      ##畫面顯示處理進度 
      IF g_bgjob <> "Y" THEN
         LET ls_value = g_detail_d[l_i].sfaadocno
         CALL cl_progress_no_window_ing(ls_value)
      END IF 
      CALL s_transaction_begin()
      SELECT sfaa004,sfaa011,sfaa015 INTO l_sfaa004,l_sfaa011,l_sfaa015
        FROM sfaa_t
       WHERE sfaaent = g_enterprise
         AND sfaasite = g_site
         AND sfaadocno = g_detail_d[l_i].sfaadocno         
      CASE g_argv[01]
         WHEN '1'
            CALL s_asft300_01_confirm(g_detail_d[l_i].sfaadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N',0)
               LET l_success2 = FALSE
               CALL asfp220_err_collect(g_detail_d[l_i].sfaadocno)
               CONTINUE FOR
            END IF
             
            CALL s_aooi200_get_slip(g_detail_d[l_i].sfaadocno) RETURNING l_success,l_ooba002
            IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0040') = 'Y' THEN
               IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0038') = '2' THEN
                  SELECT COUNT(*) INTO l_n FROM sfba_t WHERE sfbaent = g_enterprise AND sfbasite = g_site AND sfbadocno = g_detail_d[l_i].sfaadocno
                  IF l_n = 0 THEN
                     CALL s_asft300_02(g_detail_d[l_i].sfaadocno,g_detail_d[l_i].sfaa003,g_detail_d[l_i].sfaa010,l_sfaa011,l_sfaa015,g_detail_d[l_i].sfaa012,'N') RETURNING l_success,l_num
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        LET l_success2 = FALSE
                        CALL asfp220_err_collect(g_detail_d[l_i].sfaadocno)
                        CONTINUE FOR
                     END IF
                  END IF
               END IF
               IF l_sfaa004 = '2' THEN
                  IF NOT asfp220_upd_sfcb(g_detail_d[l_i].sfaadocno,'INIT','0',g_detail_d[l_i].sfaa012) THEN
                     CALL s_transaction_end('N','0')
                     LET l_success2 = FALSE
                     CALL asfp220_err_collect(g_detail_d[l_i].sfaadocno)
                     CONTINUE FOR
                  END IF
               END IF
               UPDATE sfaa_t SET sfaastus = 'F'
                WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = g_detail_d[l_i].sfaadocno               
            END IF 
           
         WHEN '2'
            CALL s_aooi200_get_slip(g_detail_d[l_i].sfaadocno) RETURNING l_success,l_ooba002
            IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0038') = '2' THEN
               SELECT COUNT(*) INTO l_n FROM sfba_t WHERE sfbaent = g_enterprise AND sfbasite = g_site AND sfbadocno = g_sfaa_m.sfaadocno
               IF l_n = 0 THEN
                  CALL s_transaction_begin()
                  CALL s_asft300_02(g_detail_d[l_i].sfaadocno,g_detail_d[l_i].sfaa003,g_detail_d[l_i].sfaa010,l_sfaa011,l_sfaa015,g_detail_d[l_i].sfaa012,'N') RETURNING l_success,l_num
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     LET l_success2 = FALSE
                     CALL asfp220_err_collect(g_detail_d[l_i].sfaadocno)
                     CONTINUE FOR
                  END IF
               END IF
            END IF
            IF l_sfaa004 = '2' THEN
               IF NOT asfp220_upd_sfcb(g_detail_d[l_i].sfaadocno,'INIT','0',g_detail_d[l_i].sfaa012) THEN
                  CALL s_transaction_end('N','0')
                  LET l_success2 = FALSE
                  CALL asfp220_err_collect(g_detail_d[l_i].sfaadocno)
                  CONTINUE FOR
               END IF
            END IF         
            UPDATE sfaa_t SET sfaastus = 'F'
             WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = g_detail_d[l_i].sfaadocno         
      END CASE
      CALL s_transaction_end('Y',0)       
   END FOR 

   CALL cl_err_collect_show()
   IF l_success2 = TRUE THEN 
      CALL cl_ask_confirm3("std-00012","")
   END IF
END FUNCTION
#發料制度如果是倒扣料時，請在工單發放時，將製程資料的在製數量寫入第一個報工點的對應欄位上(待Move in、待Check in、待報工….)
PRIVATE FUNCTION asfp220_upd_sfcb(p_sfaadocno,p_sfaa012,p_sfcc003,p_sfcc004)
DEFINE p_sfaadocno       LIKE sfaa_t.sfaadocno
DEFINE p_sfaa012         LIKE sfaa_t.sfaa012
DEFINE p_sfcc003         LIKE sfcc_t.sfcc003
DEFINE p_sfcc004         LIKE sfcc_t.sfcc004
#161109-00085#40-s
#DEFINE l_sfcb            RECORD LIKE sfcb_t.*
DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       sfcb055 LIKE sfcb_t.sfcb055  #回收站
END RECORD
#161109-00085#40-e
#161109-00085#40-s
#DEFINE l_sfcc            RECORD LIKE sfcc_t.*
DEFINE l_sfcc RECORD  #工單製程上站作業資料
       sfccent LIKE sfcc_t.sfccent, #企業編號
       sfccsite LIKE sfcc_t.sfccsite, #營運據點
       sfccdocno LIKE sfcc_t.sfccdocno, #單號
       sfcc001 LIKE sfcc_t.sfcc001, #RUN CARD
       sfcc002 LIKE sfcc_t.sfcc002, #項次
       sfcc003 LIKE sfcc_t.sfcc003, #上站作業
       sfcc004 LIKE sfcc_t.sfcc004  #上站作業序
END RECORD
#161109-00085#40-e
DEFINE l_flag            LIKE type_t.chr1

   DECLARE asfp220_sel_sfcc_init CURSOR FOR
   #161109-00085#40-s
   #SELECT * FROM sfcc_t
   SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,
          sfcc003,sfcc004 
     FROM sfcc_t
   #161109-00085#40-e
    WHERE sfccent   = g_enterprise
      AND sfccsite  = g_site
      AND sfccdocno = p_sfaadocno
      AND sfcc001   = 0
      AND sfcc003   = p_sfcc003
      AND sfcc004   = p_sfcc004
    ORDER BY sfccdocno,sfcc001,sfcc002
   LET l_flag = 'N'
   #161109-00085#40-s
   #FOREACH asfp220_sel_sfcc_init INTO l_sfcc.*
   FOREACH asfp220_sel_sfcc_init 
   INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
        l_sfcc.sfcc003,l_sfcc.sfcc004
   #161109-00085#40-e
      LET l_flag = 'Y'
      #161109-00085#40-s
      #SELECT * INTO l_sfcb.* FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbsite = g_site
      SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
             sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
             sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
             sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
             sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
             sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
             sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
             sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
             sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
             sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
             sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
             sfcb053,sfcb054,sfcb055
        INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
             l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
             l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
             l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
             l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
             l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
             l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
             l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
             l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
             l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
             l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
             l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055 
      FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbsite = g_site
      #161109-00085#40-e
         AND sfcbdocno = p_sfaadocno AND sfcb001   = 0 AND sfcb002 = l_sfcc.sfcc002
      
      IF l_sfcb.sfcb014 = 'Y' THEN
         UPDATE sfcb_t SET sfcb046 = p_sfaa012 * l_sfcb.sfcb053 / l_sfcb.sfcb054 
          WHERE sfcbent = g_enterprise AND sfcbsite = g_site
            AND sfcbdocno = p_sfaadocno AND sfcb001   = 0 AND sfcb002 = l_sfcc.sfcc002
         RETURN TRUE
      END IF
      IF l_sfcb.sfcb015 = 'Y' THEN
         UPDATE sfcb_t SET sfcb047 = p_sfaa012 * l_sfcb.sfcb053 / l_sfcb.sfcb054 
          WHERE sfcbent = g_enterprise AND sfcbsite = g_site
            AND sfcbdocno = p_sfaadocno AND sfcb001   = 0 AND sfcb002 = l_sfcc.sfcc002
         RETURN TRUE
      END IF
      IF l_sfcb.sfcb016 = 'Y' THEN
         UPDATE sfcb_t SET sfcb050 = p_sfaa012 * l_sfcb.sfcb053 / l_sfcb.sfcb054 
          WHERE sfcbent = g_enterprise AND sfcbsite = g_site
            AND sfcbdocno = p_sfaadocno AND sfcb001   = 0 AND sfcb002 = l_sfcc.sfcc002
         RETURN TRUE
      END IF
      IF l_sfcb.sfcb017 = 'Y' THEN
         UPDATE sfcb_t SET sfcb051 = p_sfaa012 * l_sfcb.sfcb053 / l_sfcb.sfcb054 
          WHERE sfcbent = g_enterprise AND sfcbsite = g_site
            AND sfcbdocno = p_sfaadocno AND sfcb001   = 0 AND sfcb002 = l_sfcc.sfcc002
         RETURN TRUE
      END IF
      IF l_sfcb.sfcb018 = 'Y' THEN
         UPDATE sfcb_t SET sfcb048 = p_sfaa012 * l_sfcb.sfcb053 / l_sfcb.sfcb054 
          WHERE sfcbent = g_enterprise AND sfcbsite = g_site
            AND sfcbdocno = p_sfaadocno AND sfcb001   = 0 AND sfcb002 = l_sfcc.sfcc002
         RETURN TRUE
      END IF
      IF l_sfcb.sfcb019 = 'Y' THEN
         UPDATE sfcb_t SET sfcb049 = p_sfaa012 * l_sfcb.sfcb053 / l_sfcb.sfcb054 
          WHERE sfcbent = g_enterprise AND sfcbsite = g_site
            AND sfcbdocno = p_sfaadocno AND sfcb001   = 0 AND sfcb002 = l_sfcc.sfcc002
         RETURN TRUE
      END IF
   END FOREACH
   
   #161109-00085#40-s
   #FOREACH asfp220_sel_sfcc_init INTO l_sfcc.*
   FOREACH asfp220_sel_sfcc_init 
   INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
        l_sfcc.sfcc003,l_sfcc.sfcc004
   #161109-00085#40-e
      IF asfp220_upd_sfcb(p_sfaadocno,l_sfcc.sfcc003,l_sfcc.sfcc004,p_sfaa012) THEN
         RETURN TRUE
      END IF
   END FOREACH
   
   IF l_flag = 'N' THEN
      UPDATE sfcb_t SET sfcb050 = p_sfaa012 
       WHERE sfcbent = g_enterprise AND sfcbsite = g_site
         AND sfcbdocno = p_sfaadocno AND sfcb001   = 0
      RETURN TRUE
   END IF 
   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION asfp220_sfab_desc(p_ac)
DEFINE p_ac              LIKE type_t.num5
DEFINE l_sfaa013         LIKE sfaa_t.sfaa013
DEFINE l_sfab007         LIKE sfab_t.sfab007
DEFINE l_sql             STRING
#161109-00085#40-s
#DEFINE l_xmdd            RECORD LIKE xmdd_t.*
DEFINE l_xmdd RECORD  #訂單交期明細檔
       xmddent LIKE xmdd_t.xmddent, #企業編號
       xmddsite LIKE xmdd_t.xmddsite, #營運據點
       xmdddocno LIKE xmdd_t.xmdddocno, #訂單單號
       xmddseq LIKE xmdd_t.xmddseq, #項次
       xmddseq1 LIKE xmdd_t.xmddseq1, #項序
       xmddseq2 LIKE xmdd_t.xmddseq2, #分批序
       xmdd001 LIKE xmdd_t.xmdd001, #料件編號
       xmdd002 LIKE xmdd_t.xmdd002, #產品特徵
       xmdd003 LIKE xmdd_t.xmdd003, #子件特性
       xmdd004 LIKE xmdd_t.xmdd004, #銷售單位
       xmdd005 LIKE xmdd_t.xmdd005, #訂購總數量
       xmdd006 LIKE xmdd_t.xmdd006, #分批訂購數量
       xmdd007 LIKE xmdd_t.xmdd007, #摺合主件數量
       xmdd008 LIKE xmdd_t.xmdd008, #QPA
       xmdd009 LIKE xmdd_t.xmdd009, #交期類型
       xmdd010 LIKE xmdd_t.xmdd010, #出貨時段
       xmdd011 LIKE xmdd_t.xmdd011, #約定交貨日期
       xmdd012 LIKE xmdd_t.xmdd012, #預計簽收日期
       xmdd013 LIKE xmdd_t.xmdd013, #MRP交期凍結
       xmdd014 LIKE xmdd_t.xmdd014, #已出貨量
       xmdd015 LIKE xmdd_t.xmdd015, #已銷退量
       xmdd016 LIKE xmdd_t.xmdd016, #銷退換貨數量
       xmdd017 LIKE xmdd_t.xmdd017, #出貨狀態
       xmdd018 LIKE xmdd_t.xmdd018, #參考價格
       xmdd019 LIKE xmdd_t.xmdd019, #稅別
       xmdd020 LIKE xmdd_t.xmdd020, #稅率
       xmdd021 LIKE xmdd_t.xmdd021, #電子訂購單號
       xmdd022 LIKE xmdd_t.xmdd022, #最近修改人員
       xmdd023 LIKE xmdd_t.xmdd023, #最近修改時間
       xmdd024 LIKE xmdd_t.xmdd024, #分批參考單位
       xmdd025 LIKE xmdd_t.xmdd025, #分批參考數量
       xmdd026 LIKE xmdd_t.xmdd026, #分批計價單位
       xmdd027 LIKE xmdd_t.xmdd027, #分批計價數量
       xmdd028 LIKE xmdd_t.xmdd028, #分批未稅金額
       xmdd029 LIKE xmdd_t.xmdd029, #分批含稅金額
       xmdd030 LIKE xmdd_t.xmdd030, #分批稅額
       xmdd031 LIKE xmdd_t.xmdd031, #已轉出通數量
       xmdd032 LIKE xmdd_t.xmdd032, #備置量
       xmdd033 LIKE xmdd_t.xmdd033, #備置原因
       xmdd034 LIKE xmdd_t.xmdd034, #已簽退量
       xmdd035 LIKE xmdd_t.xmdd035, #已分配量
       xmdd200 LIKE xmdd_t.xmdd200, #促銷方案
       xmdd201 LIKE xmdd_t.xmdd201, #分批包裝單位
       xmdd202 LIKE xmdd_t.xmdd202, #分批包裝數量
       xmdd203 LIKE xmdd_t.xmdd203, #標準價
       xmdd204 LIKE xmdd_t.xmdd204, #促銷價
       xmdd205 LIKE xmdd_t.xmdd205, #交易價
       xmdd206 LIKE xmdd_t.xmdd206, #折價金額
       xmddunit LIKE xmdd_t.xmddunit, #應用組織
       xmdd207 LIKE xmdd_t.xmdd207, #收貨網點
       xmdd208 LIKE xmdd_t.xmdd208, #送貨地址碼
       xmdd209 LIKE xmdd_t.xmdd209, #送貨站點
       xmdd210 LIKE xmdd_t.xmdd210, #送貨時段
       xmdd211 LIKE xmdd_t.xmdd211, #送貨客戶
       xmdd212 LIKE xmdd_t.xmdd212, #MRP凍結
       xmdd213 LIKE xmdd_t.xmdd213, #庫位/庫區
       xmdd214 LIKE xmdd_t.xmdd214, #儲位
       xmdd215 LIKE xmdd_t.xmdd215, #批號
       xmdd216 LIKE xmdd_t.xmdd216, #庫存鎖定等級
       xmdd217 LIKE xmdd_t.xmdd217, #庫存餘額
       xmdd218 LIKE xmdd_t.xmdd218, #銷售通路
       xmdd219 LIKE xmdd_t.xmdd219, #產品組編號
       xmdd220 LIKE xmdd_t.xmdd220, #銷售範圍編號
       xmdd221 LIKE xmdd_t.xmdd221, #備註
       xmdd222 LIKE xmdd_t.xmdd222, #辦事處
       xmdd223 LIKE xmdd_t.xmdd223, #業務人員
       xmdd224 LIKE xmdd_t.xmdd224, #業務部門
       xmdd225 LIKE xmdd_t.xmdd225, #主合約編號
       xmdd226 LIKE xmdd_t.xmdd226, #經營方式
       xmdd227 LIKE xmdd_t.xmdd227, #結算類型
       xmdd228 LIKE xmdd_t.xmdd228, #結算方式
       xmddorga LIKE xmdd_t.xmddorga, #帳務組織
       xmdd229 LIKE xmdd_t.xmdd229, #交易類型
       xmdd230 LIKE xmdd_t.xmdd230, #分批包裝銷退換貨數量
       xmdd036 LIKE xmdd_t.xmdd036, #還量數量
       xmdd037 LIKE xmdd_t.xmdd037, #還量參考數量
       xmdd038 LIKE xmdd_t.xmdd038, #還價數量
       xmdd039 LIKE xmdd_t.xmdd039, #還價參考數量
       xmdd231 LIKE xmdd_t.xmdd231, #庫存管理特徵
       xmdd040 LIKE xmdd_t.xmdd040  #BOM特性
END RECORD
#161109-00085#40-e
DEFINE l_success         LIKE type_t.num5
DEFINE l_rate            LIKE inaj_t.inaj014
DEFINE l_imae016         LIKE imae_t.imae016
DEFINE l_sfaa013_m       LIKE sfaa_t.sfaa013
DEFINE l_sfaa010         LIKE sfaa_t.sfaa010

   #带值
  IF g_detail3_d[p_ac].sfab001 ='2' THEN
     IF NOT cl_null(g_detail3_d[p_ac].sfab002) AND NOT cl_null(g_detail3_d[p_ac].sfab003) AND NOT cl_null(g_detail3_d[p_ac].sfab004) AND NOT cl_null(g_detail3_d[p_ac].sfab005) THEN
        SELECT sfaa010,sfaa013
          INTO l_sfaa010,l_sfaa013_m
          FROM sfaa_t
         WHERE sfaaent = g_enetrprise
           AND sfaasite = g_site
           AND sfaadocno = g_detail_d[g_detail_idx].sfaadocno 
        #161109-00085#40-s           
        #SELECT xmda004,xmda003,xmda002,xmdd_t.*
        SELECT xmda004,xmda003,xmda002,
               xmddent,xmddsite,xmdddocno,xmddseq,xmddseq1,
               xmddseq2,xmdd001,xmdd002,xmdd003,xmdd004,
               xmdd005,xmdd006,xmdd007,xmdd008,xmdd009,
               xmdd010,xmdd011,xmdd012,xmdd013,xmdd014,
               xmdd015,xmdd016,xmdd017,xmdd018,xmdd019,
               xmdd020,xmdd021,xmdd022,xmdd023,xmdd024,
               xmdd025,xmdd026,xmdd027,xmdd028,xmdd029,
               xmdd030,xmdd031,xmdd032,xmdd033,xmdd034,
               xmdd035,xmdd200,xmdd201,xmdd202,xmdd203,
               xmdd204,xmdd205,xmdd206,xmddunit,xmdd207,
               xmdd208,xmdd209,xmdd210,xmdd211,xmdd212,
               xmdd213,xmdd214,xmdd215,xmdd216,xmdd217,
               xmdd218,xmdd219,xmdd220,xmdd221,xmdd222,
               xmdd223,xmdd224,xmdd225,xmdd226,xmdd227,
               xmdd228,xmddorga,xmdd229,xmdd230,xmdd036,
               xmdd037,xmdd038,xmdd039,xmdd231,xmdd040
          #161109-00085#40-e
          #161109-00085#40-s        
          #INTO g_detail3_d[p_ac].a6,g_detail3_d[p_ac].a7,g_detail3_d[p_ac].a8,l_xmdd.* 
          INTO g_detail3_d[p_ac].a6,g_detail3_d[p_ac].a7,g_detail3_d[p_ac].a8,
          l_xmdd.xmddent,l_xmdd.xmddsite,l_xmdd.xmdddocno,l_xmdd.xmddseq,l_xmdd.xmddseq1,
          l_xmdd.xmddseq2,l_xmdd.xmdd001,l_xmdd.xmdd002,l_xmdd.xmdd003,l_xmdd.xmdd004,
          l_xmdd.xmdd005,l_xmdd.xmdd006,l_xmdd.xmdd007,l_xmdd.xmdd008,l_xmdd.xmdd009,
          l_xmdd.xmdd010,l_xmdd.xmdd011,l_xmdd.xmdd012,l_xmdd.xmdd013,l_xmdd.xmdd014,
          l_xmdd.xmdd015,l_xmdd.xmdd016,l_xmdd.xmdd017,l_xmdd.xmdd018,l_xmdd.xmdd019,
          l_xmdd.xmdd020,l_xmdd.xmdd021,l_xmdd.xmdd022,l_xmdd.xmdd023,l_xmdd.xmdd024,
          l_xmdd.xmdd025,l_xmdd.xmdd026,l_xmdd.xmdd027,l_xmdd.xmdd028,l_xmdd.xmdd029,
          l_xmdd.xmdd030,l_xmdd.xmdd031,l_xmdd.xmdd032,l_xmdd.xmdd033,l_xmdd.xmdd034,
          l_xmdd.xmdd035,l_xmdd.xmdd200,l_xmdd.xmdd201,l_xmdd.xmdd202,l_xmdd.xmdd203,
          l_xmdd.xmdd204,l_xmdd.xmdd205,l_xmdd.xmdd206,l_xmdd.xmddunit,l_xmdd.xmdd207,
          l_xmdd.xmdd208,l_xmdd.xmdd209,l_xmdd.xmdd210,l_xmdd.xmdd211,l_xmdd.xmdd212,
          l_xmdd.xmdd213,l_xmdd.xmdd214,l_xmdd.xmdd215,l_xmdd.xmdd216,l_xmdd.xmdd217,
          l_xmdd.xmdd218,l_xmdd.xmdd219,l_xmdd.xmdd220,l_xmdd.xmdd221,l_xmdd.xmdd222,
          l_xmdd.xmdd223,l_xmdd.xmdd224,l_xmdd.xmdd225,l_xmdd.xmdd226,l_xmdd.xmdd227,
          l_xmdd.xmdd228,l_xmdd.xmddorga,l_xmdd.xmdd229,l_xmdd.xmdd230,l_xmdd.xmdd036,
          l_xmdd.xmdd037,l_xmdd.xmdd038,l_xmdd.xmdd039,l_xmdd.xmdd231,l_xmdd.xmdd040
          #161109-00085#40-e
          FROM xmda_t,xmdd_t 
         WHERE xmdaent=xmddent 
           AND xmdadocno=xmdddocno
           AND xmddent=g_enterprise AND xmddsite=g_site AND xmdd001=l_sfaa010
           AND xmdddocno=g_detail3_d[p_ac].sfab002 AND xmddseq=g_detail3_d[p_ac].sfab003
           AND xmddseq1=g_detail3_d[p_ac].sfab004 AND xmddseq2=g_detail3_d[p_ac].sfab005
        LET g_detail3_d[p_ac].a0=l_xmdd.xmdd006
        LET g_detail3_d[p_ac].a1=l_xmdd.xmdd004
        LET g_detail3_d[p_ac].a3=l_sfaa013_m

        CALL s_aooi250_convert_qty(l_xmdd.xmdd001,g_detail3_d[p_ac].a1,g_detail3_d[p_ac].a3,g_detail3_d[p_ac].a0)
             RETURNING l_success,g_detail3_d[p_ac].a2
        IF NOT l_success THEN
           LET g_detail3_d[p_ac].a2 = g_detail3_d[p_ac].a0
        END IF
        
        #LET g_detail3_d[p_ac].a0 = l_xmdd.xmdd011
        
        #已开工单数量
        LET l_sql = "SELECT sfaa013,sfab007 FROM sfaa_t,sfab_t WHERE sfaaent=sfabent AND sfaadocno=sfabdocno",
              "   AND sfaaent=",g_enterprise," AND sfaasite='",g_site,"'",
              "   AND sfaa010='",l_sfaa010,"' AND sfaastus != 'X'",
              "   AND sfab002='",g_detail3_d[p_ac].sfab002,"' AND sfab003=",g_detail3_d[p_ac].sfab003,
              "   AND sfab004=",g_detail3_d[p_ac].sfab004," AND sfab005=",g_detail3_d[p_ac].sfab005
        PREPARE asfp220_qty2_pre FROM l_sql
        DECLARE asfp220_qty2_cs CURSOR FOR asfp220_qty2_pre
        LET g_detail3_d[p_ac].a4 = 0
        FOREACH asfp220_qty2_cs INTO l_sfaa013,l_sfab007
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "FOREACH:"
              LET g_errparam.popup = TRUE
              CALL cl_err()

              EXIT FOREACH
           END IF    

           CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,g_detail3_d[p_ac].a3,l_sfab007)
                RETURNING l_success,l_sfab007
           LET g_detail3_d[p_ac].a4 = g_detail3_d[p_ac].a4 + l_sfab007
        END FOREACH 
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_detail3_d[p_ac].a8
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_detail3_d[p_ac].a8_desc = '', g_rtn_fields[1] , ''
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_detail3_d[p_ac].a7
        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_detail3_d[p_ac].a7_desc = '', g_rtn_fields[1] , ''
       
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_detail3_d[p_ac].a6
        CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_detail3_d[p_ac].a6_desc = '', g_rtn_fields[1] , ''
     END IF
  END IF
END FUNCTION
################################################################################
# Descriptions...: 报错信息中增加显示单据编号
################################################################################
PRIVATE FUNCTION asfp220_err_collect(p_sfaadocno)
   DEFINE p_sfaadocno   LIKE sfaa_t.sfaadocno
   DEFINE l_i           LIKE type_t.num10
   
   FOR l_i = g_extra_cnt + 1 TO g_errcollect.getLength()
      LET g_errcollect[l_i].extra[1] = p_sfaadocno   #額外欄位資訊
   END FOR
   
   LET g_extra_cnt = g_errcollect.getLength()
END FUNCTION

#end add-point
 
{</section>}
 
