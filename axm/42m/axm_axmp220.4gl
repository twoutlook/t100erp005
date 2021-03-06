#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp220.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-10-23 13:56:02), PR版次:0002(2017-01-12 11:36:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: axmp220
#+ Description: 訂單整批確認作業
#+ Creator....: 02040(2015-10-23 10:22:36)
#+ Modifier...: 02040 -SD/PR- 05423
 
{</section>}
 
{<section id="axmp220.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161221-00064#19  2017/01/10  By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
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
          sel            LIKE   type_t.chr1,
          xmdadocno      LIKE   xmda_t.xmdadocno,
          xmdadocdt      LIKE   xmda_t.xmdadocdt,
          xmda004        LIKE   xmda_t.xmda004,
          xmda004_desc   LIKE   type_t.chr500,          
          xmda033        LIKE   xmda_t.xmda033,
          xmda002        LIKE   xmda_t.xmda002,
          xmda002_desc   LIKE   type_t.chr500,
          xmda003        LIKE   xmda_t.xmda003,
          xmda003_desc   LIKE   type_t.chr500,
          xmda005        LIKE   xmda_t.xmda005,                
          xmda009        LIKE   xmda_t.xmda009,
          xmda009_desc   LIKE   type_t.chr500, 
          xmda010        LIKE   xmda_t.xmda010,
          xmda010_desc   LIKE   type_t.chr500,
          xmda011        LIKE   xmda_t.xmda011,
          xmda011_desc   LIKE   type_t.chr500,
          xmda012        LIKE   xmda_t.xmda012,
          xmda013        LIKE   xmda_t.xmda013,          
          xmda015        LIKE   xmda_t.xmda015,
          xmda015_desc   LIKE   type_t.chr500       
       END RECORD
TYPE type_g_xmdc_d RECORD
          xmdcseq        LIKE   xmdc_t.xmdcseq,
          xmdc027        LIKE   xmdc_t.xmdc027,
          pmao009        LIKE   pmao_t.pmao009,
          pmao010        LIKE   pmao_t.pmao010,
          xmdc001        LIKE   xmdc_t.xmdc001,
          xmdc001_desc   LIKE   type_t.chr500, 
          xmdc001_desc_1 LIKE   type_t.chr500,          
          xmdc002        LIKE   xmdc_t.xmdc002,
          xmdc002_desc   LIKE   type_t.chr500,
          xmdc004        LIKE   xmdc_t.xmdc004,
          xmdc004_desc   LIKE   type_t.chr500,           
          xmdc005        LIKE   xmdc_t.xmdc005,
          xmdc006        LIKE   xmdc_t.xmdc006,
          xmdc006_desc   LIKE   type_t.chr500,         
          xmdc007        LIKE   xmdc_t.xmdc007,
          xmdc012        LIKE   xmdc_t.xmdc012,    
          xmdc010        LIKE   xmdc_t.xmdc010,
          xmdc010_desc   LIKE   type_t.chr500,                   
          xmdc011        LIKE   xmdc_t.xmdc011,
          xmdc015        LIKE   xmdc_t.xmdc015,
          xmdc046        LIKE   xmdc_t.xmdc046,
          xmdc047        LIKE   xmdc_t.xmdc047,
          xmdc048        LIKE   xmdc_t.xmdc048,
          xmdc020        LIKE   xmdc_t.xmdc020,
          xmdc052        LIKE   xmdc_t.xmdc052,
          xmdc049        LIKE   xmdc_t.xmdc049,
          xmdc049_desc   LIKE   type_t.chr500, 
          xmdc050        LIKE   xmdc_t.xmdc050
       END RECORD 
TYPE type_g_xmdd_d RECORD
          xmddseq        LIKE    xmdd_t.xmddseq,
          xmddseq1       LIKE    xmdd_t.xmddseq1,
          xmdd003        LIKE    xmdd_t.xmdd003,
          xmdd001        LIKE    xmdd_t.xmdd001,
          xmdd001_desc   LIKE    type_t.chr500,
          xmdd001_desc_1 LIKE    type_t.chr500,
          xmdd002        LIKE    xmdd_t.xmdd002,
          xmdd002_desc   LIKE   type_t.chr500,
          xmdd004        LIKE    xmdd_t.xmdd004,
          xmdd004_desc   LIKE    type_t.chr500,
          xmddseq2       LIKE    xmdd_t.xmddseq2,
          xmdd006        LIKE    xmdd_t.xmdd006
       END RECORD    
TYPE type_g_xmdb_d RECORD 
          xmdb001       LIKE    xmdb_t.xmdb001,
          xmdb002       LIKE    xmdb_t.xmdb002,
          xmdb002_desc  LIKE    type_t.chr500,
          xmdb003       LIKE    xmdb_t.xmdb003,
          xmdb004       LIKE    xmdb_t.xmdb004,
          xmdb005       LIKE    xmdb_t.xmdb005,
          xmdb006       LIKE    xmdb_t.xmdb006,
          xmdb007       LIKE    xmdb_t.xmdb007
       END RECORD  
DEFINE g_detail_idx        LIKE type_t.num5
DEFINE g_detail2_idx       LIKE type_t.num5
DEFINE g_detail2_cnt       LIKE type_t.num5
DEFINE g_detail3_cnt       LIKE type_t.num5
DEFINE g_detail4_cnt       LIKE type_t.num5   

DEFINE g_detail_d_t  type_g_detail_d
DEFINE g_xmdc_d      DYNAMIC ARRAY OF type_g_xmdc_d  
DEFINE g_xmdb_d      DYNAMIC ARRAY OF type_g_xmdb_d
DEFINE g_xmdd_d      DYNAMIC ARRAY OF type_g_xmdd_d 
DEFINE g_extra_cnt   LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp220.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp220 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmp220_init()   
 
      #進入選單 Menu (="N")
      CALL axmp220_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp220
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp220.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmp220_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_xmda005','2063')
   CALL cl_set_combo_scc('b_xmdd003','2055')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp220.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp220_ui_dialog()
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
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmp220_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT g_wc ON xmdadocno,xmdadocdt,xmda004,xmda033,xmda002,xmda003
              FROM xmdadocno,xmdadocdt,xmda004,xmda033,xmda002,xmda003

            BEFORE CONSTRUCT
               CALL cl_qbe_init()

            ON ACTION controlp INFIELD xmdadocno
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = " xmdastus = 'N' AND xmda006 <> '5' "
                CALL q_xmdadocno_7()                             #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdadocno        #顯示到畫面上
                NEXT FIELD xmdadocno                           #返回原欄位

            ON ACTION controlp INFIELD xmda004               #客戶
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " pmaastus = 'Y' "
	      		LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda004      #顯示到畫面上
               NEXT FIELD xmda004                         #返回原欄位 

            ON ACTION controlp INFIELD xmda033               #客戶
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " xmdastus = 'N' AND xmda006 <> '5' "
               CALL q_xmda033()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda033      #顯示到畫面上
               NEXT FIELD xmda033                         #返回原欄位 

            ON ACTION controlp INFIELD xmda002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooagstus = 'Y' "               
               CALL q_ooag001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda002      #顯示到畫面上
               NEXT FIELD xmda002                         #返回原欄位 

            ON ACTION controlp INFIELD xmda003
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = " ooegstus = 'Y' "                
                CALL q_ooeg001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda003      #顯示到畫面上
                NEXT FIELD xmda003                         #返回原欄位 
                
         END CONSTRUCT 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_detail_cnt,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = TRUE)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               LET g_detail_d_t.* = g_detail_d[l_ac].*                     #BACKUP
               IF NOT cl_null(g_detail_d[g_detail_idx].xmdadocno) THEN 
                  CALL axmp220_fetch()                
               END IF                        
               
         END INPUT 
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xmdc_d TO s_detail2.* ATTRIBUTES(COUNT = g_detail2_cnt)
            BEFORE DISPLAY
               LET g_current_page = 1

         END DISPLAY
         
         DISPLAY ARRAY g_xmdd_d TO s_detail3.* ATTRIBUTES(COUNT = g_detail3_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2

         END DISPLAY

         DISPLAY ARRAY g_xmdb_d TO s_detail4.* ATTRIBUTES(COUNT = g_detail4_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3

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
            CALL axmp220_filter()
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
            CALL axmp220_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axmp220_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute              #執行 
            LET l_cnt = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
                IF g_detail_d[li_idx].sel = "Y" THEN
                   LET l_cnt = l_cnt + 1
                END IF
            END FOR
            IF l_cnt > 0 THEN
               CALL axmp220_process() 
               CALL cl_ask_confirm3("std-00012","")          #批次作業已執行完成。       
               IF cl_ask_confirm('asf-00182') THEN           #是否繼續執行？
                  CALL g_detail_d.clear()
                  CALL g_xmdc_d.clear()
                  CALL g_xmdd_d.clear()
                  CALL g_xmdb_d.clear()
                  CALL axmp220_query()
               ELSE
                  LET g_action_choice = 'exit'
                  EXIT DIALOG
               END IF  
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00481'    #未勾選任何資料！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()           
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
 
{<section id="axmp220.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmp220_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_sql      STRING
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"


   #end add-point
        
   LET g_error_show = 1
   CALL axmp220_b_fill()
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
 
{<section id="axmp220.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmp220_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
    LET g_sql = "SELECT DISTINCT     'N',xmdadocno,xmdadocdt,xmda004,xmda033, ",
               "                 xmda002,  xmda003,  xmda005,xmda009,xmda010, ",
               "                 xmda011,  xmda012,  xmda013,xmda015 ",
               "  FROM xmda_t ",
               " WHERE xmdaent = ? ",
               "   AND xmdasite = '",g_site,"' ",
               "   AND xmdastus = 'N' AND xmda006 <> '5' ",   #需排除多角性質為5中間交易的單據
               "   AND ",g_wc ,               
               " ORDER BY xmdadocno "     
   #end add-point
 
   PREPARE axmp220_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmp220_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_detail_idx = 1
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel    ,g_detail_d[l_ac].xmdadocno,g_detail_d[l_ac].xmdadocdt,g_detail_d[l_ac].xmda004,g_detail_d[l_ac].xmda033,
   g_detail_d[l_ac].xmda002,  g_detail_d[l_ac].xmda003,  g_detail_d[l_ac].xmda005,g_detail_d[l_ac].xmda009,g_detail_d[l_ac].xmda010,
   g_detail_d[l_ac].xmda011,  g_detail_d[l_ac].xmda012,  g_detail_d[l_ac].xmda013,g_detail_d[l_ac].xmda015
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

      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmda002) RETURNING g_detail_d[l_ac].xmda002_desc
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmda003) RETURNING g_detail_d[l_ac].xmda003_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmda004) RETURNING g_detail_d[l_ac].xmda004_desc
      CALL s_desc_get_ooib002_desc(g_detail_d[l_ac].xmda009) RETURNING g_detail_d[l_ac].xmda009_desc
      CALL s_desc_get_acc_desc('238',g_detail_d[l_ac].xmda010) RETURNING g_detail_d[l_ac].xmda010_desc
      CALL s_desc_get_tax_desc1(g_site,g_detail_d[l_ac].xmda011) RETURNING g_detail_d[l_ac].xmda011_desc
      CALL s_desc_get_currency_desc(g_detail_d[l_ac].xmda015) RETURNING g_detail_d[l_ac].xmda015_desc
      #end add-point
      
      CALL axmp220_detail_show()      
 
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
   FREE axmp220_sel
   
   LET l_ac = 1
   CALL axmp220_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp220.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmp220_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_sql      STRING
   DEFINE l_success  LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_detail_idx) OR g_detail_idx <=0 THEN
      RETURN
   END IF 
   #訂單明細
   INITIALIZE g_xmdc_d TO NULL 
   LET l_sql = "SELECT xmdcseq,xmdc027,xmdc001,xmdc002,xmdc004, ",
               "       xmdc005,xmdc006,xmdc007,xmdc012,xmdc010, ",                   
               "       xmdc011,xmdc015,xmdc046,xmdc047,xmdc048, ",
               "       xmdc020,xmdc052,xmdc049,xmdc050 ",
               "  FROM xmdc_t ",
               " WHERE xmdcent = '",g_enterprise,"' " ,
               "   AND xmdcdocno = '",g_detail_d[g_detail_idx].xmdadocno,"'" ,
               " ORDER BY xmdcseq "

   PREPARE axmp220_sel_xmdc_pr FROM l_sql
   DECLARE axmp220_sel_xmdc_cs CURSOR FOR axmp220_sel_xmdc_pr 
   LET l_ac = 1

   FOREACH axmp220_sel_xmdc_cs INTO g_xmdc_d[l_ac].xmdcseq,g_xmdc_d[l_ac].xmdc027,g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc004, 
                                    g_xmdc_d[l_ac].xmdc005,g_xmdc_d[l_ac].xmdc006,g_xmdc_d[l_ac].xmdc007,g_xmdc_d[l_ac].xmdc012,g_xmdc_d[l_ac].xmdc010,                    
                                    g_xmdc_d[l_ac].xmdc011,g_xmdc_d[l_ac].xmdc015,g_xmdc_d[l_ac].xmdc046,g_xmdc_d[l_ac].xmdc047,g_xmdc_d[l_ac].xmdc048, 
                                    g_xmdc_d[l_ac].xmdc020,g_xmdc_d[l_ac].xmdc052,g_xmdc_d[l_ac].xmdc049,g_xmdc_d[l_ac].xmdc050
       CALL axmp220_xmdc027_ref(g_detail_d[g_detail_idx].xmda004,g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002,g_xmdc_d[l_ac].xmdc027)
         RETURNING g_xmdc_d[l_ac].pmao009,g_xmdc_d[l_ac].pmao010
       CALL s_desc_get_item_desc(g_xmdc_d[l_ac].xmdc001) RETURNING g_xmdc_d[l_ac].xmdc001_desc,g_xmdc_d[l_ac].xmdc001_desc_1
       CALL s_feature_description(g_xmdc_d[l_ac].xmdc001,g_xmdc_d[l_ac].xmdc002) RETURNING l_success,g_xmdc_d[l_ac].xmdc002_desc                    
       CALL s_desc_get_unit_desc(g_xmdc_d[l_ac].xmdc010) RETURNING g_xmdc_d[l_ac].xmdc010_desc                  
       CALL s_desc_get_acc_desc('221',g_xmdc_d[l_ac].xmdc004) RETURNING g_xmdc_d[l_ac].xmdc004_desc   
       CALL s_desc_get_unit_desc(g_xmdc_d[l_ac].xmdc006) RETURNING g_xmdc_d[l_ac].xmdc006_desc
       CALL s_desc_get_unit_desc(g_xmdc_d[l_ac].xmdc010) RETURNING g_xmdc_d[l_ac].xmdc010_desc
      
       LET l_ac = l_ac + 1      
   END FOREACH
   CALL g_xmdc_d.deleteElement(g_xmdc_d.getLength())
   LET g_detail2_cnt = l_ac - 1   
   
   #訂單交期明細
   #帶出訂單交期明細
   INITIALIZE g_xmdd_d TO NULL
   LET l_sql = "SELECT xmddseq,xmddseq1,xmdd003,xmdd001,xmdd002, ",
               "       xmdd004,xmddseq2,xmdd006 ",
               "  FROM xmdd_t ",
               " WHERE xmddent = '",g_enterprise,"' ",
               "   AND xmdddocno = '",g_detail_d[g_detail_idx].xmdadocno,"'"
   PREPARE axmp220_sel_xmdd_pr FROM l_sql
   DECLARE axmp220_sel_xmdd_cs CURSOR FOR axmp220_sel_xmdd_pr 
   LET l_ac = 1
  
   FOREACH axmp220_sel_xmdd_cs INTO g_xmdd_d[l_ac].xmddseq,g_xmdd_d[l_ac].xmddseq1,g_xmdd_d[l_ac].xmdd003,g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002, 
                                    g_xmdd_d[l_ac].xmdd004,g_xmdd_d[l_ac].xmddseq2,g_xmdd_d[l_ac].xmdd006 

       CALL s_desc_get_item_desc(g_xmdd_d[l_ac].xmdd001) RETURNING g_xmdd_d[l_ac].xmdd001_desc,g_xmdd_d[l_ac].xmdd001_desc_1
       CALL s_feature_description(g_xmdd_d[l_ac].xmdd001,g_xmdd_d[l_ac].xmdd002) RETURNING l_success,g_xmdd_d[l_ac].xmdd002_desc                    
       CALL s_desc_get_unit_desc(g_xmdd_d[l_ac].xmdd004) RETURNING g_xmdd_d[l_ac].xmdd004_desc                         
       LET l_ac = l_ac + 1      
   END FOREACH
   CALL g_xmdd_d.deleteElement(g_xmdd_d.getLength())
   LET g_detail3_cnt = l_ac - 1   
   
   #訂單多期預付款
   INITIALIZE g_xmdb_d TO NULL   
   LET l_sql = "SELECT xmdb001,xmdb002,xmdb003,xmdb004,xmdb005, ",
               "       xmdb006,xmdb007 ",
               "  FROM xmdb_t ",
               " WHERE xmdbent = '",g_enterprise,"' ",
               "   AND xmdbdocno = '",g_detail_d[g_detail_idx].xmdadocno,"'"
   PREPARE axmp220_sel_xmdb_pr FROM l_sql
   DECLARE axmp220_sel_xmdb_cs CURSOR FOR axmp220_sel_xmdb_pr 
   LET l_ac = 1
   FOREACH axmp220_sel_xmdb_cs INTO g_xmdb_d[l_ac].xmdb001,g_xmdb_d[l_ac].xmdb002,g_xmdb_d[l_ac].xmdb003,g_xmdb_d[l_ac].xmdb004,g_xmdb_d[l_ac].xmdb005, 
                                    g_xmdb_d[l_ac].xmdb006,g_xmdb_d[l_ac].xmdb007 
       CALL s_desc_get_ooib002_desc(g_xmdb_d[l_ac].xmdb002) RETURNING g_xmdb_d[l_ac].xmdb002_desc         
       LET l_ac = l_ac + 1      
   END FOREACH
   CALL g_xmdb_d.deleteElement(g_xmdb_d.getLength())
   LET g_detail4_cnt = l_ac - 1     
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmp220.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmp220_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp220.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axmp220_filter()
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
   
   CALL axmp220_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axmp220.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axmp220_filter_parser(ps_field)
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
 
{<section id="axmp220.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axmp220_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmp220_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp220.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 客戶料號品名/規格
# Memo...........:
# Usage..........: CALL axmp220_xmdc027_ref(p_xmda004,p_xmdc001,p_xmdc002,p_xmdc027)
#                  RETURNING r_pmao009,r_pmao010
# Input parameter: p_xmdc004      客戶
#                : p_xmdc001      料號
#                : p_xmdc002      產品特徵
#                : p_xmdc027      客戶料號
# Return code....: r_pmao009      客戶料號品名
#                : r_pmao010      客戶料號規格
# Date & Author..: 151023 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp220_xmdc027_ref(p_xmda004,p_xmdc001,p_xmdc002,p_xmdc027)
DEFINE p_xmda004  LIKE xmda_t.xmda004
DEFINE p_xmdc001  LIKE xmdc_t.xmdc001
DEFINE p_xmdc002  LIKE xmdc_t.xmdc002
DEFINE p_xmdc027  LIKE xmdc_t.xmdc027
DEFINE r_pmao009  LIKE pmao_t.pmao009
DEFINE r_pmao010  LIKE pmao_t.pmao010

   SELECT pmao009,pmao010
     INTO r_pmao009,r_pmao010
     FROM pmao_t
    WHERE pmaoent = g_enterprise
      AND pmao001 = p_xmda004
      AND pmao002 = p_xmdc001
      AND pmao003 = p_xmdc002
      AND pmao004 = p_xmdc027
      AND pmao000 = '2'    #161221-00064#19 add
      
    RETURN r_pmao009,r_pmao010
    
END FUNCTION

################################################################################
# Descriptions...: 執行訂單確認
# Memo...........:
# Usage..........: CALL axmp220_process()
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 151030 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp220_process()
  DEFINE i            LIKE type_t.num5
  DEFINE l_xmdadocno  LIKE xmda_t.xmdadocno
  DEFINE l_success    LIKE type_t.num5

    CALL cl_err_collect_init()   #匯總訊息-初始化
    LET g_extra_cnt = 0
    LET g_coll_title[1] = s_desc_get_error_desc('adb-00164')
    
    FOR i = 1 TO g_detail_d.getLength()
        IF g_detail_d[i].sel = "Y" THEN
           CALL s_transaction_begin()
           LET l_success = TRUE
           IF s_axmt500_conf_chk(g_detail_d[i].xmdadocno) THEN
              IF NOT s_axmt500_conf_upd(g_detail_d[i].xmdadocno) THEN
                 CALL s_transaction_end('N','0')              
                 LET l_success = FALSE
              END IF   
           ELSE
              CALL s_transaction_end('N','0')
              LET l_success = FALSE
           END IF
           IF l_success THEN
              #單據確認成功！
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'axr-00309'
              LET g_errparam.extend = g_detail_d[i].xmdadocno
              LET g_errparam.popup = TRUE
              CALL cl_err() 
              CALL s_transaction_end('Y','0')              
           END IF           
        END IF
        CALL axmp220_err_collect(g_detail_d[i].xmdadocno)
    END FOR
    CALL cl_err_collect_show()
END FUNCTION
################################################################################
# Descriptions...: 錯誤訊息補上單號
# Memo...........:
# Usage..........: CALL axmp220_err_collect(p_xmdadocno)
#                  
# Input parameter: p_xmdadocno 訂單單號
#                : 
# Return code....: 
#                : 
# Date & Author..: 151030 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp220_err_collect(p_xmdadocno)
   DEFINE p_xmdadocno   LIKE xmda_t.xmdadocno
   DEFINE l_i           LIKE type_t.num10
   
   FOR l_i = g_extra_cnt + 1 TO g_errcollect.getLength()
      LET g_errcollect[l_i].extra[1] = p_xmdadocno   #額外欄位資訊
   END FOR
   
   LET g_extra_cnt = g_errcollect.getLength()
END FUNCTION

#end add-point
 
{</section>}
 
