#該程式未解開Section, 採用最新樣板產出!
{<section id="aint830_1.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-07-06 22:20:33), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000071
#+ Filename...: aint830_1
#+ Description: 盤點單製造批序號維護作業
#+ Creator....: 01534(2014-05-29 22:10:14)
#+ Modifier...: 01534 -SD/PR- 00000
 
{</section>}
 
{<section id="aint830_1.global" >}
#應用 i02 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE TYPE type_g_inpe_d RECORD
       inpedocno LIKE inpe_t.inpedocno, 
   inpeseq LIKE inpe_t.inpeseq, 
   inpesite LIKE inpe_t.inpesite, 
   inpeseq2 LIKE inpe_t.inpeseq2, 
   inpe008 LIKE inpe_t.inpe008, 
   inpe009 LIKE inpe_t.inpe009, 
   inpe012 LIKE inpe_t.inpe012, 
   inpe030 LIKE inpe_t.inpe030, 
   inpe035 LIKE inpe_t.inpe035, 
   inpe050 LIKE inpe_t.inpe050, 
   inpe055 LIKE inpe_t.inpe055, 
   inpe010 LIKE inpe_t.inpe010, 
   inpe011 LIKE inpe_t.inpe011, 
   inpe031 LIKE inpe_t.inpe031, 
   inpe031_desc LIKE type_t.chr500, 
   inpe032 LIKE inpe_t.inpe032, 
   inpe033 LIKE inpe_t.inpe033, 
   inpe033_desc LIKE type_t.chr500, 
   inpe034 LIKE inpe_t.inpe034, 
   inpe036 LIKE inpe_t.inpe036, 
   inpe036_desc LIKE type_t.chr500, 
   inpe037 LIKE inpe_t.inpe037, 
   inpe038 LIKE inpe_t.inpe038, 
   inpe038_desc LIKE type_t.chr500, 
   inpe039 LIKE inpe_t.inpe039, 
   inpe051 LIKE inpe_t.inpe051, 
   inpe051_desc LIKE type_t.chr500, 
   inpe052 LIKE inpe_t.inpe052, 
   inpe053 LIKE inpe_t.inpe053, 
   inpe053_desc LIKE type_t.chr500, 
   inpe054 LIKE inpe_t.inpe054, 
   inpe056 LIKE inpe_t.inpe056, 
   inpe056_desc LIKE type_t.chr500, 
   inpe057 LIKE inpe_t.inpe057, 
   inpe058 LIKE inpe_t.inpe058, 
   inpe058_desc LIKE type_t.chr500, 
   inpe059 LIKE inpe_t.inpe059
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_inpe_d          DYNAMIC ARRAY OF type_g_inpe_d #單身變數
DEFINE g_inpe_d_t        type_g_inpe_d                  #單身備份
DEFINE g_inpe_d_o        type_g_inpe_d                  #單身備份
DEFINE g_inpe_d_mask_o   DYNAMIC ARRAY OF type_g_inpe_d #單身變數
DEFINE g_inpe_d_mask_n   DYNAMIC ARRAY OF type_g_inpe_d #單身變數
 
      
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
 
{<section id="aint830_1.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aint830_1(--)
   #add-point:main段變數傳入 name="main.get_var"
   
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT inpedocno,inpeseq,inpesite,inpeseq2,inpe008,inpe009,inpe012,inpe030,inpe035, 
       inpe050,inpe055,inpe010,inpe011,inpe031,inpe032,inpe033,inpe034,inpe036,inpe037,inpe038,inpe039, 
       inpe051,inpe052,inpe053,inpe054,inpe056,inpe057,inpe058,inpe059 FROM inpe_t WHERE inpeent=? AND  
       inpedocno=? AND inpeseq=? AND inpeseq2=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint830_1_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint830_1 WITH FORM cl_ap_formpath("ain","aint830_1")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aint830_1_init()   
 
   #進入選單 Menu (="N")
   CALL aint830_1_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aint830_1
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint830_1.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aint830_1_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL aint830_1_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aint830_1_ui_dialog()
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
         CALL g_inpe_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aint830_1_init()
      END IF
   
      CALL aint830_1_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_inpe_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aint830_1_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
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
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint830_1_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint830_1_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint830_1_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aint830_1_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint830_1_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_inpe_d)
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
            CALL aint830_1_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint830_1_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint830_1_set_pk_array()
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
 
{<section id="aint830_1.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint830_1_query()
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
   CALL g_inpe_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON inpedocno,inpeseq,inpesite,inpeseq2,inpe008,inpe009,inpe012,inpe030,inpe035, 
          inpe050,inpe055,inpe010,inpe011,inpe031,inpe032,inpe033,inpe034,inpe036,inpe037,inpe038,inpe039, 
          inpe051,inpe052,inpe053,inpe054,inpe056,inpe057,inpe058,inpe059 
 
         FROM s_detail1[1].inpedocno,s_detail1[1].inpeseq,s_detail1[1].inpesite,s_detail1[1].inpeseq2, 
             s_detail1[1].inpe008,s_detail1[1].inpe009,s_detail1[1].inpe012,s_detail1[1].inpe030,s_detail1[1].inpe035, 
             s_detail1[1].inpe050,s_detail1[1].inpe055,s_detail1[1].inpe010,s_detail1[1].inpe011,s_detail1[1].inpe031, 
             s_detail1[1].inpe032,s_detail1[1].inpe033,s_detail1[1].inpe034,s_detail1[1].inpe036,s_detail1[1].inpe037, 
             s_detail1[1].inpe038,s_detail1[1].inpe039,s_detail1[1].inpe051,s_detail1[1].inpe052,s_detail1[1].inpe053, 
             s_detail1[1].inpe054,s_detail1[1].inpe056,s_detail1[1].inpe057,s_detail1[1].inpe058,s_detail1[1].inpe059  
 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpedocno
            #add-point:BEFORE FIELD inpedocno name="query.b.page1.inpedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpedocno
            
            #add-point:AFTER FIELD inpedocno name="query.a.page1.inpedocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpedocno
            #add-point:ON ACTION controlp INFIELD inpedocno name="query.c.page1.inpedocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpeseq
            #add-point:BEFORE FIELD inpeseq name="query.b.page1.inpeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpeseq
            
            #add-point:AFTER FIELD inpeseq name="query.a.page1.inpeseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpeseq
            #add-point:ON ACTION controlp INFIELD inpeseq name="query.c.page1.inpeseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpesite
            #add-point:BEFORE FIELD inpesite name="query.b.page1.inpesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpesite
            
            #add-point:AFTER FIELD inpesite name="query.a.page1.inpesite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpesite
            #add-point:ON ACTION controlp INFIELD inpesite name="query.c.page1.inpesite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpeseq2
            #add-point:BEFORE FIELD inpeseq2 name="query.b.page1.inpeseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpeseq2
            
            #add-point:AFTER FIELD inpeseq2 name="query.a.page1.inpeseq2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpeseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpeseq2
            #add-point:ON ACTION controlp INFIELD inpeseq2 name="query.c.page1.inpeseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe008
            #add-point:BEFORE FIELD inpe008 name="query.b.page1.inpe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe008
            
            #add-point:AFTER FIELD inpe008 name="query.a.page1.inpe008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe008
            #add-point:ON ACTION controlp INFIELD inpe008 name="query.c.page1.inpe008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe009
            #add-point:BEFORE FIELD inpe009 name="query.b.page1.inpe009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe009
            
            #add-point:AFTER FIELD inpe009 name="query.a.page1.inpe009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe009
            #add-point:ON ACTION controlp INFIELD inpe009 name="query.c.page1.inpe009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe012
            #add-point:BEFORE FIELD inpe012 name="query.b.page1.inpe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe012
            
            #add-point:AFTER FIELD inpe012 name="query.a.page1.inpe012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe012
            #add-point:ON ACTION controlp INFIELD inpe012 name="query.c.page1.inpe012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe030
            #add-point:BEFORE FIELD inpe030 name="query.b.page1.inpe030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe030
            
            #add-point:AFTER FIELD inpe030 name="query.a.page1.inpe030"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe030
            #add-point:ON ACTION controlp INFIELD inpe030 name="query.c.page1.inpe030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe035
            #add-point:BEFORE FIELD inpe035 name="query.b.page1.inpe035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe035
            
            #add-point:AFTER FIELD inpe035 name="query.a.page1.inpe035"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe035
            #add-point:ON ACTION controlp INFIELD inpe035 name="query.c.page1.inpe035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe050
            #add-point:BEFORE FIELD inpe050 name="query.b.page1.inpe050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe050
            
            #add-point:AFTER FIELD inpe050 name="query.a.page1.inpe050"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe050
            #add-point:ON ACTION controlp INFIELD inpe050 name="query.c.page1.inpe050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe055
            #add-point:BEFORE FIELD inpe055 name="query.b.page1.inpe055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe055
            
            #add-point:AFTER FIELD inpe055 name="query.a.page1.inpe055"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe055
            #add-point:ON ACTION controlp INFIELD inpe055 name="query.c.page1.inpe055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe010
            #add-point:BEFORE FIELD inpe010 name="query.b.page1.inpe010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe010
            
            #add-point:AFTER FIELD inpe010 name="query.a.page1.inpe010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe010
            #add-point:ON ACTION controlp INFIELD inpe010 name="query.c.page1.inpe010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe011
            #add-point:BEFORE FIELD inpe011 name="query.b.page1.inpe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe011
            
            #add-point:AFTER FIELD inpe011 name="query.a.page1.inpe011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe011
            #add-point:ON ACTION controlp INFIELD inpe011 name="query.c.page1.inpe011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe031
            #add-point:BEFORE FIELD inpe031 name="query.b.page1.inpe031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe031
            
            #add-point:AFTER FIELD inpe031 name="query.a.page1.inpe031"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe031
            #add-point:ON ACTION controlp INFIELD inpe031 name="query.c.page1.inpe031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe032
            #add-point:BEFORE FIELD inpe032 name="query.b.page1.inpe032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe032
            
            #add-point:AFTER FIELD inpe032 name="query.a.page1.inpe032"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe032
            #add-point:ON ACTION controlp INFIELD inpe032 name="query.c.page1.inpe032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inpe033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe033
            #add-point:ON ACTION controlp INFIELD inpe033 name="construct.c.page1.inpe033"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inpe033  #顯示到畫面上
            NEXT FIELD inpe033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe033
            #add-point:BEFORE FIELD inpe033 name="query.b.page1.inpe033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe033
            
            #add-point:AFTER FIELD inpe033 name="query.a.page1.inpe033"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe034
            #add-point:BEFORE FIELD inpe034 name="query.b.page1.inpe034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe034
            
            #add-point:AFTER FIELD inpe034 name="query.a.page1.inpe034"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe034
            #add-point:ON ACTION controlp INFIELD inpe034 name="query.c.page1.inpe034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe036
            #add-point:BEFORE FIELD inpe036 name="query.b.page1.inpe036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe036
            
            #add-point:AFTER FIELD inpe036 name="query.a.page1.inpe036"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe036
            #add-point:ON ACTION controlp INFIELD inpe036 name="query.c.page1.inpe036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe037
            #add-point:BEFORE FIELD inpe037 name="query.b.page1.inpe037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe037
            
            #add-point:AFTER FIELD inpe037 name="query.a.page1.inpe037"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe037
            #add-point:ON ACTION controlp INFIELD inpe037 name="query.c.page1.inpe037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe038
            #add-point:BEFORE FIELD inpe038 name="query.b.page1.inpe038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe038
            
            #add-point:AFTER FIELD inpe038 name="query.a.page1.inpe038"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe038
            #add-point:ON ACTION controlp INFIELD inpe038 name="query.c.page1.inpe038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe039
            #add-point:BEFORE FIELD inpe039 name="query.b.page1.inpe039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe039
            
            #add-point:AFTER FIELD inpe039 name="query.a.page1.inpe039"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe039
            #add-point:ON ACTION controlp INFIELD inpe039 name="query.c.page1.inpe039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe051
            #add-point:BEFORE FIELD inpe051 name="query.b.page1.inpe051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe051
            
            #add-point:AFTER FIELD inpe051 name="query.a.page1.inpe051"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe051
            #add-point:ON ACTION controlp INFIELD inpe051 name="query.c.page1.inpe051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe052
            #add-point:BEFORE FIELD inpe052 name="query.b.page1.inpe052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe052
            
            #add-point:AFTER FIELD inpe052 name="query.a.page1.inpe052"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe052
            #add-point:ON ACTION controlp INFIELD inpe052 name="query.c.page1.inpe052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe053
            #add-point:BEFORE FIELD inpe053 name="query.b.page1.inpe053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe053
            
            #add-point:AFTER FIELD inpe053 name="query.a.page1.inpe053"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe053
            #add-point:ON ACTION controlp INFIELD inpe053 name="query.c.page1.inpe053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe054
            #add-point:BEFORE FIELD inpe054 name="query.b.page1.inpe054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe054
            
            #add-point:AFTER FIELD inpe054 name="query.a.page1.inpe054"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe054
            #add-point:ON ACTION controlp INFIELD inpe054 name="query.c.page1.inpe054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe056
            #add-point:BEFORE FIELD inpe056 name="query.b.page1.inpe056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe056
            
            #add-point:AFTER FIELD inpe056 name="query.a.page1.inpe056"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe056
            #add-point:ON ACTION controlp INFIELD inpe056 name="query.c.page1.inpe056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe057
            #add-point:BEFORE FIELD inpe057 name="query.b.page1.inpe057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe057
            
            #add-point:AFTER FIELD inpe057 name="query.a.page1.inpe057"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe057
            #add-point:ON ACTION controlp INFIELD inpe057 name="query.c.page1.inpe057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe058
            #add-point:BEFORE FIELD inpe058 name="query.b.page1.inpe058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe058
            
            #add-point:AFTER FIELD inpe058 name="query.a.page1.inpe058"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe058
            #add-point:ON ACTION controlp INFIELD inpe058 name="query.c.page1.inpe058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe059
            #add-point:BEFORE FIELD inpe059 name="query.b.page1.inpe059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe059
            
            #add-point:AFTER FIELD inpe059 name="query.a.page1.inpe059"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inpe059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe059
            #add-point:ON ACTION controlp INFIELD inpe059 name="query.c.page1.inpe059"
            
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
    
   CALL aint830_1_b_fill(g_wc2)
   
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
 
{<section id="aint830_1.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint830_1_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aint830_1_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint830_1_modify()
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
   
   LET g_action_choice = ""
   
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
      INPUT ARRAY g_inpe_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inpe_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint830_1_b_fill(g_wc2)
            LET g_detail_cnt = g_inpe_d.getLength()
         
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
            DISPLAY g_inpe_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_inpe_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inpe_d[l_ac].inpesite IS NOT NULL
               AND g_inpe_d[l_ac].inpedocno IS NOT NULL
               AND g_inpe_d[l_ac].inpeseq IS NOT NULL
               AND g_inpe_d[l_ac].inpeseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inpe_d_t.* = g_inpe_d[l_ac].*  #BACKUP
               LET g_inpe_d_o.* = g_inpe_d[l_ac].*  #BACKUP
               IF NOT aint830_1_lock_b("inpe_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint830_1_bcl INTO g_inpe_d[l_ac].inpedocno,g_inpe_d[l_ac].inpeseq,g_inpe_d[l_ac].inpesite, 
                      g_inpe_d[l_ac].inpeseq2,g_inpe_d[l_ac].inpe008,g_inpe_d[l_ac].inpe009,g_inpe_d[l_ac].inpe012, 
                      g_inpe_d[l_ac].inpe030,g_inpe_d[l_ac].inpe035,g_inpe_d[l_ac].inpe050,g_inpe_d[l_ac].inpe055, 
                      g_inpe_d[l_ac].inpe010,g_inpe_d[l_ac].inpe011,g_inpe_d[l_ac].inpe031,g_inpe_d[l_ac].inpe032, 
                      g_inpe_d[l_ac].inpe033,g_inpe_d[l_ac].inpe034,g_inpe_d[l_ac].inpe036,g_inpe_d[l_ac].inpe037, 
                      g_inpe_d[l_ac].inpe038,g_inpe_d[l_ac].inpe039,g_inpe_d[l_ac].inpe051,g_inpe_d[l_ac].inpe052, 
                      g_inpe_d[l_ac].inpe053,g_inpe_d[l_ac].inpe054,g_inpe_d[l_ac].inpe056,g_inpe_d[l_ac].inpe057, 
                      g_inpe_d[l_ac].inpe058,g_inpe_d[l_ac].inpe059
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inpe_d_t.inpesite,":",SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inpe_d_mask_o[l_ac].* =  g_inpe_d[l_ac].*
                  CALL aint830_1_inpe_t_mask()
                  LET g_inpe_d_mask_n[l_ac].* =  g_inpe_d[l_ac].*
                  
                  CALL aint830_1_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aint830_1_set_entry_b(l_cmd)
            CALL aint830_1_set_no_entry_b(l_cmd)
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
            INITIALIZE g_inpe_d_t.* TO NULL
            INITIALIZE g_inpe_d_o.* TO NULL
            INITIALIZE g_inpe_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_inpe_d_t.* = g_inpe_d[l_ac].*     #新輸入資料
            LET g_inpe_d_o.* = g_inpe_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inpe_d[li_reproduce_target].* = g_inpe_d[li_reproduce].*
 
               LET g_inpe_d[g_inpe_d.getLength()].inpesite = NULL
               LET g_inpe_d[g_inpe_d.getLength()].inpedocno = NULL
               LET g_inpe_d[g_inpe_d.getLength()].inpeseq = NULL
               LET g_inpe_d[g_inpe_d.getLength()].inpeseq2 = NULL
 
            END IF
            
 
            CALL aint830_1_set_entry_b(l_cmd)
            CALL aint830_1_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM inpe_t 
             WHERE inpeent = g_enterprise AND inpesite = g_inpe_d[l_ac].inpesite
                                       AND inpedocno = g_inpe_d[l_ac].inpedocno
                                       AND inpeseq = g_inpe_d[l_ac].inpeseq
                                       AND inpeseq2 = g_inpe_d[l_ac].inpeseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inpe_d[g_detail_idx].inpesite
               LET gs_keys[2] = g_inpe_d[g_detail_idx].inpedocno
               LET gs_keys[3] = g_inpe_d[g_detail_idx].inpeseq
               LET gs_keys[4] = g_inpe_d[g_detail_idx].inpeseq2
               CALL aint830_1_insert_b('inpe_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_inpe_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inpe_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint830_1_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (inpesite = '", g_inpe_d[l_ac].inpesite, "' "
                                  ," AND inpedocno = '", g_inpe_d[l_ac].inpedocno, "' "
                                  ," AND inpeseq = '", g_inpe_d[l_ac].inpeseq, "' "
                                  ," AND inpeseq2 = '", g_inpe_d[l_ac].inpeseq2, "' "
 
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
               
               DELETE FROM inpe_t
                WHERE inpeent = g_enterprise AND 
                      inpesite = g_inpe_d_t.inpesite
                      AND inpedocno = g_inpe_d_t.inpedocno
                      AND inpeseq = g_inpe_d_t.inpeseq
                      AND inpeseq2 = g_inpe_d_t.inpeseq2
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inpe_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aint830_1_set_pk_array()
                  IF NOT cl_log_modified_record('','') THEN 
                  ELSE
                  END IF
               END IF 
               CLOSE aint830_1_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_inpe_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inpe_d_t.inpesite
               LET gs_keys[2] = g_inpe_d_t.inpedocno
               LET gs_keys[3] = g_inpe_d_t.inpeseq
               LET gs_keys[4] = g_inpe_d_t.inpeseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint830_1_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aint830_1_delete_b('inpe_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inpe_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpedocno
            #add-point:BEFORE FIELD inpedocno name="input.b.page1.inpedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpedocno
            
            #add-point:AFTER FIELD inpedocno name="input.a.page1.inpedocno"
            #此段落由子樣板a05產生
            IF  g_inpe_d[g_detail_idx].inpesite IS NOT NULL AND g_inpe_d[g_detail_idx].inpedocno IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inpe_d[g_detail_idx].inpesite != g_inpe_d_t.inpesite OR g_inpe_d[g_detail_idx].inpedocno != g_inpe_d_t.inpedocno OR g_inpe_d[g_detail_idx].inpeseq != g_inpe_d_t.inpeseq OR g_inpe_d[g_detail_idx].inpeseq2 != g_inpe_d_t.inpeseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inpe_t WHERE "||"inpeent = '" ||g_enterprise|| "' AND "||"inpesite = '"||g_inpe_d[g_detail_idx].inpesite ||"' AND "|| "inpedocno = '"||g_inpe_d[g_detail_idx].inpedocno ||"' AND "|| "inpeseq = '"||g_inpe_d[g_detail_idx].inpeseq ||"' AND "|| "inpeseq2 = '"||g_inpe_d[g_detail_idx].inpeseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpedocno
            #add-point:ON CHANGE inpedocno name="input.g.page1.inpedocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpeseq
            #add-point:BEFORE FIELD inpeseq name="input.b.page1.inpeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpeseq
            
            #add-point:AFTER FIELD inpeseq name="input.a.page1.inpeseq"
            #此段落由子樣板a05產生
            IF  g_inpe_d[g_detail_idx].inpesite IS NOT NULL AND g_inpe_d[g_detail_idx].inpedocno IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inpe_d[g_detail_idx].inpesite != g_inpe_d_t.inpesite OR g_inpe_d[g_detail_idx].inpedocno != g_inpe_d_t.inpedocno OR g_inpe_d[g_detail_idx].inpeseq != g_inpe_d_t.inpeseq OR g_inpe_d[g_detail_idx].inpeseq2 != g_inpe_d_t.inpeseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inpe_t WHERE "||"inpeent = '" ||g_enterprise|| "' AND "||"inpesite = '"||g_inpe_d[g_detail_idx].inpesite ||"' AND "|| "inpedocno = '"||g_inpe_d[g_detail_idx].inpedocno ||"' AND "|| "inpeseq = '"||g_inpe_d[g_detail_idx].inpeseq ||"' AND "|| "inpeseq2 = '"||g_inpe_d[g_detail_idx].inpeseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpeseq
            #add-point:ON CHANGE inpeseq name="input.g.page1.inpeseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpesite
            #add-point:BEFORE FIELD inpesite name="input.b.page1.inpesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpesite
            
            #add-point:AFTER FIELD inpesite name="input.a.page1.inpesite"
            #此段落由子樣板a05產生
            IF  g_inpe_d[g_detail_idx].inpesite IS NOT NULL AND g_inpe_d[g_detail_idx].inpedocno IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inpe_d[g_detail_idx].inpesite != g_inpe_d_t.inpesite OR g_inpe_d[g_detail_idx].inpedocno != g_inpe_d_t.inpedocno OR g_inpe_d[g_detail_idx].inpeseq != g_inpe_d_t.inpeseq OR g_inpe_d[g_detail_idx].inpeseq2 != g_inpe_d_t.inpeseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inpe_t WHERE "||"inpeent = '" ||g_enterprise|| "' AND "||"inpesite = '"||g_inpe_d[g_detail_idx].inpesite ||"' AND "|| "inpedocno = '"||g_inpe_d[g_detail_idx].inpedocno ||"' AND "|| "inpeseq = '"||g_inpe_d[g_detail_idx].inpeseq ||"' AND "|| "inpeseq2 = '"||g_inpe_d[g_detail_idx].inpeseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpesite
            #add-point:ON CHANGE inpesite name="input.g.page1.inpesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpeseq2
            #add-point:BEFORE FIELD inpeseq2 name="input.b.page1.inpeseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpeseq2
            
            #add-point:AFTER FIELD inpeseq2 name="input.a.page1.inpeseq2"
            #此段落由子樣板a05產生
            IF  g_inpe_d[g_detail_idx].inpesite IS NOT NULL AND g_inpe_d[g_detail_idx].inpedocno IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq IS NOT NULL AND g_inpe_d[g_detail_idx].inpeseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inpe_d[g_detail_idx].inpesite != g_inpe_d_t.inpesite OR g_inpe_d[g_detail_idx].inpedocno != g_inpe_d_t.inpedocno OR g_inpe_d[g_detail_idx].inpeseq != g_inpe_d_t.inpeseq OR g_inpe_d[g_detail_idx].inpeseq2 != g_inpe_d_t.inpeseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inpe_t WHERE "||"inpeent = '" ||g_enterprise|| "' AND "||"inpesite = '"||g_inpe_d[g_detail_idx].inpesite ||"' AND "|| "inpedocno = '"||g_inpe_d[g_detail_idx].inpedocno ||"' AND "|| "inpeseq = '"||g_inpe_d[g_detail_idx].inpeseq ||"' AND "|| "inpeseq2 = '"||g_inpe_d[g_detail_idx].inpeseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpeseq2
            #add-point:ON CHANGE inpeseq2 name="input.g.page1.inpeseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe008
            #add-point:BEFORE FIELD inpe008 name="input.b.page1.inpe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe008
            
            #add-point:AFTER FIELD inpe008 name="input.a.page1.inpe008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe008
            #add-point:ON CHANGE inpe008 name="input.g.page1.inpe008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe009
            #add-point:BEFORE FIELD inpe009 name="input.b.page1.inpe009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe009
            
            #add-point:AFTER FIELD inpe009 name="input.a.page1.inpe009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe009
            #add-point:ON CHANGE inpe009 name="input.g.page1.inpe009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inpe_d[l_ac].inpe012,"0","0","","","azz-00079",1) THEN
               NEXT FIELD inpe012
            END IF 
 
 
 
            #add-point:AFTER FIELD inpe012 name="input.a.page1.inpe012"
            IF NOT cl_null(g_inpe_d[l_ac].inpe012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe012
            #add-point:BEFORE FIELD inpe012 name="input.b.page1.inpe012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe012
            #add-point:ON CHANGE inpe012 name="input.g.page1.inpe012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe030
            #add-point:BEFORE FIELD inpe030 name="input.b.page1.inpe030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe030
            
            #add-point:AFTER FIELD inpe030 name="input.a.page1.inpe030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe030
            #add-point:ON CHANGE inpe030 name="input.g.page1.inpe030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe035
            #add-point:BEFORE FIELD inpe035 name="input.b.page1.inpe035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe035
            
            #add-point:AFTER FIELD inpe035 name="input.a.page1.inpe035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe035
            #add-point:ON CHANGE inpe035 name="input.g.page1.inpe035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe050
            #add-point:BEFORE FIELD inpe050 name="input.b.page1.inpe050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe050
            
            #add-point:AFTER FIELD inpe050 name="input.a.page1.inpe050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe050
            #add-point:ON CHANGE inpe050 name="input.g.page1.inpe050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe055
            #add-point:BEFORE FIELD inpe055 name="input.b.page1.inpe055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe055
            
            #add-point:AFTER FIELD inpe055 name="input.a.page1.inpe055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe055
            #add-point:ON CHANGE inpe055 name="input.g.page1.inpe055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe010
            #add-point:BEFORE FIELD inpe010 name="input.b.page1.inpe010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe010
            
            #add-point:AFTER FIELD inpe010 name="input.a.page1.inpe010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe010
            #add-point:ON CHANGE inpe010 name="input.g.page1.inpe010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe011
            #add-point:BEFORE FIELD inpe011 name="input.b.page1.inpe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe011
            
            #add-point:AFTER FIELD inpe011 name="input.a.page1.inpe011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe011
            #add-point:ON CHANGE inpe011 name="input.g.page1.inpe011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe031
            
            #add-point:AFTER FIELD inpe031 name="input.a.page1.inpe031"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe031
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe031_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe031_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe031
            #add-point:BEFORE FIELD inpe031 name="input.b.page1.inpe031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe031
            #add-point:ON CHANGE inpe031 name="input.g.page1.inpe031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe032
            #add-point:BEFORE FIELD inpe032 name="input.b.page1.inpe032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe032
            
            #add-point:AFTER FIELD inpe032 name="input.a.page1.inpe032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe032
            #add-point:ON CHANGE inpe032 name="input.g.page1.inpe032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe033
            
            #add-point:AFTER FIELD inpe033 name="input.a.page1.inpe033"
            IF NOT cl_null(g_inpe_d[l_ac].inpe033) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe033
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe033_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe033
            #add-point:BEFORE FIELD inpe033 name="input.b.page1.inpe033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe033
            #add-point:ON CHANGE inpe033 name="input.g.page1.inpe033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe034
            #add-point:BEFORE FIELD inpe034 name="input.b.page1.inpe034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe034
            
            #add-point:AFTER FIELD inpe034 name="input.a.page1.inpe034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe034
            #add-point:ON CHANGE inpe034 name="input.g.page1.inpe034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe036
            
            #add-point:AFTER FIELD inpe036 name="input.a.page1.inpe036"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe036
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe036_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe036_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe036
            #add-point:BEFORE FIELD inpe036 name="input.b.page1.inpe036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe036
            #add-point:ON CHANGE inpe036 name="input.g.page1.inpe036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe037
            #add-point:BEFORE FIELD inpe037 name="input.b.page1.inpe037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe037
            
            #add-point:AFTER FIELD inpe037 name="input.a.page1.inpe037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe037
            #add-point:ON CHANGE inpe037 name="input.g.page1.inpe037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe038
            
            #add-point:AFTER FIELD inpe038 name="input.a.page1.inpe038"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe038
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe038_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe038_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe038
            #add-point:BEFORE FIELD inpe038 name="input.b.page1.inpe038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe038
            #add-point:ON CHANGE inpe038 name="input.g.page1.inpe038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe039
            #add-point:BEFORE FIELD inpe039 name="input.b.page1.inpe039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe039
            
            #add-point:AFTER FIELD inpe039 name="input.a.page1.inpe039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe039
            #add-point:ON CHANGE inpe039 name="input.g.page1.inpe039"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe051
            
            #add-point:AFTER FIELD inpe051 name="input.a.page1.inpe051"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe051
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe051_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe051_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe051
            #add-point:BEFORE FIELD inpe051 name="input.b.page1.inpe051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe051
            #add-point:ON CHANGE inpe051 name="input.g.page1.inpe051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe052
            #add-point:BEFORE FIELD inpe052 name="input.b.page1.inpe052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe052
            
            #add-point:AFTER FIELD inpe052 name="input.a.page1.inpe052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe052
            #add-point:ON CHANGE inpe052 name="input.g.page1.inpe052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe053
            
            #add-point:AFTER FIELD inpe053 name="input.a.page1.inpe053"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe053
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe053_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe053_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe053
            #add-point:BEFORE FIELD inpe053 name="input.b.page1.inpe053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe053
            #add-point:ON CHANGE inpe053 name="input.g.page1.inpe053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe054
            #add-point:BEFORE FIELD inpe054 name="input.b.page1.inpe054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe054
            
            #add-point:AFTER FIELD inpe054 name="input.a.page1.inpe054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe054
            #add-point:ON CHANGE inpe054 name="input.g.page1.inpe054"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe056
            
            #add-point:AFTER FIELD inpe056 name="input.a.page1.inpe056"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe056
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe056_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe056_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe056
            #add-point:BEFORE FIELD inpe056 name="input.b.page1.inpe056"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe056
            #add-point:ON CHANGE inpe056 name="input.g.page1.inpe056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe057
            #add-point:BEFORE FIELD inpe057 name="input.b.page1.inpe057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe057
            
            #add-point:AFTER FIELD inpe057 name="input.a.page1.inpe057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe057
            #add-point:ON CHANGE inpe057 name="input.g.page1.inpe057"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe058
            
            #add-point:AFTER FIELD inpe058 name="input.a.page1.inpe058"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe058
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe058_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe058_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe058
            #add-point:BEFORE FIELD inpe058 name="input.b.page1.inpe058"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe058
            #add-point:ON CHANGE inpe058 name="input.g.page1.inpe058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpe059
            #add-point:BEFORE FIELD inpe059 name="input.b.page1.inpe059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpe059
            
            #add-point:AFTER FIELD inpe059 name="input.a.page1.inpe059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpe059
            #add-point:ON CHANGE inpe059 name="input.g.page1.inpe059"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inpedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpedocno
            #add-point:ON ACTION controlp INFIELD inpedocno name="input.c.page1.inpedocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpeseq
            #add-point:ON ACTION controlp INFIELD inpeseq name="input.c.page1.inpeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpesite
            #add-point:ON ACTION controlp INFIELD inpesite name="input.c.page1.inpesite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpeseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpeseq2
            #add-point:ON ACTION controlp INFIELD inpeseq2 name="input.c.page1.inpeseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe008
            #add-point:ON ACTION controlp INFIELD inpe008 name="input.c.page1.inpe008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe009
            #add-point:ON ACTION controlp INFIELD inpe009 name="input.c.page1.inpe009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe012
            #add-point:ON ACTION controlp INFIELD inpe012 name="input.c.page1.inpe012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe030
            #add-point:ON ACTION controlp INFIELD inpe030 name="input.c.page1.inpe030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe035
            #add-point:ON ACTION controlp INFIELD inpe035 name="input.c.page1.inpe035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe050
            #add-point:ON ACTION controlp INFIELD inpe050 name="input.c.page1.inpe050"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe055
            #add-point:ON ACTION controlp INFIELD inpe055 name="input.c.page1.inpe055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe010
            #add-point:ON ACTION controlp INFIELD inpe010 name="input.c.page1.inpe010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe011
            #add-point:ON ACTION controlp INFIELD inpe011 name="input.c.page1.inpe011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe031
            #add-point:ON ACTION controlp INFIELD inpe031 name="input.c.page1.inpe031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe032
            #add-point:ON ACTION controlp INFIELD inpe032 name="input.c.page1.inpe032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe033
            #add-point:ON ACTION controlp INFIELD inpe033 name="input.c.page1.inpe033"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inpe_d[l_ac].inpe033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_inpe_d[l_ac].inpe033 = g_qryparam.return1              

            DISPLAY g_inpe_d[l_ac].inpe033 TO inpe033              #

            NEXT FIELD inpe033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe034
            #add-point:ON ACTION controlp INFIELD inpe034 name="input.c.page1.inpe034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe036
            #add-point:ON ACTION controlp INFIELD inpe036 name="input.c.page1.inpe036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe037
            #add-point:ON ACTION controlp INFIELD inpe037 name="input.c.page1.inpe037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe038
            #add-point:ON ACTION controlp INFIELD inpe038 name="input.c.page1.inpe038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe039
            #add-point:ON ACTION controlp INFIELD inpe039 name="input.c.page1.inpe039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe051
            #add-point:ON ACTION controlp INFIELD inpe051 name="input.c.page1.inpe051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe052
            #add-point:ON ACTION controlp INFIELD inpe052 name="input.c.page1.inpe052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe053
            #add-point:ON ACTION controlp INFIELD inpe053 name="input.c.page1.inpe053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe054
            #add-point:ON ACTION controlp INFIELD inpe054 name="input.c.page1.inpe054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe056
            #add-point:ON ACTION controlp INFIELD inpe056 name="input.c.page1.inpe056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe057
            #add-point:ON ACTION controlp INFIELD inpe057 name="input.c.page1.inpe057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe058
            #add-point:ON ACTION controlp INFIELD inpe058 name="input.c.page1.inpe058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inpe059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpe059
            #add-point:ON ACTION controlp INFIELD inpe059 name="input.c.page1.inpe059"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aint830_1_bcl
               LET INT_FLAG = 0
               LET g_inpe_d[l_ac].* = g_inpe_d_t.*
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
               LET g_errparam.extend = g_inpe_d[l_ac].inpesite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_inpe_d[l_ac].* = g_inpe_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aint830_1_inpe_t_mask_restore('restore_mask_o')
 
               UPDATE inpe_t SET (inpedocno,inpeseq,inpesite,inpeseq2,inpe008,inpe009,inpe012,inpe030, 
                   inpe035,inpe050,inpe055,inpe010,inpe011,inpe031,inpe032,inpe033,inpe034,inpe036,inpe037, 
                   inpe038,inpe039,inpe051,inpe052,inpe053,inpe054,inpe056,inpe057,inpe058,inpe059) = (g_inpe_d[l_ac].inpedocno, 
                   g_inpe_d[l_ac].inpeseq,g_inpe_d[l_ac].inpesite,g_inpe_d[l_ac].inpeseq2,g_inpe_d[l_ac].inpe008, 
                   g_inpe_d[l_ac].inpe009,g_inpe_d[l_ac].inpe012,g_inpe_d[l_ac].inpe030,g_inpe_d[l_ac].inpe035, 
                   g_inpe_d[l_ac].inpe050,g_inpe_d[l_ac].inpe055,g_inpe_d[l_ac].inpe010,g_inpe_d[l_ac].inpe011, 
                   g_inpe_d[l_ac].inpe031,g_inpe_d[l_ac].inpe032,g_inpe_d[l_ac].inpe033,g_inpe_d[l_ac].inpe034, 
                   g_inpe_d[l_ac].inpe036,g_inpe_d[l_ac].inpe037,g_inpe_d[l_ac].inpe038,g_inpe_d[l_ac].inpe039, 
                   g_inpe_d[l_ac].inpe051,g_inpe_d[l_ac].inpe052,g_inpe_d[l_ac].inpe053,g_inpe_d[l_ac].inpe054, 
                   g_inpe_d[l_ac].inpe056,g_inpe_d[l_ac].inpe057,g_inpe_d[l_ac].inpe058,g_inpe_d[l_ac].inpe059) 
 
                WHERE inpeent = g_enterprise AND
                  inpesite = g_inpe_d_t.inpesite #項次   
                  AND inpedocno = g_inpe_d_t.inpedocno  
                  AND inpeseq = g_inpe_d_t.inpeseq  
                  AND inpeseq2 = g_inpe_d_t.inpeseq2  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inpe_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inpe_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inpe_d[g_detail_idx].inpesite
               LET gs_keys_bak[1] = g_inpe_d_t.inpesite
               LET gs_keys[2] = g_inpe_d[g_detail_idx].inpedocno
               LET gs_keys_bak[2] = g_inpe_d_t.inpedocno
               LET gs_keys[3] = g_inpe_d[g_detail_idx].inpeseq
               LET gs_keys_bak[3] = g_inpe_d_t.inpeseq
               LET gs_keys[4] = g_inpe_d[g_detail_idx].inpeseq2
               LET gs_keys_bak[4] = g_inpe_d_t.inpeseq2
               CALL aint830_1_update_b('inpe_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_inpe_d_t)
                     LET g_log2 = util.JSON.stringify(g_inpe_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aint830_1_inpe_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aint830_1_unlock_b("inpe_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inpe_d[l_ac].* = g_inpe_d_t.*
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
               LET g_inpe_d[li_reproduce_target].* = g_inpe_d[li_reproduce].*
 
               LET g_inpe_d[li_reproduce_target].inpesite = NULL
               LET g_inpe_d[li_reproduce_target].inpedocno = NULL
               LET g_inpe_d[li_reproduce_target].inpeseq = NULL
               LET g_inpe_d[li_reproduce_target].inpeseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inpe_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inpe_d.getLength()+1
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
               NEXT FIELD inpedocno
 
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
      IF INT_FLAG OR cl_null(g_inpe_d[g_detail_idx].inpesite) THEN
         CALL g_inpe_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_inpe_d[g_detail_idx].* = g_inpe_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aint830_1_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint830_1_delete()
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
   FOR li_idx = 1 TO g_inpe_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aint830_1_lock_b("inpe_t") THEN
            #已被他人鎖定
            RETURN
         END IF
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_inpe_d.getLength()
      IF g_inpe_d[li_idx].inpesite IS NOT NULL
         AND g_inpe_d[li_idx].inpedocno IS NOT NULL
         AND g_inpe_d[li_idx].inpeseq IS NOT NULL
         AND g_inpe_d[li_idx].inpeseq2 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM inpe_t
          WHERE inpeent = g_enterprise AND 
                inpesite = g_inpe_d[li_idx].inpesite
                AND inpedocno = g_inpe_d[li_idx].inpedocno
                AND inpeseq = g_inpe_d[li_idx].inpeseq
                AND inpeseq2 = g_inpe_d[li_idx].inpeseq2
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inpe_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inpe_d_t.inpesite
               LET gs_keys[2] = g_inpe_d_t.inpedocno
               LET gs_keys[3] = g_inpe_d_t.inpeseq
               LET gs_keys[4] = g_inpe_d_t.inpeseq2
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aint830_1_delete_b('inpe_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint830_1_set_pk_array()
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
   CALL aint830_1_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint830_1_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2    STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.inpedocno,t0.inpeseq,t0.inpesite,t0.inpeseq2,t0.inpe008,t0.inpe009, 
       t0.inpe012,t0.inpe030,t0.inpe035,t0.inpe050,t0.inpe055,t0.inpe010,t0.inpe011,t0.inpe031,t0.inpe032, 
       t0.inpe033,t0.inpe034,t0.inpe036,t0.inpe037,t0.inpe038,t0.inpe039,t0.inpe051,t0.inpe052,t0.inpe053, 
       t0.inpe054,t0.inpe056,t0.inpe057,t0.inpe058,t0.inpe059 ,t1.ooag011 ,t2.ooag011 ,t3.ooag011 ,t4.ooag011 , 
       t5.ooag011 ,t6.ooag011 ,t7.ooag011 ,t8.ooag011 FROM inpe_t t0",
               "",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.inpe031  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inpe033  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.inpe036  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.inpe038  ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.inpe051  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.inpe053  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.inpe056  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inpe058  ",
 
               " WHERE t0.inpeent= ?  AND  1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("inpe_t"),
                      " ORDER BY t0.inpesite,t0.inpedocno,t0.inpeseq,t0.inpeseq2"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"inpe_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aint830_1_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aint830_1_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_inpe_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_inpe_d[l_ac].inpedocno,g_inpe_d[l_ac].inpeseq,g_inpe_d[l_ac].inpesite, 
       g_inpe_d[l_ac].inpeseq2,g_inpe_d[l_ac].inpe008,g_inpe_d[l_ac].inpe009,g_inpe_d[l_ac].inpe012, 
       g_inpe_d[l_ac].inpe030,g_inpe_d[l_ac].inpe035,g_inpe_d[l_ac].inpe050,g_inpe_d[l_ac].inpe055,g_inpe_d[l_ac].inpe010, 
       g_inpe_d[l_ac].inpe011,g_inpe_d[l_ac].inpe031,g_inpe_d[l_ac].inpe032,g_inpe_d[l_ac].inpe033,g_inpe_d[l_ac].inpe034, 
       g_inpe_d[l_ac].inpe036,g_inpe_d[l_ac].inpe037,g_inpe_d[l_ac].inpe038,g_inpe_d[l_ac].inpe039,g_inpe_d[l_ac].inpe051, 
       g_inpe_d[l_ac].inpe052,g_inpe_d[l_ac].inpe053,g_inpe_d[l_ac].inpe054,g_inpe_d[l_ac].inpe056,g_inpe_d[l_ac].inpe057, 
       g_inpe_d[l_ac].inpe058,g_inpe_d[l_ac].inpe059,g_inpe_d[l_ac].inpe031_desc,g_inpe_d[l_ac].inpe033_desc, 
       g_inpe_d[l_ac].inpe036_desc,g_inpe_d[l_ac].inpe038_desc,g_inpe_d[l_ac].inpe051_desc,g_inpe_d[l_ac].inpe053_desc, 
       g_inpe_d[l_ac].inpe056_desc,g_inpe_d[l_ac].inpe058_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
      
      CALL aint830_1_detail_show()      
 
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
   
 
   
   CALL g_inpe_d.deleteElement(g_inpe_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_inpe_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_inpe_d.getLength() THEN
      LET l_ac = g_inpe_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_inpe_d.getLength()
      LET g_inpe_d_mask_o[l_ac].* =  g_inpe_d[l_ac].*
      CALL aint830_1_inpe_t_mask()
      LET g_inpe_d_mask_n[l_ac].* =  g_inpe_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_inpe_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aint830_1_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aint830_1_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe033
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe033_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inpe_d[l_ac].inpe038
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inpe_d[l_ac].inpe038_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inpe_d[l_ac].inpe038_desc

   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint830_1_set_entry_b(p_cmd)                                                  
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
 
{<section id="aint830_1.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint830_1_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aint830_1.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint830_1_default_search()
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
      LET ls_wc = ls_wc, " inpesite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " inpedocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " inpeseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " inpeseq2 = '", g_argv[04], "' AND "
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
 
{<section id="aint830_1.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint830_1_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "inpe_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'inpe_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM inpe_t
          WHERE inpeent = g_enterprise AND
            inpesite = ps_keys_bak[1] AND inpedocno = ps_keys_bak[2] AND inpeseq = ps_keys_bak[3] AND inpeseq2 = ps_keys_bak[4]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_inpe_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint830_1_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "inpe_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO inpe_t
                  (inpeent,
                   inpesite,inpedocno,inpeseq,inpeseq2
                   ,inpe008,inpe009,inpe012,inpe030,inpe035,inpe050,inpe055,inpe010,inpe011,inpe031,inpe032,inpe033,inpe034,inpe036,inpe037,inpe038,inpe039,inpe051,inpe052,inpe053,inpe054,inpe056,inpe057,inpe058,inpe059) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_inpe_d[l_ac].inpe008,g_inpe_d[l_ac].inpe009,g_inpe_d[l_ac].inpe012,g_inpe_d[l_ac].inpe030, 
                       g_inpe_d[l_ac].inpe035,g_inpe_d[l_ac].inpe050,g_inpe_d[l_ac].inpe055,g_inpe_d[l_ac].inpe010, 
                       g_inpe_d[l_ac].inpe011,g_inpe_d[l_ac].inpe031,g_inpe_d[l_ac].inpe032,g_inpe_d[l_ac].inpe033, 
                       g_inpe_d[l_ac].inpe034,g_inpe_d[l_ac].inpe036,g_inpe_d[l_ac].inpe037,g_inpe_d[l_ac].inpe038, 
                       g_inpe_d[l_ac].inpe039,g_inpe_d[l_ac].inpe051,g_inpe_d[l_ac].inpe052,g_inpe_d[l_ac].inpe053, 
                       g_inpe_d[l_ac].inpe054,g_inpe_d[l_ac].inpe056,g_inpe_d[l_ac].inpe057,g_inpe_d[l_ac].inpe058, 
                       g_inpe_d[l_ac].inpe059)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inpe_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint830_1_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "inpe_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "inpe_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE inpe_t 
         SET (inpesite,inpedocno,inpeseq,inpeseq2
              ,inpe008,inpe009,inpe012,inpe030,inpe035,inpe050,inpe055,inpe010,inpe011,inpe031,inpe032,inpe033,inpe034,inpe036,inpe037,inpe038,inpe039,inpe051,inpe052,inpe053,inpe054,inpe056,inpe057,inpe058,inpe059) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_inpe_d[l_ac].inpe008,g_inpe_d[l_ac].inpe009,g_inpe_d[l_ac].inpe012,g_inpe_d[l_ac].inpe030, 
                  g_inpe_d[l_ac].inpe035,g_inpe_d[l_ac].inpe050,g_inpe_d[l_ac].inpe055,g_inpe_d[l_ac].inpe010, 
                  g_inpe_d[l_ac].inpe011,g_inpe_d[l_ac].inpe031,g_inpe_d[l_ac].inpe032,g_inpe_d[l_ac].inpe033, 
                  g_inpe_d[l_ac].inpe034,g_inpe_d[l_ac].inpe036,g_inpe_d[l_ac].inpe037,g_inpe_d[l_ac].inpe038, 
                  g_inpe_d[l_ac].inpe039,g_inpe_d[l_ac].inpe051,g_inpe_d[l_ac].inpe052,g_inpe_d[l_ac].inpe053, 
                  g_inpe_d[l_ac].inpe054,g_inpe_d[l_ac].inpe056,g_inpe_d[l_ac].inpe057,g_inpe_d[l_ac].inpe058, 
                  g_inpe_d[l_ac].inpe059) 
         WHERE inpeent = g_enterprise AND inpesite = ps_keys_bak[1] AND inpedocno = ps_keys_bak[2] AND inpeseq = ps_keys_bak[3] AND inpeseq2 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inpe_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inpe_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint830_1_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aint830_1_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "inpe_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint830_1_bcl USING g_enterprise,
                                       g_inpe_d[g_detail_idx].inpesite,g_inpe_d[g_detail_idx].inpedocno, 
                                           g_inpe_d[g_detail_idx].inpeseq,g_inpe_d[g_detail_idx].inpeseq2 
 
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint830_1_bcl:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint830_1_unlock_b(ps_table)
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
      CLOSE aint830_1_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aint830_1_modify_detail_chk(ps_record)
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
         LET ls_return = "inpedocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aint830_1.mask_functions" >}
&include "erp/ain/aint830_1_mask.4gl"
 
{</section>}
 
{<section id="aint830_1.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint830_1_set_pk_array()
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
   LET g_pk_array[1].values = g_inpe_d[l_ac].inpesite
   LET g_pk_array[1].column = 'inpesite'
   LET g_pk_array[2].values = g_inpe_d[l_ac].inpedocno
   LET g_pk_array[2].column = 'inpedocno'
   LET g_pk_array[3].values = g_inpe_d[l_ac].inpeseq
   LET g_pk_array[3].column = 'inpeseq'
   LET g_pk_array[4].values = g_inpe_d[l_ac].inpeseq2
   LET g_pk_array[4].column = 'inpeseq2'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint830_1.state_change" >}
   
 
{</section>}
 
{<section id="aint830_1.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aint830_1.other_function" readonly="Y" >}

 
{</section>}
 
