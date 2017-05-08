#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi552.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-05-03 17:15:21), PR版次:0005(2016-05-03 17:26:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: azzi552
#+ Description: 標準操作流程文件(SOP)管理作業
#+ Creator....: 00845(2015-06-23 17:12:07)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="azzi552.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#160503-00001#1...：2016/05/03 By dorislai   1.新增SOP文件刪除按鈕
#                                            2.增加刪除按鈕(action)的開關控制
#                                            3.修正同介面語言編號有資料，還多出一行"file_not_found"的問題
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
IMPORT security
IMPORT JAVA java.net.URLEncoder
#end add-point
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzte_d RECORD
       gzte001 LIKE gzte_t.gzte001, 
   gztel003 LIKE gztel_t.gztel003, 
   gzte002 LIKE gzte_t.gzte002, 
   gzte003 LIKE gzte_t.gzte003, 
   gzte004 LIKE gzte_t.gzte004
       END RECORD
PRIVATE TYPE type_g_gzte2_d RECORD
       gzte001 LIKE gzte_t.gzte001, 
   gzteownid LIKE gzte_t.gzteownid, 
   gzteownid_desc LIKE type_t.chr500, 
   gzteowndp LIKE gzte_t.gzteowndp, 
   gzteowndp_desc LIKE type_t.chr500, 
   gztecrtid LIKE gzte_t.gztecrtid, 
   gztecrtid_desc LIKE type_t.chr500, 
   gztecrtdp LIKE gzte_t.gztecrtdp, 
   gztecrtdp_desc LIKE type_t.chr500, 
   gztecrtdt DATETIME YEAR TO SECOND, 
   gztemodid LIKE gzte_t.gztemodid, 
   gztemodid_desc LIKE type_t.chr500, 
   gztemoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_gzte3_d RECORD
       gztf004 LIKE gztf_t.gztf004, 
   gztf002 LIKE gztf_t.gztf002, 
   gztf002_desc LIKE type_t.chr500
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      gztel001 LIKE gztel_t.gztel001,
      gztel002 LIKE gztel_t.gztel002,
      gztel003 LIKE gztel_t.gztel003
      END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gzzy_d       DYNAMIC ARRAY OF RECORD
       gzzy001        LIKE gzzy_t.gzzy001,   #語系
       l_filename     LIKE type_t.chr500,    #文件名稱
       l_cust         LIKE type_t.chr1       #客製文件否
       END RECORD
DEFINE g_detail_idx3  LIKE type_t.num10             #單身所在筆數(第二階單身)

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_gzte_d
DEFINE g_master_t                   type_g_gzte_d
DEFINE g_gzte_d          DYNAMIC ARRAY OF type_g_gzte_d
DEFINE g_gzte_d_t        type_g_gzte_d
DEFINE g_gzte_d_o        type_g_gzte_d
DEFINE g_gzte_d_mask_o   DYNAMIC ARRAY OF type_g_gzte_d #轉換遮罩前資料
DEFINE g_gzte_d_mask_n   DYNAMIC ARRAY OF type_g_gzte_d #轉換遮罩後資料
DEFINE g_gzte2_d          DYNAMIC ARRAY OF type_g_gzte2_d
DEFINE g_gzte2_d_t        type_g_gzte2_d
DEFINE g_gzte2_d_o        type_g_gzte2_d
DEFINE g_gzte2_d_mask_o   DYNAMIC ARRAY OF type_g_gzte2_d #轉換遮罩前資料
DEFINE g_gzte2_d_mask_n   DYNAMIC ARRAY OF type_g_gzte2_d #轉換遮罩後資料
DEFINE g_gzte3_d          DYNAMIC ARRAY OF type_g_gzte3_d
DEFINE g_gzte3_d_t        type_g_gzte3_d
DEFINE g_gzte3_d_o        type_g_gzte3_d
DEFINE g_gzte3_d_mask_o   DYNAMIC ARRAY OF type_g_gzte3_d #轉換遮罩前資料
DEFINE g_gzte3_d_mask_n   DYNAMIC ARRAY OF type_g_gzte3_d #轉換遮罩後資料
 
      
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
 
{<section id="azzi552.main" >}
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
   CALL cl_ap_init("azz","")
 
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
      OPEN WINDOW w_azzi552 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi552_init()   
 
      #進入選單 Menu (="N")
      CALL azzi552_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi552
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi552.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzi552_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   
   
   LET l_ac = 1
   
LET g_detail_multi_table_t.gztel001 = g_gzte_d[l_ac].gzte001
LET g_detail_multi_table_t.gztel002 = g_dlang
LET g_detail_multi_table_t.gztel003 = g_gzte_d[l_ac].gztel003
 
 
   
LET g_detail_multi_table_t.gztel001 = g_gzte_d[l_ac].gzte001
LET g_detail_multi_table_t.gztel002 = g_dlang
LET g_detail_multi_table_t.gztel003 = g_gzte_d[l_ac].gztel003
 
 
   
 
 
   #避免USER直接進入第二單身時無資料
   IF g_gzte_d.getLength() > 0 THEN
      LET g_master_t.* = g_gzte_d[1].*
      LET g_master.* = g_gzte_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   IF FGL_GETENV("DGENV") = "s" THEN
      CALL cl_set_combo_module_reg("gzte002",1)
   ELSE
      CALL cl_set_combo_module("gzte002",1)
   END IF
   #end add-point
   
   CALL azzi552_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzi552_ui_dialog()
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
         CALL g_gzte_d.clear()
         CALL g_gzte2_d.clear()
         CALL g_gzte3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi552_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      
      #end add-point
   
      CALL azzi552_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzte_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_master.* = g_gzte_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL azzi552_fetch()
               CALL azzi552_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL azzi552_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_gzte2_d TO s_detail2.*
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
               LET g_master.* = g_gzte_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL azzi552_fetch()
               CALL azzi552_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL azzi552_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_gzte3_d TO s_detail3.*
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
               CALL azzi552_idx_chk('d')
               LET g_master.* = g_gzte_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_gzzy_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd2' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx3)
               END IF
               LET g_loc = 'd2'


            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx3
            #  CALL azzi552_idx_chk('d')
               LET g_master.* = g_gzte_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               #160503-00001#1-add-(S)
               CALL azzi552_set_act_visible_b()
               CALL azzi552_set_act_no_visible_b()
               #160503-00001#1-add-(E)

            ON ACTION sop_click   #雙點擊單身時開啟文件
               IF cl_auth_chk_act("sop_click") THEN
                  CALL azzi552_doc_open()
               END IF
               
         END DISPLAY
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_gzte_d.getLength() THEN
                  LET g_detail_idx = g_gzte_d.getLength()
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
            LET g_export_node[1] = base.typeInfo.create(g_gzte_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_gzte2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_gzte3_d)
            LET g_export_id[3]   = "s_detail3"
 
            #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
            
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
         
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi552_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi552_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION doc_delete
            LET g_action_choice="doc_delete"
            IF cl_auth_chk_act("doc_delete") THEN
               
               #add-point:ON ACTION doc_delete name="menu.doc_delete"
               CALL azzi552_doc_delete() #160503-00001#1-add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION package_all
            LET g_action_choice="package_all"
            IF cl_auth_chk_act("package_all") THEN
               
               #add-point:ON ACTION package_all name="menu.package_all"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION package_module
            LET g_action_choice="package_module"
            IF cl_auth_chk_act("package_module") THEN
               
               #add-point:ON ACTION package_module name="menu.package_module"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION docupload
            LET g_action_choice="docupload"
            IF cl_auth_chk_act("docupload") THEN
               
               #add-point:ON ACTION docupload name="menu.docupload"
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail4")
               CALL azzi552_doc_upload()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi552_insert()
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
               CALL azzi552_query()
               #add-point:ON ACTION query name="menu.query"
 
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION docdownload
            LET g_action_choice="docdownload"
            IF cl_auth_chk_act("docdownload") THEN
               
               #add-point:ON ACTION docdownload name="menu.docdownload"
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail4")
               CALL azzi552_doc_download()
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
            CALL azzi552_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi552_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi552_set_pk_array()
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
 
{<section id="azzi552.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi552_query()
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
   CALL g_gzte_d.clear()
   CALL g_gzte2_d.clear()
   CALL g_gzte3_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON gzte001,gztel003,gzte002,gzte003,gzte004,gzteownid,gzteowndp,gztecrtid, 
          gztecrtdp,gztecrtdt,gztemodid,gztemoddt
           FROM s_detail1[1].gzte001,s_detail1[1].gztel003,s_detail1[1].gzte002,s_detail1[1].gzte003, 
               s_detail1[1].gzte004,s_detail2[1].gzteownid,s_detail2[1].gzteowndp,s_detail2[1].gztecrtid, 
               s_detail2[1].gztecrtdp,s_detail2[1].gztecrtdt,s_detail2[1].gztemodid,s_detail2[1].gztemoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gztecrtdt>>----
         AFTER FIELD gztecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gztemoddt>>----
         AFTER FIELD gztemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gztecnfdt>>----
         
         #----<<gztepstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.gzte001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte001
            #add-point:ON ACTION controlp INFIELD gzte001 name="construct.c.page1.gzte001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzte001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzte001  #顯示到畫面上
            NEXT FIELD gzte001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte001
            #add-point:BEFORE FIELD gzte001 name="construct.b.page1.gzte001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte001
            
            #add-point:AFTER FIELD gzte001 name="construct.a.page1.gzte001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztel003
            #add-point:BEFORE FIELD gztel003 name="construct.b.page1.gztel003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztel003
            
            #add-point:AFTER FIELD gztel003 name="construct.a.page1.gztel003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gztel003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztel003
            #add-point:ON ACTION controlp INFIELD gztel003 name="construct.c.page1.gztel003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte002
            #add-point:BEFORE FIELD gzte002 name="construct.b.page1.gzte002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte002
            
            #add-point:AFTER FIELD gzte002 name="construct.a.page1.gzte002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzte002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte002
            #add-point:ON ACTION controlp INFIELD gzte002 name="construct.c.page1.gzte002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte003
            #add-point:BEFORE FIELD gzte003 name="construct.b.page1.gzte003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte003
            
            #add-point:AFTER FIELD gzte003 name="construct.a.page1.gzte003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzte003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte003
            #add-point:ON ACTION controlp INFIELD gzte003 name="construct.c.page1.gzte003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte004
            #add-point:BEFORE FIELD gzte004 name="construct.b.page1.gzte004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte004
            
            #add-point:AFTER FIELD gzte004 name="construct.a.page1.gzte004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzte004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte004
            #add-point:ON ACTION controlp INFIELD gzte004 name="construct.c.page1.gzte004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzteownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzteownid
            #add-point:ON ACTION controlp INFIELD gzteownid name="construct.c.page2.gzteownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzteownid  #顯示到畫面上
            NEXT FIELD gzteownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzteownid
            #add-point:BEFORE FIELD gzteownid name="construct.b.page2.gzteownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzteownid
            
            #add-point:AFTER FIELD gzteownid name="construct.a.page2.gzteownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzteowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzteowndp
            #add-point:ON ACTION controlp INFIELD gzteowndp name="construct.c.page2.gzteowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzteowndp  #顯示到畫面上
            NEXT FIELD gzteowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzteowndp
            #add-point:BEFORE FIELD gzteowndp name="construct.b.page2.gzteowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzteowndp
            
            #add-point:AFTER FIELD gzteowndp name="construct.a.page2.gzteowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gztecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztecrtid
            #add-point:ON ACTION controlp INFIELD gztecrtid name="construct.c.page2.gztecrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztecrtid  #顯示到畫面上
            NEXT FIELD gztecrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztecrtid
            #add-point:BEFORE FIELD gztecrtid name="construct.b.page2.gztecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztecrtid
            
            #add-point:AFTER FIELD gztecrtid name="construct.a.page2.gztecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gztecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztecrtdp
            #add-point:ON ACTION controlp INFIELD gztecrtdp name="construct.c.page2.gztecrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztecrtdp  #顯示到畫面上
            NEXT FIELD gztecrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztecrtdp
            #add-point:BEFORE FIELD gztecrtdp name="construct.b.page2.gztecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztecrtdp
            
            #add-point:AFTER FIELD gztecrtdp name="construct.a.page2.gztecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztecrtdt
            #add-point:BEFORE FIELD gztecrtdt name="construct.b.page2.gztecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gztemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztemodid
            #add-point:ON ACTION controlp INFIELD gztemodid name="construct.c.page2.gztemodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztemodid  #顯示到畫面上
            NEXT FIELD gztemodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztemodid
            #add-point:BEFORE FIELD gztemodid name="construct.b.page2.gztemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztemodid
            
            #add-point:AFTER FIELD gztemodid name="construct.a.page2.gztemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztemoddt
            #add-point:BEFORE FIELD gztemoddt name="construct.b.page2.gztemoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON gztf004,gztf002
           FROM s_detail3[1].gztf004,s_detail3[1].gztf002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztf004
            #add-point:BEFORE FIELD gztf004 name="construct.b.page3.gztf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztf004
            
            #add-point:AFTER FIELD gztf004 name="construct.a.page3.gztf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gztf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztf004
            #add-point:ON ACTION controlp INFIELD gztf004 name="construct.c.page3.gztf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztf002
            #add-point:BEFORE FIELD gztf002 name="construct.b.page3.gztf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztf002
            
            #add-point:AFTER FIELD gztf002 name="construct.a.page3.gztf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gztf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztf002
            #add-point:ON ACTION controlp INFIELD gztf002 name="construct.c.page3.gztf002"
            
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
   CALL azzi552_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL azzi552_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_gzte_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_gzte3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552.insert" >}
#+ 資料修改
PRIVATE FUNCTION azzi552_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL azzi552_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi552.modify" >}
#+ 資料新增
PRIVATE FUNCTION azzi552_modify()
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
   CALL azzi552_input('u')
    
   IF INT_FLAG AND g_gzte_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL azzi552_b_fill(g_wc)
      CALL azzi552_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi552.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi552_delete()
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
   LET g_gzte_d_t.* = g_gzte_d[li_ac].*
   LET g_gzte_d_o.* = g_gzte_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM gzte_t 
         WHERE 
           gzte001 = g_gzte_d_t.gzte001
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzte_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi552_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM gztf_t 
         WHERE 
           gztf001 = g_gzte_d_t.gzte001
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
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
 
{<section id="azzi552.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi552_input(p_cmd)
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
   LET g_forupd_sql = "SELECT gzte001,gzte002,gzte003,gzte004,gzte001,gzteownid,gzteowndp,gztecrtid, 
       gztecrtdp,gztecrtdt,gztemodid,gztemoddt FROM gzte_t WHERE gzte001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE azzi552_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT gztf004,gztf002 FROM gztf_t WHERE gztf001=? AND gztf004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE azzi552_bcl2 CURSOR FROM g_forupd_sql
 
 
 
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
      INPUT ARRAY g_gzte_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
               IF  NOT cl_null(g_gzte_d[l_ac].gzte001) THEN
                  CALL n_gztel(g_gzte_d[l_ac].gzte001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gzte_d[l_ac].gzte001
                  CALL ap_ref_array2(g_ref_fields," SELECT gztel003 FROM gztel_t WHERE gztel001 = ? AND gztel002 = '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_gzte_d[l_ac].gztel003 = g_rtn_fields[1]
                  DISPLAY BY NAME g_gzte_d[l_ac].gztel003
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzte_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL azzi552_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_gzte_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_gzte_d[l_ac].*
            LET g_master.* = g_gzte_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gzte_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzte_d[l_ac].gzte001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzte_d_t.* = g_gzte_d[l_ac].*  #BACKUP
               LET g_gzte_d_o.* = g_gzte_d[l_ac].*  #BACKUP
               IF NOT azzi552_lock_b("gzte_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi552_bcl INTO g_gzte_d[l_ac].gzte001,g_gzte_d[l_ac].gzte002,g_gzte_d[l_ac].gzte003, 
                      g_gzte_d[l_ac].gzte004,g_gzte2_d[l_ac].gzte001,g_gzte2_d[l_ac].gzteownid,g_gzte2_d[l_ac].gzteowndp, 
                      g_gzte2_d[l_ac].gztecrtid,g_gzte2_d[l_ac].gztecrtdp,g_gzte2_d[l_ac].gztecrtdt, 
                      g_gzte2_d[l_ac].gztemodid,g_gzte2_d[l_ac].gztemoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzte_d_t.gzte001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_gzte_d_mask_o[l_ac].* =  g_gzte_d[l_ac].*
                  CALL azzi552_gzte_t_mask()
                  LET g_gzte_d_mask_n[l_ac].* =  g_gzte_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL azzi552_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL azzi552_set_entry_b(l_cmd)
            CALL azzi552_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.gztel001 = g_gzte_d[l_ac].gzte001
LET g_detail_multi_table_t.gztel002 = g_dlang
LET g_detail_multi_table_t.gztel003 = g_gzte_d[l_ac].gztel003
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'gztel001'
            LET l_var_keys[01] = g_gzte_d[l_ac].gzte001
            LET l_field_keys[02] = 'gztel002'
            LET l_var_keys[02] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'gztel_t') THEN
               RETURN 
            END IF 
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL azzi552_fetch()
            CALL azzi552_idx_chk('m')
 
         BEFORE INSERT
            
LET g_detail_multi_table_t.gztel001 = g_gzte_d[l_ac].gzte001
LET g_detail_multi_table_t.gztel002 = g_dlang
LET g_detail_multi_table_t.gztel003 = g_gzte_d[l_ac].gztel003
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_gzte3_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzte_d[l_ac].* TO NULL 
            INITIALIZE g_gzte_d_t.* TO NULL 
            INITIALIZE g_gzte_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzte2_d[l_ac].gzteownid = g_user
      LET g_gzte2_d[l_ac].gzteowndp = g_dept
      LET g_gzte2_d[l_ac].gztecrtid = g_user
      LET g_gzte2_d[l_ac].gztecrtdp = g_dept 
      LET g_gzte2_d[l_ac].gztecrtdt = cl_get_current()
      LET g_gzte2_d[l_ac].gztemodid = g_user
      LET g_gzte2_d[l_ac].gztemoddt = cl_get_current()
 
 
 
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_gzte_d_t.* = g_gzte_d[l_ac].*     #新輸入資料
            LET g_gzte_d_o.* = g_gzte_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi552_set_entry_b(l_cmd)
            CALL azzi552_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzte_d[li_reproduce_target].* = g_gzte_d[li_reproduce].*
               LET g_gzte2_d[li_reproduce_target].* = g_gzte2_d[li_reproduce].*
 
               LET g_gzte_d[g_gzte_d.getLength()].gzte001 = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            CALL g_gzzy_d.clear()
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
            SELECT COUNT(1) INTO l_count FROM gzte_t 
             WHERE  gzte001 = g_gzte_d[l_ac].gzte001 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzte_d[g_detail_idx].gzte001
               CALL azzi552_insert_b('gzte_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzte_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzte_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi552_b_fill(g_wc)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzte_d[l_ac].gzte001 = g_detail_multi_table_t.gztel001 AND
         g_gzte_d[l_ac].gztel003 = g_detail_multi_table_t.gztel003 THEN
         ELSE 
            LET l_var_keys[01] = g_gzte_d[l_ac].gzte001
            LET l_field_keys[01] = 'gztel001'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gztel001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gztel002'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gztel002
            LET l_vars[01] = g_gzte_d[l_ac].gztel003
            LET l_fields[01] = 'gztel003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gztel_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_gzte_d[l_ac].*
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
               
               DELETE FROM gzte_t
                WHERE  
                      gzte001 = g_gzte_d_t.gzte001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzte_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'gztel001'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.gztel001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gztel_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_gzte_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE azzi552_bcl
               LET l_count = g_gzte_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzte_d_t.gzte001
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi552_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL azzi552_delete_b('gzte_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzte_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte001
            #add-point:BEFORE FIELD gzte001 name="input.b.page1.gzte001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte001
            
            #add-point:AFTER FIELD gzte001 name="input.a.page1.gzte001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF g_gzte_d[g_detail_idx].gzte001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzte_d[g_detail_idx].gzte001 != g_gzte_d_t.gzte001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzte_t WHERE "||"gzte001 = '"||g_gzte_d[g_detail_idx].gzte001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               LET g_gzte_d[g_detail_idx].gzte003 = "SOP_",g_gzte_d[g_detail_idx].gzte001 CLIPPED
               LET g_gzte_d[g_detail_idx].gzte004 = "APP_",g_gzte_d[g_detail_idx].gzte001 CLIPPED
               DISPLAY g_gzte_d[g_detail_idx].gzte004 TO gzte004
               DISPLAY g_gzte_d[g_detail_idx].gzte003 TO gzte003             
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzte001
            #add-point:ON CHANGE gzte001 name="input.g.page1.gzte001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztel003
            #add-point:BEFORE FIELD gztel003 name="input.b.page1.gztel003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztel003
            
            #add-point:AFTER FIELD gztel003 name="input.a.page1.gztel003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gztel003
            #add-point:ON CHANGE gztel003 name="input.g.page1.gztel003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte002
            #add-point:BEFORE FIELD gzte002 name="input.b.page1.gzte002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte002
            
            #add-point:AFTER FIELD gzte002 name="input.a.page1.gzte002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzte002
            #add-point:ON CHANGE gzte002 name="input.g.page1.gzte002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte003
            #add-point:BEFORE FIELD gzte003 name="input.b.page1.gzte003"
            #NEXT FIELD gzte002
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte003
            
            #add-point:AFTER FIELD gzte003 name="input.a.page1.gzte003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzte003
            #add-point:ON CHANGE gzte003 name="input.g.page1.gzte003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzte004
            #add-point:BEFORE FIELD gzte004 name="input.b.page1.gzte004"
            #NEXT FIELD gzte002
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzte004
            
            #add-point:AFTER FIELD gzte004 name="input.a.page1.gzte004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzte004
            #add-point:ON CHANGE gzte004 name="input.g.page1.gzte004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzte001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte001
            #add-point:ON ACTION controlp INFIELD gzte001 name="input.c.page1.gzte001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gztel003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztel003
            #add-point:ON ACTION controlp INFIELD gztel003 name="input.c.page1.gztel003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzte002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte002
            #add-point:ON ACTION controlp INFIELD gzte002 name="input.c.page1.gzte002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzte003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte003
            #add-point:ON ACTION controlp INFIELD gzte003 name="input.c.page1.gzte003"
            CALL azzi552_01(g_gzte_d[g_detail_idx].gzte001 CLIPPED,g_gzte_d[g_detail_idx].gzte002 CLIPPED)
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzte004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzte004
            #add-point:ON ACTION controlp INFIELD gzte004 name="input.c.page1.gzte004"
            CALL azzi552_01(g_gzte_d[g_detail_idx].gzte001 CLIPPED,g_gzte_d[g_detail_idx].gzte002 CLIPPED)
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzte_d[l_ac].* = g_gzte_d_t.*
               CLOSE azzi552_bcl
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
               LET g_errparam.extend = g_gzte_d[l_ac].gzte001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gzte_d[l_ac].* = g_gzte_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_gzte2_d[l_ac].gztemodid = g_user 
LET g_gzte2_d[l_ac].gztemoddt = cl_get_current()
LET g_gzte2_d[l_ac].gztemodid_desc = cl_get_username(g_gzte2_d[l_ac].gztemodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi552_gzte_t_mask_restore('restore_mask_o')
      
               UPDATE gzte_t SET (gzte001,gzte002,gzte003,gzte004,gzteownid,gzteowndp,gztecrtid,gztecrtdp, 
                   gztecrtdt,gztemodid,gztemoddt) = (g_gzte_d[l_ac].gzte001,g_gzte_d[l_ac].gzte002,g_gzte_d[l_ac].gzte003, 
                   g_gzte_d[l_ac].gzte004,g_gzte2_d[l_ac].gzteownid,g_gzte2_d[l_ac].gzteowndp,g_gzte2_d[l_ac].gztecrtid, 
                   g_gzte2_d[l_ac].gztecrtdp,g_gzte2_d[l_ac].gztecrtdt,g_gzte2_d[l_ac].gztemodid,g_gzte2_d[l_ac].gztemoddt) 
 
                WHERE 
                  gzte001 = g_gzte_d_t.gzte001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_gzte_d[l_ac].* = g_gzte_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzte_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzte_d[l_ac].* = g_gzte_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzte_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzte_d[g_detail_idx].gzte001
               LET gs_keys_bak[1] = g_gzte_d_t.gzte001
               CALL azzi552_update_b('gzte_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gzte_d[l_ac].gzte001 = g_detail_multi_table_t.gztel001 AND
         g_gzte_d[l_ac].gztel003 = g_detail_multi_table_t.gztel003 THEN
         ELSE 
            LET l_var_keys[01] = g_gzte_d[l_ac].gzte001
            LET l_field_keys[01] = 'gztel001'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gztel001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gztel002'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gztel002
            LET l_vars[01] = g_gzte_d[l_ac].gztel003
            LET l_fields[01] = 'gztel003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gztel_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL azzi552_gzte_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_gzte_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzte_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_gzte_d[l_ac].*
               CALL azzi552_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL azzi552_unlock_b("gzte_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzte_d[l_ac].* = g_gzte_d_t.*
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
            CALL cl_multitable_unlock()
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_gzte_d[l_ac].* = g_gzte_d_t.*
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
               LET g_gzte_d[li_reproduce_target].* = g_gzte_d[li_reproduce].*
               LET g_gzte2_d[li_reproduce_target].* = g_gzte2_d[li_reproduce].*
 
               LET g_gzte_d[li_reproduce_target].gzte001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzte_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzte_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_gzte3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page3.update_item"
               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_gzte_d[g_detail_idx].gzte001) THEN
               NEXT FIELD gzte001
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzte3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_gzte3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
 
         BEFORE INSERT
            IF g_gzte_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD gzte001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzte3_d[l_ac].* TO NULL 
            INITIALIZE g_gzte3_d_t.* TO NULL 
            INITIALIZE g_gzte3_d_o.* TO NULL 
            
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_gzte3_d_t.* = g_gzte3_d[l_ac].*     #新輸入資料
            LET g_gzte3_d_o.* = g_gzte3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi552_set_entry_b(l_cmd)
            CALL azzi552_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzte3_d[li_reproduce_target].* = g_gzte3_d[li_reproduce].*
 
               LET g_gzte3_d[li_reproduce_target].gztf004 = NULL
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
            LET g_detail_cnt = g_gzte3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzte3_d[l_ac].gztf004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gzte3_d_t.* = g_gzte3_d[l_ac].*  #BACKUP
               LET g_gzte3_d_o.* = g_gzte3_d[l_ac].*  #BACKUP
               IF NOT azzi552_lock_b("gztf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi552_bcl2 INTO g_gzte3_d[l_ac].gztf004,g_gzte3_d[l_ac].gztf002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzte3_d_mask_o[l_ac].* =  g_gzte3_d[l_ac].*
                  CALL azzi552_gztf_t_mask()
                  LET g_gzte3_d_mask_n[l_ac].* =  g_gzte3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL azzi552_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL azzi552_set_entry_b(l_cmd)
            CALL azzi552_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            CALL azzi552_idx_chk('d')
            
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
               
               DELETE FROM gztf_t
                WHERE 
                   gztf001 = g_master.gzte001
                   AND gztf004 = g_gzte3_d_t.gztf004
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
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
               CLOSE azzi552_bcl
               LET l_count = g_gzte_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzte_d[g_detail_idx].gzte001
               LET gs_keys[2] = g_gzte3_d_t.gztf004
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL azzi552_delete_b('gztf_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzte3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM gztf_t 
             WHERE 
                   gztf001 = g_master.gzte001
                   AND gztf004 = g_gzte3_d[g_detail_idx2].gztf004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzte_d[g_detail_idx].gzte001
               LET gs_keys[2] = g_gzte3_d[g_detail_idx2].gztf004
               CALL azzi552_insert_b('gztf_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzte_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi552_b_fill(g_wc)
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
               LET g_gzte3_d[l_ac].* = g_gzte3_d_t.*
               CLOSE azzi552_bcl2
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
               LET g_gzte3_d[l_ac].* = g_gzte3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi552_gztf_t_mask_restore('restore_mask_o')
               
               UPDATE gztf_t SET (gztf004,gztf002) = (g_gzte3_d[l_ac].gztf004,g_gzte3_d[l_ac].gztf002)  
                   #自訂欄位頁簽
                WHERE 
                   gztf001 = g_master.gzte001
                   AND gztf004 = g_gzte3_d_t.gztf004
                   
               #add-point:單身修改中 name="input.body3.m_update"
               
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_gzte3_d[l_ac].* = g_gzte3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gztf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzte3_d[l_ac].* = g_gzte3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzte_d[g_detail_idx].gzte001
               LET gs_keys_bak[1] = g_gzte_d[g_detail_idx].gzte001
               LET gs_keys[2] = g_gzte3_d[g_detail_idx2].gztf004
               LET gs_keys_bak[2] = g_gzte3_d_t.gztf004
               CALL azzi552_update_b('gztf_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL azzi552_gztf_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_gzte3_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzte3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztf004
            #add-point:BEFORE FIELD gztf004 name="input.b.page3.gztf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztf004
            
            #add-point:AFTER FIELD gztf004 name="input.a.page3.gztf004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzte_d[g_detail_idx].gzte001 IS NOT NULL AND g_gzte3_d[g_detail_idx2].gztf004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzte_d[g_detail_idx].gzte001 != g_gzte_d[g_detail_idx].gzte001 OR g_gzte3_d[g_detail_idx2].gztf004 != g_gzte3_d_t.gztf004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gztf_t WHERE "||"gztf001 = '"||g_gzte_d[g_detail_idx].gzte001 ||"' AND "|| "gztf004 = '"||g_gzte3_d[g_detail_idx2].gztf004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gztf004
            #add-point:ON CHANGE gztf004 name="input.g.page3.gztf004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gztf002
            
            #add-point:AFTER FIELD gztf002 name="input.a.page3.gztf002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzte3_d[l_ac].gztf002
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzte3_d[l_ac].gztf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzte3_d[l_ac].gztf002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gztf002
            #add-point:BEFORE FIELD gztf002 name="input.b.page3.gztf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gztf002
            #add-point:ON CHANGE gztf002 name="input.g.page3.gztf002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.gztf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztf004
            #add-point:ON ACTION controlp INFIELD gztf004 name="input.c.page3.gztf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gztf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gztf002
            #add-point:ON ACTION controlp INFIELD gztf002 name="input.c.page3.gztf002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzte3_d[l_ac].gztf002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_gzzz001()                                #呼叫開窗

            LET g_gzte3_d[l_ac].gztf002 = g_qryparam.return1              

            DISPLAY g_gzte3_d[l_ac].gztf002 TO gztf002              #

            NEXT FIELD gztf002                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzte3_d[l_ac].* = g_gzte3_d_t.*
               END IF
               CLOSE azzi552_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL azzi552_unlock_b("gztf_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gzte3_d[li_reproduce_target].* = g_gzte3_d[li_reproduce].*
 
               LET g_gzte3_d[li_reproduce_target].gztf004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzte3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzte3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_gzte2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL azzi552_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL azzi552_fetch()
            CALL azzi552_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      DISPLAY ARRAY g_gzzy_d TO s_detail4.*
         ATTRIBUTES(COUNT=g_detail_cnt)

         BEFORE DISPLAY
         
      END DISPLAY
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_gzte_d.getLength() THEN
               LET g_detail_idx = g_gzte_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_gzte_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzte001
               WHEN "s_detail2"
                  NEXT FIELD gzte001_2
               WHEN "s_detail3"
                  NEXT FIELD gztf004
 
            END CASE
         ELSE
            NEXT FIELD gzte001
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
 
   CLOSE azzi552_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi552_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.gzte001,t0.gzte002,t0.gzte003,t0.gzte004,t0.gzte001,t0.gzteownid, 
       t0.gzteowndp,t0.gztecrtid,t0.gztecrtdp,t0.gztecrtdt,t0.gztemodid,t0.gztemoddt ,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM gzte_t t0",
 
               " LEFT JOIN gztf_t ON gzte001 = gztf001",
 
 
               " LEFT JOIN gztel_t ON gzte001 = gztel001 AND gztel002 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.gzteownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.gzteowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gztecrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gztecrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.gztemodid  ",
 
               " WHERE 1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gzte_t"),
                      " ORDER BY t0.gzte001"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzte_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE azzi552_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzi552_pb
   
   OPEN b_fill_curs
 
   CALL g_gzte_d.clear()
   CALL g_gzte2_d.clear()   
   CALL g_gzte3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gzte_d[l_ac].gzte001,g_gzte_d[l_ac].gzte002,g_gzte_d[l_ac].gzte003,g_gzte_d[l_ac].gzte004, 
       g_gzte2_d[l_ac].gzte001,g_gzte2_d[l_ac].gzteownid,g_gzte2_d[l_ac].gzteowndp,g_gzte2_d[l_ac].gztecrtid, 
       g_gzte2_d[l_ac].gztecrtdp,g_gzte2_d[l_ac].gztecrtdt,g_gzte2_d[l_ac].gztemodid,g_gzte2_d[l_ac].gztemoddt, 
       g_gzte2_d[l_ac].gzteownid_desc,g_gzte2_d[l_ac].gzteowndp_desc,g_gzte2_d[l_ac].gztecrtid_desc, 
       g_gzte2_d[l_ac].gztecrtdp_desc,g_gzte2_d[l_ac].gztemodid_desc
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
   
 
   CALL g_gzte_d.deleteElement(g_gzte_d.getLength())   
   CALL g_gzte2_d.deleteElement(g_gzte2_d.getLength())
   CALL g_gzte3_d.deleteElement(g_gzte3_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_gzte_d.getLength() THEN
       IF g_gzte_d.getLength() > 0 THEN
          LET g_detail_idx = g_gzte_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_gzte_d.getLength()
      LET g_gzte2_d[g_detail_idx].gzte001 = g_gzte_d[g_detail_idx].gzte001 
      #LET g_gzte3_d[g_detail_idx2].gztf004 = g_gzte_d[g_detail_idx].gzte001 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE azzi552_pb
   
   LET g_loc = 'm'
   CALL azzi552_detail_show() 
   
   LET l_ac = 1
   IF g_gzte_d.getLength() > 0 THEN
      CALL azzi552_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzte_d.getLength()
      LET g_gzte_d_mask_o[l_ac].* =  g_gzte_d[l_ac].*
      CALL azzi552_gzte_t_mask()
      LET g_gzte_d_mask_n[l_ac].* =  g_gzte_d[l_ac].*
   END FOR
   
   LET g_gzte2_d_mask_o.* =  g_gzte2_d.*
   FOR l_ac = 1 TO g_gzte2_d.getLength()
      LET g_gzte2_d_mask_o[l_ac].* =  g_gzte2_d[l_ac].*
      CALL azzi552_gzte_t_mask()
      LET g_gzte2_d_mask_n[l_ac].* =  g_gzte2_d[l_ac].*
   END FOR
   LET g_gzte3_d_mask_o.* =  g_gzte3_d.*
   FOR l_ac = 1 TO g_gzte3_d.getLength()
      LET g_gzte3_d_mask_o[l_ac].* =  g_gzte3_d[l_ac].*
      CALL azzi552_gztf_t_mask()
      LET g_gzte3_d_mask_n[l_ac].* =  g_gzte3_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi552_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE ls_sql          STRING
   DEFINE ls_orig         STRING
   DEFINE ls_path         STRING
   DEFINE ls_n            LIKE type_t.num5
   DEFINE ls_filename     STRING             #檔案名稱
   DEFINE li_h            LIKE type_t.num5
   DEFINE ls_child        STRING
   DEFINE ls_gzzy001      LIKE gzzy_t.gzzy001
   DEFINE ls_standard     LIKE type_t.chr1
   DEFINE l_chk           LIKE type_t.num5 #160503-00001#1-add 用來修正介面語言編號有檔案，又多出現一欄file_not_found的問題
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_gzte_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_gzte2_d.clear()
   CALL g_gzte3_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.gztf004,t0.gztf002 ,t6.gzzal003 FROM gztf_t t0",    
                  "",
                                 " LEFT JOIN gzzal_t t6 ON t6.gzzal001=t0.gztf002 AND t6.gzzal002='"||g_lang||"' ",
 
                  " WHERE t0.gztf001=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.gztf004" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE azzi552_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR azzi552_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_gzte_d[l_ac].gzte001   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_gzte_d[l_ac].gzte001 INTO g_gzte3_d[l_ac].gztf004,g_gzte3_d[l_ac].gztf002, 
#    g_gzte3_d[l_ac].gztf002_desc   #(ver:45) #(ver:46)mark
   FOREACH b_fill_curs2 USING g_gzte_d[g_detail_idx].gzte001 INTO g_gzte3_d[l_ac].gztf004,g_gzte3_d[l_ac].gztf002, 
       g_gzte3_d[l_ac].gztf002_desc   #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   #取得SOP各語系清單資訊
   LET ls_sql = "select gzzy001 FROM gzzy_t WHERE gzzystus = 'Y'"
   PREPARE azzi552_get_gzzy001_pb FROM ls_sql
   DECLARE azzi552_get_gzzy001_curs CURSOR FOR azzi552_get_gzzy001_pb

   OPEN azzi552_get_gzzy001_curs
   CALL g_gzzy_d.clear()
   LET ls_n = 1

   LET ls_orig = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"www"),"doc")
   LET ls_orig = os.Path.join(ls_orig.trim(),"erp")
   LET ls_orig = os.Path.join(ls_orig.trim(),DOWNSHIFT(g_gzte_d[g_detail_idx].gzte002 CLIPPED))
   
   FOREACH azzi552_get_gzzy001_curs INTO ls_gzzy001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_chk = FALSE #160503-00001#1-add
      LET ls_path = os.Path.join(ls_orig,ls_gzzy001)
      CALL os.Path.dirsort("name", 1)
      LET li_h = os.Path.diropen(ls_path)
      LET ls_standard = ""
      
      WHILE li_h > 0
         LET ls_child = os.Path.dirnext(li_h)
         IF ls_child IS NULL THEN EXIT WHILE END IF
         IF ls_child == "." OR ls_child == ".." THEN CONTINUE WHILE END IF

         LET g_gzzy_d[ls_n].gzzy001 = ls_gzzy001
         LET g_gzzy_d[ls_n].l_filename = ls_child

         IF ls_child.getIndexOf(g_gzte_d[g_detail_idx].gzte003,1) THEN
            #檢查SOP檔案是否存在
            #因為有可能同時存在標準或客製文件，或是只存在標準文件，或是只存在客製文件，
            #所以要分開處理
            #若是標準與客製文件都不存在，至少要有一筆顯示標準文件不存在的資訊
            IF ls_child.subString(1,1) = "C" THEN
               LET g_gzzy_d[ls_n].l_cust = "Y"
               LET ls_n = ls_n + 1
               LET l_chk = TRUE #160503-00001#1-add
            ELSE
               LET g_gzzy_d[ls_n].l_cust = "N"
               LET ls_standard = "Y"
               LET ls_n = ls_n + 1
               LET l_chk = TRUE #160503-00001#1-add
            END IF
         END IF
      END WHILE
      
      CALL os.Path.dirclose(li_h)
      IF ls_standard IS NULL THEN
         #160503-00001#1-add-(S)
         #介面語言有找到資料的話，不可能會出現file_not_found，多加l_chk來排除這個問題
         IF l_chk THEN
            CONTINUE FOREACH
         END IF
         #160503-00001#1-add-(E)
         LET g_gzzy_d[ls_n].gzzy001 = ls_gzzy001
         LET g_gzzy_d[ls_n].l_filename = "file_not_found"
         LET g_gzzy_d[ls_n].l_cust = "N"
         LET ls_n = ls_n + 1
      END IF

   END FOREACH
   CALL g_gzzy_d.deleteElement(g_gzzy_d.getLength())
   #160503-00001#1-add-(S)
   CALL azzi552_set_act_visible_b()
   CALL azzi552_set_act_no_visible_b()
   #160503-00001#1-add-(E)
   #end add-point
   
   #CALL g_gzte2_d.deleteElement(g_gzte2_d.getLength())   
   CALL g_gzte3_d.deleteElement(g_gzte3_d.getLength())   
 
   
   LET g_gzte3_d_mask_o.* =  g_gzte3_d.*
   FOR l_ac = 1 TO g_gzte3_d.getLength()
      LET g_gzte3_d_mask_o[l_ac].* =  g_gzte3_d[l_ac].*
      CALL azzi552_gztf_t_mask()
      LET g_gzte3_d_mask_n[l_ac].* =  g_gzte3_d[l_ac].*
   END FOR
 
   
   DISPLAY g_gzte3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL azzi552_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzi552_detail_show()
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
      FOR l_ac = 1 TO g_gzte_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_gzte_d[l_ac].gzte001
   CALL ap_ref_array2(g_ref_fields," SELECT gztel003 FROM gztel_t WHERE gztel001 = ? AND gztel002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gzte_d[l_ac].gztel003 = g_rtn_fields[1] 
   DISPLAY BY NAME g_gzte_d[l_ac].gztel003
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
         
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_gzte3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
        
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="azzi552.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi552_set_entry_b(p_cmd)                                                  
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
 
{<section id="azzi552.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi552_set_no_entry_b(p_cmd)                                               
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
 
{<section id="azzi552.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi552_default_search()
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
      LET ls_wc = ls_wc, " gzte001 = '", g_argv[01], "' AND "
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
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi552.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi552_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "gzte_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM gzte_t
       WHERE 
         gzte001 = ps_keys_bak[1]
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
   
 
   
   LET ls_group = "gztf_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM gztf_t
       WHERE 
         gztf001 = ps_keys_bak[1] AND gztf004 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "gzte_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM gztf_t
       WHERE 
         gztf001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
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
 
{<section id="azzi552.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi552_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "gzte_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO gzte_t
                  (
                   gzte001
                   ,gzte002,gzte003,gzte004,gzteownid,gzteowndp,gztecrtid,gztecrtdp,gztecrtdt,gztemodid,gztemoddt) 
            VALUES(
                   ps_keys[1]
                   ,g_gzte_d[g_detail_idx].gzte002,g_gzte_d[g_detail_idx].gzte003,g_gzte_d[g_detail_idx].gzte004, 
                       g_gzte2_d[g_detail_idx].gzteownid,g_gzte2_d[g_detail_idx].gzteowndp,g_gzte2_d[g_detail_idx].gztecrtid, 
                       g_gzte2_d[g_detail_idx].gztecrtdp,g_gzte2_d[g_detail_idx].gztecrtdt,g_gzte2_d[g_detail_idx].gztemodid, 
                       g_gzte2_d[g_detail_idx].gztemoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzte_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "gztf_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      
      #end add-point
      INSERT INTO gztf_t
                  (
                   gztf001,gztf004
                   ,gztf002) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzte3_d[g_detail_idx2].gztf002)
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
 
{<section id="azzi552.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi552_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "gzte_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gzte_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL azzi552_gzte_t_mask_restore('restore_mask_o')
               
      UPDATE gzte_t 
         SET (gzte001
              ,gzte002,gzte003,gzte004,gzteownid,gzteowndp,gztecrtid,gztecrtdp,gztecrtdt,gztemodid,gztemoddt) 
              = 
             (ps_keys[1]
              ,g_gzte_d[g_detail_idx].gzte002,g_gzte_d[g_detail_idx].gzte003,g_gzte_d[g_detail_idx].gzte004, 
                  g_gzte2_d[g_detail_idx].gzteownid,g_gzte2_d[g_detail_idx].gzteowndp,g_gzte2_d[g_detail_idx].gztecrtid, 
                  g_gzte2_d[g_detail_idx].gztecrtdp,g_gzte2_d[g_detail_idx].gztecrtdt,g_gzte2_d[g_detail_idx].gztemodid, 
                  g_gzte2_d[g_detail_idx].gztemoddt) 
         WHERE 
               gzte001 = ps_keys_bak[1]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzte_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzte_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            LET l_new_key[01] = ps_keys[1] 
LET l_old_key[01] = ps_keys_bak[1] 
LET l_field_key[01] = 'gztel001'
LET l_new_key[02] = g_dlang 
LET l_old_key[02] = g_dlang 
LET l_field_key[02] = 'gztel002'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'gztel_t')
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL azzi552_gzte_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "gztf_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gztf_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL azzi552_gztf_t_mask_restore('restore_mask_o')
      
      UPDATE gztf_t 
         SET (gztf001,gztf004
              ,gztf002) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzte3_d[g_detail_idx2].gztf002) 
         WHERE 
               gztf001 = ps_keys_bak[1] AND gztf004 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gztf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi552_gztf_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION azzi552_key_update_b()
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
   
   IF g_master.gzte001 <> g_master_t.gzte001 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE gztf_t 
      SET (gztf001) 
           = 
          (g_master.gzte001) 
      WHERE 
           gztf001 = g_master_t.gzte001
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gztf_t:",SQLERRMESSAGE 
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
 
{<section id="azzi552.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi552_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL azzi552_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gzte_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi552_bcl USING 
                                       g_gzte_d[g_detail_idx].gzte001
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi552_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "gztf_t,"
   #僅鎖定自身table
   LET ls_group = "gztf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN azzi552_bcl2 USING 
                                             g_master.gzte001,
                                             g_gzte3_d[g_detail_idx2].gztf004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi552_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi552.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi552_unlock_b(ps_table)
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
      CLOSE azzi552_bcl
   END IF
   
 
    
   LET ls_group = "gztf_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE azzi552_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi552.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION azzi552_idx_chk(ps_loc)
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
      IF g_detail_idx > g_gzte_d.getLength() THEN
         LET g_detail_idx = g_gzte_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzte_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_gzte_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gzte2_d.getLength() THEN
         LET g_detail_idx = g_gzte2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzte2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_gzte2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_gzte3_d.getLength() THEN
         LET g_detail_idx2 = g_gzte3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_gzte3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_gzte3_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_gzte3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_gzte3_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi552.mask_functions" >}
&include "erp/azz/azzi552_mask.4gl"
 
{</section>}
 
{<section id="azzi552.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi552_set_pk_array()
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
   LET g_pk_array[1].values = g_gzte_d[g_detail_idx].gzte001
   LET g_pk_array[1].column = 'gzte001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi552.state_change" >}
    
 
{</section>}
 
{<section id="azzi552.func_signature" >}
   
 
{</section>}
 
{<section id="azzi552.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="azzi552.other_function" readonly="Y" >}

################################################################################
# Descriptions...: SOP文件上傳
# Memo...........:
# Usage..........: CALL azzi552_doc_upload()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_doc_upload()
   DEFINE ls_source    STRING
   DEFINE ls_target    STRING
   DEFINE ls_js        STRING
   DEFINE ls_id        LIKE type_t.chr50
   DEFINE ls_n         LIKE type_t.num5
   DEFINE ls_name      STRING
   DEFINE ls_doc_name  STRING
   DEFINE ls_original_docname   STRING
   DEFINE ls_doc_extension      LIKE type_t.chr10
   DEFINE ls_doc_final_name     STRING
   
   LET ls_source = cl_client_browse_file()
   IF ls_source.getLength() < 1 THEN
   #  CALL cl_err("未選擇檔案","!",1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'lib-00123'
      LET g_errparam.extend = 'lib-00123'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   #因SOP文件有標準的命名原則，所以若是上傳的文件原始檔名不符命名原則，
   #需將檔名替換掉，但副檔名不做異動，並顯示訊息提示使用者
   LET ls_original_docname = os.Path.basename(ls_source)       #原始檔名

   IF ls_original_docname.getIndexOf(".",1) > 0 THEN
      FOR ls_n = ls_original_docname.getLength() TO 1 STEP -1
         IF ls_original_docname.subString(ls_n,ls_n) = "." THEN
            #取得檔名及副檔名
            LET ls_doc_name = ls_original_docname.subString(1,ls_n-1)
            LET ls_doc_extension = ls_original_docname.subString(ls_n,ls_original_docname.getLength())
            #若是原始檔名與命名規則不符，須將檔名替換掉，但副檔名不變
            IF ls_doc_name <> g_gzte_d[g_detail_idx].gzte003 THEN
               LET ls_doc_final_name = g_gzte_d[g_detail_idx].gzte003,ls_doc_extension

               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'azz-00357'
               LET g_errparam.extend = 'azz-00357'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               LET ls_doc_final_name = ls_doc_name,ls_doc_extension
            END IF
            
            EXIT FOR
         END IF
      END FOR
      #160503-00001#1-add-(S)
      #客製環境，檔名多加一個C
      IF FGL_GETENV("DGENV") = "c" THEN
         LET ls_doc_final_name = "C",ls_doc_final_name.trim()
      END IF
      #160503-00001#1-add-(E)
   END IF
   
   LET ls_id = security.RandomGenerator.CreateUUIDString()   #有抓到檔案,給一個檔案UUID
   LET ls_target = os.Path.join(FGL_GETENV("TEMPDIR"),ls_id CLIPPED)

   IF NOT cl_client_upload_file(ls_source, ls_target) THEN
   #  CALL cl_err("檔案上傳失敗","!",1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'lib-00125'
      LET g_errparam.extend = 'lib-00125'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      LET ls_source = ls_target

      LET ls_target = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"www"),"doc")
      LET ls_target = os.Path.join(ls_target.trim(),"erp")
      LET ls_target = os.Path.join(ls_target.trim(),DOWNSHIFT(g_gzte_d[g_detail_idx].gzte002 CLIPPED))
      LET ls_target = os.Path.join(ls_target.trim(),g_gzzy_d[g_detail_idx3].gzzy001 CLIPPED)
      LET ls_target = os.Path.join(ls_target.trim(),ls_doc_final_name)
      
      IF os.Path.copy(ls_source, ls_target) THEN
         #文件上傳成功
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'lib-00126'
         LET g_errparam.extend = 'lib-00126'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         #文件上傳失敗
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'lib-00125'
         LET g_errparam.extend = 'lib-00125'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   CALL azzi552_fetch()  #160503-00001#1-add
END FUNCTION

################################################################################
# Descriptions...: SOP文件下載
# Memo...........:
# Usage..........: CALL azzi552_doc_download()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_doc_download()
   DEFINE ls_source   STRING
   DEFINE ls_target   STRING


   #來源檔案
   LET ls_source = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"www"),"doc")
   LET ls_source = os.Path.join(ls_source.trim(),"erp")
   LET ls_source = os.Path.join(ls_source.trim(),DOWNSHIFT(g_gzte_d[g_detail_idx].gzte002 CLIPPED))
   LET ls_source = os.Path.join(ls_source.trim(),g_gzzy_d[g_detail_idx3].gzzy001 CLIPPED)
   LET ls_source = os.Path.join(ls_source.trim(),g_gzzy_d[g_detail_idx3].l_filename)
   
   #目的檔案
   LET ls_target = cl_client_browse_dir()
   IF cl_null(ls_target) THEN
      #未選擇目錄
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00358'
      LET g_errparam.extend = 'azz-00358'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN
   END IF

   LET ls_target = os.Path.join(ls_target,g_gzzy_d[g_detail_idx3].l_filename)

   #下載檔案
   IF cl_client_download_file(ls_source,ls_target) THEN
      #文件下載成功
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00359'
      LET g_errparam.extend = 'azz-00359'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      #文件下載失敗
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00360'
      LET g_errparam.extend = 'azz-00360'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: SOP文件開啟
# Memo...........:
# Usage..........: CALL azzi552_doc_open()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_doc_open()
   DEFINE li_stat    LIKE type_t.num5
   DEFINE ls_target  STRING
   DEFINE ls_source  STRING
   DEFINE ls_url     STRING
   DEFINE l_urlfile  STRING


   #來源檔案
   LET ls_source = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"www"),"doc")
   LET ls_source = os.Path.join(ls_source.trim(),"erp")
   LET ls_source = os.Path.join(ls_source.trim(),DOWNSHIFT(g_gzte_d[g_detail_idx].gzte002 CLIPPED))
   LET ls_source = os.Path.join(ls_source.trim(),g_gzzy_d[g_detail_idx3].gzzy001 CLIPPED)
   LET ls_source = os.Path.join(ls_source.trim(),g_gzzy_d[g_detail_idx3].l_filename)
   
   #目的檔案
   LET ls_target = os.Path.join(FGL_GETENV("TEMPDIR"),g_gzzy_d[g_detail_idx3].l_filename CLIPPED)

   #將檔案移入指定位置
   IF os.Path.copy(ls_source, ls_target) THEN
   END IF

   #組合成可開啟的url路徑
   LET l_urlfile = ''
   LET l_urlfile = g_gzzy_d[g_detail_idx3].l_filename
   LET l_urlfile = l_urlfile.trim()
   LET l_urlfile = URLEncoder.encode(l_urlfile, "UTF-8")
   LET ls_url = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),l_urlfile CLIPPED)

   LET li_stat = cl_client_open_url(ls_url)
   
END FUNCTION

################################################################################
# Descriptions...: 檔案刪除
# Memo...........:
# Usage..........: CALL azzi552_doc_delete()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/03 By dorislai (#160503-00001#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_doc_delete()
   DEFINE ls_source   STRING
   DEFINE ls_target   STRING

   #來源檔案 /u1/t10dev/www/doc/erp/模組/介面語言/檔案名稱
   LET ls_source = os.Path.join(os.Path.join(FGL_GETENV("TOP"),"www"),"doc")
   LET ls_source = os.Path.join(ls_source.trim(),"erp")
   LET ls_source = os.Path.join(ls_source.trim(),DOWNSHIFT(g_gzte_d[g_detail_idx].gzte002 CLIPPED))
   LET ls_source = os.Path.join(ls_source.trim(),g_gzzy_d[g_detail_idx3].gzzy001 CLIPPED)
   LET ls_source = os.Path.join(ls_source.trim(),g_gzzy_d[g_detail_idx3].l_filename)
   
   #先行移除文件
   IF os.Path.delete(ls_source) THEN
   
   END IF

   #判斷是否刪除成功
   IF os.Path.exists(ls_source) THEN
      #文件刪除失敗
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-01027'
      LET g_errparam.extend = 'azz-01027'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      #文件刪除成功
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-01026'
      LET g_errparam.extend = 'azz-01026'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   CALL azzi552_fetch()
END FUNCTION

################################################################################
# Descriptions...: 單身權限開啟
# Memo...........:
# Usage..........: CALL azzi552_set_act_visible_b()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/03 By dorislai (#160503-00001#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_set_act_visible_b()
   CALL cl_set_act_visible("doc_delete",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 單身權限關閉
# Memo...........:
# Usage..........: CALL azzi552_set_act_no_visible_b()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/03 By dorislai (#160503-00001#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi552_set_act_no_visible_b()
   DEFINE l_str  STRING
   DEFINE l_i    LIKE type_t.num5
   LET l_i = g_detail_idx3
   
   IF cl_null(l_i) OR l_i = 0THEN
      LET l_i= 1
   END IF
   LET l_str = g_gzzy_d[l_i].l_filename
   
   #客製環境(檔明第一個字=C)/標準環境(檔明第一個字=S)
   IF FGL_GETENV("DGENV") = "c" THEN
      IF l_str.subString(1,1) <> "C" THEN
         CALL cl_set_act_visible("doc_delete",FALSE)
      END IF
   ELSE
      IF l_str.subString(1,1) <> "S" THEN
         CALL cl_set_act_visible("doc_delete",FALSE)
      END IF
   END IF
END FUNCTION

 
{</section>}
 
