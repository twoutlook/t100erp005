#該程式已解開Section, 不再透過樣板產出!
{<section id="aqcq800.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000009
#+ 
#+ Filename...: aqcq800
#+ Description: 品質分數統計查詢作業
#+ Creator....: 02295(2014/09/12)
#+ Modifier...: 02295(2014/09/12) -SD/PR- 01996
#+ Buildtype..: 應用 q01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aqcq800.global" >}
#160425-00007#1   2016/04/25  By xianghui 不良率计算中不良数应抓单身中的不良数量
#160913-00055#4   2016/09/18  By lixiang  交易对象栏位开窗调整为q_pmaa001_25
#161124-00048#10  2016/12/13  By xujing   整批调整系统RECORD LIKE xxxx_t.* 星号写法
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_qcaq_d RECORD
       
       imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   qcaq003 LIKE qcaq_t.qcaq003, 
   qcaq003_desc LIKE type_t.chr500, 
   qcaq003_desc_1 LIKE type_t.chr500, 
   qcaq005 LIKE qcaq_t.qcaq005, 
   qcaq005_desc LIKE type_t.chr500, 
   qcaq007 LIKE qcaq_t.qcaq007, 
   qcaq007_desc LIKE type_t.chr500,   
   qcaq004 LIKE qcaq_t.qcaq004, 
   qcaq004_desc LIKE type_t.chr500,
   qcaq006 LIKE qcaq_t.qcaq006, 
   qcaq006_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_qcaq2_d RECORD
       l_totalname LIKE type_t.chr500, 
   l_jan LIKE type_t.chr500, 
   l_feb LIKE type_t.chr500, 
   l_mar LIKE type_t.chr500, 
   l_apr LIKE type_t.chr500, 
   l_may LIKE type_t.chr500, 
   l_jun LIKE type_t.chr500, 
   l_jul LIKE type_t.chr500, 
   l_aug LIKE type_t.chr500, 
   l_sept LIKE type_t.chr500, 
   l_oct LIKE type_t.chr500, 
   l_nov LIKE type_t.chr500, 
   l_dec LIKE type_t.chr500, 
   l_allyear LIKE type_t.chr500
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_qcaq_d            DYNAMIC ARRAY OF type_g_qcaq_d
DEFINE g_qcaq_d_t          type_g_qcaq_d
DEFINE g_qcaq2_d     DYNAMIC ARRAY OF type_g_qcaq2_d
DEFINE g_qcaq2_d_t   type_g_qcaq2_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num5              #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num5
DEFINE g_detail_cnt          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_qcaq           type_g_qcaq_d
DEFINE g_master   RECORD
         qcaq001    LIKE qcaq_t.qcaq001,
         l_qcaq005  LIKE type_t.chr1,
         l_qcaq003  LIKE type_t.chr1,
         l_qcaq007  LIKE type_t.chr1,
         l_qcaq004  LIKE type_t.chr1,
         l_qcaq006  LIKE type_t.chr1,
         l_imaa009  LIKE type_t.chr1
        END RECORD 
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aqcq800.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aqc","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aqcq800_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE aqcq800_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aqcq800_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aqcq800 WITH FORM cl_ap_formpath("aqc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aqcq800_init()   
 
      #進入選單 Menu (="N")
      CALL aqcq800_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aqcq800
      
   END IF 
   
   CLOSE aqcq800_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aqcq800.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aqcq800_init()
 
   #add-point:init段define
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
     
 
   #add-point:畫面資料初始化
   LET g_master.l_qcaq005 = 'Y'
   LET g_master.l_qcaq003 = 'Y'
   LET g_master.l_qcaq007 = 'Y'
   LET g_master.l_qcaq004 = 'Y'
   LET g_master.l_qcaq006 = 'Y'
   LET g_master.l_imaa009 = 'Y'
   LET g_master.qcaq001 = YEAR(g_today)
   CALL aqcq800_detail2()
   #end add-point
 
   CALL aqcq800_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.default_search" >}
PRIVATE FUNCTION aqcq800_default_search()
   #add-point:default_search段define
   
   #end add-point
 
 
   #add-point:default_search段開始前
   
   #end add-point
 
   #+ 此段落由子樣板qs27產生
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " qcaq000 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " qcaq001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " qcaq002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " qcaq003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " qcaq004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " qcaq005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " qcaq006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " qcaq007 = '", g_argv[08], "' AND "
   END IF
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段結束前
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcq800_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   #add-point:ui_dialog段define
 
   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 
  
   #end add-point
 
   
   CALL aqcq800_b_fill()
  
   WHILE li_exit = FALSE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT BY NAME g_master.l_qcaq005,g_master.l_qcaq003,g_master.l_qcaq007,
                       g_master.l_qcaq004,g_master.l_qcaq006,g_master.l_imaa009,
                       g_master.qcaq001                       
            ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT
            
         END INPUT   
         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc ON imaa009,qcaq003,qcaq004,qcaq007,qcaq005,qcaq006
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_qcaq.imaa009,g_qcaq.qcaq003,g_qcaq.qcaq004,
                               g_qcaq.qcaq007,g_qcaq.qcaq005,g_qcaq.qcaq006
   
            AFTER FIELD imaa009
               LET g_qcaq.imaa009 = GET_FLDBUF(imaa009)
   
            AFTER FIELD qcaq003
               LET g_qcaq.qcaq003 = GET_FLDBUF(qcaq003)
            AFTER FIELD qcaq004
               LET g_qcaq.qcaq004 = GET_FLDBUF(qcaq004)
            AFTER FIELD qcaq007
               LET g_qcaq.qcaq007 = GET_FLDBUF(qcaq007)
            AFTER FIELD qcaq005
               LET g_qcaq.qcaq005 = GET_FLDBUF(qcaq005)
            AFTER FIELD qcaq006
               LET g_qcaq.qcaq006 = GET_FLDBUF(qcaq006)
             

   
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009                    #返回原欄位
   
            ON ACTION controlp INFIELD qcaq003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO qcaq003      #顯示到畫面上
               NEXT FIELD qcaq003                         #返回原欄位

            ON ACTION controlp INFIELD qcaq005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001()                           #呼叫開窗  #160913-00055#4
               CALL q_pmaa001_25()        #160913-00055#4
               DISPLAY g_qryparam.return1 TO qcaq005      #顯示到畫面上
               NEXT FIELD qcaq005                         #返回原欄位
               
            ON ACTION controlp INFIELD qcaq006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_today
               CALL q_ooeg001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO qcaq006      #顯示到畫面上
               NEXT FIELD qcaq006                         #返回原欄位
               
            ON ACTION controlp INFIELD qcaq007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '221'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO qcaq007      #顯示到畫面上
               NEXT FIELD qcaq007                         #返回原欄位
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_qcaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_qcaq_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aqcq800_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
         DISPLAY ARRAY g_qcaq2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row

               #end add-point
            #自訂ACTION(detail_show,page_2)
            
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array

         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
      
         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog
#            IF g_main_hidden = 0 THEN
#               CALL cl_set_comp_visible("page_queryplan", FALSE)
#               CALL cl_set_comp_visible("page_qbe", FALSE)
#               CALL ui.interface.refresh()
#               CALL cl_set_comp_visible("page_queryplan", TRUE)
#               CALL cl_set_comp_visible("page_qbe", TRUE)
#               LET g_main_hidden = 0 
#            ELSE
#               CALL cl_set_comp_visible("page_queryplan", FALSE)
#               CALL cl_set_comp_visible("page_qbe", FALSE)
#               CALL ui.interface.refresh()
#               CALL cl_set_comp_visible("page_queryplan", TRUE)
#               CALL cl_set_comp_visible("page_qbe", TRUE)               
#               LET g_main_hidden = 1
#            END IF
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
           
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            IF g_master.l_qcaq005 = 'N' AND g_master.l_qcaq003 = 'N' AND g_master.l_qcaq007 = 'N' 
               AND g_master.l_qcaq004 = 'N' AND g_master.l_qcaq006 AND g_master.l_imaa009 = 'N' THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aqc-00071'
              LET g_errparam.extend = ' '
              LET g_errparam.popup = TRUE
              CALL cl_err()
              NEXT FIELD l_qcaq005
            END IF            
            
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            LET g_wc2 = " 1=1"
            
            #儲存WC資訊
            CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
            CALL aqcq800_b_fill()
            CALL FGL_SET_ARR_CURR(g_master_idx)
            CONTINUE DIALOG
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
 
         ON ACTION datarefresh   # 重新整理
            CALL aqcq800_b_fill()
 
         #+ 此段落由子樣板qs19產生
         #有關於sel欄位選取的action段落
         #選擇全部
#         ON ACTION selall
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
#            FOR li_idx = 1 TO g_qcaq_d.getLength()
#               LET g_qcaq_d[li_idx].sel = "Y"
#            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
#         ON ACTION selnone
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
#            FOR li_idx = 1 TO g_qcaq_d.getLength()
#               LET g_qcaq_d[li_idx].sel = "N"
#            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
#         ON ACTION sel
#            FOR li_idx = 1 TO g_qcaq_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_qcaq_d[li_idx].sel = "Y"
#               END IF
#            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
#         ON ACTION unsel
#            FOR li_idx = 1 TO g_qcaq_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_qcaq_d[li_idx].sel = "N"
#               END IF
#            END FOR
 
            #add-point:ui_dialog段on action unsel
             ON ACTION exporttoexcel
                LET g_action_choice="exporttoexcel"
                IF cl_auth_chk_act("exporttoexcel") THEN
                   #browser
                   CALL g_export_node.clear()
                   LET g_main_hidden = 0  #xj add
                   LET g_export_node[1] = base.typeInfo.create(g_qcaq_d)
                   LET g_export_id[1]   = "s_detail1"
                
                   #add-point:ON ACTION exporttoexcel
                   LET g_export_node[2] = base.typeInfo.create(g_qcaq2_d)
                   LET g_export_id[2]   = "s_detail2"
                   #END add-point
                   CALL cl_export_to_excel_getpage()
                   CALL cl_export_to_excel()
                END IF
            #end add-point
 
 
 
         #+ 此段落由子樣板qs16產生
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aqcq800_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION n_year
            LET g_action_choice="n_year"
            IF cl_auth_chk_act("n_year") THEN
               
               #add-point:ON ACTION n_year
               LET g_master.qcaq001 = g_master.qcaq001+1
               CALL aqcq800_b_fill2()
               #END add-point
               #EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert
 
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION p_year
            LET g_action_choice="p_year"
            IF cl_auth_chk_act("p_year") THEN
               
               #add-point:ON ACTION p_year
               LET g_master.qcaq001 = g_master.qcaq001-1
               CALL aqcq800_b_fill2()
               #END add-point
               #EXIT DIALOG
            END IF
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aqcq800_b_fill()
            END IF
 
         ON ACTION qbe_select
            LET ls_wc = ""
            CALL cl_qbe_list("c") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aqcq800_b_fill()
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aqcq800_b_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   #add-point:b_fill段define
   DEFINE l_sql_order     STRING
   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
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
 
   CALL g_qcaq_d.clear()
   CALL g_qcaq2_d.clear()
 
 
   #add-point:陣列清空
   CALL aqcq800_set_visible()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"
 
   # b_fill段sql組成及FOREACH撰寫
   #+ 此段落由子樣板qs04產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET g_sql = "SELECT UNIQUE "
   LET l_sql_order = " ORDER BY "
   IF g_master.l_imaa009 = 'Y' THEN 
      LET g_sql = g_sql," imaa009,rtaxl003"
      LET l_sql_order = l_sql_order," imaa009 "        
   ELSE
      LET g_sql = g_sql," '',''"
      LET l_sql_order = l_sql_order," ''" 
   END IF
   IF g_master.l_qcaq003 = 'Y' THEN 
      LET g_sql = g_sql," ,qcaq003,imaal003,imaal004"
      LET l_sql_order = l_sql_order," ,qcaq003 "        
   ELSE
      LET g_sql = g_sql," ,'','',''"
      LET l_sql_order = l_sql_order," ,''"    
   END IF
   IF g_master.l_qcaq005 = 'Y' THEN 
      LET g_sql = g_sql," ,qcaq005,pmaal004"
      LET l_sql_order = l_sql_order," ,qcaq005 "        
   ELSE
      LET g_sql = g_sql," ,'',''"
      LET l_sql_order = l_sql_order," ,''"    
   END IF
   IF g_master.l_qcaq007 = 'Y' THEN 
      LET g_sql = g_sql," ,qcaq007,oocql004"
      LET l_sql_order = l_sql_order," ,qcaq007 "        
   ELSE
      LET g_sql = g_sql," ,'',''"
      LET l_sql_order = l_sql_order," ,''"     
   END IF
   IF g_master.l_qcaq004 = 'Y' THEN 
      LET g_sql = g_sql," ,qcaq004,''"
      LET l_sql_order = l_sql_order," ,qcaq004 "        
   ELSE
      LET g_sql = g_sql," ,'',''"
      LET l_sql_order = l_sql_order," ,''"    
   END IF
   IF g_master.l_qcaq006 = 'Y' THEN 
      LET g_sql = g_sql," ,qcaq006,ooefl003"
      LET l_sql_order = l_sql_order," ,qcaq006 "        
   ELSE
      LET g_sql = g_sql," ,'',''"
      LET l_sql_order = l_sql_order," ,''"    
   END IF
 
   LET g_sql = g_sql,"  FROM qcaq_t",
               "       LEFT OUTER JOIN imaal_t ON imaalent = qcaqent AND imaal001 = qcaq003 AND imaal002= '",g_dlang,"'",
               "       LEFT OUTER JOIN pmaal_t ON pmaalent = qcaqent AND pmaal001 = qcaq005 AND pmaal002= '",g_dlang,"'",
               "       LEFT OUTER JOIN oocql_t ON oocqlent = qcaqent AND oocql001 = '221' AND oocql002 = qcaq003 AND oocql003= '",g_dlang,"'",
               "       LEFT OUTER JOIN ooefl_t ON ooeflent = qcaqent AND ooefl001 = qcaq006 AND ooefl002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN imaa_t ON imaaent = qcaqent AND imaa001 = qcaq003 ",
               "       LEFT OUTER JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002= '",g_dlang,"'",
               " WHERE qcaqent= ? AND qcaqsite= ? AND 1=1 AND ", ls_wc,l_sql_order 
   #add-point:b_fill段sql_after

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aqcq800_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aqcq800_pb
 
   OPEN b_fill_curs USING g_enterprise, g_site
 
   FOREACH b_fill_curs INTO g_qcaq_d[l_ac].imaa009,g_qcaq_d[l_ac].imaa009_desc,g_qcaq_d[l_ac].qcaq003, 
       g_qcaq_d[l_ac].qcaq003_desc,g_qcaq_d[l_ac].qcaq003_desc_1,g_qcaq_d[l_ac].qcaq005,g_qcaq_d[l_ac].qcaq005_desc, 
       g_qcaq_d[l_ac].qcaq007,g_qcaq_d[l_ac].qcaq007_desc,g_qcaq_d[l_ac].qcaq004,g_qcaq_d[l_ac].qcaq004_desc,g_qcaq_d[l_ac].qcaq006, 
       g_qcaq_d[l_ac].qcaq006_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
 
      CALL aqcq800_detail_show("'1'")
 
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
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
   CALL g_qcaq_d.deleteElement(g_qcaq_d.getLength())
   CALL g_qcaq2_d.deleteElement(g_qcaq2_d.getLength())
 
 
   #add-point:陣列長度調整

   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_qcaq_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #+ 此段落由子樣板qs06產生
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aqcq800_pb
 
 
 
 
   LET l_ac = 1
   LET g_master_idx = 1
   CALL aqcq800_b_fill2()
 
      CALL aqcq800_filter_show('imaa009','b_imaa009')
   CALL aqcq800_filter_show('qcaq003','b_qcaq003')
   CALL aqcq800_filter_show('qcaq005','b_qcaq005')
   CALL aqcq800_filter_show('qcaq007','b_qcaq007')
   CALL aqcq800_filter_show('qcaq004','b_qcaq004')
   CALL aqcq800_filter_show('qcaq006','b_qcaq006')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aqcq800_b_fill2()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define
   DEFINE l_where  STRING
   DEFINE l_group  STRING
   DEFINE l_wc     STRING
#   DEFINE la_param  RECORD                  #程式串查用變數
#             prog   STRING,                 #串查程式名稱
#             param  DYNAMIC ARRAY OF STRING #傳遞變數
#                    END RECORD   
#   DEFINE l_cmdrun  STRING 
   DEFINE l_stage  LIKE type_t.num5   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #+ 此段落由子樣板qs07產生
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空
   CALL g_qcaq2_d.clear()
   LET l_group = " GROUP BY 1"
   LET l_where = ""
   LET l_wc = " 1=1"
   IF g_master.l_qcaq003 = 'Y' THEN 
      LET l_where = l_where," AND qcaq003 ='",g_qcaq_d[g_master_idx].qcaq003,"'"
      LET l_group = l_group," ,qcaq003 " 
      LET l_wc = l_wc," AND qcba010 = '",g_qcaq_d[g_master_idx].qcaq003,"'"      
   END IF
   IF g_master.l_qcaq005 = 'Y' THEN 
      LET l_where = l_where," AND qcaq005 ='",g_qcaq_d[g_master_idx].qcaq005,"'"
      LET l_group = l_group," ,qcaq005 "
      IF NOT cl_null(g_qcaq_d[g_master_idx].qcaq005)THEN       
         LET l_wc = l_wc," AND qcba005 ='",g_qcaq_d[g_master_idx].qcaq005,"'" 
      ELSE
         LET l_wc = l_wc," AND qcba005 IS NULL " 
      END IF
   END IF
   IF g_master.l_qcaq007 = 'Y' THEN 
      LET l_where = l_where," AND qcaq007 ='",g_qcaq_d[g_master_idx].qcaq007,"'"
      LET l_group = l_group," ,qcaq007 " 
      IF NOT cl_null(g_qcaq_d[g_master_idx].qcaq007) THEN       
         LET l_wc = l_wc," AND qcba006 ='",g_qcaq_d[g_master_idx].qcaq007,"'" 
      ELSE
         LET l_wc = l_wc," AND qcba006 IS NULL " 
      END IF      
   END IF
   IF g_master.l_qcaq004 = 'Y' THEN 
      LET l_where = l_where," AND qcaq004 ='",g_qcaq_d[g_master_idx].qcaq004,"'"
      LET l_group = l_group," ,qcaq004 " 
      LET l_wc = l_wc," AND qcba012='",g_qcaq_d[g_master_idx].qcaq004,"'"      
   END IF
   IF g_master.l_qcaq006 = 'Y' THEN 
      LET l_where = l_where," AND qcaq006 ='",g_qcaq_d[g_master_idx].qcaq006,"'"
      LET l_group = l_group," ,qcaq006 "  
      LET l_wc = l_wc," AND qcba901='",g_qcaq_d[g_master_idx].qcaq006,"'"      
   END IF
   IF g_master.l_imaa009 = 'Y' THEN 
      LET l_where = l_where," AND imaa009 ='",g_qcaq_d[g_master_idx].imaa009,"'"
      LET l_group = l_group," ,imaa009 "  
      LET l_wc = l_wc," AND imaa009='",g_qcaq_d[g_master_idx].imaa009,"'"      
   END IF   
   
#   LET la_param.prog = 'aqcp800'
#   LET la_param.param[1] = 'Y'
#   LET la_param.param[2] = l_wc
#   LET l_cmdrun = util.JSON.stringify( la_param )
#   CALL cl_cmdrun(l_cmdrun)
   LET l_stage = MONTH(g_today)
   CALL aqcq800_call_aqcp800(l_wc,l_stage)
   #end add-point
 
 
 
 
   #add-point:陣列長度調整
   CALL aqcq800_detail2()
   
   LET g_sql = "SELECT SUM(qcaq008),SUM(qcaq009),SUM(qcaq010),SUM(qcaq012),SUM(qcaq013),",
               "       SUM(qcaq014),SUM(qcaq015),SUM(qcaq016),SUM(qcaq017) ",
               "  FROM qcaq_t,imaa_t ",
               " WHERE qcaqent = imaaent AND qcaq003 = imaa001 ",
               "   AND qcaqent = '",g_enterprise,"'",
               "   AND qcaqsite = '",g_site,"'",
               "   AND qcaq001 = ",g_master.qcaq001,
               "   AND qcaq002 = ? ",l_where,l_group
   PREPARE sel_stage FROM g_sql

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'1')
   EXECUTE sel_stage USING '1' INTO g_qcaq2_d[1].l_jan,g_qcaq2_d[2].l_jan,g_qcaq2_d[3].l_jan,g_qcaq2_d[5].l_jan, 
                          g_qcaq2_d[6].l_jan,g_qcaq2_d[7].l_jan,g_qcaq2_d[8].l_jan,g_qcaq2_d[9].l_jan,g_qcaq2_d[10].l_jan
   LET g_qcaq2_d[4].l_jan = g_qcaq2_d[3].l_jan/g_qcaq2_d[2].l_jan USING '&.##'
	LET g_qcaq2_d[11].l_jan = g_qcaq2_d[7].l_jan/g_qcaq2_d[6].l_jan USING '&.##'
	LET g_qcaq2_d[12].l_jan = g_qcaq2_d[8].l_jan/g_qcaq2_d[6].l_jan USING '&.##'
	LET g_qcaq2_d[13].l_jan = g_qcaq2_d[9].l_jan/g_qcaq2_d[6].l_jan USING '&.##'
   LET g_qcaq2_d[14].l_jan = g_qcaq2_d[10].l_jan/g_qcaq2_d[6].l_jan USING '&.##'

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'2')
   EXECUTE sel_stage USING '2' INTO g_qcaq2_d[1].l_feb,g_qcaq2_d[2].l_feb,g_qcaq2_d[3].l_feb,g_qcaq2_d[5].l_feb, 
                           g_qcaq2_d[6].l_feb,g_qcaq2_d[7].l_feb,g_qcaq2_d[8].l_feb,g_qcaq2_d[9].l_feb,
                          g_qcaq2_d[10].l_feb
   LET  g_qcaq2_d[4].l_feb = g_qcaq2_d[3].l_feb/g_qcaq2_d[2].l_feb USING '&.##'
	LET g_qcaq2_d[11].l_feb = g_qcaq2_d[7].l_feb/g_qcaq2_d[6].l_feb USING '&.##'
	LET g_qcaq2_d[12].l_feb = g_qcaq2_d[8].l_feb/g_qcaq2_d[6].l_feb USING '&.##'
	LET g_qcaq2_d[13].l_feb = g_qcaq2_d[9].l_feb/g_qcaq2_d[6].l_feb USING '&.##'
   LET g_qcaq2_d[14].l_feb =g_qcaq2_d[10].l_feb/g_qcaq2_d[6].l_feb USING '&.##'

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'3')
   EXECUTE sel_stage USING '3' INTO g_qcaq2_d[1].l_mar,g_qcaq2_d[2].l_mar,g_qcaq2_d[3].l_mar,g_qcaq2_d[5].l_mar, 
                                  g_qcaq2_d[6].l_mar,g_qcaq2_d[7].l_mar,g_qcaq2_d[8].l_mar,g_qcaq2_d[9].l_mar,
                                  g_qcaq2_d[10].l_mar
   LET  g_qcaq2_d[4].l_mar = g_qcaq2_d[3].l_mar/g_qcaq2_d[2].l_mar USING '&.##'
	LET g_qcaq2_d[11].l_mar = g_qcaq2_d[7].l_mar/g_qcaq2_d[6].l_mar USING '&.##'
	LET g_qcaq2_d[12].l_mar = g_qcaq2_d[8].l_mar/g_qcaq2_d[6].l_mar USING '&.##'
	LET g_qcaq2_d[13].l_mar = g_qcaq2_d[9].l_mar/g_qcaq2_d[6].l_mar USING '&.##'
   LET g_qcaq2_d[14].l_mar =g_qcaq2_d[10].l_mar/g_qcaq2_d[6].l_mar USING '&.##'  

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'4')
   EXECUTE sel_stage USING '4' INTO   g_qcaq2_d[1].l_apr,g_qcaq2_d[2].l_apr, g_qcaq2_d[3].l_apr,
                             g_qcaq2_d[5].l_apr,g_qcaq2_d[6].l_apr, g_qcaq2_d[7].l_apr,
                             g_qcaq2_d[8].l_apr,g_qcaq2_d[9].l_apr,g_qcaq2_d[10].l_apr
   LET  g_qcaq2_d[4].l_apr = g_qcaq2_d[3].l_apr/g_qcaq2_d[2].l_apr USING '&.##'
	LET g_qcaq2_d[11].l_apr = g_qcaq2_d[7].l_apr/g_qcaq2_d[6].l_apr USING '&.##'
	LET g_qcaq2_d[12].l_apr = g_qcaq2_d[8].l_apr/g_qcaq2_d[6].l_apr USING '&.##'
	LET g_qcaq2_d[13].l_apr = g_qcaq2_d[9].l_apr/g_qcaq2_d[6].l_apr USING '&.##'
   LET g_qcaq2_d[14].l_apr =g_qcaq2_d[10].l_apr/g_qcaq2_d[6].l_apr USING '&.##' 

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'5')
   EXECUTE sel_stage USING '5' INTO   g_qcaq2_d[1].l_may,g_qcaq2_d[2].l_may, g_qcaq2_d[3].l_may,
                             g_qcaq2_d[5].l_may,g_qcaq2_d[6].l_may, g_qcaq2_d[7].l_may,
                             g_qcaq2_d[8].l_may,g_qcaq2_d[9].l_may,g_qcaq2_d[10].l_may
   LET  g_qcaq2_d[4].l_may = g_qcaq2_d[3].l_may/g_qcaq2_d[2].l_may USING '&.##'
	LET g_qcaq2_d[11].l_may = g_qcaq2_d[7].l_may/g_qcaq2_d[6].l_may USING '&.##'
	LET g_qcaq2_d[12].l_may = g_qcaq2_d[8].l_may/g_qcaq2_d[6].l_may USING '&.##'
	LET g_qcaq2_d[13].l_may = g_qcaq2_d[9].l_may/g_qcaq2_d[6].l_may USING '&.##'
   LET g_qcaq2_d[14].l_may =g_qcaq2_d[10].l_may/g_qcaq2_d[6].l_may USING '&.##'

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'6')
   EXECUTE sel_stage USING '6' INTO   g_qcaq2_d[1].l_jun,g_qcaq2_d[2].l_jun, g_qcaq2_d[3].l_jun,
                             g_qcaq2_d[5].l_jun,g_qcaq2_d[6].l_jun, g_qcaq2_d[7].l_jun,
                             g_qcaq2_d[8].l_jun,g_qcaq2_d[9].l_jun,g_qcaq2_d[10].l_jun
   LET  g_qcaq2_d[4].l_jun = g_qcaq2_d[3].l_jun/g_qcaq2_d[2].l_jun USING '&.##'
	LET g_qcaq2_d[11].l_jun = g_qcaq2_d[7].l_jun/g_qcaq2_d[6].l_jun USING '&.##'
	LET g_qcaq2_d[12].l_jun = g_qcaq2_d[8].l_jun/g_qcaq2_d[6].l_jun USING '&.##'
	LET g_qcaq2_d[13].l_jun = g_qcaq2_d[9].l_jun/g_qcaq2_d[6].l_jun USING '&.##'
   LET g_qcaq2_d[14].l_jun =g_qcaq2_d[10].l_jun/g_qcaq2_d[6].l_jun USING '&.##'

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'7')
   EXECUTE sel_stage USING '7' INTO   g_qcaq2_d[1].l_jul,g_qcaq2_d[2].l_jul, g_qcaq2_d[3].l_jul,
                             g_qcaq2_d[5].l_jul,g_qcaq2_d[6].l_jul, g_qcaq2_d[7].l_jul,
                             g_qcaq2_d[8].l_jul,g_qcaq2_d[9].l_jul,g_qcaq2_d[10].l_jul
   LET  g_qcaq2_d[4].l_jul = g_qcaq2_d[3].l_jul/g_qcaq2_d[2].l_jul USING '&.##'
	LET g_qcaq2_d[11].l_jul = g_qcaq2_d[7].l_jul/g_qcaq2_d[6].l_jul USING '&.##'
	LET g_qcaq2_d[12].l_jul = g_qcaq2_d[8].l_jul/g_qcaq2_d[6].l_jul USING '&.##'
	LET g_qcaq2_d[13].l_jul = g_qcaq2_d[9].l_jul/g_qcaq2_d[6].l_jul USING '&.##'
   LET g_qcaq2_d[14].l_jul =g_qcaq2_d[10].l_jul/g_qcaq2_d[6].l_jul USING '&.##'

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'8')
   EXECUTE sel_stage USING '8' INTO   g_qcaq2_d[1].l_aug,g_qcaq2_d[2].l_aug, g_qcaq2_d[3].l_aug,
                             g_qcaq2_d[5].l_aug,g_qcaq2_d[6].l_aug, g_qcaq2_d[7].l_aug,
                             g_qcaq2_d[8].l_aug,g_qcaq2_d[9].l_aug,g_qcaq2_d[10].l_aug
   LET  g_qcaq2_d[4].l_aug = g_qcaq2_d[3].l_aug/g_qcaq2_d[2].l_aug USING '&.##'
	LET g_qcaq2_d[11].l_aug = g_qcaq2_d[7].l_aug/g_qcaq2_d[6].l_aug USING '&.##'
	LET g_qcaq2_d[12].l_aug = g_qcaq2_d[8].l_aug/g_qcaq2_d[6].l_aug USING '&.##'
	LET g_qcaq2_d[13].l_aug = g_qcaq2_d[9].l_aug/g_qcaq2_d[6].l_aug USING '&.##'
   LET g_qcaq2_d[14].l_aug =g_qcaq2_d[10].l_aug/g_qcaq2_d[6].l_aug USING '&.##'  

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'9')
   EXECUTE sel_stage USING '9' INTO   g_qcaq2_d[1].l_sept,g_qcaq2_d[2].l_sept, g_qcaq2_d[3].l_sept,
                             g_qcaq2_d[5].l_sept,g_qcaq2_d[6].l_sept, g_qcaq2_d[7].l_sept,
                             g_qcaq2_d[8].l_sept,g_qcaq2_d[9].l_sept,g_qcaq2_d[10].l_sept
   LET  g_qcaq2_d[4].l_sept = g_qcaq2_d[3].l_sept/g_qcaq2_d[2].l_sept USING '&.##'
	LET g_qcaq2_d[11].l_sept = g_qcaq2_d[7].l_sept/g_qcaq2_d[6].l_sept USING '&.##'
	LET g_qcaq2_d[12].l_sept = g_qcaq2_d[8].l_sept/g_qcaq2_d[6].l_sept USING '&.##'
	LET g_qcaq2_d[13].l_sept = g_qcaq2_d[9].l_sept/g_qcaq2_d[6].l_sept USING '&.##'
   LET g_qcaq2_d[14].l_sept =g_qcaq2_d[10].l_sept/g_qcaq2_d[6].l_sept USING '&.##' 

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'10')
   EXECUTE sel_stage USING '10' INTO  g_qcaq2_d[1].l_oct,g_qcaq2_d[2].l_oct, g_qcaq2_d[3].l_oct,
                             g_qcaq2_d[5].l_oct,g_qcaq2_d[6].l_oct, g_qcaq2_d[7].l_oct,
                             g_qcaq2_d[8].l_oct,g_qcaq2_d[9].l_oct,g_qcaq2_d[10].l_oct
   LET  g_qcaq2_d[4].l_oct = g_qcaq2_d[3].l_oct/g_qcaq2_d[2].l_oct USING '&.##'
	LET g_qcaq2_d[11].l_oct = g_qcaq2_d[7].l_oct/g_qcaq2_d[6].l_oct USING '&.##'
	LET g_qcaq2_d[12].l_oct = g_qcaq2_d[8].l_oct/g_qcaq2_d[6].l_oct USING '&.##'
	LET g_qcaq2_d[13].l_oct = g_qcaq2_d[9].l_oct/g_qcaq2_d[6].l_oct USING '&.##'
   LET g_qcaq2_d[14].l_oct =g_qcaq2_d[10].l_oct/g_qcaq2_d[6].l_oct USING '&.##' 

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'11')
   EXECUTE sel_stage USING '11' INTO  g_qcaq2_d[1].l_nov,g_qcaq2_d[2].l_nov, g_qcaq2_d[3].l_nov,
                             g_qcaq2_d[5].l_nov,g_qcaq2_d[6].l_nov, g_qcaq2_d[7].l_nov,
                             g_qcaq2_d[8].l_nov,g_qcaq2_d[9].l_nov,g_qcaq2_d[10].l_nov
   LET  g_qcaq2_d[4].l_nov = g_qcaq2_d[3].l_nov/g_qcaq2_d[2].l_nov USING '&.##'
	LET g_qcaq2_d[11].l_nov = g_qcaq2_d[7].l_nov/g_qcaq2_d[6].l_nov USING '&.##'
	LET g_qcaq2_d[12].l_nov = g_qcaq2_d[8].l_nov/g_qcaq2_d[6].l_nov USING '&.##'
	LET g_qcaq2_d[13].l_nov = g_qcaq2_d[9].l_nov/g_qcaq2_d[6].l_nov USING '&.##'
   LET g_qcaq2_d[14].l_nov =g_qcaq2_d[10].l_nov/g_qcaq2_d[6].l_nov USING '&.##'

   ---------------------------------------------------------------------------------------------
   #CALL aqcq800_call_aqcp800(l_wc,'12')
   EXECUTE sel_stage USING '12' INTO  g_qcaq2_d[1].l_dec,g_qcaq2_d[2].l_dec, g_qcaq2_d[3].l_dec,
                             g_qcaq2_d[5].l_dec,g_qcaq2_d[6].l_dec, g_qcaq2_d[7].l_dec,
                             g_qcaq2_d[8].l_dec,g_qcaq2_d[9].l_dec,g_qcaq2_d[10].l_dec
   LET  g_qcaq2_d[4].l_dec = g_qcaq2_d[3].l_dec/g_qcaq2_d[2].l_dec USING '&.##'
	LET g_qcaq2_d[11].l_dec = g_qcaq2_d[7].l_dec/g_qcaq2_d[6].l_dec USING '&.##'
	LET g_qcaq2_d[12].l_dec = g_qcaq2_d[8].l_dec/g_qcaq2_d[6].l_dec USING '&.##'
	LET g_qcaq2_d[13].l_dec = g_qcaq2_d[9].l_dec/g_qcaq2_d[6].l_dec USING '&.##'
   LET g_qcaq2_d[14].l_dec =g_qcaq2_d[10].l_dec/g_qcaq2_d[6].l_dec USING '&.##' 

   ---------------------------------------------------------------------------------------------
   EXECUTE sel_stage USING '99' INTO g_qcaq2_d[1].l_allyear,g_qcaq2_d[2].l_allyear, g_qcaq2_d[3].l_allyear,
                             g_qcaq2_d[5].l_allyear,g_qcaq2_d[6].l_allyear, g_qcaq2_d[7].l_allyear,
                             g_qcaq2_d[8].l_allyear,g_qcaq2_d[9].l_allyear,g_qcaq2_d[10].l_allyear
   LET  g_qcaq2_d[4].l_allyear = g_qcaq2_d[3].l_allyear/g_qcaq2_d[2].l_allyear USING '&.##'
	LET g_qcaq2_d[11].l_allyear = g_qcaq2_d[7].l_allyear/g_qcaq2_d[6].l_allyear USING '&.##'
	LET g_qcaq2_d[12].l_allyear = g_qcaq2_d[8].l_allyear/g_qcaq2_d[6].l_allyear USING '&.##'
	LET g_qcaq2_d[13].l_allyear = g_qcaq2_d[9].l_allyear/g_qcaq2_d[6].l_allyear USING '&.##'
   LET g_qcaq2_d[14].l_allyear =g_qcaq2_d[10].l_allyear/g_qcaq2_d[6].l_allyear USING '&.##'    

   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
   #add-point:單身填充後
   FREE sel_stage
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aqcq800_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference
      CALL s_feature_description(g_qcaq_d[l_ac].qcaq003,g_qcaq_d[l_ac].qcaq004) RETURNING g_success,g_qcaq_d[l_ac].qcaq004_desc
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.filter" >}
#+ 此段落由子樣板qs13產生
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aqcq800_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
#   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
#   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON imaa009,qcaq003,qcaq005,qcaq007,qcaq004,qcaq006
                          FROM s_detail1[1].b_imaa009,s_detail1[1].b_qcaq003,s_detail1[1].b_qcaq005, 
                              s_detail1[1].b_qcaq007,s_detail1[1].b_qcaq004,s_detail1[1].b_qcaq006
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
                     DISPLAY aqcq800_filter_parser('imaa009') TO s_detail1[1].b_imaa009
            DISPLAY aqcq800_filter_parser('qcaq003') TO s_detail1[1].b_qcaq003
            DISPLAY aqcq800_filter_parser('qcaq005') TO s_detail1[1].b_qcaq005
            DISPLAY aqcq800_filter_parser('qcaq007') TO s_detail1[1].b_qcaq007
            DISPLAY aqcq800_filter_parser('qcaq004') TO s_detail1[1].b_qcaq004
            DISPLAY aqcq800_filter_parser('qcaq006') TO s_detail1[1].b_qcaq006
 
             ON ACTION controlp INFIELD b_imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
               NEXT FIELD b_imaa009                    #返回原欄位
   
            ON ACTION controlp INFIELD b_qcaq003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_qcaq003      #顯示到畫面上
               NEXT FIELD b_qcaq003                         #返回原欄位
 
            ON ACTION controlp INFIELD b_qcaq005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_qcaq005      #顯示到畫面上
               NEXT FIELD b_qcaq005                         #返回原欄位
               
            ON ACTION controlp INFIELD b_qcaq006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_today
               CALL q_ooeg001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_qcaq006      #顯示到畫面上
               NEXT FIELD b_qcaq006                         #返回原欄位
               
            ON ACTION controlp INFIELD b_qcaq007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '221'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_qcaq007      #顯示到畫面上
               NEXT FIELD b_qcaq007                         #返回原欄位
               
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point
 
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
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL aqcq800_filter_show('imaa009','b_imaa009')
   CALL aqcq800_filter_show('qcaq003','b_qcaq003')
   CALL aqcq800_filter_show('qcaq005','b_qcaq005')
   CALL aqcq800_filter_show('qcaq007','b_qcaq007')
   CALL aqcq800_filter_show('qcaq004','b_qcaq004')
   CALL aqcq800_filter_show('qcaq006','b_qcaq006')
 
   CALL aqcq800_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.filter_parser" >}
#+ 此段落由子樣板qs14產生
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aqcq800_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
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
 
{<section id="aqcq800.filter_show" >}
#+ 此段落由子樣板qs15產生
#+ 標題欄位顯示搜尋條件
PRIVATE FUNCTION aqcq800_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aqcq800_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq800.other_function" readonly="Y" >}

PRIVATE FUNCTION aqcq800_detail2()
   SELECT dzebl003 INTO g_qcaq2_d[1].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq008' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[2].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq009' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[3].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq010' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[4].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq011' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[5].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq012' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[6].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq013' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[7].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq014' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[8].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq015' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[9].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq016' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[10].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq017' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[11].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq018' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[12].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq019' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[13].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq020' AND dzebl002 = g_dlang
   SELECT dzebl003 INTO g_qcaq2_d[14].l_totalname FROM dzebl_t WHERE dzebl001 = 'qcaq021' AND dzebl002 = g_dlang
END FUNCTION

PRIVATE FUNCTION aqcq800_set_visible()
   CALL cl_set_comp_visible("b_qcaq005,b_qcaq005_desc",FALSE)
   IF g_master.l_qcaq005 = 'Y' THEN 
      CALL cl_set_comp_visible("b_qcaq005,b_qcaq005_desc",TRUE)
   END IF
   CALL cl_set_comp_visible("b_qcaq003,b_qcaq003_desc,b_qcaq003_desc_1",FALSE)
   IF g_master.l_qcaq003 = 'Y' THEN 
      CALL cl_set_comp_visible("b_qcaq003,b_qcaq003_desc,b_qcaq003_desc_1",TRUE)
   END IF 
   CALL cl_set_comp_visible("b_qcaq007,b_qcaq007_desc",FALSE)
   IF g_master.l_qcaq007 = 'Y' THEN 
      CALL cl_set_comp_visible("b_qcaq007,b_qcaq007_desc",TRUE)
   END IF
   CALL cl_set_comp_visible("b_qcaq004,b_qcaq004_desc",FALSE)
   IF g_master.l_qcaq004 = 'Y' THEN 
      CALL cl_set_comp_visible("b_qcaq004,b_qcaq004_desc",TRUE)
   END IF
   CALL cl_set_comp_visible("b_qcaq006,b_qcaq006_desc",FALSE)
   IF g_master.l_qcaq006 = 'Y' THEN 
      CALL cl_set_comp_visible("b_qcaq006,b_qcaq006_desc",TRUE)
   END IF 
   CALL cl_set_comp_visible("b_imaa009,b_imaa009_desc",FALSE)
   IF g_master.l_imaa009 = 'Y' THEN 
      CALL cl_set_comp_visible("b_imaa009,b_imaa009_desc",TRUE)
   END IF   
END FUNCTION

PRIVATE FUNCTION aqcq800_call_aqcp800(p_wc,p_stage)
DEFINE p_wc  STRING 
DEFINE p_stage  LIKE type_t.num5
DEFINE ls_js       STRING
DEFINE ls_sql      STRING             #主SQL
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_bdate     LIKE type_t.dat
DEFINE l_edate     LIKE type_t.dat 
#DEFINE l_qcaq      RECORD LIKE qcaq_t.* #161124-00048#10  mark
#161124-00048#10 add(s)
DEFINE l_qcaq RECORD  #每月品質分數統計檔
       qcaqent LIKE qcaq_t.qcaqent, #企业编号
       qcaqsite LIKE qcaq_t.qcaqsite, #营运据点
       qcaq000 LIKE qcaq_t.qcaq000, #QC类型
       qcaq001 LIKE qcaq_t.qcaq001, #年度
       qcaq002 LIKE qcaq_t.qcaq002, #期别
       qcaq003 LIKE qcaq_t.qcaq003, #料件编号
       qcaq004 LIKE qcaq_t.qcaq004, #产品特征
       qcaq005 LIKE qcaq_t.qcaq005, #交易对象
       qcaq006 LIKE qcaq_t.qcaq006, #部门
       qcaq007 LIKE qcaq_t.qcaq007, #作业编号
       qcaq008 LIKE qcaq_t.qcaq008, #送验量
       qcaq009 LIKE qcaq_t.qcaq009, #抽验量
       qcaq010 LIKE qcaq_t.qcaq010, #不良数量
       qcaq011 LIKE qcaq_t.qcaq011, #不良率
       qcaq012 LIKE qcaq_t.qcaq012, #收货批数
       qcaq013 LIKE qcaq_t.qcaq013, #检验批数
       qcaq014 LIKE qcaq_t.qcaq014, #合格批数
       qcaq015 LIKE qcaq_t.qcaq015, #不合格批数
       qcaq016 LIKE qcaq_t.qcaq016, #验退批数
       qcaq017 LIKE qcaq_t.qcaq017, #特采批数
       qcaq018 LIKE qcaq_t.qcaq018, #批合格率
       qcaq019 LIKE qcaq_t.qcaq019, #批不合格率
       qcaq020 LIKE qcaq_t.qcaq020, #批验退率
       qcaq021 LIKE qcaq_t.qcaq021  #批特采率
END RECORD
#161124-00048#10 add(e)
DEFINE l_qcba000   LIKE qcba_t.qcba000,
       l_qcba010   LIKE qcba_t.qcba010,
       l_qcba012   LIKE qcba_t.qcba012,
       l_qcba005   LIKE qcba_t.qcba005,
       l_qcba006   LIKE qcba_t.qcba006,
       l_qcba901   LIKE qcba_t.qcba901 
DEFINE l_qcaq008   LIKE qcaq_t.qcaq018,
       l_qcaq009   LIKE qcaq_t.qcaq019,
       l_qcaq010   LIKE qcaq_t.qcaq010,
       l_qcaq011   LIKE qcaq_t.qcaq011,
       l_qcaq012   LIKE qcaq_t.qcaq012,
       l_qcaq013   LIKE qcaq_t.qcaq013,
       l_qcaq014   LIKE qcaq_t.qcaq014,
       l_qcaq015   LIKE qcaq_t.qcaq015,
       l_qcaq016   LIKE qcaq_t.qcaq016,
       l_qcaq017   LIKE qcaq_t.qcaq017,
       l_qcaq018   LIKE qcaq_t.qcaq018,
       l_qcaq019   LIKE qcaq_t.qcaq019,
       l_qcaq020   LIKE qcaq_t.qcaq020,
       l_qcaq021   LIKE qcaq_t.qcaq021
DEFINE l_where     STRING  
DEFINE l_where2    STRING    
DEFINE l_glaa003       LIKE glaa_t.glaa003  
DEFINE l_total     LIKE type_t.num5

   CALL s_transaction_begin()
   LET g_success = TRUE
   SELECT DISTINCT glaa003 INTO l_glaa003
     FROM glaa_t,ooef_t
    WHERE glaacomp = ooef017
      AND glaaent = ooefent
      AND ooefent = g_enterprise
      AND ooef001 = g_site
      AND glaa014 = 'Y'   
      
   CALL s_fin_date_get_period_range(l_glaa003,g_master.qcaq001,p_stage) RETURNING l_bdate,l_edate
   #刪除[T.每月品質分數統計檔(qcaq_t)]中該年度期別之符合條件資料
   DELETE FROM qcaq_t WHERE qcaqent = g_enterprise AND qcaq001 = g_master.qcaq001 AND qcaq002 = p_stage

   LET g_sql = " SELECT COUNT(*) ",
               "   FROM qcba_t,imaa_t",
               "  WHERE qcbaent = imaaent AND qcba010 = imaa001 ",
               "    AND qcbaent = '",g_enterprise,"' AND qcbasite ='",g_site,"'",
               "    AND qcbastus = 'Y' AND ",p_wc,
               "    AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'"
   PREPARE aqcq800_process_count FROM g_sql 
   EXECUTE aqcq800_process_count INTO l_total
   IF l_total = 0 THEN 
      LET g_success = FALSE
   END IF
   LET g_sql = " SELECT DISTINCT qcba000,qcba010,qcba012,qcba005,qcba006,qcba901 ",
               "   FROM qcba_t,imaa_t",
               "  WHERE qcbaent = imaaent AND qcba010 = imaa001 ",
               "    AND qcbaent = '",g_enterprise,"' AND qcbasite ='",g_site,"'",
               "    AND qcbastus = 'Y' AND ",p_wc,
               "    AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'"
   PREPARE aqcq800_process_pr FROM g_sql            
   DECLARE aqcq800_process_cs CURSOR FOR aqcq800_process_pr
   FOREACH aqcq800_process_cs INTO l_qcaq.qcaq000,l_qcaq.qcaq003,l_qcaq.qcaq004,
                                   l_qcaq.qcaq005,l_qcaq.qcaq007,l_qcaq.qcaq006
         
                 
      LET l_qcaq.qcaqent = g_enterprise            
      LET l_qcaq.qcaq001 = g_master.qcaq001
      LET l_qcaq.qcaq002 = p_stage
      LET l_qcaq.qcaqsite = g_site

      LET l_where = "   AND qcba000 = '",l_qcaq.qcaq000,"'",
                    "   AND qcba010 = '",l_qcaq.qcaq003,"'"
                    
      LET l_where2= "   AND pmdt006 ='",l_qcaq.qcaq003,"'"
                                         
      IF l_qcaq.qcaq004 IS NOT NULl THEN 
         LET l_where = l_where," AND qcba012 = '",l_qcaq.qcaq004,"'"
         LET l_where2= l_where2,"   AND pmdt007 ='",l_qcaq.qcaq004,"'" 
      ELSE
         LET l_where = l_where," AND qcba012 IS NULL " 
         LET l_where2= l_where2," AND pmdt007 IS NULL "          
      END IF
      IF l_qcaq.qcaq005 IS NOT NULl THEN 
         LET l_where = l_where," AND qcba005 = '",l_qcaq.qcaq005,"'"
         LET l_where2= l_where2,"   AND pmds007 ='",l_qcaq.qcaq005,"'" 
      ELSE
         LET l_where = l_where," AND qcba005 IS NULL "
         LET l_where2= l_where2," AND pmds007 IS NULL "          
      END IF
      IF l_qcaq.qcaq007 IS NOT NULl THEN 
         LET l_where = l_where," AND qcba006 = '",l_qcaq.qcaq007,"'"
      ELSE
         LET l_where = l_where," AND qcba006 IS NULL "      
      END IF
      IF l_qcaq.qcaq006 IS NOT NULl THEN 
         LET l_where = l_where," AND qcba901 = '",l_qcaq.qcaq006,"'"
      ELSE
         LET l_where = l_where," AND qcba901 IS NULL "      
      END IF      
      ##[C.送驗量](qcaq008) = [C.送驗量(qcba017)]加總
#      SELECT SUM(qcba017),SUM(qcba027) INTO l_qcaq.qcaq008,l_qcaq.qcaq010 
#        FROM qcba_t
#       WHERE qcbaent = g_enterprise
#         AND qcbastus = 'Y'
#         AND qcbadocdt BETWEEN l_bdate AND l_edate
#         AND qcba000 = l_qcaq.qcaq000
#         AND qcba010 = l_qcaq.qcaq003
#         AND qcba012 = l_qcaq.qcaq004
#         AND qcba005 = l_qcaq.qcaq005
#         AND qcba006 = l_qcaq.qcaq007
#         AND qcba901 = l_qcaq.qcaq006
  
      #LET ls_sql = " SELECT SUM(qcba017),SUM(qcba027) ",  #160425-00007#1  mark
      LET ls_sql = " SELECT SUM(qcba017) ",                #160425-00007#1
                   "  FROM qcba_t",
                   " WHERE qcbaent = '",g_enterprise,"'",
                   "   AND qcbastus = 'Y' ",
                   "   AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where       
      PREPARE get_qcaq008_10 FROM ls_sql
      EXECUTE get_qcaq008_10 INTO l_qcaq.qcaq008,l_qcaq.qcaq010 
      IF cl_null(l_qcaq.qcaq008) THEN LET l_qcaq.qcaq008 = 0 END IF
      #IF cl_null(l_qcaq.qcaq010) THEN LET l_qcaq.qcaq010 = 0 END IF    #160425-00007#1  mark   
      ##[C.抽驗量](qcaq009) = 每張QC單取單身[C.抽驗量(qcbd009)]最大一筆數量加總
      ##[C.不良数](qcaq010) = 每張QC單取單身[C.不良数(qcbd021)]最大一筆數量加總
#      SELECT SUM(MAX(qcbd009)) INTO l_qcaq.qcaq009 
#        FROM qcba_t,qcbd_t
#       WHERE qcbaent = qcbdent AND qcbadocno = qcbddocno
#         AND qcbaent = g_enterprise
#         AND qcbastus = 'Y'
#         AND qcbadocdt BETWEEN l_bdate AND l_edate
#         AND qcba000 = l_qcaq.qcaq000
#         AND qcba010 = l_qcaq.qcaq003
#         AND qcba012 = l_qcaq.qcaq004
#         AND qcba005 = l_qcaq.qcaq005
#         AND qcba006 = l_qcaq.qcaq007
#         AND qcba901 = l_qcaq.qcaq006 
#      GROUP BY qcbadocno         
      LET ls_sql = " SELECT SUM(MAX(qcbd009)),SUM(MAX(qcbd021)) ",    #160425-00007#1
                   "  FROM qcba_t,qcbd_t",
                   " WHERE qcbaent = qcbdent AND qcbadocno = qcbddocno",
                   "   AND qcbaent = '",g_enterprise,"'",
                   "   AND qcbastus = 'Y' ",
                   "   AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where,
                   " GROUP BY qcbadocno"                   
      PREPARE get_qcaq009 FROM ls_sql
      EXECUTE get_qcaq009 INTO l_qcaq.qcaq009,l_qcaq.qcaq010     #160425-00007#1
      IF cl_null(l_qcaq.qcaq009) THEN LET l_qcaq.qcaq009 = 0 END IF
      IF cl_null(l_qcaq.qcaq010) THEN LET l_qcaq.qcaq010 = 0 END IF    #160425-00007#1      
      ##[C.不良率] (qcaq011) = [C.不良數量]/[C.抽驗量]
      LET l_qcaq.qcaq011 =  l_qcaq.qcaq010/l_qcaq.qcaq009 USING '&.##'
      IF cl_null(l_qcaq.qcaq011) THEN LET l_qcaq.qcaq011 = 0 END IF 
      ##[C.收貨批數](qcaq012) = 若"檢驗類型"='1',則為該料件編號+產品特徵+交易對象的已確認收貨單單身筆數,
      ##                        其它檢驗類型則為0
      IF l_qcaq.qcaq000 = '1' THEN
         LET ls_sql = " SELECT COUNT(*) ", 
                      "  FROM pmds_t,pmdt_t",
                      " WHERE pmdsent=pmdtent AND pmdsdocno=pmdtdocno",
                      "   AND pmdsent = '",g_enterprise,"'",
                      "   AND pmdsstus = 'Y' ",
                      "   AND pmdsdocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where2                     
         PREPARE get_qcaq012 FROM ls_sql
         EXECUTE get_qcaq012 INTO l_qcaq.qcaq012 
      ELSE
         LET l_qcaq.qcaq012 = 0
      END IF
      IF cl_null(l_qcaq.qcaq012) THEN LET l_qcaq.qcaq012 = 0 END IF 
      ##[C.檢驗批數](qcaq013) = aqct300單頭之筆數
#      SELECT COUNT(*) INTO l_qcaq.qcaq013
#        FROM qcba_t
#       WHERE qcbaent = g_enterprise
#         AND qcbastus = 'Y'
#         AND qcbadocdt BETWEEN l_bdate AND l_edate
#         AND qcba000 = l_qcaq.qcaq000
#         AND qcba010 = l_qcaq.qcaq003
#         AND qcba012 = l_qcaq.qcaq004
#         AND qcba005 = l_qcaq.qcaq005
#         AND qcba006 = l_qcaq.qcaq007
#         AND qcba901 = l_qcaq.qcaq006 
      LET ls_sql = " SELECT COUNT(*) ", 
                   "  FROM qcba_t",
                   " WHERE qcbaent = '",g_enterprise,"'",
                   "   AND qcbastus = 'Y' ",
                   "   AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where       
      PREPARE get_qcaq013 FROM ls_sql
      EXECUTE get_qcaq013 INTO l_qcaq.qcaq013  
      IF cl_null(l_qcaq.qcaq013) THEN LET l_qcaq.qcaq013 = 0 END IF       
      ##[C.合格批數](qcaq014) = aqct300單頭[C:判定結果]='1'合格之筆數
#      SELECT COUNT(*) INTO l_qcaq.qcaq014
#        FROM qcba_t
#       WHERE qcbaent = g_enterprise
#         AND qcbastus = 'Y'
#         AND qcbadocdt BETWEEN l_bdate AND l_edate
#         AND qcba022 = '1'
#         AND qcba000 = l_qcaq.qcaq000
#         AND qcba010 = l_qcaq.qcaq003
#         AND qcba012 = l_qcaq.qcaq004
#         AND qcba005 = l_qcaq.qcaq005
#         AND qcba006 = l_qcaq.qcaq007
#         AND qcba901 = l_qcaq.qcaq006  
      LET ls_sql = " SELECT COUNT(*) ", 
                   "  FROM qcba_t",
                   " WHERE qcbaent = '",g_enterprise,"'",
                   "   AND qcbastus = 'Y' AND qcba022 = '1' ",
                   "   AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where       
      PREPARE get_qcaq014 FROM ls_sql
      EXECUTE get_qcaq014 INTO l_qcaq.qcaq014
      IF cl_null(l_qcaq.qcaq014) THEN LET l_qcaq.qcaq014 = 0 END IF       
      ##[C.不合格批數](qcaq015) = aqct300單頭[C:判定結果]='2'或'3'或'4'合格之筆數
#      SELECT COUNT(*) INTO l_qcaq.qcaq015
#        FROM qcba_t
#       WHERE qcbaent = g_enterprise
#         AND qcbastus = 'Y'
#         AND qcbadocdt BETWEEN l_bdate AND l_edate
#         AND qcba022 <> '1'
#         AND qcba000 = l_qcaq.qcaq000
#         AND qcba010 = l_qcaq.qcaq003
#         AND qcba012 = l_qcaq.qcaq004
#         AND qcba005 = l_qcaq.qcaq005
#         AND qcba006 = l_qcaq.qcaq007
#         AND qcba901 = l_qcaq.qcaq006
      LET ls_sql = " SELECT COUNT(*) ", 
                   "  FROM qcba_t",
                   " WHERE qcbaent = '",g_enterprise,"'",
                   "   AND qcbastus = 'Y' AND qcba022 <> '1' ",
                   "   AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where       
      PREPARE get_qcaq015 FROM ls_sql
      EXECUTE get_qcaq015 INTO l_qcaq.qcaq015
      IF cl_null(l_qcaq.qcaq015) THEN LET l_qcaq.qcaq015 = 0 END IF       
      ##[C.驗退批數](qcaq016) = aqct300單頭[C:判定結果]='2'之筆數
#      SELECT COUNT(*) INTO l_qcaq.qcaq016
#        FROM qcba_t
#       WHERE qcbaent = g_enterprise
#         AND qcbastus = 'Y'
#         AND qcbadocdt BETWEEN l_bdate AND l_edate
#         AND qcba022 = '2'
#         AND qcba000 = l_qcaq.qcaq000
#         AND qcba010 = l_qcaq.qcaq003
#         AND qcba012 = l_qcaq.qcaq004
#         AND qcba005 = l_qcaq.qcaq005
#         AND qcba006 = l_qcaq.qcaq007
#         AND qcba901 = l_qcaq.qcaq006  
      LET ls_sql = " SELECT COUNT(*) ", 
                   "  FROM qcba_t",
                   " WHERE qcbaent = '",g_enterprise,"'",
                   "   AND qcbastus = 'Y' AND qcba022 = '2' ",
                   "   AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where       
      PREPARE get_qcaq016 FROM ls_sql
      EXECUTE get_qcaq016 INTO l_qcaq.qcaq016 
      IF cl_null(l_qcaq.qcaq016) THEN LET l_qcaq.qcaq016 = 0 END IF       
      ##[C.特採批數](qcaq017) = aqct300單頭[C:判定結果]='4'之筆數
#      SELECT COUNT(*) INTO l_qcaq.qcaq017
#        FROM qcba_t
#       WHERE qcbaent = g_enterprise
#         AND qcbastus = 'Y'
#         AND qcbadocdt BETWEEN l_bdate AND l_edate
#         AND qcba022 = '4'
#         AND qcba000 = l_qcaq.qcaq000
#         AND qcba010 = l_qcaq.qcaq003
#         AND qcba012 = l_qcaq.qcaq004
#         AND qcba005 = l_qcaq.qcaq005
#         AND qcba006 = l_qcaq.qcaq007
#         AND qcba901 = l_qcaq.qcaq006  
      LET ls_sql = " SELECT COUNT(*) ", 
                   "  FROM qcba_t",
                   " WHERE qcbaent = '",g_enterprise,"'",
                   "   AND qcbastus = 'Y' AND qcba022 = '4' ",
                   "   AND qcbadocdt BETWEEN '",l_bdate,"' AND '",l_edate,"'",l_where       
      PREPARE get_qcaq017 FROM ls_sql
      EXECUTE get_qcaq017 INTO l_qcaq.qcaq017
      IF cl_null(l_qcaq.qcaq017) THEN LET l_qcaq.qcaq017 = 0 END IF       
	   ##[C.批合格率](qcaq018) = [C:合格批數] / [C:檢驗批數]
	   LET l_qcaq.qcaq018 = l_qcaq.qcaq014/l_qcaq.qcaq013  USING '&.##'
	   IF cl_null(l_qcaq.qcaq018) THEN LET l_qcaq.qcaq018 = 0 END IF 
	   ##[C.批不合格率](qcaq019) = [C:不合格批數] / [C:檢驗批數]
	   LET l_qcaq.qcaq019 = l_qcaq.qcaq015/l_qcaq.qcaq013  USING '&.##'
	   IF cl_null(l_qcaq.qcaq019) THEN LET l_qcaq.qcaq019 = 0 END IF 
	   ##[C.批驗退率](qcaq020) = [C:驗退批數] / [C:檢驗批數]
	   LET l_qcaq.qcaq020 = l_qcaq.qcaq016/l_qcaq.qcaq013  USING '&.##'
	   IF cl_null(l_qcaq.qcaq020) THEN LET l_qcaq.qcaq020 = 0 END IF 
	   ##[C.批特採率](qcaq021) = [C:特採批數] / [C:檢驗批數]
      LET l_qcaq.qcaq021 = l_qcaq.qcaq017/l_qcaq.qcaq013	  USING '&.##'
      IF cl_null(l_qcaq.qcaq021) THEN LET l_qcaq.qcaq021 = 0 END IF       
      
      IF cl_null(l_qcaq.qcaq004) THEN LET l_qcaq.qcaq004 = ' ' END IF
      IF cl_null(l_qcaq.qcaq005) THEN LET l_qcaq.qcaq005 = ' ' END IF
      IF cl_null(l_qcaq.qcaq007) THEN LET l_qcaq.qcaq007 = ' ' END IF
#      INSERT INTO qcaq_t VALUES l_qcaq.* #161124-00048#10  mark
      #161124-00048#10 add(s)
      INSERT INTO qcaq_t (qcaqent,qcaqsite,qcaq000,qcaq001,qcaq002,qcaq003,
                          qcaq004,qcaq005,qcaq006,qcaq007,qcaq008,qcaq009,
                          qcaq010,qcaq011,qcaq012,qcaq013,qcaq014,qcaq015,
                          qcaq016,qcaq017,qcaq018,qcaq019,qcaq020,qcaq021)
                  VALUES (l_qcaq.qcaqent,l_qcaq.qcaqsite,l_qcaq.qcaq000,l_qcaq.qcaq001,l_qcaq.qcaq002,l_qcaq.qcaq003,
                          l_qcaq.qcaq004,l_qcaq.qcaq005,l_qcaq.qcaq006,l_qcaq.qcaq007,l_qcaq.qcaq008,l_qcaq.qcaq009,
                          l_qcaq.qcaq010,l_qcaq.qcaq011,l_qcaq.qcaq012,l_qcaq.qcaq013,l_qcaq.qcaq014,l_qcaq.qcaq015,
                          l_qcaq.qcaq016,l_qcaq.qcaq017,l_qcaq.qcaq018,l_qcaq.qcaq019,l_qcaq.qcaq020,l_qcaq.qcaq021)
      #161124-00048#10 add(e)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INS qcaq_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = FALSE 
         EXIT FOREACH  
      END IF
      
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM qcaq_t
       WHERE qcaqent = g_enterprise
         AND qcaqsite = g_site
         AND qcaq000 = l_qcaq.qcaq000
         AND qcaq001 = g_master.qcaq001
         AND qcaq002 = 99
         AND qcaq003 = l_qcaq.qcaq003
         AND qcaq004 = l_qcaq.qcaq004
         AND qcaq005 = l_qcaq.qcaq005
         AND qcaq006 = l_qcaq.qcaq006
         AND qcaq007 = l_qcaq.qcaq007
      IF l_cnt = 0 THEN 
         LET l_qcaq.qcaq002 = 99
#        INSERT INTO qcaq_t VALUES l_qcaq.* #161124-00048#10  mark
         #161124-00048#10 add(s)
         INSERT INTO qcaq_t (qcaqent,qcaqsite,qcaq000,qcaq001,qcaq002,qcaq003,
                             qcaq004,qcaq005,qcaq006,qcaq007,qcaq008,qcaq009,
                             qcaq010,qcaq011,qcaq012,qcaq013,qcaq014,qcaq015,
                             qcaq016,qcaq017,qcaq018,qcaq019,qcaq020,qcaq021)
                     VALUES (l_qcaq.qcaqent,l_qcaq.qcaqsite,l_qcaq.qcaq000,l_qcaq.qcaq001,l_qcaq.qcaq002,l_qcaq.qcaq003,
                             l_qcaq.qcaq004,l_qcaq.qcaq005,l_qcaq.qcaq006,l_qcaq.qcaq007,l_qcaq.qcaq008,l_qcaq.qcaq009,
                             l_qcaq.qcaq010,l_qcaq.qcaq011,l_qcaq.qcaq012,l_qcaq.qcaq013,l_qcaq.qcaq014,l_qcaq.qcaq015,
                             l_qcaq.qcaq016,l_qcaq.qcaq017,l_qcaq.qcaq018,l_qcaq.qcaq019,l_qcaq.qcaq020,l_qcaq.qcaq021)
         #161124-00048#10 add(e)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "INS qcaq_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE 
            EXIT FOREACH            
         END IF         
      ELSE
         SELECT SUM(qcaq008),SUM(qcaq009),SUM(qcaq010),SUM(qcaq012),SUM(qcaq013),
                SUM(qcaq014),SUM(qcaq015),SUM(qcaq016),SUM(qcaq017)
           INTO l_qcaq008,l_qcaq009,l_qcaq010,l_qcaq012,l_qcaq013,
                l_qcaq014,l_qcaq015,l_qcaq016,l_qcaq017 
           FROM qcaq_t
          WHERE qcaqent = g_enterprise
            AND qcaqsite = g_site
            AND qcaq000 = l_qcaq.qcaq000
            AND qcaq001 = g_master.qcaq001
            AND qcaq002 <> 99
            AND qcaq003 = l_qcaq.qcaq003
            AND qcaq004 = l_qcaq.qcaq004
            AND qcaq005 = l_qcaq.qcaq005
            AND qcaq006 = l_qcaq.qcaq006
            AND qcaq007 = l_qcaq.qcaq007
         LET l_qcaq011 = l_qcaq010/l_qcaq008 USING '&.##'  
         LET l_qcaq018 = l_qcaq014/l_qcaq013 USING '&.##'
         LET l_qcaq019 = l_qcaq015/l_qcaq013 USING '&.##'
         LET l_qcaq020 = l_qcaq016/l_qcaq013 USING '&.##'
         LET l_qcaq021 = l_qcaq017/l_qcaq013 USING '&.##'
         IF cl_null(l_qcaq011) THEN LET l_qcaq011 = 0 END IF
         IF cl_null(l_qcaq018) THEN LET l_qcaq018 = 0 END IF 
         IF cl_null(l_qcaq019) THEN LET l_qcaq019 = 0 END IF 
         IF cl_null(l_qcaq020) THEN LET l_qcaq020 = 0 END IF 
         IF cl_null(l_qcaq021) THEN LET l_qcaq021 = 0 END IF 
         UPDATE qcaq_t
            SET qcaq008 = l_qcaq008,
                qcaq009 = l_qcaq009,
                qcaq010 = l_qcaq010,
                qcaq011 = l_qcaq011,
                qcaq012 = l_qcaq012,
                qcaq013 = l_qcaq013,
                qcaq014 = l_qcaq014,
                qcaq015 = l_qcaq015,
                qcaq016 = l_qcaq016,
                qcaq017 = l_qcaq017,
                qcaq018 = l_qcaq018,
                qcaq019 = l_qcaq019,
                qcaq020 = l_qcaq020,
                qcaq021 = l_qcaq021
          WHERE qcaqent = g_enterprise
            AND qcaqsite = g_site
            AND qcaq000 = l_qcaq.qcaq000
            AND qcaq001 = g_master.qcaq001
            AND qcaq002 = 99
            AND qcaq003 = l_qcaq.qcaq003
            AND qcaq004 = l_qcaq.qcaq004
            AND qcaq005 = l_qcaq.qcaq005
            AND qcaq006 = l_qcaq.qcaq006
            AND qcaq007 = l_qcaq.qcaq007 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "UPDATE qcaq_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE 
            EXIT FOREACH            
         END IF             
      END IF
#      INITIALIZE l_qcaq.* LIKE qcaq_t.*  #161124-00048#10 mark
      INITIALIZE l_qcaq.* TO NULL #161124-00048#10 add
   END FOREACH   
   IF g_success = TRUE THEN 
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')    
   END IF   
END FUNCTION

 
{</section>}
 
