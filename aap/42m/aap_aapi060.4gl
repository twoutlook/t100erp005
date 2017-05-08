#該程式未解開Section, 採用最新樣板產出!
{<section id="aapi060.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-09-05 11:48:59), PR版次:0012(2016-10-21 12:00:08)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000105
#+ Filename...: aapi060
#+ Description: 集團代收付基本資料維護作業
#+ Creator....: 04152(2014-09-16 17:40:36)
#+ Modifier...: 04152 -SD/PR- 08732
 
{</section>}
 
{<section id="aapi060.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150128-00005#18  2015/03/25 By Reanna   待抵單的開窗(apaf021)，改取aapq343的單別
#160122-00001#16  2016/02/14 By yangtt   添加交易帳戶編號用戶權限空管
#160321-00016#19  2016/03/31 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#25  2016/04/26 BY 07900    校验代码重复错误讯息的修改
#160805-00031#1   2016/08/06 By 03538    已建立之來源組織,雖沒有帳戶權限仍須查詢出來,只是帳戶使用遮罩
#160812-00027#5   2016/08/16 By 06821    全面盤點應付程式帳套權限控管
#160818-00035#1   2016/08/18 By albireo  集團代收付整測調整
#160905-00002#1   2016/09/05 By Reanna   SQL條件少ENT補上(硬框架調整)
#161006-00005#18  2016/10/21 By 08732    組織類型與職能開窗調整
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
PRIVATE TYPE type_g_apaf_d RECORD
       apaf001 LIKE apaf_t.apaf001, 
   apaf011 LIKE apaf_t.apaf011, 
   l_apaf011_desc LIKE type_t.chr500, 
   apaf012 LIKE apaf_t.apaf012, 
   lc_apaf012 LIKE type_t.chr10, 
   l_apaf012_desc LIKE type_t.chr500, 
   apaf013 LIKE apaf_t.apaf013, 
   l_apaf013_desc LIKE type_t.chr500, 
   apaf014 LIKE apaf_t.apaf014, 
   l_apaf014_desc LIKE type_t.chr500, 
   apaf021 LIKE apaf_t.apaf021, 
   l_apaf021_desc LIKE type_t.chr500, 
   apaf017 LIKE apaf_t.apaf017, 
   l_apaf017_desc LIKE type_t.chr500, 
   apaf018 LIKE apaf_t.apaf018, 
   l_apaf018_desc LIKE type_t.chr500, 
   apaf019 LIKE apaf_t.apaf019, 
   l_apaf019_desc LIKE type_t.chr500, 
   apaf020 LIKE apaf_t.apaf020, 
   l_apaf020_desc LIKE type_t.chr500, 
   apaf015 LIKE apaf_t.apaf015, 
   l_apaf015_desc LIKE type_t.chr500, 
   apaf016 LIKE apaf_t.apaf016, 
   l_apaf016_desc LIKE type_t.chr500, 
   apafstus LIKE apaf_t.apafstus
       END RECORD
PRIVATE TYPE type_g_apaf2_d RECORD
       apaf001 LIKE apaf_t.apaf001, 
   apaf011 LIKE apaf_t.apaf011, 
   apafownid LIKE apaf_t.apafownid, 
   apafownid_desc LIKE type_t.chr500, 
   apafowndp LIKE apaf_t.apafowndp, 
   apafowndp_desc LIKE type_t.chr500, 
   apafcrtid LIKE apaf_t.apafcrtid, 
   apafcrtid_desc LIKE type_t.chr500, 
   apafcrtdp LIKE apaf_t.apafcrtdp, 
   apafcrtdp_desc LIKE type_t.chr500, 
   apafcrtdt DATETIME YEAR TO SECOND, 
   apafmodid LIKE apaf_t.apafmodid, 
   apafmodid_desc LIKE type_t.chr500, 
   apafmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef019            LIKE ooef_t.ooef019           #稅區參照表(依據所屬法人所帶的設定)
DEFINE g_sql_bank           STRING                        #160122-00001#16 add by07675
DEFINE g_wc_cs_orga         STRING                        #160812-00027#5 add 帳務來源組織查詢時條件
DEFINE g_wc_apaf011         STRING                        #160812-00027#5 add 帳務來源組織新增時條件
#end add-point
 
#模組變數(Module Variables)
DEFINE g_apaf_d          DYNAMIC ARRAY OF type_g_apaf_d #單身變數
DEFINE g_apaf_d_t        type_g_apaf_d                  #單身備份
DEFINE g_apaf_d_o        type_g_apaf_d                  #單身備份
DEFINE g_apaf_d_mask_o   DYNAMIC ARRAY OF type_g_apaf_d #單身變數
DEFINE g_apaf_d_mask_n   DYNAMIC ARRAY OF type_g_apaf_d #單身變數
DEFINE g_apaf2_d   DYNAMIC ARRAY OF type_g_apaf2_d
DEFINE g_apaf2_d_t type_g_apaf2_d
DEFINE g_apaf2_d_o type_g_apaf2_d
DEFINE g_apaf2_d_mask_o DYNAMIC ARRAY OF type_g_apaf2_d
DEFINE g_apaf2_d_mask_n DYNAMIC ARRAY OF type_g_apaf2_d
 
      
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
 
{<section id="aapi060.main" >}
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
 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apaf001,apaf011,apaf012,apaf013,apaf014,apaf021,apaf017,apaf018,apaf019, 
       apaf020,apaf015,apaf016,apafstus,apaf001,apaf011,apafownid,apafowndp,apafcrtid,apafcrtdp,apafcrtdt, 
       apafmodid,apafmoddt FROM apaf_t WHERE apafent=? AND apaf001=? AND apaf011=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapi060_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapi060 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapi060_init()   
 
      #進入選單 Menu (="N")
      CALL aapi060_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapi060
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapi060.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapi060_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('apaf001','8520','1,2')
   CALL cl_set_combo_scc_part('apaf001_2','8520','1,2')
    #160122-00001#16--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#16 --add--end
   
   #160812-00027#5 --s add
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()     
   CALL s_fin_azzi800_sons_query(g_today)                      
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga 
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga  
   CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apaf011
   CALL s_fin_get_wc_str(g_wc_apaf011) RETURNING g_wc_apaf011
   #160812-00027#5 --e add
   #end add-point
   
   CALL aapi060_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aapi060.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapi060_ui_dialog()
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
         CALL g_apaf_d.clear()
         CALL g_apaf2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aapi060_init()
      END IF
   
      CALL aapi060_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_apaf2_d[g_detail_idx].apafownid   #(ver:35)
               LET g_data_dept = g_apaf2_d[g_detail_idx].apafowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aapi060_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_apaf2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body2.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body2.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aapi060_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
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
            CALL DIALOG.setSelectionMode("s_detail2", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aapi060_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapi060_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aapi060_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapi060_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aapi060_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapi060_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapi060_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapi060_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apaf_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_apaf2_d)
               LET g_export_id[2]   = "s_detail2"
 
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
            CALL aapi060_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapi060_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapi060_set_pk_array()
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
 
{<section id="aapi060.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapi060_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE  l_glaa024              LIKE glaa_t.glaa024    #單據別參照表
   DEFINE  l_comp                 LIKE apca_t.apcacomp
   DEFINE  l_ld                   LIKE apca_t.apcald
   DEFINE  l_glaa005              LIKE glaa_t.glaa005    #現金變動參照表
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apaf_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON apaf001,apaf011,apaf012,lc_apaf012,apaf013,apaf014,apaf021,apaf017,apaf018, 
          apaf019,apaf020,apaf015,apaf016,apafownid,apafowndp,apafcrtid,apafcrtdp,apafcrtdt,apafmodid, 
          apafmoddt 
 
         FROM s_detail1[1].apaf001,s_detail1[1].apaf011,s_detail1[1].apaf012,s_detail1[1].lc_apaf012, 
             s_detail1[1].apaf013,s_detail1[1].apaf014,s_detail1[1].apaf021,s_detail1[1].apaf017,s_detail1[1].apaf018, 
             s_detail1[1].apaf019,s_detail1[1].apaf020,s_detail1[1].apaf015,s_detail1[1].apaf016,s_detail2[1].apafownid, 
             s_detail2[1].apafowndp,s_detail2[1].apafcrtid,s_detail2[1].apafcrtdp,s_detail2[1].apafcrtdt, 
             s_detail2[1].apafmodid,s_detail2[1].apafmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apafcrtdt>>----
         AFTER FIELD apafcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apafmoddt>>----
         AFTER FIELD apafmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apafcnfdt>>----
         
         #----<<apafpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf001
            #add-point:BEFORE FIELD apaf001 name="query.b.page1.apaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf001
            
            #add-point:AFTER FIELD apaf001 name="query.a.page1.apaf001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf001
            #add-point:ON ACTION controlp INFIELD apaf001 name="query.c.page1.apaf001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf011
            #add-point:BEFORE FIELD apaf011 name="query.b.page1.apaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf011
            
            #add-point:AFTER FIELD apaf011 name="query.a.page1.apaf011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf011
            #add-point:ON ACTION controlp INFIELD apaf011 name="query.c.page1.apaf011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef201 = 'Y' " #為營運據點 #160812-00027#5 mark
            LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga,   #160812-00027#5 add
                                   " AND ooef201 = 'Y'"   #161006-00005#18  add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO apaf011
            NEXT FIELD apaf011
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf012
            #add-point:BEFORE FIELD apaf012 name="query.b.page1.apaf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf012
            
            #add-point:AFTER FIELD apaf012 name="query.a.page1.apaf012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf012
            #add-point:ON ACTION controlp INFIELD apaf012 name="query.c.page1.apaf012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#16--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#16 mod by 07675
            #160122-00001#16--add---end
            CALL q_nmas002_6()
            DISPLAY g_qryparam.return1 TO apaf012
            DISPLAY g_qryparam.return2 TO l_apaf012_desc
            LET g_qryparam.where = " "             #160122-00001#16
            NEXT FIELD apaf012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_apaf012
            #add-point:BEFORE FIELD lc_apaf012 name="query.b.page1.lc_apaf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_apaf012
            
            #add-point:AFTER FIELD lc_apaf012 name="query.a.page1.lc_apaf012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.lc_apaf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_apaf012
            #add-point:ON ACTION controlp INFIELD lc_apaf012 name="query.c.page1.lc_apaf012"
            #160805-00031#1--s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  
            CALL q_nmas002_6()
            DISPLAY g_qryparam.return1 TO lc_apaf012
            DISPLAY g_qryparam.return2 TO l_apaf012_desc
            LET g_qryparam.where = " "          
            NEXT FIELD lc_apaf012
            #160805-00031#1--e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf013
            #add-point:BEFORE FIELD apaf013 name="query.b.page1.apaf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf013
            
            #add-point:AFTER FIELD apaf013 name="query.a.page1.apaf013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf013
            #add-point:ON ACTION controlp INFIELD apaf013 name="query.c.page1.apaf013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooba002()
            DISPLAY g_qryparam.return1 TO apaf013
            NEXT FIELD apaf013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf014
            #add-point:BEFORE FIELD apaf014 name="query.b.page1.apaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf014
            
            #add-point:AFTER FIELD apaf014 name="query.a.page1.apaf014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf014
            #add-point:ON ACTION controlp INFIELD apaf014 name="query.c.page1.apaf014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooba002()
            DISPLAY g_qryparam.return1 TO apaf014
            NEXT FIELD apaf014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf021
            #add-point:BEFORE FIELD apaf021 name="query.b.page1.apaf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf021
            
            #add-point:AFTER FIELD apaf021 name="query.a.page1.apaf021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf021
            #add-point:ON ACTION controlp INFIELD apaf021 name="query.c.page1.apaf021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooba002()
            DISPLAY g_qryparam.return1 TO apaf021
            NEXT FIELD apaf021
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf017
            #add-point:BEFORE FIELD apaf017 name="query.b.page1.apaf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf017
            
            #add-point:AFTER FIELD apaf017 name="query.a.page1.apaf017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf017
            #add-point:ON ACTION controlp INFIELD apaf017 name="query.c.page1.apaf017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_20()
            DISPLAY g_qryparam.return1 TO apaf017
            NEXT FIELD apaf017
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf018
            #add-point:BEFORE FIELD apaf018 name="query.b.page1.apaf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf018
            
            #add-point:AFTER FIELD apaf018 name="query.a.page1.apaf018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf018
            #add-point:ON ACTION controlp INFIELD apaf018 name="query.c.page1.apaf018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooib002()
            DISPLAY g_qryparam.return1 TO apaf018
            NEXT FIELD apaf018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf019
            #add-point:BEFORE FIELD apaf019 name="query.b.page1.apaf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf019
            
            #add-point:AFTER FIELD apaf019 name="query.a.page1.apaf019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf019
            #add-point:ON ACTION controlp INFIELD apaf019 name="query.c.page1.apaf019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()
            DISPLAY g_qryparam.return1 TO apaf019
            NEXT FIELD apaf019
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf020
            #add-point:BEFORE FIELD apaf020 name="query.b.page1.apaf020"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf020
            
            #add-point:AFTER FIELD apaf020 name="query.a.page1.apaf020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf020
            #add-point:ON ACTION controlp INFIELD apaf020 name="query.c.page1.apaf020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apaf020
            NEXT FIELD apaf020
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf015
            #add-point:BEFORE FIELD apaf015 name="query.b.page1.apaf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf015
            
            #add-point:AFTER FIELD apaf015 name="query.a.page1.apaf015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf015
            #add-point:ON ACTION controlp INFIELD apaf015 name="query.c.page1.apaf015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 IN ('1','2') "
            CALL q_nmaj001()
            DISPLAY g_qryparam.return1 TO apaf015
            NEXT FIELD apaf015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf016
            #add-point:BEFORE FIELD apaf016 name="query.b.page1.apaf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf016
            
            #add-point:AFTER FIELD apaf016 name="query.a.page1.apaf016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.apaf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf016
            #add-point:ON ACTION controlp INFIELD apaf016 name="query.c.page1.apaf016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()
            DISPLAY g_qryparam.return1 TO apaf016
            NEXT FIELD apaf016
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.apafownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apafownid
            #add-point:ON ACTION controlp INFIELD apafownid name="construct.c.page2.apafownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apafownid  #顯示到畫面上
            NEXT FIELD apafownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafownid
            #add-point:BEFORE FIELD apafownid name="query.b.page2.apafownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apafownid
            
            #add-point:AFTER FIELD apafownid name="query.a.page2.apafownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apafowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apafowndp
            #add-point:ON ACTION controlp INFIELD apafowndp name="construct.c.page2.apafowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apafowndp  #顯示到畫面上
            NEXT FIELD apafowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafowndp
            #add-point:BEFORE FIELD apafowndp name="query.b.page2.apafowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apafowndp
            
            #add-point:AFTER FIELD apafowndp name="query.a.page2.apafowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apafcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apafcrtid
            #add-point:ON ACTION controlp INFIELD apafcrtid name="construct.c.page2.apafcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apafcrtid  #顯示到畫面上
            NEXT FIELD apafcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafcrtid
            #add-point:BEFORE FIELD apafcrtid name="query.b.page2.apafcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apafcrtid
            
            #add-point:AFTER FIELD apafcrtid name="query.a.page2.apafcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apafcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apafcrtdp
            #add-point:ON ACTION controlp INFIELD apafcrtdp name="construct.c.page2.apafcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apafcrtdp  #顯示到畫面上
            NEXT FIELD apafcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafcrtdp
            #add-point:BEFORE FIELD apafcrtdp name="query.b.page2.apafcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apafcrtdp
            
            #add-point:AFTER FIELD apafcrtdp name="query.a.page2.apafcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafcrtdt
            #add-point:BEFORE FIELD apafcrtdt name="query.b.page2.apafcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apafmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apafmodid
            #add-point:ON ACTION controlp INFIELD apafmodid name="construct.c.page2.apafmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apafmodid  #顯示到畫面上
            NEXT FIELD apafmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafmodid
            #add-point:BEFORE FIELD apafmodid name="query.b.page2.apafmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apafmodid
            
            #add-point:AFTER FIELD apafmodid name="query.a.page2.apafmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafmoddt
            #add-point:BEFORE FIELD apafmoddt name="query.b.page2.apafmoddt"
            
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
   #160805-00031#1--S
   IF NOT cl_null(g_wc2) THEN 
      LET g_wc2 = cl_replace_str(g_wc2,"lc_apaf012","apaf012")
   END IF
   #160805-00031#1--E
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
    
   CALL aapi060_b_fill(g_wc2)
   LET g_data_owner = g_apaf2_d[g_detail_idx].apafownid   #(ver:35)
   LET g_data_dept = g_apaf2_d[g_detail_idx].apafowndp   #(ver:35)
 
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
 
{<section id="aapi060.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapi060_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aapi060_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapi060.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapi060_modify()
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
   DEFINE  l_glaa024              LIKE glaa_t.glaa024
   DEFINE  l_comp                 LIKE apca_t.apcacomp
   DEFINE  l_ld                   LIKE apca_t.apcald
   DEFINE  l_glaa005              LIKE glaa_t.glaa005      #現金變動參照表
   DEFINE  l_oobastus             LIKE ooba_t.oobastus
   DEFINE  l_num                  LIKE type_t.num5
   DEFINE  l_sql                  STRING                   #160108-00006#1   
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
 
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_apaf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apaf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapi060_b_fill(g_wc2)
            LET g_detail_cnt = g_apaf_d.getLength()
         
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
            DISPLAY g_apaf_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_apaf_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_apaf_d[l_ac].apaf001 IS NOT NULL
               AND g_apaf_d[l_ac].apaf011 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apaf_d_t.* = g_apaf_d[l_ac].*  #BACKUP
               LET g_apaf_d_o.* = g_apaf_d[l_ac].*  #BACKUP
               IF NOT aapi060_lock_b("apaf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapi060_bcl INTO g_apaf_d[l_ac].apaf001,g_apaf_d[l_ac].apaf011,g_apaf_d[l_ac].apaf012, 
                      g_apaf_d[l_ac].apaf013,g_apaf_d[l_ac].apaf014,g_apaf_d[l_ac].apaf021,g_apaf_d[l_ac].apaf017, 
                      g_apaf_d[l_ac].apaf018,g_apaf_d[l_ac].apaf019,g_apaf_d[l_ac].apaf020,g_apaf_d[l_ac].apaf015, 
                      g_apaf_d[l_ac].apaf016,g_apaf_d[l_ac].apafstus,g_apaf2_d[l_ac].apaf001,g_apaf2_d[l_ac].apaf011, 
                      g_apaf2_d[l_ac].apafownid,g_apaf2_d[l_ac].apafowndp,g_apaf2_d[l_ac].apafcrtid, 
                      g_apaf2_d[l_ac].apafcrtdp,g_apaf2_d[l_ac].apafcrtdt,g_apaf2_d[l_ac].apafmodid, 
                      g_apaf2_d[l_ac].apafmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apaf_d_t.apaf001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apaf_d_mask_o[l_ac].* =  g_apaf_d[l_ac].*
                  CALL aapi060_apaf_t_mask()
                  LET g_apaf_d_mask_n[l_ac].* =  g_apaf_d[l_ac].*
                  
                  CALL aapi060_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapi060_set_entry_b(l_cmd)
            CALL aapi060_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            #160805-00031#1--s
            IF NOT cl_null(g_apaf_d[l_ac].apaf012) THEN
               IF NOT s_anmi120_nmll002_chk(g_apaf_d[l_ac].apaf012,g_user) THEN
                  LET g_apaf_d[l_ac].lc_apaf012 = "********"
                  DISPLAY BY NAME g_apaf_d[l_ac].lc_apaf012
                  LET g_apaf_d[l_ac].l_apaf012_desc = "********"   #160819-00049#1
                  DISPLAY BY NAME g_apaf_d[l_ac].l_apaf012_desc    #160819-00049#1
               END IF
            END IF
            #160805-00031#1--e                
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf011) THEN
               #取來源組織的所屬法人
               CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
               ##取單據別參照表號
               #SELECT glaa024 INTO l_glaa024
               #  FROM ooef_t,glaa_t
               # WHERE ooefent = glaaent AND ooefent = g_enterprise
               #    AND ooef001 = l_comp
               #    AND ooef017 = glaacomp AND glaa008 = 'Y'
               #    AND ooefstus = 'Y'     AND glaastus= 'Y'
               CALL s_ld_sel_glaa(l_ld,'glaa024') RETURNING g_sub_success,l_glaa024
            END IF
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
            INITIALIZE g_apaf_d_t.* TO NULL
            INITIALIZE g_apaf_d_o.* TO NULL
            INITIALIZE g_apaf_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apaf2_d[l_ac].apafownid = g_user
      LET g_apaf2_d[l_ac].apafowndp = g_dept
      LET g_apaf2_d[l_ac].apafcrtid = g_user
      LET g_apaf2_d[l_ac].apafcrtdp = g_dept 
      LET g_apaf2_d[l_ac].apafcrtdt = cl_get_current()
      LET g_apaf2_d[l_ac].apafmodid = g_user
      LET g_apaf2_d[l_ac].apafmoddt = cl_get_current()
      LET g_apaf_d[l_ac].apafstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_apaf_d[l_ac].apaf001 = "1"
      LET g_apaf_d[l_ac].apafstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_apaf_d_t.* = g_apaf_d[l_ac].*     #新輸入資料
            LET g_apaf_d_o.* = g_apaf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apaf_d[li_reproduce_target].* = g_apaf_d[li_reproduce].*
               LET g_apaf2_d[li_reproduce_target].* = g_apaf2_d[li_reproduce].*
 
               LET g_apaf_d[g_apaf_d.getLength()].apaf001 = NULL
               LET g_apaf_d[g_apaf_d.getLength()].apaf011 = NULL
 
            END IF
            
 
 
            CALL aapi060_set_entry_b(l_cmd)
            CALL aapi060_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM apaf_t 
             WHERE apafent = g_enterprise AND apaf001 = g_apaf_d[l_ac].apaf001
                                       AND apaf011 = g_apaf_d[l_ac].apaf011
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apaf_d[g_detail_idx].apaf001
               LET gs_keys[2] = g_apaf_d[g_detail_idx].apaf011
               CALL aapi060_insert_b('apaf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apaf_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "apaf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapi060_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (apaf001 = '", g_apaf_d[l_ac].apaf001, "' "
                                  ," AND apaf011 = '", g_apaf_d[l_ac].apaf011, "' "
 
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
               
               #end add-point   
               
               DELETE FROM apaf_t
                WHERE apafent = g_enterprise AND 
                      apaf001 = g_apaf_d_t.apaf001
                      AND apaf011 = g_apaf_d_t.apaf011
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apaf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapi060_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_apaf_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aapi060_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_apaf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apaf_d_t.apaf001
               LET gs_keys[2] = g_apaf_d_t.apaf011
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapi060_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aapi060_delete_b('apaf_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_apaf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf001
            #add-point:BEFORE FIELD apaf001 name="input.b.page1.apaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf001
            
            #add-point:AFTER FIELD apaf001 name="input.a.page1.apaf001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apaf_d[g_detail_idx].apaf001 IS NOT NULL AND g_apaf_d[g_detail_idx].apaf011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf001 != g_apaf_d_t.apaf001 OR g_apaf_d[g_detail_idx].apaf011 != g_apaf_d_t.apaf011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apaf_t WHERE "||"apafent = '" ||g_enterprise|| "' AND "||"apaf001 = '"||g_apaf_d[g_detail_idx].apaf001 ||"' AND "|| "apaf011 = '"||g_apaf_d[g_detail_idx].apaf011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf001
            #add-point:ON CHANGE apaf001 name="input.g.page1.apaf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf011
            
            #add-point:AFTER FIELD apaf011 name="input.a.page1.apaf011"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_apaf_d[g_detail_idx].apaf001 IS NOT NULL AND g_apaf_d[g_detail_idx].apaf011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf001 != g_apaf_d_t.apaf001 OR g_apaf_d[g_detail_idx].apaf011 != g_apaf_d_t.apaf011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apaf_t WHERE "||"apafent = '" ||g_enterprise|| "' AND "||"apaf001 = '"||g_apaf_d[g_detail_idx].apaf001 ||"' AND "|| "apaf011 = '"||g_apaf_d[g_detail_idx].apaf011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_azzi800_sons_query(today)
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apaf_d[g_detail_idx].apaf011
                  #IF NOT cl_chk_exist("v_ooef001_1") THEN   #161006-00005#18   mark
                  IF NOT cl_chk_exist("v_ooef001_13") THEN      #161006-00005#18   add
                     LET g_apaf_d[g_detail_idx].apaf011 = g_apaf_d_t.apaf011
                     NEXT FIELD CURRENT
                  END IF
                  #取來源組織的所屬法人
                  CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
                  #取單據別參照表號
                  #SELECT glaa024 INTO l_glaa024
                  #  FROM ooef_t,glaa_t
                  # WHERE ooefent = glaaent AND ooefent = g_enterprise
                  #    AND ooef001 = l_comp
                  #    AND ooef017 = glaacomp AND glaa008 = 'Y'
                  #    AND ooefstus = 'Y'     AND glaastus= 'Y'
                  CALL s_ld_sel_glaa(l_ld,'glaa024') RETURNING g_sub_success,l_glaa024
               END IF
            END IF
            CALL s_desc_get_department_desc(g_apaf_d[g_detail_idx].apaf011) RETURNING g_apaf_d[g_detail_idx].l_apaf011_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf011_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf011
            #add-point:BEFORE FIELD apaf011 name="input.b.page1.apaf011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf011
            #add-point:ON CHANGE apaf011 name="input.g.page1.apaf011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf012
            
            #add-point:AFTER FIELD apaf012 name="input.a.page1.apaf012"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf012) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf012 != g_apaf_d_t.apaf012 OR cl_null(g_apaf_d[g_detail_idx].apaf012))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apaf_d[g_detail_idx].apaf012 #交易帳戶編碼
                  LET g_chkparam.arg2 = g_apaf_d[g_detail_idx].apaf011 #法人
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmas002_1") THEN
                     LET g_apaf_d[g_detail_idx].apaf012 = g_apaf_d_t.apaf012
                     NEXT FIELD apaf012
                  END IF
                  #160122-00001#14--add---str
                  IF NOT s_anmi120_nmll002_chk(g_apaf_d[g_detail_idx].apaf012,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apaf_d[g_detail_idx].apaf012
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_apaf_d[g_detail_idx].apaf012 = g_apaf_d_t.apaf012
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#14--add---end
                  #160329-00018#1--(S)
                  CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
                  LET l_sql = " SELECT count(1) ",
                              "   FROM nmas_t,nmaa_t ",
                              "  WHERE nmaaent = ",g_enterprise," AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmaaent=nmabent AND nmab002 = '0') ",
                              "    AND nmasent = nmaaent AND nmas001 = nmaa001 AND nmaa002 IN ('",l_comp,"','",g_apaf_d[g_detail_idx].apaf011,"')",
                              "    AND nmas002 IN (",g_sql_bank,")" 
                  PREPARE chk_apaf012 FROM l_sql
                  EXECUTE chk_apaf012 INTO l_cnt
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apaf_d[g_detail_idx].apaf012
                     LET g_errparam.code   = 'ade-00010' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_apaf_d[g_detail_idx].apaf012 = g_apaf_d_t.apaf012
                     NEXT FIELD apaf012
                  END IF
                  #160329-00018#1--(E)                                   
               END IF
            END IF
            CALL s_desc_get_nmas002_desc(g_apaf_d[l_ac].apaf012) RETURNING g_apaf_d[l_ac].l_apaf012_desc
            #160819-00049#1--s
            IF NOT s_anmi120_nmll002_chk(g_apaf_d[l_ac].apaf012,g_user) THEN
               LET g_apaf_d[l_ac].l_apaf012_desc = "********"  
            END IF            
            #160819-00049#1--e
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf012_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf012
            #add-point:BEFORE FIELD apaf012 name="input.b.page1.apaf012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf012
            #add-point:ON CHANGE apaf012 name="input.g.page1.apaf012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_apaf012
            #add-point:BEFORE FIELD lc_apaf012 name="input.b.page1.lc_apaf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_apaf012
            
            #add-point:AFTER FIELD lc_apaf012 name="input.a.page1.lc_apaf012"
            #160805-00031#1--s
            IF NOT cl_null(g_apaf_d[g_detail_idx].lc_apaf012) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].lc_apaf012 != g_apaf_d_t.lc_apaf012 OR cl_null(g_apaf_d[g_detail_idx].lc_apaf012))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apaf_d[g_detail_idx].lc_apaf012 #交易帳戶編碼
                  LET g_chkparam.arg2 = g_apaf_d[g_detail_idx].apaf011 #法人
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  IF NOT cl_chk_exist("v_nmas002_1") THEN
                     LET g_apaf_d[g_detail_idx].lc_apaf012 = g_apaf_d_t.lc_apaf012
                     NEXT FIELD apaf012
                  END IF
                  IF NOT s_anmi120_nmll002_chk(g_apaf_d[g_detail_idx].lc_apaf012,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apaf_d[g_detail_idx].lc_apaf012
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_apaf_d[g_detail_idx].lc_apaf012 = g_apaf_d_t.lc_apaf012
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
                  LET l_sql = " SELECT count(1) ",
                              "   FROM nmas_t,nmaa_t ",
                              "  WHERE nmaaent = ",g_enterprise," AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmaaent=nmabent AND nmab002 = '0') ",
                              "    AND nmasent = nmaaent AND nmas001 = nmaa001 AND nmaa002 IN ('",l_comp,"','",g_apaf_d[g_detail_idx].apaf011,"')",
                              "    AND nmas002 IN (",g_sql_bank,")" 
                  PREPARE chk_apaf0121 FROM l_sql
                  EXECUTE chk_apaf0121 INTO l_cnt
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apaf_d[g_detail_idx].lc_apaf012
                     LET g_errparam.code   = 'ade-00010' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_apaf_d[g_detail_idx].lc_apaf012 = g_apaf_d_t.lc_apaf012
                     NEXT FIELD apaf012
                  END IF     
                  LET g_apaf_d[g_detail_idx].apaf012 = g_apaf_d[g_detail_idx].lc_apaf012
               END IF
            END IF
            CALL s_desc_get_nmas002_desc(g_apaf_d[l_ac].lc_apaf012) RETURNING g_apaf_d[l_ac].l_apaf012_desc
            #160819-00049#1--s
            IF NOT s_anmi120_nmll002_chk(g_apaf_d[l_ac].apaf012,g_user) THEN
               LET g_apaf_d[l_ac].l_apaf012_desc = "********"  
            END IF            
            #160819-00049#1--e            
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf012_desc            
            #160805-00031#1--e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lc_apaf012
            #add-point:ON CHANGE lc_apaf012 name="input.g.page1.lc_apaf012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf013
            
            #add-point:AFTER FIELD apaf013 name="input.a.page1.apaf013"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf013) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf013 != g_apaf_d_t.apaf013 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf013))) THEN
                  CASE g_apaf_d[g_detail_idx].apaf001
                     WHEN "1"
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = l_glaa024
                        LET g_chkparam.arg2 = g_apaf_d[g_detail_idx].apaf013
                        IF NOT cl_chk_exist("v_ooba002") THEN
                           LET g_apaf_d[g_detail_idx].apaf013 = g_apaf_d_t.apaf013
                           NEXT FIELD CURRENT
                        END IF
                     WHEN "2"
#CALL s_fin_slip_chk(g_apaf_d[g_detail_idx].apaf014,'aapt300',l_ld,'D-FIN-3001') RETURNING g_sub_success,g_errno   #albireo 160818 mark
                        CALL s_fin_slip_chk(g_apaf_d[g_detail_idx].apaf013,'aapt420',l_ld,'D-FIN-3001') RETURNING g_sub_success,g_errno   #albireo 160818   #160818-00035#1
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apaf_d[g_detail_idx].apaf013 = g_apaf_d_t.apaf013
                           NEXT FIELD CURRENT
                        END IF
                        #SELECT COUNT (*) INTO l_cnt
                        #  FROM ooac_t, glaa_t
                        # WHERE glaaent = g_enterprise AND glaald = l_ld
                        #   AND ooac001 = glaa024      AND ooacent= glaaent
                        #   AND ooac002 = g_apaf_d[g_detail_idx].apaf013
                        #   AND ooac003 = 'D-FIN-3006' AND ooac004 IN ('40')
                        #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        #IF l_cnt = 0 THEN
                        #   INITIALIZE g_errparam TO NULL
                        #   LET g_errparam.code = 'aap-00027'
                        #   LET g_errparam.extend = ''
                        #   LET g_errparam.popup = TRUE
                        #   CALL cl_err()
                        #   LET g_apaf_d[g_detail_idx].apaf013 = g_apaf_d_t.apaf013
                        #   NEXT FIELD CURRENT
                        #END IF
                  END CASE
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_apaf_d[l_ac].apaf013) RETURNING g_apaf_d[l_ac].l_apaf013_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf013_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf013
            #add-point:BEFORE FIELD apaf013 name="input.b.page1.apaf013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf013
            #add-point:ON CHANGE apaf013 name="input.g.page1.apaf013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf014
            
            #add-point:AFTER FIELD apaf014 name="input.a.page1.apaf014"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf014) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf014 != g_apaf_d_t.apaf014 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf014))) THEN
                   CASE g_apaf_d[g_detail_idx].apaf001
                      WHEN "1"
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = l_glaa024
                        LET g_chkparam.arg2 = g_apaf_d[g_detail_idx].apaf014
                        IF NOT cl_chk_exist("v_oobx001_1") THEN
                           LET g_apaf_d[g_detail_idx].apaf014 = g_apaf_d_t.apaf014
                           NEXT FIELD CURRENT
                        END IF
                     WHEN "2"
                        #CALL s_fin_slip_chk(g_apaf_d[g_detail_idx].apaf014,'aapt300',l_ld,'D-FIN-3001') RETURNING g_sub_success,g_errno   #160818-00035#1 mark
                        CALL s_fin_slip_chk(g_apaf_d[g_detail_idx].apaf014,'aapt301',l_ld,'D-FIN-3001') RETURNING g_sub_success,g_errno   #160818-00035#1
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apaf_d[g_detail_idx].apaf014 = g_apaf_d_t.apaf014
                           NEXT FIELD CURRENT
                        END IF
                        #SELECT COUNT (*) INTO l_cnt
                        #  FROM ooac_t, glaa_t
                        # WHERE glaaent = g_enterprise AND glaald = l_ld
                        #   AND ooac001 = glaa024      AND ooacent = glaaent
                        #   AND ooac002 = g_apaf_d[g_detail_idx].apaf014
                        #   AND ooac003 = 'D-FIN-3001' AND ooac004 IN ('19')
                        #   AND EXISTS (SELECT 1 FROM ooac_t WHERE ooac002=g_apaf_d[g_detail_idx].apaf014 AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N')
                        #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        #IF l_cnt = 0 THEN
                        #   INITIALIZE g_errparam TO NULL
                        #   LET g_errparam.code = 'aap-00027'
                        #   LET g_errparam.extend = ''
                        #   LET g_errparam.popup = TRUE
                        #   CALL cl_err()
                        #   LET g_apaf_d[g_detail_idx].apaf014 = g_apaf_d_t.apaf014
                        #   NEXT FIELD CURRENT
                        #END IF
                  END CASE
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_apaf_d[l_ac].apaf014) RETURNING g_apaf_d[l_ac].l_apaf014_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf014_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf014
            #add-point:BEFORE FIELD apaf014 name="input.b.page1.apaf014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf014
            #add-point:ON CHANGE apaf014 name="input.g.page1.apaf014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf021
            
            #add-point:AFTER FIELD apaf021 name="input.a.page1.apaf021"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf021) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf021 != g_apaf_d_t.apaf021 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf021))) THEN
                  CASE g_apaf_d[g_detail_idx].apaf001
                     WHEN "1"
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = l_glaa024
                        LET g_chkparam.arg2 = g_apaf_d[g_detail_idx].apaf021
                        IF NOT cl_chk_exist("v_oobx001_1") THEN
                           LET g_apaf_d[g_detail_idx].apaf021 = g_apaf_d_t.apaf021
                           NEXT FIELD CURRENT
                        END IF
                     WHEN "2"
                        #150128-00005#18 mark
                        #CALL s_fin_slip_chk(g_apaf_d[g_detail_idx].apaf021,'aapt320',l_ld,'D-FIN-3001') RETURNING g_sub_success,g_errno
                        #150128-00005#18 add
                        CALL s_fin_slip_chk(g_apaf_d[g_detail_idx].apaf021,'aapq343',l_ld,'D-FIN-3001') RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apaf_d[g_detail_idx].apaf021 = g_apaf_d_t.apaf021
                           NEXT FIELD CURRENT
                        END IF
                        #SELECT COUNT (*) INTO l_cnt
                        #  FROM ooac_t, glaa_t
                        # WHERE glaaent = g_enterprise AND glaald = l_ld 
                        #   AND ooac001 = glaa024      AND ooacent = glaaent
                        #   AND ooac002 = g_apaf_d[g_detail_idx].apaf021
                        #   AND ooac003 = 'D-FIN-3001' AND ooac004 IN ('22')
                        #   AND EXISTS (SELECT 1 FROM ooac_t WHERE ooac002=g_apaf_d[g_detail_idx].apaf021 AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N')
                        #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        #IF l_cnt = 0 THEN
                        #   INITIALIZE g_errparam TO NULL
                        #   LET g_errparam.code = 'aap-00027'
                        #   LET g_errparam.extend = ''
                        #   LET g_errparam.popup = TRUE
                        #   CALL cl_err()
                        #   LET g_apaf_d[g_detail_idx].apaf021 = g_apaf_d_t.apaf021
                        #   NEXT FIELD CURRENT
                        #END IF
                  END CASE
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_apaf_d[l_ac].apaf021) RETURNING g_apaf_d[l_ac].l_apaf021_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf021_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf021
            #add-point:BEFORE FIELD apaf021 name="input.b.page1.apaf021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf021
            #add-point:ON CHANGE apaf021 name="input.g.page1.apaf021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf017
            
            #add-point:AFTER FIELD apaf017 name="input.a.page1.apaf017"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf017) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf017 != g_apaf_d_t.apaf017 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf017))) THEN
                  CASE g_apaf_d[g_detail_idx].apaf001
                     WHEN "1"
                        LET l_num = '3111'
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_apaf_d[g_detail_idx].apaf017
                        #160318-00025#25  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aoo-00200:sub-01302|axri012|",cl_get_progname("axri012",g_lang,"2"),"|:EXEPROGaxri012"
                        #160318-00025#25  by 07900 --add-end
                        IF NOT cl_chk_exist("v_oocq002_3111") THEN
                           LET g_apaf_d[g_detail_idx].apaf017 = g_apaf_d_t.apaf017
                           NEXT FIELD CURRENT
                        END IF
                     WHEN "2"
                        LET l_num = '3211'
                        IF NOT s_azzi650_chk_exist('3211',g_apaf_d[g_detail_idx].apaf017) THEN
                           LET g_apaf_d[g_detail_idx].apaf017 = g_apaf_d_t.apaf017
                           NEXT FIELD CURRENT
                        END IF
                  END CASE
               END IF
            END IF
            CALL s_desc_get_acc_desc(l_num,g_apaf_d[l_ac].apaf017) RETURNING g_apaf_d[l_ac].l_apaf017_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf017_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf017
            #add-point:BEFORE FIELD apaf017 name="input.b.page1.apaf017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf017
            #add-point:ON CHANGE apaf017 name="input.g.page1.apaf017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf018
            
            #add-point:AFTER FIELD apaf018 name="input.a.page1.apaf018"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf018) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf018 != g_apaf_d_t.apaf018 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf018))) THEN
                  CASE g_apaf_d[g_detail_idx].apaf001
                     WHEN "1"
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_apaf_d[g_detail_idx].apaf018
                        LET g_chkparam.arg2 = ' '
                        #160318-00025#25  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="apm-00184:sub-01302|aooi714|",cl_get_progname("aooi714",g_lang,"2"),"|:EXEPROGaooi714"
                        #160318-00025#25  by 07900 --add-end
                        IF NOT cl_chk_exist("v_ooib002_1") THEN
                           LET g_apaf_d[g_detail_idx].apaf018 = g_apaf_d_t.apaf018
                           NEXT FIELD CURRENT
                        END IF
                     WHEN "2"
                        CALL s_aap_ooib002_chk(g_apaf_d[g_detail_idx].apaf018,'1')RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           #160321-00016#19 --s add
                           LET g_errparam.replace[1] = 'aooi716'
                           LET g_errparam.replace[2] = cl_get_progname('aooi716',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi716'
                           #160321-00016#19 --e add
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apaf_d[g_detail_idx].apaf018 = g_apaf_d_t.apaf018
                           NEXT FIELD CURRENT
                        END IF
                  END CASE
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_apaf_d[l_ac].apaf018) RETURNING g_apaf_d[l_ac].l_apaf018_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].l_apaf018_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf018
            #add-point:BEFORE FIELD apaf018 name="input.b.page1.apaf018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf018
            #add-point:ON CHANGE apaf018 name="input.g.page1.apaf018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf019
            
            #add-point:AFTER FIELD apaf019 name="input.a.page1.apaf019"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf019) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf019 != g_apaf_d_t.apaf019 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf019))) THEN
                  #取來源組織的所屬法人
                  CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
                  CALL s_aap_tax_for_noevidence(l_comp,g_apaf_d[g_detail_idx].apaf019) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apaf_d[g_detail_idx].apaf019 = g_apaf_d_t.apaf019
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_tax_desc(g_ooef019,g_apaf_d[l_ac].apaf019) RETURNING g_apaf_d[l_ac].l_apaf019_desc
            DISPLAY BY NAME g_apaf_d[l_ac].l_apaf019_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf019
            #add-point:BEFORE FIELD apaf019 name="input.b.page1.apaf019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf019
            #add-point:ON CHANGE apaf019 name="input.g.page1.apaf019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf020
            
            #add-point:AFTER FIELD apaf020 name="input.a.page1.apaf020"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf020) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf020 != g_apaf_d_t.apaf020 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf020))) THEN
                  IF NOT s_azzi650_chk_exist('3113',g_apaf_d[g_detail_idx].apaf020) THEN
                     LET g_apaf_d[g_detail_idx].apaf020 = g_apaf_d_t.apaf020
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_desc_get_acc_desc('3113',g_apaf_d[g_detail_idx].apaf020) RETURNING g_apaf_d[l_ac].l_apaf020_desc
                  DISPLAY BY NAME g_apaf_d[l_ac].l_apaf020_desc
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf020
            #add-point:BEFORE FIELD apaf020 name="input.b.page1.apaf020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf020
            #add-point:ON CHANGE apaf020 name="input.g.page1.apaf020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf015
            
            #add-point:AFTER FIELD apaf015 name="input.a.page1.apaf015"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf015) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf015 != g_apaf_d_t.apaf015 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf015))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apaf_d[g_detail_idx].apaf015
                  LET g_chkparam.arg2 = g_apaf_d[g_detail_idx].apaf001
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     LET g_apaf_d[g_detail_idx].apaf015 = g_apaf_d_t.apaf015
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_nmajl003_desc(g_apaf_d[l_ac].apaf015) RETURNING g_apaf_d[l_ac].l_apaf015_desc
            DISPLAY BY NAME g_apaf_d[l_ac].l_apaf015_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf015
            #add-point:BEFORE FIELD apaf015 name="input.b.page1.apaf015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf015
            #add-point:ON CHANGE apaf015 name="input.g.page1.apaf015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apaf016
            
            #add-point:AFTER FIELD apaf016 name="input.a.page1.apaf016"
            IF NOT cl_null(g_apaf_d[g_detail_idx].apaf016) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apaf_d[g_detail_idx].apaf016 != g_apaf_d_t.apaf016 OR NOT cl_null(g_apaf_d[g_detail_idx].apaf016))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apaf_d[g_detail_idx].apaf016
                  LET g_chkparam.arg2 = l_glaa005
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     LET g_apaf_d[g_detail_idx].apaf016 = g_apaf_d_t.apaf016                    
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #取來源組織的帳別
            CALL s_fin_orga_get_comp_ld(g_apaf_d[l_ac].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
            #取現金變動參照表號
            CALL s_ld_sel_glaa(l_ld,'glaa005') RETURNING  g_sub_success,l_glaa005
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"'"
            CALL s_desc_get_nmail004_desc(l_glaa005,g_apaf_d[l_ac].apaf016) RETURNING g_apaf_d[l_ac].l_apaf016_desc
            DISPLAY BY NAME g_apaf_d[l_ac].l_apaf016_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apaf016
            #add-point:BEFORE FIELD apaf016 name="input.b.page1.apaf016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apaf016
            #add-point:ON CHANGE apaf016 name="input.g.page1.apaf016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apafstus
            #add-point:BEFORE FIELD apafstus name="input.b.page1.apafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apafstus
            
            #add-point:AFTER FIELD apafstus name="input.a.page1.apafstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apafstus
            #add-point:ON CHANGE apafstus name="input.g.page1.apafstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf001
            #add-point:ON ACTION controlp INFIELD apaf001 name="input.c.page1.apaf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf011
            #add-point:ON ACTION controlp INFIELD apaf011 name="input.c.page1.apaf011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef201 = 'Y' AND ooef003 = 'Y' " #為營運據點且為法人  #160812-00027#5 mark
            LET l_comp = ''
            SELECT ooef017 INTO l_comp FROM ooef_t 
             WHERE ooefent = g_enterprise AND ooef001 = g_site
            #LET g_qryparam.where = " ooef001 IN ",g_wc_apaf011 CLIPPED," AND ooef017 ='",l_comp,"' "  #160812-00027#5 add   #161006-00005#18  mark
            LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga CLIPPED," AND ooef201 = 'Y'"     #161006-00005#18  add
            LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf011
            CALL q_ooef001()
            LET g_apaf_d[g_detail_idx].apaf011 = g_qryparam.return1
            CALL s_desc_get_department_desc(g_apaf_d[g_detail_idx].apaf011) RETURNING g_apaf_d[g_detail_idx].l_apaf011_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf011,g_apaf_d[g_detail_idx].l_apaf011_desc
            NEXT FIELD apaf011
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf012
            #add-point:ON ACTION controlp INFIELD apaf012 name="input.c.page1.apaf012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf012
            #取來源組織的所屬法人
            CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
            #加入帳務來源組織的所屬法人+帳務來源組織的條件
            #160122-00001#16--mod---str
           #LET g_qryparam.where = " nmaa002 IN ('",l_comp,"','",g_apaf_d[g_detail_idx].apaf011,"') "
            
            LET g_qryparam.where = " nmaa002 IN ('",l_comp,"','",g_apaf_d[g_detail_idx].apaf011,"') ",
#                                   " AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
                                    " AND nmas002 IN (",g_sql_bank,")" #160122-00001#16 mod by 07675
            #160122-00001#16--mod---end
            CALL q_nmas002_6()
            LET g_apaf_d[g_detail_idx].apaf012 = g_qryparam.return1
            LET g_apaf_d[g_detail_idx].l_apaf012_desc = g_qryparam.return2
            DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf012,g_apaf_d[g_detail_idx].l_apaf012_desc
            LET g_qryparam.where = " "             #160122-00001#16
            NEXT FIELD apaf012
            #END add-point
 
 
         #Ctrlp:input.c.page1.lc_apaf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_apaf012
            #add-point:ON ACTION controlp INFIELD lc_apaf012 name="input.c.page1.lc_apaf012"
            #160805-00031#1--s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apaf_d[g_detail_idx].lc_apaf012
            #取來源組織的所屬法人
            CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
            #加入帳務來源組織的所屬法人+帳務來源組織的條件           
            LET g_qryparam.where = " nmaa002 IN ('",l_comp,"','",g_apaf_d[g_detail_idx].apaf011,"') ",
                                    " AND nmas002 IN (",g_sql_bank,")" 
            CALL q_nmas002_6()
            LET g_apaf_d[g_detail_idx].lc_apaf012 = g_qryparam.return1
            LET g_apaf_d[g_detail_idx].l_apaf012_desc = g_qryparam.return2
            DISPLAY BY NAME g_apaf_d[g_detail_idx].lc_apaf012,g_apaf_d[g_detail_idx].l_apaf012_desc
            LET g_qryparam.where = " "             
            NEXT FIELD lc_apaf012            
            #160805-00031#1--e            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf013
            #add-point:ON ACTION controlp INFIELD apaf013 name="input.c.page1.apaf013"
            CASE g_apaf_d[g_detail_idx].apaf001
               WHEN "1"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf013
                  LET g_qryparam.arg1 = l_glaa024
                  LET g_qryparam.arg2 = "axrt400"
                  CALL q_ooba002_1()
                  LET g_apaf_d[g_detail_idx].apaf013 = g_qryparam.return1
                  CALL s_aooi200_fin_get_slip_desc(g_apaf_d[g_detail_idx].apaf013) RETURNING g_apaf_d[g_detail_idx].l_apaf013_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf013 , g_apaf_d[g_detail_idx].l_apaf013_desc
                  NEXT FIELD apaf013
               WHEN "2"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf013
                  #LET g_qryparam.arg1  = l_comp
                  #LET g_qryparam.arg2  = 'D-FIN-3006'
                  #LET g_qryparam.where = " ooac004 IN('40') "
                  #CALL q_oobx001_1()
                  LET g_qryparam.arg1 = l_glaa024
                  LET g_qryparam.arg2 = "aapt420"
                  CALL q_ooba002_1()
                  LET g_apaf_d[g_detail_idx].apaf013 = g_qryparam.return1
                  CALL s_aooi200_fin_get_slip_desc(g_apaf_d[g_detail_idx].apaf013) RETURNING g_apaf_d[g_detail_idx].l_apaf013_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf013 , g_apaf_d[g_detail_idx].l_apaf013_desc
                  NEXT FIELD apaf013
            END CASE
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf014
            #add-point:ON ACTION controlp INFIELD apaf014 name="input.c.page1.apaf014"
            CASE g_apaf_d[g_detail_idx].apaf001
               WHEN "1"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf014
                  LET g_qryparam.arg1 = l_glaa024
                  LET g_qryparam.arg2 = "axrt330"
                  CALL q_ooba002_1()
                  LET g_apaf_d[g_detail_idx].apaf014 = g_qryparam.return1
                  CALL s_aooi200_fin_get_slip_desc(g_apaf_d[g_detail_idx].apaf014) RETURNING g_apaf_d[g_detail_idx].l_apaf014_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf014,g_apaf_d[g_detail_idx].l_apaf014_desc
                  NEXT FIELD apaf014
               WHEN "2"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf014
                  #LET g_qryparam.arg1 = l_comp
                  #LET g_qryparam.arg2 = 'D-FIN-3001'
                  #LET g_qryparam.where = " ooac004 IN('19') AND EXISTS (SELECT 1 FROM ooac_t WHERE ooac002='",g_apaf_d[g_detail_idx].apaf014,"' AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "
                  #CALL q_oobx001_1()
                  LET g_qryparam.arg1 = l_glaa024
                  #LET g_qryparam.arg2 = "aapt300"  #160818-00035#1 mark
                  LET g_qryparam.arg2 = "aapt301"   #160818-00035#1
                  CALL q_ooba002_1()
                  LET g_apaf_d[g_detail_idx].apaf014 = g_qryparam.return1
                  CALL s_aooi200_fin_get_slip_desc(g_apaf_d[g_detail_idx].apaf014) RETURNING g_apaf_d[g_detail_idx].l_apaf014_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf014,g_apaf_d[g_detail_idx].l_apaf014_desc
                  NEXT FIELD apaf014
            END CASE
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf021
            #add-point:ON ACTION controlp INFIELD apaf021 name="input.c.page1.apaf021"
            CASE g_apaf_d[g_detail_idx].apaf001
               WHEN "1"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf021
                  LET g_qryparam.arg1 = l_glaa024
                  #LET g_qryparam.arg2 = "axrt340"   #150128-00005#18 mark
                  LET g_qryparam.arg2 = "axrq343" #150128-00005#18
                  CALL q_ooba002_1()
                  LET g_apaf_d[g_detail_idx].apaf021 = g_qryparam.return1
                  CALL s_aooi200_fin_get_slip_desc(g_apaf_d[g_detail_idx].apaf021) RETURNING g_apaf_d[g_detail_idx].l_apaf021_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf021,g_apaf_d[g_detail_idx].l_apaf021_desc
                  NEXT FIELD apaf021
               WHEN "2"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf021
                  #LET g_qryparam.arg1  = l_comp
                  #LET g_qryparam.arg2  = 'D-FIN-3001'
                  #LET g_qryparam.where = " ooac004 IN('22') AND EXISTS (SELECT 1 FROM ooac_t WHERE ooac002='",g_apaf_d[g_detail_idx].apaf021,"' AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "
                  #CALL q_oobx001_1()
                  LET g_qryparam.arg1 = l_glaa024
                  #LET g_qryparam.arg2 = "aapt340" #150128-00005#18 mark
                  LET g_qryparam.arg2 = "aapq343" #150128-00005#18
                  CALL q_ooba002_1()
                  LET g_apaf_d[g_detail_idx].apaf021 = g_qryparam.return1
                  CALL s_aooi200_fin_get_slip_desc(g_apaf_d[g_detail_idx].apaf021) RETURNING g_apaf_d[g_detail_idx].l_apaf021_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf021,g_apaf_d[g_detail_idx].l_apaf021_desc
                  NEXT FIELD apaf021
            END CASE
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf017
            #add-point:ON ACTION controlp INFIELD apaf017 name="input.c.page1.apaf017"
            CASE g_apaf_d[g_detail_idx].apaf001
               WHEN "1"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf017
                  LET g_qryparam.arg1 = "3111"
                  CALL q_oocq002()
                  LET g_apaf_d[g_detail_idx].apaf017 = g_qryparam.return1
                  CALL s_desc_get_acc_desc('3111',g_apaf_d[g_detail_idx].apaf017) RETURNING g_apaf_d[g_detail_idx].l_apaf017_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf017,g_apaf_d[g_detail_idx].l_apaf017_desc
                  NEXT FIELD apaf017
               WHEN "2"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf017
                  LET g_qryparam.arg1 = "3211"
                  CALL q_oocq002()
                  LET g_apaf_d[g_detail_idx].apaf017 = g_qryparam.return1
                  CALL s_desc_get_acc_desc('3211',g_apaf_d[g_detail_idx].apaf017) RETURNING g_apaf_d[g_detail_idx].l_apaf017_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf017,g_apaf_d[g_detail_idx].l_apaf017_desc
                  NEXT FIELD apaf017
            END CASE
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf018
            #add-point:ON ACTION controlp INFIELD apaf018 name="input.c.page1.apaf018"
            CASE g_apaf_d[g_detail_idx].apaf001
               WHEN "1"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf018
                  CALL q_ooib001_1()
                  LET g_apaf_d[g_detail_idx].apaf018 = g_qryparam.return1
                  CALL s_desc_get_ooib002_desc(g_apaf_d[g_detail_idx].apaf018) RETURNING g_apaf_d[g_detail_idx].l_apaf018_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf018,g_apaf_d[g_detail_idx].l_apaf018_desc
                  NEXT FIELD apaf018
               WHEN "2"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf018
                  CALL q_ooib001_2()
                  LET g_apaf_d[g_detail_idx].apaf018 = g_qryparam.return1
                  CALL s_desc_get_ooib002_desc(g_apaf_d[g_detail_idx].apaf018) RETURNING g_apaf_d[g_detail_idx].l_apaf018_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf018,g_apaf_d[g_detail_idx].l_apaf018_desc
                  NEXT FIELD apaf018
            END CASE
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf019
            #add-point:ON ACTION controlp INFIELD apaf019 name="input.c.page1.apaf019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf019
            #取來源組織的所屬法人
            CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
            SELECT ooef019 INTO g_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise
              AND ooef001 = l_comp
            LET g_qryparam.arg1 = g_ooef019         #稅區
            LET g_qryparam.where = " oodb008 ='2' " #課稅別=1:零稅
            CALL q_oodb002_5()
            LET g_apaf_d[g_detail_idx].apaf019 = g_qryparam.return1
            CALL s_desc_get_tax_desc(g_ooef019,g_apaf_d[g_detail_idx].apaf019) RETURNING g_apaf_d[g_detail_idx].l_apaf019_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf019 , g_apaf_d[g_detail_idx].l_apaf019_desc
            NEXT FIELD apaf019
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf020
            #add-point:ON ACTION controlp INFIELD apaf020 name="input.c.page1.apaf020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf020
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()
            LET g_apaf_d[g_detail_idx].apaf020 = g_qryparam.return1
            CALL s_desc_get_acc_desc('3113',g_apaf_d[g_detail_idx].apaf020) RETURNING g_apaf_d[g_detail_idx].l_apaf020_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf020,g_apaf_d[g_detail_idx].l_apaf020_desc
            NEXT FIELD apaf020
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf015
            #add-point:ON ACTION controlp INFIELD apaf015 name="input.c.page1.apaf015"
            CASE g_apaf_d[g_detail_idx].apaf001
               WHEN "1"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf015
                  LET g_qryparam.where = " nmaj002 = '1' "
                  CALL q_nmaj001() 
                  LET g_apaf_d[g_detail_idx].apaf015 = g_qryparam.return1
                  CALL s_desc_get_nmajl003_desc(g_apaf_d[g_detail_idx].apaf015) RETURNING g_apaf_d[g_detail_idx].l_apaf015_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf015,g_apaf_d[g_detail_idx].l_apaf015_desc
                  NEXT FIELD apaf015
               WHEN "2"
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf015
                  LET g_qryparam.where = " nmaj002 = '2' "
                  CALL q_nmaj001() 
                  LET g_apaf_d[g_detail_idx].apaf015 = g_qryparam.return1
                  CALL s_desc_get_nmajl003_desc(g_apaf_d[g_detail_idx].apaf015) RETURNING g_apaf_d[g_detail_idx].l_apaf015_desc
                  DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf015,g_apaf_d[g_detail_idx].l_apaf015_desc
                  NEXT FIELD apaf015
            END CASE
            #END add-point
 
 
         #Ctrlp:input.c.page1.apaf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apaf016
            #add-point:ON ACTION controlp INFIELD apaf016 name="input.c.page1.apaf016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apaf_d[g_detail_idx].apaf016
            #取來源組織的帳別
            CALL s_fin_orga_get_comp_ld(g_apaf_d[g_detail_idx].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
            #取現金變動參照表號
            CALL s_ld_sel_glaa(l_ld,'glaa005') RETURNING  g_sub_success,l_glaa005
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
            CALL q_nmai002()
            LET g_apaf_d[g_detail_idx].apaf016 = g_qryparam.return1
            CALL s_desc_get_nmail004_desc(l_glaa005,g_apaf_d[g_detail_idx].apaf016) RETURNING g_apaf_d[g_detail_idx].l_apaf016_desc
            DISPLAY BY NAME g_apaf_d[g_detail_idx].apaf016,g_apaf_d[g_detail_idx].l_apaf016_desc
            NEXT FIELD apaf016
            #END add-point
 
 
         #Ctrlp:input.c.page1.apafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apafstus
            #add-point:ON ACTION controlp INFIELD apafstus name="input.c.page1.apafstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aapi060_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_apaf_d[l_ac].* = g_apaf_d_t.*
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
               LET g_errparam.extend = g_apaf_d[l_ac].apaf001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apaf_d[l_ac].* = g_apaf_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_apaf2_d[l_ac].apafmodid = g_user 
LET g_apaf2_d[l_ac].apafmoddt = cl_get_current()
LET g_apaf2_d[l_ac].apafmodid_desc = cl_get_username(g_apaf2_d[l_ac].apafmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapi060_apaf_t_mask_restore('restore_mask_o')
 
               UPDATE apaf_t SET (apaf001,apaf011,apaf012,apaf013,apaf014,apaf021,apaf017,apaf018,apaf019, 
                   apaf020,apaf015,apaf016,apafstus,apafownid,apafowndp,apafcrtid,apafcrtdp,apafcrtdt, 
                   apafmodid,apafmoddt) = (g_apaf_d[l_ac].apaf001,g_apaf_d[l_ac].apaf011,g_apaf_d[l_ac].apaf012, 
                   g_apaf_d[l_ac].apaf013,g_apaf_d[l_ac].apaf014,g_apaf_d[l_ac].apaf021,g_apaf_d[l_ac].apaf017, 
                   g_apaf_d[l_ac].apaf018,g_apaf_d[l_ac].apaf019,g_apaf_d[l_ac].apaf020,g_apaf_d[l_ac].apaf015, 
                   g_apaf_d[l_ac].apaf016,g_apaf_d[l_ac].apafstus,g_apaf2_d[l_ac].apafownid,g_apaf2_d[l_ac].apafowndp, 
                   g_apaf2_d[l_ac].apafcrtid,g_apaf2_d[l_ac].apafcrtdp,g_apaf2_d[l_ac].apafcrtdt,g_apaf2_d[l_ac].apafmodid, 
                   g_apaf2_d[l_ac].apafmoddt)
                WHERE apafent = g_enterprise AND
                  apaf001 = g_apaf_d_t.apaf001 #項次   
                  AND apaf011 = g_apaf_d_t.apaf011  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apaf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apaf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apaf_d[g_detail_idx].apaf001
               LET gs_keys_bak[1] = g_apaf_d_t.apaf001
               LET gs_keys[2] = g_apaf_d[g_detail_idx].apaf011
               LET gs_keys_bak[2] = g_apaf_d_t.apaf011
               CALL aapi060_update_b('apaf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_apaf_d_t)
                     LET g_log2 = util.JSON.stringify(g_apaf_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapi060_apaf_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aapi060_unlock_b("apaf_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apaf_d[l_ac].* = g_apaf_d_t.*
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
               LET g_apaf_d[li_reproduce_target].* = g_apaf_d[li_reproduce].*
               LET g_apaf2_d[li_reproduce_target].* = g_apaf2_d[li_reproduce].*
 
               LET g_apaf_d[li_reproduce_target].apaf001 = NULL
               LET g_apaf_d[li_reproduce_target].apaf011 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apaf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apaf_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_apaf2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aapi060_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為 name="input.body2.action"
         
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
               NEXT FIELD apaf001
            WHEN "s_detail2"
               NEXT FIELD apaf001_2
 
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
      IF INT_FLAG OR cl_null(g_apaf_d[g_detail_idx].apaf001) THEN
         CALL g_apaf_d.deleteElement(g_detail_idx)
         CALL g_apaf2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_apaf_d[g_detail_idx].* = g_apaf_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aapi060_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aapi060.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapi060_delete()
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
 
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_apaf_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aapi060_lock_b("apaf_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("apaf_t","apafownid") THEN
            LET g_data_owner = g_apaf2_d[g_detail_idx].apafownid
            LET g_data_dept = g_apaf2_d[g_detail_idx].apafowndp
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
   
   FOR li_idx = 1 TO g_apaf_d.getLength()
      IF g_apaf_d[li_idx].apaf001 IS NOT NULL
         AND g_apaf_d[li_idx].apaf011 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM apaf_t
          WHERE apafent = g_enterprise AND 
                apaf001 = g_apaf_d[li_idx].apaf001
                AND apaf011 = g_apaf_d[li_idx].apaf011
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apaf_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_apaf_d_t.apaf001
               LET gs_keys[2] = g_apaf_d_t.apaf011
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aapi060_delete_b('apaf_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapi060_set_pk_array()
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
   CALL aapi060_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aapi060.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapi060_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE  l_comp          LIKE apca_t.apcacomp
   DEFINE  l_ld            LIKE apca_t.apcald
   DEFINE  l_glaa005       LIKE glaa_t.glaa005      #現金變動參照表
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.apaf001,t0.apaf011,t0.apaf012,t0.apaf013,t0.apaf014,t0.apaf021,t0.apaf017, 
       t0.apaf018,t0.apaf019,t0.apaf020,t0.apaf015,t0.apaf016,t0.apafstus,t0.apaf001,t0.apaf011,t0.apafownid, 
       t0.apafowndp,t0.apafcrtid,t0.apafcrtdp,t0.apafcrtdt,t0.apafmodid,t0.apafmoddt ,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM apaf_t t0",
               "",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.apafownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.apafowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apafcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.apafcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apafmodid  ",
 
               " WHERE t0.apafent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("apaf_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND apafowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("apaf_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND apafownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
#   LET g_sql = g_sql CLIPPED," AND (t0.apaf012 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') 
#                                OR t0.apaf012 IS NULL)"  #160122-00001#16
  #LET g_sql = g_sql CLIPPED," AND (t0.apaf012 IN(",g_sql_bank,") OR TRIM(t0.apaf012) IS NULL)"  #160805-00031#1 mark   #160122-00001#16 mod by 07675
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("apaf_t"),
                      " ORDER BY t0.apaf001,t0.apaf011"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"apaf_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapi060_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapi060_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apaf_d.clear()
   CALL g_apaf2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_apaf_d[l_ac].apaf001,g_apaf_d[l_ac].apaf011,g_apaf_d[l_ac].apaf012,g_apaf_d[l_ac].apaf013, 
       g_apaf_d[l_ac].apaf014,g_apaf_d[l_ac].apaf021,g_apaf_d[l_ac].apaf017,g_apaf_d[l_ac].apaf018,g_apaf_d[l_ac].apaf019, 
       g_apaf_d[l_ac].apaf020,g_apaf_d[l_ac].apaf015,g_apaf_d[l_ac].apaf016,g_apaf_d[l_ac].apafstus, 
       g_apaf2_d[l_ac].apaf001,g_apaf2_d[l_ac].apaf011,g_apaf2_d[l_ac].apafownid,g_apaf2_d[l_ac].apafowndp, 
       g_apaf2_d[l_ac].apafcrtid,g_apaf2_d[l_ac].apafcrtdp,g_apaf2_d[l_ac].apafcrtdt,g_apaf2_d[l_ac].apafmodid, 
       g_apaf2_d[l_ac].apafmoddt,g_apaf2_d[l_ac].apafownid_desc,g_apaf2_d[l_ac].apafowndp_desc,g_apaf2_d[l_ac].apafcrtid_desc, 
       g_apaf2_d[l_ac].apafcrtdp_desc,g_apaf2_d[l_ac].apafmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #160805-00031#1--s
      IF NOT s_anmi120_nmll002_chk(g_apaf_d[l_ac].apaf012,g_user) THEN
         LET g_apaf_d[l_ac].lc_apaf012 = "********"
         LET g_apaf_d[l_ac].l_apaf012_desc = "********"   #160819-00049#1
      ELSE
         LET g_apaf_d[l_ac].lc_apaf012 = g_apaf_d[l_ac].apaf012               
         CALL s_desc_get_nmas002_desc(g_apaf_d[l_ac].apaf012) RETURNING g_apaf_d[l_ac].l_apaf012_desc   #160819-00049#1 
      END IF
      DISPLAY BY NAME g_apaf_d[l_ac].lc_apaf012   
      #160805-00031#1--e      
      CALL s_desc_get_department_desc(g_apaf_d[l_ac].apaf011) RETURNING g_apaf_d[l_ac].l_apaf011_desc
     #CALL s_desc_get_nmas002_desc(g_apaf_d[l_ac].apaf012) RETURNING g_apaf_d[l_ac].l_apaf012_desc   #160819-00049#1 mark
      CALL s_aooi200_fin_get_slip_desc(g_apaf_d[l_ac].apaf013) RETURNING g_apaf_d[l_ac].l_apaf013_desc
      CALL s_aooi200_fin_get_slip_desc(g_apaf_d[l_ac].apaf014) RETURNING g_apaf_d[l_ac].l_apaf014_desc
      CALL s_aooi200_fin_get_slip_desc(g_apaf_d[l_ac].apaf021) RETURNING g_apaf_d[l_ac].l_apaf021_desc
      CALL s_desc_get_acc_desc('3211',g_apaf_d[l_ac].apaf017) RETURNING g_apaf_d[l_ac].l_apaf017_desc
      CALL s_desc_get_ooib002_desc(g_apaf_d[l_ac].apaf018) RETURNING g_apaf_d[l_ac].l_apaf018_desc
      CALL s_desc_get_tax_desc(g_ooef019,g_apaf_d[l_ac].apaf019) RETURNING g_apaf_d[l_ac].l_apaf019_desc
      CALL s_desc_get_acc_desc('3113',g_apaf_d[l_ac].apaf020) RETURNING g_apaf_d[l_ac].l_apaf020_desc
      CALL s_desc_get_nmajl003_desc(g_apaf_d[l_ac].apaf015) RETURNING g_apaf_d[l_ac].l_apaf015_desc
      #取來源組織的帳別
      CALL s_fin_orga_get_comp_ld(g_apaf_d[l_ac].apaf011) RETURNING g_sub_success,g_errno,l_comp,l_ld
      #取現金變動參照表號
      CALL s_ld_sel_glaa(l_ld,'glaa005') RETURNING  g_sub_success,l_glaa005
      LET g_qryparam.where = " nmai001 = '",l_glaa005,"'"
      CALL s_desc_get_nmail004_desc(l_glaa005,g_apaf_d[l_ac].apaf016) RETURNING g_apaf_d[l_ac].l_apaf016_desc
      
      DISPLAY BY NAME g_apaf_d[l_ac].l_apaf011_desc,g_apaf_d[l_ac].l_apaf012_desc
                     ,g_apaf_d[l_ac].l_apaf013_desc,g_apaf_d[l_ac].l_apaf014_desc
                     ,g_apaf_d[l_ac].l_apaf021_desc,g_apaf_d[l_ac].l_apaf017_desc
                     ,g_apaf_d[l_ac].l_apaf018_desc,g_apaf_d[l_ac].l_apaf019_desc
                     ,g_apaf_d[l_ac].l_apaf020_desc,g_apaf_d[l_ac].l_apaf015_desc
                     ,g_apaf_d[l_ac].l_apaf016_desc

      #end add-point
      
      CALL aapi060_detail_show()      
 
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
   
 
   
   CALL g_apaf_d.deleteElement(g_apaf_d.getLength())   
   CALL g_apaf2_d.deleteElement(g_apaf2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_apaf_d.getLength()
      LET g_apaf2_d[l_ac].apaf001 = g_apaf_d[l_ac].apaf001 
      LET g_apaf2_d[l_ac].apaf011 = g_apaf_d[l_ac].apaf011 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_apaf_d.getLength() THEN
      LET l_ac = g_apaf_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_apaf_d.getLength()
      LET g_apaf_d_mask_o[l_ac].* =  g_apaf_d[l_ac].*
      CALL aapi060_apaf_t_mask()
      LET g_apaf_d_mask_n[l_ac].* =  g_apaf_d[l_ac].*
   END FOR
   
   LET g_apaf2_d_mask_o.* =  g_apaf2_d.*
   FOR l_ac = 1 TO g_apaf2_d.getLength()
      LET g_apaf2_d_mask_o[l_ac].* =  g_apaf2_d[l_ac].*
      CALL aapi060_apaf_t_mask()
      LET g_apaf2_d_mask_n[l_ac].* =  g_apaf2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_apaf_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aapi060_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aapi060.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapi060_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapi060.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapi060_set_entry_b(p_cmd)                                                  
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
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aapi060.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapi060_set_no_entry_b(p_cmd)                                               
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
   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aapi060.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapi060_default_search()
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
      LET ls_wc = ls_wc, " apaf001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apaf011 = '", g_argv[02], "' AND "
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
 
{<section id="aapi060.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapi060_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "apaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'apaf_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM apaf_t
          WHERE apafent = g_enterprise AND
            apaf001 = ps_keys_bak[1] AND apaf011 = ps_keys_bak[2]
         
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
         CALL g_apaf_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_apaf2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapi060.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapi060_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "apaf_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO apaf_t
                  (apafent,
                   apaf001,apaf011
                   ,apaf012,apaf013,apaf014,apaf021,apaf017,apaf018,apaf019,apaf020,apaf015,apaf016,apafstus,apafownid,apafowndp,apafcrtid,apafcrtdp,apafcrtdt,apafmodid,apafmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_apaf_d[l_ac].apaf012,g_apaf_d[l_ac].apaf013,g_apaf_d[l_ac].apaf014,g_apaf_d[l_ac].apaf021, 
                       g_apaf_d[l_ac].apaf017,g_apaf_d[l_ac].apaf018,g_apaf_d[l_ac].apaf019,g_apaf_d[l_ac].apaf020, 
                       g_apaf_d[l_ac].apaf015,g_apaf_d[l_ac].apaf016,g_apaf_d[l_ac].apafstus,g_apaf2_d[l_ac].apafownid, 
                       g_apaf2_d[l_ac].apafowndp,g_apaf2_d[l_ac].apafcrtid,g_apaf2_d[l_ac].apafcrtdp, 
                       g_apaf2_d[l_ac].apafcrtdt,g_apaf2_d[l_ac].apafmodid,g_apaf2_d[l_ac].apafmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apaf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapi060.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapi060_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "apaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "apaf_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE apaf_t 
         SET (apaf001,apaf011
              ,apaf012,apaf013,apaf014,apaf021,apaf017,apaf018,apaf019,apaf020,apaf015,apaf016,apafstus,apafownid,apafowndp,apafcrtid,apafcrtdp,apafcrtdt,apafmodid,apafmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_apaf_d[l_ac].apaf012,g_apaf_d[l_ac].apaf013,g_apaf_d[l_ac].apaf014,g_apaf_d[l_ac].apaf021, 
                  g_apaf_d[l_ac].apaf017,g_apaf_d[l_ac].apaf018,g_apaf_d[l_ac].apaf019,g_apaf_d[l_ac].apaf020, 
                  g_apaf_d[l_ac].apaf015,g_apaf_d[l_ac].apaf016,g_apaf_d[l_ac].apafstus,g_apaf2_d[l_ac].apafownid, 
                  g_apaf2_d[l_ac].apafowndp,g_apaf2_d[l_ac].apafcrtid,g_apaf2_d[l_ac].apafcrtdp,g_apaf2_d[l_ac].apafcrtdt, 
                  g_apaf2_d[l_ac].apafmodid,g_apaf2_d[l_ac].apafmoddt) 
         WHERE apafent = g_enterprise AND apaf001 = ps_keys_bak[1] AND apaf011 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apaf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apaf_t:",SQLERRMESSAGE 
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
 
{<section id="aapi060.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapi060_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aapi060_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "apaf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapi060_bcl USING g_enterprise,
                                       g_apaf_d[g_detail_idx].apaf001,g_apaf_d[g_detail_idx].apaf011
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapi060_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapi060.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapi060_unlock_b(ps_table)
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
      CLOSE aapi060_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapi060.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aapi060_modify_detail_chk(ps_record)
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
         LET ls_return = "apaf001"
      WHEN "s_detail2"
         LET ls_return = "apaf001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aapi060.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aapi060_show_ownid_msg()
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
 
{<section id="aapi060.mask_functions" >}
&include "erp/aap/aapi060_mask.4gl"
 
{</section>}
 
{<section id="aapi060.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapi060_set_pk_array()
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
   LET g_pk_array[1].values = g_apaf_d[l_ac].apaf001
   LET g_pk_array[1].column = 'apaf001'
   LET g_pk_array[2].values = g_apaf_d[l_ac].apaf011
   LET g_pk_array[2].column = 'apaf011'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapi060.state_change" >}
   
 
{</section>}
 
{<section id="aapi060.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aapi060.other_function" readonly="Y" >}

 
{</section>}
 
