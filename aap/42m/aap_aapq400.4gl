#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2016-08-31 15:56:48), PR版次:0013(2017-01-18 14:57:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000596
#+ Filename...: aapq400
#+ Description: 應付未付款查詢作業
#+ Creator....: 03080(2015-01-28 10:02:19)
#+ Modifier...: 08171 -SD/PR- 03080
 
{</section>}
 
{<section id="aapq400.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150319-00004#5             By rayhuang 新增Q轉XG   只列印有勾選的明細資料
#150915          2015/09/15 By Reanna   增加現行匯率
#151013-00019#10 2015/11/11 By Reanna   單身加合計
#151231-00010#4  2016/01/11 By 02097    增加控制組
#160518-00075#26 2016/08/01 By 03538    使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#160818-00002#1  2016/08/29 By 08171    帳款單號後面增加帳款日期(apcadocdt)
#161006-00005#19 2016/10/24 By 08732    組織類型與職能開窗調整
#161108-00017#2  2016/11/09 By Reanna   程式中INSERT INTO 有星號作整批調整
#161114-00017#2  2016/11/14 By 06821    應付_開窗過濾據點
#161229-00047#31 2017/01/12 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170112-00044#2  170118     By albireo  對象識別碼說明改為由apca004判斷抓對象識別碼說明或員工說明
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
 
#單身 type 宣告
PRIVATE TYPE type_g_apcc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   apccld LIKE type_t.chr100, 
   apca005 LIKE type_t.chr100, 
   apccdocno LIKE apcc_t.apccdocno, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apcc009 LIKE apcc_t.apcc009, 
   apccseq LIKE apcc_t.apccseq, 
   apcc001 LIKE apcc_t.apcc001, 
   apcc003 LIKE apcc_t.apcc003, 
   apcc004 LIKE apcc_t.apcc004, 
   apcc002 LIKE apcc_t.apcc002, 
   apcc100 LIKE apcc_t.apcc100, 
   apcc108 LIKE apcc_t.apcc108, 
   apcc109 LIKE apcc_t.apcc109, 
   l_apcc109n LIKE type_t.num20_6, 
   l_apcc109 LIKE type_t.num20_6, 
   apcc118 LIKE apcc_t.apcc118, 
   apcc119 LIKE apcc_t.apcc119, 
   l_apcc119n LIKE type_t.num20_6, 
   l_apcc119 LIKE type_t.num20_6, 
   apca004 LIKE type_t.chr100, 
   apca057 LIKE type_t.chr100, 
   apca007 LIKE type_t.chr100, 
   apca033 LIKE type_t.chr100, 
   apca015 LIKE type_t.chr100, 
   apca014 LIKE type_t.chr100, 
   apca053 LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_input RECORD
         apcasite LIKE apca_t.apcasite,
         apcasite_desc LIKE type_t.chr100,
         grouptype     LIKE type_t.chr1
                  END RECORD
DEFINE g_input    type_g_input
DEFINE g_input_o  type_g_input
DEFINE g_wc_comp  STRING
DEFINE g_wc_site  STRING
DEFINE g_wc_ld    STRING
TYPE type_g_apcc_d2 RECORD
         apccld2    LIKE type_t.chr100,
         apca0052   LIKE type_t.chr100,
         apcc0022   LIKE apcc_t.apcc002,
         apcc1002   LIKE apcc_t.apcc100,
         apcc0032   LIKE apcc_t.apcc003,
         apcc0042   LIKE apcc_t.apcc004,
         apcc1092   LIKE apcc_t.apcc109,
         apcc1192   LIKE apcc_t.apcc119,
         apcc101    LIKE apcc_t.apcc101  #150915
                    END RECORD
DEFINE g_apcc_d2    DYNAMIC ARRAY OF type_g_apcc_d2
DEFINE g_sum        RECORD
                    sumapcc1091   LIKE apcc_t.apcc109,
                    sumapcc1191   LIKE apcc_t.apcc119,
                    sumapcc1092   LIKE apcc_t.apcc109,
                    sumapcc1192   LIKE apcc_t.apcc119
                    END RECORD
DEFINE g_sql_ctrl          STRING               #151231-00010#4
DEFINE g_user_dept_wc      STRING               #160518-00075#26
DEFINE g_user_dept_wc_q    STRING               #160518-00075#26
DEFINE g_comp              LIKE apca_t.apcacomp #161114-00017#2 add
DEFINE g_comp_str          STRING               #161229-00047#31
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apcc_d
DEFINE g_master_t                   type_g_apcc_d
DEFINE g_apcc_d          DYNAMIC ARRAY OF type_g_apcc_d
DEFINE g_apcc_d_t        type_g_apcc_d
 
      
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
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
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
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapq400.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   #161114-00017#2 --s mark
   ##151231-00010#4--(S)
   #LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   ##151231-00010#4--(E)
   #161114-00017#2 --e mark
   #161114-00017#2 --s add
   #因單頭為INPUT,因此直接以帳套法人傳入
   LET g_sql_ctrl = NULL
   LET g_comp = ''
   SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.apcasite AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#31 mark
   #161114-00017#2 --e add
   #161229-00047#31 add ------
   CALL s_fin_get_wc_str(g_comp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#31 add end---
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq400_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq400_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq400 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq400_init()   
 
      #進入選單 Menu (="N")
      CALL aapq400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq400
      
   END IF 
   
   CLOSE aapq400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq400_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_apcc002','8310') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_apcc0022','8310') 
   CALL aapq400_create_tmp()
   CALL aapq400_x01_tmp()                         #150319-00004#5
   #end add-point
 
   CALL aapq400_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq400.default_search" >}
PRIVATE FUNCTION aapq400_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apccld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apccdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " apccseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " apcc001 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " apcc009 = '", g_argv[05], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   #建立撈取帳務中心所屬範圍需使用的暫存檔
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc('grouptype','8034')
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq400_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   #150319-00004#5-----s
   DEFINE l_i          LIKE type_t.num10 
   DEFINE apcc002_desc LIKE type_t.chr80  
   DEFINE l_x01_tmp   RECORD              #XG報表用的temp
           apccld     LIKE type_t.chr80, 
           apca005    LIKE type_t.chr80, 
           apccdocno  LIKE apcc_t.apccdocno, 
           apcadocdt  LIKE apca_t.apcadocdt,      #160818-00002#1 add 帳款日期
           apcc009    LIKE apcc_t.apcc009, 
           apccseq    LIKE apcc_t.apccseq, 
           apcc001    LIKE apcc_t.apcc001, 
           apcc003    LIKE apcc_t.apcc003, 
           apcc004    LIKE apcc_t.apcc004, 
           apcc002    LIKE type_t.chr500, 
           apcc100    LIKE apcc_t.apcc100, 
           l_apcc109  LIKE type_t.num20_6, 
           l_apcc119  LIKE type_t.num20_6, 
           apca004    LIKE type_t.chr80, 
           apca057    LIKE type_t.chr80, 
           apca007    LIKE type_t.chr80, 
           apca033    LIKE type_t.chr80, 
           apca015    LIKE type_t.chr80, 
           apca014    LIKE type_t.chr80,
           l_apcasite LIKE type_t.chr500
                  END RECORD
   #150319-00004#5-----e
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
   ELSE
      CALL aapq400_qbeclear()
   END IF
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aapq400_b_fill()
   ELSE
      CALL aapq400_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apcc_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aapq400_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apcc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq400_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq400_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION choice_one
            LET g_action_choice="choice_one"
               
               #add-point:ON ACTION choice_one name="menu.detail_show.page1.choice_one"
               FOR li_idx = 1 TO g_apcc_d.getLength()
                  IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                     IF g_apcc_d[li_idx].sel = "Y" THEN
                        LET g_apcc_d[li_idx].sel = "N"
                     ELSE
                        LET g_apcc_d[li_idx].sel = 'Y'
                     END IF
                  END IF
               END FOR
               CALL aapq400_sumchoice()
               #END add-point
               
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_apcc_d2 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
            
               
         END DISPLAY
         
         INPUT BY NAME g_input.grouptype
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
            #判斷page1是否有選擇
            IF g_apcc_d.getLength() <= 0 THEN
               #沒搜尋資料
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00022'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               NEXT FIELD sel
            END IF
            
            LET g_sub_success = FALSE
            FOR li_idx = 1 TO g_apcc_d.getLength()
               IF g_apcc_d[li_idx].sel = 'Y' THEN
                  LET g_sub_success = TRUE
                  EXIT FOR
               END IF
            END FOR
            
            IF NOT g_sub_success THEN
               #沒選取資料
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00021'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               NEXT FIELD sel              
            END IF
            CALL aapq400_b_fill2()
            
            ON CHANGE grouptype
               CALL aapq400_b_fill2()
         END INPUT
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aapq400_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible('insert',FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapq400_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #150319-00004#5 -----s 
               DELETE FROM aapq400_x01_tmp
               FOR l_i = 1 TO g_apcc_d.getLength()
                  CALL s_desc_gzcbl004_desc('8310',g_apcc_d[l_i].apcc002) RETURNING apcc002_desc
                  IF g_apcc_d[l_i].sel= 'Y' THEN     #選擇勾選的資料進行列印
                     INITIALIZE l_x01_tmp.* TO NULL
                     LET l_x01_tmp.apccld     =  g_apcc_d[l_i].apccld
                     LET l_x01_tmp.apca005    =  g_apcc_d[l_i].apca005
                     LET l_x01_tmp.apccdocno  =  g_apcc_d[l_i].apccdocno
                     LET l_x01_tmp.apcadocdt  =  g_apcc_d[l_i].apcadocdt  #160818-00002#1 add
                     LET l_x01_tmp.apcc009    =  g_apcc_d[l_i].apcc009
                     LET l_x01_tmp.apccseq    =  g_apcc_d[l_i].apccseq
                     LET l_x01_tmp.apcc001    =  g_apcc_d[l_i].apcc001
                     LET l_x01_tmp.apcc003    =  g_apcc_d[l_i].apcc003
                     LET l_x01_tmp.apcc004    =  g_apcc_d[l_i].apcc004
                     LET l_x01_tmp.apcc002    =  g_apcc_d[l_i].apcc002,":",apcc002_desc
                     LET l_x01_tmp.apcc100    =  g_apcc_d[l_i].apcc100
                     LET l_x01_tmp.l_apcc109  =  g_apcc_d[l_i].l_apcc109
                     LET l_x01_tmp.l_apcc119  =  g_apcc_d[l_i].l_apcc119
                     LET l_x01_tmp.apca004    =  g_apcc_d[l_i].apca004
                     LET l_x01_tmp.apca057    =  g_apcc_d[l_i].apca057
                     LET l_x01_tmp.apca007    =  g_apcc_d[l_i].apca007
                     LET l_x01_tmp.apca033    =  g_apcc_d[l_i].apca033
                     LET l_x01_tmp.apca015    =  g_apcc_d[l_i].apca015
                     LET l_x01_tmp.apca014    =  g_apcc_d[l_i].apca014
                     LET l_x01_tmp.l_apcasite =  g_input.apcasite,":",g_input.apcasite_desc
                     #INSERT INTO aapq400_x01_tmp VALUES(l_x01_tmp.*) #161108-00017#2 mark
                     #161108-00017#2 add ------
                     INSERT INTO aapq400_x01_tmp (apccld,apca005,apccdocno,apcadocdt,apcc009,
                                                  apccseq,apcc001,apcc003,apcc004,apcc002,
                                                  apcc100,l_apcc109,l_apcc119,apca004,apca057,
                                                  apca007,apca033,apca015,apca014,l_apcasite
                                                 )
                     VALUES (l_x01_tmp.apccld,l_x01_tmp.apca005,l_x01_tmp.apccdocno,l_x01_tmp.apcadocdt,l_x01_tmp.apcc009,
                             l_x01_tmp.apccseq,l_x01_tmp.apcc001,l_x01_tmp.apcc003,l_x01_tmp.apcc004,l_x01_tmp.apcc002,
                             l_x01_tmp.apcc100,l_x01_tmp.l_apcc109,l_x01_tmp.l_apcc119,l_x01_tmp.apca004,l_x01_tmp.apca057,
                             l_x01_tmp.apca007,l_x01_tmp.apca033,l_x01_tmp.apca015,l_x01_tmp.apca014,l_x01_tmp.l_apcasite
                            )
                     #161108-00017#2 add end---
                  END IF
               END FOR
               #150319-00004#5-----e
               CALL aapq400_x01(" 1=1","aapq400_x01_tmp" )    #150319-00004#5
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150319-00004#5 -----s 
               DELETE FROM aapq400_x01_tmp
               FOR l_i = 1 TO g_apcc_d.getLength()
                  CALL s_desc_gzcbl004_desc('8310',g_apcc_d[l_i].apcc002) RETURNING apcc002_desc
                  IF g_apcc_d[l_i].sel= 'Y' THEN     #選擇勾選的資料進行列印
                     INITIALIZE l_x01_tmp.* TO NULL
                     LET l_x01_tmp.apccld     =  g_apcc_d[l_i].apccld
                     LET l_x01_tmp.apca005    =  g_apcc_d[l_i].apca005
                     LET l_x01_tmp.apccdocno  =  g_apcc_d[l_i].apccdocno
                     LET l_x01_tmp.apcadocdt  =  g_apcc_d[l_i].apcadocdt  #160818-00002#1 add
                     LET l_x01_tmp.apcc009    =  g_apcc_d[l_i].apcc009
                     LET l_x01_tmp.apccseq    =  g_apcc_d[l_i].apccseq
                     LET l_x01_tmp.apcc001    =  g_apcc_d[l_i].apcc001
                     LET l_x01_tmp.apcc003    =  g_apcc_d[l_i].apcc003
                     LET l_x01_tmp.apcc004    =  g_apcc_d[l_i].apcc004
                     LET l_x01_tmp.apcc002    =  g_apcc_d[l_i].apcc002,":",apcc002_desc
                     LET l_x01_tmp.apcc100    =  g_apcc_d[l_i].apcc100
                     LET l_x01_tmp.l_apcc109  =  g_apcc_d[l_i].l_apcc109
                     LET l_x01_tmp.l_apcc119  =  g_apcc_d[l_i].l_apcc119
                     LET l_x01_tmp.apca004    =  g_apcc_d[l_i].apca004
                     LET l_x01_tmp.apca057    =  g_apcc_d[l_i].apca057
                     LET l_x01_tmp.apca007    =  g_apcc_d[l_i].apca007
                     LET l_x01_tmp.apca033    =  g_apcc_d[l_i].apca033
                     LET l_x01_tmp.apca015    =  g_apcc_d[l_i].apca015
                     LET l_x01_tmp.apca014    =  g_apcc_d[l_i].apca014
                     LET l_x01_tmp.l_apcasite =  g_input.apcasite,":",g_input.apcasite_desc
                     #INSERT INTO aapq400_x01_tmp VALUES(l_x01_tmp.*) #161108-00017#2 mark
                     #161108-00017#2 add ------
                     INSERT INTO aapq400_x01_tmp (apccld,apca005,apccdocno,apcadocdt,apcc009,
                                                  apccseq,apcc001,apcc003,apcc004,apcc002,
                                                  apcc100,l_apcc109,l_apcc119,apca004,apca057,
                                                  apca007,apca033,apca015,apca014,l_apcasite
                                                 )
                     VALUES (l_x01_tmp.apccld,l_x01_tmp.apca005,l_x01_tmp.apccdocno,l_x01_tmp.apcadocdt,l_x01_tmp.apcc009,
                             l_x01_tmp.apccseq,l_x01_tmp.apcc001,l_x01_tmp.apcc003,l_x01_tmp.apcc004,l_x01_tmp.apcc002,
                             l_x01_tmp.apcc100,l_x01_tmp.l_apcc109,l_x01_tmp.l_apcc119,l_x01_tmp.apca004,l_x01_tmp.apca057,
                             l_x01_tmp.apca007,l_x01_tmp.apca033,l_x01_tmp.apca015,l_x01_tmp.apca014,l_x01_tmp.l_apcasite
                            )
                     #161108-00017#2 add end---
                  END IF
               END FOR
               #150319-00004#5-----e
               CALL aapq400_x01(" 1=1","aapq400_x01_tmp" )    #150319-00004#5
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapq400_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL aapq400_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apcc_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_apcc_d2)
               LET g_export_id[2]   = "s_detail2"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL aapq400_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq400_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq400_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq400_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apcc_d.getLength()
               LET g_apcc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL aapq400_sumchoice() 
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_apcc_d.getLength()
               LET g_apcc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            CALL aapq400_sumchoice()
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_apcc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apcc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            CALL aapq400_sumchoice()
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_apcc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apcc_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            CALL aapq400_sumchoice()
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
    
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq400_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apcc_d.clear()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON apccdocno,apcadocdt,apcc009,apcc003,apcc004,apcc002,apcc100
           FROM s_detail1[1].b_apccdocno,s_detail1[1].b_apcadocdt,s_detail1[1].b_apcc009,s_detail1[1].b_apcc003, 
               s_detail1[1].b_apcc004,s_detail1[1].b_apcc002,s_detail1[1].b_apcc100
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_apccld>>----
         #----<<b_apca005>>----
         #----<<b_apccdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apccdocno
            #add-point:BEFORE FIELD b_apccdocno name="construct.b.page1.b_apccdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apccdocno
            
            #add-point:AFTER FIELD b_apccdocno name="construct.a.page1.b_apccdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apccdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apccdocno
            #add-point:ON ACTION controlp INFIELD b_apccdocno name="construct.c.page1.b_apccdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apcastus = 'Y' AND apcc108-apcc109 <> 0 ",
                                   " AND apcald IN ",g_wc_ld,
                                   " AND apcasite IN ",g_wc_site,
                                   " AND (EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apcaent AND glbald = apcald AND glba001 = '",g_user,"') ",
                                   "         OR EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apcaent AND glbbld = apcald AND glbb001 = '",g_dept,"') ",
                                   "         OR (NOT EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apcaent AND glbald = apcald) AND NOT EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apcaent AND glbbld = apcald))) ",
                                   " AND apca001 NOT LIKE ('3%') AND apca001 NOT LIKE ('0%') "
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where , " AND apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            #160518-00075#26--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q  
            END IF            
            #160518-00075#26--e              
            CALL q_apcadocno_13()
            DISPLAY g_qryparam.return1 TO b_apccdocno
            NEXT FIELD b_apccdocno
            #END add-point
 
 
         #----<<b_apcadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcadocdt
            #add-point:BEFORE FIELD b_apcadocdt name="construct.b.page1.b_apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcadocdt
            
            #add-point:AFTER FIELD b_apcadocdt name="construct.a.page1.b_apcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apcc009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc009
            #add-point:BEFORE FIELD b_apcc009 name="construct.b.page1.b_apcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc009
            
            #add-point:AFTER FIELD b_apcc009 name="construct.a.page1.b_apcc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc009
            #add-point:ON ACTION controlp INFIELD b_apcc009 name="construct.c.page1.b_apcc009"
            
            #END add-point
 
 
         #----<<b_apccseq>>----
         #----<<b_apcc001>>----
         #----<<b_apcc003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc003
            #add-point:BEFORE FIELD b_apcc003 name="construct.b.page1.b_apcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc003
            
            #add-point:AFTER FIELD b_apcc003 name="construct.a.page1.b_apcc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc003
            #add-point:ON ACTION controlp INFIELD b_apcc003 name="construct.c.page1.b_apcc003"
            
            #END add-point
 
 
         #----<<b_apcc004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc004
            #add-point:BEFORE FIELD b_apcc004 name="construct.b.page1.b_apcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc004
            
            #add-point:AFTER FIELD b_apcc004 name="construct.a.page1.b_apcc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc004
            #add-point:ON ACTION controlp INFIELD b_apcc004 name="construct.c.page1.b_apcc004"
            
            #END add-point
 
 
         #----<<b_apcc002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc002
            #add-point:BEFORE FIELD b_apcc002 name="construct.b.page1.b_apcc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc002
            
            #add-point:AFTER FIELD b_apcc002 name="construct.a.page1.b_apcc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc002
            #add-point:ON ACTION controlp INFIELD b_apcc002 name="construct.c.page1.b_apcc002"
            
            #END add-point
 
 
         #----<<b_apcc100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcc100
            #add-point:BEFORE FIELD b_apcc100 name="construct.b.page1.b_apcc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcc100
            
            #add-point:AFTER FIELD b_apcc100 name="construct.a.page1.b_apcc100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc100
            #add-point:ON ACTION controlp INFIELD b_apcc100 name="construct.c.page1.b_apcc100"
            #albireo 150225-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO b_apcc100  #顯示到畫面上
            NEXT FIELD b_apcc100
            #albireo 150225-----e   
            #END add-point
 
 
         #----<<b_apcc108>>----
         #----<<b_apcc109>>----
         #----<<l_apcc109n>>----
         #----<<l_apcc109>>----
         #----<<b_apcc118>>----
         #----<<b_apcc119>>----
         #----<<l_apcc119n>>----
         #----<<l_apcc119>>----
         #----<<b_apca004>>----
         #----<<b_apca057>>----
         #----<<b_apca007>>----
         #----<<b_apca033>>----
         #----<<b_apca015>>----
         #----<<b_apca014>>----
         #----<<b_apca053>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.apcasite ATTRIBUTE(WITHOUT DEFAULTS)
      
         AFTER FIELD apcasite
            IF NOT cl_null(g_input.apcasite) THEN
               IF (g_input.apcasite != g_input_o.apcasite OR g_input_o.apcasite IS NULL) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apcasite = ''
                     LET g_input.apcasite_desc = ''
                     LET g_wc_site = ''
                     LET g_wc_ld   = ''
                     LET g_wc_comp = ''
                     LET g_input_o.apcasite = g_input.apcasite
                     LET g_input_o.apcasite_desc = g_input.apcasite_desc
                     DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
                     NEXT FIELD CURRENT
                  END IF
                                     
                  CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
                  #取得帳務中心底下之組織範圍
                  CALL s_fin_account_center_sons_str() RETURNING g_wc_site
                  CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
                  #取得帳務中心底下的帳套範圍               
                  CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
                  CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
                  #取得帳務中心底下的法人範圍
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_comp
                  CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp
                  
                  LET g_input.apcasite_desc= s_desc_get_department_desc(g_input.apcasite)
                  DISPLAY BY NAME g_input.apcasite_desc
                  
                  #161114-00017#2 --s add
                  #控制組
                  LET g_sql_ctrl = NULL
                  LET g_comp = ''
                  SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.apcasite AND ooefstus = 'Y'
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#31 mark
                  #161114-00017#2 --e add                   
               END IF
            ELSE                        
               LET g_input.apcasite_desc = ''
               LET g_wc_site = ''
               LET g_wc_ld   = ''
               LET g_wc_comp = ''
               DISPLAY BY NAME g_input.apcasite_desc
            END IF
            #161229-00047#31 add ------
            CALL s_fin_get_wc_str(g_comp) RETURNING g_comp_str
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
            #161229-00047#31 add end---
            CALL s_desc_get_department_desc(g_input.apcasite)RETURNING g_input.apcasite_desc
            LET g_input_o.apcasite = g_input.apcasite
            
         ON ACTION controlp INFIELD apcasite
            #帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.apcasite       
            #CALL q_ooef001()     #161006-00005#19   mark
            CALL q_ooef001_46()   #161006-00005#19   add                               
            LET g_input.apcasite = g_qryparam.return1        
            CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
            DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc 
            NEXT FIELD apcasite
      END INPUT
      
      BEFORE DIALOG 
         DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
         CALL aapq400_qbeclear()
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL aapq400_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aapq400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq400_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_tmp      type_g_apcc_d
   #170112-00044#2-----s
   DEFINE l_apca057_desc LIKE type_t.chr100
   DEFINE l_sql          STRING
   #170112-00044#2-----e
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','',apccdocno,'',apcc009,apccseq,apcc001,apcc003,apcc004,apcc002, 
       apcc100,apcc108,apcc109,'','',apcc118,apcc119,'','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY apcc_t.apccld, 
       apcc_t.apccdocno,apcc_t.apccseq,apcc_t.apcc001,apcc_t.apcc009) AS RANK FROM apcc_t",
 
 
                     "",
                     " WHERE apccent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apcc_t"),
                     " ORDER BY apcc_t.apccld,apcc_t.apccdocno,apcc_t.apccseq,apcc_t.apcc001,apcc_t.apcc009"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '','','',apccdocno,'',apcc009,apccseq,apcc001,apcc003,apcc004,apcc002,apcc100, 
       apcc108,apcc109,'','',apcc118,apcc119,'','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #處理帳套串連
   #帳務中心限制加入
   LET ls_wc = ls_wc CLIPPED," AND apcald IN ",g_wc_ld," AND apcasite IN ",g_wc_site," "
   LET ls_wc = ls_wc CLIPPED," AND apca001 NOT LIKE ('3%') AND apca001 NOT LIKE ('0%') "
   LET ls_wc = ls_wc CLIPPED," AND apcastus = 'Y' "
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc =  ls_wc ," AND apca005 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)
   LET ls_wc = ls_wc," AND ",g_user_dept_wc   #160518-00075#26   
   DELETE FROM aapq400_tmp
   LET g_sql  = "INSERT INTO aapq400_tmp ",
                #"SELECT 'N',apca_t.apcald,apca_t.apca005,apca_t.apcadocno,apcc009,apccseq,", #160818-00002#1 mark
                "SELECT 'N',apca_t.apcald,apca_t.apca005,apca_t.apcadocno,apca_t.apcadocdt,apcc009,apccseq,", #160818-00002#1 add apca_t.apcadocdt
                "       apcc001,apcc003,apcc004,apcc002,apcc100, ",
                "       COALESCE(apcc108,0),COALESCE(apcc109,0),COALESCE(s1.apce109,0)+COALESCE(s2.apce109,0)+COALESCE(s3.xrce109,0)+COALESCE(s4.xrce109,0),0,",
                "       COALESCE(apcc118,0),COALESCE(apcc119,0),COALESCE(s1.apce119,0)+COALESCE(s2.apce119,0)+COALESCE(s3.xrce119,0)+COALESCE(s4.xrce119,0),0,",
                "       apca_t.apca004,",
                "       apca_t.apca057,apca_t.apca007,apca_t.apca033,apca_t.apca015,apca_t.apca014,apca_t.apca001, ",
                "       apccent, ",
                "       COALESCE(apca_t.apca040,'N'),COALESCE(apca_t.apca044,0), ",   #albireo 150213 留置否
               #"       COALESCE(s5.apcc108s5,0) ",                                   #albireo 150214 判斷待抵單來源是否已付用 #151013-00019#10 mark
                "       COALESCE(s5.apcc108s5,0), apca_t.apca053",                    #151013-00019#10
                " FROM apca_t ",
                #albireo 150214-----s
                #抓取待抵來源單的資料 做判斷
                " LEFT OUTER JOIN(",
                " SELECT apccent ent,apccld ld,apccdocno docno,(SUM(apcc108)- SUM(apcc109)) apcc108s5 ",
                "   FROM apca_t,apcc_t ",
                "  WHERE apcaent = apccent ",
                "    AND apcald  = apccld ",
                "    AND apcadocno = apccdocno ",
                " GROUP BY apccent,apccld,apccdocno ",
                " ) s5 ON s5.ent = apca_t.apcaent AND s5.ld = apca_t.apcald AND s5.docno = apca_t.apca018 ",
                #albireo 150214-----e
                ",apcc_t ",
                #應付沖帳未確認
                " LEFT OUTER JOIN( ",
                "    SELECT apceent,apceld,apce003,apce004,apce005,",
                "           SUM(apce109) apce109,SUM(apce119) apce119 ",
                "      FROM apce_t,apda_t ",
                "     WHERE apceent = apdaent ",
                "       AND apceld  = apdald ",
                "       AND apcedocno = apdadocno ",
                "       AND apdastus NOT IN('X','Y') ",
                "      GROUP BY apceent,apceld,apce003,apce004,apce005 ",
                "                ) s1 ON s1.apceent = apccent AND s1.apceld = apccld ",
                "                        AND s1.apce003 = apccdocno AND s1.apce004 = apccseq AND s1.apce005 = apcc001 ",
                #應付直接沖銷未確認
                " LEFT OUTER JOIN( ",
                "    SELECT apceent,apceld,apce003,apce004,apce005,",
                "           SUM(apce109) apce109,SUM(apce119) apce119 ",
                "      FROM apce_t,apca_t ",
                "     WHERE apceent = apcaent ",
                "       AND apceld  = apcald ",
                "       AND apcedocno = apcadocno ",
                "       AND apcastus NOT IN('X','Y') ",
                "      GROUP BY apceent,apceld,apce003,apce004,apce005 ",
                "                ) s2 ON s2.apceent = apccent AND s2.apceld = apccld ",
                "                        AND s2.apce003 = apccdocno AND s2.apce004 = apccseq AND s2.apce005 = apcc001 ",  
                #應收
                " LEFT OUTER JOIN( ",
                "    SELECT xrceent,xrceld,xrce003,xrce004,xrce005,",
                "           SUM(xrce109) xrce109,SUM(xrce119) xrce119 ",
                "      FROM xrce_t,xrda_t ",
                "     WHERE xrceent = xrdaent ",
                "       AND xrceld  = xrdald ",
                "       AND xrcedocno = xrdadocno ",
                "       AND xrdastus NOT IN('X','Y') ",
                "      GROUP BY xrceent,xrceld,xrce003,xrce004,xrce005 ",
                "                ) s3 ON s3.xrceent = apccent AND s3.xrceld = apccld ",
                "                        AND s3.xrce003 = apccdocno AND s3.xrce004 = apccseq AND s3.xrce005 = apcc001 ",
                #應收直接沖銷未確認
                " LEFT OUTER JOIN( ",
                "    SELECT xrceent,xrceld,xrce003,xrce004,xrce005,",
                "           SUM(xrce109) xrce109,SUM(xrce119) xrce119 ",
                "      FROM xrce_t,xrca_t ",
                "     WHERE xrceent = xrcaent ",
                "       AND xrceld  = xrcald ",
                "       AND xrcedocno = xrcadocno ",
                "       AND xrcastus NOT IN('X','Y') ",
                "      GROUP BY xrceent,xrceld,xrce003,xrce004,xrce005 ",
                "                ) s4 ON s4.xrceent = apccent AND s4.xrceld = apccld ",
                "                        AND s4.xrce003 = apccdocno AND s4.xrce004 = apccseq AND s4.xrce005 = apcc001 ",                  
                "WHERE apcaent = apccent ",
                "  AND apcald  = apccld ",
                "  AND apcadocno = apccdocno ",
                "  AND apccent = ? AND 1=1 AND ",ls_wc,cl_sql_add_filter("apcc_t"),cl_sql_add_filter("apca_t"),
                "  AND (EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apca_t.apcaent AND glbald = apca_t.apcald AND glba001 = '",g_user,"') ",
                "         OR EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apca_t.apcaent AND glbbld = apca_t.apcald AND glbb001 = '",g_dept,"') ",
                "         OR (NOT EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apca_t.apcaent AND glbald = apca_t.apcald) AND NOT EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apca_t.apcaent AND glbbld = apca_t.apcald))) ",
                " ORDER BY apca_t.apcald,apca_t.apca005,apca_t.apcadocno,apcc009,apccseq,apcc001 "
   PREPARE aapq400_ins_tmpp1 FROM g_sql
   EXECUTE aapq400_ins_tmpp1 USING g_enterprise
   
   #回寫合計欄位
   LET g_sql = "UPDATE aapq400_tmp SET l_apcc109 = apcc108-apcc109-l_apcc109n, ",
               "                       l_apcc119 = apcc118-apcc119-l_apcc119n "
   PREPARE aapq400_upd_tmpp1 FROM g_sql
   EXECUTE aapq400_upd_tmpp1
   
   #albireo 150213 留置否為Y時要多扣留置金額-----s
   #SA提醒是跟原幣扣 扣完就不顯示的規則是相同的
   LET g_sql = "UPDATE aapq400_tmp SET l_apcc109 = l_apcc109 - apca044 ",
               " WHERE apca040 = 'Y' "
   PREPARE aapq400_upd_tmpp3 FROM g_sql
   EXECUTE aapq400_upd_tmpp3   
   #albireo 150213 留置否為Y時要多扣留置金額-----e
   
   #albireo 150214 排除待底單來源單已經被付款完的---s
   LET g_sql = " DELETE FROM aapq400_tmp ",
               "  WHERE apca001 IN ('21','23','25','26') ",
               "    AND apcc108chk = 0 "
   PREPARE aapq400_del_tmpp2 FROM g_sql
   EXECUTE aapq400_del_tmpp2
   #albireo 150214 排除待抵單來源單已經被付款完的---e
   
   #刪除不是範圍資料的tmp
   LET g_sql = "DELETE FROM aapq400_tmp ",
               " WHERE l_apcc109 = 0 "
   PREPARE aapq400_del_tmpp1 FROM g_sql
   EXECUTE aapq400_del_tmpp1
   
   #依帳款單性質回寫正OR負
   LET g_sql = "UPDATE aapq400_tmp SET l_apcc109 = l_apcc109 * (-1), ",
               "                       apcc108   =  apcc108 * (-1), ",
               "                       apcc109   =  apcc109 * (-1), ",
               "                       l_apcc109n = l_apcc109n * (-1), ",
               "                       l_apcc119 = l_apcc119 * (-1), ",
               "                       apcc118   =  apcc118 * (-1), ",
               "                       apcc119   =  apcc119 * (-1), ",
               "                       l_apcc119n = l_apcc119n * (-1) ",
               " WHERE apca001 LIKE ('2%')"
   PREPARE aapq400_upd_tmpp2 FROM g_sql
   EXECUTE aapq400_upd_tmpp2
   
   LET g_sql = "SELECT sel,apccld,apca005,apccdocno,apcadocdt,apcc009,apccseq,",  #160818-00002#1 add apcadocdt
               "       apcc001,apcc003,apcc004,apcc002,apcc100, ",
               "       apcc108,apcc109,l_apcc109n,l_apcc109,apcc118,",
               "       apcc119,l_apcc119n,l_apcc119,apca004,",
               "       apca057,apca007,apca033,apca015,apca014,", #151013-00019#10 add ,
               "       apca053", #151013-00019#10
               "  FROM aapq400_tmp ",
               " WHERE ent = ?  "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq400_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq400_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apcc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #170112-00044#2-----s
   LET l_sql = " SELECT (CASE WHEN (SELECT pmaa004 FROM pmaa_t WHERE pmaaent = apcaent AND pmaa001 = apca004) = '4' ",
                       " THEN (SELECT ooag011 FROM ooag_t WHERE ooagent = apcaent AND ooag001 = apca057)  ",
                       " ELSE  ",
                       " CASE WHEN (SELECT pmaa004 FROM pmaa_t WHERE pmaaent = apcaent AND pmaa001 = apca004) = '2' ",
                       " THEN (SELECT pmak003 FROM pmak_t WHERE pmakent = apcaent AND pmak001 = apca057)  ",
                       " ELSE ''  ",
                       " END ",
                       " END) pmak003 ",
               "  FROM apca_t        ",
               " WHERE apcaent = ?   ",
               "   AND apcald = ?    ",
               "   AND apcadocno = ? "
   PREPARE sel_057descp FROM l_sql 
   #170112-00044#2-----e
   CALL g_apcc_d2.clear()   #albireo 150302 add
  
   LET g_sum.sumapcc1091 = 0
   LET g_sum.sumapcc1191 = 0 
   LET g_sum.sumapcc1092 = 0
   LET g_sum.sumapcc1192 = 0
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apcc_d[l_ac].sel,g_apcc_d[l_ac].apccld,g_apcc_d[l_ac].apca005,g_apcc_d[l_ac].apccdocno, 
       g_apcc_d[l_ac].apcadocdt,g_apcc_d[l_ac].apcc009,g_apcc_d[l_ac].apccseq,g_apcc_d[l_ac].apcc001, 
       g_apcc_d[l_ac].apcc003,g_apcc_d[l_ac].apcc004,g_apcc_d[l_ac].apcc002,g_apcc_d[l_ac].apcc100,g_apcc_d[l_ac].apcc108, 
       g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].l_apcc109n,g_apcc_d[l_ac].l_apcc109,g_apcc_d[l_ac].apcc118, 
       g_apcc_d[l_ac].apcc119,g_apcc_d[l_ac].l_apcc119n,g_apcc_d[l_ac].l_apcc119,g_apcc_d[l_ac].apca004, 
       g_apcc_d[l_ac].apca057,g_apcc_d[l_ac].apca007,g_apcc_d[l_ac].apca033,g_apcc_d[l_ac].apca015,g_apcc_d[l_ac].apca014, 
       g_apcc_d[l_ac].apca053
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apcc_d[l_ac].statepic = cl_get_actipic(g_apcc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_apcc_d[l_ac].apccld  = s_desc_show1(g_apcc_d[l_ac].apccld,s_desc_get_ld_desc(g_apcc_d[l_ac].apccld))
      LET g_apcc_d[l_ac].apca005 = s_desc_show1(g_apcc_d[l_ac].apca005,s_desc_get_trading_partner_abbr_desc(g_apcc_d[l_ac].apca005))
      LET g_apcc_d[l_ac].apca004 = s_desc_show1(g_apcc_d[l_ac].apca004,s_desc_get_trading_partner_abbr_desc(g_apcc_d[l_ac].apca004))
      #LET g_apcc_d[l_ac].apca057 = s_desc_show1(g_apcc_d[l_ac].apca057,s_desc_get_person_desc(g_apcc_d[l_ac].apca057))   #170112-00044#2 mark
      #170112-00044#2-----s
      LET l_apca057_desc =NULL
      EXECUTE sel_057descp USING g_enterprise,g_apcc_d[l_ac].apccld,g_apcc_d[l_ac].apccdocno
         INTO l_apca057_desc
      LET g_apcc_d[l_ac].apca057 = s_desc_show1(g_apcc_d[l_ac].apca057,l_apca057_desc)
      #170112-00044#2-----e
      LEt g_apcc_d[l_ac].apca007 = s_desc_show1(g_apcc_d[l_ac].apca007,s_desc_get_acc_desc('3211',g_apcc_d[l_ac].apca007))
      LET g_apcc_d[l_ac].apca015 = s_desc_show1(g_apcc_d[l_ac].apca015,s_desc_get_department_desc(g_apcc_d[l_ac].apca015))
      LET g_apcc_d[l_ac].apca014 = s_desc_show1(g_apcc_d[l_ac].apca014,s_desc_get_person_desc(g_apcc_d[l_ac].apca014))
      IF cl_null(g_apcc_d[l_ac].l_apcc109)THEN LET g_apcc_d[l_ac].l_apcc109 = 0 END IF
      IF cl_null(g_apcc_d[l_ac].l_apcc119)THEN LET g_apcc_d[l_ac].l_apcc119 = 0 END IF
      LET g_sum.sumapcc1091 = g_sum.sumapcc1091 + g_apcc_d[l_ac].l_apcc109
      LET g_sum.sumapcc1191 = g_sum.sumapcc1191 + g_apcc_d[l_ac].l_apcc119 
      #end add-point
 
      CALL aapq400_detail_show("'1'")      
 
      CALL aapq400_apcc_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_apcc_d.deleteElement(g_apcc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   
   #end add-point
 
   LET g_detail_cnt = g_apcc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq400_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq400_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq400_detail_action_trans()
 
   IF g_apcc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq400_fetch()
   END IF
   
      CALL aapq400_filter_show('apccdocno','b_apccdocno')
   CALL aapq400_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq400_filter_show('apcc009','b_apcc009')
   CALL aapq400_filter_show('apcc003','b_apcc003')
   CALL aapq400_filter_show('apcc004','b_apcc004')
   CALL aapq400_filter_show('apcc002','b_apcc002')
   CALL aapq400_filter_show('apcc100','b_apcc100')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   DISPLAY BY NAME g_sum.sumapcc1092,g_sum.sumapcc1192,g_sum.sumapcc1091,g_sum.sumapcc1191
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq400_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aapq400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq400_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq400_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
 
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
 
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON apccdocno,apcadocdt,apcc009,apcc003,apcc004,apcc002,apcc100
                          FROM s_detail1[1].b_apccdocno,s_detail1[1].b_apcadocdt,s_detail1[1].b_apcc009, 
                              s_detail1[1].b_apcc003,s_detail1[1].b_apcc004,s_detail1[1].b_apcc002,s_detail1[1].b_apcc100 
 
 
         BEFORE CONSTRUCT
                     DISPLAY aapq400_filter_parser('apccdocno') TO s_detail1[1].b_apccdocno
            DISPLAY aapq400_filter_parser('apcadocdt') TO s_detail1[1].b_apcadocdt
            DISPLAY aapq400_filter_parser('apcc009') TO s_detail1[1].b_apcc009
            DISPLAY aapq400_filter_parser('apcc003') TO s_detail1[1].b_apcc003
            DISPLAY aapq400_filter_parser('apcc004') TO s_detail1[1].b_apcc004
            DISPLAY aapq400_filter_parser('apcc002') TO s_detail1[1].b_apcc002
            DISPLAY aapq400_filter_parser('apcc100') TO s_detail1[1].b_apcc100
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_apccld>>----
         #----<<b_apca005>>----
         #----<<b_apccdocno>>----
         #Ctrlp:construct.c.filter.page1.b_apccdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apccdocno
            #add-point:ON ACTION controlp INFIELD b_apccdocno name="construct.c.filter.page1.b_apccdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apcastus = 'Y' AND apcc108-apcc109 <> 0 ",
                                   " AND apcald IN ",g_wc_ld,
                                   " AND apcasite IN ",g_wc_site,
                                   " AND (EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apcaent AND glbald = apcald AND glba001 = '",g_user,"') ",
                                   "         OR EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apcaent AND glbbld = apcald AND glbb001 = '",g_dept,"') ",
                                   "         OR (NOT EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apcaent AND glbald = apcald) AND NOT EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apcaent AND glbbld = apcald))) ",
                                   " AND apca001 NOT LIKE ('3%') AND apca001 NOT LIKE ('0%') "
            #151231-00010#4--(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where , " AND apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            #160518-00075#26--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q  
            END IF            
            #160518-00075#26--e       
            CALL q_apcadocno_13()
            DISPLAY g_qryparam.return1 TO b_apccdocno
            NEXT FIELD b_apccdocno
            #END add-point
 
 
         #----<<b_apcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.filter.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apcc009>>----
         #Ctrlp:construct.c.filter.page1.b_apcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc009
            #add-point:ON ACTION controlp INFIELD b_apcc009 name="construct.c.filter.page1.b_apcc009"
            
            #END add-point
 
 
         #----<<b_apccseq>>----
         #----<<b_apcc001>>----
         #----<<b_apcc003>>----
         #Ctrlp:construct.c.filter.page1.b_apcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc003
            #add-point:ON ACTION controlp INFIELD b_apcc003 name="construct.c.filter.page1.b_apcc003"
            
            #END add-point
 
 
         #----<<b_apcc004>>----
         #Ctrlp:construct.c.filter.page1.b_apcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc004
            #add-point:ON ACTION controlp INFIELD b_apcc004 name="construct.c.filter.page1.b_apcc004"
            
            #END add-point
 
 
         #----<<b_apcc002>>----
         #Ctrlp:construct.c.filter.page1.b_apcc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc002
            #add-point:ON ACTION controlp INFIELD b_apcc002 name="construct.c.filter.page1.b_apcc002"
            
            #END add-point
 
 
         #----<<b_apcc100>>----
         #Ctrlp:construct.c.filter.page1.b_apcc100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc100
            #add-point:ON ACTION controlp INFIELD b_apcc100 name="construct.c.filter.page1.b_apcc100"
            
            #END add-point
 
 
         #----<<b_apcc108>>----
         #----<<b_apcc109>>----
         #----<<l_apcc109n>>----
         #----<<l_apcc109>>----
         #----<<b_apcc118>>----
         #----<<b_apcc119>>----
         #----<<l_apcc119n>>----
         #----<<l_apcc119>>----
         #----<<b_apca004>>----
         #----<<b_apca057>>----
         #----<<b_apca007>>----
         #----<<b_apca033>>----
         #----<<b_apca015>>----
         #----<<b_apca014>>----
         #----<<b_apca053>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      ON ACTION controlp
         CASE
            WHEN INFIELD(b_apccld) 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_grup
               LET g_qryparam.where = " glaald IN ",g_wc_ld
               CALL q_authorised_ld()
               DISPLAY g_qryparam.return1 TO b_apccld
               NEXT FIELD b_apccld

            WHEN INFIELD(b_apca005)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #151231-00010#4--(S)
               LET g_qryparam.where = " pmac002 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"'))"
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND pmac002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               CALL q_pmac002_1()
               DISPLAY g_qryparam.return1 TO b_apca005
               NEXT FIELD b_apca005      

            WHEN INFIELD(b_apca004)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "('1','3')"
               #151231-00010#4--(S)
               LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"'))"
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               CALL q_pmaa001_1()
               DISPLAY g_qryparam.return1 TO b_apca004      #顯示到畫面上
               NEXT FIELD b_apca004

            WHEN INFIELD(b_apca057)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO b_apca057
               NEXT FIELD b_apca057
            WHEN INFIELD(b_apca014)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001_8()
               DISPLAY g_qryparam.return1 TO b_apca014  #顯示到畫面上
               NEXT FIELD b_apca014
            WHEN INFIELD(b_apca015)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_4()
               DISPLAY g_qryparam.return1 TO b_apca015  #顯示到畫面上
               NEXT FIELD b_apca015  
            WHEN INFIELD(b_apca007)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '3111'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO b_apca007  #顯示到畫面上
               NEXT FIELD b_apca007   
            WHEN INFIELD(b_apccdocno)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " apcastus = 'Y' AND apcc108-apcc109 <> 0 ",
                                      " AND apcald IN ",g_wc_ld,
                                      " AND apcasite IN ",g_wc_site,
                                      " AND (EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apcaent AND glbald = apcald AND glba001 = '",g_user,"') ",
                                      "         OR EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apcaent AND glbbld = apcald AND glbb001 = '",g_dept,"') ",
                                      "         OR (NOT EXISTS(SELECT 1 FROM glba_t WHERE glbaent = apcaent AND glbald = apcald) AND NOT EXISTS(SELECT 1 FROM glbb_t WHERE glbbent = apcaent AND glbbld = apcald))) ",
                                      " AND apca001 NOT LIKE ('3%') AND apca001 NOT LIKE ('0%') "
               #151231-00010#4--(S)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               #160518-00075#26--s
               IF NOT cl_null(g_user_dept_wc_q) THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q  
               END IF            
               #160518-00075#26--e                
               CALL q_apcadocno_13()
               DISPLAY g_qryparam.return1 TO b_apccdocno
               NEXT FIELD b_apccdocno         
            #albireo 150225-----s
            WHEN INFIELD(b_apcc100)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooai001()
               DISPLAY g_qryparam.return1 TO b_apcc100  #顯示到畫面上
               NEXT FIELD b_apcc100
            #albireo 150225-----e            
         END CASE
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         LET l_ac = 1
         LET g_apcc_d[l_ac].sel = ' '
         DISPLAY ARRAY g_apcc_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL aapq400_filter_show('apccdocno','b_apccdocno')
   CALL aapq400_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq400_filter_show('apcc009','b_apcc009')
   CALL aapq400_filter_show('apcc003','b_apcc003')
   CALL aapq400_filter_show('apcc004','b_apcc004')
   CALL aapq400_filter_show('apcc002','b_apcc002')
   CALL aapq400_filter_show('apcc100','b_apcc100')
 
    
   CALL aapq400_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq400_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="aapq400.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq400_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapq400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.insert" >}
#+ insert
PRIVATE FUNCTION aapq400_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq400.modify" >}
#+ modify
PRIVATE FUNCTION aapq400_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq400_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.delete" >}
#+ delete
PRIVATE FUNCTION aapq400_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq400_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq400_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_apcc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apcc_d.getLength() AND g_apcc_d.getLength() > 0
            LET g_detail_idx = g_apcc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apcc_d.getLength() THEN
               LET g_detail_idx = g_apcc_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapq400.mask_functions" >}
 &include "erp/aap/aapq400_mask.4gl"
 
{</section>}
 
{<section id="aapq400.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設變數及掃把功能
# Memo...........:
# Date & Author..: 150131 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq400_qbeclear()
   DEFINE l_ld    LIKE glaa_t.glaald
   DEFINE l_comp  LIKE ooef_t.ooef001
   DEFINE l_year  LIKE type_t.num5
   DEFINE l_month LIKE type_t.num5
   INITIALIZE g_input.* TO NULL
   INITIALIZE g_input_o.* TO NULL
   CALL g_apcc_d.clear()
   LET g_wc_filter = NULL
   #帳務中心/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,
                                                      g_input.apcasite,l_ld,l_comp
                                                      
   CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_site
   CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
   #取得帳務中心底下的帳套範圍
   CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
   CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
   #取得帳務中心底下的法人範圍
   CALL s_fin_account_center_comp_str() RETURNING g_wc_comp
   CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp
   #取帳務中心說明
   CALL s_desc_get_department_desc(g_input.apcasite)RETURNING g_input.apcasite_desc
   
   LET g_input.grouptype = '1'
   
    
   DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc,g_input.grouptype
   #160518-00075#26--s
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','apccld','apccent','apccdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = cl_replace_str(g_user_dept_wc,'apcc','apca')
   #160518-00075#26--e   
   
   #161114-00017#2 --s add
   #控制組
   LET g_comp = ''
   SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.apcasite AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#31 mark
   #161114-00017#2 --e add 
   
   #161229-00047#31 add ------
   CALL s_fin_get_wc_str(g_comp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#31 add end---
   
   LET g_input_o.* = g_input.*
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Date & Author..: 150131 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq400_create_tmp()

    DROP TABLE aapq400_tmp;
    CREATE TEMP TABLE aapq400_tmp(
       sel     VARCHAR(1),
       apccld  VARCHAR(80), 
       apca005  VARCHAR(80), 
       apccdocno  VARCHAR(20),
       apcadocdt  DATE,             #160818-00002#1 add 帳款日期
       apcc009  VARCHAR(20), 
       apccseq  INTEGER, 
       apcc001  INTEGER, 
       apcc003  DATE, 
       apcc004  DATE, 
       apcc002  VARCHAR(10), 
       apcc100  VARCHAR(10), 
       apcc108  DECIMAL(20,6), 
       apcc109  DECIMAL(20,6), 
       l_apcc109n  DECIMAL(20,6), 
       l_apcc109  DECIMAL(20,6), 
       apcc118  DECIMAL(20,6), 
       apcc119  DECIMAL(20,6), 
       l_apcc119n  DECIMAL(20,6), 
       l_apcc119  DECIMAL(20,6), 
       apca004  VARCHAR(80), 
       apca057  VARCHAR(80), 
       apca007  VARCHAR(80), 
       apca033  VARCHAR(80), 
       apca015  VARCHAR(80), 
       apca014  VARCHAR(80),
       apca001  VARCHAR(10),
       ent      INTEGER,
       apca040  VARCHAR(1),         #albireo 150213   留置否
       apca044  DECIMAL(20,6),         #albireo 150213   留置金額
       apcc108chk  DECIMAL(20,6),      #albireo 150214   判斷待抵來源單用 #151013-00019#10 add ,
       apca053  VARCHAR(500)     #151013-00019#10
       )
END FUNCTION

################################################################################
# Descriptions...: 回寫Y
# Memo...........:
# Date & Author..: 150131 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq400_upd_tmp()
   DEFINE l_i     LIKE type_t.num5
   DEFINE l_sql   STRING
   DEFINE l_apcb002 LIKE apcb_t.apcb002
   DEFINE l_apcc001 LIKE apcc_t.apcc001
 
   FOR l_i = 1 TO g_apcc_d.getLength()   
      UPDATE aapq400_tmp SET sel = g_apcc_d[l_i].sel
       WHERE apccdocno = g_apcc_d[l_i].apccdocno
         AND apccseq   = g_apcc_d[l_i].apccseq
         AND apcc001   = g_apcc_d[l_i].apcc001  
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 匯總單身
# Memo...........:
# Date & Author..: 150131 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq400_b_fill2()
   DEFINE l_sql    STRING
   DEFINE l_field  STRING
   DEFINE l_group  STRING
   DEFINE l_i      LIKE type_t.num10
   DEFINE l_comp   LIKE ooef_t.ooef001
   DEFINE l_rate1  LIKE type_t.num20_6
   DEFINE l_rate2  LIKE type_t.num20_6
   DEFINE l_rate3  LIKE type_t.num20_6  
   
   CALL aapq400_upd_tmp()
   CALL cl_set_comp_visible('b_apccld2,b_apca0052,b_apcc0022,b_apcc1002,b_apcc0032,b_apcc0042',TRUE)
   CASE
      WHEN g_input.grouptype = '1'
        #LET l_field = " apccld,apca005,apcc002,apcc100,apcc003,apcc004,SUM(l_apcc109),SUM(l_apcc119)    " #150915 mark
         LET l_field = " apccld,apca005,apcc002,apcc100,apcc003,apcc004,SUM(l_apcc109),SUM(l_apcc119),'' " #150915
         LET l_group = " apccld,apca005,apcc002,apcc100,apcc003,apcc004 "
         
      WHEN g_input.grouptype = '2'
        #LET l_field = " apccld,'',apcc002,apcc100,apcc003,apcc004,SUM(l_apcc109),SUM(l_apcc119) "    #150915 mark
         LET l_field = " apccld,'',apcc002,apcc100,apcc003,apcc004,SUM(l_apcc109),SUM(l_apcc119),'' " #150915
         LET l_group = " apccld,apcc002,apcc100,apcc003,apcc004 "
         CALL cl_set_comp_visible('b_apca0052',FALSE)
      WHEN g_input.grouptype = '3'
        #LET l_field = " apccld,'',apcc002,apcc100,'',apcc004,SUM(l_apcc109),SUM(l_apcc119) "     #150915 mark
         LET l_field = " apccld,'',apcc002,apcc100,'',apcc004,SUM(l_apcc109),SUM(l_apcc119),'' "  #150915
         LET l_group = " apccld,apcc002,apcc100,apcc004 "
         CALL cl_set_comp_visible('b_apca0052,b_apcc0032',FALSE)
   END CASE
   
   LET l_sql = "SELECT ",l_field CLIPPED,
               "  FROM aapq400_tmp ",
               " WHERE sel = 'Y' ",
               " GROUP BY ",l_group CLIPPED,
               " ORDER BY ",l_group CLIPPED
   PREPARE aapq400_sel_tmpp1 FROM l_sql
   DECLARE aapq400_sel_tmpc1 CURSOR FOR aapq400_sel_tmpp1
   
   CALL g_apcc_d2.clear()
   
   LET l_i = 1
   FOREACH aapq400_sel_tmpc1 INTO g_apcc_d2[l_i].*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #依帳別+幣別取今日匯率
      LET l_comp = NULL
      SELECT glaacomp INTO l_comp FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald  = g_apcc_d2[l_i].apccld2
      CALL s_fin_get_curr_rate(l_comp,g_apcc_d2[l_i].apccld2,g_today,g_apcc_d2[l_i].apcc1002,'')
         RETURNING l_rate1,l_rate2,l_rate3
      #本幣=原幣*今日匯率 
      LET g_apcc_d2[l_i].apcc1192 = g_apcc_d2[l_i].apcc1092 * l_rate1
      
      #取說明
      LET g_apcc_d2[l_i].apccld2  = s_desc_show1(g_apcc_d2[l_i].apccld2,s_desc_get_ld_desc(g_apcc_d2[l_i].apccld2))
      LET g_apcc_d2[l_i].apca0052 = s_desc_show1(g_apcc_d2[l_i].apca0052,s_desc_get_trading_partner_abbr_desc(g_apcc_d2[l_i].apca0052))
      
      #150915 add ------
      #現行匯率=原幣金額/本幣金額
      LET g_apcc_d2[l_i].apcc101 = l_rate1
      #150915 add end---
      
      LET l_i = l_i + 1
   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...: 計算勾選的數字並顯出
# Date & Author..: 150202 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq400_sumchoice()
   DEFINE l_i    LIKE type_t.num10
   LET g_sum.sumapcc1092 = 0 
   LET g_sum.sumapcc1192 = 0
   FOR l_i = 1 TO g_apcc_d.getLength()
      IF g_apcc_d[l_i].sel = 'Y' THEN
         IF cl_null(g_apcc_d[l_i].l_apcc109)THEN
            LET g_apcc_d[l_i].l_apcc109 = 0 
         END IF
         
         IF cl_null(g_apcc_d[l_i].l_apcc119)THEN
            LET g_apcc_d[l_i].l_apcc119 = 0 
         END IF
                          
         LET g_sum.sumapcc1092 = g_sum.sumapcc1092 + g_apcc_d[l_i].l_apcc109
         LET g_sum.sumapcc1192 = g_sum.sumapcc1192 + g_apcc_d[l_i].l_apcc119
      END IF
   END FOR
   
   DISPLAY BY NAME g_sum.sumapcc1092,g_sum.sumapcc1192
END FUNCTION

################################################################################
# Descriptions...: 建立Q轉XG的TMP
# Memo...........: #150319-00004#5
# Date & Author..: 150429   By rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq400_x01_tmp()
   DROP TABLE aapq400_x01_tmp;
   CREATE TEMP TABLE aapq400_x01_tmp(
      apccld      VARCHAR(80), 
      apca005     VARCHAR(80), 
      apccdocno   VARCHAR(20), 
      apcadocdt   DATE,          #160818-00002#1 add 帳款日期
      apcc009     VARCHAR(20), 
      apccseq     INTEGER, 
      apcc001     INTEGER, 
      apcc003     DATE, 
      apcc004     DATE, 
      apcc002     VARCHAR(500), 
      apcc100     VARCHAR(10), 
      l_apcc109   DECIMAL(20,6), 
      l_apcc119   DECIMAL(20,6), 
      apca004     VARCHAR(80), 
      apca057     VARCHAR(80), 
      apca007     VARCHAR(80), 
      apca033     VARCHAR(80), 
      apca015     VARCHAR(80), 
      apca014     VARCHAR(80),
      l_apcasite  VARCHAR(500)
      )
END FUNCTION

 
{</section>}
 
