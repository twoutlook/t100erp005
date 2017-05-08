#該程式已解開Section, 不再透過樣板產出!
{<section id="asfq006.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000028
#+ 
#+ Filename...: asfq006
#+ Description: 工單在制狀況查詢
#+ Creator....: 04226(2014/08/18)
#+ Modifier...: 04226(2014/08/20) -SD/PR- 05426
#+ Buildtype..: 應用 q01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="asfq006.global" >}
#160503-00030#8    2016/05/17   By dorislai   效能改善
#160518-00017#1    2016/05/24   By dorislai   將工單單身的串查功能拿掉(因為目前單身串查功能尚未完全完工)
#160518-00019#1    2016/05/24   By dorislai   修正工單單身，選擇項目，點兩下，無法勾選的問題
#161011-00028#1    2016/10/12   By liuym      隐藏第一个单身工单单号串查栏位
 
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
PRIVATE TYPE type_g_sfca_d RECORD
       
       sel LIKE type_t.chr1, 
   sfcadocno LIKE sfca_t.sfcadocno,
   prog_b_sfcadocno  STRING, #串查用到的列  
   sfca001 LIKE sfca_t.sfca001, 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_desc LIKE type_t.chr500, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_1 LIKE type_t.chr500, 
   sfca003 LIKE sfca_t.sfca003, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfcb003 LIKE sfcb_t.sfcb003, 
   sfcb003_desc LIKE type_t.chr500, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   sfcb011_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_sfca2_d RECORD
       sfcadocno LIKE sfca_t.sfcadocno, 
   sfca001 LIKE sfca_t.sfca001,
   prog_b_sfca001_1   STRING, #串查用到的列 
   sfaa002 LIKE sfaa_t.sfaa002, 
   sfaa002_1_desc LIKE type_t.chr500, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa010_1_desc LIKE type_t.chr500, 
   sfaa010_1_desc_1 LIKE type_t.chr500, 
   sfca003 LIKE sfca_t.sfca003, 
   sfaa019 LIKE sfaa_t.sfaa019, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfcb002 LIKE sfcb_t.sfcb002,
   sfcb003 LIKE sfcb_t.sfcb003, 
   sfcb003_1_desc LIKE type_t.chr500, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   sfcb011_1_desc LIKE type_t.chr500, 
   sfcb050 LIKE sfcb_t.sfcb050, 
   sfcb028 LIKE sfcb_t.sfcb028, 
   sfcb029 LIKE sfcb_t.sfcb029, 
   sfcb030 LIKE sfcb_t.sfcb030, 
   sfcb031 LIKE sfcb_t.sfcb031, 
   sfcb032 LIKE sfcb_t.sfcb032, 
   sfcb033 LIKE sfcb_t.sfcb033, 
   sfcb034 LIKE sfcb_t.sfcb034, 
   sfcb035 LIKE sfcb_t.sfcb035, 
   sfcb036 LIKE sfcb_t.sfcb036, 
   sfcb037 LIKE sfcb_t.sfcb037, 
   sfcb038 LIKE sfcb_t.sfcb038, 
   sfcb039 LIKE sfcb_t.sfcb039, 
   sfcb040 LIKE sfcb_t.sfcb040, 
   sfcb041 LIKE sfcb_t.sfcb041, 
   sfcb042 LIKE sfcb_t.sfcb042, 
   sfcb043 LIKE sfcb_t.sfcb043, 
   sfcb046 LIKE sfcb_t.sfcb046, 
   sfcb047 LIKE sfcb_t.sfcb047, 
   sfcb048 LIKE sfcb_t.sfcb048, 
   sfcb049 LIKE sfcb_t.sfcb049, 
   sfcb051 LIKE sfcb_t.sfcb051, 
   fmovein LIKE type_t.chr80, 
   fcheckin LIKE type_t.chr80, 
   lwork LIKE type_t.chr80, 
   lcheckout LIKE type_t.chr80, 
   lmoveout LIKE type_t.chr80,
   sfcb014 LIKE sfcb_t.sfcb014,
   sfcb015 LIKE sfcb_t.sfcb015,
   sfcb016 LIKE sfcb_t.sfcb016,
   sfcb018 LIKE sfcb_t.sfcb018,
   sfcb019 LIKE sfcb_t.sfcb019
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_sfca_d            DYNAMIC ARRAY OF type_g_sfca_d
DEFINE g_sfca_d_t          type_g_sfca_d
DEFINE g_sfca2_d     DYNAMIC ARRAY OF type_g_sfca2_d
DEFINE g_sfca2_d_t   type_g_sfca2_d
 
 
 
 
 
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
DEFINE g_qbe_hidden          LIKE type_t.num5
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數(Module Variable)
#查詢條件
 TYPE type_g_qbe RECORD
       sfaa003      LIKE type_t.chr1000,
       sfcadocno    LIKE type_t.chr1000,
       sfaadocdt    LIKE type_t.chr1000,
       sfaa002      LIKE type_t.chr1000,
       sfaa010      LIKE type_t.chr1000,
       sfca003      LIKE type_t.chr1000,
       sfaa019      LIKE type_t.chr1000,
       sfaa020      LIKE type_t.chr1000,
       sfaa017      LIKE type_t.chr1000,
       sfca001      LIKE type_t.chr1000,
       sfcb003      LIKE type_t.chr1000,
       sfcb011      LIKE type_t.chr1000,
       closed       LIKE type_t.chr1000
                    END RECORD
#單頭資料內容
 TYPE type_g_show RECORD
       l_sfcadocno  LIKE type_t.chr1,
       l_sfca001    LIKE type_t.chr1,
       l_sfaa019    LIKE type_t.chr1,
       l_sfaa020    LIKE type_t.chr1,
       l_sfaa010    LIKE type_t.chr1,
       l_sfcb003    LIKE type_t.chr1,
       l_sfcb004    LIKE type_t.chr1,
       l_sfcb011    LIKE type_t.chr1,
       l_sfaa002    LIKE type_t.chr1
                    END RECORD
DEFINE g_qbe        type_g_qbe
DEFINE g_show       type_g_show
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="asfq006.main" >}
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
   CALL cl_ap_init("asf","")
 
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
   DECLARE asfq006_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE asfq006_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq006_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq006 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq006_init()   
 
      #進入選單 Menu (="N")
      CALL asfq006_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq006
      
   END IF 
   
   CLOSE asfq006_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="asfq006.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asfq006_init()
 
   #add-point:init段define
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
     
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('sfaa003','4007')
   LET g_show.l_sfcadocno = 'Y'
   LET g_show.l_sfca001   = 'N'
   LET g_show.l_sfaa019   = 'N'
   LET g_show.l_sfaa020   = 'N'
   LET g_show.l_sfaa010   = 'N'
   LET g_show.l_sfcb003   = 'N'
   LET g_show.l_sfcb004   = 'N'
   LET g_show.l_sfcb011   = 'N'
   LET g_show.l_sfaa002   = 'N'
   #準備抓日期時間的sql
   #報工類型(sffb001) 工單單號(sffb005)
   LET g_sql = "SELECT sffb012,sffb013",
               "  FROM sffb_t",
               " WHERE sffbent = ",g_enterprise,
               "   AND sffb001 = ?",
               "   AND sffb005 = ?",
               "   AND sffb007 = ?",
               "   AND sffbstus = 'Y'",
               " ORDER BY sffb012,sffb013"
   PREPARE asfq006_pre FROM g_sql
   DECLARE asfq006_curs SCROLL CURSOR FOR asfq006_pre
   CALL cl_set_comp_visible("prog_b_sfcadocno",FALSE)  #161011-00028#1 add
   CALL cl_set_comp_visible("prog_b_sfca001_1",FALSE)   #161011-00028#1 add
   #end add-point
 
   CALL asfq006_default_search()
END FUNCTION
 
{</section>}
 
{<section id="asfq006.default_search" >}
PRIVATE FUNCTION asfq006_default_search()
 
   #預設查詢條件
   LET g_wc = cl_qbe_get_default_qryplan()
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asfq006.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfq006_ui_dialog() 
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
   #160518-00017#1-mark-(S)
#   #串查隐藏的列 20150424 By dujuan str
#      # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
#      CALL gfrm_curr.setFieldHidden('b_sfcadocno',TRUE) 
#      CALL gfrm_curr.setFieldHidden('prog_b_sfcadocno',FALSE) 
#      CALL gfrm_curr.setFieldHidden('b_sfca001_1',TRUE)
#      CALL gfrm_curr.setFieldHidden('prog_b_sfca001_1',FALSE)
#   #串查隐藏的列 20150424 By dujuan end
   #160518-00017#1-mark-(S)
   #end add-point
 
   
   CALL asfq006_b_fill()
  
   WHILE li_exit = FALSE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         CONSTRUCT BY NAME g_wc ON sfaa003,sfcadocno,sfaadocdt,
                                   sfaa002,sfaa010,  sfca003,
                                   sfaa019,sfaa020,  sfaa017,
                                   sfca001,sfcb003,  sfcb011

            AFTER FIELD sfaa003
               LET g_qbe.sfaa003 = GET_FLDBUF(sfaa003)

            AFTER FIELD sfcadocno
               LET g_qbe.sfcadocno = GET_FLDBUF(sfcadocno)

            AFTER FIELD sfaadocdt
               LET g_qbe.sfaadocdt = GET_FLDBUF(sfaadocdt)

            AFTER FIELD sfaa002
               LET g_qbe.sfaa002 = GET_FLDBUF(sfaa002)

            AFTER FIELD sfaa010
               LET g_qbe.sfaa010 = GET_FLDBUF(sfaa010)

            AFTER FIELD sfca003
               LET g_qbe.sfca003 = GET_FLDBUF(sfca003)

            AFTER FIELD sfaa019
               LET g_qbe.sfaa019 = GET_FLDBUF(sfaa019)

            AFTER FIELD sfaa020
               LET g_qbe.sfaa020 = GET_FLDBUF(sfaa020)

            AFTER FIELD sfaa017
               LET g_qbe.sfaa017 = GET_FLDBUF(sfaa017)

            AFTER FIELD sfca001
               LET g_qbe.sfca001 = GET_FLDBUF(sfca001)

            AFTER FIELD sfcb003
               LET g_qbe.sfcb003 = GET_FLDBUF(sfcb003)

            AFTER FIELD sfcb011
               LET g_qbe.sfcb011 = GET_FLDBUF(sfcb011)

            ON ACTION controlp INFIELD sfcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfcadocno()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfcadocno    #顯示到畫面上
               NEXT FIELD sfcadocno                       #返回原欄位

            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001_2()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa002      #顯示到畫面上  
               NEXT FIELD sfaa002                         #返回原欄位  

            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa010      #顯示到畫面上
               NEXT FIELD sfaa010                         #返回原欄位

            ON ACTION controlp INFIELD sfaa017
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_1()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfaa017      #顯示到畫面上
               NEXT FIELD sfaa017                         #返回原欄位

            ON ACTION controlp INFIELD sfcb003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '221'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfcb003      #顯示到畫面上
               NEXT FIELD sfcb003                         #返回原欄位

            ON ACTION controlp INFIELD sfcb011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ecaa001_1()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfcb011      #顯示到畫面上
               NEXT FIELD sfcb011                         #返回原欄位

         END CONSTRUCT

         INPUT BY NAME g_qbe.closed, g_show.l_sfcadocno, g_show.l_sfca001,
                       g_show.l_sfaa019, g_show.l_sfaa020, g_show.l_sfaa010,
                       g_show.l_sfcb003, g_show.l_sfcb004, g_show.l_sfcb011,
                       g_show.l_sfaa002

            AFTER INPUT
               IF g_show.l_sfcadocno = 'N' AND g_show.l_sfca001 = 'N' AND g_show.l_sfaa019 = 'N' AND 
                  g_show.l_sfaa020 = 'N' AND   g_show.l_sfaa010 = 'N' AND g_show.l_sfcb003 = 'N' AND 
                  g_show.l_sfcb004 = 'N' AND   g_show.l_sfcb011 = 'N' AND g_show.l_sfaa002 = 'N' THEN

                  #單頭資料內容區塊裡面的資料必須要有一個欄位打勾！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00415'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD l_sfcadocno
               END IF
         END INPUT
         #end add-point
 
         #add-point:construct段落

         #end add-point
     
         DISPLAY ARRAY g_sfca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_sfca_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL asfq006_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
         DISPLAY ARRAY g_sfca2_d TO s_detail2.*
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
            IF cl_null(g_qbe.closed) THEN
                  LET g_qbe.closed = 'N'
               END IF
               IF cl_null(g_show.l_sfcadocno) THEN
                  LET g_show.l_sfcadocno = 'N'
               END IF
               IF cl_null(g_show.l_sfca001) THEN
                  LET g_show.l_sfca001 = 'N'
               END IF
               IF cl_null(g_show.l_sfaa019) THEN
                  LET g_show.l_sfaa019 = 'N'
               END IF
               IF cl_null(g_show.l_sfaa020) THEN
                  LET g_show.l_sfaa020 = 'N'
               END IF
               IF cl_null(g_show.l_sfaa010) THEN
                  LET g_show.l_sfaa010 = 'N'
               END IF
               IF cl_null(g_show.l_sfcb003) THEN
                  LET g_show.l_sfcb003 = 'N'
               END IF
               IF cl_null(g_show.l_sfcb004) THEN
                  LET g_show.l_sfcb004 = 'N'
               END IF
               IF cl_null(g_show.l_sfcb011) THEN
                  LET g_show.l_sfcb011 = 'N'
               END IF
               IF cl_null(g_show.l_sfaa002) THEN
                  LET g_show.l_sfaa002 = 'N'
               END IF
               IF g_show.l_sfcadocno = 'N' AND g_show.l_sfca001 = 'N' AND
                  g_show.l_sfaa019 = 'N' AND g_show.l_sfaa020 = 'N' AND
                  g_show.l_sfaa010 = 'N' AND g_show.l_sfcb003 = 'N' AND
                  g_show.l_sfcb004 = 'N' AND g_show.l_sfcb011 = 'N' AND
                  g_show.l_sfaa002 = 'N' THEN
                  LET g_show.l_sfcadocno = 'Y'
               END IF
               DISPLAY BY NAME g_qbe.closed,g_show.l_sfcadocno,g_show.l_sfca001,
                               g_show.l_sfaa019,g_show.l_sfaa020,g_show.l_sfaa010,
                               g_show.l_sfcb003,g_show.l_sfcb004,g_show.l_sfcb011,
                               g_show.l_sfaa002
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
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            LET g_wc2 = " 1=1"
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
            #儲存WC資訊
            CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
            LET g_qbe.sfaa003 = GET_FLDBUF(sfaa003)
            LET g_qbe.sfcadocno = GET_FLDBUF(sfcadocno)
            LET g_qbe.sfaadocdt = GET_FLDBUF(sfaadocdt)
            LET g_qbe.sfaa002 = GET_FLDBUF(sfaa002)
            LET g_qbe.sfaa010 = GET_FLDBUF(sfaa010)
            LET g_qbe.sfca003 = GET_FLDBUF(sfca003)
            LET g_qbe.sfaa019 = GET_FLDBUF(sfaa019)
            LET g_qbe.sfaa020 = GET_FLDBUF(sfaa020)
            LET g_qbe.sfaa017 = GET_FLDBUF(sfaa017)
            LET g_qbe.sfca001 = GET_FLDBUF(sfca001)
            LET g_qbe.sfcb003 = GET_FLDBUF(sfcb003)
            LET g_qbe.sfcb011 = GET_FLDBUF(sfcb011)
            CALL asfq006_b_fill()
            DISPLAY BY NAME g_qbe.sfaa003,g_qbe.sfcadocno,g_qbe.sfaadocdt,
                            g_qbe.sfaa002,g_qbe.sfaa010,g_qbe.sfca003,
                            g_qbe.sfaa019,g_qbe.sfaa020,g_qbe.sfaa017,
                            g_qbe.sfca001,g_qbe.sfcb003,g_qbe.sfcb011
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL asfq006_b_fill()
            END IF
 
         ON ACTION qbe_select
            LET ls_wc = ""
            CALL cl_qbe_list("c") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL asfq006_b_fill()
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         ON ACTION datarefresh   # 重新整理
            CALL asfq006_b_fill()
            
         ON ACTION qbehidden   #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         #+ 此段落由子樣板qs19產生
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_sfca_d.getLength()
               LET g_sfca_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_sfca_d.getLength()
               LET g_sfca_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_sfca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfca_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_sfca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfca_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
 
 
 
         #+ 此段落由子樣板qs16產生
         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfq006_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
         
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
         #160518-00019#1-add-(S)
         ON ACTION modify_detail
            FOR li_idx = 1 TO g_sfca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF g_sfca_d[li_idx].sel = 'Y' THEN
                     LET g_sfca_d[li_idx].sel = 'N'
                  ELSE
                     LET g_sfca_d[li_idx].sel = 'Y'
                  END IF
               END IF
            END FOR
         #160518-00019#1-add-(E)
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="asfq006.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq006_b_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   #add-point:b_fill段define
   DEFINE l_order_sql     STRING
   DEFINE l_sql           STRING
   DEFINE l_stus          STRING
   DEFINE l_flag          LIKE type_t.chr1
   #end add-point
 
   #add-point:b_fill段sql_before
   CALL asfq006_comp_visible()
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
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
 
   CALL g_sfca_d.clear()
 
   #add-point:陣列清空
   CALL g_sfca2_d.clear()
   CLEAR FORM
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"
 
   # b_fill段sql組成及FOREACH撰寫
   #+ 此段落由子樣板qs04產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET g_sql = "SELECT  UNIQUE '',sfcadocno,sfca001,'','','','','',sfca003,'','','','','','','' FROM sfca_t", 
 
 
#table2
               " LEFT JOIN sfcb_t ON sfcbent = sfcaent AND sfcadocno = sfcbdocno",
 
               "",
               " WHERE sfcaent=? AND sfcadocno=? AND ", ls_wc
 
   LET g_sql = g_sql, cl_sql_add_filter("sfca_t"),
                      " ORDER BY sfca_t.sfca001"
 
   #add-point:b_fill段sql_after
   #依照勾選的欄位組sql
   LET l_sql = ''
   LET g_sql = " "
   LET l_order_sql = " "

   #工單單號
   IF g_show.l_sfcadocno = 'Y' THEN
      LET g_sql = g_sql,",sfcadocno"
      LET l_sql = l_sql,",sfcadocno"
      LET l_order_sql = l_order_sql,"sfcadocno"
   ELSE
      LET g_sql = g_sql,",''"
      LET l_sql = l_sql,",''"
      LET l_order_sql = l_order_sql,"''"
   END IF

   #Run Card
   IF g_show.l_sfca001 = 'Y' THEN
      LET g_sql = g_sql,",sfca001"
      LET l_sql = l_sql,",sfca001"
      LET l_order_sql = l_order_sql,",sfca001"
   ELSE
      LET g_sql = g_sql,",''"
      LET l_sql = l_sql,",''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #生管人員
   IF g_show.l_sfaa002 = 'Y' THEN
      #160503-00030#8-mod-(S)
#      LET g_sql = g_sql,",sfaa002,''"
#      LET l_sql = l_sql,",sfaa002,''"
      LET g_sql = g_sql,",sfaa002,(SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=sfaa002) ooag011 "
      LET l_sql = l_sql,",sfaa002,(SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=sfaa002) ooag011 "
      #160503-00030#8-mod-(E)
      LET l_order_sql = l_order_sql,",sfaa002"
   ELSE
      LET g_sql = g_sql,",'',''"
      LET l_sql = l_sql,",'',''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #生產料號
   IF g_show.l_sfaa010 = 'Y' THEN
      #160503-00030#8-mod-(S)
#      LET g_sql = g_sql,",sfaa010,'',''"
#      LET l_sql = l_sql,",sfaa010,'',''"
      LET g_sql = g_sql,",sfaa010,(SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003,",
                        "         (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004 "
      LET l_sql = l_sql,",sfaa010,(SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003,",
                        "         (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004 "
      #160503-00030#8-mod-(E)
      LET l_order_sql = l_order_sql,",sfaa010"
   ELSE
      LET g_sql = g_sql,",'','',''"
      LET l_sql = l_sql,",'','',''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #生產數量
   LET g_sql = g_sql,",(SELECT SUM (a2.sfca003)",
                     "    FROM sfca_t a2",
                     "   WHERE a2.sfcadocno = a1.sfcadocno",
                     "     AND a2.sfca001 = a1.sfca001 ) sfca003"
   LET l_sql = l_sql,",SUM(sfca003)"

   #預計開工日
   IF g_show.l_sfaa019 = 'Y' THEN
      LET g_sql = g_sql,",sfaa019"
      LET l_sql = l_sql,",sfaa019"
      LET l_order_sql = l_order_sql,",sfaa019"
   ELSE
      LET g_sql = g_sql,",''"
      LET l_sql = l_sql,",''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #預計完工日
   IF g_show.l_sfaa020 = 'Y' THEN
      LET g_sql = g_sql,",sfaa020"
      LET l_sql = l_sql,",sfaa020"
      LET l_order_sql = l_order_sql,",sfaa020"
   ELSE
      LET g_sql = g_sql,",''"
      LET l_sql = l_sql,",''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #作業編號
   IF g_show.l_sfcb003 = 'Y' THEN
      #160503-00030#8-mod-(S)
#      LET g_sql = g_sql,",sfcb003,''"
#      LET l_sql = l_sql,",sfcb003,''"
      LET g_sql = g_sql,",sfcb003,(SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=sfcb003 AND oocql003='"||g_dlang||"') oocql004 "
      LET l_sql = l_sql,",sfcb003,(SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=sfcb003 AND oocql003='"||g_dlang||"') oocql004 "
      #160503-00030#8-mod-(E)
      LET l_order_sql = l_order_sql,",sfcb003"
   ELSE
      LET g_sql = g_sql,",'',''"
      LET l_sql = l_sql,",'',''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #作業序
   IF g_show.l_sfcb004 = 'Y' THEN
      LET g_sql = g_sql,",sfcb004"
      LET l_sql = l_sql,",sfcb004"
      LET l_order_sql = l_order_sql,",sfcb004"
   ELSE
      LET g_sql = g_sql,",''"
      LET l_sql = l_sql,",''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #工作站
   IF g_show.l_sfcb011 = 'Y' THEN
      #160503-00030#8-mod-(S)
#      LET g_sql = g_sql,",sfcb011,''"
#      LET l_sql = l_sql,",sfcb011,''"
      LET g_sql = g_sql,",sfcb011,(SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001=sfcb011) ecaa002 "
      LET l_sql = l_sql,",sfcb011,(SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001=sfcb011) ecaa002 "
      #160503-00030#8-mod-(E)
      LET l_order_sql = l_order_sql,",sfcb011"
   ELSE
      LET g_sql = g_sql,",'',''"
      LET l_sql = l_sql,",'',''"
      LET l_order_sql = l_order_sql,",''"
   END IF

   #含已結案工單
   IF g_qbe.closed = 'Y' THEN
      LET l_stus = " AND (sfaastus = 'Y' OR sfaastus = 'F'",
                      "  OR  sfaastus = 'C' OR sfaastus = 'E'",
                      "  OR  sfaastus = 'M')"
   ELSE
      LET l_stus = " AND (sfaastus = 'Y' OR sfaastus = 'F')"
   END IF

   #組撈單頭的sql
   LET g_sql = "SELECT UNIQUE 'N'",l_sql,
               "  FROM (",
               " SELECT UNIQUE 'N'",g_sql,
               "  FROM sfaa_t,sfca_t a1",
               "  LEFT JOIN sfcb_t ON a1.sfcaent = sfcbent",
               "                  AND a1.sfcadocno = sfcbdocno",
               "                  AND a1.sfcasite = sfcbsite",
               "                  AND a1.sfca001 = sfcb001",
               " WHERE sfaaent = sfcaent",
               "   AND sfaadocno = sfcadocno",
               "   AND sfaaent = ?",
               "   AND sfcasite = '",g_site,"'",
               "   AND ",ls_wc,l_stus,")"
   LET g_sql = g_sql," GROUP BY ",l_order_sql,
                     " ORDER BY ",l_order_sql

   LET l_flag = 'N'
   DISPLAY 'g_sql = ',g_sql
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq006_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq006_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_sfca_d[l_ac].sel,g_sfca_d[l_ac].sfcadocno,g_sfca_d[l_ac].sfca001,g_sfca_d[l_ac].sfaa002, 
       g_sfca_d[l_ac].sfaa002_desc,g_sfca_d[l_ac].sfaa010,g_sfca_d[l_ac].sfaa010_desc,g_sfca_d[l_ac].sfaa010_desc_1, 
       g_sfca_d[l_ac].sfca003,g_sfca_d[l_ac].sfaa019,g_sfca_d[l_ac].sfaa020,g_sfca_d[l_ac].sfcb003,g_sfca_d[l_ac].sfcb003_desc, 
       g_sfca_d[l_ac].sfcb004,g_sfca_d[l_ac].sfcb011,g_sfca_d[l_ac].sfcb011_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充
      LET l_flag = 'Y'
      #160518-00017#1-mark-(S)
#      #20150424 By dujuan str
#       #+ b_fill段欄位串查功能設定 
#       LET g_hyper_url = asfq006_get_hyper_data("prog_b_sfcadocno")
#       LET g_sfca_d[l_ac].prog_b_sfcadocno = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfca_d[l_ac].sfcadocno), 
#                                             "</a>"
#      # #20150424 By dujuan end
      #160518-00017#1-mark-(E)
      #end add-point
 
      CALL asfq006_detail_show("'1'")
 
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
 
   CALL g_sfca_d.deleteElement(g_sfca_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #+ 此段落由子樣板qs06產生
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE asfq006_pb
 
   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 100
      LET g_errparam.popup  = TRUE
      CALL cl_err() 
   ELSE
      LET l_ac = 1
      CALL asfq006_b_fill2()
   END IF
   
   CALL asfq006_filter_show('sfcadocno','b_sfcadocno')
   CALL asfq006_filter_show('sfca001','b_sfca001')
   CALL asfq006_filter_show('sfaa002','b_sfaa002')
   CALL asfq006_filter_show('sfaa010','b_sfaa010')
   CALL asfq006_filter_show('sfca003','b_sfca003')
   CALL asfq006_filter_show('sfaa019','b_sfaa019')
   CALL asfq006_filter_show('sfaa020','b_sfaa020')
   CALL asfq006_filter_show('sfcb003','b_sfcb003')
   CALL asfq006_filter_show('sfcb004','b_sfcb004')
   CALL asfq006_filter_show('sfcb011','b_sfcb011')
   CALL asfq006_filter_show('sfcadocno_1','b_sfcadocno_1')
   CALL asfq006_filter_show('sfca001_1','b_sfca001_1')
   CALL asfq006_filter_show('sfaa002_1','b_sfaa002_1')
   CALL asfq006_filter_show('sfaa010_1','b_sfaa010_1')
   CALL asfq006_filter_show('sfca003_1','b_sfca003_1')
   CALL asfq006_filter_show('sfaa019_1','b_sfaa019_1')
   CALL asfq006_filter_show('sfaa020_1','b_sfaa020_1')
   CALL asfq006_filter_show('sfcb003_1','b_sfcb003_1')
   CALL asfq006_filter_show('sfcb004_1','b_sfcb004_1')
   CALL asfq006_filter_show('sfcb011_1','b_sfcb011_1')
   CALL asfq006_filter_show('sfcb050','b_sfcb050')
   CALL asfq006_filter_show('sfcb028','b_sfcb028')
   CALL asfq006_filter_show('sfcb029','b_sfcb029')
   CALL asfq006_filter_show('sfcb030','b_sfcb030')
   CALL asfq006_filter_show('sfcb031','b_sfcb031')
   CALL asfq006_filter_show('sfcb032','b_sfcb032')
   CALL asfq006_filter_show('sfcb033','b_sfcb033')
   CALL asfq006_filter_show('sfcb034','b_sfcb034')
   CALL asfq006_filter_show('sfcb035','b_sfcb035')
   CALL asfq006_filter_show('sfcb036','b_sfcb036')
   CALL asfq006_filter_show('sfcb037','b_sfcb037')
   CALL asfq006_filter_show('sfcb038','b_sfcb038')
   CALL asfq006_filter_show('sfcb039','b_sfcb039')
   CALL asfq006_filter_show('sfcb040','b_sfcb040')
   CALL asfq006_filter_show('sfcb041','b_sfcb041')
   CALL asfq006_filter_show('sfcb042','b_sfcb042')
   CALL asfq006_filter_show('sfcb043','b_sfcb043')
   CALL asfq006_filter_show('sfcb046','b_sfcb046')
   CALL asfq006_filter_show('sfcb047','b_sfcb047')
   CALL asfq006_filter_show('sfcb048','b_sfcb048')
   CALL asfq006_filter_show('sfcb049','b_sfcb049')
   CALL asfq006_filter_show('sfcb051','b_sfcb051')
   CALL asfq006_filter_show('fmovein','b_fmovein')
   CALL asfq006_filter_show('fcheckin','b_fcheckin')
   CALL asfq006_filter_show('lwork','b_lwork')
   CALL asfq006_filter_show('lcheckout','b_lcheckout')
   CALL asfq006_filter_show('lmoveout','b_lmoveout')
 
 
END FUNCTION
 
{</section>}
 
{<section id="asfq006.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq006_b_fill2()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define
   DEFINE l_sffb012       LIKE sffb_t.sffb012
   DEFINE l_sffb013       LIKE sffb_t.sffb013
   DEFINE ls_wc           STRING
   DEFINE l_stus          STRING
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #+ 此段落由子樣板qs07產生
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_sfca2_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
#table2
   LET g_sql = "SELECT  UNIQUE '','','','','','','','','','',sfcb003,'',sfcb004,sfcb011,'',sfcb050,sfcb028, 
       sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb040, 
       sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051,'','','','','' FROM sfcb_t",
               "",
               " WHERE sfcbent=? AND sfcbdocno=? AND sfcb001=? AND sfcbsite=?"
 
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY sfcb_t.sfcb001,sfcb_t.sfcb002"
 
   #add-point:單身填充前
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   #含已結案工單
   IF g_qbe.closed = 'Y' THEN
      LET l_stus = " AND (sfaastus = 'Y' OR sfaastus = 'F'",
                      "  OR  sfaastus = 'C' OR sfaastus = 'E'",
                      "  OR  sfaastus = 'M')"
   ELSE
      LET l_stus = " AND (sfaastus = 'Y' OR sfaastus = 'F')"
   END IF
   #160503-00030#8-mod-(S)
#   LET g_sql = "SELECT UNIQUE sfcadocno,sfca001,sfaa002,'',sfaa010,",
#               "              '','',sfca003,sfaa019,sfaa020,",
#               "              sfcb002,sfcb003,'',sfcb004,sfcb011,",
#               "              '',sfcb050,sfcb028,sfcb029,sfcb030,",
#               "              sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,",
#               "              sfcb036,sfcb037,sfcb038,sfcb039,sfcb040,",
#               "              sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,",
#               "              sfcb048,sfcb049,sfcb051,'','',",
#               "              '','','',sfcb014,sfcb015,",
#               "              sfcb016,sfcb018,sfcb019",
#               " FROM sfaa_t,sfca_t LEFT OUTER JOIN sfcb_t ON sfcaent = sfcbent",
#               "                                          AND sfcadocno = sfcbdocno",
#               "                                          AND sfcasite = sfcbsite",
#               "                                          AND sfca001 = sfcb001",
#               " WHERE sfaaent = sfcaent",
#               "   AND sfaadocno = sfcadocno",
#               "   AND sfcasite = '",g_site,"'",
#               "   AND sfaaent = ?",
#               "   AND ",ls_wc,l_stus
   LET g_sql = "SELECT UNIQUE sfcadocno,sfca001,sfaa002,",
               "              (SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=sfaa002) ooag011,",
               "              sfaa010,",
               "              (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal003, ",
               "              (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=sfaa010 AND imaal002='"||g_dlang||"') imaal004, ",
               "              sfca003,sfaa019,sfaa020,",
               "              sfcb002,sfcb003,",
               "              (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=sfcb003 AND oocql003='"||g_dlang||"') oocql004, ",
               "              sfcb004,sfcb011,",
               "              (SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001=sfcb011) ecaa002, ",
               "              sfcb050,sfcb028,sfcb029,sfcb030,",
               "              sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,",
               "              sfcb036,sfcb037,sfcb038,sfcb039,sfcb040,",
               "              sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,",
               "              sfcb048,sfcb049,sfcb051,'','',",
               "              '','','',sfcb014,sfcb015,",
               "              sfcb016,sfcb018,sfcb019",
               " FROM sfaa_t,sfca_t LEFT OUTER JOIN sfcb_t ON sfcaent = sfcbent",
               "                                          AND sfcadocno = sfcbdocno",
               "                                          AND sfcasite = sfcbsite",
               "                                          AND sfca001 = sfcb001",
               " WHERE sfaaent = sfcaent",
               "   AND sfaadocno = sfcadocno",
               "   AND sfcasite = '",g_site,"'",
               "   AND sfaaent = ?",
               "   AND ",ls_wc,l_stus
   #160503-00030#8-mod-(E)
   #工單單號
   IF g_sfca_d[l_ac].sfcadocno IS NOT NULL THEN
      LET g_sql = g_sql," AND sfcadocno = '",g_sfca_d[l_ac].sfcadocno,"'"
   END IF

   #Run Card
   IF g_sfca_d[l_ac].sfca001 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfca001 = '",g_sfca_d[l_ac].sfca001,"'"
   END IF

   #生管人員
   IF g_sfca_d[l_ac].sfaa002 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfaa002 = '",g_sfca_d[l_ac].sfaa002,"'"
   END IF

   #生產料號
   IF g_sfca_d[l_ac].sfaa010 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfaa010 = '",g_sfca_d[l_ac].sfaa010,"'"
   END IF

   #預計開工日
   IF g_sfca_d[l_ac].sfaa019 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfaa019 = '",g_sfca_d[l_ac].sfaa019,"'"
   END IF

   #預計完工日
   IF g_sfca_d[l_ac].sfaa020 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfaa020 = '",g_sfca_d[l_ac].sfaa020,"'"
   END IF

   #作業編號
   IF g_sfca_d[l_ac].sfcb003 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfcb003 = '",g_sfca_d[l_ac].sfcb003,"'"
   END IF

   #作業序
   IF g_sfca_d[l_ac].sfcb004 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfcb004 = '",g_sfca_d[l_ac].sfcb004,"'"
   END IF

   #工作站
   IF g_sfca_d[l_ac].sfcb011 IS NOT NULL THEN
      LET g_sql = g_sql," AND sfcb011 = '",g_sfca_d[l_ac].sfcb011,"'"
   END IF
   
   LET g_sql = g_sql," ORDER BY sfcb002"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq006_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR asfq006_pb2
 
   OPEN b_fill_curs2 USING g_enterprise#,g_sfca_d[g_detail_idx2].sfca001
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_sfca2_d[l_ac].sfcadocno,g_sfca2_d[l_ac].sfca001,g_sfca2_d[l_ac].sfaa002, 
       g_sfca2_d[l_ac].sfaa002_1_desc,g_sfca2_d[l_ac].sfaa010,g_sfca2_d[l_ac].sfaa010_1_desc,
       g_sfca2_d[l_ac].sfaa010_1_desc_1,g_sfca2_d[l_ac].sfca003,g_sfca2_d[l_ac].sfaa019,g_sfca2_d[l_ac].sfaa020,
       g_sfca2_d[l_ac].sfcb002,g_sfca2_d[l_ac].sfcb003,g_sfca2_d[l_ac].sfcb003_1_desc,
       g_sfca2_d[l_ac].sfcb004,g_sfca2_d[l_ac].sfcb011,g_sfca2_d[l_ac].sfcb011_1_desc, 
       g_sfca2_d[l_ac].sfcb050,g_sfca2_d[l_ac].sfcb028,g_sfca2_d[l_ac].sfcb029,g_sfca2_d[l_ac].sfcb030, 
       g_sfca2_d[l_ac].sfcb031,g_sfca2_d[l_ac].sfcb032,g_sfca2_d[l_ac].sfcb033,g_sfca2_d[l_ac].sfcb034, 
       g_sfca2_d[l_ac].sfcb035,g_sfca2_d[l_ac].sfcb036,g_sfca2_d[l_ac].sfcb037,g_sfca2_d[l_ac].sfcb038, 
       g_sfca2_d[l_ac].sfcb039,g_sfca2_d[l_ac].sfcb040,g_sfca2_d[l_ac].sfcb041,g_sfca2_d[l_ac].sfcb042, 
       g_sfca2_d[l_ac].sfcb043,g_sfca2_d[l_ac].sfcb046,g_sfca2_d[l_ac].sfcb047,g_sfca2_d[l_ac].sfcb048, 
       g_sfca2_d[l_ac].sfcb049,g_sfca2_d[l_ac].sfcb051,g_sfca2_d[l_ac].fmovein,g_sfca2_d[l_ac].fcheckin, 
       g_sfca2_d[l_ac].lwork,g_sfca2_d[l_ac].lcheckout,g_sfca2_d[l_ac].lmoveout,g_sfca2_d[l_ac].sfcb014,
       g_sfca2_d[l_ac].sfcb015,g_sfca2_d[l_ac].sfcb016,g_sfca2_d[l_ac].sfcb018,g_sfca2_d[l_ac].sfcb019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充
      #首次Move in時間 sffb001 = 1 抓第一筆
      IF g_sfca2_d[l_ac].sfcb014 = 'Y' THEN
         LET l_sffb012 = ''
         LET l_sffb013 = ''
         OPEN asfq006_curs USING '1',g_sfca2_d[l_ac].sfcadocno,g_sfca2_d[l_ac].sfcb003
         FETCH FIRST asfq006_curs INTO l_sffb012,l_sffb013
         LET g_sfca2_d[l_ac].fmovein = l_sffb012,' ',l_sffb013
      END IF
      
      #首次Check in時間 sffb001 = 2 抓第一筆
      IF g_sfca2_d[l_ac].sfcb015 = 'Y' THEN
         LET l_sffb012 = ''
         LET l_sffb013 = ''
         OPEN asfq006_curs USING '2',g_sfca2_d[l_ac].sfcadocno,g_sfca2_d[l_ac].sfcb003
         FETCH FIRST asfq006_curs INTO l_sffb012,l_sffb013
         LET g_sfca2_d[l_ac].fcheckin = l_sffb012,' ',l_sffb013
      END IF
      
      #最近報工時間 sffb001 = 3 抓最後一筆
      IF g_sfca2_d[l_ac].sfcb016 = 'Y' THEN
         LET l_sffb012 = ''
         LET l_sffb013 = ''
         OPEN asfq006_curs USING '3',g_sfca2_d[l_ac].sfcadocno,g_sfca2_d[l_ac].sfcb003
         FETCH LAST asfq006_curs INTO l_sffb012,l_sffb013
         LET g_sfca2_d[l_ac].lwork = l_sffb012,' ',l_sffb013
      END IF

      #最近Check out時間 sffb001 = 4 抓最後一筆
      IF g_sfca2_d[l_ac].sfcb018 = 'Y' THEN
         LET l_sffb012 = ''
         LET l_sffb013 = ''
         OPEN asfq006_curs USING '4',g_sfca2_d[l_ac].sfcadocno,g_sfca2_d[l_ac].sfcb003
         FETCH LAST asfq006_curs INTO l_sffb012,l_sffb013
         LET g_sfca2_d[l_ac].lcheckout = l_sffb012,' ',l_sffb013
      END IF

      #最近Move out時間 sffb001 = 5 抓最後一筆
      IF g_sfca2_d[l_ac].sfcb019 = 'Y' THEN
         LET l_sffb012 = ''
         LET l_sffb013 = ''
         OPEN asfq006_curs USING '5',g_sfca2_d[l_ac].sfcadocno,g_sfca2_d[l_ac].sfcb003
         FETCH LAST asfq006_curs INTO l_sffb012,l_sffb013
         LET g_sfca2_d[l_ac].lmoveout = l_sffb012,' ',l_sffb013
      END IF
      #160518-00017#1-mark-(S)
#      #20150424 By dujuan str
#       #+ b_fill段欄位串查功能設定 
#       LET g_hyper_url = asfq006_get_hyper_data("prog_b_sfca001_1")
#       LET g_sfca2_d[l_ac].prog_b_sfca001_1 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfca2_d[l_ac].sfca001), 
#                                             "</a>"
#      # #20150424 By dujuan end
      #160518-00017#1-mark-(E)
      #end add-point
 
      CALL asfq006_detail_show("'2'")
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
   END FOREACH
 
   LET li_ac = l_ac - 1
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
#Page2
   CALL g_sfca2_d.deleteElement(g_sfca2_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
 
 
   #add-point:單身填充後

   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="asfq006.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq006_detail_show(ps_page)
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
      #160503-00030#8-mark-(S)
#      #生管人員
#      CALL s_desc_get_person_desc(g_sfca_d[l_ac].sfaa002)
#         RETURNING g_sfca_d[l_ac].sfaa002_desc
#      DISPLAY BY NAME g_sfca_d[l_ac].sfaa002_desc
#
#      #品名規格
#      CALL s_desc_get_item_desc(g_sfca_d[l_ac].sfaa010)
#         RETURNING g_sfca_d[l_ac].sfaa010_desc,g_sfca_d[l_ac].sfaa010_desc_1
#      DISPLAY BY NAME g_sfca_d[l_ac].sfaa010_desc,g_sfca_d[l_ac].sfaa010_desc_1
#
#      CALL s_desc_get_acc_desc('221',g_sfca_d[l_ac].sfcb003)
#         RETURNING g_sfca_d[l_ac].sfcb003_desc
#      DISPLAY BY NAME g_sfca_d[l_ac].sfcb003_desc
#
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_sfca_d[l_ac].sfcb011
#      LET ls_sql = "SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaa001=? "
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_sfca_d[l_ac].sfcb011_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_sfca_d[l_ac].sfcb011_desc
      #160503-00030#8-mark-(E)
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
      #add-point:show段單身reference
      #160503-00030#8-mark-(S)
#      #生管人員
#      CALL s_desc_get_person_desc(g_sfca2_d[l_ac].sfaa002)
#         RETURNING g_sfca2_d[l_ac].sfaa002_1_desc
#      DISPLAY BY NAME g_sfca2_d[l_ac].sfaa002_1_desc
#
#      #品名規格
#      CALL s_desc_get_item_desc(g_sfca2_d[l_ac].sfaa010)
#         RETURNING g_sfca2_d[l_ac].sfaa010_1_desc,g_sfca2_d[l_ac].sfaa010_1_desc_1
#      DISPLAY BY NAME g_sfca2_d[l_ac].sfaa010_1_desc,g_sfca2_d[l_ac].sfaa010_1_desc_1
#
#      CALL s_desc_get_acc_desc('221',g_sfca2_d[l_ac].sfcb003)
#         RETURNING g_sfca2_d[l_ac].sfcb003_1_desc
#      DISPLAY BY NAME g_sfca2_d[l_ac].sfcb003_1_desc
#
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_sfca2_d[l_ac].sfcb011
#      LET ls_sql = "SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaa001=? "
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_sfca2_d[l_ac].sfcb011_1_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_sfca2_d[l_ac].sfcb011_1_desc
      #160503-00030#8-mark-(E)
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq006.filter" >}
#+ 此段落由子樣板qs13產生
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION asfq006_filter()
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
   #160518-00017#1-mark-(S)
#    #串查隐藏的列 20150424 By dujuan str
#      # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
#      CALL gfrm_curr.setFieldHidden('prog_b_sfcadocno', TRUE)
#      CALL gfrm_curr.setFieldHidden('b_sfcadocno', FALSE) 
#      CALL gfrm_curr.setFieldHidden('prog_b_sfca001_1', TRUE) 
#      CALL gfrm_curr.setFieldHidden('b_sfca001_1', FALSE)  
#   #串查隐藏的列 20150424 By dujuan end
   #160518-00017#1-mark-(E) 
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON sfcadocno,sfca001,sfaa002,sfaa010,sfca003,sfaa019,sfaa020,sfcb003,sfcb004, 
          sfcb011
                          FROM s_detail1[1].b_sfcadocno,s_detail1[1].b_sfca001,s_detail1[1].b_sfaa002, 
                              s_detail1[1].b_sfaa010,s_detail1[1].b_sfca003,s_detail1[1].b_sfaa019,s_detail1[1].b_sfaa020, 
                              s_detail1[1].b_sfcb003,s_detail1[1].b_sfcb004,s_detail1[1].b_sfcb011
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
                     DISPLAY asfq006_filter_parser('sfcadocno') TO s_detail1[1].b_sfcadocno
            DISPLAY asfq006_filter_parser('sfca001') TO s_detail1[1].b_sfca001
            DISPLAY asfq006_filter_parser('sfaa002') TO s_detail1[1].b_sfaa002
            DISPLAY asfq006_filter_parser('sfaa010') TO s_detail1[1].b_sfaa010
            DISPLAY asfq006_filter_parser('sfca003') TO s_detail1[1].b_sfca003
            DISPLAY asfq006_filter_parser('sfaa019') TO s_detail1[1].b_sfaa019
            DISPLAY asfq006_filter_parser('sfaa020') TO s_detail1[1].b_sfaa020
            DISPLAY asfq006_filter_parser('sfcb003') TO s_detail1[1].b_sfcb003
            DISPLAY asfq006_filter_parser('sfcb004') TO s_detail1[1].b_sfcb004
            DISPLAY asfq006_filter_parser('sfcb011') TO s_detail1[1].b_sfcb011
 
 
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
 
 
    #串查隐藏的列 20150424 By dujuan str
      # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
      CALL gfrm_curr.setFieldHidden('b_sfcadocno', TRUE) 
      CALL gfrm_curr.setFieldHidden('prog_b_sfcadocno', FALSE) 
    
      CALL gfrm_curr.setFieldHidden('b_sfca001_1', TRUE)
      CALL gfrm_curr.setFieldHidden('prog_b_sfca001_1', FALSE)
   #串查隐藏的列 20150424 By dujuan end
   
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL asfq006_filter_show('sfcadocno','b_sfcadocno')
   CALL asfq006_filter_show('sfca001','b_sfca001')
   CALL asfq006_filter_show('sfaa002','b_sfaa002')
   CALL asfq006_filter_show('sfaa010','b_sfaa010')
   CALL asfq006_filter_show('sfca003','b_sfca003')
   CALL asfq006_filter_show('sfaa019','b_sfaa019')
   CALL asfq006_filter_show('sfaa020','b_sfaa020')
   CALL asfq006_filter_show('sfcb003','b_sfcb003')
   CALL asfq006_filter_show('sfcb004','b_sfcb004')
   CALL asfq006_filter_show('sfcb011','b_sfcb011')
   CALL asfq006_filter_show('sfcadocno_1','b_sfcadocno_1')
   CALL asfq006_filter_show('sfca001_1','b_sfca001_1')
   CALL asfq006_filter_show('sfaa002_1','b_sfaa002_1')
   CALL asfq006_filter_show('sfaa010_1','b_sfaa010_1')
   CALL asfq006_filter_show('sfca003_1','b_sfca003_1')
   CALL asfq006_filter_show('sfaa019_1','b_sfaa019_1')
   CALL asfq006_filter_show('sfaa020_1','b_sfaa020_1')
   CALL asfq006_filter_show('sfcb003_1','b_sfcb003_1')
   CALL asfq006_filter_show('sfcb004_1','b_sfcb004_1')
   CALL asfq006_filter_show('sfcb011_1','b_sfcb011_1')
   CALL asfq006_filter_show('sfcb050','b_sfcb050')
   CALL asfq006_filter_show('sfcb028','b_sfcb028')
   CALL asfq006_filter_show('sfcb029','b_sfcb029')
   CALL asfq006_filter_show('sfcb030','b_sfcb030')
   CALL asfq006_filter_show('sfcb031','b_sfcb031')
   CALL asfq006_filter_show('sfcb032','b_sfcb032')
   CALL asfq006_filter_show('sfcb033','b_sfcb033')
   CALL asfq006_filter_show('sfcb034','b_sfcb034')
   CALL asfq006_filter_show('sfcb035','b_sfcb035')
   CALL asfq006_filter_show('sfcb036','b_sfcb036')
   CALL asfq006_filter_show('sfcb037','b_sfcb037')
   CALL asfq006_filter_show('sfcb038','b_sfcb038')
   CALL asfq006_filter_show('sfcb039','b_sfcb039')
   CALL asfq006_filter_show('sfcb040','b_sfcb040')
   CALL asfq006_filter_show('sfcb041','b_sfcb041')
   CALL asfq006_filter_show('sfcb042','b_sfcb042')
   CALL asfq006_filter_show('sfcb043','b_sfcb043')
   CALL asfq006_filter_show('sfcb046','b_sfcb046')
   CALL asfq006_filter_show('sfcb047','b_sfcb047')
   CALL asfq006_filter_show('sfcb048','b_sfcb048')
   CALL asfq006_filter_show('sfcb049','b_sfcb049')
   CALL asfq006_filter_show('sfcb051','b_sfcb051')
   CALL asfq006_filter_show('fmovein','b_fmovein')
   CALL asfq006_filter_show('fcheckin','b_fcheckin')
   CALL asfq006_filter_show('lwork','b_lwork')
   CALL asfq006_filter_show('lcheckout','b_lcheckout')
   CALL asfq006_filter_show('lmoveout','b_lmoveout')
 
   CALL asfq006_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq006.filter_parser" >}
#+ 此段落由子樣板qs14產生
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION asfq006_filter_parser(ps_field)
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
 
{<section id="asfq006.filter_show" >}
#+ 此段落由子樣板qs15產生
#+ 標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq006_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfq006_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq006.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: CALL asfq006_comp_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/08/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION asfq006_comp_visible()
   
   #工單單號
   IF g_show.l_sfcadocno = 'Y' THEN
      #CALL cl_set_comp_visible("b_sfcadocno",TRUE)     #20150424 By dujuan mark
      #CALL cl_set_comp_visible("prog_b_sfcadocno",TRUE) #20150424 By dujuan add   #161011-00028#1 mark
      CALL cl_set_comp_visible("b_sfcadocno_1",FALSE)
   ELSE
      #CALL cl_set_comp_visible("b_sfcadocno",FALSE)      #20150424 By dujuan mark
      #CALL cl_set_comp_visible("prog_b_sfcadocno",FALSE)  #20150424 By dujuan add  #161011-00028#1 mark
      CALL cl_set_comp_visible("b_sfcadocno_1",TRUE)
   END IF

   #Run Card
   IF g_show.l_sfca001 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfca001,b_sfca003",TRUE)
      #CALL cl_set_comp_visible("b_sfca001_1,b_sfca003_1",FALSE)      #20150424 By dujuan mark
      CALL cl_set_comp_visible("b_sfca003_1",FALSE)  #20150424 By dujuan add  #161011-00028#1 去掉prog_b_sfca001_1,
   ELSE
      CALL cl_set_comp_visible("b_sfca001,b_sfca003",FALSE)
      #CALL cl_set_comp_visible("b_sfca001_1,b_sfca003_1",TRUE)     #20150424 By dujuan mark
      CALL cl_set_comp_visible("b_sfca003_1",TRUE) #20150424 By dujuan add    #161011-00028#1 去掉prog_b_sfca001_1,
   END IF

   #生管人員
   IF g_show.l_sfaa002 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfaa002,b_sfaa002_desc",TRUE)
      CALL cl_set_comp_visible("b_sfaa002_1,b_sfaa002_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_sfaa002,b_sfaa002_desc",FALSE)
      CALL cl_set_comp_visible("b_sfaa002_1,b_sfaa002_1_desc",TRUE)
   END IF

   #生產料號
   IF g_show.l_sfaa010 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfaa010,b_sfaa010_desc,b_sfaa010_desc_1",TRUE)
      CALL cl_set_comp_visible("b_sfaa010_1,b_sfaa010_1_desc,b_sfaa010_1_desc_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_sfaa010,b_sfaa010_desc,b_sfaa010_desc_1",FALSE)
      CALL cl_set_comp_visible("b_sfaa010_1,b_sfaa010_1_desc,b_sfaa010_1_desc_1",TRUE)
   END IF

   #預計開工日
   IF g_show.l_sfaa019 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfaa019",TRUE)
      CALL cl_set_comp_visible("b_sfaa019_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_sfaa019",FALSE)
      CALL cl_set_comp_visible("b_sfaa019_1",TRUE)
   END IF

   #預計完工日
   IF g_show.l_sfaa020 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfaa020",TRUE)
      CALL cl_set_comp_visible("b_sfaa020_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_sfaa020",FALSE)
      CALL cl_set_comp_visible("b_sfaa020_1",TRUE)
   END IF

   #作業編號
   IF g_show.l_sfcb003 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfcb003,b_sfcb003_desc",TRUE)
      CALL cl_set_comp_visible("b_sfcb003_1,b_sfcb003_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_sfcb003,b_sfcb003_desc",FALSE)
      CALL cl_set_comp_visible("b_sfcb003_1,b_sfcb003_1_desc",TRUE)
   END IF

   #作業序
   IF g_show.l_sfcb004 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfcb004",TRUE)
      CALL cl_set_comp_visible("b_sfcb004_1",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_sfcb004",FALSE)
      CALL cl_set_comp_visible("b_sfcb004_1",TRUE)
   END IF

   #工作站
   IF g_show.l_sfcb011 = 'Y' THEN
      CALL cl_set_comp_visible("b_sfcb011,b_sfcb011_desc",TRUE)
      CALL cl_set_comp_visible("b_sfcb011_1,b_sfcb011_1_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_sfcb011,b_sfcb011_desc",FALSE)
      CALL cl_set_comp_visible("b_sfcb011_1,b_sfcb011_1_desc",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明:串查询
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150424 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq006_get_hyper_data(ps_field_name)
   DEFINE ps_field_name    STRING 
   DEFINE ps_url           STRING 
   DEFINE ls_js            STRING 
   DEFINE la_param         RECORD 
                           prog     STRING, 
                           param    DYNAMIC ARRAY OF STRING 
                           END RECORD 
   DEFINE ps_type          LIKE type_t.chr10 
  
 
   LET ps_url = NULL 
 
   # 設定要做串查的程式代碼 
   CASE 
      WHEN ps_field_name = "prog_b_sfcadocno" 
         LET la_param.prog = "asft300" 
         LET la_param.param[1] = g_sfca_d[l_ac].sfcadocno
         
      WHEN ps_field_name = "prog_b_sfca001_1"
         LET la_param.prog = "asft301"   
         LET la_param.param[1] = g_sfca2_d[l_ac].sfca001
         
   END CASE 
 
   # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
  
   #將陣列資料組合成一個string字串 
   LET ls_js = util.JSON.stringify(la_param) 
 
   #依環境設定要走GDC或GWC模式 (""表示會依據目前的環境判斷，若有自行定義，會依據所定義的模式去執行) 
   LET ps_type = "" 
   
   CALL cl_ap_url(ps_type,ls_js) RETURNING ps_url 
 
   RETURN ps_url 
 

END FUNCTION

 
{</section>}
 
