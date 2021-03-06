#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-07-12 14:34:49), PR版次:0006(2016-11-16 10:24:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: ainq901
#+ Description: 庫存交易明細查詢作業
#+ Creator....: 01752(2015-02-12 15:12:09)
#+ Modifier...: 07142 -SD/PR- 08734
 
{</section>}
 
{<section id="ainq901.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160705-00042#12   2016/07/15 By 02159   把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#161108-00012#2    2016/11/09 By 08734   g_browser_cnt 由num5改為num10
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_inaj_m RECORD
   inajsite            LIKE inaj_t.inajsite,
   inajsite_desc       LIKE type_t.chr500,
   inaj005             LIKE inaj_t.inaj005,
   imaal003            LIKE imaal_t.imaal003,
   imaal004            LIKE imaal_t.imaal004,
   inaj006             LIKE inaj_t.inaj006,
   inaj006_desc        LIKE type_t.chr500,
   inaj008             LIKE inaj_t.inaj008,
   inaj008_desc        LIKE type_t.chr500,
   inaj009             LIKE inaj_t.inaj009,
   inaj009_desc        LIKE type_t.chr500,
   inaj010             LIKE inaj_t.inaj010,
   inaj001             LIKE inaj_t.inaj001,
   inaa120             LIKE inaa_t.inaa120,
   inaa120_desc        LIKE type_t.chr500,
   inaj007             LIKE inaj_t.inaj007,
   inaj018             LIKE inaj_t.inaj018,
   inaj018_desc        LIKE type_t.chr500
END RECORD

#單身 type 宣告
 TYPE type_g_inaj_d RECORD
   sel                 LIKE type_t.chr1, 
   inajsite            LIKE inaj_t.inajsite,
   inajsite_desc       LIKE type_t.chr500,
   inaj005             LIKE inaj_t.inaj005,
   inaj005_desc        LIKE type_t.chr500,
   inaj005_desc_desc   LIKE type_t.chr500,
   inaj022             LIKE inaj_t.inaj022, 
   inaj001             LIKE inaj_t.inaj001, 
   inaj002             LIKE inaj_t.inaj002, 
   inaj003             LIKE inaj_t.inaj003, 
   inaj004             LIKE inaj_t.inaj004, 
   inaj036             LIKE inaj_t.inaj036, 
   inaj035             LIKE inaj_t.inaj035, 
   inaj035_desc        LIKE type_t.chr500, 
   inaj006             LIKE inaj_t.inaj006,
   inaj006_desc        LIKE type_t.chr500,
   inaj008             LIKE inaj_t.inaj008,
   inaj008_desc        LIKE type_t.chr500,
   inaa120             LIKE inaa_t.inaa120,
   inaa120_desc        LIKE type_t.chr500,
   inaj009             LIKE inaj_t.inaj009,
   inaj009_desc        LIKE type_t.chr500,
   inaj010             LIKE inaj_t.inaj010,
   inaj007             LIKE inaj_t.inaj007,
   inaj011             LIKE inaj_t.inaj011, 
   inaj012             LIKE inaj_t.inaj012, 
   inaj012_desc        LIKE type_t.chr500,
   l_qty               LIKE inag_t.inag008,
   inag007             LIKE inag_t.inag007,
   inag007_desc        LIKE type_t.chr500   
       END RECORD
       
 TYPE type_g_inaj2_d RECORD
   inaj001      LIKE inaj_t.inaj001, 
   inaj002      LIKE inaj_t.inaj002, 
   inaj003      LIKE inaj_t.inaj003, 
   inaj004      LIKE inaj_t.inaj004, 
   inaj017      LIKE inaj_t.inaj017, 
   inaj017_desc LIKE type_t.chr500, 
   inaj018      LIKE inaj_t.inaj018, 
   inaj018_desc LIKE type_t.chr500, 
   inaj044      LIKE inaj_t.inaj044, 
   inaj016      LIKE inaj_t.inaj016,
   inaj016_desc LIKE type_t.chr500
       END RECORD
 
 TYPE type_g_inaj3_d RECORD
   inaj001 LIKE inaj_t.inaj001, 
   inaj002 LIKE inaj_t.inaj002, 
   inaj003 LIKE inaj_t.inaj003, 
   inaj004 LIKE inaj_t.inaj004, 
   inaj023 LIKE inaj_t.inaj023, 
   inaj024 LIKE inaj_t.inaj024, 
   inaj025 LIKE inaj_t.inaj025, 
   inaj025_desc LIKE type_t.chr500
       END RECORD
  
#模組變數(Module Variables)
DEFINE g_inaj_m             type_g_inaj_m
DEFINE g_inaj_d             DYNAMIC ARRAY OF type_g_inaj_d
DEFINE g_inaj_d_t           type_g_inaj_d
DEFINE g_inaj2_d            DYNAMIC ARRAY OF type_g_inaj2_d
DEFINE g_inaj2_d_t          type_g_inaj2_d
DEFINE g_inaj3_d            DYNAMIC ARRAY OF type_g_inaj3_d
DEFINE g_inaj3_d_t          type_g_inaj3_d
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10   #161108-00012#2 num5==》num10            
DEFINE l_ac_d               LIKE type_t.num10               #單身idx  #161108-00012#2 num5==》num10
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10              #目前所在頁數  #161108-00012#2 num5==》num10
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)  #161108-00012#2 num5==》num10
DEFINE g_detail_cnt2        LIKE type_t.num10              #單身 總筆數(所有資料)  #161108-00012#2 num5==》num10
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_detail_idx         LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_detail_idx2        LIKE type_t.num10  #161108-00012#2 num5==》num10
#DEFINE g_browser_cnt        LIKE type_t.num5   #161108-00012#2  2016/11/09 By 08734 mark
DEFINE g_browser_cnt        LIKE type_t.num10   #161108-00012#2  2016/11/09 By 08734 add
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_wc_filter_table    STRING
DEFINE g_no_ask             LIKE type_t.num5
DEFINE g_jump               LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_cons      RECORD
     inaj006             LIKE type_t.chr500,
     inaj008             LIKE type_t.chr500,
     inaj009             LIKE type_t.chr500,
     inaj010             LIKE type_t.chr500,
     inaa120             LIKE type_t.chr500,
     inaj007             LIKE type_t.chr500,
     inaj018             LIKE type_t.chr500
                   END RECORD
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="ainq901.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = " "
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE ainq901_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq901 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainq901_init()
 
      #進入選單 Menu (='N')
      CALL ainq901_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_ainq901
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="ainq901.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION ainq901_init()
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   CALL cl_set_combo_scc('b_inaj036','200')
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   CALL ainq901_default_search()
END FUNCTION

PRIVATE FUNCTION ainq901_default_search()
  
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " inajsite = '", g_argv[01], "' AND "
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " inaj001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " inaj002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " inaj003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " inaj004 = '", g_argv[05], "' AND "
   END IF
   
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF

   INITIALIZE g_cons.* TO NULL
   #如果有要給預設條件 要記得也給g_cons.*的相關欄位值 在後續的判斷才不會出問題
   
END FUNCTION

PRIVATE FUNCTION ainq901_ui_dialog()
   DEFINE ls_wc    STRING
   DEFINE li_idx   LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE lc_action_choice_old     STRING

   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)

   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL ainq901_b_fill()
   ELSE
      CALL ainq901_query()
   END IF

   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_inaj_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 1
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_inaj_d.getLength() TO FORMONLY.cnt

         END DISPLAY

         DISPLAY ARRAY g_inaj2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 2
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               
            BEFORE ROW
               
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_inaj2_d.getLength() TO FORMONLY.cnt

         END DISPLAY

         DISPLAY ARRAY g_inaj3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 3
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               
            BEFORE ROW               
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_inaj3_d.getLength() TO FORMONLY.cnt

         END DISPLAY

         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL ainq901_comp_visible('2')
            CALL cl_navigator_setting(g_master_idx,g_browser_cnt)

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               EXIT DIALOG
            END IF

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ainq901_query()
               EXIT DIALOG
            END IF

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               EXIT DIALOG
            END IF

         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainq901_filter()
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL ainq901_b_fill()

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL cl_set_comp_visible("l_inajsite,l_inajsite_desc,l_inaj005,l_inaj005_desc,l_inaj005_desc_desc",TRUE)
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_inaj_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_inaj2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_inaj3_d)
               LET g_export_id[3]   = "s_detail3"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
               CALL cl_set_comp_visible("l_inajsite,l_inajsite_desc,l_inaj005,l_inaj005_desc,l_inaj005_desc_desc",FALSE)
            END IF

         ON ACTION agendum   # 待辦事項
            CALL cl_user_overview()
            
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ainq901_fetch('F')
            LET g_curr_diag = ui.DIALOG.getCurrent()

         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ainq901_fetch('P')
            LET g_curr_diag = ui.DIALOG.getCurrent()

         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ainq901_fetch('/')
            LET g_curr_diag = ui.DIALOG.getCurrent()

         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ainq901_fetch('N')
            LET g_curr_diag = ui.DIALOG.getCurrent()

         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ainq901_fetch('L')
            LET g_curr_diag = ui.DIALOG.getCurrent() 
            
        ##有關於sel欄位選取的action段落
        ##選擇全部
        #ON ACTION selall
        #   CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
        #   FOR li_idx = 1 TO g_inaj_d.getLength()
        #      LET g_inaj_d[li_idx].sel = "Y"
        #   END FOR
        ##取消全部
        #ON ACTION selnone
        #   CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
        #   FOR li_idx = 1 TO g_inaj_d.getLength()
        #      LET g_inaj_d[li_idx].sel = "N"
        #   END FOR
        ##勾選所選資料
        #ON ACTION sel
        #   FOR li_idx = 1 TO g_inaj_d.getLength()
        #      IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
        #         LET g_inaj_d[li_idx].sel = "Y"
        #      END IF
        #   END FOR
        ##取消所選資料
        #ON ACTION unsel
        #   FOR li_idx = 1 TO g_inaj_d.getLength()
        #      IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
        #         LET g_inaj_d[li_idx].sel = "N"
        #      END IF
        #   END FOR
            
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION ainq901_query()
   DEFINE ls_wc         LIKE type_t.chr500
   DEFINE ls_wc2        LIKE type_t.chr500
   DEFINE l_cs_sql      STRING
   DEFINE l_cnt_sql     STRING
   DEFINE l_sql_order   STRING
   DEFINE ls_return     STRING
   DEFINE ls_result     STRING
   DEFINE l_def_date    LIKE type_t.chr100
   DEFINE l_yy          LIKE type_t.num5
   DEFINE l_mm          LIKE type_t.num5
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_inaj_d.clear()
   CALL g_inaj2_d.clear()
   CALL g_inaj3_d.clear()

   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter =  " 1=1"

   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac

   LET l_yy = YEAR(g_today)
   LET l_mm = MONTH(g_today)
   LET l_mm = l_mm - 3
   IF l_mm <= 0 THEN
      LET l_mm = l_mm + 12
      LET l_yy = l_yy - 1
   END IF
   
   LET l_def_date = "> ",MDY(l_mm,1,l_yy)
   
   
   INITIALIZE g_cons.* TO NULL

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單身根據table分拆construct
      CONSTRUCT g_wc ON inajsite,inaj005,inaj006,inaj008,
                              inaj009,inaj010,inaj007,inaa120,inaj018,
                              inaj022,inaj001,inaj001,inaj002,inaj003,
                              inaj004,inaj036,inaj035,inaj011,
                              inaj012,inaj017,inaj044,
                              inaj016,inaj023,inaj024,inaj025
           FROM b_inajsite,b_inaj005,b_inaj006,b_inaj008,
                b_inaj009,b_inaj010,b_inaj007,l_inaa120,l_inaj018,
                l_inaj022,inaj001,s_detail1[1].b_inaj001,s_detail1[1].b_inaj002,s_detail1[1].b_inaj003,
                s_detail1[1].b_inaj004,s_detail1[1].b_inaj036,s_detail1[1].b_inaj035,s_detail1[1].b_inaj011,
                s_detail1[1].b_inaj012,s_detail2[1].b_inaj017,s_detail2[1].b_inaj044,
                s_detail2[1].b_inaj016,s_detail3[1].b_inaj023,s_detail3[1].b_inaj024,s_detail3[1].b_inaj025

         BEFORE CONSTRUCT
            CALL ainq901_comp_visible('1')
            DISPLAY l_def_date TO l_inaj022
            
         ON ACTION controlp INFIELD b_inajsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inajsite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_inajsite  #顯示到畫面上         
            NEXT FIELD b_inajsite                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj005  #顯示到畫面上
            NEXT FIELD b_inaj005                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj006
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj006()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj006  #顯示到畫面上
            NEXT FIELD b_inaj006                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj008
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inay001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj008  #顯示到畫面上
            NEXT FIELD b_inaj008                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj009
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_7()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj009  #顯示到畫面上
            NEXT FIELD b_inaj009                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj010
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj010()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj010  #顯示到畫面上
            NEXT FIELD b_inaj010                     #返回原欄位    
            
         ON ACTION controlp INFIELD b_inaj007
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj007()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj007  #顯示到畫面上
            NEXT FIELD b_inaj007 
            #返回原欄位
         ON ACTION controlp INFIELD inaj001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaj001  #顯示到畫面上
            NEXT FIELD inaj001   
         ON ACTION controlp INFIELD b_inaj001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj001  #顯示到畫面上
            NEXT FIELD b_inaj001                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj035
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj035  #顯示到畫面上            
            NEXT FIELD b_inaj035                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj012
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj012  #顯示到畫面上
            NEXT FIELD b_inaj012                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj017
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj017  #顯示到畫面上
            NEXT FIELD b_inaj017                     #返回原欄位
            
         ON ACTION controlp INFIELD l_inaj018
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_inaj018  #顯示到畫面上
            NEXT FIELD l_inaj018                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj044
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj044_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj044  #顯示到畫面上
            NEXT FIELD b_inaj044                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj016
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj016()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj016  #顯示到畫面上
            NEXT FIELD b_inaj016                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj025
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj025  #顯示到畫面上
            NEXT FIELD b_inaj025                     #返回原欄位
            
         AFTER CONSTRUCT
              LET g_cons.inaj006  = GET_FLDBUF(b_inaj006) 
              LET g_cons.inaj008  = GET_FLDBUF(b_inaj008) 
              LET g_cons.inaj009  = GET_FLDBUF(b_inaj009) 
              LET g_cons.inaj010  = GET_FLDBUF(b_inaj010) 
              LET g_cons.inaa120  = GET_FLDBUF(l_inaa120) 
              LET g_cons.inaj007  = GET_FLDBUF(b_inaj007) 
              LET g_cons.inaj018  = GET_FLDBUF(l_inaj018)
      END CONSTRUCT

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

      ON ACTION qbeclear   # 條件清除
         CLEAR FORM

   END DIALOG

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      LET g_wc_filter = g_wc_filter_t
   ELSE
      LET g_master_idx = 1
   END IF
   
   
   IF cl_null(g_wc) THEN
      LET g_wc = s_aooi500_sql_where(g_prog,'inajsite')
   ELSE
      LET g_wc = g_wc, " AND ",s_aooi500_sql_where(g_prog,'inajsite')
   END IF
   LET g_sql = ''
   
   LET l_cs_sql  = "SELECT UNIQUE inajsite,inaj005"
   LET l_cnt_sql = "SELECT COUNT(UNIQUE inajsite||'|'||inaj005"
   LET l_sql_order = "ORDER BY inajsite,inaj005"
   IF NOT cl_null(g_cons.inaj006) THEN
      LET l_cs_sql  = l_cs_sql,",inaj006"
      LET l_cnt_sql = l_cnt_sql,"||'|'||inaj006"      
      LET l_sql_order = l_sql_order,",inaj006"
   END IF

   IF NOT cl_null(g_cons.inaj007) THEN
      LET l_cs_sql = l_cs_sql,",inaj007"
      LET l_cnt_sql = l_cnt_sql,"||'|'||inaj007"    
       LET l_sql_order = l_sql_order,",inaj007"
   END IF

   IF NOT cl_null(g_cons.inaj008) THEN
      LET l_cs_sql = l_cs_sql,",inaj008"
      LET l_cnt_sql = l_cnt_sql,"||'|'||inaj008"  
      LET l_sql_order = l_sql_order,",inaj008"      
   END IF

   IF NOT cl_null(g_cons.inaj009) THEN
      LET l_cs_sql = l_cs_sql,",inaj009"
      LET l_cnt_sql = l_cnt_sql,"||'|'||inaj009" 
       LET l_sql_order = l_sql_order,",inaj009"      
   END IF

   IF NOT cl_null(g_cons.inaj010) THEN
      LET l_cs_sql = l_cs_sql,",inaj010"
      LET l_cnt_sql = l_cnt_sql,"||'|'||inaj010" 
      LET l_sql_order = l_sql_order,",inaj010"      
   END IF
   
   IF NOT cl_null(g_cons.inaa120) THEN
      LET l_cs_sql = l_cs_sql,",inaa120"
      LET l_cnt_sql = l_cnt_sql,"||'|'||inaa120" 
      LET l_sql_order = l_sql_order,",inaa120"      
   END IF
   
   IF NOT cl_null(g_cons.inaj018) THEN
      LET l_cs_sql = l_cs_sql,",inaj018"
      LET l_cnt_sql = l_cnt_sql,"||'|'||inaj018" 
      LET l_sql_order = l_sql_order,",inaj018"      
   END IF
   
   LET g_sql = l_cs_sql ,
             "  FROM inaj_t,inaa_t ",
             " WHERE inajent = ? ",
             "   AND inajent = inaaent ",
             "   AND inajsite = inaasite",
             "   AND inaj008 = inaa001",
             "   AND ",g_wc CLIPPED," AND ",g_wc_filter
             
   LET g_sql = g_sql CLIPPED," ",l_sql_order 
             
             
#   LET g_sql = "SELECT UNIQUE inajsite,inaj005,inaj006,inaj008,inaj009,inaj010,inaj007",
#               "  FROM inaj_t ",
#               " WHERE inajent = ? ",
#               "   AND ",g_wc CLIPPED," AND ",g_wc_filter,
#               " ORDER BY inajsite,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010"
   PREPARE ainq901_prep FROM g_sql
   DECLARE ainq901_cs  SCROLL CURSOR WITH HOLD FOR ainq901_prep
   
   LET g_sql = ''
   
   LET g_sql = l_cnt_sql ,")",
             "  FROM inaj_t,inaa_t ",
             " WHERE inajent = ? ",
             "   AND inajent = inaaent ",
             "   AND inajsite = inaasite",
             "   AND inaj008 = inaa001",
             "   AND ",g_wc CLIPPED," AND ",g_wc_filter
#   LET g_sql = "SELECT COUNT(UNIQUE inajsite||'|'||inaj005||'|'||inaj006||'|'||inaj008||'|'||inaj009||'|'||inaj010||'|'||inaj007)",
#               "  FROM inaj_t ",
#               " WHERE inajent = ? ",
#               "   AND ",g_wc CLIPPED," AND ",g_wc_filter
   PREPARE ainq901_precount FROM g_sql
   DECLARE ainq901_count CURSOR FOR ainq901_precount
   
   
   OPEN ainq901_cs USING g_enterprise
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "OPEN ainq901_cs:"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   ELSE
      OPEN ainq901_count USING g_enterprise 
      FETCH ainq901_count INTO g_browser_cnt
      DISPLAY g_browser_cnt TO FORMONLY.h_count
      CALL ainq901_fetch('F')                 # 讀出TEMP第一筆並顯示
   END IF
   
END FUNCTION

PRIVATE FUNCTION ainq901_b_fill()
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE l_sql           STRING  #150924-00002#1 20150924 s983961--ADD

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF

   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   #150204-00013#8 150309 pomelo mark(s)
   #LET g_sql = "SELECT  UNIQUE '',inaj022,inaj001,inaj002,inaj003,inaj004,inaj036,inaj035,'',inaj011,
   #    inaj012,'','','','','',inaj017,'',inaj018,'',inaj044,inaj016,'','','','',inaj023,inaj024,inaj025,
   #    '' FROM inaj_t,inaa_t",
   #150204-00013#8 150309 pomelo mark(e)
   
   #150924-00002#1 20150924 s983961--mark and mod (s)效能調整
   #150204-00013#8 150309 pomelo add(s)
   #LET g_sql = "SELECT UNIQUE '',          inaj022,      inaj001,     inaj002,",
   #            "              inaj003,     inaj004,      inaj036,     inaj035,",
   #            "              t1.gzzal003, inaj006,      inaj008,     t2.inayl003,",
   #            "              inaa120,     t12.mhael023, inaj009,     t3.inab003,",
   #            "              inaj010,     inaj007,      inaj011,     inaj012,",
   #            "              t4.oocal003, t5.inag007,   t6.oocal003, inaj001,",
   #            "              inaj002,     inaj003,      inaj004,     inaj017,",
   #            "              t7.ooefl003, inaj018,      t8.pmaal004, inaj044,",
   #            "              inaj016,     t10.oocql004, inaj001,     inaj002,",
   #            "              inaj003,     inaj004,      inaj023,     inaj024,",
   #            "              inaj025,     t11.ooag011",
   #            "  FROM inaj_t",
   #            "  LEFT OUTER JOIN gzzal_t t1 ON t1.gzzal001 = inaj035",
   #            "                            AND t1.gzzal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN inayl_t t2 ON t2.inaylent = inajent",
   #            "                            AND t2.inayl001 = inaj008",
   #            "                            AND t2.inayl002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN inab_t  t3 ON t3.inabent = inajent",
   #            "                            AND t3.inabsite = inajsite",
   #            "                            AND t3.inab001  = inaj008",
   #            "                            AND t3.inab002  = inaj009",
   #            "  LEFT OUTER JOIN oocal_t t4 ON t4.oocalent = inajent",
   #            "                            AND t4.oocal001 = inaj012",
   #            "                            AND t4.oocal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN inag_t  t5 ON t5.inagent  = inajent",
   #            "                            AND t5.inagsite = inajsite",
   #            "                            AND t5.inag001  = inaj005",
   #            "                            AND t5.inag002  = inaj006",
   #            "                            AND t5.inag003  = inaj007",
   #            "                            AND t5.inag004  = inaj008",
   #            "                            AND t5.inag005  = inaj009",
   #            "                            AND t5.inag006  = inaj010",
   #            "  LEFT OUTER JOIN oocal_t t6 ON t6.oocalent = inajent",
   #            "                            AND t6.oocal001 = t5.inag007",
   #            "                            AND t6.oocal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN ooefl_t t7 ON t7.ooeflent = inajent",
   #            "                            AND t7.ooefl001 = inaj017",
   #            "                            AND t7.ooefl002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN pmaal_t t8 ON t8.pmaalent = inajent",
   #            "                            AND t8.pmaal001 = inaj018",
   #            "                            AND t8.pmaal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN gzcb_t  t9 ON t9.gzcb001 = '24'",
   #            "                            AND t9.gzcb002 = inaj035",
   #            "  LEFT OUTER JOIN oocql_t t10 ON t10.oocqlent = inajent",
   #            "                             AND t10.oocql001 = t9.gzcb004",
   #            "                             AND t10.oocql002 = inaj016",
   #            "                             AND t10.oocql003 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN ooag_t  t11 ON t11.ooagent = inajent",
   #            "                             AND t11.ooag001 = inaj025,",
   #            "       inaa_t ",
   #            "  LEFT OUTER JOIN mhael_t t12 ON t12.mhaelent = inaaent ",
   #            "                             AND t12.mhael001 = inaa120 ",
   #            "                             AND t12.mhael022 = '",g_dlang,"'",
   ##150204-00013#8 150309 pomelo add(e)
   #            " WHERE inajent= ? ", 
   #            "   AND inajent = inaaent ",
   #            "   AND inajsite = inaasite",
   #            "   AND inaj008 = inaa001 AND ",ls_wc
         
   #LET g_sql = g_sql CLIPPED,
   #            " AND inajsite = '",g_inaj_m.inajsite CLIPPED,"'"

   LET g_sql = "SELECT UNIQUE '',          inaj022,      inaj001,     inaj002,",
               "              inaj003,     inaj004,      inaj036,     inaj035,",
               "              (SELECT gzzal003 ",
               "                 FROM gzzal_t ",
               "                WHERE gzzal001 = inaj035 AND gzzal002 ='"||g_dlang||"') inaj035_desc, ",
               "              inaj006, ",
               "              inaj008, ",
               "              (SELECT inayl003 ",
               "                 FROM inayl_t ",
               "                WHERE inaylent = inajent AND inayl001 = inaj008 AND inayl002 ='"||g_dlang||"') inaj008_desc, ",
               "              inaa120, ",
               "              (SELECT mhael023 ",
               "                 FROM mhael_t ",
               "                WHERE mhaelent = inaaent AND mhael001 = inaa120 AND mhael022 ='"||g_dlang||"') inaa120_desc, ",
               "              inaj009, ",
               "              (SELECT inab003 ",
               "                 FROM inab_t ",
               "                WHERE inabent = inajent AND inabsite = inajsite AND inab001  = inaj008 AND inab002  = inaj009) inaj009_desc, ",
               "              inaj010,     inaj007,      inaj011, ",
               "              inaj012,",
               "              (SELECT oocal003 ",
               "                 FROM oocal_t ",
               "                WHERE oocalent = inajent AND oocal001 = inaj012 AND oocal002 ='"||g_dlang||"') inaj012_desc, ",
               "              inag007, ",
               "              (SELECT oocal003 ",
               "                 FROM oocal_t ",
               "                WHERE oocalent = inajent AND oocal001 = inag007 AND oocal002 ='"||g_dlang||"') inag007_desc, ",
               "              inaj001,     inaj002,      inaj003,     inaj004, ",
               "              inaj017,",
               "              (SELECT ooefl003 ",
               "                 FROM ooefl_t ",
               "                WHERE ooeflent = inajent AND ooefl001 = inaj017 AND ooefl002 ='"||g_dlang||"') inaj017_desc, ",
               "              inaj018, ",
               "              (SELECT pmaal004 ",
               "                 FROM pmaal_t ",
               "                WHERE pmaalent = inajent AND pmaal001 = inaj018 AND pmaal002 ='"||g_dlang||"') inaj018_desc, ",
               "              inaj044,",
               "              inaj016, ",
               "              (SELECT oocql004 ",
               #"                 FROM oocql_t,gzcb_t ",         #160705-00042#12 160715 by sakura mark 
               "                 FROM oocql_t,gzcb_t,gzzz_t ",   #160705-00042#12 160715 by sakura add
               "                WHERE oocqlent = inajent ",
               "                  AND oocql001 = gzcb004 ",
               "                  AND gzcb001 = '24'",     #2015/10/19 S983961 add--改串在select說明欄位
               #"                  AND gzcb002 = inaj035 ", #2015/10/19 S983961 add--改串在select說明欄位   #160705-00042#12 160715 by sakura mark
               "                  AND gzcb002 = gzzz006 AND gzzz001 = inaj035 ",                           #160705-00042#12 160715 by sakura add     
               "                  AND oocql002 = inaj016 ",
               "                  AND oocql003 ='"||g_dlang||"') inaj016_desc, ",
               "              inaj001,     inaj002,      inaj003, ",
               "              inaj004,     inaj023,      inaj024,",
               "              inaj025, ",
               "              (SELECT ooag011 ",
               "                 FROM ooag_t ",
               "                WHERE ooagent = inajent AND ooag001 = inaj025) inaj025_desc ",
               "  FROM inaj_t",
               "  LEFT OUTER JOIN inag_t     ON inagent  = inajent",
               "                            AND inagsite = inajsite",
               "                            AND inag001  = inaj005",
               "                            AND inag002  = inaj006",
               "                            AND inag003  = inaj007",
               "                            AND inag004  = inaj008",
               "                            AND inag005  = inaj009",
               "                            AND inag006  = inaj010",
               #"  LEFT OUTER JOIN gzcb_t     ON gzcb001 = '24'",     #2015/10/19 S983961 mark--改串在select說明欄位
               #"                            AND gzcb002 = inaj035 ", #2015/10/19 S983961 mark--改串在select說明欄位
               "       ,inaa_t ",
               " WHERE inajent= ? ", 
               "   AND inajent = inaaent ",
               "   AND inajsite = inaasite",
               "   AND inaj008 = inaa001 AND ",ls_wc
         
   LET g_sql = g_sql CLIPPED,
               " AND inajsite = '",g_inaj_m.inajsite CLIPPED,"'"
               


   LET l_sql = " SELECT inajsite,inaj005,inaj006,inaj007, ",
               "        inaj008,inaj009,inaj010,inaa120   ",
               "   FROM inaj_t,inaa_t         ",
               "  WHERE inajent = ?           ",
               "    AND inajent = inaaent     ",
               "    AND inajsite = inaasite   ",
               "    AND inaj008 = inaa001     ",
               "    AND inaj001 = ? ",
               "    AND inaj002 = ? ",
               "    AND inaj003 = ? ",
               "    AND inaj004 = ? "                 
   LET l_sql = l_sql CLIPPED,
               " AND inajsite = '",g_inaj_m.inajsite CLIPPED,"'"             
   PREPARE ainq901_pb_d FROM l_sql
   #150924-00002#1 20150924 s983961--mark and mod (e)效能調整   
        
  
   IF g_inaj_m.inaj005 IS NULL THEN
      LET g_sql = g_sql CLIPPED,
                  " AND inaj005 IS NULL"
   ELSE 
      IF cl_null(g_inaj_m.inaj005) THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaj005 = ' '"
      ELSE
         LET g_sql = g_sql CLIPPED,
                     " AND inaj005 = '",g_inaj_m.inaj005 CLIPPED,"'"
      END IF
   END IF

   IF NOT cl_null(g_cons.inaj006) THEN
      IF g_inaj_m.inaj006 IS NULL THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaj006 IS NULL"
      ELSE 
         IF cl_null(g_inaj_m.inaj006) THEN
            LET g_sql = g_sql CLIPPED,
                        " AND inaj006 = ' '"
         ELSE
            LET g_sql = g_sql CLIPPED,
                        " AND inaj006 = '",g_inaj_m.inaj006 CLIPPED,"'"
         END IF
      END IF 
   END IF      
   
   IF NOT cl_null(g_cons.inaj007) THEN
      IF g_inaj_m.inaj007 IS NULL THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaj007 IS NULL"
      ELSE 
         IF cl_null(g_inaj_m.inaj007) THEN
            LET g_sql = g_sql CLIPPED,
                        " AND inaj007 = ' '"
         ELSE
            LET g_sql = g_sql CLIPPED,
                        " AND inaj007 = '",g_inaj_m.inaj007 CLIPPED,"'"
         END IF
      END IF   
   END IF
   
   IF NOT cl_null(g_cons.inaj008) THEN
      IF g_inaj_m.inaj008 IS NULL THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaj008 IS NULL"
      ELSE 
         IF cl_null(g_inaj_m.inaj008) THEN
            LET g_sql = g_sql CLIPPED,
                        " AND inaj008 = ' '"
         ELSE
            LET g_sql = g_sql CLIPPED,
                        " AND inaj008 = '",g_inaj_m.inaj008 CLIPPED,"'"
         END IF
      END IF 
   END IF      
   
   IF NOT cl_null(g_cons.inaj009) THEN
      IF g_inaj_m.inaj009 IS NULL THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaj009 IS NULL"
      ELSE 
         IF cl_null(g_inaj_m.inaj009) THEN
            LET g_sql = g_sql CLIPPED,
                        " AND inaj009 = ' '"
         ELSE
            LET g_sql = g_sql CLIPPED,
                        " AND inaj009 = '",g_inaj_m.inaj009 CLIPPED,"'"
         END IF
      END IF  
   END IF      

   IF NOT cl_null(g_cons.inaj010) THEN
      IF g_inaj_m.inaj010 IS NULL THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaj010 IS NULL"
      ELSE 
         IF cl_null(g_inaj_m.inaj010) THEN
            LET g_sql = g_sql CLIPPED,
                        " AND inaj010 = ' '"
         ELSE
            LET g_sql = g_sql CLIPPED,
                        " AND inaj010 = '",g_inaj_m.inaj010 CLIPPED,"'"
         END IF
      END IF   
   END IF
   
   IF NOT cl_null(g_cons.inaa120) THEN
      IF g_inaj_m.inaa120 IS NULL THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaa120 IS NULL"
      ELSE 
         IF cl_null(g_inaj_m.inaa120) THEN
            LET g_sql = g_sql CLIPPED,
                        " AND inaa120 = ' '"
         ELSE
            LET g_sql = g_sql CLIPPED,
                        " AND inaa120 = '",g_inaj_m.inaa120 CLIPPED,"'"
         END IF
      END IF 
   END IF
   
   IF NOT cl_null(g_cons.inaj018) THEN
      IF g_inaj_m.inaj018 IS NULL THEN
         LET g_sql = g_sql CLIPPED,
                     " AND inaj018 IS NULL"
      ELSE 
         IF cl_null(g_inaj_m.inaj018) THEN
            LET g_sql = g_sql CLIPPED,
                        " AND inaj018 = ' '"
         ELSE
            LET g_sql = g_sql CLIPPED,
                        " AND inaj018 = '",g_inaj_m.inaj018 CLIPPED,"'"
         END IF
      END IF 
   END IF
   LET g_sql = g_sql CLIPPED,cl_sql_add_filter("inaj_t")

   LET g_sql = g_sql, cl_sql_add_filter("inaj_t"),
                      " ORDER BY inaj_t.inaj022 DESC,inaj_t.inaj023 DESC,inaj_t.inaj024 DESC,inaj_t.inaj001,inaj_t.inaj002,inaj_t.inaj003,inaj_t.inaj004"

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq901_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq901_pb
  
  
   OPEN b_fill_curs USING g_enterprise
   

   CALL g_inaj_d.clear()
   CALL g_inaj2_d.clear()
   CALL g_inaj3_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH b_fill_curs
      INTO g_inaj_d[l_ac].sel,           g_inaj_d[l_ac].inaj022,       g_inaj_d[l_ac].inaj001,       g_inaj_d[l_ac].inaj002,
           g_inaj_d[l_ac].inaj003,       g_inaj_d[l_ac].inaj004,       g_inaj_d[l_ac].inaj036,       g_inaj_d[l_ac].inaj035,
           g_inaj_d[l_ac].inaj035_desc,  g_inaj_d[l_ac].inaj006,       g_inaj_d[l_ac].inaj008,       g_inaj_d[l_ac].inaj008_desc,
           g_inaj_d[l_ac].inaa120,       g_inaj_d[l_ac].inaa120_desc,  g_inaj_d[l_ac].inaj009,       g_inaj_d[l_ac].inaj009_desc,
           g_inaj_d[l_ac].inaj010,       g_inaj_d[l_ac].inaj007,       g_inaj_d[l_ac].inaj011,       g_inaj_d[l_ac].inaj012,
           g_inaj_d[l_ac].inaj012_desc,  g_inaj_d[l_ac].inag007,       g_inaj_d[l_ac].inag007_desc,  g_inaj2_d[l_ac].inaj001,
           g_inaj2_d[l_ac].inaj002,      g_inaj2_d[l_ac].inaj003,      g_inaj2_d[l_ac].inaj004,      g_inaj2_d[l_ac].inaj017,
           g_inaj2_d[l_ac].inaj017_desc, g_inaj2_d[l_ac].inaj018,      g_inaj2_d[l_ac].inaj018_desc, g_inaj2_d[l_ac].inaj044,
           g_inaj2_d[l_ac].inaj016,      g_inaj2_d[l_ac].inaj016_desc, g_inaj3_d[l_ac].inaj001,      g_inaj3_d[l_ac].inaj002,
           g_inaj3_d[l_ac].inaj003,      g_inaj3_d[l_ac].inaj004,      g_inaj3_d[l_ac].inaj023,      g_inaj3_d[l_ac].inaj024,
           g_inaj3_d[l_ac].inaj025,      g_inaj3_d[l_ac].inaj025_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #150924-00002#1 20150930 s983961--add(s)
      EXECUTE ainq901_pb_d USING g_enterprise,g_inaj_d[l_ac].inaj001,g_inaj_d[l_ac].inaj002,g_inaj_d[l_ac].inaj003,g_inaj_d[l_ac].inaj004  
                            INTO g_inaj_d[l_ac].inajsite,g_inaj_d[l_ac].inaj005,g_inaj_d[l_ac].inaj006,g_inaj_d[l_ac].inaj007,g_inaj_d[l_ac].inaj008,g_inaj_d[l_ac].inaj009,g_inaj_d[l_ac].inaj010,g_inaj_d[l_ac].inaa120
      #150924-00002#1 20150930 s983961--add(e) 
 
      CALL ainq901_detail_show("'1'")
      
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
      LET l_ac = l_ac + 1
      
      
       
      
   END FOREACH
   
   LET g_error_show = 0

   CALL g_inaj_d.deleteElement(g_inaj_d.getLength())
   CALL g_inaj2_d.deleteElement(g_inaj2_d.getLength())
   CALL g_inaj3_d.deleteElement(g_inaj3_d.getLength())

   LET g_detail_cnt = g_inaj_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE b_fill_curs
   FREE ainq901_pb
   #FREE ainq901_pb_d  #150924-00002#1 20150930 s983961--add

   LET l_ac = 1

   CALL ainq901_filter_show('inaj022','b_inaj022')
   CALL ainq901_filter_show('inaj001','b_inaj001')
   CALL ainq901_filter_show('inaj002','b_inaj002')
   CALL ainq901_filter_show('inaj003','b_inaj003')
   CALL ainq901_filter_show('inaj004','b_inaj004')
   CALL ainq901_filter_show('inaj036','b_inaj036')
   CALL ainq901_filter_show('inaj035','b_inaj035')
   CALL ainq901_filter_show('inaj011','b_inaj011')
   CALL ainq901_filter_show('inaj012','b_inaj012')
   CALL ainq901_filter_show('inaj017','b_inaj017')
   CALL ainq901_filter_show('inaj018','b_inaj018')
   CALL ainq901_filter_show('inaj044','b_inaj044')
   CALL ainq901_filter_show('inaj016','b_inaj016')
   CALL ainq901_filter_show('inaj023','b_inaj023')
   CALL ainq901_filter_show('inaj024','b_inaj024')
   CALL ainq901_filter_show('inaj025','b_inaj025')
   #benson
   CALL ainq901_filter_show('inaj006','l_inaj006')
   CALL ainq901_filter_show('inaj008','l_inaj008')
   CALL ainq901_filter_show('inaa120','l_inaa120_1')
   CALL ainq901_filter_show('inaj009','l_inaj009')
   CALL ainq901_filter_show('inaj010','l_inaj009')
   CALL ainq901_filter_show('inaj007','l_inaj010')
   CALL ainq901_filter_show('inaj006','l_inaj007')
END FUNCTION

PRIVATE FUNCTION ainq901_fetch(p_flag)
   DEFINE p_flag          LIKE type_t.chr10
   DEFINE ls_msg          STRING
   DEFINE tm_field        DYNAMIC ARRAY OF VARCHAR(100)
   DEFINE l_i             LIKE type_t.num5
   CASE p_flag
      WHEN 'N' FETCH NEXT     ainq901_cs INTO tm_field[1],tm_field[2],tm_field[3],tm_field[4],tm_field[5],tm_field[6],tm_field[7],tm_field[8],tm_field[9],tm_field[10]
      WHEN 'P' FETCH PREVIOUS ainq901_cs INTO tm_field[1],tm_field[2],tm_field[3],tm_field[4],tm_field[5],tm_field[6],tm_field[7],tm_field[8],tm_field[9],tm_field[10]
      WHEN 'F' FETCH FIRST    ainq901_cs INTO tm_field[1],tm_field[2],tm_field[3],tm_field[4],tm_field[5],tm_field[6],tm_field[7],tm_field[8],tm_field[9],tm_field[10]
      WHEN 'L' FETCH LAST     ainq901_cs INTO tm_field[1],tm_field[2],tm_field[3],tm_field[4],tm_field[5],tm_field[6],tm_field[7],tm_field[8],tm_field[9],tm_field[10]
      WHEN '/'
         IF (NOT g_no_ask) THEN
            CALL cl_set_act_visible("accept,cancel", TRUE)
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            CALL cl_set_act_visible("accept,cancel", FALSE)
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                IF cl_null(g_jump) THEN
                   LET g_jump = g_master_idx
                END IF
            END IF
         END IF

         IF g_jump <= 0 THEN
            LET g_jump = 1
         END IF
         IF g_jump >= g_browser_cnt THEN
            LET g_jump = g_browser_cnt
         END IF 
         LET g_no_ask = FALSE
         FETCH ABSOLUTE g_jump ainq901_cs INTO tm_field[1],tm_field[2],tm_field[3],tm_field[4],tm_field[5],tm_field[6],tm_field[7],tm_field[8],tm_field[9],tm_field[10]
   END CASE

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN      
   ELSE
      LET g_inaj_m.inajsite = tm_field[1]
      LET g_inaj_m.inaj005  = tm_field[2]
      LET l_i = 3
      IF NOT cl_null(g_cons.inaj006) THEN
         LET g_inaj_m.inaj006 = tm_field[l_i]
         LET l_i = l_i + 1
      END IF
      IF NOT cl_null(g_cons.inaj007) THEN
         LET g_inaj_m.inaj007 = tm_field[l_i]
         LET l_i = l_i + 1
      END IF
      IF NOT cl_null(g_cons.inaj008) THEN
         LET g_inaj_m.inaj008 = tm_field[l_i]
         LET l_i = l_i + 1
      END IF
      IF NOT cl_null(g_cons.inaj009) THEN
         LET g_inaj_m.inaj009 = tm_field[l_i]
         LET l_i = l_i + 1
      END IF
      IF NOT cl_null(g_cons.inaj010) THEN
         LET g_inaj_m.inaj010 = tm_field[l_i]
         LET l_i = l_i + 1
      END IF
      IF NOT cl_null(g_cons.inaa120) THEN
         LET g_inaj_m.inaa120 = tm_field[l_i]
         LET l_i = l_i + 1
      END IF
      IF NOT cl_null(g_cons.inaj018) THEN
         LET g_inaj_m.inaj018 = tm_field[l_i]
         LET l_i = l_i + 1
      END IF
      
      CASE p_flag
         WHEN 'F' LET g_master_idx = 1
         WHEN 'P' LET g_master_idx = g_master_idx - 1
         WHEN 'N' LET g_master_idx = g_master_idx + 1
         WHEN 'L' LET g_master_idx = g_browser_cnt
         WHEN '/' LET g_master_idx = g_jump
      END CASE
      CALL cl_navigator_setting(g_master_idx,g_browser_cnt)
      DISPLAY g_master_idx TO FORMONLY.h_index                 
   END IF

   CALL ainq901_show()
   
END FUNCTION

PRIVATE FUNCTION ainq901_detail_show(ps_page)
   DEFINE ps_page           STRING
   DEFINE ls_sql            STRING
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_acc             LIKE gzcb_t.gzcb004
   DEFINE l_code            LIKE type_t.chr20
   
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #給其他單身key欄位值
      LET g_inaj2_d[l_ac].inaj001 = g_inaj_d[l_ac].inaj001
      LET g_inaj2_d[l_ac].inaj002 = g_inaj_d[l_ac].inaj002
      LET g_inaj2_d[l_ac].inaj003 = g_inaj_d[l_ac].inaj003
      LET g_inaj2_d[l_ac].inaj004 = g_inaj_d[l_ac].inaj004
      LET g_inaj3_d[l_ac].inaj001 = g_inaj_d[l_ac].inaj001
      LET g_inaj3_d[l_ac].inaj002 = g_inaj_d[l_ac].inaj002
      LET g_inaj3_d[l_ac].inaj003 = g_inaj_d[l_ac].inaj003
      LET g_inaj3_d[l_ac].inaj004 = g_inaj_d[l_ac].inaj004
      
      #------ PAGE I-------
      #s983961--mark
      #SELECT inajsite,inaj005,inaj006,inaj007,
      #       inaj008,inaj009,inaj010,inaa120
      #  INTO g_inaj_d[l_ac].inajsite,g_inaj_d[l_ac].inaj005,g_inaj_d[l_ac].inaj006,g_inaj_d[l_ac].inaj007,
      #       g_inaj_d[l_ac].inaj008,g_inaj_d[l_ac].inaj009,g_inaj_d[l_ac].inaj010,g_inaj_d[l_ac].inaa120
      #  FROM inaj_t,inaa_t
      # WHERE inajent = g_enterprise
      #   AND inajent = inaaent
      #   AND inajsite = inaasite
      #   AND inaj008 = inaa001
      #   AND inajsite = g_inaj_m.inajsite
      #   AND inaj001 = g_inaj_d[l_ac].inaj001
      #   AND inaj002 = g_inaj_d[l_ac].inaj002
      #   AND inaj003 = g_inaj_d[l_ac].inaj003
      #   AND inaj004 = g_inaj_d[l_ac].inaj004
      
      #150204-00013#8 150309 pomelo mark(s)
      #營運組織
      #CALL s_desc_get_department_desc(g_inaj_d[l_ac].inajsite)
      # RETURNING g_inaj_d[l_ac].inajsite_desc
      # 
      ##商品
      #CALL s_desc_get_item_desc(g_inaj_d[l_ac].inaj005) 
      # RETURNING g_inaj_d[l_ac].inaj005_desc,g_inaj_d[l_ac].inaj005_desc_desc
      #150204-00013#8 150309 pomelo mark(e)
      
      #產品特徵
      CALL s_feature_description(g_inaj_d[l_ac].inaj005,g_inaj_d[l_ac].inaj006)
       RETURNING l_success,g_inaj_d[l_ac].inaj006_desc
      
      #150204-00013#8 150309 pomelo mark(s)
      ##庫位
      #CALL s_desc_get_stock_desc(g_inaj_d[l_ac].inajsite,g_inaj_d[l_ac].inaj008)
      # RETURNING g_inaj_d[l_ac].inaj008_desc
      # 
      ##儲位
      #CALL s_desc_get_locator_desc(g_inaj_d[l_ac].inajsite,g_inaj_d[l_ac].inaj008,g_inaj_d[l_ac].inaj009)
      # RETURNING g_inaj_d[l_ac].inaj009_desc     
      #   
      ##作業名稱
      #CALL s_desc_get_prog_desc(g_inaj_d[l_ac].inaj035)
      # RETURNING g_inaj_d[l_ac].inaj035_desc
      #
      ##單位說明
      #CALL s_desc_get_unit_desc(g_inaj_d[l_ac].inaj012)
      # RETURNING g_inaj_d[l_ac].inaj012_desc
      #
      ##取庫存單位
      #SELECT inag007 INTO g_inaj_d[l_ac].inag007 FROM inag_t
      # WHERE inagent = g_enterprise
      #   AND inagsite = g_inaj_m.inajsite
      #   AND inag001 = g_inaj_m.inaj005
      #   AND inag002 = g_inaj_d[l_ac].inaj006
      #   AND inag003 = g_inaj_d[l_ac].inaj007
      #   AND inag004 = g_inaj_d[l_ac].inaj008
      #   AND inag005 = g_inaj_d[l_ac].inaj009
      #   AND inag006 = g_inaj_d[l_ac].inaj010
      ##單位說明
      #CALL s_desc_get_unit_desc(g_inaj_d[l_ac].inag007)
      # RETURNING g_inaj_d[l_ac].inag007_desc
      #150204-00013#8 150309 pomelo mark(e)
      
      #交易庫存數量 用計算的方式取出
      LET g_inaj_d[l_ac].inaj011 = g_inaj_d[l_ac].inaj011 * g_inaj_d[l_ac].inaj004
      
      IF NOT ( cl_null(g_inaj_m.inaj005)       OR cl_null(g_inaj_d[l_ac].inaj012) OR 
               cl_null(g_inaj_d[l_ac].inag007) OR cl_null(g_inaj_d[l_ac].inaj011)) THEN
         CALL s_aooi250_convert_qty(g_inaj_m.inaj005,g_inaj_d[l_ac].inaj012,g_inaj_d[l_ac].inag007,g_inaj_d[l_ac].inaj011) 
          RETURNING l_success,g_inaj_d[l_ac].l_qty
      END IF
      
      #------ PAGE II-------
      #150204-00013#8 150309 pomelo mark(s)
      #CALL s_desc_get_department_desc(g_inaj2_d[l_ac].inaj017)
      # RETURNING g_inaj2_d[l_ac].inaj017_desc
      #
      #CALL s_desc_get_trading_partner_abbr_desc(g_inaj2_d[l_ac].inaj018)
      # RETURNING g_inaj2_d[l_ac].inaj018_desc
      #150204-00013#8 150309 pomelo mark(e)
      
      #LET l_code = ''
      #SELECT gzzz002 INTO l_code FROM gzzz_t
      # WHERE gzzz001 = g_inaj_d[l_ac].inaj035
      #LET l_acc = ''      
      #SELECT gzcb004 INTO l_acc FROM gzcb_t 
      # WHERE gzcb001 = '24' AND gzcb002 = l_code
      #150204-00013#8 150309 pomelo mark(s)
      #LET l_acc = ''      
      #SELECT gzcb004 INTO l_acc FROM gzcb_t 
      # WHERE gzcb001 = '24' AND gzcb002 = g_inaj_d[l_ac].inaj035
      #IF NOT cl_null(l_acc) THEN
      #  CALL s_desc_get_acc_desc(l_acc,g_inaj2_d[l_ac].inaj016)
      #   RETURNING g_inaj2_d[l_ac].inaj016_desc 
      #END IF
      ##------ PAGE III-------
      #CALL s_desc_get_person_desc(g_inaj3_d[l_ac].inaj025)
      # RETURNING g_inaj3_d[l_ac].inaj025_desc
      #150204-00013#8 150309 pomelo mark(e)
   END IF

END FUNCTION

PRIVATE FUNCTION ainq901_filter()

   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   IF g_wc_filter != " 1=1" THEN
      LET g_wc = cl_replace_str(g_wc,g_wc_filter,'')
   END IF

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc_filter ON inaj022,inaj001,inaj002,inaj003,inaj004,inaj036,
                               inaj035,inaj011,inaj012,inaj017,inaj018,inaj044,
                               inaj016,inaj023,inaj024,inaj025,
                               inaj006,inaj008,inaa120,inaj009,inaj010,inaj007
                          FROM s_detail1[1].b_inaj022,s_detail1[1].b_inaj001,s_detail1[1].b_inaj002,
                               s_detail1[1].b_inaj003,s_detail1[1].b_inaj004,s_detail1[1].b_inaj036,s_detail1[1].b_inaj035,
                               s_detail1[1].b_inaj011,s_detail1[1].b_inaj012,s_detail2[1].b_inaj017,s_detail2[1].b_inaj018,
                               s_detail2[1].b_inaj044,s_detail2[1].b_inaj016,s_detail3[1].b_inaj023,s_detail3[1].b_inaj024,
                               s_detail3[1].b_inaj025,
                               #benson
                               s_detail1[1].l_inaj006,s_detail1[1].l_inaj008,s_detail1[1].l_inaa120_1,
                               s_detail1[1].l_inaj009,s_detail1[1].l_inaj010,s_detail1[1].l_inaj007
                               
         BEFORE CONSTRUCT
            DISPLAY ainq901_filter_parser('inaj022') TO s_detail1[1].b_inaj022
            DISPLAY ainq901_filter_parser('inaj001') TO s_detail1[1].b_inaj001
            DISPLAY ainq901_filter_parser('inaj002') TO s_detail1[1].b_inaj002
            DISPLAY ainq901_filter_parser('inaj003') TO s_detail1[1].b_inaj003
            DISPLAY ainq901_filter_parser('inaj004') TO s_detail1[1].b_inaj004
            DISPLAY ainq901_filter_parser('inaj036') TO s_detail1[1].b_inaj036
            DISPLAY ainq901_filter_parser('inaj035') TO s_detail1[1].b_inaj035
            DISPLAY ainq901_filter_parser('inaj011') TO s_detail1[1].b_inaj011
            DISPLAY ainq901_filter_parser('inaj012') TO s_detail1[1].b_inaj012
            DISPLAY ainq901_filter_parser('inaj017') TO s_detail2[1].b_inaj017
            DISPLAY ainq901_filter_parser('inaj018') TO s_detail2[1].b_inaj018
            DISPLAY ainq901_filter_parser('inaj044') TO s_detail2[1].b_inaj044
            DISPLAY ainq901_filter_parser('inaj016') TO s_detail2[1].b_inaj016
            DISPLAY ainq901_filter_parser('inaj023') TO s_detail3[1].b_inaj023
            DISPLAY ainq901_filter_parser('inaj024') TO s_detail3[1].b_inaj024
            DISPLAY ainq901_filter_parser('inaj025') TO s_detail3[1].b_inaj025
            #benson
            DISPLAY ainq901_filter_parser('inaj006') TO s_detail1[1].l_inaj006
            DISPLAY ainq901_filter_parser('inaj008') TO s_detail1[1].l_inaj008
            DISPLAY ainq901_filter_parser('inaa120') TO s_detail1[1].l_inaa120_1
            DISPLAY ainq901_filter_parser('inaj009') TO s_detail1[1].l_inaj009
            DISPLAY ainq901_filter_parser('inaj010') TO s_detail1[1].l_inaj010
            DISPLAY ainq901_filter_parser('inaj007') TO s_detail1[1].l_inaj007
            
         ON ACTION controlp INFIELD b_inaj001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj001  #顯示到畫面上
            NEXT FIELD b_inaj001                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj035
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj035  #顯示到畫面上            
            NEXT FIELD b_inaj035                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj012
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj012  #顯示到畫面上
            NEXT FIELD b_inaj012                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj017
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj017  #顯示到畫面上
            NEXT FIELD b_inaj017                     #返回原欄位
            
         ON ACTION controlp INFIELD b_inaj018
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj018  #顯示到畫面上
            NEXT FIELD b_inaj018                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj044
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj044_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj044  #顯示到畫面上
            NEXT FIELD b_inaj044                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj016
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj016()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj016  #顯示到畫面上
            NEXT FIELD b_inaj016                     #返回原欄位

         ON ACTION controlp INFIELD b_inaj025
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inaj025  #顯示到畫面上
            NEXT FIELD b_inaj025                     #返回原欄位
            
      END CONSTRUCT

      BEFORE DIALOG

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF

   CALL ainq901_filter_show('inaj022','b_inaj022')
   CALL ainq901_filter_show('inaj001','b_inaj001')
   CALL ainq901_filter_show('inaj002','b_inaj002')
   CALL ainq901_filter_show('inaj003','b_inaj003')
   CALL ainq901_filter_show('inaj004','b_inaj004')
   CALL ainq901_filter_show('inaj036','b_inaj036')
   CALL ainq901_filter_show('inaj035','b_inaj035')
   CALL ainq901_filter_show('inaj011','b_inaj011')
   CALL ainq901_filter_show('inaj012','b_inaj012')
   CALL ainq901_filter_show('inaj017','b_inaj017')
   CALL ainq901_filter_show('inaj018','b_inaj018')
   CALL ainq901_filter_show('inaj044','b_inaj044')
   CALL ainq901_filter_show('inaj016','b_inaj016')
   CALL ainq901_filter_show('inaj023','b_inaj023')
   CALL ainq901_filter_show('inaj024','b_inaj024')
   CALL ainq901_filter_show('inaj025','b_inaj025')
   #benson
   CALL ainq901_filter_show('inaj006','l_inaj006')
   CALL ainq901_filter_show('inaj008','l_inaj008')
   CALL ainq901_filter_show('inaa120','l_inaa120_1')
   CALL ainq901_filter_show('inaj009','l_inaj009')
   CALL ainq901_filter_show('inaj010','l_inaj009')
   CALL ainq901_filter_show('inaj007','l_inaj010')
   CALL ainq901_filter_show('inaj006','l_inaj007')
   
  
   CALL ainq901_b_fill()

END FUNCTION

PRIVATE FUNCTION ainq901_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE li_tmp2    LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE li_flag    LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE ls_var     STRING
   DEFINE l_flag     LIKE type_t.chr1

   LET l_flag = 'N'
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET l_flag = 'Y'
   END IF
   
   IF l_flag = 'N' THEN
      #數字條件解析
      LET ls_tmp = ps_field, "="
      LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
      IF li_tmp > 0 THEN
         LET li_tmp = ls_tmp.getLength() + li_tmp
         LET li_flag = g_wc_filter.getIndexOf('and',li_tmp)
         IF li_flag = 0 THEN
            LET li_tmp2 = g_wc_filter.getLength()
         ELSE 
            LET li_tmp2 = g_wc_filter.getIndexOf("and",li_tmp + 1) - 2
         END IF
         LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      END IF
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

PRIVATE FUNCTION ainq901_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainq901_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION

PRIVATE FUNCTION ainq901_insert()

END FUNCTION

PRIVATE FUNCTION ainq901_modify()

END FUNCTION

PRIVATE FUNCTION ainq901_reproduce()

END FUNCTION

PRIVATE FUNCTION ainq901_delete()

END FUNCTION

PRIVATE FUNCTION ainq901_show()
DEFINE l_success  LIKE type_t.num5
   DISPLAY g_inaj_m.inajsite,g_inaj_m.inaj005,g_inaj_m.inaj006,g_inaj_m.inaj008,g_inaj_m.inaj009,
           g_inaj_m.inaj010,g_inaj_m.inaj007,g_inaj_m.inaa120,g_inaj_m.inaj018
        TO b_inajsite,b_inaj005,b_inaj006,b_inaj008,b_inaj009,
           b_inaj010,b_inaj007,l_inaa120,l_inaj018
   
   #營運組織
   CALL s_desc_get_department_desc(g_inaj_m.inajsite)
    RETURNING g_inaj_m.inajsite_desc
    
   #商品
   CALL s_desc_get_item_desc(g_inaj_m.inaj005) 
    RETURNING g_inaj_m.imaal003,g_inaj_m.imaal004
   
   #產品特徵
   CALL s_feature_description(g_inaj_m.inaj005,g_inaj_m.inaj006)
    RETURNING l_success,g_inaj_m.inaj006_desc
    
   #庫位
   CALL s_desc_get_stock_desc(g_inaj_m.inajsite,g_inaj_m.inaj008)
    RETURNING g_inaj_m.inaj008_desc
    
   #儲位
   CALL s_desc_get_locator_desc(g_inaj_m.inajsite,g_inaj_m.inaj008,g_inaj_m.inaj009)
    RETURNING g_inaj_m.inaj009_desc
    
   #專櫃
   CALL s_desc_get_counter_desc(g_inaj_m.inaa120)
    RETURNING g_inaj_m.inaa120_desc 

   #供應商/客戶編號
   CALL s_desc_get_trading_partner_abbr_desc(g_inaj_m.inaj018) 
    RETURNING g_inaj_m.inaj018_desc
    
   DISPLAY g_inaj_m.inajsite_desc,g_inaj_m.imaal003,g_inaj_m.imaal004,
           g_inaj_m.inaj006_desc,g_inaj_m.inaj008_desc,g_inaj_m.inaj009_desc,
           g_inaj_m.inaa120_desc,g_inaj_m.inaj018_desc
           
        TO b_inajsite_desc,l_imaal003,l_imaal004,
           b_inaj006_desc,b_inaj008_desc,b_inaj009_desc,
           l_inaa120_desc,l_inaj018_desc
   CALL ainq901_b_fill()
END FUNCTION
# p_cmd    1.開欄位 2.依欄位是否有下條件關欄位
PRIVATE FUNCTION ainq901_comp_visible(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1   
   
   CALL cl_set_comp_visible("lbl_b_inaj006,b_inaj006,b_inaj006_desc",TRUE)
   IF cl_null(g_cons.inaj006) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("lbl_b_inaj006,b_inaj006,b_inaj006_desc",FALSE)
   END IF

   CALL cl_set_comp_visible("lbl_b_inaj008,b_inaj008,b_inaj008_desc",TRUE)
   IF cl_null(g_cons.inaj008) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("lbl_b_inaj008,b_inaj008,b_inaj008_desc",FALSE)
   END IF
   
   CALL cl_set_comp_visible("lbl_b_inaj009,b_inaj009,b_inaj009_desc",TRUE)
   IF cl_null(g_cons.inaj009) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("lbl_b_inaj009,b_inaj009,b_inaj009_desc",FALSE)
   END IF
   
   CALL cl_set_comp_visible("lbl_b_inaj010,b_inaj010",TRUE)
   IF cl_null(g_cons.inaj010) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("lbl_b_inaj010,b_inaj010",FALSE)
   END IF
   
   CALL cl_set_comp_visible("grid_1",TRUE)
   CALL cl_set_comp_visible("grid_3",FALSE)
   IF cl_null(g_cons.inaj006) AND cl_null(g_cons.inaj008) AND cl_null(g_cons.inaj009) AND cl_null(g_cons.inaj010) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("grid_1",FALSE)
      CALL cl_set_comp_visible("grid_3",TRUE)
   END IF
   
   CALL cl_set_comp_visible("lbl_inaa120,l_inaa120,l_inaa120_desc",TRUE)
   IF cl_null(g_cons.inaa120) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("lbl_inaa120,l_inaa120,l_inaa120_desc",FALSE)
   END IF
   
   CALL cl_set_comp_visible("lbl_b_inaj007,b_inaj007",TRUE)
   IF cl_null(g_cons.inaj007) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("lbl_b_inaj007,b_inaj007",FALSE)
   END IF
   
   CALL cl_set_comp_visible("lbl_inaj018,l_inaj018,l_inaj018_desc",TRUE)
   IF cl_null(g_cons.inaj018) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("lbl_inaj018,l_inaj018,l_inaj018_desc",FALSE)
   END IF
   
   CALL cl_set_comp_visible("grid_2",TRUE)
   IF cl_null(g_cons.inaa120) AND cl_null(g_cons.inaj007) AND cl_null(g_cons.inaj018) AND p_cmd = '2' THEN
      CALL cl_set_comp_visible("grid_2",FALSE)
      CALL cl_set_comp_visible("grid_3",TRUE)
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
