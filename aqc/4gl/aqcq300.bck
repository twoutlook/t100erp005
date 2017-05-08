#該程式已解開Section, 不再透過樣板產出!
{<section id="aqcq300.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000034
#+ 
#+ Filename...: aqcq300
#+ Description: 品質檢驗記錄查詢
#+ Creator....: 01996(2014/07/28)
#+ Modifier...: 01996(2014/07/28) -SD/PR- 01996
#+ Buildtype..: 應用 q01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aqcq300.global" >}

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#160406-00009#1  2016/04/19 By xujing 不良率相关调整
#160407-00042#1  2016/04/18 By xujing 第二个单身填充前进行清空
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_qcba_d RECORD
   qcba005 LIKE qcba_t.qcba005, 
   qcba005_desc LIKE type_t.chr500, 
   qcba010 LIKE qcba_t.qcba010, 
   qcba010_desc LIKE type_t.chr80, 
   qcba010_desc_desc LIKE type_t.chr80, 
   qcba014 LIKE qcba_t.qcba014, 
   qcba000 LIKE qcba_t.qcba000, 
   qcba024 LIKE qcba_t.qcba024, 
   qcba024_desc LIKE type_t.chr500, 
   qcba022 LIKE qcba_t.qcba022, 
   qcbadocno LIKE qcba_t.qcbadocno, 
   qcba001 LIKE qcba_t.qcba001
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_qcba_d            DYNAMIC ARRAY OF type_g_qcba_d
DEFINE g_qcba_d_t          type_g_qcba_d
 
 
 
 
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
TYPE type_g_qcba_m   RECORD
         qcba005_sel LIKE type_t.chr1,
         qcba010_sel LIKE type_t.chr1,
         qcba014_sel LIKE type_t.chr1,
         qcba024_sel LIKE type_t.chr1,
         qcba000_sel LIKE type_t.chr1,
         qcba022_sel LIKE type_t.chr1,
         qcbadocno_sel LIKE type_t.chr1,
         qcba001_sel LIKE type_t.chr1
                 END RECORD
DEFINE g_qcba_m   type_g_qcba_m
 TYPE type_g_qcba2_d RECORD
       qcba0052 LIKE type_t.chr80, 
   qcba0052_desc LIKE type_t.chr80, 
   qcba0102 LIKE type_t.chr80, 
   qcba0102_desc LIKE type_t.chr80, 
   qcba0102_desc_desc LIKE type_t.chr80, 
   qcba0122 LIKE qcba_t.qcba012, 
   qcba0142 LIKE type_t.chr80, 
   qcba0002 LIKE type_t.chr80, 
   qcba0242 LIKE type_t.chr80, 
   qcba0242_desc LIKE type_t.chr80, 
   qcba0222 LIKE type_t.chr80, 
   qcbadocno2 LIKE type_t.chr80, 
   qcba0012 LIKE type_t.chr80, 
   qcba0172 LIKE qcba_t.qcba017, 
   qcba0232 LIKE qcba_t.qcba023, 
   qcba0272 LIKE qcba_t.qcba027, 
   l_bad LIKE type_t.num15_3      #160406-00009#1 
       END RECORD
DEFINE g_qcba2_d     DYNAMIC ARRAY OF type_g_qcba2_d
DEFINE g_qcba2_d_t   type_g_qcba2_d
DEFINE l_ac2         LIKE type_t.num5
DEFINE g_detail_cnt2          LIKE type_t.num5
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aqcq300.main" >}
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
   DECLARE aqcq300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE aqcq300_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aqcq300_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aqcq300 WITH FORM cl_ap_formpath("aqc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aqcq300_init()   
 
      #進入選單 Menu (="N")
      CALL aqcq300_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aqcq300
      
   END IF 
   
   CLOSE aqcq300_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aqcq300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aqcq300_init()
 
   #add-point:init段define
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
      CALL cl_set_combo_scc('b_qcba000','5056') 
   CALL cl_set_combo_scc('b_qcba022','5072') 
  
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc_part('b_qcba000','5056','1,2,3,4,5')
   CALL cl_set_combo_scc_part('qcba0002','5056','1,2,3,4,5') 
   CALL cl_set_combo_scc('qcba022','5072') 
   CALL cl_set_combo_scc('qcba0222','5072') 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcq300_ui_dialog() 
   {<Local define>}
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   {</Local define>}
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
   LET g_qcba_m.qcba005_sel = 'Y'
   LET g_qcba_m.qcba010_sel = 'Y'
   LET g_qcba_m.qcba014_sel = 'Y'
   LET g_qcba_m.qcba024_sel = 'Y'
   LET g_qcba_m.qcba000_sel = 'Y'
   LET g_qcba_m.qcba022_sel = 'Y'
   LET g_qcba_m.qcbadocno_sel = 'N'
   LET g_qcba_m.qcba001_sel = 'N'
   CALL aqcq300_set_visible()
#   CALL aqcq300_construct()

   #end add-point
 
   
   CALL aqcq300_b_fill()
  
   WHILE li_exit = FALSE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT BY NAME g_qcba_m.qcba005_sel,g_qcba_m.qcba010_sel,g_qcba_m.qcba014_sel,
                       g_qcba_m.qcba024_sel,g_qcba_m.qcba000_sel,g_qcba_m.qcba022_sel,
                       g_qcba_m.qcbadocno_sel,g_qcba_m.qcba001_sel  ATTRIBUTE(WITHOUT DEFAULTS)
#            ON CHANGE qcba005_sel
#               CALL aqcq300_set_visible()
#               CALL aqcq300_b_fill()
#               CALL ui.interface.refresh()
#            ON CHANGE qcba010_sel
#               CALL aqcq300_set_visible()   
#               CALL aqcq300_b_fill()
#               CALL ui.interface.refresh()
#            ON CHANGE qcba014_sel
#               CALL aqcq300_set_visible()
#               CALL aqcq300_b_fill()
#               CALL ui.interface.refresh()
#            ON CHANGE qcba024_sel
#               CALL aqcq300_set_visible()    
#               CALL aqcq300_b_fill()
#               CALL ui.interface.refresh()
#            ON CHANGE qcba000_sel
#               CALL aqcq300_set_visible()
#               CALL aqcq300_b_fill()
#               CALL ui.interface.refresh()
#            ON CHANGE qcba022_sel
#               CALL aqcq300_set_visible()   
#               CALL aqcq300_b_fill()
#               CALL ui.interface.refresh()
#            ON CHANGE qcbadocno_sel
#               CALL aqcq300_set_visible()
#               CALL aqcq300_b_fill()
#               CALL ui.interface.refresh()
#            ON CHANGE qcba001_sel
#               CALL aqcq300_set_visible()
#               CALL aqcq300_b_fill()   
#               CALL ui.interface.refresh()
         END INPUT              
         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc ON qcba005,qcba010,qcba014,qcba024,qcbadocno,qcba001,qcba022
             BEFORE CONSTRUCT
             
             ON ACTION controlp INFIELD qcba005
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_qcba005()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO qcba005  #顯示到畫面上
          
                NEXT FIELD qcba005
                
             ON ACTION controlp INFIELD qcba010
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_qcba010()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO qcba010  #顯示到畫面上
          
                NEXT FIELD qcba010
                
             ON ACTION controlp INFIELD qcba024
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_qcba024()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO qcba024  #顯示到畫面上
          
                NEXT FIELD qcba024
                
              ON ACTION controlp INFIELD qcbadocno
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_qcbadocno()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO qcbadocno  #顯示到畫面上
          
                NEXT FIELD qcbadocno
                
              ON ACTION controlp INFIELD qcba001
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_qcba001_1()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO qcba001  #顯示到畫面上
          
                NEXT FIELD qcba001             
          END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_qcba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_qcba_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aqcq300_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_qcba2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
 
               #add-point:input段before row
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
      
         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog

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
            IF g_qcba_m.qcba005_sel = 'N' AND g_qcba_m.qcba010_sel = 'N' AND g_qcba_m.qcba014_sel = 'N' AND 
               g_qcba_m.qcba024_sel = 'N' AND g_qcba_m.qcba000_sel = 'N' AND g_qcba_m.qcba022_sel = 'N' AND
               g_qcba_m.qcbadocno_sel = 'N' AND g_qcba_m.qcba001_sel = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00071'
               LET g_errparam.extend = ' '
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD qcba005_sel
            END IF
         
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
        
            LET g_wc2 = " 1=1"
 
            #儲存WC資訊
            CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
            CALL aqcq300_b_fill()
      
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         ON ACTION datarefresh   # 重新整理
            CALL aqcq300_b_fill()
 
         #+ 此段落由子樣板qs19產生
         #有關於sel欄位選取的action段落
         #選擇全部
#         ON ACTION selall
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
#            FOR li_idx = 1 TO g_qcba_d.getLength()
#               LET g_qcba_d[li_idx].sel = "Y"
#            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
#         ON ACTION selnone
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
#            FOR li_idx = 1 TO g_qcba_d.getLength()
#               LET g_qcba_d[li_idx].sel = "N"
#            END FOR
# 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
#         ON ACTION sel
#            FOR li_idx = 1 TO g_qcba_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_qcba_d[li_idx].sel = "Y"
#               END IF
#            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
#         ON ACTION unsel
#            FOR li_idx = 1 TO g_qcba_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_qcba_d[li_idx].sel = "N"
#               END IF
#            END FOR
 
            #add-point:ui_dialog段on action unsel
             ON ACTION exporttoexcel
                LET g_action_choice="exporttoexcel"
                IF cl_auth_chk_act("exporttoexcel") THEN
                   #browser
                   CALL g_export_node.clear()
#                   IF g_main_hidden = 1 THEN
#                      LET g_export_node[1] = base.typeInfo.create(g_browser)
#                      LET g_export_id[1]   = "s_browse"
#                      CALL cl_export_to_excel()
#                   #非browser
#                   ELSE
                      LET g_main_hidden = 0
                      LET g_export_node[1] = base.typeInfo.create(g_qcba_d)
                      LET g_export_id[1]   = "s_detail1"
                
                      #add-point:ON ACTION exporttoexcel
                      LET g_export_node[2] = base.typeInfo.create(g_qcba2_d)
                      LET g_export_id[2]   = "s_detail2"
                      #END add-point
                      CALL cl_export_to_excel_getpage()
                      CALL cl_export_to_excel()
#                   END IF
                END IF
            #end add-point
 
 
 
         #+ 此段落由子樣板qs16產生
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aqcq300_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
         
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
               CALL aqcq300_query()
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
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aqcq300_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   {</Local define>}
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   CALL aqcq300_set_visible()    
   CALL ui.interface.refresh()
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
 
   CALL g_qcba_d.clear()
 
   #add-point:陣列清空
   CALL g_qcba2_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"
 
   # b_fill段sql組成及FOREACH撰寫
   #+ 此段落由子樣板qs04產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET g_sql = "SELECT  UNIQUE '',qcba005,'',qcba010,'','',qcba014,qcba000,qcba024,'',qcba022, 
       qcbadocno,qcba001 FROM qcba_t",
 
 
               "",
               " WHERE qcbaent= ? AND 1=1 AND ", ls_wc
 
   LET g_sql = g_sql, cl_sql_add_filter("qcba_t"),
                      " ORDER BY qcba_t.qcbadocno"
 
   #add-point:b_fill段sql_after
#   LET g_sql = "SELECT  UNIQUE '',qcba005,pmaal004,qcba010,imaal003,imaal004,qcba011,qcba014,qcba000,qcba024,ooag011,qcba022,qcbadocno,qcba001 ",
#              " FROM qcba_t LEFT JOIN pmaal_t ON pmaalent = qcbaent AND pmaal001 = qcba005 AND pmaal002 = '",g_dlang,"'",
#              "             LEFT JOIN imaal_t ON imaalent = qcbaent AND imaal001 = qcba010 AND imaal002 = '",g_dlang,"'",
#              "             LEFT JOIN ooag_t  ON ooagent  = qcbaent AND ooag001  = qcba024",
#              " WHERE qcbaent = ",g_enterprise," AND qcbasite = '",g_site,"' AND ",ls_wc 
#   LET g_sql = g_sql, cl_sql_add_filter("qcba_t"),
#                      " ORDER BY qcba_t.qcbadocno"
   LET g_sql = "SELECT UNIQUE "
   IF g_qcba_m.qcba005_sel = 'Y' THEN
      LET g_sql = g_sql,"qcba005,pmaal004,"
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF
   
   IF g_qcba_m.qcba010_sel = 'Y' THEN
      LET g_sql = g_sql,"qcba010,imaal003,imaal004,"
   ELSE 
      LET g_sql = g_sql,"'','','',"
   END IF
    
   IF g_qcba_m.qcba014_sel = 'Y' THEN
      LET g_sql = g_sql,"qcba014,"
   ELSE
      LET g_sql = g_sql,"''," 
   END IF
   
   IF g_qcba_m.qcba000_sel = 'Y' THEN
      LET g_sql = g_sql,"qcba000,"
   ELSE
      LET g_sql = g_sql,"'',"
   END IF
   
   IF g_qcba_m.qcba024_sel = 'Y' THEN
      LET g_sql = g_sql,"qcba024,ooag011,"
   ELSE
      LET g_sql = g_sql,"'','',"
   END IF
   
   IF g_qcba_m.qcba022_sel = 'Y' THEN
      LET g_sql = g_sql,"qcba022,"
   ELSE
      LET g_sql = g_sql,"'',"
   END IF
   
   IF g_qcba_m.qcbadocno_sel = 'Y' THEN
      LET g_sql = g_sql,"qcbadocno,"
   ELSE
      LET g_sql = g_sql,"'',"
   END IF
   
   IF g_qcba_m.qcba001_sel = 'Y' THEN
      LET g_sql = g_sql,"qcba001"
   ELSE
      LET g_sql = g_sql,"''"
   END IF
   
   LET g_sql = g_sql," FROM qcba_t "
   
   IF g_qcba_m.qcba005_sel = 'Y' THEN
      LET g_sql = g_sql," LEFT JOIN pmaal_t ON pmaalent = qcbaent AND pmaal001 = qcba005 AND pmaal002 = '",g_dlang,"'"    
   END IF
   
   IF g_qcba_m.qcba010_sel = 'Y' THEN
      LET g_sql = g_sql," LEFT JOIN imaal_t ON imaalent = qcbaent AND imaal001 = qcba010 AND imaal002 = '",g_dlang,"'"
   END IF
   
   IF g_qcba_m.qcba024_sel = 'Y' THEN
      LET g_sql = g_sql," LEFT JOIN ooag_t  ON ooagent  = qcbaent AND ooag001  = qcba024" 
   END IF
   
   LET g_sql = g_sql," WHERE qcbaent = ? AND qcbasite = '",g_site,"' AND ",ls_wc," ORDER BY 1" 
   IF g_qcba_m.qcba005_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba005"
   END IF
   
   IF g_qcba_m.qcba010_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba010"
   END IF
   
   IF g_qcba_m.qcba014_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba014"
   END IF
   
   IF g_qcba_m.qcba024_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba024"
   END IF
   
   IF g_qcba_m.qcba000_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba000"
   END IF
   
   IF g_qcba_m.qcba022_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba022"
   END IF
   
   IF g_qcba_m.qcbadocno_sel = 'Y' THEN
      LET g_sql = g_sql,",qcbadocno"
   END IF
   
   IF g_qcba_m.qcba001_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba001"
   END IF

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aqcq300_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aqcq300_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_qcba_d[l_ac].qcba005,g_qcba_d[l_ac].qcba005_desc,g_qcba_d[l_ac].qcba010, 
       g_qcba_d[l_ac].qcba010_desc,g_qcba_d[l_ac].qcba010_desc_desc,g_qcba_d[l_ac].qcba014, 
       g_qcba_d[l_ac].qcba000,g_qcba_d[l_ac].qcba024,g_qcba_d[l_ac].qcba024_desc,g_qcba_d[l_ac].qcba022, 
       g_qcba_d[l_ac].qcbadocno,g_qcba_d[l_ac].qcba001
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
 
      CALL aqcq300_detail_show("'1'")
 
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
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
   CALL g_qcba_d.deleteElement(g_qcba_d.getLength())
 
   #add-point:陣列長度調整
   DISPLAY ARRAY g_qcba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #+ 此段落由子樣板qs06產生
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aqcq300_pb
 
 
 
 
   LET l_ac = 1
   CALL aqcq300_b_fill2()
 
      CALL aqcq300_filter_show('qcba005','b_qcba005')
   CALL aqcq300_filter_show('qcba010','b_qcba010')
   CALL aqcq300_filter_show('qcba014','b_qcba014')
   CALL aqcq300_filter_show('qcba000','b_qcba000')
   CALL aqcq300_filter_show('qcba024','b_qcba024')
   CALL aqcq300_filter_show('qcba022','b_qcba022')
   CALL aqcq300_filter_show('qcbadocno','b_qcbadocno')
   CALL aqcq300_filter_show('qcba001','b_qcba001')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aqcq300_b_fill2()
   {<Local define>}
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:b_fill2段define
   DEFINE l_qcbd009       LIKE qcbd_t.qcbd009
   DEFINE l_qcbd021       LIKE qcbd_t.qcbd021
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #+ 此段落由子樣板qs07產生
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空
   CALL g_qcba2_d.clear() #160407-00042#1 add
   LET g_sql = " SELECT qcba005,pmaal004,qcba010,imaal003,imaal004,qcba012,qcba014,qcba000,qcba024,ooag011,",
               "        qcba022,qcbadocno,qcba001,qcba017,qcba023,qcba027,''",
               "   FROM qcba_t LEFT JOIN pmaal_t ON pmaalent = qcbaent AND pmaal001 = qcba005 AND pmaal002 = '",g_dlang,"'",
               "               LEFT JOIN imaal_t ON imaalent = qcbaent AND imaal001 = qcba010 AND imaal002 = '",g_dlang,"'",
               "               LEFT JOIN ooag_t  ON ooagent  = qcbaent AND ooag001  = qcba024",
               "  WHERE qcbaent = ",g_enterprise," AND qcbasite = '",g_site,"' AND ",g_wc
   IF g_qcba_m.qcba005_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcba005) THEN
      LET g_sql = g_sql," AND qcba005 = '",g_qcba_d[l_ac].qcba005,"'"
   END IF
   
   IF g_qcba_m.qcba010_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcba010) THEN
      LET g_sql = g_sql," AND qcba010 = '",g_qcba_d[l_ac].qcba010,"'"
   END IF
  
   IF g_qcba_m.qcba014_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcba014) THEN
      LET g_sql = g_sql," AND qcba014 = '",g_qcba_d[l_ac].qcba014,"'"
   END IF
   
   IF g_qcba_m.qcba024_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcba024) THEN
      LET g_sql = g_sql," AND qcba024 = '",g_qcba_d[l_ac].qcba024,"'"
   END IF
   
   IF g_qcba_m.qcba000_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcba000) THEN
      LET g_sql = g_sql," AND qcba000 = '",g_qcba_d[l_ac].qcba000,"'"
   END IF
   
   IF g_qcba_m.qcba022_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcba022) THEN
      LET g_sql = g_sql," AND qcba022 = '",g_qcba_d[l_ac].qcba022,"'"
   END IF
   
   IF g_qcba_m.qcbadocno_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcbadocno) THEN
      LET g_sql = g_sql," AND qcbadocno = '",g_qcba_d[l_ac].qcbadocno,"'"
   END IF
   
   IF g_qcba_m.qcba001_sel = 'Y' AND NOT cl_null(g_qcba_d[l_ac].qcba001) THEN
      LET g_sql = g_sql," AND qcba001 = '",g_qcba_d[l_ac].qcba001,"'"
   END IF
   
   LET g_sql = g_sql," ORDER BY 1"
   
   IF g_qcba_m.qcba005_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba005"
   END IF
   
   IF g_qcba_m.qcba010_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba010"
   END IF
   
   IF g_qcba_m.qcba014_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba014"
   END IF
   
   IF g_qcba_m.qcba024_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba024"
   END IF
   
   IF g_qcba_m.qcba000_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba000"
   END IF
   
   IF g_qcba_m.qcba022_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba022"
   END IF
   
   IF g_qcba_m.qcbadocno_sel = 'Y' THEN
      LET g_sql = g_sql,",qcbadocno"
   END IF
   
   IF g_qcba_m.qcba001_sel = 'Y' THEN
      LET g_sql = g_sql,",qcba001"
   END IF

   PREPARE aqcq300_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aqcq300_pb2
   
   LET l_ac2 = 1
   FOREACH b_fill_curs2 INTO g_qcba2_d[l_ac2].qcba0052,g_qcba2_d[l_ac2].qcba0052_desc,g_qcba2_d[l_ac2].qcba0102,g_qcba2_d[l_ac2].qcba0102_desc,g_qcba2_d[l_ac2].qcba0102_desc_desc,
                             g_qcba2_d[l_ac2].qcba0122,g_qcba2_d[l_ac2].qcba0142,g_qcba2_d[l_ac2].qcba0002,g_qcba2_d[l_ac2].qcba0242,g_qcba2_d[l_ac2].qcba0242_desc,
                             g_qcba2_d[l_ac2].qcba0222,g_qcba2_d[l_ac2].qcbadocno2,g_qcba2_d[l_ac2].qcba0012,g_qcba2_d[l_ac2].qcba0172,g_qcba2_d[l_ac2].qcba0232,g_qcba2_d[l_ac2].qcba0272,g_qcba2_d[l_ac2].l_bad
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充
      SELECT MAX(qcbd009) INTO l_qcbd009 FROM qcbd_t WHERE qcbdent = g_enterprise 
         AND qcbddocno = g_qcba2_d[l_ac2].qcbadocno2
      SELECT MAX(qcbd021) INTO l_qcbd021 FROM qcbd_t WHERE qcbdent = g_enterprise
         AND qcbddocno = g_qcba2_d[l_ac2].qcbadocno2
      IF NOT cl_null(l_qcbd009) THEN
         LET g_qcba2_d[l_ac2].l_bad = l_qcbd021 / l_qcbd009
         LET g_qcba2_d[l_ac2].l_bad = g_qcba2_d[l_ac2].l_bad * 100 #160406-00009#1 add
      END IF
      #end add-point

 
      LET l_ac2 = l_ac2 + 1
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
   #end add-point
 
 
 
 
   #add-point:陣列長度調整

   CALL g_qcba2_d.deleteElement(g_qcba2_d.getLength())
   LET g_detail_cnt2 = l_ac2 - 1
   #add-point:陣列長度調整
   DISPLAY ARRAY g_qcba2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY
   #end add-point
 
 
 
   #add-point:單身填充後
   CLOSE b_fill_curs2
   FREE aqcq300_pb2
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq300.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aqcq300_detail_show(ps_page)
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

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcba_d[l_ac].qcba005
#            LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_qcba_d[l_ac].qcba005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcba_d[l_ac].qcba005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcba_d[l_ac].qcba024
#            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_qcba_d[l_ac].qcba024_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcba_d[l_ac].qcba024_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq300.filter" >}
#+ 此段落由子樣板qs13產生
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aqcq300_filter()
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
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON qcba005,qcba010,qcba014,qcba000,qcba024,qcba022,qcbadocno,qcba001 
 
                          FROM s_detail1[1].b_qcba005,s_detail1[1].b_qcba010,
                              s_detail1[1].b_qcba014,s_detail1[1].b_qcba000,s_detail1[1].b_qcba024,s_detail1[1].b_qcba022, 
                              s_detail1[1].b_qcbadocno,s_detail1[1].b_qcba001
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
                     DISPLAY aqcq300_filter_parser('qcba005') TO s_detail1[1].b_qcba005
            DISPLAY aqcq300_filter_parser('qcba010') TO s_detail1[1].b_qcba010
            DISPLAY aqcq300_filter_parser('qcba014') TO s_detail1[1].b_qcba014
            DISPLAY aqcq300_filter_parser('qcba000') TO s_detail1[1].b_qcba000
            DISPLAY aqcq300_filter_parser('qcba024') TO s_detail1[1].b_qcba024
            DISPLAY aqcq300_filter_parser('qcba022') TO s_detail1[1].b_qcba022
            DISPLAY aqcq300_filter_parser('qcbadocno') TO s_detail1[1].b_qcbadocno
            DISPLAY aqcq300_filter_parser('qcba001') TO s_detail1[1].b_qcba001
            
          ON ACTION controlp INFIELD b_qcba005
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = " 1=1 AND ",g_wc
             CALL q_qcba005()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_qcba005  #顯示到畫面上
 
             NEXT FIELD b_qcba005
             
          ON ACTION controlp INFIELD b_qcba010
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = " 1=1 AND ",g_wc
             CALL q_qcba010()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_qcba010  #顯示到畫面上
 
             NEXT FIELD b_qcba010
             
          ON ACTION controlp INFIELD b_qcba024
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = " 1=1 AND ",g_wc
             CALL q_qcba024()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_qcba024  #顯示到畫面上
 
             NEXT FIELD b_qcba024
             
           ON ACTION controlp INFIELD b_qcbadocno
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = " 1=1 AND ",g_wc
             CALL q_qcbadocno()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_qcbadocno  #顯示到畫面上
 
             NEXT FIELD b_qcbadocno
             
           ON ACTION controlp INFIELD b_qcba001
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = " 1=1 AND ",g_wc
             CALL q_qcba001_1()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_qcba001  #顯示到畫面上
 
             NEXT FIELD b_qcba001
 
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
 
      CALL aqcq300_filter_show('qcba005','b_qcba005')
   CALL aqcq300_filter_show('qcba010','b_qcba010')
   CALL aqcq300_filter_show('qcba014','b_qcba014')
   CALL aqcq300_filter_show('qcba000','b_qcba000')
   CALL aqcq300_filter_show('qcba024','b_qcba024')
   CALL aqcq300_filter_show('qcba022','b_qcba022')
   CALL aqcq300_filter_show('qcbadocno','b_qcbadocno')
   CALL aqcq300_filter_show('qcba001','b_qcba001')
 
   CALL aqcq300_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq300.filter_parser" >}
#+ 此段落由子樣板qs14產生
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aqcq300_filter_parser(ps_field)
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
 
{<section id="aqcq300.filter_show" >}
#+ 此段落由子樣板qs15產生
#+ 標題欄位顯示搜尋條件
PRIVATE FUNCTION aqcq300_filter_show(ps_field,ps_object)
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
   LET ls_condition = aqcq300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aqcq300.other_function" readonly="Y" >}

PRIVATE FUNCTION aqcq300_construct()
   CLEAR FORM
   CALL g_qcba_d.clear()
   CALL g_qcba2_d.clear()
   LET g_action_choice = ""
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc_filter TO NULL
   LET g_qryparam.state = 'c'
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       CONSTRUCT BY NAME g_wc ON qcba005,qcba010,qcba014,qcba024,qcbadocno,qcba001,qcba022
          BEFORE CONSTRUCT
          
          ON ACTION controlp INFIELD qcba005
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_qcba005()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO qcba005  #顯示到畫面上

             NEXT FIELD qcba005
             
          ON ACTION controlp INFIELD qcba010
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_qcba010()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO qcba010  #顯示到畫面上

             NEXT FIELD qcba010
             
          ON ACTION controlp INFIELD qcba024
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_qcba024()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO qcba024  #顯示到畫面上

             NEXT FIELD qcba024
             
           ON ACTION controlp INFIELD qcbadocno
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_qcbadocno()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO qcbadocno  #顯示到畫面上

             NEXT FIELD qcbadocno
             
           ON ACTION controlp INFIELD qcba001
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             CALL q_qcba001_1()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO qcba001  #顯示到畫面上

             NEXT FIELD qcba001             
       END CONSTRUCT
       
       ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN
   END IF
END FUNCTION

PRIVATE FUNCTION aqcq300_query()
DEFINE ls_wc   STRING   
   CLEAR FORM
   CALL g_qcba_d.clear()
   CALL g_qcba2_d.clear()
   
   LET ls_wc = g_wc
   CALL aqcq300_construct()
   
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aqcq300_b_fill()
      RETURN
   END IF
   
   CALL aqcq300_b_fill()
END FUNCTION

PRIVATE FUNCTION aqcq300_set_visible()
   CALL cl_set_comp_visible("b_qcba005,b_qcba005_desc,b_qcba010,b_qcba010_desc,b_qcba010_desc_desc,b_qcba014,b_qcba000,
                             b_qcba024,b_qcba024_desc,b_qcba022,b_qcbadocno,b_qcba001",TRUE)
   CALL cl_set_comp_visible("qcba0052,qcba0052_desc,qcba0102,qcba0102_desc,qcba0102_desc_desc,qcba0142,qcba0002,
                             qcba0242,qcba0242_desc,qcba0222,qcbadocno2,qcba0012",TRUE)
   IF g_qcba_m.qcba005_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcba0052,qcba0052_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcba005,b_qcba005_desc",FALSE)
   END IF
   
   IF g_qcba_m.qcba010_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcba0102,qcba0102_desc,qcba0102_desc_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcba010,b_qcba010_desc,b_qcba010_desc_desc",FALSE)
   END IF
   
   IF g_qcba_m.qcba014_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcba0142",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcba014",FALSE)
   END IF
   
   IF g_qcba_m.qcba024_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcba0242,qcba0242_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcba024,b_qcba024_desc",FALSE)
   END IF
   
   IF g_qcba_m.qcba000_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcba0002",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcba000",FALSE)
   END IF
   
   IF g_qcba_m.qcba022_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcba0222",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcba022",FALSE)
   END IF
   
   IF g_qcba_m.qcbadocno_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcbadocno2",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcbadocno",FALSE)
   END IF
   
   IF g_qcba_m.qcba001_sel = 'Y' THEN
      CALL cl_set_comp_visible("qcba0012",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_qcba001",FALSE)
   END IF
END FUNCTION

 
{</section>}
 
