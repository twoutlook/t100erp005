#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq125.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-08-07 14:22:08), PR版次:0002(2015-08-07 15:19:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: apmq125
#+ Description: 供應商料件最近採購查詢作業
#+ Creator....: 05293(2014-07-09 09:00:54)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="apmq125.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單身 type 宣告
 TYPE type_g_pmar_d RECORD
   pmarsite          LIKE pmar_t.pmarsite,               #150807 polly add 
   pmarsite_desc     LIKE type_t.chr500,                 #150807 polly add
   pmar002           LIKE pmar_t.pmar002, 
   pmar002_desc      LIKE type_t.chr500, 
   pmar002_desc_desc LIKE type_t.chr500, 
   pmar003           LIKE pmar_t.pmar003, 
   pmar003_desc      LIKE type_t.chr500,
   pmar004           LIKE pmar_t.pmar004,
   pmar004_desc      LIKE type_t.chr500,   
   pmar005           LIKE pmar_t.pmar005, 
   pmar001           LIKE pmar_t.pmar001, 
   pmar001_desc      LIKE type_t.chr500, 
   pmar007           LIKE pmar_t.pmar007,
   pmar007_desc      LIKE type_t.chr500,    
   pmar009           LIKE pmar_t.pmar009,
   pmar009_desc      LIKE type_t.chr500,    
   pmar006           LIKE pmar_t.pmar006,
   pmar006_desc      LIKE type_t.chr500
       END RECORD
DEFINE g_pmar_d            DYNAMIC ARRAY OF type_g_pmar_d
DEFINE g_pmar_d_t          type_g_pmar_d

 TYPE type_g_pmar2_d RECORD
   l_pmarsite          LIKE type_t.chr500,       #150807 polly add
   l_pmarsite_desc     LIKE type_t.chr500,       #150807 polly add
   l_pmar002           LIKE type_t.chr500, 
   l_pmar002_desc      LIKE type_t.chr500, 
   l_pmar002_desc_desc LIKE type_t.chr500, 
   l_pmar003           LIKE type_t.chr500, 
   l_pmar003_desc      LIKE type_t.chr500, 
   l_pmar004           LIKE type_t.chr10,
   l_pmar004_desc      LIKE type_t.chr500,    
   l_pmar005           LIKE type_t.chr10, 
   l_pmar001           LIKE type_t.chr10, 
   l_pmar001_desc      LIKE type_t.chr500, 
   l_pmar007           LIKE type_t.chr10, 
   l_pmar007_desc      LIKE type_t.chr500, 
   l_pmar009           LIKE type_t.chr10, 
   l_pmar009_desc      LIKE type_t.chr500, 
   l_pmar006           LIKE type_t.chr10, 
   l_pmar006_desc      LIKE type_t.chr500, 
   l_pmar012           LIKE type_t.num20_6, 
   l_pmar014           LIKE type_t.chr10,
   l_pmar014_desc      LIKE type_t.chr500,    
   l_pmar015           LIKE type_t.num20_6, 
   l_pmar016           LIKE type_t.num20_6, 
   l_pmar017           LIKE type_t.num20_6, 
   l_pmar018           LIKE type_t.chr20, 
   l_pmar019           LIKE type_t.dat, 
   l_pmar020           LIKE type_t.chr10, 
   l_pmar020_desc      LIKE type_t.chr500
       END RECORD
DEFINE g_pmar2_d     DYNAMIC ARRAY OF type_g_pmar2_d
DEFINE g_pmar2_d_t   type_g_pmar2_d

#查詢條件
 TYPE type_g_pmar RECORD
     imaa009 LIKE type_t.chr1000,
     pmar002 LIKE type_t.chr1000,
     pmar003 LIKE type_t.chr1000, 
     pmar001 LIKE type_t.chr1000, 
     pmaa080 LIKE type_t.chr1000, 
     pmar006 LIKE type_t.chr1000, 
     pmar007 LIKE type_t.chr1000, 
     pmar009 LIKE type_t.chr1000, 
     pmar019 LIKE type_t.chr1000,
     pmarsite LIKE type_t.chr1000               #150807 polly add
         END RECORD
DEFINE g_pmar        type_g_pmar
#價格類型    
 TYPE type_tm RECORD
     pmar000 LIKE pmar_t.pmar000,
     l_pmarsite_1 LIKE pmar_t.pmarsite,         #150807 polly add
     l_pmar002_1 LIKE pmar_t.pmar000, 
     l_pmar004_1 LIKE pmar_t.pmar000, 
     l_pmar001_1 LIKE pmar_t.pmar000, 
     l_pmar007_1 LIKE pmar_t.pmar000, 
     l_pmar003_1 LIKE pmar_t.pmar000, 
     l_pmar005_1 LIKE pmar_t.pmar000,  
     l_pmar006_1 LIKE pmar_t.pmar000, 
     l_pmar009_1 LIKE pmar_t.pmar000
         END RECORD   
DEFINE tm         type_tm
#單頭資料內容
#PRIVATE TYPE type_g_pmar1 RECORD
#     pmar002 LIKE pmar_t.pmar000, 
#     pmar004 LIKE pmar_t.pmar000, 
#     pmar001 LIKE pmar_t.pmar000, 
#     pmar007 LIKE pmar_t.pmar000, 
#     pmar003 LIKE pmar_t.pmar000, 
#     pmar005 LIKE pmar_t.pmar000,  
#     pmar006 LIKE pmar_t.pmar000, 
#     pmar009 LIKE pmar_t.pmar000
#         END RECORD
#DEFINE g_pmar1        type_g_pmar1


DEFINE g_cnt2          LIKE type_t.num10              
DEFINE l_ac2           LIKE type_t.num5              #目前處理的ARRAY CNT

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
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="apmq125.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
 
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = " "
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE apmq125_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq125 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmq125_init()
 
      #進入選單 Menu (='N')
      CALL apmq125_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_apmq125
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="apmq125.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apmq125_init()

   #add-point:init段define
 
   #end add-point

   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"



   #add-point:畫面資料初始化
   
   #--150807--polly--add--(s)
   CALL cl_set_comp_visible("lbl_pmarsite,pmarsite,l_pmarsite_1",FALSE)
   CALL cl_set_comp_visible("b_pmarsite,b_pmarsite_desc,l_pmarsite,l_pmarsite_desc",FALSE)
   IF g_argv[01] = 'A' THEN
      CALL cl_set_comp_visible("lbl_pmarsite,pmarsite,l_pmarsite_1",TRUE)
      CALL cl_set_comp_visible("b_pmarsite,b_pmarsite_desc,l_pmarsite,l_pmarsite_desc",TRUE)
      LET tm.l_pmarsite_1 = 'Y'         
   ELSE
      LET tm.l_pmarsite_1 = 'N'                   
   END IF   
   #--150807--polly--add--(e)
   
   #價格類型預設
   LET tm.pmar000 = 'N'
   #單頭資料內容預設勾選料件編號
   LET tm.l_pmar002_1 = 'Y'
   LET tm.l_pmar004_1 = 'N'
   LET tm.l_pmar001_1 = 'N'
   LET tm.l_pmar007_1 = 'N'
   LET tm.l_pmar003_1 = 'N'
   LET tm.l_pmar005_1 = 'N'
   LET tm.l_pmar006_1 = 'N'
   LET tm.l_pmar009_1 = 'N'
   CALL apmq125_set_entry()
   CALL apmq125_set_no_entry()
   #end add-point

END FUNCTION

PRIVATE FUNCTION apmq125_ui_dialog()
   {<Local define>} 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   {</Local define>}
   #add-point:ui_dialog段define
   DEFINE ls_wc     STRING
   DEFINE ldig_curr ui.Dialog
   DEFINE li_index  LIKE type_t.num5
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


#   CALL apmq125_b_fill()

   WHILE li_exit = FALSE

      CALL cl_dlg_query_bef_disp()  #相關查詢

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:CONSTRUCT段落
         CONSTRUCT BY NAME g_wc ON imaa009,pmar002,pmar003,pmar001,pmaa080,
                                   pmar006,pmar007,pmar009,pmar019,pmarsite     #150807 polly add pmarsite
            BEFORE CONSTRUCT
               IF cl_null(g_pmar.pmar019) THEN
                  LET g_pmar.pmar019 = ''
               END IF
               DISPLAY BY NAME g_pmar.imaa009,g_pmar.pmar002,g_pmar.pmar003,
                               g_pmar.pmar001,g_pmar.pmaa080,g_pmar.pmar006,
                               g_pmar.pmar007,g_pmar.pmar009,g_pmar.pmar019,
                               g_pmar.pmarsite                                  #150807 polly add pmarsite

            AFTER FIELD imaa009
               LET g_pmar.imaa009 = GET_FLDBUF(imaa009)

            AFTER FIELD pmar002
               LET g_pmar.pmar002 = GET_FLDBUF(pmar002)

            AFTER FIELD pmar003
               LET g_pmar.pmar003 = GET_FLDBUF(pmar003)

            AFTER FIELD pmar001
               LET g_pmar.pmar001 = GET_FLDBUF(pmar001)

            AFTER FIELD pmaa080
               LET g_pmar.pmaa080 = GET_FLDBUF(pmaa080)

            AFTER FIELD pmar006
               LET g_pmar.pmar006 = GET_FLDBUF(pmar006)

            AFTER FIELD pmar007
               LET g_pmar.pmar007 = GET_FLDBUF(pmar007)

            AFTER FIELD pmar009
               LET g_pmar.pmar009 = GET_FLDBUF(pmar009)

            AFTER FIELD pmar019
               LET g_pmar.pmar019 = GET_FLDBUF(pmar019)
           #--150807--polly--add-(s)
            AFTER FIELD pmarsite
               LET g_pmar.pmarsite = GET_FLDBUF(pmarsite)
           #--150807--polly--add-(e)
           
            ON ACTION controlp INFIELD imaa009
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009      #顯示到畫面上
               NEXT FIELD imaa009                         #返回原欄位

            ON ACTION controlp INFIELD pmar002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmar002      #顯示到畫面上
               NEXT FIELD pmar002                         #返回原欄位

            ON ACTION controlp INFIELD pmar003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmar003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmar003      #顯示到畫面上
               NEXT FIELD pmar003                         #返回原欄位

            ON ACTION controlp INFIELD pmar001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmar001      #顯示到畫面上
               NEXT FIELD pmar001                         #返回原欄位

            ON ACTION controlp INFIELD pmaa080
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '251'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa080      #顯示到畫面上
               NEXT FIELD pmaa080                         #返回原欄位

            ON ACTION controlp INFIELD pmar006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooca001_1()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmar006      #顯示到畫面上
               NEXT FIELD pmar006                         #返回原欄位

            ON ACTION controlp INFIELD pmar007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_ooaj002_1()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmar007      #顯示到畫面上
               NEXT FIELD pmar007                         #返回原欄位

            ON ACTION controlp INFIELD pmar009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_oodb002_2()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmar009      #顯示到畫面上
               NEXT FIELD pmar009                         #返回原欄位
           #--150807--polly--add-(s) 
            ON ACTION controlp INFIELD pmarsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmarsite()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmarsite      #顯示到畫面上
               NEXT FIELD pmarsite                         #返回原欄位            
           #--150807--polly--add-(e)
         END CONSTRUCT

         #end add-point

         #add-point:construct段落
         INPUT BY NAME tm.pmar000 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               CALL apmq125_set_entry()
               CALL apmq125_set_no_entry()
            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
            ON CHANGE pmar000
               CALL apmq125_set_entry()
               CALL apmq125_set_no_entry()
         END INPUT

         INPUT BY NAME tm.l_pmarsite_1,tm.l_pmar002_1,tm.l_pmar004_1,tm.l_pmar001_1,tm.l_pmar007_1,
                       tm.l_pmar003_1,tm.l_pmar005_1,tm.l_pmar006_1,tm.l_pmar009_1 ATTRIBUTE(WITHOUT DEFAULTS) 

            BEFORE INPUT

            AFTER INPUT

         END INPUT
         #end add-point

         DISPLAY ARRAY g_pmar_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_pmar_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL apmq125_b_fill2(l_ac)

               #add-point:input段before row

               #end add-point



            #自訂ACTION(detail_show,page_1)


         END DISPLAY

         DISPLAY ARRAY g_pmar2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
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
            #關閉查詢按鈕，保持查詢狀態
            CALL cl_set_act_visible("query", FALSE)
            
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
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               #還原
               LET g_wc = ls_wc
            ELSE
               IF tm.l_pmar002_1 = 'N' AND tm.l_pmar004_1 = 'N' AND tm.l_pmar001_1 = 'N' AND tm.l_pmar007_1 = 'N' AND
                  tm.l_pmar003_1 = 'N' AND tm.l_pmar005_1 = 'N' AND tm.l_pmar006_1 = 'N' AND tm.l_pmar009_1 = 'N' AND
                  tm.l_pmarsite_1 = 'N' THEN                    #150807 polly add pmarsite
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'ain-00173'
                 LET g_errparam.extend = ' '
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 NEXT FIELD CURRENT
               END IF
               CALL cl_dlg_save_user_latestqry("("||g_wc||")")  
               LET g_master_idx = 1
            END IF
            
            CALL apmq125_comp_visible()
            
            LET g_error_show = 1
            CALL apmq125_b_fill()
            CALL apmq125_b_fill2(1)     
            CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
            DISPLAY g_detail_idx TO FORMONLY.h_index            
            LET l_ac = g_master_idx
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -100
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF      
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)


         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_pmar_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_pmar2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_main_hidden=0
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION qbeclear   # 條件清除
            CALL apmq125_qbeclear()


         ON ACTION datarefresh   # 重新整理
            CALL apmq125_b_fill()


         #+ 此段落由子樣板qs16產生
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq125_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG



         #+ 此段落由子樣板a43產生
#         ON ACTION insert
#            LET g_action_choice="insert"
#            IF cl_auth_chk_act("insert") THEN
#
#               #add-point:ON ACTION insert
#
#               #END add-point
#               EXIT DIALOG
#            END IF
#

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
         
         #瀏覽頁折疊
         ON ACTION qbehidden   
            IF g_worksheet_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_worksheet_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_worksheet_hidden = 1
            END IF
           
         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN

               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF

         ON ACTION queryplansel
            INITIALIZE g_pmar.* TO NULL      
            CALL cl_dlg_qryplan_select() RETURNING ls_wc         
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc   #不是空條件才寫入g_wc跟重新找資料
               CASE g_wc
                  WHEN "pmar000 = 'N'"
                     LET tm.pmar000 = 'N'

                  WHEN "pmar000 = 'Y'"
                     LET tm.pmar000 = 'Y'

               END CASE  
               #--150807--polly--add--(s)
               IF g_argv[01] = 'A' THEN
                  LET tm.l_pmarsite_1 = 'Y'         
               ELSE
                  LET tm.l_pmarsite_1 = 'N'                   
               END IF                
               #--150807--polly--add--(e)
               
               #單頭資料內容預設勾選料件編號
               LET tm.l_pmar002_1 = 'Y'
               LET tm.l_pmar004_1 = 'N'
               LET tm.l_pmar001_1 = 'N'
               LET tm.l_pmar007_1 = 'N'
               LET tm.l_pmar003_1 = 'N'
               LET tm.l_pmar005_1 = 'N'
               LET tm.l_pmar006_1 = 'N'
               LET tm.l_pmar009_1 = 'N'
               CALL apmq125_comp_visible()
               CALL apmq125_b_fill()   #browser_fill()會將notice區塊清空
               CALL apmq125_b_fill2(1)       
               CALL DIALOG.setCurrentRow("s_detail1",1)
               DISPLAY 1 TO FORMONLY.h_index               
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
            
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

      END DIALOG

   END WHILE

END FUNCTION

PRIVATE FUNCTION apmq125_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   {</Local define>}
   #add-point:b_fill段define
   DEFINE l_sql_order     STRING
   DEFINE l_sql           STRING
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

   CALL g_pmar_d.clear()
   CALL g_pmar2_d.clear()


   #add-point:陣列清空

   #end add-point

   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   # b_fill段sql組成及FOREACH撰寫
   LET l_sql = "SELECT UNIQUE "
   LET l_sql_order = " ORDER BY "
  #單頭資料內容
  #--150807--polly--add--(S)
   IF tm.l_pmarsite_1 = 'Y' THEN
      LET l_sql = l_sql,"pmarsite,''"
      LET l_sql_order = l_sql_order,"pmarsite"
   ELSE
      LET l_sql = l_sql,"'',''"
      LET l_sql_order = l_sql_order,"''"
   END IF
  #--150807--polly--add--(E)
  
   IF tm.l_pmar002_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar002,'',''"
      LET l_sql_order = l_sql_order,",pmar002"
   ELSE
      LET l_sql = l_sql,",'','',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
    IF tm.l_pmar003_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar003,''"
      LET l_sql_order = l_sql_order,",pmar003"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF

   IF tm.l_pmar004_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar004,''"
      LET l_sql_order = l_sql_order,",pmar004"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF tm.l_pmar005_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar005"
      LET l_sql_order = l_sql_order,",pmar005"
   ELSE
      LET l_sql = l_sql,",''"
      LET l_sql_order = l_sql_order,",''"
   END IF

   IF tm.l_pmar001_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar001,''"
      LET l_sql_order = l_sql_order,",pmar001"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF

   IF tm.l_pmar007_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar007,''"
      LET l_sql_order = l_sql_order,",pmar007"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF

   IF tm.l_pmar009_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar009,''"
      LET l_sql_order = l_sql_order,",pmar009"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF
   
   IF tm.l_pmar006_1 = 'Y' THEN
      LET l_sql = l_sql,",pmar006,''"
      LET l_sql_order = l_sql_order,",pmar006"
   ELSE
      LET l_sql = l_sql,",'',''"
      LET l_sql_order = l_sql_order,",''"
   END IF

   #價格類型
   IF NOT cl_null(tm.pmar000) THEN
      LET ls_wc = ls_wc," AND pmar000='",tm.pmar000,"'"
   END IF
  
  #--150807--polly--add--(s)
   #--MARK--(S)
   #IF ls_wc.getIndexOf("pmaa",1) THEN
   #   IF ls_wc.getIndexOf("imaa",1) THEN
   #      LET g_sql = l_sql,"  FROM pmar_t,imaa_t,pmaa_t ",
   #                        " WHERE pmarent = imaaent AND pmar002 = imaa001 AND pmarent = pmaaent AND pmar001 = pmaa001 ",
   #                        "   AND pmarent=",g_enterprise," AND pmarsite='",g_site,"' AND ", ls_wc
   #   ELSE
   #      LET g_sql = l_sql,"  FROM pmar_t,pmaa_t ",
   #                        " WHERE pmarent = pmaaent AND pmar001 = pmaa001 ",
   #                        "   AND pmarent=",g_enterprise," AND pmarsite='",g_site,"' AND ", ls_wc
   #   END IF
   #
   #ELSE
   #   IF ls_wc.getIndexOf("imaa",1) THEN
   #      LET g_sql = l_sql,"  FROM pmar_t,imaa_t ",
   #                        " WHERE pmarent = imaaent AND pmar002 = imaa001 ",
   #                        "   AND pmarent=",g_enterprise," AND pmarsite='",g_site,"' AND ", ls_wc
   #   ELSE
   #      LET g_sql = l_sql,"  FROM pmar_t ",
   #                        " WHERE pmarent=",g_enterprise," AND pmarsite='",g_site,"' AND ", ls_wc
   #   END IF
   #END IF
   #--MARK--(E)
   
   #營運據點
   IF cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc," AND pmarsite='",g_site,"'"
   END IF
   
   IF ls_wc.getIndexOf("pmaa",1) THEN
      IF ls_wc.getIndexOf("imaa",1) THEN
         LET g_sql = l_sql,"  FROM pmar_t,imaa_t,pmaa_t ",
                           " WHERE pmarent = imaaent AND pmar002 = imaa001 AND pmarent = pmaaent AND pmar001 = pmaa001 ",
                           "   AND pmarent=",g_enterprise," AND ", ls_wc
      ELSE
         LET g_sql = l_sql,"  FROM pmar_t,pmaa_t ",
                           " WHERE pmarent = pmaaent AND pmar001 = pmaa001 ",
                           "   AND pmarent=",g_enterprise," AND ", ls_wc
      END IF

   ELSE
      IF ls_wc.getIndexOf("imaa",1) THEN
         LET g_sql = l_sql,"  FROM pmar_t,imaa_t ",
                           " WHERE pmarent = imaaent AND pmar002 = imaa001 ",
                           "   AND pmarent=",g_enterprise," AND ", ls_wc
      ELSE
         LET g_sql = l_sql,"  FROM pmar_t ",
                           " WHERE pmarent=",g_enterprise," AND ", ls_wc
      END IF
   END IF   
  #--150807--polly--add--(e)
   LET g_sql = g_sql,l_sql_order
   #end add-point

   PREPARE apmq125_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq125_pb
 
    FOREACH b_fill_curs INTO g_pmar_d[l_ac].*
#   FOREACH b_fill_curs INTO g_pmar_d[l_ac].pmar002,g_pmar_d[l_ac].pmar002_desc,g_pmar_d[l_ac].pmar002_desc_desc,
#       g_pmar_d[l_ac].pmar003,g_pmar_d[l_ac].pmar003_desc,g_pmar_d[l_ac].pmar004,g_pmar_d[l_ac].pmar005,g_pmar_d[l_ac].pmar001,g_pmar_d[l_ac].pmar001_desc,
#       g_pmar_d[l_ac].pmar007,g_pmar_d[l_ac].pmar009,g_pmar_d[l_ac].pmar006

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF



      #add-point:b_fill段資料填充

      #end add-point

      CALL apmq125_b_fill_ref()

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


   #add-point:b_fill段資料填充(其他單身)

   #end add-point

   CALL g_pmar_d.deleteElement(g_pmar_d.getLength())
   CALL g_pmar2_d.deleteElement(g_pmar2_d.getLength())


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
   FREE apmq125_pb

#   LET l_ac = 1
#   CALL apmq125_b_fill2()
#
#   CALL apmq125_filter_show('pmar002','b_pmar002')
#   CALL apmq125_filter_show('pmar003','b_pmar003')
#   CALL apmq125_filter_show('pmar004','b_pmar004')
#   CALL apmq125_filter_show('pmar005','b_pmar005')
#   CALL apmq125_filter_show('pmar001','b_pmar001')
#   CALL apmq125_filter_show('pmar007','b_pmar007')
#   CALL apmq125_filter_show('pmar009','b_pmar009')
#   CALL apmq125_filter_show('pmar006','b_pmar006')
#

END FUNCTION

PRIVATE FUNCTION apmq125_b_fill2(p_ac)
   {<Local define>}
   DEFINE p_ac               LIKE type_t.num5
   DEFINE ls_wc           STRING
   {</Local define>}

   IF cl_null(p_ac) OR p_ac = 0 THEN
      RETURN
   END IF
   
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
   #add-point:陣列清空
   CALL g_pmar2_d.clear()
   #end add-point

   # b_fill2段sql組成及FOREACH撰寫
  
   LET g_sql = " SELECT UNIQUE pmarsite,     '',pmar002,     '',     '', ",
               "                pmar003,     '',pmar004,     '',pmar005, ",
               "                pmar001,     '',pmar007,     '',pmar009, ",
               "                     '',pmar006,     '',pmar012,pmar014, ",
               "                     '',pmar015,pmar016,pmar017,pmar018, ",
               "                pmar019,pmar020,'' ",
               "   FROM pmar_t,imaa_t,pmaa_t ",
               "  WHERE pmarent = imaaent AND pmar002 = imaa001 AND pmarent = pmaaent AND pmar001 = pmaa001 ",
  #            "    AND pmarent=",g_enterprise," AND pmarsite='",g_site,"'"    #150807 polly mark
               "    AND pmarent=",g_enterprise                                 #150807 polly add               
  
   #塞入單頭條件
   #--150807--polly--add-(s)
   IF g_argv[01] = 'A' THEN
      IF g_pmar_d[p_ac].pmarsite IS NOT NULL THEN
         LET g_sql = g_sql," AND pmarsite='",g_pmar_d[p_ac].pmarsite,"'"
      END IF
   ELSE
      LET g_sql = g_sql," AND pmarsite='",g_site,"'"
   END IF
   #--150807--polly--add-(e)   
   IF g_pmar_d[p_ac].pmar002 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar002='",g_pmar_d[p_ac].pmar002,"'"
   END IF
   IF g_pmar_d[p_ac].pmar003 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar003='",g_pmar_d[p_ac].pmar003,"'"
   END IF
   IF g_pmar_d[p_ac].pmar004 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar004='",g_pmar_d[p_ac].pmar004,"'"
   END IF
   IF g_pmar_d[p_ac].pmar005 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar005='",g_pmar_d[p_ac].pmar005,"'"
   END IF
   IF g_pmar_d[p_ac].pmar001 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar001='",g_pmar_d[p_ac].pmar001,"'"
   END IF
   IF g_pmar_d[p_ac].pmar007 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar007='",g_pmar_d[p_ac].pmar007,"'"
   END IF
   IF g_pmar_d[p_ac].pmar009 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar009='",g_pmar_d[p_ac].pmar009,"'"
   END IF
   IF g_pmar_d[p_ac].pmar006 IS NOT NULL THEN
      LET g_sql = g_sql," AND pmar006='",g_pmar_d[p_ac].pmar006,"'"
   END IF   
#   #塞入價格類型
#   IF NOT cl_null(tm.pmar000) THEN
#      LET g_sql = g_sql," AND pmar000='",tm.pmar000,"'"
#   END IF
   #組其他條件與排序
   LET g_sql = g_sql," AND ", ls_wc ," AND pmar000 = '",tm.pmar000,"' " 
   LET g_sql = g_sql, " ORDER BY pmarsite,pmar002,pmar003,pmar004,pmar005,pmar019,pmar012"  #150807 polly add pmarsite
   
   PREPARE apmq125_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apmq125_pb2
   LET l_ac2 = 1
   FOREACH b_fill_curs2 INTO g_pmar2_d[l_ac2].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
           
      CALL apmq125_b_fill2_ref()
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   LET g_cnt2 = l_ac2 - 1
   CALL g_pmar2_d.deleteElement(l_ac2)

END FUNCTION

PRIVATE FUNCTION apmq125_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point0

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)



   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL g_pmar_d.clear()
   CALL g_pmar2_d.clear()

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON pmarsite,pmar002,pmar003,pmar004,pmar005,pmar001,pmar007,pmar009,pmar006  #150807 polly add pmarsite
                          FROM s_detail1[1].b_pmarsite,s_detail1[1].b_pmar002,s_detail1[1].b_pmar003,    #150807 polly add pmarsite
                                s_detail1[1].b_pmar004,s_detail1[1].b_pmar005,s_detail1[1].b_pmar001,
                                s_detail1[1].b_pmar007,s_detail1[1].b_pmar009,s_detail1[1].b_pmar006

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            DISPLAY apmq125_filter_parser('pmarsite') TO s_detail1[1].b_pmarsite    #150807 polly add
            DISPLAY apmq125_filter_parser('pmar002') TO s_detail1[1].b_pmar002
            DISPLAY apmq125_filter_parser('pmar003') TO s_detail1[1].b_pmar003
            DISPLAY apmq125_filter_parser('pmar004') TO s_detail1[1].b_pmar004
            DISPLAY apmq125_filter_parser('pmar005') TO s_detail1[1].b_pmar005
            DISPLAY apmq125_filter_parser('pmar001') TO s_detail1[1].b_pmar001
            DISPLAY apmq125_filter_parser('pmar007') TO s_detail1[1].b_pmar007
            DISPLAY apmq125_filter_parser('pmar009') TO s_detail1[1].b_pmar009
            DISPLAY apmq125_filter_parser('pmar006') TO s_detail1[1].b_pmar006
            
            ON ACTION controlp INFIELD b_pmar002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_pmar002      #顯示到畫面上
               NEXT FIELD b_pmar002                         #返回原欄位

            ON ACTION controlp INFIELD b_pmar003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmar003()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_pmar003      #顯示到畫面上
               NEXT FIELD b_pmar003                         #返回原欄位

            ON ACTION controlp INFIELD b_pmar001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_pmar001      #顯示到畫面上
               NEXT FIELD b_pmar001                         #返回原欄位

            ON ACTION controlp INFIELD b_pmar006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooca001_1()                            #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_pmar006      #顯示到畫面上
               NEXT FIELD b_pmar006                         #返回原欄位

            ON ACTION controlp INFIELD b_pmar007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_ooaj002_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_pmar007      #顯示到畫面上
               NEXT FIELD b_pmar007                         #返回原欄位

            ON ACTION controlp INFIELD b_pmar009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_oodb002_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_pmar009      #顯示到畫面上
               NEXT FIELD b_pmar009                         #返回原欄位

           #--150807--polly--add-(s) 
            ON ACTION controlp INFIELD pmarsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmarsite()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmarsite      #顯示到畫面上
               NEXT FIELD pmarsite                         #返回原欄位            
           #--150807--polly--add-(e)

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

#   CALL apmq125_filter_show('pmar002','b_pmar002')
#   CALL apmq125_filter_show('pmar003','b_pmar003')
#   CALL apmq125_filter_show('pmar004','b_pmar004')
#   CALL apmq125_filter_show('pmar005','b_pmar005')
#   CALL apmq125_filter_show('pmar001','b_pmar001')
#   CALL apmq125_filter_show('pmar007','b_pmar007')
#   CALL apmq125_filter_show('pmar009','b_pmar009')
#   CALL apmq125_filter_show('pmar006','b_pmar006')

   CALL apmq125_b_fill()

   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)

END FUNCTION

PRIVATE FUNCTION apmq125_filter_parser(ps_field)
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

PRIVATE FUNCTION apmq125_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq125_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION

################################################################################
# Descriptions...: 依據左邊查詢條件頁籤的資料顯示維度選項動態隱藏欄位
# Memo...........:
# Usage..........: CALL apmq125_comp_visible()
#                  
# Input parameter: 
#                :
# Return code....: 
#                : 
# Date & Author..: 14/07/15 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq125_comp_visible()

   #資料清單區塊欄位隱藏
   CALL cl_set_comp_visible("b_pmarsite,b_pmarsite_desc",TRUE)                      #150807 polly add
   CALL cl_set_comp_visible("b_pmar002,b_pmar002_desc,b_pmar002_desc_desc",TRUE)
   CALL cl_set_comp_visible("b_pmar003,b_pmar003_desc,b_pmar004,b_pmar004_desc,b_pmar005,b_pmar001,b_pmar001_desc",TRUE)
   CALL cl_set_comp_visible("b_pmar007,b_pmar007_desc,b_pmar009,b_pmar009_desc,b_pmar006,b_pmar006_desc",TRUE)   
   #最近採購單價資訊頁籤隱藏
   CALL cl_set_comp_visible("l_pmarsite,l_pmarsite_desc",TRUE)  #150807 polly add
   CALL cl_set_comp_visible("l_pmar002,l_pmar002_desc,l_pmar002_desc_desc,l_pmar003,l_pmar003_desc",TRUE)
   CALL cl_set_comp_visible("l_pmar004,l_pmar004_desc,l_pmar005,l_pmar001,l_pmar001_desc,l_pmar007,l_pmar007_desc",TRUE)
   CALL cl_set_comp_visible("l_pmar009,l_pmar009_desc,l_pmar006,l_pmar006_desc,l_pmar012,l_pmar014,l_pmar014_desc",TRUE)
   CALL cl_set_comp_visible("l_pmar015,l_pmar016,l_pmar017,l_pmar018,l_pmar019,l_pmar020,l_pmar020_desc",TRUE)

   #--polly--add--(s)
   IF g_argv[01] = 'A' THEN
      IF tm.l_pmarsite_1 = 'Y' THEN  #料件編號
         CALL cl_set_comp_visible("l_pmarsite,l_pmarsite_desc",FALSE)
      ELSE
         CALL cl_set_comp_visible("b_pmarsite,b_pmarsite_desc",FALSE)
      END IF   
   ELSE
      CALL cl_set_comp_visible("l_pmarsite,l_pmarsite_desc",FALSE)
      CALL cl_set_comp_visible("b_pmarsite,b_pmarsite_desc",FALSE)
   END IF   
   #--polly--add--(e)
   
   IF tm.l_pmar002_1 = 'Y' THEN  #料件編號
      CALL cl_set_comp_visible("l_pmar002,l_pmar002_desc,l_pmar002_desc_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar002,b_pmar002_desc,b_pmar002_desc_desc",FALSE)
   END IF
   
   IF tm.l_pmar004_1 = 'Y' THEN  #作業編號
      CALL cl_set_comp_visible("l_pmar004,l_pmar004_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar004,b_pmar004_desc",FALSE)
   END IF
   
   IF tm.l_pmar001_1 = 'Y' THEN  #供應商編號
      CALL cl_set_comp_visible("l_pmar001,l_pmar001_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar001,b_pmar001_desc",FALSE)
   END IF
   
   IF tm.l_pmar007_1 = 'Y' THEN  #幣別
      CALL cl_set_comp_visible("l_pmar007,l_pmar007_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar007,b_pmar007_desc",FALSE)   
   END IF
   
   IF tm.l_pmar003_1 = 'Y' THEN  #產品特徵
      CALL cl_set_comp_visible("l_pmar003,l_pmar003_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar003,b_pmar003_desc",FALSE)
   END IF
   
   IF tm.l_pmar005_1 = 'Y' THEN  #製程序
      CALL cl_set_comp_visible("l_pmar005",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar005",FALSE)
   END IF
   
   IF tm.l_pmar006_1 = 'Y' THEN  #計價單位
      CALL cl_set_comp_visible("l_pmar006,l_pmar006_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar006,b_pmar006_desc",FALSE)   
   END IF
   
   IF tm.l_pmar009_1 = 'Y' THEN  #稅別
      CALL cl_set_comp_visible("l_pmar009,l_pmar009_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_pmar009,b_pmar009_desc",FALSE)   
   END IF
   
   #mod-----shiun-----141212---(S)
   IF tm.pmar000 = 'N' THEN
      CALL cl_set_comp_visible("l_pmar004,l_pmar004_desc,l_pmar005",FALSE)
   END IF
   #mod-----shiun-----141212---(S)

END FUNCTION

################################################################################
# Descriptions...: 單頭reference
# Memo...........:
# Usage..........: CALL apmq125_b_fill_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/07/15 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq125_b_fill_ref()
DEFINE l_success  LIKE type_t.num5

   #--150807--polly--add--(s)
   LET g_pmar_d[l_ac].pmarsite_desc = s_desc_get_department_desc(g_pmar_d[l_ac].pmarsite)
   DISPLAY BY NAME g_pmar_d[l_ac].pmarsite_desc
   #--150807--polly--add--(e)
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar_d[l_ac].pmar002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar_d[l_ac].pmar002_desc = '', g_rtn_fields[1] , ''
   LET g_pmar_d[l_ac].pmar002_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_pmar_d[l_ac].pmar002_desc
   DISPLAY BY NAME g_pmar_d[l_ac].pmar002_desc_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar_d[l_ac].pmar004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221'  AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar_d[l_ac].pmar004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar_d[l_ac].pmar004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar_d[l_ac].pmar001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar_d[l_ac].pmar001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar_d[l_ac].pmar001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar_d[l_ac].pmar007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar_d[l_ac].pmar007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar_d[l_ac].pmar007_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar_d[l_ac].pmar007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar_d[l_ac].pmar007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar_d[l_ac].pmar007_desc
   
   CALL s_desc_get_tax_desc1(g_site,g_pmar_d[l_ac].pmar009) RETURNING g_pmar_d[l_ac].pmar009_desc
   DISPLAY BY NAME g_pmar_d[l_ac].pmar009_desc
   
   CALL s_desc_get_unit_desc(g_pmar_d[l_ac].pmar006) RETURNING g_pmar_d[l_ac].pmar006_desc
   DISPLAY BY NAME g_pmar_d[l_ac].pmar006_desc
   
   CALL s_feature_description(g_pmar_d[l_ac].pmar002,g_pmar_d[l_ac].pmar003) RETURNING l_success,g_pmar_d[l_ac].pmar003_desc
END FUNCTION

################################################################################
# Descriptions...: 單身reference
# Memo...........:
# Usage..........: CALL apmq125_b_fill2_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/07/15 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq125_b_fill2_ref()
DEFINE l_success  LIKE type_t.num5

   #--150807--polly--add--(s)
   LET g_pmar2_d[l_ac2].l_pmarsite_desc = s_desc_get_department_desc(g_pmar2_d[l_ac2].l_pmarsite)
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmarsite_desc
   #--150807--polly--add--(e)      
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar2_d[l_ac2].l_pmar002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar2_d[l_ac2].l_pmar002_desc = '', g_rtn_fields[1] , ''
   LET g_pmar2_d[l_ac2].l_pmar002_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar002_desc
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar002_desc_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar2_d[l_ac2].l_pmar004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221'  AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar2_d[l_ac2].l_pmar004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar004_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar2_d[l_ac2].l_pmar001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? ","") RETURNING g_rtn_fields
   LET g_pmar2_d[l_ac2].l_pmar001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar2_d[l_ac2].l_pmar007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmar2_d[l_ac2].l_pmar007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar007_desc
   
   CALL s_desc_get_tax_desc1(g_site,g_pmar2_d[l_ac2].l_pmar009) RETURNING g_pmar2_d[l_ac2].l_pmar009_desc
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar009_desc
   
   CALL s_desc_get_unit_desc(g_pmar2_d[l_ac2].l_pmar006) RETURNING g_pmar2_d[l_ac2].l_pmar006_desc
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar006_desc
   
   CALL s_desc_get_unit_desc(g_pmar2_d[l_ac2].l_pmar014) RETURNING g_pmar2_d[l_ac2].l_pmar014_desc
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar014_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmar2_d[l_ac2].l_pmar020
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pmar2_d[l_ac2].l_pmar020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmar2_d[l_ac2].l_pmar020_desc

   CALL s_feature_description(g_pmar2_d[l_ac2].l_pmar002,g_pmar2_d[l_ac2].l_pmar003) RETURNING l_success,g_pmar2_d[l_ac2].l_pmar003_desc

END FUNCTION

################################################################################
# Descriptions...: 清除畫面資料與條件
# Memo...........:
# Usage..........: CALL apmq125_qbeclear()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/07/16 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq125_qbeclear()
   CLEAR FORM
   CALL g_pmar_d.clear()
   CALL g_pmar2_d.clear()
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc_filter TO NULL
   #價格類型預設
   LET tm.pmar000 = 'N'
   
   #--150807--polly--add--(s)   
   IF g_argv[01] = 'A' THEN
      LET tm.l_pmarsite_1 = 'Y'         
   ELSE
      LET tm.l_pmarsite_1 = 'N'                   
   END IF   
   #--150807--polly--add--(e)   
   
   #單頭資料內容預設勾選料件編號
   LET tm.l_pmar002_1 = 'Y'
   LET tm.l_pmar004_1 = 'N'
   LET tm.l_pmar001_1 = 'N'
   LET tm.l_pmar007_1 = 'N'
   LET tm.l_pmar003_1 = 'N'
   LET tm.l_pmar005_1 = 'N'
   LET tm.l_pmar006_1 = 'N'
   LET tm.l_pmar009_1 = 'N'
END FUNCTION

PRIVATE FUNCTION apmq125_set_entry()
   CALL cl_set_comp_entry('l_pmar004_1,l_pmar005_1',TRUE)
END FUNCTION

PRIVATE FUNCTION apmq125_set_no_entry()
   IF tm.pmar000 = 'N' THEN
      LET tm.l_pmar004_1 = 'N'
      LET tm.l_pmar005_1 = 'N'
      CALL cl_set_comp_entry('l_pmar004_1,l_pmar005_1',FALSE)
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
