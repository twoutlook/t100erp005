#該程式未解開Section, 採用最新樣板產出!
{<section id="aist310_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-10-18 18:01:26), PR版次:0001(2016-10-21 16:14:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aist310_03
#+ Description: 銷貨發票查詢
#+ Creator....: 02040(2016-10-18 17:45:21)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="aist310_03.global" >}
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
PRIVATE TYPE type_g_isat_d RECORD
       isat007 LIKE isat_t.isat007, 
   isat003 LIKE isat_t.isat003, 
   isat004 LIKE isat_t.isat004, 
   isat006 LIKE isat_t.isat006, 
   isat002 LIKE isat_t.isat002, 
   isat103 LIKE isat_t.isat103, 
   isat104 LIKE isat_t.isat104, 
   isat105 LIKE isat_t.isat105, 
   isat113 LIKE isat_t.isat113, 
   isat114 LIKE isat_t.isat114, 
   isat115 LIKE isat_t.isat115, 
   isat014 LIKE isat_t.isat014, 
   isat106 LIKE isat_t.isat106, 
   isat107 LIKE isat_t.isat107, 
   isatdocno LIKE isat_t.isatdocno, 
   isaf035 LIKE type_t.chr20, 
   isatseq LIKE isat_t.isatseq, 
   isatcomp LIKE isat_t.isatcomp
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdkdocno  LIKE xmdk_t.xmdkdocno
#end add-point
 
#模組變數(Module Variables)
DEFINE g_isat_d          DYNAMIC ARRAY OF type_g_isat_d #單身變數
DEFINE g_isat_d_t        type_g_isat_d                  #單身備份
DEFINE g_isat_d_o        type_g_isat_d                  #單身備份
DEFINE g_isat_d_mask_o   DYNAMIC ARRAY OF type_g_isat_d #單身變數
DEFINE g_isat_d_mask_n   DYNAMIC ARRAY OF type_g_isat_d #單身變數
 
      
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
 
{<section id="aist310_03.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aist310_03(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_xmdkdocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_xmdkdocno  LIKE xmdk_t.xmdkdocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_xmdkdocno = p_xmdkdocno
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT isat007,isat003,isat004,isat006,isat002,isat103,isat104,isat105,isat113, 
       isat114,isat115,isat014,isat106,isat107,isatdocno,isatseq,isatcomp FROM isat_t WHERE isatent=?  
       AND isatcomp=? AND isatseq=? AND isat003=? AND isat004=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aist310_03_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aist310_03 WITH FORM cl_ap_formpath("ais","aist310_03")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aist310_03_init()   
 
   #進入選單 Menu (="N")
   CALL aist310_03_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aist310_03
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aist310_03.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aist310_03_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE ls_ProgFile STRING
   DEFINE ldoc_prog          om.DomDocument
   DEFINE lwin_curr          ui.Window
   DEFINE lfrm_curr          ui.Form
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
###這段是為了顯示串查action多語系(prog_aist310), 需重新載入AXM的4ad，才能讀到多語系
   LET ls_ProgFile = os.Path.join(os.Path.join(FGL_GETENV("AXM"),"4ad"),g_lang CLIPPED)
   LET ls_ProgFile = os.Path.join(ls_ProgFile, g_code||".4ad")
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   IF lfrm_curr IS NOT NULL THEN
      CALL lfrm_curr.loadActionDefaults(ls_progfile)
      DISPLAY "INFO: 4ad for Form Level = " || ls_progfile
   END IF   
####    
   CALL cl_set_combo_scc('isat014','9716')
   #end add-point
   
   CALL aist310_03_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aist310_03_ui_dialog()
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
         CALL g_isat_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aist310_03_init()
      END IF
   
      CALL aist310_03_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isat_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aist310_03_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aist310
                  LET g_action_choice="prog_aist310"
                  IF cl_auth_chk_act("prog_aist310") THEN
                     
                     #add-point:ON ACTION prog_aist310 name="menu.detail_show.page1_sub.prog_aist310"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aist310'
               LET la_param.param[1] = g_isat_d[l_ac].isatcomp
               LET la_param.param[2] = g_isat_d[l_ac].isatdocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
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
            CALL aist310_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aist310_03_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aist310_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aist310_03_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aist310_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aist310_03_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aist310_03_insert()
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
               CALL aist310_03_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isat_d)
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
            CALL aist310_03_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aist310_03_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aist310_03_set_pk_array()
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
 
{<section id="aist310_03.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aist310_03_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   RETURN            #161012-00055#2 add
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isat_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON isat007,isat003,isat004,isat006,isat002,isat103,isat104,isat105,isat113,isat114, 
          isat115,isat014,isat106,isat107,isatdocno,isaf035,isatseq,isatcomp 
 
         FROM s_detail1[1].isat007,s_detail1[1].isat003,s_detail1[1].isat004,s_detail1[1].isat006,s_detail1[1].isat002, 
             s_detail1[1].isat103,s_detail1[1].isat104,s_detail1[1].isat105,s_detail1[1].isat113,s_detail1[1].isat114, 
             s_detail1[1].isat115,s_detail1[1].isat014,s_detail1[1].isat106,s_detail1[1].isat107,s_detail1[1].isatdocno, 
             s_detail1[1].isaf035,s_detail1[1].isatseq,s_detail1[1].isatcomp 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat007
            #add-point:BEFORE FIELD isat007 name="query.b.page1.isat007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat007
            
            #add-point:AFTER FIELD isat007 name="query.a.page1.isat007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat007
            #add-point:ON ACTION controlp INFIELD isat007 name="query.c.page1.isat007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat003
            #add-point:BEFORE FIELD isat003 name="query.b.page1.isat003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat003
            
            #add-point:AFTER FIELD isat003 name="query.a.page1.isat003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat003
            #add-point:ON ACTION controlp INFIELD isat003 name="query.c.page1.isat003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat004
            #add-point:BEFORE FIELD isat004 name="query.b.page1.isat004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat004
            
            #add-point:AFTER FIELD isat004 name="query.a.page1.isat004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat004
            #add-point:ON ACTION controlp INFIELD isat004 name="query.c.page1.isat004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat006
            #add-point:BEFORE FIELD isat006 name="query.b.page1.isat006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat006
            
            #add-point:AFTER FIELD isat006 name="query.a.page1.isat006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat006
            #add-point:ON ACTION controlp INFIELD isat006 name="query.c.page1.isat006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat002
            #add-point:BEFORE FIELD isat002 name="query.b.page1.isat002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat002
            
            #add-point:AFTER FIELD isat002 name="query.a.page1.isat002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat002
            #add-point:ON ACTION controlp INFIELD isat002 name="query.c.page1.isat002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat103
            #add-point:BEFORE FIELD isat103 name="query.b.page1.isat103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat103
            
            #add-point:AFTER FIELD isat103 name="query.a.page1.isat103"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat103
            #add-point:ON ACTION controlp INFIELD isat103 name="query.c.page1.isat103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat104
            #add-point:BEFORE FIELD isat104 name="query.b.page1.isat104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat104
            
            #add-point:AFTER FIELD isat104 name="query.a.page1.isat104"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat104
            #add-point:ON ACTION controlp INFIELD isat104 name="query.c.page1.isat104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat105
            #add-point:BEFORE FIELD isat105 name="query.b.page1.isat105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat105
            
            #add-point:AFTER FIELD isat105 name="query.a.page1.isat105"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat105
            #add-point:ON ACTION controlp INFIELD isat105 name="query.c.page1.isat105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat113
            #add-point:BEFORE FIELD isat113 name="query.b.page1.isat113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat113
            
            #add-point:AFTER FIELD isat113 name="query.a.page1.isat113"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat113
            #add-point:ON ACTION controlp INFIELD isat113 name="query.c.page1.isat113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat114
            #add-point:BEFORE FIELD isat114 name="query.b.page1.isat114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat114
            
            #add-point:AFTER FIELD isat114 name="query.a.page1.isat114"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat114
            #add-point:ON ACTION controlp INFIELD isat114 name="query.c.page1.isat114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat115
            #add-point:BEFORE FIELD isat115 name="query.b.page1.isat115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat115
            
            #add-point:AFTER FIELD isat115 name="query.a.page1.isat115"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat115
            #add-point:ON ACTION controlp INFIELD isat115 name="query.c.page1.isat115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat014
            #add-point:BEFORE FIELD isat014 name="query.b.page1.isat014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat014
            
            #add-point:AFTER FIELD isat014 name="query.a.page1.isat014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat014
            #add-point:ON ACTION controlp INFIELD isat014 name="query.c.page1.isat014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat106
            #add-point:BEFORE FIELD isat106 name="query.b.page1.isat106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat106
            
            #add-point:AFTER FIELD isat106 name="query.a.page1.isat106"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat106
            #add-point:ON ACTION controlp INFIELD isat106 name="query.c.page1.isat106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat107
            #add-point:BEFORE FIELD isat107 name="query.b.page1.isat107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat107
            
            #add-point:AFTER FIELD isat107 name="query.a.page1.isat107"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isat107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat107
            #add-point:ON ACTION controlp INFIELD isat107 name="query.c.page1.isat107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isatdocno
            #add-point:BEFORE FIELD isatdocno name="query.b.page1.isatdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isatdocno
            
            #add-point:AFTER FIELD isatdocno name="query.a.page1.isatdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isatdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isatdocno
            #add-point:ON ACTION controlp INFIELD isatdocno name="query.c.page1.isatdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf035
            #add-point:BEFORE FIELD isaf035 name="query.b.page1.isaf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf035
            
            #add-point:AFTER FIELD isaf035 name="query.a.page1.isaf035"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isaf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf035
            #add-point:ON ACTION controlp INFIELD isaf035 name="query.c.page1.isaf035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isatseq
            #add-point:BEFORE FIELD isatseq name="query.b.page1.isatseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isatseq
            
            #add-point:AFTER FIELD isatseq name="query.a.page1.isatseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isatseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isatseq
            #add-point:ON ACTION controlp INFIELD isatseq name="query.c.page1.isatseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isatcomp
            #add-point:BEFORE FIELD isatcomp name="query.b.page1.isatcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isatcomp
            
            #add-point:AFTER FIELD isatcomp name="query.a.page1.isatcomp"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.isatcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isatcomp
            #add-point:ON ACTION controlp INFIELD isatcomp name="query.c.page1.isatcomp"
            
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
    
   CALL aist310_03_b_fill(g_wc2)
 
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
 
{<section id="aist310_03.insert" >}
#+ 資料新增
PRIVATE FUNCTION aist310_03_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aist310_03_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.modify" >}
#+ 資料修改
PRIVATE FUNCTION aist310_03_modify()
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
   RETURN            #161012-00055#2 add
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
      INPUT ARRAY g_isat_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_isat_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aist310_03_b_fill(g_wc2)
            LET g_detail_cnt = g_isat_d.getLength()
         
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
            DISPLAY g_isat_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_isat_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_isat_d[l_ac].isatcomp IS NOT NULL
               AND g_isat_d[l_ac].isatseq IS NOT NULL
               AND g_isat_d[l_ac].isat003 IS NOT NULL
               AND g_isat_d[l_ac].isat004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_isat_d_t.* = g_isat_d[l_ac].*  #BACKUP
               LET g_isat_d_o.* = g_isat_d[l_ac].*  #BACKUP
               IF NOT aist310_03_lock_b("isat_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aist310_03_bcl INTO g_isat_d[l_ac].isat007,g_isat_d[l_ac].isat003,g_isat_d[l_ac].isat004, 
                      g_isat_d[l_ac].isat006,g_isat_d[l_ac].isat002,g_isat_d[l_ac].isat103,g_isat_d[l_ac].isat104, 
                      g_isat_d[l_ac].isat105,g_isat_d[l_ac].isat113,g_isat_d[l_ac].isat114,g_isat_d[l_ac].isat115, 
                      g_isat_d[l_ac].isat014,g_isat_d[l_ac].isat106,g_isat_d[l_ac].isat107,g_isat_d[l_ac].isatdocno, 
                      g_isat_d[l_ac].isatseq,g_isat_d[l_ac].isatcomp
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_isat_d_t.isatcomp,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_isat_d_mask_o[l_ac].* =  g_isat_d[l_ac].*
                  CALL aist310_03_isat_t_mask()
                  LET g_isat_d_mask_n[l_ac].* =  g_isat_d[l_ac].*
                  
                  CALL aist310_03_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aist310_03_set_entry_b(l_cmd)
            CALL aist310_03_set_no_entry_b(l_cmd)
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
            INITIALIZE g_isat_d_t.* TO NULL
            INITIALIZE g_isat_d_o.* TO NULL
            INITIALIZE g_isat_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_isat_d[l_ac].isat103 = "0"
      LET g_isat_d[l_ac].isat104 = "0"
      LET g_isat_d[l_ac].isat105 = "0"
      LET g_isat_d[l_ac].isat113 = "0"
      LET g_isat_d[l_ac].isat114 = "0"
      LET g_isat_d[l_ac].isat115 = "0"
      LET g_isat_d[l_ac].isat106 = "0"
      LET g_isat_d[l_ac].isat107 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_isat_d_t.* = g_isat_d[l_ac].*     #新輸入資料
            LET g_isat_d_o.* = g_isat_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_isat_d[li_reproduce_target].* = g_isat_d[li_reproduce].*
 
               LET g_isat_d[g_isat_d.getLength()].isatcomp = NULL
               LET g_isat_d[g_isat_d.getLength()].isatseq = NULL
               LET g_isat_d[g_isat_d.getLength()].isat003 = NULL
               LET g_isat_d[g_isat_d.getLength()].isat004 = NULL
 
            END IF
            
 
            CALL aist310_03_set_entry_b(l_cmd)
            CALL aist310_03_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM isat_t 
             WHERE isatent = g_enterprise AND isatcomp = g_isat_d[l_ac].isatcomp
                                       AND isatseq = g_isat_d[l_ac].isatseq
                                       AND isat003 = g_isat_d[l_ac].isat003
                                       AND isat004 = g_isat_d[l_ac].isat004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isat_d[g_detail_idx].isatcomp
               LET gs_keys[2] = g_isat_d[g_detail_idx].isatseq
               LET gs_keys[3] = g_isat_d[g_detail_idx].isat003
               LET gs_keys[4] = g_isat_d[g_detail_idx].isat004
               CALL aist310_03_insert_b('isat_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_isat_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isat_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aist310_03_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (isatcomp = '", g_isat_d[l_ac].isatcomp, "' "
                                  ," AND isatseq = '", g_isat_d[l_ac].isatseq, "' "
                                  ," AND isat003 = '", g_isat_d[l_ac].isat003, "' "
                                  ," AND isat004 = '", g_isat_d[l_ac].isat004, "' "
 
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
               
               DELETE FROM isat_t
                WHERE isatent = g_enterprise AND 
                      isatcomp = g_isat_d_t.isatcomp
                      AND isatseq = g_isat_d_t.isatseq
                      AND isat003 = g_isat_d_t.isat003
                      AND isat004 = g_isat_d_t.isat004
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "isat_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aist310_03_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_isat_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aist310_03_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_isat_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isat_d_t.isatcomp
               LET gs_keys[2] = g_isat_d_t.isatseq
               LET gs_keys[3] = g_isat_d_t.isat003
               LET gs_keys[4] = g_isat_d_t.isat004
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aist310_03_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aist310_03_delete_b('isat_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_isat_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isatcomp
            #add-point:BEFORE FIELD isatcomp name="input.b.page1.isatcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isatcomp
            
            #add-point:AFTER FIELD isatcomp name="input.a.page1.isatcomp"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_isat_d[g_detail_idx].isatcomp IS NOT NULL AND g_isat_d[g_detail_idx].isatseq IS NOT NULL AND g_isat_d[g_detail_idx].isat003 IS NOT NULL AND g_isat_d[g_detail_idx].isat004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_isat_d[g_detail_idx].isatcomp != g_isat_d_t.isatcomp OR g_isat_d[g_detail_idx].isatseq != g_isat_d_t.isatseq OR g_isat_d[g_detail_idx].isat003 != g_isat_d_t.isat003 OR g_isat_d[g_detail_idx].isat004 != g_isat_d_t.isat004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isat_t WHERE "||"isatent = " ||g_enterprise|| " AND "||"isatcomp = '"||g_isat_d[g_detail_idx].isatcomp ||"' AND "|| "isatseq = '"||g_isat_d[g_detail_idx].isatseq ||"' AND "|| "isat003 = '"||g_isat_d[g_detail_idx].isat003 ||"' AND "|| "isat004 = '"||g_isat_d[g_detail_idx].isat004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isatcomp
            #add-point:ON CHANGE isatcomp name="input.g.page1.isatcomp"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.isatcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isatcomp
            #add-point:ON ACTION controlp INFIELD isatcomp name="input.c.page1.isatcomp"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aist310_03_bcl
               LET INT_FLAG = 0
               LET g_isat_d[l_ac].* = g_isat_d_t.*
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
               LET g_errparam.extend = g_isat_d[l_ac].isatcomp 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_isat_d[l_ac].* = g_isat_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aist310_03_isat_t_mask_restore('restore_mask_o')
 
               UPDATE isat_t SET (isat007,isat003,isat004,isat006,isat002,isat103,isat104,isat105,isat113, 
                   isat114,isat115,isat014,isat106,isat107,isatdocno,isatseq,isatcomp) = (g_isat_d[l_ac].isat007, 
                   g_isat_d[l_ac].isat003,g_isat_d[l_ac].isat004,g_isat_d[l_ac].isat006,g_isat_d[l_ac].isat002, 
                   g_isat_d[l_ac].isat103,g_isat_d[l_ac].isat104,g_isat_d[l_ac].isat105,g_isat_d[l_ac].isat113, 
                   g_isat_d[l_ac].isat114,g_isat_d[l_ac].isat115,g_isat_d[l_ac].isat014,g_isat_d[l_ac].isat106, 
                   g_isat_d[l_ac].isat107,g_isat_d[l_ac].isatdocno,g_isat_d[l_ac].isatseq,g_isat_d[l_ac].isatcomp) 
 
                WHERE isatent = g_enterprise AND
                  isatcomp = g_isat_d_t.isatcomp #項次   
                  AND isatseq = g_isat_d_t.isatseq  
                  AND isat003 = g_isat_d_t.isat003  
                  AND isat004 = g_isat_d_t.isat004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isat_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "isat_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_isat_d[g_detail_idx].isatcomp
               LET gs_keys_bak[1] = g_isat_d_t.isatcomp
               LET gs_keys[2] = g_isat_d[g_detail_idx].isatseq
               LET gs_keys_bak[2] = g_isat_d_t.isatseq
               LET gs_keys[3] = g_isat_d[g_detail_idx].isat003
               LET gs_keys_bak[3] = g_isat_d_t.isat003
               LET gs_keys[4] = g_isat_d[g_detail_idx].isat004
               LET gs_keys_bak[4] = g_isat_d_t.isat004
               CALL aist310_03_update_b('isat_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_isat_d_t)
                     LET g_log2 = util.JSON.stringify(g_isat_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aist310_03_isat_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aist310_03_unlock_b("isat_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_isat_d[l_ac].* = g_isat_d_t.*
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
               LET g_isat_d[li_reproduce_target].* = g_isat_d[li_reproduce].*
 
               LET g_isat_d[li_reproduce_target].isatcomp = NULL
               LET g_isat_d[li_reproduce_target].isatseq = NULL
               LET g_isat_d[li_reproduce_target].isat003 = NULL
               LET g_isat_d[li_reproduce_target].isat004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_isat_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_isat_d.getLength()+1
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
               NEXT FIELD isat007
 
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
      IF INT_FLAG OR cl_null(g_isat_d[g_detail_idx].isatcomp) THEN
         CALL g_isat_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_isat_d[g_detail_idx].* = g_isat_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aist310_03_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aist310_03_delete()
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
   RETURN            #161012-00055#2 add
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_isat_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aist310_03_lock_b("isat_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("isat_t","") THEN
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
   
   FOR li_idx = 1 TO g_isat_d.getLength()
      IF g_isat_d[li_idx].isatcomp IS NOT NULL
         AND g_isat_d[li_idx].isatseq IS NOT NULL
         AND g_isat_d[li_idx].isat003 IS NOT NULL
         AND g_isat_d[li_idx].isat004 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM isat_t
          WHERE isatent = g_enterprise AND 
                isatcomp = g_isat_d[li_idx].isatcomp
                AND isatseq = g_isat_d[li_idx].isatseq
                AND isat003 = g_isat_d[li_idx].isat003
                AND isat004 = g_isat_d[li_idx].isat004
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isat_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_isat_d_t.isatcomp
               LET gs_keys[2] = g_isat_d_t.isatseq
               LET gs_keys[3] = g_isat_d_t.isat003
               LET gs_keys[4] = g_isat_d_t.isat004
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aist310_03_delete_b('isat_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aist310_03_set_pk_array()
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
   CALL aist310_03_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aist310_03_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   LET p_wc2 = "isag002 = '",g_xmdkdocno,"'"
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.isat007,t0.isat003,t0.isat004,t0.isat006,t0.isat002,t0.isat103,t0.isat104, 
       t0.isat105,t0.isat113,t0.isat114,t0.isat115,t0.isat014,t0.isat106,t0.isat107,t0.isatdocno,t0.isatseq, 
       t0.isatcomp  FROM isat_t t0",
               "",
               
               " WHERE t0.isatent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = "SELECT DISTINCT isaf035 FROM isaf_t ",
               " WHERE isafent = ",g_enterprise,
               "   AND isafdocno = ? "
   PREPARE aist310_03_isaf_pr FROM g_sql  
   
   LET g_Sql = "SELECT DISTINCT t0.isat007,t0.isat003,t0.isat004,t0.isat006,t0.isat002, ",
               "                t0.isat103,t0.isat104,t0.isat105,t0.isat113,t0.isat114, ",
               "                t0.isat115,t0.isat014,t0.isat106,t0.isat107,t0.isatdocno, ",
               "                t0.isatseq,t0.isatcomp ",
               "  FROM isaf_t,isag_t,isat_t t0",
               "  WHERE isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno AND isafstus <> 'X' ",
               "    AND isafent = t0.isatent AND isafcomp = t0.isatcomp AND isafdocno = t0.isatdocno AND t0.isat014 IN ('11','13','21','23') ",
               "    AND isagent = ? AND isag001 = '11' AND ",p_wc2               
          
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("isat_t"),
                      " ORDER BY t0.isatcomp,t0.isatseq,t0.isat003,t0.isat004"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"isat_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aist310_03_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aist310_03_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isat_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_isat_d[l_ac].isat007,g_isat_d[l_ac].isat003,g_isat_d[l_ac].isat004,g_isat_d[l_ac].isat006, 
       g_isat_d[l_ac].isat002,g_isat_d[l_ac].isat103,g_isat_d[l_ac].isat104,g_isat_d[l_ac].isat105,g_isat_d[l_ac].isat113, 
       g_isat_d[l_ac].isat114,g_isat_d[l_ac].isat115,g_isat_d[l_ac].isat014,g_isat_d[l_ac].isat106,g_isat_d[l_ac].isat107, 
       g_isat_d[l_ac].isatdocno,g_isat_d[l_ac].isatseq,g_isat_d[l_ac].isatcomp
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      EXECUTE aist310_03_isaf_pr USING g_isat_d[l_ac].isatdocno INTO g_isat_d[l_ac].isaf035
      #end add-point
      
      CALL aist310_03_detail_show()      
 
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
   
 
   
   CALL g_isat_d.deleteElement(g_isat_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_isat_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_isat_d.getLength() THEN
      LET l_ac = g_isat_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_isat_d.getLength()
      LET g_isat_d_mask_o[l_ac].* =  g_isat_d[l_ac].*
      CALL aist310_03_isat_t_mask()
      LET g_isat_d_mask_n[l_ac].* =  g_isat_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   FREE aist310_03_isaf_pr
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_isat_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aist310_03_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aist310_03_detail_show()
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
 
{<section id="aist310_03.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aist310_03_set_entry_b(p_cmd)                                                  
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
 
{<section id="aist310_03.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aist310_03_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aist310_03.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aist310_03_default_search()
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
      LET ls_wc = ls_wc, " isatcomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " isatseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " isat003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " isat004 = '", g_argv[04], "' AND "
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
 
{<section id="aist310_03.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aist310_03_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "isat_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'isat_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM isat_t
          WHERE isatent = g_enterprise AND
            isatcomp = ps_keys_bak[1] AND isatseq = ps_keys_bak[2] AND isat003 = ps_keys_bak[3] AND isat004 = ps_keys_bak[4]
         
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
         CALL g_isat_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aist310_03_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "isat_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO isat_t
                  (isatent,
                   isatcomp,isatseq,isat003,isat004
                   ,isat007,isat006,isat002,isat103,isat104,isat105,isat113,isat114,isat115,isat014,isat106,isat107,isatdocno) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_isat_d[l_ac].isat007,g_isat_d[l_ac].isat006,g_isat_d[l_ac].isat002,g_isat_d[l_ac].isat103, 
                       g_isat_d[l_ac].isat104,g_isat_d[l_ac].isat105,g_isat_d[l_ac].isat113,g_isat_d[l_ac].isat114, 
                       g_isat_d[l_ac].isat115,g_isat_d[l_ac].isat014,g_isat_d[l_ac].isat106,g_isat_d[l_ac].isat107, 
                       g_isat_d[l_ac].isatdocno)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "isat_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aist310_03_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "isat_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "isat_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE isat_t 
         SET (isatcomp,isatseq,isat003,isat004
              ,isat007,isat006,isat002,isat103,isat104,isat105,isat113,isat114,isat115,isat014,isat106,isat107,isatdocno) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_isat_d[l_ac].isat007,g_isat_d[l_ac].isat006,g_isat_d[l_ac].isat002,g_isat_d[l_ac].isat103, 
                  g_isat_d[l_ac].isat104,g_isat_d[l_ac].isat105,g_isat_d[l_ac].isat113,g_isat_d[l_ac].isat114, 
                  g_isat_d[l_ac].isat115,g_isat_d[l_ac].isat014,g_isat_d[l_ac].isat106,g_isat_d[l_ac].isat107, 
                  g_isat_d[l_ac].isatdocno) 
         WHERE isatent = g_enterprise AND isatcomp = ps_keys_bak[1] AND isatseq = ps_keys_bak[2] AND isat003 = ps_keys_bak[3] AND isat004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isat_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "isat_t:",SQLERRMESSAGE 
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
 
{<section id="aist310_03.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aist310_03_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aist310_03_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "isat_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aist310_03_bcl USING g_enterprise,
                                       g_isat_d[g_detail_idx].isatcomp,g_isat_d[g_detail_idx].isatseq, 
                                           g_isat_d[g_detail_idx].isat003,g_isat_d[g_detail_idx].isat004 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aist310_03_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aist310_03_unlock_b(ps_table)
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
      CLOSE aist310_03_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aist310_03_modify_detail_chk(ps_record)
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
         LET ls_return = "isat007"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aist310_03.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aist310_03_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aist310_03.mask_functions" >}
&include "erp/ais/aist310_03_mask.4gl"
 
{</section>}
 
{<section id="aist310_03.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aist310_03_set_pk_array()
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
   LET g_pk_array[1].values = g_isat_d[l_ac].isatcomp
   LET g_pk_array[1].column = 'isatcomp'
   LET g_pk_array[2].values = g_isat_d[l_ac].isatseq
   LET g_pk_array[2].column = 'isatseq'
   LET g_pk_array[3].values = g_isat_d[l_ac].isat003
   LET g_pk_array[3].column = 'isat003'
   LET g_pk_array[4].values = g_isat_d[l_ac].isat004
   LET g_pk_array[4].column = 'isat004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aist310_03.state_change" >}
   
 
{</section>}
 
{<section id="aist310_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aist310_03.other_function" readonly="Y" >}

 
{</section>}
 
