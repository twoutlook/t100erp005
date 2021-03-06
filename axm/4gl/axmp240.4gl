#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp240.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-10-29 10:57:02), PR版次:0002(2016-12-23 14:55:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: axmp240
#+ Description: 出貨單整批確認作業
#+ Creator....: 04543(2015-10-21 11:10:54)
#+ Modifier...: 04543 -SD/PR- 08992
 
{</section>}
 
{<section id="axmp240.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161207-00033#3   2016/12/20   By08992   一次性交易對象顯示說明，所以的客戶/供應商欄位都應該處理
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
   xmdksite         LIKE xmdk_t.xmdksite,
   xmdksite_desc    LIKE type_t.chr500,
   xmdk000          LIKE xmdk_t.xmdk000,
   xmdkdocno        LIKE xmdk_t.xmdkdocno,
   xmdkdocno_desc   LIKE type_t.chr500,
   xmdkdocdt        LIKE xmdk_t.xmdkdocdt,
   xmdk007          LIKE xmdk_t.xmdk007,
   xmdk007_desc     LIKE type_t.chr500,
   xmdk003          LIKE xmdk_t.xmdk003,
   xmdk003_desc     LIKE type_t.chr500,
   xmdk004          LIKE xmdk_t.xmdk004,
   xmdk004_desc     LIKE type_t.chr500,
   xmdk005          LIKE xmdk_t.xmdk005,
   xmdk006          LIKE xmdk_t.xmdk006,
   xmdk002          LIKE xmdk_t.xmdk002,
   xmdk008          LIKE xmdk_t.xmdk008,
   xmdk008_desc     LIKE type_t.chr500,
   xmdk009          LIKE xmdk_t.xmdk009,
   xmdk009_desc     LIKE type_t.chr500,
   xmdk010          LIKE xmdk_t.xmdk010,
   xmdk010_desc     LIKE type_t.chr500,
   xmdk011          LIKE xmdk_t.xmdk011,
   xmdk011_desc     LIKE type_t.chr500,
   xmdk012          LIKE xmdk_t.xmdk012,
   xmdk012_desc     LIKE type_t.chr500,
   xmdk013          LIKE xmdk_t.xmdk013
                     END RECORD
DEFINE g_rec_b          LIKE type_t.num5
DEFINE g_detail_idx     LIKE type_t.num10

TYPE type_g_detail2_d RECORD
   xmdlseq          LIKE xmdl_t.xmdlseq,
   xmdl001          LIKE xmdl_t.xmdl001,
   xmdl002          LIKE xmdl_t.xmdl002,
   xmdl003          LIKE xmdl_t.xmdl003,
   xmdl004          LIKE xmdl_t.xmdl004,
   xmdl005          LIKE xmdl_t.xmdl005,
   xmdl006          LIKE xmdl_t.xmdl006,
   xmdl007          LIKE xmdl_t.xmdl007,
   xmda033          LIKE xmda_t.xmda033,
   xmdl008          LIKE xmdl_t.xmdl008,
   xmdl008_desc     LIKE type_t.chr500,
   xmdl008_desc_1   LIKE type_t.chr500,
   xmdl009          LIKE xmdl_t.xmdl009,
   xmdl009_desc     LIKE type_t.chr500,
   xmdl033          LIKE xmdl_t.xmdl033,
   xmdl033_desc     LIKE type_t.chr500,
   xmdl033_desc_1   LIKE type_t.chr500,
   xmdl017          LIKE xmdl_t.xmdl017,
   xmdl017_desc     LIKE type_t.chr500,
   xmdl018          LIKE xmdl_t.xmdl018,
   xmdl023          LIKE xmdl_t.xmdl023,
   xmdl013          LIKE xmdl_t.xmdl013,
   xmdl052          LIKE xmdl_t.xmdl052,
   xmdl014          LIKE xmdl_t.xmdl014,
   xmdl014_desc     LIKE type_t.chr500,
   xmdl015          LIKE xmdl_t.xmdl015,
   xmdl015_desc     LIKE type_t.chr500,
   xmdl016          LIKE xmdl_t.xmdl016,
   xmdl050          LIKE xmdl_t.xmdl050,
   xmdl051          LIKE xmdl_t.xmdl051
                      END RECORD
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt         LIKE type_t.num10

TYPE type_g_detail3_d RECORD
   xmdmseq          LIKE xmdm_t.xmdmseq,
   xmdmseq1         LIKE xmdm_t.xmdmseq1,
   xmdm001          LIKE xmdm_t.xmdm001,
   xmdm001_desc     LIKE type_t.chr500,
   xmdm001_desc_1   LIKE type_t.chr500,
   xmdm002          LIKE xmdm_t.xmdm002,
   xmdm002_desc     LIKE type_t.chr500,
   xmdm003          LIKE xmdm_t.xmdm003,
   xmdm004          LIKE xmdm_t.xmdm004,
   xmdm033          LIKE xmdm_t.xmdm033,
   xmdm005          LIKE xmdm_t.xmdm005,
   xmdm005_desc     LIKE type_t.chr500,
   xmdm006          LIKE xmdm_t.xmdm006,
   xmdm006_desc     LIKE type_t.chr500,
   xmdm007          LIKE xmdm_t.xmdm007,
   xmdm008          LIKE xmdm_t.xmdm008,
   xmdm008_desc     LIKE type_t.chr500,
   xmdm009          LIKE xmdm_t.xmdm009
                      END RECORD
DEFINE g_detail3_d    DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt  LIKE type_t.num10
DEFINE g_extra_cnt    LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="axmp240.main" >}
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
   CALL axmp240_create_temp_table()
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp240 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmp240_init()   
 
      #進入選單 Menu (="N")
      CALL axmp240_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp240
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp240.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmp240_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   CALL cl_set_combo_scc_part('xmdk002','2063','1,2,3,4')
   CALL cl_set_combo_scc('b_xmdk002','2063')
   
   IF cl_null(g_argv[01]) THEN
      LET g_argv[01] = '1'
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp240.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp240_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt    LIKE type_t.num10
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_wc = '1=1'
   LET g_current_page = 1
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmp240_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,
                                   xmdk007,xmdk003,xmdk004,xmdk005,xmdk006,xmdk002,
                                   xmdk008,xmdk009,xmdk010,xmdk011,xmdk012

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdkdocno
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "1','2"
               LET g_qryparam.where = "xmdk002 <> '8' "
               
               IF g_argv[01] = '1' THEN #整批確認
                  IF cl_bpm_chk() THEN
                     LET g_qryparam.where =g_qryparam.where," AND xmdkstus = 'A' "
                  ELSE
                     LET g_qryparam.where =g_qryparam.where," AND xmdkstus IN ('N','A') "
                  END IF
               ELSE                     #整批過帳
                  LET g_qryparam.where =g_qryparam.where," AND xmdkstus = 'Y' "
               END IF
               
               CALL q_xmdkdocno_2()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上

               NEXT FIELD xmdkdocno                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk007
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               
               CALL q_pmaa001_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk007  #顯示到畫面上

               NEXT FIELD xmdk007                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk003
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003  #顯示到畫面上

               NEXT FIELD xmdk003                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk004
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk004  #顯示到畫面上

               NEXT FIELD xmdk004                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk005
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "xmdg001 <> '8' "

               CALL q_xmdgdocno()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk005  #顯示到畫面上

               NEXT FIELD xmdk005                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk006
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "xmda005 <> '8' "

               CALL q_xmdadocno_2()                   #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk006  #顯示到畫面上

               NEXT FIELD xmdk006                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk008
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               
               CALL q_pmac002_5()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk008  #顯示到畫面上

               NEXT FIELD xmdk008                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk009
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               
               CALL q_pmac002_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk009  #顯示到畫面上

               NEXT FIELD xmdk009                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk010
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               CALL q_pmad002_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk010  #顯示到畫面上

               NEXT FIELD xmdk010                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk011
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '238'

               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk011  #顯示到畫面上

               NEXT FIELD xmdk011                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk012
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site

               CALL q_oodb002_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk012  #顯示到畫面上

               NEXT FIELD xmdk012                     #返回原欄位
            
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
               CALL axmp240_fetch()
               
               IF g_current_page = 1 THEN
                  IF g_detail2_cnt = 0 THEN
                     LET g_detail_idx = 0
                  ELSE
                     CALL DIALOG.setCurrentRow("s_detail2",'1')
                     LET g_detail_idx = 1
                  END IF
               ELSE
                  IF g_detail3_cnt = 0 THEN
                     LET g_detail_idx = 0
                  ELSE
                     CALL DIALOG.setCurrentRow("s_detail3",'1')
                     LET g_detail_idx = 1
                  END IF
               END IF
               DISPLAY g_detail_idx TO FORMONLY.idx
               
               LET g_errshow = '1'
               
            ON ROW CHANGE
               #更新Temp_table
               UPDATE axmp240_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT = g_detail2_cnt)

             BEFORE DISPLAY
                LET g_current_page = 1
                LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
                DISPLAY g_detail_idx TO FORMONLY.idx
                
             BEFORE ROW
                LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
                DISPLAY g_detail_idx TO FORMONLY.idx

         END DISPLAY
         
         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT = g_detail3_cnt)

             BEFORE DISPLAY
                LET g_current_page = 2
                LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
                DISPLAY g_detail_idx TO FORMONLY.idx
                
             BEFORE ROW
                LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
                DISPLAY g_detail_idx TO FORMONLY.idx

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
            IF g_current_page = 1 THEN
               IF g_detail2_cnt = 0 THEN
                  LET g_detail_idx = 0
               ELSE
                  CALL DIALOG.setCurrentRow("s_detail2",'1')
                  LET g_detail_idx = 1
               END IF
            ELSE
               IF g_detail3_cnt = 0 THEN
                  LET g_detail_idx = 0
               ELSE
                  CALL DIALOG.setCurrentRow("s_detail3",'1')
                  LET g_detail_idx = 1
               END IF
            END IF
            DISPLAY g_detail_idx TO FORMONLY.idx
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
            UPDATE axmp240_tmp
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
            UPDATE axmp240_tmp
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
                  UPDATE axmp240_tmp
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
                  UPDATE axmp240_tmp
                     SET sel = 'N'
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmp240_filter()
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
            CALL axmp240_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axmp240_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF l_ac > 0 THEN
               UPDATE axmp240_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
            END IF
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM axmp240_tmp
             WHERE sel = 'Y'

            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            ELSE
               CALL axmp240_process()
               CALL axmp240_query()
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
 
{<section id="axmp240.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmp240_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"

   DELETE FROM axmp240_tmp;

   LET g_sql = "INSERT INTO axmp240_tmp ",
               "SELECT 'N',xmdkent,xmdksite,xmdk000,",
               "       xmdkdocno,xmdkdocdt,",
               "       xmdk007,xmdk003,xmdk004,xmdk005,",
               "       xmdk006,xmdk002,xmdk008,xmdk009,",
               "       xmdk010,xmdk011,xmdk012,xmdk013",
               "  FROM xmdk_t",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdksite = '",g_site,"'",
               "   AND xmdk000 IN ('1','2')",
               "   AND xmdk002 <> '8'",
               "   AND ",g_wc
   
   IF g_argv[01] = '1' THEN #整批確認
      IF cl_bpm_chk() THEN
         LET g_sql = g_sql," AND xmdkstus = 'A' "
      ELSE
         LET g_sql = g_sql," AND xmdkstus IN ('N','A') "
      END IF
   ELSE                     #整批過帳
      LET g_sql = g_sql," AND xmdkstus = 'Y' "
   END IF
   
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   LET g_wc_filter = " 1=1"

   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL axmp240_b_fill()
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
 
{<section id="axmp240.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmp240_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#3 add
   DEFINE l_pmak003       LIKE pmak_t.pmak003   #一次性交易對象全名   #161207-00033#3 add
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT 'N',xmdksite,a.ooefl003,",
               "                xmdk000,xmdkdocno,'',xmdkdocdt,",
               "                xmdk007,c.pmaal004,xmdk003,ooag011,",
               "                xmdk004,b.ooefl003,xmdk005,xmdk006,xmdk002,",
               "                xmdk008,d.pmaal004,xmdk009,e.pmaal004,",
               "                xmdk010,ooibl004,xmdk011,oocql004,",
               "                xmdk012,'',xmdk013",
               #161207-00033#3-s add
               "      ,(SELECT pmaa004 FROM pmaa_t WHERE pmaaent=xmdkent AND pmaa001=xmdk007)",
               #161207-00033#3-e add
               "  FROM axmp240_tmp ",
               "       LEFT OUTER JOIN ooefl_t a ON a.ooeflent = ",g_enterprise," AND a.ooefl001 = xmdksite AND a.ooefl002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN ooefl_t b ON b.ooeflent = ",g_enterprise," AND b.ooefl001 = xmdk004 AND b.ooefl002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN pmaal_t c ON c.pmaalent = ",g_enterprise," AND c.pmaal001 = xmdk007 AND c.pmaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN pmaal_t d ON d.pmaalent = ",g_enterprise," AND d.pmaal001 = xmdk007 AND d.pmaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN pmaal_t e ON e.pmaalent = ",g_enterprise," AND e.pmaal001 = xmdk007 AND e.pmaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN ooag_t ON ooagent = ",g_enterprise," AND ooag001 = xmdk003",
               "       LEFT OUTER JOIN ooibl_t ON ooiblent = ",g_enterprise," AND ooibl002 = xmdk010 AND ooibl003 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocql_t ON oocqlent = ",g_enterprise," AND oocql001 = '238' AND oocql002 = xmdk011 AND oocql003 = '",g_dlang,"'",
               " WHERE xmdkent = ?",
               "   AND ",g_wc_filter,
               " ORDER BY xmdkdocno"
   #end add-point
 
   PREPARE axmp240_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmp240_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,
      g_detail_d[l_ac].xmdksite,
      g_detail_d[l_ac].xmdksite_desc,
      g_detail_d[l_ac].xmdk000,
      g_detail_d[l_ac].xmdkdocno,
      g_detail_d[l_ac].xmdkdocno_desc,
      g_detail_d[l_ac].xmdkdocdt,
      g_detail_d[l_ac].xmdk007,
      g_detail_d[l_ac].xmdk007_desc,
      g_detail_d[l_ac].xmdk003,
      g_detail_d[l_ac].xmdk003_desc,
      g_detail_d[l_ac].xmdk004,
      g_detail_d[l_ac].xmdk004_desc,
      g_detail_d[l_ac].xmdk005,
      g_detail_d[l_ac].xmdk006,
      g_detail_d[l_ac].xmdk002,
      g_detail_d[l_ac].xmdk008,
      g_detail_d[l_ac].xmdk008_desc,
      g_detail_d[l_ac].xmdk009,
      g_detail_d[l_ac].xmdk009_desc,
      g_detail_d[l_ac].xmdk010,
      g_detail_d[l_ac].xmdk010_desc,
      g_detail_d[l_ac].xmdk011,
      g_detail_d[l_ac].xmdk011_desc,
      g_detail_d[l_ac].xmdk012,
      g_detail_d[l_ac].xmdk012_desc,
      g_detail_d[l_ac].xmdk013
      ,l_pmaa004   #161207-00033#3 add
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
      
      #單別說明
      CALL s_aooi200_get_slip_desc(g_detail_d[l_ac].xmdkdocno)
           RETURNING g_detail_d[l_ac].xmdkdocno_desc
      
      #稅別
      CALL s_desc_get_tax_desc1(g_site,g_detail_d[l_ac].xmdk012)
           RETURNING g_detail_d[l_ac].xmdk012_desc
      #161207-00033#3-s
      IF l_pmaa004 = '2' THEN   #2.一次性交易對象
         #一次性交易對象全名
         CALL s_desc_axm_get_oneturn_guest_desc('3',g_detail_d[l_ac].xmdkdocno)
              RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_detail_d[l_ac].xmdk007_desc = l_pmak003
            IF g_detail_d[l_ac].xmdk008 = g_detail_d[l_ac].xmdk007 THEN   #帳款客戶
               LET g_detail_d[l_ac].xmdk008_desc = g_detail_d[l_ac].xmdk007_desc
            END IF
            IF g_detail_d[l_ac].xmdk009 = g_detail_d[l_ac].xmdk007 THEN   #收貨客戶
               LET g_detail_d[l_ac].xmdk009_desc = g_detail_d[l_ac].xmdk007_desc
            END IF
         END IF
      END IF
      #161207-00033#3-e     
      #end add-point
      
      CALL axmp240_detail_show()      
 
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
   FREE axmp240_sel
   
   LET l_ac = 1
   CALL axmp240_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp240.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmp240_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   
   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   
   LET g_sql = "SELECT xmdlseq,",
               "       xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,",
               "       xmdl006,xmdl007,'',",
               "       xmdl008,a.imaal003,a.imaal004,",
               "       xmdl009,'',",
               "       xmdl033,b.imaal003,b.imaal004,",
               "       xmdl017,oocal003,",
               "       xmdl018,xmdl023,xmdl013,xmdl052,",
               "       xmdl014,inayl003,",
               "       xmdl015,inab003,",
               "       xmdl016,xmdl050,xmdl051",
               "  FROM xmdl_t",
               "     LEFT OUTER JOIN imaal_t a ON a.imaalent = ",g_enterprise," AND a.imaal001 = xmdl008 AND a.imaal002 = '",g_dlang,"'",
               "     LEFT OUTER JOIN imaal_t b ON b.imaalent = ",g_enterprise," AND b.imaal001 = xmdl033 AND b.imaal002 = '",g_dlang,"'",
               "     LEFT OUTER JOIN oocal_t ON oocalent = ",g_enterprise," AND oocal001 = xmdl017 AND oocal002 = '",g_dlang,"'",
               "     LEFT OUTER JOIN inayl_t ON inaylent = ",g_enterprise," AND inayl001 = xmdl014 AND inayl002 = '",g_dlang,"'",
               "     LEFT OUTER JOIN inab_t ON inabent = ",g_enterprise," AND inabsite = '",g_site,"' AND inab001 = xmdl014 AND inab002 = xmdl015",
               " WHERE xmdlent = ",g_enterprise,
               "   AND xmdldocno = '",g_detail_d[g_master_idx].xmdkdocno,"'",
               " ORDER BY xmdlseq"
   PREPARE xmdl_fill_pre FROM g_sql
   DECLARE xmdl_fill_cur CURSOR FOR xmdl_fill_pre
   
   LET g_sql = "SELECT xmdmseq,xmdmseq1,",
               "       xmdm001,imaal003,imaal004,",
               "       xmdm002,'',",
               "       xmdm003,xmdm004,xmdm033,",
               "       xmdm005,inayl003,",
               "       xmdm006,inab003,",
               "       xmdm007,",
               "       xmdm008,oocal003,",
               "       xmdm009",
               "  FROM xmdm_t",
               "     LEFT OUTER JOIN imaal_t a ON imaalent = ",g_enterprise," AND imaal001 = xmdm001 AND imaal002 = '",g_dlang,"'",
               "     LEFT OUTER JOIN inayl_t ON inaylent = ",g_enterprise," AND inayl001 = xmdm005 AND inayl002 = '",g_dlang,"'",
               "     LEFT OUTER JOIN inab_t ON inabent = ",g_enterprise," AND inabsite = '",g_site,"' AND inab001 = xmdm005 AND inab002 = xmdm006",
               "     LEFT OUTER JOIN oocal_t ON oocalent = ",g_enterprise," AND oocal001 = xmdm008 AND oocal002 = '",g_dlang,"'",
               " WHERE xmdment = ",g_enterprise,
               "   AND xmdmdocno = '",g_detail_d[g_master_idx].xmdkdocno,"'",
               " ORDER BY xmdmseq,xmdmseq1"
   PREPARE xmdm_fill_pre FROM g_sql
   DECLARE xmdm_fill_cur CURSOR FOR xmdm_fill_pre
   
   LET l_ac = 1
   FOREACH xmdl_fill_cur INTO g_detail2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #客戶訂購單號
      SELECT xmda033 INTO g_detail2_d[l_ac].xmda033
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmdadocno = g_detail2_d[l_ac].xmdl003
      
      #產品特徵
      CALL s_feature_description(g_detail2_d[l_ac].xmdl008,g_detail2_d[l_ac].xmdl009)
      RETURNING l_success,g_detail2_d[l_ac].xmdl009_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = '9035'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   
   IF g_current_page = 1 THEN
      LET g_detail2_cnt = l_ac - 1
      DISPLAY g_detail2_cnt TO FORMONLY.cnt
   END IF
   
   LET l_ac = 1
   FOREACH xmdm_fill_cur INTO g_detail3_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #產品特徵
      CALL s_feature_description(g_detail3_d[l_ac].xmdm001,g_detail3_d[l_ac].xmdm002)
      RETURNING l_success,g_detail3_d[l_ac].xmdm002_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = '9035'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
   
   IF g_current_page = 2 THEN
      LET g_detail3_cnt = l_ac - 1
      DISPLAY g_detail3_cnt TO FORMONLY.cnt
   END IF
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmp240.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmp240_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp240.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axmp240_filter()
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
   
   CALL axmp240_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axmp240.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axmp240_filter_parser(ps_field)
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
 
{<section id="axmp240.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axmp240_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmp240_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp240.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#Temp table
PRIVATE FUNCTION axmp240_create_temp_table()
   
   DROP TABLE axmp240_tmp;
   
   CREATE TEMP TABLE axmp240_tmp(
      sel              LIKE type_t.chr1,
      xmdkent          LIKE xmdk_t.xmdkent,
      xmdksite         LIKE xmdk_t.xmdksite,
      xmdk000          LIKE xmdk_t.xmdk000,
      xmdkdocno        LIKE xmdk_t.xmdkdocno,
      xmdkdocdt        LIKE xmdk_t.xmdkdocdt,
      xmdk007          LIKE xmdk_t.xmdk007,
      xmdk003          LIKE xmdk_t.xmdk003,
      xmdk004          LIKE xmdk_t.xmdk004,
      xmdk005          LIKE xmdk_t.xmdk005,
      xmdk006          LIKE xmdk_t.xmdk006,
      xmdk002          LIKE xmdk_t.xmdk002,
      xmdk008          LIKE xmdk_t.xmdk008,
      xmdk009          LIKE xmdk_t.xmdk009,
      xmdk010          LIKE xmdk_t.xmdk010,
      xmdk011          LIKE xmdk_t.xmdk011,
      xmdk012          LIKE xmdk_t.xmdk012,
      xmdk013          LIKE xmdk_t.xmdk013
      );
END FUNCTION

PRIVATE FUNCTION axmp240_process()
   DEFINE l_xmdk RECORD
      xmdksite         LIKE xmdk_t.xmdksite,
      xmdk000          LIKE xmdk_t.xmdk000,
      xmdkdocno        LIKE xmdk_t.xmdkdocno,
      xmdkdocdt        LIKE xmdk_t.xmdkdocdt,
      xmdk007          LIKE xmdk_t.xmdk007,
      xmdk003          LIKE xmdk_t.xmdk003,
      xmdk004          LIKE xmdk_t.xmdk004,
      xmdk005          LIKE xmdk_t.xmdk005,
      xmdk006          LIKE xmdk_t.xmdk006,
      xmdk002          LIKE xmdk_t.xmdk002,
      xmdk008          LIKE xmdk_t.xmdk008,
      xmdk009          LIKE xmdk_t.xmdk009,
      xmdk010          LIKE xmdk_t.xmdk010,
      xmdk011          LIKE xmdk_t.xmdk011,
      xmdk012          LIKE xmdk_t.xmdk012,
      xmdk013          LIKE xmdk_t.xmdk013
                 END RECORD
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_prog       LIKE type_t.chr20

   #有選擇的出貨單
   LET g_sql = "SELECT DISTINCT xmdksite,xmdk000,xmdkdocno,xmdkdocdt,",
               "                xmdk007,xmdk003,xmdk004,xmdk005,",
               "                xmdk006,xmdk002,xmdk008,xmdk009,",
               "                xmdk010,xmdk011,xmdk012,xmdk013",
               "  FROM axmp240_tmp",
               " WHERE sel = 'Y'",
               " ORDER BY xmdkdocno"
   PREPARE process_pre FROM g_sql
   DECLARE process_cur CURSOR WITH HOLD FOR process_pre
   
   #備份
   LET l_prog = g_prog
   LET g_extra_cnt = 0
   CALL cl_err_collect_init()   #匯總訊息-初始化
   LET g_coll_title[1] = s_desc_get_error_desc('axm-00732')

   INITIALIZE l_xmdk.* TO NULL
   FOREACH process_cur INTO l_xmdk.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_success = TRUE
      CALL s_transaction_begin()
      
      IF g_argv[01] = '1' THEN #整批確認
         CALL s_axmt540_conf_chk(l_xmdk.xmdkdocno) RETURNING l_success
         IF l_success THEN
            CALL s_axmt540_conf_upd(l_xmdk.xmdkdocno) RETURNING l_success
            IF l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00309' #單據確認成功！
               LET g_errparam.extend = l_xmdk.xmdkdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
         END IF
      ELSE                     #整批過帳
         CALL s_axmt540_post_chk(l_xmdk.xmdkdocno) RETURNING l_success
         IF l_success THEN
            CALL s_axmt540_post_upd(l_xmdk.xmdkdocno) RETURNING l_success
            IF l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'wss-00201' #單據過帳成功！
               LET g_errparam.extend = l_xmdk.xmdkdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF            
         END IF
      END IF
      
      CALL axmp240_err_collect(l_xmdk.xmdkdocno)
      
      IF l_success THEN
         CALL s_transaction_end('Y',0)
      ELSE
         CALL s_transaction_end('N',0)
      END IF
   END FOREACH
   
   LET g_prog = l_prog
   CALL cl_err_collect_show()
END FUNCTION

################################################################################
# Descriptions...: 錯誤訊息補上單號
# Memo...........:
# Usage..........: CALL axmp240_err_collect(p_xmdkdocno)
#                  
# Input parameter: p_xmdkdocno 出貨單號
#                : 
# Return code....: 
#                : 
# Date & Author..: 151030 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp240_err_collect(p_xmdkdocno)
   DEFINE p_xmdkdocno   LIKE xmdk_t.xmdkdocno
   DEFINE l_i           LIKE type_t.num10
   
   FOR l_i = g_extra_cnt + 1 TO g_errcollect.getLength()
      LET g_errcollect[l_i].extra[1] = p_xmdkdocno   #額外欄位資訊
   END FOR
   
   LET g_extra_cnt = g_errcollect.getLength()
END FUNCTION

#end add-point
 
{</section>}
 
