{<section id="adzi099.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000000
#+ 
#+ Filename...: adzi099
#+ Description: 產生用
#+ Creator....: 00845(2014-11-24 17:17:08)
#+ Modifier...: 00845(2014-11-24 17:17:08) -SD/PR- 00000()
 
{</section>}
 
{<section id="adzi099.global" >}
#應用 i02 樣板自動產生(Version:1)

 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_dzdu_d RECORD
       dzdustus LIKE dzdu_t.dzdustus, 
   dzdu001 LIKE dzdu_t.dzdu001, 
   dzdu002 LIKE dzdu_t.dzdu002, 
   dzdu007 LIKE dzdu_t.dzdu007,
   dzdu008 LIKE dzdu_t.dzdu008,
   dzdu009 LIKE dzdu_t.dzdu009, 
   dzdu005 LIKE dzdu_t.dzdu005, 
   dzdu003 LIKE dzdu_t.dzdu003, 
   dzdu004 LIKE dzdu_t.dzdu004, 
   dzdu006 LIKE dzdu_t.dzdu006
       END RECORD
PRIVATE TYPE type_g_dzdu2_d RECORD
       dzdu001 LIKE dzdu_t.dzdu001, 
   dzduownid LIKE dzdu_t.dzduownid, 
   dzduownid_desc LIKE type_t.chr500, 
   dzduowndp LIKE dzdu_t.dzduowndp, 
   dzduowndp_desc LIKE type_t.chr500, 
   dzducrtid LIKE dzdu_t.dzducrtid, 
   dzducrtid_desc LIKE type_t.chr500, 
   dzducrtdp LIKE dzdu_t.dzducrtdp, 
   dzducrtdp_desc LIKE type_t.chr500, 
   dzducrtdt DATETIME YEAR TO SECOND, 
   dzdumodid LIKE dzdu_t.dzdumodid, 
   dzdumodid_desc LIKE type_t.chr500, 
   dzdumoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_dzdu_d          DYNAMIC ARRAY OF type_g_dzdu_d #單身變數
DEFINE g_dzdu_d_t        type_g_dzdu_d                  #單身備份
DEFINE g_dzdu_d_o        type_g_dzdu_d                  #單身備份
DEFINE g_dzdu2_d   DYNAMIC ARRAY OF type_g_dzdu2_d
DEFINE g_dzdu2_d_t type_g_dzdu2_d
DEFINE g_dzdu2_d_o type_g_dzdu2_d
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
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
 
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="adzi099.main" >}
#應用 a26 樣板自動產生(Version:1)
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
 
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT dzdustus,dzdu001,dzdu002,dzdu007,dzdu008,dzdu009,dzdu005,dzdu003,dzdu004,dzdu006,dzdu001, 
       dzduownid,dzduowndp,dzducrtid,dzducrtdp,dzducrtdt,dzdumodid,dzdumoddt FROM dzdu_t WHERE dzdu001=?  
       FOR UPDATE"
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adzi099_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi099 WITH FORM cl_ap_formpath("adz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adzi099_init()   
 
      #進入選單 Menu (="N")
      CALL adzi099_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adzi099
      
   END IF 
   
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="adzi099.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adzi099_init()
   #add-point:init段define
   
   #end add-point   
   
      CALL cl_set_combo_scc_part('dzdustus','50','N,X,Y')
 
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   CALL adzi099_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adzi099.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adzi099_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   
   #end add-point 
 
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
   
   WHILE TRUE
   
      CALL adzi099_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dzdu_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:1)
   CALL adzi099_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_dzdu2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:1)
   CALL adzi099_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
               #add-point:display array-before row
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail2", 1)
 
            #add-point:ui_dialog段before
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adzi099_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adzi099_modify()
               #add-point:ON ACTION modify_detail
               
               #END add-point
               
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adzi099_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce
               
               #END add-point
               
            END IF
 
 
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adzi099_query()
               #add-point:ON ACTION query
               
               #END add-point
               #應用 a59 樣板自動產生(Version:1)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
			   
 
 
            END IF
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_dzdu_d)
               LET g_export_node[2] = base.typeInfo.create(g_dzdu2_d)
 
               #add-point:ON ACTION exporttoexcel
               
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
            
         
         
         #應用 a46 樣板自動產生(Version:1)
         #新增相關文件
         ON ACTION related_document
            CALL adzi099_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adzi099_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adzi099_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前
         
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="adzi099.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adzi099_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_dzdu_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON dzdustus,dzdu001,dzdu002,dzdu007,dzdu008,dzdu009,dzdu005,dzdu003,dzdu004,dzdu006,dzduownid, 
          dzduowndp,dzducrtid,dzducrtdp,dzducrtdt,dzdumodid,dzdumoddt 
 
         FROM s_detail1[1].dzdustus,s_detail1[1].dzdu001,s_detail1[1].dzdu002,s_detail1[1].dzdu007,s_detail1[1].dzdu008,s_detail1[1].dzdu009,s_detail1[1].dzdu005, 
             s_detail1[1].dzdu003,s_detail1[1].dzdu004,s_detail1[1].dzdu006,s_detail2[1].dzduownid,s_detail2[1].dzduowndp, 
             s_detail2[1].dzducrtid,s_detail2[1].dzducrtdp,s_detail2[1].dzducrtdt,s_detail2[1].dzdumodid, 
             s_detail2[1].dzdumoddt 
      
         #應用 a11 樣板自動產生(Version:1)
         #共用欄位查詢處理
         ##----<<dzducrtdt>>----
         AFTER FIELD dzducrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdumoddt>>----
         AFTER FIELD dzdumoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzducnfdt>>----
         
         #----<<dzdupstdt>>----
 
 
      
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdustus
            #add-point:BEFORE FIELD dzdustus
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdustus
            
            #add-point:AFTER FIELD dzdustus
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdustus
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdustus
            #add-point:ON ACTION controlp INFIELD dzdustus
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu001
            #add-point:BEFORE FIELD dzdu001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu001
            
            #add-point:AFTER FIELD dzdu001
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu001
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu001
            #add-point:ON ACTION controlp INFIELD dzdu001
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu002
            #add-point:BEFORE FIELD dzdu002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu002
            
            #add-point:AFTER FIELD dzdu002
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu002
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu002
            #add-point:ON ACTION controlp INFIELD dzdu002
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu007
            #add-point:BEFORE FIELD dzdu007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu007
            
            #add-point:AFTER FIELD dzdu007
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu007
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu007
            #add-point:ON ACTION controlp INFIELD dzdu007
            
            #END add-point

          #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu008
            #add-point:BEFORE FIELD dzdu008
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu008
            
            #add-point:AFTER FIELD dzdu008
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu008
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu008
            #add-point:ON ACTION controlp INFIELD dzdu008
            
            #END add-point   

           #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu009
            #add-point:BEFORE FIELD dzdu009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu009
            
            #add-point:AFTER FIELD dzdu009
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu009
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu009
            #add-point:ON ACTION controlp INFIELD dzdu009
            
            #END add-point    
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu005
            #add-point:BEFORE FIELD dzdu005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu005
            
            #add-point:AFTER FIELD dzdu005
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu005
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu005
            #add-point:ON ACTION controlp INFIELD dzdu005
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu003
            #add-point:BEFORE FIELD dzdu003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu003
            
            #add-point:AFTER FIELD dzdu003
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu003
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu003
            #add-point:ON ACTION controlp INFIELD dzdu003
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu004
            #add-point:BEFORE FIELD dzdu004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu004
            
            #add-point:AFTER FIELD dzdu004
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu004
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu004
            #add-point:ON ACTION controlp INFIELD dzdu004
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu006
            #add-point:BEFORE FIELD dzdu006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu006
            
            #add-point:AFTER FIELD dzdu006
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.dzdu006
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu006
            #add-point:ON ACTION controlp INFIELD dzdu006
            
            #END add-point
 
  
         
                  #Ctrlp:construct.c.page2.dzduownid
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzduownid
            #add-point:ON ACTION controlp INFIELD dzduownid
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzduownid  #顯示到畫面上
            NEXT FIELD dzduownid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzduownid
            #add-point:BEFORE FIELD dzduownid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzduownid
            
            #add-point:AFTER FIELD dzduownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.dzduowndp
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzduowndp
            #add-point:ON ACTION controlp INFIELD dzduowndp
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzduowndp  #顯示到畫面上
            NEXT FIELD dzduowndp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzduowndp
            #add-point:BEFORE FIELD dzduowndp
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzduowndp
            
            #add-point:AFTER FIELD dzduowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.dzducrtid
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzducrtid
            #add-point:ON ACTION controlp INFIELD dzducrtid
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzducrtid  #顯示到畫面上
            NEXT FIELD dzducrtid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzducrtid
            #add-point:BEFORE FIELD dzducrtid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzducrtid
            
            #add-point:AFTER FIELD dzducrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.dzducrtdp
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzducrtdp
            #add-point:ON ACTION controlp INFIELD dzducrtdp
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzducrtdp  #顯示到畫面上
            NEXT FIELD dzducrtdp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzducrtdp
            #add-point:BEFORE FIELD dzducrtdp
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzducrtdp
            
            #add-point:AFTER FIELD dzducrtdp
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzducrtdt
            #add-point:BEFORE FIELD dzducrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.page2.dzdumodid
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdumodid
            #add-point:ON ACTION controlp INFIELD dzdumodid
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdumodid  #顯示到畫面上
            NEXT FIELD dzdumodid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdumodid
            #add-point:BEFORE FIELD dzdumodid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdumodid
            
            #add-point:AFTER FIELD dzdumodid
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdumoddt
            #add-point:BEFORE FIELD dzdumoddt
            
            #END add-point
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct
      
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog
         
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
 
   #add-point:query段after_construct
   
   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL adzi099_b_fill(g_wc2)
   
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
 
{<section id="adzi099.insert" >}
#+ 資料新增
PRIVATE FUNCTION adzi099_insert()
   #add-point:delete段define
   
   #end add-point                
    
   #add-point:單身新增前
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL adzi099_modify()
            
   #add-point:單身新增後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adzi099.modify" >}
#+ 資料修改
PRIVATE FUNCTION adzi099_modify()
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num5
   DEFINE  l_i                    LIKE type_t.num5
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num5
   DEFINE  li_reproduce_target    LIKE type_t.num5
   DEFINE  lb_reproduce           BOOLEAN
   #add-point:modify段define
   
   #end add-point 
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前
   
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
 
   #add-point:modify段修改前
   
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzdu_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = FALSE,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dzdu_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adzi099_b_fill(g_wc2)
            LET g_detail_cnt = g_dzdu_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row
            
            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_dzdu_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dzdu_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dzdu_d[l_ac].dzdu001 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_dzdu_d_t.* = g_dzdu_d[l_ac].*  #BACKUP
               LET g_dzdu_d_o.* = g_dzdu_d[l_ac].*  #BACKUP
               IF NOT adzi099_lock_b("dzdu_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi099_bcl INTO g_dzdu_d[l_ac].dzdustus,g_dzdu_d[l_ac].dzdu001,g_dzdu_d[l_ac].dzdu002, 
                      g_dzdu_d[l_ac].dzdu007,g_dzdu_d[l_ac].dzdu008,g_dzdu_d[l_ac].dzdu009,g_dzdu_d[l_ac].dzdu005,g_dzdu_d[l_ac].dzdu003,g_dzdu_d[l_ac].dzdu004, 
                      g_dzdu_d[l_ac].dzdu006,g_dzdu2_d[l_ac].dzdu001,g_dzdu2_d[l_ac].dzduownid,g_dzdu2_d[l_ac].dzduowndp, 
                      g_dzdu2_d[l_ac].dzducrtid,g_dzdu2_d[l_ac].dzducrtdp,g_dzdu2_d[l_ac].dzducrtdt, 
                      g_dzdu2_d[l_ac].dzdumodid,g_dzdu2_d[l_ac].dzdumoddt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dzdu_d_t.dzdu001 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL adzi099_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzdu_d_t.* TO NULL
            INITIALIZE g_dzdu_d_o.* TO NULL
            INITIALIZE g_dzdu_d[l_ac].* TO NULL 
            SELECT MAX(dzdu001) + 1 INTO g_dzdu_d[l_ac].dzdu001
              FROM dzdu_t
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:1)    
            #公用欄位新增給值
            LET g_dzdu2_d[l_ac].dzduownid = g_user
            LET g_dzdu2_d[l_ac].dzduowndp = g_dept
            LET g_dzdu2_d[l_ac].dzducrtid = g_user
            LET g_dzdu2_d[l_ac].dzducrtdp = g_dept 
            LET g_dzdu2_d[l_ac].dzducrtdt = cl_get_current()
            LET g_dzdu2_d[l_ac].dzdumodid = ""
            LET g_dzdu2_d[l_ac].dzdumoddt = ""
            LET g_dzdu_d[l_ac].dzdustus = "N"
            LET g_dzdu_d[l_ac].dzdu008 = "N"
 
            #自定義預設值(單身2)
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_dzdu_d_t.* = g_dzdu_d[l_ac].*     #新輸入資料
            LET g_dzdu_d_o.* = g_dzdu_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzi099_set_entry_b("a")
            CALL adzi099_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dzdu_d[li_reproduce_target].* = g_dzdu_d[li_reproduce].*
               LET g_dzdu2_d[li_reproduce_target].* = g_dzdu2_d[li_reproduce].*
 
               LET g_dzdu_d[g_dzdu_d.getLength()].dzdu001 = NULL
 
            END IF
            
            #add-point:modify段before insert
            
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
            SELECT COUNT(*) INTO l_count FROM dzdu_t 
             WHERE  dzdu001 = g_dzdu_d[l_ac].dzdu001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdu_d[g_detail_idx].dzdu001
               CALL adzi099_insert_b('dzdu_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_dzdu_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dzdu_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adzi099_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (dzdu001 = '", g_dzdu_d[l_ac].dzdu001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前
               
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
               
               #add-point:單身刪除前
               
               #end add-point   
               
               DELETE FROM dzdu_t
                WHERE  
                      dzdu001 = g_dzdu_d_t.dzdu001
 
                      
               #add-point:單身刪除中
               
               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dzdu_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adzi099_bcl
               #add-point:單身關閉bcl
               
               #end add-point
               LET l_count = g_dzdu_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdu_d[g_detail_idx].dzdu001
 
               #應用 a47 樣板自動產生(Version:1)
      #刪除相關文件
      CALL adzi099_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2
               
               #end add-point
                              CALL adzi099_delete_b('dzdu_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_dzdu_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdustus
            #add-point:BEFORE FIELD dzdustus
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdustus
            
            #add-point:AFTER FIELD dzdustus
            IF g_dzdu_d[g_detail_idx].dzdustus = "Y" AND g_dzdu_d_t.dzdustus = "N" THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "已準備把狀態碼勾選，以後就不能再做修改了哦!" 
               LET g_errparam.code   = "!" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdustus
            #add-point:ON CHANGE dzdustus
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu001
            #add-point:BEFORE FIELD dzdu001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu001
            
            #add-point:AFTER FIELD dzdu001
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_dzdu_d[g_detail_idx].dzdu001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dzdu_d[g_detail_idx].dzdu001 != g_dzdu_d_t.dzdu001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdu_t WHERE "||"dzdu001 = '"||g_dzdu_d[g_detail_idx].dzdu001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu001
            #add-point:ON CHANGE dzdu001
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu002
            #add-point:BEFORE FIELD dzdu002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu002
            
            #add-point:AFTER FIELD dzdu002
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu002
            #add-point:ON CHANGE dzdu002
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu007
            #add-point:BEFORE FIELD dzdu007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu007
            
            #add-point:AFTER FIELD dzdu007
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu007
            #add-point:ON CHANGE dzdu007
            
            #END add-point
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu008
            #add-point:BEFORE FIELD dzdu008
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu008
            
            #add-point:AFTER FIELD dzdu008
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu008
            #add-point:ON CHANGE dzdu008
            
            #END add-point

          #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu009
            #add-point:BEFORE FIELD dzdu009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu009
            
            #add-point:AFTER FIELD dzdu009
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu009
            #add-point:ON CHANGE dzdu009
            
            #END add-point
            
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu005
            #add-point:BEFORE FIELD dzdu005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu005
            
            #add-point:AFTER FIELD dzdu005
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu005
            #add-point:ON CHANGE dzdu005
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu003
            #add-point:BEFORE FIELD dzdu003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu003
            
            #add-point:AFTER FIELD dzdu003
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu003
            #add-point:ON CHANGE dzdu003
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu004
            #add-point:BEFORE FIELD dzdu004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu004
            
            #add-point:AFTER FIELD dzdu004
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu004
            #add-point:ON CHANGE dzdu004
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzdu006
            #add-point:BEFORE FIELD dzdu006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzdu006
            
            #add-point:AFTER FIELD dzdu006
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:1)
         ON CHANGE dzdu006
            #add-point:ON CHANGE dzdu006
            
            #END add-point
 
 
                  #Ctrlp:input.c.page1.dzdustus
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdustus
            #add-point:ON ACTION controlp INFIELD dzdustus
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdu001
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu001
            #add-point:ON ACTION controlp INFIELD dzdu001
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdu002
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu002
            #add-point:ON ACTION controlp INFIELD dzdu002
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdu007
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu007
            #add-point:ON ACTION controlp INFIELD dzdu007

            
            #END add-point

         #Ctrlp:input.c.page1.dzdu008
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu008
            #add-point:ON ACTION controlp INFIELD dzdu008

            
            #END add-point
         #Ctrlp:input.c.page1.dzdu009
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu009
            #add-point:ON ACTION controlp INFIELD dzdu009

            
            #END add-point            
         #Ctrlp:input.c.page1.dzdu005
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu005
            #add-point:ON ACTION controlp INFIELD dzdu005
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdu003
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu003
            #add-point:ON ACTION controlp INFIELD dzdu003
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdu004
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu004
            #add-point:ON ACTION controlp INFIELD dzdu004
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzdu006
#         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD dzdu006
            #add-point:ON ACTION controlp INFIELD dzdu006
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzdu_d[l_ac].* = g_dzdu_d_t.*
               CLOSE adzi099_bcl
               #add-point:單身取消時
               
               #end add-point
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_dzdu_d[l_ac].dzdu001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_dzdu_d[l_ac].* = g_dzdu_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_dzdu2_d[l_ac].dzdumodid = g_user 
               LET g_dzdu2_d[l_ac].dzdumoddt = cl_get_current()
               LET g_dzdu2_d[l_ac].dzdumodid_desc = cl_get_username(g_dzdu2_d[l_ac].dzdumodid)
            
               #add-point:單身修改前
               IF g_dzdu_d_t.dzdustus = "N" THEN
               #end add-point
               
               UPDATE dzdu_t SET (dzdustus,dzdu001,dzdu002,dzdu007,dzdu008,dzdu009,dzdu005,dzdu003,dzdu004,dzdu006,dzduownid, 
                   dzduowndp,dzducrtid,dzducrtdp,dzducrtdt,dzdumodid,dzdumoddt) = (g_dzdu_d[l_ac].dzdustus, 
                   g_dzdu_d[l_ac].dzdu001,g_dzdu_d[l_ac].dzdu002,g_dzdu_d[l_ac].dzdu007,g_dzdu_d[l_ac].dzdu008,g_dzdu_d[l_ac].dzdu009,g_dzdu_d[l_ac].dzdu005, 
                   g_dzdu_d[l_ac].dzdu003,g_dzdu_d[l_ac].dzdu004,g_dzdu_d[l_ac].dzdu006,g_dzdu2_d[l_ac].dzduownid, 
                   g_dzdu2_d[l_ac].dzduowndp,g_dzdu2_d[l_ac].dzducrtid,g_dzdu2_d[l_ac].dzducrtdp,g_dzdu2_d[l_ac].dzducrtdt, 
                   g_dzdu2_d[l_ac].dzdumodid,g_dzdu2_d[l_ac].dzdumoddt)
                WHERE 
                  dzdu001 = g_dzdu_d_t.dzdu001 #項次   
 
                  
               #add-point:單身修改中
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzdu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzdu_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzdu_d[g_detail_idx].dzdu001
               LET gs_keys_bak[1] = g_dzdu_d_t.dzdu001
               CALL adzi099_update_b('dzdu_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_dzdu_d_t)
                     LET g_log2 = util.JSON.stringify(g_dzdu_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "本條目已經標註為確認，不可修改" 
                  LET g_errparam.code   = "!" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET INT_FLAG = 0
                  LET g_dzdu_d[l_ac].* = g_dzdu_d_t.*
                  CLOSE adzi099_bcl
                  CALL s_transaction_end('N','0')
               END IF 
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adzi099_unlock_b("dzdu_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
             #add-point:單身after row
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_dzdu_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_dzdu_d.getLength()+1
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_dzdu2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL adzi099_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為
         
         #end add-point
            
      END DISPLAY
 
      
      #add-point:before_more_input
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD dzdustus
            WHEN "s_detail2"
               NEXT FIELD dzdu001_2
 
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
   IF l_cmd = 'a' AND INT_FLAG THEN
      CALL g_dzdu_d.deleteElement(l_ac)
      CALL g_dzdu2_d.deleteElement(l_ac)
 
   END IF
    
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_dzdu_d[l_ac].* = g_dzdu_d_t.*
   END IF
   
   #add-point:modify段修改後
   
   #end add-point
 
   CLOSE adzi099_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
 
{<section id="adzi099.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adzi099_b_fill(p_wc2)              #BODY FILL UP
   DEFINE p_wc2    STRING
   #add-point:b_fill段define
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前
   
   #end add-point
 
   LET g_sql = "SELECT  UNIQUE t0.dzdustus,t0.dzdu001,t0.dzdu002,t0.dzdu007,t0.dzdu008,t0.dzdu009,t0.dzdu005,t0.dzdu003,t0.dzdu004, 
       t0.dzdu006,t0.dzdu001,t0.dzduownid,t0.dzduowndp,t0.dzducrtid,t0.dzducrtdp,t0.dzducrtdt,t0.dzdumodid, 
       t0.dzdumoddt ,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM dzdu_t t0",
               "",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.dzduownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.dzduowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.dzducrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.dzducrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.dzdumodid  ",
 
               " WHERE 1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("dzdu_t"),
                      " ORDER BY t0.dzdu001"
   
   #add-point:b_fill段sql之後
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"dzdu_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adzi099_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adzi099_pb
   
   OPEN b_fill_curs
 
   CALL g_dzdu_d.clear()
   CALL g_dzdu2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dzdu_d[l_ac].dzdustus,g_dzdu_d[l_ac].dzdu001,g_dzdu_d[l_ac].dzdu002,g_dzdu_d[l_ac].dzdu007,g_dzdu_d[l_ac].dzdu008,g_dzdu_d[l_ac].dzdu009, 
       g_dzdu_d[l_ac].dzdu005,g_dzdu_d[l_ac].dzdu003,g_dzdu_d[l_ac].dzdu004,g_dzdu_d[l_ac].dzdu006,g_dzdu2_d[l_ac].dzdu001, 
       g_dzdu2_d[l_ac].dzduownid,g_dzdu2_d[l_ac].dzduowndp,g_dzdu2_d[l_ac].dzducrtid,g_dzdu2_d[l_ac].dzducrtdp, 
       g_dzdu2_d[l_ac].dzducrtdt,g_dzdu2_d[l_ac].dzdumodid,g_dzdu2_d[l_ac].dzdumoddt,g_dzdu2_d[l_ac].dzduownid_desc, 
       g_dzdu2_d[l_ac].dzduowndp_desc,g_dzdu2_d[l_ac].dzducrtid_desc,g_dzdu2_d[l_ac].dzducrtdp_desc, 
       g_dzdu2_d[l_ac].dzdumodid_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      
      #end add-point
      
      CALL adzi099_detail_show()      
 
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
   
 
   
   CALL g_dzdu_d.deleteElement(g_dzdu_d.getLength())   
   CALL g_dzdu2_d.deleteElement(g_dzdu2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_dzdu_d.getLength()
      LET g_dzdu2_d[l_ac].dzdu001 = g_dzdu_d[l_ac].dzdu001 
 
   END FOR
   
   IF g_cnt > g_dzdu_d.getLength() THEN
      LET l_ac = g_dzdu_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_dzdu_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE adzi099_pb
   
END FUNCTION
 
{</section>}
 
{<section id="adzi099.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adzi099_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
 
 
   
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
   
   #add-point:show段單身reference
   
   #end add-point
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adzi099.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzi099_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段control
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
 
{</section>}
 
{<section id="adzi099.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adzi099_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point  
 
   #add-point:set_no_entry_b段control
   
   #end add-point       
                                                                                
END FUNCTION  
 
{</section>}
 
{<section id="adzi099.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adzi099_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " dzdu001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
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
 
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adzi099.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adzi099_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dzdu_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> 'dzdu_t' THEN
   
      #add-point:delete_b段刪除前
      
      #end add-point     
   
      DELETE FROM dzdu_t
       WHERE 
         dzdu001 = ps_keys_bak[1]
 
      #add-point:delete_b段刪除中
      
      #end add-point  
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      
      #add-point:delete_b段刪除後
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzi099.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adzi099_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "dzdu_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前
      
      #end add-point    
      INSERT INTO dzdu_t
                  (
                   dzdu001
                   ,dzdustus,dzdu002,dzdu007,dzdu008,dzdu009,dzdu005,dzdu003,dzdu004,dzdu006,dzduownid,dzduowndp,dzducrtid,dzducrtdp,dzducrtdt,dzdumodid,dzdumoddt) 
            VALUES(
                   ps_keys[1]
                   ,g_dzdu_d[l_ac].dzdustus,g_dzdu_d[l_ac].dzdu002,g_dzdu_d[l_ac].dzdu007,g_dzdu_d[l_ac].dzdu008,g_dzdu_d[l_ac].dzdu009,g_dzdu_d[l_ac].dzdu005, 
                       g_dzdu_d[l_ac].dzdu003,g_dzdu_d[l_ac].dzdu004,g_dzdu_d[l_ac].dzdu006,g_dzdu2_d[l_ac].dzduownid, 
                       g_dzdu2_d[l_ac].dzduowndp,g_dzdu2_d[l_ac].dzducrtid,g_dzdu2_d[l_ac].dzducrtdp, 
                       g_dzdu2_d[l_ac].dzducrtdt,g_dzdu2_d[l_ac].dzdumodid,g_dzdu2_d[l_ac].dzdumoddt) 
 
      #add-point:insert_b段新增中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dzdu_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzi099.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adzi099_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
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
   LET ls_group = "dzdu_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dzdu_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE dzdu_t 
         SET (dzdu001
              ,dzdustus,dzdu002,dzdu007,dzdu008,dzdu009,dzdu005,dzdu003,dzdu004,dzdu006,dzduownid,dzduowndp,dzducrtid,dzducrtdp,dzducrtdt,dzdumodid,dzdumoddt) 
              = 
             (ps_keys[1]
              ,g_dzdu_d[l_ac].dzdustus,g_dzdu_d[l_ac].dzdu002,g_dzdu_d[l_ac].dzdu007,g_dzdu_d[l_ac].dzdu008,g_dzdu_d[l_ac].dzdu009,g_dzdu_d[l_ac].dzdu005, 
                  g_dzdu_d[l_ac].dzdu003,g_dzdu_d[l_ac].dzdu004,g_dzdu_d[l_ac].dzdu006,g_dzdu2_d[l_ac].dzduownid, 
                  g_dzdu2_d[l_ac].dzduowndp,g_dzdu2_d[l_ac].dzducrtid,g_dzdu2_d[l_ac].dzducrtdp,g_dzdu2_d[l_ac].dzducrtdt, 
                  g_dzdu2_d[l_ac].dzdumodid,g_dzdu2_d[l_ac].dzdumoddt) 
         WHERE dzdu001 = ps_keys_bak[1]
      #add-point:update_b段修改中
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dzdu_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dzdu_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzi099.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adzi099_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL adzi099_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dzdu_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adzi099_bcl USING 
                                       g_dzdu_d[g_detail_idx].dzdu001
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adzi099_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adzi099.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adzi099_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adzi099_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzi099.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION adzi099_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "dzdustus"
      WHEN "s_detail2"
         LET ls_return = "dzdu001_2"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="adzi099.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:1)
#+ 給予pk_array內容
PRIVATE FUNCTION adzi099_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_dzdu_d[l_ac].dzdu001
   LET g_pk_array[1].column = 'dzdu001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="adzi099.state_change" >}
   
 
{</section>}
 
{<section id="adzi099.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adzi099.other_function" readonly="Y" >}

 
{</section>}
 
