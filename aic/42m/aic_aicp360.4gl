#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp360.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp360
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp360.global" >}
#160909-00080#1   2016/09/13  By 02097    修改開窗
#161231-00013#1  2016/01/11 By 08992   增加azzi850 部門權限控管
#170213-00043#1  2017/02/15 By 08171   若拋轉成功後已無符合的資料則不提示[指定的資料無法查詢到，....] 
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
 
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
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)
       sel            LIKE type_t.chr1,
       xmdodocno      LIKE xmdo_t.xmdodocno, 
       xmdodocdt      LIKE xmdo_t.xmdodocdt,
       xmdo002        LIKE xmdo_t.xmdo002,
       xmdo002_desc   LIKE type_t.chr80,
       xmdo003        LIKE xmdo_t.xmdo003,
       xmdo003_desc   LIKE type_t.chr80,
       xmdo007        LIKE xmdo_t.xmdo007,
       xmdo007_desc   LIKE type_t.chr80,
       xmdo008        LIKE xmdo_t.xmdo008,
       xmdo008_desc   LIKE type_t.chr80,
       xmdo009        LIKE xmdo_t.xmdo009,
       xmdo009_desc   LIKE type_t.chr80,
       xmdoownid      LIKE xmdo_t.xmdoownid,
       xmdoownid_desc LIKE type_t.chr80,
       xmdocrtid      LIKE xmdo_t.xmdocrtid,
       xmdocrtid_desc LIKE type_t.chr80,
       xmdo056        LIKE xmdo_t.xmdo056,
       xmdo055        LIKE xmdo_t.xmdo055
       END RECORD

TYPE type_g_detail2_d RECORD
       xmdpseq        LIKE xmdp_t.xmdpseq,
       xmdp001        LIKE xmdp_t.xmdp001,
       xmdp002        LIKE xmdp_t.xmdp002,       
       xmdp003        LIKE xmdp_t.xmdp003,
       xmdp004        LIKE xmdp_t.xmdp004,
       xmdp005        LIKE xmdp_t.xmdp005,
       xmdp006        LIKE xmdp_t.xmdp006,
       xmdp007        LIKE xmdp_t.xmdp007,
       xmdp008        LIKE xmdp_t.xmdp008,
       xmdp008_desc   LIKE type_t.chr80,
       xmdp008_desc_1 LIKE type_t.chr80,
       xmdp009        LIKE xmdp_t.xmdp009,
       xmdp010        LIKE xmdp_t.xmdp010,
       xmdp012        LIKE xmdp_t.xmdp012,
       xmdp015        LIKE xmdp_t.xmdp015,
       xmdp015_desc   LIKE type_t.chr80,
       xmdp016        LIKE xmdp_t.xmdp016,
       xmdp019        LIKE xmdp_t.xmdp019,
       xmdp019_desc   LIKE type_t.chr80,       
       xmdp020        LIKE xmdp_t.xmdp020,
       xmdp021        LIKE xmdp_t.xmdp021,
       xmdp024        LIKE xmdp_t.xmdp024,
       xmdp025        LIKE xmdp_t.xmdp025
       END RECORD
DEFINE g_detail2_d      DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt    LIKE type_t.num5

TYPE type_g_detail3_d RECORD
       xmdodocno      LIKE xmdo_t.xmdodocno, 
       xmdodocdt      LIKE xmdo_t.xmdodocdt,
       xmdo007        LIKE xmdo_t.xmdo007,
       xmdo007_desc   LIKE type_t.chr80,
       xmdo008        LIKE xmdo_t.xmdo008,
       xmdo008_desc   LIKE type_t.chr80,
       xmdo009        LIKE xmdo_t.xmdo009,
       xmdo009_desc   LIKE type_t.chr80,
       xmdo002        LIKE xmdo_t.xmdo002,
       xmdo002_desc   LIKE type_t.chr80,
       xmdo003        LIKE xmdo_t.xmdo003,
       xmdo003_desc   LIKE type_t.chr80
       END RECORD
DEFINE g_detail3_d      DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt     LIKE type_t.num5

TYPE type_g_detail4_d RECORD
       xmdodocno      LIKE xmdo_t.xmdodocno, 
       xmdodocdt      LIKE xmdo_t.xmdodocdt,
       xmdo007        LIKE xmdo_t.xmdo007,
       xmdo007_desc   LIKE type_t.chr80,
       xmdo008        LIKE xmdo_t.xmdo008,
       xmdo008_desc   LIKE type_t.chr80,
       xmdo009        LIKE xmdo_t.xmdo009,
       xmdo009_desc   LIKE type_t.chr80,
       xmdo002        LIKE xmdo_t.xmdo002,
       xmdo002_desc   LIKE type_t.chr80,
       xmdo003        LIKE xmdo_t.xmdo003,
       xmdo003_desc   LIKE type_t.chr80,
       xmdo055        LIKE xmdo_t.xmdo055,
       xmdosite       LIKE xmdo_t.xmdosite,
       xmdosite_desc  LIKE type_t.chr80,
       reason         LIKE type_t.chr1000
       END RECORD
DEFINE g_detail4_d      DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt     LIKE type_t.num5

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

DEFINE g_aicp360_sel    STRING

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp360.main" >}
#+ 作業開始 
MAIN
   DEFINE ls_js  STRING
   #add-point:main段define
   
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aic","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   
   CALL aicp360_create_temp_table()
   
   CALL aicp360_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdodocno = '",g_argv[1],"' "
         CALL aicp360_query()
         UPDATE aicp360_tmp
            SET sel = 'Y'
         CALL aicp360_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp360 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp360_init()   
 
      #進入選單 Menu (="N")
      CALL aicp360_ui_dialog() 
 
      #add-point:畫面關閉前
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp360
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp360_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp360.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp360_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   
   LET g_errshow = 1
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF

   CALL cl_set_combo_scc('b_xmdo001','2063')
   CALL cl_set_combo_scc('b_xmdp007','2055')

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp360.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp360_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 
   LET g_wc = "1=1"
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct

         CONSTRUCT BY NAME g_wc ON xmdodocno,xmdodocdt,
                                   xmdo002,xmdo003,xmdo007,xmdo008,xmdo009,
                                   xmdoownid,xmdocrtid
            
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdodocno
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = g_aicp360_sel
               
               CALL q_xmdodocno_1()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdodocno  #顯示到畫面上
               NEXT FIELD xmdodocno                     #返回原欄位

            ON ACTION controlp INFIELD xmdo002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdo002  #顯示到畫面上
               NEXT FIELD xmdo002                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdo003
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdo003  #顯示到畫面上
               NEXT FIELD xmdo003                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdo007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001_8()                     #160909-00080#1 mark
               CALL q_pmaa001_25()                     #160909-00080#1
               DISPLAY g_qryparam.return1 TO xmdo007  #顯示到畫面上
               NEXT FIELD xmdo007                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdo008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               CALL q_pmac002_5()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdo008  #顯示到畫面上
               NEXT FIELD xmdo008                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdo009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               CALL q_pmac002_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdo009  #顯示到畫面上
               NEXT FIELD xmdo009                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdoownid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdoownid  #顯示到畫面上
               NEXT FIELD xmdoownid                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdocrtid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdocrtid  #顯示到畫面上
               NEXT FIELD xmdocrtid                     #返回原欄位
            
         END CONSTRUCT         
         #end add-point
         #add-point:ui_dialog段input
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
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
               CALL aicp360_fetch()               
               
            ON CHANGE sel
               UPDATE aicp360_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE xmdodocno = g_detail_d[l_ac].xmdodocno 
                  
         END INPUT               
         #end add-point
         #add-point:ui_dialog段自定義display array
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
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            
            CALL aicp360_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp360_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp360_tmp 
               SET sel = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp360_tmp 
                     SET sel = 'Y' 
                   WHERE xmdodocno = g_detail_d[l_ac].xmdodocno 
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
            #add-point:ui_dialog段on action unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp360_tmp
                     SET sel = 'N' 
                   WHERE xmdodocno = g_detail_d[l_ac].xmdodocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp360_filter()
            #add-point:ON ACTION filter

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
            CALL aicp360_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp360_b_fill()
            CALL aicp360_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp360_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdodocno = g_detail_d[l_ac].xmdodocno
            END IF

            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp360_tmp
             WHERE sel = 'Y'

            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            ELSE
               CALL aicp360_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp360_query()
               LET INT_FLAG = FALSE    #170213-00043#1 17/02/15 By 08171 add
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
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp360.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp360_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
 
   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp360_tmp;
   LET g_sql = "SELECT DISTINCT 'N',xmdodocno,xmdodocdt,",
               "                xmdo002,xmdo003,xmdo007,xmdo008,xmdo009,",
               "                xmdoownid,xmdocrtid,",
               "                xmdo056,xmdo055 ",
               "  FROM xmdo_t ",
               " WHERE ",g_aicp360_sel,
               " AND ",g_wc
               
   LET g_sql = "INSERT INTO aicp360_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp360_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp360.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp360_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT DISTINCT sel,xmdodocno,xmdodocdt,",
               "                xmdo002,'',",
               "                xmdo003,'',",
               "                xmdo007,'',",
               "                xmdo008,'',",
               "                xmdo009,'',",
               "                xmdoownid,'',",
               "                xmdocrtid,'',",
               "                xmdo056,xmdo055 ",
               "  FROM aicp360_tmp ",
               " ORDER BY xmdodocno,xmdodocdt "
   #end add-point
 
   PREPARE aicp360_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp360_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
   CALL g_detail2_d.clear()
   LET g_master_idx = 1   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO 
   #add-point:b_fill段foreach_into
      g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdodocno,g_detail_d[l_ac].xmdodocdt,
      g_detail_d[l_ac].xmdo002,g_detail_d[l_ac].xmdo002_desc,
      g_detail_d[l_ac].xmdo003,g_detail_d[l_ac].xmdo003_desc,
      g_detail_d[l_ac].xmdo007,g_detail_d[l_ac].xmdo007_desc,
      g_detail_d[l_ac].xmdo008,g_detail_d[l_ac].xmdo008_desc,
      g_detail_d[l_ac].xmdo009,g_detail_d[l_ac].xmdo009_desc,
      g_detail_d[l_ac].xmdoownid,g_detail_d[l_ac].xmdoownid_desc,
      g_detail_d[l_ac].xmdocrtid,g_detail_d[l_ac].xmdocrtid_desc,
      g_detail_d[l_ac].xmdo056,g_detail_d[l_ac].xmdo055
   
   
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdo002)
           RETURNING g_detail_d[l_ac].xmdo002_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdoownid)
           RETURNING g_detail_d[l_ac].xmdoownid_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdocrtid)
           RETURNING g_detail_d[l_ac].xmdocrtid_desc
      
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmdo003)
           RETURNING g_detail_d[l_ac].xmdo003_desc
      
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdo007)
           RETURNING g_detail_d[l_ac].xmdo007_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdo008)
           RETURNING g_detail_d[l_ac].xmdo008_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdo009)
           RETURNING g_detail_d[l_ac].xmdo009_desc
      #end add-point
      
      CALL aicp360_detail_show()      
 
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
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身)
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
   FREE aicp360_sel
   
   LET l_ac = 1
   CALL aicp360_fetch()
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp360.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp360_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   CALL g_detail2_d.clear()

   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT xmdpseq,xmdp001,xmdp002,xmdp003,",
               "       xmdp004,xmdp005,xmdp006,xmdp007,",
               "       xmdp008,a.imaal003,a.imaal004,",
               "       xmdp009,xmdp010,xmdp012,",
               "       xmdp015,c.oocal003,",
               "       xmdp016,",
               "       xmdp019,d.oocal003,",
               "       xmdp020,xmdp021,xmdp024,xmdp025",
               "  FROM xmdp_t ",
               "       LEFT OUTER JOIN imaal_t a ON xmdpent = a.imaalent AND xmdp008 = a.imaal001 AND a.imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t c ON xmdpent = c.oocalent AND xmdp015 = c.oocal001 AND c.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t d ON xmdpent = d.oocalent AND xmdp019 = d.oocal001 AND d.oocal002 = '",g_dlang,"'",
               " WHERE xmdpent = '",g_enterprise,"'",
               "   AND xmdpdocno = '",g_detail_d[g_master_idx].xmdodocno,"'"
   PREPARE xmdp_fill_pre FROM g_sql
   DECLARE xmdp_fill_cur CURSOR FOR xmdp_fill_pre
   FOREACH xmdp_fill_cur INTO g_detail2_d[l_ac].*
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
   DISPLAY g_detail2_cnt TO FORMONLY.cnt   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp360.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp360_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp360.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp360_filter()
   #add-point:filter段define
 
   #end add-point    
 
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define
   CLEAR FORM
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   
   CONSTRUCT g_wc_filter ON xmdodocno,xmdodocdt,
                            xmdo002,xmdo003,
                            xmdo007,xmdo008,xmdo009,
                            xmdoownid,xmdocrtid,
                            xmdo056,xmdo055
        FROM s_detail1[1].b_xmdodocno,s_detail1[1].b_xmdodocdt,
             s_detail1[1].b_xmdo002,s_detail1[1].b_xmdo003,
             s_detail1[1].b_xmdo007,s_detail1[1].b_xmdo008,s_detail1[1].b_xmdo009,
             s_detail1[1].b_xmdoownid,s_detail1[1].b_xmdocrtid,
             s_detail1[1].b_xmdo056,s_detail1[1].b_xmdo055
      
         BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD b_xmdodocno
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = g_aicp360_sel
               
               CALL q_xmdodocno_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xmdodocno  #顯示到畫面上
               NEXT FIELD b_xmdodocno                     #返回原欄位

            ON ACTION controlp INFIELD b_xmdo002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xmdo002  #顯示到畫面上
               NEXT FIELD b_xmdo002                     #返回原欄位
               
            ON ACTION controlp INFIELD b_xmdo003
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xmdo003  #顯示到畫面上
               NEXT FIELD b_xmdo003                     #返回原欄位
   
            ON ACTION controlp INFIELD b_xmdo007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001_8()                     #160909-00080#1 mark
               CALL q_pmaa001_25()                     #160909-00080#1
               DISPLAY g_qryparam.return1 TO b_xmdo007  #顯示到畫面上
               NEXT FIELD b_xmdo007                     #返回原欄位
               
            ON ACTION controlp INFIELD b_xmdo008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               CALL q_pmac002_5()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xmdo008  #顯示到畫面上
               NEXT FIELD b_xmdo008                     #返回原欄位
   
            ON ACTION controlp INFIELD b_xmdo009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               CALL q_pmac002_6()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xmdo009  #顯示到畫面上
               NEXT FIELD b_xmdo009                     #返回原欄位
               
            ON ACTION controlp INFIELD b_xmdoownid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xmdoownid  #顯示到畫面上
               NEXT FIELD b_xmdoownid                     #返回原欄位
   
            ON ACTION controlp INFIELD b_xmdocrtid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xmdocrtid  #顯示到畫面上
               NEXT FIELD b_xmdocrtid                     #返回原欄位     
      
      
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp360_b_fill()
   CALL aicp360_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp360.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp360_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="aicp360.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp360_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp360_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp360.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp360_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp360_process()
DEFINE l_xmdo         type_g_detail_d
DEFINE l_success      LIKE type_t.num5
DEFINE l_icab_now  RECORD
          icab002     LIKE icab_t.icab002,
          icab003     LIKE icab_t.icab003,
          icab004     LIKE icab_t.icab004
                   END RECORD
DEFINE l_xmda031      LIKE xmda_t.xmda031
DEFINE l_xmda006      LIKE xmda_t.xmda006
DEFINE l_pmdl006      LIKE pmdl_t.pmdl006

   LET g_sql = "SELECT xmdodocno,xmdodocdt,",
               "       xmdo002,xmdo003,",
               "       xmdo007,xmdo008,xmdo009,",
               "       xmdoownid,xmdocrtid,",
               "       xmdo056,xmdo055 ",
               "  FROM aicp360_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY xmdodocno "
   PREPARE aicp360_process_pre FROM g_sql
   DECLARE aicp360_process_cur CURSOR WITH HOLD FOR aicp360_process_pre
   
   #該流程多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003,icab004",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               " ORDER BY icab002"
   PREPARE aicp360_process_icab_pre FROM g_sql
   DECLARE aicp360_process_icab_cur CURSOR FOR aicp360_process_icab_pre
   
   LET g_sql = "SELECT xmda031",
               "  FROM xmdp_t,xmda_t",
               " WHERE xmdpent = xmdaent AND xmdaent = ",g_enterprise,
               "   AND xmdpdocno = ?",
               "   AND xmdp003 = xmdadocno",
               "   AND xmdp003 IS NOT NULL",
               " ORDER BY xmdpseq"
   PREPARE xmda031_pre FROM g_sql
   DECLARE xmda031_cur SCROLL CURSOR FOR xmda031_pre
   
   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化

   FOREACH aicp360_process_cur INTO l_xmdo.xmdodocno,l_xmdo.xmdodocdt,
                                    l_xmdo.xmdo002,l_xmdo.xmdo003,
                                    l_xmdo.xmdo007,l_xmdo.xmdo008,l_xmdo.xmdo009,
                                    l_xmdo.xmdoownid,l_xmdo.xmdocrtid,
                                    l_xmdo.xmdo056,l_xmdo.xmdo055
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         #失敗記錄
         CALL aicp360_fail(l_xmdo.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      
      #多角序號為空白時，錯誤
      IF cl_null(l_xmdo.xmdo055) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00099'   #該筆資料之多角序號為空！
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE

         CALL cl_err()
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp360_fail(l_xmdo.*,'')
         CONTINUE FOREACH
      END IF
            
      LET l_xmda031 = ''
      OPEN xmda031_cur USING l_xmdo.xmdodocno
      FETCH FIRST xmda031_cur INTO l_xmda031
      CLOSE xmda031_cur
      
      #多角性質
      LET l_xmda006 = ''
      LET l_pmdl006 = ''
      SELECT xmda006 INTO l_xmda006
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmda031 = l_xmda031
         AND xmdasite = (SELECT icab003 FROM icab_t
                          WHERE icabent = g_enterprise
                            AND icab001 = l_xmdo.xmdo056
                            AND icab002 = 0)

      IF cl_null(l_xmda006) THEN
         SELECT pmdl006 INTO l_pmdl006
           FROM pmdl_t
          WHERE pmdlent = g_enterprise
            AND pmdl031 = l_xmda031
            AND pmdlsite = (SELECT icab003 FROM icab_t
                             WHERE icabent = g_enterprise
                               AND icab001 = l_xmdo.xmdo056
                               AND icab002 = 0)
      END IF
      
      IF l_xmda006 <> '3' OR l_pmdl006 <> '4' THEN
         #多角性質非"統銷統收"
         
         #多角流程代碼為空白時，錯誤
         IF cl_null(l_xmdo.xmdo056) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aic-00026'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp360_fail(l_xmdo.*,'')
            CONTINUE FOREACH
         END IF
         
         #跑站(當站)
         OPEN aicp360_process_icab_cur USING l_xmdo.xmdo056
         FOREACH aicp360_process_icab_cur INTO l_icab_now.icab002,l_icab_now.icab003,l_icab_now.icab004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
                  
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
         
            #用多角序號抓取該站的Invoice，並做處理
            CALL aicp360_xmdo(l_icab_now.icab003,l_xmdo.xmdo055,l_xmdo.xmdo056)
                 RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
         END FOREACH
      ELSE
         ##多角性質為"統銷統收"
      END IF
      
      #更新"多角貿易拋轉否"='N'及清空"多角流程序號"
      IF l_success THEN
         UPDATE xmdo_t SET xmdo054 = 'N',
                           xmdo055 = NULL
          WHERE xmdoent = g_enterprise
            AND xmdodocno = l_xmdo.xmdodocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
                        
            CALL cl_err()
            LET l_success = FALSE
         END IF
         
         #包裝單
         UPDATE xmel_t SET xmel016 = 'N',
                           xmel017 = NULL
          WHERE xmelent = g_enterprise
            AND xmel017 = l_xmdo.xmdo055
         IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
                        
            CALL cl_err()
            LET l_success = FALSE
         END IF
         
      END IF
      
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_xmdo.xmdo055,'3')
              RETURNING l_success
      END IF
      
      IF g_bgjob = 'N' THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            #成功記錄
            CALL aicp360_success(l_xmdo.*)
         ELSE
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp360_fail(l_xmdo.*,l_icab_now.icab003)
         END IF
      ELSE
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            CALL cl_ask_pressanykey("aic-00178")    #多角流程拋轉還原成功！
         ELSE
            CALL s_transaction_end('N',0)
            CALL cl_ask_pressanykey("aic-00179")    #多角流程拋轉還原失敗！
         END IF
      END IF
      
   END FOREACH

   #清空錯誤訊息的array，並且之後的訊息不以array記錄
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
  
   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 抓取該站的Invoice單，取消確認並刪除/作廢所有資料
# Memo...........:
# Usage..........: CALL aicp360_xmdo(p_site,p_xmdo055,p_xmdo056)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_xmdo055      多角序號
#                : p_xmdo056      多角代碼
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/03/20 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp360_xmdo(p_site,p_xmdo055,p_xmdo056)
DEFINE p_site            LIKE xmdo_t.xmdosite
DEFINE p_xmdo055         LIKE xmdo_t.xmdo055
DEFINE p_xmdo056         LIKE xmdo_t.xmdo056
DEFINE r_success         LIKE type_t.num5
DEFINE l_xmdodocno       LIKE xmdo_t.xmdodocno
DEFINE l_xmdodocdt       LIKE xmdo_t.xmdodocdt
DEFINE l_xmeldocno       LIKE xmel_t.xmeldocno
DEFINE l_xmeldocdt       LIKE xmel_t.xmeldocdt
DEFINE l_site            LIKE xmdo_t.xmdosite
DEFINE l_prog            LIKE ooef_t.ooef001
DEFINE l_icaa014         LIKE icaa_t.icaa014
DEFINE l_icab003_first   LIKE icab_t.icab003
DEFINE l_icab003_last    LIKE icab_t.icab003
DEFINE l_sql             STRING

   LET r_success = TRUE
   
   LET l_icaa014 = ''
   SELECT icaa014
     INTO l_icaa014
     FROM icaa_t
    WHERE icaaent = g_enterprise
      AND icaa001 = p_xmdo056
   
   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_xmdo056,"'",
               " ORDER BY icab002"
   PREPARE sel_icab003_first_pre FROM l_sql
   DECLARE sel_icab003_first_cs SCROLL CURSOR FOR sel_icab003_first_pre

   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_xmdo056,"'",
               " ORDER BY icab002 DESC"
   PREPARE sel_icab003_last_pre FROM l_sql
   DECLARE sel_icab003_last_cs SCROLL CURSOR FOR sel_icab003_last_pre
   
   LET l_icab003_first = ''
   OPEN sel_icab003_first_cs
   FETCH FIRST sel_icab003_first_cs INTO l_icab003_first
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'FETCH:sel_icab003_first_cs'
      LET g_errparam.popup = TRUE

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_icab003_last = ''
   OPEN sel_icab003_last_cs
   FETCH FIRST sel_icab003_last_cs INTO l_icab003_last
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'FETCH:sel_icab003_last_cs'
      LET g_errparam.popup = TRUE

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #正拋初始站，不做處理
   IF l_icaa014 = '1' AND l_icab003_first = p_site THEN
      RETURN r_success
   END IF

   #逆拋最終站，不做處理
   IF l_icaa014 = '2' AND l_icab003_last = p_site THEN
      RETURN r_success
   END IF
   
   LET l_xmdodocno = ''
   LET l_xmdodocdt = ''
   SELECT xmdodocno,xmdodocdt
     INTO l_xmdodocno,l_xmdodocdt
     FROM xmdo_t
    WHERE xmdoent = g_enterprise
      AND xmdosite = p_site
      AND xmdo055 = p_xmdo055
      AND xmdostus <> 'X'
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
                  
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(l_xmdodocno) THEN
      RETURN r_success
   END IF
   
   #找尋對應的包裝單axmt610
   LET l_xmeldocno = ''
   LET l_xmeldocdt = ''
   SELECT xmeldocno,xmeldocdt
     INTO l_xmeldocno,l_xmeldocdt
     FROM xmel_t
    WHERE xmelent = g_enterprise
      AND xmelsite = p_site
      AND xmel017 = p_xmdo055
      AND xmelstus <> 'X'
   
   #先將多角序號清空
   UPDATE xmdo_t SET xmdo055 = NULL,
                     xmdo054 = 'N'
    WHERE xmdoent = g_enterprise
      AND xmdodocno = l_xmdodocno
   
   #包裝單
   IF NOT cl_null(l_xmeldocno) THEN
      #先將多角序號清空
      UPDATE xmel_t SET xmel017 = NULL,
                        xmel016 = 'N'
       WHERE xmelent = g_enterprise
         AND xmeldocno = l_xmeldocno   
   END IF
   
   LET l_prog = g_prog
   LET l_site = g_site
   LET g_site = p_site
   
   #取消確認
   LET g_prog = 'axmt620'
   CALL s_axmt620_unconfirm_chk(l_xmdodocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_axmt620_unconfirm_upd(l_xmdodocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
      
   IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
      #多角單據流水號保持一致='N'時，做作廢處理
      CALL s_axmt620_invalid_chk(l_xmdodocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      CALL s_axmt620_invalid_upd(l_xmdodocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
   ELSE
      #刪除所有資料
      #1.Invoice單單頭
      DELETE FROM xmdo_t
       WHERE xmdoent = g_enterprise
         AND xmdodocno = l_xmdodocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdodocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #3.Invoice單明細
      DELETE FROM xmdp_t
       WHERE xmdpent = g_enterprise
         AND xmdpdocno = l_xmdodocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdodocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      
      #3.單號處理
      IF NOT s_aooi200_del_docno(l_xmdodocno,l_xmdodocdt) THEN
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   
      #稅額xrcd
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_xmdodocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdodocno
         LET g_errparam.popup = TRUE

         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   
      #刪除備註
      CALL s_aooi360_del('6',g_prog,l_xmdodocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
                  
      #相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_xmdodocno
      LET g_pk_array[1].column = 'xmdodocno'
      CALL cl_doc_remove()
      
   END IF
   
   #包裝單
   IF NOT cl_null(l_xmeldocno) THEN
      #取消確認
      LET g_prog = 'axmt610'
      CALL s_axmt610_unconfirm_chk(l_xmeldocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      CALL s_axmt610_unconfirm_upd(l_xmeldocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
         #多角單據流水號保持一致='N'時，做作廢處理
         CALL s_axmt610_void_chk(l_xmeldocno)
              RETURNING r_success
         IF NOT r_success THEN
            LET g_prog = l_prog
            LET g_site = l_site
            RETURN r_success
         END IF            
         CALL s_axmt610_void_upd(l_xmeldocno)
              RETURNING r_success
         IF NOT r_success THEN
            LET g_prog = l_prog
            LET g_site = l_site
            RETURN r_success
         END IF
      ELSE
         #1.包裝單單頭
         DELETE FROM xmel_t
          WHERE xmdoent = g_enterprise
            AND xmdodocno = l_xmeldocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = l_xmeldocno
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            LET r_success = FALSE
            LET g_prog = l_prog
            LET g_site = l_site
            RETURN r_success
         END IF
         
         #3.包裝單明細
         DELETE FROM xmem_t
          WHERE xmement = g_enterprise
            AND xmemdocno = l_xmeldocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = l_xmeldocno
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            LET r_success = FALSE
            LET g_prog = l_prog
            LET g_site = l_site
            RETURN r_success
         END IF
         
         #3.單號處理
         IF NOT s_aooi200_del_docno(l_xmeldocno,l_xmeldocdt) THEN
            LET r_success = FALSE
            LET g_prog = l_prog
            LET g_site = l_site
            RETURN r_success
         END IF
         
         #刪除備註
         CALL s_aooi360_del('6',g_prog,l_xmeldocno,'','','','','','','','','4') RETURNING r_success
         IF NOT r_success THEN
            LET g_prog = l_prog
            LET g_site = l_site
            RETURN r_success
         END IF
                     
         #相關文件
         CALL g_pk_array.clear()
         LET g_pk_array[1].values = l_xmeldocno
         LET g_pk_array[1].column = 'xmdodocno'
         CALL cl_doc_remove()
      END IF
   END IF
   
   LET g_prog = l_prog
   LET g_site = l_site
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aicp360_success(p_xmdo)
DEFINE p_xmdo            type_g_detail_d

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
   
   LET g_detail3_d[g_success_cnt].xmdodocno = p_xmdo.xmdodocno
   LET g_detail3_d[g_success_cnt].xmdodocdt = p_xmdo.xmdodocdt
   LET g_detail3_d[g_success_cnt].xmdo007 = p_xmdo.xmdo007
   LET g_detail3_d[g_success_cnt].xmdo008 = p_xmdo.xmdo008
   LET g_detail3_d[g_success_cnt].xmdo009 = p_xmdo.xmdo009
   LET g_detail3_d[g_success_cnt].xmdo002 = p_xmdo.xmdo002
   LET g_detail3_d[g_success_cnt].xmdo003 = p_xmdo.xmdo003
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdo007)
        RETURNING g_detail3_d[g_success_cnt].xmdo007_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdo008)
        RETURNING g_detail3_d[g_success_cnt].xmdo008_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdo009)
        RETURNING g_detail3_d[g_success_cnt].xmdo009_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmdo002)
        RETURNING g_detail3_d[g_success_cnt].xmdo002_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmdo003)
        RETURNING g_detail3_d[g_success_cnt].xmdo003_desc
   
   LET g_success_cnt = g_success_cnt +  1
END FUNCTION

PRIVATE FUNCTION aicp360_fail(p_xmdo,p_xmdosite)
DEFINE p_xmdo            type_g_detail_d
DEFINE p_xmdosite        LIKE xmdo_t.xmdosite
DEFINE l_i               LIKE type_t.num5

   IF g_bgjob = 'N' THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
          LET g_detail4_d[l_i].xmdodocno = p_xmdo.xmdodocno
          LET g_detail4_d[l_i].xmdodocdt = p_xmdo.xmdodocdt
          LET g_detail4_d[l_i].xmdo007 = p_xmdo.xmdo007
          LET g_detail4_d[l_i].xmdo008 = p_xmdo.xmdo008
          LET g_detail4_d[l_i].xmdo009 = p_xmdo.xmdo009
          LET g_detail4_d[l_i].xmdo002 = p_xmdo.xmdo002
          LET g_detail4_d[l_i].xmdo003 = p_xmdo.xmdo003
          LET g_detail4_d[l_i].xmdo055 = p_xmdo.xmdo055
          LET g_detail4_d[l_i].xmdosite = p_xmdosite
         
          #錯誤訊息
          LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
         
          #說明
          CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdo007)
               RETURNING g_detail4_d[l_i].xmdo007_desc
          CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdo008)
               RETURNING g_detail4_d[l_i].xmdo008_desc
          CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdo009)
               RETURNING g_detail4_d[l_i].xmdo009_desc
          CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdo002)
               RETURNING g_detail4_d[l_i].xmdo002_desc
          CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdo003)
               RETURNING g_detail4_d[l_i].xmdo003_desc
          CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdosite)
               RETURNING g_detail4_d[l_i].xmdosite_desc
      END FOR
      
      LET g_fail_cnt = g_errcollect.getLength()
   END IF
   
END FUNCTION

#create_temp_table
PRIVATE FUNCTION aicp360_create_temp_table()
   
   DROP TABLE aicp360_tmp;
   CREATE TEMP TABLE aicp360_tmp( 
       sel          VARCHAR(1),
       xmdodocno    VARCHAR(20), 
       xmdodocdt    DATE,
       xmdo002      VARCHAR(20),
       xmdo003      VARCHAR(10),
       xmdo007      VARCHAR(10),
       xmdo008      VARCHAR(10),
       xmdo009      VARCHAR(10),
       xmdoownid    VARCHAR(20),
       xmdocrtid    VARCHAR(20),
       xmdo056      VARCHAR(10),
       xmdo055      VARCHAR(20)
       );
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp360_sel()
  #LET g_aicp360_sel = "xmdoent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp360_sel = "xmdoent = ",g_enterprise,cl_sql_add_filter("xmdo_t"),     #161231-00013#1 add
                       " AND xmdosite = '",g_site,"'",
                       " AND xmdo056 IS NOT NULL",   #多角代碼
                       " AND xmdo055 IS NOT NULL",   #多角序號
                       " AND xmdo054 = 'Y'",         #多角貿易已拋轉
                       " AND xmdostus = 'Y'",
                       " AND EXISTS (SELECT 1 ",
                       "               FROM icaa_t,icab_t",
                       "              WHERE icaaent = icabent AND icabent = ",g_enterprise,
                       "                AND icaa001 = icab001 AND icab001 = xmdo056",
                       "                AND icab003 = '",g_site,"'",
                       "                AND (icaa003 = '1' OR (icaa003 = '2' AND icaa014 = '2'))",
                       "                AND (",
                                             #正拋
                       "                     (icaa014 = '1' AND icab002 = 0)",
                                             #逆拋
                       "                     OR (icaa014 = '2' AND icab002 = (SELECT MAX(icab002)",
                       "                                                        FROM icab_t",
                       "                                                       WHERE icabent = ",g_enterprise,
                       "                                                         AND icab001 = xmdo056))",
                       "                    )",
                       "            )",
                       
                       #1:出貨通知單,#2:出貨單
                       " AND (xmdo004 IN ('1','2') ",
                       "      AND EXISTS (SELECT 1",
                       "                    FROM xmdp_t,xmda_t a",
                       "                         LEFT OUTER JOIN xmda_t b ON b.xmdaent = a.xmdaent AND b.xmda031 = a.xmda031",
                       "                         LEFT OUTER JOIN pmdl_t c ON c.pmdlent = a.xmdaent AND c.pmdl031 = a.xmda031",
                       "                   WHERE xmdpent = a.xmdaent AND a.xmdaent = ",g_enterprise,
                       "                     AND xmdpdocno = xmdodocno",
                       "                     AND xmdpseq = (SELECT MIN(xmdpseq) FROM xmdp_t",
                       "                                     WHERE xmdpent = ",g_enterprise,
                       "                                       AND xmdpdocno = xmdodocno",
                       "                                       AND xmdp003 IS NOT NULL)",
                       "                     AND xmdp003 = a.xmdadocno",
                       "                     AND ((b.xmda006 IN ('2','7') AND b.xmdasite = (SELECT icab003 FROM icab_t",   #訂單：2:銷售多角,7:代採購出貨
                       "                                                                     WHERE icabent = ",g_enterprise,
                       "                                                                       AND icab001 = xmdo056",
                       "                                                                       AND icab002 = 0)) ",
                       "                       OR (c.pmdl006 IN ('2','3') AND c.pmdlsite = (SELECT icab003 FROM icab_t", #採購：2:代採購,3:代採購指定供應商
                       "                                                                     WHERE icabent = ",g_enterprise,
                       "                                                                       AND icab001 = xmdo056",
                       "                                                                       AND icab002 = 0)))",
                       "                 )",
                       "     )"
                       
END FUNCTION

#end add-point
 
{</section>}
 
