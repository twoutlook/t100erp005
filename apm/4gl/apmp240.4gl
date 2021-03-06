#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp240.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-10-30 15:54:47), PR版次:0003(2016-12-29 14:27:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: apmp240
#+ Description: 一般入庫單整批確認作業
#+ Creator....: 02295(2015-10-29 15:24:17)
#+ Modifier...: 02295 -SD/PR- 01534
 
{</section>}
 
{<section id="apmp240.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161207-00033#19  2016/12/20   By lixh 一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
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
   sel          LIKE type_t.chr1,
   pmdsdocno    LIKE pmds_t.pmdsdocno,
   pmdsdocdt    LIKE pmds_t.pmdsdocdt,
   pmds007      LIKE pmds_t.pmds007,
   pmds007_desc LIKE type_t.chr500,
   pmds002      LIKE pmds_t.pmds002,
   pmds002_desc LIKE type_t.chr500,
   pmds003      LIKE pmds_t.pmds003,
   pmds003_desc LIKE type_t.chr500,
   pmds006      LIKE pmds_t.pmds006,
   pmds011      LIKE pmds_t.pmds011,
   pmds008      LIKE pmds_t.pmds008,
   pmds008_desc LIKE type_t.chr500,
   pmds009      LIKE pmds_t.pmds009,
   pmds009_desc LIKE type_t.chr500,
   pmds031      LIKE pmds_t.pmds031,
   pmds031_desc LIKE type_t.chr500,
   pmds032      LIKE pmds_t.pmds032,
   pmds032_desc LIKE type_t.chr500,
   pmds033      LIKE pmds_t.pmds033,
   pmds033_desc LIKE type_t.chr500,
   pmds034      LIKE pmds_t.pmds034,
   pmds035      LIKE pmds_t.pmds035,
   pmds037      LIKE pmds_t.pmds037,
   pmds037_desc LIKE type_t.chr500
END RECORD
TYPE type_g_detail2_d RECORD
   pmdtseq        LIKE pmdt_t.pmdtseq,
   pmdt028        LIKE pmdt_t.pmdt028,
   pmdt001        LIKE pmdt_t.pmdt001,
   pmdt002        LIKE pmdt_t.pmdt002,
   pmdt003        LIKE pmdt_t.pmdt003,
   pmdt004        LIKE pmdt_t.pmdt004,
   pmdt005        LIKE pmdt_t.pmdt005,
   pmdt006        LIKE pmdt_t.pmdt006,
   pmdt006_desc   LIKE type_t.chr500,
   pmdt006_desc_1 LIKE type_t.chr500,
   pmdt007        LIKE pmdt_t.pmdt007,
   pmdt007_desc   LIKE type_t.chr500,
   pmdt025        LIKE pmdt_t.pmdt025,
   pmdt019        LIKE pmdt_t.pmdt019,
   pmdt019_desc   LIKE type_t.chr500,
   pmdt020        LIKE pmdt_t.pmdt020,
   pmdt026        LIKE pmdt_t.pmdt026,
   pmdt062        LIKE pmdt_t.pmdt062,
   pmdt063        LIKE pmdt_t.pmdt063,
   pmdt016        LIKE pmdt_t.pmdt016,
   pmdt016_desc   LIKE type_t.chr500,
   pmdt017        LIKE pmdt_t.pmdt017,
   pmdt017_desc   LIKE type_t.chr500,
   pmdt018        LIKE pmdt_t.pmdt018,
   pmdt051        LIKE pmdt_t.pmdt051,
   pmdt051_desc   LIKE type_t.chr500,
   pmdt059        LIKE pmdt_t.pmdt059
END RECORD
TYPE type_g_detail3_d RECORD
   pmduseq        LIKE pmdu_t.pmduseq,
   pmduseq1       LIKE pmdu_t.pmduseq1,
   pmdu001        LIKE pmdu_t.pmdu001,
   pmdu001_desc   LIKE type_t.chr500,
   pmdu001_desc_1 LIKE type_t.chr500,
   pmdu002        LIKE pmdu_t.pmdu002,
   pmdu002_desc   LIKE type_t.chr500,
   pmdu003        LIKE pmdu_t.pmdu003,
   pmdu003_desc   LIKE type_t.chr500,
   pmdu004        LIKE pmdu_t.pmdu004,
   pmdu006        LIKE pmdu_t.pmdu006,
   pmdu006_desc   LIKE type_t.chr500,
   pmdu007        LIKE pmdu_t.pmdu007,
   pmdu007_desc   LIKE type_t.chr500,
   pmdu008        LIKE pmdu_t.pmdu008,
   pmdu009        LIKE pmdu_t.pmdu009,
   pmdu009_desc   LIKE type_t.chr500,
   pmdu010        LIKE pmdu_t.pmdu010
END RECORD
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_count      LIKE type_t.num10
DEFINE g_rec_b      LIKE type_t.num10
DEFINE g_detail_idx LIKE type_t.num10
DEFINE g_ooef019    LIKE ooef_t.ooef019
DEFINE g_extra_cnt   LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp240.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp240 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp240_init()   
 
      #進入選單 Menu (="N")
      CALL apmp240_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp240
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp240.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp240_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_pmds011','2061')
   CALL cl_set_combo_scc('b_pmdt005','2055') 
   CALL cl_set_combo_scc('b_pmdt025','2036')  
   SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp240.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp240_ui_dialog()
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
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmp240_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdsdocno,pmdsdocdt,pmds007,pmds002,pmds003
            
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD pmdsdocno
	  	 	      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
	    	 	   LET g_qryparam.reqry = FALSE
	   	 	   CASE 
                  WHEN g_argv[01] MATCHES '[12]'   #一般  1/2
                     LET g_qryparam.where = " pmds000 IN('3','4','6') "
                  WHEN g_argv[01] MATCHES '[05]'   #委外
                     LET g_qryparam.where = " pmds000 IN('12','20') "
                  WHEN g_argv[01] MATCHES '[36]'   #重复性
                     LET g_qryparam.where = " pmds000 IN('13') "
                  WHEN g_argv[01] MATCHES '[47]'   #借货
                     LET g_qryparam.where = " pmds000 IN('24','25') "         
               END CASE 
               CASE 
                  WHEN g_argv[01] MATCHES '[0134]'   #确认
                     LET g_qryparam.where = g_qryparam.where," AND pmdsstus = 'N' "
                  WHEN g_argv[01] MATCHES '[2567]'   #过账
                     LET g_qryparam.where = g_qryparam.where," AND pmdsstus = 'Y' "        
               END CASE                
               CALL q_pmdsdocno_1()                     #呼叫開窗
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
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)
            BEFORE INPUT
   
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_master_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               CALL apmp240_fetch()

            ON CHANGE b_sel            
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
               DISPLAY l_ac TO FORMONLY.idx
               DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
               
         END DISPLAY
         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac TO FORMONLY.idx
            BEFORE DISPLAY
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac TO FORMONLY.idx
               DISPLAY g_detail3_d.getLength() TO FORMONLY.cnt
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
            CALL apmp240_filter()
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
            CALL apmp240_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp240_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF g_count = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend =  "" 
               LET g_errparam.code   =  'apm-00481'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()    
            ELSE             
               CALL apmp240_process() 
               CALL apmp240_query() 
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
 
{<section id="apmp240.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp240_query()
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
   CASE 
      WHEN g_argv[01] MATCHES '[0134]'
         LET g_wc = g_wc," AND pmdsstus = 'N'"
      WHEN g_argv[01] MATCHES '[2567]'
         LET g_wc = g_wc," AND pmdsstus = 'Y'"
   END CASE   
   #end add-point
        
   LET g_error_show = 1
   CALL apmp240_b_fill()
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
 
{<section id="apmp240.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp240_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_pmds028       LIKE pmds_t.pmds028   #161207-00033#19 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CLEAR FORM
   CALL g_detail_d.clear() 
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   LET g_detail_idx = 0
   LET g_count = 0
   LET g_sql = "SELECT DISTINCT 'N',pmdsdocno,pmdsdocdt,pmds007,a.pmaal004,pmds002,",        
               "                ooag011,pmds003,ooefl003,pmds006,pmds011,",        
               "                pmds008,b.pmaal004,pmds009,c.pmaal004,pmds031,",   
               "                ooibl004,pmds032,oocql004,pmds033,oodbl004,",        
               "                pmds034,pmds035,pmds037,ooail003,pmds028",  #161207-00033#19
               "  FROM pmds_t",
               "  LEFT OUTER JOIN pmaal_t a ON a.pmaalent=pmdsent AND a.pmaal001=pmds007 AND a.pmaal002='",g_dlang,"'",
               "  LEFT OUTER JOIN ooag_t ON ooagent=pmdsent AND ooag001=pmds002",
               "  LEFT OUTER JOIN ooefl_t ON ooeflent=pmdsent AND ooefl001=pmds003 AND ooefl002='",g_dlang,"'",
               "  LEFT OUTER JOIN pmaal_t b ON b.pmaalent=pmdsent AND b.pmaal001=pmds008 AND b.pmaal002='",g_dlang,"'",
               #"  LEFT OUTER JOIN pmaal_t c ON c.pmaalent=pmdsent AND c.pmaal001=pmds008 AND c.pmaal002='",g_dlang,"'",  #161207-00033#19 mark
               "  LEFT OUTER JOIN pmaal_t c ON c.pmaalent=pmdsent AND c.pmaal001=pmds009 AND c.pmaal002='",g_dlang,"'",   #161207-00033#19               
               "  LEFT OUTER JOIN ooibl_t ON ooiblent=pmdsent AND ooibl002=pmds031 AND ooibl003='",g_dlang,"'",
               "  LEFT OUTER JOIN oocql_t ON oocqlent=pmdsent AND oocql001='238' AND oocql002=pmds032 AND oocql003='",g_dlang,"'",
               "  LEFT OUTER JOIN oodbl_t ON oodblent=pmdsent AND oodbl001='",g_ooef019,"' AND oodbl002=pmds033 AND oodbl003='",g_dlang,"'",
               "  LEFT OUTER JOIN ooail_t ON ooailent=pmdsent AND ooail001=pmds037 AND ooail002='",g_dlang,"'",
               " WHERE pmdsent = ? ",
               "   AND pmdssite = '",g_site,"' AND ",g_wc 
 
   CASE 
      WHEN g_argv[01] MATCHES '[12]'   #一般  1/2
         LET g_sql = g_sql," AND pmds000 IN('3','4','6') "
      WHEN g_argv[01] MATCHES '[05]'   #委外
         LET g_sql = g_sql," AND pmds000 IN('12','20') "
      WHEN g_argv[01] MATCHES '[36]'   #重复性
         LET g_sql = g_sql," AND pmds000 IN('13') "
      WHEN g_argv[01] MATCHES '[47]'   #借货
         LET g_sql = g_sql," AND pmds000 IN('24','25') "         
   END CASE 
   CASE 
      WHEN g_argv[01] MATCHES '[0134]'   #确认
         LET g_sql = g_sql," AND pmdsstus = 'N' "
      WHEN g_argv[01] MATCHES '[2567]'   #过账
         LET g_sql = g_sql," AND pmdsstus = 'Y' "        
   END CASE    
   LET g_sql = g_sql," ORDER BY pmdsdocdt,pmdsdocno"   
   #end add-point
 
   PREPARE apmp240_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp240_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*,l_pmds028   #161207-00033#19
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
      #161207-00033#19-S
      IF NOT cl_null(l_pmds028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_detail_d[l_ac].pmds007_desc
         IF g_detail_d[l_ac].pmds007 = g_detail_d[l_ac].pmds008 THEN
            LET g_detail_d[l_ac].pmds008_desc = g_detail_d[l_ac].pmds007_desc
         END IF   
         IF g_detail_d[l_ac].pmds007 = g_detail_d[l_ac].pmds009 THEN
            LET g_detail_d[l_ac].pmds009_desc = g_detail_d[l_ac].pmds007_desc
         END IF           
      END IF
      #161207-00033#19-E
      #end add-point
      
      CALL apmp240_detail_show()      
 
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
      LET g_detail_idx = 1
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apmp240_sel
   
   LET l_ac = 1
   CALL apmp240_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp240.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp240_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_idx < 1 OR cl_null(g_detail_idx) THEN RETURN END IF
   
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()

   LET g_sql = "SELECT DISTINCT pmdtseq,pmdt028,pmdt001,pmdt002,pmdt003,",       
               "                pmdt004,pmdt005,",      
               "                pmdt006,imaal003,imaal004,pmdt007,'',pmdt025,",       
               "                pmdt019,oocal003,pmdt020,pmdt026,pmdt062,",       
               "                pmdt063,pmdt016,inayl003,pmdt017,inab003,",  
               "                pmdt018,pmdt051,oocql004,pmdt059 ",
               "  FROM pmdt_t ",
               "  LEFT OUTER JOIN imaal_t ON imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t ON oocalent = pmdtent AND oocal001 = pmdt019 AND oocal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN inayl_t ON inaylent = pmdtent AND inayl001 = pmdt016 AND inayl002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN inab_t ON inabent = pmdtent AND inabsite = '",g_site,"' AND inab001 = pmdt016 AND inab002 = pmdt017",
               "  LEFT OUTER JOIN oocql_t ON oocqlent = pmdtent AND oocql001 = '269' AND oocql002 = pmdt051 AND oocql003 = '",g_dlang,"'",
               " WHERE pmdtent=? AND pmdtsite=? AND pmdtdocno=? ",
               " ORDER BY pmdtseq"
   PREPARE apmp240_pb2 FROM g_sql
   DECLARE apmp240_cs2 CURSOR FOR apmp240_pb2
   LET l_ac = 1
   OPEN apmp240_cs2 USING g_enterprise,g_site,g_detail_d[g_detail_idx].pmdsdocno
   FOREACH apmp240_cs2 INTO g_detail2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF 
      CALL s_feature_description(g_detail2_d[l_ac].pmdt006,g_detail2_d[l_ac].pmdt007) RETURNING l_success,g_detail2_d[l_ac].pmdt007_desc
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

   LET g_sql = "SELECT UNIQUE pmduseq,pmduseq1,pmdu001,imaal003,imaal004,",
               "              pmdu002,'',pmdu003,oocql004,pmdu004,pmdu006,",       
               "              inayl003,pmdu007,inab003,pmdu008,",       
               "              pmdu009,oocal003,pmdu010", 
               "  FROM pmdu_t ",
               "  LEFT JOIN imaal_t  ON imaalent = pmduent AND imaal001 = pmdu001 AND imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocql_t ON oocqlent = pmduent AND oocql001 = '221' AND oocql002 = pmdu003 AND oocql003 = '",g_dlang,"'",
               "  LEFT OUTER JOIN inayl_t ON inaylent = pmduent AND inayl001 = pmdu006 AND inayl002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN inab_t ON inabent = pmduent AND inabsite = '",g_site,"' AND inab001 = pmdu006 AND inab002 = pmdu007",
               "  LEFT JOIN oocal_t ON oocalent=pmduent AND oocal001=pmdu009 AND oocal002='",g_dlang,"'",
               " WHERE pmduent=? AND pmdusite=? AND pmdudocno=? ",
               " ORDER BY pmduseq,pmduseq1"
   PREPARE apmp240_pb3 FROM g_sql
   DECLARE apmp240_cs3 CURSOR FOR apmp240_pb3
   LET l_ac = 1
   OPEN apmp240_cs3 USING g_enterprise,g_site,g_detail_d[g_detail_idx].pmdsdocno
   FOREACH apmp240_cs3 INTO g_detail3_d[l_ac].*

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL s_feature_description(g_detail3_d[l_ac].pmdu001,g_detail3_d[l_ac].pmdu002) RETURNING l_success,g_detail3_d[l_ac].pmdu002_desc
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
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmp240.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp240_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp240.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp240_filter()
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
   
   CALL apmp240_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp240.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp240_filter_parser(ps_field)
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
 
{<section id="apmp240.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp240_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp240_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp240.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apmp240_process()
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
   DEFINE l_pmdsstus    LIKE pmds_t.pmdsstus
   DEFINE l_pmds000     LIKE pmds_t.pmds000
   DEFINE l_success2    LIKE type_t.num5
   DEFINE l_pmdsmodid   LIKE pmds_t.pmdsmodid
   DEFINE l_pmdsmoddt   DATETIME YEAR TO SECOND
   
   LET l_success2 = TRUE
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
      #抓去所需處理資料的總筆數
      LET li_count = g_count
      CALL cl_progress_bar_no_window(li_count) 
   END IF
   CALL cl_err_collect_init()
   LET g_extra_cnt = 0
   LET g_coll_title[1] = s_desc_get_error_desc('aap-00153')    
   FOR l_i = 1 TO g_detail_d.getLength() 
      IF g_detail_d[l_i].sel = 'N' THEN CONTINUE FOR END IF 
             
      ##畫面顯示處理進度 
      IF g_bgjob <> "Y" THEN
         LET ls_value = g_detail_d[l_i].pmdsdocno
         CALL cl_progress_no_window_ing(ls_value)
      END IF 
      CALL s_transaction_begin()  
      LET l_pmdsstus=''
      LET l_pmds000=''      
      SELECT pmdsstus,pmds000 INTO l_pmdsstus,l_pmds000 
        FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = g_detail_d[l_i].pmdsdocno

      CASE 
         WHEN g_argv[01] MATCHES '[0134]'
            IF l_pmdsstus <> 'N' THEN CONTINUE FOR END IF
               
            CALL s_apmt520_conf_chk(g_detail_d[l_i].pmdsdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N',0)
               LET l_success2 = FALSE
               CALL apmp240_err_collect(g_detail_d[l_i].pmdsdocno)
               CONTINUE FOR
            END IF
            CALL s_apmt520_conf_upd(g_detail_d[l_i].pmdsdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N',0)
               LET l_success2 = FALSE
               CALL apmp240_err_collect(g_detail_d[l_i].pmdsdocno)
               CONTINUE FOR
            END IF 
            LET l_pmdsmodid = g_user
            LET l_pmdsmoddt = cl_get_current()
            UPDATE pmds_t
               SET (pmdsmodid,pmdsmoddt)
                 = (l_pmdsmodid,l_pmdsmoddt)
             WHERE pmdsent = g_enterprise AND pmdsdocno = g_detail_d[l_i].pmdsdocno            
            #確認後自動過賬
            IF l_pmds000 MATCHES '[346]' OR l_pmds000 = '12' OR l_pmds000 = '13' OR l_pmds000 = '24' OR l_pmds000 = '25' THEN   #入庫單才有過賬功能
               CALL s_aooi200_get_slip(g_detail_d[l_i].pmdsdocno) RETURNING l_success,l_ooba002
               IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0083') = 'Y' THEN  
                  IF apmp240_upd_pmds001(g_detail_d[l_i].pmdsdocno) THEN
                     CALL s_apmt520_posted_chk(g_detail_d[l_i].pmdsdocno) RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        LET l_success2 = FALSE
                        CALL apmp240_err_collect(g_detail_d[l_i].pmdsdocno)
                        CONTINUE FOR
                     ELSE              
                        CALL s_apmt520_posted_upd(g_detail_d[l_i].pmdsdocno) RETURNING l_success
                        IF NOT l_success THEN
                           CALL s_transaction_end('N','0')
                           LET l_success2 = FALSE
                           CALL apmp240_err_collect(g_detail_d[l_i].pmdsdocno)
                           CONTINUE FOR
                        END IF
                     END IF
                  END IF
               END IF
            END IF 
         WHEN g_argv[01] MATCHES '[2567]'
            IF l_pmdsstus <> 'Y' THEN CONTINUE FOR END IF
 
            IF apmp240_upd_pmds001(g_detail_d[l_i].pmdsdocno) THEN
               CALL s_apmt520_posted_chk(g_detail_d[l_i].pmdsdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  LET l_success2 = FALSE
                  CALL apmp240_err_collect(g_detail_d[l_i].pmdsdocno)
                  CONTINUE FOR
               ELSE              
                  CALL s_apmt520_posted_upd(g_detail_d[l_i].pmdsdocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     LET l_success2 = FALSE
                     CALL apmp240_err_collect(g_detail_d[l_i].pmdsdocno)
                     CONTINUE FOR
                  END IF
                  LET l_pmdsmodid = g_user
                  LET l_pmdsmoddt = cl_get_current()
                  UPDATE pmds_t
                     SET (pmdsmodid,pmdsmoddt)
                       = (l_pmdsmodid,l_pmdsmoddt)
                   WHERE pmdsent = g_enterprise AND pmdsdocno = g_detail_d[l_i].pmdsdocno
                  
               END IF
            END IF
      END CASE        
      CALL s_transaction_end('Y',0)       
   END FOR
   CALL cl_err_collect_show()
   IF l_success2 = TRUE THEN 
      CALL cl_ask_confirm3("std-00012","")
   END IF   
END FUNCTION

PRIVATE FUNCTION apmp240_upd_pmds001(p_pmdsdocno)
DEFINE p_pmdsdocno   LIKE pmds_t.pmdsdocno
DEFINE l_pmdsmoddt   LIKE pmds_t.pmdsmoddt
DEFINE l_pmds001     LIKE pmds_t.pmds001
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   LET l_pmdsmoddt = cl_get_current()
   LET l_pmds001 = cl_get_current()
   UPDATE pmds_t SET pmds001 = l_pmds001,
                     pmdsmodid = g_user,
                     pmdsmoddt = l_pmdsmoddt
     WHERE pmdsent = g_enterprise AND pmdsdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pmds_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 报错信息中增加显示单据编号
################################################################################
PRIVATE FUNCTION apmp240_err_collect(p_pmdsdocno)
   DEFINE p_pmdsdocno   LIKE pmds_t.pmdsdocno
   DEFINE l_i           LIKE type_t.num10
   
   FOR l_i = g_extra_cnt + 1 TO g_errcollect.getLength()
      LET g_errcollect[l_i].extra[1] = p_pmdsdocno   #額外欄位資訊
   END FOR
   
   LET g_extra_cnt = g_errcollect.getLength()
END FUNCTION

#end add-point
 
{</section>}
 
