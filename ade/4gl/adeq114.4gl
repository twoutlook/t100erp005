#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq114.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-01-27 18:20:20), PR版次:0005(2016-11-18 09:41:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: adeq114
#+ Description: 門店管理品類日銷售預算查詢作業
#+ Creator....: 02749(2015-07-09 02:44:38)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="adeq114.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#52  2016/04/27  By 07673      將重複內容的錯誤訊息置換為公用錯誤訊息
#161117-00022#1   2016/11/18  By lori       筆數相關變數型態定義改為NUM10
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
DEFINE g_master RECORD
           l_sale_qbe               LIKE rtca_t.rtca001,
           l_sale_qbe_desc          LIKE rtcal_t.rtcal003,
           l_gross_profit_qbe       LIKE rtca_t.rtca001,
           l_gross_profit_desc      LIKE rtcal_t.rtcal003
                END RECORD

DEFINE g_master_t RECORD
           l_sale_qbe               LIKE rtca_t.rtca001,
           l_sale_qbe_desc          LIKE rtcal_t.rtcal003,
           l_gross_profit_qbe       LIKE rtca_t.rtca001,
           l_gross_profit_desc      LIKE rtcal_t.rtcal003
                END RECORD
                
DEFINE g_org_dept_d   DYNAMIC ARRAY OF RECORD
           oogc003                LIKE oogc_t.oogc003,
           rtcdsite               LIKE rtcd_t.rtcdsite,
           rtcdsite_desc          LIKE ooefl_t.ooefl003,
           rtcd002                LIKE rtcd_t.rtcd002,
           rtcd002_desc           LIKE ooefl_t.ooefl003,
           rtcd003                LIKE rtcd_t.rtcd003,
           rtcd003_desc           LIKE rtaxl_t.rtaxl003,
           l_proportion           LIKE type_t.chr30,       #每天權重,需要FORMAT,故宣告為char
           l_sale                 LIKE type_t.num20_6,
           l_gross_profit         LIKE type_t.num20_6,
           l_gross_profit_margin  LIKE type_t.chr30        #毛利率,需要FORMAT,故宣告為char
                   END RECORD

DEFINE g_org_dept_sum_d   DYNAMIC ARRAY OF RECORD
           rtcdsite_1               LIKE rtcd_t.rtcdsite,
           rtcdsite_desc_1          LIKE ooefl_t.ooefl003,
           rtcd002_1                LIKE rtcd_t.rtcd002,
           rtcd002_desc_1           LIKE ooefl_t.ooefl003,
           rtcd003_1                LIKE rtcd_t.rtcd003,
           rtcd003_desc_1           LIKE rtaxl_t.rtaxl003,
           l_sale_1                 LIKE type_t.num20_6,
           l_gross_profit_1         LIKE type_t.num20_6,
           l_gross_profit_margin_1  LIKE type_t.chr30        #毛利率,需要FORMAT,故宣告為char
                   END RECORD  
                   
DEFINE g_org_d   DYNAMIC ARRAY OF RECORD
           oogc003_2                LIKE oogc_t.oogc003,
           rtcdsite_2               LIKE rtcd_t.rtcdsite,
           rtcdsite_desc_2          LIKE ooefl_t.ooefl003,
           rtcd003_2                LIKE rtcd_t.rtcd003,
           rtcd003_desc_2           LIKE rtaxl_t.rtaxl003,
           l_sale_2                 LIKE type_t.num20_6,
           l_gross_profit_2         LIKE type_t.num20_6,
           l_gross_profit_margin_2  LIKE type_t.chr30        #毛利率,需要FORMAT,故宣告為char
                   END RECORD  

DEFINE g_org_sum_d   DYNAMIC ARRAY OF RECORD
           rtcdsite_3               LIKE rtcd_t.rtcdsite,
           rtcdsite_desc_3          LIKE ooefl_t.ooefl003,
           rtcd003_3                LIKE rtcd_t.rtcd003,
           rtcd003_desc_3           LIKE rtaxl_t.rtaxl003,
           l_sale_3                 LIKE type_t.num20_6,
           l_gross_profit_3         LIKE type_t.num20_6,
           l_gross_profit_margin_3  LIKE type_t.chr30        #毛利率,需要FORMAT,故宣告為char
                   END RECORD 
                   
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
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數           #161117-00022#1 161118 by lori mod:num5 to num10
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10

DEFINE g_rtdx004   LIKE type_t.chr10

 
    
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="adeq114.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5  #150922-00001#3 20150923 S983961--ADD  
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:作業初始化 name="main.init"
   CALL adeq114_create_temp()
   LET g_rtdx004 = cl_get_para(g_enterprise,"","E-CIR-0001")
   CALL s_aooi500_create_temp() RETURNING l_success  #150922-00001#3 20150923 S983961--ADD
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE adeq114_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq114 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adeq114_init()
 
      #進入選單 Menu (='N')
      CALL adeq114_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_adeq114
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL adeq114_drop_temp()
   CALL s_aooi500_drop_temp() RETURNING l_success  #150922-00001#3 20150923 S983961--ADD
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="adeq114.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION adeq114_init()

   LET g_error_show = 1
   LET g_errshow = 1
   
   CALL adeq114_default_search()

END FUNCTION

PRIVATE FUNCTION adeq114_ui_dialog()
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING

   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL adeq114_data_process(g_wc) 
      LET g_detail_idx = 1
      CALL adeq114_b_fill(g_wc2)    
   ELSE
      CALL adeq114_query()
   END IF
   
  
   
   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_idx = 1

   WHILE TRUE

      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_org_dept_d.clear()
         CALL g_org_dept_sum_d.clear()
         CALL g_org_d.clear()
         CALL g_org_sum_d.clear()

         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL adeq114_init()
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_org_dept_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               #LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               
               CALL cl_show_fld_cont()
               
               CALL cl_user_overview_set_follow_pic()

         END DISPLAY

         DISPLAY ARRAY g_org_dept_sum_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               #LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont()
               
               CALL cl_user_overview_set_follow_pic()
         END DISPLAY
         
         DISPLAY ARRAY g_org_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               #LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont()
               
               CALL cl_user_overview_set_follow_pic()
         END DISPLAY
         
         DISPLAY ARRAY g_org_sum_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               #LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont()
               
               CALL cl_user_overview_set_follow_pic()
         END DISPLAY

         BEFORE DIALOG
            #IF g_temp_idx > 0 THEN
            #   LET l_ac = g_temp_idx
            #   CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            #   LET g_temp_idx = 1
            #END IF
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            CALL DIALOG.setSelectionMode("s_detail3", 1)
            CALL DIALOG.setSelectionMode("s_detail4", 1)

            NEXT FIELD CURRENT

         #ON ACTION insert
         #   LET g_action_choice="insert"
         #   IF cl_auth_chk_act("insert") THEN
         #      CALL adeq114_insert()
         #
         #   END IF
            
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

            END IF

         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adeq114_query()
               
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
            END IF

         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN

            END IF
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_org_dept_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_org_dept_sum_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_org_d)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_org_sum_d)
               LET g_export_id[4]   = "s_detail4"
               
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice="exit"
            CANCEL DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG

         ON ACTION related_document
            IF cl_auth_chk_act("related_document") THEN

               CALL cl_doc()
            END IF

         ON ACTION agendum

            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()

         ON ACTION followup
            CALL cl_user_overview_follow('')



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

PRIVATE FUNCTION adeq114_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING

   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_org_dept_d.clear()

   LET g_qryparam.state = "c"

   #wc備份
   LET ls_wc = g_wc2

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_master.l_sale_qbe, g_master.l_gross_profit_qbe ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD l_sale_qbe
            IF NOT cl_null(g_master.l_sale_qbe) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.l_sale_qbe
               LET g_errshow = TRUE   #160318-00025#52
               LET g_chkparam.err_str[1] = "art-00050:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"    #160318-00025#52
               IF NOT cl_chk_exist("v_rtca001") THEN
                  LET g_master.l_sale_qbe = g_master_t.l_sale_qbe
                  LET g_master.l_sale_qbe_desc = adeq114_rtca001_ref(g_master.l_sale_qbe)
                  DISPLAY BY NAME  g_master.l_sale_qbe,g_master.l_sale_qbe_desc  
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.l_sale_qbe_desc = adeq114_rtca001_ref(g_master.l_sale_qbe)
            DISPLAY BY NAME  g_master.l_sale_qbe,g_master.l_sale_qbe_desc  
            
         AFTER FIELD l_gross_profit_qbe
            IF NOT cl_null(g_master.l_gross_profit_qbe) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.l_gross_profit_qbe
               LET g_errshow = TRUE   #160318-00025#52
               LET g_chkparam.err_str[1] = "art-00050:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"    #160318-00025#52
               IF NOT cl_chk_exist("v_rtca001") THEN
                  LET g_master.l_gross_profit_qbe = g_master_t.l_gross_profit_qbe
                  LET g_master.l_gross_profit_desc = adeq114_rtca001_ref(g_master.l_gross_profit_qbe)
                  DISPLAY BY NAME  g_master.l_gross_profit_qbe,g_master.l_gross_profit_desc  
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.l_gross_profit_desc = adeq114_rtca001_ref(g_master.l_gross_profit_qbe)
            DISPLAY BY NAME  g_master.l_gross_profit_qbe,g_master.l_gross_profit_desc  
         
         ON ACTION controlp INFIELD l_sale_qbe
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001()                          
            LET g_master.l_sale_qbe = g_qryparam.return1
            LET g_master.l_sale_qbe_desc = adeq114_rtca001_ref(g_master.l_sale_qbe)
            
            DISPLAY BY NAME  g_master.l_sale_qbe,g_master.l_sale_qbe_desc  
            
            NEXT FIELD l_sale_qbe 
            
         ON ACTION controlp INFIELD l_gross_profit_qbe
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001()                          
            LET g_master.l_gross_profit_qbe = g_qryparam.return1
            LET g_master.l_gross_profit_desc = adeq114_rtca001_ref(g_master.l_gross_profit_qbe)
            DISPLAY g_master.l_gross_profit_qbe TO l_gross_profit_qbe
            DISPLAY g_master.l_gross_profit_desc TO l_gross_profit_desc 
            
            NEXT FIELD l_gross_profit_qbe          
      END INPUT      
      
      CONSTRUCT g_wc2 ON oogc003,rtcdsite,rtcd002,rtcd003
         
         FROM s_detail1[1].oogc003,s_detail1[1].rtcdsite,s_detail1[1].rtcd002,s_detail1[1].rtcd003
              
         BEFORE CONSTRUCT
            DISPLAY g_site TO rtcdsite
            
         BEFORE FIELD oogc003
         
         AFTER FIELD oogc003
         
         ON ACTION controlp INFIELD oogc003
         
         ON ACTION controlp INFIELD rtcdsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtcdsite',g_site,'c')
            CALL q_ooef001_24()                     
            DISPLAY g_qryparam.return1 TO rtcdsite  
            
            NEXT FIELD rtcdsite      
            
         BEFORE FIELD rtcdsite
         
         AFTER FIELD rtcdsite
         
         BEFORE FIELD rtcd001
         
         AFTER FIELD rtcd001
         
         ON ACTION controlp INFIELD rtcd001
         
         ON ACTION controlp INFIELD rtcd002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       
            DISPLAY g_qryparam.return1 TO rtcd002  
            
            NEXT FIELD rtcd002 
            
         BEFORE FIELD rtcd002
         
         AFTER FIELD rtcd002
         
         ON ACTION controlp INFIELD rtcd003         
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004 = '",g_rtdx004,"' "
            CALL q_rtax001_1()                     
            DISPLAY g_qryparam.return1 TO rtcd003
            
            NEXT FIELD rtcd003 
            
         BEFORE FIELD rtcd003
         
         AFTER FIELD rtcd003
                    
      END CONSTRUCT
      
      BEFORE DIALOG
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc

      ON ACTION qbe_save
         CALL cl_qbe_save()

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG
   END DIALOG
   

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF

   CALL adeq114_data_process(g_wc2) 
   CALL adeq114_b_fill(g_wc2)
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = -100
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF

   LET INT_FLAG = FALSE

END FUNCTION

PRIVATE FUNCTION adeq114_b_fill(p_wc2)
   DEFINE p_wc2    STRING
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   


   #門店部門日報
   #150826-00013#2 20150902 s983961--mark(s) 效能調整
   #LET g_sql = "SELECT oogc003,org,t1.ooefl003,dept,t2.ooefl003, ",
   #            "       rtax001,t3.rtaxl003,proportion,sale,gross_profit, ",
   #            "       gross_profit_margin ",
   #            "  FROM adeq114_tmp ",
   #            "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = ",g_enterprise,
   #            "                           AND t1.ooefl001 = org AND t1.ooefl002 ='",g_dlang,"' ",
   #            "       LEFT JOIN ooefl_t t2 ON t2.ooeflent = ",g_enterprise,
   #            "                           AND t2.ooefl001 = dept AND t2.ooefl002 ='",g_dlang,"' ",
   #            "       LEFT JOIN rtaxl_t t3 ON t3.rtaxlent = ",g_enterprise,
   #            "                           AND t3.rtaxl001 = rtax001 AND t3.rtaxl002 ='",g_dlang,"' " ,
   #            " ORDER BY oogc003,org,dept,rtax001 "           
   #LET g_sql = cl_sql_add_mask(g_sql)                       #遮蔽特定資料
   #PREPARE adeq114_pb FROM g_sql
   #DECLARE b_fill_curs CURSOR FOR adeq114_pb
   #150826-00013#2 20150902 s983961--mark(e) 效能調整
   
   #150826-00013#2 20150902 s983961--add(s) 效能調整
   LET g_sql = "SELECT oogc003, ",
               "       org,     ",
               "       (SELECT ooefl003 FROM ooefl_t ",
               "         WHERE ooeflent =",g_enterprise,
               "           AND ooefl001 = org ",
               "           AND ooefl002 ='"||g_dlang||"') org_desc,",
               "       dept,    ",
               "       (SELECT ooefl003 FROM ooefl_t ",
               "         WHERE ooeflent = ",g_enterprise,
               "           AND ooefl001 = dept ",
               "           AND ooefl002 ='"||g_dlang||"') dept_desc,",
               "       rtax001, ",
               "       (SELECT rtaxl003 FROM rtaxl_t ",
               "         WHERE rtaxlent = ",g_enterprise,
               "           AND rtaxl001 = rtax001 ",
               "           AND rtaxl002 ='"||g_dlang||"') rtaxl003,",
               "       proportion, ",
               "       sale,      ",
               "       gross_profit, ",
               "       gross_profit_margin ",
               "  FROM adeq114_tmp ",
               " ORDER BY oogc003,org,dept,rtax001 "
   LET g_sql = cl_sql_add_mask(g_sql)                       #遮蔽特定資料
   PREPARE adeq114_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq114_pb
   #150826-00013#2 20150902 s983961--add(e) 效能調整
   
   
   #門店部門彙總 
   #150826-00013#2 20150902 s983961--mark(s) 效能調整
   #LET g_sql = "SELECT org,t1.ooefl003,dept,t2.ooefl003, ",
   #            "              rtax001,t3.rtaxl003,SUM(COALESCE(sale,0)) sale,SUM(COALESCE(gross_profit,0)) gross_profit ",
   #            "         FROM adeq114_tmp ",
   #            "              LEFT JOIN ooefl_t t1 ON t1.ooeflent = ",g_enterprise,
   #            "                                  AND t1.ooefl001 = org AND t1.ooefl002 ='",g_dlang,"' ",
   #            "              LEFT JOIN ooefl_t t2 ON t2.ooeflent = ",g_enterprise,
   #            "                                  AND t2.ooefl001 = dept AND t2.ooefl002 ='",g_dlang,"' ",
   #            "              LEFT JOIN rtaxl_t t3 ON t3.rtaxlent = ",g_enterprise,
   #            "                                  AND t3.rtaxl001 = rtax001 AND t3.rtaxl002 ='",g_dlang,"' ",
   #            " GROUP BY org,t1.ooefl003,dept,t2.ooefl003,rtax001,t3.rtaxl003 ",
   #            " ORDER BY org,dept,rtax001 "
   #150826-00013#2 20150902 s983961--mark(e) 效能調整     

   #150826-00013#2 20150902 s983961--add(s) 效能調整
   LET g_sql = "SELECT org,",
             "       (SELECT ooefl003 FROM ooefl_t ",
             "         WHERE ooeflent =",g_enterprise,
             "           AND ooefl001 = org ",
             "           AND ooefl002 ='"||g_dlang||"') org_desc,",
             "        dept, ",
             "       (SELECT ooefl003 FROM ooefl_t ",
             "         WHERE ooeflent = ",g_enterprise,
             "           AND ooefl001 = dept ",
             "           AND ooefl002 ='"||g_dlang||"') dept_desc,",
             "       rtax001, ",
             "       (SELECT rtaxl003 FROM rtaxl_t ",
             "         WHERE rtaxlent = ",g_enterprise,
             "           AND rtaxl001 = rtax001 ",
             "           AND rtaxl002 ='"||g_dlang||"') rtaxl003,",
             "       sale,       ",
             "       gross_profit ",
             "  FROM ", 
             "       (SELECT org, ",               
             "              dept, ",
             "              rtax001, ",
             "              SUM(COALESCE(sale,0)) sale, ",
             "              SUM(COALESCE(gross_profit,0)) gross_profit ",
             "         FROM adeq114_tmp ",
             "        GROUP BY org,dept,rtax001 ",
             "        ORDER BY org,dept,rtax001) "
   #150826-00013#2 20150902 s983961--add(e) 效能調整     
   LET g_sql = cl_sql_add_mask(g_sql)                       #遮蔽特定資料
   PREPARE adeq114_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR adeq114_pb1
   
   #門店日報
   #150826-00013#2 20150902 s983961--mark(s) 效能調整
   #LET g_sql = "SELECT oogc003,org,t1.ooefl003,rtax001,t2.rtaxl003, ",
   #            "              SUM(COALESCE(sale,0)) sale,SUM(COALESCE(gross_profit,0)) gross_profit ",
   #            "         FROM adeq114_tmp ",
   #            "              LEFT JOIN ooefl_t t1 ON t1.ooeflent = ",g_enterprise,
   #            "                                  AND t1.ooefl001 = org AND t1.ooefl002 ='",g_dlang,"' ",
   #            "              LEFT JOIN rtaxl_t t2 ON t2.rtaxlent = ",g_enterprise,
   #            "                                  AND t2.rtaxl001 = rtax001 AND t2.rtaxl002 ='",g_dlang,"' ", 
   #            " GROUP BY oogc003,org,t1.ooefl003,rtax001,t2.rtaxl003 ",
   #            " ORDER BY oogc003,org,rtax001 "
   #150826-00013#2 20150902 s983961--mark(e) 效能調整
   
   #150826-00013#2 20150902 s983961--add(s) 效能調整
   LET g_sql = "SELECT oogc003, ",
               "       org, ",
               "       (SELECT ooefl003 FROM ooefl_t ",
               "         WHERE ooeflent =",g_enterprise,
               "           AND ooefl001 = org ",
               "           AND ooefl002 ='"||g_dlang||"') org_desc,",   
               "       rtax001, ",
               "       (SELECT rtaxl003 FROM rtaxl_t ",
               "         WHERE rtaxlent = ",g_enterprise,
               "           AND rtaxl001 = rtax001 ",
               "           AND rtaxl002 ='"||g_dlang||"') rtaxl003,",
               "       sale, ",
               "       gross_profit ",        
               "  FROM ",
               "      (SELECT oogc003, ",
               "              org,     ",
               "              rtax001, ",
               "              SUM(COALESCE(sale,0)) sale, ",
               "              SUM(COALESCE(gross_profit,0)) gross_profit ",
               "         FROM adeq114_tmp ",
               "       GROUP BY oogc003,org,rtax001 ",
               "       ORDER BY oogc003,org,rtax001) "
   #150826-00013#2 20150902 s983961--add(e) 效能調整
   LET g_sql = cl_sql_add_mask(g_sql)                       #遮蔽特定資料
   PREPARE adeq114_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR adeq114_pb2
   
   #門店彙總
   #150826-00013#2 20150902 s983961--mark(s) 效能調整
   #LET g_sql = "SELECT org,t1.ooefl003,rtax001,t2.rtaxl003, ",
   #            "               SUM(COALESCE(sale,0)) sale,SUM(COALESCE(gross_profit,0)) gross_profit",
   #            "          FROM adeq114_tmp ",
   #            "               LEFT JOIN ooefl_t t1 ON t1.ooeflent = ",g_enterprise,
   #            "                                   AND t1.ooefl001 = org AND t1.ooefl002 ='",g_dlang,"' ",
   #            "               LEFT JOIN rtaxl_t t2 ON t2.rtaxlent = ",g_enterprise,
   #            "                                   AND t2.rtaxl001 = rtax001 AND t2.rtaxl002 ='",g_dlang,"' ", 
   #            " GROUP BY org,t1.ooefl003,rtax001,t2.rtaxl003 ",
   #            " ORDER BY org,rtax001 "
   #150826-00013#2 20150902 s983961--mark(e) 效能調整    
   
   #150826-00013#2 20150902 s983961--add(s) 效能調整
   LET g_sql = "SELECT org, ",
               "       (SELECT ooefl003 FROM ooefl_t ",
               "         WHERE ooeflent =",g_enterprise,
               "           AND ooefl001 = org ",
               "           AND ooefl002 ='"||g_dlang||"') org_desc,",   
               "       rtax001, ",
               "       (SELECT rtaxl003 FROM rtaxl_t ",
               "         WHERE rtaxlent = ",g_enterprise,
               "           AND rtaxl001 = rtax001 ",
               "           AND rtaxl002 ='"||g_dlang||"') rtaxl003,",
               "       sale, ",
               "       gross_profit ",        
               "  FROM ",
               "      (SELECT org, ",
               "             rtax001, ",
               "             SUM(COALESCE(sale,0)) sale, ",
               "             SUM(COALESCE(gross_profit,0)) gross_profit",
               "        FROM adeq114_tmp ",
               "       GROUP BY org,rtax001 ",
               "       ORDER BY org,rtax001) "
   #150826-00013#2 20150902 s983961--add(e) 效能調整       
   LET g_sql = cl_sql_add_mask(g_sql)                       #遮蔽特定資料
   PREPARE adeq114_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR adeq114_pb3
   
   CALL g_org_dept_d.clear()
   CALL g_org_dept_sum_d.clear()
   CALL g_org_d.clear()
   CALL g_org_sum_d.clear()

   LET g_cnt = l_ac
   
   #門店部門日報
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_org_dept_d[l_ac].oogc003 ,       g_org_dept_d[l_ac].rtcdsite,          g_org_dept_d[l_ac].rtcdsite_desc,
                            g_org_dept_d[l_ac].rtcd002 ,       g_org_dept_d[l_ac].rtcd002_desc ,     g_org_dept_d[l_ac].rtcd003,
                            g_org_dept_d[l_ac].rtcd003_desc ,  g_org_dept_d[l_ac].l_proportion ,     g_org_dept_d[l_ac].l_sale,
                            g_org_dept_d[l_ac].l_gross_profit ,g_org_dept_d[l_ac].l_gross_profit_margin

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF      
      
      IF cl_null(g_org_dept_d[l_ac].l_proportion) THEN            LET g_org_dept_d[l_ac].l_proportion = 0            END IF
      IF cl_null(g_org_dept_d[l_ac].l_sale) THEN                  LET g_org_dept_d[l_ac].l_sale = 0                  END IF
      IF cl_null(g_org_dept_d[l_ac].l_gross_profit) THEN          LET g_org_dept_d[l_ac].l_gross_profit = 0          END IF
      IF cl_null(g_org_dept_d[l_ac].l_gross_profit_margin) THEN   LET g_org_dept_d[l_ac].l_gross_profit_margin = 0   END IF
             
      LET g_org_dept_d[l_ac].l_proportion = g_org_dept_d[l_ac].l_proportion USING "---&.&&%"  
      LET g_org_dept_d[l_ac].l_gross_profit_margin = g_org_dept_d[l_ac].l_gross_profit_margin USING "---&.&&%" 
      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1

   END FOREACH
   
   CALL g_org_dept_d.deleteElement(g_org_dept_d.getLength())
   CLOSE b_fill_curs
   FREE adeq114_pb
   
   #門店部門彙總
   LET l_ac = 1
   FOREACH b_fill_curs1 INTO g_org_dept_sum_d[l_ac].rtcdsite_1,      g_org_dept_sum_d[l_ac].rtcdsite_desc_1,  g_org_dept_sum_d[l_ac].rtcd002_1 ,
                             g_org_dept_sum_d[l_ac].rtcd002_desc_1 , g_org_dept_sum_d[l_ac].rtcd003_1,        g_org_dept_sum_d[l_ac].rtcd003_desc_1 ,
                             g_org_dept_sum_d[l_ac].l_sale_1,        g_org_dept_sum_d[l_ac].l_gross_profit_1

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #150716-00020#1 20150717 mark by beckxie---S
#      IF g_org_dept_sum_d[l_ac].l_sale_1 > 0 THEN
#         LET g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 = (g_org_dept_sum_d[l_ac].l_gross_profit_1/g_org_dept_sum_d[l_ac].l_sale_1)*100
#      ELSE
#         LET g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 = 0 
#      END IF
      #150716-00020#1 20150717 mark by beckxie---E
      #150716-00020#1 20150717  add by beckxie---S
      IF g_org_dept_sum_d[l_ac].l_sale_1 > 0 THEN
         LET g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 = (g_org_dept_sum_d[l_ac].l_gross_profit_1/g_org_dept_sum_d[l_ac].l_sale_1)*100
      ELSE
         IF g_org_dept_sum_d[l_ac].l_sale_1 = 0 THEN
            IF g_org_dept_sum_d[l_ac].l_gross_profit_1 > 0 THEN
               LET g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 = 100
            END IF
            IF g_org_dept_sum_d[l_ac].l_gross_profit_1 = 0 THEN
               LET g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 = 0
            END IF
            IF g_org_dept_sum_d[l_ac].l_gross_profit_1 < 0 THEN
               LET g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 = -100
            END IF
         END IF
      END IF      
      #150716-00020#1 20150717  add by beckxie---E

      LET g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 = g_org_dept_sum_d[l_ac].l_gross_profit_margin_1 USING "---&.&&%"
      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1

   END FOREACH   
   
   CALL g_org_dept_sum_d.deleteElement(g_org_dept_sum_d.getLength())
   
   #門店日報
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_org_d[l_ac].oogc003_2 ,       g_org_d[l_ac].rtcdsite_2,          g_org_d[l_ac].rtcdsite_desc_2,
                             g_org_d[l_ac].rtcd003_2,        g_org_d[l_ac].rtcd003_desc_2 ,     g_org_d[l_ac].l_sale_2,
                             g_org_d[l_ac].l_gross_profit_2

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #150716-00020#1 20150720 mark by beckxie---S
#      IF g_org_d[l_ac].l_sale_2 > 0 THEN
#         LET g_org_d[l_ac].l_gross_profit_margin_2 = (g_org_d[l_ac].l_gross_profit_2/g_org_d[l_ac].l_sale_2)*100
#      ELSE
#         LET g_org_d[l_ac].l_gross_profit_margin_2 = 0
#      END IF
      #150716-00020#1 20150720 mark by beckxie---E
      #150716-00020#1 20150720  add by beckxie---S
      IF g_org_d[l_ac].l_sale_2 > 0 THEN
         LET g_org_d[l_ac].l_gross_profit_margin_2 = (g_org_d[l_ac].l_gross_profit_2/g_org_d[l_ac].l_sale_2)*100
      ELSE
         IF g_org_d[l_ac].l_sale_2 = 0 THEN
            IF g_org_d[l_ac].l_gross_profit_2 > 0 THEN
               LET g_org_d[l_ac].l_gross_profit_margin_2 = 100
            END IF
            IF g_org_d[l_ac].l_gross_profit_2 = 0 THEN
               LET g_org_d[l_ac].l_gross_profit_margin_2 = 0
            END IF
            IF g_org_d[l_ac].l_gross_profit_2 < 0 THEN
               LET g_org_d[l_ac].l_gross_profit_margin_2 = -100
            END IF
         END IF
      END IF      
      #150716-00020#1 20150720  add by beckxie---E
      
      LET g_org_d[l_ac].l_gross_profit_margin_2 = g_org_d[l_ac].l_gross_profit_margin_2 USING "---&.&&%"
      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1

   END FOREACH
   
   CALL g_org_d.deleteElement(g_org_d.getLength())

   #門店彙總
   LET l_ac = 1
   FOREACH b_fill_curs3 INTO g_org_sum_d[l_ac].rtcdsite_3,      g_org_sum_d[l_ac].rtcdsite_desc_3,g_org_sum_d[l_ac].rtcd003_3,
                             g_org_sum_d[l_ac].rtcd003_desc_3 , g_org_sum_d[l_ac].l_sale_3,       g_org_sum_d[l_ac].l_gross_profit_3,
                             g_org_sum_d[l_ac].l_gross_profit_margin_3                             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #150716-00020#1 20150720 mark by beckxie---S
#      IF g_org_sum_d[l_ac].l_sale_3 > 0 THEN
#         LET g_org_sum_d[l_ac].l_gross_profit_margin_3 = (g_org_sum_d[l_ac].l_gross_profit_3/g_org_sum_d[l_ac].l_sale_3)*100
#      ELSE
#         LET g_org_sum_d[l_ac].l_gross_profit_margin_3 = 0
#      END IF
      #150716-00020#1 20150720 mark by beckxie---E
      #150716-00020#1 20150720  add by beckxie---S
      IF g_org_sum_d[l_ac].l_sale_3 > 0 THEN
         LET g_org_sum_d[l_ac].l_gross_profit_margin_3 = (g_org_sum_d[l_ac].l_gross_profit_3/g_org_sum_d[l_ac].l_sale_3)*100
      ELSE
         IF g_org_sum_d[l_ac].l_sale_3 = 0 THEN
            IF g_org_sum_d[l_ac].l_gross_profit_3 > 0 THEN
               LET g_org_sum_d[l_ac].l_gross_profit_margin_3 = 100
            END IF
            IF g_org_sum_d[l_ac].l_gross_profit_3 = 0 THEN
               LET g_org_sum_d[l_ac].l_gross_profit_margin_3 = 0
            END IF
            IF g_org_sum_d[l_ac].l_gross_profit_3 < 0 THEN
               LET g_org_sum_d[l_ac].l_gross_profit_margin_3 = -100
            END IF
         END IF
      END IF      
      #150716-00020#1 20150720  add by beckxie---E
      
      LET g_org_sum_d[l_ac].l_gross_profit_margin_3 = g_org_sum_d[l_ac].l_gross_profit_margin_3 USING "---&.&&%"
      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1

   END FOREACH
   
   CALL g_org_sum_d.deleteElement(g_org_sum_d.getLength())
   
   LET g_error_show = 0


   LET g_detail_cnt = g_org_dept_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   IF g_cnt > g_org_dept_d.getLength() THEN
      LET l_ac = g_org_dept_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF

END FUNCTION

PRIVATE FUNCTION adeq114_detail_show()

END FUNCTION

PRIVATE FUNCTION adeq114_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING

   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " rtcdsite = '", g_argv[01], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtcd001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " rtcd002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " rtcd003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " rtcd004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " rtcd005 = '", g_argv[06], "' AND "
   END IF


   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF


END FUNCTION

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL adeq114_create_temp()
# Input parameter: 
# Return code....: r_success
# Date & Author..: 2015/07/09 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq114_create_temp()
   WHENEVER ERROR CONTINUE
   
   CALL adeq114_drop_temp()
   
   CREATE TEMP TABLE adeq114_tmp(
      oogc003              LIKE oogc_t.oogc003,
      org                  LIKE rtcd_t.rtcdsite,
      dept                 LIKE rtcd_t.rtcd002,
      rtax001              LIKE rtax_t.rtax001,
      proportion           LIKE type_t.num20_6,
      sale                 LIKE type_t.num20_6,
      gross_profit         LIKE type_t.num20_6,
      gross_profit_margin  LIKE type_t.num20_6)
      
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存表
# Memo...........:
# Usage..........: CALL adeq114_create_temp()
# Input parameter: 
# Return code....: r_success
# Date & Author..: 2015/07/09 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq114_drop_temp()
   WHENEVER ERROR CONTINUE
   
   DROP TABLE adeq114_tmp
END FUNCTION

################################################################################
# Descriptions...: 查詢資料處理
# Memo...........:
# Usage..........: CALL adeq114_data_process(p_wc2)
# Date & Author..: 2015/07/10 By Lori
# Modify.........: 2016/01/27 By Lori   #160126-00007#1   調整預算係數來源,預算毛利率計算
################################################################################
PRIVATE FUNCTION adeq114_data_process(p_wc2)
   DEFINE p_wc2   STRING
   DEFINE l_sql   STRING
   DEFINE l_where STRING #150922-00001#3 20150923 S983961--ADD
   
   CALL s_aooi500_sql_where(g_prog,'rtcdsite') RETURNING l_where #150922-00001#3 20150923 S983961--ADD
   #150922-00001#3 20160106 S983961--add(s)統一寫法
   IF cl_null(p_wc2) THEN
      LET p_wc2 = l_where
   ELSE
      LET p_wc2 = p_wc2 CLIPPED," AND ",l_where
   END IF
   #150922-00001#3 20160106 S983961--add(e)統一寫法
   #寫入新查詢值前先清空
   DELETE FROM adeq114_tmp
   DISPLAY "DELETE adeq114_tmp txn-rows: ",SQLCA.sqlerrd[3]

   #寫入日期/門店/部門/管理品類
   LET l_sql = "INSERT INTO adeq114_tmp(oogc003,org,dept,rtax001) ",
               "SELECT UNIQUE oogc003,rtcdsite,rtcd002,rtcd003 ",              
               "        FROM rtcd_t,ooef_t,oogc_t ",
               "       WHERE rtcdent = ooefent ",
               "         AND rtcdsite = ooef001 ",
               "         AND ooefent = oogcent ",
               "         AND ooef008 = oogc001 ",
               "         AND SUBSTR(rtcd001,1,4) = oogc015 ",
               "         AND oogc002 = '3' ",
               "         AND rtcdent = ",g_enterprise,
               "         AND ",p_wc2
   PREPARE adeq114_tmp_ins FROM l_sql

   #更新每天權重/預算銷售額/預算毛利
   LET l_sql = "UPDATE adeq114_tmp ",
               "   SET proportion = ",
               "          (SELECT (CASE ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '01' THEN rtcd007 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '02' THEN rtcd008 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '03' THEN rtcd009 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '04' THEN rtcd010 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '05' THEN rtcd011 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '06' THEN rtcd012 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '07' THEN rtcd013 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '08' THEN rtcd014 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '09' THEN rtcd015 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '10' THEN rtcd016 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '11' THEN rtcd017 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '12' THEN rtcd018 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '13' THEN rtcd019 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '14' THEN rtcd020 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '15' THEN rtcd021 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '16' THEN rtcd022 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '17' THEN rtcd023 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '18' THEN rtcd024 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '19' THEN rtcd025 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '20' THEN rtcd026 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '21' THEN rtcd027 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '22' THEN rtcd028 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '23' THEN rtcd029 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '24' THEN rtcd030 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '25' THEN rtcd031 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '26' THEN rtcd032 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '27' THEN rtcd033 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '28' THEN rtcd034 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '29' THEN rtcd035 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '30' THEN rtcd036 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '31' THEN rtcd037 ",
               "                   END) ",
               "             FROM rtcd_t ",
               "            WHERE rtcdent = ",g_enterprise,
               "              AND rtcdsite = org ",
               "              AND TO_CHAR(oogc003, 'YYYYMM') = rtcd001 ",
               "              AND rtcd002 = dept ",
               "              AND rtcd003 = rtax001 ",
              #"              AND rtcd004 = '7' ",   #160126-00007#1 160127 by lori mark
               "              AND rtcd004 = '3' ",   #160126-00007#1 160127 by lori add
               "              AND ",p_wc2,"), ",
               "       sale = ",
               "          (SELECT (CASE ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '01' THEN rtcd007 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '02' THEN rtcd008 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '03' THEN rtcd009 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '04' THEN rtcd010 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '05' THEN rtcd011 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '06' THEN rtcd012 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '07' THEN rtcd013 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '08' THEN rtcd014 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '09' THEN rtcd015 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '10' THEN rtcd016 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '11' THEN rtcd017 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '12' THEN rtcd018 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '13' THEN rtcd019 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '14' THEN rtcd020 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '15' THEN rtcd021 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '16' THEN rtcd022 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '17' THEN rtcd023 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '18' THEN rtcd024 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '19' THEN rtcd025 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '20' THEN rtcd026 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '21' THEN rtcd027 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '22' THEN rtcd028 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '23' THEN rtcd029 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '24' THEN rtcd030 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '25' THEN rtcd031 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '26' THEN rtcd032 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '27' THEN rtcd033 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '28' THEN rtcd034 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '29' THEN rtcd035 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '30' THEN rtcd036 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '31' THEN rtcd037 ",
               "                   END) ",
               "             FROM rtcd_t ",
               "            WHERE rtcdent = ",g_enterprise,
               "              AND rtcdsite = org ",
               "              AND TO_CHAR(oogc003, 'YYYYMM') = rtcd001 ",
               "              AND rtcd002 = dept ",
               "              AND rtcd003 = rtax001 ",
               "              AND rtcd004 = '4' ",
               "              AND rtcd005 = '",g_master.l_sale_qbe,"' ",
               "              AND rtcd006 = '1' ",               
               "              AND ",p_wc2,"), ",
               "       gross_profit = ",
               "          (SELECT (CASE ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '01' THEN rtcd007 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '02' THEN rtcd008 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '03' THEN rtcd009 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '04' THEN rtcd010 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '05' THEN rtcd011 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '06' THEN rtcd012 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '07' THEN rtcd013 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '08' THEN rtcd014 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '09' THEN rtcd015 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '10' THEN rtcd016 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '11' THEN rtcd017 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '12' THEN rtcd018 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '13' THEN rtcd019 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '14' THEN rtcd020 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '15' THEN rtcd021 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '16' THEN rtcd022 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '17' THEN rtcd023 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '18' THEN rtcd024 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '19' THEN rtcd025 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '20' THEN rtcd026 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '21' THEN rtcd027 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '22' THEN rtcd028 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '23' THEN rtcd029 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '24' THEN rtcd030 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '25' THEN rtcd031 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '26' THEN rtcd032 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '27' THEN rtcd033 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '28' THEN rtcd034 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '29' THEN rtcd035 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '30' THEN rtcd036 ",
               "                      WHEN TO_CHAR(oogc003, 'DD') = '31' THEN rtcd037 ",
               "                   END) ",
               "             FROM rtcd_t ",
               "            WHERE rtcdent = ",g_enterprise,
               "              AND rtcdsite = org ",
               "              AND TO_CHAR(oogc003, 'YYYYMM') = rtcd001 ",
               "              AND rtcd002 = dept ",
               "              AND rtcd003 = rtax001 ",
               "              AND rtcd004 = '4' ",
               "              AND rtcd005 = '",g_master.l_gross_profit_qbe,"' ",
               "              AND rtcd006 = '1' ",
               "              AND ",p_wc2,") "       #160126-00007#1 160127 by lori mod
              #160126-00007#1 160127 by lori mark---(S)
              #"       gross_profit_margin = ",
              #"          (SELECT (CASE ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '01' THEN rtcd007 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '02' THEN rtcd008 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '03' THEN rtcd009 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '04' THEN rtcd010 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '05' THEN rtcd011 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '06' THEN rtcd012 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '07' THEN rtcd013 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '08' THEN rtcd014 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '09' THEN rtcd015 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '10' THEN rtcd016 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '11' THEN rtcd017 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '12' THEN rtcd018 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '13' THEN rtcd019 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '14' THEN rtcd020 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '15' THEN rtcd021 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '16' THEN rtcd022 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '17' THEN rtcd023 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '18' THEN rtcd024 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '19' THEN rtcd025 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '20' THEN rtcd026 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '21' THEN rtcd027 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '22' THEN rtcd028 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '23' THEN rtcd029 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '24' THEN rtcd030 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '25' THEN rtcd031 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '26' THEN rtcd032 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '27' THEN rtcd033 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '28' THEN rtcd034 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '29' THEN rtcd035 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '30' THEN rtcd036 ",
              #"                      WHEN TO_CHAR(oogc003, 'DD') = '31' THEN rtcd037 ",
              #"                   END) ",
              #"             FROM rtcd_t ",
              #"            WHERE rtcdent = ",g_enterprise,
              #"              AND rtcdsite = org ",
              #"              AND TO_CHAR(oogc003, 'YYYYMM') = rtcd001 ",
              #"              AND rtcd002 = dept ",
              #"              AND rtcd003 = rtax001 ",
              #"              AND rtcd004 = '8' ",
              #"              AND ",p_wc2,") " 
              #160126-00007#1 160127 by lori mark---(E)              
   PREPARE adeq114_tmp_upd FROM l_sql  
   #DISPLAY "[SQL]adeq114_tmp_upd: ",l_sql
   
   #160126-00007#1 160127 by lori add---(S)
   LET l_sql = "UPDATE adeq114_tmp ",
               "   SET gross_profit_margin = (CASE WHEN sale = 0 THEN (CASE WHEN gross_profit > 0 THEN 100 ",
               "                                                            WHEN gross_profit = 0 THEN 0 ",
               "                                                            WHEN gross_profit < 0 THEN -100 ",
               "                                                         END)",
               "                                   ELSE (gross_profit/sale)*100 ",
               "                               END) "   
   PREPARE adeq114_tmp_upd1 FROM l_sql   
   #DISPLAY "[SQL]adeq114_tmp_upd1: ",l_sql   
   #160126-00007#1 160127 by lori add---(E)
   
   EXECUTE adeq114_tmp_ins
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ERROR:adeq114_tmp_ins"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF   
   DISPLAY "adeq114_tmp_ins txn-rows: ",SQLCA.sqlerrd[3]

   EXECUTE adeq114_tmp_upd
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ERROR:adeq114_tmp_upd"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF    
   DISPLAY "adeq114_tmp_upd txn-rows: ",SQLCA.sqlerrd[3]

   EXECUTE adeq114_tmp_upd1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ERROR:adeq114_tmp_upd1"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF    
   DISPLAY "adeq114_tmp_upd1 txn-rows: ",SQLCA.sqlerrd[3]
END FUNCTION

################################################################################
# Descriptions...: 指標说明
# Memo...........:
# Usage..........: CALL adeq114_rtca001_ref(p_rtca001)
#                  RETURNING r_rtcal003
# Input parameter: p_rtca001      指標編號
# Return code....: rtcal003       指標說明
# Date & Author..: 2015/07/11 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq114_rtca001_ref(p_rtca001)
   DEFINE p_rtca001    LIKE rtca_t.rtca001
   DEFINE r_rtcal003   LIKE rtcal_t.rtcal003
   
   LET r_rtcal003 = ''
   
   SELECT rtcal003 INTO r_rtcal003
     FROM rtcal_t
    WHERE rtcalent = g_enterprise
      AND rtcal001 = p_rtca001
      AND rtcal002 = g_dlang
      
   RETURN r_rtcal003
END FUNCTION

#end add-point
 
{</section>}
 
