#該程式未解開Section, 採用最新樣板產出!
{<section id="aint302_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0028(2016-11-18 12:59:33), PR版次:0028(2016-12-29 19:08:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000359
#+ Filename...: aint302_01
#+ Description: 雜項庫存異動庫儲批明細維護作業
#+ Creator....: 02294(2013-10-17 17:32:29)
#+ Modifier...: 01534 -SD/PR- 02749
 
{</section>}
 
{<section id="aint302_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160226-00006#1    16/03/10 By lixh     20160310 点击【整单操作】-【入库明细维护】按钮，进行储位批号开窗没有资料
#160314-00008#1    16/03/16 By catmoon  批/序號3:不控管時,修改儲位/批號時沒有更新到inao_t
#160411-00014#1    16/04/11 By Dido     aint302 異動單身【入库明细】時更新 inao_t 時傳遞參數 inao000 應為 2
#160318-00025#23   16/04/22 BY 07900    校验代码重复错误讯息的修改
#160512-00004#2    16/06/23 By dorislai 1.增加製造日期欄位(inbb204、inbc203) 2.檢查是否為 有效日期(inbc203)>製造日期(inbc016)
#160617-00005#1    16/06/27 By lixiang  入庫批號自動編碼產生(料件批號須有批號且自動編碼而批號為空就自動編碼)
#160808-00063#1    16/08/09 By lixh     库位说明未带值
#160913-00053#1    16/09/21 By fionchen 調整批號開窗查無資料問題(修正q_inag004_15()前的where條件) 
#161006-00018#2    16/11/10 By lixh     增加参数D-MFG-0085(來源單據指定庫儲後，是否允許修改)
#161006-00018#31   16/11/21 By lixh     1：儲位必輸時不可以給' ';2：數量和參考數量不可以同時為0;3:批序號調整
#161109-00032#1    16/12/07 By lixh     新增作业apjt500(项目发料单)g_argv[1] = '3' 
#161109-00032#2    16/12/07 By lixh     新增作业apjt600(项目退料单)g_argv[1] = '4'
#160824-00007#278  16/12/29 By lori     修正舊值備份寫法
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
PRIVATE TYPE type_g_inbc_d RECORD
       inbcsite LIKE inbc_t.inbcsite, 
   inbcdocno LIKE inbc_t.inbcdocno, 
   inbcseq LIKE inbc_t.inbcseq, 
   inbcseq1 LIKE inbc_t.inbcseq1, 
   inbc001 LIKE inbc_t.inbc001, 
   inbc002 LIKE inbc_t.inbc002, 
   inbc005 LIKE inbc_t.inbc005, 
   inbc005_desc LIKE type_t.chr500, 
   inbc006 LIKE inbc_t.inbc006, 
   inbc006_desc LIKE type_t.chr500, 
   inbc007 LIKE inbc_t.inbc007, 
   inbc003 LIKE inbc_t.inbc003, 
   inbc010 LIKE inbc_t.inbc010, 
   inbc015 LIKE inbc_t.inbc015, 
   inbc021 LIKE inbc_t.inbc021, 
   inbc021_desc LIKE type_t.chr500, 
   inbc022 LIKE inbc_t.inbc022, 
   inbc022_desc LIKE type_t.chr500, 
   inbc023 LIKE inbc_t.inbc023, 
   inbc023_desc LIKE type_t.chr500, 
   inbc203 LIKE inbc_t.inbc203, 
   inbc016 LIKE inbc_t.inbc016, 
   inbc017 LIKE inbc_t.inbc017
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_inbb_d        RECORD
   inbbsite      LIKE inbb_t.inbbsite,
   inbbdocno     LIKE inbb_t.inbbdocno,
   inbbseq       LIKE inbb_t.inbbseq, 
   inbb001       LIKE inbb_t.inbb001, 
   inbb001_desc  LIKE type_t.chr80, 
   inbb001_desc2 LIKE type_t.chr80, 
   inbb002       LIKE inbb_t.inbb002,
   inbb002_desc  LIKE type_t.chr80, 
   inbb004       LIKE inbb_t.inbb004,
   inbb003       LIKE inbb_t.inbb003, 
   inbb007       LIKE inbb_t.inbb007, 
   inbb008       LIKE inbb_t.inbb008, 
   inbb009       LIKE inbb_t.inbb009,  
   inbb011       LIKE inbb_t.inbb011, 
   inbb014       LIKE inbb_t.inbb014,
   inbb023       LIKE inbb_t.inbb023,
   inbb023_desc  LIKE pjbal_t.pjbal003,
   inbb024       LIKE inbb_t.inbb024,
   inbb024_desc  LIKE pjbbl_t.pjbbl004,
   inbb025       LIKE inbb_t.inbb025,
   inbb025_desc  LIKE pjbml_t.pjbml004,
   inbb204 LIKE inbb_t.inbb204,  #160512-00004#2-add
   inbb022 LIKE inbb_t.inbb022,
   inbb021 LIKE inbb_t.inbb021
       END RECORD
       
DEFINE g_inbb_d          DYNAMIC ARRAY OF type_g_inbb_d

DEFINE l_ac2                  LIKE type_t.num5
DEFINE g_rec_b2               LIKE type_t.num5 
DEFINE g_detail_idx2          LIKE type_t.num5
DEFINE g_inbadocno            LIKE inba_t.inbadocno
DEFINE g_inbadocdt            LIKE inba_t.inbadocdt
DEFINE g_inba002              LIKE inba_t.inba002
DEFINE g_inba004              LIKE inba_t.inba004
DEFINE g_type                 LIKE inba_t.inba004
DEFINE g_rec_b                LIKE type_t.num5
DEFINE g_imaf061              LIKE imaf_t.imaf061
DEFINE g_imaf031              LIKE imaf_t.imaf031
DEFINE g_imaf032              LIKE imaf_t.imaf032
#161006-00018#2-S
DEFINE g_inbc005_t    LIKE inbc_t.inbc005
DEFINE g_inbc006_t    LIKE inbc_t.inbc006
DEFINE g_inbc007_t    LIKE inbc_t.inbc007 
DEFINE g_inbc010_t    LIKE inbc_t.inbc010
DEFINE g_inbc010      LIKE inbc_t.inbc010 
#161006-00018#2-E   
#end add-point
 
#模組變數(Module Variables)
DEFINE g_inbc_d          DYNAMIC ARRAY OF type_g_inbc_d #單身變數
DEFINE g_inbc_d_t        type_g_inbc_d                  #單身備份
DEFINE g_inbc_d_o        type_g_inbc_d                  #單身備份
DEFINE g_inbc_d_mask_o   DYNAMIC ARRAY OF type_g_inbc_d #單身變數
DEFINE g_inbc_d_mask_n   DYNAMIC ARRAY OF type_g_inbc_d #單身變數
 
      
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
 
{<section id="aint302_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aint302_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_type,p_inbadocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_type          LIKE inba_t.inba004
   DEFINE p_inbadocno     LIKE inba_t.inbadocno
   DEFINE l_inbastus      LIKE inba_t.inbastus

   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_inbadocno = p_inbadocno
   LET g_type = p_type
   LET l_ac2 = 1
   
   SELECT inba002,inba004,inbadocdt INTO g_inba002,g_inba004,g_inbadocdt FROM inba_t WHERE inbaent = g_enterprise AND inbadocno = g_inbadocno

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc002,inbc005,inbc006,inbc007, 
       inbc003,inbc010,inbc015,inbc021,inbc022,inbc023,inbc203,inbc016,inbc017 FROM inbc_t WHERE inbcent=?  
       AND inbcdocno=? AND inbcseq=? AND inbcseq1=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint302_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint302_01 WITH FORM cl_ap_formpath("ain","aint302_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aint302_01_init()   
 
   #進入選單 Menu (="N")
   CALL aint302_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aint302_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ""
   LET INT_FLAG = FALSE
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint302_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aint302_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("inbc015,inbb014",FALSE)
   END IF
   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("inbb002",FALSE)
   END IF
   #判斷若是雜發作業則有效日期與存貨備註隱藏不可以維護
   #IF g_type = '1' THEN                 #161109-00032#1
   IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
       CALL cl_set_comp_visible("inbb022,inbb021,inbc016,inbc017",FALSE)
       CALL cl_set_comp_visible("inbb0204,inbc203",FALSE) #製造日期 160512-00004#2-add
   END IF 
   
   #end add-point
   
   CALL aint302_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aint302_01_ui_dialog()
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
   DEFINE l_inbastus    LIKE inba_t.inbastus
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL aint302_01_inbb_fill(g_inbadocno)
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_inbc_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aint302_01_init()
      END IF
   
      CALL aint302_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_inbc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aint302_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_inbb_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)   
    
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac2
               #CALL aint302_01_inbc_fill(g_inbadocno)
               CALL aint302_01_b_fill('')
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               #CALL aint302_01_inbc_fill(g_inbadocno)
               CALL aint302_01_b_fill('')
               
         END DISPLAY
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
            CALL aint302_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aint302_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aint302_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aint302_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_inbc_d)
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
            CALL aint302_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint302_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint302_01_set_pk_array()
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
 
{<section id="aint302_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint302_01_query()
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
   CALL g_inbc_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc005,inbc006,inbc007,inbc003, 
          inbc010,inbc015,inbc021,inbc022,inbc023,inbc203,inbc016,inbc017 
 
         FROM s_detail1[1].inbcsite,s_detail1[1].inbcdocno,s_detail1[1].inbcseq,s_detail1[1].inbcseq1, 
             s_detail1[1].inbc001,s_detail1[1].inbc005,s_detail1[1].inbc006,s_detail1[1].inbc007,s_detail1[1].inbc003, 
             s_detail1[1].inbc010,s_detail1[1].inbc015,s_detail1[1].inbc021,s_detail1[1].inbc022,s_detail1[1].inbc023, 
             s_detail1[1].inbc203,s_detail1[1].inbc016,s_detail1[1].inbc017 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcsite
            #add-point:BEFORE FIELD inbcsite name="query.b.page1.inbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcsite
            
            #add-point:AFTER FIELD inbcsite name="query.a.page1.inbcsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcsite
            #add-point:ON ACTION controlp INFIELD inbcsite name="query.c.page1.inbcsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcdocno
            #add-point:BEFORE FIELD inbcdocno name="query.b.page1.inbcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcdocno
            
            #add-point:AFTER FIELD inbcdocno name="query.a.page1.inbcdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcdocno
            #add-point:ON ACTION controlp INFIELD inbcdocno name="query.c.page1.inbcdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcseq
            #add-point:BEFORE FIELD inbcseq name="query.b.page1.inbcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcseq
            
            #add-point:AFTER FIELD inbcseq name="query.a.page1.inbcseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcseq
            #add-point:ON ACTION controlp INFIELD inbcseq name="query.c.page1.inbcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcseq1
            #add-point:BEFORE FIELD inbcseq1 name="query.b.page1.inbcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcseq1
            
            #add-point:AFTER FIELD inbcseq1 name="query.a.page1.inbcseq1"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcseq1
            #add-point:ON ACTION controlp INFIELD inbcseq1 name="query.c.page1.inbcseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc001
            #add-point:BEFORE FIELD inbc001 name="query.b.page1.inbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc001
            
            #add-point:AFTER FIELD inbc001 name="query.a.page1.inbc001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc001
            #add-point:ON ACTION controlp INFIELD inbc001 name="query.c.page1.inbc001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc005
            #add-point:ON ACTION controlp INFIELD inbc005 name="construct.c.page1.inbc005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbc005  #顯示到畫面上
            NEXT FIELD inbc005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc005
            #add-point:BEFORE FIELD inbc005 name="query.b.page1.inbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc005
            
            #add-point:AFTER FIELD inbc005 name="query.a.page1.inbc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc006
            #add-point:ON ACTION controlp INFIELD inbc006 name="construct.c.page1.inbc006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbc006  #顯示到畫面上
            NEXT FIELD inbc006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc006
            #add-point:BEFORE FIELD inbc006 name="query.b.page1.inbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc006
            
            #add-point:AFTER FIELD inbc006 name="query.a.page1.inbc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc007
            #add-point:ON ACTION controlp INFIELD inbc007 name="construct.c.page1.inbc007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbc007  #顯示到畫面上
            NEXT FIELD inbc007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc007
            #add-point:BEFORE FIELD inbc007 name="query.b.page1.inbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc007
            
            #add-point:AFTER FIELD inbc007 name="query.a.page1.inbc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc003
            #add-point:ON ACTION controlp INFIELD inbc003 name="construct.c.page1.inbc003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbc003  #顯示到畫面上
            NEXT FIELD inbc003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc003
            #add-point:BEFORE FIELD inbc003 name="query.b.page1.inbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc003
            
            #add-point:AFTER FIELD inbc003 name="query.a.page1.inbc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc010
            #add-point:BEFORE FIELD inbc010 name="query.b.page1.inbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc010
            
            #add-point:AFTER FIELD inbc010 name="query.a.page1.inbc010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc010
            #add-point:ON ACTION controlp INFIELD inbc010 name="query.c.page1.inbc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc015
            #add-point:BEFORE FIELD inbc015 name="query.b.page1.inbc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc015
            
            #add-point:AFTER FIELD inbc015 name="query.a.page1.inbc015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc015
            #add-point:ON ACTION controlp INFIELD inbc015 name="query.c.page1.inbc015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbc021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc021
            #add-point:ON ACTION controlp INFIELD inbc021 name="construct.c.page1.inbc021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbc021  #顯示到畫面上
            NEXT FIELD inbc021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc021
            #add-point:BEFORE FIELD inbc021 name="query.b.page1.inbc021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc021
            
            #add-point:AFTER FIELD inbc021 name="query.a.page1.inbc021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbc022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc022
            #add-point:ON ACTION controlp INFIELD inbc022 name="construct.c.page1.inbc022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbc022  #顯示到畫面上
            NEXT FIELD inbc022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc022
            #add-point:BEFORE FIELD inbc022 name="query.b.page1.inbc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc022
            
            #add-point:AFTER FIELD inbc022 name="query.a.page1.inbc022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbc023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc023
            #add-point:ON ACTION controlp INFIELD inbc023 name="construct.c.page1.inbc023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbm002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbc023  #顯示到畫面上
            NEXT FIELD inbc023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc023
            #add-point:BEFORE FIELD inbc023 name="query.b.page1.inbc023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc023
            
            #add-point:AFTER FIELD inbc023 name="query.a.page1.inbc023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc203
            #add-point:BEFORE FIELD inbc203 name="query.b.page1.inbc203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc203
            
            #add-point:AFTER FIELD inbc203 name="query.a.page1.inbc203"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbc203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc203
            #add-point:ON ACTION controlp INFIELD inbc203 name="query.c.page1.inbc203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc016
            #add-point:BEFORE FIELD inbc016 name="query.b.page1.inbc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc016
            
            #add-point:AFTER FIELD inbc016 name="query.a.page1.inbc016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc016
            #add-point:ON ACTION controlp INFIELD inbc016 name="query.c.page1.inbc016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc017
            #add-point:BEFORE FIELD inbc017 name="query.b.page1.inbc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc017
            
            #add-point:AFTER FIELD inbc017 name="query.a.page1.inbc017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inbc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc017
            #add-point:ON ACTION controlp INFIELD inbc017 name="query.c.page1.inbc017"
            
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
    
   CALL aint302_01_b_fill(g_wc2)
 
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
 
{<section id="aint302_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint302_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aint302_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint302_01_modify()
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
   DEFINE l_inbb010    LIKE inbb_t.inbb010
   DEFINE l_inbb013    LIKE inbb_t.inbb013 
   DEFINE l_inbc016    LIKE inbc_t.inbc016
   DEFINE l_imaf032    LIKE imaf_t.imaf032
   DEFINE l_ooac004    LIKE ooac_t.ooac004
   DEFINE l_inbc010    LIKE inbc_t.inbc010
   DEFINE l_inbc015    LIKE inbc_t.inbc015
   DEFINE l_inaa007    LIKE inaa_t.inaa007
   DEFINE l_inbastus   LIKE inba_t.inbastus
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_rate       LIKE inaj_t.inaj014   
   DEFINE l_flag       LIKE type_t.num5
   DEFINE l_ooac002    LIKE ooac_t.ooac002
   DEFINE l_imaf062    LIKE imaf_t.imaf062
   DEFINE l_imaf063    LIKE imaf_t.imaf063
   DEFINE l_flag1      LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5
   #160617-00005#1---s--
   DEFINE l_imaf061      LIKE imaf_t.imaf061
   DEFINE l_oofg_return DYNAMIC ARRAY OF RECORD    
             oofg019     LIKE oofg_t.oofg019,   #field
             oofg020     LIKE oofg_t.oofg020    #value
                     END RECORD
   #160617-00005#1---e--
   DEFINE l_sql1         STRING             #161006-00018#2
   DEFINE l_flag2        LIKE type_t.chr1   #161006-00018#31
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
   LET l_flag2 = 'N'      #161006-00018#31
   LET g_errshow = 1
   
   LET l_inbastus = ''
   SELECT inbastus INTO l_inbastus FROM inba_t WHERE inbaent = g_enterprise AND inbasite = g_site AND inbadocno = g_inbadocno
   IF l_inbastus != 'Y' THEN
      #該單據編號已過賬，不可修改！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00024'
      LET g_errparam.extend = g_inbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_inbc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inbc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint302_01_b_fill(g_wc2)
            LET g_detail_cnt = g_inbc_d.getLength()
         
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
            DISPLAY g_inbc_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_inbc_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inbc_d[l_ac].inbcdocno IS NOT NULL
               AND g_inbc_d[l_ac].inbcseq IS NOT NULL
               AND g_inbc_d[l_ac].inbcseq1 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inbc_d_t.* = g_inbc_d[l_ac].*  #BACKUP
               LET g_inbc_d_o.* = g_inbc_d[l_ac].*  #BACKUP
               IF NOT aint302_01_lock_b("inbc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint302_01_bcl INTO g_inbc_d[l_ac].inbcsite,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq, 
                      g_inbc_d[l_ac].inbcseq1,g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc005, 
                      g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc010, 
                      g_inbc_d[l_ac].inbc015,g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022,g_inbc_d[l_ac].inbc023, 
                      g_inbc_d[l_ac].inbc203,g_inbc_d[l_ac].inbc016,g_inbc_d[l_ac].inbc017
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inbc_d_t.inbcdocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inbc_d_mask_o[l_ac].* =  g_inbc_d[l_ac].*
                  CALL aint302_01_inbc_t_mask()
                  LET g_inbc_d_mask_n[l_ac].* =  g_inbc_d[l_ac].*
                  
                  CALL aint302_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aint302_01_set_entry_b(l_cmd)
            CALL aint302_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL aint302_01_set_entry_b(l_cmd)
            CALL aint302_01_set_no_required()
            CALL aint302_01_set_required()
            CALL aint302_01_set_no_entry_b(l_cmd)
            #161006-00018#2-S 
            LET l_inbb010 = ''
            SELECT inbb010 INTO l_inbb010 FROM inbb_t
             WHERE inbbent = g_enterprise
               AND inbbdocno = g_inbc_d[l_ac].inbcdocno
               AND inbbseq = g_inbc_d[l_ac].inbcseq
            #161006-00018#2-E   
            IF l_cmd = 'u' THEN   #修改
               LET l_inbb010 = ''
               LET l_inbb013 = ''
               SELECT inbb010,inbb013 INTO l_inbb010,l_inbb013 FROM inbb_t 
                  WHERE inbbent = g_enterprise AND inbbsite = g_site 
                     AND inbbdocno = g_inbc_d[l_ac].inbcdocno
                     AND inbbseq = g_inbc_d[l_ac].inbcseq     
               #161006-00018#2-S
               LET g_inbc005_t = g_inbc_d[l_ac].inbc005
               LET g_inbc006_t = g_inbc_d[l_ac].inbc006
               LET g_inbc007_t = g_inbc_d[l_ac].inbc007
               LET g_inbc010_t = g_inbc_d[l_ac].inbc010
               IF g_inbc005_t IS NULL THEN LET g_inbc005_t = ' ' END IF
               IF g_inbc006_t IS NULL THEN LET g_inbc006_t = ' ' END IF
               IF g_inbc007_t IS NULL THEN LET g_inbc007_t = ' ' END IF               
               #161006-00018#2-E               
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
            INITIALIZE g_inbc_d_t.* TO NULL
            INITIALIZE g_inbc_d_o.* TO NULL
            INITIALIZE g_inbc_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_inbc_d[l_ac].inbc010 = "0"
      LET g_inbc_d[l_ac].inbc015 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_inbc_d_t.* = g_inbc_d[l_ac].*     #新輸入資料
            LET g_inbc_d_o.* = g_inbc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inbc_d[li_reproduce_target].* = g_inbc_d[li_reproduce].*
 
               LET g_inbc_d[g_inbc_d.getLength()].inbcdocno = NULL
               LET g_inbc_d[g_inbc_d.getLength()].inbcseq = NULL
               LET g_inbc_d[g_inbc_d.getLength()].inbcseq1 = NULL
 
            END IF
            
 
            CALL aint302_01_set_entry_b(l_cmd)
            CALL aint302_01_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_inbc_d[l_ac].inbcdocno = g_inbadocno
            LET g_inbc_d[l_ac].inbcseq = g_inbb_d[l_ac2].inbbseq
            LET g_inbc_d[l_ac].inbc001 = g_inbb_d[l_ac2].inbb001
            LET g_inbc_d[l_ac].inbc005 = g_inbb_d[l_ac2].inbb007
            LET g_inbc_d[l_ac].inbc006 = g_inbb_d[l_ac2].inbb008
            LET g_inbc_d[l_ac].inbc007 = g_inbb_d[l_ac2].inbb009
            LET g_inbc_d[l_ac].inbcsite = g_inbb_d[l_ac2].inbbsite
            LET g_inbc_d[l_ac].inbc203 = g_inbb_d[l_ac2].inbb204  #160512-00004#2-add
            LET g_inbc_d[l_ac].inbc016 = g_inbb_d[l_ac2].inbb022
            LET g_inbc_d[l_ac].inbc017 = g_inbb_d[l_ac2].inbb021
            LET g_inbc_d[l_ac].inbc003 = g_inbb_d[l_ac2].inbb003
            LET g_inbc_d[l_ac].inbc002 = g_inbb_d[l_ac2].inbb002
            #161006-00018#2-S
            LET l_inbb010 = ''
            SELECT inbb010 INTO l_inbb010 FROM inbb_t
             WHERE inbbent = g_enterprise
               AND inbbdocno = g_inbc_d[l_ac].inbcdocno
               AND inbbseq = g_inbc_d[l_ac].inbcseq
            #161006-00018#2-E   
            CALL aint302_01_inbc005_ref(g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc
            
            LET l_inaa007 = ''
            SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inbc_d[l_ac].inbc005
            #IF cl_null(g_inbc_d[l_ac].inbc006) AND l_inaa007 = '1' THEN  #161006-00018#31
            #1.使用储位管理-事先规划,2.使用储位管理-人工指定,5.不使用储位管理
            IF cl_null(g_inbc_d[l_ac].inbc006) AND l_inaa007 = '5' THEN   #161006-00018#31
               LET g_inbc_d[l_ac].inbc006 = ' '
            END IF
            
            CALL aint302_01_inbc006_ref(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) RETURNING g_inbc_d[l_ac].inbc006_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc006_desc
            
            
            SELECT MAX(inbcseq1)+1 INTO g_inbc_d[l_ac].inbcseq1 FROM inbc_t
               WHERE inbcent = g_enterprise AND inbcsite = g_site 
                 AND inbcdocno = g_inbc_d[l_ac].inbcdocno AND inbcseq = g_inbc_d[l_ac].inbcseq
            IF cl_null(g_inbc_d[l_ac].inbcseq1) OR g_inbc_d[l_ac].inbcseq1 = 0 THEN
               LET g_inbc_d[l_ac].inbcseq1 = 1
            END IF
            
            CALL aint302_01_set_entry_b(l_cmd)
            CALL aint302_01_set_no_required()
            CALL aint302_01_set_required()
            CALL aint302_01_set_no_entry_b(l_cmd)
            
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
            SELECT COUNT(1) INTO l_count FROM inbc_t 
             WHERE inbcent = g_enterprise AND inbcdocno = g_inbc_d[l_ac].inbcdocno
                                       AND inbcseq = g_inbc_d[l_ac].inbcseq
                                       AND inbcseq1 = g_inbc_d[l_ac].inbcseq1
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               #160617-00005#1---s--
               #若是雜項庫存收料作業時
               #IF g_argv[1] = '2' THEN   #161109-00032#1
               IF g_argv[1] = '2' OR g_argv[1] = '4' THEN  #161109-00032#1
                  LET l_imaf061 = ''
                  LET l_imaf062 = ''
                  LET l_imaf063 = ''
                  SELECT imaf061,imaf062,imaf063 INTO l_imaf061,l_imaf062,l_imaf063  
                    FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_inbc_d[l_ac].inbc001
               
                  IF cl_null(g_inbc_d[l_ac].inbc007) AND l_imaf061 = '1' AND l_imaf062 = 'Y' AND (NOT cl_null(l_imaf063)) THEN
                     CALL s_aooi390_gen_1('6',l_imaf063) RETURNING l_success,g_inbc_d[l_ac].inbc007,l_oofg_return
                     IF NOT l_success THEN
                        LET g_inbc_d[l_ac].inbc007 = ''
                     ELSE
                        CALL s_aooi390_get_auto_no('6',g_inbc_d[l_ac].inbc007) RETURNING l_success,g_inbc_d[l_ac].inbc007
                        CALL s_aooi390_oofi_upd('6',g_inbc_d[l_ac].inbc007) RETURNING l_success
                     END IF
                  END IF
                  DISPLAY BY NAME g_inbc_d[l_ac].inbc007
               END IF
               #160617-00005#1---e--
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbc_d[g_detail_idx].inbcdocno
               LET gs_keys[2] = g_inbc_d[g_detail_idx].inbcseq
               LET gs_keys[3] = g_inbc_d[g_detail_idx].inbcseq1
               CALL aint302_01_insert_b('inbc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #161006-00018#2-S
               #出库单据更新在捡量
               #IF g_argv[1] = '1' THEN  #161109-00032#1
               IF g_argv[1] = '1' OR g_argv[1] = '3' THEN   #161109-00032#1
                  #在撿量增加
                  LET l_inbb010 = ''
                  SELECT inbb010 INTO l_inbb010 FROM inbb_t
                   WHERE inbbent = g_enterprise
                     AND inbbdocno = g_inbc_d[l_ac].inbcdocno
                     AND inbbseq = g_inbc_d[l_ac].inbcseq
                  IF NOT cl_null(g_inbc_d[l_ac].inbc005) THEN   
                     IF NOT s_inventory_ins_inap('1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
                                                 g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
                                                 g_dept,'') THEN
                        #LET r_success = FALSE
                     END IF
                  END IF                  
               END IF
               #161006-00018#2-E
               #end add-point
            ELSE    
               INITIALIZE g_inbc_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint302_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               LET l_inbb010 = ''
               LET l_inbb013 = ''
               SELECT inbb010,inbb013 INTO l_inbb010,l_inbb013 FROM inbb_t 
                  WHERE inbbent = g_enterprise AND inbbsite = g_site 
                     AND inbbdocno = g_inbc_d[l_ac].inbcdocno
                     AND inbbseq = g_inbc_d[l_ac].inbcseq
               
               
               UPDATE inbc_t SET (inbc002,inbc003,inbc004,inbc009,inbc011,inbc016) =
                   (g_inbb_d[l_ac2].inbb002,g_inbb_d[l_ac2].inbb003,g_inbb_d[l_ac2].inbb004,
                    l_inbb010,l_inbb013,g_inbc_d[l_ac].inbc016)
                 WHERE inbcent = g_enterprise AND inbcsite = g_site AND inbcdocno = g_inbc_d[l_ac].inbcdocno
                                       AND inbcseq = g_inbc_d[l_ac].inbcseq
                                       AND inbcseq1 = g_inbc_d[l_ac].inbcseq1
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inbc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF    
               
               #更新申請明細的實際數量
                SELECT SUM(inbc010),SUM(inbc015) INTO l_inbc010,l_inbc015 FROM inbc_t
                 WHERE inbcent = g_enterprise AND inbcsite = g_site 
                   AND inbcdocno = g_inbc_d[l_ac].inbcdocno #項次   
                   AND inbcseq = g_inbc_d[l_ac].inbcseq

               UPDATE inbb_t SET inbb012 = l_inbc010,inbb015 = l_inbc015
                    WHERE inbbent = g_enterprise AND inbbsite = g_site 
                      AND inbbdocno = g_inbc_d[l_ac].inbcdocno
                      AND inbbseq = g_inbc_d[l_ac].inbcseq   
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inbb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
               
               CALL s_transaction_end('Y','0')  
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (inbcdocno = '", g_inbc_d[l_ac].inbcdocno, "' "
                                  ," AND inbcseq = '", g_inbc_d[l_ac].inbcseq, "' "
                                  ," AND inbcseq1 = '", g_inbc_d[l_ac].inbcseq1, "' "
 
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
               #add by lixh 20151222
               #回寫申請單 inao021
               #IF g_type = '1' THEN #161109-00032#1
               IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
                  CALL s_aint302_upd_inao(g_inbc_d_t.inbcdocno,g_inbc_d_t.inbcseq,g_inbc_d_t.inbcseq1,'-1',g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,'-1')
                       RETURNING r_success
               ELSE
                  CALL s_aint302_upd_inao(g_inbc_d_t.inbcdocno,g_inbc_d_t.inbcseq,g_inbc_d_t.inbcseq1,'1',g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,'-1')
                       RETURNING r_success               
               END IF
               DELETE FROM inao_t WHERE inaoent = g_enterprise
                                    AND inaodocno = g_inbc_d_t.inbcdocno
                                    AND inao000 = '2'
                                    AND inaoseq = g_inbc_d_t.inbcseq
                                    AND inaoseq1 = g_inbc_d_t.inbcseq1
               IF NOT r_success THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE               
               END IF
               #add by lixh 20151222 
               #在撿量減少（-1）               
               #161006-00018#2-S
               #IF g_type = '1' THEN  #aint301        #161109-00032#1
               IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
                  LET l_inbb010 = ''
                  SELECT inbb010 INTO l_inbb010 FROM inbb_t
                   WHERE inbbent = g_enterprise
                     AND inbbdocno = g_inbc_d_t.inbcdocno
                     AND inbbseq = g_inbc_d_t.inbcseq
                  IF NOT cl_null(g_inbc_d[l_ac].inbc005) THEN   
                     IF NOT s_inventory_ins_inap('-1',g_site,g_inbc_d_t.inbcdocno,g_inbc_d_t.inbcseq,g_inbc_d[l_ac].inbcseq1,
                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
                                                 g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
                                                 g_dept,'') THEN
                     END IF
                  END IF                  
               END IF
               #161006-00018#2-E               
               #end add-point   
               
               DELETE FROM inbc_t
                WHERE inbcent = g_enterprise AND 
                      inbcdocno = g_inbc_d_t.inbcdocno
                      AND inbcseq = g_inbc_d_t.inbcseq
                      AND inbcseq1 = g_inbc_d_t.inbcseq1
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
 
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                   CALL s_transaction_end('Y','0')  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aint302_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_inbc_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE aint302_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_inbc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbc_d_t.inbcdocno
               LET gs_keys[2] = g_inbc_d_t.inbcseq
               LET gs_keys[3] = g_inbc_d_t.inbcseq1
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint302_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aint302_01_delete_b('inbc_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inbc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcsite
            #add-point:BEFORE FIELD inbcsite name="input.b.page1.inbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcsite
            
            #add-point:AFTER FIELD inbcsite name="input.a.page1.inbcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbcsite
            #add-point:ON CHANGE inbcsite name="input.g.page1.inbcsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcdocno
            #add-point:BEFORE FIELD inbcdocno name="input.b.page1.inbcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcdocno
            
            #add-point:AFTER FIELD inbcdocno name="input.a.page1.inbcdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_inbc_d[g_detail_idx].inbcdocno) AND NOT cl_null(g_inbc_d[g_detail_idx].inbcseq) AND NOT cl_null(g_inbc_d[g_detail_idx].inbcseq1) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inbc_d[g_detail_idx].inbcdocno != g_inbc_d_t.inbcdocno OR g_inbc_d[g_detail_idx].inbcseq != g_inbc_d_t.inbcseq OR g_inbc_d[g_detail_idx].inbcseq1 != g_inbc_d_t.inbcseq1))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbc_t WHERE "||"inbcent = '" ||g_enterprise|| "' AND inbcsite = '" ||g_site|| "' AND "||"inbcdocno = '"||g_inbc_d[g_detail_idx].inbcdocno ||"' AND "|| "inbcseq = '"||g_inbc_d[g_detail_idx].inbcseq ||"' AND "|| "inbcseq1 = '"||g_inbc_d[g_detail_idx].inbcseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbcdocno
            #add-point:ON CHANGE inbcdocno name="input.g.page1.inbcdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcseq
            #add-point:BEFORE FIELD inbcseq name="input.b.page1.inbcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcseq
            
            #add-point:AFTER FIELD inbcseq name="input.a.page1.inbcseq"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_inbc_d[g_detail_idx].inbcdocno) AND NOT cl_null(g_inbc_d[g_detail_idx].inbcseq) AND NOT cl_null(g_inbc_d[g_detail_idx].inbcseq1) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inbc_d[g_detail_idx].inbcdocno != g_inbc_d_t.inbcdocno OR g_inbc_d[g_detail_idx].inbcseq != g_inbc_d_t.inbcseq OR g_inbc_d[g_detail_idx].inbcseq1 != g_inbc_d_t.inbcseq1))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbc_t WHERE "||"inbcent = '" ||g_enterprise|| "' AND inbcsite = '" ||g_site|| "' AND "||"inbcdocno = '"||g_inbc_d[g_detail_idx].inbcdocno ||"' AND "|| "inbcseq = '"||g_inbc_d[g_detail_idx].inbcseq ||"' AND "|| "inbcseq1 = '"||g_inbc_d[g_detail_idx].inbcseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbcseq
            #add-point:ON CHANGE inbcseq name="input.g.page1.inbcseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbcseq1
            #add-point:BEFORE FIELD inbcseq1 name="input.b.page1.inbcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbcseq1
            
            #add-point:AFTER FIELD inbcseq1 name="input.a.page1.inbcseq1"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_inbc_d[g_detail_idx].inbcdocno) AND NOT cl_null(g_inbc_d[g_detail_idx].inbcseq) AND NOT cl_null(g_inbc_d[g_detail_idx].inbcseq1) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inbc_d[g_detail_idx].inbcdocno != g_inbc_d_t.inbcdocno OR g_inbc_d[g_detail_idx].inbcseq != g_inbc_d_t.inbcseq OR g_inbc_d[g_detail_idx].inbcseq1 != g_inbc_d_t.inbcseq1))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inbc_t WHERE "||"inbcent = '" ||g_enterprise|| "' AND inbcsite = '" ||g_site|| "' AND "||"inbcdocno = '"||g_inbc_d[g_detail_idx].inbcdocno ||"' AND "|| "inbcseq = '"||g_inbc_d[g_detail_idx].inbcseq ||"' AND "|| "inbcseq1 = '"||g_inbc_d[g_detail_idx].inbcseq1 ||"'",'std-00004',0) THEN 
                     LET g_inbc_d[g_detail_idx].inbcseq1 = g_inbc_d_t.inbcseq1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbcseq1
            #add-point:ON CHANGE inbcseq1 name="input.g.page1.inbcseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc001
            #add-point:BEFORE FIELD inbc001 name="input.b.page1.inbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc001
            
            #add-point:AFTER FIELD inbc001 name="input.a.page1.inbc001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc001
            #add-point:ON CHANGE inbc001 name="input.g.page1.inbc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc005
            
            #add-point:AFTER FIELD inbc005 name="input.a.page1.inbc005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbc_d[l_ac].inbc005
            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
            LET g_inbc_d[l_ac].inbc005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc
            #161006-00018#2-S 
            IF NOT cl_null(g_inbc_d[l_ac].inbc005) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbc_d[l_ac].inbc005 != g_inbc_d_t.inbc005 OR cl_null(g_inbc_d_t.inbc005))) THEN  #161006-00018#31 mark
               #161006-00018#31-S
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((g_inbc_d[l_ac].inbc005 != g_inbc_d_t.inbc005 OR cl_null(g_inbc_d_t.inbc005))  #161006-00018#31
                  OR (g_inbc_d[l_ac].inbc006 != g_inbc_d_t.inbc006 OR g_inbc_d_t.inbc006 IS NULL)
                  OR (g_inbc_d[l_ac].inbc007 != g_inbc_d_t.inbc007))) THEN      
               #161006-00018#31-E 
                  #检查库位是否存在&有效
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbc_d[l_ac].inbc005      
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inay001") THEN 
                     LET g_inbc_d[l_ac].inbc005 = g_inbc_d_t.inbc005
                     CALL s_desc_get_stock_desc(g_site,g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc
                     DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc               
                     NEXT FIELD CURRENT
                  END IF
                  #若輸入的庫位+儲位不存在[T:儲位資料檔]時，則呼叫應用元件判斷是否需要新增儲位基本資料 
                  #IF g_type = '2' THEN   #161109-00032#1
                  IF g_type = '2' OR g_type = '4' THEN  #161109-00032#1
                     IF NOT cl_null(g_inbc_d[l_ac].inbc006) THEN
                        IF NOT s_aini002_ins_inab(g_site,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ain-00282'
                           LET g_errparam.extend = "inab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_inbc_d[l_ac].inbc005 = g_inbc_d_t.inbc005
                           CALL s_desc_get_stock_desc(g_site,g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc
                           DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc                 
                           NEXT FIELD CURRENT
                        END IF
                     END IF 
                  END IF
  
                  IF NOT aint302_01_inbc006_chk(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) THEN
                     LET g_inbc_d[l_ac].inbc005 = g_inbc_d_t.inbc005
                     CALL s_desc_get_stock_desc(g_site,g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc
                     DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00018#2-S
                  IF NOT aint302_01_check_inag() THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00018#2-E
                  IF s_lot_batch_number_1n3(g_inbb_d[g_detail_idx2].inbb001,g_site) THEN 
                     #IF g_type = '2' THEN    #161109-00032#1
                     IF g_type = '2' OR g_type = '4' THEN  #161109-00032#1
                        CALL s_lot_upd_inao(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,'2',g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_site,g_inbc_d[l_ac].inbc003)  
                             RETURNING r_success
                     END IF 
                     #IF g_type = '1' THEN   #aint301 雜發  #161109-00032#1
                     IF g_type = '1' OR g_type = '3' THEN   #aint301 雜發  #161109-00032#1
                        CALL s_lot_inao_chk(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,' ',g_site) RETURNING l_success,l_count
                        IF l_count > 0 THEN
                           IF l_success  THEN
                              CALL s_lot_sel('1','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')   
                                   RETURNING l_success                                     
                           ELSE
                              LET g_inbc_d[l_ac].inbc005 = g_inbc_d_t.inbc005   
                              CALL s_desc_get_stock_desc(g_site,g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc                              
                           END IF
                        ELSE
                           CALL s_lot_sel('1','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')   
                                RETURNING l_success                                                     
                        END IF                     
                     END IF                                              
                  END IF   
                  #出庫單據在撿量異動
                  #旧库存在捡量减少&新库位在捡量增加
                  #161006-00018#2-S
#                  IF g_type = '1' THEN
#                     IF l_cmd = 'u' AND (g_inbc_d[l_ac].inbc005 != g_inbc_d_t.inbc005 OR cl_null(g_inbc_d_t.inbc005)) THEN
#                     
#                        #在捡量减少   
#                        IF NOT s_inventory_ins_inap('-1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                    g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc005_t,g_inbc_d[l_ac].inbc006,
#                                                    g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
#                                                    g_dept,'') THEN
#                           #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                           NEXT FIELD inbc005
#                        END IF 
#                        #在捡量增加
#                        IF NOT s_inventory_ins_inap('1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                    g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
#                                                    g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
#                                                    g_dept,'') THEN
#                           #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                           NEXT FIELD inbc005
#                        END IF                        
#                     END IF                     
#                  END IF
                  #161006-00018#2-E                  
               END IF
            END IF  
            CALL aint302_01_set_entry_b(l_cmd)
            CALL aint302_01_set_no_required()
            CALL aint302_01_set_required()
            CALL aint302_01_set_no_entry_b(l_cmd)            
            CALL s_desc_get_stock_desc(g_site,g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc
            LET g_inbc_d_t.inbc005 = g_inbc_d[l_ac].inbc005
            #161006-00018#31-S            
            LET g_inbc_d_t.inbc006 = g_inbc_d[l_ac].inbc006
            LET g_inbc_d_t.inbc007 = g_inbc_d[l_ac].inbc007 
            #161006-00018#31-E            
            #161006-00018#2-E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc005
            #add-point:BEFORE FIELD inbc005 name="input.b.page1.inbc005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc005
            #add-point:ON CHANGE inbc005 name="input.g.page1.inbc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc006
            
            #add-point:AFTER FIELD inbc006 name="input.a.page1.inbc006"
            LET l_inaa007 = ''
            SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inbc_d[l_ac].inbc005
            #IF cl_null(g_inbc_d[l_ac].inbc006) AND l_inaa007 = '1' THEN
            #   LET g_inbc_d[l_ac].inbc006 = ' '
            #END IF
            
            CALL aint302_01_inbc006_ref(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) RETURNING g_inbc_d[l_ac].inbc006_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc006_desc
            
            #IF (g_inbc_d[l_ac].inbc006 IS NOT NULL) AND (NOT cl_null(g_inbc_d[l_ac].inbc005)) THEN 
            IF (NOT cl_null(g_inbc_d[l_ac].inbc006)) AND (NOT cl_null(g_inbc_d[l_ac].inbc005)) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbc_d[l_ac].inbc006 != g_inbc_d_t.inbc006 OR cl_null(g_inbc_d_t.inbc006))) THEN 
               #161006-00018#31-S
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((g_inbc_d[l_ac].inbc005 != g_inbc_d_t.inbc005 OR cl_null(g_inbc_d_t.inbc005))  
                  OR (g_inbc_d[l_ac].inbc006 != g_inbc_d_t.inbc006 OR g_inbc_d_t.inbc006 IS NULL)
                  OR (g_inbc_d[l_ac].inbc007 != g_inbc_d_t.inbc007))) THEN      
               #161006-00018#31-E                
                  #若輸入的庫位+儲位不存在[T:儲位資料檔]時，則呼叫應用元件判斷是否需要新增儲位基本資料 
                   #IF g_type = '2' THEN
                  IF g_type = '2' OR g_type = '4' THEN   #aint301 雜發  #161109-00032#1  
                      IF NOT s_aini002_ins_inab(g_site,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'ain-00282'
                         LET g_errparam.extend = "inab_t"
                         LET g_errparam.popup = TRUE
                         CALL cl_err()

                         NEXT FIELD CURRENT
                      END IF
                   END IF

                  #161006-00018#2-S
                  IF NOT aint302_01_check_inag() THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00018#2-E
                  IF NOT aint302_01_inbc006_chk(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) THEN
                     LET g_inbc_d[l_ac].inbc006 = g_inbc_d_t.inbc006
                     CALL aint302_01_inbc006_ref(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) RETURNING g_inbc_d[l_ac].inbc006_desc
                     DISPLAY BY NAME g_inbc_d[l_ac].inbc006_desc
                     NEXT FIELD CURRENT
                  END IF
               #add by lixh 20151218
                 #IF s_lot_batch_number(g_inbb_d[g_detail_idx2].inbb001,g_site) THEN     #160314-00008#1 mark
                  IF s_lot_batch_number_1n3(g_inbb_d[g_detail_idx2].inbb001,g_site) THEN #160314-00008#1 add
                     #IF g_type = '2' THEN   #161109-00032#1
                     IF g_type = '2' OR g_type = '4' THEN   #aint301 雜發  #161109-00032#1
                       #CALL s_lot_upd_inao(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,'1',g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_site,g_inbc_d[l_ac].inbc003)  #160316-00007#1 add by lixh 20160316 #160411-00014 mark
                        CALL s_lot_upd_inao(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,'2',g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_site,g_inbc_d[l_ac].inbc003)  #160411-00014 by Dido 20160411
                             RETURNING r_success
                     END IF 
                     #IF g_type = '1' THEN   #aint301 雜發                 #161109-00032#1
                     IF g_type = '1' OR g_type = '3' THEN   #aint301 雜發  #161109-00032#1
                        CALL s_lot_inao_chk(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,' ',g_site) RETURNING l_success,l_count
                        IF l_count > 0 THEN
                           IF l_success  THEN
                              CALL s_lot_sel('1','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')   
                                   RETURNING l_success  
                                   
#                              IF NOT aint302_ins_inao_2() THEN
#                                 NEXT FIELD CURRENT
#                              END IF
#                              CALL aint302_inao_fill2() 
                           ELSE
                              LET g_inbc_d[l_ac].inbc006 = g_inbc_d_t.inbc006                         
                           END IF
                        ELSE
                           CALL s_lot_sel('1','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')   
                                RETURNING l_success                                 
#                           IF NOT aint302_ins_inao_2() THEN
#                              NEXT FIELD CURRENT
#                           END IF
#                           CALL aint302_inao_fill2()                      
                        #add by lixh 20151204                     
                        END IF                     
                     END IF                         
                     
                  END IF                  
               #add by lixh 20151218                  
               END IF
               
               #出庫單據在撿量異動
               #旧库存在捡量减少&新库位在捡量增加
               #161006-00018#2-S
#               IF g_type = '1' THEN
#                  IF g_inbc_d[l_ac].inbc006 IS NULL THEN LET g_inbc_d[l_ac].inbc006 = ' ' END IF
#                  IF l_cmd = 'u' AND (g_inbc_d[l_ac].inbc006 != g_inbc_d_t.inbc006 OR cl_null(g_inbc_d_t.inbc006)) THEN
#                  
#                     LET l_inbb010 = ''
#                     SELECT inbb010 INTO l_inbb010 FROM inbb_t
#                      WHERE inbbent = g_enterprise
#                        AND inbbdocno = g_inbc_d[l_ac].inbcdocno
#                        AND inbbseq = g_inbc_d[l_ac].inbcseq
#                     #在捡量减少   
#                     IF NOT s_inventory_ins_inap('-1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc006_t,
#                                                 g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
#                                                 g_dept,'') THEN
#                        #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                        NEXT FIELD inbc006
#                     END IF 
#                     #在捡量增加
#                     IF NOT s_inventory_ins_inap('1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
#                                                 g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
#                                                 g_dept,'') THEN
#                        #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                        NEXT FIELD inbc006
#                     END IF                        
#                  END IF                     
#               END IF
               #161006-00018#2-E                 
            END IF
          
            #IF cl_null(g_inbc_d[l_ac].inbc006) AND l_inaa007 = '1' THEN  #161006-00018#31
            IF cl_null(g_inbc_d[l_ac].inbc006) AND l_inaa007 = '5' THEN   #161006-00018#31
               LET g_inbc_d[l_ac].inbc006 = ' '                              
            END IF
            CALL aint302_01_set_entry_b(l_cmd)
            CALL aint302_01_set_no_required()
            CALL aint302_01_set_required()
            CALL aint302_01_set_no_entry_b(l_cmd)
            LET g_inbc_d_t.inbc006 = g_inbc_d[l_ac].inbc006    #add by lixh 20151221
            #161006-00018#31-S            
            LET g_inbc_d_t.inbc005 = g_inbc_d[l_ac].inbc005
            LET g_inbc_d_t.inbc007 = g_inbc_d[l_ac].inbc007 
            #161006-00018#31-E             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc006
            #add-point:BEFORE FIELD inbc006 name="input.b.page1.inbc006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc006
            #add-point:ON CHANGE inbc006 name="input.g.page1.inbc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc007
            #add-point:BEFORE FIELD inbc007 name="input.b.page1.inbc007"
            ##若料件據點資料設置批號自動編碼，則進欄位之前自動編號
            #IF cl_null(g_inbc_d[l_ac].inbc007) THEN
            #   LET l_imaf062 = ''
            #   LET l_imaf063 = ''
            #   SELECT imaf062,imaf063 INTO l_imaf062,l_imaf063 FROM imaf_t 
            #      WHERE imafent = g_enterprise AND imaf001 = g_inbc_d[l_ac].inbc001 AND imafsite = g_site
            #   IF l_imaf062 = 'Y' AND (NOT cl_null(l_imaf063)) THEN  #自動編碼
            #       CALL s_aooi390_1('6',l_imaf063) RETURNING l_success,g_inbc_d[l_ac].inbc007
            #   END IF
            #END IF       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc007
            
            #add-point:AFTER FIELD inbc007 name="input.a.page1.inbc007"
            IF NOT cl_null(g_inbc_d[l_ac].inbc007) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbc_d[l_ac].inbc007 != g_inbc_d_t.inbc007 OR cl_null(g_inbc_d_t.inbc007))) THEN 
               #161006-00018#31-S
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((g_inbc_d[l_ac].inbc005 != g_inbc_d_t.inbc005 OR cl_null(g_inbc_d_t.inbc005))  
                  OR (g_inbc_d[l_ac].inbc006 != g_inbc_d_t.inbc006 OR g_inbc_d_t.inbc006 IS NULL)
                  OR (g_inbc_d[l_ac].inbc007 != g_inbc_d_t.inbc007 OR cl_null(g_inbc_d_t.inbc007)))) THEN      
               #161006-00018#31-E                
                  IF NOT aint302_01_inbc007_chk() THEN
                     LET g_inbc_d[l_ac].inbc007 = g_inbc_d_t.inbc007
                     NEXT FIELD CURRENT
                  END IF
                  #雜收作業若料件要做批號管理且又有做有效期管理時，需要自動計算該批的有效日期
                  #IF g_type = '2' AND cl_null(g_inbc_d[l_ac].inbc016) THEN                    #161109-00032#1
                  IF (g_type = '2' OR g_type = '4')  AND cl_null(g_inbc_d[l_ac].inbc016) THEN  #161109-00032#1
                     CALL s_aini010_calculate_effdt(g_site,g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac2].inbc002,g_inbc_d[l_ac].inbc007,g_inbadocdt) RETURNING g_inbc_d[l_ac].inbc016
                     DISPLAY BY NAME g_inbc_d[l_ac].inbc016
                  
                  END IF
                  
                  #161006-00018#2-S
                  IF NOT aint302_01_check_inag() THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00018#2-E
                  
               #add by lixh 20151218
                 #IF s_lot_batch_number(g_inbb_d[g_detail_idx2].inbb001,g_site) THEN      #160314-00008#1 mark
                  IF s_lot_batch_number_1n3(g_inbb_d[g_detail_idx2].inbb001,g_site) THEN  #160314-00008#1 add
                     #IF g_type = '2' THEN  #161109-00032#1
                     IF g_type = '2' OR g_type = '4' THEN  #161109-00032#1
                        CALL s_lot_upd_inao(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,'1',g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_site,g_inbc_d[l_ac].inbc003)   #160316-00007#1 add by lixh 20160316
                             RETURNING r_success
                     END IF   
                     #IF g_type = '1' THEN   #aint301 雜發  #161109-00032#1
                     IF g_type = '1' OR g_type = '3' THEN   #aint301 雜發  #161109-00032#1
                        CALL s_lot_inao_chk(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,' ',g_site) RETURNING l_success,l_count
                        IF l_count > 0 THEN
                           IF l_success  THEN
                              CALL s_lot_sel('1','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')   
                                   RETURNING l_success  
                                   
#                              IF NOT aint302_ins_inao_2() THEN
#                                 NEXT FIELD CURRENT
#                              END IF
#                              CALL aint302_inao_fill2() 
                           ELSE
                              LET g_inbc_d[l_ac].inbc007 = g_inbc_d_t.inbc007                         
                           END IF
                        ELSE
                           CALL s_lot_sel('1','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')   
                                RETURNING l_success                                 
#                           IF NOT aint302_ins_inao_2() THEN
#                              NEXT FIELD CURRENT
#                           END IF
#                           CALL aint302_inao_fill2()                      
                        #add by lixh 20151204                     
                        END IF                     
                     END IF   
                  END IF                     
               #add by lixh 20151218                    
               END IF
            #ELSE
            #   LET l_imaf062 = ''
            #   LET l_imaf063 = ''
            #   SELECT imaf062,imaf063 INTO l_imaf062,l_imaf063 FROM imaf_t 
            #      WHERE imafent = g_enterprise AND imaf001 = g_inbc_d[l_ac].inbc001 AND imafsite = g_site
            #   IF l_imaf062 = 'Y' AND (NOT cl_null(l_imaf063)) THEN  #自動編碼
            #       CALL s_aooi390_1('6',l_imaf063) RETURNING l_success,g_inbc_d[l_ac].inbc007
            #   END IF
               #161006-00018#2-S
#               IF g_type = '1' THEN
#                  IF l_cmd = 'u' AND (g_inbc_d[l_ac].inbc007 != g_inbc_d_t.inbc007 OR cl_null(g_inbc_d_t.inbc007)) THEN
#                  
#                     #在捡量减少   
#                     IF NOT s_inventory_ins_inap('-1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
#                                                 g_inbc_d_t.inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
#                                                 g_dept,'') THEN
#                        #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                        NEXT FIELD inbc007
#                     END IF 
#                     #在捡量增加
#                     IF NOT s_inventory_ins_inap('1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
#                                                 g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
#                                                 g_dept,'') THEN
#                        #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                        NEXT FIELD inbc007
#                     END IF  
#                  END IF                  
#               END IF
               #161006-00018#2-E              
            END IF
            LET g_inbc_d_t.inbc007 = g_inbc_d[l_ac].inbc007   #add by lixh 20151218
            #161006-00018#31-S            
            LET g_inbc_d_t.inbc006 = g_inbc_d[l_ac].inbc006
            LET g_inbc_d_t.inbc005 = g_inbc_d[l_ac].inbc005 
            #161006-00018#31-E             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc007
            #add-point:ON CHANGE inbc007 name="input.g.page1.inbc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc003
            #add-point:BEFORE FIELD inbc003 name="input.b.page1.inbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc003
            
            #add-point:AFTER FIELD inbc003 name="input.a.page1.inbc003"
            #161006-00018#2-S
            IF NOT cl_null(g_inbc_d[l_ac].inbc003) THEN      
               IF NOT aint302_01_check_inag() THEN 
                  NEXT FIELD CURRENT
               END IF
            END IF      
            #161006-00018#2-E
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc003
            #add-point:ON CHANGE inbc003 name="input.g.page1.inbc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc010
            #add-point:BEFORE FIELD inbc010 name="input.b.page1.inbc010"
            LET g_inbc_d_t.inbc010 = g_inbc_d[l_ac].inbc010
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc010
            
            #add-point:AFTER FIELD inbc010 name="input.a.page1.inbc010"
            IF NOT cl_null(g_inbc_d[l_ac].inbc010) THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbc_d[l_ac].inbc010 != g_inbc_d_t.inbc010)) THEN    #160824-00007#278 161229 by lori mark
               IF g_inbc_d[l_ac].inbc010 != g_inbc_d_o.inbc010 OR cl_null(g_inbc_d_o.inbc010) THEN         #160824-00007#278 161229 by lori mark
                  IF g_inbc_d[l_ac].inbc010 = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00019'
                     LET g_errparam.extend = g_inbc_d[l_ac].inbc010
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                    #LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010   #160824-00007#278 161229 by lori mark
                     LET g_inbc_d[l_ac].inbc010 = g_inbc_d_o.inbc010   #160824-00007#278 161229 by lori add
                     NEXT FIELD CURRENT
                  END IF
                 
                  #依據單據別參數控管判斷是否允許輸入小於0
                  CALL s_aooi200_get_slip(g_inbc_d[l_ac].inbcdocno) RETURNING l_flag1,l_ooac002
                  CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-BAS-0058') RETURNING l_ooac004
                  IF l_ooac004 = 'N' AND g_inbc_d[l_ac].inbc010 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00020'
                     LET g_errparam.extend = g_inbc_d[l_ac].inbc010
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                    #LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010   #160824-00007#278 161229 by lori mark
                     LET g_inbc_d[l_ac].inbc010 = g_inbc_d_o.inbc010   #160824-00007#278 161229 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  
                  #此項序輸入的數量加上其他項序已經登打的數量總和，不可已大於對應申請明細的申請數量
                  SELECT SUM(inbc010) INTO l_inbc010 FROM inbc_t 
                     WHERE inbcent = g_enterprise AND inbcsite = g_site
                       AND inbcdocno = g_inbc_d[l_ac].inbcdocno AND inbcseq = g_inbc_d[l_ac].inbcseq
                  IF l_cmd = 'a' THEN
                     LET l_inbc010 = l_inbc010 + g_inbc_d[l_ac].inbc010
                  ELSE
                     LET l_inbc010 = g_inbc_d[l_ac].inbc010
                  END IF
                  IF l_inbc010 > g_inbb_d[l_ac2].inbb011 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00022'
                     LET g_errparam.extend = g_inbc_d[l_ac].inbc010
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                    #LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010   #160824-00007#278 161229 by lori mark
                     LET g_inbc_d[l_ac].inbc010 = g_inbc_d_o.inbc010   #160824-00007#278 161229 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_inbb010 = ''
                  LET l_inbb013 = ''
                  SELECT inbb010,inbb013 INTO l_inbb010,l_inbb013 FROM inbb_t
                     WHERE inbbent = g_enterprise AND inbbsite = g_site 
                       AND inbbdocno = g_inbc_d[l_ac].inbcdocno
                       AND inbbseq = g_inbc_d[l_ac].inbcseq
                  
                  #IF g_argv[1] = '1' THEN
                  IF g_argv[1] = '1' OR g_argv[1] = '3' THEN  #161109-00032#1 
                     LET l_success = ''
                     LET l_flag = ''
                     CALL s_inventory_check_inan(g_site,g_inbc_d[l_ac].inbc001,g_inbb_d[l_ac2].inbb002,g_inbb_d[l_ac2].inbb003,
                                                 g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,
                                                 l_inbb010,g_inbc_d[l_ac].inbc010,g_inbc_d[l_ac].inbcdocno,
                                                 g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,'','') #160408-00035#9-add-'',''
                          RETURNING l_success,l_flag
                     IF NOT l_success THEN      #處理狀況
                        LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010
                        NEXT FIELD CURRENT
                     ELSE
                        IF l_flag = 0 THEN      #在揀量足夠否
                           LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  
                  #當申請數量是打負數時代表是出庫行為，檢核庫存量是否足夠
                  #IF g_argv[1] = '2' AND g_inbc_d[l_ac].inbc010 < 0 THEN   #161109-00032#1
                  IF (g_argv[1] = '2' OR g_argv[1] = '4') AND g_inbc_d[l_ac].inbc010 < 0 THEN  #161109-00032#1
                     #庫儲需存在與庫存明細檔中
                     IF NOT cl_null(g_inbc_d[l_ac].inbc005) THEN
                        IF NOT aint302_01_chk_inag004(g_inbc_d[l_ac].inbc005) THEN
                          #LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010   #160824-00007#278 161229 by lori mark
                           LET g_inbc_d[l_ac].inbc010 = g_inbc_d_o.inbc010   #160824-00007#278 161229 by lori add
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     
                     IF (NOT cl_null(g_inbc_d[l_ac].inbc005)) AND g_inbc_d[l_ac].inbc006 IS NOT NULL THEN
                        IF NOT aint302_01_chk_inag005(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) THEN
                          #LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010   #160824-00007#278 161229 by lori mark
                           LET g_inbc_d[l_ac].inbc010 = g_inbc_d_o.inbc010   #160824-00007#278 161229 by lori add
                           NEXT FIELD CURRENT
                        END IF
                     END IF 
                     
                     LET l_success = ''
                     LET l_flag1 = ''
                     SELECT inbb010 INTO l_inbb010 FROM inbb_t 
                       WHERE inbbent = g_enterprise AND inbbdocno = g_inbc_d[l_ac].inbcdocno AND inbbseq = g_inbc_d[l_ac].inbcseq
                     CALL s_inventory_check_inag008('-1',g_inbc_d[l_ac].inbc001,g_inbb_d[l_ac2].inbb002,g_inbb_d[l_ac2].inbb003,
                                                 g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,
                                                 g_inbc_d[l_ac].inbc010*(-1),g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,
                                                 '0',l_inbb010,'')
                          RETURNING l_success,l_flag1
                     IF NOT l_success THEN      #處理狀況
                        LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010
                        NEXT FIELD CURRENT
                     ELSE
                        IF l_flag1 = 0 THEN      #庫存量足夠否
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ain-00270'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                          #LET g_inbc_d[l_ac].inbc010 = g_inbc_d_t.inbc010   #160824-00007#278 161229 by lori mark
                           LET g_inbc_d[l_ac].inbc010 = g_inbc_d_o.inbc010   #160824-00007#278 161229 by lori add
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                                      
                  END IF
                  #add by lixh 20151218
                  #IF g_argv[1] = '2' THEN  #161109-00032#1
                  IF g_argv[1] = '2' OR g_argv[1] = '4' THEN  #161109-00032#1
                     IF s_aint302_copy_inao(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,'1',g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,'-1') THEN
                        IF g_inbc_d[g_detail_idx].inbcseq1 = '1' THEN
                           UPDATE inao_t SET inaoseq1 = '0' 
                            WHERE inaoent = g_enterprise
                              AND inaodocno = g_inbc_d[l_ac].inbcdocno
                              AND inaoseq = g_inbc_d[l_ac].inbcseq
                              AND inaoseq1 = 1
                              AND inao000 = '2'                              
                           CALL s_lot_sel('2','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,'0',g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'1','aint302','','','','','0')
                                RETURNING l_success                           
                        ELSE
                           CALL s_lot_sel('2','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'1','aint302','','','','','0')
                                RETURNING l_success
                        END IF                                
                     END IF    
                     IF g_inbc_d[g_detail_idx].inbcseq1 = '1' THEN 
                        IF NOT s_aint302_upd_inao(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,'0','1',g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,'1') THEN
                           NEXT FIELD CURRENT
                        END IF                     
                     ELSE                     
                        IF NOT s_aint302_upd_inao(g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,'1',g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,'1') THEN
                           NEXT FIELD CURRENT
                        END IF
                     END IF                        
                     IF g_inbc_d[g_detail_idx].inbcseq1 = '1' THEN
                        UPDATE inao_t SET inaoseq1 = '1' 
                         WHERE inaoent = g_enterprise
                           AND inaodocno = g_inbc_d[l_ac].inbcdocno
                           AND inaoseq = g_inbc_d[l_ac].inbcseq
                           AND inao000 = '2'
                           AND inaoseq1 = 0   
                        DELETE FROM inao_t 
                         WHERE inaoent = g_enterprise
                           AND inaodocno = g_inbc_d[l_ac].inbcdocno
                           AND inaoseq = g_inbc_d[l_ac].inbcseq
                           AND inao000 = '1'
                           AND inaoseq1 = 0
                     ELSE
                        #delete 其他項序的申請資料
                        DELETE FROM inao_t 
                         WHERE inaoent = g_enterprise
                           AND inaodocno = g_inbc_d[l_ac].inbcdocno
                           AND inaoseq = g_inbc_d[l_ac].inbcseq
                           AND inao000 = '1'
                           AND inaoseq1 = g_inbc_d[g_detail_idx].inbcseq1                    
                     END IF                     
                  END IF   
                  #IF g_argv[1] = '1' THEN                    #161109-00032#1
                  IF g_argv[1] = '1' OR g_argv[1] = '3' THEN  #161109-00032#1
                     #CALL s_lot_sel('2','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')
                     #     RETURNING l_success  
                     CALL s_lot_sel('1','2',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[g_detail_idx].inbcseq1,g_inbb_d[g_detail_idx2].inbb001,g_inbb_d[g_detail_idx2].inbb002,g_inbb_d[g_detail_idx2].inbb003,g_inbc_d[g_detail_idx].inbc005,g_inbc_d[g_detail_idx].inbc006,g_inbc_d[g_detail_idx].inbc007,l_inbb010,g_inbc_d[g_detail_idx].inbc010,'-1','aint301','','','','','0')
                          RETURNING l_success                      
                  END IF                    
                  #add by lixh 20151218                       
                  #單位自動換算
                  IF (NOT cl_null(l_inbb010)) AND (NOT cl_null(l_inbb013)) THEN
#                     CALL s_aimi190_get_convert(g_inbc_d[l_ac].inbc001,l_inbb010,l_inbb013) RETURNING l_success,l_rate #xj mod
                     CALL s_aooi250_convert_qty(g_inbc_d[l_ac].inbc001,l_inbb010,l_inbb013,g_inbc_d[l_ac].inbc010)
                        RETURNING l_success,g_inbc_d[l_ac].inbc015
                     IF l_success THEN
#                        LET g_inbc_d[l_ac].inbc015 = g_inbc_d[l_ac].inbc010 * l_rate  #xj mod
                     END IF
                  END IF                       
               END IF 

               #出庫單據在撿量異動
               #旧库存在捡量减少&新库位在捡量增加
               #161006-00018#2-S
#               IF g_type = '1' THEN
#                  IF l_cmd = 'u' AND (g_inbc_d[l_ac].inbc010 != g_inbc_d_t.inbc010) THEN
#                  
#                     #在捡量减少   
#                     IF NOT s_inventory_ins_inap('-1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
#                                                 g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d_t.inbc010,g_today,g_user,
#                                                 g_dept,'') THEN
#                        #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                        NEXT FIELD inbc010
#                     END IF 
#                     #在捡量增加
#                     IF NOT s_inventory_ins_inap('1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
#                                                 g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
#                                                 g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
#                                                 g_dept,'') THEN
#                        #LET g_inbc_d[l_ac].* = g_inbc_d_t.*
#                        NEXT FIELD inbc010
#                     END IF                        
#                  END IF                     
#               END IF
               #161006-00018#2-E  
            END IF
           #LET g_inbc_d_t.inbc010 = g_inbc_d[l_ac].inbc010   #add by lixh 20151218   #160824-00007#278 161229 by lori mark
            LET  g_inbc_d_o.inbc010 = g_inbc_d[l_ac].inbc010   #160824-00007#278 161229 by lori add
            LET  g_inbc_d_o.inbc015 = g_inbc_d[l_ac].inbc015   #160824-00007#278 161229 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc010
            #add-point:ON CHANGE inbc010 name="input.g.page1.inbc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc015
            #add-point:BEFORE FIELD inbc015 name="input.b.page1.inbc015"
            LET g_inbc_d_t.inbc015 = g_inbc_d[l_ac].inbc015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc015
            
            #add-point:AFTER FIELD inbc015 name="input.a.page1.inbc015"
            IF NOT cl_null(g_inbc_d[l_ac].inbc015) THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbc_d[l_ac].inbc015 != g_inbc_d_t.inbc015)) THEN    #160824-00007#278 161229 by lori mark
               IF g_inbc_d[l_ac].inbc015 != g_inbc_d_o.inbc015 OR cl_null(g_inbc_d_o.inbc015) THEN         #160824-00007#278 161229 by lori add
                #mark by lixh 20151222
#                  IF g_inbc_d[l_ac].inbc015 = 0 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'ain-00019'
#                     LET g_errparam.extend = g_inbc_d[l_ac].inbc015
#                     LET g_errparam.popup = FALSE
#                     CALL cl_err()
#
#                     LET g_inbc_d[l_ac].inbc015 = g_inbc_d_t.inbc015
#                     NEXT FIELD CURRENT
#                  END IF
                #mark by lixh 20151222
                 
                  #依據單據別參數控管判斷是否允許輸入小於0
                  CALL s_aooi200_get_slip(g_inbc_d[l_ac].inbcdocno) RETURNING l_flag1,l_ooac002
                  CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-BAS-0058') RETURNING l_ooac004
                  IF l_ooac004 = 'N' AND g_inbc_d[l_ac].inbc015 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00020'
                     LET g_errparam.extend = g_inbc_d[l_ac].inbc015
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                    #LET g_inbc_d[l_ac].inbc015 = g_inbc_d_t.inbc015   #160824-00007#278 161229 by lori mark
                     LET g_inbc_d[l_ac].inbc015 = g_inbc_d_o.inbc015   #160824-00007#278 161229 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  
                  #此項序輸入的參考數量加上其他項序已經登打的參考數量總和，不可已大於對應申請明細的參考數量
                  SELECT SUM(inbc015) INTO l_inbc015 FROM inbc_t 
                     WHERE inbcent = g_enterprise AND inbcsite = g_site
                       AND inbcdocno = g_inbc_d[l_ac].inbcdocno AND inbcseq = g_inbc_d[l_ac].inbcseq
                  IF l_cmd = 'a' THEN
                     LET l_inbc015 = l_inbc015 + g_inbc_d[l_ac].inbc015
                  ELSE
                     LET l_inbc015 = g_inbc_d[l_ac].inbc015
                  END IF
                  IF l_inbc015 > g_inbb_d[l_ac2].inbb014 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00023'
                     LET g_errparam.extend = g_inbc_d[l_ac].inbc015
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                    #LET g_inbc_d[l_ac].inbc015 = g_inbc_d_t.inbc015   #160824-00007#278 161229 by lori mark
                     LET g_inbc_d[l_ac].inbc015 = g_inbc_d_o.inbc015   #160824-00007#278 161229 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  #mark by lixh 20151222
                  #單位自動換算
#                  SELECT inbb010,inbb013 INTO l_inbb010,l_inbb013 FROM inbb_t
#                     WHERE inbbent = g_enterprise AND inbbsite = g_site 
#                       AND inbbdocno = g_inbc_d[l_ac].inbcdocno
#                       AND inbbseq = g_inbc_d[l_ac].inbcseq
#                  IF (NOT cl_null(l_inbb010)) AND (NOT cl_null(l_inbb013)) THEN
##                     CALL s_aimi190_get_convert(g_inbc_d[l_ac].inbc001,l_inbb013,l_inbb010) RETURNING l_success,l_rate #xj mod
#                     CALL s_aooi250_convert_qty(g_inbc_d[l_ac].inbc001,l_inbb013,l_inbb010,g_inbc_d[l_ac].inbc015) 
#                        RETURNING l_success,g_inbc_d[l_ac].inbc010
#                     IF l_success THEN
##                        LET g_inbc_d[l_ac].inbc010 = g_inbc_d[l_ac].inbc015 * l_rate  #xj mod
#                     END IF
#                  END IF
                  #mark by lixh 20151222
               END IF      
            END IF
            
            LET  g_inbc_d_o.inbc015 = g_inbc_d[l_ac].inbc015   #160824-00007#278 161229 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc015
            #add-point:ON CHANGE inbc015 name="input.g.page1.inbc015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc021
            
            #add-point:AFTER FIELD inbc021 name="input.a.page1.inbc021"
            CALL s_desc_get_project_desc(g_inbc_d[l_ac].inbc021) RETURNING g_inbc_d[l_ac].inbc021_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc021_desc
            
            IF NOT cl_null(g_inbc_d[l_ac].inbc021) THEN 
               IF g_inbc_d[l_ac].inbc021 != g_inbc_d_o.inbc021 OR cl_null(g_inbc_d_o.inbc021) THEN
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbc_d[l_ac].inbc021
                  #160318-00025#22  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
                  #160318-00025#22  by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pjba001") THEN
                     #檢查成功時後續處理
                     LET g_inbc_d[l_ac].inbc021 = g_inbc_d_o.inbc021
                     CALL s_desc_get_project_desc(g_inbc_d[l_ac].inbc021) RETURNING g_inbc_d[l_ac].inbc021_desc
                     DISPLAY BY NAME g_inbc_d[l_ac].inbc021_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_inbc_d[l_ac].inbc022 = ''
                  LET g_inbc_d[l_ac].inbc022_desc = ''
                  LET g_inbc_d[l_ac].inbc023 = ''
                  LET g_inbc_d[l_ac].inbc023_desc = ''
               END IF
            END IF 
            LET g_inbc_d_o.inbc021 = g_inbc_d[l_ac].inbc021

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc021
            #add-point:BEFORE FIELD inbc021 name="input.b.page1.inbc021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc021
            #add-point:ON CHANGE inbc021 name="input.g.page1.inbc021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc022
            
            #add-point:AFTER FIELD inbc022 name="input.a.page1.inbc022"
            CALL s_desc_get_wbs_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022) RETURNING g_inbc_d[l_ac].inbc022_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc022_desc
            
            IF NOT cl_null(g_inbc_d[l_ac].inbc022) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbc_d[l_ac].inbc021
               LET g_chkparam.arg2 = g_inbc_d[l_ac].inbc022
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbb002") THEN
                  #檢查失敗時後續處理
                  LET g_inbc_d[l_ac].inbc022 = g_inbc_d_t.inbc022
                  CALL s_desc_get_wbs_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022) RETURNING g_inbc_d[l_ac].inbc022_desc
                  DISPLAY BY NAME g_inbc_d[l_ac].inbc022_desc
                  NEXT FIELD CURRENT
               END IF

            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc022
            #add-point:BEFORE FIELD inbc022 name="input.b.page1.inbc022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc022
            #add-point:ON CHANGE inbc022 name="input.g.page1.inbc022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc023
            
            #add-point:AFTER FIELD inbc023 name="input.a.page1.inbc023"
            CALL s_desc_get_activity_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc023) RETURNING g_inbc_d[l_ac].inbc023_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc023_desc
            
            IF NOT cl_null(g_inbc_d[l_ac].inbc023) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_inbc_d[l_ac].inbc021
               LET g_chkparam.arg2 = g_inbc_d[l_ac].inbc023
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbm002") THEN
                  #檢查失敗時後續處理
                  LET g_inbc_d[l_ac].inbc023 = g_inbc_d_t.inbc023
                  CALL s_desc_get_activity_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc023) RETURNING g_inbc_d[l_ac].inbc023_desc
                  DISPLAY BY NAME g_inbc_d[l_ac].inbc023_desc
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc023
            #add-point:BEFORE FIELD inbc023 name="input.b.page1.inbc023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc023
            #add-point:ON CHANGE inbc023 name="input.g.page1.inbc023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc203
            #add-point:BEFORE FIELD inbc203 name="input.b.page1.inbc203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc203
            
            #add-point:AFTER FIELD inbc203 name="input.a.page1.inbc203"
            #160512-00004#2-add-(S)
            IF NOT aint302_01_inbc203_inbc016_chk(g_inbc_d[l_ac].inbc203,g_inbc_d[l_ac].inbc016) THEN
               LET g_inbc_d[l_ac].inbc203 = g_inbc_d_o.inbc203
               NEXT FIELD CURRENT
            END IF
            LET g_inbc_d_o.inbc203 = g_inbc_d[l_ac].inbc203
            #160512-00004#2-add-(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc203
            #add-point:ON CHANGE inbc203 name="input.g.page1.inbc203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc016
            #add-point:BEFORE FIELD inbc016 name="input.b.page1.inbc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc016
            
            #add-point:AFTER FIELD inbc016 name="input.a.page1.inbc016"
            #160512-00004#2-add-(S)
            IF NOT aint302_01_inbc203_inbc016_chk(g_inbc_d[l_ac].inbc203,g_inbc_d[l_ac].inbc016) THEN
               LET g_inbc_d[l_ac].inbc016 = g_inbc_d_o.inbc016
               NEXT FIELD CURRENT
            END IF
            LET g_inbc_d_o.inbc016 = g_inbc_d[l_ac].inbc016
            #160512-00004#2-add-(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc016
            #add-point:ON CHANGE inbc016 name="input.g.page1.inbc016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbc017
            #add-point:BEFORE FIELD inbc017 name="input.b.page1.inbc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbc017
            
            #add-point:AFTER FIELD inbc017 name="input.a.page1.inbc017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbc017
            #add-point:ON CHANGE inbc017 name="input.g.page1.inbc017"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcsite
            #add-point:ON ACTION controlp INFIELD inbcsite name="input.c.page1.inbcsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcdocno
            #add-point:ON ACTION controlp INFIELD inbcdocno name="input.c.page1.inbcdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcseq
            #add-point:ON ACTION controlp INFIELD inbcseq name="input.c.page1.inbcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbcseq1
            #add-point:ON ACTION controlp INFIELD inbcseq1 name="input.c.page1.inbcseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc001
            #add-point:ON ACTION controlp INFIELD inbc001 name="input.c.page1.inbc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc005
            #add-point:ON ACTION controlp INFIELD inbc005 name="input.c.page1.inbc005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "1=1 "
            LET l_sql1 = ''
            CALL s_control_get_doc_sql("inaa001",g_inbadocno,'6') RETURNING l_success,l_sql1
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql1
            END IF 
            #雜收時，庫位開窗與檢核需排除待報廢庫位
            #IF g_type = '2' THEN                  #161109-00032#1
            IF g_type = '2' OR g_type = '4' THEN   #161109-00032#1
               LET g_qryparam.where = g_qryparam.where ," AND inaa016 = 'N' "
            END IF       
            
            LET g_qryparam.default1 = g_inbc_d[l_ac].inbc005             #給予default值
            #若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
            #IF g_type = '1' THEN  #161109-00032#1
            IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
               #給予arg
               LET g_qryparam.arg1 = g_inbc_d[l_ac].inbc001
               LET g_qryparam.arg2 = g_inbc_d[l_ac].inbc002
               #呼叫開窗
               CALL q_inag004_13()
               #將開窗取得的值回傳到變數
               LET g_inbc_d[l_ac].inbc005 = g_qryparam.return1
               LET g_inbc_d[l_ac].inbc006 = g_qryparam.return2
               LET g_inbc_d[l_ac].inbc007 = g_qryparam.return3
               LET g_inbc_d[l_ac].inbc003 = g_qryparam.return4
            #若是雜項庫存收料作業時
            ELSE
               CALL q_inaa001_2()
               LET g_inbc_d[l_ac].inbc005 = g_qryparam.return1
            END IF            
            DISPLAY g_inbc_d[l_ac].inbc005 TO inbc005              
            DISPLAY g_inbc_d[l_ac].inbc006 TO inbc006
            DISPLAY g_inbc_d[l_ac].inbc007 TO inbc007
            DISPLAY g_inbc_d[l_ac].inbc003 TO inbc003            
            NEXT FIELD inbc005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc006
            #add-point:ON ACTION controlp INFIELD inbc006 name="input.c.page1.inbc006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbc_d[l_ac].inbc006             #給予default值

            #若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
            #IF g_type = '1' THEN                 #161109-00032#1
            IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
               #LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag001 = '",g_inbb_d[l_ac2].inbb002,"' AND inab003 = '",g_inbb_d[l_ac2].inbb003,"' AND inag004 = '",g_inbc_d[l_ac].inbc005,"' "
               #LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag002 = '",g_inbb_d[l_ac2].inbb002,"' AND inab003 = '",g_inbb_d[l_ac2].inbb003,"' AND inag004 = '",g_inbc_d[l_ac].inbc005,"' "   #160226-00006#1 add by lixh 20160310  #160913-00053#1 mark
               LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag002 = '",g_inbb_d[l_ac2].inbb002,"' AND inag003 = '",g_inbb_d[l_ac2].inbb003,"' AND inag004 = '",g_inbc_d[l_ac].inbc005,"' "    #160913-00053#1 add
               CALL q_inag004_15()
               LET g_inbc_d[l_ac].inbc006 = g_qryparam.return2              #將開窗取得的值回傳到變數
               LET g_inbc_d[l_ac].inbc007 = g_qryparam.return3
               DISPLAY g_inbc_d[l_ac].inbc006 TO inbc006
               DISPLAY g_inbc_d[l_ac].inbc007 TO inbc007
               
            END IF
            
            
            #若是雜項庫存收料作業時
            #IF g_type = '2' THEN  #161109-00032#1
            IF g_type = '2' OR g_type = '4' THEN  #161109-00032#1
               LET g_qryparam.where = " inab001 = '",g_inbc_d[l_ac].inbc005,"' "
               CALL q_inab002()
               LET g_inbc_d[l_ac].inbc006 = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_inbc_d[l_ac].inbc006 TO inbc006
              
            END IF       

            CALL aint302_01_inbc006_ref(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) RETURNING g_inbc_d[l_ac].inbc006_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc006_desc
            NEXT FIELD inbc006
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc007
            #add-point:ON ACTION controlp INFIELD inbc007 name="input.c.page1.inbc007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbc_d[l_ac].inbc007             #給予default值

            #若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
            #IF g_type = '1' THEN                 #161109-00032#1
            IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
               #LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag001 = '",g_inbb_d[l_ac2].inbb002,"' AND inab003 = '",g_inbb_d[l_ac2].inbb003,"' AND inag004 = '",g_inbc_d[l_ac].inbc005,"' "
               #LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag002 = '",g_inbb_d[l_ac2].inbb002,"' AND inab003 = '",g_inbb_d[l_ac2].inbb003,"' AND inag004 = '",g_inbc_d[l_ac].inbc005,"' "  #160226-00006#1 add by lixh 20160310  #160913-00053#1 mark
               LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag002 = '",g_inbb_d[l_ac2].inbb002,"' AND inag003 = '",g_inbb_d[l_ac2].inbb003,"' AND inag004 = '",g_inbc_d[l_ac].inbc005,"' "   #160913-00053#1 add
               CALL q_inag004_15()
               LET g_inbc_d[l_ac].inbc006 = g_qryparam.return2              #將開窗取得的值回傳到變數
               LET g_inbc_d[l_ac].inbc007 = g_qryparam.return3
               DISPLAY g_inbc_d[l_ac].inbc006 TO inbc006
               DISPLAY g_inbc_d[l_ac].inbc007 TO inbc007
               
            END IF
           
            NEXT FIELD inbc007
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc003
            #add-point:ON ACTION controlp INFIELD inbc003 name="input.c.page1.inbc003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbc_d[l_ac].inbc003             #給予default值

            #若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
            #IF g_type = '1' THEN   #161109-00032#1
            IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
               #LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag001 = '",g_inbb_d[l_ac2].inbb002,"' AND inab003 = '",g_inbb_d[l_ac2].inbb003,"' "
               #LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag002 = '",g_inbb_d[l_ac2].inbb002,"' AND inab003 = '",g_inbb_d[l_ac2].inbb003,"' "   #160226-00006#1 add by lixh 20160310  #160913-00053#1 mark
               LET g_qryparam.where = " inag001 = '",g_inbc_d[l_ac].inbc001,"' AND inag002 = '",g_inbb_d[l_ac2].inbb002,"' AND inag003 = '",g_inbb_d[l_ac2].inbb003,"' "    #160913-00053#1 add
               CALL q_inag004_15()
               LET g_inbc_d[l_ac].inbc006 = g_qryparam.return2              #將開窗取得的值回傳到變數
               LET g_inbc_d[l_ac].inbc007 = g_qryparam.return3
               LET g_inbc_d[l_ac].inbc003 = g_qryparam.return4
               DISPLAY g_inbc_d[l_ac].inbc006 TO inbc006
               DISPLAY g_inbc_d[l_ac].inbc007 TO inbc007
               DISPLAY g_inbc_d[l_ac].inbc003 TO inbc003
            END IF
           
            NEXT FIELD inbc007
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc010
            #add-point:ON ACTION controlp INFIELD inbc010 name="input.c.page1.inbc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc015
            #add-point:ON ACTION controlp INFIELD inbc015 name="input.c.page1.inbc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc021
            #add-point:ON ACTION controlp INFIELD inbc021 name="input.c.page1.inbc021"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbc_d[l_ac].inbc021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_pjba001()                                #呼叫開窗

            LET g_inbc_d[l_ac].inbc021 = g_qryparam.return1              

            DISPLAY g_inbc_d[l_ac].inbc021 TO inbc021              #
            CALL s_desc_get_project_desc(g_inbc_d[l_ac].inbc021) RETURNING g_inbc_d[l_ac].inbc021_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc021_desc

            NEXT FIELD inbc021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc022
            #add-point:ON ACTION controlp INFIELD inbc022 name="input.c.page1.inbc022"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbc_d[l_ac].inbc022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_inbc_d[l_ac].inbc021  #s


            CALL q_pjbb002_1()                                #呼叫開窗

            LET g_inbc_d[l_ac].inbc022 = g_qryparam.return1              

            DISPLAY g_inbc_d[l_ac].inbc022 TO inbc022              #
            CALL s_desc_get_wbs_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022) RETURNING g_inbc_d[l_ac].inbc022_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc022_desc

            NEXT FIELD inbc022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc023
            #add-point:ON ACTION controlp INFIELD inbc023 name="input.c.page1.inbc023"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbc_d[l_ac].inbc023             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_inbc_d[l_ac].inbc021  #s


            CALL q_pjbm002()                                #呼叫開窗

            LET g_inbc_d[l_ac].inbc023 = g_qryparam.return1              

            DISPLAY g_inbc_d[l_ac].inbc023 TO inbc023              #
            CALL s_desc_get_activity_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc023) RETURNING g_inbc_d[l_ac].inbc023_desc
            DISPLAY BY NAME g_inbc_d[l_ac].inbc023_desc

            NEXT FIELD inbc023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc203
            #add-point:ON ACTION controlp INFIELD inbc203 name="input.c.page1.inbc203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc016
            #add-point:ON ACTION controlp INFIELD inbc016 name="input.c.page1.inbc016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbc017
            #add-point:ON ACTION controlp INFIELD inbc017 name="input.c.page1.inbc017"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aint302_01_bcl
               LET INT_FLAG = 0
               LET g_inbc_d[l_ac].* = g_inbc_d_t.*
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
               LET g_errparam.extend = g_inbc_d[l_ac].inbcdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_inbc_d[l_ac].* = g_inbc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               #160617-00005#1---s--
               #若是雜項庫存收料作業時
               #IF g_argv[1] = '2' THEN  #161109-00032#1
               IF g_argv[1] = '2' OR g_argv[1] = '4' THEN #161109-00032#1
                  LET l_imaf061 = ''
                  LET l_imaf062 = ''
                  LET l_imaf063 = ''
                  SELECT imaf061,imaf062,imaf063 INTO l_imaf061,l_imaf062,l_imaf063  
                    FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_inbc_d[l_ac].inbc001
               
                  IF cl_null(g_inbc_d[l_ac].inbc007) AND l_imaf061 = '1' AND l_imaf062 = 'Y' AND (NOT cl_null(l_imaf063)) THEN
                     CALL s_aooi390_gen_1('6',l_imaf063) RETURNING l_success,g_inbc_d[l_ac].inbc007,l_oofg_return
                     IF NOT l_success THEN
                        LET g_inbc_d[l_ac].inbc007 = ''
                     ELSE
                        CALL s_aooi390_get_auto_no('6',g_inbc_d[l_ac].inbc007) RETURNING l_success,g_inbc_d[l_ac].inbc007
                        CALL s_aooi390_oofi_upd('6',g_inbc_d[l_ac].inbc007) RETURNING l_success
                     END IF
                  END IF
                  DISPLAY BY NAME g_inbc_d[l_ac].inbc007
               END IF
               #160617-00005#1---e--
               #161006-00018#2-S
               #IF g_argv[1] = '1' THEN  #161109-00032#1
               IF g_argv[1] = '1' OR g_argv[1] = '3' THEN  #161109-00032#1
                  #161006-00018#31-S
                  LET l_inaa007 = ''
                  SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inbc_d[l_ac].inbc005
                  IF l_inaa007 = '5' THEN
                  #161006-00018#31-E
                     IF g_inbc_d[l_ac].inbc006 IS NULL THEN
                        LET g_inbc_d[l_ac].inbc006 = ' '
                     END IF
                  END IF  #161006-00018#31  
                  IF g_inbc_d[l_ac].inbc005 <> g_inbc005_t OR g_inbc_d[l_ac].inbc006 <> g_inbc006_t OR 
                     g_inbc_d[l_ac].inbc007 <> g_inbc007_t OR g_inbc_d[l_ac].inbc010 <> g_inbc010_t THEN
                     LET l_inbb010 = ''
                     SELECT inbb010 INTO l_inbb010 FROM inbb_t
                      WHERE inbbent = g_enterprise
                        AND inbbdocno = g_inbc_d[l_ac].inbcdocno
                        AND inbbseq = g_inbc_d[l_ac].inbcseq
                     IF NOT cl_null(g_inbc_d[l_ac].inbc005) THEN   
                        IF NOT s_inventory_ins_inap('-1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
                                                    g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc005_t,g_inbc006_t,
                                                    g_inbc007_t,l_inbb010,g_inbc010_t,g_today,g_user,
                                                    g_dept,'') THEN
                           LET g_inbc_d[l_ac].* = g_inbc_d_t.*
                        END IF
                     END IF   
                     IF NOT cl_null(g_inbc_d[l_ac].inbc005) THEN                       
                        IF NOT s_inventory_ins_inap('1',g_site,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,
                                                    g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,
                                                    g_inbc_d[l_ac].inbc007,l_inbb010,g_inbc_d[l_ac].inbc010,g_today,g_user,
                                                    g_dept,'') THEN
                           LET g_inbc_d[l_ac].* = g_inbc_d_t.*
                        END IF 
                     END IF                     
                  END IF 
               END IF 
               #161006-00018#2-E                
               #end add-point
               
               #將遮罩欄位還原
               CALL aint302_01_inbc_t_mask_restore('restore_mask_o')
 
               UPDATE inbc_t SET (inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc002,inbc005,inbc006, 
                   inbc007,inbc003,inbc010,inbc015,inbc021,inbc022,inbc023,inbc203,inbc016,inbc017) = (g_inbc_d[l_ac].inbcsite, 
                   g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq,g_inbc_d[l_ac].inbcseq1,g_inbc_d[l_ac].inbc001, 
                   g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007, 
                   g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc010,g_inbc_d[l_ac].inbc015,g_inbc_d[l_ac].inbc021, 
                   g_inbc_d[l_ac].inbc022,g_inbc_d[l_ac].inbc023,g_inbc_d[l_ac].inbc203,g_inbc_d[l_ac].inbc016, 
                   g_inbc_d[l_ac].inbc017)
                WHERE inbcent = g_enterprise AND
                  inbcdocno = g_inbc_d_t.inbcdocno #項次   
                  AND inbcseq = g_inbc_d_t.inbcseq  
                  AND inbcseq1 = g_inbc_d_t.inbcseq1  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
 
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbc_d[g_detail_idx].inbcdocno
               LET gs_keys_bak[1] = g_inbc_d_t.inbcdocno
               LET gs_keys[2] = g_inbc_d[g_detail_idx].inbcseq
               LET gs_keys_bak[2] = g_inbc_d_t.inbcseq
               LET gs_keys[3] = g_inbc_d[g_detail_idx].inbcseq1
               LET gs_keys_bak[3] = g_inbc_d_t.inbcseq1
               CALL aint302_01_update_b('inbc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_inbc_d_t)
                     LET g_log2 = util.JSON.stringify(g_inbc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aint302_01_inbc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               SELECT SUM(inbc010),SUM(inbc015) INTO l_inbc010,l_inbc015 FROM inbc_t
                 WHERE inbcent = g_enterprise AND inbcsite = g_site 
                   AND inbcdocno = g_inbc_d[l_ac].inbcdocno #項次   
                   AND inbcseq = g_inbc_d[l_ac].inbcseq                  
               UPDATE inbb_t SET inbb012 = l_inbc010,inbb015 = l_inbc015
                    WHERE inbbent = g_enterprise AND inbbsite = g_site 
                      AND inbbdocno = g_inbc_d[l_ac].inbcdocno
                      AND inbbseq = g_inbc_d[l_ac].inbcseq   
               IF SQLCA.SQLcode  THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "inbb_t"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
   
                  LET g_inbc_d[l_ac].* = g_inbc_d_t.*
               END IF
               #add by lixh 20151225
               UPDATE inbc_t SET inbc010 = g_inbc_d[l_ac].inbc010
                WHERE inbcent = g_enterprise
                  AND inbcdocno = g_inbc_d_t.inbcdocno #項次   
                  AND inbcseq = g_inbc_d_t.inbcseq  
                  AND inbcseq1 = g_inbc_d_t.inbcseq1 
               #add by lixh 20151225   

               CALL s_transaction_end('Y','0')  
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aint302_01_unlock_b("inbc_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inbc_d[l_ac].* = g_inbc_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               LET l_flag2 = 'Y'   #161006-00018#31
               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            #161006-00018#31-S
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN #不使用参考单位
               IF g_inbc_d[l_ac].inbc010 = 0 AND l_flag2 = 'N' THEN                   
                  NEXT FIELD inbc010
               END IF
            END IF
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN              
               IF g_inbc_d[l_ac].inbc010 = 0 AND g_inbc_d[l_ac].inbc015 = 0 AND l_flag2 = 'N' THEN
                  NEXT FIELD inbc010
               END IF  
            END IF                
            #161006-00018#31-E  
            CALL s_transaction_end('Y','0')  
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
               LET g_inbc_d[li_reproduce_target].* = g_inbc_d[li_reproduce].*
 
               LET g_inbc_d[li_reproduce_target].inbcdocno = NULL
               LET g_inbc_d[li_reproduce_target].inbcseq = NULL
               LET g_inbc_d[li_reproduce_target].inbcseq1 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inbc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inbc_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input name="input.more_input"
      DISPLAY ARRAY g_inbb_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)   
    
         BEFORE ROW  
            LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx2 = l_ac2
            CALL aint302_01_inbc_fill(g_inbadocno)
             
         BEFORE DISPLAY
            IF g_aw ='1' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET g_aw = ''
            END IF
            #LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
            #CALL aint302_01_inbc_fill(g_inbadocno)
            
      END DISPLAY          
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
            LET l_inbastus = ''
            SELECT inbastus INTO l_inbastus FROM inba_t WHERE inbaent = g_enterprise AND inbasite = g_site AND inbadocno = g_inbadocno
            IF l_inbastus != 'Y' THEN
               CALL cl_set_act_visible("modify",FALSE)
            END IF
         LET g_aw ='1'      
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD inbcsite
 
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
      IF INT_FLAG OR cl_null(g_inbc_d[g_detail_idx].inbcdocno) THEN
         CALL g_inbc_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_inbc_d[g_detail_idx].* = g_inbc_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   #add by lixh 20151222   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL aint302_01_detail_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
   END IF 
   CALL s_transaction_end('Y','0')
   #add by lixh 20151222    
   #end add-point
 
   CLOSE aint302_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint302_01_delete()
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
   FOR li_idx = 1 TO g_inbc_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aint302_01_lock_b("inbc_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("inbc_t","") THEN
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
   
   FOR li_idx = 1 TO g_inbc_d.getLength()
      IF g_inbc_d[li_idx].inbcdocno IS NOT NULL
         AND g_inbc_d[li_idx].inbcseq IS NOT NULL
         AND g_inbc_d[li_idx].inbcseq1 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM inbc_t
          WHERE inbcent = g_enterprise AND 
                inbcdocno = g_inbc_d[li_idx].inbcdocno
                AND inbcseq = g_inbc_d[li_idx].inbcseq
                AND inbcseq1 = g_inbc_d[li_idx].inbcseq1
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_inbc_d_t.inbcdocno
               LET gs_keys[2] = g_inbc_d_t.inbcseq
               LET gs_keys[3] = g_inbc_d_t.inbcseq1
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aint302_01_delete_b('inbc_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint302_01_set_pk_array()
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
   CALL aint302_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint302_01_b_fill(p_wc2)              #BODY FILL UP
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
   IF g_inbb_d.getLength() = 0 THEN
      RETURN
   END IF

   LET p_wc2 = p_wc2, " AND inbcdocno = '",g_inbadocno,"' AND inbcseq = '",g_inbb_d[l_ac2].inbbseq,"' "
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.inbcsite,t0.inbcdocno,t0.inbcseq,t0.inbcseq1,t0.inbc001,t0.inbc002, 
       t0.inbc005,t0.inbc006,t0.inbc007,t0.inbc003,t0.inbc010,t0.inbc015,t0.inbc021,t0.inbc022,t0.inbc023, 
       t0.inbc203,t0.inbc016,t0.inbc017 ,t1.pjbal003 ,t2.pjbbl004 ,t3.pjbml004 FROM inbc_t t0",
               "",
                              " LEFT JOIN pjbal_t t1 ON t1.pjbalent="||g_enterprise||" AND t1.pjbal001=t0.inbc021 AND t1.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t2 ON t2.pjbblent="||g_enterprise||" AND t2.pjbbl001=t0.inbc021 AND t2.pjbbl002=t0.inbc022 AND t2.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t3 ON t3.pjbmlent="||g_enterprise||" AND t3.pjbml001=t0.inbc021 AND t3.pjbml002=t0.inbc023 AND t3.pjbml003='"||g_dlang||"' ",
 
               " WHERE t0.inbcent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("inbc_t"),
                      " ORDER BY t0.inbcdocno,t0.inbcseq,t0.inbcseq1"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   #160512-00004#2-mod-(S)
#   LET g_sql = "SELECT  UNIQUE inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc002, 
#       inbc005,inbc006,inbc007,inbc003,inbc010,inbc015,inbc021,inbc022,inbc023,inbc016,inbc017  FROM inbc_t", 
#
#               " WHERE inbcent= ? AND ", p_wc2 
   LET g_sql = "SELECT  UNIQUE inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc002,inbc005,inbc006, ",
               "               inbc007,inbc003,inbc010,inbc015,inbc021,inbc022,inbc023,inbc203,inbc016,inbc017 ",
               "  FROM inbc_t", 
               " WHERE inbcent= ? AND ", p_wc2 
   #160512-00004#2-mod-(E) 
   LET g_sql = g_sql, cl_sql_add_filter("inbc_t"),
                      " ORDER BY inbcdocno,inbcseq,inbcseq1"
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"inbc_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aint302_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aint302_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_inbc_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_inbc_d[l_ac].inbcsite,g_inbc_d[l_ac].inbcdocno,g_inbc_d[l_ac].inbcseq, 
       g_inbc_d[l_ac].inbcseq1,g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc005, 
       g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc010,g_inbc_d[l_ac].inbc015, 
       g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022,g_inbc_d[l_ac].inbc023,g_inbc_d[l_ac].inbc203,g_inbc_d[l_ac].inbc016, 
       g_inbc_d[l_ac].inbc017,g_inbc_d[l_ac].inbc021_desc,g_inbc_d[l_ac].inbc022_desc,g_inbc_d[l_ac].inbc023_desc 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL aint302_01_inbc005_ref(g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc
      DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc
      
      CALL aint302_01_inbc006_ref(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) RETURNING g_inbc_d[l_ac].inbc006_desc
      DISPLAY BY NAME g_inbc_d[l_ac].inbc006_desc
      
      CALL s_desc_get_project_desc(g_inbc_d[l_ac].inbc021) RETURNING g_inbc_d[l_ac].inbc021_desc
      DISPLAY BY NAME g_inbc_d[l_ac].inbc021_desc
       
      CALL s_desc_get_wbs_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022) RETURNING g_inbc_d[l_ac].inbc022_desc
      DISPLAY BY NAME g_inbc_d[l_ac].inbc022_desc
         
      CALL s_desc_get_activity_desc(g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc023) RETURNING g_inbc_d[l_ac].inbc023_desc
      DISPLAY BY NAME g_inbc_d[l_ac].inbc023_desc
      #end add-point
      
      CALL aint302_01_detail_show()      
 
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
   
 
   
   CALL g_inbc_d.deleteElement(g_inbc_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_inbc_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_inbc_d.getLength() THEN
      LET l_ac = g_inbc_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_inbc_d.getLength()
      LET g_inbc_d_mask_o[l_ac].* =  g_inbc_d[l_ac].*
      CALL aint302_01_inbc_t_mask()
      LET g_inbc_d_mask_n[l_ac].* =  g_inbc_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
    #抓取料件據點相關資訊
     SELECT imaf061,imaf031,imaf032 INTO g_imaf061,g_imaf031,g_imaf032 FROM imaf_t WHERE
       imafent = g_enterprise AND imafsite = g_inbb_d[l_ac2].inbbsite AND imaf001 = g_inbb_d[l_ac2].inbb001
     IF cl_null(g_imaf031) THEN LET g_imaf031 = 0 END IF 
     IF cl_null(g_imaf032) THEN LET g_imaf032 = 0 END IF 
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_inbc_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aint302_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aint302_01_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbc_d[l_ac].inbc005
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite='"||g_site||"' AND inaa001 = ? ","") RETURNING g_rtn_fields
#            LET g_inbc_d[l_ac].inbc005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inbc_d[l_ac].inbc005
#            LET g_ref_fields[2] = g_inbc_d[l_ac].inbc006
#            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
#            LET g_inbc_d[l_ac].inbc006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inbc_d[l_ac].inbc006_desc
            
      CALL aint302_01_inbc005_ref(g_inbc_d[l_ac].inbc005) RETURNING g_inbc_d[l_ac].inbc005_desc
      DISPLAY BY NAME g_inbc_d[l_ac].inbc005_desc
            
      CALL aint302_01_inbc006_ref(g_inbc_d[l_ac].inbc005,g_inbc_d[l_ac].inbc006) RETURNING g_inbc_d[l_ac].inbc006_desc
      DISPLAY BY NAME g_inbc_d[l_ac].inbc006_desc
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint302_01_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("inbc006,inbc003",TRUE)

   CALL cl_set_comp_entry("inbc007,inbc015",TRUE)
   CALL cl_set_comp_entry("inbc005,inbc006,inbc007",TRUE)   #161006-00018#2
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aint302_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint302_01_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaf015  LIKE imaf_t.imaf015
   DEFINE l_inaa007  LIKE inaa_t.inaa007
   DEFINE l_imaf055  LIKE imaf_t.imaf055 
#161006-00018#2-S   
   DEFINE l_ooac002  LIKE ooac_t.ooac002   
   DEFINE l_ooac004  LIKE ooac_t.ooac004 
   DEFINE l_inbb007  LIKE inbb_t.inbb007   
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_inbb008  LIKE inbb_t.inbb008
   DEFINE l_inbb009  LIKE inbb_t.inbb009
#161006-00018#2-E   
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
   CALL cl_set_comp_entry("inbcseq1",FALSE)
   #161006-00018#2-S
   CALL s_aooi200_get_slip(g_inbadocno) RETURNING l_flag,l_ooac002
   CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0085') RETURNING l_ooac004 
   IF cl_null(g_inbc_d[l_ac].inbcseq) THEN  LET g_inbc_d[l_ac].inbcseq = g_inbb_d[l_ac2].inbbseq END IF
   LET l_inbb007 = ''
   LET l_inbb008 = ''
   LET l_inbb009 = ''
   SELECT inbb007,inbb008,inbb009 INTO l_inbb007,l_inbb008,l_inbb009 FROM inbb_t 
    WHERE inbbent = g_enterprise
      AND inbbdocno = g_inbadocno
      AND inbbseq = g_inbc_d[l_ac].inbcseq
   IF l_ooac004 = 'N' AND NOT cl_null(l_inbb007) THEN
      CALL cl_set_comp_entry("inbc005",FALSE) 
   END IF 
   IF l_ooac004 = 'N' AND NOT cl_null(l_inbb008) THEN
      CALL cl_set_comp_entry("inbc006",FALSE) 
   END IF    
   IF l_ooac004 = 'N' AND NOT cl_null(l_inbb009) THEN
      CALL cl_set_comp_entry("inbc007",FALSE) 
   END IF    
   #161006-00018#2-E 
   #161006-00018#2-S mark   
#   IF NOT cl_null(g_inbb_d[l_ac2].inbb008) THEN
#      CALL cl_set_comp_entry("inbc006",FALSE)
#   END IF
#   IF NOT cl_null(g_inbb_d[l_ac2].inbb009) THEN
#      CALL cl_set_comp_entry("inbc007",FALSE)
#   END IF
   #161006-00018#2-E mark
   IF NOT cl_null(g_inbb_d[l_ac2].inbb003) THEN
      CALL cl_set_comp_entry("inbc003",FALSE)
   END IF
   
   IF NOT cl_null(g_inbb_d[l_ac2].inbb023) THEN
      CALL cl_set_comp_entry("inbc021",FALSE)
   END IF
   
   IF NOT cl_null(g_inbb_d[l_ac2].inbb024) THEN
      CALL cl_set_comp_entry("inbc022",FALSE)
   END IF
   
   IF NOT cl_null(g_inbb_d[l_ac2].inbb025) THEN
      CALL cl_set_comp_entry("inbc023",FALSE)
   END IF
   
   
   #若[T:庫位資料檔].[C:儲位管理]='5'(不使用儲位管理)時，則[C:限定儲位]不可以維護
   SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inbc_d[l_ac].inbc005
   IF l_inaa007 = '5' THEN
      CALL cl_set_comp_entry("inbc006",FALSE)
      LET g_inbc_d[l_ac].inbc006 = ' '
      LET g_inbc_d[l_ac].inbc006_desc = ' '
   END IF
   
   LET l_imaf015 = ''
   LET l_imaf055 = ''
   SELECT imaf015,imaf055 INTO l_imaf015,l_imaf055 FROM imaf_t WHERE imafent = g_enterprise AND imaf001 = g_inbc_d[l_ac].inbc001 AND imafsite = g_site
   
   #若設定imaf055(庫存管理特徵)等於'2.不可有庫存管理特徵'時，則[C:庫存管理特徵]欄位不可輸入
   IF l_imaf055 = '2' THEN
      CALL cl_set_comp_entry("inbc003",FALSE)
      LET g_inbc_d[l_ac].inbc003 = ' '
   END IF
   
   #當料件不使用參考單位管理時，則參考數量不允許輸入
   IF cl_null(l_imaf015) THEN
      CALL cl_set_comp_entry("inbc015",FALSE)
      LET g_inbc_d[l_ac].inbc015 = ''
   END IF
 
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint302_01_default_search()
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
      LET ls_wc = ls_wc, " inbcdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " inbcseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " inbcseq1 = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = " 1=1"
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
 
{<section id="aint302_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint302_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "inbc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'inbc_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM inbc_t
          WHERE inbcent = g_enterprise AND
            inbcdocno = ps_keys_bak[1] AND inbcseq = ps_keys_bak[2] AND inbcseq1 = ps_keys_bak[3]
         
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
         CALL g_inbc_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint302_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "inbc_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO inbc_t
                  (inbcent,
                   inbcdocno,inbcseq,inbcseq1
                   ,inbcsite,inbc001,inbc002,inbc005,inbc006,inbc007,inbc003,inbc010,inbc015,inbc021,inbc022,inbc023,inbc203,inbc016,inbc017) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_inbc_d[l_ac].inbcsite,g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc005, 
                       g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc010, 
                       g_inbc_d[l_ac].inbc015,g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022,g_inbc_d[l_ac].inbc023, 
                       g_inbc_d[l_ac].inbc203,g_inbc_d[l_ac].inbc016,g_inbc_d[l_ac].inbc017)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint302_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "inbc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "inbc_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE inbc_t 
         SET (inbcdocno,inbcseq,inbcseq1
              ,inbcsite,inbc001,inbc002,inbc005,inbc006,inbc007,inbc003,inbc010,inbc015,inbc021,inbc022,inbc023,inbc203,inbc016,inbc017) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_inbc_d[l_ac].inbcsite,g_inbc_d[l_ac].inbc001,g_inbc_d[l_ac].inbc002,g_inbc_d[l_ac].inbc005, 
                  g_inbc_d[l_ac].inbc006,g_inbc_d[l_ac].inbc007,g_inbc_d[l_ac].inbc003,g_inbc_d[l_ac].inbc010, 
                  g_inbc_d[l_ac].inbc015,g_inbc_d[l_ac].inbc021,g_inbc_d[l_ac].inbc022,g_inbc_d[l_ac].inbc023, 
                  g_inbc_d[l_ac].inbc203,g_inbc_d[l_ac].inbc016,g_inbc_d[l_ac].inbc017) 
         WHERE inbcent = g_enterprise AND inbcdocno = ps_keys_bak[1] AND inbcseq = ps_keys_bak[2] AND inbcseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbc_t:",SQLERRMESSAGE 
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
 
{<section id="aint302_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint302_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aint302_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "inbc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint302_01_bcl USING g_enterprise,
                                       g_inbc_d[g_detail_idx].inbcdocno,g_inbc_d[g_detail_idx].inbcseq, 
                                           g_inbc_d[g_detail_idx].inbcseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint302_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint302_01_unlock_b(ps_table)
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
      CLOSE aint302_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aint302_01_modify_detail_chk(ps_record)
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
         LET ls_return = "inbcsite"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aint302_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aint302_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aint302_01.mask_functions" >}
&include "erp/ain/aint302_01_mask.4gl"
 
{</section>}
 
{<section id="aint302_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint302_01_set_pk_array()
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
   LET g_pk_array[1].values = g_inbc_d[l_ac].inbcdocno
   LET g_pk_array[1].column = 'inbcdocno'
   LET g_pk_array[2].values = g_inbc_d[l_ac].inbcseq
   LET g_pk_array[2].column = 'inbcseq'
   LET g_pk_array[3].values = g_inbc_d[l_ac].inbcseq1
   LET g_pk_array[3].column = 'inbcseq1'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint302_01.state_change" >}
   
 
{</section>}
 
{<section id="aint302_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aint302_01.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aint302_01_inbb_fill(p_inbadocno)
DEFINE p_inbadocno   LIKE inba_t.inbadocno
DEFINE l_sql         STRING
DEFINE l_ac1         LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
   #160512-00004#2-mod-(S) 多加inbb204
#   LET l_sql ="SELECT inbbsite,inbbdocno,inbbseq,inbb001,'','',inbb002,'',inbb004,inbb003,inbb007,inbb008,inbb009,inbb011,inbb014,inbb023,'',inbb024,'',inbb025,'',inbb022,inbb021 FROM inbb_t WHERE inbbent = '",g_enterprise,"' AND inbbsite = '",g_site,"' AND inbbdocno ='",p_inbadocno,"' ORDER BY inbbseq"
   LET l_sql ="SELECT inbbsite,inbbdocno,inbbseq,inbb001,'','',inbb002,'',inbb004,inbb003,inbb007,inbb008,inbb009,inbb011,inbb014,inbb023,'',inbb024,'',inbb025,'',",
              "       inbb204,inbb022,inbb021 FROM inbb_t WHERE inbbent = '",g_enterprise,"' AND inbbsite = '",g_site,"' AND inbbdocno ='",p_inbadocno,"' ORDER BY inbbseq"
   #160512-00004#2-mod-(E)
   PREPARE aint302_01_pb2 FROM l_sql
   DECLARE inbb_b_fill_curs CURSOR FOR aint302_01_pb2

   CALL g_inbb_d.clear()
   LET l_ac1 = 1
   FOREACH inbb_b_fill_curs INTO g_inbb_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL aint302_01_inbb001_ref(g_inbb_d[l_ac1].inbb001) RETURNING g_inbb_d[l_ac1].inbb001_desc,g_inbb_d[l_ac1].inbb001_desc2
      DISPLAY BY NAME g_inbb_d[l_ac1].inbb001_desc,g_inbb_d[l_ac1].inbb001_desc2
      
      CALL s_feature_description(g_inbb_d[l_ac1].inbb001,g_inbb_d[l_ac1].inbb001) RETURNING l_success,g_inbb_d[l_ac1].inbb002_desc
      DISPLAY BY NAME g_inbb_d[l_ac1].inbb002_desc 
      
      CALL s_desc_get_project_desc(g_inbb_d[l_ac1].inbb023) RETURNING g_inbb_d[l_ac1].inbb023_desc
      DISPLAY BY NAME g_inbb_d[l_ac1].inbb023_desc
       
      CALL s_desc_get_wbs_desc(g_inbb_d[l_ac1].inbb023,g_inbb_d[l_ac1].inbb024) RETURNING g_inbb_d[l_ac1].inbb024_desc
      DISPLAY BY NAME g_inbb_d[l_ac1].inbb024_desc
         
      CALL s_desc_get_activity_desc(g_inbb_d[l_ac1].inbb023,g_inbb_d[l_ac1].inbb025) RETURNING g_inbb_d[l_ac1].inbb025_desc
      DISPLAY BY NAME g_inbb_d[l_ac1].inbb025_desc
          
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF

   END FOREACH
   CALL g_inbb_d.deleteElement(g_inbb_d.getLength())
   LET g_rec_b2 = l_ac1 - 1
   DISPLAY g_rec_b2 TO FORMONLY.cnt
   CLOSE inbb_b_fill_curs
   FREE aint302_01_pb2
   
END FUNCTION
#+
PRIVATE FUNCTION aint302_01_inbc005_ref(p_inbc005)
DEFINE p_inbc005      LIKE inbc_t.inbc005
DEFINE r_inbc005_desc LIKE inaa_t.inaa002

      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = p_inbc005
      #CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite='"||g_site||"' AND inaa001 = ? ","") RETURNING g_rtn_fields
      #LET r_inbc005_desc = '', g_rtn_fields[1] , ''
      CALL s_desc_get_stock_desc(g_site,p_inbc005) RETURNING r_inbc005_desc
      RETURN r_inbc005_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aint302_01_inbc006_ref(p_inbc005,p_inbc006)
DEFINE p_inbc005      LIKE inbc_t.inbc005
DEFINE p_inbc006      LIKE inbc_t.inbc006
DEFINE r_inbc006_desc LIKE inab_t.inab003
DEFINE l_inaa007   LIKE inaa_t.inaa007

      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = p_inbc006
      #CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site||"' AND inab001 = '"||p_inbc005||"' AND inab002 = ? ","") RETURNING g_rtn_fields
      #LET r_inbc006_desc = '', g_rtn_fields[1] , ''
      
      SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = p_inbc005
      
      IF l_inaa007 = '3' OR l_inaa007 = '4' THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_inbc006
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001 = ? AND pmaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
         LET r_inbc006_desc = '', g_rtn_fields[1] , ''
      ELSE
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = p_inbc006
         CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site||"' AND inab001 = '"||p_inbc005||"' AND inab002 = ? ","") RETURNING g_rtn_fields
         LET r_inbc006_desc = '', g_rtn_fields[1] , ''
      END IF
      
      RETURN r_inbc006_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aint302_01_inbb001_ref(p_inbb001)
DEFINE p_inbb001      LIKE inbb_t.inbb001
DEFINE r_imaal003     LIKE imaal_t.imaal003
DEFINE r_imaal004     LIKE imaal_t.imaal004

      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = p_inbb001
      #CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET r_imaal003 = '', g_rtn_fields[1] , ''
      #LET r_imaal004 = '', g_rtn_fields[2] , ''
      CALL s_desc_get_item_desc(p_inbb001) RETURNING r_imaal003,r_imaal004
      RETURN r_imaal003,r_imaal004
      
END FUNCTION
#+
PRIVATE FUNCTION aint302_01_inbc_fill(p_inbadocno)
DEFINE p_inbadocno   LIKE inba_t.inbadocno
DEFINE l_sql         STRING
DEFINE l_ac1         LIKE type_t.num5
   
   IF g_inbb_d.getLength() = 0 THEN
      RETURN
   END IF
   
   LET l_sql ="SELECT inbcsite,inbcdocno,inbcseq,inbcseq1,inbc001,inbc002,inbc005,inaa002,inbc006,'',inbc007,inbc003,inbc010,inbc015,",
              #160512-00004#2-mod-(S)
#              " inbc021,'',inbc022,'',inbc023,'',inbc016,inbc017   ",
              " inbc021,'',inbc022,'',inbc023,'',inbc203,inbc016,inbc017   ",
              #160512-00004#2-mod-(E)
              "  FROM inbc_t ",
              "       LEFT JOIN inaa_t ON inaaent=inbcent AND inaasite=inbcsite AND inaa001 = inbc005 ",
              " WHERE inbcent = ? AND inbcsite = ? AND inbcdocno =? AND inbcseq = ? ",
              " ORDER BY inbcseq,inbcseq1"
   PREPARE aint302_01_pb1 FROM l_sql
   DECLARE inbc_b_fill_curs CURSOR FOR aint302_01_pb1

   OPEN inbc_b_fill_curs USING g_enterprise,g_inbb_d[l_ac2].inbbsite ,p_inbadocno,g_inbb_d[l_ac2].inbbseq
   CALL g_inbc_d.clear()
   LET l_ac1 = 1
   FOREACH inbc_b_fill_curs INTO g_inbc_d[l_ac1].inbcsite, g_inbc_d[l_ac1].inbcdocno,g_inbc_d[l_ac1].inbcseq,g_inbc_d[l_ac1].inbcseq1,
                                 g_inbc_d[l_ac1].inbc001,g_inbc_d[l_ac1].inbc002,g_inbc_d[l_ac1].inbc005,g_inbc_d[l_ac1].inbc005_desc,
                                 g_inbc_d[l_ac1].inbc006,g_inbc_d[l_ac1].inbc006_desc,g_inbc_d[l_ac1].inbc007,g_inbc_d[l_ac1].inbc003,
                                 g_inbc_d[l_ac1].inbc010, g_inbc_d[l_ac1].inbc015,g_inbc_d[l_ac1].inbc021,g_inbc_d[l_ac1].inbc021_desc,
                                 g_inbc_d[l_ac1].inbc022,g_inbc_d[l_ac1].inbc022_desc,g_inbc_d[l_ac1].inbc023,g_inbc_d[l_ac1].inbc023_desc,
                                 g_inbc_d[l_ac1].inbc203,  #160512-00004#2-add
                                 g_inbc_d[l_ac1].inbc016,g_inbc_d[l_ac1].inbc017
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #160808-00063#1-s remark
      CALL aint302_01_inbc005_ref(g_inbc_d[l_ac1].inbc005) RETURNING g_inbc_d[l_ac1].inbc005_desc
      DISPLAY BY NAME g_inbc_d[l_ac1].inbc005_desc
      #160808-00063#1-e remark
      
      CALL aint302_01_inbc006_ref(g_inbc_d[l_ac1].inbc005,g_inbc_d[l_ac1].inbc006) RETURNING g_inbc_d[l_ac1].inbc006_desc
      DISPLAY BY NAME g_inbc_d[l_ac1].inbc006_desc
      
      CALL s_desc_get_project_desc(g_inbc_d[l_ac1].inbc021) RETURNING g_inbc_d[l_ac1].inbc021_desc
      DISPLAY BY NAME g_inbc_d[l_ac1].inbc021_desc
       
      CALL s_desc_get_wbs_desc(g_inbc_d[l_ac1].inbc021,g_inbc_d[l_ac1].inbc022) RETURNING g_inbc_d[l_ac1].inbc022_desc
      DISPLAY BY NAME g_inbc_d[l_ac1].inbc022_desc
         
      CALL s_desc_get_activity_desc(g_inbc_d[l_ac1].inbc021,g_inbc_d[l_ac1].inbc023) RETURNING g_inbc_d[l_ac1].inbc023_desc
      DISPLAY BY NAME g_inbc_d[l_ac1].inbc023_desc
          
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF

   END FOREACH
   CALL g_inbc_d.deleteElement(g_inbc_d.getLength())
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE inbc_b_fill_curs
   FREE aint302_01_pb1

END FUNCTION
#+
PRIVATE FUNCTION aint302_01_inbc006_chk(p_inbc005,p_inbc006)
DEFINE p_inbc005   LIKE inbc_t.inbc005
DEFINE p_inbc006   LIKE inbc_t.inbc006
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_flag      LIKE type_t.num5
DEFINE l_inaa007   LIKE inaa_t.inaa007

      LET r_success = TRUE   
      
      IF cl_null(p_inbc006) THEN
         LET p_inbc006 = ' '
      END IF
      
      #若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
      #IF g_type = '1' THEN  #161109-00032#1
      IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
         IF cl_null(g_inbb_d[l_ac2].inbb002) THEN
            LET g_inbb_d[l_ac2].inbb002 = ' '
         END IF
#161006-00018#2-S mark         
#         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#         INITIALIZE g_chkparam.* TO NULL
#      
#         #設定g_chkparam.*的參數
#         LET g_chkparam.arg1 = g_site
#         LET g_chkparam.arg2 = g_inbc_d[l_ac].inbc001
#         LET g_chkparam.arg3 = g_inbb_d[l_ac2].inbb002
#         LET g_chkparam.arg4 = g_inbb_d[l_ac2].inbb003
#         LET g_chkparam.arg5 = p_inbc005
#         LET g_chkparam.arg6 = p_inbc006
#      
#         #呼叫檢查存在並帶值的library
#         IF NOT cl_chk_exist("v_inag005") THEN
#            LET r_success = FALSE
#            RETURN r_success  
#         END IF
#161006-00018#2-E mark         
      END IF 
        
      #若是雜項庫存收料作業時
      #IF g_type = '2' THEN                 #161109-00032#1   
      IF g_type = '2' OR g_type = '4' THEN  #161109-00032#1   
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL
         
         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = g_site
         LET g_chkparam.arg2 = p_inbc005
         LET g_chkparam.arg3 = p_inbc006
         #160318-00025#23  by 07900 --add-str
        LET g_errshow = TRUE #是否開窗                   
        LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
         #160318-00025#23  by 07900 --add-end
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_inab002") THEN
            LET r_success = FALSE
            RETURN r_success  
         END IF 
      END IF  
      #呼叫s_control_doc_chk('6',inbcdocno,inbc005,inbc006,'','','')應用元件，
      #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
      CALL s_control_chk_doc('6',g_inbadocno,p_inbc005,p_inbc006,'','','') RETURNING l_success,l_flag
      IF NOT l_flag THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
        
      RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION aint302_01_inbc007_chk()
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_ooac001   LIKE ooac_t.ooac001
DEFINE l_ooac002   LIKE ooac_t.ooac002
DEFINE l_ooac004   LIKE ooac_t.ooac004
DEFINE l_flag      LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_flag1     LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_site      LIKE type_t.chr20
DEFINE l_inbadocno STRING 
DEFINE l_n         LIKE type_t.num5 
DEFINE l_inaa007   LIKE inaa_t.inaa007       #161006-00018#31  

      LET l_flag = TRUE
      LET l_flag1 = TRUE
      LET l_ooac001 = NULL
      LET l_ooac002 = NULL

      LET r_success = TRUE   
      
      #若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位+儲位+批號必須存在[T:庫存明細檔]中
      #IF g_type = '1' THEN                 #161109-00032#1
      IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
         #161006-00018#31-S
         LET l_inaa007 = ''
         SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inbc_d[l_ac].inbc005
         IF l_inaa007 = '5' THEN   
         #161006-00018#31-E         
            IF cl_null(g_inbc_d[l_ac].inbc006) THEN
               LET g_inbc_d[l_ac].inbc006 = ' '
            END IF
         END IF  #161006-00018#31
         IF cl_null(g_inbb_d[l_ac2].inbb002) THEN
            LET g_inbb_d[l_ac2].inbb002 = ' '
         END IF
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL
      
         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = g_site
         LET g_chkparam.arg2 = g_inbc_d[l_ac].inbc001
         LET g_chkparam.arg3 = g_inbb_d[l_ac2].inbb002
         LET g_chkparam.arg4 = g_inbb_d[l_ac2].inbb003
         LET g_chkparam.arg5 = g_inbc_d[l_ac].inbc005
         LET g_chkparam.arg6 = g_inbc_d[l_ac].inbc006
         LET g_chkparam.arg7 = g_inbc_d[l_ac].inbc007
      
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_inag006") THEN
            LET r_success = FALSE
            RETURN r_success  
         END IF
        
      END IF 
        
      #若是[P:雜項庫存收料維護作業]時，需檢核單據別參數的"庫存批號可重覆否"是否允許，
      #若勾選不允許則要檢查輸入的批號是否存在[T:料件批號檔]中
      #IF g_type = '2' THEN  #161109-00032#1   
      IF g_type = '2' OR g_type = '4' THEN  #161109-00032#1    
         #ent+參照表號+單據別+參數編號(D-MFG-0012)抓ooac004的值
         
         CALL s_aooi200_get_site(g_inbadocno) RETURNING l_flag,l_site
         IF l_flag THEN
            SELECT ooef004 INTO l_ooac001 FROM ooef_t
             WHERE ooef005 = l_site
               AND ooefent = g_enterprise
         END IF
         CALL s_aooi200_get_slip(g_inbadocno) RETURNING l_flag1,l_ooac002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-MFG-0012') RETURNING l_ooac004

         IF l_ooac004 = 'N' THEN
           LET l_n = 0
            IF g_inbb_d[l_ac].inbb002 IS NOT NULL THEN
               SELECT COUNT(*) INTO l_n FROM inad_t 
                 WHERE inadent = g_enterprise AND inadsite = g_site AND inad001 = g_inbb_d[l_ac].inbb001
                   AND inad002 = g_inbb_d[l_ac].inbb002 AND inad003 = g_inbb_d[l_ac].inbb009
            ELSE
               SELECT COUNT(*) INTO l_n FROM inad_t 
                 WHERE inadent = g_enterprise AND inadsite = g_site AND inad001 = g_inbb_d[l_ac].inbb001
                   AND inad003 = g_inbb_d[l_ac].inbb009
            END IF
            IF l_n > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00269'
               LET g_errparam.extend = g_inbb_d[l_ac].inbb009
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success  
            END IF
         END IF
      END IF   
    
      RETURN r_success
END FUNCTION

PRIVATE FUNCTION aint302_01_set_required()
DEFINE l_inaa007   LIKE inaa_t.inaa007
DEFINE l_imaf061   LIKE imaf_t.imaf061
DEFINE l_imaf055   LIKE imaf_t.imaf055

    LET l_inaa007 = ''
    SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inbc_d[l_ac].inbc005
    IF l_inaa007 MATCHES '[1234]' THEN
       CALL cl_set_comp_required("inbc006",TRUE)
    END IF
    
    SELECT imaf061,imaf055 INTO l_imaf061,l_imaf055 FROM imaf_t WHERE imafent = g_enterprise AND imaf001 =  g_inbc_d[l_ac].inbc001 AND imafsite = g_site

    #[T:料件據點進銷存檔].[C:庫存批號控管]=1時,[C:必須有批號]欄位必輸
    IF l_imaf061 = '1' THEN
       CALL cl_set_comp_required("inbc007",TRUE)
    END IF
    
    #若設定imaf055(庫存管理特徵)等於'1.必須有庫存管理特徵'時，則[C:庫存管理特徵]欄位必須輸入
    IF l_imaf055 = '1' THEN
       CALL cl_set_comp_required("inbc003",TRUE)
    END IF
    
END FUNCTION

PRIVATE FUNCTION aint302_01_set_no_required()

    CALL cl_set_comp_required("inbc006,inbc007,inbc003",FALSE)
    
END FUNCTION

#輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
PRIVATE FUNCTION aint302_01_chk_inag004(p_inbb007)
DEFINE p_inbb007   LIKE inbb_t.inbb007
DEFINE r_success   LIKE type_t.num5
      
      LET r_success = TRUE
      
      IF cl_null(g_inbb_d[l_ac2].inbb002) THEN
         LET g_inbb_d[l_ac2].inbb002 = ' '
      END IF
      IF cl_null(g_inbb_d[l_ac2].inbb003) THEN
         LET g_inbb_d[l_ac2].inbb003 = ' '
      END IF
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_inbb_d[l_ac2].inbb001
      LET g_chkparam.arg3 = g_inbb_d[l_ac2].inbb002
      LET g_chkparam.arg4 = g_inbb_d[l_ac2].inbb003
      LET g_chkparam.arg5 = p_inbb007
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inag004") THEN
         LET r_success = FALSE
         RETURN r_success  
      END IF
         
      RETURN r_success
      
END FUNCTION

#輸入的料件+產品特徵+庫存管理特徵+庫位+儲位必須存在[T:庫存明細檔]中
PRIVATE FUNCTION aint302_01_chk_inag005(p_inbb007,p_inbb008)
DEFINE p_inbb007   LIKE inbb_t.inbb007
DEFINE p_inbb008   LIKE inbb_t.inbb008
DEFINE r_success   LIKE type_t.num5

      LET r_success = TRUE   
      
      IF cl_null(p_inbb008) THEN
         LET p_inbb008 = ' '
      END IF
      IF cl_null(g_inbb_d[l_ac2].inbb003) THEN
         LET g_inbb_d[l_ac2].inbb003 = ' '
      END IF

      #若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
      IF cl_null(g_inbb_d[l_ac2].inbb002) THEN
         LET g_inbb_d[l_ac2].inbb002 = ' '
      END IF
      IF cl_null(g_inbb_d[l_ac2].inbb003) THEN
         LET g_inbb_d[l_ac2].inbb003 = ' '
      END IF
      IF cl_null(p_inbb008) THEN
         LET p_inbb008 = ' '
      END IF
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_inbb_d[l_ac2].inbb001
      LET g_chkparam.arg3 = g_inbb_d[l_ac2].inbb002
      LET g_chkparam.arg4 = g_inbb_d[l_ac2].inbb003
      LET g_chkparam.arg5 = p_inbb007
      LET g_chkparam.arg6 = p_inbb008
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inag005") THEN
         LET r_success = FALSE
         RETURN r_success  
      END IF
      RETURN r_success  
      
END FUNCTION

################################################################################
# Descriptions...: 檢查是否為 有效日期>製造日期
# Memo...........:
# Usage..........: CALL aint302_01_inbc203_inbc016_chk(p_inbc203,p_inbc016)
#                  RETURNING r_success
# Input parameter: p_inbc203      製造日期
#                : p_inbc016      有效日期
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/6/23 By dorislai (#160512-00004#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION aint302_01_inbc203_inbc016_chk(p_inbc203,p_inbc016)
   DEFINE p_inbc203  LIKE inbc_t.inbc203
   DEFINE p_inbc016  LIKE inbc_t.inbc016
   DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF cl_null(p_inbc203) OR cl_null(p_inbc016) THEN
      RETURN r_success
   END IF

   #製造日期>有效日期
   IF p_inbc203 > p_inbc016 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "ain-00311"  #有效日期不可以小於製造日期！
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 若是雜項庫存發料作業時，輸入的料件+產品特徵+庫存管理特徵+庫位必須存在[T:庫存明細檔]中
# Memo...........:
# Usage..........: CALL aint302_01_check_inag()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aint302_01_check_inag()
DEFINE  l_count     LIKE type_t.num5
DEFINE  l_sql       STRING
DEFINE  r_success   LIKE type_t.num5

   LET r_success = TRUE
   #IF g_type = '1' THEN   #161109-00032#1
   IF g_type = '1' OR g_type = '3' THEN  #161109-00032#1
      LET l_count = 0
      LET l_sql = " SELECT COUNT(1) FROM inag_t  ",
                  "  WHERE inagent = ",g_enterprise,
                  "    AND inagsite = '",g_site,"'",
                  "    AND inag001 = '",g_inbc_d[l_ac].inbc001,"'"
      
      IF NOT cl_null(g_inbc_d[l_ac].inbc002) THEN
         LET l_sql = l_sql, " AND inag002 = '",g_inbc_d[l_ac].inbc002,"'"
      END IF
      
      IF NOT cl_null(g_inbc_d[l_ac].inbc003) THEN
         LET l_sql = l_sql, " AND inag003 = '",g_inbc_d[l_ac].inbc003,"'"
      END IF
      
      IF NOT cl_null(g_inbc_d[l_ac].inbc005) THEN
         LET l_sql = l_sql, " AND inag004 = '",g_inbc_d[l_ac].inbc005,"'"
      END IF
      
      IF NOT cl_null(g_inbc_d[l_ac].inbc006) THEN
         LET l_sql = l_sql, " AND inag005 = '",g_inbc_d[l_ac].inbc006,"'"
      END IF
      
      IF NOT cl_null(g_inbc_d[l_ac].inbc007) THEN
         LET l_sql = l_sql, " AND inag006 = '",g_inbc_d[l_ac].inbc007,"'"
      END IF   
      
      PREPARE aint302_01_inag_pre FROM l_sql   
      EXECUTE aint302_01_inag_pre INTO l_count
      
      IF cl_null(l_count) THEN LET l_count = 0 END IF
       
      IF l_count = 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "ain-00017"  
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF 
   END IF
   RETURN r_success   
END FUNCTION

 
{</section>}
 
