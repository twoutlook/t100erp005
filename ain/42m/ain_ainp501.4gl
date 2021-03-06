#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-11-03 10:10:05), PR版次:0011(2016-11-23 15:53:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000161
#+ Filename...: ainp501
#+ Description: 調撥申請單整批核准作業
#+ Creator....: 01726(2014-04-11 10:29:46)
#+ Modifier...: 02159 -SD/PR- 06814
 
{</section>}
 
{<section id="ainp501.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#15   2016/04/07  BY 07900    重复错误讯息的修改
#161104-00002#4    2016/11/07  BY 06814    星號寫法調整
#161123-00042#4    2016/11/23  BY 06814    星號寫法調整應補上自定義欄位
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

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
PRIVATE TYPE type_g_inda_d RECORD
       sel LIKE type_t.chr500, 
   indastus LIKE inda_t.indastus, 
   inda002 LIKE inda_t.inda002, 
   inda002_desc LIKE type_t.chr500, 
   indadocno LIKE inda_t.indadocno, 
   indadocdt LIKE inda_t.indadocdt, 
   inda001 LIKE inda_t.inda001, 
   inda001_desc LIKE type_t.chr500, 
   inda003 LIKE inda_t.inda003, 
   inda003_desc LIKE type_t.chr500, 
   inda004 LIKE inda_t.inda004, 
   inda004_desc LIKE type_t.chr500, 
   indasite LIKE inda_t.indasite, 
   indasite_desc LIKE type_t.chr500, 
   inda005 LIKE inda_t.inda005, 
   inda006 LIKE inda_t.inda006
       END RECORD
PRIVATE TYPE type_g_inda2_d RECORD
       indadocno LIKE inda_t.indadocno, 
   indaownid LIKE inda_t.indaownid, 
   indaownid_desc LIKE type_t.chr500, 
   indaowndp LIKE inda_t.indaowndp, 
   indaowndp_desc LIKE type_t.chr500, 
   indacrtid LIKE inda_t.indacrtid, 
   indacrtid_desc LIKE type_t.chr500, 
   indacrtdp LIKE inda_t.indacrtdp, 
   indacrtdp_desc LIKE type_t.chr500, 
   indacrtdt DATETIME YEAR TO SECOND, 
   indamodid LIKE inda_t.indamodid, 
   indamodid_desc LIKE type_t.chr500, 
   indamoddt DATETIME YEAR TO SECOND, 
   indacnfid LIKE inda_t.indacnfid, 
   indacnfid_desc LIKE type_t.chr500, 
   indacnfdt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_inda3_d RECORD
       indbseq LIKE indb_t.indbseq, 
   indb002 LIKE indb_t.indb002, 
   indb001 LIKE indb_t.indb001, 
   indb001_desc LIKE type_t.chr500, 
   indb001_desc_1 LIKE type_t.chr500, 
   indb003 LIKE indb_t.indb003, 
   indb004 LIKE indb_t.indb004, 
   indb004_desc LIKE type_t.chr500, 
   indb005 LIKE indb_t.indb005, 
   indb005_desc LIKE type_t.chr500, 
   indb006 LIKE indb_t.indb006, 
   indb007 LIKE indb_t.indb007, 
   indb008 LIKE indb_t.indb008, 
   indb009 LIKE indb_t.indb009, 
   indb010 LIKE indb_t.indb010, 
   indb011 LIKE indb_t.indb011, 
   indb012 LIKE indb_t.indb012, 
   indb013 LIKE indb_t.indb013
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_detail_flag   LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_inda_d
DEFINE g_master_t                   type_g_inda_d
DEFINE g_inda_d          DYNAMIC ARRAY OF type_g_inda_d
DEFINE g_inda_d_t        type_g_inda_d
DEFINE g_inda_d_o        type_g_inda_d
DEFINE g_inda_d_mask_o   DYNAMIC ARRAY OF type_g_inda_d #轉換遮罩前資料
DEFINE g_inda_d_mask_n   DYNAMIC ARRAY OF type_g_inda_d #轉換遮罩後資料
DEFINE g_inda2_d          DYNAMIC ARRAY OF type_g_inda2_d
DEFINE g_inda2_d_t        type_g_inda2_d
DEFINE g_inda2_d_o        type_g_inda2_d
DEFINE g_inda2_d_mask_o   DYNAMIC ARRAY OF type_g_inda2_d #轉換遮罩前資料
DEFINE g_inda2_d_mask_n   DYNAMIC ARRAY OF type_g_inda2_d #轉換遮罩後資料
DEFINE g_inda3_d          DYNAMIC ARRAY OF type_g_inda3_d
DEFINE g_inda3_d_t        type_g_inda3_d
DEFINE g_inda3_d_o        type_g_inda3_d
DEFINE g_inda3_d_mask_o   DYNAMIC ARRAY OF type_g_inda3_d #轉換遮罩前資料
DEFINE g_inda3_d_mask_n   DYNAMIC ARRAY OF type_g_inda3_d #轉換遮罩後資料
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             
DEFINE g_ac_last            LIKE type_t.num10             
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_detail_idx         LIKE type_t.num10             #單身所在筆數(第一階單身)
DEFINE g_detail_idx2        LIKE type_t.num10             #單身所在筆數(第二階單身)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身總筆數 (第一階單身)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身總筆數 (第二階單身)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_current_page       LIKE type_t.num10             #判斷單身筆數用
DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp501.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp501 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainp501_init()   
 
      #進入選單 Menu (="N")
      CALL ainp501_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ainp501
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   CALL ainp501_drop_temp() RETURNING l_success   #150915-00001#1 150915 by sakura add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ainp501.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ainp501_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
      CALL cl_set_combo_scc_part('indastus','13','N,Y,A,C,D,R,T,W,X')
 
   
   LET l_ac = 1
   
 
 
   
 
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_inda_d.getLength() > 0 THEN
      LET g_master_t.* = g_inda_d[1].*
      LET g_master.* = g_inda_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   
   #150915-00001#1 150915 by sakura mark&add(S)
   CALL ainp501_create_temp() RETURNING l_success
   #CREATE TEMP TABLE ainp501_tmp(
   #                       tmp_sel       LIKE type_t.chr1,
   #                       tmp_indadocno LIKE inda_t.indadocno)
   #150915-00001#1 150915 by sakura mark&add(E)
   
   #临时表取数据
   CALL ainp501_tmp_ins()
   #end add-point
   
   CALL ainp501_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION ainp501_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num10
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
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_inda_d.clear()
         CALL g_inda2_d.clear()
         CALL g_inda3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ainp501_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      
      #end add-point
   
      CALL ainp501_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_inda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 1
      
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_inda_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL ainp501_fetch()
               CALL ainp501_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL ainp501_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_inda2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 2
               
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_master.* = g_inda_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL ainp501_fetch()
               CALL ainp501_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL ainp501_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_inda3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 3
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               CALL ainp501_idx_chk('d')
               LET g_master.* = g_inda_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         ON ACTION sel
            FOR li_idx = 1 TO g_inda_d.getlength()
               IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                  LET g_inda_d[li_idx].sel = 'Y'
                  UPDATE ainp501_tmp
                     SET tmp_sel = g_inda_d[li_idx].sel
                   WHERE tmp_indadocno = g_inda_d[li_idx].indadocno
               END IF
            END FOR
         ON ACTION unsel
            FOR li_idx = 1 TO g_inda_d.getlength()
               IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                  LET g_inda_d[li_idx].sel = 'N'
                  UPDATE ainp501_tmp
                     SET tmp_sel = g_inda_d[li_idx].sel
                   WHERE tmp_indadocno = g_inda_d[li_idx].indadocno
               END IF
            END FOR
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1",1,-1,1)
            FOR li_idx = 1 TO g_inda_d.getlength()
               LET g_inda_d[li_idx].sel = 'Y'
               UPDATE ainp501_tmp
                  SET tmp_sel = g_inda_d[li_idx].sel
                WHERE tmp_indadocno = g_inda_d[li_idx].indadocno
            END FOR
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1",1,-1,0)
            FOR li_idx = 1 TO g_inda_d.getlength()
               LET g_inda_d[li_idx].sel = 'N'
               UPDATE ainp501_tmp
                  SET tmp_sel = g_inda_d[li_idx].sel
                WHERE tmp_indadocno = g_inda_d[li_idx].indadocno
            END FOR
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_inda_d.getLength() THEN
                  LET g_detail_idx = g_inda_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point  
            NEXT FIELD CURRENT
        
         AFTER DIALOG
            #add-point:ui_dialog段after dialog name="ui_dialog.after_dialog"
            
            #end add-point
         
      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         IF cl_auth_chk_act("exporttoexcel") THEN
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_inda_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_inda2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_inda3_d)
            LET g_export_id[3]   = "s_detail3"
 
            #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
            
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
         
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_confirm
            LET g_action_choice="batch_confirm"
            IF cl_auth_chk_act("batch_confirm") THEN
               
               #add-point:ON ACTION batch_confirm name="menu.batch_confirm"
               CALL ainp501_batch_confirm()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL ainp501_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL ainp501_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ainp501_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
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
            CALL ainp501_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ainp501_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ainp501_set_pk_array()
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
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainp501.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ainp501_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_inda_d.clear()
   CALL g_inda2_d.clear()
   CALL g_inda3_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON indastus,inda002,indadocno,indadocdt,inda001,inda003,inda004,indasite, 
          inda005,inda006,indaownid,indaowndp,indacrtid,indacrtdp,indacrtdt,indamodid,indamoddt,indacnfid, 
          indacnfdt
           FROM s_detail1[1].indastus,s_detail1[1].inda002,s_detail1[1].indadocno,s_detail1[1].indadocdt, 
               s_detail1[1].inda001,s_detail1[1].inda003,s_detail1[1].inda004,s_detail1[1].indasite, 
               s_detail1[1].inda005,s_detail1[1].inda006,s_detail2[1].indaownid,s_detail2[1].indaowndp, 
               s_detail2[1].indacrtid,s_detail2[1].indacrtdp,s_detail2[1].indacrtdt,s_detail2[1].indamodid, 
               s_detail2[1].indamoddt,s_detail2[1].indacnfid,s_detail2[1].indacnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY 'Y' TO indastus
            DISPLAY g_site TO inda002
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<indacrtdt>>----
         AFTER FIELD indacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<indamoddt>>----
         AFTER FIELD indamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indacnfdt>>----
         AFTER FIELD indacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indapstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indastus
            #add-point:BEFORE FIELD indastus name="construct.b.page1.indastus"
            NEXT FIELD inda002
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indastus
            
            #add-point:AFTER FIELD indastus name="construct.a.page1.indastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indastus
            #add-point:ON ACTION controlp INFIELD indastus name="construct.c.page1.indastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda002
            #add-point:ON ACTION controlp INFIELD inda002 name="construct.c.page1.inda002"
            #备注：上级组织预设当前组织不可开窗
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda002
            #add-point:BEFORE FIELD inda002 name="construct.b.page1.inda002"
            NEXT FIELD indadocno 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda002
            
            #add-point:AFTER FIELD inda002 name="construct.a.page1.inda002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocno
            #add-point:BEFORE FIELD indadocno name="construct.b.page1.indadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocno
            
            #add-point:AFTER FIELD indadocno name="construct.a.page1.indadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocno
            #add-point:ON ACTION controlp INFIELD indadocno name="construct.c.page1.indadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " indastus = 'Y' AND inda002 = '",g_site,"' "
            CALL q_indadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indadocno  #顯示到畫面上
            NEXT FIELD indadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocdt
            #add-point:BEFORE FIELD indadocdt name="construct.b.page1.indadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocdt
            
            #add-point:AFTER FIELD indadocdt name="construct.a.page1.indadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocdt
            #add-point:ON ACTION controlp INFIELD indadocdt name="construct.c.page1.indadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda001
            #add-point:BEFORE FIELD inda001 name="construct.b.page1.inda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda001
            
            #add-point:AFTER FIELD inda001 name="construct.a.page1.inda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda001
            #add-point:ON ACTION controlp INFIELD inda001 name="construct.c.page1.inda001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inda001  #顯示到畫面上
            NEXT FIELD inda001                     #返回原欄位
    


            #END add-point
 
 
         #Ctrlp:construct.c.page1.inda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda003
            #add-point:ON ACTION controlp INFIELD inda003 name="construct.c.page1.inda003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'inda003') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda003',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE
               #aooi500中未设定按原逻辑
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004_6()
            END IF
            DISPLAY g_qryparam.return1 TO inda003  #顯示到畫面上
            NEXT FIELD inda003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda003
            #add-point:BEFORE FIELD inda003 name="construct.b.page1.inda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda003
            
            #add-point:AFTER FIELD inda003 name="construct.a.page1.inda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda004
            #add-point:ON ACTION controlp INFIELD inda004 name="construct.c.page1.inda004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'inda004') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda004',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE
               #aooi500中未设定按原逻辑
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO inda004  #顯示到畫面上
            NEXT FIELD inda004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda004
            #add-point:BEFORE FIELD inda004 name="construct.b.page1.inda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda004
            
            #add-point:AFTER FIELD inda004 name="construct.a.page1.inda004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indasite
            #add-point:ON ACTION controlp INFIELD indasite name="construct.c.page1.indasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'indasite') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'indasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO indasite  #顯示到畫面上
            NEXT FIELD indasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indasite
            #add-point:BEFORE FIELD indasite name="construct.b.page1.indasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indasite
            
            #add-point:AFTER FIELD indasite name="construct.a.page1.indasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda005
            #add-point:BEFORE FIELD inda005 name="construct.b.page1.inda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda005
            
            #add-point:AFTER FIELD inda005 name="construct.a.page1.inda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda005
            #add-point:ON ACTION controlp INFIELD inda005 name="construct.c.page1.inda005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda006
            #add-point:BEFORE FIELD inda006 name="construct.b.page1.inda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda006
            
            #add-point:AFTER FIELD inda006 name="construct.a.page1.inda006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda006
            #add-point:ON ACTION controlp INFIELD inda006 name="construct.c.page1.inda006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.indaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indaownid
            #add-point:ON ACTION controlp INFIELD indaownid name="construct.c.page2.indaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indaownid  #顯示到畫面上
            NEXT FIELD indaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indaownid
            #add-point:BEFORE FIELD indaownid name="construct.b.page2.indaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indaownid
            
            #add-point:AFTER FIELD indaownid name="construct.a.page2.indaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indaowndp
            #add-point:ON ACTION controlp INFIELD indaowndp name="construct.c.page2.indaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indaowndp  #顯示到畫面上
            NEXT FIELD indaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indaowndp
            #add-point:BEFORE FIELD indaowndp name="construct.b.page2.indaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indaowndp
            
            #add-point:AFTER FIELD indaowndp name="construct.a.page2.indaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indacrtid
            #add-point:ON ACTION controlp INFIELD indacrtid name="construct.c.page2.indacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indacrtid  #顯示到畫面上
            NEXT FIELD indacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacrtid
            #add-point:BEFORE FIELD indacrtid name="construct.b.page2.indacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indacrtid
            
            #add-point:AFTER FIELD indacrtid name="construct.a.page2.indacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.indacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indacrtdp
            #add-point:ON ACTION controlp INFIELD indacrtdp name="construct.c.page2.indacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indacrtdp  #顯示到畫面上
            NEXT FIELD indacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacrtdp
            #add-point:BEFORE FIELD indacrtdp name="construct.b.page2.indacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indacrtdp
            
            #add-point:AFTER FIELD indacrtdp name="construct.a.page2.indacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacrtdt
            #add-point:BEFORE FIELD indacrtdt name="construct.b.page2.indacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.indamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indamodid
            #add-point:ON ACTION controlp INFIELD indamodid name="construct.c.page2.indamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indamodid  #顯示到畫面上
            NEXT FIELD indamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indamodid
            #add-point:BEFORE FIELD indamodid name="construct.b.page2.indamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indamodid
            
            #add-point:AFTER FIELD indamodid name="construct.a.page2.indamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indamoddt
            #add-point:BEFORE FIELD indamoddt name="construct.b.page2.indamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.indacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indacnfid
            #add-point:ON ACTION controlp INFIELD indacnfid name="construct.c.page2.indacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indacnfid  #顯示到畫面上
            NEXT FIELD indacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacnfid
            #add-point:BEFORE FIELD indacnfid name="construct.b.page2.indacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indacnfid
            
            #add-point:AFTER FIELD indacnfid name="construct.a.page2.indacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacnfdt
            #add-point:BEFORE FIELD indacnfdt name="construct.b.page2.indacnfdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON indbseq,indb002,indb001,indb003,indb004,indb005,indb006,indb007,indb008, 
          indb009,indb010,indb011,indb012,indb013
           FROM s_detail3[1].indbseq,s_detail3[1].indb002,s_detail3[1].indb001,s_detail3[1].indb003, 
               s_detail3[1].indb004,s_detail3[1].indb005,s_detail3[1].indb006,s_detail3[1].indb007,s_detail3[1].indb008, 
               s_detail3[1].indb009,s_detail3[1].indb010,s_detail3[1].indb011,s_detail3[1].indb012,s_detail3[1].indb013 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbseq
            #add-point:BEFORE FIELD indbseq name="construct.b.page3.indbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbseq
            
            #add-point:AFTER FIELD indbseq name="construct.a.page3.indbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbseq
            #add-point:ON ACTION controlp INFIELD indbseq name="construct.c.page3.indbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb002
            #add-point:BEFORE FIELD indb002 name="construct.b.page3.indb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb002
            
            #add-point:AFTER FIELD indb002 name="construct.a.page3.indb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb002
            #add-point:ON ACTION controlp INFIELD indb002 name="construct.c.page3.indb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb002  #顯示到畫面上
            NEXT FIELD indb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb001
            #add-point:BEFORE FIELD indb001 name="construct.b.page3.indb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb001
            
            #add-point:AFTER FIELD indb001 name="construct.a.page3.indb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb001
            #add-point:ON ACTION controlp INFIELD indb001 name="construct.c.page3.indb001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb001  #顯示到畫面上
            NEXT FIELD indb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb003
            #add-point:BEFORE FIELD indb003 name="construct.b.page3.indb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb003
            
            #add-point:AFTER FIELD indb003 name="construct.a.page3.indb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb003
            #add-point:ON ACTION controlp INFIELD indb003 name="construct.c.page3.indb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb004
            #add-point:BEFORE FIELD indb004 name="construct.b.page3.indb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb004
            
            #add-point:AFTER FIELD indb004 name="construct.a.page3.indb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb004
            #add-point:ON ACTION controlp INFIELD indb004 name="construct.c.page3.indb004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb004  #顯示到畫面上
            NEXT FIELD indb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb005
            #add-point:BEFORE FIELD indb005 name="construct.b.page3.indb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb005
            
            #add-point:AFTER FIELD indb005 name="construct.a.page3.indb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb005
            #add-point:ON ACTION controlp INFIELD indb005 name="construct.c.page3.indb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb005  #顯示到畫面上
            NEXT FIELD indb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb006
            #add-point:BEFORE FIELD indb006 name="construct.b.page3.indb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb006
            
            #add-point:AFTER FIELD indb006 name="construct.a.page3.indb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb006
            #add-point:ON ACTION controlp INFIELD indb006 name="construct.c.page3.indb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb007
            #add-point:BEFORE FIELD indb007 name="construct.b.page3.indb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb007
            
            #add-point:AFTER FIELD indb007 name="construct.a.page3.indb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb007
            #add-point:ON ACTION controlp INFIELD indb007 name="construct.c.page3.indb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb008
            #add-point:BEFORE FIELD indb008 name="construct.b.page3.indb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb008
            
            #add-point:AFTER FIELD indb008 name="construct.a.page3.indb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb008
            #add-point:ON ACTION controlp INFIELD indb008 name="construct.c.page3.indb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb009
            #add-point:BEFORE FIELD indb009 name="construct.b.page3.indb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb009
            
            #add-point:AFTER FIELD indb009 name="construct.a.page3.indb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb009
            #add-point:ON ACTION controlp INFIELD indb009 name="construct.c.page3.indb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb010
            #add-point:BEFORE FIELD indb010 name="construct.b.page3.indb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb010
            
            #add-point:AFTER FIELD indb010 name="construct.a.page3.indb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb010
            #add-point:ON ACTION controlp INFIELD indb010 name="construct.c.page3.indb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb011
            #add-point:BEFORE FIELD indb011 name="construct.b.page3.indb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb011
            
            #add-point:AFTER FIELD indb011 name="construct.a.page3.indb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb011
            #add-point:ON ACTION controlp INFIELD indb011 name="construct.c.page3.indb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb012
            #add-point:BEFORE FIELD indb012 name="construct.b.page3.indb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb012
            
            #add-point:AFTER FIELD indb012 name="construct.a.page3.indb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb012
            #add-point:ON ACTION controlp INFIELD indb012 name="construct.c.page3.indb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb013
            #add-point:BEFORE FIELD indb013 name="construct.b.page3.indb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb013
            
            #add-point:AFTER FIELD indb013 name="construct.a.page3.indb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.indb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb013
            #add-point:ON ACTION controlp INFIELD indb013 name="construct.c.page3.indb013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="query.b_dialog"
         
         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
      ON ACTION qbe_save       #條件儲存
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
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
 
        
   #add-point:cs段after_construct name="cs.after_construct"
   CALL ainp501_tmp_ins()
   #end add-point
   
   LET g_error_show = 1
   CALL ainp501_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL ainp501_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_inda_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_inda3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.insert" >}
#+ 資料修改
PRIVATE FUNCTION ainp501_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL ainp501_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ainp501.modify" >}
#+ 資料新增
PRIVATE FUNCTION ainp501_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point 
  
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   LET l_ac_t = g_detail_idx
 
   #add-point:modify段新增前 name="modify.before_modify"
   
   #end add-point 
   
   #進入資料輸入段落
   CALL ainp501_input('u')
    
   IF INT_FLAG AND g_inda_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL ainp501_b_fill(g_wc)
      CALL ainp501_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ainp501.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ainp501_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point 
   DEFINE li_ac LIKE type_t.num10
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_inda_d_t.* = g_inda_d[li_ac].*
   LET g_inda_d_o.* = g_inda_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM inda_t 
         WHERE indaent = g_enterprise AND
           indadocno = g_inda_d_t.indadocno
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "inda_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ainp501_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM indb_t 
         WHERE indbent = g_enterprise AND
           indbdocno = g_inda_d_t.indadocno
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後 name="delete.after_delete2"
   
   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.input" >}
#+ 資料輸入
PRIVATE FUNCTION ainp501_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point 
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT indastus,inda002,indadocno,indadocdt,inda001,inda003,inda004,indasite, 
       inda005,inda006,indadocno,indaownid,indaowndp,indacrtid,indacrtdp,indacrtdt,indamodid,indamoddt, 
       indacnfid,indacnfdt FROM inda_t WHERE indaent=? AND indadocno=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
  #LET g_forupd_sql = "SELECT tmp_sel,indastus,inda002,'',indadocno,indadocdt,inda001,'',inda003,'',inda004, ",
  #                   "       '',indasite,'',inda005,inda006,'',indaownid,'',indaowndp,'',indacrtid,'',indacrtdp, ",
  #                   "       '',indacrtdt,indamodid,'',indamoddt,indacnfid,'',indacnfdt ",
  #                   "  FROM inda_t,ainp501_tmp ",
  #                   " WHERE indadocno = tmp_indadocno AND indaent=? AND indadocno=? FOR UPDATE "
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ainp501_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT indbseq,indb002,indb001,indb003,indb004,indb005,indb006,indb007,indb008, 
       indb009,indb010,indb011,indb012,indb013 FROM indb_t WHERE indbent=? AND indbdocno=? AND indbseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ainp501_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
      
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:input段修改前 name="input.before_input"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_inda_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inda_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL ainp501_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_inda_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
            LET g_detail_flag = '1'
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_inda_d[l_ac].*
            LET g_master.* = g_inda_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_inda_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inda_d[l_ac].indadocno IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inda_d_t.* = g_inda_d[l_ac].*  #BACKUP
               LET g_inda_d_o.* = g_inda_d[l_ac].*  #BACKUP
               IF NOT ainp501_lock_b("inda_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ainp501_bcl INTO g_inda_d[l_ac].indastus,g_inda_d[l_ac].inda002,g_inda_d[l_ac].indadocno, 
                      g_inda_d[l_ac].indadocdt,g_inda_d[l_ac].inda001,g_inda_d[l_ac].inda003,g_inda_d[l_ac].inda004, 
                      g_inda_d[l_ac].indasite,g_inda_d[l_ac].inda005,g_inda_d[l_ac].inda006,g_inda2_d[l_ac].indadocno, 
                      g_inda2_d[l_ac].indaownid,g_inda2_d[l_ac].indaowndp,g_inda2_d[l_ac].indacrtid, 
                      g_inda2_d[l_ac].indacrtdp,g_inda2_d[l_ac].indacrtdt,g_inda2_d[l_ac].indamodid, 
                      g_inda2_d[l_ac].indamoddt,g_inda2_d[l_ac].indacnfid,g_inda2_d[l_ac].indacnfdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inda_d_t.indadocno,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_inda_d_mask_o[l_ac].* =  g_inda_d[l_ac].*
                  CALL ainp501_inda_t_mask()
                  LET g_inda_d_mask_n[l_ac].* =  g_inda_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL ainp501_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL ainp501_set_entry_b(l_cmd)
            CALL ainp501_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL ainp501_fetch()
            CALL ainp501_idx_chk('m')
 
         BEFORE INSERT
            
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_inda3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inda_d[l_ac].* TO NULL 
            INITIALIZE g_inda_d_t.* TO NULL 
            INITIALIZE g_inda_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inda2_d[l_ac].indaownid = g_user
      LET g_inda2_d[l_ac].indaowndp = g_dept
      LET g_inda2_d[l_ac].indacrtid = g_user
      LET g_inda2_d[l_ac].indacrtdp = g_dept 
      LET g_inda2_d[l_ac].indacrtdt = cl_get_current()
      LET g_inda2_d[l_ac].indamodid = g_user
      LET g_inda2_d[l_ac].indamoddt = cl_get_current()
      LET g_inda_d[l_ac].indastus = ''
 
 
 
                  LET g_inda_d[l_ac].sel = "N"
      LET g_inda_d[l_ac].indastus = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_inda_d_t.* = g_inda_d[l_ac].*     #新輸入資料
            LET g_inda_d_o.* = g_inda_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ainp501_set_entry_b(l_cmd)
            CALL ainp501_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inda_d[li_reproduce_target].* = g_inda_d[li_reproduce].*
               LET g_inda2_d[li_reproduce_target].* = g_inda2_d[li_reproduce].*
 
               LET g_inda_d[g_inda_d.getLength()].indadocno = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM inda_t 
             WHERE indaent = g_enterprise AND indadocno = g_inda_d[l_ac].indadocno 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_d[g_detail_idx].indadocno
               CALL ainp501_insert_b('inda_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_inda_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inda_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ainp501_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_inda_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               DELETE FROM inda_t
                WHERE indaent = g_enterprise AND 
                      indadocno = g_inda_d_t.indadocno
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inda_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_inda_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE ainp501_bcl
               LET l_count = g_inda_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_d_t.indadocno
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ainp501_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL ainp501_delete_b('inda_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inda_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indastus
            #add-point:BEFORE FIELD indastus name="input.b.page1.indastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indastus
            
            #add-point:AFTER FIELD indastus name="input.a.page1.indastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indastus
            #add-point:ON CHANGE indastus name="input.g.page1.indastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda002
            
            #add-point:AFTER FIELD inda002 name="input.a.page1.inda002"
            CALL ainp501_inda002_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda002
            #add-point:BEFORE FIELD inda002 name="input.b.page1.inda002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda002
            #add-point:ON CHANGE inda002 name="input.g.page1.inda002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocno
            #add-point:BEFORE FIELD indadocno name="input.b.page1.indadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocno
            
            #add-point:AFTER FIELD indadocno name="input.a.page1.indadocno"
            #此段落由子樣板a05產生
            IF  g_inda_d[g_detail_idx].indadocno IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inda_d[g_detail_idx].indadocno != g_inda_d_t.indadocno)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inda_t WHERE "||"indaent = '" ||g_enterprise|| "' AND "||"indadocno = '"||g_inda_d[g_detail_idx].indadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indadocno
            #add-point:ON CHANGE indadocno name="input.g.page1.indadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocdt
            #add-point:BEFORE FIELD indadocdt name="input.b.page1.indadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocdt
            
            #add-point:AFTER FIELD indadocdt name="input.a.page1.indadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indadocdt
            #add-point:ON CHANGE indadocdt name="input.g.page1.indadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda001
            
            #add-point:AFTER FIELD inda001 name="input.a.page1.inda001"
            CALL ainp501_inda001_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda001
            #add-point:BEFORE FIELD inda001 name="input.b.page1.inda001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda001
            #add-point:ON CHANGE inda001 name="input.g.page1.inda001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda003
            
            #add-point:AFTER FIELD inda003 name="input.a.page1.inda003"
            IF NOT cl_null(g_inda_d[l_ac].inda003) THEN 

            END IF 
            CALL ainp501_inda003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda003
            #add-point:BEFORE FIELD inda003 name="input.b.page1.inda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda003
            #add-point:ON CHANGE inda003 name="input.g.page1.inda003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda004
            
            #add-point:AFTER FIELD inda004 name="input.a.page1.inda004"
            IF NOT cl_null(g_inda_d[l_ac].inda004) THEN 

            END IF 
            CALL ainp501_inda004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda004
            #add-point:BEFORE FIELD inda004 name="input.b.page1.inda004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda004
            #add-point:ON CHANGE inda004 name="input.g.page1.inda004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indasite
            
            #add-point:AFTER FIELD indasite name="input.a.page1.indasite"
            CALL ainp501_indasite_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indasite
            #add-point:BEFORE FIELD indasite name="input.b.page1.indasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indasite
            #add-point:ON CHANGE indasite name="input.g.page1.indasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda005
            #add-point:BEFORE FIELD inda005 name="input.b.page1.inda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda005
            
            #add-point:AFTER FIELD inda005 name="input.a.page1.inda005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda005
            #add-point:ON CHANGE inda005 name="input.g.page1.inda005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda006
            #add-point:BEFORE FIELD inda006 name="input.b.page1.inda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda006
            
            #add-point:AFTER FIELD inda006 name="input.a.page1.inda006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda006
            #add-point:ON CHANGE inda006 name="input.g.page1.inda006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indastus
            #add-point:ON ACTION controlp INFIELD indastus name="input.c.page1.indastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inda002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda002
            #add-point:ON ACTION controlp INFIELD inda002 name="input.c.page1.inda002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocno
            #add-point:ON ACTION controlp INFIELD indadocno name="input.c.page1.indadocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocdt
            #add-point:ON ACTION controlp INFIELD indadocdt name="input.c.page1.indadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda001
            #add-point:ON ACTION controlp INFIELD inda001 name="input.c.page1.inda001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda_d[l_ac].inda001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_inda_d[l_ac].inda001 = g_qryparam.return1              

            DISPLAY g_inda_d[l_ac].inda001 TO inda001              #

            NEXT FIELD inda001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda003
            #add-point:ON ACTION controlp INFIELD inda003 name="input.c.page1.inda003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda_d[l_ac].inda003             #給予default值
            LET g_qryparam.default2 = "" #g_inda_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = g_site #
            LET g_qryparam.arg2 = "8" #
            
            CALL q_ooed004()                                #呼叫開窗

            LET g_inda_d[l_ac].inda003 = g_qryparam.return1              
            #LET g_inda_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_inda_d[l_ac].inda003 TO inda003              #
            #DISPLAY g_inda_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD inda003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda004
            #add-point:ON ACTION controlp INFIELD inda004 name="input.c.page1.inda004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda_d[l_ac].inda004             #給予default值

			   LET g_qryparam.where = " ooef201 = 'Y' "
            
            CALL q_ooef001()                                #呼叫開窗

            LET g_inda_d[l_ac].inda004 = g_qryparam.return1              

            DISPLAY g_inda_d[l_ac].inda004 TO inda004              #

            NEXT FIELD inda004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indasite
            #add-point:ON ACTION controlp INFIELD indasite name="input.c.page1.indasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda005
            #add-point:ON ACTION controlp INFIELD inda005 name="input.c.page1.inda005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda006
            #add-point:ON ACTION controlp INFIELD inda006 name="input.c.page1.inda006"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inda_d[l_ac].* = g_inda_d_t.*
               CLOSE ainp501_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inda_d[l_ac].indadocno 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inda_d[l_ac].* = g_inda_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_inda2_d[l_ac].indamodid = g_user 
LET g_inda2_d[l_ac].indamoddt = cl_get_current()
LET g_inda2_d[l_ac].indamodid_desc = cl_get_username(g_inda2_d[l_ac].indamodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL ainp501_inda_t_mask_restore('restore_mask_o')
      
               UPDATE inda_t SET (indastus,inda002,indadocno,indadocdt,inda001,inda003,inda004,indasite, 
                   inda005,inda006,indaownid,indaowndp,indacrtid,indacrtdp,indacrtdt,indamodid,indamoddt, 
                   indacnfid,indacnfdt) = (g_inda_d[l_ac].indastus,g_inda_d[l_ac].inda002,g_inda_d[l_ac].indadocno, 
                   g_inda_d[l_ac].indadocdt,g_inda_d[l_ac].inda001,g_inda_d[l_ac].inda003,g_inda_d[l_ac].inda004, 
                   g_inda_d[l_ac].indasite,g_inda_d[l_ac].inda005,g_inda_d[l_ac].inda006,g_inda2_d[l_ac].indaownid, 
                   g_inda2_d[l_ac].indaowndp,g_inda2_d[l_ac].indacrtid,g_inda2_d[l_ac].indacrtdp,g_inda2_d[l_ac].indacrtdt, 
                   g_inda2_d[l_ac].indamodid,g_inda2_d[l_ac].indamoddt,g_inda2_d[l_ac].indacnfid,g_inda2_d[l_ac].indacnfdt) 
 
                WHERE indaent = g_enterprise AND
                  indadocno = g_inda_d_t.indadocno #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_inda_d[l_ac].* = g_inda_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inda_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inda_d[l_ac].* = g_inda_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inda_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_d[g_detail_idx].indadocno
               LET gs_keys_bak[1] = g_inda_d_t.indadocno
               CALL ainp501_update_b('inda_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL ainp501_inda_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_inda_d_t)
                     LET g_log2 = util.JSON.stringify(g_inda_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_inda_d[l_ac].*
               CALL ainp501_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               UPDATE ainp501_tmp 
                  SET tmp_sel = g_inda_d[l_ac].sel
                WHERE tmp_indadocno = g_inda_d[l_ac].indadocno
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL ainp501_unlock_b("inda_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inda_d[l_ac].* = g_inda_d_t.*
               END IF
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_inda_d[l_ac].* = g_inda_d_t.*
            END IF
            LET l_cmd = ''
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()      
            #CALL cl_showmsg()            
    
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_inda_d[li_reproduce_target].* = g_inda_d[li_reproduce].*
               LET g_inda2_d[li_reproduce_target].* = g_inda2_d[li_reproduce].*
 
               LET g_inda_d[li_reproduce_target].indadocno = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inda_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inda_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_inda3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_inda_d[g_detail_idx].indadocno) THEN
               NEXT FIELD sel
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inda3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_inda3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            LET g_detail_flag = '2'
            #end add-point
 
         BEFORE INSERT
            IF g_inda_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD indadocno
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inda3_d[l_ac].* TO NULL 
            INITIALIZE g_inda3_d_t.* TO NULL 
            INITIALIZE g_inda3_d_o.* TO NULL 
                  LET g_inda3_d[l_ac].indb006 = "0"
      LET g_inda3_d[l_ac].indb007 = "0"
      LET g_inda3_d[l_ac].indb008 = "0"
      LET g_inda3_d[l_ac].indb009 = "0"
      LET g_inda3_d[l_ac].indb010 = "0"
      LET g_inda3_d[l_ac].indb011 = "0"
      LET g_inda3_d[l_ac].indb012 = "0"
 
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_inda3_d_t.* = g_inda3_d[l_ac].*     #新輸入資料
            LET g_inda3_d_o.* = g_inda3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ainp501_set_entry_b(l_cmd)
            CALL ainp501_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inda3_d[li_reproduce_target].* = g_inda3_d[li_reproduce].*
 
               LET g_inda3_d[li_reproduce_target].indbseq = NULL
            END IF
            #add-point:input段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET l_insert = FALSE
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_inda3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inda3_d[l_ac].indbseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_inda3_d_t.* = g_inda3_d[l_ac].*  #BACKUP
               LET g_inda3_d_o.* = g_inda3_d[l_ac].*  #BACKUP
               IF NOT ainp501_lock_b("indb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ainp501_bcl2 INTO g_inda3_d[l_ac].indbseq,g_inda3_d[l_ac].indb002,g_inda3_d[l_ac].indb001, 
                      g_inda3_d[l_ac].indb003,g_inda3_d[l_ac].indb004,g_inda3_d[l_ac].indb005,g_inda3_d[l_ac].indb006, 
                      g_inda3_d[l_ac].indb007,g_inda3_d[l_ac].indb008,g_inda3_d[l_ac].indb009,g_inda3_d[l_ac].indb010, 
                      g_inda3_d[l_ac].indb011,g_inda3_d[l_ac].indb012,g_inda3_d[l_ac].indb013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inda3_d_mask_o[l_ac].* =  g_inda3_d[l_ac].*
                  CALL ainp501_indb_t_mask()
                  LET g_inda3_d_mask_n[l_ac].* =  g_inda3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL ainp501_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL ainp501_set_entry_b(l_cmd)
            CALL ainp501_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL ainp501_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point  
               
               DELETE FROM indb_t
                WHERE indbent = g_enterprise AND
                   indbdocno = g_master.indadocno
                   AND indbseq = g_inda3_d_t.indbseq
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ainp501_bcl
               LET l_count = g_inda_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_d[g_detail_idx].indadocno
               LET gs_keys[2] = g_inda3_d_t.indbseq
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL ainp501_delete_b('indb_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inda3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
    
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE   
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM indb_t 
             WHERE indbent = g_enterprise AND
                   indbdocno = g_master.indadocno
                   AND indbseq = g_inda3_d[g_detail_idx2].indbseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_d[g_detail_idx].indadocno
               LET gs_keys[2] = g_inda3_d[g_detail_idx2].indbseq
               CALL ainp501_insert_b('indb_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_inda_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ainp501_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inda3_d[l_ac].* = g_inda3_d_t.*
               CLOSE ainp501_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inda3_d[l_ac].* = g_inda3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL ainp501_indb_t_mask_restore('restore_mask_o')
               
               UPDATE indb_t SET (indbseq,indb002,indb001,indb003,indb004,indb005,indb006,indb007,indb008, 
                   indb009,indb010,indb011,indb012,indb013) = (g_inda3_d[l_ac].indbseq,g_inda3_d[l_ac].indb002, 
                   g_inda3_d[l_ac].indb001,g_inda3_d[l_ac].indb003,g_inda3_d[l_ac].indb004,g_inda3_d[l_ac].indb005, 
                   g_inda3_d[l_ac].indb006,g_inda3_d[l_ac].indb007,g_inda3_d[l_ac].indb008,g_inda3_d[l_ac].indb009, 
                   g_inda3_d[l_ac].indb010,g_inda3_d[l_ac].indb011,g_inda3_d[l_ac].indb012,g_inda3_d[l_ac].indb013)  
                   #自訂欄位頁簽
                WHERE indbent = g_enterprise AND
                   indbdocno = g_master.indadocno
                   AND indbseq = g_inda3_d_t.indbseq
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_inda3_d[l_ac].* = g_inda3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inda3_d[l_ac].* = g_inda3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_d[g_detail_idx].indadocno
               LET gs_keys_bak[1] = g_inda_d[g_detail_idx].indadocno
               LET gs_keys[2] = g_inda3_d[g_detail_idx2].indbseq
               LET gs_keys_bak[2] = g_inda3_d_t.indbseq
               CALL ainp501_update_b('indb_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL ainp501_indb_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_inda3_d_t)
                     LET g_log2 = util.JSON.stringify(g_inda3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbseq
            #add-point:BEFORE FIELD indbseq name="input.b.page3.indbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbseq
            
            #add-point:AFTER FIELD indbseq name="input.a.page3.indbseq"
            #此段落由子樣板a05產生
            IF  g_inda_d[g_detail_idx].indadocno IS NOT NULL AND g_inda3_d[g_detail_idx2].indbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inda_d[g_detail_idx].indadocno != g_inda_d[g_detail_idx].indadocno OR g_inda3_d[g_detail_idx2].indbseq != g_inda3_d_t.indbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indb_t WHERE "||"indbent = '" ||g_enterprise|| "' AND "||"indbdocno = '"||g_inda_d[g_detail_idx].indadocno ||"' AND "|| "indbseq = '"||g_inda3_d[g_detail_idx2].indbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indbseq
            #add-point:ON CHANGE indbseq name="input.g.page3.indbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb002
            #add-point:BEFORE FIELD indb002 name="input.b.page3.indb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb002
            
            #add-point:AFTER FIELD indb002 name="input.a.page3.indb002"
            IF NOT cl_null(g_inda3_d[l_ac].indb002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_imay003") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb002
            #add-point:ON CHANGE indb002 name="input.g.page3.indb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb001
            
            #add-point:AFTER FIELD indb001 name="input.a.page3.indb001"
            IF NOT cl_null(g_inda3_d[l_ac].indb001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #160318-00025#15 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               #160318-00025#15 by 07900 --add-end
               #設定g_chkparam.*的參數

                #160318-00025#15 by 07900 --add-str 
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#15 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_imaa001_5") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL ainp501_indb001_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb001
            #add-point:BEFORE FIELD indb001 name="input.b.page3.indb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb001
            #add-point:ON CHANGE indb001 name="input.g.page3.indb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb003
            #add-point:BEFORE FIELD indb003 name="input.b.page3.indb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb003
            
            #add-point:AFTER FIELD indb003 name="input.a.page3.indb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb003
            #add-point:ON CHANGE indb003 name="input.g.page3.indb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb004
            
            #add-point:AFTER FIELD indb004 name="input.a.page3.indb004"
            IF NOT cl_null(g_inda3_d[l_ac].indb004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #160318-00025#15 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               #160318-00025#15 by 07900 --add-end
               #設定g_chkparam.*的參數

                #160318-00025#15 by 07900 --add-str 
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#15 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL ainp501_indb004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb004
            #add-point:BEFORE FIELD indb004 name="input.b.page3.indb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb004
            #add-point:ON CHANGE indb004 name="input.g.page3.indb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb005
            
            #add-point:AFTER FIELD indb005 name="input.a.page3.indb005"
            IF NOT cl_null(g_inda3_d[l_ac].indb005) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #160318-00025#15 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               #160318-00025#15 by 07900 --add-end
               #設定g_chkparam.*的參數

               #160318-00025#15 by 07900 --add-str 
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#15 by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL ainp501_indb005_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb005
            #add-point:BEFORE FIELD indb005 name="input.b.page3.indb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb005
            #add-point:ON CHANGE indb005 name="input.g.page3.indb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb006
            #add-point:BEFORE FIELD indb006 name="input.b.page3.indb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb006
            
            #add-point:AFTER FIELD indb006 name="input.a.page3.indb006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb006
            #add-point:ON CHANGE indb006 name="input.g.page3.indb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inda3_d[l_ac].indb007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD indb007
            END IF 
 
 
 
            #add-point:AFTER FIELD indb007 name="input.a.page3.indb007"
            IF NOT cl_null(g_inda3_d[l_ac].indb007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb007
            #add-point:BEFORE FIELD indb007 name="input.b.page3.indb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb007
            #add-point:ON CHANGE indb007 name="input.g.page3.indb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inda3_d[l_ac].indb008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD indb008
            END IF 
 
 
 
            #add-point:AFTER FIELD indb008 name="input.a.page3.indb008"
            IF NOT cl_null(g_inda3_d[l_ac].indb008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb008
            #add-point:BEFORE FIELD indb008 name="input.b.page3.indb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb008
            #add-point:ON CHANGE indb008 name="input.g.page3.indb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inda3_d[l_ac].indb009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD indb009
            END IF 
 
 
 
            #add-point:AFTER FIELD indb009 name="input.a.page3.indb009"
            IF NOT cl_null(g_inda3_d[l_ac].indb009) THEN 
               CALL ainp501_indb009_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_inda3_d[l_ac].indb009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_inda3_d[l_ac].indb009 = g_inda3_d_t.indb009
                  DISPLAY BY NAME g_inda3_d[l_ac].indb009
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inda3_d[l_ac].indb009 != g_inda3_d_t.indb009 OR cl_null(g_inda3_d_t.indb009))) THEN
                  CALL ainp501_indb009_init()
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb009
            #add-point:BEFORE FIELD indb009 name="input.b.page3.indb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb009
            #add-point:ON CHANGE indb009 name="input.g.page3.indb009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inda3_d[l_ac].indb010,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD indb010
            END IF 
 
 
 
            #add-point:AFTER FIELD indb010 name="input.a.page3.indb010"
            IF NOT cl_null(g_inda3_d[l_ac].indb010) THEN 
               CALL ainp501_indb010_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_inda3_d[l_ac].indb010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_inda3_d[l_ac].indb010 = g_inda3_d_t.indb010
                  DISPLAY BY NAME g_inda3_d[l_ac].indb010
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inda3_d[l_ac].indb010 != g_inda3_d_t.indb010 OR cl_null(g_inda3_d_t.indb010))) THEN
                  CALL ainp501_indb010_init()
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb010
            #add-point:BEFORE FIELD indb010 name="input.b.page3.indb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb010
            #add-point:ON CHANGE indb010 name="input.g.page3.indb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb011
            #add-point:BEFORE FIELD indb011 name="input.b.page3.indb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb011
            
            #add-point:AFTER FIELD indb011 name="input.a.page3.indb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb011
            #add-point:ON CHANGE indb011 name="input.g.page3.indb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb012
            #add-point:BEFORE FIELD indb012 name="input.b.page3.indb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb012
            
            #add-point:AFTER FIELD indb012 name="input.a.page3.indb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb012
            #add-point:ON CHANGE indb012 name="input.g.page3.indb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb013
            #add-point:BEFORE FIELD indb013 name="input.b.page3.indb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb013
            
            #add-point:AFTER FIELD indb013 name="input.a.page3.indb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb013
            #add-point:ON CHANGE indb013 name="input.g.page3.indb013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.indbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbseq
            #add-point:ON ACTION controlp INFIELD indbseq name="input.c.page3.indbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb002
            #add-point:ON ACTION controlp INFIELD indb002 name="input.c.page3.indb002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda3_d[l_ac].indb002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imay003_3()                                #呼叫開窗

            LET g_inda3_d[l_ac].indb002 = g_qryparam.return1              

            DISPLAY g_inda3_d[l_ac].indb002 TO indb002              #

            NEXT FIELD indb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.indb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb001
            #add-point:ON ACTION controlp INFIELD indb001 name="input.c.page3.indb001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda3_d[l_ac].indb001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaa001()                                #呼叫開窗

            LET g_inda3_d[l_ac].indb001 = g_qryparam.return1              

            DISPLAY g_inda3_d[l_ac].indb001 TO indb001              #

            NEXT FIELD indb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.indb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb003
            #add-point:ON ACTION controlp INFIELD indb003 name="input.c.page3.indb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb004
            #add-point:ON ACTION controlp INFIELD indb004 name="input.c.page3.indb004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda3_d[l_ac].indb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_inda3_d[l_ac].indb004 = g_qryparam.return1              

            DISPLAY g_inda3_d[l_ac].indb004 TO indb004              #

            NEXT FIELD indb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.indb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb005
            #add-point:ON ACTION controlp INFIELD indb005 name="input.c.page3.indb005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda3_d[l_ac].indb005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_inda3_d[l_ac].indb005 = g_qryparam.return1              

            DISPLAY g_inda3_d[l_ac].indb005 TO indb005              #

            NEXT FIELD indb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.indb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb006
            #add-point:ON ACTION controlp INFIELD indb006 name="input.c.page3.indb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb007
            #add-point:ON ACTION controlp INFIELD indb007 name="input.c.page3.indb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb008
            #add-point:ON ACTION controlp INFIELD indb008 name="input.c.page3.indb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb009
            #add-point:ON ACTION controlp INFIELD indb009 name="input.c.page3.indb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb010
            #add-point:ON ACTION controlp INFIELD indb010 name="input.c.page3.indb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb011
            #add-point:ON ACTION controlp INFIELD indb011 name="input.c.page3.indb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb012
            #add-point:ON ACTION controlp INFIELD indb012 name="input.c.page3.indb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.indb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb013
            #add-point:ON ACTION controlp INFIELD indb013 name="input.c.page3.indb013"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inda3_d[l_ac].* = g_inda3_d_t.*
               END IF
               CLOSE ainp501_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL ainp501_unlock_b("indb_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_inda3_d[li_reproduce_target].* = g_inda3_d[li_reproduce].*
 
               LET g_inda3_d[li_reproduce_target].indbseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_inda3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inda3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_inda2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL ainp501_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL ainp501_fetch()
            CALL ainp501_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_inda_d.getLength() THEN
               LET g_detail_idx = g_inda_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_inda_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sel
               WHEN "s_detail2"
                  NEXT FIELD indadocno_2
               WHEN "s_detail3"
                  NEXT FIELD indbseq
 
            END CASE
         ELSE
            NEXT FIELD sel
         END IF
            
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION close
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
   
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
 
   
   #add-point:input段修改後 name="input.after_input"
   
   #end add-point
 
   CLOSE ainp501_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainp501_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where       STRING   #151029-00007#3 151109 by sakura add
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,"inda002")   #151029-00007#3 151109 by sakura add  
   IF cl_null(l_where) THEN
      LET l_where = "1=1"
   END IF
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.indastus,t0.inda002,t0.indadocno,t0.indadocdt,t0.inda001,t0.inda003, 
       t0.inda004,t0.indasite,t0.inda005,t0.inda006,t0.indadocno,t0.indaownid,t0.indaowndp,t0.indacrtid, 
       t0.indacrtdp,t0.indacrtdt,t0.indamodid,t0.indamoddt,t0.indacnfid,t0.indacnfdt ,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooefl003 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , 
       t11.ooag011 FROM inda_t t0",
 
               " LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno",
 
 
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inda002 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inda001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inda003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.inda004 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.indasite AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.indaownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.indaowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.indacrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.indacrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.indamodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.indacnfid  ",
 
               " WHERE t0.indaent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("inda_t"),
                      " ORDER BY t0.indadocno"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE t0.indastus,t0.inda002,t0.indadocno,t0.indadocdt,t0.inda001,t0.inda003, 
       t0.inda004,t0.indasite,t0.inda005,t0.inda006,t0.indadocno,t0.indaownid,t0.indaowndp,t0.indacrtid, 
       t0.indacrtdp,t0.indacrtdt,t0.indamodid,t0.indamoddt,t0.indacnfid,t0.indacnfdt ,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooefl003 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , 
       t11.ooag011 FROM inda_t t0",
 
               " LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno",
 
 
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.inda002 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.inda001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.inda003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.inda004 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.indasite AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.indaownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=t0.indaowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.indacrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.indacrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=t0.indamodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent='"||g_enterprise||"' AND t11.ooag001=t0.indacnfid  ",
 
               " WHERE t0.indaent= ?  AND  1=1 AND (", p_wc2, ") ",
               "   AND t0.inda002 = '",g_site,"' ",
               "   AND ",l_where,            #151029-00007#3 151109 by sakura add
               "   AND t0.indastus = 'Y' "   #151029-00007#3 151109 by sakura add
   
   LET g_sql = g_sql, cl_sql_add_filter("inda_t"),
                      " ORDER BY t0.indadocno"
   
  #LET g_sql = "SELECT UNIQUE indastus,inda002,'',indadocno,indadocdt,inda001,'',inda003,'',inda004, ",
  #            "       '',indasite,'',inda005,inda006,indadocno,indaownid,'',indaowndp,'',indacrtid,'',indacrtdp,'', ", 
  #            "       indacrtdt,indamodid,'',indamoddt,indacnfid,'',indacnfdt ",
  #            "  FROM ainp501_tmp,inda_t ",
  #            "  LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno ",
  #            " WHERE indadocno = tmp_indadocno AND indaent= ? AND inda002 = '",g_site,"' AND ", p_wc2
  # 
  #LET g_sql = g_sql, " ORDER BY inda_t.indadocno"
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"inda_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE ainp501_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainp501_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_inda_d.clear()
   CALL g_inda2_d.clear()   
   CALL g_inda3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_inda_d[l_ac].indastus,g_inda_d[l_ac].inda002,g_inda_d[l_ac].indadocno, 
       g_inda_d[l_ac].indadocdt,g_inda_d[l_ac].inda001,g_inda_d[l_ac].inda003,g_inda_d[l_ac].inda004, 
       g_inda_d[l_ac].indasite,g_inda_d[l_ac].inda005,g_inda_d[l_ac].inda006,g_inda2_d[l_ac].indadocno, 
       g_inda2_d[l_ac].indaownid,g_inda2_d[l_ac].indaowndp,g_inda2_d[l_ac].indacrtid,g_inda2_d[l_ac].indacrtdp, 
       g_inda2_d[l_ac].indacrtdt,g_inda2_d[l_ac].indamodid,g_inda2_d[l_ac].indamoddt,g_inda2_d[l_ac].indacnfid, 
       g_inda2_d[l_ac].indacnfdt,g_inda_d[l_ac].inda002_desc,g_inda_d[l_ac].inda001_desc,g_inda_d[l_ac].inda003_desc, 
       g_inda_d[l_ac].inda004_desc,g_inda_d[l_ac].indasite_desc,g_inda2_d[l_ac].indaownid_desc,g_inda2_d[l_ac].indaowndp_desc, 
       g_inda2_d[l_ac].indacrtid_desc,g_inda2_d[l_ac].indacrtdp_desc,g_inda2_d[l_ac].indamodid_desc, 
       g_inda2_d[l_ac].indacnfid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_detail_flag = '1'
      #end add-point
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   CALL g_inda_d.deleteElement(g_inda_d.getLength())   
   CALL g_inda2_d.deleteElement(g_inda2_d.getLength())
   CALL g_inda3_d.deleteElement(g_inda3_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_inda_d.getLength() THEN
       IF g_inda_d.getLength() > 0 THEN
          LET g_detail_idx = g_inda_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_inda_d.getLength()
      LET g_inda2_d[g_detail_idx].indadocno = g_inda_d[g_detail_idx].indadocno 
      #LET g_inda3_d[g_detail_idx2].indbseq = g_inda_d[g_detail_idx].indadocno 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      LET g_detail_idx = 1
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE ainp501_pb
   
   LET g_loc = 'm'
   CALL ainp501_detail_show() 
   
   LET l_ac = 1
   IF g_inda_d.getLength() > 0 THEN
      CALL ainp501_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inda_d.getLength()
      LET g_inda_d_mask_o[l_ac].* =  g_inda_d[l_ac].*
      CALL ainp501_inda_t_mask()
      LET g_inda_d_mask_n[l_ac].* =  g_inda_d[l_ac].*
   END FOR
   
   LET g_inda2_d_mask_o.* =  g_inda2_d.*
   FOR l_ac = 1 TO g_inda2_d.getLength()
      LET g_inda2_d_mask_o[l_ac].* =  g_inda2_d[l_ac].*
      CALL ainp501_inda_t_mask()
      LET g_inda2_d_mask_n[l_ac].* =  g_inda2_d[l_ac].*
   END FOR
   LET g_inda3_d_mask_o.* =  g_inda3_d.*
   FOR l_ac = 1 TO g_inda3_d.getLength()
      LET g_inda3_d_mask_o[l_ac].* =  g_inda3_d[l_ac].*
      CALL ainp501_indb_t_mask()
      LET g_inda3_d_mask_n[l_ac].* =  g_inda3_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainp501_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_inda_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_inda2_d.clear()
   CALL g_inda3_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.indbseq,t0.indb002,t0.indb001,t0.indb003,t0.indb004,t0.indb005, 
          t0.indb006,t0.indb007,t0.indb008,t0.indb009,t0.indb010,t0.indb011,t0.indb012,t0.indb013 ,t12.imaal003 , 
          t13.oocal003 ,t14.oocal003 FROM indb_t t0",    
                  "",
                                 " LEFT JOIN imaal_t t12 ON t12.imaalent="||g_enterprise||" AND t12.imaal001=t0.indb001 AND t12.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t13 ON t13.oocalent="||g_enterprise||" AND t13.oocal001=t0.indb004 AND t13.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t14 ON t14.oocalent="||g_enterprise||" AND t14.oocal001=t0.indb005 AND t14.oocal002='"||g_dlang||"' ",
 
                  " WHERE t0.indbent=?  AND t0. indbdocno=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.indbseq" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE ainp501_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR ainp501_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise,g_inda_d[l_ac].indadocno   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise,g_inda_d[l_ac].indadocno INTO g_inda3_d[l_ac].indbseq,g_inda3_d[l_ac].indb002, 
#    g_inda3_d[l_ac].indb001,g_inda3_d[l_ac].indb003,g_inda3_d[l_ac].indb004,g_inda3_d[l_ac].indb005, 
#    g_inda3_d[l_ac].indb006,g_inda3_d[l_ac].indb007,g_inda3_d[l_ac].indb008,g_inda3_d[l_ac].indb009, 
#    g_inda3_d[l_ac].indb010,g_inda3_d[l_ac].indb011,g_inda3_d[l_ac].indb012,g_inda3_d[l_ac].indb013, 
#    g_inda3_d[l_ac].indb001_desc,g_inda3_d[l_ac].indb004_desc,g_inda3_d[l_ac].indb005_desc   #(ver:45)  
#    #(ver:46)mark
   FOREACH b_fill_curs2 USING g_enterprise,g_inda_d[g_detail_idx].indadocno INTO g_inda3_d[l_ac].indbseq, 
       g_inda3_d[l_ac].indb002,g_inda3_d[l_ac].indb001,g_inda3_d[l_ac].indb003,g_inda3_d[l_ac].indb004, 
       g_inda3_d[l_ac].indb005,g_inda3_d[l_ac].indb006,g_inda3_d[l_ac].indb007,g_inda3_d[l_ac].indb008, 
       g_inda3_d[l_ac].indb009,g_inda3_d[l_ac].indb010,g_inda3_d[l_ac].indb011,g_inda3_d[l_ac].indb012, 
       g_inda3_d[l_ac].indb013,g_inda3_d[l_ac].indb001_desc,g_inda3_d[l_ac].indb004_desc,g_inda3_d[l_ac].indb005_desc  
         #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      LET g_detail_flag = '2'
      CALL ainp501_detail_show()
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point
   
   #CALL g_inda2_d.deleteElement(g_inda2_d.getLength())   
   CALL g_inda3_d.deleteElement(g_inda3_d.getLength())   
 
   
   LET g_inda3_d_mask_o.* =  g_inda3_d.*
   FOR l_ac = 1 TO g_inda3_d.getLength()
      LET g_inda3_d_mask_o[l_ac].* =  g_inda3_d[l_ac].*
      CALL ainp501_indb_t_mask()
      LET g_inda3_d_mask_n[l_ac].* =  g_inda3_d[l_ac].*
   END FOR
 
   
   DISPLAY g_inda3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL ainp501_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainp501_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   #帶出公用欄位reference值page3
   
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_inda_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"
   IF g_detail_flag = '1' THEN
      CALL ainp501_sel_init()
      CALL ainp501_inda001_ref()
      CALL ainp501_inda002_ref()
      CALL ainp501_inda003_ref()
      CALL ainp501_inda004_ref()
      CALL ainp501_indasite_ref()
   END IF
   IF g_detail_flag = '2' THEN
      CALL ainp501_indb001_ref()
      CALL ainp501_indb004_ref()
      CALL ainp501_indb005_ref()
   END IF
  #END CASE
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
   IF g_detail_flag = '1' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda2_d[l_ac].indaownid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_inda2_d[l_ac].indaownid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda2_d[l_ac].indaownid_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda2_d[l_ac].indaowndp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_inda2_d[l_ac].indaowndp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda2_d[l_ac].indaowndp_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda2_d[l_ac].indacrtid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_inda2_d[l_ac].indacrtid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda2_d[l_ac].indacrtid_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda2_d[l_ac].indacrtdp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_inda2_d[l_ac].indacrtdp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda2_d[l_ac].indacrtdp_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda2_d[l_ac].indamodid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_inda2_d[l_ac].indamodid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda2_d[l_ac].indamodid_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda2_d[l_ac].indacnfid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_inda2_d[l_ac].indacnfid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda2_d[l_ac].indacnfid_desc
   END IF
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_inda3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
   IF g_detail_flag = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda3_d[l_ac].indb001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_inda3_d[l_ac].indb001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda3_d[l_ac].indb001_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda3_d[l_ac].indb004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_inda3_d[l_ac].indb004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda3_d[l_ac].indb004_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_inda3_d[l_ac].indb005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_inda3_d[l_ac].indb005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_inda3_d[l_ac].indb005_desc
   END IF
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="ainp501.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ainp501_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="ainp501.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ainp501_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
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
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="ainp501.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ainp501_default_search()
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
      LET ls_wc = ls_wc, " indadocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=2"
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   #151029-00007#3 151103 by sakura add(S)
   IF g_wc = " 1=2" THEN
      LET g_wc = " 1=1"
   END IF
   #151029-00007#3 151103 by sakura add(E)
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ainp501.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ainp501_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
  
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "inda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM inda_t
       WHERE indaent = g_enterprise AND
         indadocno = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete"
      
      #end add-point  
   END IF
   
 
   
   LET ls_group = "indb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM indb_t
       WHERE indbent = g_enterprise AND
         indbdocno = ps_keys_bak[1] AND indbseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "inda_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM indb_t
       WHERE indbent = g_enterprise AND
         indbdocno = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_body_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ainp501_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "inda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO inda_t
                  (indaent,
                   indadocno
                   ,indastus,inda002,indadocdt,inda001,inda003,inda004,indasite,inda005,inda006,indaownid,indaowndp,indacrtid,indacrtdp,indacrtdt,indamodid,indamoddt,indacnfid,indacnfdt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_inda_d[g_detail_idx].indastus,g_inda_d[g_detail_idx].inda002,g_inda_d[g_detail_idx].indadocdt, 
                       g_inda_d[g_detail_idx].inda001,g_inda_d[g_detail_idx].inda003,g_inda_d[g_detail_idx].inda004, 
                       g_inda_d[g_detail_idx].indasite,g_inda_d[g_detail_idx].inda005,g_inda_d[g_detail_idx].inda006, 
                       g_inda2_d[g_detail_idx].indaownid,g_inda2_d[g_detail_idx].indaowndp,g_inda2_d[g_detail_idx].indacrtid, 
                       g_inda2_d[g_detail_idx].indacrtdp,g_inda2_d[g_detail_idx].indacrtdt,g_inda2_d[g_detail_idx].indamodid, 
                       g_inda2_d[g_detail_idx].indamoddt,g_inda2_d[g_detail_idx].indacnfid,g_inda2_d[g_detail_idx].indacnfdt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inda_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "indb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
      #end add-point
      INSERT INTO indb_t
                  (indbent,
                   indbdocno,indbseq
                   ,indb002,indb001,indb003,indb004,indb005,indb006,indb007,indb008,indb009,indb010,indb011,indb012,indb013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_inda3_d[g_detail_idx2].indb002,g_inda3_d[g_detail_idx2].indb001,g_inda3_d[g_detail_idx2].indb003, 
                       g_inda3_d[g_detail_idx2].indb004,g_inda3_d[g_detail_idx2].indb005,g_inda3_d[g_detail_idx2].indb006, 
                       g_inda3_d[g_detail_idx2].indb007,g_inda3_d[g_detail_idx2].indb008,g_inda3_d[g_detail_idx2].indb009, 
                       g_inda3_d[g_detail_idx2].indb010,g_inda3_d[g_detail_idx2].indb011,g_inda3_d[g_detail_idx2].indb012, 
                       g_inda3_d[g_detail_idx2].indb013)
      #add-point:insert_b段新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         RETURN
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ainp501_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
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
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "inda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "inda_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL ainp501_inda_t_mask_restore('restore_mask_o')
               
      UPDATE inda_t 
         SET (indadocno
              ,indastus,inda002,indadocdt,inda001,inda003,inda004,indasite,inda005,inda006,indaownid,indaowndp,indacrtid,indacrtdp,indacrtdt,indamodid,indamoddt,indacnfid,indacnfdt) 
              = 
             (ps_keys[1]
              ,g_inda_d[g_detail_idx].indastus,g_inda_d[g_detail_idx].inda002,g_inda_d[g_detail_idx].indadocdt, 
                  g_inda_d[g_detail_idx].inda001,g_inda_d[g_detail_idx].inda003,g_inda_d[g_detail_idx].inda004, 
                  g_inda_d[g_detail_idx].indasite,g_inda_d[g_detail_idx].inda005,g_inda_d[g_detail_idx].inda006, 
                  g_inda2_d[g_detail_idx].indaownid,g_inda2_d[g_detail_idx].indaowndp,g_inda2_d[g_detail_idx].indacrtid, 
                  g_inda2_d[g_detail_idx].indacrtdp,g_inda2_d[g_detail_idx].indacrtdt,g_inda2_d[g_detail_idx].indamodid, 
                  g_inda2_d[g_detail_idx].indamoddt,g_inda2_d[g_detail_idx].indacnfid,g_inda2_d[g_detail_idx].indacnfdt)  
 
         WHERE indaent = g_enterprise AND
               indadocno = ps_keys_bak[1]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inda_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inda_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL ainp501_inda_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "indb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "indb_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL ainp501_indb_t_mask_restore('restore_mask_o')
      
      UPDATE indb_t 
         SET (indbdocno,indbseq
              ,indb002,indb001,indb003,indb004,indb005,indb006,indb007,indb008,indb009,indb010,indb011,indb012,indb013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_inda3_d[g_detail_idx2].indb002,g_inda3_d[g_detail_idx2].indb001,g_inda3_d[g_detail_idx2].indb003, 
                  g_inda3_d[g_detail_idx2].indb004,g_inda3_d[g_detail_idx2].indb005,g_inda3_d[g_detail_idx2].indb006, 
                  g_inda3_d[g_detail_idx2].indb007,g_inda3_d[g_detail_idx2].indb008,g_inda3_d[g_detail_idx2].indb009, 
                  g_inda3_d[g_detail_idx2].indb010,g_inda3_d[g_detail_idx2].indb011,g_inda3_d[g_detail_idx2].indb012, 
                  g_inda3_d[g_detail_idx2].indb013) 
         WHERE indbent = g_enterprise AND
               indbdocno = ps_keys_bak[1] AND indbseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ainp501_indb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION ainp501_key_update_b()
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)   #(ver:44)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.indadocno <> g_master_t.indadocno THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE indb_t 
      SET (indbdocno) 
           = 
          (g_master.indadocno) 
      WHERE indbent = g_enterprise AND
           indbdocno = g_master_t.indadocno
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後 name="key_update_b.after_update2"
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ainp501_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL ainp501_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "inda_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ainp501_bcl USING g_enterprise,
                                       g_inda_d[g_detail_idx].indadocno
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ainp501_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "indb_t,"
   #僅鎖定自身table
   LET ls_group = "indb_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ainp501_bcl2 USING g_enterprise,
                                             g_master.indadocno,
                                             g_inda3_d[g_detail_idx2].indbseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ainp501_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ainp501.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ainp501_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE ainp501_bcl
   END IF
   
 
    
   LET ls_group = "indb_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE ainp501_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ainp501.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION ainp501_idx_chk(ps_loc)
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_inda_d.getLength() THEN
         LET g_detail_idx = g_inda_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inda_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_inda_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_inda2_d.getLength() THEN
         LET g_detail_idx = g_inda2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inda2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_inda2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_inda3_d.getLength() THEN
         LET g_detail_idx2 = g_inda3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inda3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_inda3_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_inda3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inda3_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ainp501.mask_functions" >}
&include "erp/ain/ainp501_mask.4gl"
 
{</section>}
 
{<section id="ainp501.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ainp501_set_pk_array()
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
   LET g_pk_array[1].values = g_inda_d[g_detail_idx].indadocno
   LET g_pk_array[1].column = 'indadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ainp501.state_change" >}
    
 
{</section>}
 
{<section id="ainp501.func_signature" >}
   
 
{</section>}
 
{<section id="ainp501.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="ainp501.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION ainp501_inda002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_d[l_ac].inda002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_d[l_ac].inda002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_d[l_ac].inda002_desc
END FUNCTION
#+
PRIVATE FUNCTION ainp501_inda001_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_d[l_ac].inda001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inda_d[l_ac].inda001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_d[l_ac].inda001_desc
END FUNCTION
#+
PRIVATE FUNCTION ainp501_inda003_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_d[l_ac].inda003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_d[l_ac].inda003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_d[l_ac].inda003_desc
END FUNCTION
#+
PRIVATE FUNCTION ainp501_inda004_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_d[l_ac].inda004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_d[l_ac].inda004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_d[l_ac].inda004_desc
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indasite_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_d[l_ac].indasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_d[l_ac].indasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_d[l_ac].indasite_desc
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indb001_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda3_d[l_ac].indb001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda3_d[l_ac].indb001_desc = '', g_rtn_fields[1] , ''
   LET g_inda3_d[l_ac].indb001_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inda3_d[l_ac].indb001_desc
   DISPLAY BY NAME g_inda3_d[l_ac].indb001_desc_1
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indb004_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda3_d[l_ac].indb004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda3_d[l_ac].indb004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda3_d[l_ac].indb004_desc
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indb005_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda3_d[l_ac].indb005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda3_d[l_ac].indb005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda3_d[l_ac].indb005_desc
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indb009_chk()
   
   INITIALIZE g_errno TO NULL

   IF cl_null(g_inda3_d[l_ac].indb006) OR cl_null(g_inda3_d[l_ac].indb009) THEN
      RETURN
   END IF

   IF g_inda3_d[l_ac].indb006 * g_inda3_d[l_ac].indb009 > g_inda3_d[l_ac].indb008 THEN
      LET g_errno = 'agc-00088' #核准數量不可以大於申請數量，請重新輸入
   END IF
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indb009_init()
   
   IF cl_null(g_inda3_d[l_ac].indb006) OR cl_null(g_inda3_d[l_ac].indb009) THEN
      RETURN
   END IF

   LET g_inda3_d[l_ac].indb010 = g_inda3_d[l_ac].indb006 * g_inda3_d[l_ac].indb009
   DISPLAY BY NAME g_inda3_d[l_ac].indb010
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indb010_chk()
   INITIALIZE g_errno TO NULL

   IF cl_null(g_inda3_d[l_ac].indb008) OR cl_null(g_inda3_d[l_ac].indb010) THEN
      RETURN
   END IF

   IF g_inda3_d[l_ac].indb010 > g_inda3_d[l_ac].indb008 THEN
      LET g_errno = 'agc-00088' #核准數量不可以大於申請數量，請重新輸入
   END IF
END FUNCTION
#+
PRIVATE FUNCTION ainp501_indb010_init()
   
   IF cl_null(g_inda3_d[l_ac].indb006) OR cl_null(g_inda3_d[l_ac].indb010) THEN
      RETURN
   END IF

   LET g_inda3_d[l_ac].indb009 = g_inda3_d[l_ac].indb010/g_inda3_d[l_ac].indb006
   DISPLAY BY NAME g_inda3_d[l_ac].indb009
END FUNCTION
#+
PRIVATE FUNCTION ainp501_batch_confirm()
DEFINE l_sql       STRING
#DEFINE l_inda      RECORD LIKE inda_t.*   #161104-00002#4 20161107 mark by beckxie
#161104-00002#4 20161107 add by beckxie---S
DEFINE l_inda    RECORD                 #調撥申請單單頭檔
       indaent   LIKE inda_t.indaent,   #企業編號
       indasite  LIKE inda_t.indasite,  #營運據點
       indaunit  LIKE inda_t.indaunit,  #應用組織
       indadocno LIKE inda_t.indadocno, #單號
       indadocdt LIKE inda_t.indadocdt, #單據日期
       inda001   LIKE inda_t.inda001,   #申請人員
       inda002   LIKE inda_t.inda002,   #上級組織
       inda003   LIKE inda_t.inda003,   #撥出組織
       inda004   LIKE inda_t.inda004,   #撥入組織
       inda005   LIKE inda_t.inda005,   #調撥日期
       inda006   LIKE inda_t.inda006,   #備註
       indaownid LIKE inda_t.indaownid, #資料所有者
       indaowndp LIKE inda_t.indaowndp, #資料所屬部門
       indacrtid LIKE inda_t.indacrtid, #資料建立者
       indacrtdp LIKE inda_t.indacrtdp, #資料建立部門
       indacrtdt LIKE inda_t.indacrtdt, #資料創建日
       indamodid LIKE inda_t.indamodid, #資料修改者
       indamoddt LIKE inda_t.indamoddt, #最近修改日
       indacnfid LIKE inda_t.indacnfid, #資料確認者
       indacnfdt LIKE inda_t.indacnfdt, #資料確認日
       indastus  LIKE inda_t.indastus,  #狀態碼
       inda101   LIKE inda_t.inda101,   #申請部門
       inda102   LIKE inda_t.inda102,   #檢驗方式
       inda103   LIKE inda_t.inda103,   #包裝單製作
       inda104   LIKE inda_t.inda104,   #Invoice製作
       inda105   LIKE inda_t.inda105,   #送貨地址編號
       inda106   LIKE inda_t.inda106,   #運輸方式
       inda107   LIKE inda_t.inda107,   #交運地點
       inda108   LIKE inda_t.inda108,   #交運終點
       inda109   LIKE inda_t.inda109,   #調撥方式
       inda151   LIKE inda_t.inda151,   #理由碼
       indaud001 LIKE inda_t.indaud001, #自定義欄位(文字)001       #161123-00042#4 20161123 add by beckxie---S
       indaud002 LIKE inda_t.indaud002, #自定義欄位(文字)002
       indaud003 LIKE inda_t.indaud003, #自定義欄位(文字)003
       indaud004 LIKE inda_t.indaud004, #自定義欄位(文字)004
       indaud005 LIKE inda_t.indaud005, #自定義欄位(文字)005
       indaud006 LIKE inda_t.indaud006, #自定義欄位(文字)006
       indaud007 LIKE inda_t.indaud007, #自定義欄位(文字)007
       indaud008 LIKE inda_t.indaud008, #自定義欄位(文字)008
       indaud009 LIKE inda_t.indaud009, #自定義欄位(文字)009
       indaud010 LIKE inda_t.indaud010, #自定義欄位(文字)010
       indaud011 LIKE inda_t.indaud011, #自定義欄位(數字)011
       indaud012 LIKE inda_t.indaud012, #自定義欄位(數字)012
       indaud013 LIKE inda_t.indaud013, #自定義欄位(數字)013
       indaud014 LIKE inda_t.indaud014, #自定義欄位(數字)014
       indaud015 LIKE inda_t.indaud015, #自定義欄位(數字)015
       indaud016 LIKE inda_t.indaud016, #自定義欄位(數字)016
       indaud017 LIKE inda_t.indaud017, #自定義欄位(數字)017
       indaud018 LIKE inda_t.indaud018, #自定義欄位(數字)018
       indaud019 LIKE inda_t.indaud019, #自定義欄位(數字)019
       indaud020 LIKE inda_t.indaud020, #自定義欄位(數字)020
       indaud021 LIKE inda_t.indaud021, #自定義欄位(日期時間)021
       indaud022 LIKE inda_t.indaud022, #自定義欄位(日期時間)022
       indaud023 LIKE inda_t.indaud023, #自定義欄位(日期時間)023
       indaud024 LIKE inda_t.indaud024, #自定義欄位(日期時間)024
       indaud025 LIKE inda_t.indaud025, #自定義欄位(日期時間)025
       indaud026 LIKE inda_t.indaud026, #自定義欄位(日期時間)026
       indaud027 LIKE inda_t.indaud027, #自定義欄位(日期時間)027
       indaud028 LIKE inda_t.indaud028, #自定義欄位(日期時間)028
       indaud029 LIKE inda_t.indaud029, #自定義欄位(日期時間)029
       indaud030 LIKE inda_t.indaud030, #自定義欄位(日期時間)030   #161123-00042#4 20161123 add by beckxie---E
       inda007   LIKE inda_t.inda007    #單一單位庫存單位變更
END RECORD
#161104-00002#4 20161107 add by beckxie---E
DEFINE l_success   LIKE type_t.num5
DEFINE l_errno     LIKE type_t.chr10
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_cnt       LIKE type_t.num10

   #检查是否勾选
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM ainp501_tmp
    WHERE tmp_sel = 'Y'
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00170'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
 #未选取需审核的资料
      RETURN
   END IF

   IF NOT cl_ask_confirm('ain-00169') THEN
      RETURN
   END IF
   LET l_flag = 'Y'
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   #LET l_sql = "SELECT inda_t.* ",   #161104-00002#4 20161108 mark by beckxie
   #161104-00002#4 20161108 add by beckxie---S
   LET l_sql = "SELECT indaent,indasite,indaunit,indadocno,indadocdt, ",
               "       inda001,inda002,inda003,inda004,inda005, ",
               "       inda006,indaownid,indaowndp,indacrtid,indacrtdp, ",
               "       indacrtdt,indamodid,indamoddt,indacnfid,indacnfdt, ",
               "       indastus,inda101,inda102,inda103,inda104, ",
               "       inda105,inda106,inda107,inda108,inda109, ",
               "       inda151,",
               #161123-00042#4 20161123 add by beckxie---S
               "       indaud001,indaud002,indaud003,indaud004,indaud005, ",
               "       indaud006,indaud007,indaud008,indaud009,indaud010, ",
               "       indaud011,indaud012,indaud013,indaud014,indaud015, ",
               "       indaud016,indaud017,indaud018,indaud019,indaud020, ",
               "       indaud021,indaud022,indaud023,indaud024,indaud025, ",
               "       indaud026,indaud027,indaud028,indaud029,indaud030, ",
               #161123-00042#4 20161123 add by beckxie---E
               "       inda007 ",   
   #161104-00002#4 20161108 add by beckxie---E
               "  FROM inda_t,ainp501_tmp ",
               " WHERE indadocno = tmp_indadocno ",
               "   AND indaent = '",g_enterprise,"' AND tmp_sel = 'Y' "
   PREPARE ainp501_sel_inda_pre FROM l_sql
   DECLARE ainp501_sel_inda_cs CURSOR FOR ainp501_sel_inda_pre
   #FOREACH ainp501_sel_inda_cs INTO l_inda.*   #161104-00002#4 20161108 mark by beckxie
   #161104-00002#4 20161108 add by beckxie---S
   FOREACH ainp501_sel_inda_cs INTO l_inda.indaent,l_inda.indasite,l_inda.indaunit,l_inda.indadocno,l_inda.indadocdt,
                                    l_inda.inda001,l_inda.inda002,l_inda.inda003,l_inda.inda004,l_inda.inda005,
                                    l_inda.inda006,l_inda.indaownid,l_inda.indaowndp,l_inda.indacrtid,l_inda.indacrtdp,
                                    l_inda.indacrtdt,l_inda.indamodid,l_inda.indamoddt,l_inda.indacnfid,l_inda.indacnfdt,
                                    l_inda.indastus,l_inda.inda101,l_inda.inda102,l_inda.inda103,l_inda.inda104,
                                    l_inda.inda105,l_inda.inda106,l_inda.inda107,l_inda.inda108,l_inda.inda109,
                                    l_inda.inda151,
                                    #161123-00042#4 20161123 add by beckxie---S
                                    l_inda.indaud001,l_inda.indaud002,l_inda.indaud003,l_inda.indaud004,l_inda.indaud005,
                                    l_inda.indaud006,l_inda.indaud007,l_inda.indaud008,l_inda.indaud009,l_inda.indaud010,
                                    l_inda.indaud011,l_inda.indaud012,l_inda.indaud013,l_inda.indaud014,l_inda.indaud015,
                                    l_inda.indaud016,l_inda.indaud017,l_inda.indaud018,l_inda.indaud019,l_inda.indaud020,
                                    l_inda.indaud021,l_inda.indaud022,l_inda.indaud023,l_inda.indaud024,l_inda.indaud025,
                                    l_inda.indaud026,l_inda.indaud027,l_inda.indaud028,l_inda.indaud029,l_inda.indaud030,
                                    #161123-00042#4 20161123 add by beckxie---E
                                    l_inda.inda007
   #161104-00002#4 20161108 add by beckxie---E   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Sel inda_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #审核前检查
      CALL s_aint500_approve_chk(l_inda.indadocno,l_inda.indastus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         LET l_flag = 'N'
         CALL cl_errmsg('indadocno',l_inda.indadocno,'',l_errno,1)
      ELSE
         #审核
         CALL s_aint500_approve_upd(l_inda.indadocno) RETURNING l_success
         IF NOT l_success THEN
            LET l_flag = 'N'
         END IF
      END IF
      
      #初始化
      INITIALIZE l_inda.* TO NULL
      LET l_success = TRUE
      LET l_errno   = ''
   END FOREACH
   
   IF l_flag = 'N' THEN
      CALL cl_showmsg()
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
   CALL ainp501_tmp_ins()
   CALL ainp501_b_fill(g_wc)
   
END FUNCTION
#+
PRIVATE FUNCTION ainp501_tmp_ins()
   DELETE FROM ainp501_tmp
   
   INSERT INTO ainp501_tmp
     SELECT 'N',indadocno
       FROM inda_t
      WHERE indaent = g_enterprise
        AND indastus = 'Y'
END FUNCTION
#+
PRIVATE FUNCTION ainp501_sel_init()
DEFINE l_n   LIKE type_t.num5
   
   LET l_n = 0   
   SELECT COUNT(*) INTO l_n    
     FROM ainp501_tmp 
    WHERE tmp_indadocno = g_inda_d[l_ac].indadocno
   IF l_n = 0 THEN
      INSERT INTO ainp501_tmp(tmp_sel,tmp_indadocno) VALUES('N',g_inda_d[l_ac].indadocno)
   END IF
   
   SELECT tmp_sel INTO g_inda_d[l_ac].sel
     FROM ainp501_tmp 
    WHERE tmp_indadocno = g_inda_d[l_ac].indadocno
END FUNCTION

################################################################################
# Descriptions...: 建立tmp table
# Memo...........: 
# Usage..........: CALL ainp501_create_temp()
#                  RETURNING r_success
# Return code....: r_success     TRUE/FALSE
# Date & Author..: 2015/09/15 By sakura
# Modify.........: 
################################################################################
PRIVATE FUNCTION ainp501_create_temp()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT ainp501_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE ainp501_tmp(
                          tmp_sel        VARCHAR(1),
                          tmp_indadocno  VARCHAR(20))   
   
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ainp501_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除tmp table
# Memo...........:
# Usage..........: CALL ainp501_drop_temp()
#                  RETURNING r_success
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/09/15 By sakura
# Modify.........: 
################################################################################
PRIVATE FUNCTION ainp501_drop_temp()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE ainp501_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop ainp501_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
