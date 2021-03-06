#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt390_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2013-12-12 16:05:03), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000241
#+ Filename...: aglt390_01
#+ Description: 金額來源科目
#+ Creator....: 02298(2013-12-11 14:57:18)
#+ Modifier...: 02298 -SD/PR- 00000
 
{</section>}
 
{<section id="aglt390_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#151103-00017#1  2015/11/04  by 02599  当修改时离开科目栏位开启核算项维护窗口维护核算项
#151117-00009#1  2015/11/18  By 02599  当有账套时，科目检查改为检查是否存在于glad_t中
#160321-00016#30 2016/03/25  By Jessy  修正azzi920重複定義之錯誤訊息
#160318-00005#18  2016/03/29 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
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
PRIVATE TYPE type_g_glan_d RECORD
       glanstus LIKE glan_t.glanstus, 
   glandocno LIKE glan_t.glandocno, 
   glanld LIKE glan_t.glanld, 
   glanseq LIKE glan_t.glanseq, 
   glan001 LIKE glan_t.glan001, 
   lc_subject LIKE type_t.chr500, 
   glan002 LIKE glan_t.glan002, 
   edit2 LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaldocno           LIKE glal_t.glaldocno
DEFINE g_glalld              LIKE glal_t.glalld
DEFINE g_glaldocdt           LIKE glal_t.glaldocdt
DEFINE g_glaacomp            LIKE glaa_t.glaacomp
DEFINE g_prog                 LIKE type_t.chr10
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa002             LIKE glaa_t.glaa002
DEFINE g_glaa003             LIKE glaa_t.glaa003
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_glan_m        RECORD
       glan003 LIKE glan_t.glan003, 
       glan003_desc LIKE type_t.chr80, 
       glan004 LIKE glan_t.glan004, 
       glan004_desc LIKE type_t.chr80, 
       glan005 LIKE glan_t.glan005, 
       glan005_desc LIKE type_t.chr80, 
       glan006 LIKE glan_t.glan006, 
       glan006_desc LIKE type_t.chr80, 
       glan007 LIKE glan_t.glan007, 
       glan007_desc LIKE type_t.chr80, 
       glan008 LIKE glan_t.glan008, 
       glan008_desc LIKE type_t.chr80, 
       glan009 LIKE glan_t.glan009, 
       glan009_desc LIKE type_t.chr80, 
       glan010 LIKE glan_t.glan010, 
       glan010_desc LIKE type_t.chr80, 
       glan011 LIKE glan_t.glan011, 
       glan011_desc LIKE type_t.chr80, 
       glan013 LIKE glan_t.glan013, 
       glan013_desc LIKE type_t.chr80, 
       glan014 LIKE glan_t.glan014, 
       glan014_desc LIKE type_t.chr80,
       glan051 LIKE glan_t.glan051,
       glan052 LIKE glan_t.glan052, 
       glan052_desc LIKE type_t.chr80,
       glan053 LIKE glan_t.glan053, 
       glan053_desc LIKE type_t.chr80
       END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_glan_d          DYNAMIC ARRAY OF type_g_glan_d #單身變數
DEFINE g_glan_d_t        type_g_glan_d                  #單身備份
DEFINE g_glan_d_o        type_g_glan_d                  #單身備份
DEFINE g_glan_d_mask_o   DYNAMIC ARRAY OF type_g_glan_d #單身變數
DEFINE g_glan_d_mask_n   DYNAMIC ARRAY OF type_g_glan_d #單身變數
 
      
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
 
{<section id="aglt390_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aglt390_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_glaldocno,p_glalld,p_glaldocdt,p_cmd,p_prog
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_glaldocno          LIKE glal_t.glaldocno     #单据编号
   DEFINE p_glalld             LIKE glal_t.glalld        #帐别 
   DEFINE p_glaldocdt          LIKE glal_t.glaldocdt     #单据日期
   DEFINE p_cmd                LIKE type_t.chr1          #主程式操作状态
   DEFINE p_prog               LIKE type_t.chr10         #执行程式
   DEFINE l_n                  LIKE type_t.num5  
   DEFINE l_glalstus           LIKE glal_t.glalstus
   DEFINE l_success            LIKE type_t.num5
   DEFINE l_glaa013            LIKE glaa_t.glaa013   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_glaldocno = p_glaldocno
   LET g_glalld = p_glalld
   LET g_glaldocdt = p_glaldocdt
   LET g_prog = p_prog
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT glanstus,glandocno,glanld,glanseq,glan001,glan002 FROM glan_t WHERE glanent=?  
       AND glanld=? AND glandocno=? AND glanseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt390_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt390_01 WITH FORM cl_ap_formpath("agl","aglt390_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aglt390_01_init()   
 
   #進入選單 Menu (="N")
   CALL aglt390_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aglt390_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ''
   SELECT count(*) INTO l_n 
     FROM glan_t
    WHERE glanent = g_enterprise 
      AND glandocno = g_glaldocno
      AND glanld = g_glalld
   SELECT glalstus INTO l_glalstus FROM glal_t
    WHERE glalent = g_enterprise
      AND glalld = p_glalld
      AND glaldocno = p_glaldocno
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   LET l_success = TRUE
   SELECT glaa013 INTO l_glaa013 FROM glaa_t
    WHERE glaaent=g_enterprise AND glaald=g_glalld
   IF g_glaldocdt <= l_glaa013 THEN
      LET l_success = FALSE
   END IF
   #glan_t存在资料并且当前资料为开立状态      
   IF l_n > 0 AND l_glalstus = 'N' AND l_success=TRUE THEN      
      CALL aglt370_02(g_glaldocno,g_glalld,g_prog) RETURNING g_success
   END IF
   RETURN g_success
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt390_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglt390_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_glalstus           LIKE type_t.chr1 
   DEFINE l_success            LIKE type_t.num5
   DEFINE l_glaa013            LIKE glaa_t.glaa013   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004 INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glalld

   #抓取状态码
   SELECT glalstus INTO l_glalstus
     FROM glal_t
    WHERE glalent = g_enterprise
      AND glalld = g_glalld
      AND glaldocno = g_glaldocno
    
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   LET l_success = TRUE
   SELECT glaa013 INTO l_glaa013 FROM glaa_t
    WHERE glaaent=g_enterprise AND glaald=g_glalld
   IF g_glaldocdt <= l_glaa013 THEN
      LET l_success = FALSE
   END IF     
   IF l_glalstus = 'N' AND l_success = TRUE THEN
      CALL aglt390_01_modify()
   END IF          {#ADP版次:1#}   
   #end add-point
   
   CALL aglt390_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglt390_01_ui_dialog()
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
         CALL g_glan_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aglt390_01_init()
      END IF
   
      CALL aglt390_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glan_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aglt390_01_set_pk_array()
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
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aglt390_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aglt390_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aglt390_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aglt390_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aglt390_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aglt390_01_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglt390_01_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglt390_01_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glan_d)
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
            CALL aglt390_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglt390_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglt390_01_set_pk_array()
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
 
{<section id="aglt390_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglt390_01_query()
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
   CALL g_glan_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON glanstus,glandocno,glanld,glanseq,glan001,lc_subject,glan002 
 
         FROM s_detail1[1].glanstus,s_detail1[1].glandocno,s_detail1[1].glanld,s_detail1[1].glanseq, 
             s_detail1[1].glan001,s_detail1[1].lc_subject,s_detail1[1].glan002 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glancrtdt>>----
 
         #----<<glanmoddt>>----
         
         #----<<glancnfdt>>----
         
         #----<<glanpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glanstus
            #add-point:BEFORE FIELD glanstus name="query.b.page1.glanstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glanstus
            
            #add-point:AFTER FIELD glanstus name="query.a.page1.glanstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glanstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glanstus
            #add-point:ON ACTION controlp INFIELD glanstus name="query.c.page1.glanstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glandocno
            #add-point:BEFORE FIELD glandocno name="query.b.page1.glandocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glandocno
            
            #add-point:AFTER FIELD glandocno name="query.a.page1.glandocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glandocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glandocno
            #add-point:ON ACTION controlp INFIELD glandocno name="query.c.page1.glandocno"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glanld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glanld
            #add-point:ON ACTION controlp INFIELD glanld name="construct.c.page1.glanld"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glanld  #顯示到畫面上

            NEXT FIELD glanld                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glanld
            #add-point:BEFORE FIELD glanld name="query.b.page1.glanld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glanld
            
            #add-point:AFTER FIELD glanld name="query.a.page1.glanld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glanseq
            #add-point:BEFORE FIELD glanseq name="query.b.page1.glanseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glanseq
            
            #add-point:AFTER FIELD glanseq name="query.a.page1.glanseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glanseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glanseq
            #add-point:ON ACTION controlp INFIELD glanseq name="query.c.page1.glanseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glan001
            #add-point:BEFORE FIELD glan001 name="query.b.page1.glan001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glan001
            
            #add-point:AFTER FIELD glan001 name="query.a.page1.glan001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glan001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glan001
            #add-point:ON ACTION controlp INFIELD glan001 name="query.c.page1.glan001"
            
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
			   #151117-00009#1--add--str--
			   LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glalld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
            #151117-00009#1--add--end
            CALL aglt310_04()                           #呼叫開窗
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
         BEFORE FIELD glan002
            #add-point:BEFORE FIELD glan002 name="query.b.page1.glan002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glan002
            
            #add-point:AFTER FIELD glan002 name="query.a.page1.glan002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glan002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glan002
            #add-point:ON ACTION controlp INFIELD glan002 name="query.c.page1.glan002"
            
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
   IF NOT cl_null(g_wc2) AND g_wc2 <>" 1=1" THEN
      LET g_wc2 = cl_replace_str(g_wc2,"lc_subject","glan001")
   END IF
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
    
   CALL aglt390_01_b_fill(g_wc2)
 
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
 
{<section id="aglt390_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglt390_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aglt390_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglt390_01_modify()
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
   DEFINE  l_glan001_desc  LIKE type_t.chr200 
   DEFINE  l_glan001_1     LIKE glan_t.glan001
   DEFINE  l_glan002       LIKE glan_t.glan002
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_glalstus      LIKE glal_t.glalstus
   DEFINE  l_str           STRING
   DEFINE  l_glaa004             LIKE glaa_t.glaa004  #150916-00015#1 -add
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
   #检查帐别权限
   CALL s_ld_chk_authorization(g_user,g_glalld) RETURNING l_success
   IF l_success = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glalld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF
   #当前单据状态不为开立的话，不可修改
   SELECT glalstus INTO l_glalstus 
     FROM glal_t
    WHERE glalent = g_enterprise
      AND glalld = g_glalld
      AND glaldocno = g_glaldocno
   IF l_glalstus <> 'N' THEN
      CALL cl_set_act_visible('modify,delete',FALSE)
      RETURN
   ELSE
      CALL cl_set_act_visible('modify,delete',TRUE)  
   END IF 
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk(g_glalld,'','AGL',g_glaldocdt) RETURNING l_success
   IF l_success = FALSE THEN
      RETURN
   END IF
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_glan_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glan_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglt390_01_b_fill(g_wc2)
            LET g_detail_cnt = g_glan_d.getLength()
         
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
            DISPLAY g_glan_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_glan_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_glan_d[l_ac].glanld IS NOT NULL
               AND g_glan_d[l_ac].glandocno IS NOT NULL
               AND g_glan_d[l_ac].glanseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glan_d_t.* = g_glan_d[l_ac].*  #BACKUP
               LET g_glan_d_o.* = g_glan_d[l_ac].*  #BACKUP
               IF NOT aglt390_01_lock_b("glan_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglt390_01_bcl INTO g_glan_d[l_ac].glanstus,g_glan_d[l_ac].glandocno,g_glan_d[l_ac].glanld, 
                      g_glan_d[l_ac].glanseq,g_glan_d[l_ac].glan001,g_glan_d[l_ac].glan002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glan_d_t.glanld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glan_d_mask_o[l_ac].* =  g_glan_d[l_ac].*
                  CALL aglt390_01_glan_t_mask()
                  LET g_glan_d_mask_n[l_ac].* =  g_glan_d[l_ac].*
                  
                  CALL aglt390_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aglt390_01_set_entry_b(l_cmd)
            CALL aglt390_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL aglt390_01_glan001('Y') RETURNING l_glan001_desc,l_str  #151103-00017#1 mod
            LET g_glan_d[l_ac].lc_subject = g_glan_d[l_ac].glan001,l_str,'\n',l_glan001_desc
            DISPLAY BY NAME g_glan_d[l_ac].lc_subject
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
            INITIALIZE g_glan_d_t.* TO NULL
            INITIALIZE g_glan_d_o.* TO NULL
            INITIALIZE g_glan_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glan_d[l_ac].glanstus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_glan_d[l_ac].glanstus = "Y"
      LET g_glan_d[l_ac].glan002 = "100"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_glan_d_t.* = g_glan_d[l_ac].*     #新輸入資料
            LET g_glan_d_o.* = g_glan_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glan_d[li_reproduce_target].* = g_glan_d[li_reproduce].*
 
               LET g_glan_d[g_glan_d.getLength()].glanld = NULL
               LET g_glan_d[g_glan_d.getLength()].glandocno = NULL
               LET g_glan_d[g_glan_d.getLength()].glanseq = NULL
 
            END IF
            
 
            CALL aglt390_01_set_entry_b(l_cmd)
            CALL aglt390_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_glan_d[l_ac].glandocno = g_glaldocno
            LET g_glan_d[l_ac].glanld = g_glalld
            LET g_glan_d[l_ac].glanstus = "Y"
      
            IF l_cmd = 'a' THEN 
               IF cl_null(g_glan_d[g_detail_idx].glanseq) THEN 
                  SELECT MAX(glanseq) INTO g_glan_d[g_detail_idx].glanseq
                    FROM glan_t
                   WHERE glanent = g_enterprise
                     AND glanld = g_glan_d[g_detail_idx].glanld
                     AND glandocno = g_glan_d[g_detail_idx].glandocno
                     
                  IF cl_null(g_glan_d[g_detail_idx].glanseq) THEN 
                     LET g_glan_d[g_detail_idx].glanseq = 1
                  ELSE
                     LET g_glan_d[g_detail_idx].glanseq = g_glan_d[g_detail_idx].glanseq + 1
                  END IF
               END IF 
            END IF 
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
            SELECT COUNT(1) INTO l_count FROM glan_t 
             WHERE glanent = g_enterprise AND glanld = g_glan_d[l_ac].glanld
                                       AND glandocno = g_glan_d[l_ac].glandocno
                                       AND glanseq = g_glan_d[l_ac].glanseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glan_d[g_detail_idx].glanld
               LET gs_keys[2] = g_glan_d[g_detail_idx].glandocno
               LET gs_keys[3] = g_glan_d[g_detail_idx].glanseq
               CALL aglt390_01_insert_b('glan_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
#               CALL aglt390_01_update_forzen() RETURNING l_success #151103-00017#1 mark
               #151103-00017#1--add--str--
               IF SQLCA.SQLcode  THEN
                  CALL s_transaction_end('N','0')
               END IF
               #151103-00017#1--add--end
               #end add-point
            ELSE    
               INITIALIZE g_glan_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glan_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aglt390_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #151103-00017#1--add--str--
               #更新核算项
               CALL aglt390_01_update_forzen() RETURNING l_success 
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #151103-00017#1--add--end
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (glanld = '", g_glan_d[l_ac].glanld, "' "
                                  ," AND glandocno = '", g_glan_d[l_ac].glandocno, "' "
                                  ," AND glanseq = '", g_glan_d[l_ac].glanseq, "' "
 
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
               
               DELETE FROM glan_t
                WHERE glanent = g_enterprise AND 
                      glanld = g_glan_d_t.glanld
                      AND glandocno = g_glan_d_t.glandocno
                      AND glanseq = g_glan_d_t.glanseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               #151103-00017#1--add--str--
               IF SQLCA.SQLcode  THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt390_01_bcl
               END IF
               #151103-00017#1--add--end
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "glan_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aglt390_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_glan_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aglt390_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_glan_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glan_d_t.glanld
               LET gs_keys[2] = g_glan_d_t.glandocno
               LET gs_keys[3] = g_glan_d_t.glanseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglt390_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aglt390_01_delete_b('glan_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glan_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glanstus
            #add-point:BEFORE FIELD glanstus name="input.b.page1.glanstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glanstus
            
            #add-point:AFTER FIELD glanstus name="input.a.page1.glanstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glanstus
            #add-point:ON CHANGE glanstus name="input.g.page1.glanstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glandocno
            #add-point:BEFORE FIELD glandocno name="input.b.page1.glandocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glandocno
            
            #add-point:AFTER FIELD glandocno name="input.a.page1.glandocno"
            #此段落由子樣板a05產生
            IF  g_glan_d[g_detail_idx].glanld IS NOT NULL AND g_glan_d[g_detail_idx].glandocno IS NOT NULL AND g_glan_d[g_detail_idx].glanseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glan_d[g_detail_idx].glanld != g_glan_d_t.glanld OR g_glan_d[g_detail_idx].glandocno != g_glan_d_t.glandocno OR g_glan_d[g_detail_idx].glanseq != g_glan_d_t.glanseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glan_t WHERE "||"glanent = '" ||g_enterprise|| "' AND "||"glanld = '"||g_glan_d[g_detail_idx].glanld ||"' AND "|| "glandocno = '"||g_glan_d[g_detail_idx].glandocno ||"' AND "|| "glanseq = '"||g_glan_d[g_detail_idx].glanseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glandocno
            #add-point:ON CHANGE glandocno name="input.g.page1.glandocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glanld
            #add-point:BEFORE FIELD glanld name="input.b.page1.glanld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glanld
            
            #add-point:AFTER FIELD glanld name="input.a.page1.glanld"
            #此段落由子樣板a05產生
            IF  g_glan_d[g_detail_idx].glanld IS NOT NULL AND g_glan_d[g_detail_idx].glandocno IS NOT NULL AND g_glan_d[g_detail_idx].glanseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glan_d[g_detail_idx].glanld != g_glan_d_t.glanld OR g_glan_d[g_detail_idx].glandocno != g_glan_d_t.glandocno OR g_glan_d[g_detail_idx].glanseq != g_glan_d_t.glanseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glan_t WHERE "||"glanent = '" ||g_enterprise|| "' AND "||"glanld = '"||g_glan_d[g_detail_idx].glanld ||"' AND "|| "glandocno = '"||g_glan_d[g_detail_idx].glandocno ||"' AND "|| "glanseq = '"||g_glan_d[g_detail_idx].glanseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glanld
            #add-point:ON CHANGE glanld name="input.g.page1.glanld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glanseq
            #add-point:BEFORE FIELD glanseq name="input.b.page1.glanseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glanseq
            
            #add-point:AFTER FIELD glanseq name="input.a.page1.glanseq"
            #此段落由子樣板a05產生
            IF  g_glan_d[g_detail_idx].glanld IS NOT NULL AND g_glan_d[g_detail_idx].glandocno IS NOT NULL AND g_glan_d[g_detail_idx].glanseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glan_d[g_detail_idx].glanld != g_glan_d_t.glanld OR g_glan_d[g_detail_idx].glandocno != g_glan_d_t.glandocno OR g_glan_d[g_detail_idx].glanseq != g_glan_d_t.glanseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glan_t WHERE "||"glanent = '" ||g_enterprise|| "' AND "||"glanld = '"||g_glan_d[g_detail_idx].glanld ||"' AND "|| "glandocno = '"||g_glan_d[g_detail_idx].glandocno ||"' AND "|| "glanseq = '"||g_glan_d[g_detail_idx].glanseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glanseq
            #add-point:ON CHANGE glanseq name="input.g.page1.glanseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glan001
            #add-point:BEFORE FIELD glan001 name="input.b.page1.glan001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glan001
            
            #add-point:AFTER FIELD glan001 name="input.a.page1.glan001"
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glan001
            #add-point:ON CHANGE glan001 name="input.g.page1.glan001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="input.b.page1.lc_subject"
            LET g_glan_d[l_ac].lc_subject = g_glan_d[l_ac].glan001
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="input.a.page1.lc_subject"
           IF NOT cl_null(g_glan_d[l_ac].lc_subject) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glan_d[l_ac].glanld,g_glan_d[l_ac].lc_subject,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glan_d[l_ac].glanld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glan_d[l_ac].lc_subject
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glan_d[l_ac].lc_subject
                  LET g_qryparam.arg3 = g_glan_d[l_ac].glanld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glan_d[l_ac].lc_subject = g_qryparam.return1 
                  DISPLAY g_glan_d[l_ac].lc_subject TO lc_subject                   
               END IF
               # 150916-00015#1 --end
              #151117-00009#1--mod--str--
#              CALL aglt390_01_glan001_chk(g_glan_d[l_ac].lc_subject)
              #科目存在性，有效性，非统治科目，账户科目属性检查
              CALL s_voucher_glaq002_chk(g_glan_d[l_ac].glanld,g_glan_d[l_ac].lc_subject)
              #151117-00009#1--mod--end 
              IF NOT cl_null(g_errno) THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = g_glan_d[l_ac].lc_subject
                 #160321-00016#30 --s add
                 LET g_errparam.replace[1] = 'agli030'
                 LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                 LET g_errparam.exeprog = 'agli030'
                 #160321-00016#30 --e add
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
              
                 IF l_cmd = 'a' THEN 
                    LET g_glan_d[l_ac].lc_subject = ''
                 ELSE
                    LET g_glan_d[l_ac].lc_subject = g_glan_d_t.lc_subject
                 END IF 
                 NEXT FIELD lc_subject
              END IF
              LET g_glan_d[l_ac].glan001 = g_glan_d[l_ac].lc_subject
              IF l_cmd = 'a' THEN 
                 CALL aglt390_01_frozen_clear()
#                 CALL aglt390_01_glan001_open_chk(g_glan_d[l_ac].glan001) RETURNING l_cnt  #151103-00017#1 mark
                 #如果有启用核算项，则开处子视窗，否则不开
#                 IF l_cnt > 0  THEN  #151103-00017#1 mark
                    CALL aglt360_01('a',g_glan_d[l_ac].glanld,'',g_glaldocdt,g_glan_d[l_ac].glan001,'','glan001')
                    RETURNING g_glan_m.glan003,g_glan_m.glan003_desc,g_glan_m.glan004,g_glan_m.glan004_desc,
                              g_glan_m.glan005,g_glan_m.glan005_desc,g_glan_m.glan006,g_glan_m.glan006_desc,
                              g_glan_m.glan007,g_glan_m.glan007_desc,g_glan_m.glan008,g_glan_m.glan008_desc,
                              g_glan_m.glan009,g_glan_m.glan009_desc,g_glan_m.glan010,g_glan_m.glan010_desc,
                              g_glan_m.glan011,g_glan_m.glan011_desc,
                              g_glan_m.glan013,g_glan_m.glan013_desc,g_glan_m.glan014,g_glan_m.glan014_desc,
                              g_glan_m.glan051,g_glan_m.glan052,g_glan_m.glan052_desc,
                              g_glan_m.glan053,g_glan_m.glan053_desc
#                 END IF#151103-00017#1 mark
              #151103-00017#1--add--str--
              ELSE
                 CALL aglt360_01('u',g_glan_d[l_ac].glanld,g_glaldocno,g_glaldocdt,g_glan_d[l_ac].glan001,g_glan_d[l_ac].glanseq,'glan001')
                    RETURNING g_glan_m.glan003,g_glan_m.glan003_desc,g_glan_m.glan004,g_glan_m.glan004_desc,
                              g_glan_m.glan005,g_glan_m.glan005_desc,g_glan_m.glan006,g_glan_m.glan006_desc,
                              g_glan_m.glan007,g_glan_m.glan007_desc,g_glan_m.glan008,g_glan_m.glan008_desc,
                              g_glan_m.glan009,g_glan_m.glan009_desc,g_glan_m.glan010,g_glan_m.glan010_desc,
                              g_glan_m.glan011,g_glan_m.glan011_desc,
                              g_glan_m.glan013,g_glan_m.glan013_desc,g_glan_m.glan014,g_glan_m.glan014_desc,
                              g_glan_m.glan051,g_glan_m.glan052,g_glan_m.glan052_desc,
                              g_glan_m.glan053,g_glan_m.glan053_desc
              #151103-00017#1--add--end
              END IF      
              #重新抓取单身冻结部分显示               
              CALL aglt390_01_glan001('N') RETURNING l_glan001_desc,l_str  #151103-00017#1 mod
              LET g_glan_d[l_ac].lc_subject = g_glan_d[l_ac].glan001,l_str,'\n',l_glan001_desc
              DISPLAY BY NAME g_glan_d[l_ac].lc_subject
           END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lc_subject
            #add-point:ON CHANGE lc_subject name="input.g.page1.lc_subject"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glan002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glan_d[l_ac].glan002,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD glan002
            END IF 
 
 
 
            #add-point:AFTER FIELD glan002 name="input.a.page1.glan002"
            IF NOT cl_null(g_glan_d[l_ac].glan002) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glan002
            #add-point:BEFORE FIELD glan002 name="input.b.page1.glan002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glan002
            #add-point:ON CHANGE glan002 name="input.g.page1.glan002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glanstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glanstus
            #add-point:ON ACTION controlp INFIELD glanstus name="input.c.page1.glanstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glandocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glandocno
            #add-point:ON ACTION controlp INFIELD glandocno name="input.c.page1.glandocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glanld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glanld
            #add-point:ON ACTION controlp INFIELD glanld name="input.c.page1.glanld"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glan_d[l_ac].glanld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glan_d[l_ac].glanld = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glan_d[l_ac].glanld TO glanld              #顯示到畫面上

            NEXT FIELD glanld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glanseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glanseq
            #add-point:ON ACTION controlp INFIELD glanseq name="input.c.page1.glanseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glan001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glan001
            #add-point:ON ACTION controlp INFIELD glan001 name="input.c.page1.glan001"
                           #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="input.c.page1.lc_subject"
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glan_d[l_ac].lc_subject             #給予default值
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   #151117-00009#1--add--str--
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glalld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            #給予arg
            CALL aglt310_04()
            LET g_glan_d[l_ac].lc_subject = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_glan_d[l_ac].glan001 = g_glan_d[l_ac].lc_subject
            DISPLAY g_glan_d[l_ac].lc_subject TO lc_subject              #顯示到畫面上
            LET g_qryparam.where = NULL
            NEXT FIELD lc_subject           
            #END add-point
 
 
         #Ctrlp:input.c.page1.glan002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glan002
            #add-point:ON ACTION controlp INFIELD glan002 name="input.c.page1.glan002"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aglt390_01_bcl
               LET INT_FLAG = 0
               LET g_glan_d[l_ac].* = g_glan_d_t.*
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
               LET g_errparam.extend = g_glan_d[l_ac].glanld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glan_d[l_ac].* = g_glan_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglt390_01_glan_t_mask_restore('restore_mask_o')
 
               UPDATE glan_t SET (glanstus,glandocno,glanld,glanseq,glan001,glan002) = (g_glan_d[l_ac].glanstus, 
                   g_glan_d[l_ac].glandocno,g_glan_d[l_ac].glanld,g_glan_d[l_ac].glanseq,g_glan_d[l_ac].glan001, 
                   g_glan_d[l_ac].glan002)
                WHERE glanent = g_enterprise AND
                  glanld = g_glan_d_t.glanld #項次   
                  AND glandocno = g_glan_d_t.glandocno  
                  AND glanseq = g_glan_d_t.glanseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               #151103-00017#1--add--str--
               IF SQLCA.SQLcode OR SQLCA.sqlerrd[3] = 0 THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt390_01_bcl
               END IF
               #151103-00017#1--add--end
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glan_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glan_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glan_d[g_detail_idx].glanld
               LET gs_keys_bak[1] = g_glan_d_t.glanld
               LET gs_keys[2] = g_glan_d[g_detail_idx].glandocno
               LET gs_keys_bak[2] = g_glan_d_t.glandocno
               LET gs_keys[3] = g_glan_d[g_detail_idx].glanseq
               LET gs_keys_bak[3] = g_glan_d_t.glanseq
               CALL aglt390_01_update_b('glan_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_glan_d_t)
                     LET g_log2 = util.JSON.stringify(g_glan_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglt390_01_glan_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aglt390_01_unlock_b("glan_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glan_d[l_ac].* = g_glan_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            #151103-00017#1--add--str--
            IF l_cmd='u' THEN
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               #將離開科目欄位后的核算项 insert進DB
               CALL aglt390_01_update_forzen() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            
            CALL s_transaction_end('Y','0')
            #151103-00017#1--add--end
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
               LET g_glan_d[li_reproduce_target].* = g_glan_d[li_reproduce].*
 
               LET g_glan_d[li_reproduce_target].glanld = NULL
               LET g_glan_d[li_reproduce_target].glandocno = NULL
               LET g_glan_d[li_reproduce_target].glanseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glan_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glan_d.getLength()+1
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
               NEXT FIELD glanstus
 
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
      IF INT_FLAG OR cl_null(g_glan_d[g_detail_idx].glanld) THEN
         CALL g_glan_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_glan_d[g_detail_idx].* = g_glan_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
 
   #end add-point
 
   CLOSE aglt390_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglt390_01_delete()
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
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glalstus      LIKE glal_t.glalstus
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_glan_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aglt390_01_lock_b("glan_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("glan_t","glanownid") THEN
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
               RETURN
            END IF
         END IF
         #(ver:35) --- add end ---
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   #检查帐别权限
   CALL s_ld_chk_authorization(g_user,g_glalld) RETURNING l_success
   IF l_success = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glalld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF
   #当前单据状态不为开立的话，不可修改
   SELECT glalstus INTO l_glalstus 
     FROM glal_t
    WHERE glalent = g_enterprise
      AND glalld = g_glalld
      AND glaldocno = g_glaldocno
   
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk(g_glalld,'','AGL',g_glaldocdt) RETURNING l_success
   IF l_success = FALSE THEN
      RETURN
   END IF
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_glan_d.getLength()
      IF g_glan_d[li_idx].glanld IS NOT NULL
         AND g_glan_d[li_idx].glandocno IS NOT NULL
         AND g_glan_d[li_idx].glanseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM glan_t
          WHERE glanent = g_enterprise AND 
                glanld = g_glan_d[li_idx].glanld
                AND glandocno = g_glan_d[li_idx].glandocno
                AND glanseq = g_glan_d[li_idx].glanseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glan_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_glan_d_t.glanld
               LET gs_keys[2] = g_glan_d_t.glandocno
               LET gs_keys[3] = g_glan_d_t.glanseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aglt390_01_delete_b('glan_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglt390_01_set_pk_array()
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
   CALL aglt390_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglt390_01_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glan001_desc     STRING 
   DEFINE l_str              STRING
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   LET p_wc2 = " glanld = '",g_glalld,"' AND glandocno = '",g_glaldocno,"' "
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.glanstus,t0.glandocno,t0.glanld,t0.glanseq,t0.glan001,t0.glan002  FROM glan_t t0", 
 
               "",
               
               " WHERE t0.glanent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("glan_t"),
                      " ORDER BY t0.glanld,t0.glandocno,t0.glanseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
 
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glan_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglt390_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglt390_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glan_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glan_d[l_ac].glanstus,g_glan_d[l_ac].glandocno,g_glan_d[l_ac].glanld,g_glan_d[l_ac].glanseq, 
       g_glan_d[l_ac].glan001,g_glan_d[l_ac].glan002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET l_glan001_desc = ''
      CALL aglt390_01_glan001('Y') RETURNING l_glan001_desc,l_str   #151103-00017#1 mod
      LET g_glan_d[l_ac].lc_subject = g_glan_d[l_ac].glan001,l_str,'\n',l_glan001_desc
      DISPLAY BY NAME g_glan_d[l_ac].lc_subject
      CALL aglt390_01_frozen_clear()
      #end add-point
      
      CALL aglt390_01_detail_show()      
 
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
   
 
   
   CALL g_glan_d.deleteElement(g_glan_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glan_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_glan_d.getLength() THEN
      LET l_ac = g_glan_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glan_d.getLength()
      LET g_glan_d_mask_o[l_ac].* =  g_glan_d[l_ac].*
      CALL aglt390_01_glan_t_mask()
      LET g_glan_d_mask_n[l_ac].* =  g_glan_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_glan_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aglt390_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglt390_01_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglt390_01_set_entry_b(p_cmd)                                                  
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
 
{<section id="aglt390_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglt390_01_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aglt390_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglt390_01_default_search()
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
      LET ls_wc = ls_wc, " glanld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glandocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glanseq = '", g_argv[03], "' AND "
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
 
{<section id="aglt390_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglt390_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "glan_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'glan_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM glan_t
          WHERE glanent = g_enterprise AND
            glanld = ps_keys_bak[1] AND glandocno = ps_keys_bak[2] AND glanseq = ps_keys_bak[3]
         
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
         CALL g_glan_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglt390_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "glan_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO glan_t
                  (glanent,
                   glanld,glandocno,glanseq
                   ,glanstus,glan001,glan002) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_glan_d[l_ac].glanstus,g_glan_d[l_ac].glan001,g_glan_d[l_ac].glan002)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glan_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglt390_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "glan_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "glan_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE glan_t 
         SET (glanld,glandocno,glanseq
              ,glanstus,glan001,glan002) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_glan_d[l_ac].glanstus,g_glan_d[l_ac].glan001,g_glan_d[l_ac].glan002) 
         WHERE glanent = g_enterprise AND glanld = ps_keys_bak[1] AND glandocno = ps_keys_bak[2] AND glanseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glan_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glan_t:",SQLERRMESSAGE 
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
 
{<section id="aglt390_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglt390_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aglt390_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "glan_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aglt390_01_bcl USING g_enterprise,
                                       g_glan_d[g_detail_idx].glanld,g_glan_d[g_detail_idx].glandocno, 
                                           g_glan_d[g_detail_idx].glanseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aglt390_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglt390_01_unlock_b(ps_table)
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
      CLOSE aglt390_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aglt390_01_modify_detail_chk(ps_record)
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
         LET ls_return = "glanstus"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aglt390_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aglt390_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aglt390_01.mask_functions" >}
&include "erp/agl/aglt390_01_mask.4gl"
 
{</section>}
 
{<section id="aglt390_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglt390_01_set_pk_array()
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
   LET g_pk_array[1].values = g_glan_d[l_ac].glanld
   LET g_pk_array[1].column = 'glanld'
   LET g_pk_array[2].values = g_glan_d[l_ac].glandocno
   LET g_pk_array[2].column = 'glandocno'
   LET g_pk_array[3].values = g_glan_d[l_ac].glanseq
   LET g_pk_array[3].column = 'glanseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt390_01.state_change" >}
   
 
{</section>}
 
{<section id="aglt390_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt390_01.other_function" readonly="Y" >}
#科目检查
PRIVATE FUNCTION aglt390_01_glan001_chk(p_glan001)
   DEFINE p_glan001    LIKE glan_t.glan001
   DEFINE l_glacstus   LIKE glac_t.glacstus
   DEFINE l_glac003    LIKE glac_t.glac003
   DEFINE l_glac006    LIKE glac_t.glac006
   
   LET g_errno = ''
   SELECT glacstus,glac003,glac006 INTO l_glacstus,l_glac003,l_glac006 FROM glac_t
    WHERE glacent = g_enterprise
      AND glac001 = g_glaa004  #会计科目参照表号
      AND glac002 = p_glan001
      
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00011'
      WHEN l_glacstus = 'N'      LET g_errno =  'sub-01302'  #160318-00005#18 mod 'agl-00012'
      WHEN l_glac003 = '1'       LET g_errno = 'agl-00013'  #必须为非统治类科目
      WHEN l_glac006 <>'1'       LET g_errno = 'agl-00030'  #须为账户性质   
   END CASE   
END FUNCTION
#核算项清空
PRIVATE FUNCTION aglt390_01_frozen_clear()
   LET g_glan_m.glan003 = '' 
   LET g_glan_m.glan003_desc = ''
   LET g_glan_m.glan004 = ''
   LET g_glan_m.glan004_desc = ''
   LET g_glan_m.glan005 = ''
   LET g_glan_m.glan005_desc = ''
   LET g_glan_m.glan006 = ''
   LET g_glan_m.glan006_desc = ''
   LET g_glan_m.glan007 = ''
   LET g_glan_m.glan007_desc = ''
   LET g_glan_m.glan008 = ''
   LET g_glan_m.glan008_desc = ''
   LET g_glan_m.glan009 = ''
   LET g_glan_m.glan009_desc = ''
   LET g_glan_m.glan010 = ''
   LET g_glan_m.glan010_desc = ''
   LET g_glan_m.glan011 = ''
   LET g_glan_m.glan011_desc = ''
   LET g_glan_m.glan013 = ''
   LET g_glan_m.glan013_desc = ''
   LET g_glan_m.glan014 = ''
   LET g_glan_m.glan014_desc = ''
   LET g_glan_m.glan051 = ''
   LET g_glan_m.glan052 = ''
   LET g_glan_m.glan052_desc = ''
   LET g_glan_m.glan053 = ''
   LET g_glan_m.glan053_desc = ''
END FUNCTION
#检查该科目是否启用核算项
PRIVATE FUNCTION aglt390_01_glan001_open_chk(p_glan001)
    DEFINE p_glan001     LIKE glan_t.glan001
   DEFINE r_cnt         LIKE type_t.num5
   #科目核算项
   DEFINE l_glad005       LIKE glad_t.glad005
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   #记录隐藏栏位标示
   DEFINE l_flag1         LIKE type_t.num5 

   LET l_flag1 = 0
   #依據是否啟用數量金額式,帳別，科目編號，判斷該科目是否做部門管理， 利潤成本中心管理，區域管理，客商管理，客群管理，產品類別，人員，預算，專案，wbs管理
#   SELECT glad007,glad008,glad009,glad010,glad011,glad012,glad013,glad014,glad015,glad016 
#     INTO l_glad007,l_glad008,l_glad009,l_glad010,l_glad011,l_glad012,l_glad013,l_glad014,l_glad015,l_glad016
#     FROM glad_t
#    WHERE gladent = g_enterprise
#      AND gladld = g_glalld
#      AND glad001 = p_glan001
   CALL s_voucher_fix_acc_open_chk(g_glalld,p_glan001)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,
             l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,
             l_glad031,l_glad032,l_glad033
   #該科目做部門管理時，部門
   IF l_glad007 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做利潤成本管理時，利潤成本
   IF l_glad008 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做區域管理時，區域
   IF l_glad009 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做客商管理時，客商
   IF l_glad010 = 'Y' THEN
       LET l_flag1 = l_flag1+1
   END IF 
   #該科目做帳款客戶管理時，客商
   IF l_glad027 = 'Y' THEN
       LET l_flag1 = l_flag1+1
   END IF 
   #該科目做客群管理時，客群
   IF l_glad011 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做產品分類管理時，
   IF l_glad012 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF 
   
   #該科目做經營方式管理時，
   IF l_glad031 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF
   #該科目做渠道管理時，
   IF l_glad032 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF   
   #該科目做品牌管理時，
   IF l_glad033 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF
   
   #該科目做人員管理時，
   IF l_glad013 = 'Y' THEN
      LET l_flag1 = l_flag1+1         
   END IF 
#   #該科目做預算管理時，
#   IF l_glad014 = 'Y' THEN
#      LET l_flag1 = l_flag1+1         
#   END IF 
   #該科目做專案管理時，
   IF l_glad015 = 'Y' THEN
      LET l_flag1 = l_flag1+1         
   END IF 
   #該科目做WBS管理時，
   IF l_glad016 = 'Y' THEN
      LET l_flag1 = l_flag1+1    
   END IF    
    
   #如果核算项没有启用，则不需开出子视窗  
   RETURN l_flag1
END FUNCTION
#核算项带值
PRIVATE FUNCTION aglt390_01_glan_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan003_desc = '', g_rtn_fields[1] , ''
            
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan004_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan005_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan006_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan007
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan007_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan008
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan008_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan009_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan010
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan010_desc = '', g_rtn_fields[1] , ''
   
   LET g_glan_m.glan011_desc = ''
   SELECT ooag011 INTO g_glan_m.glan011_desc FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = g_glam_m.glan011
   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glan_m.glan012
#   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glan_m.glan012_desc = '', g_rtn_fields[1] , ''
   #渠道
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan052
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan052_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glan_m.glan052_desc
   #品牌
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glan_m.glan053
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glan_m.glan053_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glan_m.glan053_desc
   #专案
   CALL s_desc_get_project_desc(g_glan_m.glan013) RETURNING g_glan_m.glan013_desc
   DISPLAY BY NAME g_glan_m.glan013_desc
   #WBS
   CALL s_desc_get_wbs_desc(g_glan_m.glan013,g_glan_m.glan014) RETURNING g_glan_m.glan014_desc
   DISPLAY BY NAME g_glan_m.glan014_desc
END FUNCTION
#单身显示
PRIVATE FUNCTION aglt390_01_b_detail()
    SELECT glan003,glan004,glan005,glan006,
          glan007,glan008,glan009,glan010,
          glan011,glan013,glan014,glan051,glan052,glan053
     INTO g_glan_m.glan003,g_glan_m.glan004,g_glan_m.glan005,g_glan_m.glan006,
          g_glan_m.glan007,g_glan_m.glan008,g_glan_m.glan009,g_glan_m.glan010,
          g_glan_m.glan011,g_glan_m.glan013,g_glan_m.glan014,
          g_glan_m.glan051,g_glan_m.glan052,g_glan_m.glan053          
     FROM glan_t
    WHERE glanent = g_enterprise
      AND glanld = g_glan_d[l_ac].glanld
      AND glandocno = g_glan_d[l_ac].glandocno
      AND glanseq = g_glan_d[l_ac].glanseq
      
   CALL aglt390_01_glan_desc()
END FUNCTION
#科目组合
PRIVATE FUNCTION aglt390_01_glan001(p_flag)
   DEFINE p_flag              LIKE type_t.chr1     #151103-00017#1 add
   DEFINE l_glan001_desc      LIKE glacl_t.glacl004
   DEFINE r_glan001           STRING
   DEFINE r_str               STRING
   DEFINE l_desc              STRING
   
   IF p_flag = 'Y' THEN   #151103-00017#1 add
      CALL aglt390_01_b_detail()
   END IF                 #151103-00017#1 add
   #抓取科目名称
   LET l_glan001_desc = ''
   SELECT glacl004 INTO l_glan001_desc FROM glacl_t
    WHERE glaclent = g_enterprise
      AND glacl001 = g_glaa004
      AND glacl002 = g_glan_d[l_ac].glan001
      AND glacl003 = g_dlang   
   #组合名称以及核算项
   LET r_glan001 = ''
   #營運據點
   IF NOT cl_null(g_glan_m.glan003) THEN
      LET r_glan001 = g_glan_m.glan003_desc
      LET r_str=g_glan_m.glan003
   END IF
   #部门
   IF NOT cl_null(g_glan_m.glan004) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan004_desc
      ELSE
         LET r_glan001 = g_glan_m.glan004_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan004
      ELSE
         LET r_str=g_glan_m.glan004
      END IF    
   END IF 
   #成本利润中心
   IF NOT cl_null(g_glan_m.glan005) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan005_desc
      ELSE
         LET r_glan001 = g_glan_m.glan005_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan005
      ELSE
         LET r_str=g_glan_m.glan005
      END IF
   END IF 
   
   #区域
   IF NOT cl_null(g_glan_m.glan006) THEN  
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan006_desc
      ELSE
         LET r_glan001 = g_glan_m.glan006_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan006
      ELSE
         LET r_str=g_glan_m.glan006
      END IF
   END IF 
   #交易客商
   IF NOT cl_null(g_glan_m.glan007) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan007_desc
      ELSE
         LET r_glan001 = g_glan_m.glan007_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan007
      ELSE
         LET r_str=g_glan_m.glan007
      END IF
   END IF 
   #帐款客商
   IF NOT cl_null(g_glan_m.glan008) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan008_desc
      ELSE
         LET r_glan001 = g_glan_m.glan008_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan008
      ELSE
         LET r_str=g_glan_m.glan008
      END IF
   END IF 
   #客群
   IF NOT cl_null(g_glan_m.glan009) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan009_desc
      ELSE
         LET r_glan001 = g_glan_m.glan009_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan009
      ELSE
         LET r_str=g_glan_m.glan009
      END IF
   END IF 
   
   #产品分类
   IF NOT cl_null(g_glan_m.glan010) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan010_desc
      ELSE
         LET r_glan001 = g_glan_m.glan010_desc
      END IF      
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan010
      ELSE
         LET r_str=g_glan_m.glan010
      END IF
   END IF 
   
   #經營方式
   IF NOT cl_null(g_glan_m.glan051) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '6013'
      LET g_ref_fields[2] = g_glan_m.glan051
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001=? AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_desc = g_rtn_fields[1]
      
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',l_desc
      ELSE
         LET r_glan001 = l_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan051
      ELSE
         LET r_str=g_glan_m.glan051
      END IF       
   END IF 
   
   #渠道
   IF NOT cl_null(g_glan_m.glan052) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan052_desc
      ELSE
         LET r_glan001 = g_glan_m.glan052_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan052
      ELSE
         LET r_str=g_glan_m.glan052
      END IF       
   END IF 
   
   #品牌
   IF NOT cl_null(g_glan_m.glan053) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan053_desc
      ELSE
         LET r_glan001 = g_glan_m.glan053_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan053
      ELSE
         LET r_str=g_glan_m.glan053
      END IF       
   END IF 
   
   #人员
   IF NOT cl_null(g_glan_m.glan011) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan011_desc
      ELSE
         LET r_glan001 = g_glan_m.glan011_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan011
      ELSE
         LET r_str=g_glan_m.glan011
      END IF      
   END IF 
#   #预算编号
#   IF NOT cl_null(g_glan_m.glan012) THEN
#      IF NOT cl_null(r_glan001) THEN
#         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan012_desc
#      ELSE
#         LET r_glan001 = g_glan_m.glan012_desc
#      END IF      
#   END IF 
   #专案编号
   IF NOT cl_null(g_glan_m.glan013) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan013_desc
      ELSE
         LET r_glan001 = g_glan_m.glan013_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan013
      ELSE
         LET r_str=g_glan_m.glan013
      END IF      
   END IF 
   #WBS
   IF NOT cl_null(g_glan_m.glan014) THEN
      IF NOT cl_null(r_glan001) THEN
         LET r_glan001 = r_glan001 ,'-',g_glan_m.glan014_desc
      ELSE
         LET r_glan001 = g_glan_m.glan014_desc
      END IF      
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glan_m.glan014
      ELSE
         LET r_str=g_glan_m.glan014
      END IF
   END IF 
   #组合科目名称以及核算项
   LET r_glan001 = l_glan001_desc,'\n',
                   r_glan001
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF                      
   RETURN r_glan001,r_str  
END FUNCTION
#更新核算项
PRIVATE FUNCTION aglt390_01_update_forzen()
   DEFINE  l_success   LIKE type_t.num5
    
   LET l_success = TRUE
 
   UPDATE glan_t SET glan003 = g_glan_m.glan003,
                     glan004 = g_glan_m.glan004,
                     glan005 = g_glan_m.glan005,
                     glan006 = g_glan_m.glan006,
                     glan007 = g_glan_m.glan007,
                     glan008 = g_glan_m.glan008,
                     glan009 = g_glan_m.glan009,
                     glan010 = g_glan_m.glan010,
                     glan011 = g_glan_m.glan011,
                     glan013 = g_glan_m.glan013,
                     glan014 = g_glan_m.glan014,
                     glan051 = g_glan_m.glan051,
                     glan052 = g_glan_m.glan052,
                     glan053 = g_glan_m.glan053
   WHERE glanent = g_enterprise
     AND glanld = g_glalld
     AND glandocno = g_glaldocno
     AND glanseq =   g_glan_d[g_detail_idx].glanseq

   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = 'update glan_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      LET l_success = FALSE
   END IF 
   RETURN l_success
END FUNCTION

 
{</section>}
 
