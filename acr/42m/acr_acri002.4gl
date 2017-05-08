#該程式未解開Section, 採用最新樣板產出!
{<section id="acri002.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-01-15 10:53:59), PR版次:0006(2016-10-20 10:41:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000156
#+ Filename...: acri002
#+ Description: 潛在客戶等級資料維護作業
#+ Creator....: 04226(2014-04-25 11:34:52)
#+ Modifier...: 06189 -SD/PR- 05384
 
{</section>}
 
{<section id="acri002.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160809-00047#2   2016/10/11 By shiun       刪除前先判斷s_azzi610_check
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
PRIVATE TYPE type_g_oocq_d RECORD
       oocqstus LIKE oocq_t.oocqstus, 
   oocq001 LIKE oocq_t.oocq001, 
   oocq001_desc LIKE type_t.chr500, 
   oocq002 LIKE oocq_t.oocq002, 
   oocql004 LIKE type_t.chr500, 
   oocql005 LIKE type_t.chr500, 
   oocq014 LIKE oocq_t.oocq014, 
   oocq011 LIKE oocq_t.oocq011, 
   oocq012 LIKE oocq_t.oocq012, 
   oocq013 LIKE oocq_t.oocq013
       END RECORD
PRIVATE TYPE type_g_oocq2_d RECORD
       oocq001 LIKE oocq_t.oocq001, 
   oocq002 LIKE oocq_t.oocq002, 
   oocqownid LIKE oocq_t.oocqownid, 
   oocqownid_desc LIKE type_t.chr500, 
   oocqowndp LIKE oocq_t.oocqowndp, 
   oocqowndp_desc LIKE type_t.chr500, 
   oocqcrtid LIKE oocq_t.oocqcrtid, 
   oocqcrtid_desc LIKE type_t.chr500, 
   oocqcrtdp LIKE oocq_t.oocqcrtdp, 
   oocqcrtdp_desc LIKE type_t.chr500, 
   oocqcrtdt DATETIME YEAR TO SECOND, 
   oocqmodid LIKE oocq_t.oocqmodid, 
   oocqmodid_desc LIKE type_t.chr500, 
   oocqmoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_oocq3_d RECORD
       crae003 LIKE crae_t.crae003, 
   crae003_desc LIKE type_t.chr500
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      oocql001 LIKE oocql_t.oocql001,
      oocql002 LIKE oocql_t.oocql002,
      oocql003 LIKE oocql_t.oocql003,
      oocql004 LIKE oocql_t.oocql004,
      oocql005 LIKE oocql_t.oocql005
      END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_oocq001            LIKE oocq_t.oocq001
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_oocq_d
DEFINE g_master_t                   type_g_oocq_d
DEFINE g_oocq_d          DYNAMIC ARRAY OF type_g_oocq_d
DEFINE g_oocq_d_t        type_g_oocq_d
DEFINE g_oocq_d_o        type_g_oocq_d
DEFINE g_oocq_d_mask_o   DYNAMIC ARRAY OF type_g_oocq_d #轉換遮罩前資料
DEFINE g_oocq_d_mask_n   DYNAMIC ARRAY OF type_g_oocq_d #轉換遮罩後資料
DEFINE g_oocq2_d          DYNAMIC ARRAY OF type_g_oocq2_d
DEFINE g_oocq2_d_t        type_g_oocq2_d
DEFINE g_oocq2_d_o        type_g_oocq2_d
DEFINE g_oocq2_d_mask_o   DYNAMIC ARRAY OF type_g_oocq2_d #轉換遮罩前資料
DEFINE g_oocq2_d_mask_n   DYNAMIC ARRAY OF type_g_oocq2_d #轉換遮罩後資料
DEFINE g_oocq3_d          DYNAMIC ARRAY OF type_g_oocq3_d
DEFINE g_oocq3_d_t        type_g_oocq3_d
DEFINE g_oocq3_d_o        type_g_oocq3_d
DEFINE g_oocq3_d_mask_o   DYNAMIC ARRAY OF type_g_oocq3_d #轉換遮罩前資料
DEFINE g_oocq3_d_mask_n   DYNAMIC ARRAY OF type_g_oocq3_d #轉換遮罩後資料
 
      
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
 
{<section id="acri002.main" >}
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
   CALL cl_ap_init("acr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acri002 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acri002_init()   
 
      #進入選單 Menu (="N")
      CALL acri002_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acri002
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="acri002.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION acri002_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   
   
   LET l_ac = 1
   
LET g_detail_multi_table_t.oocql001 = '2105'
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
   
LET g_detail_multi_table_t.oocql001 = '2105'
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_oocq_d.getLength() > 0 THEN
      LET g_master_t.* = g_oocq_d[1].*
      LET g_master.* = g_oocq_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_oocq001 = '2105'
   LET g_errshow = 1
   #end add-point
   
   CALL acri002_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="acri002.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION acri002_ui_dialog()
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
         CALL g_oocq_d.clear()
         CALL g_oocq2_d.clear()
         CALL g_oocq3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL acri002_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      LET g_current_page = 0
      #end add-point
   
      CALL acri002_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_oocq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_master.* = g_oocq_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL acri002_fetch()
               CALL acri002_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL acri002_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_oocq2_d TO s_detail2.*
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
               LET g_master.* = g_oocq_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL acri002_fetch()
               CALL acri002_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL acri002_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_oocq3_d TO s_detail3.*
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
               CALL acri002_idx_chk('d')
               LET g_master.* = g_oocq_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_oocq_d.getLength() THEN
                  LET g_detail_idx = g_oocq_d.getLength()
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
            LET g_export_node[1] = base.typeInfo.create(g_oocq_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_oocq2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_oocq3_d)
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
               CALL acri002_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL acri002_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
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
               CALL acri002_query()
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
            CALL acri002_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL acri002_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL acri002_set_pk_array()
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
 
{<section id="acri002.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION acri002_query()
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
   CALL g_oocq_d.clear()
   CALL g_oocq2_d.clear()
   CALL g_oocq3_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON oocqstus,oocq001,oocq002,oocql004,oocql005,oocq014,oocq011,oocq012,oocq013, 
          oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt
           FROM s_detail1[1].oocqstus,s_detail1[1].oocq001,s_detail1[1].oocq002,s_detail1[1].oocql004, 
               s_detail1[1].oocql005,s_detail1[1].oocq014,s_detail1[1].oocq011,s_detail1[1].oocq012, 
               s_detail1[1].oocq013,s_detail2[1].oocqownid,s_detail2[1].oocqowndp,s_detail2[1].oocqcrtid, 
               s_detail2[1].oocqcrtdp,s_detail2[1].oocqcrtdt,s_detail2[1].oocqmodid,s_detail2[1].oocqmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            IF NOT cl_null(g_oocq001) THEN
               DISPLAY g_oocq001 TO l_oocq001
               CALL acri002_l_oocq001_ref()
            END IF
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oocqcrtdt>>----
         AFTER FIELD oocqcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oocqmoddt>>----
         AFTER FIELD oocqmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oocqcnfdt>>----
         
         #----<<oocqpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqstus
            #add-point:BEFORE FIELD oocqstus name="construct.b.page1.oocqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqstus
            
            #add-point:AFTER FIELD oocqstus name="construct.a.page1.oocqstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqstus
            #add-point:ON ACTION controlp INFIELD oocqstus name="construct.c.page1.oocqstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq001
            #add-point:BEFORE FIELD oocq001 name="construct.b.page1.oocq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq001
            
            #add-point:AFTER FIELD oocq001 name="construct.a.page1.oocq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq001
            #add-point:ON ACTION controlp INFIELD oocq001 name="construct.c.page1.oocq001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.oocq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="construct.c.page1.oocq002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2105"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq002  #顯示到畫面上
            NEXT FIELD oocq002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="construct.b.page1.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="construct.a.page1.oocq002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="construct.b.page1.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="construct.a.page1.oocql004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="construct.c.page1.oocql004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="construct.b.page1.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="construct.a.page1.oocql005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="construct.c.page1.oocql005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq014
            #add-point:BEFORE FIELD oocq014 name="construct.b.page1.oocq014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq014
            
            #add-point:AFTER FIELD oocq014 name="construct.a.page1.oocq014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocq014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq014
            #add-point:ON ACTION controlp INFIELD oocq014 name="construct.c.page1.oocq014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq011
            #add-point:BEFORE FIELD oocq011 name="construct.b.page1.oocq011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq011
            
            #add-point:AFTER FIELD oocq011 name="construct.a.page1.oocq011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocq011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq011
            #add-point:ON ACTION controlp INFIELD oocq011 name="construct.c.page1.oocq011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq012
            #add-point:BEFORE FIELD oocq012 name="construct.b.page1.oocq012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq012
            
            #add-point:AFTER FIELD oocq012 name="construct.a.page1.oocq012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocq012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq012
            #add-point:ON ACTION controlp INFIELD oocq012 name="construct.c.page1.oocq012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq013
            #add-point:BEFORE FIELD oocq013 name="construct.b.page1.oocq013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq013
            
            #add-point:AFTER FIELD oocq013 name="construct.a.page1.oocq013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oocq013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq013
            #add-point:ON ACTION controlp INFIELD oocq013 name="construct.c.page1.oocq013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.oocqownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqownid
            #add-point:ON ACTION controlp INFIELD oocqownid name="construct.c.page2.oocqownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqownid  #顯示到畫面上
            NEXT FIELD oocqownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqownid
            #add-point:BEFORE FIELD oocqownid name="construct.b.page2.oocqownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqownid
            
            #add-point:AFTER FIELD oocqownid name="construct.a.page2.oocqownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oocqowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqowndp
            #add-point:ON ACTION controlp INFIELD oocqowndp name="construct.c.page2.oocqowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqowndp  #顯示到畫面上
            NEXT FIELD oocqowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqowndp
            #add-point:BEFORE FIELD oocqowndp name="construct.b.page2.oocqowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqowndp
            
            #add-point:AFTER FIELD oocqowndp name="construct.a.page2.oocqowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oocqcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqcrtid
            #add-point:ON ACTION controlp INFIELD oocqcrtid name="construct.c.page2.oocqcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqcrtid  #顯示到畫面上
            NEXT FIELD oocqcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtid
            #add-point:BEFORE FIELD oocqcrtid name="construct.b.page2.oocqcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqcrtid
            
            #add-point:AFTER FIELD oocqcrtid name="construct.a.page2.oocqcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oocqcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqcrtdp
            #add-point:ON ACTION controlp INFIELD oocqcrtdp name="construct.c.page2.oocqcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqcrtdp  #顯示到畫面上
            NEXT FIELD oocqcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtdp
            #add-point:BEFORE FIELD oocqcrtdp name="construct.b.page2.oocqcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqcrtdp
            
            #add-point:AFTER FIELD oocqcrtdp name="construct.a.page2.oocqcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtdt
            #add-point:BEFORE FIELD oocqcrtdt name="construct.b.page2.oocqcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.oocqmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqmodid
            #add-point:ON ACTION controlp INFIELD oocqmodid name="construct.c.page2.oocqmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqmodid  #顯示到畫面上
            NEXT FIELD oocqmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqmodid
            #add-point:BEFORE FIELD oocqmodid name="construct.b.page2.oocqmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqmodid
            
            #add-point:AFTER FIELD oocqmodid name="construct.a.page2.oocqmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqmoddt
            #add-point:BEFORE FIELD oocqmoddt name="construct.b.page2.oocqmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON crae003
           FROM s_detail3[1].crae003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.crae003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crae003
            #add-point:ON ACTION controlp INFIELD crae003 name="construct.c.page3.crae003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2057'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crae003  #顯示到畫面上
            NEXT FIELD crae003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crae003
            #add-point:BEFORE FIELD crae003 name="construct.b.page3.crae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crae003
            
            #add-point:AFTER FIELD crae003 name="construct.a.page3.crae003"
            
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
   CALL acri002_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL acri002_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_oocq_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_oocq3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="acri002.insert" >}
#+ 資料修改
PRIVATE FUNCTION acri002_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL acri002_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acri002.modify" >}
#+ 資料新增
PRIVATE FUNCTION acri002_modify()
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
   CALL acri002_input('u')
    
   IF INT_FLAG AND g_oocq_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL acri002_b_fill(g_wc)
      CALL acri002_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="acri002.delete" >}
#+ 資料刪除
PRIVATE FUNCTION acri002_delete()
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
   LET g_oocq_d_t.* = g_oocq_d[li_ac].*
   LET g_oocq_d_o.* = g_oocq_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM oocq_t 
         WHERE oocqent = g_enterprise AND
           oocq001 = g_oocq_d_t.oocq001
           AND oocq002 = g_oocq_d_t.oocq002
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL acri002_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM crae_t 
         WHERE craeent = g_enterprise AND
           crae001 = g_oocq_d_t.oocq001
           AND crae002 = g_oocq_d_t.oocq002
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
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
 
{<section id="acri002.input" >}
#+ 資料輸入
PRIVATE FUNCTION acri002_input(p_cmd)
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
   DEFINE  r_success             LIKE type_t.num5
   #add--160809-00047#2 By shiun--(S)
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_use                 LIKE type_t.num5
   #add--160809-00047#2 By shiun--(E)
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT oocqstus,oocq001,oocq002,oocq014,oocq011,oocq012,oocq013,oocq001,oocq002, 
       oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt FROM oocq_t WHERE oocqent=?  
       AND oocq001=? AND oocq002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE acri002_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT crae003 FROM crae_t WHERE craeent=? AND crae001=? AND crae002=? AND crae003=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE acri002_bcl2 CURSOR FROM g_forupd_sql
 
 
 
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
      INPUT ARRAY g_oocq_d FROM s_detail1.*
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
            IF NOT cl_null(g_oocq_d[l_ac].oocq002) THEN
               CALL n_oocql(g_oocq001,g_oocq_d[l_ac].oocq002)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_oocq001
               LET g_ref_fields[2] = g_oocq_d[l_ac].oocq002
               CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                   ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_oocq_d[l_ac].oocql004= g_rtn_fields[1]
               LET g_oocq_d[l_ac].oocql005= g_rtn_fields[2]

               DISPLAY BY NAME g_oocq_d[l_ac].oocql004
               DISPLAY BY NAME g_oocq_d[l_ac].oocql005
            END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oocq_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL acri002_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_oocq_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
 
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_oocq_d[l_ac].*
            LET g_master.* = g_oocq_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_oocq_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_oocq_d[l_ac].oocq001 IS NOT NULL
               AND g_oocq_d[l_ac].oocq002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_oocq_d_t.* = g_oocq_d[l_ac].*  #BACKUP
               LET g_oocq_d_o.* = g_oocq_d[l_ac].*  #BACKUP
               IF NOT acri002_lock_b("oocq_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH acri002_bcl INTO g_oocq_d[l_ac].oocqstus,g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002, 
                      g_oocq_d[l_ac].oocq014,g_oocq_d[l_ac].oocq011,g_oocq_d[l_ac].oocq012,g_oocq_d[l_ac].oocq013, 
                      g_oocq2_d[l_ac].oocq001,g_oocq2_d[l_ac].oocq002,g_oocq2_d[l_ac].oocqownid,g_oocq2_d[l_ac].oocqowndp, 
                      g_oocq2_d[l_ac].oocqcrtid,g_oocq2_d[l_ac].oocqcrtdp,g_oocq2_d[l_ac].oocqcrtdt, 
                      g_oocq2_d[l_ac].oocqmodid,g_oocq2_d[l_ac].oocqmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_oocq_d_t.oocq001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_oocq_d_mask_o[l_ac].* =  g_oocq_d[l_ac].*
                  CALL acri002_oocq_t_mask()
                  LET g_oocq_d_mask_n[l_ac].* =  g_oocq_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL acri002_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL acri002_set_entry_b(l_cmd)
            CALL acri002_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.oocql001 = '2105'
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys[02] = '2105'
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys[03] = g_oocq_d[l_ac].oocq002
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'oocql_t') THEN
               RETURN 
            END IF 
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL acri002_fetch()
            CALL acri002_idx_chk('m')
 
         BEFORE INSERT
            
LET g_detail_multi_table_t.oocql001 = '2105'
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_oocq3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oocq_d[l_ac].* TO NULL 
            INITIALIZE g_oocq_d_t.* TO NULL 
            INITIALIZE g_oocq_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oocq2_d[l_ac].oocqownid = g_user
      LET g_oocq2_d[l_ac].oocqowndp = g_dept
      LET g_oocq2_d[l_ac].oocqcrtid = g_user
      LET g_oocq2_d[l_ac].oocqcrtdp = g_dept 
      LET g_oocq2_d[l_ac].oocqcrtdt = cl_get_current()
      LET g_oocq2_d[l_ac].oocqmodid = g_user
      LET g_oocq2_d[l_ac].oocqmoddt = cl_get_current()
      LET g_oocq_d[l_ac].oocqstus = ''
 
 
 
                  LET g_oocq_d[l_ac].oocqstus = "Y"
      LET g_oocq_d[l_ac].oocq014 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_oocq_d_t.* = g_oocq_d[l_ac].*     #新輸入資料
            LET g_oocq_d_o.* = g_oocq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL acri002_set_entry_b(l_cmd)
            CALL acri002_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oocq_d[li_reproduce_target].* = g_oocq_d[li_reproduce].*
               LET g_oocq2_d[li_reproduce_target].* = g_oocq2_d[li_reproduce].*
 
               LET g_oocq_d[g_oocq_d.getLength()].oocq001 = NULL
               LET g_oocq_d[g_oocq_d.getLength()].oocq002 = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            LET g_oocq_d[l_ac].oocq001 = g_oocq001
            LET g_oocq_d_o.* = g_oocq_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM oocq_t 
             WHERE oocqent = g_enterprise AND oocq001 = g_oocq_d[l_ac].oocq001 
                                       AND oocq002 = g_oocq_d[l_ac].oocq002 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys[2] = g_oocq_d[g_detail_idx].oocq002
               CALL acri002_insert_b('oocq_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oocq_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL acri002_b_fill(g_wc)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF '2105' = g_detail_multi_table_t.oocql001 AND
         g_oocq_d[l_ac].oocq002 = g_detail_multi_table_t.oocql002 AND
         g_oocq_d[l_ac].oocql004 = g_detail_multi_table_t.oocql004 AND
         g_oocq_d[l_ac].oocql005 = g_detail_multi_table_t.oocql005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '2105'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
            LET l_var_keys[03] = g_oocq_d[l_ac].oocq002
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.oocql003
            LET l_vars[01] = g_oocq_d[l_ac].oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_oocq_d[l_ac].oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_oocq_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               #add--160809-00047#2 By shiun--(S)
               CALL s_azzi610_check('4',g_oocq_d_t.oocq002,g_site) RETURNING l_success,l_use
               IF l_use THEN
                  INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'azz-01159'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   CANCEL DELETE 
               END IF
               #add--160809-00047#2 By shiun--(E)
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
               
               DELETE FROM oocq_t
                WHERE oocqent = g_enterprise AND 
                      oocq001 = g_oocq_d_t.oocq001
                      AND oocq002 = g_oocq_d_t.oocq002
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oocqlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oocql001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
                  LET l_field_keys[03] = 'oocql002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_oocq_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE acri002_bcl
               LET l_count = g_oocq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d_t.oocq001
               LET gs_keys[2] = g_oocq_d_t.oocq002
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL acri002_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL acri002_delete_b('oocq_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_oocq_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqstus
            #add-point:BEFORE FIELD oocqstus name="input.b.page1.oocqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqstus
            
            #add-point:AFTER FIELD oocqstus name="input.a.page1.oocqstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocqstus
            #add-point:ON CHANGE oocqstus name="input.g.page1.oocqstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq001
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_oocq_d[l_ac].oocq001,"1.000","0","30000.000","0","azz-00087",1)  
                THEN
               NEXT FIELD oocq001
            END IF 
 
 
 
            #add-point:AFTER FIELD oocq001 name="input.a.page1.oocq001"
            IF NOT cl_null(g_oocq_d[l_ac].oocq001) THEN 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq_d[l_ac].oocq001
            CALL ap_ref_array2(g_ref_fields,"SELECT gzaal003 FROM gzaal_t WHERE gzaal001=? AND gzaal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_oocq_d[l_ac].oocq001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oocq_d[l_ac].oocq001_desc


            #此段落由子樣板a05產生
            IF  g_oocq_d[g_detail_idx].oocq001 IS NOT NULL AND g_oocq_d[g_detail_idx].oocq002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oocq_d[g_detail_idx].oocq001 != g_oocq_d_t.oocq001 OR g_oocq_d[g_detail_idx].oocq002 != g_oocq_d_t.oocq002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq001 = '"||g_oocq_d[g_detail_idx].oocq001 ||"' AND "|| "oocq002 = '"||g_oocq_d[g_detail_idx].oocq002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq001
            #add-point:BEFORE FIELD oocq001 name="input.b.page1.oocq001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq001
            #add-point:ON CHANGE oocq001 name="input.g.page1.oocq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="input.b.page1.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="input.a.page1.oocq002"
            #此段落由子樣板a05產生
            IF  g_oocq_d[g_detail_idx].oocq001 IS NOT NULL AND g_oocq_d[g_detail_idx].oocq002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oocq_d[g_detail_idx].oocq001 != g_oocq_d_t.oocq001 OR g_oocq_d[g_detail_idx].oocq002 != g_oocq_d_t.oocq002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq001 = '"||g_oocq_d[g_detail_idx].oocq001 ||"' AND "|| "oocq002 = '"||g_oocq_d[g_detail_idx].oocq002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq002
            #add-point:ON CHANGE oocq002 name="input.g.page1.oocq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="input.b.page1.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="input.a.page1.oocql004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql004
            #add-point:ON CHANGE oocql004 name="input.g.page1.oocql004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="input.b.page1.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="input.a.page1.oocql005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql005
            #add-point:ON CHANGE oocql005 name="input.g.page1.oocql005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq014
            #add-point:BEFORE FIELD oocq014 name="input.b.page1.oocq014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq014
            
            #add-point:AFTER FIELD oocq014 name="input.a.page1.oocq014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq014
            #add-point:ON CHANGE oocq014 name="input.g.page1.oocq014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_oocq_d[l_ac].oocq011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD oocq011
            END IF 
 
 
 
            #add-point:AFTER FIELD oocq011 name="input.a.page1.oocq011"
            IF NOT cl_null(g_oocq_d[l_ac].oocq011) THEN
               #檢查是否錄入的為數值
               CALL s_num_isnum(g_oocq_d[l_ac].oocq011) RETURNING r_success
               IF r_success = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00266'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq011
            #add-point:BEFORE FIELD oocq011 name="input.b.page1.oocq011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq011
            #add-point:ON CHANGE oocq011 name="input.g.page1.oocq011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_oocq_d[l_ac].oocq012,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD oocq012
            END IF 
 
 
 
            #add-point:AFTER FIELD oocq012 name="input.a.page1.oocq012"
            IF NOT cl_null(g_oocq_d[l_ac].oocq012) THEN
               #檢查是否錄入的為數值
               CALL s_num_isnum(g_oocq_d[l_ac].oocq012) RETURNING r_success
               IF r_success = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00266'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq012
            #add-point:BEFORE FIELD oocq012 name="input.b.page1.oocq012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq012
            #add-point:ON CHANGE oocq012 name="input.g.page1.oocq012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_oocq_d[l_ac].oocq013,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD oocq013
            END IF 
 
 
 
            #add-point:AFTER FIELD oocq013 name="input.a.page1.oocq013"
            IF NOT cl_null(g_oocq_d[l_ac].oocq013) THEN
               #檢查是否錄入的為數值
               CALL s_num_isnum(g_oocq_d[l_ac].oocq013) RETURNING r_success
               IF r_success = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00266'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq013
            #add-point:BEFORE FIELD oocq013 name="input.b.page1.oocq013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq013
            #add-point:ON CHANGE oocq013 name="input.g.page1.oocq013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.oocqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqstus
            #add-point:ON ACTION controlp INFIELD oocqstus name="input.c.page1.oocqstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq001
            #add-point:ON ACTION controlp INFIELD oocq001 name="input.c.page1.oocq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="input.c.page1.oocq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="input.c.page1.oocql004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="input.c.page1.oocql005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq014
            #add-point:ON ACTION controlp INFIELD oocq014 name="input.c.page1.oocq014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq011
            #add-point:ON ACTION controlp INFIELD oocq011 name="input.c.page1.oocq011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq012
            #add-point:ON ACTION controlp INFIELD oocq012 name="input.c.page1.oocq012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq013
            #add-point:ON ACTION controlp INFIELD oocq013 name="input.c.page1.oocq013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oocq_d[l_ac].* = g_oocq_d_t.*
               CLOSE acri002_bcl
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
               LET g_errparam.extend = g_oocq_d[l_ac].oocq001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_oocq_d[l_ac].* = g_oocq_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_oocq2_d[l_ac].oocqmodid = g_user 
LET g_oocq2_d[l_ac].oocqmoddt = cl_get_current()
LET g_oocq2_d[l_ac].oocqmodid_desc = cl_get_username(g_oocq2_d[l_ac].oocqmodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL acri002_oocq_t_mask_restore('restore_mask_o')
      
               UPDATE oocq_t SET (oocqstus,oocq001,oocq002,oocq014,oocq011,oocq012,oocq013,oocqownid, 
                   oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt) = (g_oocq_d[l_ac].oocqstus, 
                   g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002,g_oocq_d[l_ac].oocq014,g_oocq_d[l_ac].oocq011, 
                   g_oocq_d[l_ac].oocq012,g_oocq_d[l_ac].oocq013,g_oocq2_d[l_ac].oocqownid,g_oocq2_d[l_ac].oocqowndp, 
                   g_oocq2_d[l_ac].oocqcrtid,g_oocq2_d[l_ac].oocqcrtdp,g_oocq2_d[l_ac].oocqcrtdt,g_oocq2_d[l_ac].oocqmodid, 
                   g_oocq2_d[l_ac].oocqmoddt)
                WHERE oocqent = g_enterprise AND
                  oocq001 = g_oocq_d_t.oocq001 #項次   
                  AND oocq002 = g_oocq_d_t.oocq002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_oocq_d[l_ac].* = g_oocq_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oocq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oocq_d[l_ac].* = g_oocq_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys_bak[1] = g_oocq_d_t.oocq001
               LET gs_keys[2] = g_oocq_d[g_detail_idx].oocq002
               LET gs_keys_bak[2] = g_oocq_d_t.oocq002
               CALL acri002_update_b('oocq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF '2105' = g_detail_multi_table_t.oocql001 AND
         g_oocq_d[l_ac].oocq002 = g_detail_multi_table_t.oocql002 AND
         g_oocq_d[l_ac].oocql004 = g_detail_multi_table_t.oocql004 AND
         g_oocq_d[l_ac].oocql005 = g_detail_multi_table_t.oocql005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '2105'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
            LET l_var_keys[03] = g_oocq_d[l_ac].oocq002
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.oocql003
            LET l_vars[01] = g_oocq_d[l_ac].oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_oocq_d[l_ac].oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL acri002_oocq_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_oocq_d_t)
                     LET g_log2 = util.JSON.stringify(g_oocq_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_oocq_d[l_ac].*
               CALL acri002_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL acri002_unlock_b("oocq_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oocq_d[l_ac].* = g_oocq_d_t.*
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
               LET g_oocq_d[l_ac].* = g_oocq_d_t.*
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
               LET g_oocq_d[li_reproduce_target].* = g_oocq_d[li_reproduce].*
               LET g_oocq2_d[li_reproduce_target].* = g_oocq2_d[li_reproduce].*
 
               LET g_oocq_d[li_reproduce_target].oocq001 = NULL
               LET g_oocq_d[li_reproduce_target].oocq002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_oocq_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oocq_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_oocq3_d FROM s_detail3.*
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
            IF cl_null(g_oocq_d[g_detail_idx].oocq001) THEN
               NEXT FIELD oocqstus
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oocq3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_oocq3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            IF cl_null(g_oocq_d[l_ac].oocq002) THEN
               LET p_cmd = 'u'
               #尚未選擇潛在客戶等級！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00031'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD oocq002
            END IF
            #end add-point
 
         BEFORE INSERT
            IF g_oocq_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD oocq001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oocq3_d[l_ac].* TO NULL 
            INITIALIZE g_oocq3_d_t.* TO NULL 
            INITIALIZE g_oocq3_d_o.* TO NULL 
            
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_oocq3_d_t.* = g_oocq3_d[l_ac].*     #新輸入資料
            LET g_oocq3_d_o.* = g_oocq3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL acri002_set_entry_b(l_cmd)
            CALL acri002_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oocq3_d[li_reproduce_target].* = g_oocq3_d[li_reproduce].*
 
               LET g_oocq3_d[li_reproduce_target].crae003 = NULL
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
            LET g_detail_cnt = g_oocq3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_oocq3_d[l_ac].crae003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oocq3_d_t.* = g_oocq3_d[l_ac].*  #BACKUP
               LET g_oocq3_d_o.* = g_oocq3_d[l_ac].*  #BACKUP
               IF NOT acri002_lock_b("crae_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH acri002_bcl2 INTO g_oocq3_d[l_ac].crae003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oocq3_d_mask_o[l_ac].* =  g_oocq3_d[l_ac].*
                  CALL acri002_crae_t_mask()
                  LET g_oocq3_d_mask_n[l_ac].* =  g_oocq3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL acri002_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL acri002_set_entry_b(l_cmd)
            CALL acri002_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL acri002_idx_chk('d')
            
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
               
               DELETE FROM crae_t
                WHERE craeent = g_enterprise AND
                   crae001 = g_master.oocq001
                   AND crae002 = g_master.oocq002
                   AND crae003 = g_oocq3_d_t.crae003
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
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
               CLOSE acri002_bcl
               LET l_count = g_oocq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys[2] = g_oocq_d[g_detail_idx].oocq002
               LET gs_keys[3] = g_oocq3_d_t.crae003
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL acri002_delete_b('crae_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_oocq3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM crae_t 
             WHERE craeent = g_enterprise AND
                   crae001 = g_master.oocq001
                   AND crae002 = g_master.oocq002
                   AND crae003 = g_oocq3_d[g_detail_idx2].crae003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys[2] = g_oocq_d[g_detail_idx].oocq002
               LET gs_keys[3] = g_oocq3_d[g_detail_idx2].crae003
               CALL acri002_insert_b('crae_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oocq_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL acri002_b_fill(g_wc)
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
               LET g_oocq3_d[l_ac].* = g_oocq3_d_t.*
               CLOSE acri002_bcl2
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
               LET g_oocq3_d[l_ac].* = g_oocq3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL acri002_crae_t_mask_restore('restore_mask_o')
               
               UPDATE crae_t SET (crae003) = (g_oocq3_d[l_ac].crae003) #自訂欄位頁簽
                WHERE craeent = g_enterprise AND
                   crae001 = g_master.oocq001
                   AND crae002 = g_master.oocq002
                   AND crae003 = g_oocq3_d_t.crae003
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_oocq3_d[l_ac].* = g_oocq3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crae_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oocq3_d[l_ac].* = g_oocq3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys_bak[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys[2] = g_oocq_d[g_detail_idx].oocq002
               LET gs_keys_bak[2] = g_oocq_d[g_detail_idx].oocq002
               LET gs_keys[3] = g_oocq3_d[g_detail_idx2].crae003
               LET gs_keys_bak[3] = g_oocq3_d_t.crae003
               CALL acri002_update_b('crae_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL acri002_crae_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_oocq3_d_t)
                     LET g_log2 = util.JSON.stringify(g_oocq3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crae003
            
            #add-point:AFTER FIELD crae003 name="input.a.page3.crae003"
            LET g_oocq3_d[l_ac].crae003_desc = ''
            DISPLAY BY NAME g_oocq3_d[l_ac].crae003_desc
            #此段落由子樣板a05產生
            IF g_oocq_d[g_detail_idx].oocq001 IS NOT NULL AND g_oocq_d[g_detail_idx].oocq002 IS NOT NULL AND g_oocq3_d[g_detail_idx2].crae003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oocq_d[g_detail_idx].oocq001 != g_oocq_d[g_detail_idx].oocq001 OR g_oocq_d[g_detail_idx].oocq002 != g_oocq_d[g_detail_idx].oocq002 OR g_oocq3_d[g_detail_idx2].crae003 != g_oocq3_d_t.crae003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM crae_t WHERE "||"craeent = '" ||g_enterprise|| "' AND "||"crae001 = '"||g_oocq_d[g_detail_idx].oocq001 ||"' AND "|| "crae002 = '"||g_oocq_d[g_detail_idx].oocq002 ||"' AND "|| "crae003 = '"||g_oocq3_d[g_detail_idx2].crae003 ||"'",'std-00004',0) THEN 
                     CALL acri002_crae003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_azzi650_chk_exist('2057',g_oocq3_d[l_ac].crae003) THEN
                     CALL acri002_crae003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL acri002_crae003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crae003
            #add-point:BEFORE FIELD crae003 name="input.b.page3.crae003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crae003
            #add-point:ON CHANGE crae003 name="input.g.page3.crae003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.crae003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crae003
            #add-point:ON ACTION controlp INFIELD crae003 name="input.c.page3.crae003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oocq3_d[l_ac].crae003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2057"
            CALL q_oocq002()                                #呼叫開窗
            LET g_oocq3_d[l_ac].crae003 = g_qryparam.return1        
            DISPLAY g_oocq3_d[l_ac].crae003 TO crae003
            CALL acri002_crae003_ref()
            NEXT FIELD crae003                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oocq3_d[l_ac].* = g_oocq3_d_t.*
               END IF
               CLOSE acri002_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL acri002_unlock_b("crae_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oocq3_d[li_reproduce_target].* = g_oocq3_d[li_reproduce].*
 
               LET g_oocq3_d[li_reproduce_target].crae003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oocq3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oocq3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_oocq2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL acri002_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL acri002_fetch()
            CALL acri002_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_oocq_d.getLength() THEN
               LET g_detail_idx = g_oocq_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_oocq_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD oocqstus
               WHEN "s_detail2"
                  NEXT FIELD oocq001_2
               WHEN "s_detail3"
                  NEXT FIELD crae003
 
            END CASE
         ELSE
            NEXT FIELD oocqstus
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
   
   #end add-point
 
   CLOSE acri002_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="acri002.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION acri002_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   IF cl_null(p_wc2) THEN
      LET p_wc2 = "oocq001 = '",g_oocq001,"'"
   ELSE
      LET p_wc2 = p_wc2," AND oocq001 = '",g_oocq001,"'"
   END IF
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.oocqstus,t0.oocq001,t0.oocq002,t0.oocq014,t0.oocq011,t0.oocq012, 
       t0.oocq013,t0.oocq001,t0.oocq002,t0.oocqownid,t0.oocqowndp,t0.oocqcrtid,t0.oocqcrtdp,t0.oocqcrtdt, 
       t0.oocqmodid,t0.oocqmoddt ,t1.gzaal003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM oocq_t t0", 
 
 
               " LEFT JOIN crae_t ON craeent = oocqent AND oocq001 = crae001 AND oocq002 = crae002",
 
 
               " LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND '2105' = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"'",
                              " LEFT JOIN gzaal_t t1 ON t1.gzaal001=t0.oocq001 AND t1.gzaal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.oocqownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.oocqowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.oocqcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.oocqcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.oocqmodid  ",
 
               " WHERE t0.oocqent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("oocq_t"),
                      " ORDER BY t0.oocq001,t0.oocq002"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF NOT cl_null(g_oocq001) THEN  #pomelo
      DISPLAY g_oocq001 TO l_oocq001
      CALL acri002_l_oocq001_ref()
   END IF
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"oocq_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE acri002_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR acri002_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_oocq_d.clear()
   CALL g_oocq2_d.clear()   
   CALL g_oocq3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_oocq_d[l_ac].oocqstus,g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002,g_oocq_d[l_ac].oocq014, 
       g_oocq_d[l_ac].oocq011,g_oocq_d[l_ac].oocq012,g_oocq_d[l_ac].oocq013,g_oocq2_d[l_ac].oocq001, 
       g_oocq2_d[l_ac].oocq002,g_oocq2_d[l_ac].oocqownid,g_oocq2_d[l_ac].oocqowndp,g_oocq2_d[l_ac].oocqcrtid, 
       g_oocq2_d[l_ac].oocqcrtdp,g_oocq2_d[l_ac].oocqcrtdt,g_oocq2_d[l_ac].oocqmodid,g_oocq2_d[l_ac].oocqmoddt, 
       g_oocq_d[l_ac].oocq001_desc,g_oocq2_d[l_ac].oocqownid_desc,g_oocq2_d[l_ac].oocqowndp_desc,g_oocq2_d[l_ac].oocqcrtid_desc, 
       g_oocq2_d[l_ac].oocqcrtdp_desc,g_oocq2_d[l_ac].oocqmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF cl_null(g_oocq_d[l_ac].oocq014) THEN
         LET g_oocq_d[l_ac].oocq014 = 'N'
      END IF
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
   
 
   CALL g_oocq_d.deleteElement(g_oocq_d.getLength())   
   CALL g_oocq2_d.deleteElement(g_oocq2_d.getLength())
   CALL g_oocq3_d.deleteElement(g_oocq3_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_oocq_d.getLength() THEN
       IF g_oocq_d.getLength() > 0 THEN
          LET g_detail_idx = g_oocq_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_oocq_d.getLength()
      LET g_oocq2_d[g_detail_idx].oocq001 = g_oocq_d[g_detail_idx].oocq001 
      LET g_oocq2_d[g_detail_idx].oocq002 = g_oocq_d[g_detail_idx].oocq002 
      #LET g_oocq3_d[g_detail_idx2].crae003 = g_oocq_d[g_detail_idx].oocq001 
 
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
   FREE acri002_pb
   
   LET g_loc = 'm'
   CALL acri002_detail_show() 
   
   LET l_ac = 1
   IF g_oocq_d.getLength() > 0 THEN
      CALL acri002_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_oocq_d.getLength()
      LET g_oocq_d_mask_o[l_ac].* =  g_oocq_d[l_ac].*
      CALL acri002_oocq_t_mask()
      LET g_oocq_d_mask_n[l_ac].* =  g_oocq_d[l_ac].*
   END FOR
   
   LET g_oocq2_d_mask_o.* =  g_oocq2_d.*
   FOR l_ac = 1 TO g_oocq2_d.getLength()
      LET g_oocq2_d_mask_o[l_ac].* =  g_oocq2_d[l_ac].*
      CALL acri002_oocq_t_mask()
      LET g_oocq2_d_mask_n[l_ac].* =  g_oocq2_d[l_ac].*
   END FOR
   LET g_oocq3_d_mask_o.* =  g_oocq3_d.*
   FOR l_ac = 1 TO g_oocq3_d.getLength()
      LET g_oocq3_d_mask_o[l_ac].* =  g_oocq3_d[l_ac].*
      CALL acri002_crae_t_mask()
      LET g_oocq3_d_mask_n[l_ac].* =  g_oocq3_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="acri002.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION acri002_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_oocq_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_oocq2_d.clear()
   CALL g_oocq3_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.crae003 ,t7.oocql004 FROM crae_t t0",    
                  "",
                                 " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2057' AND t7.oocql002=t0.crae003 AND t7.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.craeent=?  AND t0. crae001=?  AND t0. crae002=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.crae003" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE acri002_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR acri002_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise,g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise,g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002 INTO g_oocq3_d[l_ac].crae003, 
#    g_oocq3_d[l_ac].crae003_desc   #(ver:45) #(ver:46)mark
   FOREACH b_fill_curs2 USING g_enterprise,g_oocq_d[g_detail_idx].oocq001,g_oocq_d[g_detail_idx].oocq002 INTO g_oocq3_d[l_ac].crae003, 
       g_oocq3_d[l_ac].crae003_desc   #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      CALL acri002_crae003_ref()
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point
   
   #CALL g_oocq2_d.deleteElement(g_oocq2_d.getLength())   
   CALL g_oocq3_d.deleteElement(g_oocq3_d.getLength())   
 
   
   LET g_oocq3_d_mask_o.* =  g_oocq3_d.*
   FOR l_ac = 1 TO g_oocq3_d.getLength()
      LET g_oocq3_d_mask_o[l_ac].* =  g_oocq3_d[l_ac].*
      CALL acri002_crae_t_mask()
      LET g_oocq3_d_mask_n[l_ac].* =  g_oocq3_d[l_ac].*
   END FOR
 
   
   DISPLAY g_oocq3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL acri002_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="acri002.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION acri002_detail_show()
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
      FOR l_ac = 1 TO g_oocq_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"
   IF g_current_page = '0' OR g_current_page = '1' OR g_current_page = '2' THEN
      CALL acri002_oocq001_ref()
      IF cl_null(g_oocq_d[l_ac].oocq014) THEN  #pomelo
         LET g_oocq_d[l_ac].oocq014 = 'N'
      END IF

      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_oocq_d[l_ac].oocq001
      LET g_ref_fields[2] = g_oocq_d[l_ac].oocq002
      CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_oocq_d[l_ac].oocql004 = g_rtn_fields[1] 
      DISPLAY BY NAME g_oocq_d[l_ac].oocql004
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_oocq_d[l_ac].oocq001
      LET g_ref_fields[2] = g_oocq_d[l_ac].oocq002
      CALL ap_ref_array2(g_ref_fields," SELECT oocql005 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_oocq_d[l_ac].oocql005 = g_rtn_fields[1] 
      DISPLAY BY NAME g_oocq_d[l_ac].oocql005
   END IF
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
IF g_current_page = '0' OR g_current_page = '1' OR g_current_page = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oocq2_d[l_ac].oocqownid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_oocq2_d[l_ac].oocqownid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_oocq2_d[l_ac].oocqownid_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oocq2_d[l_ac].oocqowndp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oocq2_d[l_ac].oocqowndp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_oocq2_d[l_ac].oocqowndp_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oocq2_d[l_ac].oocqcrtid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_oocq2_d[l_ac].oocqcrtid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_oocq2_d[l_ac].oocqcrtid_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oocq2_d[l_ac].oocqcrtdp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oocq2_d[l_ac].oocqcrtdp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_oocq2_d[l_ac].oocqcrtdp_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oocq2_d[l_ac].oocqmodid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_oocq2_d[l_ac].oocqmodid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_oocq2_d[l_ac].oocqmodid_desc
   END IF
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_oocq3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
   IF g_current_page = '3' THEN
      CALL acri002_crae003_ref()
   END IF
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="acri002.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION acri002_set_entry_b(p_cmd)                                                  
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
 
{<section id="acri002.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION acri002_set_no_entry_b(p_cmd)                                               
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
 
{<section id="acri002.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION acri002_default_search()
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
      LET ls_wc = ls_wc, " oocq001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " oocq002 = '", g_argv[02], "' AND "
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
 
{<section id="acri002.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION acri002_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "oocq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM oocq_t
       WHERE oocqent = g_enterprise AND
         oocq001 = ps_keys_bak[1] AND oocq002 = ps_keys_bak[2]
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
   
 
   
   LET ls_group = "crae_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM crae_t
       WHERE craeent = g_enterprise AND
         crae001 = ps_keys_bak[1] AND crae002 = ps_keys_bak[2] AND crae003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "oocq_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM crae_t
       WHERE craeent = g_enterprise AND
         crae001 = ps_keys_bak[1] AND crae002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
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
 
{<section id="acri002.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION acri002_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "oocq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO oocq_t
                  (oocqent,
                   oocq001,oocq002
                   ,oocqstus,oocq014,oocq011,oocq012,oocq013,oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oocq_d[g_detail_idx].oocqstus,g_oocq_d[g_detail_idx].oocq014,g_oocq_d[g_detail_idx].oocq011, 
                       g_oocq_d[g_detail_idx].oocq012,g_oocq_d[g_detail_idx].oocq013,g_oocq2_d[g_detail_idx].oocqownid, 
                       g_oocq2_d[g_detail_idx].oocqowndp,g_oocq2_d[g_detail_idx].oocqcrtid,g_oocq2_d[g_detail_idx].oocqcrtdp, 
                       g_oocq2_d[g_detail_idx].oocqcrtdt,g_oocq2_d[g_detail_idx].oocqmodid,g_oocq2_d[g_detail_idx].oocqmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "crae_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
      #end add-point
      INSERT INTO crae_t
                  (craeent,
                   crae001,crae002,crae003
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
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
 
{<section id="acri002.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION acri002_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "oocq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "oocq_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL acri002_oocq_t_mask_restore('restore_mask_o')
               
      UPDATE oocq_t 
         SET (oocq001,oocq002
              ,oocqstus,oocq014,oocq011,oocq012,oocq013,oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oocq_d[g_detail_idx].oocqstus,g_oocq_d[g_detail_idx].oocq014,g_oocq_d[g_detail_idx].oocq011, 
                  g_oocq_d[g_detail_idx].oocq012,g_oocq_d[g_detail_idx].oocq013,g_oocq2_d[g_detail_idx].oocqownid, 
                  g_oocq2_d[g_detail_idx].oocqowndp,g_oocq2_d[g_detail_idx].oocqcrtid,g_oocq2_d[g_detail_idx].oocqcrtdp, 
                  g_oocq2_d[g_detail_idx].oocqcrtdt,g_oocq2_d[g_detail_idx].oocqmodid,g_oocq2_d[g_detail_idx].oocqmoddt)  
 
         WHERE oocqent = g_enterprise AND
               oocq001 = ps_keys_bak[1] AND oocq002 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oocq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'oocqlent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'oocql001'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'oocql002'
LET l_new_key[04] = g_dlang 
LET l_old_key[04] = g_dlang 
LET l_field_key[04] = 'oocql003'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'oocql_t')
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL acri002_oocq_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "crae_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "crae_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL acri002_crae_t_mask_restore('restore_mask_o')
      
      UPDATE crae_t 
         SET (crae001,crae002,crae003
              ) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ) 
         WHERE craeent = g_enterprise AND
               crae001 = ps_keys_bak[1] AND crae002 = ps_keys_bak[2] AND crae003 = ps_keys_bak[3]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "crae_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL acri002_crae_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="acri002.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION acri002_key_update_b()
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
   
   IF g_master.oocq001 <> g_master_t.oocq001 THEN
      LET lb_chk = FALSE
   END IF
   IF g_master.oocq002 <> g_master_t.oocq002 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE crae_t 
      SET (crae001,crae002) 
           = 
          (g_master.oocq001,g_master.oocq002) 
      WHERE craeent = g_enterprise AND
           crae001 = g_master_t.oocq001
           AND crae002 = g_master_t.oocq002
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "crae_t:",SQLERRMESSAGE 
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
 
{<section id="acri002.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION acri002_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL acri002_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "oocq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN acri002_bcl USING g_enterprise,
                                       g_oocq_d[g_detail_idx].oocq001,g_oocq_d[g_detail_idx].oocq002
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "acri002_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "crae_t,"
   #僅鎖定自身table
   LET ls_group = "crae_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN acri002_bcl2 USING g_enterprise,
                                             g_master.oocq001,g_master.oocq002,
                                             g_oocq3_d[g_detail_idx2].crae003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "acri002_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="acri002.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION acri002_unlock_b(ps_table)
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
      CLOSE acri002_bcl
   END IF
   
 
    
   LET ls_group = "crae_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE acri002_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="acri002.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION acri002_idx_chk(ps_loc)
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
      IF g_detail_idx > g_oocq_d.getLength() THEN
         LET g_detail_idx = g_oocq_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oocq_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_oocq_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_oocq2_d.getLength() THEN
         LET g_detail_idx = g_oocq2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oocq2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_oocq2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_oocq3_d.getLength() THEN
         LET g_detail_idx2 = g_oocq3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_oocq3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_oocq3_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_oocq3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_oocq3_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="acri002.mask_functions" >}
&include "erp/acr/acri002_mask.4gl"
 
{</section>}
 
{<section id="acri002.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION acri002_set_pk_array()
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
   LET g_pk_array[1].values = g_oocq_d[g_detail_idx].oocq001
   LET g_pk_array[1].column = 'oocq001'
   LET g_pk_array[2].values = g_oocq_d[g_detail_idx].oocq002
   LET g_pk_array[2].column = 'oocq002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="acri002.state_change" >}
    
 
{</section>}
 
{<section id="acri002.func_signature" >}
   
 
{</section>}
 
{<section id="acri002.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="acri002.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 應用分類帶出说明
# Memo...........:
# Usage..........: CALL acri002_oocq001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acri002_oocq001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oocq_d[l_ac].oocq001
   CALL ap_ref_array2(g_ref_fields,"SELECT gzaal003 FROM gzaal_t WHERE gzaal001=? AND gzaal002='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_oocq_d[l_ac].oocq001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oocq_d[l_ac].oocq001_desc
END FUNCTION

################################################################################
# Descriptions...: 應用分類帶出说明
# Memo...........:
# Usage..........: CALL acri002_l_oocq001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acri002_l_oocq001_ref()
DEFINE l_oocq001_desc         LIKE type_t.chr500
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oocq001
   CALL ap_ref_array2(g_ref_fields,"SELECT gzaal003 FROM gzaal_t WHERE gzaal001=? AND gzaal002='"||g_lang||"'","") RETURNING g_rtn_fields
   LET l_oocq001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME l_oocq001_desc
END FUNCTION

################################################################################
# Descriptions...: 行銷方式帶出说明
# Memo...........:
# Usage..........: CALL acri002_crae003_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/25 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION acri002_crae003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oocq3_d[l_ac].crae003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2057' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oocq3_d[l_ac].crae003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oocq3_d[l_ac].crae003_desc
END FUNCTION

 
{</section>}
 
