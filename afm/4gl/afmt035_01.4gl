#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt035_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-03-25 13:52:06), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: afmt035_01
#+ Description: 擔保明細
#+ Creator....: 02291(2015-11-17 10:06:33)
#+ Modifier...: 02291 -SD/PR- 00000
 
{</section>}
 
{<section id="afmt035_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160322-00036#1   2016/03/25 By yangtt  1.添加fmcp021,fmcp022两个字段
#160318-00005#12  2016/03/25 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160324-00005#1   2016/03/25 by 01531   集团内企业进行资产抵押时，未考虑到afat515中的抵押状态
#160318-00025#6   2016/04/18 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
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
PRIVATE TYPE type_g_fmcp_d RECORD
       fmcpdocno LIKE fmcp_t.fmcpdocno, 
   fmcpseq LIKE fmcp_t.fmcpseq, 
   fmcpseq2 LIKE fmcp_t.fmcpseq2, 
   fmcp015 LIKE fmcp_t.fmcp015, 
   fmcp001 LIKE fmcp_t.fmcp001, 
   fmcp002 LIKE fmcp_t.fmcp002, 
   fmcp002_desc LIKE type_t.chr500, 
   fmcp003 LIKE fmcp_t.fmcp003, 
   fmcp003_desc LIKE type_t.chr500, 
   fmcp017 LIKE fmcp_t.fmcp017, 
   fmcp016 LIKE fmcp_t.fmcp016, 
   fmcp004 LIKE fmcp_t.fmcp004, 
   fmcp005 LIKE fmcp_t.fmcp005, 
   fmcp018 LIKE fmcp_t.fmcp018, 
   fmcp019 LIKE fmcp_t.fmcp019, 
   fmcp020 LIKE fmcp_t.fmcp020, 
   fmcp006 LIKE fmcp_t.fmcp006, 
   fmcp007 LIKE fmcp_t.fmcp007, 
   fmcp008 LIKE fmcp_t.fmcp008, 
   fmcp009 LIKE fmcp_t.fmcp009, 
   fmcp021 LIKE fmcp_t.fmcp021, 
   fmcp021_desc LIKE type_t.chr500, 
   fmcp010 LIKE fmcp_t.fmcp010, 
   fmcp022 LIKE fmcp_t.fmcp022, 
   fmcp022_desc LIKE type_t.chr500, 
   fmcp011 LIKE fmcp_t.fmcp011, 
   fmcp012 LIKE fmcp_t.fmcp012, 
   fmcp013 LIKE fmcp_t.fmcp013, 
   fmcp014 LIKE fmcp_t.fmcp014
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fmcpdocno      LIKE fmcp_t.fmcpdocno
DEFINE g_fmcjsite       LIKE fmcj_t.fmcjsite
DEFINE g_fmcjdocdt       LIKE fmcj_t.fmcjdocdt
DEFINE g_fmcj005        LIKE fmcj_t.fmcj005
DEFINE g_glaald         LIKE glaa_t.glaald
DEFINE g_glaa001        LIKE glaa_t.glaa001
DEFINE g_glaa120        LIKE glaa_t.glaa120
DEFINE g_para_data      LIKE type_t.chr80     #采用成本域否
DEFINE g_glaa026        LIKE glaa_t.glaa026   #160322-00036#1#1 add

#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmcp_d          DYNAMIC ARRAY OF type_g_fmcp_d #單身變數
DEFINE g_fmcp_d_t        type_g_fmcp_d                  #單身備份
DEFINE g_fmcp_d_o        type_g_fmcp_d                  #單身備份
DEFINE g_fmcp_d_mask_o   DYNAMIC ARRAY OF type_g_fmcp_d #單身變數
DEFINE g_fmcp_d_mask_n   DYNAMIC ARRAY OF type_g_fmcp_d #單身變數
 
      
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
 
{<section id="afmt035_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION afmt035_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_fmcpdocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_fmcpdocno       LIKE fmcp_t.fmcpdocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_fmcpdocno = p_fmcpdocno
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fmcpdocno,fmcpseq,fmcpseq2,fmcp015,fmcp001,fmcp002,fmcp003,fmcp017,fmcp016, 
       fmcp004,fmcp005,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp021,fmcp010,fmcp022, 
       fmcp011,fmcp012,fmcp013,fmcp014 FROM fmcp_t WHERE fmcpent=? AND fmcpdocno=? AND fmcpseq=? AND  
       fmcpseq2=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt035_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afmt035_01 WITH FORM cl_ap_formpath("afm","afmt035_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL afmt035_01_init()   
 
   #進入選單 Menu (="N")
   CALL afmt035_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_afmt035_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt035_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmt035_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE  l_ooef017              LIKE ooef_t.ooef017
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('fmcp015','8856','1,2,3')
   CALL cl_set_combo_scc('fmcp012','8863')
   SELECT fmcjsite,fmcjdocdt,fmcj005 INTO g_fmcjsite,g_fmcjdocdt,g_fmcj005 FROM fmcj_t
    WHERE fmcjent = g_enterprise AND fmcjdocno = g_fmcpdocno
   
   CASE
      WHEN g_fmcj005 = '2'
         CALL cl_set_combo_scc_part('fmcp003','8862','1,2')
      WHEN g_fmcj005 = '3'
         CALL cl_set_combo_scc_part('fmcp003','8862','A,B,C,D')
   END CASE
   
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_fmcjsite
    
   SELECT glaald,glaa001,glaa120,glaa026 INTO g_glaald,g_glaa001,g_glaa120,g_glaa026 FROM glaa_t  #160322-00036#1#1 add gla026
    WHERE glaaent = g_enterprise AND glaa014 = 'Y'
      AND glaacomp = g_fmcjsite
   CALL cl_get_para(g_enterprise,g_fmcjsite,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   #end add-point
   
   CALL afmt035_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afmt035_01_ui_dialog()
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
   DEFINE  l_fmcjstus             LIKE fmcj_t.fmcjstus
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   SELECT fmcjstus INTO l_fmcjstus FROM fmcj_t
    WHERE fmcjent = g_enterprise AND fmcjdocno = g_fmcpdocno
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_fmcp_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL afmt035_01_init()
      END IF
   
      CALL afmt035_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_fmcp_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL afmt035_01_set_pk_array()
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
            IF l_fmcjstus NOT MATCHES "[NDR]" THEN
               CALL cl_set_act_visible("insert,modify,delete,modify_detail", FALSE)
            END IF
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL afmt035_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afmt035_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL afmt035_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afmt035_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL afmt035_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL afmt035_01_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt035_01_insert()
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
               CALL afmt035_01_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_fmcp_d)
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
            CALL afmt035_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt035_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt035_01_set_pk_array()
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
         IF INT_FLAG THEN LET INT_FLAG = FALSE END IF
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt035_01_query()
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
   CALL g_fmcp_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON fmcpdocno,fmcpseq,fmcpseq2,fmcp015,fmcp001,fmcp002,fmcp003,fmcp017,fmcp016, 
          fmcp004,fmcp005,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp021,fmcp010,fmcp022, 
          fmcp011,fmcp012,fmcp013,fmcp014 
 
         FROM s_detail1[1].fmcpdocno,s_detail1[1].fmcpseq,s_detail1[1].fmcpseq2,s_detail1[1].fmcp015, 
             s_detail1[1].fmcp001,s_detail1[1].fmcp002,s_detail1[1].fmcp003,s_detail1[1].fmcp017,s_detail1[1].fmcp016, 
             s_detail1[1].fmcp004,s_detail1[1].fmcp005,s_detail1[1].fmcp018,s_detail1[1].fmcp019,s_detail1[1].fmcp020, 
             s_detail1[1].fmcp006,s_detail1[1].fmcp007,s_detail1[1].fmcp008,s_detail1[1].fmcp009,s_detail1[1].fmcp021, 
             s_detail1[1].fmcp010,s_detail1[1].fmcp022,s_detail1[1].fmcp011,s_detail1[1].fmcp012,s_detail1[1].fmcp013, 
             s_detail1[1].fmcp014 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcpdocno
            #add-point:BEFORE FIELD fmcpdocno name="query.b.page1.fmcpdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcpdocno
            
            #add-point:AFTER FIELD fmcpdocno name="query.a.page1.fmcpdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcpdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcpdocno
            #add-point:ON ACTION controlp INFIELD fmcpdocno name="query.c.page1.fmcpdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcpseq
            #add-point:BEFORE FIELD fmcpseq name="query.b.page1.fmcpseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcpseq
            
            #add-point:AFTER FIELD fmcpseq name="query.a.page1.fmcpseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcpseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcpseq
            #add-point:ON ACTION controlp INFIELD fmcpseq name="query.c.page1.fmcpseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcpseq2
            #add-point:BEFORE FIELD fmcpseq2 name="query.b.page1.fmcpseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcpseq2
            
            #add-point:AFTER FIELD fmcpseq2 name="query.a.page1.fmcpseq2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcpseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcpseq2
            #add-point:ON ACTION controlp INFIELD fmcpseq2 name="query.c.page1.fmcpseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp015
            #add-point:BEFORE FIELD fmcp015 name="query.b.page1.fmcp015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp015
            
            #add-point:AFTER FIELD fmcp015 name="query.a.page1.fmcp015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp015
            #add-point:ON ACTION controlp INFIELD fmcp015 name="query.c.page1.fmcp015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp001
            #add-point:BEFORE FIELD fmcp001 name="query.b.page1.fmcp001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp001
            
            #add-point:AFTER FIELD fmcp001 name="query.a.page1.fmcp001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp001
            #add-point:ON ACTION controlp INFIELD fmcp001 name="query.c.page1.fmcp001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp001  #顯示到畫面上
            NEXT FIELD fmcp001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp002
            #add-point:BEFORE FIELD fmcp002 name="query.b.page1.fmcp002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp002
            
            #add-point:AFTER FIELD fmcp002 name="query.a.page1.fmcp002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp002
            #add-point:ON ACTION controlp INFIELD fmcp002 name="query.c.page1.fmcp002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp002  #顯示到畫面上
            NEXT FIELD fmcp002                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmcp003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp003
            #add-point:ON ACTION controlp INFIELD fmcp003 name="construct.c.page1.fmcp003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzcb002_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp003  #顯示到畫面上
            NEXT FIELD fmcp003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp003
            #add-point:BEFORE FIELD fmcp003 name="query.b.page1.fmcp003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp003
            
            #add-point:AFTER FIELD fmcp003 name="query.a.page1.fmcp003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp017
            #add-point:BEFORE FIELD fmcp017 name="query.b.page1.fmcp017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp017
            
            #add-point:AFTER FIELD fmcp017 name="query.a.page1.fmcp017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp017
            #add-point:ON ACTION controlp INFIELD fmcp017 name="query.c.page1.fmcp017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp017()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp017  #顯示到畫面上
            NEXT FIELD fmcp017                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp016
            #add-point:BEFORE FIELD fmcp016 name="query.b.page1.fmcp016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp016
            
            #add-point:AFTER FIELD fmcp016 name="query.a.page1.fmcp016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp016
            #add-point:ON ACTION controlp INFIELD fmcp016 name="query.c.page1.fmcp016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp016()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp016  #顯示到畫面上
            NEXT FIELD fmcp016                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp004
            #add-point:BEFORE FIELD fmcp004 name="query.b.page1.fmcp004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp004
            
            #add-point:AFTER FIELD fmcp004 name="query.a.page1.fmcp004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp004
            #add-point:ON ACTION controlp INFIELD fmcp004 name="query.c.page1.fmcp004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp004  #顯示到畫面上
            NEXT FIELD fmcp004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp005
            #add-point:BEFORE FIELD fmcp005 name="query.b.page1.fmcp005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp005
            
            #add-point:AFTER FIELD fmcp005 name="query.a.page1.fmcp005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp005
            #add-point:ON ACTION controlp INFIELD fmcp005 name="query.c.page1.fmcp005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp005  #顯示到畫面上
            NEXT FIELD fmcp005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp018
            #add-point:BEFORE FIELD fmcp018 name="query.b.page1.fmcp018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp018
            
            #add-point:AFTER FIELD fmcp018 name="query.a.page1.fmcp018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp018
            #add-point:ON ACTION controlp INFIELD fmcp018 name="query.c.page1.fmcp018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp018()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp018  #顯示到畫面上
            NEXT FIELD fmcp018                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp019
            #add-point:BEFORE FIELD fmcp019 name="query.b.page1.fmcp019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp019
            
            #add-point:AFTER FIELD fmcp019 name="query.a.page1.fmcp019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp019
            #add-point:ON ACTION controlp INFIELD fmcp019 name="query.c.page1.fmcp019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp019()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp019  #顯示到畫面上
            NEXT FIELD fmcp019                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp020
            #add-point:BEFORE FIELD fmcp020 name="query.b.page1.fmcp020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp020
            
            #add-point:AFTER FIELD fmcp020 name="query.a.page1.fmcp020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp020
            #add-point:ON ACTION controlp INFIELD fmcp020 name="query.c.page1.fmcp020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcp020()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp020  #顯示到畫面上
            NEXT FIELD fmcp020                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp006
            #add-point:BEFORE FIELD fmcp006 name="query.b.page1.fmcp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp006
            
            #add-point:AFTER FIELD fmcp006 name="query.a.page1.fmcp006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp006
            #add-point:ON ACTION controlp INFIELD fmcp006 name="query.c.page1.fmcp006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp006  #顯示到畫面上
            NEXT FIELD fmcp006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp007
            #add-point:BEFORE FIELD fmcp007 name="query.b.page1.fmcp007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp007
            
            #add-point:AFTER FIELD fmcp007 name="query.a.page1.fmcp007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp007
            #add-point:ON ACTION controlp INFIELD fmcp007 name="query.c.page1.fmcp007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp008
            #add-point:BEFORE FIELD fmcp008 name="query.b.page1.fmcp008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp008
            
            #add-point:AFTER FIELD fmcp008 name="query.a.page1.fmcp008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp008
            #add-point:ON ACTION controlp INFIELD fmcp008 name="query.c.page1.fmcp008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp009
            #add-point:BEFORE FIELD fmcp009 name="query.b.page1.fmcp009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp009
            
            #add-point:AFTER FIELD fmcp009 name="query.a.page1.fmcp009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp009
            #add-point:ON ACTION controlp INFIELD fmcp009 name="query.c.page1.fmcp009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmcp021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp021
            #add-point:ON ACTION controlp INFIELD fmcp021 name="construct.c.page1.fmcp021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp021  #顯示到畫面上
            NEXT FIELD fmcp021                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp021
            #add-point:BEFORE FIELD fmcp021 name="query.b.page1.fmcp021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp021
            
            #add-point:AFTER FIELD fmcp021 name="query.a.page1.fmcp021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp010
            #add-point:BEFORE FIELD fmcp010 name="query.b.page1.fmcp010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp010
            
            #add-point:AFTER FIELD fmcp010 name="query.a.page1.fmcp010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp010
            #add-point:ON ACTION controlp INFIELD fmcp010 name="query.c.page1.fmcp010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmcp022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp022
            #add-point:ON ACTION controlp INFIELD fmcp022 name="construct.c.page1.fmcp022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp022  #顯示到畫面上
            NEXT FIELD fmcp022                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp022
            #add-point:BEFORE FIELD fmcp022 name="query.b.page1.fmcp022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp022
            
            #add-point:AFTER FIELD fmcp022 name="query.a.page1.fmcp022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp011
            #add-point:BEFORE FIELD fmcp011 name="query.b.page1.fmcp011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp011
            
            #add-point:AFTER FIELD fmcp011 name="query.a.page1.fmcp011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp011
            #add-point:ON ACTION controlp INFIELD fmcp011 name="query.c.page1.fmcp011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp012
            #add-point:BEFORE FIELD fmcp012 name="query.b.page1.fmcp012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp012
            
            #add-point:AFTER FIELD fmcp012 name="query.a.page1.fmcp012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp012
            #add-point:ON ACTION controlp INFIELD fmcp012 name="query.c.page1.fmcp012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp013
            #add-point:BEFORE FIELD fmcp013 name="query.b.page1.fmcp013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp013
            
            #add-point:AFTER FIELD fmcp013 name="query.a.page1.fmcp013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp013
            #add-point:ON ACTION controlp INFIELD fmcp013 name="query.c.page1.fmcp013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbddocno_1()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcp013  #顯示到畫面上
            NEXT FIELD fmcp013                    #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp014
            #add-point:BEFORE FIELD fmcp014 name="query.b.page1.fmcp014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp014
            
            #add-point:AFTER FIELD fmcp014 name="query.a.page1.fmcp014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.fmcp014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp014
            #add-point:ON ACTION controlp INFIELD fmcp014 name="query.c.page1.fmcp014"
            
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
    
   CALL afmt035_01_b_fill(g_wc2)
 
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
 
{<section id="afmt035_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt035_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL afmt035_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt035_01_modify()
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
   DEFINE  l_fmcp009_sum          LIKE fmcp_t.fmcp009
   DEFINE  l_fmcp010              LIKE fmcp_t.fmcp010
   DEFINE  l_inbdstus             LIKE inbd_t.inbdstus
   DEFINE  l_inbdsite             LIKE inbd_t.inbdsite
   DEFINE  l_nmbastus             LIKE nmba_t.nmbastus
   DEFINE  l_faah004              LIKE faah_t.faah004 
   DEFINE  l_faah017              LIKE faah_t.faah017
   DEFINE  l_faah018              LIKE faah_t.faah018
   DEFINE  l_faaj016              LIKE faaj_t.faaj016
   DEFINE  l_faaj017              LIKE faaj_t.faaj017
   DEFINE  l_faaj021              LIKE faaj_t.faaj021
   DEFINE  l_xccc901              LIKE xccc_t.xccc901
   DEFINE  l_xccc902              LIKE xccc_t.xccc902
   DEFINE  l_faah028              LIKE faah_t.faah028
   DEFINE  l_fabq009              LIKE fabq_t.fabq009
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
      INPUT ARRAY g_fmcp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmcp_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt035_01_b_fill(g_wc2)
            LET g_detail_cnt = g_fmcp_d.getLength()
         
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
            DISPLAY g_fmcp_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_fmcp_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_fmcp_d[l_ac].fmcpdocno IS NOT NULL
               AND g_fmcp_d[l_ac].fmcpseq IS NOT NULL
               AND g_fmcp_d[l_ac].fmcpseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmcp_d_t.* = g_fmcp_d[l_ac].*  #BACKUP
               LET g_fmcp_d_o.* = g_fmcp_d[l_ac].*  #BACKUP
               IF NOT afmt035_01_lock_b("fmcp_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt035_01_bcl INTO g_fmcp_d[l_ac].fmcpdocno,g_fmcp_d[l_ac].fmcpseq,g_fmcp_d[l_ac].fmcpseq2, 
                      g_fmcp_d[l_ac].fmcp015,g_fmcp_d[l_ac].fmcp001,g_fmcp_d[l_ac].fmcp002,g_fmcp_d[l_ac].fmcp003, 
                      g_fmcp_d[l_ac].fmcp017,g_fmcp_d[l_ac].fmcp016,g_fmcp_d[l_ac].fmcp004,g_fmcp_d[l_ac].fmcp005, 
                      g_fmcp_d[l_ac].fmcp018,g_fmcp_d[l_ac].fmcp019,g_fmcp_d[l_ac].fmcp020,g_fmcp_d[l_ac].fmcp006, 
                      g_fmcp_d[l_ac].fmcp007,g_fmcp_d[l_ac].fmcp008,g_fmcp_d[l_ac].fmcp009,g_fmcp_d[l_ac].fmcp021, 
                      g_fmcp_d[l_ac].fmcp010,g_fmcp_d[l_ac].fmcp022,g_fmcp_d[l_ac].fmcp011,g_fmcp_d[l_ac].fmcp012, 
                      g_fmcp_d[l_ac].fmcp013,g_fmcp_d[l_ac].fmcp014
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcp_d_t.fmcpdocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmcp_d_mask_o[l_ac].* =  g_fmcp_d[l_ac].*
                  CALL afmt035_01_fmcp_t_mask()
                  LET g_fmcp_d_mask_n[l_ac].* =  g_fmcp_d[l_ac].*
                  
                  CALL afmt035_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL afmt035_01_set_entry_b(l_cmd)
            CALL afmt035_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CASE g_fmcj005
               WHEN '1' 
                  CALL cl_set_comp_entry("fmcp015",FALSE)
               WHEN '2' 
                  CALL cl_set_comp_entry("fmcp015",FALSE)
               WHEN '3' 
                  CALL cl_set_comp_entry("fmcp015",FALSE)
               WHEN '4' 
                  CALL cl_set_comp_entry("fmcp015",TRUE)
            END CASE
            CALL afmt035_01_fmcp015_entry()
            CALL afmt035_01_fmcp002_chk()
            CALL afmt035_01_fmcp003_entry()
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
            INITIALIZE g_fmcp_d_t.* TO NULL
            INITIALIZE g_fmcp_d_o.* TO NULL
            INITIALIZE g_fmcp_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_fmcp_d[l_ac].fmcpseq = "1"
      LET g_fmcp_d[l_ac].fmcpseq2 = "1"
      LET g_fmcp_d[l_ac].fmcp015 = "5"
      LET g_fmcp_d[l_ac].fmcp009 = "0"
      LET g_fmcp_d[l_ac].fmcp010 = "0"
      LET g_fmcp_d[l_ac].fmcp011 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_fmcp_d[l_ac].fmcpseq2 = ""
            CALL afmt035_01_fmcpseq_ref() RETURNING g_fmcp_d[l_ac].fmcpseq
            LET g_fmcp_d[l_ac].fmcp012 = "1"
            IF l_cmd = 'a' THEN
               LET g_fmcp_d[l_ac].fmcpdocno = g_fmcpdocno
               CALL afmt035_01_default_ref()
               IF cl_null(g_fmcp_d[l_ac].fmcpseq2) THEN
                  SELECT MAX(fmcpseq2) INTO g_fmcp_d[l_ac].fmcpseq2
                    FROM fmcp_t
                   WHERE fmcpent = g_enterprise
                     AND fmcpdocno = g_fmcpdocno
                     AND fmcpseq = g_fmcp_d[l_ac].fmcpseq
               
                  IF cl_null(g_fmcp_d[l_ac].fmcpseq2) THEN
                     LET g_fmcp_d[l_ac].fmcpseq2 = 1
                  ELSE
                     LET g_fmcp_d[l_ac].fmcpseq2 = g_fmcp_d[l_ac].fmcpseq2 + 1
                  END IF
               END IF
            END IF
            CALL afmt035_01_fmcp015_entry()
            #end add-point
            LET g_fmcp_d_t.* = g_fmcp_d[l_ac].*     #新輸入資料
            LET g_fmcp_d_o.* = g_fmcp_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmcp_d[li_reproduce_target].* = g_fmcp_d[li_reproduce].*
 
               LET g_fmcp_d[g_fmcp_d.getLength()].fmcpdocno = NULL
               LET g_fmcp_d[g_fmcp_d.getLength()].fmcpseq = NULL
               LET g_fmcp_d[g_fmcp_d.getLength()].fmcpseq2 = NULL
 
            END IF
            
 
            CALL afmt035_01_set_entry_b(l_cmd)
            CALL afmt035_01_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM fmcp_t 
             WHERE fmcpent = g_enterprise AND fmcpdocno = g_fmcp_d[l_ac].fmcpdocno
                                       AND fmcpseq = g_fmcp_d[l_ac].fmcpseq
                                       AND fmcpseq2 = g_fmcp_d[l_ac].fmcpseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcp_d[g_detail_idx].fmcpdocno
               LET gs_keys[2] = g_fmcp_d[g_detail_idx].fmcpseq
               LET gs_keys[3] = g_fmcp_d[g_detail_idx].fmcpseq2
               CALL afmt035_01_insert_b('fmcp_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmcp_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt035_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL s_transaction_end('Y','0')
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (fmcpdocno = '", g_fmcp_d[l_ac].fmcpdocno, "' "
                                  ," AND fmcpseq = '", g_fmcp_d[l_ac].fmcpseq, "' "
                                  ," AND fmcpseq2 = '", g_fmcp_d[l_ac].fmcpseq2, "' "
 
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
               
               DELETE FROM fmcp_t
                WHERE fmcpent = g_enterprise AND 
                      fmcpdocno = g_fmcp_d_t.fmcpdocno
                      AND fmcpseq = g_fmcp_d_t.fmcpseq
                      AND fmcpseq2 = g_fmcp_d_t.fmcpseq2
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmcp_t:",SQLERRMESSAGE 
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
                  CALL afmt035_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_fmcp_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE afmt035_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_fmcp_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcp_d_t.fmcpdocno
               LET gs_keys[2] = g_fmcp_d_t.fmcpseq
               LET gs_keys[3] = g_fmcp_d_t.fmcpseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt035_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL afmt035_01_delete_b('fmcp_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fmcp_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcpdocno
            #add-point:BEFORE FIELD fmcpdocno name="input.b.page1.fmcpdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcpdocno
            
            #add-point:AFTER FIELD fmcpdocno name="input.a.page1.fmcpdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcp_d[g_detail_idx].fmcpdocno IS NOT NULL AND g_fmcp_d[g_detail_idx].fmcpseq IS NOT NULL AND g_fmcp_d[g_detail_idx].fmcpseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcp_d[g_detail_idx].fmcpdocno != g_fmcp_d_t.fmcpdocno OR g_fmcp_d[g_detail_idx].fmcpseq != g_fmcp_d_t.fmcpseq OR g_fmcp_d[g_detail_idx].fmcpseq2 != g_fmcp_d_t.fmcpseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcp_t WHERE "||"fmcpent = '" ||g_enterprise|| "' AND "||"fmcpdocno = '"||g_fmcp_d[g_detail_idx].fmcpdocno ||"' AND "|| "fmcpseq = '"||g_fmcp_d[g_detail_idx].fmcpseq ||"' AND "|| "fmcpseq2 = '"||g_fmcp_d[g_detail_idx].fmcpseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcpdocno
            #add-point:ON CHANGE fmcpdocno name="input.g.page1.fmcpdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcpseq
            #add-point:BEFORE FIELD fmcpseq name="input.b.page1.fmcpseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcpseq
            
            #add-point:AFTER FIELD fmcpseq name="input.a.page1.fmcpseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcp_d[g_detail_idx].fmcpdocno IS NOT NULL AND g_fmcp_d[g_detail_idx].fmcpseq IS NOT NULL AND g_fmcp_d[g_detail_idx].fmcpseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcp_d[g_detail_idx].fmcpdocno != g_fmcp_d_t.fmcpdocno OR g_fmcp_d[g_detail_idx].fmcpseq != g_fmcp_d_t.fmcpseq OR g_fmcp_d[g_detail_idx].fmcpseq2 != g_fmcp_d_t.fmcpseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcp_t WHERE "||"fmcpent = '" ||g_enterprise|| "' AND "||"fmcpdocno = '"||g_fmcp_d[g_detail_idx].fmcpdocno ||"' AND "|| "fmcpseq = '"||g_fmcp_d[g_detail_idx].fmcpseq ||"' AND "|| "fmcpseq2 = '"||g_fmcp_d[g_detail_idx].fmcpseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM fmck_t
                WHERE fmckent = g_enterprise AND fmckdocno = g_fmcpdocno
                  AND fmckseq = g_fmcp_d[g_detail_idx].fmcpseq 
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmcp_d[g_detail_idx].fmcpseq
                  LET g_errparam.code   = 'afm-00164'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcpseq
            #add-point:ON CHANGE fmcpseq name="input.g.page1.fmcpseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcpseq2
            #add-point:BEFORE FIELD fmcpseq2 name="input.b.page1.fmcpseq2"
            IF cl_null(g_fmcp_d[l_ac].fmcpseq2) THEN
               SELECT MAX(fmcpseq2) INTO g_fmcp_d[l_ac].fmcpseq2
                 FROM fmcp_t
                WHERE fmcpent = g_enterprise
                  AND fmcpdocno = g_fmcpdocno
                  AND fmcpseq = g_fmcp_d[l_ac].fmcpseq
            
               IF cl_null(g_fmcp_d[l_ac].fmcpseq2) THEN
                  LET g_fmcp_d[l_ac].fmcpseq2 = 1
               ELSE
                  LET g_fmcp_d[l_ac].fmcpseq2 = g_fmcp_d[l_ac].fmcpseq2 + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcpseq2
            
            #add-point:AFTER FIELD fmcpseq2 name="input.a.page1.fmcpseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmcp_d[g_detail_idx].fmcpdocno IS NOT NULL AND g_fmcp_d[g_detail_idx].fmcpseq IS NOT NULL AND g_fmcp_d[g_detail_idx].fmcpseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcp_d[g_detail_idx].fmcpdocno != g_fmcp_d_t.fmcpdocno OR g_fmcp_d[g_detail_idx].fmcpseq != g_fmcp_d_t.fmcpseq OR g_fmcp_d[g_detail_idx].fmcpseq2 != g_fmcp_d_t.fmcpseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcp_t WHERE "||"fmcpent = '" ||g_enterprise|| "' AND "||"fmcpdocno = '"||g_fmcp_d[g_detail_idx].fmcpdocno ||"' AND "|| "fmcpseq = '"||g_fmcp_d[g_detail_idx].fmcpseq ||"' AND "|| "fmcpseq2 = '"||g_fmcp_d[g_detail_idx].fmcpseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcpseq2
            #add-point:ON CHANGE fmcpseq2 name="input.g.page1.fmcpseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp015
            #add-point:BEFORE FIELD fmcp015 name="input.b.page1.fmcp015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp015
            
            #add-point:AFTER FIELD fmcp015 name="input.a.page1.fmcp015"
            IF  g_fmcp_d[g_detail_idx].fmcp015 THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmcp_d_t.fmcp015 IS NULL OR g_fmcp_d[g_detail_idx].fmcp015 != g_fmcp_d_t.fmcp015)) THEN 
                  LET g_fmcp_d[l_ac].fmcp003 = ''
                  LET g_fmcp_d[l_ac].fmcp003_desc = ""
               END IF
            END IF
            CALL afmt035_01_fmcp015_entry()
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp015
            #add-point:ON CHANGE fmcp015 name="input.g.page1.fmcp015"
            CALL afmt035_01_fmcp015_entry()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp001
            #add-point:BEFORE FIELD fmcp001 name="input.b.page1.fmcp001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp001
            
            #add-point:AFTER FIELD fmcp001 name="input.a.page1.fmcp001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp001
            #add-point:ON CHANGE fmcp001 name="input.g.page1.fmcp001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp002
            
            #add-point:AFTER FIELD fmcp002 name="input.a.page1.fmcp002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcp_d[l_ac].fmcp002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcp_d[l_ac].fmcp002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcp_d[l_ac].fmcp002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp002
            #add-point:BEFORE FIELD fmcp002 name="input.b.page1.fmcp002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp002
            #add-point:ON CHANGE fmcp002 name="input.g.page1.fmcp002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp003
            
            #add-point:AFTER FIELD fmcp003 name="input.a.page1.fmcp003"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp003) THEN
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '8862'
               LET g_chkparam.arg2 = g_fmcp_d[l_ac].fmcp003

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_gzcb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
                  LET g_errno = ''
                  CASE
                     WHEN g_fmcp_d[l_ac].fmcp015 = '1'
                        LET g_fmcp_d[l_ac].fmcp003 = ''
                     LET g_fmcp_d[l_ac].fmcp003_desc = ""
                     WHEN g_fmcp_d[l_ac].fmcp015 = '2'
                        CALL cl_set_combo_scc_part('fmcp003','8862','1,2')
                         IF g_fmcp_d[l_ac].fmcp003 MATCHES '[ABCD]' THEN LET g_errno = 'afm-00250'  END IF
                     WHEN g_fmcp_d[l_ac].fmcp015 = '3'
                        CALL cl_set_combo_scc_part('fmcp003','8862','A,B,C,D')
                        CALL cl_set_combo_scc_part('fmcp003','8862','1,2')
                         IF g_fmcp_d[l_ac].fmcp003 MATCHES '[12]' THEN LET g_errno = 'afm-00251' END IF
                  END CASE
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcp_d[l_ac].fmcp003
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fmcp_d[l_ac].fmcp003 = g_fmcp_d_t.fmcp003
                     LET g_fmcp_d[l_ac].fmcp003_desc = ""
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_fmcp_d[l_ac].fmcp003 = g_fmcp_d_t.fmcp003
                  LET g_fmcp_d[l_ac].fmcp003_desc = ""
                  NEXT FIELD CURRENT
               END IF
               SELECT gzcbl004 INTO g_fmcp_d[l_ac].fmcp003_desc FROM gzcbl_t
                WHERE gzcbl001 = '8862'
                  AND gzcbl002 = g_fmcp_d[l_ac].fmcp003 AND gzcbl003 = g_dlang
            END IF
            CALL afmt035_01_fmcp003_entry()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp003
            #add-point:BEFORE FIELD fmcp003 name="input.b.page1.fmcp003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp003
            #add-point:ON CHANGE fmcp003 name="input.g.page1.fmcp003"
            CALL afmt035_01_fmcp003_entry()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp017
            #add-point:BEFORE FIELD fmcp017 name="input.b.page1.fmcp017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp017
            
            #add-point:AFTER FIELD fmcp017 name="input.a.page1.fmcp017"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp004) AND NOT cl_null(g_fmcp_d[l_ac].fmcp017) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
               #当担保人存在于组织档
               IF l_n > 0 THEN
                  #抵押物性质=1.资产
                  IF g_fmcp_d[l_ac].fmcp003 = '2' THEN
                     #欄位存在檢查
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                  
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fmcp_d[l_ac].fmcp004
                     LET g_chkparam.arg2 = g_fmcp_d[l_ac].fmcp005
                     LET g_chkparam.arg3 = g_fmcp_d[l_ac].fmcp016
                     LET g_chkparam.arg4 = g_fmcp_d[l_ac].fmcp017
                     #160318-00025#6--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                     #160318-00025#6--add--end
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_faah003_5") THEN
                        #檢查成功時後續處理
                        IF cl_null(g_fmcp_d[l_ac].fmcp005) THEN
                           SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND trim(faah004) IS NULL
                        ELSE
                           SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND faah004 = g_fmcp_d[l_ac].fmcp005
                        END IF
                        IF g_fmcp_d[l_ac].fmcp002 <> l_faah028 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'afa-00473'
                           LET g_errparam.extend = g_fmcp_d[l_ac].fmcp004||g_fmcp_d[l_ac].fmcp005||g_fmcp_d[l_ac].fmcp016||g_fmcp_d[l_ac].fmcp017
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        #檢查失敗時後續處理
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp017
            #add-point:ON CHANGE fmcp017 name="input.g.page1.fmcp017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp016
            #add-point:BEFORE FIELD fmcp016 name="input.b.page1.fmcp016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp016
            
            #add-point:AFTER FIELD fmcp016 name="input.a.page1.fmcp016"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp004) AND NOT cl_null(g_fmcp_d[l_ac].fmcp016) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
               #当担保人存在于组织档
               IF l_n > 0 THEN
                  #抵押物性质=1.资产
                  IF g_fmcp_d[l_ac].fmcp003 = '2' THEN
                     #欄位存在檢查
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                  
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fmcp_d[l_ac].fmcp004
                     LET g_chkparam.arg2 = g_fmcp_d[l_ac].fmcp005
                     LET g_chkparam.arg3 = g_fmcp_d[l_ac].fmcp016
                     LET g_chkparam.arg4 = g_fmcp_d[l_ac].fmcp017
                     #160318-00025#6--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                     #160318-00025#6--add--end
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_faah003_5") THEN
                        #檢查成功時後續處理
                        IF cl_null(g_fmcp_d[l_ac].fmcp005) THEN
                           SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND trim(faah004) IS NULL
                        ELSE
                           SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND faah004 = g_fmcp_d[l_ac].fmcp005
                        END IF
                        IF g_fmcp_d[l_ac].fmcp002 <> l_faah028 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'afa-00473'
                           LET g_errparam.extend = g_fmcp_d[l_ac].fmcp004||g_fmcp_d[l_ac].fmcp005||g_fmcp_d[l_ac].fmcp016||g_fmcp_d[l_ac].fmcp017
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        #檢查失敗時後續處理
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp016
            #add-point:ON CHANGE fmcp016 name="input.g.page1.fmcp016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp004
            #add-point:BEFORE FIELD fmcp004 name="input.b.page1.fmcp004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp004
            
            #add-point:AFTER FIELD fmcp004 name="input.a.page1.fmcp004"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp004) THEN
               CALL cl_set_comp_entry("fmcp006",TRUE)
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
               #当担保人存在于组织档
               IF l_n > 0 THEN
                  CALL cl_set_comp_entry("fmcp006",FALSE)
                  IF g_fmcp_d[l_ac].fmcp004 <> g_fmcp_d_t.fmcp004 THEN
                     #抵押物性质=1.原料
                     IF g_fmcp_d[l_ac].fmcp003 = '1' THEN
                        SELECT imag014 INTO g_fmcp_d[l_ac].fmcp006 FROM imag_t
                         WHERE imagent = g_enterprise AND imagsite = g_fmcjsite
                           AND imag001 = g_fmcp_d[l_ac].fmcp004
                        
                        #数量，金额
                        CALL afmt035_01_fmcp004_ref() RETURNING l_xccc901,l_xccc902
                        LET g_fmcp_d[l_ac].fmcp009 = l_xccc901
                        LET g_fmcp_d[l_ac].fmcp010 = l_xccc902/l_xccc901 * g_fmcp_d[l_ac].fmcp009
                     END IF    
                  END IF
                  #抵押物性质=2.资产
                  IF g_fmcp_d[l_ac].fmcp003 = '2' THEN
                     #欄位存在檢查
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                  
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fmcp_d[l_ac].fmcp004
                     LET g_chkparam.arg2 = g_fmcp_d[l_ac].fmcp005
                     LET g_chkparam.arg3 = g_fmcp_d[l_ac].fmcp016
                     LET g_chkparam.arg4 = g_fmcp_d[l_ac].fmcp017
                     #160318-00025#6--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                     #160318-00025#6--add--end
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_faah003_5") THEN
                        #檢查成功時後續處理
                        IF g_fmcp_d[l_ac].fmcp004 <> g_fmcp_d_t.fmcp004 THEN
                           IF cl_null(g_fmcp_d[l_ac].fmcp005) THEN
                              SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND trim(faah004) IS NULL
                        ELSE
                           SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND faah004 = g_fmcp_d[l_ac].fmcp005
                        END IF
                        IF g_fmcp_d[l_ac].fmcp002 <> l_faah028 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'afa-00473'
                           LET g_errparam.extend = g_fmcp_d[l_ac].fmcp004||g_fmcp_d[l_ac].fmcp005||g_fmcp_d[l_ac].fmcp016||g_fmcp_d[l_ac].fmcp017
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           NEXT FIELD CURRENT
                        END IF
                           #单位原有账面价值
                           LET l_fmcp010 = l_faaj016 - l_faaj017 - l_faaj021 / l_faah018
                           IF NOT cl_null(g_fmcp_d[l_ac].fmcp009) THEN
                              LET g_fmcp_d[l_ac].fmcp010 = g_fmcp_d[l_ac].fmcp009 * l_fmcp010
                           END IF
                        END IF
                     ELSE
                        #檢查失敗時後續處理
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp004
            #add-point:ON CHANGE fmcp004 name="input.g.page1.fmcp004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp005
            #add-point:BEFORE FIELD fmcp005 name="input.b.page1.fmcp005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp005
            
            #add-point:AFTER FIELD fmcp005 name="input.a.page1.fmcp005"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp005) AND NOT cl_null(g_fmcp_d[l_ac].fmcp004) AND NOT cl_null(g_fmcp_d[l_ac].fmcp016) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
               #当担保人存在于组织档
               IF l_n > 0 THEN
                  #抵押物性质=1.资产
                  IF g_fmcp_d[l_ac].fmcp003 = '2' THEN
                     #欄位存在檢查
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                  
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fmcp_d[l_ac].fmcp004
                     LET g_chkparam.arg2 = g_fmcp_d[l_ac].fmcp005
                     LET g_chkparam.arg3 = g_fmcp_d[l_ac].fmcp016
                     LET g_chkparam.arg4 = g_fmcp_d[l_ac].fmcp017
                     #160318-00025#6--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                     #160318-00025#6--add--end
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_faah003_5") THEN
                        #檢查成功時後續處理
                        IF cl_null(g_fmcp_d[l_ac].fmcp005) THEN
                           SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND trim(faah004) IS NULL
                        ELSE
                           SELECT faah004,faah017,faah018,faah028,faaj016,faaj017,faaj021 
                             INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faah028,l_faaj016,l_faaj017,l_faaj021
                             FROM faah_t,faaj_t
                            WHERE faahent = faajent AND faah003 = faaj001
                              AND faah004 = faaj002 AND faahent = g_enterprise 
                              AND faajld = g_glaald 
                              AND faah001 = g_fmcp_d[l_ac].fmcp016
                              AND faah003 = g_fmcp_d[l_ac].fmcp004
                              AND faah004 = g_fmcp_d[l_ac].fmcp005
                        END IF
                        IF g_fmcp_d[l_ac].fmcp002 <> l_faah028 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'afa-00473'
                           LET g_errparam.extend = g_fmcp_d[l_ac].fmcp004||g_fmcp_d[l_ac].fmcp005||g_fmcp_d[l_ac].fmcp016||g_fmcp_d[l_ac].fmcp017
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        #檢查失敗時後續處理
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp005
            #add-point:ON CHANGE fmcp005 name="input.g.page1.fmcp005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp018
            #add-point:BEFORE FIELD fmcp018 name="input.b.page1.fmcp018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp018
            
            #add-point:AFTER FIELD fmcp018 name="input.a.page1.fmcp018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp018
            #add-point:ON CHANGE fmcp018 name="input.g.page1.fmcp018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp019
            #add-point:BEFORE FIELD fmcp019 name="input.b.page1.fmcp019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp019
            
            #add-point:AFTER FIELD fmcp019 name="input.a.page1.fmcp019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp019
            #add-point:ON CHANGE fmcp019 name="input.g.page1.fmcp019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp020
            #add-point:BEFORE FIELD fmcp020 name="input.b.page1.fmcp020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp020
            
            #add-point:AFTER FIELD fmcp020 name="input.a.page1.fmcp020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp020
            #add-point:ON CHANGE fmcp020 name="input.g.page1.fmcp020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp006
            #add-point:BEFORE FIELD fmcp006 name="input.b.page1.fmcp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp006
            
            #add-point:AFTER FIELD fmcp006 name="input.a.page1.fmcp006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp006
            #add-point:ON CHANGE fmcp006 name="input.g.page1.fmcp006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp007
            #add-point:BEFORE FIELD fmcp007 name="input.b.page1.fmcp007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp007
            
            #add-point:AFTER FIELD fmcp007 name="input.a.page1.fmcp007"
            IF g_fmcp_d[l_ac].fmcp003 = 'A' THEN
               IF NOT cl_null(g_fmcp_d[l_ac].fmcp007) THEN
                  LET g_errno = ''
                  SELECT nmbastus INTO l_nmbastus FROM nmba_t
                   WHERE nmbaent = g_enterprie AND nmbadocno = g_fmcp_d[l_ac].fmcp007
                     AND nmba003 = 'anmt310'
                  CASE
                     WHEN SQLCA.SQLCODE = 100 LET g_errno = 'afm-00170'
                     WHEN l_nmbastus <> 'Y' LET g_errno = 'sub-01313' #'afm-00171'  #160318-00005#12 mod
                  END CASE
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcp_d[l_ac].fmcp007
                     LET g_errparam.code   = g_errno
                     #160318-00005#12   --add--str
                     LET g_errparam.replace[1] ='anmt510'
                     LET g_errparam.replace[2] = cl_get_progname('anmt510',g_lang,"2")
                     LET g_errparam.exeprog    ='anmt510'
                     #160318-00005#12  --add--end
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp007
            #add-point:ON CHANGE fmcp007 name="input.g.page1.fmcp007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp008
            #add-point:BEFORE FIELD fmcp008 name="input.b.page1.fmcp008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp008
            
            #add-point:AFTER FIELD fmcp008 name="input.a.page1.fmcp008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp008
            #add-point:ON CHANGE fmcp008 name="input.g.page1.fmcp008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmcp_d[l_ac].fmcp009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmcp009
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcp009 name="input.a.page1.fmcp009"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp009) THEN 
               IF g_fmcp_d[l_ac].fmcp003 = '1' THEN
                  #数量，金额
                  CALL afmt035_01_fmcp004_ref() RETURNING l_xccc901,l_xccc902
                  LET l_fmcp009_sum = 0 
                  SELECT SUM(fmcp009) INTO l_fmcp009_sum FROM fmcp_t
                   WHERE fmcpent = g_enterprise 
                     AND fmcp004 = g_fmcp_d[l_ac].fmcp004
                     AND fmcp018 = g_fmcp_d[l_ac].fmcp018
                     AND fmcp019 = g_fmcp_d[l_ac].fmcp019
                     AND fmcp020 = g_fmcp_d[l_ac].fmcp020
                     AND fmcp002 = (SELECT glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glaald)
                  IF cl_null(l_fmcp009_sum) THEN LET l_fmcp009_sum = 0 END IF
                  IF cl_null(g_fmcp_d_t.fmcp009) THEN LET g_fmcp_d_t.fmcp009 = 0 END IF
                  IF (l_cmd = 'a' AND l_fmcp009_sum + g_fmcp_d[l_ac].fmcp009 > l_xccc901) OR
                     (l_cmd = 'u' AND l_fmcp009_sum + g_fmcp_d[l_ac].fmcp009 - g_fmcp_d_t.fmcp009 > l_xccc901) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcp_d[l_ac].fmcp009
                     LET g_errparam.code   = 'afm-00244'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  LET g_fmcp_d[l_ac].fmcp010 = l_xccc902/l_xccc901 * g_fmcp_d[l_ac].fmcp009
               END IF
               IF g_fmcp_d[l_ac].fmcp003 = '2' THEN
                  IF cl_null(g_fmcp_d[l_ac].fmcp005) THEN
                     SELECT faah004,faah017,faah018,faaj016,faaj017,faaj021 
                       INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faaj016,l_faaj017,l_faaj021
                       FROM faah_t,faaj_t
                      WHERE faahent = faajent AND faah003 = faaj001
                        AND faah004 = faaj002 AND faahent = g_enterprise 
                        AND faajld = g_glaald
                        AND faah001 = g_fmcp_d[l_ac].fmcp016
                        AND faah003 = g_fmcp_d[l_ac].fmcp004
                        AND trim(faah004) IS NULL
                  ELSE
                     SELECT faah004,faah017,faah018,faaj016,faaj017,faaj021 
                       INTO g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp006,l_faah018,l_faaj016,l_faaj017,l_faaj021
                       FROM faah_t,faaj_t
                      WHERE faahent = faajent AND faah003 = faaj001
                        AND faah004 = faaj002 AND faahent = g_enterprise 
                        AND faajld = g_glaald
                        AND faah001 = g_fmcp_d[l_ac].fmcp016
                        AND faah003 = g_fmcp_d[l_ac].fmcp004
                        AND faah004 = g_fmcp_d[l_ac].fmcp005
                  END IF
                  LET l_fmcp009_sum = 0 
                  SELECT SUM(fmcp009) INTO l_fmcp009_sum FROM fmcp_t
                   WHERE fmcpent = g_enterprise 
                     AND fmcp004 = g_fmcp_d[l_ac].fmcp004
                     AND fmcp005 = g_fmcp_d[l_ac].fmcp005
                     AND fmcp016 = g_fmcp_d[l_ac].fmcp016
                  IF cl_null(l_fmcp009_sum) THEN LET l_fmcp009_sum = 0 END IF
                  
                  #160324-00005#1 add--str
                  #已抵押资产数量
                  SELECT SUM(fabq009) INTO l_fabq009
                    FROM faba_t,fabq_t
                   WHERE fabqent = fabaent
                     AND fabadocno = fabqdocno
                     AND fabqent = g_enterprise
                     AND faba003 = '28' #抵押    
                     AND fabq005 = g_fmcp_d[l_ac].fmcp004 #财产编号
                     AND fabq006 = g_fmcp_d[l_ac].fmcp005 #附号
                     AND fabq007 = g_fmcp_d[l_ac].fmcp016 #卡片编号
                     AND fabastus <> 'X'
                     AND fabq018 = 2     #已抵押状态
                  IF cl_null(l_fabq009) THEN LET l_fabq009 = 0 END IF   
                  #160324-00005#1 add--end
                  
                  IF cl_null(g_fmcp_d_t.fmcp009) THEN LET g_fmcp_d_t.fmcp009 = 0 END IF
                  IF (l_cmd = 'a' AND l_fmcp009_sum + g_fmcp_d[l_ac].fmcp009 + l_fabq009 > l_faah018) OR                        #160324-00005#1 add + l_fabq009
                     (l_cmd = 'u' AND l_fmcp009_sum + g_fmcp_d[l_ac].fmcp009 + l_fabq009 - g_fmcp_d_t.fmcp009 > l_faah018) THEN #160324-00005#1 add + l_fabq009
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcp_d[l_ac].fmcp009
                     #LET g_errparam.code   = 'afm-00176' #160324-00005#1 mark
                     LET g_errparam.code   = 'afm-00253'  #160324-00005#1 add
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #单位原有账面价值
                  LET l_fmcp010 = l_faaj016 - l_faaj017 - l_faaj021 / l_faah018
                  IF NOT cl_null(g_fmcp_d[l_ac].fmcp009) THEN
                     LET g_fmcp_d[l_ac].fmcp010 = g_fmcp_d[l_ac].fmcp009 * l_fmcp010
                  END IF
               END IF
               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp009
            #add-point:BEFORE FIELD fmcp009 name="input.b.page1.fmcp009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp009
            #add-point:ON CHANGE fmcp009 name="input.g.page1.fmcp009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp021
            
            #add-point:AFTER FIELD fmcp021 name="input.a.page1.fmcp021"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp021) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa026  #160322-00036#1#1 add
               LET g_chkparam.arg2 = g_fmcp_d[l_ac].fmcp021
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_fmcp_d[l_ac].fmcp021
               CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_fmcp_d[l_ac].fmcp021_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_fmcp_d[l_ac].fmcp021_desc

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp021
            #add-point:BEFORE FIELD fmcp021 name="input.b.page1.fmcp021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp021
            #add-point:ON CHANGE fmcp021 name="input.g.page1.fmcp021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmcp_d[l_ac].fmcp010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmcp010
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcp010 name="input.a.page1.fmcp010"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp010) THEN 
               CALL afmt035_01_fmcp002_chk()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp010
            #add-point:BEFORE FIELD fmcp010 name="input.b.page1.fmcp010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp010
            #add-point:ON CHANGE fmcp010 name="input.g.page1.fmcp010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp022
            
            #add-point:AFTER FIELD fmcp022 name="input.a.page1.fmcp022"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp022) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa026   #160322-00036#1#1 add
               LET g_chkparam.arg2 = g_fmcp_d[l_ac].fmcp022
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_fmcp_d[l_ac].fmcp022
               CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_fmcp_d[l_ac].fmcp022_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_fmcp_d[l_ac].fmcp022_desc

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp022
            #add-point:BEFORE FIELD fmcp022 name="input.b.page1.fmcp022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp022
            #add-point:ON CHANGE fmcp022 name="input.g.page1.fmcp022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmcp_d[l_ac].fmcp011,"0","0","","","azz-00079",1) THEN
               NEXT FIELD fmcp011
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcp011 name="input.a.page1.fmcp011"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp011) THEN 

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp011
            #add-point:BEFORE FIELD fmcp011 name="input.b.page1.fmcp011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp011
            #add-point:ON CHANGE fmcp011 name="input.g.page1.fmcp011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp012
            #add-point:BEFORE FIELD fmcp012 name="input.b.page1.fmcp012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp012
            
            #add-point:AFTER FIELD fmcp012 name="input.a.page1.fmcp012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp012
            #add-point:ON CHANGE fmcp012 name="input.g.page1.fmcp012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp013
            #add-point:BEFORE FIELD fmcp013 name="input.b.page1.fmcp013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp013
            
            #add-point:AFTER FIELD fmcp013 name="input.a.page1.fmcp013"
            IF NOT cl_null(g_fmcp_d[l_ac].fmcp013) THEN 
               LET g_errno = ''
               SELECT inbdstus,inbdsite INTO l_inbdstus,l_inbdsite FROM inbd_t
                WHERE inbdent = g_enterprie AND inbddocno = g_fmcp_d[l_ac].fmcp013
               CASE
                  WHEN SQLCA.SQLCODE = 100 LET g_errno = 'afm-00173'
                  WHEN l_inbdstus <> 'Y' LET g_errno =  'sub-01313'  #'afm-00174' #160318-00005#12 mod 
                  WHEN l_inbdsite <> g_fmcjsite LET g_errno = 'afm-00175'
               END CASE
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =g_fmcp_d[l_ac].fmcp013
                  LET g_errparam.code   = g_errno
                  #160318-00005#12   --add--str
                  LET g_errparam.replace[1] ='aint160'
                  LET g_errparam.replace[2] = cl_get_progname('aint160',g_lang,"2")
                  LET g_errparam.exeprog    ='aint160'
                  #160318-00005#12  --add--end
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #若已取消留置，报错
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM inbd_t
                WHERE inbdent = g_enterprise AND inbd004 = g_fmcp_d[l_ac].fmcp013

               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =g_fmcp_d[l_ac].fmcp013
                  LET g_errparam.code   = 'afm-00172'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp013
            #add-point:ON CHANGE fmcp013 name="input.g.page1.fmcp013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcp014
            #add-point:BEFORE FIELD fmcp014 name="input.b.page1.fmcp014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcp014
            
            #add-point:AFTER FIELD fmcp014 name="input.a.page1.fmcp014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcp014
            #add-point:ON CHANGE fmcp014 name="input.g.page1.fmcp014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmcpdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcpdocno
            #add-point:ON ACTION controlp INFIELD fmcpdocno name="input.c.page1.fmcpdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcpseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcpseq
            #add-point:ON ACTION controlp INFIELD fmcpseq name="input.c.page1.fmcpseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcpseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcpseq2
            #add-point:ON ACTION controlp INFIELD fmcpseq2 name="input.c.page1.fmcpseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp015
            #add-point:ON ACTION controlp INFIELD fmcp015 name="input.c.page1.fmcp015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp001
            #add-point:ON ACTION controlp INFIELD fmcp001 name="input.c.page1.fmcp001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp002
            #add-point:ON ACTION controlp INFIELD fmcp002 name="input.c.page1.fmcp002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp002             #給予default值
            LET g_qryparam.default2 = "" #g_fmcj_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp002 = g_qryparam.return1              
            #LET g_fmcj_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmcp_d[l_ac].fmcp002 TO fmcp002    
            NEXT FIELD fmcp002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp003
            #add-point:ON ACTION controlp INFIELD fmcp003 name="input.c.page1.fmcp003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "8862" #
            CASE g_fmcp_d[l_ac].fmcp015 
               WHEN '2' LET g_qryparam.where = " gzcb002 IN('1','2')"
               WHEN '3' LET g_qryparam.where = " gzcb002 IN('A','B','C','D')"
            END CASE


            CALL q_gzcb002_01()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp003 = g_qryparam.return1      
            LET g_fmcp_d[l_ac].fmcp003_desc = g_qryparam.return2
            DISPLAY g_fmcp_d[l_ac].fmcp003 TO fmcp003    
            NEXT FIELD fmcp003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp017
            #add-point:ON ACTION controlp INFIELD fmcp017 name="input.c.page1.fmcp017"
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
            #当担保人存在于组织档
            IF l_n > 0 THEN
            #開窗i段
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp004             #給予default值
            LET g_qryparam.default2 = g_fmcp_d[l_ac].fmcp005      
            LET g_qryparam.default3 = g_fmcp_d[l_ac].fmcp016    
            LET g_qryparam.default4 = g_fmcp_d[l_ac].fmcp017
            LET g_qryparam.where = " faah028 = '",g_fmcp_d[l_ac].fmcp002,"' AND faah037<>'4'"

            #給予arg

            CALL q_faah003_10()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp004 = g_qryparam.return1              #财产编号
            LET g_fmcp_d[l_ac].fmcp005 = g_qryparam.return2 #附号
            LET g_fmcp_d[l_ac].fmcp016 = g_qryparam.return3 #卡片编号
            LET g_fmcp_d[l_ac].fmcp017 = g_qryparam.return4 #生成批号
            
            LET g_qryparam.where = NULL

            NEXT FIELD fmcp017                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp016
            #add-point:ON ACTION controlp INFIELD fmcp016 name="input.c.page1.fmcp016"
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
            #当担保人存在于组织档
            IF l_n > 0 THEN
            #開窗i段
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp004             #給予default值
            LET g_qryparam.default2 = g_fmcp_d[l_ac].fmcp005      
            LET g_qryparam.default3 = g_fmcp_d[l_ac].fmcp016    
            LET g_qryparam.default4 = g_fmcp_d[l_ac].fmcp017
            LET g_qryparam.where = " faah028 = '",g_fmcp_d[l_ac].fmcp002,"' AND faah037<>'4'"

            #給予arg

            CALL q_faah003_10()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp004 = g_qryparam.return1              #财产编号
            LET g_fmcp_d[l_ac].fmcp005 = g_qryparam.return2 #附号
            LET g_fmcp_d[l_ac].fmcp016 = g_qryparam.return3 #卡片编号
            LET g_fmcp_d[l_ac].fmcp017 = g_qryparam.return4 #生成批号
            
            LET g_qryparam.where = NULL

            NEXT FIELD fmcp016                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp004
            #add-point:ON ACTION controlp INFIELD fmcp004 name="input.c.page1.fmcp004"
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
            #当担保人存在于组织档
            IF l_n > 0 THEN
            #開窗i段
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE
                        
            IF g_fmcp_d[l_ac].fmcp003 = '2' THEN

               LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp004             #給予default值
               LET g_qryparam.default2 = g_fmcp_d[l_ac].fmcp005      
               LET g_qryparam.default3 = g_fmcp_d[l_ac].fmcp016    
               LET g_qryparam.default4 = g_fmcp_d[l_ac].fmcp017
               LET g_qryparam.where = " faah028 = '",g_fmcp_d[l_ac].fmcp002,"' AND faah037<>'4'"
               
               
               #給予arg
               
               CALL q_faah003_10()                                #呼叫開窗
               
               LET g_fmcp_d[l_ac].fmcp004 = g_qryparam.return1              #财产编号
               LET g_fmcp_d[l_ac].fmcp005 = g_qryparam.return2 #附号
               LET g_fmcp_d[l_ac].fmcp016 = g_qryparam.return3 #卡片编号
               LET g_fmcp_d[l_ac].fmcp017 = g_qryparam.return4 #生成批号
            END IF
            
            IF g_fmcp_d[l_ac].fmcp003 = '1' THEN
               LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp004             #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = "" #
               
               
               CALL q_xccc006()                                #呼叫開窗
               LET g_fmcp_d[l_ac].fmcp004 = g_qryparam.return1
            END IF

            
            LET g_qryparam.where = NULL

            NEXT FIELD fmcp004                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp005
            #add-point:ON ACTION controlp INFIELD fmcp005 name="input.c.page1.fmcp005"
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
            #当担保人存在于组织档
            IF l_n > 0 THEN
            #開窗i段
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp004             #給予default值
            LET g_qryparam.default2 = g_fmcp_d[l_ac].fmcp005      
            LET g_qryparam.default3 = g_fmcp_d[l_ac].fmcp016    
            LET g_qryparam.default4 = g_fmcp_d[l_ac].fmcp017
            LET g_qryparam.where = " faah028 = '",g_fmcp_d[l_ac].fmcp002,"' AND faah037<>'4'"

            #給予arg

            CALL q_faah003_10()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp004 = g_qryparam.return1              #财产编号
            LET g_fmcp_d[l_ac].fmcp005 = g_qryparam.return2 #附号
            LET g_fmcp_d[l_ac].fmcp016 = g_qryparam.return3 #卡片编号
            LET g_fmcp_d[l_ac].fmcp017 = g_qryparam.return4 #生成批号
            
            LET g_qryparam.where = NULL

            NEXT FIELD fmcp005                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp018
            #add-point:ON ACTION controlp INFIELD fmcp018 name="input.c.page1.fmcp018"
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
            #当担保人存在于组织档
            IF l_n > 0 THEN
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_xcbf001()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp018 = g_qryparam.return1

            DISPLAY g_fmcp_d[l_ac].fmcp018 TO fmcp018              #

            NEXT FIELD fmcp018                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp019
            #add-point:ON ACTION controlp INFIELD fmcp019 name="input.c.page1.fmcp019"
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
            #当担保人存在于组织档
            IF l_n > 0 THEN
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_bmaa002_1()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp019 = g_qryparam.return1

            DISPLAY g_fmcp_d[l_ac].fmcp019 TO fmcp019              #

            NEXT FIELD fmcp019                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp020
            #add-point:ON ACTION controlp INFIELD fmcp020 name="input.c.page1.fmcp020"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp006
            #add-point:ON ACTION controlp INFIELD fmcp006 name="input.c.page1.fmcp006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp007
            #add-point:ON ACTION controlp INFIELD fmcp007 name="input.c.page1.fmcp007"
            #仅当抵押质押物性质=A.银行票据才可以开创
            IF g_fmcp_d[l_ac].fmcp003 = 'A' THEN
               #應用 a07 樣板自動產生(Version:2)   
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp007             #給予default值
               #給予arg
               LET g_qryparam.arg1 = "" #
               LET g_qryparam.where = " nmba003 = 'anmt510' AND nmbasite = '",g_fmcjsite,"'"
               
               CALL q_nmbadocno()                                #呼叫開窗
               
               LET g_fmcp_d[l_ac].fmcp007 = g_qryparam.return1      
               LET g_qryparam.where = " "
               DISPLAY g_fmcp_d[l_ac].fmcp007 TO fmcp007    
               NEXT FIELD fmcp007                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp008
            #add-point:ON ACTION controlp INFIELD fmcp008 name="input.c.page1.fmcp008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp009
            #add-point:ON ACTION controlp INFIELD fmcp009 name="input.c.page1.fmcp009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp021
            #add-point:ON ACTION controlp INFIELD fmcp021 name="input.c.page1.fmcp021"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " ooaj001='",g_glaa026,"' "    #160322-00036#1#1 add

 
            CALL q_ooaj002()                                #呼叫開窗
 
            LET g_fmcp_d[l_ac].fmcp021 = g_qryparam.return1              

            DISPLAY g_fmcp_d[l_ac].fmcp021 TO fmcp021              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcp_d[l_ac].fmcp021
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcp_d[l_ac].fmcp021_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcp_d[l_ac].fmcp021_desc
            LET g_qryparam.where = " "

            NEXT FIELD fmcp021                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp010
            #add-point:ON ACTION controlp INFIELD fmcp010 name="input.c.page1.fmcp010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp022
            #add-point:ON ACTION controlp INFIELD fmcp022 name="input.c.page1.fmcp022"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " ooaj001='",g_glaa026,"' "  #160322-00036#1#1 add

 
            CALL q_ooaj002()                                #呼叫開窗
 
            LET g_fmcp_d[l_ac].fmcp022 = g_qryparam.return1              

            DISPLAY g_fmcp_d[l_ac].fmcp022 TO fmcp022              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcp_d[l_ac].fmcp022
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcp_d[l_ac].fmcp022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcp_d[l_ac].fmcp022_desc
            LET g_qryparam.where = ""

            NEXT FIELD fmcp022                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp011
            #add-point:ON ACTION controlp INFIELD fmcp011 name="input.c.page1.fmcp011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp012
            #add-point:ON ACTION controlp INFIELD fmcp012 name="input.c.page1.fmcp012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp013
            #add-point:ON ACTION controlp INFIELD fmcp013 name="input.c.page1.fmcp013"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcp_d[l_ac].fmcp013             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " inbdsite = '",g_fmcjsite,"' AND inbd004 NOT EXISTS (SELECT 1 FROM inbd_t WHERE inbdent = ",g_enterprise," AND inbd004 = '",g_fmcp_d[l_ac].fmcp013,"')"

            CALL q_inbddocno_1()                                #呼叫開窗

            LET g_fmcp_d[l_ac].fmcp013 = g_qryparam.return1      
            LET g_qryparam.where = " "
            DISPLAY g_fmcp_d[l_ac].fmcp013 TO fmcp013    
            NEXT FIELD fmcp013                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcp014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcp014
            #add-point:ON ACTION controlp INFIELD fmcp014 name="input.c.page1.fmcp014"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE afmt035_01_bcl
               LET INT_FLAG = 0
               LET g_fmcp_d[l_ac].* = g_fmcp_d_t.*
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
               LET g_errparam.extend = g_fmcp_d[l_ac].fmcpdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmcp_d[l_ac].* = g_fmcp_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt035_01_fmcp_t_mask_restore('restore_mask_o')
 
               UPDATE fmcp_t SET (fmcpdocno,fmcpseq,fmcpseq2,fmcp015,fmcp001,fmcp002,fmcp003,fmcp017, 
                   fmcp016,fmcp004,fmcp005,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp021, 
                   fmcp010,fmcp022,fmcp011,fmcp012,fmcp013,fmcp014) = (g_fmcp_d[l_ac].fmcpdocno,g_fmcp_d[l_ac].fmcpseq, 
                   g_fmcp_d[l_ac].fmcpseq2,g_fmcp_d[l_ac].fmcp015,g_fmcp_d[l_ac].fmcp001,g_fmcp_d[l_ac].fmcp002, 
                   g_fmcp_d[l_ac].fmcp003,g_fmcp_d[l_ac].fmcp017,g_fmcp_d[l_ac].fmcp016,g_fmcp_d[l_ac].fmcp004, 
                   g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp018,g_fmcp_d[l_ac].fmcp019,g_fmcp_d[l_ac].fmcp020, 
                   g_fmcp_d[l_ac].fmcp006,g_fmcp_d[l_ac].fmcp007,g_fmcp_d[l_ac].fmcp008,g_fmcp_d[l_ac].fmcp009, 
                   g_fmcp_d[l_ac].fmcp021,g_fmcp_d[l_ac].fmcp010,g_fmcp_d[l_ac].fmcp022,g_fmcp_d[l_ac].fmcp011, 
                   g_fmcp_d[l_ac].fmcp012,g_fmcp_d[l_ac].fmcp013,g_fmcp_d[l_ac].fmcp014)
                WHERE fmcpent = g_enterprise AND
                  fmcpdocno = g_fmcp_d_t.fmcpdocno #項次   
                  AND fmcpseq = g_fmcp_d_t.fmcpseq  
                  AND fmcpseq2 = g_fmcp_d_t.fmcpseq2  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcp_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcp_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmcp_d[g_detail_idx].fmcpdocno
               LET gs_keys_bak[1] = g_fmcp_d_t.fmcpdocno
               LET gs_keys[2] = g_fmcp_d[g_detail_idx].fmcpseq
               LET gs_keys_bak[2] = g_fmcp_d_t.fmcpseq
               LET gs_keys[3] = g_fmcp_d[g_detail_idx].fmcpseq2
               LET gs_keys_bak[3] = g_fmcp_d_t.fmcpseq2
               CALL afmt035_01_update_b('fmcp_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_fmcp_d_t)
                     LET g_log2 = util.JSON.stringify(g_fmcp_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt035_01_fmcp_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL s_transaction_end('Y','0')
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL afmt035_01_unlock_b("fmcp_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmcp_d[l_ac].* = g_fmcp_d_t.*
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
               LET g_fmcp_d[li_reproduce_target].* = g_fmcp_d[li_reproduce].*
 
               LET g_fmcp_d[li_reproduce_target].fmcpdocno = NULL
               LET g_fmcp_d[li_reproduce_target].fmcpseq = NULL
               LET g_fmcp_d[li_reproduce_target].fmcpseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmcp_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmcp_d.getLength()+1
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
               NEXT FIELD fmcpdocno
 
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
      IF INT_FLAG OR cl_null(g_fmcp_d[g_detail_idx].fmcpdocno) THEN
         CALL g_fmcp_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_fmcp_d[g_detail_idx].* = g_fmcp_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE afmt035_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt035_01_delete()
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
   FOR li_idx = 1 TO g_fmcp_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT afmt035_01_lock_b("fmcp_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("fmcp_t","") THEN
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
   
   FOR li_idx = 1 TO g_fmcp_d.getLength()
      IF g_fmcp_d[li_idx].fmcpdocno IS NOT NULL
         AND g_fmcp_d[li_idx].fmcpseq IS NOT NULL
         AND g_fmcp_d[li_idx].fmcpseq2 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM fmcp_t
          WHERE fmcpent = g_enterprise AND 
                fmcpdocno = g_fmcp_d[li_idx].fmcpdocno
                AND fmcpseq = g_fmcp_d[li_idx].fmcpseq
                AND fmcpseq2 = g_fmcp_d[li_idx].fmcpseq2
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcp_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_fmcp_d_t.fmcpdocno
               LET gs_keys[2] = g_fmcp_d_t.fmcpseq
               LET gs_keys[3] = g_fmcp_d_t.fmcpseq2
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL afmt035_01_delete_b('fmcp_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt035_01_set_pk_array()
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
   CALL afmt035_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt035_01_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.fmcpdocno,t0.fmcpseq,t0.fmcpseq2,t0.fmcp015,t0.fmcp001,t0.fmcp002, 
       t0.fmcp003,t0.fmcp017,t0.fmcp016,t0.fmcp004,t0.fmcp005,t0.fmcp018,t0.fmcp019,t0.fmcp020,t0.fmcp006, 
       t0.fmcp007,t0.fmcp008,t0.fmcp009,t0.fmcp021,t0.fmcp010,t0.fmcp022,t0.fmcp011,t0.fmcp012,t0.fmcp013, 
       t0.fmcp014 ,t1.ooefl003 ,t2.gzcbl004 ,t3.ooail003 ,t4.ooail003 FROM fmcp_t t0",
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fmcp001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN gzcbl_t t2 ON t2.gzcbl001='8862' AND t2.gzcbl002=t0.fmcp003 AND t2.gzcbl003='"||g_lang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.fmcp021 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.fmcp022 AND t4.ooail001='"||g_dlang||"' ",
 
               " WHERE t0.fmcpent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = g_sql CLIPPED," AND fmcpdocno = '",g_fmcpdocno,"'"
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("fmcp_t"),
                      " ORDER BY t0.fmcpdocno,t0.fmcpseq,t0.fmcpseq2"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmcp_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmt035_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmt035_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_fmcp_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_fmcp_d[l_ac].fmcpdocno,g_fmcp_d[l_ac].fmcpseq,g_fmcp_d[l_ac].fmcpseq2, 
       g_fmcp_d[l_ac].fmcp015,g_fmcp_d[l_ac].fmcp001,g_fmcp_d[l_ac].fmcp002,g_fmcp_d[l_ac].fmcp003,g_fmcp_d[l_ac].fmcp017, 
       g_fmcp_d[l_ac].fmcp016,g_fmcp_d[l_ac].fmcp004,g_fmcp_d[l_ac].fmcp005,g_fmcp_d[l_ac].fmcp018,g_fmcp_d[l_ac].fmcp019, 
       g_fmcp_d[l_ac].fmcp020,g_fmcp_d[l_ac].fmcp006,g_fmcp_d[l_ac].fmcp007,g_fmcp_d[l_ac].fmcp008,g_fmcp_d[l_ac].fmcp009, 
       g_fmcp_d[l_ac].fmcp021,g_fmcp_d[l_ac].fmcp010,g_fmcp_d[l_ac].fmcp022,g_fmcp_d[l_ac].fmcp011,g_fmcp_d[l_ac].fmcp012, 
       g_fmcp_d[l_ac].fmcp013,g_fmcp_d[l_ac].fmcp014,g_fmcp_d[l_ac].fmcp002_desc,g_fmcp_d[l_ac].fmcp003_desc, 
       g_fmcp_d[l_ac].fmcp021_desc,g_fmcp_d[l_ac].fmcp022_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT ooefl003 INTO g_fmcp_d[l_ac].fmcp002_desc FROM ooefl_t
       WHERE ooeflent = g_enterprise AND ooefl001 = g_fmcp_d[l_ac].fmcp002
         AND ooefl002 = g_dlang
         
      SELECT ooail003 INTO g_fmcp_d[l_ac].fmcp022_desc FROM ooail_t
       WHERE ooailent = g_enterprise AND ooail001 = g_fmcp_d[l_ac].fmcp022
         AND ooail002 = g_dlang
      #end add-point
      
      CALL afmt035_01_detail_show()      
 
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
   
 
   
   CALL g_fmcp_d.deleteElement(g_fmcp_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_fmcp_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_fmcp_d.getLength() THEN
      LET l_ac = g_fmcp_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmcp_d.getLength()
      LET g_fmcp_d_mask_o[l_ac].* =  g_fmcp_d[l_ac].*
      CALL afmt035_01_fmcp_t_mask()
      LET g_fmcp_d_mask_n[l_ac].* =  g_fmcp_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_fmcp_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE afmt035_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmt035_01_detail_show()
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
 
{<section id="afmt035_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt035_01_set_entry_b(p_cmd)                                                  
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
 
{<section id="afmt035_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt035_01_set_no_entry_b(p_cmd)                                               
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
 
{<section id="afmt035_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt035_01_default_search()
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
      LET ls_wc = ls_wc, " fmcpdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fmcpseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fmcpseq2 = '", g_argv[03], "' AND "
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
 
{<section id="afmt035_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt035_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "fmcp_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'fmcp_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM fmcp_t
          WHERE fmcpent = g_enterprise AND
            fmcpdocno = ps_keys_bak[1] AND fmcpseq = ps_keys_bak[2] AND fmcpseq2 = ps_keys_bak[3]
         
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
         CALL g_fmcp_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt035_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "fmcp_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO fmcp_t
                  (fmcpent,
                   fmcpdocno,fmcpseq,fmcpseq2
                   ,fmcp015,fmcp001,fmcp002,fmcp003,fmcp017,fmcp016,fmcp004,fmcp005,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp021,fmcp010,fmcp022,fmcp011,fmcp012,fmcp013,fmcp014) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmcp_d[l_ac].fmcp015,g_fmcp_d[l_ac].fmcp001,g_fmcp_d[l_ac].fmcp002,g_fmcp_d[l_ac].fmcp003, 
                       g_fmcp_d[l_ac].fmcp017,g_fmcp_d[l_ac].fmcp016,g_fmcp_d[l_ac].fmcp004,g_fmcp_d[l_ac].fmcp005, 
                       g_fmcp_d[l_ac].fmcp018,g_fmcp_d[l_ac].fmcp019,g_fmcp_d[l_ac].fmcp020,g_fmcp_d[l_ac].fmcp006, 
                       g_fmcp_d[l_ac].fmcp007,g_fmcp_d[l_ac].fmcp008,g_fmcp_d[l_ac].fmcp009,g_fmcp_d[l_ac].fmcp021, 
                       g_fmcp_d[l_ac].fmcp010,g_fmcp_d[l_ac].fmcp022,g_fmcp_d[l_ac].fmcp011,g_fmcp_d[l_ac].fmcp012, 
                       g_fmcp_d[l_ac].fmcp013,g_fmcp_d[l_ac].fmcp014)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt035_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "fmcp_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "fmcp_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE fmcp_t 
         SET (fmcpdocno,fmcpseq,fmcpseq2
              ,fmcp015,fmcp001,fmcp002,fmcp003,fmcp017,fmcp016,fmcp004,fmcp005,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp021,fmcp010,fmcp022,fmcp011,fmcp012,fmcp013,fmcp014) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmcp_d[l_ac].fmcp015,g_fmcp_d[l_ac].fmcp001,g_fmcp_d[l_ac].fmcp002,g_fmcp_d[l_ac].fmcp003, 
                  g_fmcp_d[l_ac].fmcp017,g_fmcp_d[l_ac].fmcp016,g_fmcp_d[l_ac].fmcp004,g_fmcp_d[l_ac].fmcp005, 
                  g_fmcp_d[l_ac].fmcp018,g_fmcp_d[l_ac].fmcp019,g_fmcp_d[l_ac].fmcp020,g_fmcp_d[l_ac].fmcp006, 
                  g_fmcp_d[l_ac].fmcp007,g_fmcp_d[l_ac].fmcp008,g_fmcp_d[l_ac].fmcp009,g_fmcp_d[l_ac].fmcp021, 
                  g_fmcp_d[l_ac].fmcp010,g_fmcp_d[l_ac].fmcp022,g_fmcp_d[l_ac].fmcp011,g_fmcp_d[l_ac].fmcp012, 
                  g_fmcp_d[l_ac].fmcp013,g_fmcp_d[l_ac].fmcp014) 
         WHERE fmcpent = g_enterprise AND fmcpdocno = ps_keys_bak[1] AND fmcpseq = ps_keys_bak[2] AND fmcpseq2 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcp_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcp_t:",SQLERRMESSAGE 
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
 
{<section id="afmt035_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt035_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL afmt035_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "fmcp_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt035_01_bcl USING g_enterprise,
                                       g_fmcp_d[g_detail_idx].fmcpdocno,g_fmcp_d[g_detail_idx].fmcpseq, 
                                           g_fmcp_d[g_detail_idx].fmcpseq2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt035_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt035_01_unlock_b(ps_table)
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
      CLOSE afmt035_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION afmt035_01_modify_detail_chk(ps_record)
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
         LET ls_return = "fmcpdocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="afmt035_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION afmt035_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="afmt035_01.mask_functions" >}
&include "erp/afm/afmt035_01_mask.4gl"
 
{</section>}
 
{<section id="afmt035_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt035_01_set_pk_array()
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
   LET g_pk_array[1].values = g_fmcp_d[l_ac].fmcpdocno
   LET g_pk_array[1].column = 'fmcpdocno'
   LET g_pk_array[2].values = g_fmcp_d[l_ac].fmcpseq
   LET g_pk_array[2].column = 'fmcpseq'
   LET g_pk_array[3].values = g_fmcp_d[l_ac].fmcpseq2
   LET g_pk_array[3].column = 'fmcpseq2'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt035_01.state_change" >}
   
 
{</section>}
 
{<section id="afmt035_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afmt035_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 栏位可录空管
# Memo...........:
# Usage..........: CALL afmt035_01_fmcp015_entry()
# Date & Author..: 2015/11/17 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_01_fmcp015_entry()
   CALL cl_set_comp_entry("fmcp001,fmcp002,fmcp003,fmcp004,fmcp005,fmcp016,fmcp017,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp010,fmcp011,fmcp012,fmcp013,fmcp014",TRUE)
   
   CASE g_fmcp_d[l_ac].fmcp015 
      WHEN '1' CALL cl_set_comp_entry("fmcp003,fmcp004,fmcp005,fmcp016,fmcp017,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp010,fmcp011,fmcp012,fmcp013,fmcp014",FALSE)
      WHEN '2' CALL cl_set_comp_entry("fmcp007,fmcp008,fmcp012,fmcp013,fmcp014",FALSE)
      WHEN '3' CALL cl_set_comp_entry("fmcp004,fmcp005,fmcp016,fmcp017,fmcp018,fmcp019,fmcp020,fmcp006,fmcp012,fmcp013,fmcp014",FALSE)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 栏位预设
# Memo...........:
# Usage..........: CALL afmt035_01_default_ref()
# Date & Author..: 2015/11/17 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_01_default_ref()
  
   LET g_fmcp_d[l_ac].fmcp002 = g_fmcjsite
   SELECT ooefl003 INTO g_fmcp_d[l_ac].fmcp002_desc FROM ooefl_t
    WHERE ooeflent = g_enterprise AND ooefl001 = g_fmcp_d[l_ac].fmcp002
      AND ooefl002 = g_dlang
      
   CASE g_fmcj005
      WHEN '1' LET g_fmcp_d[l_ac].fmcp015 = '1'
         CALL cl_set_comp_entry("fmcp015",FALSE)
      WHEN '2' LET g_fmcp_d[l_ac].fmcp015 = '2'
         CALL cl_set_comp_entry("fmcp015",FALSE)
      WHEN '3' LET g_fmcp_d[l_ac].fmcp015 = '3'
         CALL cl_set_comp_entry("fmcp015",FALSE)
      WHEN '4' LET g_fmcp_d[l_ac].fmcp015 = '1'
         CALL cl_set_comp_entry("fmcp015",TRUE)
   END CASE
   
   CALL cl_set_comp_entry("fmcp001,fmcp002,fmcp003,fmcp004,fmcp005,fmcp016,fmcp017,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp010,fmcp011,fmcp012,fmcp013,fmcp014",TRUE)
   
   CASE g_fmcp_d[l_ac].fmcp015 
      WHEN '1' CALL cl_set_comp_entry("fmcp003,fmcp004,fmcp005,fmcp016,fmcp017,fmcp018,fmcp019,fmcp020,fmcp006,fmcp007,fmcp008,fmcp009,fmcp010,fmcp011,fmcp012,fmcp013,fmcp014",FALSE)
      WHEN '2' CALL cl_set_comp_entry("fmcp006,fmcp007,fmcp008,fmcp012,fmcp013,fmcp014",FALSE)
      WHEN '3' CALL cl_set_comp_entry("fmcp004,fmcp005,fmcp016,fmcp017,fmcp018,fmcp019,fmcp020,fmcp006,fmcp012,fmcp013,fmcp014",FALSE)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL afmt035_01_fmcp004_ref()
# Date & Author..: 2015/11/17 By yangt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_01_fmcp004_ref()
DEFINE l_year      LIKE type_t.num5
DEFINE l_month     LIKE type_t.num5
DEFINE r_xccc901   LIKE xccc_t.xccc901
DEFINE r_xccc902   LIKE xccc_t.xccc902
DEFINE l_sql       STRING

   LET l_year = YEAR(g_fmcjdocdt)
   LET l_month = MONTH(g_fmcjdocdt)
#   IF l_month = 1 THEN  
#      LET l_year = l_year - 1
#      LET l_month = 12
#   ELSE
#      LET l_month = l_month - 1
#   END IF
   #数量，金额
   LET l_sql = " SELECT xccc901,xccc902 FROM xccc_t ",
               "  WHERE xcccent = ",g_enterprise," AND xcccld = '",g_glaald,"'",
               "    AND xccc001 = '1'",
               "    AND xccc003 = '",g_glaa120,"' AND xccc004 = ",l_year,
               "    AND xccc005 = ",l_month," AND xccc006 = '",g_fmcp_d[l_ac].fmcp004,"'"
   
   IF cl_null(g_fmcp_d[l_ac].fmcp018) THEN
      LET l_sql = l_sql CLIPPED," AND trim(xccc002) IS NULL"
   ELSE
      LET l_sql = l_sql CLIPPED," AND xccc002 = '",g_fmcp_d[l_ac].fmcp018,"'"
   END IF
   IF cl_null(g_fmcp_d[l_ac].fmcp019) THEN
      LET l_sql = l_sql CLIPPED," AND trim(xccc007) IS NULL"
   ELSE
      LET l_sql = l_sql CLIPPED," AND xccc007 = '",g_fmcp_d[l_ac].fmcp019,"'"
   END IF
   IF cl_null(g_fmcp_d[l_ac].fmcp020) THEN
      LET l_sql = l_sql CLIPPED," AND trim(xccc008) IS NULL"
   ELSE
      LET l_sql = l_sql CLIPPED," AND xccc008 = '",g_fmcp_d[l_ac].fmcp020,"'"
   END IF
   PREPARE xccc_prep FROM l_sql
   EXECUTE xccc_prep INTO r_xccc901,r_xccc902
   IF cl_null(r_xccc901) THEN LET r_xccc901 = 0 END IF
   IF cl_null(r_xccc902) THEN LET r_xccc902 = 0 END IF
   
   RETURN r_xccc901,r_xccc902
END FUNCTION

################################################################################
# Descriptions...: 当担保人存在于组织档，fmcp010不可录
# Memo...........:
# Usage..........: CALL afmt035_01_fmcp002_chk()
# Date & Author..: 2015/11/18 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_01_fmcp002_chk()
DEFINE l_n        LIKE type_t.num5
   CALL cl_set_comp_entry("fmcp010,fmcp018,fmcp019,fmcp020",TRUE)
   IF NOT cl_null(g_fmcp_d[l_ac].fmcp002) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = g_fmcp_d[l_ac].fmcp002
     IF l_n > 0 THEN
        CALL cl_set_comp_entry("fmcp010,fmcp019,fmcp020",FALSE)
        IF g_para_data = 'Y' THEN
           CALL cl_set_comp_entry("fmcp018",TRUE)
        ELSE
           CALL cl_set_comp_entry("fmcp018",FALSE)
        END IF
     ELSE
        CALL cl_set_comp_entry("fmcp010,fmcp018,fmcp019,fmcp020",TRUE)
     END IF 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 当抵押质押物性质=1.原料，fmcp013不可录
# Memo...........:
# Usage..........: CALL afmt035_01_fmcp003_entry()
# Date & Author..: 2015/11/19 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt035_01_fmcp003_entry()
   CASE g_fmcp_d[l_ac].fmcp003 
      WHEN '2' 
         CALL cl_set_comp_entry("fmcp013,fmcp018,fmcp019,fmcp020",FALSE)
         CALL cl_set_comp_entry("fmcp004,fmcp005,fmcp016,fmcp017",TRUE)
         LET g_fmcp_d[l_ac].fmcp013 = ''
         LET g_fmcp_d[l_ac].fmcp019 = ''
         LET g_fmcp_d[l_ac].fmcp018 = ''
         LET g_fmcp_d[l_ac].fmcp020 = ''
      WHEN '1' 
         CALL cl_set_comp_entry("fmcp004,fmcp013,fmcp018,fmcp019,fmcp020",TRUE)
         CALL cl_set_comp_entry("fmcp016,fmcp017,fmcp005",FALSE)
         LET g_fmcp_d[l_ac].fmcp016 = ''
         LET g_fmcp_d[l_ac].fmcp017 = ''
      OTHERWISE
         CALL cl_set_comp_entry("fmcp004,fmcp013,fmcp018,fmcp019,fmcp020",FALSE)
         CALL cl_set_comp_entry("fmcp016,fmcp017,fmcp005",FALSE)
         LET g_fmcp_d[l_ac].fmcp016 = ''
         LET g_fmcp_d[l_ac].fmcp017 = ''
         LET g_fmcp_d[l_ac].fmcp013 = ''
         LET g_fmcp_d[l_ac].fmcp019 = ''
         LET g_fmcp_d[l_ac].fmcp018 = ''
         LET g_fmcp_d[l_ac].fmcp020 = ''
   END CASE
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
PRIVATE FUNCTION afmt035_01_fmcpseq_ref()
   DEFINE l_sql          STRING
DEFINE r_fmckseq      LIKE fmck_t.fmckseq

   LET l_sql = " SELECT fmckseq FROM fmck_t ",
               "  WHERE fmckent = ",g_enterprise," AND fmckdocno = '",g_fmcpdocno,"'",
               "  ORDER BY fmckseq"
               
   PREPARE fmckseq_prep FROM l_sql
   DECLARE fmckseq_curs SCROLL CURSOR WITH HOLD FOR fmckseq_prep
   OPEN fmckseq_curs
   FETCH FIRST fmckseq_curs INTO r_fmckseq
   CLOSE fmckseq_curs
   
   RETURN r_fmckseq
END FUNCTION

 
{</section>}
 
