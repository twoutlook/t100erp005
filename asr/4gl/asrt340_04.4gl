#該程式未解開Section, 採用最新樣板產出!
{<section id="asrt340_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-03-17 14:01:03), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000091
#+ Filename...: asrt340_04
#+ Description: 重複性生產完工入庫單-倒扣領料單明細
#+ Creator....: 00378(2014-03-17 11:14:58)
#+ Modifier...: 00378 -SD/PR- 00000
 
{</section>}
 
{<section id="asrt340_04.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE TYPE type_g_sfed_d RECORD
       sfedsite LIKE sfed_t.sfedsite, 
   sfeddocno LIKE sfed_t.sfeddocno, 
   sfed004 LIKE sfed_t.sfed004, 
   sfed001 LIKE sfed_t.sfed001, 
   sfed001_desc1 LIKE type_t.chr500, 
   sfed001_desc2 LIKE type_t.chr500, 
   sfed002 LIKE sfed_t.sfed002, 
   sfed003 LIKE sfed_t.sfed003
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sfeddocno          LIKE sfed_t.sfeddocno
#end add-point
 
#模組變數(Module Variables)
DEFINE g_sfed_d          DYNAMIC ARRAY OF type_g_sfed_d #單身變數
DEFINE g_sfed_d_t        type_g_sfed_d                  #單身備份
DEFINE g_sfed_d_o        type_g_sfed_d                  #單身備份
DEFINE g_sfed_d_mask_o   DYNAMIC ARRAY OF type_g_sfed_d #單身變數
DEFINE g_sfed_d_mask_n   DYNAMIC ARRAY OF type_g_sfed_d #單身變數
 
      
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
 
{<section id="asrt340_04.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION asrt340_04(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_sfeddocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
DEFINE p_sfeddocno      LIKE sfed_t.sfeddocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_sfeddocno = p_sfeddocno
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT sfedsite,sfeddocno,sfed004,sfed001,sfed002,sfed003 FROM sfed_t WHERE sfedent=?  
       AND sfeddocno=? AND sfed004=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt340_04_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asrt340_04 WITH FORM cl_ap_formpath("asr","asrt340_04")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL asrt340_04_init()   
 
   #進入選單 Menu (="N")
   CALL asrt340_04_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_asrt340_04
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt340_04.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asrt340_04_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL asrt340_04_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asrt340_04_ui_dialog()
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
         CALL g_sfed_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL asrt340_04_init()
      END IF
   
      CALL asrt340_04_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_sfed_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL asrt340_04_set_pk_array()
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
      
         
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_sfed_d)
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
            CALL asrt340_04_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asrt340_04_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asrt340_04_set_pk_array()
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
 
{<section id="asrt340_04.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asrt340_04_query()
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
   CALL g_sfed_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON sfedsite,sfeddocno,sfed004,sfed001,sfed002,sfed003 
 
         FROM s_detail1[1].sfedsite,s_detail1[1].sfeddocno,s_detail1[1].sfed004,s_detail1[1].sfed001, 
             s_detail1[1].sfed002,s_detail1[1].sfed003 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfedsite
            #add-point:BEFORE FIELD sfedsite name="query.b.page1.sfedsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfedsite
            
            #add-point:AFTER FIELD sfedsite name="query.a.page1.sfedsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfedsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfedsite
            #add-point:ON ACTION controlp INFIELD sfedsite name="query.c.page1.sfedsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeddocno
            #add-point:BEFORE FIELD sfeddocno name="query.b.page1.sfeddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeddocno
            
            #add-point:AFTER FIELD sfeddocno name="query.a.page1.sfeddocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeddocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeddocno
            #add-point:ON ACTION controlp INFIELD sfeddocno name="query.c.page1.sfeddocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed004
            #add-point:BEFORE FIELD sfed004 name="query.b.page1.sfed004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed004
            
            #add-point:AFTER FIELD sfed004 name="query.a.page1.sfed004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfed004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed004
            #add-point:ON ACTION controlp INFIELD sfed004 name="query.c.page1.sfed004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed001
            #add-point:BEFORE FIELD sfed001 name="query.b.page1.sfed001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed001
            
            #add-point:AFTER FIELD sfed001 name="query.a.page1.sfed001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfed001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed001
            #add-point:ON ACTION controlp INFIELD sfed001 name="query.c.page1.sfed001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed002
            #add-point:BEFORE FIELD sfed002 name="query.b.page1.sfed002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed002
            
            #add-point:AFTER FIELD sfed002 name="query.a.page1.sfed002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfed002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed002
            #add-point:ON ACTION controlp INFIELD sfed002 name="query.c.page1.sfed002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed003
            #add-point:BEFORE FIELD sfed003 name="query.b.page1.sfed003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed003
            
            #add-point:AFTER FIELD sfed003 name="query.a.page1.sfed003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfed003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed003
            #add-point:ON ACTION controlp INFIELD sfed003 name="query.c.page1.sfed003"
            
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
    
   CALL asrt340_04_b_fill(g_wc2)
 
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
 
{<section id="asrt340_04.insert" >}
#+ 資料新增
PRIVATE FUNCTION asrt340_04_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL asrt340_04_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.modify" >}
#+ 資料修改
PRIVATE FUNCTION asrt340_04_modify()
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
      INPUT ARRAY g_sfed_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sfed_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asrt340_04_b_fill(g_wc2)
            LET g_detail_cnt = g_sfed_d.getLength()
         
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
            DISPLAY g_sfed_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_sfed_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_sfed_d[l_ac].sfeddocno IS NOT NULL
               AND g_sfed_d[l_ac].sfed004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sfed_d_t.* = g_sfed_d[l_ac].*  #BACKUP
               LET g_sfed_d_o.* = g_sfed_d[l_ac].*  #BACKUP
               IF NOT asrt340_04_lock_b("sfed_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt340_04_bcl INTO g_sfed_d[l_ac].sfedsite,g_sfed_d[l_ac].sfeddocno,g_sfed_d[l_ac].sfed004, 
                      g_sfed_d[l_ac].sfed001,g_sfed_d[l_ac].sfed002,g_sfed_d[l_ac].sfed003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sfed_d_t.sfeddocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_sfed_d_mask_o[l_ac].* =  g_sfed_d[l_ac].*
                  CALL asrt340_04_sfed_t_mask()
                  LET g_sfed_d_mask_n[l_ac].* =  g_sfed_d[l_ac].*
                  
                  CALL asrt340_04_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asrt340_04_set_entry_b(l_cmd)
            CALL asrt340_04_set_no_entry_b(l_cmd)
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
            INITIALIZE g_sfed_d_t.* TO NULL
            INITIALIZE g_sfed_d_o.* TO NULL
            INITIALIZE g_sfed_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_sfed_d_t.* = g_sfed_d[l_ac].*     #新輸入資料
            LET g_sfed_d_o.* = g_sfed_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sfed_d[li_reproduce_target].* = g_sfed_d[li_reproduce].*
 
               LET g_sfed_d[g_sfed_d.getLength()].sfeddocno = NULL
               LET g_sfed_d[g_sfed_d.getLength()].sfed004 = NULL
 
            END IF
            
 
            CALL asrt340_04_set_entry_b(l_cmd)
            CALL asrt340_04_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM sfed_t 
             WHERE sfedent = g_enterprise AND sfeddocno = g_sfed_d[l_ac].sfeddocno
                                       AND sfed004 = g_sfed_d[l_ac].sfed004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfed_d[g_detail_idx].sfeddocno
               LET gs_keys[2] = g_sfed_d[g_detail_idx].sfed004
               CALL asrt340_04_insert_b('sfed_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_sfed_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sfed_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt340_04_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (sfeddocno = '", g_sfed_d[l_ac].sfeddocno, "' "
                                  ," AND sfed004 = '", g_sfed_d[l_ac].sfed004, "' "
 
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
               
               DELETE FROM sfed_t
                WHERE sfedent = g_enterprise AND 
                      sfeddocno = g_sfed_d_t.sfeddocno
                      AND sfed004 = g_sfed_d_t.sfed004
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "sfed_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL asrt340_04_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_sfed_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE asrt340_04_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_sfed_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfed_d_t.sfeddocno
               LET gs_keys[2] = g_sfed_d_t.sfed004
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asrt340_04_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL asrt340_04_delete_b('sfed_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_sfed_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfedsite
            #add-point:BEFORE FIELD sfedsite name="input.b.page1.sfedsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfedsite
            
            #add-point:AFTER FIELD sfedsite name="input.a.page1.sfedsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfedsite
            #add-point:ON CHANGE sfedsite name="input.g.page1.sfedsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeddocno
            #add-point:BEFORE FIELD sfeddocno name="input.b.page1.sfeddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeddocno
            
            #add-point:AFTER FIELD sfeddocno name="input.a.page1.sfeddocno"
            #此段落由子樣板a05產生
            IF  g_sfed_d[g_detail_idx].sfeddocno IS NOT NULL AND g_sfed_d[g_detail_idx].sfed004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfed_d[g_detail_idx].sfeddocno != g_sfed_d_t.sfeddocno OR g_sfed_d[g_detail_idx].sfed004 != g_sfed_d_t.sfed004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sfed_t WHERE "||"sfedent = '" ||g_enterprise|| "' AND "||"sfeddocno = '"||g_sfed_d[g_detail_idx].sfeddocno ||"' AND "|| "sfed004 = '"||g_sfed_d[g_detail_idx].sfed004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeddocno
            #add-point:ON CHANGE sfeddocno name="input.g.page1.sfeddocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed004
            #add-point:BEFORE FIELD sfed004 name="input.b.page1.sfed004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed004
            
            #add-point:AFTER FIELD sfed004 name="input.a.page1.sfed004"
            #此段落由子樣板a05產生
            IF  g_sfed_d[g_detail_idx].sfeddocno IS NOT NULL AND g_sfed_d[g_detail_idx].sfed004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfed_d[g_detail_idx].sfeddocno != g_sfed_d_t.sfeddocno OR g_sfed_d[g_detail_idx].sfed004 != g_sfed_d_t.sfed004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sfed_t WHERE "||"sfedent = '" ||g_enterprise|| "' AND "||"sfeddocno = '"||g_sfed_d[g_detail_idx].sfeddocno ||"' AND "|| "sfed004 = '"||g_sfed_d[g_detail_idx].sfed004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfed004
            #add-point:ON CHANGE sfed004 name="input.g.page1.sfed004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed001
            #add-point:BEFORE FIELD sfed001 name="input.b.page1.sfed001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed001
            
            #add-point:AFTER FIELD sfed001 name="input.a.page1.sfed001"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfed001
            #add-point:ON CHANGE sfed001 name="input.g.page1.sfed001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed002
            #add-point:BEFORE FIELD sfed002 name="input.b.page1.sfed002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed002
            
            #add-point:AFTER FIELD sfed002 name="input.a.page1.sfed002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfed002
            #add-point:ON CHANGE sfed002 name="input.g.page1.sfed002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfed003
            #add-point:BEFORE FIELD sfed003 name="input.b.page1.sfed003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfed003
            
            #add-point:AFTER FIELD sfed003 name="input.a.page1.sfed003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfed003
            #add-point:ON CHANGE sfed003 name="input.g.page1.sfed003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sfedsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfedsite
            #add-point:ON ACTION controlp INFIELD sfedsite name="input.c.page1.sfedsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeddocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeddocno
            #add-point:ON ACTION controlp INFIELD sfeddocno name="input.c.page1.sfeddocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfed004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed004
            #add-point:ON ACTION controlp INFIELD sfed004 name="input.c.page1.sfed004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfed001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed001
            #add-point:ON ACTION controlp INFIELD sfed001 name="input.c.page1.sfed001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfed002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed002
            #add-point:ON ACTION controlp INFIELD sfed002 name="input.c.page1.sfed002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfed003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfed003
            #add-point:ON ACTION controlp INFIELD sfed003 name="input.c.page1.sfed003"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE asrt340_04_bcl
               LET INT_FLAG = 0
               LET g_sfed_d[l_ac].* = g_sfed_d_t.*
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
               LET g_errparam.extend = g_sfed_d[l_ac].sfeddocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_sfed_d[l_ac].* = g_sfed_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL asrt340_04_sfed_t_mask_restore('restore_mask_o')
 
               UPDATE sfed_t SET (sfedsite,sfeddocno,sfed004,sfed001,sfed002,sfed003) = (g_sfed_d[l_ac].sfedsite, 
                   g_sfed_d[l_ac].sfeddocno,g_sfed_d[l_ac].sfed004,g_sfed_d[l_ac].sfed001,g_sfed_d[l_ac].sfed002, 
                   g_sfed_d[l_ac].sfed003)
                WHERE sfedent = g_enterprise AND
                  sfeddocno = g_sfed_d_t.sfeddocno #項次   
                  AND sfed004 = g_sfed_d_t.sfed004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sfed_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sfed_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfed_d[g_detail_idx].sfeddocno
               LET gs_keys_bak[1] = g_sfed_d_t.sfeddocno
               LET gs_keys[2] = g_sfed_d[g_detail_idx].sfed004
               LET gs_keys_bak[2] = g_sfed_d_t.sfed004
               CALL asrt340_04_update_b('sfed_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_sfed_d_t)
                     LET g_log2 = util.JSON.stringify(g_sfed_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asrt340_04_sfed_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL asrt340_04_unlock_b("sfed_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_sfed_d[l_ac].* = g_sfed_d_t.*
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
               LET g_sfed_d[li_reproduce_target].* = g_sfed_d[li_reproduce].*
 
               LET g_sfed_d[li_reproduce_target].sfeddocno = NULL
               LET g_sfed_d[li_reproduce_target].sfed004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_sfed_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_sfed_d.getLength()+1
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
               NEXT FIELD sfedsite
 
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
      IF INT_FLAG OR cl_null(g_sfed_d[g_detail_idx].sfeddocno) THEN
         CALL g_sfed_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_sfed_d[g_detail_idx].* = g_sfed_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE asrt340_04_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asrt340_04_delete()
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
   FOR li_idx = 1 TO g_sfed_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT asrt340_04_lock_b("sfed_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("sfed_t","") THEN
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
   
   FOR li_idx = 1 TO g_sfed_d.getLength()
      IF g_sfed_d[li_idx].sfeddocno IS NOT NULL
         AND g_sfed_d[li_idx].sfed004 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM sfed_t
          WHERE sfedent = g_enterprise AND 
                sfeddocno = g_sfed_d[li_idx].sfeddocno
                AND sfed004 = g_sfed_d[li_idx].sfed004
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfed_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_sfed_d_t.sfeddocno
               LET gs_keys[2] = g_sfed_d_t.sfed004
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL asrt340_04_delete_b('sfed_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asrt340_04_set_pk_array()
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
   CALL asrt340_04_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asrt340_04_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   LET p_wc2 = p_wc2 CLIPPED," AND sfeddocno = '",g_sfeddocno,"'"
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.sfedsite,t0.sfeddocno,t0.sfed004,t0.sfed001,t0.sfed002,t0.sfed003  FROM sfed_t t0", 
 
               "",
               
               " WHERE t0.sfedent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("sfed_t"),
                      " ORDER BY t0.sfeddocno,t0.sfed004"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"sfed_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asrt340_04_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asrt340_04_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_sfed_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_sfed_d[l_ac].sfedsite,g_sfed_d[l_ac].sfeddocno,g_sfed_d[l_ac].sfed004, 
       g_sfed_d[l_ac].sfed001,g_sfed_d[l_ac].sfed002,g_sfed_d[l_ac].sfed003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
      
      CALL asrt340_04_detail_show()      
 
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
   
 
   
   CALL g_sfed_d.deleteElement(g_sfed_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_sfed_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_sfed_d.getLength() THEN
      LET l_ac = g_sfed_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_sfed_d.getLength()
      LET g_sfed_d_mask_o[l_ac].* =  g_sfed_d[l_ac].*
      CALL asrt340_04_sfed_t_mask()
      LET g_sfed_d_mask_n[l_ac].* =  g_sfed_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_sfed_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE asrt340_04_pb
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asrt340_04_detail_show()
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
 
{<section id="asrt340_04.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asrt340_04_set_entry_b(p_cmd)                                                  
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
 
{<section id="asrt340_04.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asrt340_04_set_no_entry_b(p_cmd)                                               
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
 
{<section id="asrt340_04.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asrt340_04_default_search()
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
      LET ls_wc = ls_wc, " sfeddocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " sfed004 = '", g_argv[02], "' AND "
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
 
{<section id="asrt340_04.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asrt340_04_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "sfed_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'sfed_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM sfed_t
          WHERE sfedent = g_enterprise AND
            sfeddocno = ps_keys_bak[1] AND sfed004 = ps_keys_bak[2]
         
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
         CALL g_sfed_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asrt340_04_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "sfed_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO sfed_t
                  (sfedent,
                   sfeddocno,sfed004
                   ,sfedsite,sfed001,sfed002,sfed003) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_sfed_d[l_ac].sfedsite,g_sfed_d[l_ac].sfed001,g_sfed_d[l_ac].sfed002,g_sfed_d[l_ac].sfed003) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfed_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asrt340_04_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "sfed_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "sfed_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE sfed_t 
         SET (sfeddocno,sfed004
              ,sfedsite,sfed001,sfed002,sfed003) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_sfed_d[l_ac].sfedsite,g_sfed_d[l_ac].sfed001,g_sfed_d[l_ac].sfed002,g_sfed_d[l_ac].sfed003)  
 
         WHERE sfedent = g_enterprise AND sfeddocno = ps_keys_bak[1] AND sfed004 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfed_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfed_t:",SQLERRMESSAGE 
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
 
{<section id="asrt340_04.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asrt340_04_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL asrt340_04_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "sfed_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asrt340_04_bcl USING g_enterprise,
                                       g_sfed_d[g_detail_idx].sfeddocno,g_sfed_d[g_detail_idx].sfed004 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt340_04_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asrt340_04_unlock_b(ps_table)
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
      CLOSE asrt340_04_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION asrt340_04_modify_detail_chk(ps_record)
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
         LET ls_return = "sfedsite"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340_04.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION asrt340_04_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="asrt340_04.mask_functions" >}
&include "erp/asr/asrt340_04_mask.4gl"
 
{</section>}
 
{<section id="asrt340_04.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asrt340_04_set_pk_array()
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
   LET g_pk_array[1].values = g_sfed_d[l_ac].sfeddocno
   LET g_pk_array[1].column = 'sfeddocno'
   LET g_pk_array[2].values = g_sfed_d[l_ac].sfed004
   LET g_pk_array[2].column = 'sfed004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt340_04.state_change" >}
   
 
{</section>}
 
{<section id="asrt340_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asrt340_04.other_function" readonly="Y" >}

 
{</section>}
 
