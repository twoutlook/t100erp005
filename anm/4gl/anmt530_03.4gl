#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt530_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-10-11 14:21:22), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000151
#+ Filename...: anmt530_03
#+ Description: 憑證預覽
#+ Creator....: 02114(2014-07-04 17:15:50)
#+ Modifier...: 02481 -SD/PR- 00000
 
{</section>}
 
{<section id="anmt530_03.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
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
PRIVATE TYPE type_g_nmbs_d RECORD
       nmbsld LIKE type_t.chr5, 
   nmbsdocno LIKE type_t.chr20, 
   glaqseq LIKE type_t.num10, 
   glaq001 LIKE type_t.chr500, 
   glaq002 LIKE type_t.chr500, 
   lc_subject LIKE type_t.chr500, 
   glaq003 LIKE type_t.num20_6, 
   glaq004 LIKE type_t.num20_6, 
   glaq040 LIKE type_t.num20_6, 
   glaq041 LIKE type_t.num20_6, 
   glaq043 LIKE type_t.num20_6, 
   glaq044 LIKE type_t.num20_6, 
   seq LIKE type_t.chr500, 
   seq2 LIKE type_t.chr500, 
   text LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_nmbsld         LIKE nmbs_t.nmbsld
DEFINE g_nmbsdocno      LIKE nmbs_t.nmbsdocno
DEFINE g_nmbs003        LIKE nmbs_t.nmbs003
DEFINE g_nmbsstus       LIKE nmbs_t.nmbsstus
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmbs_d          DYNAMIC ARRAY OF type_g_nmbs_d #單身變數
DEFINE g_nmbs_d_t        type_g_nmbs_d                  #單身備份
DEFINE g_nmbs_d_o        type_g_nmbs_d                  #單身備份
DEFINE g_nmbs_d_mask_o   DYNAMIC ARRAY OF type_g_nmbs_d #單身變數
DEFINE g_nmbs_d_mask_n   DYNAMIC ARRAY OF type_g_nmbs_d #單身變數
 
      
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
 
{<section id="anmt530_03.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION anmt530_03(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_nmbsld,p_nmbsdocno,p_nmbs003,p_nmbsstus
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_nmbsld         LIKE nmbs_t.nmbsld
   DEFINE p_nmbsdocno      LIKE nmbs_t.nmbsdocno
   DEFINE p_nmbs003        LIKE nmbs_t.nmbs003
   DEFINE p_nmbsstus       LIKE nmbs_t.nmbsstus
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_nmbsdocno = p_nmbsdocno
   LET g_nmbs003   = p_nmbs003
   LET g_nmbsld    = p_nmbsld
   LET g_nmbsstus  = p_nmbsstus
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmbsld,nmbsdocno FROM nmbs_t WHERE nmbsent=? AND nmbsld=? AND nmbsdocno=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt530_03_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt530_03 WITH FORM cl_ap_formpath("anm","anmt530_03")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL anmt530_03_init()   
 
   #進入選單 Menu (="N")
   CALL anmt530_03_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_anmt530_03
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ''
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt530_03.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmt530_03_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glaq051','6013')  #經營方式
   #end add-point
   
   CALL anmt530_03_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmt530_03_ui_dialog()
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
         CALL g_nmbs_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL anmt530_03_init()
      END IF
   
      CALL anmt530_03_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmbs_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL anmt530_03_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   IF l_ac > 0 THEN
      CALL anmt530_03_b_detail()
   END IF    
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
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL anmt530_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmt530_03_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL anmt530_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmt530_03_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
               CALL anmt530_03_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
 
 
 
 
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
         ON ACTION insert
            LET g_action_choice="insert"
               CALL anmt530_03_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL anmt530_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmt530_03_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
               
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmbs_d)
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
            CALL anmt530_03_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt530_03_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt530_03_set_pk_array()
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
 
{<section id="anmt530_03.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt530_03_query()
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
   CALL g_nmbs_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON nmbsld,nmbsdocno,glaqseq,glaq001,glaq002,lc_subject,glaq003,glaq004,glaq040, 
          glaq041,glaq043,glaq044,seq2,text 
 
         FROM s_detail1[1].nmbsld,s_detail1[1].nmbsdocno,s_detail1[1].glaqseq,s_detail1[1].glaq001,s_detail1[1].glaq002, 
             s_detail1[1].lc_subject,s_detail1[1].glaq003,s_detail1[1].glaq004,s_detail1[1].glaq040, 
             s_detail1[1].glaq041,s_detail1[1].glaq043,s_detail1[1].glaq044,s_detail1[1].seq2,s_detail1[1].text  
 
      
         
      
                  #Ctrlp:construct.c.page1.nmbsld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsld
            #add-point:ON ACTION controlp INFIELD nmbsld name="construct.c.page1.nmbsld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbsld  #顯示到畫面上
            NEXT FIELD nmbsld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsld
            #add-point:BEFORE FIELD nmbsld name="query.b.page1.nmbsld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsld
            
            #add-point:AFTER FIELD nmbsld name="query.a.page1.nmbsld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocno
            #add-point:BEFORE FIELD nmbsdocno name="query.b.page1.nmbsdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocno
            
            #add-point:AFTER FIELD nmbsdocno name="query.a.page1.nmbsdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmbsdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocno
            #add-point:ON ACTION controlp INFIELD nmbsdocno name="query.c.page1.nmbsdocno"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="query.b.page1.glaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="query.a.page1.glaq001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="query.c.page1.glaq001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="query.b.page1.glaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="query.a.page1.glaq002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glaq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="query.c.page1.glaq002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="construct.c.page1.lc_subject"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO lc_subject  #顯示到畫面上
            NEXT FIELD lc_subject                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="query.b.page1.lc_subject"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="query.a.page1.lc_subject"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq
            #add-point:BEFORE FIELD seq name="query.b.page1.seq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq
            
            #add-point:AFTER FIELD seq name="query.a.page1.seq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.seq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq
            #add-point:ON ACTION controlp INFIELD seq name="query.c.page1.seq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq2
            #add-point:BEFORE FIELD seq2 name="query.b.page1.seq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq2
            
            #add-point:AFTER FIELD seq2 name="query.a.page1.seq2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.seq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq2
            #add-point:ON ACTION controlp INFIELD seq2 name="query.c.page1.seq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD text
            #add-point:BEFORE FIELD text name="query.b.page1.text"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD text
            
            #add-point:AFTER FIELD text name="query.a.page1.text"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.text
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD text
            #add-point:ON ACTION controlp INFIELD text name="query.c.page1.text"
            
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
    
   CALL anmt530_03_b_fill(g_wc2)
 
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
 
{<section id="anmt530_03.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt530_03_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL anmt530_03_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt530_03_modify()
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
   IF g_nmbsstus = 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00188'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN
   END IF
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmbs_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmbs_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt530_03_b_fill(g_wc2)
            LET g_detail_cnt = g_nmbs_d.getLength()
         
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
            DISPLAY g_nmbs_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_nmbs_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_nmbs_d[l_ac].nmbsld IS NOT NULL
               AND g_nmbs_d[l_ac].nmbsdocno IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmbs_d_t.* = g_nmbs_d[l_ac].*  #BACKUP
               LET g_nmbs_d_o.* = g_nmbs_d[l_ac].*  #BACKUP
               IF NOT anmt530_03_lock_b("nmbs_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt530_03_bcl INTO g_nmbs_d[l_ac].nmbsld,g_nmbs_d[l_ac].nmbsdocno
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmbs_d_t.nmbsld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbs_d_mask_o[l_ac].* =  g_nmbs_d[l_ac].*
                  CALL anmt530_03_nmbs_t_mask()
                  LET g_nmbs_d_mask_n[l_ac].* =  g_nmbs_d[l_ac].*
                  
                  CALL anmt530_03_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL anmt530_03_set_entry_b(l_cmd)
            CALL anmt530_03_set_no_entry_b(l_cmd)
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
            INITIALIZE g_nmbs_d_t.* TO NULL
            INITIALIZE g_nmbs_d_o.* TO NULL
            INITIALIZE g_nmbs_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_nmbs_d_t.* = g_nmbs_d[l_ac].*     #新輸入資料
            LET g_nmbs_d_o.* = g_nmbs_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbs_d[li_reproduce_target].* = g_nmbs_d[li_reproduce].*
 
               LET g_nmbs_d[g_nmbs_d.getLength()].nmbsld = NULL
               LET g_nmbs_d[g_nmbs_d.getLength()].nmbsdocno = NULL
 
            END IF
            
 
            CALL anmt530_03_set_entry_b(l_cmd)
            CALL anmt530_03_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM nmbs_t 
             WHERE nmbsent = g_enterprise AND nmbsld = g_nmbs_d[l_ac].nmbsld
                                       AND nmbsdocno = g_nmbs_d[l_ac].nmbsdocno
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbs_d[g_detail_idx].nmbsld
               LET gs_keys[2] = g_nmbs_d[g_detail_idx].nmbsdocno
               CALL anmt530_03_insert_b('nmbs_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmbs_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt530_03_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (nmbsld = '", g_nmbs_d[l_ac].nmbsld, "' "
                                  ," AND nmbsdocno = '", g_nmbs_d[l_ac].nmbsdocno, "' "
 
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
               
               DELETE FROM nmbs_t
                WHERE nmbsent = g_enterprise AND 
                      nmbsld = g_nmbs_d_t.nmbsld
                      AND nmbsdocno = g_nmbs_d_t.nmbsdocno
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmbs_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL anmt530_03_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_nmbs_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE anmt530_03_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_nmbs_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbs_d_t.nmbsld
               LET gs_keys[2] = g_nmbs_d_t.nmbsdocno
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt530_03_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL anmt530_03_delete_b('nmbs_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmbs_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsld
            
            #add-point:AFTER FIELD nmbsld name="input.a.page1.nmbsld"
            #此段落由子樣板a05產生
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsld
            #add-point:BEFORE FIELD nmbsld name="input.b.page1.nmbsld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsld
            #add-point:ON CHANGE nmbsld name="input.g.page1.nmbsld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocno
            #add-point:BEFORE FIELD nmbsdocno name="input.b.page1.nmbsdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocno
            
            #add-point:AFTER FIELD nmbsdocno name="input.a.page1.nmbsdocno"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsdocno
            #add-point:ON CHANGE nmbsdocno name="input.g.page1.nmbsdocno"
            
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
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="input.b.page1.lc_subject"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="input.a.page1.lc_subject"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lc_subject
            #add-point:ON CHANGE lc_subject name="input.g.page1.lc_subject"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq040
            #add-point:BEFORE FIELD glaq040 name="input.b.page1.glaq040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq040
            
            #add-point:AFTER FIELD glaq040 name="input.a.page1.glaq040"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq044
            #add-point:BEFORE FIELD glaq044 name="input.b.page1.glaq044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq044
            
            #add-point:AFTER FIELD glaq044 name="input.a.page1.glaq044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq044
            #add-point:ON CHANGE glaq044 name="input.g.page1.glaq044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq
            #add-point:BEFORE FIELD seq name="input.b.page1.seq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq
            
            #add-point:AFTER FIELD seq name="input.a.page1.seq"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE seq
            #add-point:ON CHANGE seq name="input.g.page1.seq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq2
            #add-point:BEFORE FIELD seq2 name="input.b.page1.seq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq2
            
            #add-point:AFTER FIELD seq2 name="input.a.page1.seq2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE seq2
            #add-point:ON CHANGE seq2 name="input.g.page1.seq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD text
            #add-point:BEFORE FIELD text name="input.b.page1.text"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD text
            
            #add-point:AFTER FIELD text name="input.a.page1.text"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE text
            #add-point:ON CHANGE text name="input.g.page1.text"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmbsld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsld
            #add-point:ON ACTION controlp INFIELD nmbsld name="input.c.page1.nmbsld"
            #此段落由子樣板a07產生            

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbsdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocno
            #add-point:ON ACTION controlp INFIELD nmbsdocno name="input.c.page1.nmbsdocno"
            
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="input.c.page1.glaq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="input.c.page1.lc_subject"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_d[l_ac].lc_subject             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002_2()                                #呼叫開窗

            LET g_nmbs_d[l_ac].lc_subject = g_qryparam.return1              

            DISPLAY g_nmbs_d[l_ac].lc_subject TO lc_subject              #

            NEXT FIELD lc_subject                          #返回原欄位


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
 
 
         #Ctrlp:input.c.page1.seq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq
            #add-point:ON ACTION controlp INFIELD seq name="input.c.page1.seq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.seq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq2
            #add-point:ON ACTION controlp INFIELD seq2 name="input.c.page1.seq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.text
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD text
            #add-point:ON ACTION controlp INFIELD text name="input.c.page1.text"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE anmt530_03_bcl
               LET INT_FLAG = 0
               LET g_nmbs_d[l_ac].* = g_nmbs_d_t.*
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
               LET g_errparam.extend = g_nmbs_d[l_ac].nmbsld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmbs_d[l_ac].* = g_nmbs_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               UPDATE s_vr_tmp06 SET glaq001 = g_nmbs_d[l_ac].glaq001  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
                WHERE glaqld  = g_nmbs_d[l_ac].nmbsld
                  AND docno   = g_nmbs_d[l_ac].nmbsdocno
                  AND glaq002 = g_nmbs_d[l_ac].glaq002
                  AND seq     = g_nmbs_d[l_ac].seq
                  AND seq2    = g_nmbs_d[l_ac].seq2
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt530_03_nmbs_t_mask_restore('restore_mask_o')
 
               UPDATE nmbs_t SET (nmbsld,nmbsdocno) = (g_nmbs_d[l_ac].nmbsld,g_nmbs_d[l_ac].nmbsdocno) 
 
                WHERE nmbsent = g_enterprise AND
                  nmbsld = g_nmbs_d_t.nmbsld #項次   
                  AND nmbsdocno = g_nmbs_d_t.nmbsdocno  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbs_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbs_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbs_d[g_detail_idx].nmbsld
               LET gs_keys_bak[1] = g_nmbs_d_t.nmbsld
               LET gs_keys[2] = g_nmbs_d[g_detail_idx].nmbsdocno
               LET gs_keys_bak[2] = g_nmbs_d_t.nmbsdocno
               CALL anmt530_03_update_b('nmbs_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_nmbs_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmbs_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt530_03_nmbs_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL anmt530_03_unlock_b("nmbs_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmbs_d[l_ac].* = g_nmbs_d_t.*
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
               LET g_nmbs_d[li_reproduce_target].* = g_nmbs_d[li_reproduce].*
 
               LET g_nmbs_d[li_reproduce_target].nmbsld = NULL
               LET g_nmbs_d[li_reproduce_target].nmbsdocno = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbs_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbs_d.getLength()+1
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
               NEXT FIELD nmbsld
 
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
      IF INT_FLAG OR cl_null(g_nmbs_d[g_detail_idx].nmbsld) THEN
         CALL g_nmbs_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_nmbs_d[g_detail_idx].* = g_nmbs_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE anmt530_03_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt530_03_delete()
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
   FOR li_idx = 1 TO g_nmbs_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT anmt530_03_lock_b("nmbs_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("nmbs_t","") THEN
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
   
   FOR li_idx = 1 TO g_nmbs_d.getLength()
      IF g_nmbs_d[li_idx].nmbsld IS NOT NULL
         AND g_nmbs_d[li_idx].nmbsdocno IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM nmbs_t
          WHERE nmbsent = g_enterprise AND 
                nmbsld = g_nmbs_d[li_idx].nmbsld
                AND nmbsdocno = g_nmbs_d[li_idx].nmbsdocno
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbs_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_nmbs_d_t.nmbsld
               LET gs_keys[2] = g_nmbs_d_t.nmbsdocno
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL anmt530_03_delete_b('nmbs_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt530_03_set_pk_array()
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
   CALL anmt530_03_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt530_03_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_n   LIKE type_t.num5
   DEFINE l_docno   LIKE nmbs_t.nmbsdocno
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   CALL anmt530_03_b_fill_1(p_wc2)
   RETURN
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.nmbsld,t0.nmbsdocno  FROM nmbs_t t0",
               "",
               
               " WHERE t0.nmbsent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("nmbs_t"),
                      " ORDER BY t0.nmbsld,t0.nmbsdocno"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   LET g_sql= " SELECT DISTINCT '',docno,glaqseq,glaq001,glaq002,d,c,glaq040,glaq041,glaq043,glaq044 FROM s_vr_tmp06 ",  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
                 "  WHERE docno = '",g_nmbsdocno,"'",
                 "  ORDER BY seq "
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmbs_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmt530_03_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmt530_03_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmbs_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_nmbs_d[l_ac].nmbsld,g_nmbs_d[l_ac].nmbsdocno
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
      
      CALL anmt530_03_detail_show()      
 
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
   
 
   
   CALL g_nmbs_d.deleteElement(g_nmbs_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_nmbs_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_nmbs_d.getLength() THEN
      LET l_ac = g_nmbs_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmbs_d.getLength()
      LET g_nmbs_d_mask_o[l_ac].* =  g_nmbs_d[l_ac].*
      CALL anmt530_03_nmbs_t_mask()
      LET g_nmbs_d_mask_n[l_ac].* =  g_nmbs_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_nmbs_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE anmt530_03_pb
   
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmt530_03_detail_show()
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
 
{<section id="anmt530_03.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt530_03_set_entry_b(p_cmd)                                                  
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
 
{<section id="anmt530_03.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt530_03_set_no_entry_b(p_cmd)                                               
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
 
{<section id="anmt530_03.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt530_03_default_search()
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
      LET ls_wc = ls_wc, " nmbsld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmbsdocno = '", g_argv[02], "' AND "
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
 
{<section id="anmt530_03.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt530_03_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "nmbs_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'nmbs_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM nmbs_t
          WHERE nmbsent = g_enterprise AND
            nmbsld = ps_keys_bak[1] AND nmbsdocno = ps_keys_bak[2]
         
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
         CALL g_nmbs_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt530_03_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "nmbs_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO nmbs_t
                  (nmbsent,
                   nmbsld,nmbsdocno
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt530_03_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "nmbs_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "nmbs_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE nmbs_t 
         SET (nmbsld,nmbsdocno
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE nmbsent = g_enterprise AND nmbsld = ps_keys_bak[1] AND nmbsdocno = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbs_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbs_t:",SQLERRMESSAGE 
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
 
{<section id="anmt530_03.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt530_03_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL anmt530_03_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "nmbs_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN anmt530_03_bcl USING g_enterprise,
                                       g_nmbs_d[g_detail_idx].nmbsld,g_nmbs_d[g_detail_idx].nmbsdocno 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt530_03_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt530_03_unlock_b(ps_table)
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
      CLOSE anmt530_03_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION anmt530_03_modify_detail_chk(ps_record)
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
         LET ls_return = "nmbsld"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="anmt530_03.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION anmt530_03_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="anmt530_03.mask_functions" >}
&include "erp/anm/anmt530_03_mask.4gl"
 
{</section>}
 
{<section id="anmt530_03.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt530_03_set_pk_array()
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
   LET g_pk_array[1].values = g_nmbs_d[l_ac].nmbsld
   LET g_pk_array[1].column = 'nmbsld'
   LET g_pk_array[2].values = g_nmbs_d[l_ac].nmbsdocno
   LET g_pk_array[2].column = 'nmbsdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt530_03.state_change" >}
   
 
{</section>}
 
{<section id="anmt530_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt530_03.other_function" readonly="Y" >}
# 單身陣列填充
PRIVATE FUNCTION anmt530_03_b_fill_1(p_wc2)
   DEFINE p_wc2    STRING
   #add-point:b_fill段define
   DEFINE l_glaa015        LIKE glaa_t.glaa015
   DEFINE l_glaa016        LIKE glaa_t.glaa016
   DEFINE l_glaa019        LIKE glaa_t.glaa019
   DEFINE l_glaa020        LIKE glaa_t.glaa020
   DEFINE l_str1           STRING
   DEFINE l_str2           STRING
   DEFINE l_str3           STRING
   DEFINE l_str4           STRING
   DEFINE l_msg1           STRING
   DEFINE l_msg2           STRING
   DEFINE l_msg3           STRING
   DEFINE l_msg4           STRING
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前

   SELECT glaa015,glaa016,glaa019,glaa020
     INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_nmbsld
   
   LET l_str1 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str2 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str3 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str4 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str1 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg2 = l_str2 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg3 = l_str1 CLIPPED,l_glaa020 CLIPPED,l_str4
   LET l_msg4 = l_str2 CLIPPED,l_glaa020 CLIPPED,l_str4
      
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

   
   #add-point:b_fill段sql之後
   IF cl_null(g_nmbs003) THEN 
      LET g_sql= " SELECT DISTINCT glaqld,docno,glaqseq,glaq001,glaq002,'',d,c,glaq040,glaq041,glaq043,glaq044,seq,seq2,'' FROM s_vr_tmp06 ",  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
                 "  WHERE docno = '",g_nmbsdocno,"'",
                 "  ORDER BY d desc,c  "
   ELSE
      LET g_sql= " SELECT DISTINCT glaqld,'',glaqseq,glaq001,glaq002,'',glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,seq,seq2,'' FROM glaq_t ",
                 "  WHERE glaqent = '",g_enterprise,"'",
                 "    AND glaqld = '",g_nmbsld,"'",
                 "    AND glaqdocno = '",g_nmbs003,"'",
                 "  ORDER BY d desc,c  "
   END IF
   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmt530_03_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR anmt530_03_pb1
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmbs_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_nmbs_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      IF cl_null(g_nmbs003) THEN 
         LET g_nmbs_d[l_ac].glaqseq = l_ac
      ELSE
         LET g_nmbs_d[l_ac].nmbsdocno = g_nmbsdocno
      END IF
      LET g_nmbs_d[l_ac].lc_subject =  g_nmbs_d[l_ac].glaq002,'\n',anmt530_03_glaq002_desc(g_nmbs_d[l_ac].nmbsld,g_nmbs_d[l_ac].glaq002)
      #end add-point
      
      CALL anmt530_03_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF l_ac > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = "nmbs_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF 
   LET g_error_show = 0
   
 
   
   CALL g_nmbs_d.deleteElement(g_nmbs_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_nmbs_d.getLength()
 
   END FOR
   
   IF g_cnt > g_nmbs_d.getLength() THEN
      LET l_ac = g_nmbs_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_nmbs_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs1
   FREE anmt530_03_pb1
   
END FUNCTION
# 科目欄位顯示
PRIVATE FUNCTION anmt530_03_glaq002_desc(p_glaqld,p_glaq002)
   DEFINE p_glaqld            LIKE glaq_t.glaqld
   DEFINE p_glaq002           LIKE glaq_t.glaq002
   DEFINE l_glaq002_desc      LIKE glacl_t.glacl004
   DEFINE r_glaq002           STRING
   DEFINE l_oogf002_desc      LIKE oofa_t.oofa011
   DEFINE l_glaq    RECORD 
          glaq017   LIKE glaq_t.glaq017,
          glaq018   LIKE glaq_t.glaq018,
          glaq019   LIKE glaq_t.glaq019,
          glaq020   LIKE glaq_t.glaq020,
          glaq021   LIKE glaq_t.glaq021,
          glaq022   LIKE glaq_t.glaq022,
          glaq023   LIKE glaq_t.glaq023,
          glaq024   LIKE glaq_t.glaq024,
          glaq025   LIKE glaq_t.glaq025,
          glaq026   LIKE glaq_t.glaq026,
          glaq027   LIKE glaq_t.glaq027,
          glaq028   LIKE glaq_t.glaq028        
                    END RECORD
   
   SELECT glaq017,glaq018,glaq019,glaq020,
          glaq021,glaq022,glaq023,glaq024,
          glaq025,glaq026,glaq027,glaq028
     INTO l_glaq.*     
     FROM s_vr_tmp06  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
    WHERE glaqent = g_enterprise
      AND glaqld = p_glaqld
      AND glaq002 = p_glaq002      
   
   #抓取科目名称
   LET l_glaq002_desc = ''
   SELECT glacl004 INTO l_glaq002_desc FROM glacl_t,glaa_t
    WHERE glaaent = glaclent 
      AND glaa004 = glacl001
      AND glaclent = g_enterprise
      AND glaald = p_glaqld
      AND glacl002 = p_glaq002
      AND glacl003 = g_dlang  


   #组合名称以及核算项
   LET r_glaq002 = ''
   #部门
   IF NOT cl_null(l_glaq.glaq018) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq018
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_glaq002 = g_rtn_fields[1]     
   END IF 
   #成本利润中心
   IF NOT cl_null(l_glaq.glaq019) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq019
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   
   #区域
   IF NOT cl_null(l_glaq.glaq020) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '287'
      LET g_ref_fields[2] = l_glaq.glaq020
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields  
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #交易客商
   IF NOT cl_null(l_glaq.glaq021) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq021
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1] 
      ELSE
         LET r_glaq002 = g_rtn_fields[1] 
      END IF      
   END IF 
   #帐款客商
   IF NOT cl_null(l_glaq.glaq022) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq022
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #客群
   IF NOT cl_null(l_glaq.glaq023) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '281'
      LET g_ref_fields[2] = l_glaq.glaq023
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   
   #产品分类
   IF NOT cl_null(l_glaq.glaq024) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq024
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #人员
   IF NOT cl_null(l_glaq.glaq025) THEN
      LET  l_oogf002_desc = ''
      SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
       WHERE oofaent = g_enterprise
         AND oofa001 IN (SELECT ooag002 FROM ooag_t
                          WHERE ooagent = g_enterprise
                            AND ooag001 = l_glaq.glaq025)
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_oogf002_desc
      ELSE
         LET r_glaq002 = l_oogf002_desc
      END IF      
   END IF 
   #预算编号
   IF NOT cl_null(l_glaq.glaq026) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq026
      CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #专案编号
   IF NOT cl_null(l_glaq.glaq027) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq027
      ELSE
         LET r_glaq002 = l_glaq.glaq027
      END IF      
   END IF 
   #WBS
   IF NOT cl_null(l_glaq.glaq028) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq028
      ELSE
         LET r_glaq002 = l_glaq.glaq028
      END IF      
   END IF 
   #组合科目名称以及核算项
   LET r_glaq002 = l_glaq002_desc,'\n',
                   r_glaq002
                   
   RETURN r_glaq002 
END FUNCTION

################################################################################
# Descriptions...: 帶出固定核算項和自由核算項
# Memo...........:
# Usage..........: CALL anmt530_03_b_detail()
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_b_detail()
DEFINE l_glaq RECORD 
       glaq017 LIKE glaq_t.glaq017,
       glaq018 LIKE glaq_t.glaq018,
       glaq019 LIKE glaq_t.glaq019,
       glaq020 LIKE glaq_t.glaq020,
       glaq021 LIKE glaq_t.glaq021,
       glaq022 LIKE glaq_t.glaq022,
       glaq023 LIKE glaq_t.glaq023,
       glaq024 LIKE glaq_t.glaq024,
       glaq025 LIKE glaq_t.glaq025,
       glaq026 LIKE glaq_t.glaq026,
       glaq027 LIKE glaq_t.glaq027,
       glaq028 LIKE glaq_t.glaq028,
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
       glaq051 LIKE glaq_t.glaq051,
       glaq052 LIKE glaq_t.glaq052,
       glaq053 LIKE glaq_t.glaq053
END RECORD 
DEFINE l_glaq017_desc LIKE type_t.chr50,
       l_glaq018_desc LIKE type_t.chr50,
       l_glaq019_desc LIKE type_t.chr50,
       l_glaq020_desc LIKE type_t.chr50,
       l_glaq021_desc LIKE type_t.chr50,
       l_glaq022_desc LIKE type_t.chr50,
       l_glaq023_desc LIKE type_t.chr50,  
       l_glaq024_desc LIKE type_t.chr50,
       l_glaq025_desc LIKE type_t.chr50, 
       l_glaq026_desc LIKE type_t.chr50,
       l_glaq052_desc LIKE type_t.chr50,
       l_glaq053_desc LIKE type_t.chr50,
       l_glaq029_desc LIKE type_t.chr50, 
       l_glaq030_desc LIKE type_t.chr50,
       l_glaq031_desc LIKE type_t.chr50,
       l_glaq032_desc LIKE type_t.chr50,
       l_glaq033_desc LIKE type_t.chr50,
       l_glaq034_desc LIKE type_t.chr50,
       l_glaq035_desc LIKE type_t.chr50,
       l_glaq036_desc LIKE type_t.chr50,
       l_glaq037_desc LIKE type_t.chr50,   
       l_glaq038_desc LIKE type_t.chr50    

#是否做自由科目核算项管理
   DEFINE l_glad017       LIKE glad_t.glad017
   DEFINE l_glad0171       LIKE glad_t.glad0171
   DEFINE l_glad0172       LIKE glad_t.glad0172
   DEFINE l_glad018       LIKE glad_t.glad018
   DEFINE l_glad0181       LIKE glad_t.glad0181
   DEFINE l_glad0182       LIKE glad_t.glad0182
   DEFINE l_glad019       LIKE glad_t.glad019
   DEFINE l_glad0191       LIKE glad_t.glad0191
   DEFINE l_glad0192       LIKE glad_t.glad0192
   DEFINE l_glad020       LIKE glad_t.glad020
   DEFINE l_glad0201       LIKE glad_t.glad0201
   DEFINE l_glad0202       LIKE glad_t.glad0202
   DEFINE l_glad021       LIKE glad_t.glad021
   DEFINE l_glad0211       LIKE glad_t.glad0211
   DEFINE l_glad0212       LIKE glad_t.glad0212
   DEFINE l_glad022       LIKE glad_t.glad022
   DEFINE l_glad0221       LIKE glad_t.glad0221
   DEFINE l_glad0222       LIKE glad_t.glad0222
   DEFINE l_glad023       LIKE glad_t.glad023
   DEFINE l_glad0231       LIKE glad_t.glad0231
   DEFINE l_glad0232       LIKE glad_t.glad0232
   DEFINE l_glad024       LIKE glad_t.glad024
   DEFINE l_glad0241       LIKE glad_t.glad0241
   DEFINE l_glad0242       LIKE glad_t.glad0242
   DEFINE l_glad025       LIKE glad_t.glad025
   DEFINE l_glad0251       LIKE glad_t.glad0251
   DEFINE l_glad0252       LIKE glad_t.glad0252
   DEFINE l_glad026       LIKE glad_t.glad026
   DEFINE l_glad0261       LIKE glad_t.glad0261
   DEFINE l_glad0262       LIKE glad_t.glad0262
   
INITIALIZE l_glaq.* TO NULL

 SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
        glaq023,glaq024,glaq025,glaq026,glaq027,glaq028,
        glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,
        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053
        INTO l_glaq.*
#SELECT glaq017 INTO l_glaq.glaq017
   FROM s_vr_tmp06  #160727-00019#38   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_nm_tmp ——> s_vr_tmp06
    WHERE glaqent = g_enterprise
       AND glaqld = g_nmbsld
       AND docno = g_nmbsdocno
       AND seq = g_nmbs_d[g_detail_idx].seq
       AND seq2 = g_nmbs_d[g_detail_idx].seq2 

CALL anmt530_03_ooef001_desc(l_glaq.glaq017) RETURNING l_glaq017_desc
CALL anmt530_03_ooef001_desc(l_glaq.glaq018) RETURNING l_glaq018_desc
CALL anmt530_03_ooef001_desc(l_glaq.glaq019) RETURNING l_glaq019_desc
CALL anmt530_03_glaq020_desc('287',l_glaq.glaq020) RETURNING l_glaq020_desc
CALL anmt530_03_glaq020_desc('281',l_glaq.glaq023) RETURNING l_glaq023_desc
CALL anmt530_03_glaq021_desc(l_glaq.glaq021) RETURNING l_glaq021_desc
CALL anmt530_03_glaq021_desc(l_glaq.glaq022) RETURNING l_glaq022_desc
CALL anmt530_03_glaq024_desc(l_glaq.glaq024) RETURNING l_glaq024_desc
CALL anmt530_03_glaq025_desc(l_glaq.glaq025) RETURNING l_glaq025_desc
CALL anmt530_03_glaq026_desc(l_glaq.glaq026) RETURNING l_glaq026_desc

CALL s_desc_get_oojdl003_desc(l_glaq.glaq052) RETURNING l_glaq052_desc
CALL anmt530_03_glaq053_desc(l_glaq.glaq053) RETURNING l_glaq053_desc


#自由核算項
#总体说明：若启用该核算项管理则对应控制方式为2.必须输入不检查，3.必须输入必检查，则栏位不可空白，为1时可以空白，否则栏位>
   SELECT glad017,glad0171,glad0172,glad018,glad0181,glad0182,
          glad019,glad0191,glad0192,glad020,glad0201,glad0202,
          glad021,glad0211,glad0212,glad022,glad0221,glad0222,
          glad023,glad0231,glad0232,glad024,glad0221,glad0242,
          glad025,glad0251,glad0252,glad026,glad0261,glad0262
    INTO  l_glad017,l_glad0171,l_glad0172,l_glad018,l_glad0181,l_glad0182,
          l_glad019,l_glad0191,l_glad0192,l_glad020,l_glad0201,l_glad0202,
          l_glad021,l_glad0211,l_glad0212,l_glad022,l_glad0221,l_glad0222,
          l_glad023,l_glad0231,l_glad0232,l_glad024,l_glad0241,l_glad0242,
          l_glad025,l_glad0251,l_glad0252,l_glad026,l_glad0261,l_glad0262
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld = g_nmbsld
      AND glad001 = g_nmbs_d[g_detail_idx].glaq002

   CALL anmt530_03_glaq029_desc(l_glad0171,l_glaq.glaq029) RETURNING l_glaq029_desc  #核算項一
   CALL anmt530_03_glaq029_desc(l_glad0181,l_glaq.glaq030) RETURNING l_glaq030_desc #核算項二
   CALL anmt530_03_glaq029_desc(l_glad0191,l_glaq.glaq031) RETURNING l_glaq031_desc #核算項三
   CALL anmt530_03_glaq029_desc(l_glad0201,l_glaq.glaq032) RETURNING l_glaq032_desc #核算項四
   CALL anmt530_03_glaq029_desc(l_glad0211,l_glaq.glaq033) RETURNING l_glaq033_desc #核算項五
   CALL anmt530_03_glaq029_desc(l_glad0221,l_glaq.glaq034) RETURNING l_glaq034_desc #核算項六
   CALL anmt530_03_glaq029_desc(l_glad0231,l_glaq.glaq035) RETURNING l_glaq035_desc #核算項七
   CALL anmt530_03_glaq029_desc(l_glad0241,l_glaq.glaq036) RETURNING l_glaq036_desc  #核算項八
   CALL anmt530_03_glaq029_desc(l_glad0251,l_glaq.glaq037) RETURNING l_glaq037_desc #核算項九
   CALL anmt530_03_glaq029_desc(l_glad0261,l_glaq.glaq038) RETURNING l_glaq038_desc #核算項十
   

   DISPLAY l_glaq.glaq017 TO glaq017
   DISPLAY l_glaq.glaq018 TO glaq018
   DISPLAY l_glaq.glaq019 TO glaq019
   DISPLAY l_glaq.glaq020 TO glaq020
   DISPLAY l_glaq.glaq021 TO glaq021
   DISPLAY l_glaq.glaq022 TO glaq022
   DISPLAY l_glaq.glaq023 TO glaq023
   DISPLAY l_glaq.glaq024 TO glaq024
   DISPLAY l_glaq.glaq025 TO glaq025
   DISPLAY l_glaq.glaq026 TO glaq026
   DISPLAY l_glaq.glaq027 TO glaq027
   DISPLAY l_glaq.glaq028 TO glaq028
   DISPLAY l_glaq.glaq029 TO glaq029
   DISPLAY l_glaq.glaq030 TO glaq030
   DISPLAY l_glaq.glaq031 TO glaq031
   DISPLAY l_glaq.glaq032 TO glaq032
   DISPLAY l_glaq.glaq033 TO glaq033
   DISPLAY l_glaq.glaq034 TO glaq034
   DISPLAY l_glaq.glaq035 TO glaq035
   DISPLAY l_glaq.glaq036 TO glaq036
   DISPLAY l_glaq.glaq037 TO glaq037
   DISPLAY l_glaq.glaq038 TO glaq038
   DISPLAY l_glaq.glaq051 TO glaq051
   DISPLAY l_glaq.glaq052 TO glaq052
   DISPLAY l_glaq.glaq053 TO glaq053
   DISPLAY l_glaq017_desc TO glaq017_desc
   DISPLAY l_glaq018_desc TO glaq018_desc
   DISPLAY l_glaq019_desc TO glaq019_desc
   DISPLAY l_glaq020_desc TO glaq020_desc
   DISPLAY l_glaq021_desc TO glaq021_desc
   DISPLAY l_glaq022_desc TO glaq022_desc
   DISPLAY l_glaq023_desc TO glaq023_desc
   DISPLAY l_glaq024_desc TO glaq024_desc
   DISPLAY l_glaq025_desc TO glaq025_desc
   DISPLAY l_glaq026_desc TO glaq026_desc
   DISPLAY l_glaq029_desc TO glaq029_desc
   DISPLAY l_glaq030_desc TO glaq030_desc
   DISPLAY l_glaq031_desc TO glaq031_desc
   DISPLAY l_glaq032_desc TO glaq032_desc
   DISPLAY l_glaq033_desc TO glaq033_desc
   DISPLAY l_glaq034_desc TO glaq034_desc
   DISPLAY l_glaq035_desc TO glaq035_desc
   DISPLAY l_glaq036_desc TO glaq036_desc
   DISPLAY l_glaq037_desc TO glaq037_desc
   DISPLAY l_glaq038_desc TO glaq038_desc
   DISPLAY l_glaq052_desc TO glaq052_desc
   DISPLAY l_glaq053_desc TO glaq053_desc
END FUNCTION

################################################################################
# Descriptions...: #+ 營運據點/部門/利潤成本中心
# Memo...........:
# Usage..........: CALL anmt530_03_ooef001_desc(p_ooef001)


# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_ooef001_desc(p_ooef001)
   DEFINE p_ooef001     LIKE ooef_t.ooef001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 區域/客戶群帶值
# Memo...........:
# Usage..........: CALL  anmt530_03_glaq020_desc(p_oocql001,p_oocql002)
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_glaq020_desc(p_oocql001,p_oocql002)
DEFINE p_oocql001     LIKE oocql_t.oocql001
    DEFINE p_oocql002     LIKE oocql_t.oocql002

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_oocql001
    LET g_ref_fields[2] = p_oocql002
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...:客商說明
# Memo...........:
# Usage..........: CALL anmt530_03_glaq021_desc(p_glaq021)
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_glaq021_desc(p_glaq021)
  DEFINE p_glaq021    LIKE pmaa_t.pmaa001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq021
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 產品分類說明
# Memo...........:
# Usage..........: CALL anmt530_03_glaq024_desc(p_glaq024)
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_glaq024_desc(p_glaq024)
   DEFINE p_glaq024   LIKE glaq_t.glaq024

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaq024
    CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 人員說明
# Memo...........:
# Usage..........: CALL anmt530_03_glaq025_desc(p_glaq025)
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_glaq025_desc(p_glaq025)
 DEFINE l_oogf002_desc        LIKE oofa_t.oofa011
    DEFINE p_glaq025             LIKE glaq_t.glaq025

    LET  l_oogf002_desc = ''
    SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
     WHERE oofaent = g_enterprise
       AND oofa001 IN (SELECT ooag002 FROM ooag_t
                        WHERE ooagent = g_enterprise
                          AND ooag001 = p_glaq025)
     RETURN l_oogf002_desc
END FUNCTION

################################################################################
# Descriptions...: 預算編號说明
# Memo...........:
# Usage..........: CALL anmt530_03_glaq026_desc(p_glaq026)
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_glaq026_desc(p_glaq026)
    DEFINE p_glaq026      LIKE glaq_t.glaq026

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaq026
    CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...:品牌說明
# Memo...........:
# Usage..........: CALL anmt530_03_glaq053_desc(p_glaq053)
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_glaq053_desc(p_glaq053)
DEFINE p_glaq053 LIKE glaq_t.glaq053

INITIALIZE g_ref_fields TO NULL
 LET g_ref_fields[1] = p_glaq053
 CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
 RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 核算項說明
# Memo...........:
# Usage..........: CALL anmt530_03_make_sql_desc(p_glae001)
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_make_sql_desc(p_glae001)
 DEFINE p_glae001   LIKE glae_t.glae001   #核算项类型
    #DEFINE p_field_value   LIKE glaf_t.glaf002   #核算项值
    DEFINE r_sql       STRING
    DEFINE l_glae003   LIKE glae_t.glae003   #来源档案
    DEFINE l_glae004   LIKE glae_t.glae004   #来源编号栏位
    DEFINE l_glae005   LIKE glae_t.glae005   #来源说明档案
    DEFINE l_glae006   LIKE glae_t.glae006   #来源说明栏位
    DEFINE l_dzeb002   LIKE dzeb_t.dzeb002   #栏位代号
    DEFINE l_dzeb006   LIKE dzeb_t.dzeb002   #栏位属性
    DEFINE l_sql     STRING
    DEFINE li_sql1   STRING    #抓主档表的key
    DEFINE li_sql2   STRING    #抓对应多语言表的key
    #抓取主表的key放入数组
    DEFINE li_main    DYNAMIC ARRAY OF RECORD
           dzeb002    LIKE dzeb_t.dzeb002
    END RECORD
    #抓取多语言表的key放入数组
    DEFINE li_dlang    DYNAMIC ARRAY OF RECORD
           dzeb002    LIKE dzeb_t.dzeb002
    END RECORD
    DEFINE l_where   STRING    #组出的对应的抓取说明的where条件
    DEFINE l_i,l_i2,l_i3       LIKE type_t.num5

    #初始化
    CALL li_main.clear()
    CALL li_dlang.clear()

   #抓取来源档案，来源说明档案，来源说明栏位
    SELECT glae003,glae004,glae005,glae006 INTO l_glae003,l_glae004,l_glae005,l_glae006 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = p_glae001

   #抓取主档key
   LET l_i = 1
   LET li_sql1 = " SELECT dzeb002 FROM dzeb_t ",
                 "  WHERE dzeb001 = '",l_glae003,"'",
                 "    AND dzeb004 = 'Y'",
                 "  ORDER BY dzeb021 "
   PREPARE anmt530_03_pr FROM li_sql1
   DECLARE anmt530_03_cs CURSOR FOR anmt530_03_pr
   FOREACH anmt530_03_cs INTO li_main[l_i].dzeb002
       LET l_i = l_i +1
   END FOREACH
   #真实数组长度
   LET l_i = l_i -1

   #抓取多语言档key
   LET l_i2 = 1
   LET li_sql2 = " SELECT dzeb002 FROM dzeb_t ",
                 " WHERE dzeb001 = '",l_glae005,"'" ,
                  "  AND dzeb004 = 'Y'",
                 " ORDER BY dzeb021 "
   PREPARE anmt530_03_pr2 FROM li_sql2
   DECLARE anmt530_03_cs2 CURSOR FOR anmt530_03_pr2
   FOREACH anmt530_03_cs2 INTO li_dlang[l_i2].dzeb002
       LET l_i2 = l_i2 +1
   END FOREACH
   #真实数组长度
   LET l_i2 = l_i2 -1


   #组合where条件
   LET l_where = '1=1'
   FOR  l_i3 = 1 TO  l_i
       LET l_where = l_where," AND ", li_main[l_i3].dzeb002, " = " ,li_dlang[l_i3].dzeb002
   END FOR

   #组出的基础sql
   LET r_sql = " SELECT ", l_glae006 ," FROM ",l_glae005 ,',',l_glae003,
               " WHERE " , l_glae004," = ?",
               "   AND " ,l_where
   #组sql
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '",l_glae005,"'",
               "   AND dzeb004 = 'Y'"
   PREPARE anmt530_03_make_sql_pre1 FROM l_sql
   DECLARE anmt530_03_make_sql_cs1 CURSOR FOR anmt530_03_make_sql_pre1
   FOREACH anmt530_03_make_sql_cs1 INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF

      IF l_dzeb006 = 'C800' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_dlang,"' "
      END IF

   END FOREACH
   RETURN r_sql
END FUNCTION

################################################################################
# Descriptions...: 自由核算說明
# Memo...........:
# Usage..........: CALL anmt530_03_glaq029_desc(p_glae001,p_glaq029)
#                  RETURNING 回传参数

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_03_glaq029_desc(p_glae001,p_glaq029)
DEFINE p_glae001 LIKE glae_t.glae001
DEFINE p_glaq029 LIKE glaq_t.glaq029
DEFINE l_glae002 LIKE glae_t.glae002     #资料来源
DEFINE l_sql     STRING                  #组的抓取资料的sql


   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = p_glae001
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =p_glae001
      LET g_ref_fields[2] =p_glaq029
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      RETURN g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_glaq029
      CALL anmt530_03_make_sql_desc(p_glae001) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      RETURN g_rtn_fields[1]
   END IF

END FUNCTION

 
{</section>}
 
