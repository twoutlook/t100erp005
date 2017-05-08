#該程式未解開Section, 採用最新樣板產出!
{<section id="arti500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-04-14 10:19:18), PR版次:0006(2016-10-25 14:27:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: arti500
#+ Description: 標價籤模板設定作業
#+ Creator....: 06189(2015-06-16 11:51:39)
#+ Modifier...: 06540 -SD/PR- 03247
 
{</section>}
 
{<section id="arti500.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#44 2016/04/26  By 07959  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161024-00025#1  2016/10/24  By dongsz   rtdz002编辑开窗改为q_ooef001_24，条件：ooef304='Y'；对应栏位检查同步修改
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
PRIVATE TYPE type_g_rtdy_d RECORD
       rtdystus LIKE rtdy_t.rtdystus, 
   rtdy001 LIKE rtdy_t.rtdy001, 
   rtdyl003 LIKE rtdyl_t.rtdyl003, 
   rtdy002 LIKE rtdy_t.rtdy002, 
   rtdy003 LIKE rtdy_t.rtdy003, 
   rtdy004 LIKE rtdy_t.rtdy004
       END RECORD
PRIVATE TYPE type_g_rtdy2_d RECORD
       rtdy001 LIKE rtdy_t.rtdy001, 
   rtdyownid LIKE rtdy_t.rtdyownid, 
   rtdyownid_desc LIKE type_t.chr500, 
   rtdyowndp LIKE rtdy_t.rtdyowndp, 
   rtdyowndp_desc LIKE type_t.chr500, 
   rtdycrtid LIKE rtdy_t.rtdycrtid, 
   rtdycrtid_desc LIKE type_t.chr500, 
   rtdycrtdp LIKE rtdy_t.rtdycrtdp, 
   rtdycrtdp_desc LIKE type_t.chr500, 
   rtdycrtdt DATETIME YEAR TO SECOND, 
   rtdymodid LIKE rtdy_t.rtdymodid, 
   rtdymodid_desc LIKE type_t.chr500, 
   rtdymoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_rtdy3_d RECORD
       rtdzstus LIKE type_t.chr10, 
   rtdz001 LIKE type_t.chr10, 
   rtdz002 LIKE type_t.chr10, 
   rtdz002_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_rtdy4_d RECORD
       rtdz001 LIKE rtdz_t.rtdz001, 
   rtdz002 LIKE rtdz_t.rtdz002, 
   rtdzownid LIKE type_t.chr20, 
   rtdzownid_desc LIKE type_t.chr500, 
   rtdzowndp LIKE type_t.chr10, 
   rtdzowndp_desc LIKE type_t.chr500, 
   rtdzcrtid LIKE type_t.chr20, 
   rtdzcrtid_desc LIKE type_t.chr500, 
   rtdzcrtdp LIKE type_t.chr10, 
   rtdzcrtdp_desc LIKE type_t.chr500, 
   rtdzcrtdt LIKE type_t.dat, 
   rtdzmodid LIKE type_t.chr20, 
   rtdzmodid_desc LIKE type_t.chr500, 
   rtdzmoddt LIKE type_t.dat
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      rtdyl001 LIKE rtdyl_t.rtdyl001,
      rtdyl002 LIKE rtdyl_t.rtdyl002,
      rtdyl003 LIKE rtdyl_t.rtdyl003
      END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_rtdy_d
DEFINE g_master_t                   type_g_rtdy_d
DEFINE g_rtdy_d          DYNAMIC ARRAY OF type_g_rtdy_d
DEFINE g_rtdy_d_t        type_g_rtdy_d
DEFINE g_rtdy_d_o        type_g_rtdy_d
DEFINE g_rtdy_d_mask_o   DYNAMIC ARRAY OF type_g_rtdy_d #轉換遮罩前資料
DEFINE g_rtdy_d_mask_n   DYNAMIC ARRAY OF type_g_rtdy_d #轉換遮罩後資料
DEFINE g_rtdy2_d          DYNAMIC ARRAY OF type_g_rtdy2_d
DEFINE g_rtdy2_d_t        type_g_rtdy2_d
DEFINE g_rtdy2_d_o        type_g_rtdy2_d
DEFINE g_rtdy2_d_mask_o   DYNAMIC ARRAY OF type_g_rtdy2_d #轉換遮罩前資料
DEFINE g_rtdy2_d_mask_n   DYNAMIC ARRAY OF type_g_rtdy2_d #轉換遮罩後資料
DEFINE g_rtdy3_d          DYNAMIC ARRAY OF type_g_rtdy3_d
DEFINE g_rtdy3_d_t        type_g_rtdy3_d
DEFINE g_rtdy3_d_o        type_g_rtdy3_d
DEFINE g_rtdy3_d_mask_o   DYNAMIC ARRAY OF type_g_rtdy3_d #轉換遮罩前資料
DEFINE g_rtdy3_d_mask_n   DYNAMIC ARRAY OF type_g_rtdy3_d #轉換遮罩後資料
DEFINE g_rtdy4_d          DYNAMIC ARRAY OF type_g_rtdy4_d
DEFINE g_rtdy4_d_t        type_g_rtdy4_d
DEFINE g_rtdy4_d_o        type_g_rtdy4_d
DEFINE g_rtdy4_d_mask_o   DYNAMIC ARRAY OF type_g_rtdy4_d #轉換遮罩前資料
DEFINE g_rtdy4_d_mask_n   DYNAMIC ARRAY OF type_g_rtdy4_d #轉換遮罩後資料
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             
DEFINE g_ac_last            LIKE type_t.num10             
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_detail_idx         LIKE type_t.num10             #單身所在筆數(第一階單身)
DEFINE g_detail_idx2        LIKE type_t.num10             #單身所在筆數(第二階單身)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身總筆數 (第一階單身)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身總筆數 (第二階單身)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_current_page       LIKE type_t.num10             #判斷單身筆數用
DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="arti500.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti500 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti500_init()   
 
      #進入選單 Menu (="N")
      CALL arti500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti500
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table() 
   CALL s_aooi500_drop_temp() RETURNING l_success #add by geza 20151231
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti500.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION arti500_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5  #add by geza 20151231
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   
   
   LET l_ac = 1
   
LET g_detail_multi_table_t.rtdyl001 = g_rtdy_d[l_ac].rtdy001
LET g_detail_multi_table_t.rtdyl002 = g_dlang
LET g_detail_multi_table_t.rtdyl003 = g_rtdy_d[l_ac].rtdyl003
 
 
   
LET g_detail_multi_table_t.rtdyl001 = g_rtdy_d[l_ac].rtdy001
LET g_detail_multi_table_t.rtdyl002 = g_dlang
LET g_detail_multi_table_t.rtdyl003 = g_rtdy_d[l_ac].rtdyl003
 
 
   
 
 
   
 
 
 
   #避免USER直接進入第二單身時無資料
   IF g_rtdy_d.getLength() > 0 THEN
      LET g_master_t.* = g_rtdy_d[1].*
      LET g_master.* = g_rtdy_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success  #add by geza 20151231
   CALL cl_set_combo_scc('rtdy004','6921')  #lanjj add on 2016-04-14 促销方式
   #end add-point
   
   CALL arti500_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION arti500_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num10
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_url                   STRING
   DEFINE l_code                  STRING
   DEFINE l_cnt         LIKE type_t.num10 
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtdy_d.clear()
         CALL g_rtdy2_d.clear()
         CALL g_rtdy3_d.clear()
         CALL g_rtdy4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL arti500_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      LET g_wc = ' 1=1'
      #end add-point
   
      CALL arti500_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtdy_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 1
      
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_rtdy_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL arti500_fetch()
               CALL arti500_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL arti500_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_rtdy2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 2
               
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_master.* = g_rtdy_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL arti500_fetch()
               CALL arti500_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL arti500_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_rtdy3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 3
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               CALL arti500_idx_chk('d')
               LET g_master.* = g_rtdy_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
         DISPLAY ARRAY g_rtdy4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 4
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               CALL arti500_idx_chk('d')
               LET g_master.* = g_rtdy_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_4)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_rtdy_d.getLength() THEN
                  LET g_detail_idx = g_rtdy_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point  
            NEXT FIELD CURRENT
        
         AFTER DIALOG
            #add-point:ui_dialog段after dialog name="ui_dialog.after_dialog"
            
            #end add-point
         
      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         IF cl_auth_chk_act("exporttoexcel") THEN
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_rtdy_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_rtdy2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_rtdy3_d)
            LET g_export_id[3]   = "s_detail3"
            LET g_export_node[4] = base.typeInfo.create(g_rtdy4_d)
            LET g_export_id[4]   = "s_detail4"
 
            #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
            
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
         
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL arti500_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL arti500_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL arti500_insert()
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
         ON ACTION get_date
            LET g_action_choice="get_date"
            IF cl_auth_chk_act("get_date") THEN
               
               #add-point:ON ACTION get_date name="menu.get_date"
               LET l_cnt = g_rtdy_d.getLength()
               IF l_cnt > 0 THEN 
                  IF l_ac = 0 THEN
                     LET l_ac = 1 
                  END IF
                  LET l_code = g_rtdy_d[l_ac].rtdy001  #模版編號
                  LET l_url = FGL_GETENV("FGLASIP"),"/components/tag/index.html"
                  LET l_url = l_url, "?id=", l_code
                  
                  CALL ui.Interface.frontCall("standard", "launchurl", [l_url], [])
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00626'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  EXIT DIALOG
               END IF   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL arti500_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
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
            CALL arti500_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti500_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti500_set_pk_array()
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
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="arti500.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti500_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_rtdy_d.clear()
   CALL g_rtdy2_d.clear()
   CALL g_rtdy3_d.clear()
   CALL g_rtdy4_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON rtdystus,rtdy001,rtdyl003,rtdy002,rtdy003,rtdy004,rtdyownid,rtdyowndp, 
          rtdycrtid,rtdycrtdp,rtdycrtdt,rtdymodid,rtdymoddt
           FROM s_detail1[1].rtdystus,s_detail1[1].rtdy001,s_detail1[1].rtdyl003,s_detail1[1].rtdy002, 
               s_detail1[1].rtdy003,s_detail1[1].rtdy004,s_detail2[1].rtdyownid,s_detail2[1].rtdyowndp, 
               s_detail2[1].rtdycrtid,s_detail2[1].rtdycrtdp,s_detail2[1].rtdycrtdt,s_detail2[1].rtdymodid, 
               s_detail2[1].rtdymoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtdycrtdt>>----
         AFTER FIELD rtdycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdymoddt>>----
         AFTER FIELD rtdymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdycnfdt>>----
         
         #----<<rtdypstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdystus
            #add-point:BEFORE FIELD rtdystus name="construct.b.page1.rtdystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdystus
            
            #add-point:AFTER FIELD rtdystus name="construct.a.page1.rtdystus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdystus
            #add-point:ON ACTION controlp INFIELD rtdystus name="construct.c.page1.rtdystus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy001
            #add-point:BEFORE FIELD rtdy001 name="construct.b.page1.rtdy001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy001
            
            #add-point:AFTER FIELD rtdy001 name="construct.a.page1.rtdy001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdy001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy001
            #add-point:ON ACTION controlp INFIELD rtdy001 name="construct.c.page1.rtdy001"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'c'      #sakura add
            LET g_qryparam.reqry = FALSE
           
            CALL q_rtdy001()                           #呼叫開窗
           #LET g_qryparam.where = NULL #sakura mark
            DISPLAY g_qryparam.return1 TO rtdy001  #顯示到畫面上

            NEXT FIELD rtdy001 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdyl003
            #add-point:BEFORE FIELD rtdyl003 name="construct.b.page1.rtdyl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdyl003
            
            #add-point:AFTER FIELD rtdyl003 name="construct.a.page1.rtdyl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdyl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdyl003
            #add-point:ON ACTION controlp INFIELD rtdyl003 name="construct.c.page1.rtdyl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy002
            #add-point:BEFORE FIELD rtdy002 name="construct.b.page1.rtdy002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy002
            
            #add-point:AFTER FIELD rtdy002 name="construct.a.page1.rtdy002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdy002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy002
            #add-point:ON ACTION controlp INFIELD rtdy002 name="construct.c.page1.rtdy002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy003
            #add-point:BEFORE FIELD rtdy003 name="construct.b.page1.rtdy003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy003
            
            #add-point:AFTER FIELD rtdy003 name="construct.a.page1.rtdy003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdy003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy003
            #add-point:ON ACTION controlp INFIELD rtdy003 name="construct.c.page1.rtdy003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy004
            #add-point:BEFORE FIELD rtdy004 name="construct.b.page1.rtdy004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy004
            
            #add-point:AFTER FIELD rtdy004 name="construct.a.page1.rtdy004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdy004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy004
            #add-point:ON ACTION controlp INFIELD rtdy004 name="construct.c.page1.rtdy004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtdyownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdyownid
            #add-point:ON ACTION controlp INFIELD rtdyownid name="construct.c.page2.rtdyownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdyownid  #顯示到畫面上
            NEXT FIELD rtdyownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdyownid
            #add-point:BEFORE FIELD rtdyownid name="construct.b.page2.rtdyownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdyownid
            
            #add-point:AFTER FIELD rtdyownid name="construct.a.page2.rtdyownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdyowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdyowndp
            #add-point:ON ACTION controlp INFIELD rtdyowndp name="construct.c.page2.rtdyowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdyowndp  #顯示到畫面上
            NEXT FIELD rtdyowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdyowndp
            #add-point:BEFORE FIELD rtdyowndp name="construct.b.page2.rtdyowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdyowndp
            
            #add-point:AFTER FIELD rtdyowndp name="construct.a.page2.rtdyowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdycrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdycrtid
            #add-point:ON ACTION controlp INFIELD rtdycrtid name="construct.c.page2.rtdycrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdycrtid  #顯示到畫面上
            NEXT FIELD rtdycrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdycrtid
            #add-point:BEFORE FIELD rtdycrtid name="construct.b.page2.rtdycrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdycrtid
            
            #add-point:AFTER FIELD rtdycrtid name="construct.a.page2.rtdycrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdycrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdycrtdp
            #add-point:ON ACTION controlp INFIELD rtdycrtdp name="construct.c.page2.rtdycrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdycrtdp  #顯示到畫面上
            NEXT FIELD rtdycrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdycrtdp
            #add-point:BEFORE FIELD rtdycrtdp name="construct.b.page2.rtdycrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdycrtdp
            
            #add-point:AFTER FIELD rtdycrtdp name="construct.a.page2.rtdycrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdycrtdt
            #add-point:BEFORE FIELD rtdycrtdt name="construct.b.page2.rtdycrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtdymodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdymodid
            #add-point:ON ACTION controlp INFIELD rtdymodid name="construct.c.page2.rtdymodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdymodid  #顯示到畫面上
            NEXT FIELD rtdymodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdymodid
            #add-point:BEFORE FIELD rtdymodid name="construct.b.page2.rtdymodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdymodid
            
            #add-point:AFTER FIELD rtdymodid name="construct.a.page2.rtdymodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdymoddt
            #add-point:BEFORE FIELD rtdymoddt name="construct.b.page2.rtdymoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON rtdzstus,rtdz001,rtdz002,rtdz001_1,rtdz002_1,rtdzownid,rtdzowndp,rtdzcrtid, 
          rtdzcrtdp,rtdzcrtdt,rtdzmodid,rtdzmoddt
           FROM s_detail3[1].rtdzstus,s_detail3[1].rtdz001,s_detail3[1].rtdz002,s_detail4[1].rtdz001_1, 
               s_detail4[1].rtdz002_1,s_detail4[1].rtdzownid,s_detail4[1].rtdzowndp,s_detail4[1].rtdzcrtid, 
               s_detail4[1].rtdzcrtdp,s_detail4[1].rtdzcrtdt,s_detail4[1].rtdzmodid,s_detail4[1].rtdzmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtdzcrtdt>>----
         AFTER FIELD rtdzcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdzmoddt>>----
         AFTER FIELD rtdzmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdzcnfdt>>----
         
         #----<<rtdzpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzstus
            #add-point:BEFORE FIELD rtdzstus name="construct.b.page3.rtdzstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdzstus
            
            #add-point:AFTER FIELD rtdzstus name="construct.a.page3.rtdzstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rtdzstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdzstus
            #add-point:ON ACTION controlp INFIELD rtdzstus name="construct.c.page3.rtdzstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdz001
            #add-point:BEFORE FIELD rtdz001 name="construct.b.page3.rtdz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdz001
            
            #add-point:AFTER FIELD rtdz001 name="construct.a.page3.rtdz001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rtdz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdz001
            #add-point:ON ACTION controlp INFIELD rtdz001 name="construct.c.page3.rtdz001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.rtdz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdz002
            #add-point:ON ACTION controlp INFIELD rtdz002 name="construct.c.page3.rtdz002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_24()                           #呼叫開窗  #161024-00025#1 mark
            #161024-00025#1--add--s
            IF s_aooi500_setpoint(g_prog,'rtdz002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdz002',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef304 = 'Y'"
               CALL q_ooef001_24() 
            END IF
            #161024-00025#1--add--e
            DISPLAY g_qryparam.return1 TO rtdz002  #顯示到畫面上
            NEXT FIELD rtdz002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdz002
            #add-point:BEFORE FIELD rtdz002 name="construct.b.page3.rtdz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdz002
            
            #add-point:AFTER FIELD rtdz002 name="construct.a.page3.rtdz002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdz001_1
            #add-point:BEFORE FIELD rtdz001_1 name="construct.b.page4.rtdz001_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdz001_1
            
            #add-point:AFTER FIELD rtdz001_1 name="construct.a.page4.rtdz001_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtdz001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdz001_1
            #add-point:ON ACTION controlp INFIELD rtdz001_1 name="construct.c.page4.rtdz001_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdz002_1
            #add-point:BEFORE FIELD rtdz002_1 name="construct.b.page4.rtdz002_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdz002_1
            
            #add-point:AFTER FIELD rtdz002_1 name="construct.a.page4.rtdz002_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtdz002_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdz002_1
            #add-point:ON ACTION controlp INFIELD rtdz002_1 name="construct.c.page4.rtdz002_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.rtdzownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdzownid
            #add-point:ON ACTION controlp INFIELD rtdzownid name="construct.c.page4.rtdzownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdzownid  #顯示到畫面上
            NEXT FIELD rtdzownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzownid
            #add-point:BEFORE FIELD rtdzownid name="construct.b.page4.rtdzownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdzownid
            
            #add-point:AFTER FIELD rtdzownid name="construct.a.page4.rtdzownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtdzowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdzowndp
            #add-point:ON ACTION controlp INFIELD rtdzowndp name="construct.c.page4.rtdzowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdzowndp  #顯示到畫面上
            NEXT FIELD rtdzowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzowndp
            #add-point:BEFORE FIELD rtdzowndp name="construct.b.page4.rtdzowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdzowndp
            
            #add-point:AFTER FIELD rtdzowndp name="construct.a.page4.rtdzowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtdzcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdzcrtid
            #add-point:ON ACTION controlp INFIELD rtdzcrtid name="construct.c.page4.rtdzcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdzcrtid  #顯示到畫面上
            NEXT FIELD rtdzcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzcrtid
            #add-point:BEFORE FIELD rtdzcrtid name="construct.b.page4.rtdzcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdzcrtid
            
            #add-point:AFTER FIELD rtdzcrtid name="construct.a.page4.rtdzcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtdzcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdzcrtdp
            #add-point:ON ACTION controlp INFIELD rtdzcrtdp name="construct.c.page4.rtdzcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdzcrtdp  #顯示到畫面上
            NEXT FIELD rtdzcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzcrtdp
            #add-point:BEFORE FIELD rtdzcrtdp name="construct.b.page4.rtdzcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdzcrtdp
            
            #add-point:AFTER FIELD rtdzcrtdp name="construct.a.page4.rtdzcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzcrtdt
            #add-point:BEFORE FIELD rtdzcrtdt name="construct.b.page4.rtdzcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.rtdzmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdzmodid
            #add-point:ON ACTION controlp INFIELD rtdzmodid name="construct.c.page4.rtdzmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdzmodid  #顯示到畫面上
            NEXT FIELD rtdzmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzmodid
            #add-point:BEFORE FIELD rtdzmodid name="construct.b.page4.rtdzmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdzmodid
            
            #add-point:AFTER FIELD rtdzmodid name="construct.a.page4.rtdzmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzmoddt
            #add-point:BEFORE FIELD rtdzmoddt name="construct.b.page4.rtdzmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="query.b_dialog"
         
         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
      ON ACTION qbe_save       #條件儲存
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
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
 
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   LET g_error_show = 1
   CALL arti500_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL arti500_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_rtdy_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_rtdy3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.insert" >}
#+ 資料修改
PRIVATE FUNCTION arti500_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL arti500_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti500.modify" >}
#+ 資料新增
PRIVATE FUNCTION arti500_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE  l_url                  STRING
   DEFINE l_dir                   STRING
   DEFINE l_dir1                  STRING
   DEFINE l_code                  STRING
   DEFINE l_c                     STRING
   DEFINE  l_success             LIKE type_t.num5
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #end add-point 
  
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   LET l_ac_t = g_detail_idx
 
   #add-point:modify段新增前 name="modify.before_modify"
   
   #end add-point 
   
   #進入資料輸入段落
   CALL arti500_input('u')
    
   IF INT_FLAG AND g_rtdy_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL arti500_b_fill(g_wc)
      CALL arti500_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti500.delete" >}
#+ 資料刪除
PRIVATE FUNCTION arti500_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point 
   DEFINE li_ac LIKE type_t.num10
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_dir                   STRING
   DEFINE l_c                   STRING
   #end add-point 
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_rtdy_d_t.* = g_rtdy_d[li_ac].*
   LET g_rtdy_d_o.* = g_rtdy_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM rtdy_t 
         WHERE rtdyent = g_enterprise AND
           rtdy001 = g_rtdy_d_t.rtdy001
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "rtdy_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti500_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   LET l_dir = FGL_GETENV("GSTWCDIR"),"/tag/templates/",g_rtdy_d_t.rtdy001,".svg"
   LET l_c ="rm ",l_dir
   RUN l_c
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM rtdz_t 
         WHERE rtdzent = g_enterprise AND
           rtdz001 = g_rtdy_d_t.rtdy001
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後 name="delete.after_delete2"
   
   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.input" >}
#+ 資料輸入
PRIVATE FUNCTION arti500_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point 
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_url                   STRING
   DEFINE l_dir                   STRING
   DEFINE l_dir1                  STRING
   DEFINE l_code                  STRING
   DEFINE l_c                     STRING
   DEFINE l_success               LIKE type_t.num5
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   DEFINE  l_errno               STRING   
   DEFINE  ls_sql                STRING   
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtdystus,rtdy001,rtdy002,rtdy003,rtdy004,rtdy001,rtdyownid,rtdyowndp,rtdycrtid, 
       rtdycrtdp,rtdycrtdt,rtdymodid,rtdymoddt FROM rtdy_t WHERE rtdyent=? AND rtdy001=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE arti500_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtdzstus,rtdz001,rtdz002,rtdz001,rtdz002,rtdzownid,rtdzowndp,rtdzcrtid, 
       rtdzcrtdp,rtdzcrtdt,rtdzmodid,rtdzmoddt FROM rtdz_t WHERE rtdzent=? AND rtdz001=? AND rtdz002=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE arti500_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
      
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:input段修改前 name="input.before_input"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtdy_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
               IF NOT cl_null(g_rtdy_d[l_ac].rtdy001) THEN
                  CALL n_rtdyl(g_rtdy_d[l_ac].rtdy001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtdy_d[l_ac].rtdy001
                  CALL ap_ref_array2(g_ref_fields," SELECT rtdyl003 FROM rtdyl_t WHERE rtdylent = '"||g_enterprise||"' AND rtdyl001 = ? AND rtdyl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rtdy_d[l_ac].rtdyl003 = g_rtn_fields[1]
                  DISPLAY BY NAME g_rtdy_d[l_ac].rtdyl003
               END IF   
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdy_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL arti500_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_rtdy_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_rtdy_d[l_ac].*
            LET g_master.* = g_rtdy_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtdy_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtdy_d[l_ac].rtdy001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtdy_d_t.* = g_rtdy_d[l_ac].*  #BACKUP
               LET g_rtdy_d_o.* = g_rtdy_d[l_ac].*  #BACKUP
               IF NOT arti500_lock_b("rtdy_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti500_bcl INTO g_rtdy_d[l_ac].rtdystus,g_rtdy_d[l_ac].rtdy001,g_rtdy_d[l_ac].rtdy002, 
                      g_rtdy_d[l_ac].rtdy003,g_rtdy_d[l_ac].rtdy004,g_rtdy2_d[l_ac].rtdy001,g_rtdy2_d[l_ac].rtdyownid, 
                      g_rtdy2_d[l_ac].rtdyowndp,g_rtdy2_d[l_ac].rtdycrtid,g_rtdy2_d[l_ac].rtdycrtdp, 
                      g_rtdy2_d[l_ac].rtdycrtdt,g_rtdy2_d[l_ac].rtdymodid,g_rtdy2_d[l_ac].rtdymoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtdy_d_t.rtdy001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_rtdy_d_mask_o[l_ac].* =  g_rtdy_d[l_ac].*
                  CALL arti500_rtdy_t_mask()
                  LET g_rtdy_d_mask_n[l_ac].* =  g_rtdy_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL arti500_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL arti500_set_entry_b(l_cmd)
            CALL arti500_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.rtdyl001 = g_rtdy_d[l_ac].rtdy001
LET g_detail_multi_table_t.rtdyl002 = g_dlang
LET g_detail_multi_table_t.rtdyl003 = g_rtdy_d[l_ac].rtdyl003
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'rtdylent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'rtdyl001'
            LET l_var_keys[02] = g_rtdy_d[l_ac].rtdy001
            LET l_field_keys[03] = 'rtdyl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'rtdyl_t') THEN
               RETURN 
            END IF 
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL arti500_fetch()
            CALL arti500_idx_chk('m')
 
         BEFORE INSERT
            
LET g_detail_multi_table_t.rtdyl001 = g_rtdy_d[l_ac].rtdy001
LET g_detail_multi_table_t.rtdyl002 = g_dlang
LET g_detail_multi_table_t.rtdyl003 = g_rtdy_d[l_ac].rtdyl003
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_rtdy3_d.clear()
            CALL g_rtdy4_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtdy_d[l_ac].* TO NULL 
            INITIALIZE g_rtdy_d_t.* TO NULL 
            INITIALIZE g_rtdy_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtdy2_d[l_ac].rtdyownid = g_user
      LET g_rtdy2_d[l_ac].rtdyowndp = g_dept
      LET g_rtdy2_d[l_ac].rtdycrtid = g_user
      LET g_rtdy2_d[l_ac].rtdycrtdp = g_dept 
      LET g_rtdy2_d[l_ac].rtdycrtdt = cl_get_current()
      LET g_rtdy2_d[l_ac].rtdymodid = g_user
      LET g_rtdy2_d[l_ac].rtdymoddt = cl_get_current()
      LET g_rtdy_d[l_ac].rtdystus = ''
 
 
 
                  LET g_rtdy_d[l_ac].rtdystus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            #add by geza 20150827(S)
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #add by geza 20150827(E)
            
            LET g_rtdy_d[l_ac].rtdy002 = '/u1/t10dev/www/components/tag/templates/'
            #end add-point
            LET g_rtdy_d_t.* = g_rtdy_d[l_ac].*     #新輸入資料
            LET g_rtdy_d_o.* = g_rtdy_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL arti500_set_entry_b(l_cmd)
            CALL arti500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtdy_d[li_reproduce_target].* = g_rtdy_d[li_reproduce].*
               LET g_rtdy2_d[li_reproduce_target].* = g_rtdy2_d[li_reproduce].*
 
               LET g_rtdy_d[g_rtdy_d.getLength()].rtdy001 = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtdy_t 
             WHERE rtdyent = g_enterprise AND rtdy001 = g_rtdy_d[l_ac].rtdy001 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               CALL s_aooi390_get_auto_no('31',g_rtdy_d[l_ac].rtdy001) RETURNING l_success,g_rtdy_d[l_ac].rtdy001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_aooi390_oofi_upd('31',g_rtdy_d[l_ac].rtdy001) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
               LET g_rtdy_d[l_ac].rtdy003 =g_rtdy_d[l_ac].rtdy001,".svg"
               DISPLAY BY NAME g_rtdy_d[l_ac].rtdy003 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdy_d[g_detail_idx].rtdy001
               CALL arti500_insert_b('rtdy_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
#               #第二个单身插入一笔默认资料
#               LET l_cnt = 0 
#               SELECT COUNT(*) INTO l_cnt
#                 FROM rtdz_t
#                WHERE rtdzent = g_enterprise
#                  AND rtdz001 = g_rtdy_d[l_ac].rtdy001
#               IF l_cnt = 0 THEN
#                   INSERT INTO rtdz_t
#                  (rtdzent,
#                   rtdz001,rtdz002
#                   ,rtdzstus,rtdzownid,rtdzowndp,rtdzcrtid,rtdzcrtdp,rtdzcrtdt,rtdzmodid,rtdzmoddt) 
#                  VALUES(g_enterprise,
#                       g_rtdy_d[g_detail_idx].rtdy001,g_site,'Y', 
#                       g_rtdy2_d[g_detail_idx].rtdyownid,g_rtdy2_d[g_detail_idx].rtdyowndp,g_rtdy2_d[g_detail_idx].rtdycrtid, 
#                       g_rtdy2_d[g_detail_idx].rtdycrtdp,g_rtdy2_d[g_detail_idx].rtdycrtdt,g_rtdy2_d[g_detail_idx].rtdymodid, 
#                       g_rtdy2_d[g_detail_idx].rtdymoddt)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "rtdz_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = FALSE 
#                     CALL cl_err()
#                  END IF
#               END IF               
               #end add-point
            ELSE    
               INITIALIZE g_rtdy_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtdy_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti500_b_fill(g_wc)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtdy_d[l_ac].rtdy001 = g_detail_multi_table_t.rtdyl001 AND
         g_rtdy_d[l_ac].rtdyl003 = g_detail_multi_table_t.rtdyl003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtdylent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtdy_d[l_ac].rtdy001
            LET l_field_keys[02] = 'rtdyl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdyl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtdyl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdyl002
            LET l_vars[01] = g_rtdy_d[l_ac].rtdyl003
            LET l_fields[01] = 'rtdyl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdyl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
        
#               LET l_dir = FGL_GETENV("GSTWCDIR"),"/tag/templates/",g_rtdy_d[l_ac].rtdy003
#               LET l_dir1 = FGL_GETENV("GSTWCDIR"),"/tag/0000.svg"
#               LET l_c ="cp ",l_dir1," ",l_dir
#               RUN l_c
             

               LET l_code = g_rtdy_d[l_ac].rtdy001  #模版編號
               LET l_url = FGL_GETENV("FGLASIP"),"/components/tag/index.html"
               LET l_url = l_url, "?id=", l_code
               
               CALL ui.Interface.frontCall("standard", "launchurl", [l_url], [])
               
               
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_rtdy_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               DELETE FROM rtdy_t
                WHERE rtdyent = g_enterprise AND 
                      rtdy001 = g_rtdy_d_t.rtdy001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtdy_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtdylent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtdyl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdyl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtdyl_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_rtdy_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE arti500_bcl
               LET l_count = g_rtdy_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdy_d_t.rtdy001
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti500_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL arti500_delete_b('rtdy_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtdy_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdystus
            #add-point:BEFORE FIELD rtdystus name="input.b.page1.rtdystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdystus
            
            #add-point:AFTER FIELD rtdystus name="input.a.page1.rtdystus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdystus
            #add-point:ON CHANGE rtdystus name="input.g.page1.rtdystus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy001
            #add-point:BEFORE FIELD rtdy001 name="input.b.page1.rtdy001"
            IF g_rtdy_d[g_detail_idx].rtdy001 IS NULL THEN 
               CALL s_aooi390_gen('31') RETURNING l_success,g_rtdy_d[g_detail_idx].rtdy001,l_oofg_return   
               DISPLAY BY NAME g_rtdy_d[l_ac].rtdy001
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy001
            
            #add-point:AFTER FIELD rtdy001 name="input.a.page1.rtdy001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtdy_d[g_detail_idx].rtdy001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdy_d[g_detail_idx].rtdy001 != g_rtdy_d_t.rtdy001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdy_t WHERE "||"rtdyent = '" ||g_enterprise|| "' AND "||"rtdy001 = '"||g_rtdy_d[g_detail_idx].rtdy001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_rtdy_d[g_detail_idx].rtdy003 = g_rtdy_d[g_detail_idx].rtdy001,'.svg'
            END IF
            IF NOT s_aooi390_chk('31',g_rtdy_d[g_detail_idx].rtdy001) THEN
               LET g_rtdy_d[g_detail_idx].rtdy001 = g_rtdy_d_t.rtdy001
               DISPLAY BY NAME g_rtdy_d[g_detail_idx].rtdy001
               NEXT FIELD CURRENT
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdy001
            #add-point:ON CHANGE rtdy001 name="input.g.page1.rtdy001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdyl003
            #add-point:BEFORE FIELD rtdyl003 name="input.b.page1.rtdyl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdyl003
            
            #add-point:AFTER FIELD rtdyl003 name="input.a.page1.rtdyl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdyl003
            #add-point:ON CHANGE rtdyl003 name="input.g.page1.rtdyl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy002
            #add-point:BEFORE FIELD rtdy002 name="input.b.page1.rtdy002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy002
            
            #add-point:AFTER FIELD rtdy002 name="input.a.page1.rtdy002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdy002
            #add-point:ON CHANGE rtdy002 name="input.g.page1.rtdy002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy003
            #add-point:BEFORE FIELD rtdy003 name="input.b.page1.rtdy003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy003
            
            #add-point:AFTER FIELD rtdy003 name="input.a.page1.rtdy003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdy003
            #add-point:ON CHANGE rtdy003 name="input.g.page1.rtdy003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdy004
            #add-point:BEFORE FIELD rtdy004 name="input.b.page1.rtdy004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdy004
            
            #add-point:AFTER FIELD rtdy004 name="input.a.page1.rtdy004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdy004
            #add-point:ON CHANGE rtdy004 name="input.g.page1.rtdy004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtdystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdystus
            #add-point:ON ACTION controlp INFIELD rtdystus name="input.c.page1.rtdystus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdy001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy001
            #add-point:ON ACTION controlp INFIELD rtdy001 name="input.c.page1.rtdy001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdyl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdyl003
            #add-point:ON ACTION controlp INFIELD rtdyl003 name="input.c.page1.rtdyl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdy002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy002
            #add-point:ON ACTION controlp INFIELD rtdy002 name="input.c.page1.rtdy002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdy003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy003
            #add-point:ON ACTION controlp INFIELD rtdy003 name="input.c.page1.rtdy003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdy004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdy004
            #add-point:ON ACTION controlp INFIELD rtdy004 name="input.c.page1.rtdy004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtdy_d[l_ac].* = g_rtdy_d_t.*
               CLOSE arti500_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtdy_d[l_ac].rtdy001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtdy_d[l_ac].* = g_rtdy_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_rtdy2_d[l_ac].rtdymodid = g_user 
LET g_rtdy2_d[l_ac].rtdymoddt = cl_get_current()
LET g_rtdy2_d[l_ac].rtdymodid_desc = cl_get_username(g_rtdy2_d[l_ac].rtdymodid)
               
               #add-point:單身修改前 name="input.body.b_update"
#               CALL s_aooi390_get_auto_no('31',g_rtdy_d[l_ac].rtdy001) RETURNING l_success,g_rtdy_d[l_ac].rtdy001
#               IF NOT l_success THEN
#                  CALL s_transaction_end('N','0')
#                  NEXT FIELD CURRENT
#               END IF
#               
#               CALL s_aooi390_oofi_upd('31',g_rtdy_d[l_ac].rtdy001) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
#               LET g_rtdy_d[l_ac].rtdy003 =g_rtdy_d[l_ac].rtdy001,".svg"
#               DISPLAY BY NAME g_rtdy_d[l_ac].rtdy003 
               #end add-point
               
               #將遮罩欄位還原
               CALL arti500_rtdy_t_mask_restore('restore_mask_o')
      
               UPDATE rtdy_t SET (rtdystus,rtdy001,rtdy002,rtdy003,rtdy004,rtdyownid,rtdyowndp,rtdycrtid, 
                   rtdycrtdp,rtdycrtdt,rtdymodid,rtdymoddt) = (g_rtdy_d[l_ac].rtdystus,g_rtdy_d[l_ac].rtdy001, 
                   g_rtdy_d[l_ac].rtdy002,g_rtdy_d[l_ac].rtdy003,g_rtdy_d[l_ac].rtdy004,g_rtdy2_d[l_ac].rtdyownid, 
                   g_rtdy2_d[l_ac].rtdyowndp,g_rtdy2_d[l_ac].rtdycrtid,g_rtdy2_d[l_ac].rtdycrtdp,g_rtdy2_d[l_ac].rtdycrtdt, 
                   g_rtdy2_d[l_ac].rtdymodid,g_rtdy2_d[l_ac].rtdymoddt)
                WHERE rtdyent = g_enterprise AND
                  rtdy001 = g_rtdy_d_t.rtdy001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_rtdy_d[l_ac].* = g_rtdy_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdy_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtdy_d[l_ac].* = g_rtdy_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdy_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdy_d[g_detail_idx].rtdy001
               LET gs_keys_bak[1] = g_rtdy_d_t.rtdy001
               CALL arti500_update_b('rtdy_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtdy_d[l_ac].rtdy001 = g_detail_multi_table_t.rtdyl001 AND
         g_rtdy_d[l_ac].rtdyl003 = g_detail_multi_table_t.rtdyl003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtdylent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtdy_d[l_ac].rtdy001
            LET l_field_keys[02] = 'rtdyl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdyl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtdyl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdyl002
            LET l_vars[01] = g_rtdy_d[l_ac].rtdyl003
            LET l_fields[01] = 'rtdyl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdyl_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL arti500_rtdy_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_rtdy_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtdy_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_rtdy_d[l_ac].*
               CALL arti500_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
#               LET l_dir = FGL_GETENV("GSTWCDIR"),"/tag/templates/",g_rtdy_d_t.rtdy001,".svg"
#               LET l_c ="rm ",l_dir
#               RUN l_c
#                        
#               
#               LET l_dir = FGL_GETENV("GSTWCDIR"),"/tag/templates/",g_rtdy_d[l_ac].rtdy003
#               LET l_dir1 = FGL_GETENV("GSTWCDIR"),"/tag/0000.svg"
#               LET l_c ="cp ",l_dir1," ",l_dir
#               RUN l_c
               
#               LET l_code = g_rtdy_d[l_ac].rtdy001  #模版編號
#               LET l_url = FGL_GETENV("FGLASIP"),"/components/tag/index.html"
#               LET l_url = l_url, "?id=", l_code
#               
#               CALL ui.Interface.frontCall("standard", "launchurl", [l_url], [])
      
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti500_unlock_b("rtdy_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtdy_d[l_ac].* = g_rtdy_d_t.*
               END IF
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            CALL cl_multitable_unlock()
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_rtdy_d[l_ac].* = g_rtdy_d_t.*
            END IF
            LET l_cmd = ''
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()      
            #CALL cl_showmsg()            
    
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtdy_d[li_reproduce_target].* = g_rtdy_d[li_reproduce].*
               LET g_rtdy2_d[li_reproduce_target].* = g_rtdy2_d[li_reproduce].*
 
               LET g_rtdy_d[li_reproduce_target].rtdy001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtdy_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtdy_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_rtdy3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page3.update_item"
               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_rtdy_d[g_detail_idx].rtdy001) THEN
               NEXT FIELD rtdystus
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdy3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_rtdy3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
 
         BEFORE INSERT
            IF g_rtdy_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD rtdy001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtdy3_d[l_ac].* TO NULL 
            INITIALIZE g_rtdy3_d_t.* TO NULL 
            INITIALIZE g_rtdy3_d_o.* TO NULL 
            
            #add-point:modify段before備份 name="input.body3.before_bak"
            LET g_rtdy4_d[l_ac].rtdzownid = g_user
            LET g_rtdy4_d[l_ac].rtdzowndp = g_dept
            LET g_rtdy4_d[l_ac].rtdzcrtid = g_user
            LET g_rtdy4_d[l_ac].rtdzcrtdp = g_dept 
            LET g_rtdy4_d[l_ac].rtdzcrtdt = cl_get_current()
            LET g_rtdy4_d[l_ac].rtdzmodid = g_user
            LET g_rtdy4_d[l_ac].rtdzmoddt = cl_get_current()
            LET g_rtdy3_d[l_ac].rtdz001 =g_rtdy_d[g_detail_idx].rtdy001  
            LET g_rtdy3_d[l_ac].rtdzstus ='Y' 
            
            #end add-point
            LET g_rtdy3_d_t.* = g_rtdy3_d[l_ac].*     #新輸入資料
            LET g_rtdy3_d_o.* = g_rtdy3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL arti500_set_entry_b(l_cmd)
            CALL arti500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtdy3_d[li_reproduce_target].* = g_rtdy3_d[li_reproduce].*
               LET g_rtdy4_d[li_reproduce_target].* = g_rtdy4_d[li_reproduce].*
 
               LET g_rtdy3_d[li_reproduce_target].rtdz002 = NULL
            END IF
            #add-point:input段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET l_insert = FALSE
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtdy3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtdy3_d[l_ac].rtdz002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_rtdy3_d_t.* = g_rtdy3_d[l_ac].*  #BACKUP
               LET g_rtdy3_d_o.* = g_rtdy3_d[l_ac].*  #BACKUP
               IF NOT arti500_lock_b("rtdz_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti500_bcl2 INTO g_rtdy3_d[l_ac].rtdzstus,g_rtdy3_d[l_ac].rtdz001,g_rtdy3_d[l_ac].rtdz002, 
                      g_rtdy4_d[l_ac].rtdz001,g_rtdy4_d[l_ac].rtdz002,g_rtdy4_d[l_ac].rtdzownid,g_rtdy4_d[l_ac].rtdzowndp, 
                      g_rtdy4_d[l_ac].rtdzcrtid,g_rtdy4_d[l_ac].rtdzcrtdp,g_rtdy4_d[l_ac].rtdzcrtdt, 
                      g_rtdy4_d[l_ac].rtdzmodid,g_rtdy4_d[l_ac].rtdzmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtdy3_d_mask_o[l_ac].* =  g_rtdy3_d[l_ac].*
                  CALL arti500_rtdz_t_mask()
                  LET g_rtdy3_d_mask_n[l_ac].* =  g_rtdy3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL arti500_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL arti500_set_entry_b(l_cmd)
            CALL arti500_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            CALL arti500_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point  
               
               DELETE FROM rtdz_t
                WHERE rtdzent = g_enterprise AND
                   rtdz001 = g_master.rtdy001
                   AND rtdz002 = g_rtdy3_d_t.rtdz002
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE arti500_bcl
               LET l_count = g_rtdy_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdy_d[g_detail_idx].rtdy001
               LET gs_keys[2] = g_rtdy3_d_t.rtdz002
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL arti500_delete_b('rtdz_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtdy3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
    
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE   
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtdz_t 
             WHERE rtdzent = g_enterprise AND
                   rtdz001 = g_master.rtdy001
                   AND rtdz002 = g_rtdy3_d[g_detail_idx2].rtdz002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdy_d[g_detail_idx].rtdy001
               LET gs_keys[2] = g_rtdy3_d[g_detail_idx2].rtdz002
               CALL arti500_insert_b('rtdz_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtdy_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti500_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtdy3_d[l_ac].* = g_rtdy3_d_t.*
               CLOSE arti500_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtdy3_d[l_ac].* = g_rtdy3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               LET g_rtdy4_d[l_ac].rtdzmodid = g_user 
LET g_rtdy4_d[l_ac].rtdzmoddt = cl_get_current()
LET g_rtdy4_d[l_ac].rtdzmodid_desc = cl_get_username(g_rtdy4_d[l_ac].rtdzmodid)
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL arti500_rtdz_t_mask_restore('restore_mask_o')
               
               UPDATE rtdz_t SET (rtdzstus,rtdz001,rtdz002,rtdzownid,rtdzowndp,rtdzcrtid,rtdzcrtdp,rtdzcrtdt, 
                   rtdzmodid,rtdzmoddt) = (g_rtdy3_d[l_ac].rtdzstus,g_rtdy3_d[l_ac].rtdz001,g_rtdy3_d[l_ac].rtdz002, 
                   g_rtdy4_d[l_ac].rtdzownid,g_rtdy4_d[l_ac].rtdzowndp,g_rtdy4_d[l_ac].rtdzcrtid,g_rtdy4_d[l_ac].rtdzcrtdp, 
                   g_rtdy4_d[l_ac].rtdzcrtdt,g_rtdy4_d[l_ac].rtdzmodid,g_rtdy4_d[l_ac].rtdzmoddt) #自訂欄位頁簽 
 
                WHERE rtdzent = g_enterprise AND
                   rtdz001 = g_master.rtdy001
                   AND rtdz002 = g_rtdy3_d_t.rtdz002
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_rtdy3_d[l_ac].* = g_rtdy3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdz_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtdy3_d[l_ac].* = g_rtdy3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdy_d[g_detail_idx].rtdy001
               LET gs_keys_bak[1] = g_rtdy_d[g_detail_idx].rtdy001
               LET gs_keys[2] = g_rtdy3_d[g_detail_idx2].rtdz002
               LET gs_keys_bak[2] = g_rtdy3_d_t.rtdz002
               CALL arti500_update_b('rtdz_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL arti500_rtdz_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_rtdy3_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtdy3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdzstus
            #add-point:BEFORE FIELD rtdzstus name="input.b.page3.rtdzstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdzstus
            
            #add-point:AFTER FIELD rtdzstus name="input.a.page3.rtdzstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdzstus
            #add-point:ON CHANGE rtdzstus name="input.g.page3.rtdzstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdz001
            #add-point:BEFORE FIELD rtdz001 name="input.b.page3.rtdz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdz001
            
            #add-point:AFTER FIELD rtdz001 name="input.a.page3.rtdz001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdz001
            #add-point:ON CHANGE rtdz001 name="input.g.page3.rtdz001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdz002
            
            #add-point:AFTER FIELD rtdz002 name="input.a.page3.rtdz002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtdy_d[g_detail_idx].rtdy001 IS NOT NULL AND g_rtdy3_d[g_detail_idx2].rtdz002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdy_d[g_detail_idx].rtdy001 != g_rtdy_d[g_detail_idx].rtdy001 OR g_rtdy3_d[g_detail_idx2].rtdz002 != g_rtdy3_d_t.rtdz002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdz_t WHERE "||"rtdzent = '" ||g_enterprise|| "' AND "||"rtdz001 = '"||g_rtdy_d[g_detail_idx].rtdy001 ||"' AND "|| "rtdz002 = '"||g_rtdy3_d[g_detail_idx2].rtdz002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_rtdy3_d[g_detail_idx2].rtdz002) THEN
              IF s_aooi500_setpoint(g_prog,'rtdz002') THEN
                  CALL s_aooi500_chk(g_prog,'rtdz002',g_rtdy3_d[g_detail_idx2].rtdz002,g_site) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_rtdy3_d[g_detail_idx2].rtdz002
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_rtdy3_d[g_detail_idx2].rtdz002 = g_rtdy3_d_t.rtdz002
                     CALL s_desc_get_department_desc(g_rtdy3_d[g_detail_idx2].rtdz002) RETURNING g_rtdy3_d[g_detail_idx2].rtdz002_desc
                     DISPLAY BY NAME g_rtdy3_d[g_detail_idx2].rtdz002,g_rtdy3_d[g_detail_idx2].rtdz002_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_rtdy3_d[g_detail_idx2].rtdz002
                  
                  #160318-00025#44  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#44  2016/04/26  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  #IF cl_chk_exist("v_ooef001_11") THEN      #161024-00025#1 mark
                  IF cl_chk_exist("v_ooef001_35") THEN       #161024-00025#1 add
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdy3_d[g_detail_idx2].rtdz002
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdy3_d[g_detail_idx2].rtdz002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtdy3_d[g_detail_idx2].rtdz002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdz002
            #add-point:BEFORE FIELD rtdz002 name="input.b.page3.rtdz002"
            IF l_ac = 1 THEN
               IF cl_null(g_rtdy3_d[l_ac].rtdz002) THEN
                  LET g_rtdy3_d[l_ac].rtdz002 = g_site
                  DISPLAY BY NAME g_rtdy3_d[l_ac].rtdz002
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtdy3_d[l_ac].rtdz002
                  LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
                  LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
                  CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
                  LET g_rtdy3_d[l_ac].rtdz002_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_rtdy3_d[l_ac].rtdz002_desc
               END IF
            END IF   
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdz002
            #add-point:ON CHANGE rtdz002 name="input.g.page3.rtdz002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.rtdzstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdzstus
            #add-point:ON ACTION controlp INFIELD rtdzstus name="input.c.page3.rtdzstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rtdz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdz001
            #add-point:ON ACTION controlp INFIELD rtdz001 name="input.c.page3.rtdz001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rtdz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdz002
            #add-point:ON ACTION controlp INFIELD rtdz002 name="input.c.page3.rtdz002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdy3_d[l_ac].rtdz002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            IF s_aooi500_setpoint(g_prog,'rtdz002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdz002',g_site,'i')
               CALL q_ooef001_24() 
            ELSE
               #LET g_qryparam.where = "ooef212 = 'Y'"
               #CALL q_ooef001()     #161024-00025#1 mark
               LET g_qryparam.where = "ooef304 = 'Y'"    #161024-00025#1 add
               CALL q_ooef001_24()   #161024-00025#1 add
            END IF

            LET g_rtdy3_d[l_ac].rtdz002 = g_qryparam.return1              

            DISPLAY g_rtdy3_d[l_ac].rtdz002 TO rtdz002              #

            NEXT FIELD rtdz002                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtdy3_d[l_ac].* = g_rtdy3_d_t.*
               END IF
               CLOSE arti500_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL arti500_unlock_b("rtdz_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtdy3_d[li_reproduce_target].* = g_rtdy3_d[li_reproduce].*
               LET g_rtdy4_d[li_reproduce_target].* = g_rtdy4_d[li_reproduce].*
 
               LET g_rtdy3_d[li_reproduce_target].rtdz002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtdy3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtdy3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_rtdy2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL arti500_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL arti500_fetch()
            CALL arti500_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
      DISPLAY ARRAY g_rtdy4_d TO s_detail4.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)
            LET g_current_page = 4
            
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL arti500_idx_chk('d')
            
         #add-point:page4自定義行為 name="input.body4.action"
        
         #end add-point
            
      END DISPLAY
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_rtdy_d.getLength() THEN
               LET g_detail_idx = g_rtdy_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_rtdy_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtdystus
               WHEN "s_detail2"
                  NEXT FIELD rtdy001_2
               WHEN "s_detail3"
                  NEXT FIELD rtdzstus
               WHEN "s_detail4"
                  NEXT FIELD rtdz001
 
            END CASE
         ELSE
            NEXT FIELD rtdystus
         END IF
            
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION close
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
   
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
   CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx2)
 
   
   #add-point:input段修改後 name="input.after_input"
   
   #end add-point
 
   CLOSE arti500_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION arti500_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.rtdystus,t0.rtdy001,t0.rtdy002,t0.rtdy003,t0.rtdy004,t0.rtdy001, 
       t0.rtdyownid,t0.rtdyowndp,t0.rtdycrtid,t0.rtdycrtdp,t0.rtdycrtdt,t0.rtdymodid,t0.rtdymoddt ,t1.ooag011 , 
       t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM rtdy_t t0",
 
               " LEFT JOIN rtdz_t ON rtdzent = rtdyent AND rtdy001 = rtdz001",
 
 
               " LEFT JOIN rtdyl_t ON rtdylent = "||g_enterprise||" AND rtdy001 = rtdyl001 AND rtdyl002 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rtdyownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rtdyowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.rtdycrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.rtdycrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rtdymodid  ",
 
               " WHERE t0.rtdyent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("rtdy_t"),
                      " ORDER BY t0.rtdy001"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtdy_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE arti500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR arti500_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtdy_d.clear()
   CALL g_rtdy2_d.clear()   
   CALL g_rtdy3_d.clear()   
   CALL g_rtdy4_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_rtdy_d[l_ac].rtdystus,g_rtdy_d[l_ac].rtdy001,g_rtdy_d[l_ac].rtdy002,g_rtdy_d[l_ac].rtdy003, 
       g_rtdy_d[l_ac].rtdy004,g_rtdy2_d[l_ac].rtdy001,g_rtdy2_d[l_ac].rtdyownid,g_rtdy2_d[l_ac].rtdyowndp, 
       g_rtdy2_d[l_ac].rtdycrtid,g_rtdy2_d[l_ac].rtdycrtdp,g_rtdy2_d[l_ac].rtdycrtdt,g_rtdy2_d[l_ac].rtdymodid, 
       g_rtdy2_d[l_ac].rtdymoddt,g_rtdy2_d[l_ac].rtdyownid_desc,g_rtdy2_d[l_ac].rtdyowndp_desc,g_rtdy2_d[l_ac].rtdycrtid_desc, 
       g_rtdy2_d[l_ac].rtdycrtdp_desc,g_rtdy2_d[l_ac].rtdymodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
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
   
 
   CALL g_rtdy_d.deleteElement(g_rtdy_d.getLength())   
   CALL g_rtdy2_d.deleteElement(g_rtdy2_d.getLength())
   CALL g_rtdy3_d.deleteElement(g_rtdy3_d.getLength())
   CALL g_rtdy4_d.deleteElement(g_rtdy4_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_rtdy_d.getLength() THEN
       IF g_rtdy_d.getLength() > 0 THEN
          LET g_detail_idx = g_rtdy_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_rtdy_d.getLength()
      LET g_rtdy2_d[g_detail_idx].rtdy001 = g_rtdy_d[g_detail_idx].rtdy001 
      #LET g_rtdy3_d[g_detail_idx2].rtdz002 = g_rtdy_d[g_detail_idx].rtdy001 
      #LET g_rtdy4_d[g_detail_idx2].rtdz002 = g_rtdy_d[g_detail_idx].rtdy001 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE arti500_pb
   
   LET g_loc = 'm'
   CALL arti500_detail_show() 
   
   LET l_ac = 1
   IF g_rtdy_d.getLength() > 0 THEN
      CALL arti500_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtdy_d.getLength()
      LET g_rtdy_d_mask_o[l_ac].* =  g_rtdy_d[l_ac].*
      CALL arti500_rtdy_t_mask()
      LET g_rtdy_d_mask_n[l_ac].* =  g_rtdy_d[l_ac].*
   END FOR
   
   LET g_rtdy2_d_mask_o.* =  g_rtdy2_d.*
   FOR l_ac = 1 TO g_rtdy2_d.getLength()
      LET g_rtdy2_d_mask_o[l_ac].* =  g_rtdy2_d[l_ac].*
      CALL arti500_rtdy_t_mask()
      LET g_rtdy2_d_mask_n[l_ac].* =  g_rtdy2_d[l_ac].*
   END FOR
   LET g_rtdy3_d_mask_o.* =  g_rtdy3_d.*
   FOR l_ac = 1 TO g_rtdy3_d.getLength()
      LET g_rtdy3_d_mask_o[l_ac].* =  g_rtdy3_d[l_ac].*
      CALL arti500_rtdz_t_mask()
      LET g_rtdy3_d_mask_n[l_ac].* =  g_rtdy3_d[l_ac].*
   END FOR
   LET g_rtdy4_d_mask_o.* =  g_rtdy4_d.*
   FOR l_ac = 1 TO g_rtdy4_d.getLength()
      LET g_rtdy4_d_mask_o[l_ac].* =  g_rtdy4_d[l_ac].*
      CALL arti500_rtdz_t_mask()
      LET g_rtdy4_d_mask_n[l_ac].* =  g_rtdy4_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION arti500_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_rtdy_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_rtdy2_d.clear()
   CALL g_rtdy3_d.clear()
   CALL g_rtdy4_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.rtdzstus,t0.rtdz001,t0.rtdz002,t0.rtdz001,t0.rtdz002,t0.rtdzownid, 
          t0.rtdzowndp,t0.rtdzcrtid,t0.rtdzcrtdp,t0.rtdzcrtdt,t0.rtdzmodid,t0.rtdzmoddt ,t6.ooefl003 , 
          t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 FROM rtdz_t t0",    
                  "",
                                 " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.rtdz002 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.rtdzownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.rtdzowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.rtdzcrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.rtdzcrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.rtdzmodid  ",
 
                  " WHERE t0.rtdzent=?  AND t0. rtdz001=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.rtdz002" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE arti500_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR arti500_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise,g_rtdy_d[l_ac].rtdy001   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise,g_rtdy_d[l_ac].rtdy001 INTO g_rtdy3_d[l_ac].rtdzstus,g_rtdy3_d[l_ac].rtdz001, 
#    g_rtdy3_d[l_ac].rtdz002,g_rtdy4_d[l_ac].rtdz001,g_rtdy4_d[l_ac].rtdz002,g_rtdy4_d[l_ac].rtdzownid, 
#    g_rtdy4_d[l_ac].rtdzowndp,g_rtdy4_d[l_ac].rtdzcrtid,g_rtdy4_d[l_ac].rtdzcrtdp,g_rtdy4_d[l_ac].rtdzcrtdt, 
#    g_rtdy4_d[l_ac].rtdzmodid,g_rtdy4_d[l_ac].rtdzmoddt,g_rtdy3_d[l_ac].rtdz002_desc,g_rtdy4_d[l_ac].rtdzownid_desc, 
#    g_rtdy4_d[l_ac].rtdzowndp_desc,g_rtdy4_d[l_ac].rtdzcrtid_desc,g_rtdy4_d[l_ac].rtdzcrtdp_desc,g_rtdy4_d[l_ac].rtdzmodid_desc  
#      #(ver:45) #(ver:46)mark
   FOREACH b_fill_curs2 USING g_enterprise,g_rtdy_d[g_detail_idx].rtdy001 INTO g_rtdy3_d[l_ac].rtdzstus, 
       g_rtdy3_d[l_ac].rtdz001,g_rtdy3_d[l_ac].rtdz002,g_rtdy4_d[l_ac].rtdz001,g_rtdy4_d[l_ac].rtdz002, 
       g_rtdy4_d[l_ac].rtdzownid,g_rtdy4_d[l_ac].rtdzowndp,g_rtdy4_d[l_ac].rtdzcrtid,g_rtdy4_d[l_ac].rtdzcrtdp, 
       g_rtdy4_d[l_ac].rtdzcrtdt,g_rtdy4_d[l_ac].rtdzmodid,g_rtdy4_d[l_ac].rtdzmoddt,g_rtdy3_d[l_ac].rtdz002_desc, 
       g_rtdy4_d[l_ac].rtdzownid_desc,g_rtdy4_d[l_ac].rtdzowndp_desc,g_rtdy4_d[l_ac].rtdzcrtid_desc, 
       g_rtdy4_d[l_ac].rtdzcrtdp_desc,g_rtdy4_d[l_ac].rtdzmodid_desc   #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point
   
   #CALL g_rtdy2_d.deleteElement(g_rtdy2_d.getLength())   
   CALL g_rtdy3_d.deleteElement(g_rtdy3_d.getLength())   
   CALL g_rtdy4_d.deleteElement(g_rtdy4_d.getLength())   
 
   
   LET g_rtdy3_d_mask_o.* =  g_rtdy3_d.*
   FOR l_ac = 1 TO g_rtdy3_d.getLength()
      LET g_rtdy3_d_mask_o[l_ac].* =  g_rtdy3_d[l_ac].*
      CALL arti500_rtdz_t_mask()
      LET g_rtdy3_d_mask_n[l_ac].* =  g_rtdy3_d[l_ac].*
   END FOR
   LET g_rtdy4_d_mask_o.* =  g_rtdy4_d.*
   FOR l_ac = 1 TO g_rtdy4_d.getLength()
      LET g_rtdy4_d_mask_o[l_ac].* =  g_rtdy4_d[l_ac].*
      CALL arti500_rtdz_t_mask()
      LET g_rtdy4_d_mask_n[l_ac].* =  g_rtdy4_d[l_ac].*
   END FOR
 
   
   DISPLAY g_rtdy3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL arti500_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION arti500_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   #帶出公用欄位reference值page3
   
   #帶出公用欄位reference值page4
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_rtdy_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_rtdy_d[l_ac].rtdy001
   CALL ap_ref_array2(g_ref_fields," SELECT rtdyl003 FROM rtdyl_t WHERE rtdylent = '"||g_enterprise||"' AND rtdyl001 = ? AND rtdyl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_rtdy_d[l_ac].rtdyl003 = g_rtn_fields[1] 
   DISPLAY BY NAME g_rtdy_d[l_ac].rtdyl003
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
         
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_rtdy3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
        
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_rtdy4_d.getLength()
        #add-point:show段單身reference name="detail_show.body4.reference"
        
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="arti500.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION arti500_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="arti500.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION arti500_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
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
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="arti500.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti500_default_search()
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
      LET ls_wc = ls_wc, " rtdy001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=2"
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="arti500.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION arti500_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_dir                   STRING
   DEFINE l_c                   STRING
   #end add-point     
  
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "rtdy_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM rtdy_t
       WHERE rtdyent = g_enterprise AND
         rtdy001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete"
      
      #end add-point  
   END IF
   
 
   
   LET ls_group = "rtdz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM rtdz_t
       WHERE rtdzent = g_enterprise AND
         rtdz001 = ps_keys_bak[1] AND rtdz002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "rtdy_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM rtdz_t
       WHERE rtdzent = g_enterprise AND
         rtdz001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_body_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION arti500_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "rtdy_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO rtdy_t
                  (rtdyent,
                   rtdy001
                   ,rtdystus,rtdy002,rtdy003,rtdy004,rtdyownid,rtdyowndp,rtdycrtid,rtdycrtdp,rtdycrtdt,rtdymodid,rtdymoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_rtdy_d[g_detail_idx].rtdystus,g_rtdy_d[g_detail_idx].rtdy002,g_rtdy_d[g_detail_idx].rtdy003, 
                       g_rtdy_d[g_detail_idx].rtdy004,g_rtdy2_d[g_detail_idx].rtdyownid,g_rtdy2_d[g_detail_idx].rtdyowndp, 
                       g_rtdy2_d[g_detail_idx].rtdycrtid,g_rtdy2_d[g_detail_idx].rtdycrtdp,g_rtdy2_d[g_detail_idx].rtdycrtdt, 
                       g_rtdy2_d[g_detail_idx].rtdymodid,g_rtdy2_d[g_detail_idx].rtdymoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdy_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "rtdz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
      #end add-point
      INSERT INTO rtdz_t
                  (rtdzent,
                   rtdz001,rtdz002
                   ,rtdzstus,rtdzownid,rtdzowndp,rtdzcrtid,rtdzcrtdp,rtdzcrtdt,rtdzmodid,rtdzmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtdy3_d[g_detail_idx2].rtdzstus,g_rtdy4_d[g_detail_idx2].rtdzownid,g_rtdy4_d[g_detail_idx2].rtdzowndp, 
                       g_rtdy4_d[g_detail_idx2].rtdzcrtid,g_rtdy4_d[g_detail_idx2].rtdzcrtdp,g_rtdy4_d[g_detail_idx2].rtdzcrtdt, 
                       g_rtdy4_d[g_detail_idx2].rtdzmodid,g_rtdy4_d[g_detail_idx2].rtdzmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         RETURN
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION arti500_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
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
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "rtdy_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtdy_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL arti500_rtdy_t_mask_restore('restore_mask_o')
               
      UPDATE rtdy_t 
         SET (rtdy001
              ,rtdystus,rtdy002,rtdy003,rtdy004,rtdyownid,rtdyowndp,rtdycrtid,rtdycrtdp,rtdycrtdt,rtdymodid,rtdymoddt) 
              = 
             (ps_keys[1]
              ,g_rtdy_d[g_detail_idx].rtdystus,g_rtdy_d[g_detail_idx].rtdy002,g_rtdy_d[g_detail_idx].rtdy003, 
                  g_rtdy_d[g_detail_idx].rtdy004,g_rtdy2_d[g_detail_idx].rtdyownid,g_rtdy2_d[g_detail_idx].rtdyowndp, 
                  g_rtdy2_d[g_detail_idx].rtdycrtid,g_rtdy2_d[g_detail_idx].rtdycrtdp,g_rtdy2_d[g_detail_idx].rtdycrtdt, 
                  g_rtdy2_d[g_detail_idx].rtdymodid,g_rtdy2_d[g_detail_idx].rtdymoddt) 
         WHERE rtdyent = g_enterprise AND
               rtdy001 = ps_keys_bak[1]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdy_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdy_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'rtdylent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'rtdyl001'
LET l_new_key[03] = g_dlang 
LET l_old_key[03] = g_dlang 
LET l_field_key[03] = 'rtdyl002'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'rtdyl_t')
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL arti500_rtdy_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "rtdz_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtdz_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL arti500_rtdz_t_mask_restore('restore_mask_o')
      
      UPDATE rtdz_t 
         SET (rtdz001,rtdz002
              ,rtdzstus,rtdzownid,rtdzowndp,rtdzcrtid,rtdzcrtdp,rtdzcrtdt,rtdzmodid,rtdzmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtdy3_d[g_detail_idx2].rtdzstus,g_rtdy4_d[g_detail_idx2].rtdzownid,g_rtdy4_d[g_detail_idx2].rtdzowndp, 
                  g_rtdy4_d[g_detail_idx2].rtdzcrtid,g_rtdy4_d[g_detail_idx2].rtdzcrtdp,g_rtdy4_d[g_detail_idx2].rtdzcrtdt, 
                  g_rtdy4_d[g_detail_idx2].rtdzmodid,g_rtdy4_d[g_detail_idx2].rtdzmoddt) 
         WHERE rtdzent = g_enterprise AND
               rtdz001 = ps_keys_bak[1] AND rtdz002 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdz_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL arti500_rtdz_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION arti500_key_update_b()
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)   #(ver:44)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.rtdy001 <> g_master_t.rtdy001 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE rtdz_t 
      SET (rtdz001) 
           = 
          (g_master.rtdy001) 
      WHERE rtdzent = g_enterprise AND
           rtdz001 = g_master_t.rtdy001
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後 name="key_update_b.after_update2"
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION arti500_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL arti500_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtdy_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN arti500_bcl USING g_enterprise,
                                       g_rtdy_d[g_detail_idx].rtdy001
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti500_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "rtdz_t,"
   #僅鎖定自身table
   LET ls_group = "rtdz_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN arti500_bcl2 USING g_enterprise,
                                             g_master.rtdy001,
                                             g_rtdy3_d[g_detail_idx2].rtdz002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti500_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti500.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION arti500_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE arti500_bcl
   END IF
   
 
    
   LET ls_group = "rtdz_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE arti500_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="arti500.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION arti500_idx_chk(ps_loc)
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtdy_d.getLength() THEN
         LET g_detail_idx = g_rtdy_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtdy_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_rtdy_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rtdy2_d.getLength() THEN
         LET g_detail_idx = g_rtdy2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtdy2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_rtdy2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_rtdy3_d.getLength() THEN
         LET g_detail_idx2 = g_rtdy3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_rtdy3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_rtdy3_d.getLength()
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx2 > g_rtdy4_d.getLength() THEN
         LET g_detail_idx2 = g_rtdy4_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_rtdy4_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_rtdy4_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_rtdy3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_rtdy3_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_rtdy4_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_rtdy4_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="arti500.mask_functions" >}
&include "erp/art/arti500_mask.4gl"
 
{</section>}
 
{<section id="arti500.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti500_set_pk_array()
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
   LET g_pk_array[1].values = g_rtdy_d[g_detail_idx].rtdy001
   LET g_pk_array[1].column = 'rtdy001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti500.state_change" >}
    
 
{</section>}
 
{<section id="arti500.func_signature" >}
   
 
{</section>}
 
{<section id="arti500.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="arti500.other_function" readonly="Y" >}

 
{</section>}
 
