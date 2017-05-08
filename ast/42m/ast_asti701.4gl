#該程式未解開Section, 採用最新樣板產出!
{<section id="asti701.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-12-17 16:03:18), PR版次:0008(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000094
#+ Filename...: asti701
#+ Description: 內部結算參數設定作業
#+ Creator....: 02003(2014-07-23 15:39:46)
#+ Modifier...: 06189 -SD/PR- 00000
 
{</section>}
 
{<section id="asti701.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#15 2016/09/05 by 08172 调整系统中无ENT的SQL条件增加ent
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
PRIVATE TYPE type_g_stdb_d RECORD
       stdbstus LIKE type_t.chr10, 
   stdb001 LIKE stdb_t.stdb001, 
   stdb002 LIKE stdb_t.stdb002, 
   stdb002_desc LIKE type_t.chr500, 
   stdb003 LIKE stdb_t.stdb003, 
   stdb004 LIKE stdb_t.stdb004, 
   stdb005 LIKE stdb_t.stdb005, 
   stdb005_desc LIKE type_t.chr500, 
   stdb006 LIKE stdb_t.stdb006, 
   stdb006_desc LIKE type_t.chr500, 
   stdb007 LIKE stdb_t.stdb007, 
   stdb008 LIKE stdb_t.stdb008, 
   stdb009 LIKE stdb_t.stdb009, 
   stdb010 LIKE stdb_t.stdb010
       END RECORD
PRIVATE TYPE type_g_stdb2_d RECORD
       stdb001 LIKE stdb_t.stdb001, 
   stdbownid LIKE stdb_t.stdbownid, 
   stdbownid_desc LIKE type_t.chr500, 
   stdbowndp LIKE stdb_t.stdbowndp, 
   stdbowndp_desc LIKE type_t.chr500, 
   stdbcrtid LIKE stdb_t.stdbcrtid, 
   stdbcrtid_desc LIKE type_t.chr500, 
   stdbcrtdp LIKE stdb_t.stdbcrtdp, 
   stdbcrtdp_desc LIKE type_t.chr500, 
   stdbcrtdt DATETIME YEAR TO SECOND, 
   stdbmodid LIKE stdb_t.stdbmodid, 
   stdbmodid_desc LIKE type_t.chr500, 
   stdbmoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_stdb3_d RECORD
       stdc002 LIKE stdc_t.stdc002, 
   stdc003 LIKE stdc_t.stdc003, 
   stdc003_desc LIKE type_t.chr500, 
   stdc004 LIKE stdc_t.stdc004, 
   stdc005 LIKE stdc_t.stdc005
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_change            LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_stdb_d
DEFINE g_master_t                   type_g_stdb_d
DEFINE g_stdb_d          DYNAMIC ARRAY OF type_g_stdb_d
DEFINE g_stdb_d_t        type_g_stdb_d
DEFINE g_stdb_d_o        type_g_stdb_d
DEFINE g_stdb_d_mask_o   DYNAMIC ARRAY OF type_g_stdb_d #轉換遮罩前資料
DEFINE g_stdb_d_mask_n   DYNAMIC ARRAY OF type_g_stdb_d #轉換遮罩後資料
DEFINE g_stdb2_d          DYNAMIC ARRAY OF type_g_stdb2_d
DEFINE g_stdb2_d_t        type_g_stdb2_d
DEFINE g_stdb2_d_o        type_g_stdb2_d
DEFINE g_stdb2_d_mask_o   DYNAMIC ARRAY OF type_g_stdb2_d #轉換遮罩前資料
DEFINE g_stdb2_d_mask_n   DYNAMIC ARRAY OF type_g_stdb2_d #轉換遮罩後資料
DEFINE g_stdb3_d          DYNAMIC ARRAY OF type_g_stdb3_d
DEFINE g_stdb3_d_t        type_g_stdb3_d
DEFINE g_stdb3_d_o        type_g_stdb3_d
DEFINE g_stdb3_d_mask_o   DYNAMIC ARRAY OF type_g_stdb3_d #轉換遮罩前資料
DEFINE g_stdb3_d_mask_n   DYNAMIC ARRAY OF type_g_stdb3_d #轉換遮罩後資料
 
      
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
 
{<section id="asti701.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/20 By shiun
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asti701 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asti701_init()   
 
      #進入選單 Menu (="N")
      CALL asti701_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asti701
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asti701.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asti701_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   
      CALL cl_set_combo_scc('stdb003','6082') 
   CALL cl_set_combo_scc('stdb004','6085') 
   CALL cl_set_combo_scc('stdb007','6086') 
   CALL cl_set_combo_scc('stdb008','6087') 
   CALL cl_set_combo_scc('stdc004','6088') 
 
   LET l_ac = 1
   
 
 
   
 
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_stdb_d.getLength() > 0 THEN
      LET g_master_t.* = g_stdb_d[1].*
      LET g_master.* = g_stdb_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_change = ''
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   CALL cl_set_combo_scc_part('stdb007','6086','1')          #add by geza 20151125 #关联交易频率只能选择实时 
   #end add-point
   
   CALL asti701_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="asti701.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asti701_ui_dialog()
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
         CALL g_stdb_d.clear()
         CALL g_stdb2_d.clear()
         CALL g_stdb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asti701_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      
      #end add-point
   
      CALL asti701_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stdb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_master.* = g_stdb_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL asti701_fetch()
               CALL asti701_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL asti701_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
#            IF g_stdb_d[l_ac].stdb003 = '1' THEN 
#               CALL cl_set_comp_visible("stdc005,stdc004",FALSE)
#            ELSE
#               CALL cl_set_comp_visible("stdc005,stdc004",TRUE)
#            END IF 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_stdb2_d TO s_detail2.*
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
               LET g_master.* = g_stdb_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL asti701_fetch()
               CALL asti701_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL asti701_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
#            IF g_stdb_d[l_ac].stdb003 = '1' THEN 
#               CALL cl_set_comp_visible("stdc005,stdc004",FALSE)
#            ELSE
#               CALL cl_set_comp_visible("stdc005,stdc004",TRUE)
#            END IF 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_stdb3_d TO s_detail3.*
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
               CALL asti701_idx_chk('d')
               LET g_master.* = g_stdb_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_stdb_d.getLength() THEN
                  LET g_detail_idx = g_stdb_d.getLength()
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
            LET g_export_node[1] = base.typeInfo.create(g_stdb_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_stdb2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_stdb3_d)
            LET g_export_id[3]   = "s_detail3"
 
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
               CALL asti701_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL asti701_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               
               #add-point:ON ACTION delete name="menu.delete"
               CALL asti701_delete_2()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asti701_insert()
               #add-point:ON ACTION insert name="menu.insert"

               CALL asti701_modify()
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
               CALL asti701_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
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
            CALL asti701_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asti701_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asti701_set_pk_array()
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
 
{<section id="asti701.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asti701_query()
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
   CALL g_stdb_d.clear()
   CALL g_stdb2_d.clear()
   CALL g_stdb3_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON stdbstus,stdb001,stdb002,stdb003,stdb004,stdb005,stdb006,stdb007,stdb008, 
          stdb009,stdb010,stdbownid,stdbowndp,stdbcrtid,stdbcrtdp,stdbcrtdt,stdbmodid,stdbmoddt
           FROM s_detail1[1].stdbstus,s_detail1[1].stdb001,s_detail1[1].stdb002,s_detail1[1].stdb003, 
               s_detail1[1].stdb004,s_detail1[1].stdb005,s_detail1[1].stdb006,s_detail1[1].stdb007,s_detail1[1].stdb008, 
               s_detail1[1].stdb009,s_detail1[1].stdb010,s_detail2[1].stdbownid,s_detail2[1].stdbowndp, 
               s_detail2[1].stdbcrtid,s_detail2[1].stdbcrtdp,s_detail2[1].stdbcrtdt,s_detail2[1].stdbmodid, 
               s_detail2[1].stdbmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stdbcrtdt>>----
         AFTER FIELD stdbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stdbmoddt>>----
         AFTER FIELD stdbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stdbcnfdt>>----
         
         #----<<stdbpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbstus
            #add-point:BEFORE FIELD stdbstus name="construct.b.page1.stdbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdbstus
            
            #add-point:AFTER FIELD stdbstus name="construct.a.page1.stdbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdbstus
            #add-point:ON ACTION controlp INFIELD stdbstus name="construct.c.page1.stdbstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb001
            #add-point:BEFORE FIELD stdb001 name="construct.b.page1.stdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb001
            
            #add-point:AFTER FIELD stdb001 name="construct.a.page1.stdb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb001
            #add-point:ON ACTION controlp INFIELD stdb001 name="construct.c.page1.stdb001"
             ###  ### start ###
             INITIALIZE g_qryparam.* TO NULL 
             LET g_qryparam.state = "c"
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = "1=1"
             CALL q_stdb001()
             DISPLAY g_qryparam.return1 TO stdb001
             NEXT FIELD stdb001
             ###  ### end ###

            #END add-point
 
 
         #Ctrlp:construct.c.page1.stdb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb002
            #add-point:ON ACTION controlp INFIELD stdb002 name="construct.c.page1.stdb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef212 = 'Y' "
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdb002  #顯示到畫面上
            NEXT FIELD stdb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb002
            #add-point:BEFORE FIELD stdb002 name="construct.b.page1.stdb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb002
            
            #add-point:AFTER FIELD stdb002 name="construct.a.page1.stdb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb003
            #add-point:BEFORE FIELD stdb003 name="construct.b.page1.stdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb003
            
            #add-point:AFTER FIELD stdb003 name="construct.a.page1.stdb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb003
            #add-point:ON ACTION controlp INFIELD stdb003 name="construct.c.page1.stdb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb004
            #add-point:BEFORE FIELD stdb004 name="construct.b.page1.stdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb004
            
            #add-point:AFTER FIELD stdb004 name="construct.a.page1.stdb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb004
            #add-point:ON ACTION controlp INFIELD stdb004 name="construct.c.page1.stdb004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb005
            #add-point:ON ACTION controlp INFIELD stdb005 name="construct.c.page1.stdb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef003 = 'Y' " #
#            CALL q_ooef001()                         #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdb005') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdb005',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' " #
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO stdb005  #顯示到畫面上
            NEXT FIELD stdb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb005
            #add-point:BEFORE FIELD stdb005 name="construct.b.page1.stdb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb005
            
            #add-point:AFTER FIELD stdb005 name="construct.a.page1.stdb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb006
            #add-point:ON ACTION controlp INFIELD stdb006 name="construct.c.page1.stdb006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef003 = 'Y' " #
#            CALL q_ooef001()                                   #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdb006') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdb006',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' " #
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO stdb006  #顯示到畫面上
            NEXT FIELD stdb006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb006
            #add-point:BEFORE FIELD stdb006 name="construct.b.page1.stdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb006
            
            #add-point:AFTER FIELD stdb006 name="construct.a.page1.stdb006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb007
            #add-point:BEFORE FIELD stdb007 name="construct.b.page1.stdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb007
            
            #add-point:AFTER FIELD stdb007 name="construct.a.page1.stdb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb007
            #add-point:ON ACTION controlp INFIELD stdb007 name="construct.c.page1.stdb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb008
            #add-point:BEFORE FIELD stdb008 name="construct.b.page1.stdb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb008
            
            #add-point:AFTER FIELD stdb008 name="construct.a.page1.stdb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb008
            #add-point:ON ACTION controlp INFIELD stdb008 name="construct.c.page1.stdb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb009
            #add-point:BEFORE FIELD stdb009 name="construct.b.page1.stdb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb009
            
            #add-point:AFTER FIELD stdb009 name="construct.a.page1.stdb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb009
            #add-point:ON ACTION controlp INFIELD stdb009 name="construct.c.page1.stdb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb010
            #add-point:BEFORE FIELD stdb010 name="construct.b.page1.stdb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb010
            
            #add-point:AFTER FIELD stdb010 name="construct.a.page1.stdb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stdb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb010
            #add-point:ON ACTION controlp INFIELD stdb010 name="construct.c.page1.stdb010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.stdbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdbownid
            #add-point:ON ACTION controlp INFIELD stdbownid name="construct.c.page2.stdbownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdbownid  #顯示到畫面上
            NEXT FIELD stdbownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbownid
            #add-point:BEFORE FIELD stdbownid name="construct.b.page2.stdbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdbownid
            
            #add-point:AFTER FIELD stdbownid name="construct.a.page2.stdbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stdbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdbowndp
            #add-point:ON ACTION controlp INFIELD stdbowndp name="construct.c.page2.stdbowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdbowndp  #顯示到畫面上
            NEXT FIELD stdbowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbowndp
            #add-point:BEFORE FIELD stdbowndp name="construct.b.page2.stdbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdbowndp
            
            #add-point:AFTER FIELD stdbowndp name="construct.a.page2.stdbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stdbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdbcrtid
            #add-point:ON ACTION controlp INFIELD stdbcrtid name="construct.c.page2.stdbcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdbcrtid  #顯示到畫面上
            NEXT FIELD stdbcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbcrtid
            #add-point:BEFORE FIELD stdbcrtid name="construct.b.page2.stdbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdbcrtid
            
            #add-point:AFTER FIELD stdbcrtid name="construct.a.page2.stdbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stdbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdbcrtdp
            #add-point:ON ACTION controlp INFIELD stdbcrtdp name="construct.c.page2.stdbcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdbcrtdp  #顯示到畫面上
            NEXT FIELD stdbcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbcrtdp
            #add-point:BEFORE FIELD stdbcrtdp name="construct.b.page2.stdbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdbcrtdp
            
            #add-point:AFTER FIELD stdbcrtdp name="construct.a.page2.stdbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbcrtdt
            #add-point:BEFORE FIELD stdbcrtdt name="construct.b.page2.stdbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.stdbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdbmodid
            #add-point:ON ACTION controlp INFIELD stdbmodid name="construct.c.page2.stdbmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdbmodid  #顯示到畫面上
            NEXT FIELD stdbmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbmodid
            #add-point:BEFORE FIELD stdbmodid name="construct.b.page2.stdbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdbmodid
            
            #add-point:AFTER FIELD stdbmodid name="construct.a.page2.stdbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbmoddt
            #add-point:BEFORE FIELD stdbmoddt name="construct.b.page2.stdbmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON stdc002,stdc003,stdc004,stdc005
           FROM s_detail3[1].stdc002,s_detail3[1].stdc003,s_detail3[1].stdc004,s_detail3[1].stdc005
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc002
            #add-point:BEFORE FIELD stdc002 name="construct.b.page3.stdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc002
            
            #add-point:AFTER FIELD stdc002 name="construct.a.page3.stdc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.stdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc002
            #add-point:ON ACTION controlp INFIELD stdc002 name="construct.c.page3.stdc002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.stdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc003
            #add-point:ON ACTION controlp INFIELD stdc003 name="construct.c.page3.stdc003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef003 = 'Y' " #
#            CALL q_ooef001()                             #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdc003') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdc003',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' " #
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO stdc003  #顯示到畫面上
            NEXT FIELD stdc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc003
            #add-point:BEFORE FIELD stdc003 name="construct.b.page3.stdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc003
            
            #add-point:AFTER FIELD stdc003 name="construct.a.page3.stdc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc004
            #add-point:BEFORE FIELD stdc004 name="construct.b.page3.stdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc004
            
            #add-point:AFTER FIELD stdc004 name="construct.a.page3.stdc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.stdc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc004
            #add-point:ON ACTION controlp INFIELD stdc004 name="construct.c.page3.stdc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc005
            #add-point:BEFORE FIELD stdc005 name="construct.b.page3.stdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc005
            
            #add-point:AFTER FIELD stdc005 name="construct.a.page3.stdc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.stdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc005
            #add-point:ON ACTION controlp INFIELD stdc005 name="construct.c.page3.stdc005"
            
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
   CALL asti701_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL asti701_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_stdb_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_stdb3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="asti701.insert" >}
#+ 資料修改
PRIVATE FUNCTION asti701_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL asti701_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asti701.modify" >}
#+ 資料新增
PRIVATE FUNCTION asti701_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point 
  
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   LET l_ac_t = g_detail_idx
 
   #add-point:modify段新增前 name="modify.before_modify"
   
   #end add-point 
   
   #進入資料輸入段落
   CALL asti701_input('u')
    
   IF INT_FLAG AND g_stdb_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL asti701_b_fill(g_wc)
      CALL asti701_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asti701.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asti701_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point 
   DEFINE li_ac LIKE type_t.num10
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_stdb_d_t.* = g_stdb_d[li_ac].*
   LET g_stdb_d_o.* = g_stdb_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM stdb_t 
         WHERE stdbent = g_enterprise AND
           stdb001 = g_stdb_d_t.stdb001
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "stdb_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti701_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM stdc_t 
         WHERE stdcent = g_enterprise AND
           stdc001 = g_stdb_d_t.stdb001
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
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
 
{<section id="asti701.input" >}
#+ 資料輸入
PRIVATE FUNCTION asti701_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   #add--2015/07/02 By shiun--(E)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD    #15/06/09 Sarah add
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #add--2015/07/02 By shiun--(E)
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT stdbstus,stdb001,stdb002,stdb003,stdb004,stdb005,stdb006,stdb007,stdb008, 
       stdb009,stdb010,stdb001,stdbownid,stdbowndp,stdbcrtid,stdbcrtdp,stdbcrtdt,stdbmodid,stdbmoddt  
       FROM stdb_t WHERE stdbent=? AND stdb001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE asti701_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT stdc002,stdc003,stdc004,stdc005 FROM stdc_t WHERE stdcent=? AND stdc001=?  
       AND stdc002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE asti701_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
      
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:input段修改前 name="input.before_input"
   CALL cl_set_act_visible("insert,delete,reproduce", TRUE)
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_stdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL asti701_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_stdb_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
 
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_stdb_d[l_ac].*
            LET g_master.* = g_stdb_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_stdb_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_stdb_d[l_ac].stdb001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stdb_d_t.* = g_stdb_d[l_ac].*  #BACKUP
               LET g_stdb_d_o.* = g_stdb_d[l_ac].*  #BACKUP
               IF NOT asti701_lock_b("stdb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asti701_bcl INTO g_stdb_d[l_ac].stdbstus,g_stdb_d[l_ac].stdb001,g_stdb_d[l_ac].stdb002, 
                      g_stdb_d[l_ac].stdb003,g_stdb_d[l_ac].stdb004,g_stdb_d[l_ac].stdb005,g_stdb_d[l_ac].stdb006, 
                      g_stdb_d[l_ac].stdb007,g_stdb_d[l_ac].stdb008,g_stdb_d[l_ac].stdb009,g_stdb_d[l_ac].stdb010, 
                      g_stdb2_d[l_ac].stdb001,g_stdb2_d[l_ac].stdbownid,g_stdb2_d[l_ac].stdbowndp,g_stdb2_d[l_ac].stdbcrtid, 
                      g_stdb2_d[l_ac].stdbcrtdp,g_stdb2_d[l_ac].stdbcrtdt,g_stdb2_d[l_ac].stdbmodid, 
                      g_stdb2_d[l_ac].stdbmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stdb_d_t.stdb001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_stdb_d_mask_o[l_ac].* =  g_stdb_d[l_ac].*
                  CALL asti701_stdb_t_mask()
                  LET g_stdb_d_mask_n[l_ac].* =  g_stdb_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL asti701_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asti701_set_entry_b(l_cmd)
            CALL asti701_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
            IF l_cmd = 'u' THEN 
               IF g_stdb_d[l_ac].stdb007 = '2' THEN 
                  CALL cl_set_comp_entry("stdb009",TRUE)
               ELSE
                  CALL cl_set_comp_entry("stdb009",FALSE)
               END IF 
            END IF 
#            IF g_stdb_d[l_ac].stdb003 = '1' THEN 
#               CALL cl_set_comp_visible("stdc005,stdc004",FALSE)
#            ELSE
#               CALL cl_set_comp_visible("stdc005,stdc004",TRUE)
#            END IF             
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL asti701_fetch()
            CALL asti701_idx_chk('m')
 
         BEFORE INSERT
            
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_stdb3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stdb_d[l_ac].* TO NULL 
            INITIALIZE g_stdb_d_t.* TO NULL 
            INITIALIZE g_stdb_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stdb2_d[l_ac].stdbownid = g_user
      LET g_stdb2_d[l_ac].stdbowndp = g_dept
      LET g_stdb2_d[l_ac].stdbcrtid = g_user
      LET g_stdb2_d[l_ac].stdbcrtdp = g_dept 
      LET g_stdb2_d[l_ac].stdbcrtdt = cl_get_current()
      LET g_stdb2_d[l_ac].stdbmodid = g_user
      LET g_stdb2_d[l_ac].stdbmoddt = cl_get_current()
      LET g_stdb_d[l_ac].stdbstus = ''
 
 
 
                  LET g_stdb_d[l_ac].stdbstus = "N"
      LET g_stdb_d[l_ac].stdb004 = "1"
      LET g_stdb_d[l_ac].stdb007 = "1"
      LET g_stdb_d[l_ac].stdb008 = "2"
      LET g_stdb_d[l_ac].stdb009 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_stdb_d[l_ac].stdb004 = '1'
            LET g_stdb_d[l_ac].stdb008 = "1"   #add by geza 20151126 往来关系默认给1
            #end add-point
            LET g_stdb_d_t.* = g_stdb_d[l_ac].*     #新輸入資料
            LET g_stdb_d_o.* = g_stdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asti701_set_entry_b(l_cmd)
            CALL asti701_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stdb_d[li_reproduce_target].* = g_stdb_d[li_reproduce].*
               LET g_stdb2_d[li_reproduce_target].* = g_stdb2_d[li_reproduce].*
 
               LET g_stdb_d[g_stdb_d.getLength()].stdb001 = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            IF g_stdb_d[l_ac].stdb007 = '2' THEN 
               CALL cl_set_comp_entry("stdb009",TRUE)
            ELSE
               CALL cl_set_comp_entry("stdb009",FALSE)
            END IF 
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
            SELECT COUNT(1) INTO l_count FROM stdb_t 
             WHERE stdbent = g_enterprise AND stdb001 = g_stdb_d[l_ac].stdb001 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stdb_d[g_detail_idx].stdb001
               CALL asti701_insert_b('stdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #当往来关系=1.两角时，内部交易页签不可以新增，自动产生两笔数据 ，后续可以修改取价类型以及比例值
               IF g_stdb_d[g_detail_idx].stdb008 = '1' THEN
                  #第一笔供货对象资料
                  INSERT INTO stdc_t
                  (stdcent,
                   stdc001,stdc002
                   ,stdc003,stdc004,stdc005) 
                   VALUES(g_enterprise,
                   g_stdb_d[g_detail_idx].stdb001,1
                   ,g_stdb_d[g_detail_idx].stdb005,'1','')
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = "stdc_t" 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = FALSE 
                      CALL cl_err()
                   END IF
                  #第二笔需求对象资料 
                  INSERT INTO stdc_t
                  (stdcent,
                   stdc001,stdc002
                   ,stdc003,stdc004,stdc005) 
                   VALUES(g_enterprise,
                   g_stdb_d[g_detail_idx].stdb001,2
                   ,g_stdb_d[g_detail_idx].stdb006,'1','')
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = "stdc_t" 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = FALSE 
                      CALL cl_err()
                   END IF
                   #更新单头有效码栏位为N
                   UPDATE stdb_t SET stdbstus = 'Y'
                    WHERE stdbent = g_enterprise
                      AND stdb001 = g_stdb_d[g_detail_idx].stdb001
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = "stdb_t" 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = FALSE 
                      CALL cl_err()
                   END IF                   
                  #CALL asti701_fetch()
                   CALL asti701_display()
               ELSE
                  CALL asti701_detail_chk()
                  IF NOT cl_null(g_errno) THEN
                     LET g_stdb_d[l_ac].stdbstus = 'N'
                     #更新单头有效码栏位为N
                     UPDATE stdb_t SET stdbstus = 'N'
                      WHERE stdbent = g_enterprise
                        AND stdb001 = g_stdb_d[g_detail_idx].stdb001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "stdb_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                     END IF
                  END IF 
               END IF 
               #end add-point
            ELSE    
               INITIALIZE g_stdb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "stdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asti701_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_stdb_d[l_ac].*
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
               
               DELETE FROM stdb_t
                WHERE stdbent = g_enterprise AND 
                      stdb001 = g_stdb_d_t.stdb001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stdb_t:",SQLERRMESSAGE  
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
                  LET g_log1 = util.JSON.stringify(g_stdb_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE asti701_bcl
               LET l_count = g_stdb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stdb_d_t.stdb001
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti701_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL asti701_delete_b('stdb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_stdb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdbstus
            #add-point:BEFORE FIELD stdbstus name="input.b.page1.stdbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdbstus
            
            #add-point:AFTER FIELD stdbstus name="input.a.page1.stdbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdbstus
            #add-point:ON CHANGE stdbstus name="input.g.page1.stdbstus"
            IF g_stdb_d[l_ac].stdbstus ='Y' THEN 
               LET g_errno = ''
               CALL s_asti701_stdb001_chk_1(g_stdb_d[l_ac].stdb001,g_stdb_d[l_ac].stdb002,g_stdb_d[l_ac].stdb005,g_stdb_d[l_ac].stdb006) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb_d[l_ac].stdbstus = 'N'
                  NEXT FIELD stdbstus
               END IF 
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb001
            #add-point:BEFORE FIELD stdb001 name="input.b.page1.stdb001"
               IF l_cmd = 'a' AND cl_null(g_stdb_d[l_ac].stdb001) THEN
#                 CALL s_aooi390('27') RETURNING l_success,g_stdb_d[l_ac].stdb001
                  CALL s_aooi390_gen('27') RETURNING l_success,g_stdb_d[l_ac].stdb001,l_oofg_return   #add--2015/05/08 By shiun
                 IF NOT cl_null(g_stdb_d[l_ac].stdb001) THEN               
                    IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM stdb_t WHERE "||"stdbent = '" ||g_enterprise|| "' AND "||"stdb001 = '"||g_stdb_d[l_ac].stdb001||"'",'std-00004',0) THEN #160905-00007#15 by 08172 *变1
                       LET g_stdb_d[l_ac].stdb001 = ''
                    END IF   
                 END IF                            
              END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb001
            
            #add-point:AFTER FIELD stdb001 name="input.a.page1.stdb001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_stdb_d[g_detail_idx].stdb001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stdb_d[g_detail_idx].stdb001 != g_stdb_d_t.stdb001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM stdb_t WHERE "||"stdbent = '" ||g_enterprise|| "' AND "||"stdb001 = '"||g_stdb_d[g_detail_idx].stdb001 ||"'",'std-00004',0) THEN #160905-00007#15 by 08172 *变1
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/07/02 By shiun--(S)
                  IF NOT s_aooi390_chk('27',g_stdb_d[l_ac].stdb001) THEN
                     LET g_stdb_d[l_ac].stdb001 = g_stdb_d_t.stdb001
                     DISPLAY BY NAME g_stdb_d[l_ac].stdb001
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/07/02 By shiun--(E)
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb001
            #add-point:ON CHANGE stdb001 name="input.g.page1.stdb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb002
            
            #add-point:AFTER FIELD stdb002 name="input.a.page1.stdb002"
            IF NOT cl_null(g_stdb_d[l_ac].stdb002) THEN 
               CALL asti701_stdb002_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb_d[l_ac].stdb002 = g_stdb_d_t.stdb002
                  NEXT FIELD stdb002
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb_d[l_ac].stdb002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb_d[l_ac].stdb002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb_d[l_ac].stdb002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb002
            #add-point:BEFORE FIELD stdb002 name="input.b.page1.stdb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb002
            #add-point:ON CHANGE stdb002 name="input.g.page1.stdb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb003
            #add-point:BEFORE FIELD stdb003 name="input.b.page1.stdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb003
            
            #add-point:AFTER FIELD stdb003 name="input.a.page1.stdb003"
            IF NOT cl_null(g_stdb_d[l_ac].stdb003) THEN 
               CALL asti701_stdb003_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()          
                  LET g_stdb_d[l_ac].stdb003 = g_stdb_d_t.stdb003                  
                  NEXT FIELD stdb003
               END IF 
               CALL asti701_stdb007_chk(l_cmd)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()          
                  LET g_stdb_d[l_ac].stdb003 = g_stdb_d_t.stdb003                  
                  NEXT FIELD stdb003
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb003
            #add-point:ON CHANGE stdb003 name="input.g.page1.stdb003"
#            IF g_stdb_d[l_ac].stdb003 = '1' THEN
#               UPDATE stdc_t SET stdc005 = '',
#                                 stdc004 = ''
#                WHERE stdcent = g_enterprise
#                  AND stdc001 = g_stdb_d[l_ac].stdb001
#               CALL cl_set_comp_visible("stdc005,stdc004",FALSE)
#            ELSE
#               UPDATE stdc_t SET stdc005 = '',
#                                 stdc004 = '1'
#                WHERE stdcent = g_enterprise
#                  AND stdc001 = g_stdb_d[l_ac].stdb001
#               CALL asti701_fetch()
#               CALL cl_set_comp_visible("stdc005,stdc004",TRUE)
#            END IF   
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb004
            #add-point:BEFORE FIELD stdb004 name="input.b.page1.stdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb004
            
            #add-point:AFTER FIELD stdb004 name="input.a.page1.stdb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb004
            #add-point:ON CHANGE stdb004 name="input.g.page1.stdb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb005
            
            #add-point:AFTER FIELD stdb005 name="input.a.page1.stdb005"
            IF NOT cl_null(g_stdb_d[l_ac].stdb005) THEN 
               IF s_aooi500_setpoint(g_prog,'stdb005') THEN
                  CALL s_aooi500_chk(g_prog,'stdb005',g_stdb_d[l_ac].stdb005,g_site) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_stdb_d[l_ac].stdb005
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_stdb_d[l_ac].stdb005 = g_stdb_d_t.stdb005
                     CALL s_desc_get_department_desc(g_stdb_d[l_ac].stdb005) RETURNING g_stdb_d[l_ac].stdb005_desc
                     DISPLAY BY NAME g_stdb_d[l_ac].stdb005,g_stdb_d[l_ac].stdb005_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  CALL asti701_stdb005_chk(g_stdb_d[l_ac].stdb004,g_stdb_d[l_ac].stdb005)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()               
                     LET g_stdb_d[l_ac].stdb005 = g_stdb_d_t.stdb005
                     NEXT FIELD stdb005
                  END IF 
               END IF
               
#               CALL asti701_stdb005_chk(g_stdb_d[l_ac].stdb004,g_stdb_d[l_ac].stdb005)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = '' 
#                  LET g_errparam.code   = g_errno 
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()               
#                  LET g_stdb_d[l_ac].stdb005 = g_stdb_d_t.stdb005
#                  NEXT FIELD stdb005
#               END IF 
               IF NOT cl_null(g_stdb_d[l_ac].stdb006) THEN 
                  IF g_stdb_d[l_ac].stdb005 =g_stdb_d[l_ac].stdb006 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'ast-00155' 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()               
                     LET g_stdb_d[l_ac].stdb005 = g_stdb_d_t.stdb005
                     NEXT FIELD stdb005
                  END IF 
               END IF 
               CALL asti701_stdb007_chk(l_cmd)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb_d[l_ac].stdb005 = g_stdb_d_t.stdb005
                  NEXT FIELD stdb005
               END IF 
               CALL asti701_stdb005_chk1() 
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb_d[l_ac].stdb005 = g_stdb_d_t.stdb005
                  NEXT FIELD stdb005
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb_d[l_ac].stdb005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb_d[l_ac].stdb005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb_d[l_ac].stdb005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb005
            #add-point:BEFORE FIELD stdb005 name="input.b.page1.stdb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb005
            #add-point:ON CHANGE stdb005 name="input.g.page1.stdb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb006
            
            #add-point:AFTER FIELD stdb006 name="input.a.page1.stdb006"
            IF NOT cl_null(g_stdb_d[l_ac].stdb006) THEN 
               IF s_aooi500_setpoint(g_prog,'stdb006') THEN
                  CALL s_aooi500_chk(g_prog,'stdb006',g_stdb_d[l_ac].stdb006,g_site) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_stdb_d[l_ac].stdb006
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_stdb_d[l_ac].stdb006 = g_stdb_d_t.stdb006
                     CALL s_desc_get_department_desc(g_stdb_d[l_ac].stdb006) RETURNING g_stdb_d[l_ac].stdb006_desc
                     DISPLAY BY NAME g_stdb_d[l_ac].stdb006,g_stdb_d[l_ac].stdb006_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  CALL asti701_stdb005_chk(g_stdb_d[l_ac].stdb004,g_stdb_d[l_ac].stdb006)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()               
                     LET g_stdb_d[l_ac].stdb006 = g_stdb_d_t.stdb006
                     NEXT FIELD stdb006
                  END IF 
               END IF 
#               CALL asti701_stdb005_chk(g_stdb_d[l_ac].stdb004,g_stdb_d[l_ac].stdb006)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = '' 
#                  LET g_errparam.code   = g_errno 
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()               
#                  LET g_stdb_d[l_ac].stdb006 = g_stdb_d_t.stdb006
#                  NEXT FIELD stdb006
#               END IF 
               IF NOT cl_null(g_stdb_d[l_ac].stdb005) THEN 
                  IF g_stdb_d[l_ac].stdb005 =g_stdb_d[l_ac].stdb006 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'ast-00155' 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()               
                     LET g_stdb_d[l_ac].stdb006 = g_stdb_d_t.stdb006
                     NEXT FIELD stdb006
                  END IF 
               END IF 
               CALL asti701_stdb007_chk(l_cmd)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb_d[l_ac].stdb006 = g_stdb_d_t.stdb006
                  NEXT FIELD stdb006
               END IF 
               CALL asti701_stdb006_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb_d[l_ac].stdb006 = g_stdb_d_t.stdb006
                  NEXT FIELD stdb006
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb_d[l_ac].stdb006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb_d[l_ac].stdb006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb_d[l_ac].stdb006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb006
            #add-point:BEFORE FIELD stdb006 name="input.b.page1.stdb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb006
            #add-point:ON CHANGE stdb006 name="input.g.page1.stdb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb007
            #add-point:BEFORE FIELD stdb007 name="input.b.page1.stdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb007
            
            #add-point:AFTER FIELD stdb007 name="input.a.page1.stdb007"
            IF g_stdb_d[l_ac].stdb007 = '1' THEN 
               CALL asti701_stdb007_chk(l_cmd)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = g_errno 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb_d[l_ac].stdb007 = g_stdb_d_t.stdb007
                  NEXT FIELD stdb007
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb007
            #add-point:ON CHANGE stdb007 name="input.g.page1.stdb007"
            IF g_stdb_d[l_ac].stdb007 = '2' THEN 
               CALL cl_set_comp_entry("stdb009",TRUE)
            ELSE
               CALL cl_set_comp_entry("stdb009",FALSE)
               LET g_stdb_d[l_ac].stdb009 = 'N'
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb008
            #add-point:BEFORE FIELD stdb008 name="input.b.page1.stdb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb008
            
            #add-point:AFTER FIELD stdb008 name="input.a.page1.stdb008"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb008
            #add-point:ON CHANGE stdb008 name="input.g.page1.stdb008"
            LET l_n = 0         
            SELECT COUNT(1) INTO l_n   #160905-00007#15 by 08172 *变1
              FROM stdc_t
             WHERE stdcent =g_enterprise 
               AND stdc001 = g_stdb_d[l_ac].stdb001
            IF l_n > 0 THEN 
               IF cl_ask_confirm('ast-00154') THEN 
#                  #清空单身二资料
#                  DELETE FROM stdc_t WHERE stdcent =g_enterprise AND stdc001 = g_stdb_d[l_ac].stdb001
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "stdc_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = FALSE 
#                     CALL cl_err()
#                  END IF
#                  CALL g_stdb3_d.clear()
#                  CALL asti701_display()
               ELSE
                  LET g_stdb_d[l_ac].stdb008 = g_stdb_d_t.stdb008
               END IF 
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb009
            #add-point:BEFORE FIELD stdb009 name="input.b.page1.stdb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb009
            
            #add-point:AFTER FIELD stdb009 name="input.a.page1.stdb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb009
            #add-point:ON CHANGE stdb009 name="input.g.page1.stdb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdb010
            #add-point:BEFORE FIELD stdb010 name="input.b.page1.stdb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdb010
            
            #add-point:AFTER FIELD stdb010 name="input.a.page1.stdb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdb010
            #add-point:ON CHANGE stdb010 name="input.g.page1.stdb010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.stdbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdbstus
            #add-point:ON ACTION controlp INFIELD stdbstus name="input.c.page1.stdbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb001
            #add-point:ON ACTION controlp INFIELD stdb001 name="input.c.page1.stdb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb002
            #add-point:ON ACTION controlp INFIELD stdb002 name="input.c.page1.stdb002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stdb_d[l_ac].stdb002             #給予default值

            #給予arg
            LET g_qryparam.where = " ooef212 = 'Y' "
            CALL q_ooef001()                                #呼叫開窗

            LET g_stdb_d[l_ac].stdb002 = g_qryparam.return1              

            DISPLAY g_stdb_d[l_ac].stdb002 TO stdb002              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb_d[l_ac].stdb002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb_d[l_ac].stdb002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb_d[l_ac].stdb002_desc
            NEXT FIELD stdb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb003
            #add-point:ON ACTION controlp INFIELD stdb003 name="input.c.page1.stdb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb004
            #add-point:ON ACTION controlp INFIELD stdb004 name="input.c.page1.stdb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb005
            #add-point:ON ACTION controlp INFIELD stdb005 name="input.c.page1.stdb005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stdb_d[l_ac].stdb005             #給予default值

            #給予arg
#            LET g_qryparam.where = " ooef003 = 'Y' "
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdb005') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdb005',g_site,'i')   #150308-00001#5  By benson add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' " #
               CALL q_ooef001() 
            END IF
            LET g_stdb_d[l_ac].stdb005 = g_qryparam.return1              

            DISPLAY g_stdb_d[l_ac].stdb005 TO stdb005              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb_d[l_ac].stdb005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb_d[l_ac].stdb005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb_d[l_ac].stdb005_desc
            NEXT FIELD stdb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb006
            #add-point:ON ACTION controlp INFIELD stdb006 name="input.c.page1.stdb006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stdb_d[l_ac].stdb006             #給予default值

            #給予arg
#            LET g_qryparam.where = " ooef003 = 'Y' "
#            CALL q_ooef001()                               #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdb006') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdb006',g_site,'i')   #150308-00001#5  By benson add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' " #
               CALL q_ooef001() 
            END IF

            LET g_stdb_d[l_ac].stdb006 = g_qryparam.return1              

            DISPLAY g_stdb_d[l_ac].stdb006 TO stdb006              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb_d[l_ac].stdb006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb_d[l_ac].stdb006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb_d[l_ac].stdb006_desc
            NEXT FIELD stdb006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb007
            #add-point:ON ACTION controlp INFIELD stdb007 name="input.c.page1.stdb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb008
            #add-point:ON ACTION controlp INFIELD stdb008 name="input.c.page1.stdb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb009
            #add-point:ON ACTION controlp INFIELD stdb009 name="input.c.page1.stdb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stdb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdb010
            #add-point:ON ACTION controlp INFIELD stdb010 name="input.c.page1.stdb010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_stdb_d[l_ac].* = g_stdb_d_t.*
               CLOSE asti701_bcl
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
               LET g_errparam.extend = g_stdb_d[l_ac].stdb001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_stdb_d[l_ac].* = g_stdb_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_stdb2_d[l_ac].stdbmodid = g_user 
LET g_stdb2_d[l_ac].stdbmoddt = cl_get_current()
LET g_stdb2_d[l_ac].stdbmodid_desc = cl_get_username(g_stdb2_d[l_ac].stdbmodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL asti701_stdb_t_mask_restore('restore_mask_o')
      
               UPDATE stdb_t SET (stdbstus,stdb001,stdb002,stdb003,stdb004,stdb005,stdb006,stdb007,stdb008, 
                   stdb009,stdb010,stdbownid,stdbowndp,stdbcrtid,stdbcrtdp,stdbcrtdt,stdbmodid,stdbmoddt) = (g_stdb_d[l_ac].stdbstus, 
                   g_stdb_d[l_ac].stdb001,g_stdb_d[l_ac].stdb002,g_stdb_d[l_ac].stdb003,g_stdb_d[l_ac].stdb004, 
                   g_stdb_d[l_ac].stdb005,g_stdb_d[l_ac].stdb006,g_stdb_d[l_ac].stdb007,g_stdb_d[l_ac].stdb008, 
                   g_stdb_d[l_ac].stdb009,g_stdb_d[l_ac].stdb010,g_stdb2_d[l_ac].stdbownid,g_stdb2_d[l_ac].stdbowndp, 
                   g_stdb2_d[l_ac].stdbcrtid,g_stdb2_d[l_ac].stdbcrtdp,g_stdb2_d[l_ac].stdbcrtdt,g_stdb2_d[l_ac].stdbmodid, 
                   g_stdb2_d[l_ac].stdbmoddt)
                WHERE stdbent = g_enterprise AND
                  stdb001 = g_stdb_d_t.stdb001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_stdb_d[l_ac].* = g_stdb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stdb_d[l_ac].* = g_stdb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stdb_d[g_detail_idx].stdb001
               LET gs_keys_bak[1] = g_stdb_d_t.stdb001
               CALL asti701_update_b('stdb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL asti701_stdb_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_stdb_d_t)
                     LET g_log2 = util.JSON.stringify(g_stdb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_stdb_d[l_ac].*
               CALL asti701_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_stdb_d_t.stdb008 != g_stdb_d[l_ac].stdb008 THEN 
                  #清空单身二资料
                  DELETE FROM stdc_t WHERE stdcent =g_enterprise AND stdc001 = g_stdb_d_t.stdb001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stdc_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                  END IF 
                  #当往来关系=1.两角时，内部交易页签不可以新增，自动产生两笔数据 ，后续可以修改取价类型以及比例值
                  IF g_stdb_d[g_detail_idx].stdb008 = '1' THEN
                     #第一笔供货对象资料
                     INSERT INTO stdc_t
                     (stdcent,
                      stdc001,stdc002
                      ,stdc003,stdc004,stdc005) 
                      VALUES(g_enterprise,
                      g_stdb_d[g_detail_idx].stdb001,1
                      ,g_stdb_d[g_detail_idx].stdb005,'1','')
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "stdc_t" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                      END IF
                     #第二笔需求对象资料 
                     INSERT INTO stdc_t
                     (stdcent,
                      stdc001,stdc002
                      ,stdc003,stdc004,stdc005) 
                      VALUES(g_enterprise,
                      g_stdb_d[g_detail_idx].stdb001,2
                      ,g_stdb_d[g_detail_idx].stdb006,'1','')
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "stdc_t" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                      END IF
                  END IF 
               END IF
               CALL g_stdb3_d.clear()
               CALL asti701_display()
               CALL asti701_detail_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_stdb_d[l_ac].stdbstus = 'N'
                  #更新单头有效码栏位为N
                  UPDATE stdb_t SET stdbstus = 'N'
                   WHERE stdbent = g_enterprise
                     AND stdb001 = g_stdb_d[g_detail_idx].stdb001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stdb_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                  END IF
               END IF 
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL asti701_unlock_b("stdb_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stdb_d[l_ac].* = g_stdb_d_t.*
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
            
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_stdb_d[l_ac].* = g_stdb_d_t.*
            END IF
            LET l_cmd = ''
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL asti701_detail_chk()
            IF NOT cl_null(g_errno) THEN
               #更新单头有效码栏位为N
               UPDATE stdb_t SET stdbstus = 'N'
                WHERE stdbent = g_enterprise
                  AND stdb001 = g_stdb_d[g_detail_idx].stdb001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stdb_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
               END IF
            END IF 
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()      
            #CALL cl_showmsg()            
    
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_stdb_d[li_reproduce_target].* = g_stdb_d[li_reproduce].*
               LET g_stdb2_d[li_reproduce_target].* = g_stdb2_d[li_reproduce].*
 
               LET g_stdb_d[li_reproduce_target].stdb001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stdb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stdb_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_stdb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_stdb_d[g_detail_idx].stdb001) THEN
               NEXT FIELD stdbstus
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stdb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_stdb3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            LET g_action_choice = ''
            CALL asti701_fetch()
            IF g_stdb_d[g_detail_idx].stdb008 = '1' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'ast-00158' 
               LET g_errparam.popup  = FALSE
               CALL cl_err()
            END IF 
            #end add-point
 
         BEFORE INSERT
            IF g_stdb_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD stdb001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stdb3_d[l_ac].* TO NULL 
            INITIALIZE g_stdb3_d_t.* TO NULL 
            INITIALIZE g_stdb3_d_o.* TO NULL 
                  LET g_stdb3_d[l_ac].stdc004 = "2"
 
            #add-point:modify段before備份 name="input.body3.before_bak"

            IF g_stdb_d[g_detail_idx].stdb008 = '1' THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'ast-00158' 
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               CANCEL INSERT 
            END IF 
            #end add-point
            LET g_stdb3_d_t.* = g_stdb3_d[l_ac].*     #新輸入資料
            LET g_stdb3_d_o.* = g_stdb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asti701_set_entry_b(l_cmd)
            CALL asti701_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stdb3_d[li_reproduce_target].* = g_stdb3_d[li_reproduce].*
 
               LET g_stdb3_d[li_reproduce_target].stdc002 = NULL
            END IF
            #add-point:input段before insert name="input.body3.before_insert"
            IF g_stdb3_d[l_ac].stdc004 = '3' OR g_stdb3_d[l_ac].stdc004 = '4' THEN 
               CALL cl_set_comp_entry("stdc005",TRUE)
            ELSE
               CALL cl_set_comp_entry("stdc005",FALSE)
               LET g_stdb3_d[l_ac].stdc005 = ''
            END IF 
#            IF g_stdb_d[g_detail_idx].stdb003 = '1' THEN 
#               CALL cl_set_comp_visible("stdc005,stdc004",FALSE)
#               LET g_stdb3_d[l_ac].stdc004 = ''
#            ELSE
#               CALL cl_set_comp_visible("stdc005,stdc004",TRUE)
#            END IF 
            SELECT MAX(stdc002) + 1 INTO g_stdb3_d[l_ac].stdc002
              FROM stdc_t
             WHERE stdc001 = g_stdb_d[g_detail_idx].stdb001
               AND stdcent = g_enterprise
            IF cl_null(g_stdb3_d[l_ac].stdc002) THEN 
               LET g_stdb3_d[l_ac].stdc002 = 1
            END IF 
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
            LET g_detail_cnt = g_stdb3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_stdb3_d[l_ac].stdc002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stdb3_d_t.* = g_stdb3_d[l_ac].*  #BACKUP
               LET g_stdb3_d_o.* = g_stdb3_d[l_ac].*  #BACKUP
               IF NOT asti701_lock_b("stdc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asti701_bcl2 INTO g_stdb3_d[l_ac].stdc002,g_stdb3_d[l_ac].stdc003,g_stdb3_d[l_ac].stdc004, 
                      g_stdb3_d[l_ac].stdc005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stdb3_d_mask_o[l_ac].* =  g_stdb3_d[l_ac].*
                  CALL asti701_stdc_t_mask()
                  LET g_stdb3_d_mask_n[l_ac].* =  g_stdb3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL asti701_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asti701_set_entry_b(l_cmd)
            CALL asti701_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            IF l_cmd = 'u' THEN 
               IF g_stdb3_d[l_ac].stdc004 = '3' OR g_stdb3_d[l_ac].stdc004 = '4' THEN 
                  CALL cl_set_comp_entry("stdc005",TRUE)
               ELSE
                  CALL cl_set_comp_entry("stdc005",FALSE)
               END IF 
            END IF 
#            IF g_stdb_d[g_detail_idx].stdb003 = '1' THEN 
#               CALL cl_set_comp_visible("stdc005,stdc004",FALSE)
#            ELSE
#               CALL cl_set_comp_visible("stdc005,stdc004",TRUE)
#            END IF 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL asti701_idx_chk('d')
            
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
               IF g_stdb_d[g_detail_idx].stdb008 = '1' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'ast-00158' 
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CANCEL DELETE 
               END IF 
               #end add-point  
               
               DELETE FROM stdc_t
                WHERE stdcent = g_enterprise AND
                   stdc001 = g_master.stdb001
                   AND stdc002 = g_stdb3_d_t.stdc002
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
           
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  LET g_change = 'Y'
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE asti701_bcl
               LET l_count = g_stdb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stdb_d[g_detail_idx].stdb001
               LET gs_keys[2] = g_stdb3_d_t.stdc002
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL asti701_delete_b('stdc_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_stdb3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM stdc_t 
             WHERE stdcent = g_enterprise AND
                   stdc001 = g_master.stdb001
                   AND stdc002 = g_stdb3_d[g_detail_idx2].stdc002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stdb_d[g_detail_idx].stdb001
               LET gs_keys[2] = g_stdb3_d[g_detail_idx2].stdc002
               CALL asti701_insert_b('stdc_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_stdb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asti701_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               LET g_change = 'Y'
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_stdb3_d[l_ac].* = g_stdb3_d_t.*
               CLOSE asti701_bcl2
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
               LET g_stdb3_d[l_ac].* = g_stdb3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               LET g_change = 'Y'
               #end add-point
               
               #將遮罩欄位還原
               CALL asti701_stdc_t_mask_restore('restore_mask_o')
               
               UPDATE stdc_t SET (stdc002,stdc003,stdc004,stdc005) = (g_stdb3_d[l_ac].stdc002,g_stdb3_d[l_ac].stdc003, 
                   g_stdb3_d[l_ac].stdc004,g_stdb3_d[l_ac].stdc005) #自訂欄位頁簽
                WHERE stdcent = g_enterprise AND
                   stdc001 = g_master.stdb001
                   AND stdc002 = g_stdb3_d_t.stdc002
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_stdb3_d[l_ac].* = g_stdb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stdc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stdb3_d[l_ac].* = g_stdb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stdb_d[g_detail_idx].stdb001
               LET gs_keys_bak[1] = g_stdb_d[g_detail_idx].stdb001
               LET gs_keys[2] = g_stdb3_d[g_detail_idx2].stdc002
               LET gs_keys_bak[2] = g_stdb3_d_t.stdc002
               CALL asti701_update_b('stdc_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL asti701_stdc_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_stdb3_d_t)
                     LET g_log2 = util.JSON.stringify(g_stdb3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc002
            #add-point:BEFORE FIELD stdc002 name="input.b.page3.stdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc002
            
            #add-point:AFTER FIELD stdc002 name="input.a.page3.stdc002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_stdb_d[g_detail_idx].stdb001 IS NOT NULL AND g_stdb3_d[g_detail_idx2].stdc002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stdb_d[g_detail_idx].stdb001 != g_stdb_d[g_detail_idx].stdb001 OR g_stdb3_d[g_detail_idx2].stdc002 != g_stdb3_d_t.stdc002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM stdc_t WHERE "||"stdcent = '" ||g_enterprise|| "' AND "||"stdc001 = '"||g_stdb_d[g_detail_idx].stdb001 ||"' AND "|| "stdc002 = '"||g_stdb3_d[g_detail_idx2].stdc002 ||"'",'std-00004',0) THEN #160905-00007#15 by 08172 *变1
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF g_stdb3_d[l_ac].stdc002 < 0 THEN
                  LET g_stdb3_d[l_ac].stdc002 = g_stdb3_d_t.stdc002
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'ast-00083' 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()    
                  NEXT FIELD CURRENT
               END IF 
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdc002
            #add-point:ON CHANGE stdc002 name="input.g.page3.stdc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc003
            
            #add-point:AFTER FIELD stdc003 name="input.a.page3.stdc003"
            IF NOT cl_null(g_stdb3_d[l_ac].stdc003) THEN 
               IF s_aooi500_setpoint(g_prog,'stdc003') THEN
                  CALL s_aooi500_chk(g_prog,'stdc003',g_stdb3_d[l_ac].stdc003,g_site) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_stdb3_d[l_ac].stdc003
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_stdb3_d[l_ac].stdc003 = g_stdb3_d_t.stdc003
                     CALL s_desc_get_department_desc(g_stdb3_d[l_ac].stdc003) RETURNING g_stdb3_d[l_ac].stdc003_desc
                     DISPLAY BY NAME g_stdb3_d[l_ac].stdc003,g_stdb3_d[l_ac].stdc003_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  CALL asti701_stdb005_chk(g_stdb_d[g_detail_idx].stdb004,g_stdb3_d[l_ac].stdc003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()               
                     LET g_stdb3_d[l_ac].stdc003 = g_stdb3_d_t.stdc003
                     NEXT FIELD stdc003
                  END IF 
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND g_stdb3_d[l_ac].stdc003 != g_stdb3_d_t.stdc003) THEN 
                     CALL asti701_stdc003_chk()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = '' 
                        LET g_errparam.code   = g_errno 
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()               
                        LET g_stdb3_d[l_ac].stdc003 = g_stdb3_d_t.stdc003
                        NEXT FIELD stdc003
                     END IF 
                  END IF 
               END IF
#               CALL asti701_stdb005_chk(g_stdb_d[g_detail_idx].stdb004,g_stdb3_d[l_ac].stdc003)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = '' 
#                  LET g_errparam.code   = g_errno 
#                  LET g_errparam.popup  = TRUE
#                  CALL cl_err()               
#                  LET g_stdb3_d[l_ac].stdc003 = g_stdb3_d_t.stdc003
#                  NEXT FIELD stdc003
#               END IF 
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_stdb3_d[l_ac].stdc003 != g_stdb3_d_t.stdc003) THEN 
#                  CALL asti701_stdc003_chk()
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = '' 
#                     LET g_errparam.code   = g_errno 
#                     LET g_errparam.popup  = TRUE
#                     CALL cl_err()               
#                     LET g_stdb3_d[l_ac].stdc003 = g_stdb3_d_t.stdc003
#                     NEXT FIELD stdc003
#                  END IF 
#               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb3_d[l_ac].stdc003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb3_d[l_ac].stdc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb3_d[l_ac].stdc003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc003
            #add-point:BEFORE FIELD stdc003 name="input.b.page3.stdc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdc003
            #add-point:ON CHANGE stdc003 name="input.g.page3.stdc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc004
            #add-point:BEFORE FIELD stdc004 name="input.b.page3.stdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc004
            
            #add-point:AFTER FIELD stdc004 name="input.a.page3.stdc004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdc004
            #add-point:ON CHANGE stdc004 name="input.g.page3.stdc004"
            IF g_stdb3_d[l_ac].stdc004 = '3' OR g_stdb3_d[l_ac].stdc004 = '4' THEN 
               CALL cl_set_comp_entry("stdc005",TRUE)
            ELSE
               CALL cl_set_comp_entry("stdc005",FALSE)
               LET g_stdb3_d[l_ac].stdc005 = ''
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdc005
            #add-point:BEFORE FIELD stdc005 name="input.b.page3.stdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdc005
            
            #add-point:AFTER FIELD stdc005 name="input.a.page3.stdc005"
            IF NOT cl_null(g_stdb3_d[l_ac].stdc005) THEN 
               IF g_stdb3_d[l_ac].stdc005 < 0 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'aqc-00004' 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()               
                  LET g_stdb3_d[l_ac].stdc005 = g_stdb3_d_t.stdc005
                  NEXT FIELD stdc005
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stdc005
            #add-point:ON CHANGE stdc005 name="input.g.page3.stdc005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.stdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc002
            #add-point:ON ACTION controlp INFIELD stdc002 name="input.c.page3.stdc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.stdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc003
            #add-point:ON ACTION controlp INFIELD stdc003 name="input.c.page3.stdc003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stdb3_d[l_ac].stdc003             #給予default值
#            LET g_qryparam.where = " ooef003 = 'Y' "
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'stdc003') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stdc003',g_site,'i')   #150308-00001#5  By benson add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' " #
               CALL q_ooef001() 
            END IF
            LET g_stdb3_d[l_ac].stdc003 = g_qryparam.return1
            DISPLAY g_stdb3_d[l_ac].stdc003 TO stdc003              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stdb3_d[l_ac].stdc003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stdb3_d[l_ac].stdc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stdb3_d[l_ac].stdc003_desc
            NEXT FIELD stdc003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.stdc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc004
            #add-point:ON ACTION controlp INFIELD stdc004 name="input.c.page3.stdc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.stdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdc005
            #add-point:ON ACTION controlp INFIELD stdc005 name="input.c.page3.stdc005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stdb3_d[l_ac].* = g_stdb3_d_t.*
               END IF
               CLOSE asti701_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL asti701_unlock_b("stdc_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            CALL asti701_detail_chk()
            IF NOT cl_null(g_errno) THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = g_errno 
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT 
            ELSE
               IF g_change = 'Y' THEN 
                  #更新单头有效码栏位为Y
                  UPDATE stdb_t SET stdbstus = 'Y'
                   WHERE stdbent = g_enterprise
                     AND stdb001 = g_stdb_d[g_detail_idx].stdb001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stdb_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                  END IF
                  LET g_change = 'N'
               END IF 
            END IF 
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_stdb3_d[li_reproduce_target].* = g_stdb3_d[li_reproduce].*
 
               LET g_stdb3_d[li_reproduce_target].stdc002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_stdb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stdb3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_stdb2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL asti701_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL asti701_fetch()
            CALL asti701_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_stdb_d.getLength() THEN
               LET g_detail_idx = g_stdb_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
 
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_stdb_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stdbstus
               WHEN "s_detail2"
                  NEXT FIELD stdb001_2
               WHEN "s_detail3"
                  NEXT FIELD stdc002
 
            END CASE
         ELSE
            NEXT FIELD stdbstus
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
 
   
   #add-point:input段修改後 name="input.after_input"
   IF INT_FLAG THEN 
      CLOSE asti701_bcl
      CALL s_transaction_end('N','0')
      CALL asti701_detail_chk()
      IF NOT cl_null(g_errno) THEN
         #更新单头有效码栏位为N
         UPDATE stdb_t SET stdbstus = 'N'
          WHERE stdbent = g_enterprise
            AND stdb001 = g_stdb_d[g_detail_idx].stdb001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stdb_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
         END IF
      END IF 
      RETURN 
   END IF 
   #end add-point
 
   CLOSE asti701_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="asti701.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asti701_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.stdbstus,t0.stdb001,t0.stdb002,t0.stdb003,t0.stdb004,t0.stdb005, 
       t0.stdb006,t0.stdb007,t0.stdb008,t0.stdb009,t0.stdb010,t0.stdb001,t0.stdbownid,t0.stdbowndp,t0.stdbcrtid, 
       t0.stdbcrtdp,t0.stdbcrtdt,t0.stdbmodid,t0.stdbmoddt ,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 FROM stdb_t t0",
 
               " LEFT JOIN stdc_t ON stdcent = stdbent AND stdb001 = stdc001",
 
 
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stdb002 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.stdb005 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.stdb006 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.stdbownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.stdbowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.stdbcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.stdbcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.stdbmodid  ",
 
               " WHERE t0.stdbent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("stdb_t"),
                      " ORDER BY t0.stdb001"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"stdb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE asti701_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asti701_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stdb_d.clear()
   CALL g_stdb2_d.clear()   
   CALL g_stdb3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_stdb_d[l_ac].stdbstus,g_stdb_d[l_ac].stdb001,g_stdb_d[l_ac].stdb002,g_stdb_d[l_ac].stdb003, 
       g_stdb_d[l_ac].stdb004,g_stdb_d[l_ac].stdb005,g_stdb_d[l_ac].stdb006,g_stdb_d[l_ac].stdb007,g_stdb_d[l_ac].stdb008, 
       g_stdb_d[l_ac].stdb009,g_stdb_d[l_ac].stdb010,g_stdb2_d[l_ac].stdb001,g_stdb2_d[l_ac].stdbownid, 
       g_stdb2_d[l_ac].stdbowndp,g_stdb2_d[l_ac].stdbcrtid,g_stdb2_d[l_ac].stdbcrtdp,g_stdb2_d[l_ac].stdbcrtdt, 
       g_stdb2_d[l_ac].stdbmodid,g_stdb2_d[l_ac].stdbmoddt,g_stdb_d[l_ac].stdb002_desc,g_stdb_d[l_ac].stdb005_desc, 
       g_stdb_d[l_ac].stdb006_desc,g_stdb2_d[l_ac].stdbownid_desc,g_stdb2_d[l_ac].stdbowndp_desc,g_stdb2_d[l_ac].stdbcrtid_desc, 
       g_stdb2_d[l_ac].stdbcrtdp_desc,g_stdb2_d[l_ac].stdbmodid_desc
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
   
 
   CALL g_stdb_d.deleteElement(g_stdb_d.getLength())   
   CALL g_stdb2_d.deleteElement(g_stdb2_d.getLength())
   CALL g_stdb3_d.deleteElement(g_stdb3_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_stdb_d.getLength() THEN
       IF g_stdb_d.getLength() > 0 THEN
          LET g_detail_idx = g_stdb_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_stdb_d.getLength()
      LET g_stdb2_d[g_detail_idx].stdb001 = g_stdb_d[g_detail_idx].stdb001 
      #LET g_stdb3_d[g_detail_idx2].stdc002 = g_stdb_d[g_detail_idx].stdb001 
 
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
   FREE asti701_pb
   
   LET g_loc = 'm'
   CALL asti701_detail_show() 
   
   LET l_ac = 1
   IF g_stdb_d.getLength() > 0 THEN
      CALL asti701_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_stdb_d.getLength()
      LET g_stdb_d_mask_o[l_ac].* =  g_stdb_d[l_ac].*
      CALL asti701_stdb_t_mask()
      LET g_stdb_d_mask_n[l_ac].* =  g_stdb_d[l_ac].*
   END FOR
   
   LET g_stdb2_d_mask_o.* =  g_stdb2_d.*
   FOR l_ac = 1 TO g_stdb2_d.getLength()
      LET g_stdb2_d_mask_o[l_ac].* =  g_stdb2_d[l_ac].*
      CALL asti701_stdb_t_mask()
      LET g_stdb2_d_mask_n[l_ac].* =  g_stdb2_d[l_ac].*
   END FOR
   LET g_stdb3_d_mask_o.* =  g_stdb3_d.*
   FOR l_ac = 1 TO g_stdb3_d.getLength()
      LET g_stdb3_d_mask_o[l_ac].* =  g_stdb3_d[l_ac].*
      CALL asti701_stdc_t_mask()
      LET g_stdb3_d_mask_n[l_ac].* =  g_stdb3_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="asti701.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asti701_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_stdb_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_stdb2_d.clear()
   CALL g_stdb3_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.stdc002,t0.stdc003,t0.stdc004,t0.stdc005 ,t9.ooefl003 FROM stdc_t t0", 
              
                  "",
                                 " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.stdc003 AND t9.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.stdcent=?  AND t0. stdc001=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.stdc002" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE asti701_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR asti701_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise,g_stdb_d[l_ac].stdb001   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise,g_stdb_d[l_ac].stdb001 INTO g_stdb3_d[l_ac].stdc002,g_stdb3_d[l_ac].stdc003, 
#    g_stdb3_d[l_ac].stdc004,g_stdb3_d[l_ac].stdc005,g_stdb3_d[l_ac].stdc003_desc   #(ver:45) #(ver:46)mark 
 
   FOREACH b_fill_curs2 USING g_enterprise,g_stdb_d[g_detail_idx].stdb001 INTO g_stdb3_d[l_ac].stdc002, 
       g_stdb3_d[l_ac].stdc003,g_stdb3_d[l_ac].stdc004,g_stdb3_d[l_ac].stdc005,g_stdb3_d[l_ac].stdc003_desc  
         #(ver:45) #(ver:46)
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
   CALL cl_set_act_visible("reproduce,output", FALSE)
   #end add-point
   
   #CALL g_stdb2_d.deleteElement(g_stdb2_d.getLength())   
   CALL g_stdb3_d.deleteElement(g_stdb3_d.getLength())   
 
   
   LET g_stdb3_d_mask_o.* =  g_stdb3_d.*
   FOR l_ac = 1 TO g_stdb3_d.getLength()
      LET g_stdb3_d_mask_o[l_ac].* =  g_stdb3_d[l_ac].*
      CALL asti701_stdc_t_mask()
      LET g_stdb3_d_mask_n[l_ac].* =  g_stdb3_d[l_ac].*
   END FOR
 
   
   DISPLAY g_stdb3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL asti701_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="asti701.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asti701_detail_show()
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
   
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_stdb_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"
         
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
         
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_stdb3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
        
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="asti701.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asti701_set_entry_b(p_cmd)                                                  
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
 
{<section id="asti701.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asti701_set_no_entry_b(p_cmd)                                               
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
 
{<section id="asti701.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asti701_default_search()
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
      LET ls_wc = ls_wc, " stdb001 = '", g_argv[01], "' AND "
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
 
{<section id="asti701.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asti701_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
  
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "stdb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM stdb_t
       WHERE stdbent = g_enterprise AND
         stdb001 = ps_keys_bak[1]
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
   
 
   
   LET ls_group = "stdc_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM stdc_t
       WHERE stdcent = g_enterprise AND
         stdc001 = ps_keys_bak[1] AND stdc002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "stdb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM stdc_t
       WHERE stdcent = g_enterprise AND
         stdc001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
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
 
{<section id="asti701.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asti701_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point
  
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "stdb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      #add--2015/07/02 By shiun--(S)
      CALL s_aooi390_get_auto_no('27',ps_keys[1]) RETURNING l_success,ps_keys[1]
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
      END IF   
      LET g_stdb_d[g_detail_idx].stdb001 = ps_keys[1]
      DISPLAY BY NAME g_stdb_d[g_detail_idx].stdb001
      CALL s_aooi390_oofi_upd('27',ps_keys[1]) RETURNING l_success  #add--2015/05/18 By shiun 增加編碼功能
      #add--2015/07/02 By shiun--(E)
      #end add-point
      INSERT INTO stdb_t
                  (stdbent,
                   stdb001
                   ,stdbstus,stdb002,stdb003,stdb004,stdb005,stdb006,stdb007,stdb008,stdb009,stdb010,stdbownid,stdbowndp,stdbcrtid,stdbcrtdp,stdbcrtdt,stdbmodid,stdbmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_stdb_d[g_detail_idx].stdbstus,g_stdb_d[g_detail_idx].stdb002,g_stdb_d[g_detail_idx].stdb003, 
                       g_stdb_d[g_detail_idx].stdb004,g_stdb_d[g_detail_idx].stdb005,g_stdb_d[g_detail_idx].stdb006, 
                       g_stdb_d[g_detail_idx].stdb007,g_stdb_d[g_detail_idx].stdb008,g_stdb_d[g_detail_idx].stdb009, 
                       g_stdb_d[g_detail_idx].stdb010,g_stdb2_d[g_detail_idx].stdbownid,g_stdb2_d[g_detail_idx].stdbowndp, 
                       g_stdb2_d[g_detail_idx].stdbcrtid,g_stdb2_d[g_detail_idx].stdbcrtdp,g_stdb2_d[g_detail_idx].stdbcrtdt, 
                       g_stdb2_d[g_detail_idx].stdbmodid,g_stdb2_d[g_detail_idx].stdbmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "stdc_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
      #end add-point
      INSERT INTO stdc_t
                  (stdcent,
                   stdc001,stdc002
                   ,stdc003,stdc004,stdc005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stdb3_d[g_detail_idx2].stdc003,g_stdb3_d[g_detail_idx2].stdc004,g_stdb3_d[g_detail_idx2].stdc005) 
 
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
 
{<section id="asti701.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asti701_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "stdb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "stdb_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL asti701_stdb_t_mask_restore('restore_mask_o')
               
      UPDATE stdb_t 
         SET (stdb001
              ,stdbstus,stdb002,stdb003,stdb004,stdb005,stdb006,stdb007,stdb008,stdb009,stdb010,stdbownid,stdbowndp,stdbcrtid,stdbcrtdp,stdbcrtdt,stdbmodid,stdbmoddt) 
              = 
             (ps_keys[1]
              ,g_stdb_d[g_detail_idx].stdbstus,g_stdb_d[g_detail_idx].stdb002,g_stdb_d[g_detail_idx].stdb003, 
                  g_stdb_d[g_detail_idx].stdb004,g_stdb_d[g_detail_idx].stdb005,g_stdb_d[g_detail_idx].stdb006, 
                  g_stdb_d[g_detail_idx].stdb007,g_stdb_d[g_detail_idx].stdb008,g_stdb_d[g_detail_idx].stdb009, 
                  g_stdb_d[g_detail_idx].stdb010,g_stdb2_d[g_detail_idx].stdbownid,g_stdb2_d[g_detail_idx].stdbowndp, 
                  g_stdb2_d[g_detail_idx].stdbcrtid,g_stdb2_d[g_detail_idx].stdbcrtdp,g_stdb2_d[g_detail_idx].stdbcrtdt, 
                  g_stdb2_d[g_detail_idx].stdbmodid,g_stdb2_d[g_detail_idx].stdbmoddt) 
         WHERE stdbent = g_enterprise AND
               stdb001 = ps_keys_bak[1]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stdb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stdb_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL asti701_stdb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "stdc_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "stdc_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL asti701_stdc_t_mask_restore('restore_mask_o')
      
      UPDATE stdc_t 
         SET (stdc001,stdc002
              ,stdc003,stdc004,stdc005) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stdb3_d[g_detail_idx2].stdc003,g_stdb3_d[g_detail_idx2].stdc004,g_stdb3_d[g_detail_idx2].stdc005)  
 
         WHERE stdcent = g_enterprise AND
               stdc001 = ps_keys_bak[1] AND stdc002 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stdc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asti701_stdc_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti701.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION asti701_key_update_b()
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
   
   IF g_master.stdb001 <> g_master_t.stdb001 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE stdc_t 
      SET (stdc001) 
           = 
          (g_master.stdb001) 
      WHERE stdcent = g_enterprise AND
           stdc001 = g_master_t.stdb001
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stdc_t:",SQLERRMESSAGE 
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
 
{<section id="asti701.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asti701_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL asti701_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "stdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asti701_bcl USING g_enterprise,
                                       g_stdb_d[g_detail_idx].stdb001
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asti701_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "stdc_t,"
   #僅鎖定自身table
   LET ls_group = "stdc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN asti701_bcl2 USING g_enterprise,
                                             g_master.stdb001,
                                             g_stdb3_d[g_detail_idx2].stdc002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asti701_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asti701.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asti701_unlock_b(ps_table)
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
      CLOSE asti701_bcl
   END IF
   
 
    
   LET ls_group = "stdc_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE asti701_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="asti701.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION asti701_idx_chk(ps_loc)
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
      IF g_detail_idx > g_stdb_d.getLength() THEN
         LET g_detail_idx = g_stdb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stdb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_stdb_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_stdb2_d.getLength() THEN
         LET g_detail_idx = g_stdb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stdb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_stdb2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_stdb3_d.getLength() THEN
         LET g_detail_idx2 = g_stdb3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_stdb3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_stdb3_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_stdb3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_stdb3_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asti701.mask_functions" >}
&include "erp/ast/asti701_mask.4gl"
 
{</section>}
 
{<section id="asti701.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asti701_set_pk_array()
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
   LET g_pk_array[1].values = g_stdb_d[g_detail_idx].stdb001
   LET g_pk_array[1].column = 'stdb001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asti701.state_change" >}
    
 
{</section>}
 
{<section id="asti701.func_signature" >}
   
 
{</section>}
 
{<section id="asti701.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="asti701.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 结算中心检查
# Memo...........:
# Usage..........: CALL asti701_stdb002_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/24 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_stdb002_chk()
   DEFINE l_ooefstus   LIKE ooef_t.ooefstus
   
   LET g_errno = ''
   SELECT ooefstus INTO l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_stdb_d[l_ac].stdb002
      AND ooef212 = 'Y' 
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'aoo-00224' #不存在
      WHEN l_ooefstus <> 'Y'   LET g_errno = 'aoo-00225' #無效
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 对象检查
# Memo...........:
# Usage..........: CALL asti701_stdb005_chk(p_stdb004,p_stdb005)
# Input parameter: p_stdb004      对象类型
#                : p_stdb005      对象编号
# Return code....: 无
# Date & Author..: 2014/07/24 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_stdb005_chk(p_stdb004,p_stdb005)
   DEFINE p_stdb004   LIKE stdb_t.stdb004
   DEFINE p_stdb005   LIKE stdb_t.stdb005
   DEFINE l_ooefstus  LIKE ooef_t.ooefstus
   
   LET g_errno = ''
   #对象为法人
   IF p_stdb004 = '1' THEN 
      SELECT ooefstus INTO l_ooefstus
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = p_stdb005
         AND ooef003 = 'Y'
      CASE
         WHEN SQLCA.sqlcode = 100 LET g_errno = 'aoo-00103' #不存在
         WHEN l_ooefstus <> 'Y'   LET g_errno = 'aoo-00104' #無效
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 业务类型检查
# Memo...........:
# Usage..........: CALL asti701_stdb003_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/24 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_stdb003_chk()
   DEFINE l_n   LIKE type_t.num5
   
   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(1) INTO l_n  #160905-00007#15 by 08172 *变1
     FROM stda_t
    WHERE stdaent = g_enterprise
      AND stda001 = g_stdb_d[l_ac].stdb003
      AND stda003 IN ('1','-1')
   IF l_n <> 2 THEN 
      LET g_errno = 'ast-00133'
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 关联交易频率检查
# Memo...........:
# Usage..........: CALL asti701_stdb007_chk(p_cmd)
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/25 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_stdb007_chk(p_cmd)
   DEFINE l_n   LIKE type_t.num5
   DEFINE p_cmd LIKE type_t.chr1
   
   LET g_errno = ''
   IF g_stdb_d[l_ac].stdb007 != '1' THEN 
      RETURN 
   END IF 
   IF cl_null(g_stdb_d[l_ac].stdb003) OR cl_null(g_stdb_d[l_ac].stdb005) OR cl_null(g_stdb_d[l_ac].stdb006) THEN 
      RETURN 
   END IF 
   LET l_n = 0
   IF p_cmd = 'a' THEN 
      SELECT COUNT(1) INTO l_n  #160905-00007#15 by 08172 *变1
        FROM stdb_t
       WHERE stdbent = g_enterprise
         AND stdb003 = g_stdb_d[l_ac].stdb003
         AND stdb005 = g_stdb_d[l_ac].stdb005
         AND stdb006 = g_stdb_d[l_ac].stdb006
         AND stdb007 = '1'
   ELSE
      SELECT COUNT(1) INTO l_n   #160905-00007#15 by 08172 *变1
        FROM stdb_t
       WHERE stdbent = g_enterprise
         AND stdb003 = g_stdb_d[l_ac].stdb003
         AND stdb005 = g_stdb_d[l_ac].stdb005
         AND stdb006 = g_stdb_d[l_ac].stdb006
         AND stdb001 <> g_stdb_d_t.stdb001
         AND stdb007 = '1'
   END IF 
   IF l_n > 0 THEN 
      LET g_errno = 'ast-00135'
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 单身二刷新
# Memo...........:
# Usage..........: CALL asti701_display()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/25 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_display()
    DISPLAY ARRAY g_stdb2_d TO s_detail2.*
       ATTRIBUTES(COUNT=g_detail_cnt)  
    
       BEFORE DISPLAY 
          EXIT DISPLAY 
    END DISPLAY 
END FUNCTION

################################################################################
# Descriptions...: 单身二检查
# Memo...........:
# Usage..........: CALL asti701_detail_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/25 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_detail_chk()
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_min_stdc003   LIKE stdc_t.stdc003
   DEFINE l_max_stdc003   LIKE stdc_t.stdc003
   
   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(1) INTO l_n   #160905-00007#15 by 08172 *变1
     FROM stdc_t
    WHERE stdcent = g_enterprise
      AND stdc001 = g_stdb_d[g_detail_idx].stdb001
   #两角关系
   IF g_stdb_d[g_detail_idx].stdb008 = '1' THEN 
      IF l_n <> 2 THEN 
         LET g_errno = 'ast-00136'
         RETURN 
      END IF 
   #多角关系    
   ELSE
      IF l_n < 3 THEN 
         LET g_errno = 'ast-00137'
         RETURN 
      END IF
   END IF 
   SELECT stdc003 INTO l_min_stdc003
     FROM stdc_t 
    WHERE stdcent = g_enterprise
      AND stdc001 = g_stdb_d[g_detail_idx].stdb001
      AND stdc002 = (SELECT MIN(stdc002) FROM stdc_t WHERE stdcent = g_enterprise AND stdc001 = g_stdb_d[g_detail_idx].stdb001)
   
   SELECT stdc003 INTO l_max_stdc003
     FROM stdc_t 
    WHERE stdcent = g_enterprise
      AND stdc001 = g_stdb_d[g_detail_idx].stdb001
      AND stdc002 = (SELECT MAX(stdc002) FROM stdc_t WHERE stdcent = g_enterprise AND stdc001 = g_stdb_d[g_detail_idx].stdb001)
   IF l_min_stdc003 != g_stdb_d[g_detail_idx].stdb005 THEN 
      LET g_errno = 'ast-00138'
      RETURN 
   END IF 
   IF l_max_stdc003 != g_stdb_d[g_detail_idx].stdb006 THEN 
      LET g_errno = 'ast-00139'
      RETURN 
   END IF 
#   IF cl_null(g_errno) THEN 
#      #更新单头有效码栏位为Y
#      UPDATE stdb_t SET stdbstus = 'Y'
#       WHERE stdbent = g_enterprise
#         AND stdb001 = g_stdb_d[g_detail_idx].stdb001
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "stdb_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
#      END IF
#   END IF 
END FUNCTION

################################################################################
# Descriptions...: 检查供货组织与单身二是否对应
# Memo...........:
# Usage..........: CALL asti701_stdb005_chk1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/07 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_stdb005_chk1()
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_stdc003 LIKE stdc_t.stdc003
   
   LET g_errno = ''
   SELECT stdc003 INTO l_stdc003
     FROM stdc_t 
    WHERE stdcent = g_enterprise
      AND stdc001 = g_stdb_d[l_ac].stdb001
      AND stdc002 = (SELECT MIN(stdc002) 
                       FROM stdc_t 
                      WHERE stdcent = g_enterprise
                        AND stdc001 = g_stdb_d[l_ac].stdb001)
   IF NOT cl_null(l_stdc003) THEN 
      IF l_stdc003 != g_stdb_d[l_ac].stdb005 THEN 
         LET g_errno = 'ast-00138'
      END IF 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 需求组织检查
# Memo...........:
# Usage..........: CALL asti701_stdb006_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/07 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_stdb006_chk()
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_stdc003 LIKE stdc_t.stdc003
   
   LET g_errno = ''
   SELECT stdc003 INTO l_stdc003
     FROM stdc_t 
    WHERE stdcent = g_enterprise
      AND stdc001 = g_stdb_d[l_ac].stdb001
      AND stdc002 = (SELECT MAX(stdc002) 
                       FROM stdc_t 
                      WHERE stdcent = g_enterprise
                        AND stdc001 = g_stdb_d[l_ac].stdb001)
   IF NOT cl_null(l_stdc003) THEN 
      IF l_stdc003 != g_stdb_d[l_ac].stdb006 THEN 
         LET g_errno = 'ast-00139'
      END IF 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 对象重复检查
# Memo...........:
# Usage..........: CALL asti701_stdc003_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/08 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION asti701_stdc003_chk()
   DEFINE l_n   LIKE type_t.num5
   
   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(1) INTO l_n   #160905-00007#15 by 08172 *变1
     FROM stdc_t
    WHERE stdcent = g_enterprise
      AND stdc001 = g_stdb_d[g_detail_idx].stdb001
      AND stdc003 = g_stdb3_d[l_ac].stdc003
   IF l_n > 0 THEN 
      LET g_errno = 'ast-00156'
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 删除
# Memo...........:
# Usage..........: asti701_delete_2()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/29 By yangxf
# Modify.........:
################################################################################
PUBLIC FUNCTION asti701_delete_2()
   DEFINE li_idx          LIKE type_t.num5
   DEFINE li_ac_t         LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_stdb008       LIKE stdb_t.stdb008
   
   LET g_forupd_sql = "SELECT stdbstus,stdb001,stdb002,stdb003,stdb004,stdb005,stdb006,stdb007,stdb008, 
       stdb009,stdb010,stdb001,stdbownid,stdbowndp,stdbcrtid,stdbcrtdp,stdbcrtdt,stdbmodid,stdbmoddt  
       FROM stdb_t WHERE stdbent=? AND stdb001=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE asti701_bcl3 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   LET g_forupd_sql = "SELECT stdc002,stdc003,stdc004,stdc005 FROM stdc_t WHERE stdcent=? AND stdc001=?  
       AND stdc002=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE asti701_bcl4 CURSOR FROM g_forupd_sql
   
   LET g_aw = g_curr_diag.getCurrentItem()
   IF g_aw = "s_detail1" THEN 
      FOR li_idx = 1 TO g_stdb_d.getLength()
         LET g_detail_idx = li_idx
         #已選擇的資料
         IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
            CALL s_transaction_begin()
            OPEN asti701_bcl3 USING g_enterprise,g_stdb_d[g_detail_idx].stdb001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "asti701_bcl" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               RETURN 
            END IF
         END IF
      END FOR
   END IF 
   IF g_aw = "s_detail3" THEN
      FOR li_idx = 1 TO g_stdb_d.getLength()
         LET g_detail_idx2 = li_idx
         #已選擇的資料
         IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
            CALL s_transaction_begin()
            OPEN asti701_bcl4 USING g_enterprise,
                                             g_master.stdb001,
                                             g_stdb3_d[g_detail_idx2].stdc002
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "asti701_bcl2" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            SELECT stdb008 INTO l_stdb008 FROM stdb_t WHERE stdb001 = g_master.stdb001
               AND stdbent = g_enterprise #160905-00007#15 by 08172
               IF l_stdb008 = '1' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'ast-00158' 
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  RETURN 
               END IF 
         END IF
      END FOR
   END IF 
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   CASE g_aw
       WHEN "s_detail1"       
          FOR li_idx = 1 TO g_stdb_d.getLength()
             IF g_stdb_d[li_idx].stdb001 IS NOT NULL
                AND g_stdb_d[li_idx].stdb002 IS NOT NULL
                AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
                
                
                DELETE FROM stdc_t
                 WHERE stdcent = g_enterprise
                   AND stdc001 = g_stdb_d[li_idx].stdb001
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "stdc_t" 
                   LET g_errparam.code   = SQLCA.sqlcode 
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   CALL s_transaction_end('N','0')
                   RETURN
                ELSE
                   DELETE FROM stdb_t
                    WHERE stdbent = g_enterprise 
                      AND stdb001 = g_stdb_d[li_idx].stdb001
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = "stdb_t" 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      CALL s_transaction_end('N','0')
                      RETURN
                   END IF
                   LET g_detail_cnt = g_detail_cnt-1
                END IF 
             END IF 
          END FOR
   WHEN "s_detail3"
      FOR li_idx = 1 TO g_stdb3_d.getLength()
         IF g_stdb_d[g_detail_idx].stdb001 IS NOT NULL
            AND g_stdb3_d[li_idx].stdc002 IS NOT NULL
            AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 

            DELETE FROM stdc_t
             WHERE stdcent = g_enterprise
               AND stdc001 = g_stdb_d[g_detail_idx].stdb001
               AND stdc002 = g_stdb3_d[li_idx].stdc002
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stdc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               RETURN
            END IF 
            CALL asti701_detail_chk()
            IF NOT cl_null(g_errno) THEN
               #更新单头有效码栏位为N
               UPDATE stdb_t SET stdbstus = 'N'
                WHERE stdbent = g_enterprise
                  AND stdb001 = g_stdb_d[g_detail_idx].stdb001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stdb_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
               END IF
            END IF 
         END IF 
      END FOR 
   END CASE 
   CALL s_transaction_end('Y','0')
   LET l_ac = li_ac_t
   #刷新資料
   CALL asti701_b_fill(g_wc)
   CALL asti701_fetch()
END FUNCTION

 
{</section>}
 
