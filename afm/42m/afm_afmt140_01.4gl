#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt140_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-11-24 18:56:07), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: afmt140_01
#+ Description: 融資費用維護
#+ Creator....: 06421(2015-11-19 10:59:57)
#+ Modifier...: 06421 -SD/PR- 00000
 
{</section>}
 
{<section id="afmt140_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#36   2016/04/14 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#+ Modifier...:   No.160822-00008#7    2016/08/29 BY 08732    _t_o新舊值調整
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
PRIVATE TYPE type_g_fmdc_d RECORD
       fmdcseq2 LIKE fmdc_t.fmdcseq2, 
   fmdcdocno LIKE fmdc_t.fmdcdocno, 
   fmdcseq LIKE fmdc_t.fmdcseq, 
   fmdc001 LIKE fmdc_t.fmdc001, 
   fmdc002 LIKE fmdc_t.fmdc002, 
   fmdc003 LIKE fmdc_t.fmdc003, 
   fmdc004 LIKE fmdc_t.fmdc004, 
   fmdc004_desc LIKE type_t.chr500, 
   fmdc005 LIKE fmdc_t.fmdc005, 
   fmdc006 LIKE fmdc_t.fmdc006, 
   fmdc008 LIKE fmdc_t.fmdc008, 
   fmdc007 LIKE fmdc_t.fmdc007, 
   fmdc009 LIKE fmdc_t.fmdc009, 
   fmdc010 LIKE fmdc_t.fmdc010, 
   fmdc011 LIKE fmdc_t.fmdc011, 
   fmdc012 LIKE fmdc_t.fmdc012, 
   fmdc013 LIKE fmdc_t.fmdc013, 
   fmdc014 LIKE fmdc_t.fmdc014, 
   fmdc015 LIKE fmdc_t.fmdc015, 
   fmdc016 LIKE fmdc_t.fmdc016, 
   fmdc016_desc LIKE type_t.chr500, 
   fmdc017 LIKE fmdc_t.fmdc017, 
   fmdc017_desc LIKE type_t.chr500, 
   fmdc018 LIKE fmdc_t.fmdc018
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fmcrcomp    LIKE fmcr_t.fmcrcomp,
       g_fmcrdocno   LIKE fmcr_t.fmcrdocno,
       g_fmcrdocdt   LIKE fmcr_t.fmcrdocdt,
       g_fmcrstus    LIKE fmcr_t.fmcrstus,
       g_glaa005     LIKE glaa_t.glaa005,
       g_glaa001     LIKE glaa_t.glaa001,
       g_glaa016     LIKE glaa_t.glaa016, 
       g_glaa020     LIKE glaa_t.glaa020,
       g_glaald      LIKE glaa_t.glaald,
       g_glaa026     LIKE glaa_t.glaa026,
       g_glaa025     LIKE glaa_t.glaa025
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmdc_d          DYNAMIC ARRAY OF type_g_fmdc_d #單身變數
DEFINE g_fmdc_d_t        type_g_fmdc_d                  #單身備份
DEFINE g_fmdc_d_o        type_g_fmdc_d                  #單身備份
DEFINE g_fmdc_d_mask_o   DYNAMIC ARRAY OF type_g_fmdc_d #單身變數
DEFINE g_fmdc_d_mask_n   DYNAMIC ARRAY OF type_g_fmdc_d #單身變數
 
      
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
 
{<section id="afmt140_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION afmt140_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_fmcrdocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_fmcrdocno   LIKE fmcr_t.fmcrdocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
    WHENEVER ERROR CONTINUE
   IF cl_null(p_fmcrdocno) THEN
      RETURN
   ELSE
      LET g_fmcrdocno = p_fmcrdocno
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fmdcseq2,fmdcdocno,fmdcseq,fmdc001,fmdc002,fmdc003,fmdc004,fmdc005,fmdc006, 
       fmdc008,fmdc007,fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc016,fmdc017,fmdc018  
       FROM fmdc_t WHERE fmdcent=? AND fmdcdocno=? AND fmdcseq=? AND fmdcseq2=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt140_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afmt140_01 WITH FORM cl_ap_formpath("afm","afmt140_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL afmt140_01_init()   
 
   #進入選單 Menu (="N")
   CALL afmt140_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_afmt140_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt140_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmt140_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('fmdc003','8858') 
   CALL cl_set_combo_scc('fmdc007','8871') 
   CALL cl_set_combo_scc('fmdc015','8708') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #根據傳入參數抓取單号資料
   DISPLAY g_fmcrdocno TO l_fmcrdocno 
   CALL cl_set_combo_scc_part('fmdc003','8858','1,2,3,4,5')
   CALL afmt140_01_get_glaa()
   SELECT fmcrdocdt,fmcrstus INTO g_fmcrdocdt,g_fmcrstus
   FROM fmcr_t WHERE fmcrent  = g_enterprise AND fmcrdocno = g_fmcrdocno
   IF cl_null(g_glaa016) THEN
      CALL cl_set_comp_visible("fmdc011,fmdc012",FALSE)
   ELSE
      CALL cl_set_comp_visible("fmdc011,fmdc012",TRUE) 
   END IF
   IF cl_null(g_glaa020) THEN
      CALL cl_set_comp_visible("fmdc013,fmdc014",FALSE)
   ELSE
      CALL cl_set_comp_visible("fmdc013,fmdc014",TRUE) 
   END IF
   CALL cl_set_comp_entry("fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc018",FALSE)
   #end add-point
   
   CALL afmt140_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afmt140_01_ui_dialog()
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
         CALL g_fmdc_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL afmt140_01_init()
      END IF
   
      CALL afmt140_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_fmdc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL afmt140_01_set_pk_array()
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
            CALL cl_set_act_visible("logistics,query,output,reproduce", FALSE)
            IF g_fmcrstus NOT MATCHES "[N]" THEN
               CALL cl_set_act_visible("insert,modify,delete,modify_detail", FALSE)
            END IF
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL afmt140_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afmt140_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL afmt140_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afmt140_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL afmt140_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afmt140_01_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt140_01_insert()
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
               CALL afmt140_01_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_fmdc_d)
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
            CALL afmt140_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt140_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt140_01_set_pk_array()
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
 
{<section id="afmt140_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt140_01_query()
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
   CALL g_fmdc_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON fmdcseq2,fmdcdocno,fmdcseq,fmdc001,fmdc002,fmdc003,fmdc004,fmdc005,fmdc006, 
          fmdc008,fmdc007,fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc016,fmdc017,fmdc018  
 
 
         FROM s_detail1[1].fmdcseq2,s_detail1[1].fmdcdocno,s_detail1[1].fmdcseq,s_detail1[1].fmdc001, 
             s_detail1[1].fmdc002,s_detail1[1].fmdc003,s_detail1[1].fmdc004,s_detail1[1].fmdc005,s_detail1[1].fmdc006, 
             s_detail1[1].fmdc008,s_detail1[1].fmdc007,s_detail1[1].fmdc009,s_detail1[1].fmdc010,s_detail1[1].fmdc011, 
             s_detail1[1].fmdc012,s_detail1[1].fmdc013,s_detail1[1].fmdc014,s_detail1[1].fmdc015,s_detail1[1].fmdc016, 
             s_detail1[1].fmdc017,s_detail1[1].fmdc018 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdcseq2
            #add-point:BEFORE FIELD fmdcseq2 name="query.b.page1.fmdcseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdcseq2
            
            #add-point:AFTER FIELD fmdcseq2 name="query.a.page1.fmdcseq2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdcseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdcseq2
            #add-point:ON ACTION controlp INFIELD fmdcseq2 name="query.c.page1.fmdcseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdcdocno
            #add-point:BEFORE FIELD fmdcdocno name="query.b.page1.fmdcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdcdocno
            
            #add-point:AFTER FIELD fmdcdocno name="query.a.page1.fmdcdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdcdocno
            #add-point:ON ACTION controlp INFIELD fmdcdocno name="query.c.page1.fmdcdocno"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmdcseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdcseq
            #add-point:ON ACTION controlp INFIELD fmdcseq name="construct.c.page1.fmdcseq"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmdcseq()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmdcseq  #顯示到畫面上
            NEXT FIELD fmdcseq                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdcseq
            #add-point:BEFORE FIELD fmdcseq name="query.b.page1.fmdcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdcseq
            
            #add-point:AFTER FIELD fmdcseq name="query.a.page1.fmdcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmdc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc001
            #add-point:ON ACTION controlp INFIELD fmdc001 name="construct.c.page1.fmdc001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_fmcrdocno
            CALL q_fmdc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmdc001  #顯示到畫面上
            NEXT FIELD fmdc001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc001
            #add-point:BEFORE FIELD fmdc001 name="query.b.page1.fmdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc001
            
            #add-point:AFTER FIELD fmdc001 name="query.a.page1.fmdc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc002
            #add-point:BEFORE FIELD fmdc002 name="query.b.page1.fmdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc002
            
            #add-point:AFTER FIELD fmdc002 name="query.a.page1.fmdc002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc002
            #add-point:ON ACTION controlp INFIELD fmdc002 name="query.c.page1.fmdc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc003
            #add-point:BEFORE FIELD fmdc003 name="query.b.page1.fmdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc003
            
            #add-point:AFTER FIELD fmdc003 name="query.a.page1.fmdc003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc003
            #add-point:ON ACTION controlp INFIELD fmdc003 name="query.c.page1.fmdc003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmdc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc004
            #add-point:ON ACTION controlp INFIELD fmdc004 name="construct.c.page1.fmdc004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmdc004  #顯示到畫面上
            NEXT FIELD fmdc004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc004
            #add-point:BEFORE FIELD fmdc004 name="query.b.page1.fmdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc004
            
            #add-point:AFTER FIELD fmdc004 name="query.a.page1.fmdc004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc005
            #add-point:BEFORE FIELD fmdc005 name="query.b.page1.fmdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc005
            
            #add-point:AFTER FIELD fmdc005 name="query.a.page1.fmdc005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc005
            #add-point:ON ACTION controlp INFIELD fmdc005 name="query.c.page1.fmdc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc006
            #add-point:BEFORE FIELD fmdc006 name="query.b.page1.fmdc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc006
            
            #add-point:AFTER FIELD fmdc006 name="query.a.page1.fmdc006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc006
            #add-point:ON ACTION controlp INFIELD fmdc006 name="query.c.page1.fmdc006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmdc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc008
            #add-point:ON ACTION controlp INFIELD fmdc008 name="construct.c.page1.fmdc008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmdc008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmdc008  #顯示到畫面上
            NEXT FIELD fmdc008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc008
            #add-point:BEFORE FIELD fmdc008 name="query.b.page1.fmdc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc008
            
            #add-point:AFTER FIELD fmdc008 name="query.a.page1.fmdc008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc007
            #add-point:BEFORE FIELD fmdc007 name="query.b.page1.fmdc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc007
            
            #add-point:AFTER FIELD fmdc007 name="query.a.page1.fmdc007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc007
            #add-point:ON ACTION controlp INFIELD fmdc007 name="query.c.page1.fmdc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc009
            #add-point:BEFORE FIELD fmdc009 name="query.b.page1.fmdc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc009
            
            #add-point:AFTER FIELD fmdc009 name="query.a.page1.fmdc009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc009
            #add-point:ON ACTION controlp INFIELD fmdc009 name="query.c.page1.fmdc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc010
            #add-point:BEFORE FIELD fmdc010 name="query.b.page1.fmdc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc010
            
            #add-point:AFTER FIELD fmdc010 name="query.a.page1.fmdc010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc010
            #add-point:ON ACTION controlp INFIELD fmdc010 name="query.c.page1.fmdc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc011
            #add-point:BEFORE FIELD fmdc011 name="query.b.page1.fmdc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc011
            
            #add-point:AFTER FIELD fmdc011 name="query.a.page1.fmdc011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc011
            #add-point:ON ACTION controlp INFIELD fmdc011 name="query.c.page1.fmdc011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc012
            #add-point:BEFORE FIELD fmdc012 name="query.b.page1.fmdc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc012
            
            #add-point:AFTER FIELD fmdc012 name="query.a.page1.fmdc012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc012
            #add-point:ON ACTION controlp INFIELD fmdc012 name="query.c.page1.fmdc012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc013
            #add-point:BEFORE FIELD fmdc013 name="query.b.page1.fmdc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc013
            
            #add-point:AFTER FIELD fmdc013 name="query.a.page1.fmdc013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc013
            #add-point:ON ACTION controlp INFIELD fmdc013 name="query.c.page1.fmdc013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc014
            #add-point:BEFORE FIELD fmdc014 name="query.b.page1.fmdc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc014
            
            #add-point:AFTER FIELD fmdc014 name="query.a.page1.fmdc014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc014
            #add-point:ON ACTION controlp INFIELD fmdc014 name="query.c.page1.fmdc014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc015
            #add-point:BEFORE FIELD fmdc015 name="query.b.page1.fmdc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc015
            
            #add-point:AFTER FIELD fmdc015 name="query.a.page1.fmdc015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc015
            #add-point:ON ACTION controlp INFIELD fmdc015 name="query.c.page1.fmdc015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmdc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc016
            #add-point:ON ACTION controlp INFIELD fmdc016 name="construct.c.page1.fmdc016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2'"
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmdc016  #顯示到畫面上
            NEXT FIELD fmdc016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc016
            #add-point:BEFORE FIELD fmdc016 name="query.b.page1.fmdc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc016
            
            #add-point:AFTER FIELD fmdc016 name="query.a.page1.fmdc016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc017
            #add-point:BEFORE FIELD fmdc017 name="query.b.page1.fmdc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc017
            
            #add-point:AFTER FIELD fmdc017 name="query.a.page1.fmdc017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc017
            #add-point:ON ACTION controlp INFIELD fmdc017 name="query.c.page1.fmdc017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc018
            #add-point:BEFORE FIELD fmdc018 name="query.b.page1.fmdc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc018
            
            #add-point:AFTER FIELD fmdc018 name="query.a.page1.fmdc018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmdc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc018
            #add-point:ON ACTION controlp INFIELD fmdc018 name="query.c.page1.fmdc018"
            
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
    
   CALL afmt140_01_b_fill(g_wc2)
 
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
 
{<section id="afmt140_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt140_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL afmt140_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt140_01_modify()
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
   DEFINE l_cn                   LIKE type_t.num10
   DEFINE l_glaald               LIKE glaa_t.glaald,
          l_fmcs008              LIKE fmcs_t.fmcs008,
          l_fmcs007              LIKE fmcs_t.fmcs007,
          l_fmcrcomp             LIKE fmcr_t.fmcrcomp
   DEFINE l_rate                 LIKE fmmp_t.fmmp010
   DEFINE l_fmcs009              LIKE fmcs_t.fmcs009,
          l_fmcs010              LIKE fmcs_t.fmcs010,
          l_fmcs011              LIKE fmcs_t.fmcs011,
          l_fmcs012              LIKE fmcs_t.fmcs012,
          l_fmcs013              LIKE fmcs_t.fmcs013,
          l_fmcs014              LIKE fmcs_t.fmcs014
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
      INPUT ARRAY g_fmdc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmdc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt140_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fmdc_d.getLength()
         
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
            DISPLAY g_fmdc_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_fmdc_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fmdc_d[l_ac].fmdcdocno IS NOT NULL
               AND g_fmdc_d[l_ac].fmdcseq IS NOT NULL
               AND g_fmdc_d[l_ac].fmdcseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmdc_d_t.* = g_fmdc_d[l_ac].*  #BACKUP
               LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*  #BACKUP
               IF NOT afmt140_01_lock_b("fmdc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt140_01_bcl INTO g_fmdc_d[l_ac].fmdcseq2,g_fmdc_d[l_ac].fmdcdocno,g_fmdc_d[l_ac].fmdcseq, 
                      g_fmdc_d[l_ac].fmdc001,g_fmdc_d[l_ac].fmdc002,g_fmdc_d[l_ac].fmdc003,g_fmdc_d[l_ac].fmdc004, 
                      g_fmdc_d[l_ac].fmdc005,g_fmdc_d[l_ac].fmdc006,g_fmdc_d[l_ac].fmdc008,g_fmdc_d[l_ac].fmdc007, 
                      g_fmdc_d[l_ac].fmdc009,g_fmdc_d[l_ac].fmdc010,g_fmdc_d[l_ac].fmdc011,g_fmdc_d[l_ac].fmdc012, 
                      g_fmdc_d[l_ac].fmdc013,g_fmdc_d[l_ac].fmdc014,g_fmdc_d[l_ac].fmdc015,g_fmdc_d[l_ac].fmdc016, 
                      g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc018
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmdc_d_t.fmdcdocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmdc_d_mask_o[l_ac].* =  g_fmdc_d[l_ac].*
                  CALL afmt140_01_fmdc_t_mask()
                  LET g_fmdc_d_mask_n[l_ac].* =  g_fmdc_d[l_ac].*
                  
                  CALL afmt140_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afmt140_01_set_entry_b(l_cmd)
            CALL afmt140_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL afmt140_01_set_entry_b(l_cmd)
            CALL afmt140_01_set_no_entry_b(l_cmd)
            IF cl_null(g_glaa016) THEN
               CALL cl_set_comp_visible("fmdc011,fmdc012",FALSE)
            ELSE
               CALL cl_set_comp_visible("fmdc011,fmdc012",TRUE) 
            END IF
            IF cl_null(g_glaa020) THEN
               CALL cl_set_comp_visible("fmdc013,fmdc014",FALSE)
            ELSE
               CALL cl_set_comp_visible("fmdc013,fmdc014",TRUE) 
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
            INITIALIZE g_fmdc_d_t.* TO NULL
            INITIALIZE g_fmdc_d_o.* TO NULL
            INITIALIZE g_fmdc_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_fmdc_d[l_ac].fmdc003 = "1"
      LET g_fmdc_d[l_ac].fmdc007 = "1"
      LET g_fmdc_d[l_ac].fmdc010 = "0"
      LET g_fmdc_d[l_ac].fmdc012 = "0"
      LET g_fmdc_d[l_ac].fmdc014 = "0"
      LET g_fmdc_d[l_ac].fmdc015 = "2"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_fmdc_d[l_ac].fmdcdocno = g_fmcrdocno
 
            #end add-point
            LET g_fmdc_d_t.* = g_fmdc_d[l_ac].*     #新輸入資料
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmdc_d[li_reproduce_target].* = g_fmdc_d[li_reproduce].*
 
               LET g_fmdc_d[g_fmdc_d.getLength()].fmdcdocno = NULL
               LET g_fmdc_d[g_fmdc_d.getLength()].fmdcseq = NULL
               LET g_fmdc_d[g_fmdc_d.getLength()].fmdcseq2 = NULL
 
            END IF
            
 
            CALL afmt140_01_set_entry_b(l_cmd)
            CALL afmt140_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_fmdc_d[l_ac].fmdcdocno = g_fmcrdocno
            SELECT fmcs004 INTO g_fmdc_d[l_ac].fmdc018 FROM fmcs_t
             WHERE fmcsent = g_enterprise AND fmcsdocno = p_fmcrdocno
               AND fmcsseq = g_fmdc_d[l_ac].fmdcseq
            #預帶項次
            LET g_fmdc_d[l_ac].fmdcseq2 = NULL
            SELECT MAX(fmdcseq2) INTO g_fmdc_d[l_ac].fmdcseq2 FROM fmdc_t
             WHERE fmdcent = g_enterprise
               AND fmdcdocno = g_fmdc_d[l_ac].fmdcdocno
            IF cl_null(g_fmdc_d[l_ac].fmdcseq2) THEN
               LET g_fmdc_d[l_ac].fmdcseq2 = 0
            END IF
            LET g_fmdc_d[l_ac].fmdcseq2 = g_fmdc_d[l_ac].fmdcseq2 + 1  
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
            SELECT COUNT(1) INTO l_count FROM fmdc_t 
             WHERE fmdcent = g_enterprise AND fmdcdocno = g_fmdc_d[l_ac].fmdcdocno
                                       AND fmdcseq = g_fmdc_d[l_ac].fmdcseq
                                       AND fmdcseq2 = g_fmdc_d[l_ac].fmdcseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmdc_d[g_detail_idx].fmdcdocno
               LET gs_keys[2] = g_fmdc_d[g_detail_idx].fmdcseq
               LET gs_keys[3] = g_fmdc_d[g_detail_idx].fmdcseq2
               CALL afmt140_01_insert_b('fmdc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmdc_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmdc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt140_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (fmdcdocno = '", g_fmdc_d[l_ac].fmdcdocno, "' "
                                  ," AND fmdcseq = '", g_fmdc_d[l_ac].fmdcseq, "' "
                                  ," AND fmdcseq2 = '", g_fmdc_d[l_ac].fmdcseq2, "' "
 
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
               
               DELETE FROM fmdc_t
                WHERE fmdcent = g_enterprise AND 
                      fmdcdocno = g_fmdc_d_t.fmdcdocno
                      AND fmdcseq = g_fmdc_d_t.fmdcseq
                      AND fmdcseq2 = g_fmdc_d_t.fmdcseq2
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmdc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL afmt140_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_fmdc_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE afmt140_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_fmdc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmdc_d_t.fmdcdocno
               LET gs_keys[2] = g_fmdc_d_t.fmdcseq
               LET gs_keys[3] = g_fmdc_d_t.fmdcseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt140_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL afmt140_01_delete_b('fmdc_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fmdc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdcseq2
            #add-point:BEFORE FIELD fmdcseq2 name="input.b.page1.fmdcseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdcseq2
            
            #add-point:AFTER FIELD fmdcseq2 name="input.a.page1.fmdcseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmdc_d[g_detail_idx].fmdcdocno IS NOT NULL AND g_fmdc_d[g_detail_idx].fmdcseq IS NOT NULL AND g_fmdc_d[g_detail_idx].fmdcseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmdc_d[g_detail_idx].fmdcdocno != g_fmdc_d_t.fmdcdocno OR g_fmdc_d[g_detail_idx].fmdcseq != g_fmdc_d_t.fmdcseq OR g_fmdc_d[g_detail_idx].fmdcseq2 != g_fmdc_d_t.fmdcseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmdc_t WHERE "||"fmdcent = '" ||g_enterprise|| "' AND "||"fmdcdocno = '"||g_fmdc_d[g_detail_idx].fmdcdocno ||"' AND "|| "fmdcseq = '"||g_fmdc_d[g_detail_idx].fmdcseq ||"' AND "|| "fmdcseq2 = '"||g_fmdc_d[g_detail_idx].fmdcseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdcseq2
            #add-point:ON CHANGE fmdcseq2 name="input.g.page1.fmdcseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdcdocno
            #add-point:BEFORE FIELD fmdcdocno name="input.b.page1.fmdcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdcdocno
            
            #add-point:AFTER FIELD fmdcdocno name="input.a.page1.fmdcdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmdc_d[g_detail_idx].fmdcdocno IS NOT NULL AND g_fmdc_d[g_detail_idx].fmdcseq IS NOT NULL AND g_fmdc_d[g_detail_idx].fmdcseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmdc_d[g_detail_idx].fmdcdocno != g_fmdc_d_t.fmdcdocno OR g_fmdc_d[g_detail_idx].fmdcseq != g_fmdc_d_t.fmdcseq OR g_fmdc_d[g_detail_idx].fmdcseq2 != g_fmdc_d_t.fmdcseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmdc_t WHERE "||"fmdcent = '" ||g_enterprise|| "' AND "||"fmdcdocno = '"||g_fmdc_d[g_detail_idx].fmdcdocno ||"' AND "|| "fmdcseq = '"||g_fmdc_d[g_detail_idx].fmdcseq ||"' AND "|| "fmdcseq2 = '"||g_fmdc_d[g_detail_idx].fmdcseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdcdocno
            #add-point:ON CHANGE fmdcdocno name="input.g.page1.fmdcdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdcseq
            
            #add-point:AFTER FIELD fmdcseq name="input.a.page1.fmdcseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmdc_d[g_detail_idx].fmdcdocno IS NOT NULL AND g_fmdc_d[g_detail_idx].fmdcseq IS NOT NULL AND g_fmdc_d[g_detail_idx].fmdcseq2 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmdc_d[g_detail_idx].fmdcdocno != g_fmdc_d_t.fmdcdocno OR g_fmdc_d[g_detail_idx].fmdcseq != g_fmdc_d_t.fmdcseq OR g_fmdc_d[g_detail_idx].fmdcseq2 != g_fmdc_d_t.fmdcseq2)) THEN   #160822-00008#7  mark
               IF g_fmdc_d[g_detail_idx].fmdcdocno != g_fmdc_d_o.fmdcdocno OR g_fmdc_d[g_detail_idx].fmdcseq != g_fmdc_d_o.fmdcseq OR g_fmdc_d[g_detail_idx].fmdcseq2 != g_fmdc_d_o.fmdcseq2 THEN   #160822-00008#7
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmdc_t WHERE "||"fmdcent = '" ||g_enterprise|| "' AND "||"fmdcdocno = '"||g_fmdc_d[g_detail_idx].fmdcdocno ||"' AND "|| "fmdcseq = '"||g_fmdc_d[g_detail_idx].fmdcseq ||"' AND "|| "fmdcseq2 = '"||g_fmdc_d[g_detail_idx].fmdcseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_fmdc_d[l_ac].fmdcseq) THEN 
#應用 a17 樣板自動產生(Version:2)
                     #欄位存在檢查
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                  
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fmcrdocno   #融资到账单号
                     LET g_chkparam.arg2 = g_fmdc_d[l_ac].fmdcseq
                     
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_fmdcseq") THEN
                        #檢查成功時後續處理
                     ELSE
                        #檢查失敗時後續處理
                        #LET g_fmdc_d[l_ac].fmdcseq = g_fmdc_d_t.fmdcseq  #160822-00008#7  mark
                        LET g_fmdc_d[l_ac].fmdcseq = g_fmdc_d_o.fmdcseq   #160822-00008#7
                        DISPLAY BY NAME g_fmdc_d[l_ac].fmdcseq
                        LET g_fmdc_d[l_ac].fmdc001 = ''
                        LET g_fmdc_d[l_ac].fmdc002 = ''
                        LET g_fmdc_d[l_ac].fmdc004 = ''
                        LET g_fmdc_d[l_ac].fmdc004_desc = ''
                        DISPLAY BY NAME g_fmdc_d[l_ac].fmdc001
                        DISPLAY BY NAME g_fmdc_d[l_ac].fmdc002
                        DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004
                        DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc
                        NEXT FIELD CURRENT
                     END IF
                  
                  
                  END IF 
                  SELECT fmcs001,fmcs002,fmcs007,fmcs004 #融资合同 融资项次 币别
                    INTO g_fmdc_d[l_ac].fmdc001,g_fmdc_d[l_ac].fmdc002,g_fmdc_d[l_ac].fmdc004,g_fmdc_d[l_ac].fmdc018
                    FROM fmcs_t 
                   WHERE fmcsdocno = g_fmcrdocno 
                    AND fmcsseq = g_fmdc_d[l_ac].fmdcseq 
                    AND fmcsent = g_enterprise
                  DISPLAY BY NAME g_fmdc_d[l_ac].fmdc001
                  DISPLAY BY NAME g_fmdc_d[l_ac].fmdc002
                  DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc004
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_fmdc_d[l_ac].fmdc004_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc
               END IF
            END IF
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*   #160822-00008#7
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdcseq
            #add-point:BEFORE FIELD fmdcseq name="input.b.page1.fmdcseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdcseq
            #add-point:ON CHANGE fmdcseq name="input.g.page1.fmdcseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc001
            #add-point:BEFORE FIELD fmdc001 name="input.b.page1.fmdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc001
            
            #add-point:AFTER FIELD fmdc001 name="input.a.page1.fmdc001"
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*   #160822-00008#7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc001
            #add-point:ON CHANGE fmdc001 name="input.g.page1.fmdc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc002
            #add-point:BEFORE FIELD fmdc002 name="input.b.page1.fmdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc002
            
            #add-point:AFTER FIELD fmdc002 name="input.a.page1.fmdc002"
            SELECT nmas002
              INTO g_fmdc_d[l_ac].fmdc018 #支付账户
              FROM nmas_t
             WHERE nmasent = g_enterprise
               AND nmas001 = 
           (SELECT fmcs003 #融资组织
              FROM fmcs_t
             WHERE fmcsent = g_enterprise
               AND fmcsdocno = g_fmcrdocno
               AND fmcsseq = g_fmdc_d[l_ac].fmdcseq)
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc018
            
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*   #160822-00008#7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc002
            #add-point:ON CHANGE fmdc002 name="input.g.page1.fmdc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc003
            #add-point:BEFORE FIELD fmdc003 name="input.b.page1.fmdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc003
            
            #add-point:AFTER FIELD fmdc003 name="input.a.page1.fmdc003"
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc003) THEN  
              CALL  afmt140_01_set_entry_b(l_cmd)
              LET g_fmdc_d[l_ac].fmdc015 = '2'
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc015
            END IF
            IF　cl_null(g_fmdc_d[l_ac].fmdc003) THEN  #当fmdc003为空时，只可录入LC票号
              CALL  afmt140_01_set_entry_b(l_cmd)
              CALL  afmt140_01_set_no_entry_b(l_cmd)
              IF cl_null(g_glaa016) THEN
                 CALL cl_set_comp_visible("fmdc011,fmdc012",FALSE)
              ELSE
                 CALL cl_set_comp_visible("fmdc011,fmdc012",TRUE) 
              END IF
              IF cl_null(g_glaa020) THEN
                 CALL cl_set_comp_visible("fmdc013,fmdc014",FALSE)
              ELSE
                 CALL cl_set_comp_visible("fmdc013,fmdc014",TRUE) 
              END IF
              #将后面的栏位都清空
              LET g_fmdc_d[l_ac].fmdc004 = NULL
              LET g_fmdc_d[l_ac].fmdc004_desc = NULL
              LET g_fmdc_d[l_ac].fmdc005 = NULL
              LET g_fmdc_d[l_ac].fmdc006 = NULL
              LET g_fmdc_d[l_ac].fmdc007 = NULL
              LET g_fmdc_d[l_ac].fmdc009 = NULL
              LET g_fmdc_d[l_ac].fmdc011 = NULL
              LET g_fmdc_d[l_ac].fmdc013 = NULL
              LET g_fmdc_d[l_ac].fmdc010 = 0
              LET g_fmdc_d[l_ac].fmdc012 = 0
              LET g_fmdc_d[l_ac].fmdc014 = 0
              LET g_fmdc_d[l_ac].fmdc015 = NULL 
              LET g_fmdc_d[l_ac].fmdc016 = NULL
              LET g_fmdc_d[l_ac].fmdc016_desc = NULL
              LET g_fmdc_d[l_ac].fmdc017 = NULL
              LET g_fmdc_d[l_ac].fmdc017_desc = NULL
              #LET g_fmdc_d[l_ac].fmdc018 = NULL
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc005
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc006
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc007
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc009
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc011
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc013
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc010
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc012
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc014
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc015
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc016
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc016_desc
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017
              DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017_desc
              #DISPLAY BY NAME g_fmdc_d[l_ac].fmdc018
            END IF
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc003) AND cl_null(g_fmdc_d_t.fmdc003) THEN
               CALL  afmt140_01_set_entry_b(l_cmd)
               LET g_fmdc_d[l_ac].fmdc008 = NULL
               DISPLAY BY NAME g_fmdc_d[l_ac].fmdc008 #清空lc票号
               LET g_fmdc_d[l_ac].fmdc015 = '2'
               DISPLAY BY NAME g_fmdc_d[l_ac].fmdc015
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc003
            #add-point:ON CHANGE fmdc003 name="input.g.page1.fmdc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc004
            
            #add-point:AFTER FIELD fmdc004 name="input.a.page1.fmdc004"
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#36  add
               #設定g_chkparam.*的參數
               #LET g_chkparam.arg1 = g_fmdc_d[l_ac].fmdc004
               CALL afmt140_01_get_glaa()
               LET g_chkparam.arg1 = g_glaa026  #币别参照表
               LET g_chkparam.arg2 = g_fmdc_d[l_ac].fmdc004  #币别
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"  #160318-00025#36  add
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooai001") THEN
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  #LET g_fmdc_d[l_ac].fmdc004 = g_fmdc_d_t.fmdc004  #160822-00008#7  mark
                  LET g_fmdc_d[l_ac].fmdc004 = g_fmdc_d_o.fmdc004   #160822-00008#7
                  DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004
                  NEXT FIELD CURRENT
               END IF


            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmdc_d[l_ac].fmdc004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc
            
            
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc004) AND  NOT cl_null(g_fmdc_d[l_ac].fmdc005) 
                AND NOT cl_null(g_fmdc_d[l_ac].fmdc001) AND  NOT cl_null(g_fmdc_d[l_ac].fmdc002)   THEN
                SELECT fmcs008,fmcs010,fmcs007,fmcrcomp
                  INTO l_fmcs008,l_fmcs010,l_fmcs007,l_fmcrcomp  #原币，本币金额 币种 法人
                  FROM fmcs_t,fmcr_t
                 WHERE fmcsent = fmcrent
                   AND fmcsdocno = fmcrdocno
                   AND fmcsent = g_enterprise
                   AND fmcsdocno = g_fmcrdocno
                   AND fmcsseq = g_fmdc_d[l_ac].fmdcseq
                   
#                SELECT glaald
#                  INTO l_glaald #帐别
#                  FROM glaa_t
#                 WHERE glaaent = g_enterprise
#                   AND glaacomp = l_fmcrcomp   #法人
#                   AND glaa001 = g_fmdc_d[l_ac].fmdc004     #币别
                #取汇率   
                IF g_fmdc_d[l_ac].fmdc004  = l_fmcs007 THEN
                   LET g_fmdc_d[l_ac].fmdc006 = (g_fmdc_d[l_ac].fmdc005/100)*l_fmcs008
                ELSE 
                   CALL s_aooi160_get_exrate('2',g_glaald,g_fmcrdocdt,g_fmdc_d[l_ac].fmdc004,g_glaa001,0,g_glaa025)  # 2：帳別,账套,日期,交易币,使用币别,数量,汇率采用
                        RETURNING l_rate
                   #取得金额fmcs006
                   LET g_fmdc_d[l_ac].fmdc006 = (g_fmdc_d[l_ac].fmdc005/100)*l_fmcs010*l_rate  #本币金额*汇率*（利率值/100）
                   
                   #金额取位
                   CALL s_curr_round_ld('1',g_glaald,g_fmdc_d[l_ac].fmdc004,g_fmdc_d[l_ac].fmdc006,2) #(1.取币种参照表号,帐别，币种，金额1，2：按金额设定)
                        RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc006
                   END IF
                DISPLAY BY NAME g_fmdc_d[l_ac].fmdc006
            END IF
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*   #160822-00008#7


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc004
            #add-point:BEFORE FIELD fmdc004 name="input.b.page1.fmdc004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmdc_d[l_ac].fmdc004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc
            
            SELECT fmcs001,fmcs002,fmcs007 #融资合同 融资项次 币别
              INTO g_fmdc_d[l_ac].fmdc001,g_fmdc_d[l_ac].fmdc002,g_fmdc_d[l_ac].fmdc004
              FROM fmcs_t 
             WHERE fmcsdocno = g_fmcrdocno 
              AND fmcsseq = g_fmdc_d[l_ac].fmdcseq 
              AND fmcsent = g_enterprise
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc001
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc002
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmdc_d[l_ac].fmdc004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc004
            #add-point:ON CHANGE fmdc004 name="input.g.page1.fmdc004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmdc_d[l_ac].fmdc005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmdc005
            END IF 
 
 
 
            #add-point:AFTER FIELD fmdc005 name="input.a.page1.fmdc005"
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc005) THEN 
                 
            END IF 
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc004) AND  NOT cl_null(g_fmdc_d[l_ac].fmdc005) 
                AND NOT cl_null(g_fmdc_d[l_ac].fmdc001) AND  NOT cl_null(g_fmdc_d[l_ac].fmdc002)   THEN
                SELECT fmcs008,fmcs010,fmcs007,fmcrcomp
                  INTO l_fmcs008,l_fmcs010,l_fmcs007,l_fmcrcomp  #原币，本币金额 币种 法人
                  FROM fmcs_t,fmcr_t
                 WHERE fmcsent = fmcrent
                   AND fmcsdocno = fmcrdocno
                   AND fmcsent = g_enterprise
                   AND fmcsdocno = g_fmcrdocno
                   AND fmcsseq = g_fmdc_d[l_ac].fmdcseq
                   
#                SELECT glaald
#                  INTO l_glaald #帐别
#                  FROM glaa_t
#                 WHERE glaaent = g_enterprise
#                   AND glaacomp = l_fmcrcomp   #法人
#                   AND glaa001 = g_fmdc_d[l_ac].fmdc004     #币别
                #取汇率   
                IF g_fmdc_d[l_ac].fmdc004  = l_fmcs007 THEN
                   LET g_fmdc_d[l_ac].fmdc006 = (g_fmdc_d[l_ac].fmdc005/100)*l_fmcs008
                ELSE 
                   CALL s_aooi160_get_exrate('2',g_glaald,g_fmcrdocdt,g_fmdc_d[l_ac].fmdc004,g_glaa001,0,g_glaa025)  # 2：帳別,账套,日期,交易币,使用币别,数量,汇率采用
                        RETURNING l_rate
                   #取得金额fmcs006
                   LET g_fmdc_d[l_ac].fmdc006 = (g_fmdc_d[l_ac].fmdc005/100)*l_fmcs010*l_rate  #本币金额*汇率*（利率值/100）
                   
                   #金额取位
                   CALL s_curr_round_ld('1',g_glaald,g_fmdc_d[l_ac].fmdc004,g_fmdc_d[l_ac].fmdc006,2) #(1.取币种参照表号,帐别，币种，金额1，2：按金额设定)
                        RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc006
                   END IF
                DISPLAY BY NAME g_fmdc_d[l_ac].fmdc006
            END IF
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*   #160822-00008#7


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc005
            #add-point:BEFORE FIELD fmdc005 name="input.b.page1.fmdc005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc005
            #add-point:ON CHANGE fmdc005 name="input.g.page1.fmdc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmdc_d[l_ac].fmdc006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmdc006
            END IF 
 
 
 
            #add-point:AFTER FIELD fmdc006 name="input.a.page1.fmdc006"
            #IF NOT cl_null(g_fmdc_d[l_ac].fmdc006) AND (g_fmdc_d[l_ac].fmdc006 <> g_fmdc_d_t.fmdc006 OR cl_null(g_fmdc_d_t.fmdc006)) THEN   #160822-00008#7  mark
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc006) AND (g_fmdc_d[l_ac].fmdc006 <> g_fmdc_d_o.fmdc006 OR cl_null(g_fmdc_d_o.fmdc006)) THEN    #160822-00008#7
                #汇率，本币，汇率二，本币二，汇率三，本币三
                  SELECT fmcs009,fmcs010,fmcs011,fmcs012,fmcs013,fmcs014
                    INTO l_fmcs009,l_fmcs010,l_fmcs011,l_fmcs012,l_fmcs013,l_fmcs014
                    FROM fmcs_t
                   WHERE fmcsent = g_enterprise
                     AND fmcsdocno = g_fmcrdocno 
                     AND fmcsseq = g_fmdc_d[l_ac].fmdcseq
                  LET g_fmdc_d[l_ac].fmdc009 = l_fmcs009 #汇率
                  LET g_fmdc_d[l_ac].fmdc011 = l_fmcs011 #汇率二
                  LET g_fmdc_d[l_ac].fmdc013 = l_fmcs013 #汇率三
                  CALL afmt140_01_get_glaa()
               #本币一
               IF NOT cl_null(l_fmcs010) THEN
                  LET g_fmdc_d[l_ac].fmdc010 = g_fmdc_d[l_ac].fmdc006  * l_fmcs009 #融资费用本币=融资到账本币*费率值/100
                  #金额取位
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmdc_d[l_ac].fmdc010,2) #(1.取币种参照表号,帐别，币种1，金额1，2：按金额设定)
                        RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc010
               ELSE
                  LET g_fmdc_d[l_ac].fmdc010 = 0
               END IF
               #本币2
               IF NOT cl_null(l_fmcs012) THEN
                  LET g_fmdc_d[l_ac].fmdc012 = g_fmdc_d[l_ac].fmdc006  * l_fmcs011 #融资费用本币二=融资到账本币二*费率值/100
                  #金额取位
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmdc_d[l_ac].fmdc012,2) #(1.取币种参照表号,帐别，币种2，金额2，2：按金额设定)
                           RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc012
               ELSE
                  LET g_fmdc_d[l_ac].fmdc012 = 0
               END IF
               #本币3
               IF NOT cl_null(l_fmcs014) THEN
                  LET g_fmdc_d[l_ac].fmdc014 = g_fmdc_d[l_ac].fmdc006  * l_fmcs012 #融资费用本币三=融资到账本币三*费率值/100
                  #金额取位  
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmdc_d[l_ac].fmdc014,2) #(1.取币种参照表号,帐别，币种3，金额3，2：按金额设定)
                           RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc014
               ELSE
                  LET g_fmdc_d[l_ac].fmdc014 = 0
               END IF
            END IF 
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*   #160822-00008#7


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc006
            #add-point:BEFORE FIELD fmdc006 name="input.b.page1.fmdc006"
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc004) AND  NOT cl_null(g_fmdc_d[l_ac].fmdc005) 
                AND NOT cl_null(g_fmdc_d[l_ac].fmdc001) AND  NOT cl_null(g_fmdc_d[l_ac].fmdc002)   THEN
#                SELECT fmcs008,fmcs010,fmcs007,fmcrcomp
#                  INTO l_fmcs008,l_fmcs010,l_fmcs007,l_fmcrcomp  #原币，本币金额 币种 法人
#                  FROM fmcs_t,fmcr_t
#                 WHERE fmcsent = fmcrent
#                   AND fmcsdocno = fmcrdocno
#                   AND fmcsent = g_enterprise
#                   AND fmcsdocno = g_fmcrdocno
#                   AND fmcsseq = g_fmdc_d[l_ac].fmdcseq
                   
#                SELECT glaald
#                  INTO l_glaald #帐别
#                  FROM glaa_t
#                 WHERE glaaent = g_enterprise
#                   AND glaacomp = l_fmcrcomp   #法人
#                   AND glaa001 = g_fmdc_d[l_ac].fmdc004     #币别
#                #取汇率   
#                IF g_fmdc_d[l_ac].fmdc004  = l_fmcs007 THEN
#                   LET g_fmdc_d[l_ac].fmdc006 = (g_fmdc_d[l_ac].fmdc005/100)*l_fmcs008
#                ELSE 
#                   CALL s_aooi160_get_exrate('2',g_glaald,g_fmcrdocdt,g_fmdc_d[l_ac].fmdc004,g_glaa001,0,g_glaa025)  # 2：帳別,账套,日期,交易币,使用币别,数量,汇率采用
#                        RETURNING l_rate
#                   #取得金额fmcs006
#                   LET g_fmdc_d[l_ac].fmdc006 = (g_fmdc_d[l_ac].fmdc005/100)*l_fmcs010*l_rate  #本币金额*汇率*（利率值/100）
#                   
#                   #金额取位
#                   CALL s_curr_round_ld('1',g_glaald,g_fmdc_d[l_ac].fmdc004,g_fmdc_d[l_ac].fmdc006,2) #(1.取币种参照表号,帐别，币种，金额1，2：按金额设定)
#                        RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc006
#                   END IF
#                DISPLAY BY NAME g_fmdc_d[l_ac].fmdc006
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc006
            #add-point:ON CHANGE fmdc006 name="input.g.page1.fmdc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc008
            #add-point:BEFORE FIELD fmdc008 name="input.b.page1.fmdc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc008
            
            #add-point:AFTER FIELD fmdc008 name="input.a.page1.fmdc008"
            LET g_fmdc_d_o.* = g_fmdc_d[l_ac].*   #160822-00008#7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc008
            #add-point:ON CHANGE fmdc008 name="input.g.page1.fmdc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc007
            #add-point:BEFORE FIELD fmdc007 name="input.b.page1.fmdc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc007
            
            #add-point:AFTER FIELD fmdc007 name="input.a.page1.fmdc007"
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc003) AND cl_null(g_fmdc_d[l_ac].fmdc007) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = "afm-00209" #:当费用种类不为空时，支付方式不可为空
                LET g_errparam.extend = g_fmdc_d[l_ac].fmdc007
                LET g_errparam.popup = TRUE
                CALL cl_err()
                NEXT FIELD fmdc007
            END IF
            IF g_fmdc_d[l_ac].fmdc007 = '2' THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_fmcrdocno #融资到账单
               LET g_chkparam.arg2 = g_fmdc_d[l_ac].fmdcseq
               LET g_chkparam.arg3 = g_fmdc_d[l_ac].fmdc004 #币种
               IF cl_chk_exist("v_fmdc007") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_fmdc_d[l_ac].fmdc007 = g_fmdc_d_t.fmdc007
                  DISPLAY BY NAME g_fmdc_d[l_ac].fmdc007
                  NEXT FIELD CURRENT
               END IF
            END IF
#            #汇率，本币，汇率二，本币二，汇率三，本币三
#            SELECT fmcs009,fmcs010,fmcs011,fmcs012,fmcs013,fmcs014
#              INTO l_fmcs009,l_fmcs010,l_fmcs011,l_fmcs012,l_fmcs013,l_fmcs014
#              FROM fmcs_t
#             WHERE fmcsent = g_enterprise
#               AND fmcsdocno = g_fmcrdocno 
#               AND fmcsseq = g_fmdc_d[l_ac].fmdcseq
#            LET g_fmdc_d[l_ac].fmdc009 = l_fmcs009 #汇率
#            LET g_fmdc_d[l_ac].fmdc011 = l_fmcs011 #汇率二
#            LET g_fmdc_d[l_ac].fmdc013 = l_fmcs013 #汇率三
#            CALL afmt140_01_get_glaa()
#            #本币一
#            IF NOT cl_null(l_fmcs010) THEN
#               LET g_fmdc_d[l_ac].fmdc010 = l_fmcs010 * g_fmdc_d[l_ac].fmdc005/100 #融资费用本币=融资到账本币*费率值/100
#               #金额取位
#               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmdc_d[l_ac].fmdc010,2) #(1.取币种参照表号,帐别，币种1，金额1，2：按金额设定)
#                     RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc010
#            ELSE
#               LET g_fmdc_d[l_ac].fmdc010 = 0
#            END IF
#            #本币2
#            IF NOT cl_null(l_fmcs012) THEN
#               LET g_fmdc_d[l_ac].fmdc012 = l_fmcs012 * g_fmdc_d[l_ac].fmdc005/100 #融资费用本币二=融资到账本币二*费率值/100
#               #金额取位
#               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmdc_d[l_ac].fmdc012,2) #(1.取币种参照表号,帐别，币种2，金额2，2：按金额设定)
#                        RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc012
#            ELSE
#               LET g_fmdc_d[l_ac].fmdc012 = 0
#            END IF
#            #本币3
#            IF NOT cl_null(l_fmcs014) THEN
#               LET g_fmdc_d[l_ac].fmdc014 = l_fmcs014 * g_fmdc_d[l_ac].fmdc005/100 #融资费用本币三=融资到账本币三*费率值/100
#               #金额取位  
#               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmdc_d[l_ac].fmdc014,2) #(1.取币种参照表号,帐别，币种3，金额3，2：按金额设定)
#                        RETURNING g_sub_success,g_errno,g_fmdc_d[l_ac].fmdc014
#            ELSE
#               LET g_fmdc_d[l_ac].fmdc014 = 0
#            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc007
            #add-point:ON CHANGE fmdc007 name="input.g.page1.fmdc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc015
            #add-point:BEFORE FIELD fmdc015 name="input.b.page1.fmdc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc015
            
            #add-point:AFTER FIELD fmdc015 name="input.a.page1.fmdc015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc015
            #add-point:ON CHANGE fmdc015 name="input.g.page1.fmdc015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc016
            
            #add-point:AFTER FIELD fmdc016 name="input.a.page1.fmdc016"
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc016) THEN 
               CALL afmt140_01_fmdc016_chk()
               IF NOT cl_null(g_errno) THEN
                  DISPLAY '' TO fmdc004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_fmdc_d[l_ac].fmdc016
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fmdc_d[l_ac].fmdc016 = g_fmdc_d_t.fmdc016
                  LET g_fmdc_d[l_ac].fmdc017 = ''
                  DISPLAY g_fmdc_d[l_ac].fmdc017 TO s_detail1[l_ac].fmdc017
                  NEXT FIELD CURRENT            
               END IF 
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc016
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmdc_d[l_ac].fmdc016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc016_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc016
            #add-point:BEFORE FIELD fmdc016 name="input.b.page1.fmdc016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc016
            #add-point:ON CHANGE fmdc016 name="input.g.page1.fmdc016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc017
            
            #add-point:AFTER FIELD fmdc017 name="input.a.page1.fmdc017"
#            IF NOT cl_null(g_fmdc_d[l_ac].fmdc017) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fmdc_d[l_ac].fmdc017
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_nmai002_1") THEN
#                  #檢查成功時後續處理
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF

#               CALL afmt140_01_fmdc017_chk()
#               IF NOT cl_null(g_errno) THEN
#                  IF l_cmd = 'a' THEN 
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_fmdc_d[l_ac].fmdc017
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_fmdc_d[l_ac].fmdc017 = ''
#                     LET g_fmdc_d[l_ac].fmdc017_desc = ''
#                  ELSE
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_fmdc_d[l_ac].fmdc017
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_fmdc_d[l_ac].fmdc017 = g_fmdc_d_t.fmdc017
#                     LET g_fmdc_d[l_ac].fmdc017_desc = g_fmdc_d_t.fmdc017_desc
#                  END IF 
#                  DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc017_desc
#                  NEXT FIELD fmdc017
#               END IF
#
#            END IF 
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc017
#            CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail002=? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_fmdc_d[l_ac].fmdc017_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017_desc
            
            LET g_fmdc_d[l_ac].fmdc017_desc = ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017_desc
            IF NOT cl_null(g_fmdc_d[l_ac].fmdc017) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fmdc_d[l_ac].fmdc017 != g_fmdc_d_t.fmdc017 OR g_fmdc_d_t.fmdc017 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_fmdc_d[l_ac].fmdc017
                  LET g_chkparam.arg2 = g_glaa005
                  IF NOT cl_chk_exist("v_nmai002") THEN                  
                     LET g_fmdc_d[l_ac].fmdc017 = g_fmdc_d_t.fmdc017
                     CALL s_desc_get_nmail004_desc(g_glaa005,g_fmdc_d[l_ac].fmdc017) RETURNING g_fmdc_d[l_ac].fmdc017_desc
                     DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_nmail004_desc(g_glaa005,g_fmdc_d[l_ac].fmdc017) RETURNING g_fmdc_d[l_ac].fmdc017_desc
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc017_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc017
            #add-point:BEFORE FIELD fmdc017 name="input.b.page1.fmdc017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc017
            #add-point:ON CHANGE fmdc017 name="input.g.page1.fmdc017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmdc018
            #add-point:BEFORE FIELD fmdc018 name="input.b.page1.fmdc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmdc018
            
            #add-point:AFTER FIELD fmdc018 name="input.a.page1.fmdc018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmdc018
            #add-point:ON CHANGE fmdc018 name="input.g.page1.fmdc018"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmdcseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdcseq2
            #add-point:ON ACTION controlp INFIELD fmdcseq2 name="input.c.page1.fmdcseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdcdocno
            #add-point:ON ACTION controlp INFIELD fmdcdocno name="input.c.page1.fmdcdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdcseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdcseq
            #add-point:ON ACTION controlp INFIELD fmdcseq name="input.c.page1.fmdcseq"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmdc_d[l_ac].fmdcseq             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_fmcrdocno #s融资到账单号


            CALL q_fmdcseq()                                #呼叫開窗

            LET g_fmdc_d[l_ac].fmdcseq = g_qryparam.return1
            LET g_fmdc_d[l_ac].fmdc001 = g_qryparam.return2#融资单
            LET g_fmdc_d[l_ac].fmdc002 = g_qryparam.return3#项次
            LET g_fmdc_d[l_ac].fmdc004 = g_qryparam.return4#币别

            DISPLAY g_fmdc_d[l_ac].fmdcseq TO fmdcseq              #
            DISPLAY g_fmdc_d[l_ac].fmdc001 TO fmdc001
            DISPLAY g_fmdc_d[l_ac].fmdc002 TO fmdc002
            DISPLAY g_fmdc_d[l_ac].fmdc004 TO fmdc004
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmdc_d[l_ac].fmdc004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc
            
            NEXT FIELD fmdcseq                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc001
            #add-point:ON ACTION controlp INFIELD fmdc001 name="input.c.page1.fmdc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc002
            #add-point:ON ACTION controlp INFIELD fmdc002 name="input.c.page1.fmdc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc003
            #add-point:ON ACTION controlp INFIELD fmdc003 name="input.c.page1.fmdc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc004
            #add-point:ON ACTION controlp INFIELD fmdc004 name="input.c.page1.fmdc004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmdc_d[l_ac].fmdc004             #給予default值

            #給予arg
            CALL afmt140_01_get_glaa()
            LET g_qryparam.arg1 = g_glaa026 #s 币别参照表

            CALL q_ooaj002_5()
            #CALL q_ooaj002_5()                                #呼叫開窗

            LET g_fmdc_d[l_ac].fmdc004 = g_qryparam.return1              

            DISPLAY g_fmdc_d[l_ac].fmdc004 TO fmdc004              #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmdc_d[l_ac].fmdc004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc004_desc

            NEXT FIELD fmdc004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc005
            #add-point:ON ACTION controlp INFIELD fmdc005 name="input.c.page1.fmdc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc006
            #add-point:ON ACTION controlp INFIELD fmdc006 name="input.c.page1.fmdc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc008
            #add-point:ON ACTION controlp INFIELD fmdc008 name="input.c.page1.fmdc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc007
            #add-point:ON ACTION controlp INFIELD fmdc007 name="input.c.page1.fmdc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc015
            #add-point:ON ACTION controlp INFIELD fmdc015 name="input.c.page1.fmdc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc016
            #add-point:ON ACTION controlp INFIELD fmdc016 name="input.c.page1.fmdc016"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmdc_d[l_ac].fmdc016             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " nmaj002 = '2'"


            CALL q_nmaj001()                                #呼叫開窗

            LET g_fmdc_d[l_ac].fmdc016 = g_qryparam.return1              

            DISPLAY g_fmdc_d[l_ac].fmdc016 TO fmdc016              #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc016
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmdc_d[l_ac].fmdc016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc016_desc

            NEXT FIELD fmdc016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc017
            #add-point:ON ACTION controlp INFIELD fmdc017 name="input.c.page1.fmdc017"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmdc_d[l_ac].fmdc017             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #s
            CALL afmt140_01_get_glaa()
            
            LET g_qryparam.where = " nmai001 = '",g_glaa005,"'"


            CALL q_nmai002()                                #呼叫開窗

            LET g_fmdc_d[l_ac].fmdc017 = g_qryparam.return1              

            DISPLAY g_fmdc_d[l_ac].fmdc017 TO fmdc017              #
            CALL s_desc_get_nmail004_desc(g_glaa005,g_fmdc_d[l_ac].fmdc017) RETURNING g_fmdc_d[l_ac].fmdc017_desc
            DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017_desc

            NEXT FIELD fmdc017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmdc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmdc018
            #add-point:ON ACTION controlp INFIELD fmdc018 name="input.c.page1.fmdc018"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE afmt140_01_bcl
               LET INT_FLAG = 0
               LET g_fmdc_d[l_ac].* = g_fmdc_d_t.*
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
               LET g_errparam.extend = g_fmdc_d[l_ac].fmdcdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmdc_d[l_ac].* = g_fmdc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt140_01_fmdc_t_mask_restore('restore_mask_o')
 
               UPDATE fmdc_t SET (fmdcseq2,fmdcdocno,fmdcseq,fmdc001,fmdc002,fmdc003,fmdc004,fmdc005, 
                   fmdc006,fmdc008,fmdc007,fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc016, 
                   fmdc017,fmdc018) = (g_fmdc_d[l_ac].fmdcseq2,g_fmdc_d[l_ac].fmdcdocno,g_fmdc_d[l_ac].fmdcseq, 
                   g_fmdc_d[l_ac].fmdc001,g_fmdc_d[l_ac].fmdc002,g_fmdc_d[l_ac].fmdc003,g_fmdc_d[l_ac].fmdc004, 
                   g_fmdc_d[l_ac].fmdc005,g_fmdc_d[l_ac].fmdc006,g_fmdc_d[l_ac].fmdc008,g_fmdc_d[l_ac].fmdc007, 
                   g_fmdc_d[l_ac].fmdc009,g_fmdc_d[l_ac].fmdc010,g_fmdc_d[l_ac].fmdc011,g_fmdc_d[l_ac].fmdc012, 
                   g_fmdc_d[l_ac].fmdc013,g_fmdc_d[l_ac].fmdc014,g_fmdc_d[l_ac].fmdc015,g_fmdc_d[l_ac].fmdc016, 
                   g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc018)
                WHERE fmdcent = g_enterprise AND
                  fmdcdocno = g_fmdc_d_t.fmdcdocno #項次   
                  AND fmdcseq = g_fmdc_d_t.fmdcseq  
                  AND fmdcseq2 = g_fmdc_d_t.fmdcseq2  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmdc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmdc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmdc_d[g_detail_idx].fmdcdocno
               LET gs_keys_bak[1] = g_fmdc_d_t.fmdcdocno
               LET gs_keys[2] = g_fmdc_d[g_detail_idx].fmdcseq
               LET gs_keys_bak[2] = g_fmdc_d_t.fmdcseq
               LET gs_keys[3] = g_fmdc_d[g_detail_idx].fmdcseq2
               LET gs_keys_bak[3] = g_fmdc_d_t.fmdcseq2
               CALL afmt140_01_update_b('fmdc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_fmdc_d_t)
                     LET g_log2 = util.JSON.stringify(g_fmdc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt140_01_fmdc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL afmt140_01_unlock_b("fmdc_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmdc_d[l_ac].* = g_fmdc_d_t.*
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
               LET g_fmdc_d[li_reproduce_target].* = g_fmdc_d[li_reproduce].*
 
               LET g_fmdc_d[li_reproduce_target].fmdcdocno = NULL
               LET g_fmdc_d[li_reproduce_target].fmdcseq = NULL
               LET g_fmdc_d[li_reproduce_target].fmdcseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmdc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmdc_d.getLength()+1
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
               NEXT FIELD fmdcseq2
 
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
      IF INT_FLAG OR cl_null(g_fmdc_d[g_detail_idx].fmdcdocno) THEN
         CALL g_fmdc_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_fmdc_d[g_detail_idx].* = g_fmdc_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE afmt140_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt140_01_delete()
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
   FOR li_idx = 1 TO g_fmdc_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT afmt140_01_lock_b("fmdc_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("fmdc_t","") THEN
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
   
   FOR li_idx = 1 TO g_fmdc_d.getLength()
      IF g_fmdc_d[li_idx].fmdcdocno IS NOT NULL
         AND g_fmdc_d[li_idx].fmdcseq IS NOT NULL
         AND g_fmdc_d[li_idx].fmdcseq2 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM fmdc_t
          WHERE fmdcent = g_enterprise AND 
                fmdcdocno = g_fmdc_d[li_idx].fmdcdocno
                AND fmdcseq = g_fmdc_d[li_idx].fmdcseq
                AND fmdcseq2 = g_fmdc_d[li_idx].fmdcseq2
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmdc_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_fmdc_d_t.fmdcdocno
               LET gs_keys[2] = g_fmdc_d_t.fmdcseq
               LET gs_keys[3] = g_fmdc_d_t.fmdcseq2
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL afmt140_01_delete_b('fmdc_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt140_01_set_pk_array()
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
   CALL afmt140_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt140_01_b_fill(p_wc2)              #BODY FILL UP
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
   LET p_wc2 = " fmdcdocno = '",g_fmcrdocno,"'"
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.fmdcseq2,t0.fmdcdocno,t0.fmdcseq,t0.fmdc001,t0.fmdc002,t0.fmdc003, 
       t0.fmdc004,t0.fmdc005,t0.fmdc006,t0.fmdc008,t0.fmdc007,t0.fmdc009,t0.fmdc010,t0.fmdc011,t0.fmdc012, 
       t0.fmdc013,t0.fmdc014,t0.fmdc015,t0.fmdc016,t0.fmdc017,t0.fmdc018 ,t1.ooail003 ,t2.nmajl003 FROM fmdc_t t0", 
 
               "",
                              " LEFT JOIN ooail_t t1 ON t1.ooailent="||g_enterprise||" AND t1.ooail001=t0.fmdc004 AND t1.ooail002='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t2 ON t2.nmajlent="||g_enterprise||" AND t2.nmajl001=t0.fmdc016 AND t2.nmajl002='"||g_dlang||"' ",
 
               " WHERE t0.fmdcent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("fmdc_t"),
                      " ORDER BY t0.fmdcdocno,t0.fmdcseq,t0.fmdcseq2"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmdc_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmt140_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmt140_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_fmdc_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_fmdc_d[l_ac].fmdcseq2,g_fmdc_d[l_ac].fmdcdocno,g_fmdc_d[l_ac].fmdcseq, 
       g_fmdc_d[l_ac].fmdc001,g_fmdc_d[l_ac].fmdc002,g_fmdc_d[l_ac].fmdc003,g_fmdc_d[l_ac].fmdc004,g_fmdc_d[l_ac].fmdc005, 
       g_fmdc_d[l_ac].fmdc006,g_fmdc_d[l_ac].fmdc008,g_fmdc_d[l_ac].fmdc007,g_fmdc_d[l_ac].fmdc009,g_fmdc_d[l_ac].fmdc010, 
       g_fmdc_d[l_ac].fmdc011,g_fmdc_d[l_ac].fmdc012,g_fmdc_d[l_ac].fmdc013,g_fmdc_d[l_ac].fmdc014,g_fmdc_d[l_ac].fmdc015, 
       g_fmdc_d[l_ac].fmdc016,g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc018,g_fmdc_d[l_ac].fmdc004_desc, 
       g_fmdc_d[l_ac].fmdc016_desc
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
      
      CALL afmt140_01_detail_show()      
 
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
   
 
   
   CALL g_fmdc_d.deleteElement(g_fmdc_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fmdc_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_fmdc_d.getLength() THEN
      LET l_ac = g_fmdc_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmdc_d.getLength()
      LET g_fmdc_d_mask_o[l_ac].* =  g_fmdc_d[l_ac].*
      CALL afmt140_01_fmdc_t_mask()
      LET g_fmdc_d_mask_n[l_ac].* =  g_fmdc_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_fmdc_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE afmt140_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmt140_01_detail_show()
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
 
{<section id="afmt140_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt140_01_set_entry_b(p_cmd)                                                  
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

   CALL cl_set_comp_entry("fmdc004,fmdc005,fmdc006,fmdc007,fmdc016,fmdc017",TRUE)

   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="afmt140_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt140_01_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"

   CALL cl_set_comp_entry("fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc018",FALSE)
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
   
   IF (p_cmd = 'a' OR p_cmd = 'u') AND  cl_null(g_fmdc_d[l_ac].fmdc003) THEN
      CALL cl_set_comp_entry("fmdc004,fmdc005,fmdc006,fmdc007,fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc016,fmdc017,fmdc018",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt140_01_default_search()
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
      LET ls_wc = ls_wc, " fmdcdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fmdcseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fmdcseq2 = '", g_argv[03], "' AND "
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
 
{<section id="afmt140_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt140_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "fmdc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'fmdc_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM fmdc_t
          WHERE fmdcent = g_enterprise AND
            fmdcdocno = ps_keys_bak[1] AND fmdcseq = ps_keys_bak[2] AND fmdcseq2 = ps_keys_bak[3]
         
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
         CALL g_fmdc_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt140_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "fmdc_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO fmdc_t
                  (fmdcent,
                   fmdcdocno,fmdcseq,fmdcseq2
                   ,fmdc001,fmdc002,fmdc003,fmdc004,fmdc005,fmdc006,fmdc008,fmdc007,fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc016,fmdc017,fmdc018) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmdc_d[l_ac].fmdc001,g_fmdc_d[l_ac].fmdc002,g_fmdc_d[l_ac].fmdc003,g_fmdc_d[l_ac].fmdc004, 
                       g_fmdc_d[l_ac].fmdc005,g_fmdc_d[l_ac].fmdc006,g_fmdc_d[l_ac].fmdc008,g_fmdc_d[l_ac].fmdc007, 
                       g_fmdc_d[l_ac].fmdc009,g_fmdc_d[l_ac].fmdc010,g_fmdc_d[l_ac].fmdc011,g_fmdc_d[l_ac].fmdc012, 
                       g_fmdc_d[l_ac].fmdc013,g_fmdc_d[l_ac].fmdc014,g_fmdc_d[l_ac].fmdc015,g_fmdc_d[l_ac].fmdc016, 
                       g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc018)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmdc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt140_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "fmdc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "fmdc_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE fmdc_t 
         SET (fmdcdocno,fmdcseq,fmdcseq2
              ,fmdc001,fmdc002,fmdc003,fmdc004,fmdc005,fmdc006,fmdc008,fmdc007,fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc015,fmdc016,fmdc017,fmdc018) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmdc_d[l_ac].fmdc001,g_fmdc_d[l_ac].fmdc002,g_fmdc_d[l_ac].fmdc003,g_fmdc_d[l_ac].fmdc004, 
                  g_fmdc_d[l_ac].fmdc005,g_fmdc_d[l_ac].fmdc006,g_fmdc_d[l_ac].fmdc008,g_fmdc_d[l_ac].fmdc007, 
                  g_fmdc_d[l_ac].fmdc009,g_fmdc_d[l_ac].fmdc010,g_fmdc_d[l_ac].fmdc011,g_fmdc_d[l_ac].fmdc012, 
                  g_fmdc_d[l_ac].fmdc013,g_fmdc_d[l_ac].fmdc014,g_fmdc_d[l_ac].fmdc015,g_fmdc_d[l_ac].fmdc016, 
                  g_fmdc_d[l_ac].fmdc017,g_fmdc_d[l_ac].fmdc018) 
         WHERE fmdcent = g_enterprise AND fmdcdocno = ps_keys_bak[1] AND fmdcseq = ps_keys_bak[2] AND fmdcseq2 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmdc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmdc_t:",SQLERRMESSAGE 
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
 
{<section id="afmt140_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt140_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL afmt140_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "fmdc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt140_01_bcl USING g_enterprise,
                                       g_fmdc_d[g_detail_idx].fmdcdocno,g_fmdc_d[g_detail_idx].fmdcseq, 
                                           g_fmdc_d[g_detail_idx].fmdcseq2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt140_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt140_01_unlock_b(ps_table)
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
      CLOSE afmt140_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION afmt140_01_modify_detail_chk(ps_record)
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
         LET ls_return = "fmdcseq2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="afmt140_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION afmt140_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="afmt140_01.mask_functions" >}
&include "erp/afm/afmt140_01_mask.4gl"
 
{</section>}
 
{<section id="afmt140_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt140_01_set_pk_array()
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
   LET g_pk_array[1].values = g_fmdc_d[l_ac].fmdcdocno
   LET g_pk_array[1].column = 'fmdcdocno'
   LET g_pk_array[2].values = g_fmdc_d[l_ac].fmdcseq
   LET g_pk_array[2].column = 'fmdcseq'
   LET g_pk_array[3].values = g_fmdc_d[l_ac].fmdcseq2
   LET g_pk_array[3].column = 'fmdcseq2'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt140_01.state_change" >}
   
 
{</section>}
 
{<section id="afmt140_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afmt140_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 根据法人取主帐别，取得币别，币别二，币别三用来取位
# Memo...........:
# Usage..........: CALL afmt140_01_get_glaa()

# Date & Author..: 2105/11/24 By muping
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt140_01_get_glaa()
#取得法人
      SELECT fmcrcomp
        INTO g_fmcrcomp
        FROM fmcr_t
       WHERE fmcrdocno = g_fmcrdocno
         AND fmcrent = g_enterprise       
      #取得主帐别
      SELECT glaald  INTO g_glaald  #法人对应的主帐别的帐别
        FROM glaa_t 
       WHERE glaacomp = g_fmcrcomp 
         AND glaaent = g_enterprise
         AND glaa014 = 'Y'
       
      #取得使用币别
      SELECT glaa001,glaa026,glaa025,glaa005 #使用币别,币别参照表,汇率采用
        INTO g_glaa001,g_glaa026,g_glaa025,g_glaa005
        FROM glaa_t 
       WHERE glaald = g_glaald #主帐别
         AND glaacomp = g_fmcrcomp #法人
         AND glaaent = g_enterprise
      SELECT glaa016   #币别2
        INTO g_glaa016
        FROM glaa_t 
       WHERE glaald = g_glaald #主帐别
         AND glaa015 = 'Y'
         AND glaacomp = g_fmcrcomp #法人
         AND glaaent = g_enterprise
      SELECT glaa020    #币别3
        INTO g_glaa020
        FROM glaa_t 
       WHERE glaald = g_glaald #主帐别
         AND glaa019 = 'Y'
         AND glaacomp = g_fmcrcomp #法人
         AND glaaent = g_enterprise
            

END FUNCTION

################################################################################
# Descriptions...: 检核银行存提码
# Memo...........:
# Usage..........: CALL afmt140_01_fmdc016_chk()
#                  RETURNING 回传参数

# Date & Author..: 2015/11/4By muping
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt140_01_fmdc016_chk()
DEFINE l_nmajstus               LIKE nmaj_t.nmajstus
DEFINE l_nmaj002                LIKE nmaj_t.nmaj002
   
   LET g_errno = ''
   
   #取得法人
   SELECT fmcrcomp
     INTO g_fmcrcomp
     FROM fmcr_t
    WHERE fmcrdocno = g_fmcrdocno
      AND fmcrent = g_enterprise       
   
   SELECT nmajstus,nmaj002 INTO l_nmajstus,l_nmaj002
     FROM nmaj_t
    WHERE nmajent = g_enterprise
      AND nmaj001 = g_fmdc_d[l_ac].fmdc016

   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00017'
      WHEN l_nmajstus = 'N'       LET g_errno = 'anm-00016'
      WHEN l_nmaj002 <> '2'       LET g_errno = 'anm-00215' #只可输入存提为[2:提出]的存提码
   END CASE
   
   #帶值
   SELECT glaa005 INTO g_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_fmcrcomp  #法人
      AND glaa014 = 'Y'
      
   IF NOT cl_null(g_fmdc_d[l_ac].fmdc016) THEN
      SELECT nmad003 INTO g_fmdc_d[l_ac].fmdc017
        FROM nmad_t
       WHERE nmadent = g_enterprise
         AND nmad001 = g_glaa005
         AND nmad002 = g_fmdc_d[l_ac].fmdc016
      DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_fmdc_d[l_ac].fmdc017
      CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail002=? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_fmdc_d[l_ac].fmdc017_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_fmdc_d[l_ac].fmdc017_desc
   END IF

END FUNCTION

################################################################################
# Descriptions...: 现金变动码检核
# Memo...........:
# Usage..........: CALL afmt140_01_fmdc017_chk()

# Date & Author..: 2015/11/24 By muping
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt140_01_fmdc017_chk()
DEFINE l_nmaistus         LIKE nmai_t.nmaistus
   
   LET g_errno = ''
   #存在nmai002  且其現金變動參照表存在于单头法人的主帐套的glaa005   且為有效資料   
   SELECT nmaistus INTO l_nmaistus
     FROM nmai_t
    WHERE nmaient = g_enterprise
      AND nmai001 = g_glaa005
      AND nmai002 = g_fmdc_d[l_ac].fmdc017
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00034'
      WHEN l_nmaistus = 'N'       LET g_errno = 'anm-00035'
   END CASE
END FUNCTION

 
{</section>}
 
