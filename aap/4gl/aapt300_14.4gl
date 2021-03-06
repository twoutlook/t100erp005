#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt300_14.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-04-25 15:21:17), PR版次:0009(2016-09-29 13:37:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000138
#+ Filename...: aapt300_14
#+ Description: 傳票拋轉預覽
#+ Creator....: 05016(2014-09-15 10:00:45)
#+ Modifier...: 02097 -SD/PR- 08732
 
{</section>}
 
{<section id="aapt300_14.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150209-00008#2   2015/02/10 By Belle    增加現金變動碼
#150320           2015/03/20 By Reanna   增加月結非拋傳票不可的機制
#160905-00002#1   2016/09/05 By Reanna   SQL條件少ENT補上(硬框架調整)
#160920-00019#2   2016/09/21 By 08732    交易對象開窗校驗調整
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
PRIVATE TYPE type_g_glaq_d RECORD
       glaqdocno LIKE glaq_t.glaqdocno, 
   glaqld LIKE glaq_t.glaqld, 
   glaqseq LIKE glaq_t.glaqseq, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq002 LIKE glaq_t.glaq002, 
   glacl004 LIKE type_t.chr500, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq010 LIKE glaq_t.glaq010, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq040 LIKE type_t.num20_6, 
   glaq041 LIKE type_t.num20_6, 
   glaq043 LIKE type_t.num20_6, 
   glaq044 LIKE type_t.num20_6, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq021 LIKE glaq_t.glaq021, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq025 LIKE glaq_t.glaq025, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq028 LIKE glaq_t.glaq028, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq029 LIKE glaq_t.glaq029, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq038 LIKE glaq_t.glaq038, 
   glaq011 LIKE glaq_t.glaq011
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 type type_g_detail_m        RECORD
        glaq0171_desc   LIKE type_t.chr80, 
        glaq017_desc    LIKE type_t.chr80, 
        glaq0181_desc   LIKE type_t.chr80, 
        glaq018_desc    LIKE type_t.chr80, 
        glaq0191_desc   LIKE type_t.chr80, 
        glaq019_desc    LIKE type_t.chr80, 
        glaq0201_desc   LIKE type_t.chr80, 
        glaq020_desc    LIKE type_t.chr80, 
        glaq0211_desc   LIKE type_t.chr80, 
        glaq021_desc    LIKE type_t.chr80, 
        glaq0221_desc   LIKE type_t.chr80, 
        glaq022_desc    LIKE type_t.chr80, 
        glaq0231_desc   LIKE type_t.chr80, 
        glaq023_desc    LIKE type_t.chr80, 
        glaq0241_desc   LIKE type_t.chr80, 
        glaq024_desc    LIKE type_t.chr80, 
        glaq0251_desc   LIKE type_t.chr80, 
        glaq025_desc    LIKE type_t.chr80, 
        glaq0271_desc   LIKE type_t.chr80, 
        glaq027_desc    LIKE type_t.chr80, 
        glaq0281_desc   LIKE type_t.chr80, 
        glaq028_desc    LIKE type_t.chr80, 
        glaq0511_desc   LIKE type_t.chr80, 
        glaq0521_desc   LIKE type_t.chr80, 
        glaq052_desc    LIKE type_t.chr80, 
        glaq0531_desc   LIKE type_t.chr80, 
        glaq053_desc    LIKE type_t.chr80, 
        glaq0291_desc   LIKE type_t.chr80, 
        glaq029_desc    LIKE type_t.chr80, 
        glaq0301_desc   LIKE type_t.chr80, 
        glaq030_desc    LIKE type_t.chr80, 
        glaq0311_desc   LIKE type_t.chr80, 
        glaq031_desc    LIKE type_t.chr80, 
        glaq0321_desc   LIKE type_t.chr80, 
        glaq032_desc    LIKE type_t.chr80, 
        glaq0331_desc   LIKE type_t.chr80, 
        glaq033_desc    LIKE type_t.chr80, 
        glaq0341_desc   LIKE type_t.chr80, 
        glaq034_desc    LIKE type_t.chr80, 
        glaq0351_desc   LIKE type_t.chr80, 
        glaq035_desc    LIKE type_t.chr80, 
        glaq0361_desc   LIKE type_t.chr80, 
        glaq036_desc    LIKE type_t.chr80, 
        glaq0371_desc   LIKE type_t.chr80, 
        glaq037_desc    LIKE type_t.chr80, 
        glaq0381_desc   LIKE type_t.chr80, 
        glaq038_desc    LIKE type_t.chr80,
        glgb0551_desc   LIKE type_t.chr80,
        glgb055_desc    LIKE type_t.chr80          #150209-00008#2
        END RECORD
DEFINE g_detail_m          type_g_detail_m
#end add-point
 
#模組變數(Module Variables)
DEFINE g_glaq_d          DYNAMIC ARRAY OF type_g_glaq_d #單身變數
DEFINE g_glaq_d_t        type_g_glaq_d                  #單身備份
DEFINE g_glaq_d_o        type_g_glaq_d                  #單身備份
DEFINE g_glaq_d_mask_o   DYNAMIC ARRAY OF type_g_glaq_d #單身變數
DEFINE g_glaq_d_mask_n   DYNAMIC ARRAY OF type_g_glaq_d #單身變數
 
      
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
DEFINE g_apcadocno      LIKE apca_t.apcadocno
DEFINE g_apcald         LIKE apca_t.apcald
DEFINE g_wc             STRING
DEFINE g_type           LIKE type_t.chr2 
#end add-point
 
{</section>}
 
{<section id="aapt300_14.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aapt300_14(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_ld,p_docno,p_type
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_ld        LIKE apca_t.apcald
   DEFINE p_docno     LIKE apca_t.apcadocno
   DEFINE p_type      LIKE type_t.chr2 
   DEFINE l_apca038   LIKE apca_t.apca038
   DEFINE l_apcacomp  LIKE apca_t.apcacomp
   DEFINE l_ap_slip   LIKE apca_t.apcadocno
   DEFINE l_chr       LIKE type_t.chr1
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_apcadocno = p_docno
   LET g_apcald    = p_ld
   LET g_type      = p_type      #NO USE
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
  
   #end add-point 
   LET g_forupd_sql = "SELECT glaqdocno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003, 
       glaq004,glaq040,glaq041,glaq043,glaq044,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023, 
       glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,glaq029,glaq030,glaq031,glaq032,glaq033, 
       glaq034,glaq035,glaq036,glaq037,glaq038,glaq011 FROM glaq_t WHERE glaqent=? AND glaqld=? AND  
       glaqdocno=? AND glaqseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt300_14_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt300_14 WITH FORM cl_ap_formpath("aap","aapt300_14")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aapt300_14_init()   
 
   #進入選單 Menu (="N")
   CALL aapt300_14_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aapt300_14
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ''
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_14.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapt300_14_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
  #CALL s_aapp330_cre_tmp() RETURNING g_sub_success   #以主程式cre為主
   CALL cl_set_combo_scc('glaq0511_desc','6013')
   #end add-point
   
   CALL aapt300_14_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapt300_14_ui_dialog()
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
   DEFINE l_apcastus LIKE apca_t.apcastus
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
         CALL g_glaq_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aapt300_14_init()
      END IF
   
      CALL aapt300_14_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               CALL aapt300_14_b_detail()
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aapt300_14_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL aapt300_14_b_detail()
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
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
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            CALL cl_set_act_visible("logistics,insert,delete,modify_detail", FALSE)
            LET l_apcastus = 'Y'
            CASE
                WHEN g_prog[1,5] = 'aapt3'
                     SELECT apcastus INTO l_apcastus 
                       FROM apca_t
                      WHERE apcaent = g_enterprise 
                        AND apcald  = g_apcald AND apcadocno = g_apcadocno
                WHEN g_prog[1,6] = 'aapt42'
                     SELECT apdastus INTO l_apcastus 
                       FROM apda_t
                      WHERE apdaent = g_enterprise 
                        AND apdald  = g_apcald AND apdadocno = g_apcadocno
            END CASE            
            IF l_apcastus NOT MATCHES "[N]" THEN   
               CALL cl_set_act_visible("modify", FALSE)
            END IF 
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aapt300_14_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_14_modify()
            #add-point:ON ACTION modify name="menu.modify"
               CALL aapt300_14_glgb055()
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aapt300_14_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_14_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aapt300_14_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aapt300_14_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt300_14_insert()
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
               CALL aapt300_14_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glaq_d)
               LET g_export_id[1]   = "s_detail1"
 
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
            CALL aapt300_14_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt300_14_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt300_14_set_pk_array()
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
 
{<section id="aapt300_14.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt300_14_query()
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
   CALL g_glaq_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON glaqdocno,glaqld,glaqseq,glaq001,glaq002,glacl004,glaq005,glaq006,glaq010,glaq003, 
          glaq004,glaq040,glaq041,glaq043,glaq044,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023, 
          glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,glaq029,glaq030,glaq031,glaq032,glaq033, 
          glaq034,glaq035,glaq036,glaq037,glaq038,glaq011 
 
         FROM s_detail1[1].glaqdocno,s_detail1[1].glaqld,s_detail1[1].glaqseq,s_detail1[1].glaq001,s_detail1[1].glaq002, 
             s_detail1[1].glacl004,s_detail1[1].glaq005,s_detail1[1].glaq006,s_detail1[1].glaq010,s_detail1[1].glaq003, 
             s_detail1[1].glaq004,s_detail1[1].glaq040,s_detail1[1].glaq041,s_detail1[1].glaq043,s_detail1[1].glaq044, 
             s_detail1[1].glaq017,s_detail1[1].glaq018,s_detail1[1].glaq019,s_detail1[1].glaq020,s_detail1[1].glaq021, 
             s_detail1[1].glaq022,s_detail1[1].glaq023,s_detail1[1].glaq024,s_detail1[1].glaq025,s_detail1[1].glaq027, 
             s_detail1[1].glaq028,s_detail1[1].glaq051,s_detail1[1].glaq052,s_detail1[1].glaq053,s_detail1[1].glaq029, 
             s_detail1[1].glaq030,s_detail1[1].glaq031,s_detail1[1].glaq032,s_detail1[1].glaq033,s_detail1[1].glaq034, 
             s_detail1[1].glaq035,s_detail1[1].glaq036,s_detail1[1].glaq037,s_detail1[1].glaq038,s_detail1[1].glaq011  
 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqdocno
            #add-point:BEFORE FIELD glaqdocno name="query.b.page1.glaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqdocno
            
            #add-point:AFTER FIELD glaqdocno name="query.a.page1.glaqdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqdocno
            #add-point:ON ACTION controlp INFIELD glaqdocno name="query.c.page1.glaqdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqld
            #add-point:BEFORE FIELD glaqld name="query.b.page1.glaqld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqld
            
            #add-point:AFTER FIELD glaqld name="query.a.page1.glaqld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaqld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqld
            #add-point:ON ACTION controlp INFIELD glaqld name="query.c.page1.glaqld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqseq
            #add-point:BEFORE FIELD glaqseq name="query.b.page1.glaqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqseq
            
            #add-point:AFTER FIELD glaqseq name="query.a.page1.glaqseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqseq
            #add-point:ON ACTION controlp INFIELD glaqseq name="query.c.page1.glaqseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="construct.c.page1.glaq001"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="query.b.page1.glaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="query.a.page1.glaq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="construct.c.page1.glaq002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq002  #顯示到畫面上
            NEXT FIELD glaq002                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="query.b.page1.glaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="query.a.page1.glaq002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glacl004
            #add-point:BEFORE FIELD glacl004 name="query.b.page1.glacl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glacl004
            
            #add-point:AFTER FIELD glacl004 name="query.a.page1.glacl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glacl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glacl004
            #add-point:ON ACTION controlp INFIELD glacl004 name="query.c.page1.glacl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq005
            #add-point:BEFORE FIELD glaq005 name="query.b.page1.glaq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq005
            
            #add-point:AFTER FIELD glaq005 name="query.a.page1.glaq005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq005
            #add-point:ON ACTION controlp INFIELD glaq005 name="query.c.page1.glaq005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq006
            #add-point:BEFORE FIELD glaq006 name="query.b.page1.glaq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq006
            
            #add-point:AFTER FIELD glaq006 name="query.a.page1.glaq006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq006
            #add-point:ON ACTION controlp INFIELD glaq006 name="query.c.page1.glaq006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq010
            #add-point:BEFORE FIELD glaq010 name="query.b.page1.glaq010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq010
            
            #add-point:AFTER FIELD glaq010 name="query.a.page1.glaq010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq010
            #add-point:ON ACTION controlp INFIELD glaq010 name="query.c.page1.glaq010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq003
            #add-point:BEFORE FIELD glaq003 name="query.b.page1.glaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq003
            
            #add-point:AFTER FIELD glaq003 name="query.a.page1.glaq003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq003
            #add-point:ON ACTION controlp INFIELD glaq003 name="query.c.page1.glaq003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq004
            #add-point:BEFORE FIELD glaq004 name="query.b.page1.glaq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq004
            
            #add-point:AFTER FIELD glaq004 name="query.a.page1.glaq004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq004
            #add-point:ON ACTION controlp INFIELD glaq004 name="query.c.page1.glaq004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq040
            #add-point:BEFORE FIELD glaq040 name="query.b.page1.glaq040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq040
            
            #add-point:AFTER FIELD glaq040 name="query.a.page1.glaq040"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq040
            #add-point:ON ACTION controlp INFIELD glaq040 name="query.c.page1.glaq040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq041
            #add-point:BEFORE FIELD glaq041 name="query.b.page1.glaq041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq041
            
            #add-point:AFTER FIELD glaq041 name="query.a.page1.glaq041"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq041
            #add-point:ON ACTION controlp INFIELD glaq041 name="query.c.page1.glaq041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq043
            #add-point:BEFORE FIELD glaq043 name="query.b.page1.glaq043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq043
            
            #add-point:AFTER FIELD glaq043 name="query.a.page1.glaq043"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq043
            #add-point:ON ACTION controlp INFIELD glaq043 name="query.c.page1.glaq043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq044
            #add-point:BEFORE FIELD glaq044 name="query.b.page1.glaq044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq044
            
            #add-point:AFTER FIELD glaq044 name="query.a.page1.glaq044"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq044
            #add-point:ON ACTION controlp INFIELD glaq044 name="query.c.page1.glaq044"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glaq017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq017
            #add-point:ON ACTION controlp INFIELD glaq017 name="construct.c.page1.glaq017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq017  #顯示到畫面上
            NEXT FIELD glaq017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq017
            #add-point:BEFORE FIELD glaq017 name="query.b.page1.glaq017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq017
            
            #add-point:AFTER FIELD glaq017 name="query.a.page1.glaq017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq018
            #add-point:BEFORE FIELD glaq018 name="query.b.page1.glaq018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq018
            
            #add-point:AFTER FIELD glaq018 name="query.a.page1.glaq018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq018
            #add-point:ON ACTION controlp INFIELD glaq018 name="query.c.page1.glaq018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq019
            #add-point:BEFORE FIELD glaq019 name="query.b.page1.glaq019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq019
            
            #add-point:AFTER FIELD glaq019 name="query.a.page1.glaq019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq019
            #add-point:ON ACTION controlp INFIELD glaq019 name="query.c.page1.glaq019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glaq020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq020
            #add-point:ON ACTION controlp INFIELD glaq020 name="construct.c.page1.glaq020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq020  #顯示到畫面上
            NEXT FIELD glaq020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq020
            #add-point:BEFORE FIELD glaq020 name="query.b.page1.glaq020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq020
            
            #add-point:AFTER FIELD glaq020 name="query.a.page1.glaq020"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq021
            #add-point:BEFORE FIELD glaq021 name="query.b.page1.glaq021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq021
            
            #add-point:AFTER FIELD glaq021 name="query.a.page1.glaq021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq021
            #add-point:ON ACTION controlp INFIELD glaq021 name="query.c.page1.glaq021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq022
            #add-point:ON ACTION controlp INFIELD glaq022 name="construct.c.page1.glaq022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()     #160920-00019#2   mark
            CALL q_pmaa001_25()   #160920-00019#2   add
            DISPLAY g_qryparam.return1 TO glaq022  #顯示到畫面上
            NEXT FIELD glaq022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq022
            #add-point:BEFORE FIELD glaq022 name="query.b.page1.glaq022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq022
            
            #add-point:AFTER FIELD glaq022 name="query.a.page1.glaq022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq023
            #add-point:ON ACTION controlp INFIELD glaq023 name="construct.c.page1.glaq023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq023  #顯示到畫面上
            NEXT FIELD glaq023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq023
            #add-point:BEFORE FIELD glaq023 name="query.b.page1.glaq023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq023
            
            #add-point:AFTER FIELD glaq023 name="query.a.page1.glaq023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq024
            #add-point:ON ACTION controlp INFIELD glaq024 name="construct.c.page1.glaq024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq024  #顯示到畫面上
            NEXT FIELD glaq024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq024
            #add-point:BEFORE FIELD glaq024 name="query.b.page1.glaq024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq024
            
            #add-point:AFTER FIELD glaq024 name="query.a.page1.glaq024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq025
            #add-point:ON ACTION controlp INFIELD glaq025 name="construct.c.page1.glaq025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq025  #顯示到畫面上
            NEXT FIELD glaq025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq025
            #add-point:BEFORE FIELD glaq025 name="query.b.page1.glaq025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq025
            
            #add-point:AFTER FIELD glaq025 name="query.a.page1.glaq025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq027
            #add-point:BEFORE FIELD glaq027 name="query.b.page1.glaq027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq027
            
            #add-point:AFTER FIELD glaq027 name="query.a.page1.glaq027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq027
            #add-point:ON ACTION controlp INFIELD glaq027 name="query.c.page1.glaq027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq028
            #add-point:BEFORE FIELD glaq028 name="query.b.page1.glaq028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq028
            
            #add-point:AFTER FIELD glaq028 name="query.a.page1.glaq028"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq028
            #add-point:ON ACTION controlp INFIELD glaq028 name="query.c.page1.glaq028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq051
            #add-point:BEFORE FIELD glaq051 name="query.b.page1.glaq051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq051
            
            #add-point:AFTER FIELD glaq051 name="query.a.page1.glaq051"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq051
            #add-point:ON ACTION controlp INFIELD glaq051 name="query.c.page1.glaq051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq052
            #add-point:BEFORE FIELD glaq052 name="query.b.page1.glaq052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq052
            
            #add-point:AFTER FIELD glaq052 name="query.a.page1.glaq052"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq052
            #add-point:ON ACTION controlp INFIELD glaq052 name="query.c.page1.glaq052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq053
            #add-point:BEFORE FIELD glaq053 name="query.b.page1.glaq053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq053
            
            #add-point:AFTER FIELD glaq053 name="query.a.page1.glaq053"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq053
            #add-point:ON ACTION controlp INFIELD glaq053 name="query.c.page1.glaq053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029
            #add-point:BEFORE FIELD glaq029 name="query.b.page1.glaq029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="query.a.page1.glaq029"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="query.c.page1.glaq029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030
            #add-point:BEFORE FIELD glaq030 name="query.b.page1.glaq030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030
            
            #add-point:AFTER FIELD glaq030 name="query.a.page1.glaq030"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030
            #add-point:ON ACTION controlp INFIELD glaq030 name="query.c.page1.glaq030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031
            #add-point:BEFORE FIELD glaq031 name="query.b.page1.glaq031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031
            
            #add-point:AFTER FIELD glaq031 name="query.a.page1.glaq031"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031
            #add-point:ON ACTION controlp INFIELD glaq031 name="query.c.page1.glaq031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032
            #add-point:BEFORE FIELD glaq032 name="query.b.page1.glaq032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032
            
            #add-point:AFTER FIELD glaq032 name="query.a.page1.glaq032"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032
            #add-point:ON ACTION controlp INFIELD glaq032 name="query.c.page1.glaq032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033
            #add-point:BEFORE FIELD glaq033 name="query.b.page1.glaq033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033
            
            #add-point:AFTER FIELD glaq033 name="query.a.page1.glaq033"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033
            #add-point:ON ACTION controlp INFIELD glaq033 name="query.c.page1.glaq033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034
            #add-point:BEFORE FIELD glaq034 name="query.b.page1.glaq034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034
            
            #add-point:AFTER FIELD glaq034 name="query.a.page1.glaq034"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034
            #add-point:ON ACTION controlp INFIELD glaq034 name="query.c.page1.glaq034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035
            #add-point:BEFORE FIELD glaq035 name="query.b.page1.glaq035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035
            
            #add-point:AFTER FIELD glaq035 name="query.a.page1.glaq035"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035
            #add-point:ON ACTION controlp INFIELD glaq035 name="query.c.page1.glaq035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036
            #add-point:BEFORE FIELD glaq036 name="query.b.page1.glaq036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036
            
            #add-point:AFTER FIELD glaq036 name="query.a.page1.glaq036"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036
            #add-point:ON ACTION controlp INFIELD glaq036 name="query.c.page1.glaq036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037
            #add-point:BEFORE FIELD glaq037 name="query.b.page1.glaq037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037
            
            #add-point:AFTER FIELD glaq037 name="query.a.page1.glaq037"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="query.c.page1.glaq037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038
            #add-point:BEFORE FIELD glaq038 name="query.b.page1.glaq038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038
            
            #add-point:AFTER FIELD glaq038 name="query.a.page1.glaq038"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038
            #add-point:ON ACTION controlp INFIELD glaq038 name="query.c.page1.glaq038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq011
            #add-point:BEFORE FIELD glaq011 name="query.b.page1.glaq011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq011
            
            #add-point:AFTER FIELD glaq011 name="query.a.page1.glaq011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq011
            #add-point:ON ACTION controlp INFIELD glaq011 name="query.c.page1.glaq011"
            
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
    
   CALL aapt300_14_b_fill(g_wc2)
 
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
 
{<section id="aapt300_14.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt300_14_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   RETURN
   #end add-point
   
   LET g_insert = 'Y'
   CALL aapt300_14_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt300_14_modify()
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
   
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   RETURN
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
      INPUT ARRAY g_glaq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glaq_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt300_14_b_fill(g_wc2)
            LET g_detail_cnt = g_glaq_d.getLength()
         
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
            DISPLAY g_glaq_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_glaq_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_glaq_d[l_ac].glaqld IS NOT NULL
               AND g_glaq_d[l_ac].glaqdocno IS NOT NULL
               AND g_glaq_d[l_ac].glaqseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glaq_d_t.* = g_glaq_d[l_ac].*  #BACKUP
               LET g_glaq_d_o.* = g_glaq_d[l_ac].*  #BACKUP
               IF NOT aapt300_14_lock_b("glaq_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt300_14_bcl INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq, 
                      g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006, 
                      g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040, 
                      g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].glaq017, 
                      g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq019,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq021, 
                      g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq023,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq025, 
                      g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glaq051,g_glaq_d[l_ac].glaq052, 
                      g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq029,g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq031, 
                      g_glaq_d[l_ac].glaq032,g_glaq_d[l_ac].glaq033,g_glaq_d[l_ac].glaq034,g_glaq_d[l_ac].glaq035, 
                      g_glaq_d[l_ac].glaq036,g_glaq_d[l_ac].glaq037,g_glaq_d[l_ac].glaq038,g_glaq_d[l_ac].glaq011 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glaq_d_t.glaqld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glaq_d_mask_o[l_ac].* =  g_glaq_d[l_ac].*
                  CALL aapt300_14_glaq_t_mask()
                  LET g_glaq_d_mask_n[l_ac].* =  g_glaq_d[l_ac].*
                  
                  CALL aapt300_14_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aapt300_14_set_entry_b(l_cmd)
            CALL aapt300_14_set_no_entry_b(l_cmd)
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
            INITIALIZE g_glaq_d_t.* TO NULL
            INITIALIZE g_glaq_d_o.* TO NULL
            INITIALIZE g_glaq_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_glaq_d_t.* = g_glaq_d[l_ac].*     #新輸入資料
            LET g_glaq_d_o.* = g_glaq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glaq_d[li_reproduce_target].* = g_glaq_d[li_reproduce].*
 
               LET g_glaq_d[g_glaq_d.getLength()].glaqld = NULL
               LET g_glaq_d[g_glaq_d.getLength()].glaqdocno = NULL
               LET g_glaq_d[g_glaq_d.getLength()].glaqseq = NULL
 
            END IF
            
 
            CALL aapt300_14_set_entry_b(l_cmd)
            CALL aapt300_14_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM glaq_t 
             WHERE glaqent = g_enterprise AND glaqld = g_glaq_d[l_ac].glaqld
                                       AND glaqdocno = g_glaq_d[l_ac].glaqdocno
                                       AND glaqseq = g_glaq_d[l_ac].glaqseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d[g_detail_idx].glaqld
               LET gs_keys[2] = g_glaq_d[g_detail_idx].glaqdocno
               LET gs_keys[3] = g_glaq_d[g_detail_idx].glaqseq
               CALL aapt300_14_insert_b('glaq_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_glaq_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt300_14_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (glaqld = '", g_glaq_d[l_ac].glaqld, "' "
                                  ," AND glaqdocno = '", g_glaq_d[l_ac].glaqdocno, "' "
                                  ," AND glaqseq = '", g_glaq_d[l_ac].glaqseq, "' "
 
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
               
               DELETE FROM glaq_t
                WHERE glaqent = g_enterprise AND 
                      glaqld = g_glaq_d_t.glaqld
                      AND glaqdocno = g_glaq_d_t.glaqdocno
                      AND glaqseq = g_glaq_d_t.glaqseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aapt300_14_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_glaq_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aapt300_14_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_glaq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d_t.glaqld
               LET gs_keys[2] = g_glaq_d_t.glaqdocno
               LET gs_keys[3] = g_glaq_d_t.glaqseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_14_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aapt300_14_delete_b('glaq_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glaq_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqdocno
            #add-point:BEFORE FIELD glaqdocno name="input.b.page1.glaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqdocno
            
            #add-point:AFTER FIELD glaqdocno name="input.a.page1.glaqdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqdocno
            #add-point:ON CHANGE glaqdocno name="input.g.page1.glaqdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqld
            #add-point:BEFORE FIELD glaqld name="input.b.page1.glaqld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqld
            
            #add-point:AFTER FIELD glaqld name="input.a.page1.glaqld"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqld
            #add-point:ON CHANGE glaqld name="input.g.page1.glaqld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqseq
            #add-point:BEFORE FIELD glaqseq name="input.b.page1.glaqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqseq
            
            #add-point:AFTER FIELD glaqseq name="input.a.page1.glaqseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqseq
            #add-point:ON CHANGE glaqseq name="input.g.page1.glaqseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="input.b.page1.glaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="input.a.page1.glaq001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq001
            #add-point:ON CHANGE glaq001 name="input.g.page1.glaq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="input.b.page1.glaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="input.a.page1.glaq002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq002
            #add-point:ON CHANGE glaq002 name="input.g.page1.glaq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glacl004
            #add-point:BEFORE FIELD glacl004 name="input.b.page1.glacl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glacl004
            
            #add-point:AFTER FIELD glacl004 name="input.a.page1.glacl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glacl004
            #add-point:ON CHANGE glacl004 name="input.g.page1.glacl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq005
            #add-point:BEFORE FIELD glaq005 name="input.b.page1.glaq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq005
            
            #add-point:AFTER FIELD glaq005 name="input.a.page1.glaq005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq005
            #add-point:ON CHANGE glaq005 name="input.g.page1.glaq005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq006
            #add-point:BEFORE FIELD glaq006 name="input.b.page1.glaq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq006
            
            #add-point:AFTER FIELD glaq006 name="input.a.page1.glaq006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq006
            #add-point:ON CHANGE glaq006 name="input.g.page1.glaq006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq010
            #add-point:BEFORE FIELD glaq010 name="input.b.page1.glaq010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq010
            
            #add-point:AFTER FIELD glaq010 name="input.a.page1.glaq010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq010
            #add-point:ON CHANGE glaq010 name="input.g.page1.glaq010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq003
            #add-point:BEFORE FIELD glaq003 name="input.b.page1.glaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq003
            
            #add-point:AFTER FIELD glaq003 name="input.a.page1.glaq003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq003
            #add-point:ON CHANGE glaq003 name="input.g.page1.glaq003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq004
            #add-point:BEFORE FIELD glaq004 name="input.b.page1.glaq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq004
            
            #add-point:AFTER FIELD glaq004 name="input.a.page1.glaq004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq004
            #add-point:ON CHANGE glaq004 name="input.g.page1.glaq004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq040
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq040,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD glaq040
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq040 name="input.a.page1.glaq040"
            IF NOT cl_null(g_glaq_d[l_ac].glaq040) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq040
            #add-point:BEFORE FIELD glaq040 name="input.b.page1.glaq040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq040
            #add-point:ON CHANGE glaq040 name="input.g.page1.glaq040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq041
            #add-point:BEFORE FIELD glaq041 name="input.b.page1.glaq041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq041
            
            #add-point:AFTER FIELD glaq041 name="input.a.page1.glaq041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq041
            #add-point:ON CHANGE glaq041 name="input.g.page1.glaq041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq043
            #add-point:BEFORE FIELD glaq043 name="input.b.page1.glaq043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq043
            
            #add-point:AFTER FIELD glaq043 name="input.a.page1.glaq043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq043
            #add-point:ON CHANGE glaq043 name="input.g.page1.glaq043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq044,"0.000","1","10.000","1","azz-00087",1) THEN 
 
               NEXT FIELD glaq044
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq044 name="input.a.page1.glaq044"
            IF NOT cl_null(g_glaq_d[l_ac].glaq044) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq044
            #add-point:BEFORE FIELD glaq044 name="input.b.page1.glaq044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq044
            #add-point:ON CHANGE glaq044 name="input.g.page1.glaq044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq017
            #add-point:BEFORE FIELD glaq017 name="input.b.page1.glaq017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq017
            
            #add-point:AFTER FIELD glaq017 name="input.a.page1.glaq017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq017
            #add-point:ON CHANGE glaq017 name="input.g.page1.glaq017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq018
            #add-point:BEFORE FIELD glaq018 name="input.b.page1.glaq018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq018
            
            #add-point:AFTER FIELD glaq018 name="input.a.page1.glaq018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq018
            #add-point:ON CHANGE glaq018 name="input.g.page1.glaq018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq019
            #add-point:BEFORE FIELD glaq019 name="input.b.page1.glaq019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq019
            
            #add-point:AFTER FIELD glaq019 name="input.a.page1.glaq019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq019
            #add-point:ON CHANGE glaq019 name="input.g.page1.glaq019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq020
            #add-point:BEFORE FIELD glaq020 name="input.b.page1.glaq020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq020
            
            #add-point:AFTER FIELD glaq020 name="input.a.page1.glaq020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq020
            #add-point:ON CHANGE glaq020 name="input.g.page1.glaq020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq021
            #add-point:BEFORE FIELD glaq021 name="input.b.page1.glaq021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq021
            
            #add-point:AFTER FIELD glaq021 name="input.a.page1.glaq021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq021
            #add-point:ON CHANGE glaq021 name="input.g.page1.glaq021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq022
            #add-point:BEFORE FIELD glaq022 name="input.b.page1.glaq022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq022
            
            #add-point:AFTER FIELD glaq022 name="input.a.page1.glaq022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq022
            #add-point:ON CHANGE glaq022 name="input.g.page1.glaq022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq023
            #add-point:BEFORE FIELD glaq023 name="input.b.page1.glaq023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq023
            
            #add-point:AFTER FIELD glaq023 name="input.a.page1.glaq023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq023
            #add-point:ON CHANGE glaq023 name="input.g.page1.glaq023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq024
            #add-point:BEFORE FIELD glaq024 name="input.b.page1.glaq024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq024
            
            #add-point:AFTER FIELD glaq024 name="input.a.page1.glaq024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq024
            #add-point:ON CHANGE glaq024 name="input.g.page1.glaq024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq025
            #add-point:BEFORE FIELD glaq025 name="input.b.page1.glaq025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq025
            
            #add-point:AFTER FIELD glaq025 name="input.a.page1.glaq025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq025
            #add-point:ON CHANGE glaq025 name="input.g.page1.glaq025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq027
            #add-point:BEFORE FIELD glaq027 name="input.b.page1.glaq027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq027
            
            #add-point:AFTER FIELD glaq027 name="input.a.page1.glaq027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq027
            #add-point:ON CHANGE glaq027 name="input.g.page1.glaq027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq028
            #add-point:BEFORE FIELD glaq028 name="input.b.page1.glaq028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq028
            
            #add-point:AFTER FIELD glaq028 name="input.a.page1.glaq028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq028
            #add-point:ON CHANGE glaq028 name="input.g.page1.glaq028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq051
            #add-point:BEFORE FIELD glaq051 name="input.b.page1.glaq051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq051
            
            #add-point:AFTER FIELD glaq051 name="input.a.page1.glaq051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq051
            #add-point:ON CHANGE glaq051 name="input.g.page1.glaq051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq052
            #add-point:BEFORE FIELD glaq052 name="input.b.page1.glaq052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq052
            
            #add-point:AFTER FIELD glaq052 name="input.a.page1.glaq052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq052
            #add-point:ON CHANGE glaq052 name="input.g.page1.glaq052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq053
            #add-point:BEFORE FIELD glaq053 name="input.b.page1.glaq053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq053
            
            #add-point:AFTER FIELD glaq053 name="input.a.page1.glaq053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq053
            #add-point:ON CHANGE glaq053 name="input.g.page1.glaq053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029
            #add-point:BEFORE FIELD glaq029 name="input.b.page1.glaq029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="input.a.page1.glaq029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq029
            #add-point:ON CHANGE glaq029 name="input.g.page1.glaq029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030
            #add-point:BEFORE FIELD glaq030 name="input.b.page1.glaq030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030
            
            #add-point:AFTER FIELD glaq030 name="input.a.page1.glaq030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq030
            #add-point:ON CHANGE glaq030 name="input.g.page1.glaq030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031
            #add-point:BEFORE FIELD glaq031 name="input.b.page1.glaq031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031
            
            #add-point:AFTER FIELD glaq031 name="input.a.page1.glaq031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq031
            #add-point:ON CHANGE glaq031 name="input.g.page1.glaq031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032
            #add-point:BEFORE FIELD glaq032 name="input.b.page1.glaq032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032
            
            #add-point:AFTER FIELD glaq032 name="input.a.page1.glaq032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq032
            #add-point:ON CHANGE glaq032 name="input.g.page1.glaq032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033
            #add-point:BEFORE FIELD glaq033 name="input.b.page1.glaq033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033
            
            #add-point:AFTER FIELD glaq033 name="input.a.page1.glaq033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq033
            #add-point:ON CHANGE glaq033 name="input.g.page1.glaq033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034
            #add-point:BEFORE FIELD glaq034 name="input.b.page1.glaq034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034
            
            #add-point:AFTER FIELD glaq034 name="input.a.page1.glaq034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq034
            #add-point:ON CHANGE glaq034 name="input.g.page1.glaq034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035
            #add-point:BEFORE FIELD glaq035 name="input.b.page1.glaq035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035
            
            #add-point:AFTER FIELD glaq035 name="input.a.page1.glaq035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq035
            #add-point:ON CHANGE glaq035 name="input.g.page1.glaq035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036
            #add-point:BEFORE FIELD glaq036 name="input.b.page1.glaq036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036
            
            #add-point:AFTER FIELD glaq036 name="input.a.page1.glaq036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq036
            #add-point:ON CHANGE glaq036 name="input.g.page1.glaq036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037
            #add-point:BEFORE FIELD glaq037 name="input.b.page1.glaq037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037
            
            #add-point:AFTER FIELD glaq037 name="input.a.page1.glaq037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq037
            #add-point:ON CHANGE glaq037 name="input.g.page1.glaq037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038
            #add-point:BEFORE FIELD glaq038 name="input.b.page1.glaq038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038
            
            #add-point:AFTER FIELD glaq038 name="input.a.page1.glaq038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq038
            #add-point:ON CHANGE glaq038 name="input.g.page1.glaq038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq011
            #add-point:BEFORE FIELD glaq011 name="input.b.page1.glaq011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq011
            
            #add-point:AFTER FIELD glaq011 name="input.a.page1.glaq011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq011
            #add-point:ON CHANGE glaq011 name="input.g.page1.glaq011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glaqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqdocno
            #add-point:ON ACTION controlp INFIELD glaqdocno name="input.c.page1.glaqdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaqld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqld
            #add-point:ON ACTION controlp INFIELD glaqld name="input.c.page1.glaqld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqseq
            #add-point:ON ACTION controlp INFIELD glaqseq name="input.c.page1.glaqseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="input.c.page1.glaq001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="input.c.page1.glaq002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_glac002()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq002 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq002 TO glaq002              #

            NEXT FIELD glaq002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glacl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glacl004
            #add-point:ON ACTION controlp INFIELD glacl004 name="input.c.page1.glacl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq005
            #add-point:ON ACTION controlp INFIELD glaq005 name="input.c.page1.glaq005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq006
            #add-point:ON ACTION controlp INFIELD glaq006 name="input.c.page1.glaq006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq010
            #add-point:ON ACTION controlp INFIELD glaq010 name="input.c.page1.glaq010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq003
            #add-point:ON ACTION controlp INFIELD glaq003 name="input.c.page1.glaq003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq004
            #add-point:ON ACTION controlp INFIELD glaq004 name="input.c.page1.glaq004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq040
            #add-point:ON ACTION controlp INFIELD glaq040 name="input.c.page1.glaq040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq041
            #add-point:ON ACTION controlp INFIELD glaq041 name="input.c.page1.glaq041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq043
            #add-point:ON ACTION controlp INFIELD glaq043 name="input.c.page1.glaq043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq044
            #add-point:ON ACTION controlp INFIELD glaq044 name="input.c.page1.glaq044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq017
            #add-point:ON ACTION controlp INFIELD glaq017 name="input.c.page1.glaq017"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooea001()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq017 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq017 TO glaq017              #

            NEXT FIELD glaq017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq018
            #add-point:ON ACTION controlp INFIELD glaq018 name="input.c.page1.glaq018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq019
            #add-point:ON ACTION controlp INFIELD glaq019 name="input.c.page1.glaq019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq020
            #add-point:ON ACTION controlp INFIELD glaq020 name="input.c.page1.glaq020"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq020             #給予default值
            LET g_qryparam.default2 = "" #g_glaq_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq020 = g_qryparam.return1              
            #LET g_glaq_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_glaq_d[l_ac].glaq020 TO glaq020              #
            #DISPLAY g_glaq_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD glaq020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq021
            #add-point:ON ACTION controlp INFIELD glaq021 name="input.c.page1.glaq021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq022
            #add-point:ON ACTION controlp INFIELD glaq022 name="input.c.page1.glaq022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            
            #CALL q_pmaa001()     #160920-00019#2   mark
            CALL q_pmaa001_25()   #160920-00019#2   add
            LET g_glaq_d[l_ac].glaq022 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq022 TO glaq022              #

            NEXT FIELD glaq022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq023
            #add-point:ON ACTION controlp INFIELD glaq023 name="input.c.page1.glaq023"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq023             #給予default值
            LET g_qryparam.default2 = "" #g_glaq_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq023 = g_qryparam.return1              
            #LET g_glaq_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_glaq_d[l_ac].glaq023 TO glaq023              #
            #DISPLAY g_glaq_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD glaq023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq024
            #add-point:ON ACTION controlp INFIELD glaq024 name="input.c.page1.glaq024"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_rtax001()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq024 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq024 TO glaq024              #

            NEXT FIELD glaq024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq025
            #add-point:ON ACTION controlp INFIELD glaq025 name="input.c.page1.glaq025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq025             #給予default值
            LET g_qryparam.default2 = "" #g_glaq_d[l_ac].oofa011 #全名
            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_ooag001_2()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq025 = g_qryparam.return1              
            #LET g_glaq_d[l_ac].oofa011 = g_qryparam.return2 
            DISPLAY g_glaq_d[l_ac].glaq025 TO glaq025              #
            #DISPLAY g_glaq_d[l_ac].oofa011 TO oofa011 #全名
            NEXT FIELD glaq025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq027
            #add-point:ON ACTION controlp INFIELD glaq027 name="input.c.page1.glaq027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq028
            #add-point:ON ACTION controlp INFIELD glaq028 name="input.c.page1.glaq028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq051
            #add-point:ON ACTION controlp INFIELD glaq051 name="input.c.page1.glaq051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq052
            #add-point:ON ACTION controlp INFIELD glaq052 name="input.c.page1.glaq052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq053
            #add-point:ON ACTION controlp INFIELD glaq053 name="input.c.page1.glaq053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="input.c.page1.glaq029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030
            #add-point:ON ACTION controlp INFIELD glaq030 name="input.c.page1.glaq030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031
            #add-point:ON ACTION controlp INFIELD glaq031 name="input.c.page1.glaq031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032
            #add-point:ON ACTION controlp INFIELD glaq032 name="input.c.page1.glaq032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033
            #add-point:ON ACTION controlp INFIELD glaq033 name="input.c.page1.glaq033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034
            #add-point:ON ACTION controlp INFIELD glaq034 name="input.c.page1.glaq034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035
            #add-point:ON ACTION controlp INFIELD glaq035 name="input.c.page1.glaq035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036
            #add-point:ON ACTION controlp INFIELD glaq036 name="input.c.page1.glaq036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="input.c.page1.glaq037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038
            #add-point:ON ACTION controlp INFIELD glaq038 name="input.c.page1.glaq038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq011
            #add-point:ON ACTION controlp INFIELD glaq011 name="input.c.page1.glaq011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aapt300_14_bcl
               LET INT_FLAG = 0
               LET g_glaq_d[l_ac].* = g_glaq_d_t.*
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
               LET g_errparam.extend = g_glaq_d[l_ac].glaqld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glaq_d[l_ac].* = g_glaq_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt300_14_glaq_t_mask_restore('restore_mask_o')
 
               UPDATE glaq_t SET (glaqdocno,glaqld,glaqseq,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003, 
                   glaq004,glaq040,glaq041,glaq043,glaq044,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022, 
                   glaq023,glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,glaq029,glaq030,glaq031, 
                   glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq011) = (g_glaq_d[l_ac].glaqdocno, 
                   g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002, 
                   g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003, 
                   g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043, 
                   g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].glaq017,g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq019, 
                   g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq021,g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq023, 
                   g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq025,g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq028, 
                   g_glaq_d[l_ac].glaq051,g_glaq_d[l_ac].glaq052,g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq029, 
                   g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq031,g_glaq_d[l_ac].glaq032,g_glaq_d[l_ac].glaq033, 
                   g_glaq_d[l_ac].glaq034,g_glaq_d[l_ac].glaq035,g_glaq_d[l_ac].glaq036,g_glaq_d[l_ac].glaq037, 
                   g_glaq_d[l_ac].glaq038,g_glaq_d[l_ac].glaq011)
                WHERE glaqent = g_enterprise AND
                  glaqld = g_glaq_d_t.glaqld #項次   
                  AND glaqdocno = g_glaq_d_t.glaqdocno  
                  AND glaqseq = g_glaq_d_t.glaqseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glaq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d[g_detail_idx].glaqld
               LET gs_keys_bak[1] = g_glaq_d_t.glaqld
               LET gs_keys[2] = g_glaq_d[g_detail_idx].glaqdocno
               LET gs_keys_bak[2] = g_glaq_d_t.glaqdocno
               LET gs_keys[3] = g_glaq_d[g_detail_idx].glaqseq
               LET gs_keys_bak[3] = g_glaq_d_t.glaqseq
               CALL aapt300_14_update_b('glaq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_glaq_d_t)
                     LET g_log2 = util.JSON.stringify(g_glaq_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt300_14_glaq_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aapt300_14_unlock_b("glaq_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glaq_d[l_ac].* = g_glaq_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
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
               LET g_glaq_d[li_reproduce_target].* = g_glaq_d[li_reproduce].*
 
               LET g_glaq_d[li_reproduce_target].glaqld = NULL
               LET g_glaq_d[li_reproduce_target].glaqdocno = NULL
               LET g_glaq_d[li_reproduce_target].glaqseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glaq_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glaq_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
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
               NEXT FIELD glaqdocno
 
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
      IF INT_FLAG OR cl_null(g_glaq_d[g_detail_idx].glaqld) THEN
         CALL g_glaq_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_glaq_d[g_detail_idx].* = g_glaq_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aapt300_14_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt300_14_delete()
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
   FOR li_idx = 1 TO g_glaq_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aapt300_14_lock_b("glaq_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("glaq_t","") THEN
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
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
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_glaq_d.getLength()
      IF g_glaq_d[li_idx].glaqld IS NOT NULL
         AND g_glaq_d[li_idx].glaqdocno IS NOT NULL
         AND g_glaq_d[li_idx].glaqseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM glaq_t
          WHERE glaqent = g_enterprise AND 
                glaqld = g_glaq_d[li_idx].glaqld
                AND glaqdocno = g_glaq_d[li_idx].glaqdocno
                AND glaqseq = g_glaq_d[li_idx].glaqseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glaq_d_t.glaqld
               LET gs_keys[2] = g_glaq_d_t.glaqdocno
               LET gs_keys[3] = g_glaq_d_t.glaqseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aapt300_14_delete_b('glaq_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt300_14_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL aapt300_14_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt300_14_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_glaa015       LIKE glaa_t.glaa015 #啟用本位幣二
   DEFINE l_glaa016       LIKE glaa_t.glaa016 #本位幣二
   DEFINE l_glaa019       LIKE glaa_t.glaa019 #啟用本位幣三
   DEFINE l_glaa020       LIKE glaa_t.glaa020 #本位幣三
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_glaq002       STRING #科目編號
   DEFINE l_str1          STRING 
   DEFINE l_str2          STRING 
   DEFINE l_str21         STRING
   DEFINE l_str22         STRING
   DEFINE l_str23         STRING
   DEFINE l_str24         STRING
   DEFINE l_msg1          STRING
   DEFINE l_msg2          STRING
   DEFINE l_msg3          STRING
   DEFINE l_msg4          STRING
   DEFINE l_start_no      LIKE glap_t.glapdocno
   DEFINE l_end_no        LIKE glap_t.glapdocno
   DEFINE l_stus          LIKE apca_t.apcastus
   DEFINE l_cate          LIKE type_t.chr7
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_chr           LIKE type_t.chr1
   DEFINE g_ap_slip       LIKE ooba_t.ooba002      #應付帳款單單別
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   SELECT glaa015,glaa016,glaa019,glaa020,glaacomp
    INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020,l_glaacomp
    FROM glaa_t
   WHERE glaaent = g_enterprise
     AND glaald  = g_apcald
      
   LET l_str21 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str22 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str23 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str24 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str21 CLIPPED,l_glaa016 CLIPPED,l_str23
   LET l_msg2 = l_str22 CLIPPED,l_glaa016 CLIPPED,l_str23
   LET l_msg3 = l_str21 CLIPPED,l_glaa020 CLIPPED,l_str24
   LET l_msg4 = l_str22 CLIPPED,l_glaa020 CLIPPED,l_str24
      
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq040,glaq041',TRUE)
      CALL cl_set_comp_att_text('glaq040',l_msg1)
      CALL cl_set_comp_att_text('glaq041',l_msg2)
   ELSE
      CALL cl_set_comp_visible('glaq040,glaq041',FALSE)
   END IF
      
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq043,glaq044',TRUE)
      CALL cl_set_comp_att_text('glaq043',l_msg3)
      CALL cl_set_comp_att_text('glaq044',l_msg4)
   ELSE
      CALL cl_set_comp_visible('glaq043,glaq044',FALSE)
   END IF
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.glaqdocno,t0.glaqld,t0.glaqseq,t0.glaq001,t0.glaq002,t0.glaq005, 
       t0.glaq006,t0.glaq010,t0.glaq003,t0.glaq004,t0.glaq040,t0.glaq041,t0.glaq043,t0.glaq044,t0.glaq017, 
       t0.glaq018,t0.glaq019,t0.glaq020,t0.glaq021,t0.glaq022,t0.glaq023,t0.glaq024,t0.glaq025,t0.glaq027, 
       t0.glaq028,t0.glaq051,t0.glaq052,t0.glaq053,t0.glaq029,t0.glaq030,t0.glaq031,t0.glaq032,t0.glaq033, 
       t0.glaq034,t0.glaq035,t0.glaq036,t0.glaq037,t0.glaq038,t0.glaq011  FROM glaq_t t0",
               "",
               
               " WHERE t0.glaqent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("glaq_t"),
                      " ORDER BY t0.glaqld,t0.glaqdocno,t0.glaqseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   IF g_prog[1,5] <> 'aapt9' THEN #150320
      CALL s_aooi200_fin_get_slip(g_apcadocno) RETURNING g_sub_success,g_ap_slip    
      CALL s_fin_get_doc_para(g_apcald,l_glaacomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr
   #150320 add ------
   ELSE
      LET l_chr = 'Y'
   END IF
   #150320 add end---
   IF l_chr = 'Y' THEN
      CALL s_transaction_begin()
   
      CASE     
          WHEN g_prog[1,5] = 'aapt3'
               LET l_cate = "P10"
               LET g_wc = "apcadocno = '",g_apcadocno,"'"
               SELECT apcastus INTO l_stus 
                 FROM apca_t
                WHERE apcaent = g_enterprise AND apcald = g_apcald
                  AND apcadocno = g_apcadocno
   
          WHEN g_prog[1,6] = 'aapt42'
               LET l_cate = "P20"
               LET g_wc = "apdadocno = '",g_apcadocno,"'"
               SELECT apdastus INTO l_stus 
                 FROM apda_t
                WHERE apdaent = g_enterprise AND apdald = g_apcald
                  AND apdadocno = g_apcadocno 
          
          WHEN g_prog[1,6] = 'aapt43'
               LET l_cate = "P30"
               LET g_wc = "apdadocno = '",g_apcadocno,"'"
               SELECT apdastus INTO l_stus 
                 FROM apda_t
                WHERE apdaent = g_enterprise AND apdald = g_apcald
                  AND apdadocno = g_apcadocno
         
          WHEN g_prog[1,6] = 'aapt92'
               LET l_cate = "P40"
               LET g_wc = "xregdocno = '",g_apcadocno,"'"
               SELECT xregstus INTO l_stus 
                 FROM xreg_t
                WHERE xregent = g_enterprise AND xregld = g_apcald
                  AND xregdocno = g_apcadocno          
                  
         WHEN g_prog[1,6] = 'aapt93'
               IF g_prog = 'aapt930' THEN
                  LET l_cate = 'P50'
               ELSE
                  LET l_cate = 'P51'
               END IF
               LET g_wc = "xremdocno = '",g_apcadocno,"'"
               
               SELECT xremstus INTO l_stus 
                 FROM xrem_t
                WHERE xrement = g_enterprise AND xremld = g_apcald
                  AND xremdocno = g_apcadocno
          WHEN g_prog[1,6] = 'aapt94'
               LET l_cate = 'P60'
               LET g_wc = "xrejdocno = '",g_apcadocno,"'"
               
               SELECT xrejstus INTO l_stus 
                 FROM xrej_t
                WHERE xrejent = g_enterprise AND xrejld = g_apcald
                  AND xrejdocno = g_apcadocno                  
      END CASE
      
      CALL s_aapp330_gen_ac('1',l_cate,g_apcald,'','','1',g_wc,l_stus) RETURNING g_sub_success,l_start_no,l_end_no

      IF g_sub_success THEN
         CALL s_transaction_end('Y','Y')
      ELSE
         CALL s_transaction_end('N','Y')
      END IF
   END IF
   
   ##主SQL
   LET g_sql= " SELECT  docno,glaqld ,glaqseq ,glaq001,",
              "        glaq002,glaq005,glaq006,glaq010,      d,",
              "              c,glaq040,glaq041,glaq043,glaq044,",
              "        glaq017,glaq018,glaq019,glaq020,glaq021,",
              "        glaq022,glaq023,glaq024,glaq025,glaq027,",
              "        glaq028,glaq051,glaq052,glaq053,glaq029,",
              "        glaq030,glaq031,glaq032,glaq033,glaq034,",
              "        glaq035,glaq036,glaq037,glaq038,glgb055 ",
              "   FROM s_voucher_tmp ",
              "  WHERE glaqent = ? AND type = '2'",               #g_sql重寫迴避：OPEN b_fill_curs
              "  ORDER BY glaq001"   

   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glaq_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapt300_14_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapt300_14_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001, 
       g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003, 
       g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044, 
       g_glaq_d[l_ac].glaq017,g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq019,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq021, 
       g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq023,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq025,g_glaq_d[l_ac].glaq027, 
       g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glaq051,g_glaq_d[l_ac].glaq052,g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq029, 
       g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq031,g_glaq_d[l_ac].glaq032,g_glaq_d[l_ac].glaq033,g_glaq_d[l_ac].glaq034, 
       g_glaq_d[l_ac].glaq035,g_glaq_d[l_ac].glaq036,g_glaq_d[l_ac].glaq037,g_glaq_d[l_ac].glaq038,g_glaq_d[l_ac].glaq011 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL aapt300_14_glaq002_desc(g_glaq_d[l_ac].glaq002) RETURNING l_str1,l_str2   
      
      LET g_glaq_d[l_ac].glacl004 = g_glaq_d[l_ac].glaq002,"(",l_str1,")",'\n',
                                    s_desc_get_account_desc(g_apcald,g_glaq_d[l_ac].glaq002),'\n',
                                    l_str2
      
      IF g_glaq_d[l_ac].glaq003 = 0 THEN LET g_glaq_d[l_ac].glaq003 = '' END IF
      IF g_glaq_d[l_ac].glaq004 = 0 THEN LET g_glaq_d[l_ac].glaq004 = '' END IF
                                                            
      #end add-point
      
      CALL aapt300_14_detail_show()      
 
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
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glaq_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_glaq_d.getLength() THEN
      LET l_ac = g_glaq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glaq_d.getLength()
      LET g_glaq_d_mask_o[l_ac].* =  g_glaq_d[l_ac].*
      CALL aapt300_14_glaq_t_mask()
      LET g_glaq_d_mask_n[l_ac].* =  g_glaq_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_glaq_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aapt300_14_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapt300_14_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
 
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt300_14_set_entry_b(p_cmd)                                                  
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
 
{<section id="aapt300_14.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt300_14_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aapt300_14.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt300_14_default_search()
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
      LET ls_wc = ls_wc, " glaqld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glaqdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glaqseq = '", g_argv[03], "' AND "
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
 
{<section id="aapt300_14.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt300_14_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "glaq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'glaq_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM glaq_t
          WHERE glaqent = g_enterprise AND
            glaqld = ps_keys_bak[1] AND glaqdocno = ps_keys_bak[2] AND glaqseq = ps_keys_bak[3]
         
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
         CALL g_glaq_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt300_14_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "glaq_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO glaq_t
                  (glaqent,
                   glaqld,glaqdocno,glaqseq
                   ,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006, 
                       g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040, 
                       g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].glaq017, 
                       g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq019,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq021, 
                       g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq023,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq025, 
                       g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glaq051,g_glaq_d[l_ac].glaq052, 
                       g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq029,g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq031, 
                       g_glaq_d[l_ac].glaq032,g_glaq_d[l_ac].glaq033,g_glaq_d[l_ac].glaq034,g_glaq_d[l_ac].glaq035, 
                       g_glaq_d[l_ac].glaq036,g_glaq_d[l_ac].glaq037,g_glaq_d[l_ac].glaq038,g_glaq_d[l_ac].glaq011) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt300_14_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "glaq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "glaq_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE glaq_t 
         SET (glaqld,glaqdocno,glaqseq
              ,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glaq011) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006, 
                  g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040, 
                  g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].glaq017, 
                  g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq019,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq021, 
                  g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq023,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq025, 
                  g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glaq051,g_glaq_d[l_ac].glaq052, 
                  g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq029,g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq031, 
                  g_glaq_d[l_ac].glaq032,g_glaq_d[l_ac].glaq033,g_glaq_d[l_ac].glaq034,g_glaq_d[l_ac].glaq035, 
                  g_glaq_d[l_ac].glaq036,g_glaq_d[l_ac].glaq037,g_glaq_d[l_ac].glaq038,g_glaq_d[l_ac].glaq011)  
 
         WHERE glaqent = g_enterprise AND glaqld = ps_keys_bak[1] AND glaqdocno = ps_keys_bak[2] AND glaqseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt300_14_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aapt300_14_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "glaq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt300_14_bcl USING g_enterprise,
                                       g_glaq_d[g_detail_idx].glaqld,g_glaq_d[g_detail_idx].glaqdocno, 
                                           g_glaq_d[g_detail_idx].glaqseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt300_14_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt300_14_unlock_b(ps_table)
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
      CLOSE aapt300_14_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aapt300_14_modify_detail_chk(ps_record)
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
         LET ls_return = "glaqdocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aapt300_14.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aapt300_14_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aapt300_14.mask_functions" >}
&include "erp/aap/aapt300_14_mask.4gl"
 
{</section>}
 
{<section id="aapt300_14.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt300_14_set_pk_array()
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
   LET g_pk_array[1].values = g_glaq_d[l_ac].glaqld
   LET g_pk_array[1].column = 'glaqld'
   LET g_pk_array[2].values = g_glaq_d[l_ac].glaqdocno
   LET g_pk_array[2].column = 'glaqdocno'
   LET g_pk_array[3].values = g_glaq_d[l_ac].glaqseq
   LET g_pk_array[3].column = 'glaqseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt300_14.state_change" >}
   
 
{</section>}
 
{<section id="aapt300_14.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt300_14.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 組合說明字串
# Memo...........:
# Usage..........: CALL aapt300_14_glaq002_desc(p_glaq002)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_14_glaq002_desc(p_glaq002)
DEFINE p_glaq002       LIKE glaq_t.glaq002
DEFINE l_str1          STRING
DEFINE l_str2          STRING
DEFINE r_desc1         STRING
DEFINE r_desc2         STRING

   
   #營運據點 
   IF NOT cl_null(g_glaq_d[l_ac].glaq017) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq017
      LET l_str2 = s_desc_get_department_desc(g_glaq_d[l_ac].glaq017)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
   #部門
   IF NOT cl_null(g_glaq_d[l_ac].glaq018) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq018
      LET l_str2 = s_desc_get_department_desc(g_glaq_d[l_ac].glaq018)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
   #利潤中心
   IF NOT cl_null(g_glaq_d[l_ac].glaq019) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq019
      LET l_str2 = s_desc_get_department_desc(g_glaq_d[l_ac].glaq019)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
   #區域
   IF NOT cl_null(g_glaq_d[l_ac].glaq020) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq020
      LET l_str2 = s_desc_get_acc_desc('287',g_glaq_d[l_ac].glaq020)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
   #交易客商
   IF NOT cl_null(g_glaq_d[l_ac].glaq021) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq021
      LET l_str2 = s_desc_get_trading_partner_abbr_desc(g_glaq_d[l_ac].glaq021)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF 
   #帳款客戶
   IF NOT cl_null(g_glaq_d[l_ac].glaq022) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq022
      LET l_str2 = s_desc_get_trading_partner_abbr_desc(g_glaq_d[l_ac].glaq022)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
   #客群
   IF NOT cl_null(g_glaq_d[l_ac].glaq023) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq023
      LET l_str2 = s_desc_get_acc_desc('281',g_glaq_d[l_ac].glaq023)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
   #產品類別
   IF NOT cl_null(g_glaq_d[l_ac].glaq024) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq024
      LET l_str2 = s_desc_get_rtaxl003_desc(g_glaq_d[l_ac].glaq024)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
   #人員
   IF NOT cl_null(g_glaq_d[l_ac].glaq025) THEN
      LET l_str1 = g_glaq_d[l_ac].glaq025
      LET l_str2 = s_desc_get_person_desc(g_glaq_d[l_ac].glaq025)
      CALL aapt300_14_desc_conjunctive(l_str1,r_desc1) RETURNING r_desc1
      CALL aapt300_14_desc_conjunctive(l_str2,r_desc2) RETURNING r_desc2
   END IF
  
   RETURN r_desc1,r_desc2
 

END FUNCTION

################################################################################
# Descriptions...: 下方單身
# Memo...........:
# Usage..........: CALL aapt300_14_b_detail
# Date & Author..: 2014/09/15 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_14_b_detail()
DEFINE l_glad         RECORD
                      glad0171    LIKE  glad_t.glad0171, 
                      glad0172    LIKE  glad_t.glad0172,
                      glad0181    LIKE  glad_t.glad0181,
                      glad0182    LIKE  glad_t.glad0182,
                      glad0191    LIKE  glad_t.glad0191,
                      glad0192    LIKE  glad_t.glad0192,
                      glad0201    LIKE  glad_t.glad0201,
                      glad0202    LIKE  glad_t.glad0202,
                      glad0211    LIKE  glad_t.glad0211,
                      glad0212    LIKE  glad_t.glad0212,
                      glad0221    LIKE  glad_t.glad0221,
                      glad0222    LIKE  glad_t.glad0222,
                      glad0231    LIKE  glad_t.glad0231,
                      glad0232    LIKE  glad_t.glad0232,
                      glad0241    LIKE  glad_t.glad0241,
                      glad0242    LIKE  glad_t.glad0242,
                      glad0251    LIKE  glad_t.glad0251,
                      glad0252    LIKE  glad_t.glad0252,
                      glad0261    LIKE  glad_t.glad0261,
                      glad0262    LIKE  glad_t.glad0262
                  END RECORD
DEFINE l_glaa005      LIKE glaa_t.glaa005   #現金變動碼參照表   #150209-00008#2

   #150209-00008#2--(S)
   SELECT glaa005
     INTO l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_apcald
   #150209-00008#2--(E)
   CALL s_fin_sel_glad(g_apcald,g_glaq_d[g_detail_idx].glaq002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262')
        RETURNING g_errno,l_glad.*
   INITIALIZE g_detail_m.* LIKE glaq_t.* 
   
   LET g_detail_m.glaq0171_desc = g_glaq_d[g_detail_idx].glaq017
   CALL s_desc_get_department_desc(g_glaq_d[g_detail_idx].glaq017)RETURNING g_detail_m.glaq017_desc
   
   LET g_detail_m.glaq0181_desc = g_glaq_d[g_detail_idx].glaq018
   CALL s_desc_get_department_desc(g_glaq_d[g_detail_idx].glaq018)RETURNING g_detail_m.glaq018_desc
   
   LET g_detail_m.glaq0191_desc = g_glaq_d[g_detail_idx].glaq019
   CALL s_desc_get_department_desc(g_glaq_d[g_detail_idx].glaq019)RETURNING g_detail_m.glaq019_desc
   
   LET g_detail_m.glaq0201_desc = g_glaq_d[g_detail_idx].glaq020
   CALL s_desc_get_acc_desc('287',g_glaq_d[g_detail_idx].glaq020)RETURNING g_detail_m.glaq020_desc
   
   LET g_detail_m.glaq0211_desc = g_glaq_d[g_detail_idx].glaq021
   CALL s_desc_get_trading_partner_abbr_desc(g_glaq_d[g_detail_idx].glaq021)RETURNING g_detail_m.glaq021_desc
   
   LET g_detail_m.glaq0221_desc = g_glaq_d[g_detail_idx].glaq022
   CALL s_desc_get_trading_partner_abbr_desc(g_glaq_d[g_detail_idx].glaq022)RETURNING g_detail_m.glaq022_desc
   
   LET g_detail_m.glaq0231_desc = g_glaq_d[g_detail_idx].glaq023
   CALL s_desc_get_acc_desc('281',g_glaq_d[g_detail_idx].glaq023) RETURNING g_detail_m.glaq023_desc
   
   LET g_detail_m.glaq0241_desc = g_glaq_d[g_detail_idx].glaq024
   CALL s_desc_get_rtaxl003_desc(g_glaq_d[g_detail_idx].glaq024)  RETURNING g_detail_m.glaq024_desc
   
   LET g_detail_m.glaq0251_desc = g_glaq_d[g_detail_idx].glaq025
   CALL s_desc_get_person_desc(g_glaq_d[g_detail_idx].glaq025)    RETURNING g_detail_m.glaq025_desc
   
   LET g_detail_m.glaq0271_desc = g_glaq_d[g_detail_idx].glaq027
     
   LET g_detail_m.glaq0281_desc = g_glaq_d[g_detail_idx].glaq028
   LET g_detail_m.glaq0511_desc = g_glaq_d[g_detail_idx].glaq051
   LET g_detail_m.glaq0521_desc = g_glaq_d[g_detail_idx].glaq052
   LET g_detail_m.glaq0531_desc = g_glaq_d[g_detail_idx].glaq053
  
   #自由核算項1
   LET g_detail_m.glaq0291_desc = g_glaq_d[g_detail_idx].glaq029
   CALL s_fin_get_accting_desc(l_glad.glad0171,g_glaq_d[g_detail_idx].glaq029)    RETURNING g_detail_m.glaq029_desc
   
   #自由核算項2
   LET g_detail_m.glaq0301_desc = g_glaq_d[g_detail_idx].glaq030
   CALL s_fin_get_accting_desc(l_glad.glad0181,g_glaq_d[g_detail_idx].glaq030)    RETURNING g_detail_m.glaq030_desc
   
   #自由核算項3
   LET g_detail_m.glaq0311_desc = g_glaq_d[g_detail_idx].glaq031
   CALL s_fin_get_accting_desc(l_glad.glad0191,g_glaq_d[g_detail_idx].glaq031)    RETURNING g_detail_m.glaq031_desc
   
   #自由核算項4
   LET g_detail_m.glaq0321_desc = g_glaq_d[g_detail_idx].glaq032
   CALL s_fin_get_accting_desc(l_glad.glad0201,g_glaq_d[g_detail_idx].glaq032)    RETURNING g_detail_m.glaq032_desc
   
   #自由核算項5
   LET g_detail_m.glaq0331_desc = g_glaq_d[g_detail_idx].glaq033
   CALL s_fin_get_accting_desc(l_glad.glad0211,g_glaq_d[g_detail_idx].glaq033)    RETURNING g_detail_m.glaq033_desc
   
   #自由核算項6
   LET g_detail_m.glaq0341_desc = g_glaq_d[g_detail_idx].glaq034
   CALL s_fin_get_accting_desc(l_glad.glad0221,g_glaq_d[g_detail_idx].glaq034)    RETURNING g_detail_m.glaq034_desc
   
   #自由核算項7
   LET g_detail_m.glaq0351_desc = g_glaq_d[g_detail_idx].glaq035
   CALL s_fin_get_accting_desc(l_glad.glad0231,g_glaq_d[g_detail_idx].glaq035)    RETURNING g_detail_m.glaq035_desc
   
   #自由核算項8
   LET g_detail_m.glaq0361_desc = g_glaq_d[g_detail_idx].glaq036
   CALL s_fin_get_accting_desc(l_glad.glad0241,g_glaq_d[g_detail_idx].glaq036)    RETURNING g_detail_m.glaq036_desc
   
   #自由核算項9
   LET g_detail_m.glaq0371_desc = g_glaq_d[g_detail_idx].glaq037
   CALL s_fin_get_accting_desc(l_glad.glad0251,g_glaq_d[g_detail_idx].glaq037)    RETURNING g_detail_m.glaq037_desc
   
   #自由核算項10
   LET g_detail_m.glaq0381_desc = g_glaq_d[g_detail_idx].glaq038
   CALL s_fin_get_accting_desc(l_glad.glad0261,g_glaq_d[g_detail_idx].glaq038)    RETURNING g_detail_m.glaq038_desc
   
   #現金變動碼--#150209-00008#2  
   LET g_detail_m.glgb0551_desc = g_glaq_d[g_detail_idx].glaq011
   CALL s_desc_get_nmail004_desc(l_glaa005,g_detail_m.glgb0551_desc) RETURNING g_detail_m.glgb055_desc            

   DISPLAY BY NAME g_detail_m.glaq0171_desc,g_detail_m.glaq017_desc,g_detail_m.glaq0181_desc,g_detail_m.glaq018_desc,
                   g_detail_m.glaq0191_desc,g_detail_m.glaq019_desc,g_detail_m.glaq0201_desc,g_detail_m.glaq020_desc,
                   g_detail_m.glaq0211_desc,g_detail_m.glaq021_desc,g_detail_m.glaq0221_desc,g_detail_m.glaq022_desc,
                   g_detail_m.glaq0231_desc,g_detail_m.glaq023_desc,g_detail_m.glaq0241_desc,g_detail_m.glaq024_desc,
                   g_detail_m.glaq0251_desc,g_detail_m.glaq025_desc,g_detail_m.glaq0271_desc,g_detail_m.glaq027_desc,
                   g_detail_m.glaq0281_desc,g_detail_m.glaq028_desc,g_detail_m.glaq0511_desc,
                   g_detail_m.glaq0521_desc,g_detail_m.glaq052_desc,g_detail_m.glaq0531_desc,g_detail_m.glaq053_desc,
                   g_detail_m.glaq0291_desc,g_detail_m.glaq029_desc,g_detail_m.glaq0301_desc,g_detail_m.glaq030_desc,
                   g_detail_m.glaq0311_desc,g_detail_m.glaq031_desc,g_detail_m.glaq0321_desc,g_detail_m.glaq032_desc,
                   g_detail_m.glaq0331_desc,g_detail_m.glaq033_desc,g_detail_m.glaq0341_desc,g_detail_m.glaq034_desc,
                   g_detail_m.glaq0351_desc,g_detail_m.glaq035_desc,g_detail_m.glaq0361_desc,g_detail_m.glaq036_desc,
                   g_detail_m.glaq0371_desc,g_detail_m.glaq037_desc,g_detail_m.glaq0381_desc,g_detail_m.glaq038_desc,
                   g_detail_m.glgb0551_desc,g_detail_m.glgb055_desc
          
END FUNCTION

################################################################################
# Descriptions...: 連接語句
# Memo...........:
# Usage..........: CALL aapt300_14_desc_conjunctive(p_str,p_desc)
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt300_14_desc_conjunctive(p_str,p_desc)
DEFINE p_str      STRING
DEFINE p_desc     STRING
DEFINE r_desc     STRING

   WHENEVER ERROR CONTINUE
   IF cl_null(p_str) THEN
      RETURN p_desc
   END IF
   IF cl_null(p_desc) THEN
      LET r_desc = p_str
   ELSE
      LET r_desc = p_str,"-",p_desc
   END IF

   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 現金變動碼
# Memo...........:
# Usage..........: CALL aapt300_14_glgb055()
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt300_14_glgb055()
DEFINE l_glaq011_t      LIKE glaq_t.glaq011
DEFINE l_glgb055        LIKE glgb_t.glgb055
DEFINE l_glaa005        LIKE glaa_t.glaa005

   WHENEVER ERROR CONTINUE
   IF NOT g_detail_idx > 0 THEN RETURN END IF
   SELECT glaa005 INTO l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_apcald
   LET l_glaq011_t = g_glaq_d[g_detail_idx].glaq011
   INPUT g_glaq_d[g_detail_idx].glaq011 FROM glgb0551_desc
   
       AFTER FIELD glgb0551_desc
         IF NOT cl_null(g_glaq_d[g_detail_idx].glaq011) THEN
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_glaq_d[g_detail_idx].glaq011
            LET g_chkparam.arg2 = l_glaa005
            IF NOT cl_chk_exist("v_nmai002") THEN
               LET g_glaq_d[g_detail_idx].glaq011 = l_glaq011_t
               CALL s_desc_get_nmail004_desc(l_glaa005,g_glaq_d[g_detail_idx].glaq011) RETURNING g_detail_m.glgb055_desc
               DISPLAY BY NAME g_detail_m.glgb055_desc
               NEXT FIELD CURRENT
            END IF
         END IF
         CALL s_desc_get_nmail004_desc(l_glaa005,g_glaq_d[g_detail_idx].glaq011) RETURNING g_detail_m.glgb055_desc                      
         DISPLAY BY NAME g_detail_m.glgb055_desc
            
       ON ACTION controlp INFIELD glgb0551_desc
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
          LET g_qryparam.reqry = FALSE
          LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
          LET g_qryparam.default1 = g_glaq_d[g_detail_idx].glaq011
          CALL q_nmai002()
          LET g_glaq_d[g_detail_idx].glaq011 = g_qryparam.return1
          DISPLAY g_glaq_d[g_detail_idx].glaq011 TO glgb055 
          CALL s_desc_get_nmail004_desc(l_glaa005,g_glaq_d[g_detail_idx].glaq011) RETURNING g_detail_m.glgb055_desc                      
          DISPLAY BY NAME g_detail_m.glgb0551_desc,g_detail_m.glgb055_desc    
          NEXT FIELD CURRENT
      
      AFTER INPUT
         CALL s_transaction_begin()
         #要以科目核算項啟用否回寫
         UPDATE s_voucher_tmp 
            SET glgb055 = g_glaq_d[g_detail_idx].glaq011
          WHERE glaq002 = g_glaq_d[g_detail_idx].glaq002
            AND glaq021 = g_glaq_d[g_detail_idx].glaq021
            AND glaq022 = g_glaq_d[g_detail_idx].glaq022
            AND type = 2
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
            OTHERWISE
               CALL s_transaction_end('Y','0')
         END CASE
      ON ACTION accept
         ACCEPT INPUT
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT INPUT
         
   END INPUT  
END FUNCTION

 
{</section>}
 
