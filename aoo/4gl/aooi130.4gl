#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi130.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2016-11-28 15:13:13), PR版次:0018(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000308
#+ Filename...: aooi130
#+ Description: 員工資料維護作業
#+ Creator....: 01258(2013-07-01 00:00:00)
#+ Modifier...: 07375 -SD/PR- 00000
 
{</section>}
 
{<section id="aooi130.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#30 2016/03/24 By 07900    重复错误信息修改
#160505-00021#2  2016/06/12 By 02295    增加ooag015，ooag016，ooag017三个栏位
#160808-00006#1  2016/08/22 By Sarah    點擊業務人員的串查按鈕，自動打開員工資料後，沒有直接顯示出業務人員資料
#160429-00013#12 2016/09/01 By Jessica  1.增加欄位ooag018(直屬主管員工編號):
#                                        (1)集團參數E-SYS-0700(是否啟用BPM協同)不為Y時，隱藏此欄位
#                                        (2)開窗q_ooag001，畫面需帶出員工全名ooag011
#                                       2.歸屬部門ooag003，輸入後處理: 若該部門的部門主管ooeg011不為空值，則將值帶入ooag018
#161019-00017#1  2016/10/20 By lixh     组织类型整批调整 
#160902-00024#7  2016/11/02 By Jessica  移除新舊相容的判斷，直接用新參數
#161024-00068#1  2016/11/07 By 08734    aooi130删除一笔资料后，aooi350相应的资料也要删除

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_ooag_d RECORD
       ooagstus LIKE ooag_t.ooagstus, 
   ooag001 LIKE ooag_t.ooag001, 
   ooag008 LIKE ooag_t.ooag008, 
   ooag009 LIKE ooag_t.ooag009, 
   ooag010 LIKE ooag_t.ooag010, 
   ooag011 LIKE ooag_t.ooag011, 
   ooag012 LIKE ooag_t.ooag012, 
   ooag013 LIKE ooag_t.ooag013, 
   ooag014 LIKE ooag_t.ooag014, 
   oofa015 LIKE type_t.chr500, 
   ooag003 LIKE ooag_t.ooag003, 
   ooag003_desc LIKE type_t.chr500, 
   ooag004 LIKE ooag_t.ooag004, 
   ooag004_desc LIKE type_t.chr500, 
   ooag005 LIKE ooag_t.ooag005, 
   ooag005_desc LIKE type_t.chr500, 
   ooag015 LIKE ooag_t.ooag015, 
   ooag015_desc LIKE type_t.chr500, 
   ooag016 LIKE ooag_t.ooag016, 
   ooag017 LIKE ooag_t.ooag017, 
   ooag017_desc LIKE type_t.chr500, 
   ooag018 LIKE ooag_t.ooag018, 
   ooag018_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_ooag1_info_d RECORD
       ooag001 LIKE ooag_t.ooag001, 
   ooagmodid LIKE ooag_t.ooagmodid, 
   ooagmodid_desc LIKE type_t.chr500, 
   ooagmoddt DATETIME YEAR TO SECOND, 
   ooagownid LIKE ooag_t.ooagownid, 
   ooagownid_desc LIKE type_t.chr500, 
   ooagowndp LIKE ooag_t.ooagowndp, 
   ooagowndp_desc LIKE type_t.chr500, 
   ooagcrtid LIKE ooag_t.ooagcrtid, 
   ooagcrtid_desc LIKE type_t.chr500, 
   ooagcrtdp LIKE ooag_t.ooagcrtdp, 
   ooagcrtdp_desc LIKE type_t.chr500, 
   ooagcrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_ooag_d          DYNAMIC ARRAY OF type_g_ooag_d #單身變數
DEFINE g_ooag_d_t        type_g_ooag_d                  #單身備份
DEFINE g_ooag_d_o        type_g_ooag_d                  #單身備份
DEFINE g_ooag_d_mask_o   DYNAMIC ARRAY OF type_g_ooag_d #單身變數
DEFINE g_ooag_d_mask_n   DYNAMIC ARRAY OF type_g_ooag_d #單身變數
DEFINE g_ooag1_info_d   DYNAMIC ARRAY OF type_g_ooag1_info_d
DEFINE g_ooag1_info_d_t type_g_ooag1_info_d
DEFINE g_ooag1_info_d_o type_g_ooag1_info_d
DEFINE g_ooag1_info_d_mask_o DYNAMIC ARRAY OF type_g_ooag1_info_d
DEFINE g_ooag1_info_d_mask_n DYNAMIC ARRAY OF type_g_ooag1_info_d
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi130.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT ooagstus,ooag001,ooag008,ooag009,ooag010,ooag011,ooag012,ooag013,ooag014, 
       ooag003,ooag004,ooag005,ooag015,ooag016,ooag017,ooag018,ooag001,ooagmodid,ooagmoddt,ooagownid, 
       ooagowndp,ooagcrtid,ooagcrtdp,ooagcrtdt FROM ooag_t WHERE ooagent=? AND ooag001=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi130_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi130 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi130_init()   
 
      #進入選單 Menu (="N")
      CALL aooi130_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi130
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi130.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aooi130_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_e_sys_0723   LIKE type_t.chr1   #160505-00021#2
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #160505-00021#2---add---s
   #160429-00013#12-S
   #CALL cl_set_comp_visible("ooag015,ooag015_desc,ooag016,ooag017,ooag017_desc",TRUE)                     
   CALL cl_set_comp_visible("ooag015,ooag015_desc,ooag016,ooag017,ooag017_desc,ooag018,ooag018_desc",TRUE)  

   IF NOT s_aooi723_chk_bpm() THEN      #160902-00024#7
      #CALL cl_set_comp_visible("ooag015,ooag015_desc,ooag016,ooag017,ooag017_desc",FALSE)                     
      CALL cl_set_comp_visible("ooag015,ooag015_desc,ooag016,ooag017,ooag017_desc,ooag018,ooag018_desc",FALSE) 
   #160429-00013#12-E
   END IF
   #160505-00021#2---add---e
   #end add-point
   
   CALL aooi130_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aooi130_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_cmd      STRING
   DEFINE l_ooag002  LIKE ooag_t.ooag002
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_ooag_d.clear()
         CALL g_ooag1_info_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aooi130_init()
      END IF
   
      CALL aooi130_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_ooag_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               LET g_data_owner = g_ooag1_info_d[g_detail_idx].ooagownid   #(ver:35)
               LET g_data_dept = g_ooag1_info_d[g_detail_idx].ooagowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aooi130_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_ooag1_info_d TO s_detail1_info.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body1_info.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body1_info.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_info")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aooi130_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row1_info"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail1_info", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aooi130_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi130_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aooi130_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi130_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_lldz
            LET g_action_choice="open_lldz"
            IF cl_auth_chk_act("open_lldz") THEN
               
               #add-point:ON ACTION open_lldz name="menu.open_lldz"
               SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_ooag_d[l_ac].ooag001
               CALL aooi350_01(l_ooag002)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aooi130_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi130_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi130_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_txfs
            LET g_action_choice="open_txfs"
            IF cl_auth_chk_act("open_txfs") THEN
               
               #add-point:ON ACTION open_txfs name="menu.open_txfs"
               SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_ooag_d[l_ac].ooag001
               CALL aooi350_02(l_ooag002)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi130_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail1_info",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch
            LET g_action_choice="batch"
            IF cl_auth_chk_act("batch") THEN
               
               #add-point:ON ACTION batch name="menu.batch"
               CALL aooi130_batch()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_yhzh
            LET g_action_choice="open_yhzh"
            IF cl_auth_chk_act("open_yhzh") THEN
               
               #add-point:ON ACTION open_yhzh name="menu.open_yhzh"
               CALL aooi130_01(g_ooag_d[l_ac].ooag001)
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_ooag_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_ooag1_info_d)
               LET g_export_id[2]   = "s_detail1_info"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
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
            
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi130_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi130_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi130_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aooi130.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi130_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_ooag_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON ooagstus,ooag001,ooag008,ooag009,ooag010,ooag011,ooag012,ooag013,ooag014,oofa015, 
          ooag003,ooag004,ooag005,ooag015,ooag016,ooag017,ooag018,ooagmodid,ooagmoddt,ooagownid,ooagowndp, 
          ooagcrtid,ooagcrtdp,ooagcrtdt 
 
         FROM s_detail1[1].ooagstus,s_detail1[1].ooag001,s_detail1[1].ooag008,s_detail1[1].ooag009,s_detail1[1].ooag010, 
             s_detail1[1].ooag011,s_detail1[1].ooag012,s_detail1[1].ooag013,s_detail1[1].ooag014,s_detail1[1].oofa015, 
             s_detail1[1].ooag003,s_detail1[1].ooag004,s_detail1[1].ooag005,s_detail1[1].ooag015,s_detail1[1].ooag016, 
             s_detail1[1].ooag017,s_detail1[1].ooag018,s_detail1_info[1].ooagmodid,s_detail1_info[1].ooagmoddt, 
             s_detail1_info[1].ooagownid,s_detail1_info[1].ooagowndp,s_detail1_info[1].ooagcrtid,s_detail1_info[1].ooagcrtdp, 
             s_detail1_info[1].ooagcrtdt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<ooagcrtdt>>----
         AFTER FIELD ooagcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<ooagmoddt>>----
         AFTER FIELD ooagmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ooagcnfdt>>----
         
         #----<<ooagpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagstus
            #add-point:BEFORE FIELD ooagstus name="query.b.page1.ooagstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooagstus
            
            #add-point:AFTER FIELD ooagstus name="query.a.page1.ooagstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooagstus
            #add-point:ON ACTION controlp INFIELD ooagstus name="query.c.page1.ooagstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ooag001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag001
            #add-point:ON ACTION controlp INFIELD ooag001 name="construct.c.page1.ooag001"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooag001  #顯示到畫面上
            NEXT FIELD ooag001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag001
            #add-point:BEFORE FIELD ooag001 name="query.b.page1.ooag001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag001
            
            #add-point:AFTER FIELD ooag001 name="query.a.page1.ooag001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag008
            #add-point:BEFORE FIELD ooag008 name="query.b.page1.ooag008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag008
            
            #add-point:AFTER FIELD ooag008 name="query.a.page1.ooag008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag008
            #add-point:ON ACTION controlp INFIELD ooag008 name="query.c.page1.ooag008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag009
            #add-point:BEFORE FIELD ooag009 name="query.b.page1.ooag009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag009
            
            #add-point:AFTER FIELD ooag009 name="query.a.page1.ooag009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag009
            #add-point:ON ACTION controlp INFIELD ooag009 name="query.c.page1.ooag009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag010
            #add-point:BEFORE FIELD ooag010 name="query.b.page1.ooag010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag010
            
            #add-point:AFTER FIELD ooag010 name="query.a.page1.ooag010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag010
            #add-point:ON ACTION controlp INFIELD ooag010 name="query.c.page1.ooag010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag011
            #add-point:BEFORE FIELD ooag011 name="query.b.page1.ooag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag011
            
            #add-point:AFTER FIELD ooag011 name="query.a.page1.ooag011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag011
            #add-point:ON ACTION controlp INFIELD ooag011 name="query.c.page1.ooag011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag012
            #add-point:BEFORE FIELD ooag012 name="query.b.page1.ooag012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag012
            
            #add-point:AFTER FIELD ooag012 name="query.a.page1.ooag012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag012
            #add-point:ON ACTION controlp INFIELD ooag012 name="query.c.page1.ooag012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag013
            #add-point:BEFORE FIELD ooag013 name="query.b.page1.ooag013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag013
            
            #add-point:AFTER FIELD ooag013 name="query.a.page1.ooag013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag013
            #add-point:ON ACTION controlp INFIELD ooag013 name="query.c.page1.ooag013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag014
            #add-point:BEFORE FIELD ooag014 name="query.b.page1.ooag014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag014
            
            #add-point:AFTER FIELD ooag014 name="query.a.page1.ooag014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag014
            #add-point:ON ACTION controlp INFIELD ooag014 name="query.c.page1.ooag014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofa015
            #add-point:BEFORE FIELD oofa015 name="query.b.page1.oofa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofa015
            
            #add-point:AFTER FIELD oofa015 name="query.a.page1.oofa015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oofa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofa015
            #add-point:ON ACTION controlp INFIELD oofa015 name="query.c.page1.oofa015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ooag003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag003
            #add-point:ON ACTION controlp INFIELD ooag003 name="construct.c.page1.ooag003"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooag003  #顯示到畫面上

            NEXT FIELD ooag003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag003
            #add-point:BEFORE FIELD ooag003 name="query.b.page1.ooag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag003
            
            #add-point:AFTER FIELD ooag003 name="query.a.page1.ooag003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooag004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag004
            #add-point:ON ACTION controlp INFIELD ooag004 name="construct.c.page1.ooag004"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = " " 
            DISPLAY g_qryparam.return1 TO ooag004  #顯示到畫面上

            NEXT FIELD ooag004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag004
            #add-point:BEFORE FIELD ooag004 name="query.b.page1.ooag004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag004
            
            #add-point:AFTER FIELD ooag004 name="query.a.page1.ooag004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooag005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag005
            #add-point:ON ACTION controlp INFIELD ooag005 name="construct.c.page1.ooag005"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "5"
            LET g_qryparam.where = " oocqstus = 'Y' "
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooag005  #顯示到畫面上
            LET g_qryparam.where = " "
            NEXT FIELD ooag005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag005
            #add-point:BEFORE FIELD ooag005 name="query.b.page1.ooag005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag005
            
            #add-point:AFTER FIELD ooag005 name="query.a.page1.ooag005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooag015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag015
            #add-point:ON ACTION controlp INFIELD ooag015 name="construct.c.page1.ooag015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "16"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooag015  #顯示到畫面上
            NEXT FIELD ooag015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag015
            #add-point:BEFORE FIELD ooag015 name="query.b.page1.ooag015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag015
            
            #add-point:AFTER FIELD ooag015 name="query.a.page1.ooag015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag016
            #add-point:BEFORE FIELD ooag016 name="query.b.page1.ooag016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag016
            
            #add-point:AFTER FIELD ooag016 name="query.a.page1.ooag016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooag016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag016
            #add-point:ON ACTION controlp INFIELD ooag016 name="query.c.page1.ooag016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ooag017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag017
            #add-point:ON ACTION controlp INFIELD ooag017 name="construct.c.page1.ooag017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooag017  #顯示到畫面上
            NEXT FIELD ooag017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag017
            #add-point:BEFORE FIELD ooag017 name="query.b.page1.ooag017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag017
            
            #add-point:AFTER FIELD ooag017 name="query.a.page1.ooag017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooag018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag018
            #add-point:ON ACTION controlp INFIELD ooag018 name="construct.c.page1.ooag018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooag018  #顯示到畫面上
            NEXT FIELD ooag018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag018
            #add-point:BEFORE FIELD ooag018 name="query.b.page1.ooag018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag018
            
            #add-point:AFTER FIELD ooag018 name="query.a.page1.ooag018"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page1_info.ooagmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooagmodid
            #add-point:ON ACTION controlp INFIELD ooagmodid name="construct.c.page1_info.ooagmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooagmodid  #顯示到畫面上

            NEXT FIELD ooagmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagmodid
            #add-point:BEFORE FIELD ooagmodid name="query.b.page1_info.ooagmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooagmodid
            
            #add-point:AFTER FIELD ooagmodid name="query.a.page1_info.ooagmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagmoddt
            #add-point:BEFORE FIELD ooagmoddt name="query.b.page1_info.ooagmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_info.ooagownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooagownid
            #add-point:ON ACTION controlp INFIELD ooagownid name="construct.c.page1_info.ooagownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooagownid  #顯示到畫面上

            NEXT FIELD ooagownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagownid
            #add-point:BEFORE FIELD ooagownid name="query.b.page1_info.ooagownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooagownid
            
            #add-point:AFTER FIELD ooagownid name="query.a.page1_info.ooagownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.ooagowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooagowndp
            #add-point:ON ACTION controlp INFIELD ooagowndp name="construct.c.page1_info.ooagowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooagowndp  #顯示到畫面上

            NEXT FIELD ooagowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagowndp
            #add-point:BEFORE FIELD ooagowndp name="query.b.page1_info.ooagowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooagowndp
            
            #add-point:AFTER FIELD ooagowndp name="query.a.page1_info.ooagowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.ooagcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooagcrtid
            #add-point:ON ACTION controlp INFIELD ooagcrtid name="construct.c.page1_info.ooagcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooagcrtid  #顯示到畫面上

            NEXT FIELD ooagcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagcrtid
            #add-point:BEFORE FIELD ooagcrtid name="query.b.page1_info.ooagcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooagcrtid
            
            #add-point:AFTER FIELD ooagcrtid name="query.a.page1_info.ooagcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.ooagcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooagcrtdp
            #add-point:ON ACTION controlp INFIELD ooagcrtdp name="construct.c.page1_info.ooagcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooagcrtdp  #顯示到畫面上

            NEXT FIELD ooagcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagcrtdp
            #add-point:BEFORE FIELD ooagcrtdp name="query.b.page1_info.ooagcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooagcrtdp
            
            #add-point:AFTER FIELD ooagcrtdp name="query.a.page1_info.ooagcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagcrtdt
            #add-point:BEFORE FIELD ooagcrtdt name="query.b.page1_info.ooagcrtdt"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog name="query.before_dialog"
         
         #end add-point 
      
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
 
   #add-point:query段after_construct name="query.after_construct"
   LET g_wc2 = cl_replace_str(g_wc2,'ooag','t0.ooag')   #160505-00021#2
   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL aooi130_b_fill(g_wc2)
   LET g_data_owner = g_ooag1_info_d[g_detail_idx].ooagownid   #(ver:35)
   LET g_data_dept = g_ooag1_info_d[g_detail_idx].ooagowndp   #(ver:35)
 
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi130_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aooi130_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi130.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi130_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num10
   DEFINE  l_i                    LIKE type_t.num10
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num10
   DEFINE  li_reproduce_target    LIKE type_t.num10
   DEFINE  lb_reproduce           BOOLEAN
   DEFINE  l_insert               BOOLEAN
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE  l_oofa001       LIKE oofa_t.oofa001
   DEFINE  l_n1            LIKE type_t.num5
   DEFINE  l_ooag002       LIKE ooag_t.ooag002
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_wc            STRING
   DEFINE  l_date          LIKE oofa_t.oofa017   #当日
   DEFINE  l_oofamoddt     DATETIME YEAR TO SECOND
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前 name="modify.before_input"
   LET g_errshow = 1
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_ooag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ooag_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi130_b_fill(g_wc2)
            LET g_detail_cnt = g_ooag_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_ooag_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_ooag_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_ooag_d[l_ac].ooag001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_ooag_d_t.* = g_ooag_d[l_ac].*  #BACKUP
               LET g_ooag_d_o.* = g_ooag_d[l_ac].*  #BACKUP
               IF NOT aooi130_lock_b("ooag_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi130_bcl INTO g_ooag_d[l_ac].ooagstus,g_ooag_d[l_ac].ooag001,g_ooag_d[l_ac].ooag008, 
                      g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010,g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag012, 
                      g_ooag_d[l_ac].ooag013,g_ooag_d[l_ac].ooag014,g_ooag_d[l_ac].ooag003,g_ooag_d[l_ac].ooag004, 
                      g_ooag_d[l_ac].ooag005,g_ooag_d[l_ac].ooag015,g_ooag_d[l_ac].ooag016,g_ooag_d[l_ac].ooag017, 
                      g_ooag_d[l_ac].ooag018,g_ooag1_info_d[l_ac].ooag001,g_ooag1_info_d[l_ac].ooagmodid, 
                      g_ooag1_info_d[l_ac].ooagmoddt,g_ooag1_info_d[l_ac].ooagownid,g_ooag1_info_d[l_ac].ooagowndp, 
                      g_ooag1_info_d[l_ac].ooagcrtid,g_ooag1_info_d[l_ac].ooagcrtdp,g_ooag1_info_d[l_ac].ooagcrtdt 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_ooag_d_t.ooag001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_ooag_d_mask_o[l_ac].* =  g_ooag_d[l_ac].*
                  CALL aooi130_ooag_t_mask()
                  LET g_ooag_d_mask_n[l_ac].* =  g_ooag_d[l_ac].*
                  
                  CALL aooi130_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aooi130_set_entry_b(l_cmd)
            CALL aooi130_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_ooag_d_t.* TO NULL
            INITIALIZE g_ooag_d_o.* TO NULL
            INITIALIZE g_ooag_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooag1_info_d[l_ac].ooagownid = g_user
      LET g_ooag1_info_d[l_ac].ooagowndp = g_dept
      LET g_ooag1_info_d[l_ac].ooagcrtid = g_user
      LET g_ooag1_info_d[l_ac].ooagcrtdp = g_dept 
      LET g_ooag1_info_d[l_ac].ooagcrtdt = cl_get_current()
      LET g_ooag1_info_d[l_ac].ooagmodid = g_user
      LET g_ooag1_info_d[l_ac].ooagmoddt = cl_get_current()
      LET g_ooag_d[l_ac].ooagstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_ooag_d[l_ac].ooag016 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_ooag_d_t.* = g_ooag_d[l_ac].*     #新輸入資料
            LET g_ooag_d_o.* = g_ooag_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ooag_d[li_reproduce_target].* = g_ooag_d[li_reproduce].*
               LET g_ooag1_info_d[li_reproduce_target].* = g_ooag1_info_d[li_reproduce].*
 
               LET g_ooag_d[g_ooag_d.getLength()].ooag001 = NULL
 
            END IF
            
 
 
            CALL aooi130_set_entry_b(l_cmd)
            CALL aooi130_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_ooag_d[l_ac].ooagstus = 'Y'
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM ooag_t 
             WHERE ooagent = g_enterprise AND ooag001 = g_ooag_d[l_ac].ooag001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooag_d[g_detail_idx].ooag001
               CALL aooi130_insert_b('ooag_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               SELECT COUNT(1) INTO l_n1 FROM ooag_t WHERE ooag001 = g_ooag_d[l_ac].ooag001 AND ooagent = g_enterprise
               IF l_n1 > 0 THEN 
                  #SELECT MAX(to_number(oofa001))+1 INTO l_oofa001 FROM oofa_t
                  #CALL s_aooi350_get_oofa001() RETURNING l_success,l_oofa001
                  LET l_wc = " oofaent = '",g_enterprise,"' "
                  CALL s_aooi350_get_idno('oofa001','oofa_t',l_wc) RETURNING l_success,l_oofa001
                  UPDATE ooag_t SET ooag002 = l_oofa001 WHERE ooag001 = g_ooag_d[l_ac].ooag001 AND ooagent = g_enterprise
                  IF SQLCA.sqlcode THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooag_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                  ELSE
                     LET l_oofamoddt = cl_get_current()
                     INSERT INTO oofa_t(oofastus,oofaent,oofa001,oofa002,oofa003,oofa004,oofa005,oofa006,
                                        oofa007,oofa008,oofa009,oofa010,oofa011,oofa012,oofa013,oofa014,oofa015,oofa016,oofa017,
                                        oofamodid,oofamoddt,oofaownid,oofaowndp,oofacrtid,oofacrtdp,oofacrtdt)
                      VALUES('Y',g_enterprise,l_oofa001,'2',g_ooag_d[l_ac].ooag001,'','','','',
                      g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010,
                      g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag012,
                      g_ooag_d[l_ac].ooag013,g_ooag_d[l_ac].ooag014,g_ooag_d[l_ac].oofa015,'','',
                      g_user,l_oofamoddt,g_user,g_dept,g_user,g_dept,l_oofamoddt)
                     
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofa_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                     END IF
                  END IF
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_ooag_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ooag_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi130_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #上面一段pattern產生的新增多語言的資料(oofa_t)有錯誤(欄位不對應,oofa001應該與ooag002對應),先刪除掉
               #DELETE FROM oofa_t WHERE oofaent = g_enterprise AND oofa001 = g_ooag_d[l_ac].ooag001
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (ooag001 = '", g_ooag_d[l_ac].ooag001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               
               #end add-point   
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               LET l_n = 0
               #若這個員工編號已經存在gzxa_t(azzi800使用者資料設定作業)裡，則不允許刪除
               SELECT COUNT(1) INTO l_n FROM gzxa_t 
                 WHERE gzxaent = g_enterprise AND gzxa002 = '2' AND gzxa003 = g_ooag_d_t.ooag001
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00271'
                  LET g_errparam.extend = g_ooag_d_t.ooag001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               
               LET l_ooag002 = ' '
               SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_ooag_d_t.ooag001
                  
               #end add-point   
               
               DELETE FROM ooag_t
                WHERE ooagent = g_enterprise AND 
                      ooag001 = g_ooag_d_t.ooag001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ooag_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  IF NOT cl_null(l_ooag002) THEN
                     IF NOT s_aooi350_del(l_ooag002) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                     END IF
                  END IF
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aooi130_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_ooag_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aooi130_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_ooag_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooag_d_t.ooag001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi130_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aooi130_delete_b('ooag_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_ooag_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooagstus
            #add-point:BEFORE FIELD ooagstus name="input.b.page1.ooagstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooagstus
            
            #add-point:AFTER FIELD ooagstus name="input.a.page1.ooagstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooagstus
            #add-point:ON CHANGE ooagstus name="input.g.page1.ooagstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag001
            #add-point:BEFORE FIELD ooag001 name="input.b.page1.ooag001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag001
            
            #add-point:AFTER FIELD ooag001 name="input.a.page1.ooag001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooag_d[l_ac].ooag001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooag_d[l_ac].ooag001 != g_ooag_d_t.ooag001))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = '"||g_ooag_d[l_ac].ooag001 ||"'",'std-00004',0) THEN 
                     LET g_ooag_d[l_ac].ooag001 = g_ooag_d_t.ooag001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
                   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag001
            #add-point:ON CHANGE ooag001 name="input.g.page1.ooag001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag008
            #add-point:BEFORE FIELD ooag008 name="input.b.page1.ooag008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag008
            
            #add-point:AFTER FIELD ooag008 name="input.a.page1.ooag008"
            IF (NOT cl_null(g_ooag_d[l_ac].ooag008)) AND (NOT cl_null(g_ooag_d[l_ac].ooag010)) THEN 
                CALL s_aooi350_gen_fullname(g_site,g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010) RETURNING l_success,g_ooag_d[l_ac].ooag011
             END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag008
            #add-point:ON CHANGE ooag008 name="input.g.page1.ooag008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag009
            #add-point:BEFORE FIELD ooag009 name="input.b.page1.ooag009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag009
            
            #add-point:AFTER FIELD ooag009 name="input.a.page1.ooag009"
           IF (NOT cl_null(g_ooag_d[l_ac].ooag009)) AND (NOT cl_null(g_ooag_d[l_ac].ooag008)) AND (NOT cl_null(g_ooag_d[l_ac].ooag010)) THEN 
              CALL s_aooi350_gen_fullname(g_site,g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010) RETURNING l_success,g_ooag_d[l_ac].ooag011
           END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag009
            #add-point:ON CHANGE ooag009 name="input.g.page1.ooag009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag010
            #add-point:BEFORE FIELD ooag010 name="input.b.page1.ooag010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag010
            
            #add-point:AFTER FIELD ooag010 name="input.a.page1.ooag010"
            IF (NOT cl_null(g_ooag_d[l_ac].ooag008)) AND (NOT cl_null(g_ooag_d[l_ac].ooag010)) THEN 
                CALL s_aooi350_gen_fullname(g_site,g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010) RETURNING l_success,g_ooag_d[l_ac].ooag011
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag010
            #add-point:ON CHANGE ooag010 name="input.g.page1.ooag010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag011
            #add-point:BEFORE FIELD ooag011 name="input.b.page1.ooag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag011
            
            #add-point:AFTER FIELD ooag011 name="input.a.page1.ooag011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag011
            #add-point:ON CHANGE ooag011 name="input.g.page1.ooag011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag012
            #add-point:BEFORE FIELD ooag012 name="input.b.page1.ooag012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag012
            
            #add-point:AFTER FIELD ooag012 name="input.a.page1.ooag012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag012
            #add-point:ON CHANGE ooag012 name="input.g.page1.ooag012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag013
            #add-point:BEFORE FIELD ooag013 name="input.b.page1.ooag013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag013
            
            #add-point:AFTER FIELD ooag013 name="input.a.page1.ooag013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag013
            #add-point:ON CHANGE ooag013 name="input.g.page1.ooag013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag014
            #add-point:BEFORE FIELD ooag014 name="input.b.page1.ooag014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag014
            
            #add-point:AFTER FIELD ooag014 name="input.a.page1.ooag014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag014
            #add-point:ON CHANGE ooag014 name="input.g.page1.ooag014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofa015
            #add-point:BEFORE FIELD oofa015 name="input.b.page1.oofa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofa015
            
            #add-point:AFTER FIELD oofa015 name="input.a.page1.oofa015"
             IF NOT cl_null(g_ooag_d[l_ac].oofa015) THEN 
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooag_d[l_ac].oofa015 != g_ooag_d_t.oofa015))) THEN 
                   LET l_oofa001 = ' '
                   #当日
                   LET l_date = cl_get_current()

                   #根据识别证号抓取联络对象识别码
                   SELECT oofa001 INTO l_oofa001 FROM oofa_t 
                     WHERE oofa015 = g_ooag_d[l_ac].oofa015 AND oofaent = g_enterprise
                       AND (oofa017 IS NULL or oofa017 > l_date)            #失效日期
                       AND oofastus='Y'                                      #状态码
                     ORDER BY oofa001
   
                   IF NOT cl_null(l_oofa001) THEN
                      CALL s_aooi350_gen_data(g_ooag_d[l_ac].oofa015,l_oofa001,'1') RETURNING l_success
                   END IF
                  
                END IF
             END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofa015
            #add-point:ON CHANGE oofa015 name="input.g.page1.oofa015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag003
            
            #add-point:AFTER FIELD ooag003 name="input.a.page1.ooag003"
            LET g_ooag_d[l_ac].ooag003_desc = ' '
            DISPLAY g_ooag_d[l_ac].ooag003_desc TO s_detail1[l_ac].ooag003_desc
            
            IF NOT cl_null(g_ooag_d[l_ac].ooag003)  THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ooag_d[l_ac].ooag003 != g_ooag_d_t.ooag003) THEN 
                  CALL aooi130_ooag003_ref(g_ooag_d[l_ac].ooag003) RETURNING g_ooag_d[l_ac].ooag003_desc
                  DISPLAY BY NAME g_ooag_d[l_ac].ooag003_desc
                  IF NOT s_aooi125_chk_dept(g_ooag_d[l_ac].ooag003) THEN
                     LET g_ooag_d[l_ac].ooag003 = g_ooag_d_t.ooag003
                     CALL aooi130_ooag003_ref(g_ooag_d[l_ac].ooag003) RETURNING g_ooag_d[l_ac].ooag003_desc
                     DISPLAY BY NAME g_ooag_d[l_ac].ooag003_desc
                     NEXT FIELD ooag003
                  END IF 
               END IF 
            END IF 
            CALL aooi130_ooag003_ref(g_ooag_d[l_ac].ooag003) RETURNING g_ooag_d[l_ac].ooag003_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag003_desc
            
            #160429-00013#12-S
            IF s_aooi723_chk_bpm() THEN      #160902-00024#7
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_ooag_d[l_ac].ooag003
               CALL ap_ref_array2(g_ref_fields,"SELECT ooeg011, ooag011 FROM ooeg_t LEFT OUTER JOIN ooag_t ON ooagent = ooegent AND ooag001 = ooeg011 WHERE ooegent = '"||g_enterprise||"' AND ooeg001 = ?","") 
               RETURNING g_rtn_fields
               IF g_rtn_fields[1] IS NOT NULL THEN
                  LET g_ooag_d[l_ac].ooag018      = '', g_rtn_fields[1] , ''
                  LET g_ooag_d[l_ac].ooag018_desc = '', g_rtn_fields[2] , ''
                  DISPLAY BY NAME g_ooag_d[l_ac].ooag018
                  DISPLAY BY NAME g_ooag_d[l_ac].ooag018_desc
               END IF
            END IF
            #160429-00013#12-E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag003
            #add-point:BEFORE FIELD ooag003 name="input.b.page1.ooag003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag003
            #add-point:ON CHANGE ooag003 name="input.g.page1.ooag003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag004
            
            #add-point:AFTER FIELD ooag004 name="input.a.page1.ooag004"
            LET g_ooag_d[l_ac].ooag004_desc = ' '
            DISPLAY g_ooag_d[l_ac].ooag004_desc TO s_detail1[l_ac].ooag004_desc
            
            IF NOT cl_null(g_ooag_d[l_ac].ooag004) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ooag_d[l_ac].ooag004 != g_ooag_d_t.ooag004) THEN 
                  IF NOT aooi130_ooag004(g_ooag_d[l_ac].ooag004) THEN
                     LET g_ooag_d[l_ac].ooag004 = g_ooag_d_t.ooag004
                     CALL aooi130_ooag004_ref(g_ooag_d[l_ac].ooag004) RETURNING g_ooag_d[l_ac].ooag004_desc
                     DISPLAY BY NAME g_ooag_d[l_ac].ooag004_desc
                     NEXT FIELD ooag004
                  END IF 
               END IF 
            END IF 
            CALL aooi130_ooag004_ref(g_ooag_d[l_ac].ooag004) RETURNING g_ooag_d[l_ac].ooag004_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag004
            #add-point:BEFORE FIELD ooag004 name="input.b.page1.ooag004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag004
            #add-point:ON CHANGE ooag004 name="input.g.page1.ooag004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag005
            
            #add-point:AFTER FIELD ooag005 name="input.a.page1.ooag005"
            LET g_ooag_d[l_ac].ooag005_desc = ' '
            DISPLAY g_ooag_d[l_ac].ooag005_desc TO s_detail1[l_ac].ooag005_desc
            
            IF NOT cl_null(g_ooag_d[l_ac].ooag005) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ooag_d[l_ac].ooag005 != g_ooag_d_t.ooag005) THEN 
                  #IF NOT ap_chk_isExist(g_ooag_d[l_ac].ooag005,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 ='5' AND oocq002 = ? ","aoo-00086",0 ) THEN
                  #   LET g_ooag_d[l_ac].ooag005 = g_ooag_d_t.ooag005
                  #   CALL aooi130_ooag005_ref(g_ooag_d[l_ac].ooag005) RETURNING g_ooag_d[l_ac].ooag005_desc
                  #   DISPLAY BY NAME g_ooag_d[l_ac].ooag005_desc
                  #   NEXT FIELD ooag005
                  #END IF
                  #IF NOT ap_chk_isExist(g_ooag_d[l_ac].ooag005,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocqstus = 'Y' AND oocq001 ='5' AND oocq002 = ? ","aim-00015",0 ) THEN
                  #   LET g_ooag_d[l_ac].ooag005 = g_ooag_d_t.ooag005
                  #   CALL aooi130_ooag005_ref(g_ooag_d[l_ac].ooag005) RETURNING g_ooag_d[l_ac].ooag005_desc
                  #   DISPLAY BY NAME g_ooag_d[l_ac].ooag005_desc
                  #   NEXT FIELD ooag005
                  #END IF
                  IF NOT s_azzi650_chk_exist('5',g_ooag_d[l_ac].ooag005) THEN
                     LET g_ooag_d[l_ac].ooag005 = g_ooag_d_t.ooag005
                     CALL aooi130_ooag005_ref(g_ooag_d[l_ac].ooag005) RETURNING g_ooag_d[l_ac].ooag005_desc
                     DISPLAY BY NAME g_ooag_d[l_ac].ooag005_desc
                     NEXT FIELD ooag005
                  END IF
               #END IF   
            END IF
            CALL aooi130_ooag005_ref(g_ooag_d[l_ac].ooag005) RETURNING g_ooag_d[l_ac].ooag005_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag005_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag005
            #add-point:BEFORE FIELD ooag005 name="input.b.page1.ooag005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag005
            #add-point:ON CHANGE ooag005 name="input.g.page1.ooag005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag015
            
            #add-point:AFTER FIELD ooag015 name="input.a.page1.ooag015"
            CALL s_desc_get_acc_desc('16',g_ooag_d[l_ac].ooag015) RETURNING g_ooag_d[l_ac].ooag015_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag015_desc
            IF NOT cl_null(g_ooag_d[l_ac].ooag015) THEN 
               IF NOT s_azzi650_chk_exist('16',g_ooag_d[l_ac].ooag015) THEN
                  LET g_ooag_d[l_ac].ooag015 = g_ooag_d_t.ooag015
                  NEXT FIELD CURRENT
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag015
            #add-point:BEFORE FIELD ooag015 name="input.b.page1.ooag015"
            CALL s_desc_get_acc_desc('16',g_ooag_d[l_ac].ooag015) RETURNING g_ooag_d[l_ac].ooag015_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag015_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag015
            #add-point:ON CHANGE ooag015 name="input.g.page1.ooag015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag016
            #add-point:BEFORE FIELD ooag016 name="input.b.page1.ooag016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag016
            
            #add-point:AFTER FIELD ooag016 name="input.a.page1.ooag016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag016
            #add-point:ON CHANGE ooag016 name="input.g.page1.ooag016"
            CALL aooi130_set_entry_b(l_cmd)
            CALL aooi130_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag017
            
            #add-point:AFTER FIELD ooag017 name="input.a.page1.ooag017"
            CALL s_desc_get_person_desc(g_ooag_d[l_ac].ooag017) RETURNING g_ooag_d[l_ac].ooag017_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag017_desc
            IF NOT cl_null(g_ooag_d[l_ac].ooag017) THEN 
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooag_d[l_ac].ooag017
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_ooag_d[l_ac].ooag017 = g_ooag_d_t.ooag017
                  NEXT FIELD CURRENT
               END IF
            END IF   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag017
            #add-point:BEFORE FIELD ooag017 name="input.b.page1.ooag017"
            CALL s_desc_get_person_desc(g_ooag_d[l_ac].ooag017) RETURNING g_ooag_d[l_ac].ooag017_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag017_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag017
            #add-point:ON CHANGE ooag017 name="input.g.page1.ooag017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooag018
            
            #add-point:AFTER FIELD ooag018 name="input.a.page1.ooag018"
            #160429-00013#12-S
            #確認資料無重複
            IF  g_ooag_d[l_ac].ooag018 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooag_d[g_detail_idx].ooag018 != g_ooag_d_t.ooag018)) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ooag_d[g_detail_idx].ooag018
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_ooag_d[g_detail_idx].ooag018      = g_ooag_d[g_detail_idx].ooag018
                     LET g_ooag_d[g_detail_idx].ooag018_desc = g_ooag_d_t.ooag018_desc
                     NEXT FIELD CURRENT
                  END IF  
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooag_d[l_ac].ooag018
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_ooag_d[l_ac].ooag018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooag_d[l_ac].ooag018_desc
            #160429-00013#12-E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooag018
            #add-point:BEFORE FIELD ooag018 name="input.b.page1.ooag018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooag018
            #add-point:ON CHANGE ooag018 name="input.g.page1.ooag018"
 
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.ooagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooagstus
            #add-point:ON ACTION controlp INFIELD ooagstus name="input.c.page1.ooagstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag001
            #add-point:ON ACTION controlp INFIELD ooag001 name="input.c.page1.ooag001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag008
            #add-point:ON ACTION controlp INFIELD ooag008 name="input.c.page1.ooag008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag009
            #add-point:ON ACTION controlp INFIELD ooag009 name="input.c.page1.ooag009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag010
            #add-point:ON ACTION controlp INFIELD ooag010 name="input.c.page1.ooag010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag011
            #add-point:ON ACTION controlp INFIELD ooag011 name="input.c.page1.ooag011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag012
            #add-point:ON ACTION controlp INFIELD ooag012 name="input.c.page1.ooag012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag013
            #add-point:ON ACTION controlp INFIELD ooag013 name="input.c.page1.ooag013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag014
            #add-point:ON ACTION controlp INFIELD ooag014 name="input.c.page1.ooag014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oofa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofa015
            #add-point:ON ACTION controlp INFIELD oofa015 name="input.c.page1.oofa015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag003
            #add-point:ON ACTION controlp INFIELD ooag003 name="input.c.page1.ooag003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooag_d[l_ac].ooag003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_ooag_d[l_ac].ooag003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooag_d[l_ac].ooag003 TO ooag003              #顯示到畫面上
            CALL aooi130_ooag003_ref(g_ooag_d[l_ac].ooag003) RETURNING g_ooag_d[l_ac].ooag003_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag003_desc
            NEXT FIELD ooag003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag004
            #add-point:ON ACTION controlp INFIELD ooag004 name="input.c.page1.ooag004"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooag_d[l_ac].ooag004             #給予default值

            #給予arg
            LET g_qryparam.where = " ooef201 = 'Y' "

            CALL q_ooef001()                                #呼叫開窗
            LET g_qryparam.where = " "

            LET g_ooag_d[l_ac].ooag004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooag_d[l_ac].ooag004 TO ooag004              #顯示到畫面上
            CALL aooi130_ooag004_ref(g_ooag_d[l_ac].ooag004) RETURNING g_ooag_d[l_ac].ooag004_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag004_desc
            NEXT FIELD ooag004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag005
            #add-point:ON ACTION controlp INFIELD ooag005 name="input.c.page1.ooag005"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooag_d[l_ac].ooag005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "5" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooag_d[l_ac].ooag005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooag_d[l_ac].ooag005 TO ooag005              #顯示到畫面上
            CALL aooi130_ooag005_ref(g_ooag_d[l_ac].ooag005) RETURNING g_ooag_d[l_ac].ooag005_desc
            DISPLAY BY NAME g_ooag_d[l_ac].ooag005_desc
            NEXT FIELD ooag005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag015
            #add-point:ON ACTION controlp INFIELD ooag015 name="input.c.page1.ooag015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_ooag_d[l_ac].ooag015             #給予default值
            LET g_qryparam.default2 = "" #g_ooag_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "16" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_ooag_d[l_ac].ooag015 = g_qryparam.return1              
            #LET g_ooag_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_ooag_d[l_ac].ooag015 TO ooag015              #
            #DISPLAY g_ooag_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD ooag015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag016
            #add-point:ON ACTION controlp INFIELD ooag016 name="input.c.page1.ooag016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag017
            #add-point:ON ACTION controlp INFIELD ooag017 name="input.c.page1.ooag017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_ooag_d[l_ac].ooag017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_ooag_d[l_ac].ooag017 = g_qryparam.return1              

            DISPLAY g_ooag_d[l_ac].ooag017 TO ooag017              #

            NEXT FIELD ooag017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.ooag018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooag018
            #add-point:ON ACTION controlp INFIELD ooag018 name="input.c.page1.ooag018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_ooag_d[l_ac].ooag018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_ooag_d[l_ac].ooag018 = g_qryparam.return1              

            DISPLAY g_ooag_d[l_ac].ooag018 TO ooag018              #

            NEXT FIELD ooag018                          #返回原欄位



            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aooi130_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_ooag_d[l_ac].* = g_ooag_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               #add-point:單身取消時 name="input.body.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_ooag_d[l_ac].ooag001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_ooag_d[l_ac].* = g_ooag_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_ooag1_info_d[l_ac].ooagmodid = g_user 
LET g_ooag1_info_d[l_ac].ooagmoddt = cl_get_current()
LET g_ooag1_info_d[l_ac].ooagmodid_desc = cl_get_username(g_ooag1_info_d[l_ac].ooagmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi130_ooag_t_mask_restore('restore_mask_o')
 
               UPDATE ooag_t SET (ooagstus,ooag001,ooag008,ooag009,ooag010,ooag011,ooag012,ooag013,ooag014, 
                   ooag003,ooag004,ooag005,ooag015,ooag016,ooag017,ooag018,ooagmodid,ooagmoddt,ooagownid, 
                   ooagowndp,ooagcrtid,ooagcrtdp,ooagcrtdt) = (g_ooag_d[l_ac].ooagstus,g_ooag_d[l_ac].ooag001, 
                   g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010,g_ooag_d[l_ac].ooag011, 
                   g_ooag_d[l_ac].ooag012,g_ooag_d[l_ac].ooag013,g_ooag_d[l_ac].ooag014,g_ooag_d[l_ac].ooag003, 
                   g_ooag_d[l_ac].ooag004,g_ooag_d[l_ac].ooag005,g_ooag_d[l_ac].ooag015,g_ooag_d[l_ac].ooag016, 
                   g_ooag_d[l_ac].ooag017,g_ooag_d[l_ac].ooag018,g_ooag1_info_d[l_ac].ooagmodid,g_ooag1_info_d[l_ac].ooagmoddt, 
                   g_ooag1_info_d[l_ac].ooagownid,g_ooag1_info_d[l_ac].ooagowndp,g_ooag1_info_d[l_ac].ooagcrtid, 
                   g_ooag1_info_d[l_ac].ooagcrtdp,g_ooag1_info_d[l_ac].ooagcrtdt)
                WHERE ooagent = g_enterprise AND
                  ooag001 = g_ooag_d_t.ooag001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooag_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooag_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooag_d[g_detail_idx].ooag001
               LET gs_keys_bak[1] = g_ooag_d_t.ooag001
               CALL aooi130_update_b('ooag_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_ooag_d_t)
                     LET g_log2 = util.JSON.stringify(g_ooag_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi130_ooag_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooag001 = g_ooag_d_t.ooag001  AND ooagent = g_enterprise
               UPDATE oofa_t SET (oofa008,oofa009,oofa010,oofa011,oofa012,oofa013,oofa014,oofa015)
                               = (g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010,g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag012,g_ooag_d[l_ac].ooag013,g_ooag_d[l_ac].ooag014,g_ooag_d[l_ac].oofa015)
                WHERE oofaent = g_enterprise AND oofa001 = l_ooag002
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aooi130_unlock_b("ooag_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_ooag_d[l_ac].* = g_ooag_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_ooag_d[li_reproduce_target].* = g_ooag_d[li_reproduce].*
               LET g_ooag1_info_d[li_reproduce_target].* = g_ooag1_info_d[li_reproduce].*
 
               LET g_ooag_d[li_reproduce_target].ooag001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_ooag_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_ooag_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_ooag1_info_d TO s_detail1_info.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aooi130_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_info")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為 name="input.body1_info.action"
         
         #end add-point
            
      END DISPLAY
 
      
      #add-point:before_more_input name="input.more_input"
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog name="input.before_dialog"
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD ooagstus
            WHEN "s_detail1_info"
               NEXT FIELD ooag001_2
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
    
   #新增後取消
   IF l_cmd = 'a' THEN
      #當取消或無輸入資料按確定時刪除對應資料
      IF INT_FLAG OR cl_null(g_ooag_d[g_detail_idx].ooag001) THEN
         CALL g_ooag_d.deleteElement(g_detail_idx)
         CALL g_ooag1_info_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_ooag_d[g_detail_idx].* = g_ooag_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aooi130_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi130_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_oofa001       LIKE oofa_t.oofa001
   DEFINE l_sql           STRING
   DEFINE  l_oofa     RECORD
                      oofa001 LIKE oofa_t.oofa001
                      END RECORD
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_ooag_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aooi130_lock_b("ooag_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("ooag_t","ooagownid") THEN
            LET g_data_owner = g_ooag1_info_d[g_detail_idx].ooagownid
            LET g_data_dept = g_ooag1_info_d[g_detail_idx].ooagowndp
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
         #(ver:35) --- add end ---
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_ooag_d.getLength()
      IF g_ooag_d[li_idx].ooag001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM ooag_t
          WHERE ooagent = g_enterprise AND 
                ooag001 = g_ooag_d[li_idx].ooag001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         #161024-00068#1  2016/11/07 By 08734 add(S)
         LET l_sql =" SELECT oofa001 ",
                    " FROM oofa_t ",
                    " WHERE oofaent ='",g_enterprise,"'", 
                    " AND oofa003 = '",g_ooag_d[li_idx].ooag001,"'"
         PREPARE aooi130_pre FROM l_sql
         DECLARE aooi350_del CURSOR FOR aooi130_pre
         INITIALIZE l_oofa001 TO NULL
         FOREACH aooi350_del INTO l_oofa.oofa001
            IF NOT cl_null(l_oofa.oofa001) THEN
               IF NOT s_aooi350_del(l_oofa.oofa001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
         
                  CALL s_transaction_end('N','0')
               END IF
            END IF
          #  DELETE FROM oofa_t
          #     WHERE oofaent = g_enterprise AND 
          #        oofa001 = l_oofa.oofa001
          #  IF SQLCA.sqlcode THEN
          #     INITIALIZE g_errparam TO NULL
          #     LET g_errparam.code = SQLCA.sqlcode
          #     LET g_errparam.extend = "oofa_t:",SQLERRMESSAGE 
          #     LET g_errparam.popup = TRUE
          #     CALL cl_err()                  
          #     CALL s_transaction_end('N','0')
          #     RETURN 
          #  END IF
            
         END FOREACH
         FREE aooi130_pre
         #161024-00068#1  2016/11/07 By 08734 add(E)
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooag_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
 
            
 
 
            
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooag_d_t.ooag001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aooi130_delete_b('ooag_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi130_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   CALL s_transaction_end('Y','0')
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
 
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL aooi130_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aooi130.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi130_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ooag002       LIKE ooag_t.ooag002
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
#160808-00006#1-s add
   IF NOT p_wc2.getIndexOf("t0",1) THEN
      LET p_wc2 = cl_replace_str(p_wc2,'ooag','t0.ooag')
   END IF
#160808-00006#1-e add
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.ooagstus,t0.ooag001,t0.ooag008,t0.ooag009,t0.ooag010,t0.ooag011, 
       t0.ooag012,t0.ooag013,t0.ooag014,t0.ooag003,t0.ooag004,t0.ooag005,t0.ooag015,t0.ooag016,t0.ooag017, 
       t0.ooag018,t0.ooag001,t0.ooagmodid,t0.ooagmoddt,t0.ooagownid,t0.ooagowndp,t0.ooagcrtid,t0.ooagcrtdp, 
       t0.ooagcrtdt ,t1.ooefl003 ,t2.ooefl003 ,t3.oocql004 ,t4.oocql004 ,t5.ooag011 ,t6.ooag011 ,t7.ooag011 , 
       t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 FROM ooag_t t0",
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.ooag003 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.ooag004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='5' AND t3.oocql002=t0.ooag005 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='16' AND t4.oocql002=t0.ooag015 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.ooag017  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.ooag018  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.ooagmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.ooagownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.ooagowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.ooagcrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.ooagcrtdp AND t11.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.ooagent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("ooag_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND ooagowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("ooag_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND ooagownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("ooag_t"),
                      " ORDER BY t0.ooag001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooag_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aooi130_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aooi130_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_ooag_d.clear()
   CALL g_ooag1_info_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_ooag_d[l_ac].ooagstus,g_ooag_d[l_ac].ooag001,g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009, 
       g_ooag_d[l_ac].ooag010,g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag012,g_ooag_d[l_ac].ooag013,g_ooag_d[l_ac].ooag014, 
       g_ooag_d[l_ac].ooag003,g_ooag_d[l_ac].ooag004,g_ooag_d[l_ac].ooag005,g_ooag_d[l_ac].ooag015,g_ooag_d[l_ac].ooag016, 
       g_ooag_d[l_ac].ooag017,g_ooag_d[l_ac].ooag018,g_ooag1_info_d[l_ac].ooag001,g_ooag1_info_d[l_ac].ooagmodid, 
       g_ooag1_info_d[l_ac].ooagmoddt,g_ooag1_info_d[l_ac].ooagownid,g_ooag1_info_d[l_ac].ooagowndp, 
       g_ooag1_info_d[l_ac].ooagcrtid,g_ooag1_info_d[l_ac].ooagcrtdp,g_ooag1_info_d[l_ac].ooagcrtdt, 
       g_ooag_d[l_ac].ooag003_desc,g_ooag_d[l_ac].ooag004_desc,g_ooag_d[l_ac].ooag005_desc,g_ooag_d[l_ac].ooag015_desc, 
       g_ooag_d[l_ac].ooag017_desc,g_ooag_d[l_ac].ooag018_desc,g_ooag1_info_d[l_ac].ooagmodid_desc,g_ooag1_info_d[l_ac].ooagownid_desc, 
       g_ooag1_info_d[l_ac].ooagowndp_desc,g_ooag1_info_d[l_ac].ooagcrtid_desc,g_ooag1_info_d[l_ac].ooagcrtdp_desc 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooag001 = g_ooag_d[l_ac].ooag001 AND ooagent = g_enterprise
      SELECT oofa015  INTO g_ooag_d[l_ac].oofa015
        FROM oofa_t WHERE oofa001 = l_ooag002 AND oofaent = g_enterprise

       #CALL aooi130_ooag003_ref(g_ooag_d[l_ac].ooag003) RETURNING g_ooag_d[l_ac].ooag003_desc
       #CALL aooi130_ooag004_ref(g_ooag_d[l_ac].ooag004) RETURNING g_ooag_d[l_ac].ooag004_desc
       #CALL aooi130_ooag005_ref(g_ooag_d[l_ac].ooag005) RETURNING g_ooag_d[l_ac].ooag005_desc
       #DISPLAY BY NAME g_ooag_d[l_ac].ooag003_desc,g_ooag_d[l_ac].ooag004_desc,g_ooag_d[l_ac].ooag005_desc
       #CALL aooi130_ooagmodid_ref(g_ooag1_info_d[l_ac].ooagmodid) RETURNING g_ooag1_info_d[l_ac].ooagmodid_desc
       #CALL aooi130_ooagmodid_ref(g_ooag1_info_d[l_ac].ooagownid) RETURNING g_ooag1_info_d[l_ac].ooagownid_desc
       #CALL aooi130_ooagmodid_ref(g_ooag1_info_d[l_ac].ooagcrtid) RETURNING g_ooag1_info_d[l_ac].ooagcrtid_desc 
       #DISPLAY BY NAME g_ooag1_info_d[l_ac].ooagmodid_desc,g_ooag1_info_d[l_ac].ooagownid_desc,g_ooag1_info_d[l_ac].ooagcrtid_desc
       
      #end add-point
      
      CALL aooi130_detail_show()      
 
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
 
   LET g_error_show = 0
   
 
   
   CALL g_ooag_d.deleteElement(g_ooag_d.getLength())   
   CALL g_ooag1_info_d.deleteElement(g_ooag1_info_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_ooag_d.getLength()
      LET g_ooag1_info_d[l_ac].ooag001 = g_ooag_d[l_ac].ooag001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_ooag_d.getLength() THEN
      LET l_ac = g_ooag_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_ooag_d.getLength()
      LET g_ooag_d_mask_o[l_ac].* =  g_ooag_d[l_ac].*
      CALL aooi130_ooag_t_mask()
      LET g_ooag_d_mask_n[l_ac].* =  g_ooag_d[l_ac].*
   END FOR
   
   LET g_ooag1_info_d_mask_o.* =  g_ooag1_info_d.*
   FOR l_ac = 1 TO g_ooag1_info_d.getLength()
      LET g_ooag1_info_d_mask_o[l_ac].* =  g_ooag1_info_d[l_ac].*
      CALL aooi130_ooag_t_mask()
      LET g_ooag1_info_d_mask_n[l_ac].* =  g_ooag1_info_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_ooag_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aooi130_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aooi130_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_ooag002     LIKE ooag_t.ooag002
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
            #CALL aooi130_ooag003_ref(g_ooag_d[l_ac].ooag003) RETURNING g_ooag_d[l_ac].ooag003_desc
            #CALL aooi130_ooag004_ref(g_ooag_d[l_ac].ooag004) RETURNING g_ooag_d[l_ac].ooag004_desc
            #CALL aooi130_ooag005_ref(g_ooag_d[l_ac].ooag005) RETURNING g_ooag_d[l_ac].ooag005_desc
            #DISPLAY BY NAME g_ooag_d[l_ac].ooag003_desc,g_ooag_d[l_ac].ooag004_desc,g_ooag_d[l_ac].ooag005_desc
            
           
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body1_info.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooag1_info_d[l_ac].ooagmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_ooag1_info_d[l_ac].ooagmodid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_ooag1_info_d[l_ac].ooagmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooag1_info_d[l_ac].ooagownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_ooag1_info_d[l_ac].ooagownid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_ooag1_info_d[l_ac].ooagownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooag1_info_d[l_ac].ooagowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooag1_info_d[l_ac].ooagowndp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_ooag1_info_d[l_ac].ooagowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooag1_info_d[l_ac].ooagcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_ooag1_info_d[l_ac].ooagcrtid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_ooag1_info_d[l_ac].ooagcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooag1_info_d[l_ac].ooagcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooag1_info_d[l_ac].ooagcrtdp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_ooag1_info_d[l_ac].ooagcrtdp_desc

   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooag001 = g_ooag_d[l_ac].ooag001 AND ooagent = g_enterprise
   SELECT oofa015 INTO g_ooag_d[l_ac].oofa015 FROM oofa_t WHERE oofa001 = l_ooag002 AND oofaent = g_enterprise    
   DISPLAY BY NAME g_ooag_d[l_ac].oofa015
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi130.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi130_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段control name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("ooag017,ooag017_desc",TRUE)    #160505-00021#2
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aooi130.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi130_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry_b段control name="set_no_entry_b.set_no_entry_b"
   #160505-00021#2---add---s
   IF g_ooag_d[l_ac].ooag016 = 'N' THEN 
      CALL cl_set_comp_entry("ooag017,ooag017_desc",FALSE)
   END IF
   #160505-00021#2---add---e
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aooi130.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi130_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " ooag001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
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
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aooi130.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi130_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "ooag_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'ooag_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM ooag_t
          WHERE ooagent = g_enterprise AND
            ooag001 = ps_keys_bak[1]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_ooag_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_ooag1_info_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi130_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "ooag_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO ooag_t
                  (ooagent,
                   ooag001
                   ,ooagstus,ooag008,ooag009,ooag010,ooag011,ooag012,ooag013,ooag014,ooag003,ooag004,ooag005,ooag015,ooag016,ooag017,ooag018,ooagmodid,ooagmoddt,ooagownid,ooagowndp,ooagcrtid,ooagcrtdp,ooagcrtdt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_ooag_d[l_ac].ooagstus,g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010, 
                       g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag012,g_ooag_d[l_ac].ooag013,g_ooag_d[l_ac].ooag014, 
                       g_ooag_d[l_ac].ooag003,g_ooag_d[l_ac].ooag004,g_ooag_d[l_ac].ooag005,g_ooag_d[l_ac].ooag015, 
                       g_ooag_d[l_ac].ooag016,g_ooag_d[l_ac].ooag017,g_ooag_d[l_ac].ooag018,g_ooag1_info_d[l_ac].ooagmodid, 
                       g_ooag1_info_d[l_ac].ooagmoddt,g_ooag1_info_d[l_ac].ooagownid,g_ooag1_info_d[l_ac].ooagowndp, 
                       g_ooag1_info_d[l_ac].ooagcrtid,g_ooag1_info_d[l_ac].ooagcrtdp,g_ooag1_info_d[l_ac].ooagcrtdt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooag_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi130_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #若key有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
   LET ls_group = "ooag_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "ooag_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE ooag_t 
         SET (ooag001
              ,ooagstus,ooag008,ooag009,ooag010,ooag011,ooag012,ooag013,ooag014,ooag003,ooag004,ooag005,ooag015,ooag016,ooag017,ooag018,ooagmodid,ooagmoddt,ooagownid,ooagowndp,ooagcrtid,ooagcrtdp,ooagcrtdt) 
              = 
             (ps_keys[1]
              ,g_ooag_d[l_ac].ooagstus,g_ooag_d[l_ac].ooag008,g_ooag_d[l_ac].ooag009,g_ooag_d[l_ac].ooag010, 
                  g_ooag_d[l_ac].ooag011,g_ooag_d[l_ac].ooag012,g_ooag_d[l_ac].ooag013,g_ooag_d[l_ac].ooag014, 
                  g_ooag_d[l_ac].ooag003,g_ooag_d[l_ac].ooag004,g_ooag_d[l_ac].ooag005,g_ooag_d[l_ac].ooag015, 
                  g_ooag_d[l_ac].ooag016,g_ooag_d[l_ac].ooag017,g_ooag_d[l_ac].ooag018,g_ooag1_info_d[l_ac].ooagmodid, 
                  g_ooag1_info_d[l_ac].ooagmoddt,g_ooag1_info_d[l_ac].ooagownid,g_ooag1_info_d[l_ac].ooagowndp, 
                  g_ooag1_info_d[l_ac].ooagcrtid,g_ooag1_info_d[l_ac].ooagcrtdp,g_ooag1_info_d[l_ac].ooagcrtdt)  
 
         WHERE ooagent = g_enterprise AND ooag001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooag_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooag_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi130_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aooi130_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "ooag_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi130_bcl USING g_enterprise,
                                       g_ooag_d[g_detail_idx].ooag001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi130_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi130.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi130_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aooi130_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi130.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aooi130_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define(客製用) name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前 name="modify_detail_chk.before"
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "ooagstus"
      WHEN "s_detail1_info"
         LET ls_return = "ooag001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aooi130.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aooi130_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   IF g_action_choice = 'modify' OR g_action_choice = 'modify_detail' THEN
      IF mc_data_owner_check THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'lib-00419'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   END IF
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aooi130.mask_functions" >}
&include "erp/aoo/aooi130_mask.4gl"
 
{</section>}
 
{<section id="aooi130.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi130_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_ooag_d[l_ac].ooag001
   LET g_pk_array[1].column = 'ooag001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi130.state_change" >}
   
 
{</section>}
 
{<section id="aooi130.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi130.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aooi130_ooag004_ref(p_ooag004)
DEFINE p_ooag004      LIKE ooag_t.ooag004
DEFINE r_ooag004_desc LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_ooag004
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooag004_desc = g_rtn_fields[1]
       RETURN r_ooag004_desc  
       
END FUNCTION
# 營運據點欄位控管
PRIVATE FUNCTION aooi130_ooag004(p_ooag004)
DEFINE p_ooag004       LIKE ooag_t.ooag004
 
 IF NOT cl_null(p_ooag004) THEN
    IF NOT ap_chk_isExist(p_ooag004,"SELECT COUNT(1) FROM ooef_t WHERE ooefent = '" ||g_enterprise||"' AND ooef001 = ? ","aoo-00090",0 ) THEN
       RETURN FALSE
    END IF
    IF NOT ap_chk_isExist(p_ooag004,"SELECT COUNT(1) FROM ooef_t WHERE ooefent = '" ||g_enterprise||"' AND ooefstus = 'Y' AND ooef001 = ? ","sub-01302","aooi100") THEN  #aoo-00091  #160318-00005#30  By 07900 --mod
       RETURN FALSE
    END IF
    #161019-00017#1-S
    INITIALIZE g_chkparam.* TO NULL
     
    #設定g_chkparam.*的參數
    LET g_chkparam.arg1 = p_ooag004
     
       
    #呼叫檢查存在並帶值的library
    IF cl_chk_exist("v_ooef001_13") THEN   
       #檢查成功時後續處理
    ELSE
       #檢查失敗時後續處理
       RETURN FALSE
    END IF    
    #161019-00017#1-E
 END IF   
RETURN TRUE
END FUNCTION
#+
PRIVATE FUNCTION aooi130_ooag005_ref(p_ooag005)
DEFINE p_ooag005      LIKE ooag_t.ooag005
DEFINE r_ooag005_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_ooag005
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='5' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooag005_desc = g_rtn_fields[1]
       RETURN r_ooag005_desc  
END FUNCTION
#+
PRIVATE FUNCTION aooi130_ooag003_ref(p_ooag003)
DEFINE p_ooag003      LIKE ooag_t.ooag003
DEFINE r_ooag003_desc LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_ooag003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooag003_desc = g_rtn_fields[1] 
       RETURN r_ooag003_desc   
       
END FUNCTION

PRIVATE FUNCTION aooi130_ooagmodid_ref(p_ooagmodid)
DEFINE p_ooagmodid   LIKE ooag_t.ooagmodid
DEFINE r_ooag011     LIKE ooag_t.ooag011

      LET r_ooag011 = ''
      SELECT ooag011 INTO r_ooag011 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = p_ooagmodid
      RETURN r_ooag011
      
END FUNCTION

################################################################################
# Descriptions...: 聯絡對象識別碼批次產生
# Memo...........:
# Usage..........: CALL aooi130_batch()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 14/09/03 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi130_batch()
DEFINE l_sql           STRING
DEFINE l_ooag001       LIKE ooag_t.ooag001
DEFINE l_success       LIKE type_t.num5
DEFINE l_oofa001       LIKE oofa_t.oofa001
DEFINE l_success1      LIKE type_t.num5
   
   LET l_ooag001 = ''
   LET l_success = TRUE
   LET l_oofa001 = ''
   LET l_success1 = TRUE
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()   #匯總錯誤訊息初始化
   LET l_sql = " SELECT ooag001",
               "   FROM ooag_t",
               "  WHERE ooagent = '",g_enterprise,"'",
               "    AND ooag002 IS NULL"
   PREPARE aooi130_sel_ooag001_pr FROM l_sql
   DECLARE aooi130_sel_ooag001_cs CURSOR FOR aooi130_sel_ooag001_pr
   FOREACH aooi130_sel_ooag001_cs INTO l_ooag001
      CALL s_aooi350_ins_oofa('2',l_ooag001,'') RETURNING l_success,l_oofa001
      IF l_success THEN
         UPDATE ooag_t set ooag002 = l_oofa001
          WHERE ooagent = g_enterprise AND ooag001 = l_ooag001
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ooag001
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               CALL s_transaction_end('N','0')
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ooag001
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               CALL s_transaction_end('N','0')
         END CASE
      ELSE
         LET l_success1 = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00032'   #資料更新失敗
         LET g_errparam.extend = l_ooag001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N','0')
      END IF
   END FOREACH
   CALL cl_err_collect_show()   #顯示匯總錯誤訊息
   
   IF l_success1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00033'   #資料更新成功
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      
      CALL s_transaction_end('Y','0')      
   END IF
END FUNCTION

 
{</section>}
 
