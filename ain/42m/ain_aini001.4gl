#該程式未解開Section, 採用最新樣板產出!
{<section id="aini001.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2017-02-15 15:48:49), PR版次:0019(2017-02-15 15:50:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000419
#+ Filename...: aini001
#+ Description: 庫位資料維護作業
#+ Creator....: 02294(2013-07-26 11:01:32)
#+ Modifier...: 06978 -SD/PR- 06978
 
{</section>}
 
{<section id="aini001.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#21  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#23   16/04/22  BY 07900   校验代码重复错误讯息的修改
#160315-00023#1   2016/05/17 By lixiang 结算库位开窗时，若据点参数未设定库位tag,不加限定条件
#160604-00037#1   2016/06/08 By ywtsai  修正更新庫位儲位時，儲位名稱不可帶入庫位名稱
#160707-00008#1   2016/07/12 By ywtsai  異動規格，庫存管理頁籤將儲位編號隱藏取消，並設定為不可編輯與查詢
#160808-00001#1   2016/08/19 By lixh    开窗变量初始化
#160905-00007#4   2016/09/05 by 08172   调整系统中无ENT的SQL条件增加ent
#161019-00017#1   2016/10/20 By lixh    组织类型调整 q_ooef001 => q_ooeg001_8
#161124-00048#3   2016/12/08 By 08734   星号整批调整
#170116-00013#1   2017/02/15 By ywtsai  規格將儲位編號隱藏，取資料時僅取得儲位編號為空白的資料
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
PRIVATE TYPE type_g_inaa_d RECORD
       inaastus LIKE inaa_t.inaastus, 
   inaa001 LIKE inaa_t.inaa001, 
   inaa001_desc LIKE type_t.chr500, 
   inaa001_desc_desc LIKE type_t.chr10, 
   inaa005 LIKE inaa_t.inaa005, 
   inaa018 LIKE inaa_t.inaa018, 
   inaa018_desc LIKE type_t.chr500, 
   inaa006 LIKE inaa_t.inaa006, 
   inaa007 LIKE inaa_t.inaa007, 
   inaa008 LIKE inaa_t.inaa008, 
   inaa009 LIKE inaa_t.inaa009, 
   inaa010 LIKE inaa_t.inaa010, 
   inaa014 LIKE inaa_t.inaa014, 
   inaa015 LIKE inaa_t.inaa015, 
   inaa017 LIKE inaa_t.inaa017, 
   inaa016 LIKE inaa_t.inaa016, 
   inaa011 LIKE inaa_t.inaa011, 
   inaa012 LIKE inaa_t.inaa012, 
   inaa013 LIKE inaa_t.inaa013
       END RECORD
PRIVATE TYPE type_g_inaa2_d RECORD
       inaa001 LIKE inaa_t.inaa001, 
   inaamodid LIKE inaa_t.inaamodid, 
   inaamodid_desc LIKE type_t.chr500, 
   inaamoddt DATETIME YEAR TO SECOND, 
   inaaownid LIKE inaa_t.inaaownid, 
   inaaownid_desc LIKE type_t.chr500, 
   inaaowndp LIKE inaa_t.inaaowndp, 
   inaaowndp_desc LIKE type_t.chr500, 
   inaacrtid LIKE inaa_t.inaacrtid, 
   inaacrtid_desc LIKE type_t.chr500, 
   inaacrtdp LIKE inaa_t.inaacrtdp, 
   inaacrtdp_desc LIKE type_t.chr500, 
   inaacrtdt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_inaa3_d RECORD
       inac002 LIKE inac_t.inac002, 
   inac003 LIKE inac_t.inac003, 
   inac003_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE  g_flag          LIKE type_t.num5   #庫存標籤新增多筆
DEFINE  g_flag2         LIKE type_t.num5   #庫位新增多筆
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_inaa_d
DEFINE g_master_t                   type_g_inaa_d
DEFINE g_inaa_d          DYNAMIC ARRAY OF type_g_inaa_d
DEFINE g_inaa_d_t        type_g_inaa_d
DEFINE g_inaa_d_o        type_g_inaa_d
DEFINE g_inaa_d_mask_o   DYNAMIC ARRAY OF type_g_inaa_d #轉換遮罩前資料
DEFINE g_inaa_d_mask_n   DYNAMIC ARRAY OF type_g_inaa_d #轉換遮罩後資料
DEFINE g_inaa2_d          DYNAMIC ARRAY OF type_g_inaa2_d
DEFINE g_inaa2_d_t        type_g_inaa2_d
DEFINE g_inaa2_d_o        type_g_inaa2_d
DEFINE g_inaa2_d_mask_o   DYNAMIC ARRAY OF type_g_inaa2_d #轉換遮罩前資料
DEFINE g_inaa2_d_mask_n   DYNAMIC ARRAY OF type_g_inaa2_d #轉換遮罩後資料
DEFINE g_inaa3_d          DYNAMIC ARRAY OF type_g_inaa3_d
DEFINE g_inaa3_d_t        type_g_inaa3_d
DEFINE g_inaa3_d_o        type_g_inaa3_d
DEFINE g_inaa3_d_mask_o   DYNAMIC ARRAY OF type_g_inaa3_d #轉換遮罩前資料
DEFINE g_inaa3_d_mask_n   DYNAMIC ARRAY OF type_g_inaa3_d #轉換遮罩後資料
 
      
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
 
{<section id="aini001.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   LET g_flag = FALSE
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aini001 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aini001_init()   
 
      #進入選單 Menu (="N")
      CALL aini001_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aini001
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aini001.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aini001_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   
      CALL cl_set_combo_scc('inaa007','2050') 
 
   LET l_ac = 1
   
 
 
   
 
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_inaa_d.getLength() > 0 THEN
      LET g_master_t.* = g_inaa_d[1].*
      LET g_master.* = g_inaa_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_detail_idx = 1
   
   CALL cl_set_comp_visible("inaa013",FALSE)
   #end add-point
   
   CALL aini001_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aini001.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aini001_ui_dialog()
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
   DEFINE l_inaa004 LIKE inaa_t.inaa004
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
         CALL g_inaa_d.clear()
         CALL g_inaa2_d.clear()
         CALL g_inaa3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aini001_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      
      #end add-point
   
      CALL aini001_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_inaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL aini001_fetch()
               CALL aini001_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aini001_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_inaa2_d TO s_detail2.*
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
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL aini001_fetch()
               CALL aini001_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aini001_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_inaa3_d TO s_detail3.*
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
               CALL aini001_idx_chk('d')
               LET g_master.* = g_inaa_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_inaa_d.getLength() THEN
                  LET g_detail_idx = g_inaa_d.getLength()
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
            LET g_export_node[1] = base.typeInfo.create(g_inaa_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_inaa2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_inaa3_d)
            LET g_export_id[3]   = "s_detail3"
 
            #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               #browser
               -----2015-1-9 zj mod
               CALL g_export_node.clear()
               LET g_main_hidden = 0
               LET g_export_node[1] = base.typeInfo.create(g_inaa_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel
               LET g_export_node[2] = base.typeInfo.create(g_inaa2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_inaa3_d)
               LET g_export_id[3]   = "s_detail3"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
               -----2015-1-9 zj mod
               

        
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
         
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aini001_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aini001_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               
               #add-point:ON ACTION delete name="menu.delete"
               CALL aini001_delete()
               CALL aini001_b_fill(g_wc)
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aini001_insert()
               #add-point:ON ACTION insert name="menu.insert"
               LET g_insert = 'Y'
               CALL aini001_input('a')
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
               CALL aini001_query()
               #add-point:ON ACTION query name="menu.query"
               #IF g_master_idx > 0 THEN
               #   CALL DIALOG.setCurrentRow("s_detail1", g_master_idx)
               #END IF
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_01
            LET g_action_choice="aooi350_01"
            IF cl_auth_chk_act("aooi350_01") THEN
               
               #add-point:ON ACTION aooi350_01 name="menu.aooi350_01"
               IF NOT cl_null(g_inaa_d[l_ac].inaa001) THEN
                  LET l_inaa004 = ' '
                  SELECT inaa004 INTO l_inaa004 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_d[l_ac].inaa001
                  IF NOT cl_null(l_inaa004) THEN
                     CALL aooi350_01(l_inaa004)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi350_02
            LET g_action_choice="aooi350_02"
            IF cl_auth_chk_act("aooi350_02") THEN
               
               #add-point:ON ACTION aooi350_02 name="menu.aooi350_02"
               IF NOT cl_null(g_inaa_d[l_ac].inaa001) THEN
                  LET l_inaa004 = ' '
                  SELECT inaa004 INTO l_inaa004 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_d[l_ac].inaa001
                  IF NOT cl_null(l_inaa004) THEN
                     CALL aooi350_02(l_inaa004)
                  END IF
               END IF
               #END add-point
               
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
            CALL aini001_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aini001_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aini001_set_pk_array()
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
 
{<section id="aini001.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aini001_query()
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
   CALL g_inaa_d.clear()
   CALL g_inaa2_d.clear()
   CALL g_inaa3_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON inaastus,inaa001,inaa005,inaa018,inaa006,inaa007,inaa008,inaa009,inaa010, 
          inaa014,inaa015,inaa017,inaa016,inaa011,inaa012,inaa013,inaamodid,inaamoddt,inaaownid,inaaowndp, 
          inaacrtid,inaacrtdp,inaacrtdt
           FROM s_detail1[1].inaastus,s_detail1[1].inaa001,s_detail1[1].inaa005,s_detail1[1].inaa018, 
               s_detail1[1].inaa006,s_detail1[1].inaa007,s_detail1[1].inaa008,s_detail1[1].inaa009,s_detail1[1].inaa010, 
               s_detail1[1].inaa014,s_detail1[1].inaa015,s_detail1[1].inaa017,s_detail1[1].inaa016,s_detail1[1].inaa011, 
               s_detail1[1].inaa012,s_detail1[1].inaa013,s_detail2[1].inaamodid,s_detail2[1].inaamoddt, 
               s_detail2[1].inaaownid,s_detail2[1].inaaowndp,s_detail2[1].inaacrtid,s_detail2[1].inaacrtdp, 
               s_detail2[1].inaacrtdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inaacrtdt>>----
         AFTER FIELD inaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inaamoddt>>----
         AFTER FIELD inaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inaacnfdt>>----
         
         #----<<inaapstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaastus
            #add-point:BEFORE FIELD inaastus name="construct.b.page1.inaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaastus
            
            #add-point:AFTER FIELD inaastus name="construct.a.page1.inaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaastus
            #add-point:ON ACTION controlp INFIELD inaastus name="construct.c.page1.inaastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001 name="construct.c.page1.inaa001"
            #此段落由子樣板a08產生
            #開窗c段
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            #160808-00001#1-e
            LET g_qryparam.reqry = FALSE            
            CALL q_inay001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaa001  #顯示到畫面上

            NEXT FIELD inaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001 name="construct.b.page1.inaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001 name="construct.a.page1.inaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa005
            #add-point:ON ACTION controlp INFIELD inaa005 name="construct.c.page1.inaa005"
            #此段落由子樣板a08產生
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            #160808-00001#1-e            
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #CALL q_inaa005()                           #呼叫開窗
            #CALL q_ooef001()    #161019-00017#1 mark
            CALL q_ooeg001_8()  #161019-00017#1
            DISPLAY g_qryparam.return1 TO inaa005  #顯示到畫面上

            NEXT FIELD inaa005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa005
            #add-point:BEFORE FIELD inaa005 name="construct.b.page1.inaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa005
            
            #add-point:AFTER FIELD inaa005 name="construct.a.page1.inaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa018
            #add-point:ON ACTION controlp INFIELD inaa018 name="construct.c.page1.inaa018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inay001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaa018  #顯示到畫面上
            NEXT FIELD inaa018                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa018
            #add-point:BEFORE FIELD inaa018 name="construct.b.page1.inaa018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa018
            
            #add-point:AFTER FIELD inaa018 name="construct.a.page1.inaa018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa006
            #add-point:BEFORE FIELD inaa006 name="construct.b.page1.inaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa006
            
            #add-point:AFTER FIELD inaa006 name="construct.a.page1.inaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa006
            #add-point:ON ACTION controlp INFIELD inaa006 name="construct.c.page1.inaa006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa007
            #add-point:BEFORE FIELD inaa007 name="construct.b.page1.inaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa007
            
            #add-point:AFTER FIELD inaa007 name="construct.a.page1.inaa007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa007
            #add-point:ON ACTION controlp INFIELD inaa007 name="construct.c.page1.inaa007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa008
            #add-point:BEFORE FIELD inaa008 name="construct.b.page1.inaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa008
            
            #add-point:AFTER FIELD inaa008 name="construct.a.page1.inaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa008
            #add-point:ON ACTION controlp INFIELD inaa008 name="construct.c.page1.inaa008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa009
            #add-point:BEFORE FIELD inaa009 name="construct.b.page1.inaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa009
            
            #add-point:AFTER FIELD inaa009 name="construct.a.page1.inaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa009
            #add-point:ON ACTION controlp INFIELD inaa009 name="construct.c.page1.inaa009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa010
            #add-point:BEFORE FIELD inaa010 name="construct.b.page1.inaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa010
            
            #add-point:AFTER FIELD inaa010 name="construct.a.page1.inaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa010
            #add-point:ON ACTION controlp INFIELD inaa010 name="construct.c.page1.inaa010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa014
            #add-point:BEFORE FIELD inaa014 name="construct.b.page1.inaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa014
            
            #add-point:AFTER FIELD inaa014 name="construct.a.page1.inaa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa014
            #add-point:ON ACTION controlp INFIELD inaa014 name="construct.c.page1.inaa014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa015
            #add-point:BEFORE FIELD inaa015 name="construct.b.page1.inaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa015
            
            #add-point:AFTER FIELD inaa015 name="construct.a.page1.inaa015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa015
            #add-point:ON ACTION controlp INFIELD inaa015 name="construct.c.page1.inaa015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa017
            #add-point:BEFORE FIELD inaa017 name="construct.b.page1.inaa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa017
            
            #add-point:AFTER FIELD inaa017 name="construct.a.page1.inaa017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa017
            #add-point:ON ACTION controlp INFIELD inaa017 name="construct.c.page1.inaa017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa016
            #add-point:BEFORE FIELD inaa016 name="construct.b.page1.inaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa016
            
            #add-point:AFTER FIELD inaa016 name="construct.a.page1.inaa016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa016
            #add-point:ON ACTION controlp INFIELD inaa016 name="construct.c.page1.inaa016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa011
            #add-point:BEFORE FIELD inaa011 name="construct.b.page1.inaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa011
            
            #add-point:AFTER FIELD inaa011 name="construct.a.page1.inaa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa011
            #add-point:ON ACTION controlp INFIELD inaa011 name="construct.c.page1.inaa011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa012
            #add-point:BEFORE FIELD inaa012 name="construct.b.page1.inaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa012
            
            #add-point:AFTER FIELD inaa012 name="construct.a.page1.inaa012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa012
            #add-point:ON ACTION controlp INFIELD inaa012 name="construct.c.page1.inaa012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa013
            #add-point:BEFORE FIELD inaa013 name="construct.b.page1.inaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa013
            
            #add-point:AFTER FIELD inaa013 name="construct.a.page1.inaa013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa013
            #add-point:ON ACTION controlp INFIELD inaa013 name="construct.c.page1.inaa013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.inaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaamodid
            #add-point:ON ACTION controlp INFIELD inaamodid name="construct.c.page2.inaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            #160808-00001#1-e              
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaamodid  #顯示到畫面上

            NEXT FIELD inaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaamodid
            #add-point:BEFORE FIELD inaamodid name="construct.b.page2.inaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaamodid
            
            #add-point:AFTER FIELD inaamodid name="construct.a.page2.inaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaamoddt
            #add-point:BEFORE FIELD inaamoddt name="construct.b.page2.inaamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.inaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaownid
            #add-point:ON ACTION controlp INFIELD inaaownid name="construct.c.page2.inaaownid"
            #此段落由子樣板a08產生
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            #160808-00001#1-e  
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaaownid  #顯示到畫面上

            NEXT FIELD inaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaownid
            #add-point:BEFORE FIELD inaaownid name="construct.b.page2.inaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaownid
            
            #add-point:AFTER FIELD inaaownid name="construct.a.page2.inaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaowndp
            #add-point:ON ACTION controlp INFIELD inaaowndp name="construct.c.page2.inaaowndp"
            #此段落由子樣板a08產生
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            #160808-00001#1-e              
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaaowndp  #顯示到畫面上

            NEXT FIELD inaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaowndp
            #add-point:BEFORE FIELD inaaowndp name="construct.b.page2.inaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaowndp
            
            #add-point:AFTER FIELD inaaowndp name="construct.a.page2.inaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaacrtid
            #add-point:ON ACTION controlp INFIELD inaacrtid name="construct.c.page2.inaacrtid"
            #此段落由子樣板a08產生
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            #160808-00001#1-e              
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaacrtid  #顯示到畫面上

            NEXT FIELD inaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtid
            #add-point:BEFORE FIELD inaacrtid name="construct.b.page2.inaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaacrtid
            
            #add-point:AFTER FIELD inaacrtid name="construct.a.page2.inaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaacrtdp
            #add-point:ON ACTION controlp INFIELD inaacrtdp name="construct.c.page2.inaacrtdp"
            #此段落由子樣板a08產生
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            #160808-00001#1-e              
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaacrtdp  #顯示到畫面上

            NEXT FIELD inaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtdp
            #add-point:BEFORE FIELD inaacrtdp name="construct.b.page2.inaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaacrtdp
            
            #add-point:AFTER FIELD inaacrtdp name="construct.a.page2.inaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtdt
            #add-point:BEFORE FIELD inaacrtdt name="construct.b.page2.inaacrtdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON inac003
           FROM s_detail3[1].inac003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.inac003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inac003
            #add-point:ON ACTION controlp INFIELD inac003 name="construct.c.page3.inac003"
            #此段落由子樣板a08產生
            #160808-00001#1-s
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            #160808-00001#1-e              
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "220" 
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inac003  #顯示到畫面上

            NEXT FIELD inac003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inac003
            #add-point:BEFORE FIELD inac003 name="construct.b.page3.inac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inac003
            
            #add-point:AFTER FIELD inac003 name="construct.a.page3.inac003"
            
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
   
   #end add-point
   
   LET g_error_show = 1
   CALL aini001_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL aini001_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_inaa_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_inaa3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="aini001.insert" >}
#+ 資料修改
PRIVATE FUNCTION aini001_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL aini001_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aini001.modify" >}
#+ 資料新增
PRIVATE FUNCTION aini001_modify()
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
   CALL aini001_input('u')
    
   IF INT_FLAG AND g_inaa_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL aini001_b_fill(g_wc)
      CALL aini001_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aini001.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aini001_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point 
   DEFINE li_ac LIKE type_t.num10
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_inaa004  LIKE inaa_t.inaa004
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_inaa_d_t.* = g_inaa_d[li_ac].*
   LET g_inaa_d_o.* = g_inaa_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_d_t.inaa001
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00001'
      LET g_errparam.extend = g_inaa_d_t.inaa001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   LET l_inaa004 = ''
   SELECT inaa004 INTO l_inaa004 FROM inaa_t 
     WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_d_t.inaa001

   #end add-point 
   
   #刪除單頭
   DELETE FROM inaa_t 
         WHERE inaaent = g_enterprise AND inaasite = g_site AND
           inaa001 = g_inaa_d_t.inaa001
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aini001_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   LET l_success = ''
   CALL s_aooi350_del(l_inaa004) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "oofa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   DELETE FROM inab_t WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_d_t.inaa001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "inab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM inac_t 
         WHERE inacent = g_enterprise AND inacsite = g_site AND
           inac001 = g_inaa_d_t.inaa001
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   DELETE FROM inac_t 
      WHERE inacent = g_enterprise AND inacsite = g_site AND inac001 = g_inaa_d_t.inaa001
         
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
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
 
{<section id="aini001.input" >}
#+ 資料輸入
PRIVATE FUNCTION aini001_input(p_cmd)
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
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_inaa004       LIKE inaa_t.inaa004
   DEFINE  l_inaa013       LIKE inaa_t.inaa013
   DEFINE  l_inac003       STRING
   DEFINE  l_inaccrtdt     LIKE inac_t.inaccrtdt
   DEFINE  lc_para_data    LIKE type_t.chr80
   #add by lixiang 20150611--S----
   DEFINE l_str1          STRING
   DEFINE l_str2          STRING
   DEFINE bst             base.StringTokenizer
   DEFINE l_index         LIKE type_t.num5
   DEFINE l_inaa001       LIKE inaa_t.inaa001
   #add by lixiang 20150611--E----
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT inaastus,inaa001,inaa005,inaa018,inaa006,inaa007,inaa008,inaa009,inaa010, 
       inaa014,inaa015,inaa017,inaa016,inaa011,inaa012,inaa013,inaa001,inaamodid,inaamoddt,inaaownid, 
       inaaowndp,inaacrtid,inaacrtdp,inaacrtdt FROM inaa_t WHERE inaaent=? AND inaasite=? AND inaa001=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aini001_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT inac002,inac003 FROM inac_t WHERE inacent=? AND inacsite=? AND inac001=?  
       AND inac002=? AND inac003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aini001_bcl2 CURSOR FROM g_forupd_sql
 
 
 
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
      INPUT ARRAY g_inaa_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL aini001_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_inaa_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_inaa_d[l_ac].*
            LET g_master.* = g_inaa_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_inaa_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inaa_d[l_ac].inaa001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inaa_d_t.* = g_inaa_d[l_ac].*  #BACKUP
               LET g_inaa_d_o.* = g_inaa_d[l_ac].*  #BACKUP
               IF NOT aini001_lock_b("inaa_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aini001_bcl INTO g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa005, 
                      g_inaa_d[l_ac].inaa018,g_inaa_d[l_ac].inaa006,g_inaa_d[l_ac].inaa007,g_inaa_d[l_ac].inaa008, 
                      g_inaa_d[l_ac].inaa009,g_inaa_d[l_ac].inaa010,g_inaa_d[l_ac].inaa014,g_inaa_d[l_ac].inaa015, 
                      g_inaa_d[l_ac].inaa017,g_inaa_d[l_ac].inaa016,g_inaa_d[l_ac].inaa011,g_inaa_d[l_ac].inaa012, 
                      g_inaa_d[l_ac].inaa013,g_inaa2_d[l_ac].inaa001,g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt, 
                      g_inaa2_d[l_ac].inaaownid,g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid, 
                      g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inaa_d_t.inaa001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_inaa_d_mask_o[l_ac].* =  g_inaa_d[l_ac].*
                  CALL aini001_inaa_t_mask()
                  LET g_inaa_d_mask_n[l_ac].* =  g_inaa_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL aini001_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aini001_set_entry_b(l_cmd)
            CALL aini001_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL aini001_fetch()
            CALL aini001_idx_chk('m')
 
         BEFORE INSERT
            
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_inaa3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inaa_d[l_ac].* TO NULL 
            INITIALIZE g_inaa_d_t.* TO NULL 
            INITIALIZE g_inaa_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inaa2_d[l_ac].inaaownid = g_user
      LET g_inaa2_d[l_ac].inaaowndp = g_dept
      LET g_inaa2_d[l_ac].inaacrtid = g_user
      LET g_inaa2_d[l_ac].inaacrtdp = g_dept 
      LET g_inaa2_d[l_ac].inaacrtdt = cl_get_current()
      LET g_inaa2_d[l_ac].inaamodid = g_user
      LET g_inaa2_d[l_ac].inaamoddt = cl_get_current()
      LET g_inaa_d[l_ac].inaastus = ''
 
 
 
                  LET g_inaa_d[l_ac].inaastus = "Y"
      LET g_inaa_d[l_ac].inaa007 = "1"
      LET g_inaa_d[l_ac].inaa008 = "Y"
      LET g_inaa_d[l_ac].inaa009 = "Y"
      LET g_inaa_d[l_ac].inaa010 = "Y"
      LET g_inaa_d[l_ac].inaa014 = "N"
      LET g_inaa_d[l_ac].inaa015 = "N"
      LET g_inaa_d[l_ac].inaa017 = "N"
      LET g_inaa_d[l_ac].inaa016 = "N"
      LET g_inaa_d[l_ac].inaa011 = "N"
      LET g_inaa_d[l_ac].inaa012 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_inaa_d_t.* = g_inaa_d[l_ac].*     #新輸入資料
            LET g_inaa_d_o.* = g_inaa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aini001_set_entry_b(l_cmd)
            CALL aini001_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inaa_d[li_reproduce_target].* = g_inaa_d[li_reproduce].*
               LET g_inaa2_d[li_reproduce_target].* = g_inaa2_d[li_reproduce].*
 
               LET g_inaa_d[g_inaa_d.getLength()].inaa001 = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
         LET g_inaa_d[l_ac].inaastus = "Y"
         CALL g_inaa3_d.clear()
         CALL s_transaction_begin()
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
            SELECT COUNT(1) INTO l_count FROM inaa_t 
             WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_d[l_ac].inaa001  
 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaa001
               CALL aini001_insert_b('inaa_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_inaa_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aini001_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               LET l_success = ''
               LET l_inaa004 = ''
               CALL s_aooi350_ins_oofa('8',g_inaa_d[l_ac].inaa001,'') RETURNING l_success,l_inaa004
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofa_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
               ELSE
                  LET l_success = ''
                  LET l_inaa013 = ''
                  #tag二進制碼初始化
                  CALL s_aooi310_init_tagb('1') RETURNING l_success,l_inaa013
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "gen inaa013"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                  ELSE
                     UPDATE inaa_t SET inaa004 = l_inaa004,inaa013 = l_inaa013 
                      WHERE inaaent = g_enterprise AND  inaasite = g_site AND inaa001 = g_inaa_d[l_ac].inaa001
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "inaa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF
               END IF
               LET l_success = ''
               #CALL aini001_insert_inab(g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa006,g_inaa_d[l_ac].inaa008,g_inaa_d[l_ac].inaa009,g_inaa_d[l_ac].inaastus) RETURNING l_success #新增儲位基本資料
               IF NOT aini001_insert_inab(g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa006,g_inaa_d[l_ac].inaa008,g_inaa_d[l_ac].inaa009,g_inaa_d[l_ac].inaastus) THEN
                  CALL s_transaction_end('N','0')
               END IF
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_inaa_d[l_ac].*
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
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_d[l_ac].inaa001
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00001'
                  LET g_errparam.extend = g_inaa_d[l_ac].inaa001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               LET l_inaa004 = ''
               SELECT inaa004 INTO l_inaa004 FROM inaa_t 
                 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_inaa_d[l_ac].inaa001
               #end add-point
               
               DELETE FROM inaa_t
                WHERE inaaent = g_enterprise AND inaasite = g_site AND 
                      inaa001 = g_inaa_d_t.inaa001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  LET l_success = ''
                  CALL s_aooi350_del(l_inaa004) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  END IF
                  DELETE FROM inab_t WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_d_t.inaa001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  END IF
                  
                  DELETE FROM inac_t WHERE inacent = g_enterprise AND inacsite = g_site AND inac001 = g_inaa_d_t.inaa001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inac_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  END IF
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_inaa_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aini001_bcl
               LET l_count = g_inaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d_t.inaa001
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aini001_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aini001_delete_b('inaa_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaastus
            #add-point:BEFORE FIELD inaastus name="input.b.page1.inaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaastus
            
            #add-point:AFTER FIELD inaastus name="input.a.page1.inaastus"
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inaa_d[l_ac].inaastus != g_inaa_d_t.inaastus))) THEN
               IF g_inaa_d[l_ac].inaastus = 'N' AND (NOT cl_null(g_inaa_d[l_ac].inaa001)) THEN
                  IF NOT aini001_inaastus_chk(g_inaa_d[l_ac].inaa001) THEN
                     LET g_inaa_d[l_ac].inaastus = g_inaa_d_t.inaastus
                     NEXT FIELD inaastus
                  END IF
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaastus
            #add-point:ON CHANGE inaastus name="input.g.page1.inaastus"
            #IF g_inaa_d[l_ac].inaastus = 'N' AND (NOT cl_null(g_inaa_d[l_ac].inaa001)) THEN
            #   IF NOT aini001_inaastus_chk(g_inaa_d[l_ac].inaa001) THEN
            #      CALL cl_err(g_inaa_d[l_ac].inaa001,'ain-00006',1)
            #      LET g_inaa_d[l_ac].inaastus = g_inaa_d_t.inaastus
            #      NEXT FIELD inaastus
            #   END IF
            #END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001 name="input.a.page1.inaa001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_inaa_d[l_ac].inaa001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inaa_d[l_ac].inaa001 != g_inaa_d_t.inaa001))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inaa_t WHERE "||"inaaent = '" ||g_enterprise|| "' AND inaasite = '" ||g_site|| "' AND "||"inaa001 = '"||g_inaa_d[l_ac].inaa001 ||"' AND "|| "inaasite = '"||g_site ||"'",'std-00004',0) THEN 
                     LET g_inaa_d[l_ac].inaa001 = g_inaa_d_t.inaa001
                     CALL aini001_inaa001_desc()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_inaa_d[l_ac].inaa001,"SELECT COUNT(*) FROM inay_t WHERE inayent = '" ||g_enterprise||"' AND inay001 = ? ","ain-00307",1 ) THEN
                     LET g_inaa_d[l_ac].inaa001 = g_inaa_d_t.inaa001
                     CALL aini001_inaa001_desc()
                     NEXT FIELD CURRENT
                  END IF
                  IF l_cmd = 'u' THEN
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_d_t.inaa001
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ain-00001'
                        LET g_errparam.extend = g_inaa_d_t.inaa001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        LET g_inaa_d[l_ac].inaa001 = g_inaa_d_t.inaa001
                        CALL aini001_inaa001_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL aini001_inaa001_desc()
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001 name="input.b.page1.inaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa001
            #add-point:ON CHANGE inaa001 name="input.g.page1.inaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa005
            #add-point:BEFORE FIELD inaa005 name="input.b.page1.inaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa005
            
            #add-point:AFTER FIELD inaa005 name="input.a.page1.inaa005"
            IF NOT cl_null(g_inaa_d[l_ac].inaa005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inaa_d[l_ac].inaa005 != g_inaa_d_t.inaa005 OR g_inaa_d_t.inaa005 IS NULL))) THEN  #161019-00017#1 add g_inaa_d_t.inaa005 IS NULL
                  #IF NOT ap_chk_isExist(g_inaa_d[l_ac].inaa005,"SELECT COUNT(*) FROM ooea_t WHERE ooeaent = '" ||g_enterprise||"' AND ooea001 = ? ","aoo-00094",1 ) THEN
                  #   LET g_inaa_d[l_ac].inaa005 = g_inaa_d_t.inaa005
                  #   NEXT FIELD CURRENT
                  #END IF
                  #IF NOT ap_chk_isExist(g_inaa_d[l_ac].inaa005,"SELECT COUNT(*) FROM ooea_t WHERE ooeaent = '" ||g_enterprise||"' AND ooea001 = ? AND ooeastus = 'Y' ",'sub-01302','aooi125' ) THEN
                  #   LET g_inaa_d[l_ac].inaa005 = g_inaa_d_t.inaa005
                  #   NEXT FIELD CURRENT
                  #END IF
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_inaa_d[l_ac].inaa005
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#23  by 07900 --add-end
                  #IF NOT cl_chk_exist("v_ooef001") THEN
                  LET g_chkparam.arg2 = g_today             #161019-00017#1 
                  IF NOT cl_chk_exist("v_ooeg001_4") THEN   #161019-00017#1
                     LET g_inaa_d[l_ac].inaa005 = g_inaa_d_t.inaa005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa005
            #add-point:ON CHANGE inaa005 name="input.g.page1.inaa005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa018
            
            #add-point:AFTER FIELD inaa018 name="input.a.page1.inaa018"
            LET g_inaa_d[l_ac].inaa018_desc = ''
            LET lc_para_data = cl_get_para(g_enterprise,g_site,'S-BAS-0043')
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM inac_t
             WHERE inacent = g_enterprise
               AND inacsite = g_site
               AND inac001 = g_inaa_d[l_ac].inaa001
               AND inac003 = lc_para_data
            IF l_n > 0 THEN
               IF NOT cl_null(g_inaa_d[l_ac].inaa018) THEN 
                  IF g_inaa_d[l_ac].inaa018 != g_inaa_d_t.inaa018 OR cl_null(g_inaa_d_t.inaa018) THEN 
                     IF NOT aini001_inaa018_chk() THEN
                        LET g_inaa_d[l_ac].inaa018 = g_inaa_d_t.inaa018
                        CALL s_desc_get_stock_desc(g_site,g_inaa_d[l_ac].inaa018) RETURNING g_inaa_d[l_ac].inaa018_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00312'
                  LET g_errparam.extend = 'inaa018'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_inaa_d[l_ac].inaa018 = g_inaa_d_t.inaa018
                  CALL s_desc_get_stock_desc(g_site,g_inaa_d[l_ac].inaa018) RETURNING g_inaa_d[l_ac].inaa018_desc
                  NEXT FIELD CURRENT
               END IF 
            END IF
            CALL s_desc_get_stock_desc(g_site,g_inaa_d[l_ac].inaa018) RETURNING g_inaa_d[l_ac].inaa018_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa018
            #add-point:BEFORE FIELD inaa018 name="input.b.page1.inaa018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa018
            #add-point:ON CHANGE inaa018 name="input.g.page1.inaa018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inaa_d[l_ac].inaa006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD inaa006
            END IF 
 
 
 
            #add-point:AFTER FIELD inaa006 name="input.a.page1.inaa006"
            IF NOT cl_null(g_inaa_d[l_ac].inaa006) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa006
            #add-point:BEFORE FIELD inaa006 name="input.b.page1.inaa006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa006
            #add-point:ON CHANGE inaa006 name="input.g.page1.inaa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa007
            #add-point:BEFORE FIELD inaa007 name="input.b.page1.inaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa007
            
            #add-point:AFTER FIELD inaa007 name="input.a.page1.inaa007"
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inaa_d[l_ac].inaa007 != g_inaa_d_t.inaa007))) THEN
               IF NOT aini001_inaa007_chk(g_inaa_d[l_ac].inaa001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00007'
                  LET g_errparam.extend = g_inaa_d[l_ac].inaa001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_inaa_d[l_ac].inaa007 = g_inaa_d_t.inaa007
                  NEXT FIELD inaa007
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa007
            #add-point:ON CHANGE inaa007 name="input.g.page1.inaa007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa008
            #add-point:BEFORE FIELD inaa008 name="input.b.page1.inaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa008
            
            #add-point:AFTER FIELD inaa008 name="input.a.page1.inaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa008
            #add-point:ON CHANGE inaa008 name="input.g.page1.inaa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa009
            #add-point:BEFORE FIELD inaa009 name="input.b.page1.inaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa009
            
            #add-point:AFTER FIELD inaa009 name="input.a.page1.inaa009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa009
            #add-point:ON CHANGE inaa009 name="input.g.page1.inaa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa010
            #add-point:BEFORE FIELD inaa010 name="input.b.page1.inaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa010
            
            #add-point:AFTER FIELD inaa010 name="input.a.page1.inaa010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa010
            #add-point:ON CHANGE inaa010 name="input.g.page1.inaa010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa014
            #add-point:BEFORE FIELD inaa014 name="input.b.page1.inaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa014
            
            #add-point:AFTER FIELD inaa014 name="input.a.page1.inaa014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa014
            #add-point:ON CHANGE inaa014 name="input.g.page1.inaa014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa015
            #add-point:BEFORE FIELD inaa015 name="input.b.page1.inaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa015
            
            #add-point:AFTER FIELD inaa015 name="input.a.page1.inaa015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa015
            #add-point:ON CHANGE inaa015 name="input.g.page1.inaa015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa017
            #add-point:BEFORE FIELD inaa017 name="input.b.page1.inaa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa017
            
            #add-point:AFTER FIELD inaa017 name="input.a.page1.inaa017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa017
            #add-point:ON CHANGE inaa017 name="input.g.page1.inaa017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa016
            #add-point:BEFORE FIELD inaa016 name="input.b.page1.inaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa016
            
            #add-point:AFTER FIELD inaa016 name="input.a.page1.inaa016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa016
            #add-point:ON CHANGE inaa016 name="input.g.page1.inaa016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa011
            #add-point:BEFORE FIELD inaa011 name="input.b.page1.inaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa011
            
            #add-point:AFTER FIELD inaa011 name="input.a.page1.inaa011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa011
            #add-point:ON CHANGE inaa011 name="input.g.page1.inaa011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa012
            #add-point:BEFORE FIELD inaa012 name="input.b.page1.inaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa012
            
            #add-point:AFTER FIELD inaa012 name="input.a.page1.inaa012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa012
            #add-point:ON CHANGE inaa012 name="input.g.page1.inaa012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa013
            #add-point:BEFORE FIELD inaa013 name="input.b.page1.inaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa013
            
            #add-point:AFTER FIELD inaa013 name="input.a.page1.inaa013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa013
            #add-point:ON CHANGE inaa013 name="input.g.page1.inaa013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaastus
            #add-point:ON ACTION controlp INFIELD inaastus name="input.c.page1.inaastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001 name="input.c.page1.inaa001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'c'  #開窗多選，新增多筆 #modify by lixiang 20150611
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inaa_d[l_ac].inaa001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " inay001 NOT IN (SELECT inaa001 FROM inaa_t WHERE inaaent = '",g_enterprise,"' AND inaasite = '",g_site,"' )"
            
            CALL q_inay001()                                #呼叫開窗
            
            #add by lixiang 20150604--S----
            LET l_str1 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET l_index = l_str1.getIndexOf('|',1)
            #開窗時多選，則所選資料全部新增到表中
            IF l_index > 1 THEN
               
               LET bst= base.StringTokenizer.create(l_str1,"|")
               WHILE bst.hasMoreTokens()
                  LET l_str2 = bst.nextToken()
                  LET l_inaa001 = l_str2
                  LET l_count = 1  
                  SELECT COUNT(*) INTO l_count FROM inaa_t 
                      WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = l_inaa001
                  IF l_count = 0 OR cl_null(l_count) THEN
                     CALL s_transaction_begin()
                     IF NOT aini001_ins_inaa(l_inaa001) THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                  END IF
               END WHILE

               #IF g_wc  = " 1=2" THEN
               #   LET g_wc = " inaa001 IN ('",l_str1,"' )"
               #ELSE
               #   LET g_wc = g_wc ," OR (inaa001 IN ('",l_str1,"' ))"
               #END IF
               CALL aini001_b_fill(g_wc)
               IF g_detail_cnt > 0 THEN
                  LET g_flag2 = TRUE
                  EXIT DIALOG
               END IF
            ELSE
            #add by lixiang 20150604--E----

               LET g_inaa_d[l_ac].inaa001 = g_qryparam.return1              
               
               DISPLAY g_inaa_d[l_ac].inaa001 TO inaa001              #
               CALL aini001_inaa001_desc()
               NEXT FIELD inaa001                          #返回原欄位

            END IF
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa005
            #add-point:ON ACTION controlp INFIELD inaa005 name="input.c.page1.inaa005"
#此段落由子樣板a07產生 
            INITIALIZE g_qryparam.* TO NULL #160808-00001#1 
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inaa_d[l_ac].inaa005             #給予default值

            #給予arg

            #CALL q_ooea001()                                #呼叫開窗
            #CALL q_ooef001()   #161019-00017#1
            CALL q_ooeg001_8()  #161019-00017#1
            LET g_inaa_d[l_ac].inaa005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_inaa_d[l_ac].inaa005 TO inaa005              #顯示到畫面上

            NEXT FIELD inaa005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa018
            #add-point:ON ACTION controlp INFIELD inaa018 name="input.c.page1.inaa018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inaa_d[l_ac].inaa018  #給予default值
            #VMI結算庫位Tag
            LET lc_para_data = cl_get_para(g_enterprise,g_site,'S-BAS-0044')
            
            LET l_n = 0
           
            IF NOT cl_null(lc_para_data) THEN  #160315-00023#1 add
               LET g_qryparam.where = " inay001 IN ( SELECT inac001 FROM inac_t WHERE inacent = '",g_enterprise,"' AND inacsite = '",g_site,"' AND inac003 = '",lc_para_data,"' )"
            END IF   #160315-00023#1 add
            CALL q_inay001()                                  #呼叫開窗
            LET g_inaa_d[l_ac].inaa018 = g_qryparam.return1              
            DISPLAY g_inaa_d[l_ac].inaa018 TO inaa018
            CALL s_desc_get_stock_desc(g_site,g_inaa_d[l_ac].inaa018) RETURNING g_inaa_d[l_ac].inaa018_desc
            NEXT FIELD inaa018                                #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa006
            #add-point:ON ACTION controlp INFIELD inaa006 name="input.c.page1.inaa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa007
            #add-point:ON ACTION controlp INFIELD inaa007 name="input.c.page1.inaa007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa008
            #add-point:ON ACTION controlp INFIELD inaa008 name="input.c.page1.inaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa009
            #add-point:ON ACTION controlp INFIELD inaa009 name="input.c.page1.inaa009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa010
            #add-point:ON ACTION controlp INFIELD inaa010 name="input.c.page1.inaa010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa014
            #add-point:ON ACTION controlp INFIELD inaa014 name="input.c.page1.inaa014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa015
            #add-point:ON ACTION controlp INFIELD inaa015 name="input.c.page1.inaa015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa017
            #add-point:ON ACTION controlp INFIELD inaa017 name="input.c.page1.inaa017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa016
            #add-point:ON ACTION controlp INFIELD inaa016 name="input.c.page1.inaa016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa011
            #add-point:ON ACTION controlp INFIELD inaa011 name="input.c.page1.inaa011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa012
            #add-point:ON ACTION controlp INFIELD inaa012 name="input.c.page1.inaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa013
            #add-point:ON ACTION controlp INFIELD inaa013 name="input.c.page1.inaa013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inaa_d[l_ac].* = g_inaa_d_t.*
               CLOSE aini001_bcl
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
               LET g_errparam.extend = g_inaa_d[l_ac].inaa001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inaa_d[l_ac].* = g_inaa_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_inaa2_d[l_ac].inaamodid = g_user 
LET g_inaa2_d[l_ac].inaamoddt = cl_get_current()
LET g_inaa2_d[l_ac].inaamodid_desc = cl_get_username(g_inaa2_d[l_ac].inaamodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aini001_inaa_t_mask_restore('restore_mask_o')
      
               UPDATE inaa_t SET (inaastus,inaa001,inaa005,inaa018,inaa006,inaa007,inaa008,inaa009,inaa010, 
                   inaa014,inaa015,inaa017,inaa016,inaa011,inaa012,inaa013,inaamodid,inaamoddt,inaaownid, 
                   inaaowndp,inaacrtid,inaacrtdp,inaacrtdt) = (g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaa001, 
                   g_inaa_d[l_ac].inaa005,g_inaa_d[l_ac].inaa018,g_inaa_d[l_ac].inaa006,g_inaa_d[l_ac].inaa007, 
                   g_inaa_d[l_ac].inaa008,g_inaa_d[l_ac].inaa009,g_inaa_d[l_ac].inaa010,g_inaa_d[l_ac].inaa014, 
                   g_inaa_d[l_ac].inaa015,g_inaa_d[l_ac].inaa017,g_inaa_d[l_ac].inaa016,g_inaa_d[l_ac].inaa011, 
                   g_inaa_d[l_ac].inaa012,g_inaa_d[l_ac].inaa013,g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt, 
                   g_inaa2_d[l_ac].inaaownid,g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid,g_inaa2_d[l_ac].inaacrtdp, 
                   g_inaa2_d[l_ac].inaacrtdt)
                WHERE inaaent = g_enterprise AND inaasite = g_site AND
                  inaa001 = g_inaa_d_t.inaa001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_inaa_d[l_ac].* = g_inaa_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inaa_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inaa_d[l_ac].* = g_inaa_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys_bak[1] = g_inaa_d_t.inaa001
               CALL aini001_update_b('inaa_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aini001_inaa_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_inaa_d_t)
                     LET g_log2 = util.JSON.stringify(g_inaa_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_inaa_d[l_ac].*
               CALL aini001_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               #UPDATE inab_t SET (inab001,inab003,inabmodid,inabmoddt) = (g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa001_desc,g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt)   #160604-00037#1 mark
               UPDATE inab_t SET (inab001,inabmodid,inabmoddt) = (g_inaa_d[l_ac].inaa001,g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt)    #160604-00037#1 add
                WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_d_t.inaa001 AND inab002 = ' '
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inab_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  CALL s_transaction_end('N','0')
               END IF
               
               UPDATE inab_t SET (inab001,inab004,inab005,inab006,inab007,inabmodid,inabmoddt) = (g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa001_desc_desc,g_inaa_d[l_ac].inaa006,g_inaa_d[l_ac].inaa008,g_inaa_d[l_ac].inaa009,g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt)
                WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_inaa_d_t.inaa001  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inab_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  CALL s_transaction_end('N','0')
               END IF
               
               UPDATE inag_t SET (inag010,inag011,inag012) = (g_inaa_d[l_ac].inaa008,g_inaa_d[l_ac].inaa009,g_inaa_d[l_ac].inaa010)
                WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_inaa_d[l_ac].inaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "inag_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aini001_unlock_b("inaa_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inaa_d[l_ac].* = g_inaa_d_t.*
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
               LET g_inaa_d[l_ac].* = g_inaa_d_t.*
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
               LET g_inaa_d[li_reproduce_target].* = g_inaa_d[li_reproduce].*
               LET g_inaa2_d[li_reproduce_target].* = g_inaa2_d[li_reproduce].*
 
               LET g_inaa_d[li_reproduce_target].inaa001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inaa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inaa_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_inaa3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_inaa_d[g_detail_idx].inaa001) THEN
               NEXT FIELD inaastus
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inaa3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_inaa3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
 
         BEFORE INSERT
            IF g_inaa_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD inaa001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inaa3_d[l_ac].* TO NULL 
            INITIALIZE g_inaa3_d_t.* TO NULL 
            INITIALIZE g_inaa3_d_o.* TO NULL 
            
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_inaa3_d_t.* = g_inaa3_d[l_ac].*     #新輸入資料
            LET g_inaa3_d_o.* = g_inaa3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aini001_set_entry_b(l_cmd)
            CALL aini001_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inaa3_d[li_reproduce_target].* = g_inaa3_d[li_reproduce].*
 
               LET g_inaa3_d[li_reproduce_target].inac002 = NULL
               LET g_inaa3_d[li_reproduce_target].inac003 = NULL
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
            LET g_detail_cnt = g_inaa3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inaa3_d[l_ac].inac002 IS NOT NULL
               AND g_inaa3_d[l_ac].inac003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_inaa3_d_t.* = g_inaa3_d[l_ac].*  #BACKUP
               LET g_inaa3_d_o.* = g_inaa3_d[l_ac].*  #BACKUP
               IF NOT aini001_lock_b("inac_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aini001_bcl2 INTO g_inaa3_d[l_ac].inac002,g_inaa3_d[l_ac].inac003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inaa3_d_mask_o[l_ac].* =  g_inaa3_d[l_ac].*
                  CALL aini001_inac_t_mask()
                  LET g_inaa3_d_mask_n[l_ac].* =  g_inaa3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL aini001_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aini001_set_entry_b(l_cmd)
            CALL aini001_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            
            CALL aini001_inac003_ref(g_inaa3_d[l_ac].inac003) RETURNING g_inaa3_d[l_ac].inac003_desc
            DISPLAY BY NAME g_inaa3_d[l_ac].inac003_desc
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL aini001_idx_chk('d')
            
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
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0043') = g_inaa3_d[l_ac].inac003 AND
                  NOT cl_null(g_inaa_d[g_detail_idx].inaa018) THEN
                  UPDATE inaa_t SET inaa018 = ''
                   WHERE inaaent = g_enterprise
                     AND inaasite = g_site
                     AND inaa001 = g_master.inaa001
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inaa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CANCEL DELETE 
                  ELSE
                     LET g_inaa_d[g_detail_idx].inaa018 = ''
                  END IF
               END IF

               #end add-point  
               
               DELETE FROM inac_t
                WHERE inacent = g_enterprise AND inacsite = g_site AND
                   inac001 = g_master.inaa001
                   AND inac002 = g_inaa3_d_t.inac002
                   AND inac003 = g_inaa3_d_t.inac003
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  #產生tag二進制碼
                  LET l_success = ''
                  LET l_inaa013 = ''
                  CALL s_aooi310_gen_tagb(g_master.inaa001,' ','2') RETURNING l_success,l_inaa013
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "gen inaa013"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                     CANCEL DELETE 
                  ELSE
                     UPDATE inaa_t SET inaa013 = l_inaa013 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_master.inaa001
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "inaa_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0') 
                        CANCEL DELETE 
                     END IF
                     UPDATE inab_t SET inab008 = l_inaa013 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_master.inaa001 AND inab002 = g_inaa3_d_t.inac002
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "inab_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0') 
                        CANCEL DELETE 
                     END IF
                     UPDATE inag_t SET inag023 = l_inaa013 WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_master.inaa001 AND inag005 = g_inaa3_d_t.inac002
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "inag_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0') 
                        CANCEL DELETE 
                     END IF
                     UPDATE inah_t SET inah011 = l_inaa013 WHERE inahent = g_enterprise AND inahsite = g_site AND inah004 = g_master.inaa001 AND inah005 = g_inaa3_d_t.inac002
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "inah_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0') 
                        CANCEL DELETE 
                     END IF
                     UPDATE inai_t SET inai013 = l_inaa013 WHERE inaient = g_enterprise AND inaisite = g_site AND inai004 = g_master.inaa001 AND inai005 = g_inaa3_d_t.inac002
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "inai_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0')
                        CANCEL DELETE                         
                     END IF
                  END IF
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aini001_bcl
               LET l_count = g_inaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[2] = g_inaa3_d_t.inac002
               LET gs_keys[3] = g_inaa3_d_t.inac003
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL aini001_delete_b('inac_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inaa3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM inac_t 
             WHERE inacent = g_enterprise AND inacsite = g_site AND
                   inac001 = g_master.inaa001
                   AND inac002 = g_inaa3_d[g_detail_idx2].inac002
                   AND inac003 = g_inaa3_d[g_detail_idx2].inac003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               LET g_inaa3_d[l_ac].inac002 = ' '
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[2] = g_inaa3_d[g_detail_idx2].inac002
               LET gs_keys[3] = g_inaa3_d[g_detail_idx2].inac003
               CALL aini001_insert_b('inac_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               LET l_inaccrtdt = cl_get_current()
               UPDATE inac_t SET (inacstus,inacownid,inacowndp,inaccrtid,inaccrtdp,inaccrtdt) = ('Y',g_user,g_dept,g_user,g_dept,l_inaccrtdt)
                   WHERE inacent = g_enterprise AND inacsite = g_site
                     AND inac001 = g_master.inaa001 AND inac002 = g_inaa3_d[l_ac].inac002 AND inac003 = g_inaa3_d[l_ac].inac003
                     
               #end add-point
            ELSE    
               INITIALIZE g_inaa_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aini001_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               #產生tag二進制碼
               LET l_success = ''
               LET l_inaa013 = ''
               CALL s_aooi310_gen_tagb(g_master.inaa001,' ','2') RETURNING l_success,l_inaa013
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "gen inaa013"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0') 
               ELSE
                  UPDATE inaa_t SET inaa013 = l_inaa013 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_master.inaa001
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inaa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inab_t SET inab008 = l_inaa013 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_master.inaa001 AND inab002 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inag_t SET inag023 = l_inaa013 WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_master.inaa001 AND inag005 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inag_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inah_t SET inah011 = l_inaa013 WHERE inahent = g_enterprise AND inahsite = g_site AND inah004 = g_master.inaa001 AND inah005 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inah_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inai_t SET inai013 = l_inaa013 WHERE inaient = g_enterprise AND inaisite = g_site AND inai004 = g_master.inaa001 AND inai005 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inai_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                  END IF
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inaa3_d[l_ac].* = g_inaa3_d_t.*
               CLOSE aini001_bcl2
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
               LET g_inaa3_d[l_ac].* = g_inaa3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aini001_inac_t_mask_restore('restore_mask_o')
               
               UPDATE inac_t SET (inac002,inac003) = (g_inaa3_d[l_ac].inac002,g_inaa3_d[l_ac].inac003)  
                   #自訂欄位頁簽
                WHERE inacent = g_enterprise AND inacsite = g_site AND
                   inac001 = g_master.inaa001
                   AND inac002 = g_inaa3_d_t.inac002
                   AND inac003 = g_inaa3_d_t.inac003
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_inaa3_d[l_ac].* = g_inaa3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inac_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inaa3_d[l_ac].* = g_inaa3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys_bak[1] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys[2] = g_inaa3_d[g_detail_idx2].inac002
               LET gs_keys_bak[2] = g_inaa3_d_t.inac002
               LET gs_keys[3] = g_inaa3_d[g_detail_idx2].inac003
               LET gs_keys_bak[3] = g_inaa3_d_t.inac003
               CALL aini001_update_b('inac_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aini001_inac_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_inaa3_d_t)
                     LET g_log2 = util.JSON.stringify(g_inaa3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               #產生tag二進制碼
               LET l_success = ''
               LET l_inaa013 = ''
               CALL s_aooi310_gen_tagb(g_master.inaa001,' ','2') RETURNING l_success,l_inaa013
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "gen inaa013"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0') 
               ELSE
                  UPDATE inaa_t SET inaa013 = l_inaa013 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_master.inaa001
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inaa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inab_t SET inab008 = l_inaa013 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = g_master.inaa001 AND inab002 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inag_t SET inag023 = l_inaa013 WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = g_master.inaa001 AND inag005 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inag_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inah_t SET inah011 = l_inaa013 WHERE inahent = g_enterprise AND inahsite = g_site AND inah004 = g_master.inaa001 AND inah005 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inah_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    
                     CALL s_transaction_end('N','0') 
                  END IF
                  UPDATE inai_t SET inai013 = l_inaa013 WHERE inaient = g_enterprise AND inaisite = g_site AND inai004 = g_master.inaa001 AND inai005 = g_inaa3_d[l_ac].inac002
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "inai_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0') 
                  END IF
               END IF
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inac003
            
            #add-point:AFTER FIELD inac003 name="input.a.page3.inac003"
            #此段落由子樣板a05產生
            LET g_inaa3_d[l_ac].inac003_desc = ' '
            DISPLAY BY NAME g_inaa3_d[l_ac].inac003_desc
            
            IF  NOT cl_null(g_master.inaa001) AND NOT cl_null(g_inaa3_d[l_ac].inac003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_inaa3_d[l_ac].inac003 != g_inaa3_d_t.inac003))) THEN 
                  IF NOT aini001_inac003_chk(g_inaa3_d[l_ac].inac003) THEN
                     LET g_inaa3_d[l_ac].inac003 = g_inaa3_d_t.inac003
                     CALL aini001_inac003_ref(g_inaa3_d[l_ac].inac003) RETURNING g_inaa3_d[l_ac].inac003_desc
                     DISPLAY BY NAME g_inaa3_d[l_ac].inac003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aini001_inac003_ref(g_inaa3_d[l_ac].inac003) RETURNING g_inaa3_d[l_ac].inac003_desc
            DISPLAY BY NAME g_inaa3_d[l_ac].inac003_desc
            CALL aini001_set_entry_b(l_cmd)
            CALL aini001_set_no_entry_b(l_cmd)
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0043') = g_inaa3_d[l_ac].inac003 AND cl_null(g_inaa_d[g_detail_idx].inaa018) THEN
               NEXT FIELD inaa018
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inac003
            #add-point:BEFORE FIELD inac003 name="input.b.page3.inac003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inac003
            #add-point:ON CHANGE inac003 name="input.g.page3.inac003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.inac003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inac003
            #add-point:ON ACTION controlp INFIELD inac003 name="input.c.page3.inac003"
#此段落由子樣板a07產生 
            INITIALIZE g_qryparam.* TO NULL #160808-00001#1 
            #開窗i段
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = "c"
               LET g_qryparam.where = " oocqstus = 'Y' AND oocq002 NOT IN (SELECT inac003 FROM inac_t WHERE inac001 = '",g_master.inaa001,"' AND inac002 = '",g_inaa3_d[l_ac].inac002,"') "
            ELSE
               LET g_qryparam.state = "i"
            END IF
            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inaa3_d[l_ac].inac003             #給予default值

            LET g_qryparam.arg1 = "220" #應用分類

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_qryparam.where = " "
            IF l_cmd = 'a' THEN
               LET l_inac003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               IF NOT cl_null(l_inac003) THEN
                  CALL aini001_insert_inac(l_inac003,g_master.inaa001) RETURNING l_success
                  IF l_success THEN
                     CALL aini001_b_fill2(g_master.inaa001)
                     LET g_flag = TRUE
                     EXIT DIALOG
                  ELSE
                     LET g_flag = FALSE
                     NEXT FIELD inac003
                  END IF
               END IF
               
            ELSE
               LET g_inaa3_d[l_ac].inac003 = g_qryparam.return1
               DISPLAY g_inaa3_d[l_ac].inac003 TO inac003              #顯示到畫面上
               CALL aini001_inac003_ref(g_inaa3_d[l_ac].inac003) RETURNING g_inaa3_d[l_ac].inac003_desc
               DISPLAY BY NAME g_inaa3_d[l_ac].inac003_desc
               NEXT FIELD inac003
            END IF

            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inaa3_d[l_ac].* = g_inaa3_d_t.*
               END IF
               CLOSE aini001_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aini001_unlock_b("inac_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_inaa3_d[li_reproduce_target].* = g_inaa3_d[li_reproduce].*
 
               LET g_inaa3_d[li_reproduce_target].inac002 = NULL
               LET g_inaa3_d[li_reproduce_target].inac003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_inaa3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inaa3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_inaa2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL aini001_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL aini001_fetch()
            CALL aini001_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_inaa_d.getLength() THEN
               LET g_detail_idx = g_inaa_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         IF g_flag2 THEN
            LET g_flag2 = FALSE
            NEXT FIELD inaa001
         END IF
         IF g_flag THEN
            LET g_flag = FALSE
            NEXT FIELD inac003
         END IF
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_inaa_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inaastus
               WHEN "s_detail2"
                  NEXT FIELD inaa001_2
               WHEN "s_detail3"
                  NEXT FIELD inac002
 
            END CASE
         ELSE
            NEXT FIELD inaastus
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
   IF g_flag2 THEN
      CALL aini001_input('u')
   END IF
   
   IF g_flag THEN
      CALL aini001_input('u')
   END IF
   #end add-point
 
   CLOSE aini001_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aini001.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aini001_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.inaastus,t0.inaa001,t0.inaa005,t0.inaa018,t0.inaa006,t0.inaa007, 
       t0.inaa008,t0.inaa009,t0.inaa010,t0.inaa014,t0.inaa015,t0.inaa017,t0.inaa016,t0.inaa011,t0.inaa012, 
       t0.inaa013,t0.inaa001,t0.inaamodid,t0.inaamoddt,t0.inaaownid,t0.inaaowndp,t0.inaacrtid,t0.inaacrtdp, 
       t0.inaacrtdt ,t1.inayl003 ,t2.inayl004 ,t3.inayl003 ,t4.ooag011 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooefl003 FROM inaa_t t0",
 
               " LEFT JOIN inac_t ON inacent = inaaent AND inacsite = inaasite AND inaa001 = inac001",
 
 
               "",
                              " LEFT JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=t0.inaa001 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=t0.inaa001 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t3 ON t3.inaylent="||g_enterprise||" AND t3.inayl001=t0.inaa018 AND t3.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.inaamodid  ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.inaaownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.inaaowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.inaacrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.inaacrtdp AND t8.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.inaaent= ?  AND t0. inaasite= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("inaa_t"),
                      " ORDER BY t0.inaa001"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"inaa_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE aini001_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aini001_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_inaa_d.clear()
   CALL g_inaa2_d.clear()   
   CALL g_inaa3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa005,g_inaa_d[l_ac].inaa018, 
       g_inaa_d[l_ac].inaa006,g_inaa_d[l_ac].inaa007,g_inaa_d[l_ac].inaa008,g_inaa_d[l_ac].inaa009,g_inaa_d[l_ac].inaa010, 
       g_inaa_d[l_ac].inaa014,g_inaa_d[l_ac].inaa015,g_inaa_d[l_ac].inaa017,g_inaa_d[l_ac].inaa016,g_inaa_d[l_ac].inaa011, 
       g_inaa_d[l_ac].inaa012,g_inaa_d[l_ac].inaa013,g_inaa2_d[l_ac].inaa001,g_inaa2_d[l_ac].inaamodid, 
       g_inaa2_d[l_ac].inaamoddt,g_inaa2_d[l_ac].inaaownid,g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid, 
       g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt,g_inaa_d[l_ac].inaa001_desc,g_inaa_d[l_ac].inaa001_desc_desc, 
       g_inaa_d[l_ac].inaa018_desc,g_inaa2_d[l_ac].inaamodid_desc,g_inaa2_d[l_ac].inaaownid_desc,g_inaa2_d[l_ac].inaaowndp_desc, 
       g_inaa2_d[l_ac].inaacrtid_desc,g_inaa2_d[l_ac].inaacrtdp_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
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
   
 
   CALL g_inaa_d.deleteElement(g_inaa_d.getLength())   
   CALL g_inaa2_d.deleteElement(g_inaa2_d.getLength())
   CALL g_inaa3_d.deleteElement(g_inaa3_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_inaa_d.getLength() THEN
       IF g_inaa_d.getLength() > 0 THEN
          LET g_detail_idx = g_inaa_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_inaa_d.getLength()
      LET g_inaa2_d[g_detail_idx].inaa001 = g_inaa_d[g_detail_idx].inaa001 
      #LET g_inaa3_d[g_detail_idx2].inac002 = g_inaa_d[g_detail_idx].inaa001 
      #LET g_inaa3_d[g_detail_idx2].inac003 =  
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_detail_idx  = 1
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aini001_pb
   
   LET g_loc = 'm'
   CALL aini001_detail_show() 
   
   LET l_ac = 1
   IF g_inaa_d.getLength() > 0 THEN
      CALL aini001_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inaa_d.getLength()
      LET g_inaa_d_mask_o[l_ac].* =  g_inaa_d[l_ac].*
      CALL aini001_inaa_t_mask()
      LET g_inaa_d_mask_n[l_ac].* =  g_inaa_d[l_ac].*
   END FOR
   
   LET g_inaa2_d_mask_o.* =  g_inaa2_d.*
   FOR l_ac = 1 TO g_inaa2_d.getLength()
      LET g_inaa2_d_mask_o[l_ac].* =  g_inaa2_d[l_ac].*
      CALL aini001_inaa_t_mask()
      LET g_inaa2_d_mask_n[l_ac].* =  g_inaa2_d[l_ac].*
   END FOR
   LET g_inaa3_d_mask_o.* =  g_inaa3_d.*
   FOR l_ac = 1 TO g_inaa3_d.getLength()
      LET g_inaa3_d_mask_o[l_ac].* =  g_inaa3_d[l_ac].*
      CALL aini001_inac_t_mask()
      LET g_inaa3_d_mask_n[l_ac].* =  g_inaa3_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="aini001.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aini001_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_inaa_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_inaa2_d.clear()
   CALL g_inaa3_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.inac002,t0.inac003 ,t9.oocql004 FROM inac_t t0",    
                  "",
                                 " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='220' AND t9.oocql002=t0.inac003 AND t9.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.inacent=?  AND t0. inacsite=?  AND t0. inac001=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      #170116-00013#1 add---start---
      LET g_sql = g_sql CLIPPED," AND (t0.inac002 IS NULL OR t0.inac002 = ' ') "
      #170116-00013#1 add---end---
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.inac002,t0.inac003" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE aini001_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR aini001_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise, g_site,g_inaa_d[l_ac].inaa001   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise, g_site,g_inaa_d[l_ac].inaa001 INTO g_inaa3_d[l_ac].inac002, 
#    g_inaa3_d[l_ac].inac003,g_inaa3_d[l_ac].inac003_desc   #(ver:45) #(ver:46)mark
   FOREACH b_fill_curs2 USING g_enterprise, g_site,g_inaa_d[g_detail_idx].inaa001 INTO g_inaa3_d[l_ac].inac002, 
       g_inaa3_d[l_ac].inac003,g_inaa3_d[l_ac].inac003_desc   #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      CALL aini001_inac003_ref(g_inaa3_d[l_ac].inac003) RETURNING g_inaa3_d[l_ac].inac003_desc
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point
   
   #CALL g_inaa2_d.deleteElement(g_inaa2_d.getLength())   
   CALL g_inaa3_d.deleteElement(g_inaa3_d.getLength())   
 
   
   LET g_inaa3_d_mask_o.* =  g_inaa3_d.*
   FOR l_ac = 1 TO g_inaa3_d.getLength()
      LET g_inaa3_d_mask_o[l_ac].* =  g_inaa3_d[l_ac].*
      CALL aini001_inac_t_mask()
      LET g_inaa3_d_mask_n[l_ac].* =  g_inaa3_d[l_ac].*
   END FOR
 
   
   DISPLAY g_inaa3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL aini001_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aini001.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aini001_detail_show()
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
      FOR l_ac = 1 TO g_inaa_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa2_d[l_ac].inaaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inaa2_d[l_ac].inaaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inaa2_d[l_ac].inaaownid_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa2_d[l_ac].inaaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inaa2_d[l_ac].inaaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inaa2_d[l_ac].inaaowndp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa2_d[l_ac].inaacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inaa2_d[l_ac].inaacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inaa2_d[l_ac].inaacrtid_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa2_d[l_ac].inaacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inaa2_d[l_ac].inaacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inaa2_d[l_ac].inaacrtdp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa2_d[l_ac].inaamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inaa2_d[l_ac].inaamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inaa2_d[l_ac].inaamodid_desc
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa2_d[l_ac].inaamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inaa2_d[l_ac].inaamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa2_d[l_ac].inaamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa2_d[l_ac].inaaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inaa2_d[l_ac].inaaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa2_d[l_ac].inaaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa2_d[l_ac].inaaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inaa2_d[l_ac].inaaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa2_d[l_ac].inaaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa2_d[l_ac].inaacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inaa2_d[l_ac].inaacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa2_d[l_ac].inaacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa2_d[l_ac].inaacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inaa2_d[l_ac].inaacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa2_d[l_ac].inaacrtdp_desc

         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_inaa3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inaa3_d[l_ac].inac003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inaa3_d[l_ac].inac003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inaa3_d[l_ac].inac003_desc

        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aini001.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aini001_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   DEFINE l_n     LIKE type_t.num5
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
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("inaa001",TRUE)
      
   END IF
   #新增的時候不會存在庫存交易，所以inaa011,inaa012開啟錄入
   CALL cl_set_comp_entry("inaa011,inaa012",TRUE)
   
   CALL cl_set_comp_entry("inaa018,inaa010",TRUE)

   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="aini001.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aini001_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_n     LIKE type_t.num5
   DEFINE lc_para_data    LIKE type_t.chr80
   
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
   IF p_cmd = "u" THEN

   END IF
         
   #如果存在庫存交易，則inaa010,inaa011,inaa012不允許修改
   LET l_n = 0  
   SELECT COUNT(*) INTO l_n FROM inaj_t 
     WHERE inajent = g_enterprise AND inajsite = g_site AND inaj008 = g_inaa_d[l_ac].inaa001
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("inaa011,inaa012",FALSE)
   END IF
   
   LET lc_para_data = cl_get_para(g_enterprise,g_site,'S-BAS-0043')
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM inac_t
    WHERE inacent = g_enterprise
      AND inacsite = g_site
      AND inac001 = g_inaa_d[l_ac].inaa001
      AND inac003 = lc_para_data
   IF l_n = 0 OR cl_null(l_n) THEN
      CALL cl_set_comp_entry("inaa018",FALSE)
      LET g_inaa_d[l_ac].inaa018_desc = ''
      LET g_inaa_d[l_ac].inaa018 = ''
   END IF
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM xcck_t WHERE xcckent = g_enterprise AND xccksite = g_site AND xcck015 = g_inaa_d[l_ac].inaa001 AND xcckstus <>'X'
   #该库位已经结算过成本
   IF l_n > 0 THEN
      CALL cl_set_comp_entry("inaa010",FALSE)
   END IF
   
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="aini001.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aini001_default_search()
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
      LET ls_wc = ls_wc, " inaa001 = '", g_argv[01], "' AND "
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
   IF g_wc = " 1=2" THEN
      LET g_wc = " 1=1"
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aini001.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aini001_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM inaa_t
       WHERE inaaent = g_enterprise AND inaasite = g_site AND
         inaa001 = ps_keys_bak[1]
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
   
 
   
   LET ls_group = "inac_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM inac_t
       WHERE inacent = g_enterprise AND inacsite = g_site AND
         inac001 = ps_keys_bak[1] AND inac002 = ps_keys_bak[2] AND inac003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "inaa_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM inac_t
       WHERE inacent = g_enterprise AND inacsite = g_site AND
         inac001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
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
 
{<section id="aini001.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aini001_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO inaa_t
                  (inaaent, inaasite,
                   inaa001
                   ,inaastus,inaa005,inaa018,inaa006,inaa007,inaa008,inaa009,inaa010,inaa014,inaa015,inaa017,inaa016,inaa011,inaa012,inaa013,inaamodid,inaamoddt,inaaownid,inaaowndp,inaacrtid,inaacrtdp,inaacrtdt) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1]
                   ,g_inaa_d[g_detail_idx].inaastus,g_inaa_d[g_detail_idx].inaa005,g_inaa_d[g_detail_idx].inaa018, 
                       g_inaa_d[g_detail_idx].inaa006,g_inaa_d[g_detail_idx].inaa007,g_inaa_d[g_detail_idx].inaa008, 
                       g_inaa_d[g_detail_idx].inaa009,g_inaa_d[g_detail_idx].inaa010,g_inaa_d[g_detail_idx].inaa014, 
                       g_inaa_d[g_detail_idx].inaa015,g_inaa_d[g_detail_idx].inaa017,g_inaa_d[g_detail_idx].inaa016, 
                       g_inaa_d[g_detail_idx].inaa011,g_inaa_d[g_detail_idx].inaa012,g_inaa_d[g_detail_idx].inaa013, 
                       g_inaa2_d[g_detail_idx].inaamodid,g_inaa2_d[g_detail_idx].inaamoddt,g_inaa2_d[g_detail_idx].inaaownid, 
                       g_inaa2_d[g_detail_idx].inaaowndp,g_inaa2_d[g_detail_idx].inaacrtid,g_inaa2_d[g_detail_idx].inaacrtdp, 
                       g_inaa2_d[g_detail_idx].inaacrtdt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
        
      #end add-point
   END IF
   
 
   
   LET ls_group = "inac_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
      #end add-point
      INSERT INTO inac_t
                  (inacent, inacsite,
                   inac001,inac002,inac003
                   ) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
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
 
{<section id="aini001.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aini001_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "inaa_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL aini001_inaa_t_mask_restore('restore_mask_o')
               
      UPDATE inaa_t 
         SET (inaa001
              ,inaastus,inaa005,inaa018,inaa006,inaa007,inaa008,inaa009,inaa010,inaa014,inaa015,inaa017,inaa016,inaa011,inaa012,inaa013,inaamodid,inaamoddt,inaaownid,inaaowndp,inaacrtid,inaacrtdp,inaacrtdt) 
              = 
             (ps_keys[1]
              ,g_inaa_d[g_detail_idx].inaastus,g_inaa_d[g_detail_idx].inaa005,g_inaa_d[g_detail_idx].inaa018, 
                  g_inaa_d[g_detail_idx].inaa006,g_inaa_d[g_detail_idx].inaa007,g_inaa_d[g_detail_idx].inaa008, 
                  g_inaa_d[g_detail_idx].inaa009,g_inaa_d[g_detail_idx].inaa010,g_inaa_d[g_detail_idx].inaa014, 
                  g_inaa_d[g_detail_idx].inaa015,g_inaa_d[g_detail_idx].inaa017,g_inaa_d[g_detail_idx].inaa016, 
                  g_inaa_d[g_detail_idx].inaa011,g_inaa_d[g_detail_idx].inaa012,g_inaa_d[g_detail_idx].inaa013, 
                  g_inaa2_d[g_detail_idx].inaamodid,g_inaa2_d[g_detail_idx].inaamoddt,g_inaa2_d[g_detail_idx].inaaownid, 
                  g_inaa2_d[g_detail_idx].inaaowndp,g_inaa2_d[g_detail_idx].inaacrtid,g_inaa2_d[g_detail_idx].inaacrtdp, 
                  g_inaa2_d[g_detail_idx].inaacrtdt) 
         WHERE inaaent = g_enterprise AND inaasite = g_site AND
               inaa001 = ps_keys_bak[1]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inaa_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL aini001_inaa_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "inac_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "inac_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL aini001_inac_t_mask_restore('restore_mask_o')
      
      UPDATE inac_t 
         SET (inac001,inac002,inac003
              ) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ) 
         WHERE inacent = g_enterprise AND inacsite = g_site AND
               inac001 = ps_keys_bak[1] AND inac002 = ps_keys_bak[2] AND inac003 = ps_keys_bak[3]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inac_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aini001_inac_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aini001.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION aini001_key_update_b()
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
   
   IF g_master.inaa001 <> g_master_t.inaa001 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE inac_t 
      SET (inac001) 
           = 
          (g_master.inaa001) 
      WHERE inacent = g_enterprise AND inacsite = g_site AND
           inac001 = g_master_t.inaa001
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inac_t:",SQLERRMESSAGE 
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
 
{<section id="aini001.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aini001_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aini001_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "inaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aini001_bcl USING g_enterprise, g_site,
                                       g_inaa_d[g_detail_idx].inaa001
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aini001_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "inac_t,"
   #僅鎖定自身table
   LET ls_group = "inac_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aini001_bcl2 USING g_enterprise, g_site,
                                             g_master.inaa001,
                                             g_inaa3_d[g_detail_idx2].inac002,g_inaa3_d[g_detail_idx2].inac003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aini001_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aini001.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aini001_unlock_b(ps_table)
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
      CLOSE aini001_bcl
   END IF
   
 
    
   LET ls_group = "inac_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aini001_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aini001.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION aini001_idx_chk(ps_loc)
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
      IF g_detail_idx > g_inaa_d.getLength() THEN
         LET g_detail_idx = g_inaa_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inaa_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_inaa_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_inaa2_d.getLength() THEN
         LET g_detail_idx = g_inaa2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inaa2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_inaa2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_inaa3_d.getLength() THEN
         LET g_detail_idx2 = g_inaa3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inaa3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_inaa3_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_inaa3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_inaa3_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aini001.mask_functions" >}
&include "erp/ain/aini001_mask.4gl"
 
{</section>}
 
{<section id="aini001.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aini001_set_pk_array()
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
   LET g_pk_array[1].values = g_inaa_d[g_detail_idx].inaa001
   LET g_pk_array[1].column = 'inaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aini001.state_change" >}
    
 
{</section>}
 
{<section id="aini001.func_signature" >}
   
 
{</section>}
 
{<section id="aini001.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aini001.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aini001_inac003_ref(p_inac003)
DEFINE p_inac003      LIKE inac_t.inac003
DEFINE r_inac003_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_inac003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_inac003_desc = g_rtn_fields[1]
      RETURN r_inac003_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aini001_insert_inab(p_inaa001,p_inaa006,p_inaa008,p_inaa009,p_inaastus)
DEFINE p_inaa001      LIKE inaa_t.inaa001
DEFINE p_inaa006      LIKE inaa_t.inaa006
DEFINE p_inaa008      LIKE inaa_t.inaa008
DEFINE p_inaa009      LIKE inaa_t.inaa009
DEFINE p_inaastus     LIKE inaa_t.inaastus
#DEFINE l_inab         RECORD LIKE inab_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_inab RECORD  #儲位基本資料檔
       inabent LIKE inab_t.inabent, #企业编号
       inabsite LIKE inab_t.inabsite, #营运据点
       inab001 LIKE inab_t.inab001, #库位编号
       inab002 LIKE inab_t.inab002, #储位编号
       inab003 LIKE inab_t.inab003, #储位名称
       inab004 LIKE inab_t.inab004, #助记码
       inab005 LIKE inab_t.inab005, #拣料优先级
       inab006 LIKE inab_t.inab006, #库存可用否
       inab007 LIKE inab_t.inab007, #MRP可用否
       inab008 LIKE inab_t.inab008, #Tag二进位码
       inabstus LIKE inab_t.inabstus, #状态码
       inabownid LIKE inab_t.inabownid, #资料所有者
       inabowndp LIKE inab_t.inabowndp, #资料所有部门
       inabcrtid LIKE inab_t.inabcrtid, #资料录入者
       inabcrtdp LIKE inab_t.inabcrtdp, #资料录入部门
       inabcrtdt LIKE inab_t.inabcrtdt, #资料创建日
       inabmodid LIKE inab_t.inabmodid, #资料更改者
       inabmoddt LIKE inab_t.inabmoddt #最近更改日
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_inaa013      LIKE inaa_t.inaa013
DEFINE l_inabcrtdt    DATETIME YEAR TO SECOND
DEFINE l_count     LIKE type_t.num5

      LET r_success = TRUE
      
      LET l_inab.inabent = g_enterprise
      LET l_inab.inabsite = g_site
      #LET l_inab.inab001 = g_inaa_d[l_ac].inaa001
      LET l_inab.inab001 = p_inaa001
      LET l_inab.inab002 =  ' '
      #LET l_inab.inab003 = g_inaa_d[l_ac].inaa001_desc
      #LET l_inab.inab004 = g_inaa_d[l_ac].inaa001_desc_desc
      
      #20151102 by stellar modify ----- (S)
#      SELECT inayl003,inayl004 INTO l_inab.inab003,l_inab.inab004 
#         FROM inayl_t WHERE inaylent = g_enterprise AND inayl001 = p_inaa001 AND inayl002 = g_dlang
      LET l_inab.inab003 = ''
      LET l_inab.inab004 = ''
      #20151102 by stellar modify ----- (E)
         
      #LET l_inab.inab005 = g_inaa_d[l_ac].inaa006
      #LET l_inab.inab006 = g_inaa_d[l_ac].inaa008
      #LET l_inab.inab007 = g_inaa_d[l_ac].inaa009
      LET l_inab.inab005 = p_inaa006
      LET l_inab.inab006 = p_inaa008
      LET l_inab.inab007 = p_inaa009
      LET l_success = ''
      LET l_inaa013 = ''
      #tag二進制碼初始化
      CALL s_aooi310_init_tagb('1') RETURNING l_success,l_inaa013
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gen inaa013"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE 
         RETURN r_success
      ELSE
         LET l_inab.inab008 = l_inaa013
      END IF
      #LET l_inab.inabstus = g_inaa_d[l_ac].inaastus
      LET l_inab.inabstus = p_inaastus
      LET l_inab.inabownid = g_user
      LET l_inab.inabowndp = g_dept
      LET l_inab.inabcrtid = g_user
      LET l_inab.inabcrtdp = g_dept
      LET l_inabcrtdt = cl_get_current()
      LET l_inab.inabmodid = g_user
      
      SELECT COUNT(*) INTO l_count FROM inab_t 
             WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = p_inaa001 AND inab002 = ' '
      IF l_count = 0 OR cl_null(l_count) THEN   
      
         INSERT INTO inab_t
                     (inabent, inabsite,
                      inab001,inab002
                      ,inabstus,inab003,inab004,inab005,inab006,inab007,inab008,inabownid,inabowndp,inabcrtid,inabcrtdp,inabcrtdt,inabmodid,inabmoddt) 
               VALUES(l_inab.inabent, l_inab.inabsite,
                      l_inab.inab001,l_inab.inab002,
                      l_inab.inabstus,l_inab.inab003,l_inab.inab004,l_inab.inab005,l_inab.inab006,l_inab.inab007,l_inab.inab008,l_inab.inabownid,l_inab.inabowndp,l_inab.inabcrtid,l_inab.inabcrtdp,l_inabcrtdt,l_inab.inabmodid,l_inabcrtdt)
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "gen inaa013"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE 
            RETURN r_success
         END IF 
      END IF         
      RETURN r_success
      
END FUNCTION
#檢核庫存明細檔中是否有資料，若有不等於0的資料，不允許無效
PRIVATE FUNCTION aini001_inaastus_chk(p_inaa001)
DEFINE p_inaa001     LIKE inaa_t.inaa001
DEFINE l_n           LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5

      LET r_success = TRUE
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM inag_t 
        WHERE inagent = g_enterprise AND inagsite = g_site 
           AND inag004 = p_inaa001 AND (inag008 <> 0)
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00006'
         LET g_errparam.extend = p_inaa001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM inah_t 
        WHERE inahent = g_enterprise AND inahsite = g_site 
           AND inah004 = p_inaa001 AND (inah009 <> 0)
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00010'
         LET g_errparam.extend = p_inaa001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM inai_t 
        WHERE inaient = g_enterprise AND inaisite = g_site 
           AND inai004 = p_inaa001 AND (inai010 <> 0)
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ain-00011'
         LET g_errparam.extend = p_inaa001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      
      RETURN r_success
        
END FUNCTION
#如果儲位編號存在除了' '的資料，則不能將儲位管理設成 '5'不使用儲位管理
PRIVATE FUNCTION aini001_inaa007_chk(p_inaa001)
DEFINE p_inaa001   LIKE inaa_t.inaa001
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5

      LET r_success = TRUE
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM inab_t
        WHERE inabent = g_enterprise AND inabsite = g_site
          AND inab001 = p_inaa001 AND inab002 <> ' '
      IF l_n > 0 THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION aini001_inac003_chk(p_inac003)
DEFINE p_inac003      LIKE inac_t.inac003
DEFINE r_success      LIKE type_t.num5

      LET r_success = TRUE
      IF NOT cl_null(p_inac003) THEN 
         IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inac_t WHERE "||"inacent = '" ||g_enterprise|| "' AND inacsite = '" ||g_site|| "' AND inac001 = '"||g_master.inaa001 || "' AND inac002 = ' ' AND inac003 = '"||p_inac003||"'",'std-00004',0) THEN 
            LET r_success = FALSE
            RETURN r_success
         END IF 
         
         IF NOT ap_chk_isExist(p_inac003,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '220' AND oocq002 = ? ","sub-01303",'aini003') THEN#160318-00005#21 mod#"ain-00008",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         IF NOT ap_chk_isExist(p_inac003,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '" ||g_enterprise||"' AND oocq001 = '220' AND oocq002 = ? AND oocqstus = 'Y' ",'sub-01302','aini003') THEN#160318-00005#21 mod #"ain-00009",1 ) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      RETURN r_success
      
END FUNCTION
#開窗可選多個，新增到inac_t
PRIVATE FUNCTION aini001_insert_inac(p_inac003,p_inaa001)
DEFINE p_inac003   STRING
DEFINE p_inaa001   LIKE inaa_t.inaa001
DEFINE bst         base.StringTokenizer
DEFINE l_inac003   LIKE inac_t.inac003
DEFINE r_success   LIKE type_t.num5
DEFINE l_inaccrtdt LIKE inac_t.inaccrtdt
DEFINE l_inaa013   LIKE inaa_t.inaa013
DEFINE l_oocr003   LIKE oocr_t.oocr003
DEFINE l_success   LIKE type_t.num5

      LET r_success = TRUE
      
      CALL s_transaction_begin()  
      CALL cl_showmsg_init()
      LET l_inaccrtdt = cl_get_current()
      LET bst= base.StringTokenizer.create(p_inac003,'|')
      WHILE bst.hasMoreTokens()
         LET l_inac003 = bst.nextToken()
         INSERT INTO inac_t
                  (inacent, inacsite,inac001,inac002,inac003,inacstus,
                   inacownid,inacowndp,inaccrtid,inaccrtdp,inaccrtdt
                   ) 
            VALUES(g_enterprise, g_site,p_inaa001,' ',l_inac003,'Y',
                   g_user,g_dept,g_user,g_dept,l_inaccrtdt
                   )
         IF SQLCA.sqlcode THEN
            IF SQLCA.sqlcode = '-268' THEN   #重复的标签编号，跳过
               CONTINUE WHILE
            ELSE
               CALL cl_errmsg(l_inac003,'inac_t','',SQLCA.sqlcode,1)
               #CALL cl_err("inac_t",SQLCA.sqlcode,0)
               LET r_success = FALSE
            END IF
         END IF 
         #關聯標籤同步新增
         DECLARE oocr003_cs CURSOR FOR 
            SELECT oocr003 FROM oocr_t 
            WHERE oocrent = g_enterprise AND oocr001 = '220' AND oocr002 = l_inac003 AND oocrstus = 'Y'
              AND oocr003 NOT IN (SELECT inac003 FROM inac_t WHERE inacent = g_enterprise AND inac001 = p_inaa001 AND inac002 = ' ')  #160905-00007#4 BY 08172 add ent
         FOREACH oocr003_cs INTO l_oocr003
            INSERT INTO inac_t
                  (inacent, inacsite,inac001,inac002,inac003,inacstus,
                   inacownid,inacowndp,inaccrtid,inaccrtdp,inaccrtdt
                   ) 
            VALUES(g_enterprise, g_site,p_inaa001,' ',l_oocr003,'Y',
                   g_user,g_dept,g_user,g_dept,l_inaccrtdt
                   )
            IF SQLCA.sqlcode THEN
               IF SQLCA.sqlcode = '-268' THEN   #重复的标签编号，跳过
                  CONTINUE FOREACH
               ELSE
                  CALL cl_errmsg(l_oocr003,'inac_t','',SQLCA.sqlcode,1)
                  #CALL cl_err("inac_t",SQLCA.sqlcode,0)
                  LET r_success = FALSE
                  CONTINUE FOREACH
               END IF
            END IF
         END FOREACH
      END WHILE
      #產生tag二進制碼
      LET l_success = ''
      LET l_inaa013 = ''
      CALL s_aooi310_gen_tagb(p_inaa001,' ','2') RETURNING l_success,l_inaa013
      IF NOT l_success THEN
         CALL cl_errmsg(l_inaa013,'gen inaa013','',SQLCA.sqlcode,1)
         #CALL cl_err("gen inaa013",SQLCA.sqlcode,1)  
         LET r_success = FALSE
      ELSE
         UPDATE inaa_t SET inaa013 = l_inaa013 WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = p_inaa001
         IF SQLCA.SQLcode  THEN
            CALL cl_errmsg(l_inaa013,'inaa_t','',SQLCA.sqlcode,1)
            #CALL cl_err("inaa_t",SQLCA.sqlcode,1)  
            LET r_success = FALSE
         END IF
         UPDATE inab_t SET inab008 = l_inaa013 WHERE inabent = g_enterprise AND inabsite = g_site AND inab001 = p_inaa001 AND inab002 = ' '
         IF SQLCA.SQLcode  THEN
            CALL cl_errmsg(l_inaa013,'inab_t','',SQLCA.sqlcode,1)
            #CALL cl_err("inab_t",SQLCA.sqlcode,1)  
            LET r_success = FALSE
         END IF
         UPDATE inag_t SET inag023 = l_inaa013 WHERE inagent = g_enterprise AND inagsite = g_site AND inag004 = p_inaa001 AND inag005 = ' '
         IF SQLCA.SQLcode  THEN
            #CALL cl_err("inag_t",SQLCA.sqlcode,1)  
            CALL cl_errmsg(l_inaa013,'inag_t','',SQLCA.sqlcode,1) 
            LET r_success = FALSE
         END IF
         UPDATE inah_t SET inah011 = l_inaa013 WHERE inahent = g_enterprise AND inahsite = g_site AND inah004 = p_inaa001 AND inah005 = ' '
         IF SQLCA.SQLcode  THEN
            #CALL cl_err("inah_t",SQLCA.sqlcode,1)  
            CALL cl_errmsg(l_inaa013,'inah_t','',SQLCA.sqlcode,1) 
            LET r_success = FALSE
         END IF
         UPDATE inai_t SET inai013 = l_inaa013 WHERE inaient = g_enterprise AND inaisite = g_site AND inai004 = p_inaa001 AND inai005 = ' '
         IF SQLCA.SQLcode  THEN
            #CALL cl_err("inai_t",SQLCA.sqlcode,1)  
            CALL cl_errmsg(l_inaa013,'inai_t','',SQLCA.sqlcode,1) 
            LET r_success = FALSE
         END IF
      END IF
      IF r_success THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
      #CALL cl_showmsg()
      CALL cl_err_showmsg()
      
      RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION aini001_b_fill2(p_inaa001)
DEFINE p_inaa001  LIKE inaa_t.inaa001
   
   CALL g_inaa3_d.clear()

   LET g_sql = "SELECT  UNIQUE inac002,inac003,'' FROM inac_t",  
               " WHERE inacent=? AND inacsite=? AND inac001=? AND inac002 = ? "

   LET g_sql = g_sql, " ORDER BY inac002 " 
                      
   PREPARE aini001_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR aini001_pb3
   
   OPEN b_fill_curs3 USING g_enterprise, g_site,p_inaa001,' '

   LET l_ac = 1
   FOREACH b_fill_curs3 INTO g_inaa3_d[l_ac].inac002,g_inaa3_d[l_ac].inac003,g_inaa3_d[l_ac].inac003_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL aini001_inac003_ref(g_inaa3_d[l_ac].inac003) RETURNING g_inaa3_d[l_ac].inac003_desc

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   CALL g_inaa3_d.deleteElement(g_inaa3_d.getLength())   

END FUNCTION

################################################################################
# Descriptions...: 抓取库位名称显示
################################################################################
PRIVATE FUNCTION aini001_inaa001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa_d[l_ac].inaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT inayl003,inayl004 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inaa_d[l_ac].inaa001_desc = '', g_rtn_fields[1] , ''
   LET g_inaa_d[l_ac].inaa001_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inaa_d[l_ac].inaa001_desc
   DISPLAY BY NAME g_inaa_d[l_ac].inaa001_desc_desc
END FUNCTION

################################################################################
# Descriptions...: VMI結算庫位檢核
# Memo...........:
# Usage..........: CALL aini001_inaa018_chk()
# Input parameter: no
# Return code....: TRUE OR FALSE
# Date & Author..: 140828 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aini001_inaa018_chk()
DEFINE lc_para_data  LIKE type_t.chr80
DEFINE l_n           LIKE type_t.num5

   #庫位檢核
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_inaa_d[l_ac].inaa018
   #160318-00025#23  by 07900 --add-str
   LET g_errshow = TRUE #是否開窗                   
   LET g_chkparam.err_str[1] ="aoo-00054:sub-01302|aooi010|",cl_get_progname("aooi010",g_lang,"2"),"|:EXEPROGaooi010"
   #160318-00025#23  by 07900 --add-end
   IF NOT cl_chk_exist("v_inay001") THEN
      RETURN FALSE
   END IF
   
   #VMI結算庫位Tag
   LET lc_para_data = cl_get_para(g_enterprise,g_site,'S-BAS-0044')
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM inac_t
    WHERE inacent = g_enterprise
      AND inacsite = g_site
      AND inac001 = g_inaa_d[l_ac].inaa018
      AND inac003 = lc_para_data
   #此庫位非VMI結算庫位！
   IF l_n = 0 OR cl_null(l_n) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00313'
      LET g_errparam.extend = 'inaa018'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaasite = g_site
      AND inaa018 = g_inaa_d[l_ac].inaa018
   #VMI存貨庫位與VMI結算庫位需為一對一，該VMI結算庫位已為其他VMI存貨庫位對應！
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00314'
      LET g_errparam.extend = 'inaa018'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 庫位新增時，開窗多選
# Memo...........:
# Usage..........: CALL s_aini001_ins_inaa (p_inaa001)
#                  RETURNING r_success
# Input parameter: p_inaa001      庫位編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/06/11 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION aini001_ins_inaa(p_inaa001)
DEFINE p_inaa001   LIKE inaa_t.inaa001
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_ac1       LIKE type_t.num5  #標記下標
#DEFINE l_inaa      RECORD LIKE inaa_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_inaa RECORD  #庫位基本資料檔
       inaaent LIKE inaa_t.inaaent, #企业编号
       inaasite LIKE inaa_t.inaasite, #营运据点
       inaaunit LIKE inaa_t.inaaunit, #应用组织
       inaa001 LIKE inaa_t.inaa001, #库位编号
       inaa002 LIKE inaa_t.inaa002, #库位名称
       inaa003 LIKE inaa_t.inaa003, #助记码
       inaa004 LIKE inaa_t.inaa004, #连络对象识别码
       inaa005 LIKE inaa_t.inaa005, #成本中心
       inaa006 LIKE inaa_t.inaa006, #拣料优先级
       inaa007 LIKE inaa_t.inaa007, #储位控管
       inaa008 LIKE inaa_t.inaa008, #库存可用否
       inaa009 LIKE inaa_t.inaa009, #MRP可用否
       inaa010 LIKE inaa_t.inaa010, #成本库否
       inaa011 LIKE inaa_t.inaa011, #与WMS集成否
       inaa012 LIKE inaa_t.inaa012, #自动仓储集成否
       inaa013 LIKE inaa_t.inaa013, #Tag二进位码
       inaa014 LIKE inaa_t.inaa014, #允许负库存否
       inaa015 LIKE inaa_t.inaa015, #保税否
       inaa016 LIKE inaa_t.inaa016, #待报废库否
       inaa017 LIKE inaa_t.inaa017, #存货冻结否
       inaa018 LIKE inaa_t.inaa018, #结算库位
       inaa101 LIKE inaa_t.inaa101, #库位类别
       inaa102 LIKE inaa_t.inaa102, #库区类别
       inaa103 LIKE inaa_t.inaa103, #销售类别
       inaa104 LIKE inaa_t.inaa104, #收入类别
       inaa105 LIKE inaa_t.inaa105, #业态
       inaa106 LIKE inaa_t.inaa106, #品类
       inaa110 LIKE inaa_t.inaa110, #收银方式
       inaa111 LIKE inaa_t.inaa111, #商品管理方式
       inaa120 LIKE inaa_t.inaa120, #专柜编号
       inaa121 LIKE inaa_t.inaa121, #场地
       inaa122 LIKE inaa_t.inaa122, #区域
       inaa123 LIKE inaa_t.inaa123, #楼层
       inaa124 LIKE inaa_t.inaa124, #楼栋
       inaa130 LIKE inaa_t.inaa130, #启用日期
       inaastus LIKE inaa_t.inaastus, #状态码
       inaaownid LIKE inaa_t.inaaownid, #资料所有者
       inaaowndp LIKE inaa_t.inaaowndp, #资料所有部门
       inaacrtid LIKE inaa_t.inaacrtid, #资料录入者
       inaacrtdp LIKE inaa_t.inaacrtdp, #资料录入部门
       inaacrtdt LIKE inaa_t.inaacrtdt, #资料创建日
       inaamodid LIKE inaa_t.inaamodid, #资料更改者
       inaamoddt LIKE inaa_t.inaamoddt, #最近更改日
       inaa131 LIKE inaa_t.inaa131, #管理方式
       inaa132 LIKE inaa_t.inaa132, #参与自动补货
       inaa133 LIKE inaa_t.inaa133, #参与上下限计算
       inaa134 LIKE inaa_t.inaa134, #专柜类型
       inaa135 LIKE inaa_t.inaa135, #库区用途分类
       inaa136 LIKE inaa_t.inaa136, #是否为默认库区
       inaa137 LIKE inaa_t.inaa137, #接赠卡否
       inaa138 LIKE inaa_t.inaa138, #接赠券否
       inaa139 LIKE inaa_t.inaa139, #接礼券否
       inaa140 LIKE inaa_t.inaa140, #库区特殊属性
       inaastamp LIKE inaa_t.inaastamp, #下传时间戳
       inaa141 LIKE inaa_t.inaa141, #对应常规库区
       inaa142 LIKE inaa_t.inaa142 #优先级
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
DEFINE l_inaacrtdt DATETIME YEAR TO SECOND
DEFINE l_count     LIKE type_t.num5
DEFINE  l_inaa004  LIKE inaa_t.inaa004
DEFINE  l_inaa013  LIKE inaa_t.inaa013

       LET r_success = TRUE
       
       IF cl_null(p_inaa001) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       
       SELECT COUNT(*) INTO l_count FROM inaa_t 
             WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = p_inaa001 
       IF l_count > 0 THEN   
          LET r_success = FALSE
          RETURN r_success
       END IF
       
       LET l_success = ''
       LET l_inaa004 = ''
       CALL s_aooi350_ins_oofa('8',p_inaa001,'') RETURNING l_success,l_inaa004
       IF NOT l_success THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "oofa_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
       
       LET l_success = ''
       LET l_inaa013 = ''
       #tag二進制碼初始化
       CALL s_aooi310_init_tagb('1') RETURNING l_success,l_inaa013
       IF NOT l_success THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "gen inaa013"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
          
       END IF
       
       #預設上一筆資料的值，若當前下標即為1，則預設下一筆資料的，若都無資料，則預設初始化值
       IF l_ac > 1 THEN  
          LET l_ac1 = l_ac - 1
       ELSE
          LET l_ac1 = l_ac + 1
       END IF
       
       LET l_inaa.inaastus = "Y"
       
       LET l_inaa.inaaownid = g_user
       LET l_inaa.inaaowndp = g_dept
       LET l_inaa.inaacrtid = g_user
       LET l_inaa.inaacrtdp = g_dept 
       LET l_inaacrtdt = cl_get_current()
       LET l_inaa.inaamodid = g_user
       
       LET l_inaa.inaa004 = l_inaa004
       LET l_inaa.inaa007 = "1"
       LET l_inaa.inaa008 = "Y"
       LET l_inaa.inaa009 = "Y"
       LET l_inaa.inaa010 = "Y"
       LET l_inaa.inaa014 = "N"
       LET l_inaa.inaa015 = "N"
       LET l_inaa.inaa017 = "N"
       LET l_inaa.inaa016 = "N"
       LET l_inaa.inaa011 = "N"
       LET l_inaa.inaa012 = "N"
       LET l_inaa.inaa013 = l_inaa013
 
       IF l_ac1 > 0 THEN
          IF NOT cl_null(g_inaa_d[l_ac1].inaa001) THEN
             LET l_inaa.inaa005 = g_inaa_d[l_ac1].inaa005
             LET l_inaa.inaa018 = g_inaa_d[l_ac1].inaa018
             LET l_inaa.inaa006 = g_inaa_d[l_ac1].inaa006
             LET l_inaa.inaa007 = g_inaa_d[l_ac1].inaa007
             LET l_inaa.inaa008 = g_inaa_d[l_ac1].inaa008
             LET l_inaa.inaa009 = g_inaa_d[l_ac1].inaa009
             LET l_inaa.inaa010 = g_inaa_d[l_ac1].inaa010
             LET l_inaa.inaa014 = g_inaa_d[l_ac1].inaa014
             LET l_inaa.inaa015 = g_inaa_d[l_ac1].inaa015
             LET l_inaa.inaa017 = g_inaa_d[l_ac1].inaa017
             LET l_inaa.inaa016 = g_inaa_d[l_ac1].inaa016
             LET l_inaa.inaa011 = g_inaa_d[l_ac1].inaa011
          END IF
       END IF
       
       INSERT INTO inaa_t
              (inaaent,inaasite,inaa001,inaastus,inaa004,inaa005,inaa018,inaa006,inaa007,inaa008,inaa009,inaa010,inaa014,inaa015,inaa017,
               inaa016,inaa011,inaa012,inaa013,inaamodid,inaamoddt,inaaownid,inaaowndp,inaacrtid,inaacrtdp,inaacrtdt) 
        VALUES(g_enterprise, g_site,p_inaa001,l_inaa.inaastus,l_inaa.inaa004,l_inaa.inaa005,l_inaa.inaa018,l_inaa.inaa006,
               l_inaa.inaa007,l_inaa.inaa008, 
               l_inaa.inaa009,l_inaa.inaa010,l_inaa.inaa014,l_inaa.inaa015,l_inaa.inaa017,l_inaa.inaa016, 
               l_inaa.inaa011,l_inaa.inaa012,l_inaa.inaa013,l_inaa.inaamodid,l_inaacrtdt,l_inaa.inaaownid, 
               l_inaa.inaaowndp,l_inaa.inaacrtid,l_inaa.inaacrtdp,l_inaacrtdt)
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "inaa_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF       
       
       LET l_success = ''
       IF NOT aini001_insert_inab(p_inaa001,l_inaa.inaa006,l_inaa.inaa008,l_inaa.inaa009,l_inaa.inaastus)  THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       
       RETURN r_success
       
END FUNCTION

 
{</section>}
 
