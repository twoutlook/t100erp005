#該程式未解開Section, 採用最新樣板產出!
{<section id="afat502_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-12-02 09:59:48), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000143
#+ Filename...: afat502_01
#+ Description: 憑證預覽
#+ Creator....: 01531(2014-09-15 15:13:25)
#+ Modifier...: 01727 -SD/PR- 00000
 
{</section>}
 
{<section id="afat502_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#12   2016/04/26 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
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
PRIVATE TYPE type_g_fabh_d RECORD
       fabhdocno LIKE fabh_t.fabhdocno, 
   fabhld LIKE fabh_t.fabhld, 
   fabhseq LIKE fabh_t.fabhseq, 
   fabh036 LIKE fabh_t.fabh036, 
   fabh021 LIKE fabh_t.fabh021, 
   fabh019 LIKE fabh_t.fabh019, 
   lbl_fabh019 LIKE type_t.num20_6, 
   fabh110 LIKE fabh_t.fabh110, 
   lbl_fabh110 LIKE type_t.num20_6, 
   fabh160 LIKE fabh_t.fabh160, 
   lbl_fabh160 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fabgdocno          LIKE fabg_t.fabgdocno   #异动单号
DEFINE g_fabhld             LIKE fabh_t.fabhld      #帐套 
DEFINE g_fabhseq            LIKE fabh_t.fabhseq     #项次
DEFINE g_fabh018            LIKE fabh_t.fabh018     #异动类型
type type_g_detail_m        RECORD
        fabh026 LIKE fabh_t.fabh026, 
        fabh026_desc LIKE type_t.chr80, 
        fabh027 LIKE fabh_t.fabh027,
        fabh027_desc LIKE type_t.chr80,
        fabh028 LIKE fabh_t.fabh028,
        fabh028_desc LIKE type_t.chr80, 
        fabh029 LIKE fabh_t.fabh029, 
        fabh029_desc LIKE type_t.chr80, 
        fabh030 LIKE fabh_t.fabh026,
        fabh030_desc LIKE type_t.chr80, 
        fabh031 LIKE fabh_t.fabh026, 
        fabh031_desc LIKE type_t.chr80, 
        fabh032 LIKE fabh_t.fabh026,
        fabh032_desc LIKE type_t.chr80, 
        fabh033 LIKE fabh_t.fabh026, 
        fabh033_desc LIKE type_t.chr80, 
        fabh034 LIKE fabh_t.fabh026,
        fabh034_desc LIKE type_t.chr80,
        fabh035 LIKE fabh_t.fabh026,
        fabh035_desc LIKE type_t.chr80
        END RECORD
DEFINE g_detail_m          type_g_detail_m


 TYPE type_g_fabh_d1 RECORD
       fabhdocno LIKE fabh_t.fabhdocno, 
   fabhld LIKE fabh_t.fabhld, 
   fabhseq LIKE fabh_t.fabhseq, 
   fabh036 LIKE fabh_t.fabh036, 
   fabh021 LIKE fabh_t.fabh021, 
   fabh019 LIKE fabh_t.fabh019, 
   lbl_fabh019 LIKE type_t.num20_6, 
   fabh110 LIKE fabh_t.fabh110, 
   lbl_fabh110 LIKE type_t.num20_6, 
   fabh160 LIKE fabh_t.fabh160, 
   lbl_fabh160 LIKE type_t.num20_6
       END RECORD
DEFINE g_fabh_d1          DYNAMIC ARRAY OF type_g_fabh_d #單身變數
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fabh_d          DYNAMIC ARRAY OF type_g_fabh_d #單身變數
DEFINE g_fabh_d_t        type_g_fabh_d                  #單身備份
DEFINE g_fabh_d_o        type_g_fabh_d                  #單身備份
DEFINE g_fabh_d_mask_o   DYNAMIC ARRAY OF type_g_fabh_d #單身變數
DEFINE g_fabh_d_mask_n   DYNAMIC ARRAY OF type_g_fabh_d #單身變數
 
      
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
 
{<section id="afat502_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION afat502_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_fabgdocno,p_fabhld,p_fabhseq,p_fabh018
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_fabgdocno          LIKE fabg_t.fabgdocno   #异动单号
   DEFINE p_fabhld             LIKE fabh_t.fabhld      #帐套 
   DEFINE p_fabhseq            LIKE fabh_t.fabhseq     #项次
   DEFINE p_fabh018            LIKE fabh_t.fabh018     #异动类型
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_fabgdocno=p_fabgdocno
   LET g_fabhld=p_fabhld
   LET g_fabhseq=p_fabhseq
   LET g_fabh018=p_fabh018
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fabhdocno,fabhld,fabhseq,fabh036,fabh021,fabh019,fabh110,fabh160 FROM  
       fabh_t WHERE fabhent=? AND fabhld=? AND fabhdocno=? AND fabhseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat502_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat502_01 WITH FORM cl_ap_formpath("afa","afat502_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL afat502_01_init()   
 
   #進入選單 Menu (="N")
   CALL afat502_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_afat502_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat502_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afat502_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   DROP TABLE fabh_temp_t;
   CREATE TEMP TABLE fabh_temp_t(
   fabhdocno       VARCHAR(20), 
   fabhld          VARCHAR(5), 
   fabhseq         INTEGER, 
   fabh036         VARCHAR(40), 
   fabh021         VARCHAR(24), 
   fabh019         DECIMAL(20,6), 
   lbl_fabh019     DECIMAL(20,6), 
   fabh110         DECIMAL(20,6), 
   lbl_fabh110     DECIMAL(20,6), 
   fabh160         DECIMAL(20,6), 
   lbl_fabh160     DECIMAL(20,6),
   fabhent         SMALLINT,
   fabhseq1        INTEGER
   
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   #CALL cl_set_act_visible('insert,delete,query,modify,modify_detail',FALSE)
   #end add-point
   
   CALL afat502_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afat502_01_ui_dialog()
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
         CALL g_fabh_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL afat502_01_init()
      END IF
   
      CALL afat502_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_fabh_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               CALL afat502_01_b_detail()
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL afat502_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL afat502_01_b_detail()
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
            CALL afat502_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afat502_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL afat502_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afat502_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL afat502_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afat502_01_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat502_01_insert()
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
               CALL afat502_01_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_fabh_d)
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
            CALL afat502_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat502_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat502_01_set_pk_array()
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
 
{<section id="afat502_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat502_01_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
    RETURN
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_fabh_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON fabhdocno,fabhld,fabhseq,fabh036,fabh021,fabh019,lbl_fabh019,fabh110,lbl_fabh110, 
          fabh160,lbl_fabh160 
 
         FROM s_detail1[1].fabhdocno,s_detail1[1].fabhld,s_detail1[1].fabhseq,s_detail1[1].fabh036,s_detail1[1].fabh021, 
             s_detail1[1].fabh019,s_detail1[1].lbl_fabh019,s_detail1[1].fabh110,s_detail1[1].lbl_fabh110, 
             s_detail1[1].fabh160,s_detail1[1].lbl_fabh160 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhdocno
            #add-point:BEFORE FIELD fabhdocno name="query.b.page1.fabhdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhdocno
            
            #add-point:AFTER FIELD fabhdocno name="query.a.page1.fabhdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabhdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhdocno
            #add-point:ON ACTION controlp INFIELD fabhdocno name="query.c.page1.fabhdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhld
            #add-point:BEFORE FIELD fabhld name="query.b.page1.fabhld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhld
            
            #add-point:AFTER FIELD fabhld name="query.a.page1.fabhld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabhld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhld
            #add-point:ON ACTION controlp INFIELD fabhld name="query.c.page1.fabhld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhseq
            #add-point:BEFORE FIELD fabhseq name="query.b.page1.fabhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhseq
            
            #add-point:AFTER FIELD fabhseq name="query.a.page1.fabhseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhseq
            #add-point:ON ACTION controlp INFIELD fabhseq name="query.c.page1.fabhseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh036
            #add-point:BEFORE FIELD fabh036 name="query.b.page1.fabh036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh036
            
            #add-point:AFTER FIELD fabh036 name="query.a.page1.fabh036"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabh036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh036
            #add-point:ON ACTION controlp INFIELD fabh036 name="query.c.page1.fabh036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabh021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh021
            #add-point:ON ACTION controlp INFIELD fabh021 name="construct.c.page1.fabh021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabh021  #顯示到畫面上
            NEXT FIELD fabh021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh021
            #add-point:BEFORE FIELD fabh021 name="query.b.page1.fabh021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh021
            
            #add-point:AFTER FIELD fabh021 name="query.a.page1.fabh021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh019
            #add-point:BEFORE FIELD fabh019 name="query.b.page1.fabh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh019
            
            #add-point:AFTER FIELD fabh019 name="query.a.page1.fabh019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh019
            #add-point:ON ACTION controlp INFIELD fabh019 name="query.c.page1.fabh019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fabh019
            #add-point:BEFORE FIELD lbl_fabh019 name="query.b.page1.lbl_fabh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fabh019
            
            #add-point:AFTER FIELD lbl_fabh019 name="query.a.page1.lbl_fabh019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.lbl_fabh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fabh019
            #add-point:ON ACTION controlp INFIELD lbl_fabh019 name="query.c.page1.lbl_fabh019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh110
            #add-point:BEFORE FIELD fabh110 name="query.b.page1.fabh110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh110
            
            #add-point:AFTER FIELD fabh110 name="query.a.page1.fabh110"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabh110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh110
            #add-point:ON ACTION controlp INFIELD fabh110 name="query.c.page1.fabh110"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fabh110
            #add-point:BEFORE FIELD lbl_fabh110 name="query.b.page1.lbl_fabh110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fabh110
            
            #add-point:AFTER FIELD lbl_fabh110 name="query.a.page1.lbl_fabh110"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.lbl_fabh110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fabh110
            #add-point:ON ACTION controlp INFIELD lbl_fabh110 name="query.c.page1.lbl_fabh110"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh160
            #add-point:BEFORE FIELD fabh160 name="query.b.page1.fabh160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh160
            
            #add-point:AFTER FIELD fabh160 name="query.a.page1.fabh160"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fabh160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh160
            #add-point:ON ACTION controlp INFIELD fabh160 name="query.c.page1.fabh160"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fabh160
            #add-point:BEFORE FIELD lbl_fabh160 name="query.b.page1.lbl_fabh160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fabh160
            
            #add-point:AFTER FIELD lbl_fabh160 name="query.a.page1.lbl_fabh160"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.lbl_fabh160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fabh160
            #add-point:ON ACTION controlp INFIELD lbl_fabh160 name="query.c.page1.lbl_fabh160"
            
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
    
   CALL afat502_01_b_fill(g_wc2)
 
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
 
{<section id="afat502_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat502_01_insert()
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
   CALL afat502_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat502_01_modify()
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
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004  #BYXZG20151202
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
      INPUT ARRAY g_fabh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat502_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fabh_d.getLength()
         
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
            DISPLAY g_fabh_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_fabh_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fabh_d[l_ac].fabhld IS NOT NULL
               AND g_fabh_d[l_ac].fabhdocno IS NOT NULL
               AND g_fabh_d[l_ac].fabhseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabh_d_t.* = g_fabh_d[l_ac].*  #BACKUP
               LET g_fabh_d_o.* = g_fabh_d[l_ac].*  #BACKUP
               IF NOT afat502_01_lock_b("fabh_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat502_01_bcl INTO g_fabh_d[l_ac].fabhdocno,g_fabh_d[l_ac].fabhld,g_fabh_d[l_ac].fabhseq, 
                      g_fabh_d[l_ac].fabh036,g_fabh_d[l_ac].fabh021,g_fabh_d[l_ac].fabh019,g_fabh_d[l_ac].fabh110, 
                      g_fabh_d[l_ac].fabh160
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabh_d_t.fabhld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabh_d_mask_o[l_ac].* =  g_fabh_d[l_ac].*
                  CALL afat502_01_fabh_t_mask()
                  LET g_fabh_d_mask_n[l_ac].* =  g_fabh_d[l_ac].*
                  
                  CALL afat502_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afat502_01_set_entry_b(l_cmd)
            CALL afat502_01_set_no_entry_b(l_cmd)
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
            INITIALIZE g_fabh_d_t.* TO NULL
            INITIALIZE g_fabh_d_o.* TO NULL
            INITIALIZE g_fabh_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_fabh_d_t.* = g_fabh_d[l_ac].*     #新輸入資料
            LET g_fabh_d_o.* = g_fabh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabh_d[li_reproduce_target].* = g_fabh_d[li_reproduce].*
 
               LET g_fabh_d[g_fabh_d.getLength()].fabhld = NULL
               LET g_fabh_d[g_fabh_d.getLength()].fabhdocno = NULL
               LET g_fabh_d[g_fabh_d.getLength()].fabhseq = NULL
 
            END IF
            
 
            CALL afat502_01_set_entry_b(l_cmd)
            CALL afat502_01_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM fabh_t 
             WHERE fabhent = g_enterprise AND fabhld = g_fabh_d[l_ac].fabhld
                                       AND fabhdocno = g_fabh_d[l_ac].fabhdocno
                                       AND fabhseq = g_fabh_d[l_ac].fabhseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabh_d[g_detail_idx].fabhld
               LET gs_keys[2] = g_fabh_d[g_detail_idx].fabhdocno
               LET gs_keys[3] = g_fabh_d[g_detail_idx].fabhseq
               CALL afat502_01_insert_b('fabh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabh_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat502_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (fabhld = '", g_fabh_d[l_ac].fabhld, "' "
                                  ," AND fabhdocno = '", g_fabh_d[l_ac].fabhdocno, "' "
                                  ," AND fabhseq = '", g_fabh_d[l_ac].fabhseq, "' "
 
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
               
               DELETE FROM fabh_t
                WHERE fabhent = g_enterprise AND 
                      fabhld = g_fabh_d_t.fabhld
                      AND fabhdocno = g_fabh_d_t.fabhdocno
                      AND fabhseq = g_fabh_d_t.fabhseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL afat502_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_fabh_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE afat502_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_fabh_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabh_d_t.fabhld
               LET gs_keys[2] = g_fabh_d_t.fabhdocno
               LET gs_keys[3] = g_fabh_d_t.fabhseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat502_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL afat502_01_delete_b('fabh_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhdocno
            #add-point:BEFORE FIELD fabhdocno name="input.b.page1.fabhdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhdocno
            
            #add-point:AFTER FIELD fabhdocno name="input.a.page1.fabhdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabh_d[g_detail_idx].fabhld IS NOT NULL AND g_fabh_d[g_detail_idx].fabhdocno IS NOT NULL AND g_fabh_d[g_detail_idx].fabhseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabh_d[g_detail_idx].fabhld != g_fabh_d_t.fabhld OR g_fabh_d[g_detail_idx].fabhdocno != g_fabh_d_t.fabhdocno OR g_fabh_d[g_detail_idx].fabhseq != g_fabh_d_t.fabhseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabh_t WHERE "||"fabhent = '" ||g_enterprise|| "' AND "||"fabhld = '"||g_fabh_d[g_detail_idx].fabhld ||"' AND "|| "fabhdocno = '"||g_fabh_d[g_detail_idx].fabhdocno ||"' AND "|| "fabhseq = '"||g_fabh_d[g_detail_idx].fabhseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabhdocno
            #add-point:ON CHANGE fabhdocno name="input.g.page1.fabhdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhld
            #add-point:BEFORE FIELD fabhld name="input.b.page1.fabhld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhld
            
            #add-point:AFTER FIELD fabhld name="input.a.page1.fabhld"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabh_d[g_detail_idx].fabhld IS NOT NULL AND g_fabh_d[g_detail_idx].fabhdocno IS NOT NULL AND g_fabh_d[g_detail_idx].fabhseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabh_d[g_detail_idx].fabhld != g_fabh_d_t.fabhld OR g_fabh_d[g_detail_idx].fabhdocno != g_fabh_d_t.fabhdocno OR g_fabh_d[g_detail_idx].fabhseq != g_fabh_d_t.fabhseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabh_t WHERE "||"fabhent = '" ||g_enterprise|| "' AND "||"fabhld = '"||g_fabh_d[g_detail_idx].fabhld ||"' AND "|| "fabhdocno = '"||g_fabh_d[g_detail_idx].fabhdocno ||"' AND "|| "fabhseq = '"||g_fabh_d[g_detail_idx].fabhseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabhld
            #add-point:ON CHANGE fabhld name="input.g.page1.fabhld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhseq
            #add-point:BEFORE FIELD fabhseq name="input.b.page1.fabhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhseq
            
            #add-point:AFTER FIELD fabhseq name="input.a.page1.fabhseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabh_d[g_detail_idx].fabhld IS NOT NULL AND g_fabh_d[g_detail_idx].fabhdocno IS NOT NULL AND g_fabh_d[g_detail_idx].fabhseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabh_d[g_detail_idx].fabhld != g_fabh_d_t.fabhld OR g_fabh_d[g_detail_idx].fabhdocno != g_fabh_d_t.fabhdocno OR g_fabh_d[g_detail_idx].fabhseq != g_fabh_d_t.fabhseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabh_t WHERE "||"fabhent = '" ||g_enterprise|| "' AND "||"fabhld = '"||g_fabh_d[g_detail_idx].fabhld ||"' AND "|| "fabhdocno = '"||g_fabh_d[g_detail_idx].fabhdocno ||"' AND "|| "fabhseq = '"||g_fabh_d[g_detail_idx].fabhseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabhseq
            #add-point:ON CHANGE fabhseq name="input.g.page1.fabhseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh036
            #add-point:BEFORE FIELD fabh036 name="input.b.page1.fabh036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh036
            
            #add-point:AFTER FIELD fabh036 name="input.a.page1.fabh036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh036
            #add-point:ON CHANGE fabh036 name="input.g.page1.fabh036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh021
            
            #add-point:AFTER FIELD fabh021 name="input.a.page1.fabh021"
            IF NOT cl_null(g_fabh_d[l_ac].fabh021) THEN 
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511202
              LET l_sql = " "
              #IF  1=1 THEN #s_aglt310_getlike_lc_subject(g_fabhld ,g_fabh_d[l_ac].fabh021,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fabhld 
                 LET g_qryparam.state = 'i'
                 LET g_qryparam.reqry = 'FALSE'
                 LET g_qryparam.default1 = g_fabh_d[l_ac].fabh021
                 
                 LET g_qryparam.arg1 = l_glaa004
                 LET g_qryparam.arg2 = g_fabh_d[l_ac].fabh021
                 LET g_qryparam.arg3 = g_fabhld 
                 LET g_qryparam.arg4 = "1 "
                 CALL q_glac002_6()
                 LET g_fabh_d[l_ac].fabh021 = g_qryparam.return1
                
              #END IF
           #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh021
               LET g_chkparam.arg2 = '參數2'
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#12--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh021
            #add-point:BEFORE FIELD fabh021 name="input.b.page1.fabh021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh021
            #add-point:ON CHANGE fabh021 name="input.g.page1.fabh021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh019
            #add-point:BEFORE FIELD fabh019 name="input.b.page1.fabh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh019
            
            #add-point:AFTER FIELD fabh019 name="input.a.page1.fabh019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh019
            #add-point:ON CHANGE fabh019 name="input.g.page1.fabh019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fabh019
            #add-point:BEFORE FIELD lbl_fabh019 name="input.b.page1.lbl_fabh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fabh019
            
            #add-point:AFTER FIELD lbl_fabh019 name="input.a.page1.lbl_fabh019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_fabh019
            #add-point:ON CHANGE lbl_fabh019 name="input.g.page1.lbl_fabh019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh110
            #add-point:BEFORE FIELD fabh110 name="input.b.page1.fabh110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh110
            
            #add-point:AFTER FIELD fabh110 name="input.a.page1.fabh110"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh110
            #add-point:ON CHANGE fabh110 name="input.g.page1.fabh110"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fabh110
            #add-point:BEFORE FIELD lbl_fabh110 name="input.b.page1.lbl_fabh110"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fabh110
            
            #add-point:AFTER FIELD lbl_fabh110 name="input.a.page1.lbl_fabh110"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_fabh110
            #add-point:ON CHANGE lbl_fabh110 name="input.g.page1.lbl_fabh110"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh160
            #add-point:BEFORE FIELD fabh160 name="input.b.page1.fabh160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh160
            
            #add-point:AFTER FIELD fabh160 name="input.a.page1.fabh160"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh160
            #add-point:ON CHANGE fabh160 name="input.g.page1.fabh160"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fabh160
            #add-point:BEFORE FIELD lbl_fabh160 name="input.b.page1.lbl_fabh160"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fabh160
            
            #add-point:AFTER FIELD lbl_fabh160 name="input.a.page1.lbl_fabh160"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_fabh160
            #add-point:ON CHANGE lbl_fabh160 name="input.g.page1.lbl_fabh160"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fabhdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhdocno
            #add-point:ON ACTION controlp INFIELD fabhdocno name="input.c.page1.fabhdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabhld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhld
            #add-point:ON ACTION controlp INFIELD fabhld name="input.c.page1.fabhld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhseq
            #add-point:ON ACTION controlp INFIELD fabhseq name="input.c.page1.fabhseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh036
            #add-point:ON ACTION controlp INFIELD fabh036 name="input.c.page1.fabh036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh021
            #add-point:ON ACTION controlp INFIELD fabh021 name="input.c.page1.fabh021"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh021 = g_qryparam.return1              

            DISPLAY g_fabh_d[l_ac].fabh021 TO fabh021              #

            NEXT FIELD fabh021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh019
            #add-point:ON ACTION controlp INFIELD fabh019 name="input.c.page1.fabh019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.lbl_fabh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fabh019
            #add-point:ON ACTION controlp INFIELD lbl_fabh019 name="input.c.page1.lbl_fabh019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh110
            #add-point:ON ACTION controlp INFIELD fabh110 name="input.c.page1.fabh110"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.lbl_fabh110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fabh110
            #add-point:ON ACTION controlp INFIELD lbl_fabh110 name="input.c.page1.lbl_fabh110"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh160
            #add-point:ON ACTION controlp INFIELD fabh160 name="input.c.page1.fabh160"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.lbl_fabh160
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fabh160
            #add-point:ON ACTION controlp INFIELD lbl_fabh160 name="input.c.page1.lbl_fabh160"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE afat502_01_bcl
               LET INT_FLAG = 0
               LET g_fabh_d[l_ac].* = g_fabh_d_t.*
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
               LET g_errparam.extend = g_fabh_d[l_ac].fabhld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabh_d[l_ac].* = g_fabh_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat502_01_fabh_t_mask_restore('restore_mask_o')
 
               UPDATE fabh_t SET (fabhdocno,fabhld,fabhseq,fabh036,fabh021,fabh019,fabh110,fabh160) = (g_fabh_d[l_ac].fabhdocno, 
                   g_fabh_d[l_ac].fabhld,g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh036,g_fabh_d[l_ac].fabh021, 
                   g_fabh_d[l_ac].fabh019,g_fabh_d[l_ac].fabh110,g_fabh_d[l_ac].fabh160)
                WHERE fabhent = g_enterprise AND
                  fabhld = g_fabh_d_t.fabhld #項次   
                  AND fabhdocno = g_fabh_d_t.fabhdocno  
                  AND fabhseq = g_fabh_d_t.fabhseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabh_d[g_detail_idx].fabhld
               LET gs_keys_bak[1] = g_fabh_d_t.fabhld
               LET gs_keys[2] = g_fabh_d[g_detail_idx].fabhdocno
               LET gs_keys_bak[2] = g_fabh_d_t.fabhdocno
               LET gs_keys[3] = g_fabh_d[g_detail_idx].fabhseq
               LET gs_keys_bak[3] = g_fabh_d_t.fabhseq
               CALL afat502_01_update_b('fabh_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_fabh_d_t)
                     LET g_log2 = util.JSON.stringify(g_fabh_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat502_01_fabh_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL afat502_01_unlock_b("fabh_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabh_d[l_ac].* = g_fabh_d_t.*
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
               LET g_fabh_d[li_reproduce_target].* = g_fabh_d[li_reproduce].*
 
               LET g_fabh_d[li_reproduce_target].fabhld = NULL
               LET g_fabh_d[li_reproduce_target].fabhdocno = NULL
               LET g_fabh_d[li_reproduce_target].fabhseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabh_d.getLength()+1
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
               NEXT FIELD fabhdocno
 
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
      IF INT_FLAG OR cl_null(g_fabh_d[g_detail_idx].fabhld) THEN
         CALL g_fabh_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_fabh_d[g_detail_idx].* = g_fabh_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE afat502_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat502_01_delete()
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
    RETURN
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_fabh_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT afat502_01_lock_b("fabh_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("fabh_t","") THEN
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
   
   FOR li_idx = 1 TO g_fabh_d.getLength()
      IF g_fabh_d[li_idx].fabhld IS NOT NULL
         AND g_fabh_d[li_idx].fabhdocno IS NOT NULL
         AND g_fabh_d[li_idx].fabhseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM fabh_t
          WHERE fabhent = g_enterprise AND 
                fabhld = g_fabh_d[li_idx].fabhld
                AND fabhdocno = g_fabh_d[li_idx].fabhdocno
                AND fabhseq = g_fabh_d[li_idx].fabhseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_fabh_d_t.fabhld
               LET gs_keys[2] = g_fabh_d_t.fabhdocno
               LET gs_keys[3] = g_fabh_d_t.fabhseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL afat502_01_delete_b('fabh_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat502_01_set_pk_array()
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
   CALL afat502_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat502_01_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.fabhdocno,t0.fabhld,t0.fabhseq,t0.fabh036,t0.fabh021,t0.fabh019, 
       t0.fabh110,t0.fabh160  FROM fabh_t t0",
               "",
               
               " WHERE t0.fabhent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("fabh_t"),
                      " ORDER BY t0.fabhld,t0.fabhdocno,t0.fabhseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabh_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat502_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afat502_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_fabh_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_fabh_d[l_ac].fabhdocno,g_fabh_d[l_ac].fabhld,g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh036, 
       g_fabh_d[l_ac].fabh021,g_fabh_d[l_ac].fabh019,g_fabh_d[l_ac].fabh110,g_fabh_d[l_ac].fabh160
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
      
      CALL afat502_01_detail_show()      
 
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
   
 
   
   CALL g_fabh_d.deleteElement(g_fabh_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fabh_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_fabh_d.getLength() THEN
      LET l_ac = g_fabh_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_fabh_d.getLength()
      LET g_fabh_d_mask_o[l_ac].* =  g_fabh_d[l_ac].*
      CALL afat502_01_fabh_t_mask()
      LET g_fabh_d_mask_n[l_ac].* =  g_fabh_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL afat502_01_b_fill_1()
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_fabh_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE afat502_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afat502_01_detail_show()
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
 
{<section id="afat502_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat502_01_set_entry_b(p_cmd)                                                  
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
 
{<section id="afat502_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat502_01_set_no_entry_b(p_cmd)                                               
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
 
{<section id="afat502_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat502_01_default_search()
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
      LET ls_wc = ls_wc, " fabhld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabhdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fabhseq = '", g_argv[03], "' AND "
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
 
{<section id="afat502_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat502_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "fabh_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'fabh_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM fabh_t
          WHERE fabhent = g_enterprise AND
            fabhld = ps_keys_bak[1] AND fabhdocno = ps_keys_bak[2] AND fabhseq = ps_keys_bak[3]
         
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
         CALL g_fabh_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat502_01_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   RETURN
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "fabh_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO fabh_t
                  (fabhent,
                   fabhld,fabhdocno,fabhseq
                   ,fabh036,fabh021,fabh019,fabh110,fabh160) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fabh_d[l_ac].fabh036,g_fabh_d[l_ac].fabh021,g_fabh_d[l_ac].fabh019,g_fabh_d[l_ac].fabh110, 
                       g_fabh_d[l_ac].fabh160)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat502_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   RETURN
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
   LET ls_group = "fabh_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "fabh_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE fabh_t 
         SET (fabhld,fabhdocno,fabhseq
              ,fabh036,fabh021,fabh019,fabh110,fabh160) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabh_d[l_ac].fabh036,g_fabh_d[l_ac].fabh021,g_fabh_d[l_ac].fabh019,g_fabh_d[l_ac].fabh110, 
                  g_fabh_d[l_ac].fabh160) 
         WHERE fabhent = g_enterprise AND fabhld = ps_keys_bak[1] AND fabhdocno = ps_keys_bak[2] AND fabhseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
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
 
{<section id="afat502_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat502_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL afat502_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "fabh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat502_01_bcl USING g_enterprise,
                                       g_fabh_d[g_detail_idx].fabhld,g_fabh_d[g_detail_idx].fabhdocno, 
                                           g_fabh_d[g_detail_idx].fabhseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat502_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat502_01_unlock_b(ps_table)
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
      CLOSE afat502_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION afat502_01_modify_detail_chk(ps_record)
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
         LET ls_return = "fabhdocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="afat502_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION afat502_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="afat502_01.mask_functions" >}
&include "erp/afa/afat502_01_mask.4gl"
 
{</section>}
 
{<section id="afat502_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat502_01_set_pk_array()
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
   LET g_pk_array[1].values = g_fabh_d[l_ac].fabhld
   LET g_pk_array[1].column = 'fabhld'
   LET g_pk_array[2].values = g_fabh_d[l_ac].fabhdocno
   LET g_pk_array[2].column = 'fabhdocno'
   LET g_pk_array[3].values = g_fabh_d[l_ac].fabhseq
   LET g_pk_array[3].column = 'fabhseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat502_01.state_change" >}
   
 
{</section>}
 
{<section id="afat502_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat502_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION afat502_01_b_fill_1()
  DEFINE p_wc2    STRING
   #add-point:b_fill段define
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_glaa015       LIKE glaa_t.glaa015
   DEFINE l_glaa016       LIKE glaa_t.glaa016
   DEFINE l_glaa019       LIKE glaa_t.glaa019
   DEFINE l_glaa020       LIKE glaa_t.glaa020
   DEFINE l_fabh021       STRING
   DEFINE l_str           STRING 
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING
   DEFINE l_str3          STRING
   DEFINE l_str4          STRING
   DEFINE l_msg1          STRING
   DEFINE l_msg2          STRING
   DEFINE l_msg3          STRING
   DEFINE l_msg4          STRING
   DEFINE l_fabh025       LIKE fabh_t.fabh025
   DEFINE l_fabh025_t       LIKE fabh_t.fabh025
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_sum           LIKE type_t.num5
   DEFINE l_fabh019       LIKE fabh_t.fabh019
   DEFINE l_fabh110       LIKE fabh_t.fabh110
   DEFINE l_fabh160       LIKE fabh_t.fabh160
    SELECT glaa015,glaa016,glaa019,glaa020
     INTO l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xrcald
      
   LET l_str1 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str2 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str3 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str4 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str1 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg2 = l_str2 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg3 = l_str1 CLIPPED,l_glaa020 CLIPPED,l_str4
   LET l_msg4 = l_str2 CLIPPED,l_glaa020 CLIPPED,l_str4
      
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('fabh110,lbl_fabh110',TRUE)
      CALL cl_set_comp_att_text('fabh110',l_msg1)
      CALL cl_set_comp_att_text('lbl_fabh110',l_msg2)
   ELSE
      CALL cl_set_comp_visible('fabh110,lbl_fabh110',FALSE)
   END IF
      
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('fabh160,lbl_fabh160',TRUE)
      CALL cl_set_comp_att_text('fabh160',l_msg3)
      CALL cl_set_comp_att_text('lbl_fabh160',l_msg4)
   ELSE
      CALL cl_set_comp_visible('fabh160,lbl_fabh160',FALSE)
   END IF
   
   
   LET g_sql = "SELECT  UNIQUE t0.fabhdocno,t0.fabhld,t0.fabhseq,t0.fabh036,t0.fabh021,t0.fabh025,t0.fabh019,t0.fabh110, 
       t0.fabh160  FROM fabh_t t0",
               "",
               
               " WHERE t0.fabhent= ? AND t0.fabhdocno='",g_fabgdocno,"'  AND t0.fabhld='",g_fabhld,"' AND  1=1   " 

   LET g_sql = g_sql, cl_sql_add_filter("fabh_t"),
                      " ORDER BY t0.fabhld,t0.fabhdocno,t0.fabhseq"

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat502_01_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR afat502_01_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
 
   CALL g_fabh_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs2 INTO g_fabh_d1[l_ac].fabhdocno,g_fabh_d1[l_ac].fabhld,g_fabh_d1[l_ac].fabhseq,
        g_fabh_d1[l_ac].fabh036,g_fabh_d1[l_ac].fabh021,l_fabh025,g_fabh_d1[l_ac].fabh019, 
        g_fabh_d1[l_ac].fabh110,g_fabh_d1[l_ac].fabh160        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
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
      SELECT COUNT (*) INTO l_count
            FROM fabh_temp_t WHERE fabhent=g_enterprise  AND fabh021=l_fabh025 
      IF l_count<1 THEN  #科目名称不同
         IF g_fabh018=1 THEN  #调增
            INSERT INTO fabh_temp_t(fabhent,fabhdocno,fabhld,fabhseq,fabhseq1,fabh036,fabh021,fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                          VALUES(g_enterprise,g_fabgdocno,g_fabhld,g_fabhseq,1,g_fabh_d1[l_ac].fabh036,g_fabh_d1[l_ac].fabh021,
                                 g_fabh_d1[l_ac].fabh019,0,g_fabh_d1[l_ac].fabh110,0,g_fabh_d1[l_ac].fabh160,0)
                                 
            INSERT INTO fabh_temp_t(fabhent,fabhdocno,fabhld,fabhseq,fabhseq1,fabh036,fabh021,fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                          VALUES(g_enterprise,g_fabgdocno,g_fabhld,g_fabhseq,2,g_fabh_d1[l_ac].fabh036,l_fabh025,
                                 0,g_fabh_d1[l_ac].fabh019,0,g_fabh_d1[l_ac].fabh110,0,g_fabh_d1[l_ac].fabh160)
         ELSE 
            INSERT INTO fabh_temp_t(fabhent,fabhdocno,fabhld,fabhseq,fabhseq1,fabh036,fabh021,fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                          VALUES(g_enterprise,g_fabgdocno,g_fabhld,g_fabhseq,1,g_fabh_d1[l_ac].fabh036,l_fabh025,
                                 g_fabh_d1[l_ac].fabh019,0,g_fabh_d1[l_ac].fabh110,0,g_fabh_d1[l_ac].fabh160,0)
                                 
            INSERT INTO fabh_temp_t(fabhent,fabhdocno,fabhld,fabhseq,fabhseq1,fabh036,fabh021,fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                          VALUES(g_enterprise,g_fabgdocno,g_fabhld,g_fabhseq,2,g_fabh_d[l_ac].fabh036,g_fabh_d[l_ac].fabh021,
                                 0,g_fabh_d[l_ac].fabh019,0,g_fabh_d[l_ac].fabh110,0,g_fabh_d[l_ac].fabh160)
         END IF
      
      ELSE 
         
         IF g_fabh018=1 THEN  #调增
            SELECT  fabhld,fabhdocno,fabhseq,lbl_fabh019,lbl_fabh110,lbl_fabh160
            INTO   g_fabh_d_t.fabhld, g_fabh_d_t.fabhdocno,g_fabh_d_t.fabhseq,g_fabh_d_t.fabh019,g_fabh_d_t.fabh110,g_fabh_d_t.fabh160       
            FROM fabh_temp_t WHERE fabhent=g_enterprise AND fabhseq1=2 AND fabh021=l_fabh025
            LET l_sum=g_fabh_d1[l_ac].fabh019+g_fabh_d_t.fabh019
            UPDATE fabh_temp_t SET (fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                                 =(0,l_sum,0,g_fabh_d1[l_ac].fabh110+g_fabh_d_t.fabh110,
                                   0,g_fabh_d1[l_ac].fabh160+g_fabh_d_t.fabh160)                 
                             WHERE fabhent=g_enterprise AND fabh021=l_fabh025 AND fabhseq1=2

           UPDATE fabh_temp_t SET (fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                                 =
                                 (l_sum,0,g_fabh_d1[l_ac].fabh110+g_fabh_d_t.fabh110,
                                 0,g_fabh_d1[l_ac].fabh160+g_fabh_d_t.fabh160,0)
                             WHERE fabhent=g_enterprise AND fabhseq1=1  AND fabhseq= g_fabh_d_t.fabhseq AND fabhld= g_fabh_d_t.fabhld AND  fabhdocno=g_fabh_d_t.fabhdocno
            

         ELSE 
            SELECT fabhld,fabhdocno,fabhseq,fabh019,fabh110,fabh160
            INTO  g_fabh_d_t.fabhld, g_fabh_d_t.fabhdocno,g_fabh_d_t.fabhseq,g_fabh_d_t.fabh019, g_fabh_d_t.fabh110,g_fabh_d_t.fabh160       
            FROM fabh_temp_t WHERE fabhent=g_enterprise AND fabhseq1=1 AND fabh021=l_fabh025
            LET l_sum=g_fabh_d1[l_ac].fabh019+g_fabh_d_t.fabh019
            UPDATE fabh_temp_t SET (fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                                 =
                                 (l_sum ,0,g_fabh_d1[l_ac].fabh110+g_fabh_d_t.fabh110,
                                 0,g_fabh_d1[l_ac].fabh160+g_fabh_d_t.fabh160,0)
                             WHERE fabhent=g_enterprise AND fabhseq1=1 AND fabh021=l_fabh025          
            
            UPDATE fabh_temp_t SET (fabh019,lbl_fabh019,fabh110,lbl_fabh110,fabh160,lbl_fabh160)
                                 =(0,g_fabh_d1[l_ac].fabh019+g_fabh_d_t.fabh019,0,g_fabh_d1[l_ac].fabh110+g_fabh_d_t.fabh110,
                                   0,g_fabh_d1[l_ac].fabh160+g_fabh_d_t.fabh160) 
                             WHERE fabhent=g_enterprise AND fabhseq1=2  AND fabhseq= g_fabh_d_t.fabhseq AND fabhld= g_fabh_d_t.fabhld AND  fabhdocno=g_fabh_d_t.fabhdocno
         END IF
         
      END IF
      
      
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   
   
   CALL g_fabh_d.clear()
   LET l_ac=1

   
   
   
   LET g_sql="SELECT  UNIQUE t0.fabhdocno,t0.fabhld,t0.fabhseq,t0.fabh036,t0.fabh021,t0.fabh019,t0.lbl_fabh019,t0.fabh110, t0.lbl_fabh110,
       t0.fabh160,t0.lbl_fabh160  FROM fabh_temp_t t0",
               "",
               
               " WHERE t0.fabhent= ? "
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabh_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat502_01_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR afat502_01_pb1
   
   OPEN b_fill_curs1 USING g_enterprise
 
   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_fabh_d[l_ac].fabhdocno,g_fabh_d[l_ac].fabhld,g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh036, 
       g_fabh_d[l_ac].fabh021,g_fabh_d[l_ac].fabh019,g_fabh_d[l_ac].lbl_fabh019,g_fabh_d[l_ac].fabh110,g_fabh_d[l_ac].lbl_fabh110,
       g_fabh_d[l_ac].fabh160,g_fabh_d[l_ac].lbl_fabh160
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  

      IF  g_fabh_d[l_ac].fabh019=0 THEN LET g_fabh_d[l_ac].fabh019="" END IF
      IF  g_fabh_d[l_ac].fabh110=0 THEN LET g_fabh_d[l_ac].fabh110="" END IF
      IF  g_fabh_d[l_ac].fabh160=9 THEN LET g_fabh_d[l_ac].fabh160="" END IF
      IF  g_fabh_d[l_ac].lbl_fabh019=0 THEN LET g_fabh_d[l_ac].lbl_fabh019="" END IF
      IF  g_fabh_d[l_ac].lbl_fabh110=0 THEN LET g_fabh_d[l_ac].lbl_fabh110="" END IF
      IF  g_fabh_d[l_ac].lbl_fabh160=0 THEN LET g_fabh_d[l_ac].lbl_fabh160="" END IF
      CALL afat502_01_fabh021_desc(g_fabh_d[l_ac].fabh021) RETURNING l_fabh021,l_str
      LET g_fabh_d[l_ac].fabh021 = g_fabh_d[l_ac].fabh021,l_str,'\n',l_fabh021
      CALL afat502_01_detail_show()      
 
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
   
 
   
   CALL g_fabh_d.deleteElement(g_fabh_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fabh_d.getLength()
 
   END FOR
   
   IF g_cnt > g_fabh_d.getLength() THEN
      LET l_ac = g_fabh_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_fabh_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs1
   FREE afat502_01_pb1
   CALL afat502_01_b_detail()
END FUNCTION

################################################################################
# Descriptions...: 核算项取值
################################################################################
PRIVATE FUNCTION afat502_01_b_detail()
INITIALIZE g_detail_m.* LIKE fabh_t.* 
   
   SELECT fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,
          fabh032,fabh033,fabh034,fabh035
     INTO g_detail_m.fabh026,g_detail_m.fabh027,g_detail_m.fabh028,g_detail_m.fabh029,g_detail_m.fabh030,g_detail_m.fabh031,
          g_detail_m.fabh032,g_detail_m.fabh033,g_detail_m.fabh034,g_detail_m.fabh035             
     FROM fabh_t
    WHERE fabhent = g_enterprise
      AND fabhdocno = g_fabgdocno
      AND fabhld=g_fabhld
      AND fabhseq=g_fabh_d[g_detail_idx].fabhseq
      
   CALL afat502_01__detail_desc()
   DISPLAY  g_detail_m.fabh026 TO fabh026
   DISPLAY  g_detail_m.fabh027 TO fabh027
   DISPLAY  g_detail_m.fabh028 TO fabh028
   DISPLAY  g_detail_m.fabh029 TO fabh029
   DISPLAY  g_detail_m.fabh030 TO fabh030
   DISPLAY  g_detail_m.fabh031 TO fabh031
   DISPLAY  g_detail_m.fabh032 TO fabh032
   DISPLAY  g_detail_m.fabh033 TO fabh033
   DISPLAY  g_detail_m.fabh034 TO fabh034
   DISPLAY  g_detail_m.fabh035 TO fabh035
      
#   DISPLAY BY NAME 
#          g_detail_m.fabh026,g_detail_m.fabh027,g_detail_m.fabh028,g_detail_m.fabh029,g_detail_m.fabh030,g_detail_m.fabh031,
#          g_detail_m.fabh032,g_detail_m.fabh033,g_detail_m.fabh034,g_detail_m.fabh035   
END FUNCTION

################################################################################
# Descriptions...: 核算项说明
################################################################################
PRIVATE FUNCTION afat502_01__detail_desc()
INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh026
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh026_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_detail_m.fabh026_desc TO fabh026_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh027
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh027_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh028_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh029
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh029_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh029_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh030
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh030_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh030_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh031
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh031_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh031_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh032
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh032_desc

   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh033
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_detail_m.fabh033_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh033_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh034
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh034_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh034_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_m.fabh034
   LET g_ref_fields[2] = g_detail_m.fabh035
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_detail_m.fabh035_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_detail_m.fabh035_desc
END FUNCTION

################################################################################
# Descriptions...: 科目名稱組合
################################################################################
PRIVATE FUNCTION afat502_01_fabh021_desc(p_fabh021)
DEFINE p_fabh021           LIKE fabh_t.fabh021
DEFINE l_fabh021_desc      LIKE glacl_t.glacl004
DEFINE r_fabh021          STRING
DEFINE l_oogf002_desc      LIKE oofa_t.oofa011
DEFINE r_str               STRING
DEFINE l_fabh      RECORD 
         fabh026   LIKE fabh_t.fabh026,
         fabh027   LIKE fabh_t.fabh027,
         fabh028   LIKE fabh_t.fabh028,
         fabh029   LIKE fabh_t.fabh029,
         fabh030   LIKE fabh_t.fabh030,
         fabh031   LIKE fabh_t.fabh031,
         fabh032   LIKE fabh_t.fabh032,
         fabh033   LIKE fabh_t.fabh033,
         fabh034   LIKE fabh_t.fabh034,
         fabh035   LIKE fabh_t.fabh035
                   END RECORD
   
   SELECT fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,
            fabh032,fabh033,fabh034,fabh035
     INTO l_fabh.*
     FROM fabh_t
    WHERE fabhent = g_enterprise
      AND fabhld = g_fabhld  
      AND fabhdocno = g_fabgdocno  

   
   #抓取科目名称
   LET l_fabh021_desc = ''
   SELECT glacl004 INTO l_fabh021_desc FROM glacl_t,glaa_t
    WHERE glaaent = glaclent 
      AND glaa004 = glacl001
      AND glaclent = g_enterprise
      AND glaald = g_fabhld
      AND glacl002 = p_fabh021
      AND glacl003 = g_dlang  


   #组合名称以及核算项
   LET r_fabh021 = ''
   LET r_str = ''
   #營運據點
   IF NOT cl_null(l_fabh.fabh026) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabh.fabh026
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_fabh021 = g_rtn_fields[1]     
      LET r_str = l_fabh.fabh026 
   END IF
   #部门
   IF NOT cl_null(l_fabh.fabh027) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabh.fabh027
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_fabh021 = g_rtn_fields[1]   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh027
      ELSE
         LET r_str=l_fabh.fabh027
      END IF   
   END IF 
   #成本利润中心
   IF NOT cl_null(l_fabh.fabh028) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabh.fabh028
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021 = r_fabh021 ,'-',g_rtn_fields[1]
      ELSE
         LET r_fabh021 = g_rtn_fields[1]
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh028
      ELSE
         LET r_str=l_fabh.fabh028
      END IF      
   END IF 
   
   #区域
   IF NOT cl_null(l_fabh.fabh029) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '287'
      LET g_ref_fields[2] = l_fabh.fabh028
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields  
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021 = r_fabh021 ,'-',g_rtn_fields[1]
      ELSE
         LET r_fabh021 = g_rtn_fields[1]
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh029
      ELSE
         LET r_str=l_fabh.fabh029
      END IF       
   END IF 
   #交易客商
   IF NOT cl_null(l_fabh.fabh030) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabh.fabh030
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021 = r_fabh021 ,'-',g_rtn_fields[1] 
      ELSE
         LET r_fabh021 = g_rtn_fields[1] 
      END IF    
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh030
      ELSE
         LET r_str=l_fabh.fabh030
      END IF       
   END IF 
   #帐款客商
   IF NOT cl_null(l_fabh.fabh031) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_fabh.fabh031
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021= r_fabh021 ,'-',g_rtn_fields[1]
      ELSE
         LET r_fabh021 = g_rtn_fields[1]
      END IF     
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh031
      ELSE
         LET r_str=l_fabh.fabh031
      END IF        
   END IF 
   #客群
   IF NOT cl_null(l_fabh.fabh032) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '281'
      LET g_ref_fields[2] = l_fabh.fabh032
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021 = r_fabh021 ,'-',g_rtn_fields[1]
      ELSE
         LET r_fabh021 = g_rtn_fields[1]
      END IF  
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh032
      ELSE
         LET r_str=l_fabh.fabh032
      END IF        
   END IF 
   
   #人员
   IF NOT cl_null(l_fabh.fabh033) THEN
      LET  l_oogf002_desc = ''
      SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
       WHERE oofaent = g_enterprise
         AND oofa001 IN (SELECT ooag002 FROM ooag_t
                          WHERE ooagent = g_enterprise
                            AND ooag001 = l_fabh.fabh033)
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021 = r_fabh021 ,'-',l_oogf002_desc
      ELSE
         LET r_fabh021 = l_oogf002_desc
      END IF     
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh033
      ELSE
         LET r_str=l_fabh.fabh033
      END IF       
   END IF
   #专案编号
   IF NOT cl_null(l_fabh.fabh034) THEN
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021 = r_fabh021 ,'-',l_fabh.fabh034
      ELSE
         LET r_fabh021 = l_fabh.fabh034
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh034
      ELSE
         LET r_str=l_fabh.fabh034
      END IF          
   END IF 
   #WBS
   IF NOT cl_null(l_fabh.fabh035) THEN
      IF NOT cl_null(r_fabh021) THEN
         LET r_fabh021= r_fabh021 ,'-',l_fabh.fabh035
      ELSE
         LET r_fabh021 = l_fabh.fabh035
      END IF   
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_fabh.fabh035
      ELSE
         LET r_str=l_fabh.fabh035
      END IF       
   END IF 
   #组合科目名称以及核算项
   LET r_fabh021 = l_fabh021_desc,'\n',
                   r_fabh021
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF  
   RETURN r_fabh021,r_str 
END FUNCTION

################################################################################
# Descriptions...: 科目核算项显示
################################################################################
PRIVATE FUNCTION afat502_01_show()

END FUNCTION

 
{</section>}
 
