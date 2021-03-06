#該程式已解開Section, 不再透過樣板產出!
{<section id="aslt500_01.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:1,PR版次:1) Build-000001
#+ 
#+ Filename...: aslt500_01
#+ Description: 商品資訊二維輸入
#+ Creator....: 05423(2016-06-29 17:06:51)
#+ Modifier...: 05423(2016-06-29 18:24:04) -SD/PR- 05423(2016-07-05 17:32:38)
 
{</section>}
 
{<section id="aslt500_01.global" >}
#應用 i02 樣板自動產生(Version:29)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_pmdn_d RECORD
       pmdn001 LIKE pmdn_t.pmdn001, 
   pmdn001_desc LIKE type_t.chr500, 
   pmdn006 LIKE pmdn_t.pmdn006, 
   pmdn006_desc LIKE type_t.chr500, 
   pmdn007 LIKE pmdn_t.pmdn007
       END RECORD
PRIVATE TYPE type_g_pmdn2_d RECORD
   l_item_name1   LIKE pmdn_t.pmdn002, 
   l_item_name2   LIKE type_t.chr100,
   l_item_name3   LIKE type_t.chr100,
   l_item_name4   LIKE type_t.chr100,
   l_item_name5   LIKE type_t.chr100,
   l_item1 LIKE type_t.num20_6, 
   l_item2 LIKE type_t.num20_6, 
   l_item3 LIKE type_t.num20_6, 
   l_item4 LIKE type_t.num20_6, 
   l_item5 LIKE type_t.num20_6, 
   l_item6 LIKE type_t.num20_6, 
   l_item7 LIKE type_t.num20_6, 
   l_item8 LIKE type_t.num20_6, 
   l_item9 LIKE type_t.num20_6, 
   l_item10 LIKE type_t.num20_6, 
   l_item_sum LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_pmdn3_d RECORD
       l_pmdn001_1 LIKE type_t.chr500, 
   l_pmdn001_1_desc LIKE type_t.chr500, 
   l_pmdn006_1 LIKE type_t.chr10, 
   l_pmdn006_1_desc LIKE type_t.chr500, 
   l_pmdn002_1 LIKE type_t.chr500, 
   l_pmdn002_2 LIKE type_t.chr500, 
   l_pmdn002_3 LIKE type_t.chr500, 
   l_pmdn002_4 LIKE type_t.chr500, 
   l_pmdn002_5 LIKE type_t.chr500, 
   l_item1_1 LIKE type_t.chr20, 
   l_item2_1 LIKE type_t.chr20, 
   l_item3_1 LIKE type_t.chr20, 
   l_item4_1 LIKE type_t.chr20, 
   l_item5_1 LIKE type_t.chr20, 
   l_item6_1 LIKE type_t.chr20, 
   l_item7_1 LIKE type_t.chr20, 
   l_item8_1 LIKE type_t.chr20, 
   l_item9_1 LIKE type_t.chr20, 
   l_item10_1 LIKE type_t.chr20,
   l_item_sum_1   LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master RECORD
   pmdn001     LIKE pmdn_t.pmdn001,
   l_cmd       LIKE type_t.chr10
END RECORD
DEFINE g_pmdn3_d_color DYNAMIC ARRAY OF RECORD
   c01         STRING,
   c02         STRING,
   c03         STRING,
   c04         STRING,
   c05         STRING,
   c06         STRING,
   c07         STRING,
   c08         STRING,
   c09         STRING,
   c10         STRING,
   c11         STRING,
   c12         STRING,
   c13         STRING,
   c14         STRING,
   c15         STRING,
   c16         STRING,
   c17         STRING,
   c18         STRING,
   c19         STRING,
   c20         STRING
END RECORD
DEFINE lc_array   DYNAMIC ARRAY WITH DIMENSION 2 OF INTEGER
DEFINE g_detail_idx2         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx3         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_max_title      LIKE type_t.num5
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmdn_d          DYNAMIC ARRAY OF type_g_pmdn_d #單身變數
DEFINE g_pmdn_d_t        type_g_pmdn_d                  #單身備份
DEFINE g_pmdn_d_o        type_g_pmdn_d                  #單身備份
DEFINE g_pmdn_d_mask_o   DYNAMIC ARRAY OF type_g_pmdn_d #單身變數
DEFINE g_pmdn_d_mask_n   DYNAMIC ARRAY OF type_g_pmdn_d #單身變數
DEFINE g_pmdn2_d   DYNAMIC ARRAY OF type_g_pmdn2_d
DEFINE g_pmdn2_d_t type_g_pmdn2_d
DEFINE g_pmdn2_d_o type_g_pmdn2_d
DEFINE g_pmdn2_d_mask_o DYNAMIC ARRAY OF type_g_pmdn2_d
DEFINE g_pmdn2_d_mask_n DYNAMIC ARRAY OF type_g_pmdn2_d
DEFINE g_pmdn3_d   DYNAMIC ARRAY OF type_g_pmdn3_d
DEFINE g_pmdn3_d_t type_g_pmdn3_d
DEFINE g_pmdn3_d_o type_g_pmdn3_d
DEFINE g_pmdn3_d_mask_o DYNAMIC ARRAY OF type_g_pmdn3_d
DEFINE g_pmdn3_d_mask_n DYNAMIC ARRAY OF type_g_pmdn3_d
 
      
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
 
{<section id="aslt500_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aslt500_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_pmdndocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"

   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_pmdndocno   LIKE pmdn_t.pmdndocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"

   #end add-point 
   LET g_forupd_sql = "SELECT pmdn001,pmdn006,pmdn007 FROM pmdn_t WHERE pmdnent=? AND pmdndocno=?  
       AND pmdnseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aslt500_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aslt500_01 WITH FORM cl_ap_formpath("asl","aslt500_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aslt500_01_init()   
 
   #進入選單 Menu (="N")
   CALL aslt500_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aslt500_01
 
   
   
 
   #add-point:離開前 name="main.exit"

   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aslt500_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aslt500_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible('l_item_name2,l_item_name3,l_item_name4,l_item_name5',FALSE)
   CALL cl_set_comp_visible('l_item1,l_item2,l_item3,l_item4,l_item5,l_item6,l_item7,l_item8,l_item9,l_item10',FALSE)   
   CALL cl_set_comp_visible('l_pmdn002_2,l_pmdn002_3,l_pmdn002_4,l_pmdn002_5',FALSE)
   CALL cl_set_comp_visible('l_item1_1,l_item2_1,l_item3_1,l_item4_1,l_item5_1,l_item6_1,l_item7_1,l_item8_1,l_item9_1,l_item10_1',FALSE)   
   LET g_max_title = NULL
   CALL aslt500_01_create_tmp()
   CALL cl_set_act_visible("modify,modify_detail", FALSE)
   DELETE FROM aslt500_01_tit_tmp
   DELETE FROM aslt500_01_val_tmp
   #end add-point
   
   CALL aslt500_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aslt500_01_ui_dialog()
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
   LET g_detail_idx2 = 1
   LET g_wc2 = ' 1=2 '
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmdn_d.clear()
         CALL g_pmdn2_d.clear()
         CALL g_pmdn3_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aslt500_01_init()
      END IF
   
#      CALL aslt500_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_pmdn_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aslt500_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
                  
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               CALL aslt500_01_title1_fill(g_pmdn_d[g_detail_idx].pmdn001)
               CALL aslt500_01_value1_fill(g_pmdn_d[g_detail_idx].pmdn001)
               CALL aslt500_01_b_fill2()   
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_pmdn2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body2.before_display"

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               #add-point:ui_dialog段before display2 name="ui_dialog.body2.before_display2"

               #end add-point
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aslt500_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
                  
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"

               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
         DISPLAY ARRAY g_pmdn3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body3.before_display"

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx3)
               #add-point:ui_dialog段before display2 name="ui_dialog.body3.before_display2"

               #end add-point
         
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx3
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx3 TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aslt500_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
                  
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row3"

               #end add-point
               
            #自訂ACTION(detail_show,page_3)
            
               
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
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            CALL DIALOG.setSelectionMode("s_detail3", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            CALL DIALOG.setArrayAttributes("s_detail3",g_pmdn3_d_color)
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aslt500_01_query()
               #add-point:ON ACTION query name="menu.query"

               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL aslt500_01_modify()
               #add-point:ON ACTION query name="menu.query"
 
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_pmdn_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_pmdn2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_pmdn3_d)
               LET g_export_id[3]   = "s_detail3"
 
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
            CALL aslt500_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aslt500_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aslt500_01_set_pk_array()
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
 
{<section id="aslt500_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aslt500_01_query()
   #add-point:query段define(客製用) name="query.define_customerization"

   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
#   DELETE FROM aslt500_01_tit_tmp
#   DELETE FROM aslt500_01_val_tmp
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_pmdn_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT BY NAME g_wc2 ON l_pmdn001
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            ON ACTION controlp INFIELD l_pmdn001
            #add-point:ON ACTION controlp INFIELD xcckcomp name="construct.c.xcckcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_pmdn001  #顯示到畫面上
            NEXT FIELD l_pmdn001                     #返回原欄位
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
   IF NOT cl_null(g_wc2) THEN
      CALL cl_replace_str(g_wc2,'l_pmdn001','imaa001') RETURNING g_wc2
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
    
   CALL aslt500_01_b_fill(g_wc2)
   
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
 
{<section id="aslt500_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION aslt500_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aslt500_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION aslt500_01_modify()
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
   DEFINE  l_upd_sql             STRING
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   IF cl_null(g_pmdn_d[g_detail_idx].pmdn001) THEN RETURN END IF
   #end add-point
   
   LET g_action_choice = ""
   
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
 
      #S_DETAIL1 DISPLAY ONLY 故mark掉
#      #Page1 預設值產生於此處
#      INPUT ARRAY g_pmdn_d FROM s_detail1.*
#          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
#                  INSERT ROW = , 
#                  DELETE ROW = ,
#                  APPEND ROW = )
# 
#         #自訂ACTION(detail_input,page_1)
#         
#         
#         BEFORE INPUT
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_pmdn_d.getLength()+1) 
#              LET g_insert = 'N' 
#           END IF 
# 
#            CALL aslt500_01_b_fill(g_wc2)
#            LET g_detail_cnt = g_pmdn_d.getLength()
#         
#         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"

            #end add-point  
#            LET l_insert = FALSE
#            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#            LET l_cmd = ''
#            LET l_ac_t = l_ac 
#            LET l_ac = g_detail_idx
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#            DISPLAY g_pmdn_d.getLength() TO FORMONLY.cnt
#         
#            CALL s_transaction_begin()
#            LET g_detail_cnt = g_pmdn_d.getLength()
#            
#            IF g_detail_cnt >= l_ac 
#               AND g_pmdn_d[l_ac].pmdndocno IS NOT NULL
#               AND g_pmdn_d[l_ac].pmdnseq IS NOT NULL
# 
#            THEN
#               LET l_cmd='u'
#               LET g_pmdn_d_t.* = g_pmdn_d[l_ac].*  #BACKUP
#               LET g_pmdn_d_o.* = g_pmdn_d[l_ac].*  #BACKUP
#               IF NOT aslt500_01_lock_b("pmdn_t") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH aslt500_01_bcl INTO g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007, 
#                      g_pmdn2_d[l_ac].pmdn002
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_pmdn_d_t.pmdndocno,":",SQLERRMESSAGE  
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  #遮罩相關處理
#                  LET g_pmdn_d_mask_o[l_ac].* =  g_pmdn_d[l_ac].*
#                  CALL aslt500_01_pmdn_t_mask()
#                  LET g_pmdn_d_mask_n[l_ac].* =  g_pmdn_d[l_ac].*
#                  
#                  CALL aslt500_01_detail_show()
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#            CALL aslt500_01_set_entry_b(l_cmd)
#            CALL aslt500_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
#        
#         BEFORE INSERT
#            
#            LET l_insert = TRUE
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_pmdn_d_t.* TO NULL
#            INITIALIZE g_pmdn_d_o.* TO NULL
#            INITIALIZE g_pmdn_d[l_ac].* TO NULL 
#            #公用欄位給值(單身)
#            
#            #自定義預設值(單身3)
#                  LET g_pmdn_d[l_ac].pmdn007 = "0"
# 
            #add-point:modify段before備份 name="input.body.before_bak"

            #end add-point
#            LET g_pmdn_d_t.* = g_pmdn_d[l_ac].*     #新輸入資料
#            LET g_pmdn_d_o.* = g_pmdn_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_pmdn_d[li_reproduce_target].* = g_pmdn_d[li_reproduce].*
#               LET g_pmdn2_d[li_reproduce_target].* = g_pmdn2_d[li_reproduce].*
#               LET g_pmdn3_d[li_reproduce_target].* = g_pmdn3_d[li_reproduce].*
# 
#               LET g_pmdn_d[g_pmdn_d.getLength()].pmdndocno = NULL
#               LET g_pmdn_d[g_pmdn_d.getLength()].pmdnseq = NULL
# 
#            END IF
#            
# 
# 
# 
            #add-point:modify段before insert name="input.body.before_insert"

            #end add-point  
#  
#         AFTER INSERT
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#               
#            LET l_count = 1  
#            SELECT COUNT(1) INTO l_count FROM pmdn_t 
#             WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdn_d[l_ac].pmdndocno
#                                       AND pmdnseq = g_pmdn_d[l_ac].pmdnseq
# 
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身新增前 name="input.body.b_insert"

               #end add-point
#            
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_pmdn_d[g_detail_idx].pmdndocno
#               LET gs_keys[2] = g_pmdn_d[g_detail_idx].pmdnseq
#               CALL aslt500_01_insert_b('pmdn_t',gs_keys,"'1'")
#                           
#               #add-point:單身新增後 name="input.body.a_insert"

               #end add-point
#            ELSE    
#               INITIALIZE g_pmdn_d[l_ac].* TO NULL
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'INSERT' 
#               LET g_errparam.code   = "std-00006" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CANCEL INSERT
#            END IF
# 
#            IF SQLCA.SQLcode  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CANCEL INSERT
#            ELSE
#               #先刷新資料
#               #CALL aslt500_01_b_fill(g_wc2)
#               #資料多語言用-增/改
#               
#               #add-point:input段-after_insert name="input.body.a_insert2"

#               #end add-point
#               ##ERROR 'INSERT O.K'
#               LET g_detail_cnt = g_detail_cnt + 1
#               
#               LET g_wc2 = g_wc2, " OR (pmdndocno = '", g_pmdn_d[l_ac].pmdndocno, "' "
#                                  ," AND pmdnseq = '", g_pmdn_d[l_ac].pmdnseq, "' "
# 
#                                  ,")"
#            END IF                
#              
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' THEN
#               LET l_cmd='d'
#            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"

               #end add-point   
#               
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = -263 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CANCEL DELETE
#               END IF
#               
               #add-point:單身刪除前 name="input.body.b_delete"

               #end add-point   
               
#               DELETE FROM pmdn_t
#                WHERE pmdnent = g_enterprise AND 
#                      pmdndocno = g_pmdn_d_t.pmdndocno
#                      AND pmdnseq = g_pmdn_d_t.pmdnseq
# 
#                      
               #add-point:單身刪除中 name="input.body.m_delete"

               #end add-point  
#                      
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CANCEL DELETE   
#               ELSE
#                  LET g_detail_cnt = g_detail_cnt-1
#                  
# 
# 
# 
                  #add-point:單身刪除後 name="input.body.a_delete"

                  #end add-point
#                  #修改歷程記錄(刪除)
#                  CALL aslt500_01_set_pk_array()
#                  IF NOT cl_log_modified_record('','') THEN 
#                  ELSE
#                  END IF
#               END IF 
#               CLOSE aslt500_01_bcl
               #add-point:單身關閉bcl name="input.body.close"

               #end add-point
#               LET l_count = g_pmdn_d.getLength()
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_pmdn_d_t.pmdndocno
#               LET gs_keys[2] = g_pmdn_d_t.pmdnseq
# 
#               #應用 a47 樣板自動產生(Version:4)
#      #刪除相關文件
#      CALL aslt500_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"

      #end add-point   
#      CALL cl_doc_remove()  
# 
# 
# 
# 
#            END IF 
#              
#         AFTER DELETE 
#            IF l_cmd <> 'd' THEN
#               #add-point:單身刪除後2 name="input.body.after_delete"

#               #end add-point
#                              CALL aslt500_01_delete_b('pmdn_t',gs_keys,"'1'")
#            END IF
#            #如果是最後一筆
#            IF l_ac = (g_pmdn_d.getLength() + 1) THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
#            #add-point:單身刪除後3 name="input.body.after_delete3"

            #end add-point
# 
#         
#         
# 
#         ON ROW CHANGE
#            IF INT_FLAG THEN
#               CLOSE aslt500_01_bcl
#               LET INT_FLAG = 0
#               LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               #add-point:單身取消時 name="input.body.cancel"

#               #end add-point
#               EXIT DIALOG 
#            END IF
#              
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = g_pmdn_d[l_ac].pmdndocno 
#               LET g_errparam.code   = -263 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*
#            ELSE
#               #寫入修改者/修改日期資訊(單身)
#               
#            
               #add-point:單身修改前 name="input.body.b_update"

               #end add-point
#               
#               #將遮罩欄位還原
#               CALL aslt500_01_pmdn_t_mask_restore('restore_mask_o')
# 
#               UPDATE pmdn_t SET (pmdn001,pmdn006,pmdn007,pmdn002) = (g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006, 
#                   g_pmdn_d[l_ac].pmdn007,g_pmdn2_d[l_ac].pmdn002)
#                WHERE pmdnent = g_enterprise AND
#                  pmdndocno = g_pmdn_d_t.pmdndocno #項次   
#                  AND pmdnseq = g_pmdn_d_t.pmdnseq  
# 
#                  
#               #add-point:單身修改中 name="input.body.m_update"

               #end add-point
#                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "pmdn_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_pmdn_d[g_detail_idx].pmdndocno
#               LET gs_keys_bak[1] = g_pmdn_d_t.pmdndocno
#               LET gs_keys[2] = g_pmdn_d[g_detail_idx].pmdnseq
#               LET gs_keys_bak[2] = g_pmdn_d_t.pmdnseq
#               CALL aslt500_01_update_b('pmdn_t',gs_keys,gs_keys_bak,"'1'")
#                     #資料多語言用-增/改
#                     
#                     #修改歷程記錄(修改)
#                     LET g_log1 = util.JSON.stringify(g_pmdn_d_t)
#                     LET g_log2 = util.JSON.stringify(g_pmdn_d[l_ac])
#                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                     END IF
#               END CASE
#               
#               #將遮罩欄位進行遮蔽
#               CALL aslt500_01_pmdn_t_mask_restore('restore_mask_n')
#               
               #add-point:單身修改後 name="input.body.a_update"

#               #end add-point
# 
#            END IF
#            
#         AFTER ROW
#            CALL aslt500_01_unlock_b("pmdn_t")
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET INT_FLAG = 0
#               IF l_cmd = 'u' THEN
#                  LET g_pmdn_d[l_ac].* = g_pmdn_d_t.*
#               END IF
               #add-point:單身after row name="input.body.a_close"

               #end add-point
#            ELSE
#            END IF
#            #其他table進行unlock
#            
             #add-point:單身after row name="input.body.a_row"

            #end add-point
#            
#         AFTER INPUT
#            #add-point:單身input後 name="input.body.a_input"

            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
#            
#         ON ACTION controlo   
#            IF l_insert THEN
#               LET li_reproduce = l_ac_t
#               LET li_reproduce_target = l_ac
#               LET g_pmdn_d[li_reproduce_target].* = g_pmdn_d[li_reproduce].*
#               LET g_pmdn2_d[li_reproduce_target].* = g_pmdn2_d[li_reproduce].*
#               LET g_pmdn3_d[li_reproduce_target].* = g_pmdn3_d[li_reproduce].*
# 
#               LET g_pmdn_d[li_reproduce_target].pmdndocno = NULL
#               LET g_pmdn_d[li_reproduce_target].pmdnseq = NULL
# 
#            ELSE
#               CALL FGL_SET_ARR_CURR(g_pmdn_d.getLength()+1)
#               LET lb_reproduce = TRUE
#               LET li_reproduce = l_ac
#               LET li_reproduce_target = g_pmdn_d.getLength()+1
#            END IF
#            
#      END INPUT
      
      INPUT ARRAY g_pmdn2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx2)
            
            CALL aslt500_01_b_fill(g_wc2)
            LET g_detail_cnt = g_pmdn2_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
#            NEXT FIELD pmdndocno
            NEXT FIELD l_item1
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmdn2_d[l_ac].* TO NULL 
            INITIALIZE g_pmdn2_d_t.* TO NULL
            INITIALIZE g_pmdn2_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_pmdn2_d[l_ac].l_item1 = "0"
      LET g_pmdn2_d[l_ac].l_item2 = "0"
      LET g_pmdn2_d[l_ac].l_item3 = "0"
      LET g_pmdn2_d[l_ac].l_item4 = "0"
      LET g_pmdn2_d[l_ac].l_item5 = "0"
      LET g_pmdn2_d[l_ac].l_item6 = "0"
      LET g_pmdn2_d[l_ac].l_item7 = "0"
      LET g_pmdn2_d[l_ac].l_item8 = "0"
      LET g_pmdn2_d[l_ac].l_item9 = "0"
      LET g_pmdn2_d[l_ac].l_item10 = "0"
      LET g_pmdn2_d[l_ac].l_item_sum = "0"
 
            #add-point:modify段before備份 name="input.body2.before_bak"

            #end add-point
            LET g_pmdn2_d_t.* = g_pmdn2_d[l_ac].*     #新輸入資料
            LET g_pmdn2_d_o.* = g_pmdn2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmdn_d[li_reproduce_target].* = g_pmdn_d[li_reproduce].*
               LET g_pmdn2_d[li_reproduce_target].* = g_pmdn2_d[li_reproduce].*
               LET g_pmdn3_d[li_reproduce_target].* = g_pmdn3_d[li_reproduce].*
# 
#               LET g_pmdn2_d[li_reproduce_target].pmdndocno = NULL
#               LET g_pmdn2_d[li_reproduce_target].pmdnseq = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body2.before_insert"

            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body2.before_row2"

            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx2
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_pmdn2_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_pmdn2_d.getLength()
            LET l_cmd='u'
#            IF g_detail_cnt >= l_ac 
#               AND g_pmdn2_d[l_ac].pmdndocno IS NOT NULL
#               AND g_pmdn2_d[l_ac].pmdnseq IS NOT NULL
#            THEN 
#               LET l_cmd='u'
#               LET g_pmdn2_d_t.* = g_pmdn2_d[l_ac].*  #BACKUP
#               LET g_pmdn2_d_o.* = g_pmdn2_d[l_ac].*  #BACKUP
#               IF NOT aslt500_01_lock_b("pmdn_t") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH aslt500_01_bcl INTO g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = SQLERRMESSAGE 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  #遮罩相關處理
#                  LET g_pmdn2_d_mask_o[l_ac].* =  g_pmdn2_d[l_ac].*
#                  CALL aslt500_01_pmdn_t_mask()
#                  LET g_pmdn2_d_mask_n[l_ac].* =  g_pmdn2_d[l_ac].*
#                  
#                  CALL cl_show_fld_cont()
#                  CALL aslt500_01_detail_show()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
            CALL aslt500_01_set_entry_b(l_cmd)
            CALL aslt500_01_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body2.before_row"
            LET g_pmdn2_d_t.* = g_pmdn2_d[l_ac].*  #BACKUP
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前 name="input.body2.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"

               #end add-point 
               
#               DELETE FROM pmdn_t
#                WHERE pmdnent = g_enterprise AND
#                  pmdndocno = g_pmdn2_d_t.pmdndocno
#                  AND pmdnseq = g_pmdn2_d_t.pmdnseq
                  
               #add-point:單身2刪除中 name="input.body2.m_delete"

               #end add-point 
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
                  #add-point:單身2刪除後 name="input.body2.a_delete"

                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aslt500_01_set_pk_array()
                  IF NOT cl_log_modified_record('','') THEN 
                  ELSE
                  END IF
               END IF 
               CLOSE aslt500_01_bcl
               #add-point:單身2刪除關閉bcl name="input.body2.close"

               #end add-point
               LET l_count = g_pmdn_d.getLength()
                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_pmdn2_d_t.pmdndocno
#               LET gs_keys[2] = g_pmdn2_d_t.pmdnseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aslt500_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body2.after_delete"

               #end add-point
                              CALL aslt500_01_delete_b('pmdn_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_pmdn2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body2.after_delete3"

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
#               
#            LET l_count = 1  
#            SELECT COUNT(1) INTO l_count FROM pmdn_t 
#             WHERE pmdnent = g_enterprise AND
#                   pmdndocno = g_pmdn2_d[l_ac].pmdndocno
#                   AND pmdnseq = g_pmdn2_d[l_ac].pmdnseq
#                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
 
               #end add-point
#            
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_pmdn2_d[g_detail_idx].pmdndocno
#               LET gs_keys[2] = g_pmdn2_d[g_detail_idx].pmdnseq
#               CALL aslt500_01_insert_b('pmdn_t',gs_keys,"'2'")
#                           
               #add-point:單身新增後2 name="input.body2.a_insert"

               #end add-point
            ELSE    
               INITIALIZE g_pmdn_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aslt500_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"

               #end add-point
#               ##ERROR 'INSERT O.K'
#               LET g_detail_cnt = g_detail_cnt + 1
#               LET g_wc2 = g_wc2, " OR (pmdndocno = '", g_pmdn2_d[l_ac].pmdndocno, "' "
#                                  ," AND pmdnseq = '", g_pmdn2_d[l_ac].pmdnseq, "' "
#                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_pmdn2_d[l_ac].* = g_pmdn2_d_t.*
               CLOSE aslt500_01_bcl
               #add-point:單身page2取消後 name="input.body2.cancel"

               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_pmdn2_d[l_ac].* = g_pmdn2_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前 name="input.body2.b_update"
               #修改内容写入暂存档
               LET l_upd_sql = " UPDATE aslt500_01_val_tmp SET "
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item1) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," l_item1 = ",g_pmdn2_d[l_ac].l_item1
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item2) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item2 = ",g_pmdn2_d[l_ac].l_item2
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item3) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item3 = ",g_pmdn2_d[l_ac].l_item3
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item4) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item4 = ",g_pmdn2_d[l_ac].l_item4
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item5) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item5 = ",g_pmdn2_d[l_ac].l_item5
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item6) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item6 = ",g_pmdn2_d[l_ac].l_item6
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item7) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item7 = ",g_pmdn2_d[l_ac].l_item7
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item8) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item8 = ",g_pmdn2_d[l_ac].l_item8
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item9) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item9 = ",g_pmdn2_d[l_ac].l_item9
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item10) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item10 = ",g_pmdn2_d[l_ac].l_item10
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item_sum) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED," , l_item_sum = ",g_pmdn2_d[l_ac].l_item_sum
               END IF
               LET l_upd_sql = l_upd_sql CLIPPED,                " WHERE l_pmdn001 = '",g_pmdn_d[g_detail_idx].pmdn001,"' "
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item_name1) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED, "  AND l_item_name1 = '",g_pmdn2_d[l_ac].l_item_name1,"' "
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item_name2) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED, "  AND l_item_name2 = '",g_pmdn2_d[l_ac].l_item_name2,"' "
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item_name3) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED, "  AND l_item_name3 = '",g_pmdn2_d[l_ac].l_item_name3,"' "
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item_name4) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED, "  AND l_item_name4 = '",g_pmdn2_d[l_ac].l_item_name4,"' "
               END IF
               IF NOT cl_null(g_pmdn2_d[l_ac].l_item_name5) THEN
                  LET l_upd_sql = l_upd_sql CLIPPED, "  AND l_item_name5 = '",g_pmdn2_d[l_ac].l_item_name5,"' "
               END IF
               PREPARE l_pmdn2_d_pre FROM l_upd_sql
               EXECUTE l_pmdn2_d_pre
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "value_tmp" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "value_tmp:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
               END CASE
               CALL s_transaction_end('Y','0')
#               EXECUTE IMMEDIATE l_upd_sql
#               AND l_item_name1 =  g_pmdn2_d[l_ac].l_item_name1              
#                 AND l_item_name2 =  g_pmdn2_d[l_ac].l_item_name2              
#                 AND l_item_name3 =  g_pmdn2_d[l_ac].l_item_name3              
#                 AND l_item_name4 =  g_pmdn2_d[l_ac].l_item_name4              
#                 AND l_item_name5 =  g_pmdn2_d[l_ac].l_item_name5              
               #end add-point
               
               #將遮罩欄位還原
#               CALL aslt500_01_pmdn_t_mask_restore('restore_mask_o')
               
#               UPDATE pmdn_t SET (pmdn001,pmdn006,pmdn007,pmdn002) = (g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006, 
#                   g_pmdn_d[l_ac].pmdn007,g_pmdn2_d[l_ac].pmdn002) #自訂欄位頁簽
#                WHERE pmdnent = g_enterprise AND
#                  pmdndocno = g_pmdn2_d_t.pmdndocno #項次 
#                  AND pmdnseq = g_pmdn2_d_t.pmdnseq
                  
               #add-point:單身page2修改中 name="input.body2.m_update"

               #end add-point
                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "pmdn_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_pmdn2_d[g_detail_idx].pmdndocno
#               LET gs_keys_bak[1] = g_pmdn2_d_t.pmdndocno
#               LET gs_keys[2] = g_pmdn2_d[g_detail_idx].pmdnseq
#               LET gs_keys_bak[2] = g_pmdn2_d_t.pmdnseq
#               CALL aslt500_01_update_b('pmdn_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
#                     
#                     #修改歷程記錄(修改)
#                     LET g_log1 = util.JSON.stringify(g_pmdn2_d_t)
#                     LET g_log2 = util.JSON.stringify(g_pmdn2_d[l_ac])
#                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                     END IF
#               END CASE
#               
               #將遮罩欄位進行遮蔽
#               CALL aslt500_01_pmdn_t_mask_restore('restore_mask_n')
               
               #add-point:單身page2修改後 name="input.body2.a_update"

               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item1,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item1
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item1 name="input.a.page2.l_item1"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item1) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item1
            #add-point:BEFORE FIELD l_item1 name="input.b.page2.l_item1"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item1
            #add-point:ON CHANGE l_item1 name="input.g.page2.l_item1"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item2
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item2,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item2
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item2 name="input.a.page2.l_item2"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item2) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item2
            #add-point:BEFORE FIELD l_item2 name="input.b.page2.l_item2"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item2
            #add-point:ON CHANGE l_item2 name="input.g.page2.l_item2"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item3
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item3,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item3
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item3 name="input.a.page2.l_item3"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item3) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item3
            #add-point:BEFORE FIELD l_item3 name="input.b.page2.l_item3"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item3
            #add-point:ON CHANGE l_item3 name="input.g.page2.l_item3"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item4
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item4,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item4
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item4 name="input.a.page2.l_item4"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item4) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item4
            #add-point:BEFORE FIELD l_item4 name="input.b.page2.l_item4"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item4
            #add-point:ON CHANGE l_item4 name="input.g.page2.l_item4"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item5
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item5,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item5
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item5 name="input.a.page2.l_item5"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item5) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item5
            #add-point:BEFORE FIELD l_item5 name="input.b.page2.l_item5"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item5
            #add-point:ON CHANGE l_item5 name="input.g.page2.l_item5"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item6
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item6,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item6
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item6 name="input.a.page2.l_item6"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item6) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item6
            #add-point:BEFORE FIELD l_item6 name="input.b.page2.l_item6"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item6
            #add-point:ON CHANGE l_item6 name="input.g.page2.l_item6"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item7
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item7,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item7
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item7 name="input.a.page2.l_item7"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item7) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item7
            #add-point:BEFORE FIELD l_item7 name="input.b.page2.l_item7"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item7
            #add-point:ON CHANGE l_item7 name="input.g.page2.l_item7"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item8
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item8,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item8
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item8 name="input.a.page2.l_item8"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item8) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item8
            #add-point:BEFORE FIELD l_item8 name="input.b.page2.l_item8"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item8
            #add-point:ON CHANGE l_item8 name="input.g.page2.l_item8"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item9
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item9,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item9
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item9 name="input.a.page2.l_item9"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item9) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item9
            #add-point:BEFORE FIELD l_item9 name="input.b.page2.l_item9"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item9
            #add-point:ON CHANGE l_item9 name="input.g.page2.l_item9"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_item10
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdn2_d[l_ac].l_item10,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD l_item10
            END IF 
 
 
 
            #add-point:AFTER FIELD l_item10 name="input.a.page2.l_item10"
            IF NOT cl_null(g_pmdn2_d[l_ac].l_item10) THEN 
               CALL aslt500_01_value1_sum()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_item10
            #add-point:BEFORE FIELD l_item10 name="input.b.page2.l_item10"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_item10
            #add-point:ON CHANGE l_item10 name="input.g.page2.l_item10"

            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.l_item1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item1
            #add-point:ON ACTION controlp INFIELD l_item1 name="input.c.page2.l_item1"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item2
            #add-point:ON ACTION controlp INFIELD l_item2 name="input.c.page2.l_item2"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item3
            #add-point:ON ACTION controlp INFIELD l_item3 name="input.c.page2.l_item3"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item4
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item4
            #add-point:ON ACTION controlp INFIELD l_item4 name="input.c.page2.l_item4"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item5
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item5
            #add-point:ON ACTION controlp INFIELD l_item5 name="input.c.page2.l_item5"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item6
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item6
            #add-point:ON ACTION controlp INFIELD l_item6 name="input.c.page2.l_item6"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item7
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item7
            #add-point:ON ACTION controlp INFIELD l_item7 name="input.c.page2.l_item7"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item8
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item8
            #add-point:ON ACTION controlp INFIELD l_item8 name="input.c.page2.l_item8"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item9
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item9
            #add-point:ON ACTION controlp INFIELD l_item9 name="input.c.page2.l_item9"

            #END add-point
 
 
         #Ctrlp:input.c.page2.l_item10
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_item10
            #add-point:ON ACTION controlp INFIELD l_item10 name="input.c.page2.l_item10"

            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pmdn2_d[l_ac].* = g_pmdn2_d_t.*
               END IF
               CLOSE aslt500_01_bcl
               #add-point:單身after row name="input.body2.a_close"
               CALL aslt500_01_value1_sum()
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL aslt500_01_unlock_b("pmdn_t")
            #add-point:單身after row name="input.body2.a_row"

            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後 name="input.body2.a_input"
            CALL aslt500_01_b_fill(g_wc2)
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_pmdn_d[li_reproduce_target].* = g_pmdn_d[li_reproduce].*
               LET g_pmdn2_d[li_reproduce_target].* = g_pmdn2_d[li_reproduce].*
               LET g_pmdn3_d[li_reproduce_target].* = g_pmdn3_d[li_reproduce].*
 
#               LET g_pmdn2_d[li_reproduce_target].pmdndocno = NULL
#               LET g_pmdn2_d[li_reproduce_target].pmdnseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmdn2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmdn2_d.getLength()+1
            END IF
      END INPUT
 
      
      DISPLAY ARRAY g_pmdn3_d TO s_detail3.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aslt500_01_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx3
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx3 TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page3自定義行為 name="input.body3.action"
         CALL DIALOG.setArrayAttributes("s_detail3",g_pmdn3_d_color)
         #end add-point
            
      END DISPLAY
 
      
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
         CALL DIALOG.setArrayAttributes("s_detail3",g_pmdn3_d_color)
         NEXT FIELD l_item1
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD pmdn001
            WHEN "s_detail2"
               NEXT FIELD pmdn002
            WHEN "s_detail3"
               NEXT FIELD l_pmdn001_1
 
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
#      IF INT_FLAG OR cl_null(g_pmdn_d[g_detail_idx].pmdndocno) THEN
      IF INT_FLAG THEN
         CALL g_pmdn_d.deleteElement(g_detail_idx)
         CALL g_pmdn2_d.deleteElement(g_detail_idx2)
         CALL g_pmdn3_d.deleteElement(g_detail_idx3)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_pmdn_d[g_detail_idx].* = g_pmdn_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"

   #end add-point
 
   CLOSE aslt500_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aslt500_01_delete()
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
   FOR li_idx = 1 TO g_pmdn_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aslt500_01_lock_b("pmdn_t") THEN
            #已被他人鎖定
            RETURN
         END IF
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"

   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
#   FOR li_idx = 1 TO g_pmdn_d.getLength()
#      IF g_pmdn_d[li_idx].pmdndocno IS NOT NULL
#         AND g_pmdn_d[li_idx].pmdnseq IS NOT NULL
# 
#         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"

         #end add-point   
#         
#         DELETE FROM pmdn_t
#          WHERE pmdnent = g_enterprise AND 
#                pmdndocno = g_pmdn_d[li_idx].pmdndocno
#                AND pmdnseq = g_pmdn_d[li_idx].pmdnseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"

         #end add-point  
#                
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            RETURN
#         ELSE
#            LET g_detail_cnt = g_detail_cnt-1
#            LET l_ac = li_idx
#            
 
 
 
            
 
 
 
            
 
 
 
 
            
 
 
 
            
 
 
 
            
 
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"

            #end add-point
#            LET g_detail_idx = li_idx
#                           INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_pmdn_d_t.pmdndocno
#               LET gs_keys[2] = g_pmdn_d_t.pmdnseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"

            #end add-point
#                           CALL aslt500_01_delete_b('pmdn_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"

            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
#      CALL aslt500_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"

      #end add-point   
#      CALL cl_doc_remove()  
 
 
 
# 
#            
#         END IF 
#      END IF 
#    
#   END FOR
#   
#   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"

   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL aslt500_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aslt500_01_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"

   #end add-point
   DEFINE p_wc2    STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql    STRING
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   DISPLAY p_wc2
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
 
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.pmdn001,t0.pmdn006,t0.pmdn007,",#t0.pmdn002 ,
       "t1.imaal003 ,t2.oocal003 , 
       t3.imaal003 ,t4.oocal003 FROM pmdn_t t0",
               "",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.pmdn001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent='"||g_enterprise||"' AND t2.oocal001=t0.pmdn006 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=t0.pmdn001 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent='"||g_enterprise||"' AND t4.oocal001=t0.pmdn006 AND t4.oocal002='"||g_dlang||"' ",
 
               " WHERE t0.pmdnent= ?  AND  1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"

   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("pmdn_t"),
                      " ORDER BY t0.pmdndocno,t0.pmdnseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   LET g_sql = "SELECT  DISTINCT t0.imaa001,t0.imaa006,",#t0.pmdn002 ,
       "(SELECT SUM(NVL(l_item_sum,0)) FROM aslt500_01_val_tmp WHERE l_pmdn001 = t0.imaa001) t0_pmdn007,",
       "t1.imaal003 ,t2.oocal003 , 
       t3.imaal003 ,t4.oocal003 FROM imaa_t t0",
               "",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.imaa001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent='"||g_enterprise||"' AND t2.oocal001=t0.imaa006 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=t0.imaa001 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent='"||g_enterprise||"' AND t4.oocal001=t0.imaa006 AND t4.oocal002='"||g_dlang||"' ",
 
               " WHERE t0.imaaent= ?  AND  1=1 AND (", p_wc2, ") " ,
               " ORDER BY t0.imaa001 "
   LET g_temp_idx = g_detail_idx               
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmdn_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aslt500_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aslt500_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_pmdn_d.clear()
   CALL g_pmdn2_d.clear()   
   CALL g_pmdn3_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007,#g_pmdn2_d[l_ac].pmdn002, 
       g_pmdn_d[l_ac].pmdn001_desc,g_pmdn_d[l_ac].pmdn006_desc,g_pmdn3_d[l_ac].l_pmdn001_1_desc,g_pmdn3_d[l_ac].l_pmdn006_1_desc 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
#      #查询产品特征，并填充第二页签
#      LET g_detail_idx = l_ac
#      CALL aslt500_01_title1_fill(g_pmdn_d[g_detail_idx].pmdn001)
#      CALL aslt500_01_value1_fill(g_pmdn_d[g_detail_idx].pmdn001)
##      CALL aslt500_01_title1_fill(g_pmdn_d[l_ac].pmdn001)
##      CALL aslt500_01_title2_fill(g_pmdn_d[l_ac].pmdn001)
      #end add-point
      
      CALL aslt500_01_detail_show()      
 
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
   
 
   
   CALL g_pmdn_d.deleteElement(g_pmdn_d.getLength())   
   CALL g_pmdn2_d.deleteElement(g_pmdn2_d.getLength())
   CALL g_pmdn3_d.deleteElement(g_pmdn3_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_pmdn_d.getLength()
#      LET g_pmdn2_d[l_ac].pmdndocno = g_pmdn_d[l_ac].pmdndocno 
#      LET g_pmdn2_d[l_ac].pmdnseq = g_pmdn_d[l_ac].pmdnseq 
#      LET g_pmdn3_d[l_ac].pmdndocno = g_pmdn_d[l_ac].pmdndocno 
#      LET g_pmdn3_d[l_ac].pmdnseq = g_pmdn_d[l_ac].pmdnseq 
# 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      #查询产品特征，并填充第二页签
      LET g_detail_idx = l_ac
      CALL aslt500_01_title1_fill(g_pmdn_d[g_detail_idx].pmdn001)
      CALL aslt500_01_value1_fill(g_pmdn_d[g_detail_idx].pmdn001)
#      CALL aslt500_01_b_fill2()
      #end add-point
   END FOR
   
   IF g_cnt > g_pmdn_d.getLength() THEN
      LET l_ac = g_pmdn_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmdn_d.getLength()
      LET g_pmdn_d_mask_o[l_ac].* =  g_pmdn_d[l_ac].*
      CALL aslt500_01_pmdn_t_mask()
      LET g_pmdn_d_mask_n[l_ac].* =  g_pmdn_d[l_ac].*
   END FOR
   
   LET g_pmdn2_d_mask_o.* =  g_pmdn2_d.*
   FOR l_ac = 1 TO g_pmdn2_d.getLength()
      LET g_pmdn2_d_mask_o[l_ac].* =  g_pmdn2_d[l_ac].*
      CALL aslt500_01_pmdn_t_mask()
      LET g_pmdn2_d_mask_n[l_ac].* =  g_pmdn2_d[l_ac].*
   END FOR
   LET g_pmdn3_d_mask_o.* =  g_pmdn3_d.*
   FOR l_ac = 1 TO g_pmdn3_d.getLength()
      LET g_pmdn3_d_mask_o[l_ac].* =  g_pmdn3_d[l_ac].*
      CALL aslt500_01_pmdn_t_mask()
      LET g_pmdn3_d_mask_n[l_ac].* =  g_pmdn3_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_detail_idx = g_temp_idx
   CALL aslt500_01_title1_fill(g_pmdn_d[g_detail_idx].pmdn001)
   CALL aslt500_01_value1_fill(g_pmdn_d[g_detail_idx].pmdn001)
   CALL aslt500_01_b_fill2()   
   IF g_pmdn2_d.getLength()>0 THEN
      CALL cl_set_act_visible("modify,modify_detail", TRUE)
   END IF
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_pmdn_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aslt500_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aslt500_01_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
   #帶出公用欄位reference值page3
   
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
   #add-point:show段單身reference name="detail_show.body3.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aslt500_01_set_entry_b(p_cmd)                                                  
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
 
{<section id="aslt500_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aslt500_01_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aslt500_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aslt500_01_default_search()
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
      LET ls_wc = ls_wc, " pmdndocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " pmdnseq = '", g_argv[02], "' AND "
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
 
{<section id="aslt500_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aslt500_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "pmdn_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'pmdn_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM pmdn_t
          WHERE pmdnent = g_enterprise AND
            pmdndocno = ps_keys_bak[1] AND pmdnseq = ps_keys_bak[2]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmdn_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_pmdn2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_pmdn3_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aslt500_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "pmdn_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"

      #end add-point    
#      INSERT INTO pmdn_t
#                  (pmdnent,
#                   pmdndocno,pmdnseq
#                   ,pmdn001,pmdn006,pmdn007,pmdn002) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2]
#                   ,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007,g_pmdn2_d[l_ac].pmdn002) 
#
      #add-point:insert_b段新增中 name="insert_b.m_insert"

      #end add-point    
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
#      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"

      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aslt500_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "pmdn_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "pmdn_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"

      #end add-point     
#      UPDATE pmdn_t 
#         SET (pmdndocno,pmdnseq
#              ,pmdn001,pmdn006,pmdn007,pmdn002) 
#              = 
#             (ps_keys[1],ps_keys[2]
#              ,g_pmdn_d[l_ac].pmdn001,g_pmdn_d[l_ac].pmdn006,g_pmdn_d[l_ac].pmdn007,g_pmdn2_d[l_ac].pmdn002)  
#
#         WHERE pmdndocno = ps_keys_bak[1] AND pmdnseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"

      #end add-point 
#      CASE
#         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "pmdn_t" 
#            LET g_errparam.code   = "std-00009" 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#         WHEN SQLCA.sqlcode #其他錯誤
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "pmdn_t:",SQLERRMESSAGE 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#         OTHERWISE
#            
#      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"

      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aslt500_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"

   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"

   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"

   #end add-point
   
   #先刷新資料
   #CALL aslt500_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "pmdn_t"
#   
#   IF ls_group.getIndexOf(ps_table,1) THEN
#   
#      OPEN aslt500_01_bcl USING g_enterprise,
#                                       g_pmdn_d[g_detail_idx].pmdndocno,g_pmdn_d[g_detail_idx].pmdnseq 
#
#                                       
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "aslt500_01_bcl:",SQLERRMESSAGE 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         RETURN FALSE
#      END IF
#   
#   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aslt500_01_unlock_b(ps_table)
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
      CLOSE aslt500_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aslt500_01_modify_detail_chk(ps_record)
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
         LET ls_return = "pmdn001"
      WHEN "s_detail2"
         LET ls_return = "pmdn002"
      WHEN "s_detail3"
         LET ls_return = "l_pmdn001_1"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aslt500_01.mask_functions" >}
&include "erp/asl/aslt500_01_mask.4gl"
 
{</section>}
 
{<section id="aslt500_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aslt500_01_set_pk_array()
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
   
#   CALL g_pk_array.clear()
#   LET g_pk_array[1].values = g_pmdn_d[l_ac].pmdndocno
#   LET g_pk_array[1].column = 'pmdndocno'
#   LET g_pk_array[2].values = g_pmdn_d[l_ac].pmdnseq
#   LET g_pk_array[2].column = 'pmdnseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"

   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aslt500_01.state_change" >}
   
 
{</section>}
 
{<section id="aslt500_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aslt500_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 填充二维输入页签的title
# Memo...........:
# Usage..........: CALL aslt500_01_title1_fill(p_pmdn001)
#                  RETURNING 回传参数
# Date & Author..: 2016-6-30 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION aslt500_01_title1_fill(p_pmdn001)
DEFINE p_pmdn001  LIKE pmdn_t.pmdn001
DEFINE l_imea001  LIKE imea_t.imea001
DEFINE l_imeb002  LIKE imeb_t.imeb002
DEFINE l_imeb004  LIKE imeb_t.imeb004
DEFINE l_imeb004_desc  LIKE type_t.chr100
DEFINE l_sql      STRING
DEFINE l_select   STRING
DEFINE l_from   STRING
DEFINE l_where   STRING
DEFINE l_order   STRING
DEFINE l_item_sql STRING
DEFINE l_cnt      LIKE type_t.num10
DEFINE l_ac       LIKE type_t.num10
DEFINE l_flag     LIKE type_t.chr2     #用来记录是否有特征值
DEFINE l_imec_d   DYNAMIC ARRAY OF RECORD
   l_imec001   LIKE imec_t.imec001,
   l_imec002   LIKE imec_t.imec002,
   l_imec003   LIKE imec_t.imec003,
   l_imecl005  LIKE type_t.chr100
END RECORD
DEFINE l_imeb_d   DYNAMIC ARRAY OF RECORD
   l_imeb001   LIKE imeb_t.imeb001,
   l_imeb002   LIKE imeb_t.imeb002,
   l_imeb004   LIKE imeb_t.imeb004,
   l_imeb004_desc   LIKE type_t.chr100
END RECORD
DEFINE l_item_d RECORD
   l_pmdn001      LIKE pmdn_t.pmdn001,
   l_item_name1   LIKE type_t.chr100,
   l_item_name2   LIKE type_t.chr100,
   l_item_name3   LIKE type_t.chr100,
   l_item_name4   LIKE type_t.chr100,
   l_item_name5   LIKE type_t.chr100,
   l_item1   LIKE type_t.chr100,
   l_item2   LIKE type_t.chr100,
   l_item3   LIKE type_t.chr100,
   l_item4   LIKE type_t.chr100,
   l_item5   LIKE type_t.chr100,
   l_item6   LIKE type_t.chr100,
   l_item7   LIKE type_t.chr100,
   l_item8   LIKE type_t.chr100,
   l_item9   LIKE type_t.chr100,
   l_item10   LIKE type_t.chr100
END RECORD

   IF cl_null(p_pmdn001) THEN
      RETURN
   END IF
   CALL cl_set_comp_visible('l_item_name2,l_item_name3,l_item_name4,l_item_name5',FALSE)
   CALL cl_set_comp_visible('l_item1,l_item2,l_item3,l_item4,l_item5,l_item6,l_item7,l_item8,l_item9,l_item10',FALSE)   
   
   #获取特征组别
   LET l_imea001 = NULL
   LET l_imeb002 = NULL
   LET l_imeb004 = NULL
   LET l_flag = 'N'
   SELECT imaa005 INTO l_imea001
     FROM imaa_t
    WHERE imaa001 = p_pmdn001
      AND imaaent = g_enterprise
   IF cl_null(l_imea001) THEN RETURN END IF
   #根据特征组别，获取二维录入的特征-只有一个，横向延伸
   SELECT DISTINCT imeb002,imeb004,oocql004
     INTO l_imeb002,l_imeb004,l_imeb004_desc
     FROM imeb_t LEFT OUTER JOIN oocql_t ON oocql001 = '273' AND oocql002 = imeb004 AND oocql003 = g_dlang
    WHERE imeb001 = l_imea001
      AND imebent = g_enterprise
      AND imeb003 = '2'
      AND imeb012 = 'Y'
      AND imeb005 = '2'   #非固定值
   IF cl_null(l_imeb002) THEN #无二维输入特征
      CALL cl_set_comp_visible('l_item1',TRUE)
      CALL cl_set_comp_att_text('l_item1','数量')
      IF cl_null(g_max_title) THEN LET g_max_title = 1 END IF  #设定画面显示的栏位数
   ELSE
      #获取二维输入的特征值个数，并将特征值，特征值说明存入暂存档
      LET l_cnt = 1
      CALL l_imec_d.clear()
      LET l_sql = " SELECT DISTINCT imec001,imec002,imec003,imecl005 ",
                  " FROM imec_t ",
                  " LEFT OUTER JOIN imecl_t ON imeclent = imecent AND imecl001 = imec001 AND imecl002 = imec002 AND imecl003 = imec003 AND imecl004 = '",g_dlang,"' ",
                  " WHERE imec001 = '",l_imea001,"' ",
                  "   AND imec002 = '",l_imeb002,"' ",
                  "   AND imecent = ",g_enterprise,
                  " ORDER BY imec003 "
      PREPARE aslt500_01_title1_pre FROM l_sql
      DECLARE aslt500_01_title1_cur CURSOR FOR aslt500_01_title1_pre
      FOREACH aslt500_01_title1_cur INTO l_imec_d[l_cnt].*
         IF cl_null(l_imec_d[l_cnt].l_imecl005) THEN
            LET l_imec_d[l_cnt].l_imecl005 = l_imec_d[l_cnt].l_imec003
         END IF
         CASE l_cnt
            WHEN 1
               CALL cl_set_comp_visible('l_item1',TRUE)
               CALL cl_set_comp_att_text('l_item1',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item1 = l_imec_d[l_cnt].l_imecl005
            WHEN 2
               CALL cl_set_comp_visible('l_item2',TRUE)
               CALL cl_set_comp_att_text('l_item2',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item2 = l_imec_d[l_cnt].l_imecl005
            WHEN 3
               CALL cl_set_comp_visible('l_item3',TRUE)
               CALL cl_set_comp_att_text('l_item3',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item3 = l_imec_d[l_cnt].l_imecl005
            WHEN 4
               CALL cl_set_comp_visible('l_item4',TRUE)
               CALL cl_set_comp_att_text('l_item4',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item4 = l_imec_d[l_cnt].l_imecl005
            WHEN 5
               CALL cl_set_comp_visible('l_item5',TRUE)
               CALL cl_set_comp_att_text('l_item5',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item5 = l_imec_d[l_cnt].l_imecl005
            WHEN 6
               CALL cl_set_comp_visible('l_item6',TRUE)
               CALL cl_set_comp_att_text('l_item6',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item6 = l_imec_d[l_cnt].l_imecl005
            WHEN 7
               CALL cl_set_comp_visible('l_item7',TRUE)
               CALL cl_set_comp_att_text('l_item7',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item7 = l_imec_d[l_cnt].l_imecl005
            WHEN 8
               CALL cl_set_comp_visible('l_item8',TRUE)
               CALL cl_set_comp_att_text('l_item8',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item8 = l_imec_d[l_cnt].l_imecl005
            WHEN 9
               CALL cl_set_comp_visible('l_item9',TRUE)
               CALL cl_set_comp_att_text('l_item9',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item9 = l_imec_d[l_cnt].l_imecl005
            WHEN 10
               CALL cl_set_comp_visible('l_item10',TRUE)
               CALL cl_set_comp_att_text('l_item10',l_imec_d[l_cnt].l_imecl005)
               LET l_item_d.l_item10 = l_imec_d[l_cnt].l_imecl005
         END CASE
         LET l_flag = 'Y'
         LET l_cnt = l_cnt + 1
      END FOREACH
      CALL l_imec_d.deleteElement(l_cnt)
      LET l_cnt = l_cnt - 1
   END IF
   #非二维特征，即纵向延伸的特征
   #首先获取特征名称
   LET l_cnt = 1
   CALL l_imeb_d.clear()
   INITIALIZE l_select TO NULL
   INITIALIZE l_from TO NULL
   INITIALIZE l_where TO NULL
   INITIALIZE l_order TO NULL
   INITIALIZE l_item_sql TO NULL
   LET l_sql = " SELECT DISTINCT imeb001,imeb002,imeb004,oocql004 ",
               " FROM imeb_t ",
               " LEFT OUTER JOIN oocql_t ON oocqlent = imebent AND oocql001 = '273' AND oocql002 = imeb004 AND oocql003 = '",g_dlang,"' ",
               " WHERE imeb001 = '",l_imea001,"' ",
               "   AND imeb003 = '2' ",
               "   AND imeb012 <> 'Y' ",
               "   AND imeb005 = '2' ",
               "   AND imebent = ",g_enterprise,
               " ORDER BY imeb004 "
   PREPARE aslt500_01_title_name1_pre FROM l_sql
   DECLARE aslt500_01_title_name1_cur CURSOR FOR aslt500_01_title_name1_pre
   FOREACH aslt500_01_title_name1_cur INTO l_imeb_d[l_cnt].*
      IF cl_null(l_imeb_d[l_cnt].l_imeb004_desc) THEN
         LET l_imeb_d[l_cnt].l_imeb004_desc = l_imeb_d[l_cnt].l_imeb004
      END IF
      CASE l_cnt
         WHEN 1
            CALL cl_set_comp_att_text('l_item_name1',l_imeb_d[l_cnt].l_imeb004_desc)
            LET l_item_d.l_item_name1 = l_imeb_d[l_cnt].l_imeb004_desc
            LET l_select = " SELECT t1.imec003,(SELECT imecl005 FROM imecl_t WHERE imeclent = t1.imecent AND imecl001 = t1.imec001 AND imecl002 = t1.imec002 AND imecl003 = t1.imec003 AND imecl004 = '",g_dlang,"') t1_imecl005 "
            LET l_from = " FROM imec_t t1 "
            LET l_where = " WHERE t1.imec001 = '",l_imeb_d[l_cnt].l_imeb001,"' AND t1.imec002 = '",l_imeb_d[l_cnt].l_imeb002,"' AND t1.imecent = ",g_enterprise," "
            LET l_order = " ORDER BY t1.imec003 "
         WHEN 2
            CALL cl_set_comp_visible('l_item_name2',TRUE)
            CALL cl_set_comp_att_text('l_item_name2',l_imeb_d[l_cnt].l_imeb004_desc)
            LET l_item_d.l_item_name2 = l_imeb_d[l_cnt].l_imeb004_desc
            LET l_select = l_select CLIPPED," ,t2.imec003,(SELECT imecl005 FROM imecl_t WHERE imeclent = t2.imecent AND imecl001 = t2.imec001 AND imecl002 = t2.imec002 AND imecl003 = t2.imec003 AND imecl004 = '",g_dlang,"') t2_imecl005 "
            LET l_from = l_from CLIPPED," ,imec_t t2 "
            LET l_where = l_where CLIPPED," AND t2.imec001 = '",l_imeb_d[l_cnt].l_imeb001,"' AND t2.imec002 = '",l_imeb_d[l_cnt].l_imeb002,"' AND t2.imecent = ",g_enterprise," "
            LET l_order = l_order CLIPPED," ,t2.imec003 "
         WHEN 3
            CALL cl_set_comp_visible('l_item_name3',TRUE)
            CALL cl_set_comp_att_text('l_item_name3',l_imeb_d[l_cnt].l_imeb004_desc)
            LET l_item_d.l_item_name3 = l_imeb_d[l_cnt].l_imeb004_desc
            LET l_select = l_select CLIPPED," ,t3.imec003,(SELECT imecl005 FROM imecl_t WHERE imeclent = t3.imecent AND imecl001 = t3.imec001 AND imecl002 = t3.imec002 AND imecl003 = t3.imec003 AND imecl004 = '",g_dlang,"') t3_imecl005 "
            LET l_from = l_from CLIPPED," ,imec_t t3 "
            LET l_where = l_where CLIPPED," AND t3.imec001 = '",l_imeb_d[l_cnt].l_imeb001,"' AND t3.imec002 = '",l_imeb_d[l_cnt].l_imeb002,"' AND t3.imecent = ",g_enterprise," "
            LET l_order = l_order CLIPPED," ,t3.imec003 "
         WHEN 4
            CALL cl_set_comp_visible('l_item_name4',TRUE)
            CALL cl_set_comp_att_text('l_item_name4',l_imeb_d[l_cnt].l_imeb004_desc)
            LET l_item_d.l_item_name4 = l_imeb_d[l_cnt].l_imeb004_desc
            LET l_select = l_select CLIPPED," ,t4.imec003,(SELECT imecl005 FROM imecl_t WHERE imeclent = t4.imecent AND imecl001 = t4.imec001 AND imecl002 = t4.imec002 AND imecl003 = t4.imec003 AND imecl004 = '",g_dlang,"') t4_imecl005 "
            LET l_from = l_from CLIPPED," ,imec_t t4 "
            LET l_where = l_where CLIPPED," AND t4.imec001 = '",l_imeb_d[l_cnt].l_imeb001,"' AND t4.imec002 = '",l_imeb_d[l_cnt].l_imeb002,"' AND t4.imecent = ",g_enterprise," "
            LET l_order = l_order CLIPPED," ,t4.imec003 "
         WHEN 5
            CALL cl_set_comp_visible('l_item_name5',TRUE)
            CALL cl_set_comp_att_text('l_item_name5',l_imeb_d[l_cnt].l_imeb004_desc)
            LET l_item_d.l_item_name5 = l_imeb_d[l_cnt].l_imeb004_desc
            LET l_select = l_select CLIPPED," ,t5.imec003,(SELECT imecl005 FROM imecl_t WHERE imeclent = t5.imecent AND imecl001 = t5.imec001 AND imecl002 = t5.imec002 AND imecl003 = t5.imec003 AND imecl004 = '",g_dlang,"') t5_imecl005 "
            LET l_from = l_from CLIPPED," ,imec_t t5 "
            LET l_where = l_where CLIPPED," AND t5.imec001 = '",l_imeb_d[l_cnt].l_imeb001,"' AND t5.imec002 = '",l_imeb_d[l_cnt].l_imeb002,"' AND t5.imecent = ",g_enterprise," "
            LET l_order = l_order CLIPPED," ,t5.imec003 "
      END CASE
      LET l_flag = 'Y'        #l_flag有其他特征
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_imec_d.deleteElement(l_cnt)
   LET l_cnt = l_cnt - 1
   #获取后直接存入title暂存档
   IF l_flag = 'Y' THEN
      CALL s_transaction_begin()
      LET l_item_d.l_pmdn001 = p_pmdn001
      SELECT COUNT(*) INTO l_ac        #判断是否已有
        FROM aslt500_01_tit_tmp
       WHERE l_pmdn001 = l_item_d.l_pmdn001
      IF l_ac > 0 THEN
         CALL s_transaction_end('N','0')
         LET l_cnt = 0
      ELSE
         INSERT INTO aslt500_01_tit_tmp VALUES (l_item_d.*)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins_tmp"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
      END IF
   END IF
   #纵向展开二维特征值,采用全连接的方式，列举出所有组合可能
   LET l_item_sql = l_select CLIPPED,' ',l_from CLIPPED,' ',l_where CLIPPED,' ',l_order CLIPPED
   PREPARE aslt500_01_value_pre FROM l_item_sql
   DECLARE aslt500_01_value_cur CURSOR FOR aslt500_01_value_pre
   LET l_ac = 1
#   CALL s_transaction_begin()
   
   #根据l_cnt的值,将查出的字段存入
   CASE l_cnt
      WHEN 1
         FOREACH aslt500_01_value_cur INTO l_item_d.l_item_name1,g_pmdn2_d[l_ac].l_item_name1
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name1) THEN
               LET g_pmdn2_d[l_ac].l_item_name1 = l_item_d.l_item_name1
            END IF
            INSERT INTO aslt500_01_val_tmp VALUES (g_pmdn_d[g_detail_idx].pmdn001,g_pmdn_d[g_detail_idx].pmdn001_desc,
                                                   g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn006_desc,
                                                   g_pmdn2_d[l_ac].l_item_name1,g_pmdn2_d[l_ac].l_item_name2,g_pmdn2_d[l_ac].l_item_name3,g_pmdn2_d[l_ac].l_item_name4,g_pmdn2_d[l_ac].l_item_name5,
                                                   0,0,0,0,0,0,0,0,0,0,0)
#                                                   g_pmdn2_d[l_ac].*)
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "ins_tmp2"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               CALL s_transaction_end('N','0')
#            ELSE
#               CALL s_transaction_end('Y','0')
#            END IF                                                   
            LET l_ac = l_ac + 1
         END FOREACH
      WHEN 2
         FOREACH aslt500_01_value_cur INTO l_item_d.l_item_name1,g_pmdn2_d[l_ac].l_item_name1,
                                           l_item_d.l_item_name2,g_pmdn2_d[l_ac].l_item_name2
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name1) THEN
               LET g_pmdn2_d[l_ac].l_item_name1 = l_item_d.l_item_name1
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name2) THEN
               LET g_pmdn2_d[l_ac].l_item_name2 = l_item_d.l_item_name2
            END IF
            INSERT INTO aslt500_01_val_tmp VALUES (g_pmdn_d[g_detail_idx].pmdn001,g_pmdn_d[g_detail_idx].pmdn001_desc,
                                                   g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn006_desc,
                                                   g_pmdn2_d[l_ac].l_item_name1,g_pmdn2_d[l_ac].l_item_name2,g_pmdn2_d[l_ac].l_item_name3,g_pmdn2_d[l_ac].l_item_name4,g_pmdn2_d[l_ac].l_item_name5,
                                                   0,0,0,0,0,0,0,0,0,0,0)
#                                                   g_pmdn2_d[l_ac].*)
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "ins_tmp2"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               CALL s_transaction_end('N','0')
#            ELSE
#               CALL s_transaction_end('Y','0')
#            END IF                                                   
            LET l_ac = l_ac + 1
         END FOREACH
      WHEN 3
         FOREACH aslt500_01_value_cur INTO l_item_d.l_item_name1,g_pmdn2_d[l_ac].l_item_name1,
                                           l_item_d.l_item_name2,g_pmdn2_d[l_ac].l_item_name2,
                                           l_item_d.l_item_name3,g_pmdn2_d[l_ac].l_item_name3
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name1) THEN
               LET g_pmdn2_d[l_ac].l_item_name1 = l_item_d.l_item_name1
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name2) THEN
               LET g_pmdn2_d[l_ac].l_item_name2 = l_item_d.l_item_name2
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name3) THEN
               LET g_pmdn2_d[l_ac].l_item_name3 = l_item_d.l_item_name3
            END IF
            INSERT INTO aslt500_01_val_tmp VALUES (g_pmdn_d[g_detail_idx].pmdn001,g_pmdn_d[g_detail_idx].pmdn001_desc,
                                                   g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn006_desc,
                                                   g_pmdn2_d[l_ac].l_item_name1,g_pmdn2_d[l_ac].l_item_name2,g_pmdn2_d[l_ac].l_item_name3,g_pmdn2_d[l_ac].l_item_name4,g_pmdn2_d[l_ac].l_item_name5,
                                                   0,0,0,0,0,0,0,0,0,0,0)
#                                                   g_pmdn2_d[l_ac].*)
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "ins_tmp2"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               CALL s_transaction_end('N','0')
#            ELSE
#               CALL s_transaction_end('Y','0')
#            END IF                                                   
            LET l_ac = l_ac + 1
         END FOREACH         
      WHEN 4
         FOREACH aslt500_01_value_cur INTO l_item_d.l_item_name1,g_pmdn2_d[l_ac].l_item_name1,
                                           l_item_d.l_item_name2,g_pmdn2_d[l_ac].l_item_name2,
                                           l_item_d.l_item_name3,g_pmdn2_d[l_ac].l_item_name3,
                                           l_item_d.l_item_name4,g_pmdn2_d[l_ac].l_item_name4
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name1) THEN
               LET g_pmdn2_d[l_ac].l_item_name1 = l_item_d.l_item_name1
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name2) THEN
               LET g_pmdn2_d[l_ac].l_item_name2 = l_item_d.l_item_name2
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name3) THEN
               LET g_pmdn2_d[l_ac].l_item_name3 = l_item_d.l_item_name3
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name4) THEN
               LET g_pmdn2_d[l_ac].l_item_name4 = l_item_d.l_item_name4
            END IF
            INSERT INTO aslt500_01_val_tmp VALUES (g_pmdn_d[g_detail_idx].pmdn001,g_pmdn_d[g_detail_idx].pmdn001_desc,
                                                   g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn006_desc,
                                                   g_pmdn2_d[l_ac].l_item_name1,g_pmdn2_d[l_ac].l_item_name2,g_pmdn2_d[l_ac].l_item_name3,g_pmdn2_d[l_ac].l_item_name4,g_pmdn2_d[l_ac].l_item_name5,
                                                   0,0,0,0,0,0,0,0,0,0,0)
#                                                   g_pmdn2_d[l_ac].*)
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "ins_tmp2"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               CALL s_transaction_end('N','0')
#            ELSE
#               CALL s_transaction_end('Y','0')
#            END IF                                                   
            LET l_ac = l_ac + 1
         END FOREACH         
      WHEN 5
         FOREACH aslt500_01_value_cur INTO l_item_d.l_item_name1,g_pmdn2_d[l_ac].l_item_name1,
                                           l_item_d.l_item_name2,g_pmdn2_d[l_ac].l_item_name2,
                                           l_item_d.l_item_name3,g_pmdn2_d[l_ac].l_item_name3,
                                           l_item_d.l_item_name4,g_pmdn2_d[l_ac].l_item_name4,
                                           l_item_d.l_item_name5,g_pmdn2_d[l_ac].l_item_name5
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name1) THEN
               LET g_pmdn2_d[l_ac].l_item_name1 = l_item_d.l_item_name1
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name2) THEN
               LET g_pmdn2_d[l_ac].l_item_name2 = l_item_d.l_item_name2
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name3) THEN
               LET g_pmdn2_d[l_ac].l_item_name3 = l_item_d.l_item_name3
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name4) THEN
               LET g_pmdn2_d[l_ac].l_item_name4 = l_item_d.l_item_name4
            END IF
            IF cl_null(g_pmdn2_d[l_ac].l_item_name5) THEN
               LET g_pmdn2_d[l_ac].l_item_name5 = l_item_d.l_item_name5
            END IF
            INSERT INTO aslt500_01_val_tmp VALUES (g_pmdn_d[g_detail_idx].pmdn001,g_pmdn_d[g_detail_idx].pmdn001_desc,
                                                   g_pmdn_d[g_detail_idx].pmdn006,g_pmdn_d[g_detail_idx].pmdn006_desc,
                                                   g_pmdn2_d[l_ac].l_item_name1,g_pmdn2_d[l_ac].l_item_name2,g_pmdn2_d[l_ac].l_item_name3,g_pmdn2_d[l_ac].l_item_name4,g_pmdn2_d[l_ac].l_item_name5,
                                                   0,0,0,0,0,0,0,0,0,0,0)
#                                                   g_pmdn2_d[l_ac].*)
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "ins_tmp2"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               CALL s_transaction_end('N','0')
#            ELSE
#               CALL s_transaction_end('Y','0')
#            END IF                                                   
            LET l_ac = l_ac + 1
         END FOREACH              
   END CASE
#   DISPLAY ARRAY g_pmdn2_d TO s_detail2.*
END FUNCTION

################################################################################
# Descriptions...: 建立暂存档，存放产品特征值及特征项目
# Memo...........:
# Usage..........: CALL aslt500_01_create_tmp()
#                  RETURNING r_success
# Date & Author..: 2016-6-30 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION aslt500_01_create_tmp()
   DROP TABLE aslt500_01_tit_tmp
   #存放title信息，供明细浏览页签显示群组值
   CREATE TEMP TABLE aslt500_01_tit_tmp(
   l_pmdn001       VARCHAR(40),
   l_item_name1    VARCHAR(100),
   l_item_name2    VARCHAR(100),
   l_item_name3    VARCHAR(100),
   l_item_name4    VARCHAR(100),
   l_item_name5    VARCHAR(100),
   l_item1    VARCHAR(100),
   l_item2    VARCHAR(100),
   l_item3    VARCHAR(100),
   l_item4    VARCHAR(100),
   l_item5    VARCHAR(100),
   l_item6    VARCHAR(100),
   l_item7    VARCHAR(100),
   l_item8    VARCHAR(100),
   l_item9    VARCHAR(100),
   l_item10    VARCHAR(100)
   )
   DROP TABLE aslt500_01_val_tmp
   #存放资料信息，供明细浏览页签显示明细
   CREATE TEMP TABLE aslt500_01_val_tmp(
   l_pmdn001       VARCHAR(40),
   l_pmdn001_desc  VARCHAR(255),
   l_pmdn006       VARCHAR(10), 
   l_pmdn006_desc  VARCHAR(500), 
   l_item_name1    VARCHAR(100),
   l_item_name2    VARCHAR(100),
   l_item_name3    VARCHAR(100),
   l_item_name4    VARCHAR(100),
   l_item_name5    VARCHAR(100),
   l_item1    INTEGER,
   l_item2    INTEGER,
   l_item3    INTEGER,
   l_item4    INTEGER,
   l_item5    INTEGER,
   l_item6    INTEGER,
   l_item7    INTEGER,
   l_item8    INTEGER,
   l_item9    INTEGER,
   l_item10    INTEGER,
   l_item_sum  INTEGER
   )
   DROP TABLE aslt500_01_sho_tmp
   #存放资料信息，供明细浏览页签显示明细
   CREATE TEMP TABLE aslt500_01_sho_tmp(
   l_cnt           VARCHAR(20),
   l_pmdn001       VARCHAR(40),
   l_pmdn001_desc  VARCHAR(255),
   l_pmdn006       VARCHAR(10), 
   l_pmdn006_desc  VARCHAR(500), 
   l_item_name1    VARCHAR(100),
   l_item_name2    VARCHAR(100),
   l_item_name3    VARCHAR(100),
   l_item_name4    VARCHAR(100),
   l_item_name5    VARCHAR(100),
   l_item1    VARCHAR(20),
   l_item2    VARCHAR(20),
   l_item3    VARCHAR(20),
   l_item4    VARCHAR(20),
   l_item5    VARCHAR(20),
   l_item6    VARCHAR(20),
   l_item7    VARCHAR(20),
   l_item8    VARCHAR(20),
   l_item9    VARCHAR(20),
   l_item10    VARCHAR(20),
   l_item_sum  INTEGER
   )
END FUNCTION

################################################################################
# Descriptions...: 填充二维录入页签的数值
# Memo...........:
# Usage..........: CALL aslt500_01_value1_fill(p_pmdn001)
#                  RETURNING 回传参数
# Date & Author..: 2016-7-1 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION aslt500_01_value1_fill(p_pmdn001)
DEFINE p_pmdn001  LIKE pmdn_t.pmdn001
DEFINE l_sql      STRING
DEFINE l_ac       LIKE type_t.num10
   
   IF cl_null(p_pmdn001) THEN RETURN END IF
   CALL g_pmdn2_d.CLEAR()
   LET l_sql = " SELECT DISTINCT l_item_name1,l_item_name2,l_item_name3,l_item_name4,l_item_name5,",
               "                 NVL(l_item1,0),NVL(l_item2,0),NVL(l_item3,0),NVL(l_item4,0),NVL(l_item5,0),",
               "                 NVL(l_item6,0),NVL(l_item7,0),NVL(l_item8,0),NVL(l_item9,0),NVL(l_item10,0),",
               "                 NVL(l_item1,0)+NVL(l_item2,0)+NVL(l_item3,0)+NVL(l_item4,0)+NVL(l_item5,0)+NVL(l_item6,0)+NVL(l_item7,0)+NVL(l_item8,0)+NVL(l_item9,0)+NVL(l_item10,0) ",
               "   FROM aslt500_01_val_tmp ",
               "  WHERE l_pmdn001 = '",p_pmdn001,"' ",
               "  ORDER BY l_item_name1,l_item_name2,l_item_name3,l_item_name4,l_item_name5 "
   LET l_ac = 1               
   PREPARE aslt500_01_val_fill_pre FROM l_sql    
   DECLARE aslt500_01_val_fill_cur CURSOR FOR aslt500_01_val_fill_pre
   FOREACH aslt500_01_val_fill_cur INTO g_pmdn2_d[l_ac].*
      LET l_ac = l_ac + 1 
   END FOREACH
   CALL g_pmdn2_d.deleteElement(l_ac)
   LET l_ac = l_ac - 1
END FUNCTION

################################################################################
# Descriptions...: 求二维录入合计值
# Memo...........:
################################################################################
PRIVATE FUNCTION aslt500_01_value1_sum()
DEFINE l_i     LIKE type_t.num10
   LET l_i = g_detail_idx2   
   LET g_pmdn2_d[l_i].l_item_sum = 0
#   FOR l_i = 1 TO g_pmdn2_d.getLength()
      IF NOT cl_null(g_pmdn2_d[l_i].l_item1) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item1
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item2) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item2
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item3) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item3
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item4) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item4
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item5) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item5
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item6) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item6
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item7) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item7
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item8) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item8
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item9) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item9
      END IF
      IF NOT cl_null(g_pmdn2_d[l_i].l_item10) THEN
         LET g_pmdn2_d[l_i].l_item_sum = g_pmdn2_d[l_i].l_item_sum + g_pmdn2_d[l_i].l_item10
      END IF
    LET g_pmdn_d[g_detail_idx].pmdn007 = 0
   FOR l_i = 1 TO g_pmdn2_d.getLength()
      IF NOT cl_null(g_pmdn2_d[l_i].l_item_sum) THEN
         LET g_pmdn_d[g_detail_idx].pmdn007 = g_pmdn_d[g_detail_idx].pmdn007 + g_pmdn2_d[l_i].l_item_sum    
      END IF
   END FOR
         
#   END FOR
END FUNCTION

################################################################################
# Descriptions...: 填充最下方的浏览数据
# Memo...........:
# Usage..........: CALL aslt500_01_b_fill2()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aslt500_01_b_fill2()
DEFINE l_sr    RECORD
   l_name1     LIKE type_t.num10,
   l_name2     LIKE type_t.num10,
   l_name3     LIKE type_t.num10,
   l_name4     LIKE type_t.num10,
   l_name5     LIKE type_t.num10,
   l_item1     LIKE type_t.num10,
   l_item2     LIKE type_t.num10,
   l_item3     LIKE type_t.num10,
   l_item4     LIKE type_t.num10,
   l_item5     LIKE type_t.num10,
   l_item6     LIKE type_t.num10,
   l_item7     LIKE type_t.num10,
   l_item8     LIKE type_t.num10,
   l_item9     LIKE type_t.num10,
   l_item10    LIKE type_t.num10
END RECORD
DEFINE l_pmdn001  STRING
DEFINE l_sql      STRING
DEFINE l_sql_ins  STRING
DEFINE l_fill2_sql STRING
DEFINE l_cnt         LIKE type_t.chr20 #用来计数，控制单身的排序
DEFINE l_cnt1        LIKE type_t.num10
DEFINE l_item_sum    LIKE type_t.num10 #用来合计
DEFINE l_ac          LIKE type_t.num10
   #建立暂存档
   DELETE FROM aslt500_01_sho_tmp
   #将title资料进行插入，并根据最大个数进行显示栏位抬头
   CALL cl_set_comp_visible('l_pmdn002_2,l_pmdn002_3,l_pmdn002_4,l_pmdn002_5',FALSE)
   CALL cl_set_comp_visible('l_item1_1,l_item2_1,l_item3_1,l_item4_1,l_item5_1,l_item6_1,l_item7_1,l_item8_1,l_item9_1,l_item10_1',FALSE)   
   INITIALIZE l_pmdn001 TO NULL
   IF NOT cl_null(g_pmdn_d[1].pmdn001) THEN
      LET l_pmdn001 = l_pmdn001 CLIPPED,"'",g_pmdn_d[1].pmdn001,"'"
   END IF
   FOR l_cnt1 = 2 TO g_pmdn_d.getLength()
      LET l_pmdn001 = l_pmdn001 CLIPPED,",'",g_pmdn_d[l_cnt1].pmdn001,"'"
   END FOR
   INITIALIZE l_sr.* TO NULL
   CALL g_pmdn3_d.CLEAR()
   CALL g_pmdn3_d_color.CLEAR()
   LET l_sql = " SELECT COUNT(l_item_name1),COUNT(l_item_name2),COUNT(l_item_name3),COUNT(l_item_name4),COUNT(l_item_name5),",
               " COUNT(l_item1),COUNT(l_item2),COUNT(l_item3),COUNT(l_item4),COUNT(l_item5),",
               " COUNT(l_item6),COUNT(l_item7),COUNT(l_item8),COUNT(l_item9),COUNT(l_item10) ",
               " FROM aslt500_01_tit_tmp ",
               " WHERE l_pmdn001 IN (",l_pmdn001 CLIPPED,") "
   PREPARE l_pre1 FROM l_sql
   EXECUTE l_pre1 INTO l_sr.*
   IF l_sr.l_name1>0 THEN
      CALL cl_set_comp_visible('l_pmdn002_1',TRUE)
      CALL cl_set_comp_att_text('l_pmdn002_1','特征一')
   END IF
   IF l_sr.l_name2>0 THEN
      CALL cl_set_comp_visible('l_pmdn002_2',TRUE)
      CALL cl_set_comp_att_text('l_pmdn002_2','特征二')
   END IF
   IF l_sr.l_name3>0 THEN
      CALL cl_set_comp_visible('l_pmdn002_3',TRUE)
      CALL cl_set_comp_att_text('l_pmdn002_3','特征三')
   END IF
   IF l_sr.l_name4>0 THEN
      CALL cl_set_comp_visible('l_pmdn002_4',TRUE)
      CALL cl_set_comp_att_text('l_pmdn002_4','特征四')
   END IF
   IF l_sr.l_name5>0 THEN
      CALL cl_set_comp_visible('l_pmdn002_5',TRUE)
      CALL cl_set_comp_att_text('l_pmdn002_5','特征五')
   END IF
   IF l_sr.l_item1>0 THEN
      CALL cl_set_comp_visible('l_item1_1',TRUE)
      CALL cl_set_comp_att_text('l_item1_1','特征值一')
   END IF
   IF l_sr.l_item2>0 THEN
      CALL cl_set_comp_visible('l_item2_1',TRUE)
      CALL cl_set_comp_att_text('l_item2_1','特征值二')
   END IF
   IF l_sr.l_item3>0 THEN
      CALL cl_set_comp_visible('l_item3_1',TRUE)
      CALL cl_set_comp_att_text('l_item3_1','特征值三')
   END IF
   IF l_sr.l_item4>0 THEN
      CALL cl_set_comp_visible('l_item4_1',TRUE)
      CALL cl_set_comp_att_text('l_item4_1','特征值四')
   END IF
   IF l_sr.l_item5>0 THEN
      CALL cl_set_comp_visible('l_item5_1',TRUE)
      CALL cl_set_comp_att_text('l_item5_1','特征值五')
   END IF
   IF l_sr.l_item6>0 THEN
      CALL cl_set_comp_visible('l_item6_1',TRUE)
      CALL cl_set_comp_att_text('l_item6_1','特征值六')
   END IF
   IF l_sr.l_item7>0 THEN
      CALL cl_set_comp_visible('l_item7_1',TRUE)
      CALL cl_set_comp_att_text('l_item7_1','特征值七')
   END IF
   IF l_sr.l_item8>0 THEN
      CALL cl_set_comp_visible('l_item8_1',TRUE)
      CALL cl_set_comp_att_text('l_item8_1','特征值八')
   END IF
   IF l_sr.l_item9>0 THEN
      CALL cl_set_comp_visible('l_item9_1',TRUE)
      CALL cl_set_comp_att_text('l_item9_1','特征值九')
   END IF
   IF l_sr.l_item10>0 THEN
      CALL cl_set_comp_visible('l_item10_1',TRUE)
      CALL cl_set_comp_att_text('l_item10_1','特征值十')
   END IF
   #按照料号，显示单身内容，并进行合计
   LET l_sql = " SELECT trim(l_pmdn001)||'-'||'1',NULL,NULL,NULL,NULL,l_item_name1,l_item_name2,l_item_name3,l_item_name4,l_item_name5,",
               "        l_item1,l_item2,l_item3,l_item4,l_item5,l_item6,l_item7,l_item8,l_item9,l_item10,NULL ",
#               "        DECODE(l_item1,0,NULL,l_item1),DECODE(l_item2,0,NULL,l_item2),DECODE(l_item3,0,NULL,l_item3),DECODE(l_item4,0,NULL,l_item4),DECODE(l_item5,0,NULL,l_item5),",
#               "        DECODE(l_item6,0,NULL,l_item6),DECODE(l_item7,0,NULL,l_item7),DECODE(l_item8,0,NULL,l_item8),DECODE(l_item9,0,NULL,l_item9),DECODE(l_item10,0,NULL,l_item10),0 ",
               "   FROM aslt500_01_tit_tmp ",
               "  WHERE l_pmdn001 IN (",l_pmdn001,") AND l_pmdn001 IN (SELECT l_pmdn001 FROM aslt500_01_val_tmp WHERE l_item_sum>0 AND l_item_sum IS NOT NULL) ",
               "  ORDER BY l_pmdn001 "
   LET l_sql_ins ="INSERT INTO aslt500_01_sho_tmp ",l_sql
   EXECUTE IMMEDIATE l_sql_ins
   IF sqlca.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "INS_FILL2_TMP1:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
#   PREPARE l_title_fill_pre FROM l_sql
#   DECLARE l_title_fill_cur CURSOR FOR l_title_fill_pre
   LET l_sql = " SELECT trim(l_pmdn001)||'-'||'2',l_pmdn001,l_pmdn001_desc,l_pmdn006,l_pmdn006_desc,",
               "        l_item_name1,l_item_name2,l_item_name3,l_item_name4,l_item_name5,",
#               "        l_item1,l_item2,l_item3,l_item4,l_item5,l_item6,l_item7,l_item8,l_item9,l_item10,l_item_sum ",
               "        DECODE(l_item1,0,NULL,l_item1),DECODE(l_item2,0,NULL,l_item2),DECODE(l_item3,0,NULL,l_item3),DECODE(l_item4,0,NULL,l_item4),DECODE(l_item5,0,NULL,l_item5),",
               "        DECODE(l_item6,0,NULL,l_item6),DECODE(l_item7,0,NULL,l_item7),DECODE(l_item8,0,NULL,l_item8),DECODE(l_item9,0,NULL,l_item9),DECODE(l_item10,0,NULL,l_item10),l_item_sum ",
               "   FROM aslt500_01_val_tmp ",
               "  WHERE l_pmdn001 IN (",l_pmdn001,") AND l_item_sum > 0",
               "  ORDER BY l_pmdn001 "
#   PREPARE l_value_fill_pre FROM l_sql
#   DECLARE l_value_fill_cur CURSOR FOR l_value_fill_pre
   LET l_sql_ins= "INSERT INTO aslt500_01_sho_tmp ",l_sql
   EXECUTE IMMEDIATE l_sql_ins
   IF sqlca.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "INS_FILL2_TMP2:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   LET l_sql = "SELECT SUM(l_item_sum) 
                  FROM aslt500_01_val_tmp ",
                "  WHERE l_pmdn001 IN (",l_pmdn001,") "
   PREPARE l_pre2 FROM l_sql
   EXECUTE l_pre2 INTO l_item_sum
   
   IF cl_null(l_item_sum) THEN
      LET l_item_sum = 0
   END IF
   INSERT INTO aslt500_01_sho_tmp VALUES ('ZZZZZZZZZZ','合计',NULL,NULL,NULL,
                                           NULL,NULL,NULL,NULL,NULL,
                                           NULL,NULL,NULL,NULL,NULL,
                                           NULL,NULL,NULL,NULL,NULL,l_item_sum)
   #填充入单身
   LET l_fill2_sql = "SELECT * FROM aslt500_01_sho_tmp ",   #WHERE (l_item_sum <> 0 OR l_item_sum IS NULL) 
                     "ORDER BY l_cnt,l_item_name1,l_item_name2,l_item_name3,l_item_name4,l_item_name5"
   PREPARE l_title_fill_pre FROM l_fill2_sql
   DECLARE l_title_fill_cur CURSOR FOR l_title_fill_pre
   LET l_ac = 1
   FOREACH l_title_fill_cur INTO l_cnt,g_pmdn3_d[l_ac].*
      IF l_cnt = 1 OR cl_null(g_pmdn3_d[l_ac].l_pmdn001_1) OR l_cnt = 'ZZZZZZZZZZ' THEN
         LET g_pmdn3_d_color[l_ac].c01 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c02 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c03 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c04 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c05 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c06 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c07 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c08 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c09 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c10 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c11 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c12 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c13 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c14 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c15 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c16 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c17 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c18 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c19 = 'blue reverse'
         LET g_pmdn3_d_color[l_ac].c20 = 'blue reverse'
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_pmdn3_d.deleteElement(l_ac)
   CALL g_pmdn3_d_color.deleteElement(l_ac)
END FUNCTION

 
{</section>}
 
