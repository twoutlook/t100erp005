#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp470.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-10-13 10:56:51), PR版次:0004(2016-10-24 16:22:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: anmp470
#+ Description: 應付請款單拋轉還原作業
#+ Creator....: 06816(2015-10-12 10:12:01)
#+ Modifier...: 06816 -SD/PR- 06821
 
{</section>}
 
{<section id="anmp470.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#27  2016/03/23 By 07900    重复错误信息修改
#160816-00012#2   2016/08/29 By 01727    ANM增加资金中心，帐套，法人三个栏位权限
#161021-00038#1   2016/10/24 By 06821    組織類型與職能開窗調整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
GLOBALS "../../cfg/top_finance.inc"    #財務模組使用
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
   sel           LIKE type_t.chr1,
   nmckdocno     LIKE nmck_t.nmckdocno,
   nmckdocdt     LIKE nmck_t.nmckdocdt,
   nmck005       LIKE nmck_t.nmck005,
   nmck005_desc  LIKE type_t.chr500,
   nmck006       LIKE type_t.chr500,
   nmck011       LIKE nmck_t.nmck011,
   nmck025       LIKE nmck_t.nmck025,
   nmck103       LIKE nmck_t.nmck103,
   nmck101       LIKE nmck_t.nmck101,
   nmck113       LIKE nmck_t.nmck113,
   nmck004       LIKE nmck_t.nmck004,
   nmck004_desc  LIKE type_t.chr500,
   nmckstus      LIKE nmck_t.nmckstus
                 END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 TYPE type_master   RECORD
   nmcksite         LIKE nmck_t.nmcksite,
   nmcksite_desc    LIKE type_t.chr500,
   nmckcomp         LIKE nmck_t.nmckcomp,
   nmckcomp_desc    LIKE type_t.chr500,
   apde006          LIKE apde_t.apde006,
   wc               STRING
                END RECORD
DEFINE g_master     type_master
DEFINE g_nmag002    LIKE nmag_t.nmag002
DEFINE g_glaald     LIKE glaa_t.glaald
DEFINE g_nmckcomp_str  STRING   #組織範圍
#end add-point
 
{</section>}
 
{<section id="anmp470.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp470 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmp470_init()   
 
      #進入選單 Menu (="N")
      CALL anmp470_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp470
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp470.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmp470_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('apde006','8310','20,30')
   CALL cl_set_combo_scc_part('b_nmckstus','13','N,Y,A,D,R,W,X')
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp470.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp470_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
  #160816-00012#2 Add  ---(S)---
   DEFINE  l_count    LIKE type_t.num5
   DEFINE  l_wc       STRING
  #160816-00012#2 Add  ---(E)---
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
         CALL anmp470_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc ON nmck003,nmckdocno,nmckdocdt,nmck011,nmck004,nmck100,nmck005
            ON ACTION controlp INFIELD nmck003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO nmck003    #顯示到畫面上
               NEXT FIELD nmck003
               
            ON ACTION controlp INFIELD nmckdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET l_sql = " nmckcomp = '",g_master.nmckcomp,"' AND nmcksite = '",g_master.nmcksite,"' ",
                           " AND nmckstus = 'N' AND nmck002 IN (",
                           " SELECT ooia001 FROM ooia_t ",
                           "  WHERE ooia002 = '",g_master.apde006,"' AND ooiaent = ",g_enterprise,")"
               LET g_qryparam.where = l_sql
               CALL q_nmckdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmckdocno  #顯示到畫面上
               NEXT FIELD nmckdocno                     #返回原欄位
               
            ON ACTION controlp INFIELD nmck004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " nmasent = nmaaent AND ", 
                                      " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                      "              AND ooef017 = '",g_master.nmckcomp,"')",
                                      " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 AND nmagent = '",g_enterprise,"' ",
                                      " AND nmag002 IN ('1','",g_nmag002,"')) "
               CALL q_nmas_01()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmck004    #顯示到畫面上
               NEXT FIELD nmck004                       #返回原欄位
               
            ON ACTION controlp INFIELD nmck100
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_aooi001_1()
               DISPLAY g_qryparam.return1 TO nmck100
               NEXT FIELD nmck100
               
            ON ACTION controlp INFIELD nmck005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') AND (pmaa004 = '1' OR pmaa004 = '3')"
               CALL q_pmaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmck005  #顯示到畫面上
               NEXT FIELD nmck005                     #返回原欄位
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,g_master.nmckcomp_desc,g_master.apde006
            ATTRIBUTE(WITHOUT DEFAULTS)
            ON ACTION controlp INFIELD nmcksite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmcksite
               LET g_qryparam.default2 = ""  #g_master.nmcksite_desc #說明(簡稱)
               LET g_qryparam.where = " ooef206 = 'Y' "
               #CALL q_ooef001()   #161021-00038#1 mark
               CALL q_ooef001_33() #161021-00038#1 add
               LET g_master.nmcksite = g_qryparam.return1
               LET g_master.nmcksite_desc = g_qryparam.return2
               DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc
               NEXT FIELD nmcksite
               
            AFTER FIELD nmcksite
               LET g_master.nmcksite_desc = ''
               DISPLAY BY NAME g_master.nmcksite_desc
               IF NOT cl_null(g_master.nmcksite) THEN 
                  CALL anmp470_nmcksite_chk(g_master.nmcksite)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.nmcksite
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_orga_get_comp_ld(g_master.nmcksite) RETURNING g_sub_success,g_errno,g_master.nmckcomp,g_glaald
                  CALL s_fin_account_center_sons_query('6',g_master.nmcksite,g_today,'')
                  CALL s_fin_account_center_comp_str()  RETURNING g_nmckcomp_str
                  CALL s_fin_get_wc_str(g_nmckcomp_str) RETURNING g_nmckcomp_str
                  #160816-00012#2 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_master.nmckcomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep FROM l_sql
                  EXECUTE anmp410_count_prep INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     LET g_master.nmckcomp = ''
                     LET g_master.nmckcomp_desc = ''
                     DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc
                  END IF
                  #160816-00012#2 Add  ---(E)---
               END IF
               LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
               DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc
               LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc
               
            ON ACTION controlp INFIELD nmckcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmckcomp
               LET g_qryparam.default2 = "" #g_master.nmckcomp_desc #說明(簡稱)
               IF cl_null(g_nmckcomp_str) THEN
                  LET g_qryparam.where = " ooef001 IN(SELECT ooef017 FROM ooef_t WHERE ooef001 = '",g_master.nmcksite,"' )"
               ELSE                        
                  LET g_qryparam.where = " ooef001 IN ",g_nmckcomp_str CLIPPED
               END IF
               #160816-00012#2 Add  ---(S)---
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
               LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
               #160816-00012#2 Add  ---(E)---
               #CALL q_ooef001()  #161021-00038#1 mark
               CALL q_ooef001_2() #161021-00038#1 add
               LET g_master.nmckcomp = g_qryparam.return1
               LET g_master.nmckcomp_desc = g_qryparam.return2
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc
               NEXT FIELD nmckcomp
               
            AFTER FIELD nmckcomp
               LET g_master.nmckcomp_desc = ''
               DISPLAY BY NAME g_master.nmckcomp_desc
               IF NOT cl_null(g_master.nmckcomp) THEN
                  CALL s_fin_comp_chk(g_master.nmckcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''
                     NEXT FIELD CURRENT
                  END IF
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt
                    FROM ooef_t
                   WHERE ooefent = g_enterprise AND ooef017 = g_master.nmckcomp 
                     AND ooef001 = g_master.nmcksite
                  IF s_chr_get_index_of(g_nmckcomp_str,g_master.nmckcomp,1) = 0 AND l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-02928'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#2 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_master.nmckcomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep1 FROM l_sql
                  EXECUTE anmp410_count_prep1 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#2 Add  ---(E)---
               END IF
               LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc
               
            ON CHANGE apde006
               IF g_master.apde006 = '20' THEN
                  CALL cl_set_comp_visible("b_nmck025",FALSE)
                  LET g_nmag002 = '1'   #不限制
               ELSE
                  CALL cl_set_comp_visible("b_nmck025",TRUE)
                  LET g_nmag002 = '4'   #票據往來
               END IF
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
               

            ON CHANGE sel
               IF NOT cl_null(g_detail_d[l_ac].nmck025) THEN
                  LET g_detail_d[l_ac].sel = 'N'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02957'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
         END INPUT
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
            CALL anmp470_qbe_clear()
            DISPLAY g_user TO nmck003
            IF cl_null(g_master.wc) THEN
               LET g_master.wc = " nmck003 =  '",g_user,"' "
            END IF
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               IF NOT cl_null(g_detail_d[li_idx].nmck025 ) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
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
            LET li_idx = ARR_CURR()
            IF NOT cl_null(g_detail_d[li_idx].nmck025 ) THEN
               LET g_detail_d[li_idx].sel = "N"
            END IF
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
            CALL anmp470_filter()
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
            CALL anmp470_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL anmp470_qbe_clear()
            DISPLAY g_user TO nmck003
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL anmp470_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL anmp470_process()
            IF g_success ='N' THEN
               CONTINUE DIALOG
            END IF
         
            IF g_bgjob = "N" THEN
               CALL cl_ask_confirm3("std-00012","")
            END IF
            CALL anmp470_b_fill()
            NEXT FIELD nmcksite
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
 
{<section id="anmp470.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmp470_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_master.nmckcomp) OR cl_null(g_master.apde006) OR cl_null(g_master.nmcksite) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'acr-00015'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL anmp470_b_fill()
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
 
{<section id="anmp470.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmp470_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1 "
   END IF
   LET g_sql =" SELECT 'N',nmckdocno,nmckdocdt,nmck005,'',nmck006,nmck011,",
              "        nmck025,nmck103,nmck101,nmck113,nmck004,'',nmckstus",
              "   FROM nmck_t,nmcl_t,apde_t ",
              "  WHERE nmckent = ? AND nmckstus = 'N' AND nmckent = nmclent AND nmckcomp = apdecomp ",
              "    AND nmckcomp = nmclcomp AND nmckdocno = nmcldocno AND nmckent = apdeent ",
              "    AND nmcl001 = apdedocno AND nmcl002 = apdeseq " ,
              "    AND nmckcomp = '",g_master.nmckcomp,"' ",
              "    AND nmcksite = '",g_master.nmcksite,"' ",
              "    AND nmck002 IN (SELECT ooia001 ",
              "                      FROM ooia_t  ",
              "                     WHERE ooia002 = '",g_master.apde006,"' ",
              "                       AND ooiaent = ",g_enterprise,") ",
              "    AND ",g_master.wc," ORDER BY nmckdocno "
   
   #end add-point
 
   PREPARE anmp470_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmp470_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
     g_detail_d[l_ac].*
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
      IF NOT cl_null(g_detail_d[l_ac].nmck005) THEN
         LET g_detail_d[l_ac].nmck005_desc = g_detail_d[l_ac].nmck005,".",s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].nmck005)
      END IF
      IF NOT cl_null(g_detail_d[l_ac].nmck006) THEN
         LET g_detail_d[l_ac].nmck006 = g_detail_d[l_ac].nmck006,".",s_desc_get_person_desc(g_detail_d[l_ac].nmck006)
      END IF
      #end add-point
      
      CALL anmp470_detail_show()      
 
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
   FREE anmp470_sel
   
   LET l_ac = 1
   CALL anmp470_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp470.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmp470_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="anmp470.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmp470_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp470.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmp470_filter()
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
   
   CALL anmp470_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="anmp470.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmp470_filter_parser(ps_field)
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
 
{<section id="anmp470.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmp470_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmp470_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmp470.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL anmp470_qbe_clear()
# Date & Author..: 2015/10/12 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp470_qbe_clear()

   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_detail_d.clear()
   
   LET g_master.apde006 = '30'
   LET g_nmag002 = '4'
   CALL cl_set_comp_visible("b_nmck025",TRUE)
   CALL s_fin_account_center_sons_query('6',g_site,g_today,'')
   CALL s_fin_account_center_comp_str()  RETURNING g_nmckcomp_str
   CALL s_fin_get_wc_str(g_nmckcomp_str) RETURNING g_nmckcomp_str
   CALL s_fin_account_center_with_ld_chk(g_site,'',g_user,'6','N','',g_today) RETURNING g_sub_success,g_errno
   
   IF g_sub_success THEN
      CALL anmp470_nmcksite_chk(g_site)
      IF NOT cl_null(g_errno) THEN
         # g_site <> 資金中心,則空白
         LET g_master.nmcksite = ''
         LET g_master.nmckcomp = ''
      ELSE
         LET g_master.nmcksite = g_site
         CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master.nmckcomp,g_glaald   
      END IF
   ELSE
      LET g_master.nmcksite = ''
      LET g_master.nmckcomp = ''
   END IF
   
   LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
   LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
   DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,g_master.nmckcomp_desc
END FUNCTION

PRIVATE FUNCTION anmp470_process()
DEFINE l_i         LIKE type_t.num10
DEFINE l_success   LIKE type_t.num5
   LET g_success ='Y'
   CALL s_transaction_begin()

   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      ELSE
         CALL anmp470_del(g_detail_d[l_i].nmckdocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            LET g_success ='N'
            RETURN 
         END IF    
      END IF
   END FOR
   CALL s_transaction_end('Y','0')   
END FUNCTION
################################################################################
# Descriptions...: 資金中心檢查
# Memo...........:
# Usage..........: CALL anmt470_nmcksite_chk(p_nmcksite)
# Date & Author..: 2015/10/12 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp470_nmcksite_chk(p_nmcksite)
   DEFINE l_ooef206  LIKE ooef_t.ooef206
   DEFINE l_ooefstus LIKE ooef_t.ooefstus
   DEFINE p_nmcksite LIKE nmck_t.nmcksite

   LET g_errno = ''
   SELECT ooef206,ooefstus INTO l_ooef206,l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_nmcksite  
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aoo-00094'
      WHEN l_ooefstus = 'N'    LET g_errno = 'sub-01302' #aoo-00095   #160318-00005#27 by 07900--mod
      WHEN l_ooef206 <> 'Y'    LET g_errno = 'anm-00272'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 刪除 nmck , nmcl , nmcm
# Memo...........:
# Usage..........: CALL anmp470_del()
# Input parameter: p_nmckdocno    單據號碼
# Return code....: r_success      成功否
# Date & Author..: 2015/10/13 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp470_del(p_nmckdocno)
DEFINE r_success   LIKE type_t.num5
DEFINE p_nmckdocno LIKE nmck_t.nmckdocno
DEFINE l_nmcl001   LIKE nmcl_t.nmcl001
DEFINE l_nmcl002   LIKE nmcl_t.nmcl002
   LET r_success = TRUE
   
   SELECT nmcl001,nmcl002
     INTO l_nmcl001,l_nmcl002
     FROM nmcl_t
    WHERE nmclent   = g_enterprise
      AND nmclcomp  = g_master.nmckcomp
      AND nmcldocno = p_nmckdocno
   
   DELETE FROM nmck_t
    WHERE nmckent   = g_enterprise
      AND nmckcomp  = g_master.nmckcomp
      AND nmckdocno = p_nmckdocno
      
   DELETE FROM nmcl_t
    WHERE nmclent   = g_enterprise
      AND nmclcomp  = g_master.nmckcomp
      AND nmcldocno = p_nmckdocno
      
   DELETE FROM nmcm_t
    WHERE nmcment   = g_enterprise
      AND nmcmcomp  = g_master.nmckcomp
      AND nmcmdocno = p_nmckdocno
      
   UPDATE apde_t
      SET apde009 = 'N', # 已轉　（aapt420)
          apde003 = ''   # 已付款單號
    WHERE apdeent = g_enterprise
      AND apdecomp  = g_master.nmckcomp 
      AND apdedocno = l_nmcl001
      AND apdeseq   = l_nmcl002  
   
   IF SQLCA.sqlcode THEN
      LET g_errparam.extend = "update" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
