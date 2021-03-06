#該程式未解開Section, 採用最新樣板產出!
{<section id="astt806_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-07-31 21:11:47), PR版次:0001(2017-01-11 18:01:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: astt806_01
#+ Description: 招商租賃合約批量抓取合約
#+ Creator....: 06189(2016-07-31 17:00:42)
#+ Modifier...: 06189 -SD/PR- 06189
 
{</section>}
 
{<section id="astt806_01.global" >}
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
PRIVATE TYPE type_g_stje_d RECORD
       sel LIKE type_t.chr1, 
   stjesite LIKE stje_t.stjesite, 
   stjesite_desc LIKE type_t.chr500, 
   stje001 LIKE stje_t.stje001, 
   stje002 LIKE stje_t.stje002, 
   stje007 LIKE stje_t.stje007, 
   stje007_desc LIKE type_t.chr500, 
   stje008 LIKE stje_t.stje008, 
   stje008_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc              STRING
DEFINE g_stemdocno       LIKE stem_t.stemdocno
#end add-point
 
#模組變數(Module Variables)
DEFINE g_stje_d          DYNAMIC ARRAY OF type_g_stje_d #單身變數
DEFINE g_stje_d_t        type_g_stje_d                  #單身備份
DEFINE g_stje_d_o        type_g_stje_d                  #單身備份
DEFINE g_stje_d_mask_o   DYNAMIC ARRAY OF type_g_stje_d #單身變數
DEFINE g_stje_d_mask_n   DYNAMIC ARRAY OF type_g_stje_d #單身變數
 
      
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
 
{<section id="astt806_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION astt806_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_stemdocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_stemdocno  LIKE stem_t.stemdocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_stemdocno = p_stemdocno
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT stjesite,stje001,stje002,stje007,stje008 FROM stje_t WHERE stjeent=? AND  
       stje001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt806_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_astt806_01 WITH FORM cl_ap_formpath("ast","astt806_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL astt806_01_init()   
 
   #進入選單 Menu (="N")
   CALL astt806_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_astt806_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   CALL astt806_01_drop_temp()
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt806_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astt806_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL astt806_01_create_temp() RETURNING l_success
   #end add-point
   
   CALL astt806_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astt806_01_ui_dialog()
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
         CALL g_stje_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL astt806_01_init()
      END IF
   
      CALL astt806_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stje_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL astt806_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         CONSTRUCT BY NAME g_wc ON stje007,stje008,stje022,stje019,stje020,stje021,stje028,stje017,stje018
            ON ACTION controlp INFIELD stje007
               #add-point:ON ACTION controlp INFIELD stie007 name="construct.c.stie007"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "('1','3')" 
               CALL q_pmaa001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje007  #顯示到畫面上
               NEXT FIELD stje007                     #返回原欄位
               
            ON ACTION controlp INFIELD stje008
               #add-point:ON ACTION controlp INFIELD stie008 name="construct.c.stie008"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhbe001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje008  #顯示到畫面上
               NEXT FIELD stje008                     #返回原欄位
    
            ON ACTION controlp INFIELD stje017
               #add-point:ON ACTION controlp INFIELD stje017 name="construct.c.stje017"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje017  #顯示到畫面上
               NEXT FIELD stje017   
            ON ACTION controlp INFIELD stje018
               #add-point:ON ACTION controlp INFIELD stje018 name="construct.c.stje018"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje018  #顯示到畫面上
               NEXT FIELD stje018
            ON ACTION controlp INFIELD stje019
               #add-point:ON ACTION controlp INFIELD stje019 name="construct.c.stje019"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje019  #顯示到畫面上
               NEXT FIELD stje019                     #返回原欄位
              
            #Ctrlp:construct.c.stje020
            #應用 a03 樣板自動產生(Version:3)
            ON ACTION controlp INFIELD stje020
               #add-point:ON ACTION controlp INFIELD stje020 name="construct.c.stje020"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhab002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje020  #顯示到畫面上
               NEXT FIELD stje020                     #返回原欄位
     
            #Ctrlp:construct.c.stje021
            #應用 a03 樣板自動產生(Version:3)
            ON ACTION controlp INFIELD stje021
               #add-point:ON ACTION controlp INFIELD stje021 name="construct.c.stje021"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhac003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje021  #顯示到畫面上
               NEXT FIELD stje021                     #返回原欄位
                     
            #Ctrlp:construct.c.stje022
            #應用 a03 樣板自動產生(Version:3)
            ON ACTION controlp INFIELD stje022
               #add-point:ON ACTION controlp INFIELD stje022 name="construct.c.stje022"
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2144'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje022  #顯示到畫面上
               NEXT FIELD stje022    
               #END add-point
            
            ON ACTION controlp INFIELD stje028
               #add-point:ON ACTION controlp INFIELD stje028 name="construct.c.stje028"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001') #
               CALL q_rtax001_3()                              #呼叫開窗
               DISPLAY g_qryparam.return1 TO stje028  #顯示到畫面上
               NEXT FIELD stje028  
         END CONSTRUCT 
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
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL astt806_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL astt806_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL astt806_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL astt806_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION check_no_all
            LET g_action_choice="check_no_all"
            IF cl_auth_chk_act("check_no_all") THEN
               
               #add-point:ON ACTION check_no_all name="menu.check_no_all"
               CALL astt806_01_check_no_all()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query_data
            LET g_action_choice="query_data"
            IF cl_auth_chk_act("query_data") THEN
               
               #add-point:ON ACTION query_data name="menu.query_data"
               CALL astt806_01_query_data(g_wc)
               CALL astt806_01_b_fill(g_wc)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION produce_data
            LET g_action_choice="produce_data"
            IF cl_auth_chk_act("produce_data") THEN
               
               #add-point:ON ACTION produce_data name="menu.produce_data"
               IF astt806_01_produce_data() THEN
                  IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續                            
                     #更新tmp table
                     CALL astt806_01_query_data(g_wc)
                  ELSE
                     #LET INT_FLAG = TRUE 
                     LET g_action_choice = "exit" 
                     CANCEL DIALOG
                     #RETURN
                  END IF

               ELSE
                  #false
                  IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                     LET g_action_choice = "exit"              
                     CANCEL DIALOG
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION check_all
            LET g_action_choice="check_all"
            IF cl_auth_chk_act("check_all") THEN
               
               #add-point:ON ACTION check_all name="menu.check_all"
               CALL astt806_01_check_all()
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stje_d)
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
            CALL astt806_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL astt806_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL astt806_01_set_pk_array()
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
 
{<section id="astt806_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt806_01_query()
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
   CALL g_stje_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON NULL 
 
         FROM NULL 
      
         
      
           
         
 
      
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
    
   CALL astt806_01_b_fill(g_wc2)
 
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
 
{<section id="astt806_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION astt806_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL astt806_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION astt806_01_modify()
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
      INPUT ARRAY g_stje_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stje_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt806_01_b_fill(g_wc2)
            LET g_detail_cnt = g_stje_d.getLength()
         
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
            DISPLAY g_stje_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_stje_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_stje_d[l_ac].stje001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stje_d_t.* = g_stje_d[l_ac].*  #BACKUP
               LET g_stje_d_o.* = g_stje_d[l_ac].*  #BACKUP
               IF NOT astt806_01_lock_b("stje_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt806_01_bcl INTO g_stje_d[l_ac].stjesite,g_stje_d[l_ac].stje001,g_stje_d[l_ac].stje002, 
                      g_stje_d[l_ac].stje007,g_stje_d[l_ac].stje008
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stje_d_t.stje001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stje_d_mask_o[l_ac].* =  g_stje_d[l_ac].*
                  CALL astt806_01_stje_t_mask()
                  LET g_stje_d_mask_n[l_ac].* =  g_stje_d[l_ac].*
                  
                  CALL astt806_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL astt806_01_set_entry_b(l_cmd)
            CALL astt806_01_set_no_entry_b(l_cmd)
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
            INITIALIZE g_stje_d_t.* TO NULL
            INITIALIZE g_stje_d_o.* TO NULL
            INITIALIZE g_stje_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_stje_d_t.* = g_stje_d[l_ac].*     #新輸入資料
            LET g_stje_d_o.* = g_stje_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stje_d[li_reproduce_target].* = g_stje_d[li_reproduce].*
 
               LET g_stje_d[g_stje_d.getLength()].stje001 = NULL
 
            END IF
            
 
            CALL astt806_01_set_entry_b(l_cmd)
            CALL astt806_01_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM stje_t 
             WHERE stjeent = g_enterprise AND stje001 = g_stje_d[l_ac].stje001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stje_d[g_detail_idx].stje001
               CALL astt806_01_insert_b('stje_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_stje_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stje_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt806_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (stje001 = '", g_stje_d[l_ac].stje001, "' "
 
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
               
               DELETE FROM stje_t
                WHERE stjeent = g_enterprise AND 
                      stje001 = g_stje_d_t.stje001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stje_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL astt806_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_stje_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE astt806_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_stje_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stje_d_t.stje001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt806_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL astt806_01_delete_b('stje_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_stje_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            UPDATE astt806_01_tmp SET sel =  g_stje_d[l_ac].sel
             WHERE stje001 = g_stje_d[l_ac].stje001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE astt806_01_tmp"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            
            CALL astt806_01_b_fill(g_wc2)
             
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stjesite
            
            #add-point:AFTER FIELD stjesite name="input.a.page1.stjesite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stje_d[l_ac].stjesite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stje_d[l_ac].stjesite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stje_d[l_ac].stjesite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stjesite
            #add-point:BEFORE FIELD stjesite name="input.b.page1.stjesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stjesite
            #add-point:ON CHANGE stjesite name="input.g.page1.stjesite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stjesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stjesite
            #add-point:ON ACTION controlp INFIELD stjesite name="input.c.page1.stjesite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE astt806_01_bcl
               LET INT_FLAG = 0
               LET g_stje_d[l_ac].* = g_stje_d_t.*
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
               LET g_errparam.extend = g_stje_d[l_ac].stje001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_stje_d[l_ac].* = g_stje_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL astt806_01_stje_t_mask_restore('restore_mask_o')
 
               UPDATE stje_t SET (stjesite,stje001,stje002,stje007,stje008) = (g_stje_d[l_ac].stjesite, 
                   g_stje_d[l_ac].stje001,g_stje_d[l_ac].stje002,g_stje_d[l_ac].stje007,g_stje_d[l_ac].stje008) 
 
                WHERE stjeent = g_enterprise AND
                  stje001 = g_stje_d_t.stje001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stje_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stje_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stje_d[g_detail_idx].stje001
               LET gs_keys_bak[1] = g_stje_d_t.stje001
               CALL astt806_01_update_b('stje_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_stje_d_t)
                     LET g_log2 = util.JSON.stringify(g_stje_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL astt806_01_stje_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL astt806_01_unlock_b("stje_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stje_d[l_ac].* = g_stje_d_t.*
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
               LET g_stje_d[li_reproduce_target].* = g_stje_d[li_reproduce].*
 
               LET g_stje_d[li_reproduce_target].stje001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stje_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stje_d.getLength()+1
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
               NEXT FIELD sel
 
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
      IF INT_FLAG OR cl_null(g_stje_d[g_detail_idx].stje001) THEN
         CALL g_stje_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_stje_d[g_detail_idx].* = g_stje_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE astt806_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astt806_01_delete()
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
   FOR li_idx = 1 TO g_stje_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT astt806_01_lock_b("stje_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("stje_t","") THEN
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
   
   FOR li_idx = 1 TO g_stje_d.getLength()
      IF g_stje_d[li_idx].stje001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM stje_t
          WHERE stjeent = g_enterprise AND 
                stje001 = g_stje_d[li_idx].stje001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stje_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_stje_d_t.stje001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL astt806_01_delete_b('stje_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt806_01_set_pk_array()
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
   CALL astt806_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt806_01_b_fill(p_wc2)              #BODY FILL UP
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
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.stjesite,t0.stje001,t0.stje002,t0.stje007,t0.stje008 ,t1.ooefl003 , 
       t2.pmaal003 ,t3.mhbel003 FROM stje_t t0",
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stjesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.stje007 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t3 ON t3.mhbelent="||g_enterprise||" AND t3.mhbel001=t0.stje008 AND t3.mhbel002='"||g_dlang||"' ",
 
               " WHERE t0.stjeent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("stje_t"),
                      " ORDER BY t0.stje001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   LET g_sql = " SELECT  DISTINCT      stjesite     ,stje001     , ",
               "                       stje002      ,stje007     , stje008, stjesite_desc     ,stje007_desc  , ",
               "                       stje008_desc   ",
               "   FROM astt806_01_tmp  ",
               "  WHERE stjeent = ? "
   LET g_sql = g_sql, " ORDER BY stjesite,stje001,stje002 "
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"stje_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astt806_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astt806_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stje_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_stje_d[l_ac].stjesite,g_stje_d[l_ac].stje001,g_stje_d[l_ac].stje002,g_stje_d[l_ac].stje007, 
       g_stje_d[l_ac].stje008,g_stje_d[l_ac].stjesite_desc,g_stje_d[l_ac].stje007_desc,g_stje_d[l_ac].stje008_desc 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT sel INTO g_stje_d[l_ac].sel 
        FROM astt806_01_tmp 
       WHERE stje001 = g_stje_d[l_ac].stje001
         AND stjeent = g_enterprise
      #end add-point
      
      CALL astt806_01_detail_show()      
 
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
   
 
   
   CALL g_stje_d.deleteElement(g_stje_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_stje_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_stje_d.getLength() THEN
      LET l_ac = g_stje_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_stje_d.getLength()
      LET g_stje_d_mask_o[l_ac].* =  g_stje_d[l_ac].*
      CALL astt806_01_stje_t_mask()
      LET g_stje_d_mask_n[l_ac].* =  g_stje_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_stje_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE astt806_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astt806_01_detail_show()
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
 
{<section id="astt806_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astt806_01_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("sel",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="astt806_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astt806_01_set_no_entry_b(p_cmd)                                               
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
 
{<section id="astt806_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astt806_01_default_search()
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
      LET ls_wc = ls_wc, " stje001 = '", g_argv[01], "' AND "
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
 
{<section id="astt806_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astt806_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "stje_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'stje_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM stje_t
          WHERE stjeent = g_enterprise AND
            stje001 = ps_keys_bak[1]
         
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
         CALL g_stje_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astt806_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "stje_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO stje_t
                  (stjeent,
                   stje001
                   ,stjesite,stje002,stje007,stje008) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_stje_d[l_ac].stjesite,g_stje_d[l_ac].stje002,g_stje_d[l_ac].stje007,g_stje_d[l_ac].stje008) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stje_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astt806_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "stje_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "stje_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE stje_t 
         SET (stje001
              ,stjesite,stje002,stje007,stje008) 
              = 
             (ps_keys[1]
              ,g_stje_d[l_ac].stjesite,g_stje_d[l_ac].stje002,g_stje_d[l_ac].stje007,g_stje_d[l_ac].stje008)  
 
         WHERE stjeent = g_enterprise AND stje001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stje_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stje_t:",SQLERRMESSAGE 
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
 
{<section id="astt806_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astt806_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL astt806_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "stje_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt806_01_bcl USING g_enterprise,
                                       g_stje_d[g_detail_idx].stje001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt806_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astt806_01_unlock_b(ps_table)
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
      CLOSE astt806_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION astt806_01_modify_detail_chk(ps_record)
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
         LET ls_return = "sel"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="astt806_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION astt806_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="astt806_01.mask_functions" >}
&include "erp/ast/astt806_01_mask.4gl"
 
{</section>}
 
{<section id="astt806_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION astt806_01_set_pk_array()
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
   LET g_pk_array[1].values = g_stje_d[l_ac].stje001
   LET g_pk_array[1].column = 'stje001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt806_01.state_change" >}
   
 
{</section>}
 
{<section id="astt806_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="astt806_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt806_01_create_temp()
   DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   CALL astt806_01_drop_temp()
   
   CREATE TEMP TABLE astt806_01_tmp(
      sel            LIKE type_t.chr1,
      stjeent        LIKE stje_t.stjeent,      
      stjesite       LIKE stje_t.stjesite, 
      stjesite_desc  LIKE type_t.chr500, 
      stje001        LIKE stje_t.stje001, 
      stje002        LIKE stje_t.stje002, 
      stje007        LIKE stje_t.stje007, 
      stje007_desc   LIKE type_t.chr500, 
      stje008        LIKE stje_t.stje008, 
      stje008_desc   LIKE type_t.chr500)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table astt806_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt806_01_drop_temp()
   DROP TABLE astt806_01_tmp
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt806_01_check_all()
   UPDATE astt806_01_tmp SET sel = 'Y'
   CALL astt806_01_b_fill(g_wc2)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt806_01_check_no_all()
   UPDATE astt806_01_tmp SET sel = 'N'
   CALL astt806_01_b_fill(g_wc2)
END FUNCTION

################################################################################
# Descriptions...: 產生單身
# Memo...........:
# Usage..........: CALL astt806_01_produce_data()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success
#                : 
# Date & Author..: 20160731 add by geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt806_01_produce_data()
   DEFINE l_success            LIKE type_t.num5
   DEFINE r_success            LIKE type_t.num5
   DEFINE l_sql                STRING 
   DEFINE l_stjecrtdt          LIKE stje_t.stjecrtdt   
   DEFINE l_stje001            LIKE stje_t.stje001
   DEFINE l_stem RECORD  #合約費用優惠審批單頭檔
          stement LIKE stem_t.stement, #企业代码
          stemunit LIKE stem_t.stemunit, #制定組織
          stemsite LIKE stem_t.stemsite, #营运组织
          stemdocno LIKE stem_t.stemdocno, #審批單號
          stemdocdt LIKE stem_t.stemdocdt, #申請日期
          stemacti LIKE stem_t.stemacti, #資料有效
          stemstus LIKE stem_t.stemstus, #狀態碼
          stem001 LIKE stem_t.stem001, #
          stem002 LIKE stem_t.stem002, #专柜编号
          stem003 LIKE stem_t.stem003, #供應商編號
          stem004 LIKE stem_t.stem004, #品牌編號
          stem005 LIKE stem_t.stem005, #經營小類
          stem006 LIKE stem_t.stem006, #建築面積
          stem007 LIKE stem_t.stem007, #經營面積
          stem008 LIKE stem_t.stem008, #是否按帳期抹零
          stem009 LIKE stem_t.stem009, #生效日期
          stem010 LIKE stem_t.stem010, #失效日期
          stem011 LIKE stem_t.stem011, #進場日期
          stem012 LIKE stem_t.stem012, #申請人員
          stem013 LIKE stem_t.stem013, #申請部門
          stem014 LIKE stem_t.stem014, #
          stem015 LIKE stem_t.stem015, #
          stem000 LIKE stem_t.stem000, #程式編號
          stem016 LIKE stem_t.stem016, #合約版本號
          stem017 LIKE stem_t.stem017, #測量面積
          stem018 LIKE stem_t.stem018, #優惠總金額
          stem019 LIKE stem_t.stem019, #延期日期
          stem020 LIKE stem_t.stem020, #面積修改日
          stem021 LIKE stem_t.stem021, #新建築面積
          stem022 LIKE stem_t.stem022, #新測量面積
          stem023 LIKE stem_t.stem023, #新經營面積
          stem024 LIKE stem_t.stem024, #終止類型
          stem025 LIKE stem_t.stem025, #終止結算日
          stem026 LIKE stem_t.stem026, #違約方
          stem027 LIKE stem_t.stem027, #違約金比例
          stem028 LIKE stem_t.stem028, #違約金額
          stem029 LIKE stem_t.stem029, #違約費用編號
          stem030 LIKE stem_t.stem030, #合約總額
          stem031 LIKE stem_t.stem031, #原付款金額
          stem032 LIKE stem_t.stem032, #應扣款金額
          stem033 LIKE stem_t.stem033, #應退款金額
          stem034 LIKE stem_t.stem034, #備註
          stem035 LIKE stem_t.stem035, #申請類型
          stem036 LIKE stem_t.stem036  #執行日期
   END RECORD
   DEFINE l_stje RECORD  #招商租賃合約單頭檔
          stjeent LIKE stje_t.stjeent, #企业代码
          stjesite LIKE stje_t.stjesite, #营运组织
          stjeunit LIKE stje_t.stjeunit, #制定組織
          stje001 LIKE stje_t.stje001, #合約編號
          stje002 LIKE stje_t.stje002, #版本
          stje003 LIKE stje_t.stje003, #合約項編號
          stje004 LIKE stje_t.stje004, #經營方式
          stje005 LIKE stje_t.stje005, #合約狀態
          stje006 LIKE stje_t.stje006, #文件編號
          stje007 LIKE stje_t.stje007, #商戶編號
          stje008 LIKE stje_t.stje008, #鋪位編號
          stje009 LIKE stje_t.stje009, #租賃類型
          stje010 LIKE stje_t.stje010, #門牌號
          stje011 LIKE stje_t.stje011, #租賃開始日期
          stje012 LIKE stje_t.stje012, #租賃結束日期
          stje013 LIKE stje_t.stje013, #免租天數
          stje014 LIKE stje_t.stje014, #首零合併
          stje015 LIKE stje_t.stje015, #尾零合併
          stje016 LIKE stje_t.stje016, #簽訂日期
          stje017 LIKE stje_t.stje017, #簽訂人員
          stje018 LIKE stje_t.stje018, #簽訂部門
          stje019 LIKE stje_t.stje019, #樓棟編號
          stje020 LIKE stje_t.stje020, #樓層編號
          stje021 LIKE stje_t.stje021, #區域編號
          stje022 LIKE stje_t.stje022, #鋪位用途
          stje023 LIKE stje_t.stje023, #建築面積
          stje024 LIKE stje_t.stje024, #測量面積
          stje025 LIKE stje_t.stje025, #經營面積
          stje026 LIKE stje_t.stje026, #人數
          stje027 LIKE stje_t.stje027, #no use
          stje028 LIKE stje_t.stje028, #管理品類
          stje029 LIKE stje_t.stje029, #經營主品牌
          stje030 LIKE stje_t.stje030, #結算組織
          stje031 LIKE stje_t.stje031, #結算方式
          stje032 LIKE stje_t.stje032, #結算類型
          stje033 LIKE stje_t.stje033, #收銀方式
          stje034 LIKE stje_t.stje034, #付款條件
          stje035 LIKE stje_t.stje035, #交易條件
          stje036 LIKE stje_t.stje036, #幣別
          stje037 LIKE stje_t.stje037, #匯率計算基準
          stje038 LIKE stje_t.stje038, #稅別
          stje039 LIKE stje_t.stje039, #發票類型
          stje040 LIKE stje_t.stje040, #含發票否
          stje041 LIKE stje_t.stje041, #執行日期
          stje042 LIKE stje_t.stje042, #進場日期
          stje043 LIKE stje_t.stje043, #延期日期
          stje044 LIKE stje_t.stje044, #原合約開始日期
          stje045 LIKE stje_t.stje045, #清退日期
          stje046 LIKE stje_t.stje046, #作廢日期
          stje047 LIKE stje_t.stje047, #蓋章日期
          stje048 LIKE stje_t.stje048, #預租協議
          stje049 LIKE stje_t.stje049, #備註
          stje050 LIKE stje_t.stje050, #初審異動日期
          stje051 LIKE stje_t.stje051, #初審異動人員
          stje052 LIKE stje_t.stje052, #終審異動日期
          stje053 LIKE stje_t.stje053, #終審異動人員
          stjestus LIKE stje_t.stjestus #狀態碼
   END RECORD
   DEFINE l_stie000            LIKE stie_t.stie000
   DEFINE  l_stje043             LIKE stje_t.stje043  
   DEFINE  l_stje012             LIKE stje_t.stje012
   DEFINE  l_sdate               LIKE type_t.dat 
   DEFINE  l_cnt                 LIKE type_t.num10
   DEFINE  l_choice              LIKE type_t.chr10 #续签的时候1重取标准2沿用旧的方案
   DEFINE  l_count               LIKE type_t.num10
   WHENEVER ERROR CONTINUE 
   
   LET l_success = TRUE
   LET r_success = TRUE
      
   LET l_stjecrtdt = cl_get_current()
   
   CALL cl_err_collect_init()
   INITIALIZE l_stem.* TO NULL
   SELECT stement,stemunit,stemsite,stemdocno,stemdocdt,
          stemacti,stemstus,stem001,stem002,stem003,
          stem004,stem005,stem006,stem007,stem008,
          stem009,stem010,stem011,stem012,stem013,
          stem014,stem015,stem000,stem016,stem017,
          stem018,stem019,stem020,stem021,stem022,
          stem023,stem024,stem025,stem026,stem027,
          stem028,stem029,stem030,stem031,stem032,
          stem033,stem034,stem035,stem036
     INTO l_stem.stement,l_stem.stemunit,l_stem.stemsite,l_stem.stemdocno,l_stem.stemdocdt,
          l_stem.stemacti,l_stem.stemstus,l_stem.stem001,l_stem.stem002,l_stem.stem003,
          l_stem.stem004,l_stem.stem005,l_stem.stem006,l_stem.stem007,l_stem.stem008,
          l_stem.stem009,l_stem.stem010,l_stem.stem011,l_stem.stem012,l_stem.stem013,
          l_stem.stem014,l_stem.stem015,l_stem.stem000,l_stem.stem016,l_stem.stem017,
          l_stem.stem018,l_stem.stem019,l_stem.stem020,l_stem.stem021,l_stem.stem022,
          l_stem.stem023,l_stem.stem024,l_stem.stem025,l_stem.stem026,l_stem.stem027,
          l_stem.stem028,l_stem.stem029,l_stem.stem030,l_stem.stem031,l_stem.stem032,
          l_stem.stem033,l_stem.stem034,l_stem.stem035,l_stem.stem036
     FROM stem_t
    WHERE stement = g_enterprise
      AND stemdocno = g_stemdocno
   
   IF l_stem.stem035 = '1' THEN               
      IF cl_ask_confirm('ast-00831') THEN 
         LET l_choice = '1'
      ELSE
         LET l_choice = '2'
      END IF
   END IF   
      
#   LET l_sql = " SELECT  DISTINCT stje001  ",
#               "   FROM astt806_01_tmp  ",
#               "  WHERE stjeent = ? AND sel = 'Y' ",
#               "  ORDER BY stje001 "
#   
#   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
#   PREPARE astt806_01_pb1 FROM l_sql
#   DECLARE b_fill_curs1 CURSOR WITH HOLD FOR astt806_01_pb1
#   
#   OPEN b_fill_curs1 USING g_enterprise
# 
#   LET g_cnt = l_ac
#   LET l_ac = 1   
#   ERROR "Searching!" 
# 
#   FOREACH b_fill_curs1 INTO l_stje001
    FOR l_count = 1 TO g_stje_d.getLength() STEP 1
      IF g_stje_d[l_count].sel = 'Y' THEN
         CALL s_transaction_begin()
         LET l_stje001 = g_stje_d[l_count].stje001
         INITIALIZE l_stje.* TO NULL
         SELECT stjeent,stjesite,stjeunit,
                stje001,stje002,stje003,stje004,stje005,
                stje006,stje007,stje008,stje009,stje010,
                stje011,stje012,stje013,stje014,stje015,
                stje016,stje017,stje018,stje019,stje020,
                stje021,stje022,stje023,stje024,stje025,
                stje026,stje027,stje028,stje029,stje030,
                stje031,stje032,stje033,stje034,stje035,
                stje036,stje037,stje038,stje039,stje040,
                stje041,stje042,stje043,stje044,stje045,
                stje046,stje047,stje048,stje049,stje050,
                stje051,stje052,stje053,stjestus
           INTO l_stje.stjeent,l_stje.stjesite,l_stje.stjeunit,
                l_stje.stje001,l_stje.stje002,l_stje.stje003,l_stje.stje004,l_stje.stje005,
                l_stje.stje006,l_stje.stje007,l_stje.stje008,l_stje.stje009,l_stje.stje010,
                l_stje.stje011,l_stje.stje012,l_stje.stje013,l_stje.stje014,l_stje.stje015,
                l_stje.stje016,l_stje.stje017,l_stje.stje018,l_stje.stje019,l_stje.stje020,
                l_stje.stje021,l_stje.stje022,l_stje.stje023,l_stje.stje024,l_stje.stje025,
                l_stje.stje026,l_stje.stje027,l_stje.stje028,l_stje.stje029,l_stje.stje030,
                l_stje.stje031,l_stje.stje032,l_stje.stje033,l_stje.stje034,l_stje.stje035,
                l_stje.stje036,l_stje.stje037,l_stje.stje038,l_stje.stje039,l_stje.stje040,
                l_stje.stje041,l_stje.stje042,l_stje.stje043,l_stje.stje044,l_stje.stje045,
                l_stje.stje046,l_stje.stje047,l_stje.stje048,l_stje.stje049,l_stje.stje050,
                l_stje.stje051,l_stje.stje052,l_stje.stje053,l_stje.stjestus
           FROM stje_t
          WHERE stjeent = g_enterprise
            AND stje001 = l_stje001
         IF l_stje.stje002 IS NULL THEN
            LET l_stje.stje002 = 1
         ELSE
            LET l_stje.stje002 = 1+l_stje.stje002               
         END IF
         LET l_stje.stje002 = l_stje.stje002 USING "<<<<<<<<<#"   
         #续签
         IF l_stem.stem035 = '1'  THEN
            IF l_stje.stje044 IS NULL THEN
               LET l_stje.stje044 = l_stje.stje011  
            END IF   
            LET l_stje.stje011 = l_stje.stje012+1 
            LET l_stje.stje013 = 0        
            LET l_stje.stje041 = l_stje.stje012+1
            LET l_stje.stje042 = l_stje.stje012+1
            LET l_stje.stje012 = l_stem.stem036
            LET l_stje.stje043 = ''  
            LET l_stie000 = 'R'
         END IF
         #延期
         IF l_stem.stem035 = '2'  THEN
            LET l_stje.stje041 = l_stje.stje012+1
            LET l_stje.stje043 = l_stem.stem036
            LET l_stie000 = 'B'
         END IF
         #优惠变更
         IF l_stem.stem035 = '3'  THEN
            LET l_stje.stje041 = l_stem.stem036
            LET l_stie000 = 'A'
         END IF
         
         #LET l_stje.stje027 = '1'
         
         #新增单头
         INSERT INTO  stke_t (stkeent,stkesite,stkeunit,stkedocno,stkedocdt,stke000,
                              stke001,stke002,stke003,stke004,stke005,
                              stke006,stke007,stke008,stke009,stke010,
                              stke011,stke012,stke013,stke014,stke015,
                              stke016,stke017,stke018,stke019,stke020,
                              stke021,stke022,stke023,stke024,stke025,
                              stke026,stke027,stke028,stke029,stke030,
                              stke031,stke032,stke033,stke034,stke035,
                              stke036,stke037,stke038,stke039,stke040,
                              stke041,stke042,stke043,stke044,stke045,
                              stke046,stke047,stke048,stke049,stke050,
                              stke051,stke052,stke053,stke200,
                              stkestus,stkeownid,stkeowndp,stkecrtid,
                              stkecrtdp,stkecrtdt,stkemodid,stkemoddt) 
                      VALUES (l_stje.stjeent,l_stje.stjesite,l_stje.stjeunit,g_stemdocno,l_stem.stemdocdt,l_stie000,
                              l_stje.stje001,l_stje.stje002,l_stje.stje003,l_stje.stje004,l_stje.stje005,
                              l_stje.stje006,l_stje.stje007,l_stje.stje008,l_stje.stje009,l_stje.stje010,
                              l_stje.stje011,l_stje.stje012,l_stje.stje013,l_stje.stje014,l_stje.stje015,
                              l_stje.stje016,l_stje.stje017,l_stje.stje018,l_stje.stje019,l_stje.stje020,
                              l_stje.stje021,l_stje.stje022,l_stje.stje023,l_stje.stje024,l_stje.stje025,
                              l_stje.stje026,l_stje.stje027,l_stje.stje028,l_stje.stje029,l_stje.stje030,
                              l_stje.stje031,l_stje.stje032,l_stje.stje033,l_stje.stje034,l_stje.stje035,
                              l_stje.stje036,l_stje.stje037,l_stje.stje038,l_stje.stje039,l_stje.stje040,
                              l_stje.stje041,l_stje.stje042,l_stje.stje043,l_stje.stje044,l_stje.stje045,
                              l_stje.stje046,l_stje.stje047,l_stje.stje048,l_stje.stje049,l_stje.stje050,
                              l_stje.stje051,l_stje.stje052,l_stje.stje053,g_stemdocno,
                              'N',g_user,g_dept,g_user,
                              g_dept,l_stjecrtdt,g_user,l_stjecrtdt)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'Ins stke_t err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF
         CALL astt806_01_stke001_genb(g_stemdocno,l_stje001,l_choice) RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE
         END IF
         
         #产生对应的延期续签内容
         #新增或者面积变更续签的时候               
         IF l_stem.stem035 = '1' THEN 
            #产生场地信息
            CALL s_astt806_stkj_insert(l_stje001,g_stemdocno) RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF 
         END IF
         #产生账期
         IF l_stem.stem035 = '1' OR l_stem.stem035 = '2'  THEN   
            IF NOT s_astt806_upd_stko(l_stje001,g_stemdocno) THEN
               LET r_success = FALSE
            END IF
         END IF                  
         #优惠变更
         IF l_stem.stem035 = '3' THEN                  
            CALL s_astt806_stkh_insert(l_stje001,g_stemdocno,l_stem.stem035) RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF
            #产生费用日核算
            CALL s_astt806_day_account('A',g_stemdocno,l_stje.stje042,l_stje.stje012,l_stje001)  RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF                 
            #优惠的时候更新合同账单
            CALL s_astt806_update_stkm_t(g_stemdocno,'A',l_stje001) RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF 
         END IF
         #延期
         IF l_stem.stem035 = '2' THEN                  
            #重取标准
            CALL s_astt806_refetch_standard('B',g_stemdocno,l_stje001)  RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF                  
            #产生费用日核算
            INITIALIZE l_stje043,l_stje012,l_sdate TO NULL
            SELECT stje043,stje012 INTO l_stje043,l_stje012
              FROM stje_t
             WHERE stjeent = g_enterprise
               AND stje001 = l_stje001
            IF l_stje043 IS NOT NULL THEN
               LET l_sdate = l_stje043
            ELSE
               LET l_sdate = l_stje012
            END IF
            CALL s_astt806_day_account('B',g_stemdocno,l_sdate+1,l_stje.stje043,l_stje001)  RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF                 
            #产生合同账单                  
            CALL s_astt806_produce_period('B',g_stemdocno,l_sdate+1,l_stje.stje043,l_sdate+1,l_stje001)  RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF  
         END IF                              
         #续签单头录入后自动产生单身（固定费用和变动费用不自动从合同主档带）：先提示是否重取标准，
         #是从合同开始~结束日期重新取标准费用带出单身；
         #否，从原合同带出 （一次性的费用不自动带出）
         IF l_stem.stem035 = '1' THEN               
            IF l_choice = '1'  THEN 
               CALL s_astt806_refetch_standard('R',g_stemdocno,l_stje001)  RETURNING l_success
               IF NOT l_success THEN
                  LET r_success = FALSE
               END IF
            ELSE   
               #如果场地发生变化，提示只能重取标准
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM stkj_t,stjj_t
                WHERE stkjent = g_enterprise
                  AND stkjdocno = g_stemdocno
                  AND stkjent = stjjent 
                  AND stkj001 = stjj001
                  AND stjj001 = l_stje001
                  AND stkj002 <> stjj002
                  AND stkjseq = stjjseq
               IF l_cnt > 0 THEN
                  CALL cl_ask_confirm3("ast-00832","")
                  CALL s_astt806_refetch_standard('R',g_stemdocno,l_stje001)  RETURNING l_success
                  IF NOT l_success THEN
                     LET r_success = FALSE
                  END IF
                  #从合同主档带出非标准的
                  CALL s_astt806_stkf_get('1',l_stje001,g_stemdocno) RETURNING l_success
                  IF NOT l_success THEN
                     LET r_success = FALSE
                  END IF
               ELSE                     
                  #从合同主档带值
                  CALL s_astt806_stkf_get('2',l_stje001,g_stemdocno) RETURNING l_success
                  IF NOT l_success THEN
                     LET r_success = FALSE
                  END IF
               END IF
            END IF
            #产生费用日核算
            CALL s_astt806_day_account('R',g_stemdocno,l_stje.stje042,l_stje.stje012,l_stje001)  RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF
            #新增定义账期
            CALL s_astt806_stki_insert(l_stje001,g_stemdocno) RETURNING l_success                      
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF 
            #产生合同账单                  
            CALL s_astt806_produce_period('R',g_stemdocno,l_stje.stje011,l_stje.stje012,l_stje.stje042,l_stje001)  RETURNING l_success
            IF NOT l_success THEN
               LET r_success = FALSE
            END IF           
               
         END IF
         IF r_success THEN
            CALL s_transaction_end('Y',0)
         ELSE
            CALL s_transaction_end('N',0)
         END IF
      END IF    
   END FOR
   

   
   CALL cl_err_collect_show()
   
   LET r_success = TRUE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 查詢時將資料ins至tmp
# Memo...........:
# Usage..........: CALL astt806_01_query_data(p_wc2)
# Input parameter: p_wc2          查詢條件
#                : 
# Return code....: 
#                : 
# Date & Author..: 20160731 add by geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt806_01_query_data(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_stbc037_value STRING
   DEFINE l_date_sql      STRING
   DEFINE l_sql           STRING
   DEFINE l_stem RECORD  #合約費用優惠審批單頭檔
          stement LIKE stem_t.stement, #企业代码
          stemunit LIKE stem_t.stemunit, #制定組織
          stemsite LIKE stem_t.stemsite, #营运组织
          stemdocno LIKE stem_t.stemdocno, #審批單號
          stemdocdt LIKE stem_t.stemdocdt, #申請日期
          stemacti LIKE stem_t.stemacti, #資料有效
          stemstus LIKE stem_t.stemstus, #狀態碼
          stem001 LIKE stem_t.stem001, #
          stem002 LIKE stem_t.stem002, #专柜编号
          stem003 LIKE stem_t.stem003, #供應商編號
          stem004 LIKE stem_t.stem004, #品牌編號
          stem005 LIKE stem_t.stem005, #經營小類
          stem006 LIKE stem_t.stem006, #建築面積
          stem007 LIKE stem_t.stem007, #經營面積
          stem008 LIKE stem_t.stem008, #是否按帳期抹零
          stem009 LIKE stem_t.stem009, #生效日期
          stem010 LIKE stem_t.stem010, #失效日期
          stem011 LIKE stem_t.stem011, #進場日期
          stem012 LIKE stem_t.stem012, #申請人員
          stem013 LIKE stem_t.stem013, #申請部門
          stem014 LIKE stem_t.stem014, #
          stem015 LIKE stem_t.stem015, #
          stem000 LIKE stem_t.stem000, #程式編號
          stem016 LIKE stem_t.stem016, #合約版本號
          stem017 LIKE stem_t.stem017, #測量面積
          stem018 LIKE stem_t.stem018, #優惠總金額
          stem019 LIKE stem_t.stem019, #延期日期
          stem020 LIKE stem_t.stem020, #面積修改日
          stem021 LIKE stem_t.stem021, #新建築面積
          stem022 LIKE stem_t.stem022, #新測量面積
          stem023 LIKE stem_t.stem023, #新經營面積
          stem024 LIKE stem_t.stem024, #終止類型
          stem025 LIKE stem_t.stem025, #終止結算日
          stem026 LIKE stem_t.stem026, #違約方
          stem027 LIKE stem_t.stem027, #違約金比例
          stem028 LIKE stem_t.stem028, #違約金額
          stem029 LIKE stem_t.stem029, #違約費用編號
          stem030 LIKE stem_t.stem030, #合約總額
          stem031 LIKE stem_t.stem031, #原付款金額
          stem032 LIKE stem_t.stem032, #應扣款金額
          stem033 LIKE stem_t.stem033, #應退款金額
          stem034 LIKE stem_t.stem034, #備註
          stem035 LIKE stem_t.stem035, #申請類型
          stem036 LIKE stem_t.stem036  #執行日期
   END RECORD
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   INITIALIZE l_stem.* TO NULL
   SELECT stement,stemunit,stemsite,stemdocno,stemdocdt,
          stemacti,stemstus,stem001,stem002,stem003,
          stem004,stem005,stem006,stem007,stem008,
          stem009,stem010,stem011,stem012,stem013,
          stem014,stem015,stem000,stem016,stem017,
          stem018,stem019,stem020,stem021,stem022,
          stem023,stem024,stem025,stem026,stem027,
          stem028,stem029,stem030,stem031,stem032,
          stem033,stem034,stem035,stem036
     INTO l_stem.stement,l_stem.stemunit,l_stem.stemsite,l_stem.stemdocno,l_stem.stemdocdt,
          l_stem.stemacti,l_stem.stemstus,l_stem.stem001,l_stem.stem002,l_stem.stem003,
          l_stem.stem004,l_stem.stem005,l_stem.stem006,l_stem.stem007,l_stem.stem008,
          l_stem.stem009,l_stem.stem010,l_stem.stem011,l_stem.stem012,l_stem.stem013,
          l_stem.stem014,l_stem.stem015,l_stem.stem000,l_stem.stem016,l_stem.stem017,
          l_stem.stem018,l_stem.stem019,l_stem.stem020,l_stem.stem021,l_stem.stem022,
          l_stem.stem023,l_stem.stem024,l_stem.stem025,l_stem.stem026,l_stem.stem027,
          l_stem.stem028,l_stem.stem029,l_stem.stem030,l_stem.stem031,l_stem.stem032,
          l_stem.stem033,l_stem.stem034,l_stem.stem035,l_stem.stem036
     FROM stem_t
    WHERE stement = g_enterprise
      AND stemdocno = g_stemdocno
   #ins至temp
   DELETE FROM astt806_01_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE:astt806_01_tmp"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET l_sql = " INSERT INTO astt806_01_tmp ( ",
                 "             sel            ,stjesite     ,stjesite_desc    ,stje001     , ",
                 "             stje002        ,stje007      ,stje007_desc     ,stje008     , ",
                 "             stje008_desc   ,stjeent  ) ",
                 " SELECT UNIQUE        'N',stjesite, ooefl003, stje001 ,",
                 "                  stje002,stje007,  pmaal003, stje008 ,",  
                 "                 mhbel003,stjeent ",
                 "   FROM stje_t ",
                 "   LEFT JOIN ooefl_t  ON ooeflent='"||g_enterprise||"' AND  ooefl001= stjesite AND ooefl002='"||g_dlang||"' ",
                 "   LEFT JOIN pmaal_t  ON pmaalent='"||g_enterprise||"' AND  pmaal001= stje007  AND pmaal002='"||g_dlang||"' ",
                 "   LEFT JOIN mhbel_t  ON mhbelent='"||g_enterprise||"' AND  mhbel001= stje008  AND mhbel002='"||g_dlang||"' ",
                 "  WHERE stjeent = ? AND ",g_wc," AND stjestus = 'Y'  AND stje005 IN ('2','3','4','5') ",
                 "    AND stjesite = '",l_stem.stemsite,"' ",
                 "    AND NOT EXISTS (SELECT 1 FROM stke_t,stem_t WHERE stement = stkeent AND stemdocno = stkedocno AND stkeent = '"||g_enterprise||"' AND stke001 = stje001 AND stkedocno <> '",g_stemdocno,"' AND stemstus = 'N' )",
                 "    AND NOT EXISTS (SELECT 1 FROM stke_t WHERE stkeent = '"||g_enterprise||"' AND stke001 = stje001 AND stkedocno = '",g_stemdocno,"' )",
                 #是否存在合同未完成的合同申请档中的资料
                 "    AND NOT EXISTS (SELECT 1 FROM stie_t WHERE stieent = '"||g_enterprise||"' AND stie001 = stje001  AND stiestus IN ('N','TP') )",
                 #是否存在合同在变更单中未审核的资料
                 "    AND NOT EXISTS (SELECT 1 FROM stem_t WHERE stement = '"||g_enterprise||"' AND stem001 = stje001  AND stemstus = 'N' AND stem001 IS NOT NULL) ",
                 #是否存在合同在变更单中但不在合同申请档中的资料
                 "    AND NOT EXISTS (SELECT 1 FROM stem_t WHERE stement = '"||g_enterprise||"' AND stem001 = stje001  AND stemstus = 'Y' AND stem001 IS NOT NULL ",
                 "    AND NOT EXISTS (SELECT 1 FROM stie_t WHERE stieent = '"||g_enterprise||"' AND stie001 = stem001  AND stiestus = 'FP' AND stie200 = stemdocno))"
   #批量续签
   IF l_stem.stem035 = '1' THEN
      LET l_sql = l_sql," AND  stje012 < '",l_stem.stem036,"' "
   END IF
   #批量延期
   IF l_stem.stem035 = '2' THEN
      LET l_sql = l_sql," AND  stje012 < '",l_stem.stem036,"' "
   END IF
   #批量优惠变更
   IF l_stem.stem035 = '3' THEN
      LET l_sql = l_sql," AND  stje011 <='",l_stem.stem036,"' AND stje012 >= '",l_stem.stem036,"' "
   END IF

   PREPARE astt806_01_ins_temp_pre FROM l_sql
   EXECUTE astt806_01_ins_temp_pre USING g_enterprise
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE:astt806_01_ins_temp_pre"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   LET p_wc2 = " 1=1"
   CALL astt806_01_b_fill(p_wc2)
END FUNCTION

################################################################################
# Descriptions...: 通过合同产生合同单身
# Memo...........:
# Usage..........: CALL astt806_01_stke001_genb(p_stemdocno,p_stje001,p_choice)
#                  RETURNING 回传参数
# Input parameter: p_stemdocno    单号
# Input parameter: p_stje001      合同
# Input parameter: p_choice       续签产生资料的方式 1.重取标准 2.原合同
# Date & Author..: 20160801 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt806_01_stke001_genb(p_stemdocno,p_stje001,p_choice)
   DEFINE p_stemdocno            LIKE stem_t.stemdocno
   DEFINE p_stje001              LIKE stje_t.stje001
   DEFINE r_success              LIKE type_t.num5
   DEFINE l_stem RECORD  #合約費用優惠審批單頭檔
          stement LIKE stem_t.stement, #企业代码
          stemunit LIKE stem_t.stemunit, #制定組織
          stemsite LIKE stem_t.stemsite, #营运组织
          stemdocno LIKE stem_t.stemdocno, #審批單號
          stemdocdt LIKE stem_t.stemdocdt, #申請日期
          stemacti LIKE stem_t.stemacti, #資料有效
          stemstus LIKE stem_t.stemstus, #狀態碼
          stem001 LIKE stem_t.stem001, #
          stem002 LIKE stem_t.stem002, #专柜编号
          stem003 LIKE stem_t.stem003, #供應商編號
          stem004 LIKE stem_t.stem004, #品牌編號
          stem005 LIKE stem_t.stem005, #經營小類
          stem006 LIKE stem_t.stem006, #建築面積
          stem007 LIKE stem_t.stem007, #經營面積
          stem008 LIKE stem_t.stem008, #是否按帳期抹零
          stem009 LIKE stem_t.stem009, #生效日期
          stem010 LIKE stem_t.stem010, #失效日期
          stem011 LIKE stem_t.stem011, #進場日期
          stem012 LIKE stem_t.stem012, #申請人員
          stem013 LIKE stem_t.stem013, #申請部門
          stem014 LIKE stem_t.stem014, #
          stem015 LIKE stem_t.stem015, #
          stem000 LIKE stem_t.stem000, #程式編號
          stem016 LIKE stem_t.stem016, #合約版本號
          stem017 LIKE stem_t.stem017, #測量面積
          stem018 LIKE stem_t.stem018, #優惠總金額
          stem019 LIKE stem_t.stem019, #延期日期
          stem020 LIKE stem_t.stem020, #面積修改日
          stem021 LIKE stem_t.stem021, #新建築面積
          stem022 LIKE stem_t.stem022, #新測量面積
          stem023 LIKE stem_t.stem023, #新經營面積
          stem024 LIKE stem_t.stem024, #終止類型
          stem025 LIKE stem_t.stem025, #終止結算日
          stem026 LIKE stem_t.stem026, #違約方
          stem027 LIKE stem_t.stem027, #違約金比例
          stem028 LIKE stem_t.stem028, #違約金額
          stem029 LIKE stem_t.stem029, #違約費用編號
          stem030 LIKE stem_t.stem030, #合約總額
          stem031 LIKE stem_t.stem031, #原付款金額
          stem032 LIKE stem_t.stem032, #應扣款金額
          stem033 LIKE stem_t.stem033, #應退款金額
          stem034 LIKE stem_t.stem034, #備註
          stem035 LIKE stem_t.stem035, #申請類型
          stem036 LIKE stem_t.stem036  #執行日期
   END RECORD 
   DEFINE  p_choice              LIKE type_t.chr10 #续签的时候1重取标准2沿用旧的方案
   
   INITIALIZE l_stem.* TO NULL
   SELECT stement,stemunit,stemsite,stemdocno,stemdocdt,
          stemacti,stemstus,stem001,stem002,stem003,
          stem004,stem005,stem006,stem007,stem008,
          stem009,stem010,stem011,stem012,stem013,
          stem014,stem015,stem000,stem016,stem017,
          stem018,stem019,stem020,stem021,stem022,
          stem023,stem024,stem025,stem026,stem027,
          stem028,stem029,stem030,stem031,stem032,
          stem033,stem034,stem035,stem036
     INTO l_stem.stement,l_stem.stemunit,l_stem.stemsite,l_stem.stemdocno,l_stem.stemdocdt,
          l_stem.stemacti,l_stem.stemstus,l_stem.stem001,l_stem.stem002,l_stem.stem003,
          l_stem.stem004,l_stem.stem005,l_stem.stem006,l_stem.stem007,l_stem.stem008,
          l_stem.stem009,l_stem.stem010,l_stem.stem011,l_stem.stem012,l_stem.stem013,
          l_stem.stem014,l_stem.stem015,l_stem.stem000,l_stem.stem016,l_stem.stem017,
          l_stem.stem018,l_stem.stem019,l_stem.stem020,l_stem.stem021,l_stem.stem022,
          l_stem.stem023,l_stem.stem024,l_stem.stem025,l_stem.stem026,l_stem.stem027,
          l_stem.stem028,l_stem.stem029,l_stem.stem030,l_stem.stem031,l_stem.stem032,
          l_stem.stem033,l_stem.stem034,l_stem.stem035,l_stem.stem036
     FROM stem_t
    WHERE stement = g_enterprise
      AND stemdocno = g_stemdocno
   LET r_success = TRUE
   DELETE FROM stkf_t WHERE stkfent = g_enterprise AND stkfdocno = p_stemdocno AND stkf001 = p_stje001
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkf_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stkg_t WHERE stkgent = g_enterprise AND stkgdocno = p_stemdocno  AND stkg001 = p_stje001    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkg_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stkh_t WHERE stkhent = g_enterprise AND stkhdocno = p_stemdocno AND stkh001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkh_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stki_t WHERE stkient = g_enterprise AND stkidocno = p_stemdocno AND stki001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stee'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stkj_t WHERE stkjent = g_enterprise AND stkjdocno = p_stemdocno AND stkj001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkj_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stkk_t WHERE stkkent = g_enterprise AND stkkdocno = p_stemdocno AND stkk001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkk_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stkl_t WHERE stklent = g_enterprise AND stkldocno = p_stemdocno AND stkl001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkl_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stkm_t WHERE stkment = g_enterprise AND stkmdocno = p_stemdocno AND stkm001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkm_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stkn_t WHERE stknent = g_enterprise AND stkndocno = p_stemdocno AND stkn001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stkn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM stko_t WHERE stkoent = g_enterprise AND stkodocno = p_stemdocno AND stko001 = p_stje001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del stko_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #续签的合同不自动从合同带出    
   IF l_stem.stem035 <> '1' THEN
      INSERT INTO stkf_t
                  (stkfent,stkf001,stkfseq,stkf002,stkf003,stkf004,stkf005,stkf006,stkf007,
                   stkf008,stkf009,stkf010,stkf011,stkf012,stkf013,stkf014,stkf015,stkf016,stkf017,
                   stkf018,stkf019,stkf020,stkf021,stkf022,stkf023,stkf024,stkf025,stkfsite,stkfunit,stkfdocno) 
              SELECT stjfent,stjf001,stjfseq,stjf002,stjf003,stjf004,stjf005,stjf006,stjf007,
                     stjf008,stjf009,stjf010,stjf011,stjf012,stjf013,stjf014,stjf015,stjf016,stjf017,
                     stjf018,stjf019,stjf020,stjf021,stjf022,stjf023,stjf024,stjf025,stjfsite,stjfunit,p_stemdocno 
                FROM stjf_t
               WHERE stjfent = g_enterprise 
                 AND stjf001 = p_stje001
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Ins stkf_t err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
         
      INSERT INTO stkg_t
                  (stkgent,stkgseq,stkgseq1,stkg001,stkg002,stkg003,stkg004,stkg005,stkg006,stkg007,stkgsite,stkgunit,stkgdocno)
      SELECT stjgent,stjgseq,stjgseq1,stjg001,stjg002,stjg003,stjg004,stjg005,stjg006,stjg007,stjgsite,stjgunit,p_stemdocno   
        FROM stjg_t
       WHERE stjgent = g_enterprise AND stjg001 = p_stje001
      
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Ins stkg_t err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
         RETURN r_success
      END IF
         
      INSERT INTO stkh_t
                  (stkhent,stkhseq,stkh001,stkh002,stkh003,stkh004,stkh005,stkh006,stkh007,stkh008,stkhsite,stkhunit,stkhdocno)
              SELECT stjhent,stjhseq,stjh001,stjh002,stjh003,stjh004,stjh005,stjh006,stjh007,stjh008,stjhsite,stjhunit,p_stemdocno     
                FROM stjh_t
               WHERE stjhent = g_enterprise AND stjh001 = p_stje001
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Ins stkh_t err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF   
   #续签并且重取标准的合同不自动从合同带出    
   IF l_stem.stem035 = '1' AND ( p_choice = '1' AND p_choice IS NOT NULL ) THEN
   
   ELSE
      INSERT INTO stki_t
                  (stkient,stkiseq,stki001,stki002,stki003,stki004,stki005,stki006,stki007,stki008,stki009,stki010,stkisite,stkiunit,stkidocno)           
              SELECT stjient,stjiseq,stji001,stji002,stji003,stji004,stji005,stji006,stji007,stji008,stji009,stji010,stjisite,stjiunit,p_stemdocno   
                FROM stji_t
               WHERE stjient = g_enterprise AND stji001 = p_stje001
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Ins stki_t err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF   
   INSERT INTO stkj_t
                 (stkjent,stkjseq,stkjacti,stkj001,stkj002,stkj003,stkj004,stkj005,stkj006,stkj007,stkj008,stkj009,stkjsite,stkjunit,stkjdocno)
           SELECT stjjent,stjjseq,stjjacti,stjj001,stjj002,stjj003,stjj004,stjj005,stjj006,stjj007,stjj008,stjj009,stjjsite,stjjunit,p_stemdocno 
             FROM stjj_t
            WHERE stjjent = g_enterprise AND stjj001 = p_stje001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins stkj_t err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success
   END IF
      
   INSERT INTO stkk_t
               (stkkent,stkkseq,stkkacti,stkk001,stkk002,stkk003,stkk004,stkk005,stkksite,stkkunit,stkkdocno)               
           SELECT stjkent,stjkseq,stjkacti,stjk001,stjk002,stjk003,stjk004,stjk005,stjksite,stjkunit,p_stemdocno 
             FROM stjk_t
            WHERE stjkent = g_enterprise AND stjk001 = p_stje001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins stkk_t err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success
   END IF
      
   INSERT INTO stkl_t
              (stklent,stklseq,stkl001,stkl002,stkl003,stkl004,stkl005,stkl006,stkl007,stkl008,stklsite,stklunit,stkldocno) 
        SELECT stjlent,stjlseq,stjl001,stjl002,stjl003,stjl004,stjl005,stjl006,stjl007,stjl008,stjlsite,stjlunit,p_stemdocno 
          FROM stjl_t
         WHERE stjlent = g_enterprise AND stjl001 = p_stje001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins stkl_t err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success
   END IF
      
   INSERT INTO stkm_t
                  (stkment,stkmseq,stkm001,stkm002,stkm003,stkm004,stkm005,stkm006,stkm007,stkm008,stkm009,stkm010,
                  stkm011,stkm012,stkm013,stkm014,stkm015,stkm016,stkm017,stkm018,stkm019,stkmsite,stkmunit,stkmdocno)          
           SELECT stjment,stjmseq,stjm001,stjm002,stjm003,stjm004,stjm005,stjm006,stjm007,stjm008,stjm009,stjm010,
                  stjm011,stjm012,stjm013,stjm014,stjm015,stjm016,stjm017,stjm018,stjm019,stjmsite,stjmunit,p_stemdocno            
             FROM stjm_t
            WHERE stjment = g_enterprise AND stjm001 = p_stje001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins stkm_t err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success
   END IF
      
   INSERT INTO stkn_t
               (stknent,stknseq,stkn001,stkn002,stkn003,stkn004,stkn005,stkn006,stkn007,stkn008,stkn009,stkn010,stknsite,stknunit,stkndocno)
           SELECT stjnent,stjnseq,stjn001,stjn002,stjn003,stjn004,stjn005,stjn006,stjn007,stjn008,stjn009,stjn010,stjnsite,stjnunit,p_stemdocno   
             FROM stjn_t
            WHERE stjnent = g_enterprise AND stjn001 = p_stje001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins stkn_t err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   INSERT INTO stko_t
               (stkoent,stkoseq,stko001,stko002,stko003,stko004,stko005,stko006,stko007,stkosite,stkounit,stkodocno)
           SELECT stjoent,stjoseq,stjo001,stjo002,stjo003,stjo004,stjo005,stjo006,stjo007,stjosite,stjounit,p_stemdocno   
             FROM stjo_t
            WHERE stjoent = g_enterprise AND stjo001 = p_stje001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins stko_t err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
