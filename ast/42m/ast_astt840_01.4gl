#該程式未解開Section, 採用最新樣板產出!
{<section id="astt840_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-08-03 17:45:42), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: astt840_01
#+ Description: 租賃結算單元件
#+ Creator....: 06814(2016-06-03 15:07:26)
#+ Modifier...: 06189 -SD/PR- 00000
 
{</section>}
 
{<section id="astt840_01.global" >}
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
PRIVATE TYPE type_g_stbc_d RECORD
       sel LIKE type_t.chr1, 
   stbc001 LIKE stbc_t.stbc001, 
   stbc001_desc LIKE type_t.chr500, 
   stbcsite LIKE stbc_t.stbcsite, 
   stbcsite_desc LIKE type_t.chr500, 
   stbc002 LIKE stbc_t.stbc002, 
   stbc003 LIKE stbc_t.stbc003, 
   stbc004 LIKE stbc_t.stbc004, 
   stbc005 LIKE stbc_t.stbc005, 
   stbc033 LIKE stbc_t.stbc033, 
   stbc033_desc LIKE type_t.chr500, 
   stbc012 LIKE stbc_t.stbc012, 
   stbc012_desc LIKE type_t.chr500, 
   stbc059 LIKE stbc_t.stbc059, 
   stbc060 LIKE stbc_t.stbc060, 
   stbc060_desc LIKE type_t.chr500, 
   stbc034 LIKE stbc_t.stbc034, 
   stbc036 LIKE stbc_t.stbc036, 
   stbc017 LIKE stbc_t.stbc017, 
   stbc018 LIKE stbc_t.stbc018, 
   l_stbc019 LIKE type_t.num20_6, 
   stbc020 LIKE stbc_t.stbc020
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_stbddocno       LIKE stbd_t.stbddocno
DEFINE g_stbdsite        LIKE stbd_t.stbdsite
DEFINE g_stbdunit        LIKE stbd_t.stbdunit
DEFINE g_stbd003         LIKE stbd_t.stbd003
DEFINE g_stbd004         LIKE stbd_t.stbd004
DEFINE g_stbd006         LIKE stbd_t.stbd006 #20160627 By shi
DEFINE g_stbd037         LIKE stbd_t.stbd037
DEFINE g_stbd043         LIKE stbd_t.stbd043
DEFINE g_stbd044         LIKE stbd_t.stbd044
DEFINE g_stbc030         LIKE stbc_t.stbc030
DEFINE g_stjo002         LIKE stjo_t.stjo002
DEFINE g_para            LIKE type_t.chr1
DEFINE g_wc              STRING
DEFINE g_wc3             STRING   #160604-00009#15 20160607 add by beckxie
#end add-point
 
#模組變數(Module Variables)
DEFINE g_stbc_d          DYNAMIC ARRAY OF type_g_stbc_d #單身變數
DEFINE g_stbc_d_t        type_g_stbc_d                  #單身備份
DEFINE g_stbc_d_o        type_g_stbc_d                  #單身備份
DEFINE g_stbc_d_mask_o   DYNAMIC ARRAY OF type_g_stbc_d #單身變數
DEFINE g_stbc_d_mask_n   DYNAMIC ARRAY OF type_g_stbc_d #單身變數
 
      
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
 
{<section id="astt840_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION astt840_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_stbddocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_stbddocno  LIKE stbd_t.stbddocno
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_stbddocno = p_stbddocno
   
   SELECT stbdsite , stbdunit,stbd001,stbd003,stbd004,stbd037,stbd006
     INTO g_stbdsite,g_stbdunit, g_stbc030 ,g_stbd003,g_stbd004,g_stbd037,g_stbd006 #20160627 By shi Add stbd006
     FROM stbd_t
    WHERE stbdent = g_enterprise
      AND stbddocno = g_stbddocno
      
   IF cl_null(g_stbdsite) OR cl_null(g_stbc030) THEN
      RETURN
   END IF
   
   CALL s_astt840_get_period(g_stbc030,g_stbd004,g_stbdunit)
      RETURNING g_stjo002,g_stbd043,g_stbd044
      
   LET g_para = cl_get_para(g_enterprise,g_stbdsite,"S-CIR-2012")
   
   CALL astt840_01_create_temp() RETURNING l_success
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL astt840_01_query_data(g_wc2)
   
   SELECT COUNT(*) INTO l_cnt
     FROM astt840_01_tmp
     
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 'ast-00803' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      CALL s_aooi500_drop_temp() RETURNING l_success
      RETURN
   END IF
   IF NOT cl_ask_confirm('axm-00013') THEN
      CALL s_aooi500_drop_temp() RETURNING l_success
      RETURN
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT stbc001,stbcsite,stbc002,stbc003,stbc004,stbc005,stbc033,stbc012,stbc059, 
       stbc060,stbc034,stbc036,stbc017,stbc018,stbc020 FROM stbc_t WHERE stbcent=? AND stbc001=? AND  
       stbc004=? AND stbc005=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt840_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_astt840_01 WITH FORM cl_ap_formpath("ast","astt840_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL astt840_01_init()   
 
   #進入選單 Menu (="N")
   CALL astt840_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_astt840_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt840_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astt840_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('stbc003','6703') 
   CALL cl_set_combo_scc('stbc059','6932') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL astt840_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astt840_01_ui_dialog()
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
         CALL g_stbc_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL astt840_01_init()
      END IF
   
      CALL astt840_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stbc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL astt840_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         CONSTRUCT BY NAME g_wc ON stbcsite
            ON ACTION controlp INFIELD stbcsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where('astt840','stbdsite',g_stbdsite,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO stbcsite  #顯示到畫面上
               NEXT FIELD stbcsite                     #返回原欄位
         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_wc3 ON stbc025
            ON ACTION controlp INFIELD stbc025
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
               #160604-00009#15 20160607 add by beckxie---S
               LET g_qryparam.where = " rtax001 IN (SELECT stjk002 FROM stjk_t ",
                                      "              WHERE stjkent = ",g_enterprise," ",
                                      "                AND stjk001 = '",g_stbc030,"' ) "
               #160604-00009#15 20160607 add by beckxie---E
               CALL q_rtax001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO stbc025  #顯示到畫面上
               NEXT FIELD stbc025                        #返回原欄位
            
         END CONSTRUCT
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
            CALL cl_set_act_visible("modify,delete,query,insert,reproduce", FALSE)
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL astt840_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL astt840_01_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL astt840_01_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL astt840_01_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION check_all
            LET g_action_choice="check_all"
               
               #add-point:ON ACTION check_all name="menu.check_all"
               CALL astt840_01_check_all()
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION produce_data
            LET g_action_choice="produce_data"
               
               #add-point:ON ACTION produce_data name="menu.produce_data"
               IF astt840_01_produce_data() THEN
                  #true
                  #160604-00009#15 20160607 add by beckxie---S
                  IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續                            
                     #更新tmp table
                     CALL astt840_01_query_data(g_wc2)
                  ELSE
                     #LET INT_FLAG = TRUE 
                     LET g_action_choice = "exit" 
                     CANCEL DIALOG
                     #RETURN
                  END IF
                  #160604-00009#15 20160607 add by beckxie---E
               ELSE
                  #false
                  #160604-00009#15 20160607 add by beckxie---S
                  IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                     LET g_action_choice = "exit"              
                     CANCEL DIALOG
                  END IF
                  #160604-00009#15 20160607 add by beckxie---E
               END IF
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query_data
            LET g_action_choice="query_data"
               
               #add-point:ON ACTION query_data name="menu.query_data"
               CALL astt840_01_query_data(g_wc2)
               CALL astt840_01_b_fill(g_wc2)
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION check_no_all
            LET g_action_choice="check_no_all"
               
               #add-point:ON ACTION check_no_all name="menu.check_no_all"
               CALL astt840_01_check_no_all()
               #END add-point
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stbc_d)
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
            CALL astt840_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL astt840_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL astt840_01_set_pk_array()
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
 
{<section id="astt840_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt840_01_query()
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
   CALL g_stbc_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON NULL 
 
         FROM NULL 
      
         
      
           
         
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT BY NAME g_wc ON stbdsite
         ON ACTION controlp INFIELD stbdsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where('astt840','stbdsite',g_stbdsite,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO stbdsite  #顯示到畫面上
            NEXT FIELD stbdsite                     #返回原欄位
      END CONSTRUCT 
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
    
   CALL astt840_01_b_fill(g_wc2)
 
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
 
{<section id="astt840_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION astt840_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL astt840_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION astt840_01_modify()
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
   CALL cl_set_act_visible("modify,delete,query,insert,reproduce", FALSE)
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_stbc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stbc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt840_01_b_fill(g_wc2)
            LET g_detail_cnt = g_stbc_d.getLength()
         
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
            DISPLAY g_stbc_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_stbc_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_stbc_d[l_ac].stbc001 IS NOT NULL
               AND g_stbc_d[l_ac].stbc004 IS NOT NULL
               AND g_stbc_d[l_ac].stbc005 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stbc_d_t.* = g_stbc_d[l_ac].*  #BACKUP
               LET g_stbc_d_o.* = g_stbc_d[l_ac].*  #BACKUP
               IF NOT astt840_01_lock_b("stbc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt840_01_bcl INTO g_stbc_d[l_ac].stbc001,g_stbc_d[l_ac].stbcsite,g_stbc_d[l_ac].stbc002, 
                      g_stbc_d[l_ac].stbc003,g_stbc_d[l_ac].stbc004,g_stbc_d[l_ac].stbc005,g_stbc_d[l_ac].stbc033, 
                      g_stbc_d[l_ac].stbc012,g_stbc_d[l_ac].stbc059,g_stbc_d[l_ac].stbc060,g_stbc_d[l_ac].stbc034, 
                      g_stbc_d[l_ac].stbc036,g_stbc_d[l_ac].stbc017,g_stbc_d[l_ac].stbc018,g_stbc_d[l_ac].stbc020 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stbc_d_t.stbc001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stbc_d_mask_o[l_ac].* =  g_stbc_d[l_ac].*
                  CALL astt840_01_stbc_t_mask()
                  LET g_stbc_d_mask_n[l_ac].* =  g_stbc_d[l_ac].*
                  
                  CALL astt840_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL astt840_01_set_entry_b(l_cmd)
            CALL astt840_01_set_no_entry_b(l_cmd)
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
            INITIALIZE g_stbc_d_t.* TO NULL
            INITIALIZE g_stbc_d_o.* TO NULL
            INITIALIZE g_stbc_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_stbc_d[l_ac].sel = "N"
      LET g_stbc_d[l_ac].stbc034 = "0"
      LET g_stbc_d[l_ac].stbc036 = "0"
      LET g_stbc_d[l_ac].stbc017 = "0"
      LET g_stbc_d[l_ac].stbc018 = "0"
      LET g_stbc_d[l_ac].l_stbc019 = "0"
      LET g_stbc_d[l_ac].stbc020 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
 
            #end add-point
            LET g_stbc_d_t.* = g_stbc_d[l_ac].*     #新輸入資料
            LET g_stbc_d_o.* = g_stbc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stbc_d[li_reproduce_target].* = g_stbc_d[li_reproduce].*
 
               LET g_stbc_d[g_stbc_d.getLength()].stbc001 = NULL
               LET g_stbc_d[g_stbc_d.getLength()].stbc004 = NULL
               LET g_stbc_d[g_stbc_d.getLength()].stbc005 = NULL
 
            END IF
            
 
            CALL astt840_01_set_entry_b(l_cmd)
            CALL astt840_01_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM stbc_t 
             WHERE stbcent = g_enterprise AND stbc001 = g_stbc_d[l_ac].stbc001
                                       AND stbc004 = g_stbc_d[l_ac].stbc004
                                       AND stbc005 = g_stbc_d[l_ac].stbc005
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbc_d[g_detail_idx].stbc001
               LET gs_keys[2] = g_stbc_d[g_detail_idx].stbc004
               LET gs_keys[3] = g_stbc_d[g_detail_idx].stbc005
               CALL astt840_01_insert_b('stbc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_stbc_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stbc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt840_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (stbc001 = '", g_stbc_d[l_ac].stbc001, "' "
                                  ," AND stbc004 = '", g_stbc_d[l_ac].stbc004, "' "
                                  ," AND stbc005 = '", g_stbc_d[l_ac].stbc005, "' "
 
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
               
               DELETE FROM stbc_t
                WHERE stbcent = g_enterprise AND 
                      stbc001 = g_stbc_d_t.stbc001
                      AND stbc004 = g_stbc_d_t.stbc004
                      AND stbc005 = g_stbc_d_t.stbc005
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stbc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL astt840_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_stbc_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE astt840_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_stbc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbc_d_t.stbc001
               LET gs_keys[2] = g_stbc_d_t.stbc004
               LET gs_keys[3] = g_stbc_d_t.stbc005
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt840_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL astt840_01_delete_b('stbc_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_stbc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
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
            UPDATE astt840_01_tmp SET sel =  g_stbc_d[l_ac].sel
             WHERE stbcent = g_enterprise
               AND stbc001 = g_stbc_d[l_ac].stbc001
               AND stbc004 = g_stbc_d[l_ac].stbc004
               AND stbc005 = g_stbc_d[l_ac].stbc005
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE astt840_01_tmp"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            
            CALL astt840_01_b_fill(g_wc2)
            
            IF s_transaction_chk("Y",0) THEN
               CALL s_transaction_end('Y',0)
            END IF
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            CALL astt840_01_set_entry_b(l_cmd) 
            CALL astt840_01_set_no_entry_b(l_cmd) 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stbc019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_stbc_d[l_ac].l_stbc019,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_stbc019
            END IF 
 
 
 
            #add-point:AFTER FIELD l_stbc019 name="input.a.page1.l_stbc019"
            #add by geza 20160803 #160728-00006#18(S)
            #本次结算金额不能大于未结算金额
            IF NOT cl_null(g_stbc_d[l_ac].l_stbc019) THEN
               IF g_stbc_d[l_ac].l_stbc019 > g_stbc_d[l_ac].stbc018 - g_stbc_d[l_ac].stbc020 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ast-00292'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_stbc_d[l_ac].l_stbc019 = g_stbc_d_t.l_stbc019
                  NEXT FIELD CURRENT  
               END IF
            END IF
            #add by geza 20160803 #160728-00006#18(E)
            IF NOT cl_null(g_stbc_d[l_ac].l_stbc019) THEN
               UPDATE astt840_01_tmp SET stbc019 =  g_stbc_d[l_ac].l_stbc019
                WHERE stbcent = g_enterprise
                  AND stbc001 = g_stbc_d[l_ac].stbc001
                  AND stbc004 = g_stbc_d[l_ac].stbc004
                  AND stbc005 = g_stbc_d[l_ac].stbc005
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "UPDATE astt840_01_tmp"
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
               
               CALL astt840_01_b_fill(g_wc2)
               
               IF s_transaction_chk("Y",0) THEN
                  CALL s_transaction_end('Y',0)
               END IF
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF          
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stbc019
            #add-point:BEFORE FIELD l_stbc019 name="input.b.page1.l_stbc019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_stbc019
            #add-point:ON CHANGE l_stbc019 name="input.g.page1.l_stbc019"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_stbc019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stbc019
            #add-point:ON ACTION controlp INFIELD l_stbc019 name="input.c.page1.l_stbc019"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE astt840_01_bcl
               LET INT_FLAG = 0
               LET g_stbc_d[l_ac].* = g_stbc_d_t.*
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
               LET g_errparam.extend = g_stbc_d[l_ac].stbc001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_stbc_d[l_ac].* = g_stbc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL astt840_01_stbc_t_mask_restore('restore_mask_o')
 
               UPDATE stbc_t SET (stbc001,stbcsite,stbc002,stbc003,stbc004,stbc005,stbc033,stbc012,stbc059, 
                   stbc060,stbc034,stbc036,stbc017,stbc018,stbc020) = (g_stbc_d[l_ac].stbc001,g_stbc_d[l_ac].stbcsite, 
                   g_stbc_d[l_ac].stbc002,g_stbc_d[l_ac].stbc003,g_stbc_d[l_ac].stbc004,g_stbc_d[l_ac].stbc005, 
                   g_stbc_d[l_ac].stbc033,g_stbc_d[l_ac].stbc012,g_stbc_d[l_ac].stbc059,g_stbc_d[l_ac].stbc060, 
                   g_stbc_d[l_ac].stbc034,g_stbc_d[l_ac].stbc036,g_stbc_d[l_ac].stbc017,g_stbc_d[l_ac].stbc018, 
                   g_stbc_d[l_ac].stbc020)
                WHERE stbcent = g_enterprise AND
                  stbc001 = g_stbc_d_t.stbc001 #項次   
                  AND stbc004 = g_stbc_d_t.stbc004  
                  AND stbc005 = g_stbc_d_t.stbc005  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbc_d[g_detail_idx].stbc001
               LET gs_keys_bak[1] = g_stbc_d_t.stbc001
               LET gs_keys[2] = g_stbc_d[g_detail_idx].stbc004
               LET gs_keys_bak[2] = g_stbc_d_t.stbc004
               LET gs_keys[3] = g_stbc_d[g_detail_idx].stbc005
               LET gs_keys_bak[3] = g_stbc_d_t.stbc005
               CALL astt840_01_update_b('stbc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_stbc_d_t)
                     LET g_log2 = util.JSON.stringify(g_stbc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL astt840_01_stbc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL astt840_01_unlock_b("stbc_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stbc_d[l_ac].* = g_stbc_d_t.*
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
               LET g_stbc_d[li_reproduce_target].* = g_stbc_d[li_reproduce].*
 
               LET g_stbc_d[li_reproduce_target].stbc001 = NULL
               LET g_stbc_d[li_reproduce_target].stbc004 = NULL
               LET g_stbc_d[li_reproduce_target].stbc005 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stbc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stbc_d.getLength()+1
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
               NEXT FIELD sel
 
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
      IF INT_FLAG OR cl_null(g_stbc_d[g_detail_idx].stbc001) THEN
         CALL g_stbc_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_stbc_d[g_detail_idx].* = g_stbc_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE astt840_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astt840_01_delete()
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
   FOR li_idx = 1 TO g_stbc_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT astt840_01_lock_b("stbc_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("stbc_t","") THEN
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
   
   FOR li_idx = 1 TO g_stbc_d.getLength()
      IF g_stbc_d[li_idx].stbc001 IS NOT NULL
         AND g_stbc_d[li_idx].stbc004 IS NOT NULL
         AND g_stbc_d[li_idx].stbc005 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM stbc_t
          WHERE stbcent = g_enterprise AND 
                stbc001 = g_stbc_d[li_idx].stbc001
                AND stbc004 = g_stbc_d[li_idx].stbc004
                AND stbc005 = g_stbc_d[li_idx].stbc005
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbc_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_stbc_d_t.stbc001
               LET gs_keys[2] = g_stbc_d_t.stbc004
               LET gs_keys[3] = g_stbc_d_t.stbc005
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL astt840_01_delete_b('stbc_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt840_01_set_pk_array()
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
   CALL astt840_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt840_01_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   IF g_wc3 != " 1=1" THEN
      LET g_wc = cl_replace_str(g_wc3,"stbc025","stjk002")
   END IF
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   LET p_wc2 = p_wc2 , " AND ",g_wc, " AND ",g_wc3
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.stbc001,t0.stbcsite,t0.stbc002,t0.stbc003,t0.stbc004,t0.stbc005, 
       t0.stbc033,t0.stbc012,t0.stbc059,t0.stbc060,t0.stbc034,t0.stbc036,t0.stbc017,t0.stbc018,t0.stbc020 , 
       t1.ooefl003 ,t2.ooefl003 ,t3.mhbel003 ,t4.stael003 ,t5.ooefl003 FROM stbc_t t0",
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stbc001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.stbcsite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t3 ON t3.mhbelent="||g_enterprise||" AND t3.mhbel001=t0.stbc033 AND t3.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t4 ON t4.staelent="||g_enterprise||" AND t4.stael001=t0.stbc011 AND t4.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.stbc060 AND t5.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.stbcent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("stbc_t"),
                      " ORDER BY t0.stbc001,t0.stbc004,t0.stbc005"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   LET g_sql = "SELECT  DISTINCT stbc001     ,stbcsite    ,stbc002      ,stbc003     ,stbc004     , ",
               "                 stbc005     ,stbc033     ,stbc012      ,stbc059     ,stbc060     , ",
               "                 stbc034     ,stbc036     ,stbc017      ,stbc018     ,stbc020     , ",
               "                 stbc001_desc,stbcsite_desc,stbc033_desc,stbc012_desc,stbc060_desc ",
               "  FROM astt840_01_tmp  ",
               " WHERE stbcent = ? "
   LET g_sql = g_sql, cl_sql_add_filter("stbc_t"),
               " ORDER BY stbc001,stbc004,stbc005 "
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"stbc_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astt840_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astt840_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stbc_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_stbc_d[l_ac].stbc001,g_stbc_d[l_ac].stbcsite,g_stbc_d[l_ac].stbc002,g_stbc_d[l_ac].stbc003, 
       g_stbc_d[l_ac].stbc004,g_stbc_d[l_ac].stbc005,g_stbc_d[l_ac].stbc033,g_stbc_d[l_ac].stbc012,g_stbc_d[l_ac].stbc059, 
       g_stbc_d[l_ac].stbc060,g_stbc_d[l_ac].stbc034,g_stbc_d[l_ac].stbc036,g_stbc_d[l_ac].stbc017,g_stbc_d[l_ac].stbc018, 
       g_stbc_d[l_ac].stbc020,g_stbc_d[l_ac].stbc001_desc,g_stbc_d[l_ac].stbcsite_desc,g_stbc_d[l_ac].stbc033_desc, 
       g_stbc_d[l_ac].stbc012_desc,g_stbc_d[l_ac].stbc060_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT sel ,stbc019 INTO g_stbc_d[l_ac].sel,g_stbc_d[l_ac].l_stbc019
        FROM astt840_01_tmp 
       WHERE stbcent = g_enterprise
         AND stbc001 = g_stbc_d[l_ac].stbc001
         AND stbc004 = g_stbc_d[l_ac].stbc004
         AND stbc005 = g_stbc_d[l_ac].stbc005
             
      #end add-point
      
      CALL astt840_01_detail_show()      
 
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
   
 
   
   CALL g_stbc_d.deleteElement(g_stbc_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_stbc_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_stbc_d.getLength() THEN
      LET l_ac = g_stbc_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_stbc_d.getLength()
      LET g_stbc_d_mask_o[l_ac].* =  g_stbc_d[l_ac].*
      CALL astt840_01_stbc_t_mask()
      LET g_stbc_d_mask_n[l_ac].* =  g_stbc_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_stbc_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE astt840_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astt840_01_detail_show()
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
 
{<section id="astt840_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astt840_01_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("l_stbc019",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="astt840_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astt840_01_set_no_entry_b(p_cmd)                                               
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
   IF NOT (g_stbc_d[l_ac].sel ='Y' AND (g_stbc_d[l_ac].stbc003 = '3' OR g_stbc_d[l_ac].stbc003 = '4')) THEN
      CALL cl_set_comp_entry("l_stbc019",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astt840_01_default_search()
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
      LET ls_wc = ls_wc, " stbc001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " stbc004 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " stbc005 = '", g_argv[03], "' AND "
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
 
{<section id="astt840_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astt840_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "stbc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'stbc_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM stbc_t
          WHERE stbcent = g_enterprise AND
            stbc001 = ps_keys_bak[1] AND stbc004 = ps_keys_bak[2] AND stbc005 = ps_keys_bak[3]
         
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
         CALL g_stbc_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astt840_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "stbc_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO stbc_t
                  (stbcent,
                   stbc001,stbc004,stbc005
                   ,stbcsite,stbc002,stbc003,stbc033,stbc012,stbc059,stbc060,stbc034,stbc036,stbc017,stbc018,stbc020) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_stbc_d[l_ac].stbcsite,g_stbc_d[l_ac].stbc002,g_stbc_d[l_ac].stbc003,g_stbc_d[l_ac].stbc033, 
                       g_stbc_d[l_ac].stbc012,g_stbc_d[l_ac].stbc059,g_stbc_d[l_ac].stbc060,g_stbc_d[l_ac].stbc034, 
                       g_stbc_d[l_ac].stbc036,g_stbc_d[l_ac].stbc017,g_stbc_d[l_ac].stbc018,g_stbc_d[l_ac].stbc020) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astt840_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "stbc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "stbc_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE stbc_t 
         SET (stbc001,stbc004,stbc005
              ,stbcsite,stbc002,stbc003,stbc033,stbc012,stbc059,stbc060,stbc034,stbc036,stbc017,stbc018,stbc020) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_stbc_d[l_ac].stbcsite,g_stbc_d[l_ac].stbc002,g_stbc_d[l_ac].stbc003,g_stbc_d[l_ac].stbc033, 
                  g_stbc_d[l_ac].stbc012,g_stbc_d[l_ac].stbc059,g_stbc_d[l_ac].stbc060,g_stbc_d[l_ac].stbc034, 
                  g_stbc_d[l_ac].stbc036,g_stbc_d[l_ac].stbc017,g_stbc_d[l_ac].stbc018,g_stbc_d[l_ac].stbc020)  
 
         WHERE stbcent = g_enterprise AND stbc001 = ps_keys_bak[1] AND stbc004 = ps_keys_bak[2] AND stbc005 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbc_t:",SQLERRMESSAGE 
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
 
{<section id="astt840_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astt840_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL astt840_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "stbc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt840_01_bcl USING g_enterprise,
                                       g_stbc_d[g_detail_idx].stbc001,g_stbc_d[g_detail_idx].stbc004, 
                                           g_stbc_d[g_detail_idx].stbc005
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt840_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astt840_01_unlock_b(ps_table)
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
      CLOSE astt840_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION astt840_01_modify_detail_chk(ps_record)
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
         LET ls_return = "sel"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="astt840_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION astt840_01_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="astt840_01.mask_functions" >}
&include "erp/ast/astt840_01_mask.4gl"
 
{</section>}
 
{<section id="astt840_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION astt840_01_set_pk_array()
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
   LET g_pk_array[1].values = g_stbc_d[l_ac].stbc001
   LET g_pk_array[1].column = 'stbc001'
   LET g_pk_array[2].values = g_stbc_d[l_ac].stbc004
   LET g_pk_array[2].column = 'stbc004'
   LET g_pk_array[3].values = g_stbc_d[l_ac].stbc005
   LET g_pk_array[3].column = 'stbc005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt840_01.state_change" >}
   
 
{</section>}
 
{<section id="astt840_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="astt840_01.other_function" readonly="Y" >}

PRIVATE FUNCTION astt840_01_create_temp()
   DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   CALL astt840_01_drop_temp()
   
   CREATE TEMP TABLE astt840_01_tmp(
      stbcent        SMALLINT,
      sel            VARCHAR(1), 
      stbc001        VARCHAR(10), 
      stbc001_desc   VARCHAR(500), 
      stbcsite       VARCHAR(10), 
      stbcsite_desc  VARCHAR(500), 
      stbc002        DATE, 
      stbc003        VARCHAR(10), 
      stbc004        VARCHAR(20), 
      stbc005        INTEGER, 
      stbc033        VARCHAR(20), 
      stbc033_desc   VARCHAR(500), 
      stbc012        VARCHAR(10), 
      stbc012_desc   VARCHAR(500), 
      stbc059        VARCHAR(10), 
      stbc060        VARCHAR(10), 
      stbc060_desc   VARCHAR(500), 
      stbc034        DECIMAL(20,6), 
      stbc036        DECIMAL(20,6), 
      stbc017        DECIMAL(20,6), 
      stbc018        DECIMAL(20,6), 
      stbc019        DECIMAL(20,6), 
      stbc020        DECIMAL(20,6))
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table astt840_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION astt840_01_drop_temp()
   DROP TABLE astt840_01_tmp
END FUNCTION

PRIVATE FUNCTION astt840_01_check_all()
   UPDATE astt840_01_tmp SET sel = 'Y'
   CALL astt840_01_b_fill(g_wc2)
END FUNCTION

PRIVATE FUNCTION astt840_01_check_no_all()
   UPDATE astt840_01_tmp SET sel = 'N'
   CALL astt840_01_b_fill(g_wc2)
END FUNCTION

################################################################################
# Descriptions...: 產生單身
# Memo...........:
# Usage..........: CALL astt840_01_produce_data()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success
#                : 
# Date & Author..: 20160604 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_01_produce_data()
   DEFINE l_success LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   
   LET l_success = TRUE
   LET r_success = TRUE
      
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
  #CALL s_astp840_ins_detail('N',               1,                 g_para,               #是否為批次作業,處理類型,是否啟用交款匯總        #160513-00037#12 160524 by lori 加傳第一個參數
  #                          g_stbdsite, g_stbdunit, '',                   #結算組織,結算中心,來源單據編號
  #                          '',                g_stbd003,  g_stbc030,     #來源單據項次,經營方式,合約編號
  #                          g_stbd037,  '',                g_stjo002,   #鋪位編號,納入結算單否,結算日期     
  #                          g_stbddocno,'')                                      #結算單號/匯總單號,批次處理條件
  #   RETURNING l_success
  
   CALL s_astp840_insert_stbe(g_stbddocno,'Y','') RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
   END IF
   CALL s_astp840_insert_stbe(g_stbddocno,'N','') RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
   END IF
   #更新费用单身的本次结算金额
   IF NOT s_astp840_upd_stbe3(g_stbddocno) THEN
      LET r_success = FALSE
   ELSE
      #單頭金額更新
      CALL s_astp840_stbe_summary(g_stbddocno) RETURNING r_success
      IF NOT r_success THEN
         LET r_success = FALSE
      END IF
   END IF
   
   IF r_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   
   CALL cl_err_collect_show()
   
   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 查詢時將資料ins至tmp
# Memo...........:
# Usage..........: CALL astt840_01_query_data(p_wc2)
# Input parameter: p_wc2          查詢條件
#                : 
# Return code....: 
#                : 
# Date & Author..: 20160604 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_01_query_data(p_wc2)
   DEFINE p_wc2           STRING
   DEFINE l_stbc037_value STRING
   DEFINE l_date_sql      STRING
   DEFINE l_sql           STRING
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
      
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   IF g_wc3 != " 1=1" THEN
      LET g_wc = cl_replace_str(g_wc3,"stbc025","stjk002")
   END IF
   LET p_wc2 = p_wc2 , " AND ",g_wc, " AND ",g_wc3
   
   #ins至temp
   DELETE FROM astt840_01_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE:astt840_01_tmp"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   LET l_sql = " INSERT INTO astt840_01_tmp ( ",
                 "             stbcent     ,sel         ,stbc001     ,stbcsite    ,stbc002      , ",
                 "             stbc003     ,stbc004     ,stbc005     ,stbc033     ,stbc012      , ",
                 "             stbc059     ,stbc060     ,stbc034     ,stbc036     ,stbc017      , ",
                 "             stbc018     ,stbc019     ,stbc020     ,stbc001_desc,stbcsite_desc, ",
                 "             stbc033_desc,stbc012_desc,stbc060_desc) ",
                 "               ",
                 " SELECT UNIQUE ",g_enterprise," , 'N' ,",
                 "             t0.stbc001,t0.stbcsite,t0.stbc002 ,t0.stbc003 ,t0.stbc004 ,",
                 "             t0.stbc005,t0.stbc033,t0.stbc012 ,t0.stbc059 ,t0.stbc060 , ",
                 "             t0.stbc034 ,t0.stbc036,t0.stbc017,t0.stbc018,t0.stbc019, ",
                 "             t0.stbc020,t1.ooefl003,t2.ooefl003,t3.mhbel003,t4.stael003, ",
                 "             t5.ooefl003 ",
                 "   FROM stbc_t t0 ",
                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.stbc001 AND t1.ooefl002='"||g_dlang||"' ",
                 " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.stbcsite AND t2.ooefl002='"||g_dlang||"'",
                 " LEFT JOIN mhbel_t t3 ON t3.mhbelent='"||g_enterprise||"' AND t3.mhbel001=t0.stbc033 AND t3.mhbel002='"||g_dlang||"' ",
                 " LEFT JOIN stael_t t4 ON t4.staelent='"||g_enterprise||"' AND t4.stael001=t0.stbc011 AND t4.stael002='"||g_dlang||"' ",
                 " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.stbc060 AND t5.ooefl002='"||g_dlang||"' ",
                 " LEFT JOIN stjk_t t6 ON t6.stjkent = '"||g_enterprise||"' AND t6.stjk001 = t0.stbc030 ",
                 " WHERE t0.stbcent= ?  AND  1=1 AND (", p_wc2, ") ",
                 "   AND t0.stbc003 IN ('3','4','5') ",
                 "   AND t0.stbc009 = '5' ",
                 "   AND t0.stbc019 <> 0 ",
                 "   AND t0.stbc030 = '",g_stbc030,"' ",
                 "   AND t0.stbc033 = '",g_stbd037,"' ",
                 "   AND t0.stbcstus IN ('1','3') "
   LET l_date_sql =  " AND ((t0.stbc003 IN ('4','5') ",
                     #"       AND COALESCE(t0.stbc040,TO_DATE ('",g_stjo002,"', 'YYYY,MM,DD')) <= '",g_stjo002,"') ", #mark by geza 20160627  
                     "       AND COALESCE(t0.stbc040,TO_DATE ('",g_stbd006,"', 'YYYY,MM,DD')) <= '",g_stbd006,"') ", #20160627 By shi Mod                     
                     "   OR (t0.stbc003 = '3' AND l_stbc037_value)) "  
   IF g_para = 'Y' THEN
       LET l_stbc037_value = " t0.stbc037 = 'Y' "
   ELSE
       LET l_stbc037_value = " 1 = 1 "              
   END IF
   LET l_date_sql = cl_str_replace(l_date_sql,'l_stbc037_value',l_stbc037_value)
   LET l_sql = l_sql,l_date_sql    


   PREPARE astt840_01_ins_temp_pre FROM l_sql
   EXECUTE astt840_01_ins_temp_pre USING g_enterprise
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE:astt840_01_ins_temp_pre"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   CALL astt840_01_b_fill(p_wc2)

END FUNCTION

 
{</section>}
 
