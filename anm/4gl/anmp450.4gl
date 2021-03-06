#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp450.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-09-07 15:18:05), PR版次:0006(2016-10-24 05:58:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: anmp450
#+ Description: 應付票據寄出作業
#+ Creator....: 06821(2015-06-03 14:12:42)
#+ Modifier...: 06816 -SD/PR- 08729
 
{</section>}
 
{<section id="anmp450.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150902-00001#1  2015/09/04 By RayHuang 增加自領應付票據廠商簽收回條
#160318-00005#27 2016/03/23 By 07900    重复错误信息修改
#160318-00025#30 2016/04/08 by 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160816-00012#2  2016/08/29 By 01727    ANM增加资金中心，帐套，法人三个栏位权限
#161021-00050#1  2016/10/24 By 08729    處理組織開窗
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
   sel     LIKE type_t.chr1,
   nmck025 LIKE nmck_t.nmck025,
   nmck005 LIKE nmck_t.nmck005,
   nmck015 LIKE nmck_t.nmck015, 
   nmck011 LIKE nmck_t.nmck011,
   nmck034 LIKE nmck_t.nmck034             #150902-00001#1
END RECORD

#單頭
TYPE type_master   RECORD
   nmcksite        LIKE nmck_t.nmcksite,
   nmcksite_desc   LIKE type_t.chr500,
   nmckcomp        LIKE nmck_t.nmckcomp,
   nmckcomp_desc   LIKE type_t.chr500,
   nmck035         LIKE nmck_t.nmck035,
   ooag001         LIKE ooag_t.ooag001,
   ooag001_desc    LIKE type_t.chr500,
   l_nmck034       LIKE type_t.chr500,     #150902-00001#1
   chk_1           LIKE type_t.chr500,  
   chk_2           LIKE type_t.chr500,
   chk_3           LIKE type_t.chr500,    
   chk_4           LIKE type_t.chr500,     #150902-00001#1
   wc              STRING
                   END RECORD

DEFINE g_master      type_master
DEFINE g_wc_nmcksite STRING
DEFINE g_wc_nmckcomp STRING
DEFINE g_apcald      LIKE glaa_t.glaald
DEFINE g_wc_filter2  STRING
DEFINE g_master_wc   STRING
DEFINE g_nmck034_wc  STRING                #150902-00001#1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="anmp450.main" >}
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
      OPEN WINDOW w_anmp450 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmp450_init()   
 
      #進入選單 Menu (="N")
      CALL anmp450_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp450
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp450.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmp450_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_nmck034','8712')
   #組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp() 
   CALL anmp450_qbe_clear()   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp450.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp450_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
  #160816-00012#2 Add  ---(S)---
   DEFINE  l_count    LIKE type_t.num5
   DEFINE  l_wc       STRING
   DEFINE  l_sql      STRING
  #160816-00012#2 Add  ---(E)---
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL anmp450_qbe_clear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmp450_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.nmcksite,g_master.nmckcomp,g_master.nmck035,g_master.ooag001,g_master.l_nmck034,
                       g_master.chk_1,g_master.chk_2,g_master.chk_3,g_master.chk_4
                     ATTRIBUTE(WITHOUT DEFAULTS)
                     
            AFTER FIELD nmcksite
               LET g_master.nmcksite_desc = ' '
               DISPLAY BY NAME g_master.nmcksite_desc
               IF NOT cl_null(g_master.nmcksite) THEN 
                  CALL s_fin_account_center_with_ld_chk(g_master.nmcksite,'',g_user,'6','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmcksite = g_site
                     LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
                     LET g_master.nmckcomp = ''
                     LET g_master.nmckcomp_desc = ''
                     LET g_wc_nmcksite = ''
                     LET g_wc_nmckcomp = ''
                     DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,g_master.nmckcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #資金中心預設主帳套及主帳套所屬法人及其他預設值         
                  CALL s_fin_orga_get_comp_ld(g_master.nmcksite) RETURNING g_sub_success,g_errno,g_master.nmckcomp,g_apcald   
                  CALL s_fin_account_center_sons_query('6',g_master.nmcksite,g_today,'1')
                  #取得資金中心底下的法人範圍               
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_nmckcomp
                  CALL s_fin_get_wc_str(g_wc_nmckcomp) RETURNING g_wc_nmckcomp 
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
                  LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
                  LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
                  DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,g_master.nmckcomp_desc
               ELSE                        
                  LET g_master.nmcksite_desc = ''
                  LET g_master.nmckcomp      = ''
                  LET g_master.nmckcomp_desc = ''
                  LET g_wc_nmcksite = ''
                  LET g_wc_nmckcomp = ''
                  DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,g_master.nmckcomp_desc
               END IF
           
            AFTER FIELD nmckcomp
               LET g_master.nmckcomp_desc = ' '
               DISPLAY BY NAME g_master.nmckcomp_desc
               IF NOT cl_null(g_master.nmckcomp) THEN
                  #取得資金組織底下所屬的法人範圍
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_nmckcomp
                  #將取回的字串轉換為SQL條件
                  CALL s_fin_get_wc_str(g_wc_nmckcomp) RETURNING g_wc_nmckcomp
                  CALL anmp450_nmcksite_chk() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''
                     LET g_master.nmckcomp_desc = ''
                     DISPLAY BY NAME g_master.nmckcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #比對輸入的法人是否在資金組織下
                  IF s_chr_get_index_of(g_wc_nmckcomp,g_master.nmckcomp,'1') = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00274'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''
                     LET g_master.nmckcomp_desc = ''
                     DISPLAY BY NAME g_master.nmckcomp_desc
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
                  LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
                  DISPLAY BY NAME g_master.nmckcomp_desc     
               END IF
               
            AFTER FIELD ooag001   
               IF NOT cl_null(g_master.ooag001) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
                  LET g_chkparam.arg1 = g_master.ooag001
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#30  add
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     LET g_master.ooag001_desc = s_desc_get_person_desc(g_master.ooag001)
                     DISPLAY BY NAME g_master.ooag001_desc
                  ELSE
                     LET g_master.ooag001 = ''
                     LET g_master.ooag001_desc = ''
                     DISPLAY BY NAME g_master.ooag001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ON CHANGE l_nmck034
               LET g_nmck034_wc = ''
               CASE g_master.l_nmck034
                  WHEN '1'
                     LET g_nmck034_wc = " nmck034 = '1' "
                  WHEN '2'
                     LET g_nmck034_wc = " nmck034 = '2' "
                  WHEN '3'
                     LET g_nmck034_wc = " nmck034 = '3' "
                  WHEN '4'
                     LET g_nmck034_wc = " 1 = 1 "
               END CASE

            ON ACTION controlp INFIELD nmcksite
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmcksite    #給予default值
               #LET g_qryparam.where = " ooef206 = 'Y'"                      #161021-00050#1 mark
               #CALL q_ooef001()                                #呼叫開窗     #161021-00050#1 mark
               CALL q_ooef001_33()                                           #161021-00050#1 add
               LET g_master.nmcksite = g_qryparam.return1              
               LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
               DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc                
               NEXT FIELD nmcksite  
            
            ON ACTION controlp INFIELD nmckcomp
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmckcomp    #給予default值
               CALL s_fin_account_center_sons_query('6',g_master.nmcksite,g_today,'1')
               #取得資金中心底下的法人範圍               
               CALL s_fin_account_center_comp_str() RETURNING g_wc_nmckcomp
               CALL s_fin_get_wc_str(g_wc_nmckcomp) RETURNING g_wc_nmckcomp
               LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc               
               LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_nmckcomp CLIPPED
               #160816-00012#2 Add  ---(S)---
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
               LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
               #160816-00012#2 Add  ---(E)---
               CALL q_ooef017_01()                                #呼叫開窗
               LET g_master.nmckcomp = g_qryparam.return1  
               LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
               DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc            
               NEXT FIELD nmckcomp                          #返回原欄位
               
            ON ACTION controlp INFIELD ooag001   
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.ooag001  
               LET g_qryparam.arg1 = ""            
               CALL q_ooag001()                              
               LET g_master.ooag001 = g_qryparam.return1
               LET g_master.ooag001_desc = s_desc_get_person_desc(g_master.ooag001)               
               DISPLAY BY NAME g_master.ooag001,g_master.ooag001_desc            
               NEXT FIELD ooag001  
                              
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
         END INPUT

         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
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
            LET g_master.l_nmck034 = '4'
            LET g_nmck034_wc = ' 1 = 1 '
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
            CALL anmp450_filter()
            #add-point:ON ACTION filter name="menu.filter"
            #單身資料二次搜尋
            CALL anmp450_filter2()
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
            CALL anmp450_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL anmp450_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL anmp450_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL anmp450_process()
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
 
{<section id="anmp450.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmp450_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL anmp450_b_fill()
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
 
{<section id="anmp450.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmp450_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc_filter2) THEN
      LET g_wc_filter2 = "1=1"
   END IF 
   LET g_sql =" SELECT 'N',nmck025,nmck005,nmck015,nmck011,nmck034 ",
              "  FROM nmck_t ",    
              "  WHERE nmckent = ? ",
              "    AND nmcksite = '",g_master.nmcksite,"' ",   #資金中心條件
              "    AND nmckcomp = '",g_master.nmckcomp,"' ",   #法人條件
              "    AND nmck025 IS NOT NULL ",                  #票據號碼非空白
              "    AND nmckstus ='Y' ",                        #有效的
              "    AND nmck026 in (0,1,2) ",                   #票況        
              "    AND nmck035 IS NULL ",                      #領取日期
              "    AND ",g_nmck034_wc,                         #寄領方式
              "    AND ",g_wc_filter2,
              "  ORDER BY nmck025,nmck005"
   #end add-point
 
   PREPARE anmp450_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmp450_sel
   
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
      
      #end add-point
      
      CALL anmp450_detail_show()      
 
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
   IF g_detail_d.getLength() > 0 THEN
      CALL g_detail_d.deleteElement(g_detail_d.getLength())
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmp450_sel
   
   LET l_ac = 1
   CALL anmp450_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp450.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmp450_fetch()
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
 
{<section id="anmp450.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmp450_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmp450.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmp450_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   RETURN 
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
   
   CALL anmp450_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="anmp450.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmp450_filter_parser(ps_field)
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
 
{<section id="anmp450.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmp450_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmp450_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmp450.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 檢驗是否在組織下之有效的法人
# Memo...........:
# Usage..........: CALL anmp450_nmcksite_chk()
# Date & Author..: 150604 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp450_nmcksite_chk()
DEFINE l_ooefstus          LIKE ooef_t.ooefstus
DEFINE r_success           LIKE type_t.num5
DEFINE r_errno             LIKE gzze_t.gzze001

   LET r_success = TRUE
   LET r_errno = ''
   
   SELECT ooefstus INTO l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.nmcksite  
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET r_errno = 'aoo-00094' LET r_success = FALSE
      WHEN l_ooefstus = 'N'    LET r_errno = 'sub-01302' LET r_success = FALSE  #aoo-00095  #160318-00005#27  By 07900--mod  
   END CASE
   
   RETURN r_success,r_errno
   
END FUNCTION

################################################################################
# Descriptions...: 單身進行二次搜尋
# Memo...........:
# Usage..........: CALL anmp450_filter2()
# Date & Author..: 150604 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp450_filter2()
DEFINE l_wc_filter2_t STRING

   LET INT_FLAG = 0

   LET l_ac = 1
   LET g_detail_cnt = 1
  
   LET l_wc_filter2_t = g_wc_filter2
   LET g_wc_t = g_wc
     
   #使用DIALOG包住 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #進行二次搜尋的欄位
      CONSTRUCT g_wc_filter2 ON nmck025,nmck005,nmck015,nmck011,nmck034 
           FROM s_detail1[1].b_nmck025,s_detail1[1].b_nmck005,s_detail1[1].b_nmck015,
                s_detail1[1].b_nmck011,s_detail1[1].b_nmck034
      
         BEFORE CONSTRUCT
         ON ACTION controlp INFIELD b_nmck025
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_master.nmcksite
            LET g_qryparam.arg2 = g_master.nmckcomp
            LET g_qryparam.where = "nmck026 IN (0,1,2) AND nmck034 = '1' AND nmck025 IS NOT NULL AND nmckstus = 'Y'"
            CALL q_nmck025_1()
            DISPLAY g_qryparam.return1 TO b_nmck025
         NEXT FIELD b_nmck025
         
         ON ACTION controlp INFIELD b_nmck005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa005 = '",g_master.nmckcomp,"' "
            CALL q_pmaa001_10()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck005  #顯示到畫面上
         NEXT FIELD b_nmck005  
      END CONSTRUCT
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
     &include "common_action.4gl"
     CONTINUE DIALOG
     
   END DIALOG 

      
      IF NOT INT_FLAG THEN
         LET g_wc_filter2 = g_wc_filter2, " "
      ELSE
         LET g_wc_filter2 = l_wc_filter2_t
      END IF
      
      CALL anmp450_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 資料處理
# Memo...........:
# Usage..........: CALL anmp450_process()
# Date & Author..: 150604 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp450_process()
DEFINE l_n          LIKE type_t.num5    
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_print_type LIKE type_t.chr500  #列印參數
DEFINE l_i          LIKE type_t.num5    
DEFINE l_wc         STRING              
   
   #確認必要欄位是否有輸入值否則報錯
   IF cl_null(g_master.nmcksite) OR cl_null(g_master.nmckcomp) OR cl_null(g_master.nmck035) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00332'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #總共有幾筆資料要跑
   LET l_cnt = 0
   FOR l_n = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_n].sel = "Y" THEN
         LET l_cnt = l_cnt + 1
      END IF
   END FOR
  
   #取得有勾選的票號條件
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR 
      ELSE
         IF cl_null(l_wc) THEN
            LET l_wc = g_detail_d[l_i].nmck025
         ELSE
            LET l_wc = l_wc,"','",g_detail_d[l_i].nmck025
         END IF       
      END IF
   END FOR
   #如未勾選任何一筆資料
   IF cl_null(l_wc) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()       
      LET g_success = 'N'
      RETURN
   ELSE
      LET l_wc = "('",l_wc,"')"      
   END IF

   #列印需求
   LET g_master_wc = "nmckent = ",g_enterprise," AND nmck025 IN ",l_wc CLIPPED 
   IF g_master.chk_1 = 'Y' THEN 
      LET l_print_type = 'a'
      CALL anmp450_g01(g_master_wc,l_print_type,g_master.nmcksite,g_master.nmckcomp,g_master.ooag001)
   END IF
   
   IF g_master.chk_2 = 'Y' THEN
      LET l_print_type = 'b'
      CALL anmp450_g01(g_master_wc,l_print_type,g_master.nmcksite,g_master.nmckcomp,g_master.ooag001)
   END IF
   
   IF g_master.chk_3 = 'Y' THEN
      LET l_print_type = 'c'
      CALL anmp450_g01(g_master_wc,l_print_type,g_master.nmcksite,g_master.nmckcomp,g_master.ooag001)
   END IF
   
   IF g_master.chk_4 = 'Y' THEN
      CALL anmp450_g02(g_master_wc,g_master.nmckcomp)
   END IF         
   #有勾大宗存根才詢問是否回寫寄領出日期
   IF g_master.chk_2 = 'Y' THEN
      IF cl_ask_confirm('anm-02914') THEN   
         CALL s_transaction_begin()
         FOR l_n = 1 TO g_detail_d.getLength()
            IF g_detail_d[l_n].sel = "Y" THEN  
               #回寫異動/列印日期和寄件人
               CALL anmp450_writeback_date(g_master.nmck035,g_master.nmckcomp,g_detail_d[l_n].nmck025) RETURNING g_sub_success
            END IF
         END FOR
      ELSE
         CALL s_transaction_end('N','0')
      END IF   
      IF g_sub_success THEN
         #執行成功
         CALL s_transaction_end('Y','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00217'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL anmp450_b_fill()
      ELSE
         #執行失敗
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00218'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL anmp450_b_fill() 
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 資料回寫
# Memo...........:
# Usage..........: CALL anmp450_writeback_date(p_nmck035,p_nmckcomp,p_nmck025)
# Date & Author..: 150604 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp450_writeback_date(p_nmck035,p_nmckcomp,p_nmck025)
DEFINE p_nmck035  LIKE nmck_t.nmck035
DEFINE p_nmckcomp LIKE nmck_t.nmckcomp
DEFINE p_nmck025  LIKE nmck_t.nmck025
DEFINE r_success  LIKE type_t.num5
DEFINE l_today    DATETIME YEAR TO SECOND
   LET r_success = TRUE
   IF NOT cl_null(p_nmck035) THEN
      LET l_today = cl_get_current()
      UPDATE nmck_t
         SET nmck035 = p_nmck035,
             nmck022 = g_user,
             nmckmodid = g_user,
             nmckcnfid = g_user,
             nmckmoddt = l_today,
             nmckcnfdt = l_today
       WHERE nmckent = g_enterprise
         AND nmckcomp = p_nmckcomp
         AND nmck025 = p_nmck025
         AND nmck034 = '1'                #150902-00001#1
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPDATE nmck_t wrong'
         LET g_errparam.popup = TRUE
         LET g_errparam.sqlerr = SQLCA.SQLCODE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 清空QBE
# Memo...........:
# Usage..........: CALL anmp450_qbe_clear())
# Date & Author..: 150616 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp450_qbe_clear()
   #清空二次條件
   LET g_wc_filter2 = ""

   CALL s_fin_account_center_sons_query('6',g_master.nmcksite,g_today,'1')
   #取得資金中心底下的法人範圍               
   CALL s_fin_account_center_comp_str() RETURNING g_wc_nmckcomp
   CALL s_fin_get_wc_str(g_wc_nmckcomp) RETURNING g_wc_nmckcomp 
         
   #預設值
   LET g_master.nmcksite = g_site
   LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
   CALL s_fin_orga_get_comp_ld(g_master.nmcksite) RETURNING g_sub_success,g_errno,g_master.nmckcomp,g_apcald
   LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
   LET g_master.nmck035 = g_today
   LET g_master.ooag001 = g_user   
   LET g_master.ooag001_desc = s_desc_get_person_desc(g_master.ooag001)
   LET g_master.chk_1 = 'N'
   LET g_master.chk_2 = 'N'
   LET g_master.chk_3 = 'N'
   LET g_master.chk_4 = 'N'
   
   DISPLAY BY NAME g_master.nmcksite,g_master.nmcksite_desc,g_master.nmckcomp,
                   g_master.nmckcomp_desc,g_master.nmck035,g_master.ooag001,
                   g_master.ooag001_desc,g_master.chk_1,g_master.chk_2,g_master.chk_3,
                   g_master.chk_4
END FUNCTION

#end add-point
 
{</section>}
 
