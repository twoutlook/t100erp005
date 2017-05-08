#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi310_03.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000005
#+ 
#+ Filename...: azzi310_03
#+ Description: 
#+ Creator....: 02286(2015-06-26 11:22:13)
#+ Modifier...: 02286(2015-07-14 14:43:21) -SD/PR- 02286
 
{</section>}
 
{<section id="azzi310_03.global" >}
#應用 i02 樣板自動產生(Version:14)

 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzif_d RECORD
       gzif001 LIKE gzif_t.gzif001, 
   gzif002 LIKE gzif_t.gzif002, 
   gzif003 LIKE gzif_t.gzif003, 
   gzif004 LIKE gzif_t.gzif004, 
   gzif005 LIKE gzif_t.gzif005, 
   gzif006 LIKE gzif_t.gzif006, 
   gzif006_desc LIKE type_t.chr500
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_gzif_d          DYNAMIC ARRAY OF type_g_gzif_d #單身變數
DEFINE g_gzif_d_t        type_g_gzif_d                  #單身備份
DEFINE g_gzif_d_o        type_g_gzif_d                  #單身備份
DEFINE g_gzif_d_mask_o   DYNAMIC ARRAY OF type_g_gzif_d #單身變數
DEFINE g_gzif_d_mask_n   DYNAMIC ARRAY OF type_g_gzif_d #單身變數
 
      
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
 
 
#add-point:自定義模組變數(Module Variable)
 DEFINE g_gzif001    LIKE gzif_t.gzif001
 DEFINE g_gzif002    LIKE gzif_t.gzif002
 DEFINE g_msg        STRING
 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="azzi310_03.main" >}
#應用 a27 樣板自動產生(Version:4)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION azzi310_03(--)
   #add-point:main段變數傳入
    p_gzif001,p_gzif002
   #end add-point
   )
   #add-point:main段define
     DEFINE p_gzif001    LIKE gzif_t.gzif001
     DEFINE p_gzif002    LIKE gzif_t.gzif002
     
     DEFINE l_cnt        LIKE type_t.num5
   #end add-point   
   #add-point:main段define(客製用)

   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
   LET g_gzif001=p_gzif001
   LET g_gzif002=p_gzif002
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT gzif001,gzif002,gzif003,gzif004,gzif005,gzif006 FROM gzif_t WHERE gzif001=?  
       AND gzif002=? AND gzif004 = ? FOR UPDATE"     #x修改程序框架 gzif004
   #add-point:main段define_sql
   LET g_wc2="gzif001='",p_gzif001,"' AND gzif002='",p_gzif002,"'"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi310_03_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi310_03 WITH FORM cl_ap_formpath("azz","azzi310_03")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL azzi310_03_init()   
 
   #進入選單 Menu (="N")
   CALL azzi310_03_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_azzi310_03
 
   
   
 
   #add-point:離開前
    LET l_cnt=0
    SELECT COUNT(*) INTO l_cnt FROM gzif_t 
    WHERE gzif001=p_gzif001 AND gzif002=p_gzif002
    IF l_cnt>0 THEN
        RETURN TRUE
    ELSE
        RETURN FALSE
    END IF
   #end add-point
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310_03.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzi310_03_init()
   #add-point:init段define

   #end add-point   
   #add-point:init段define(客製用)

   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('gzif003','203') 
   CALL cl_set_combo_scc('gzif005','204')
   LET g_msg=cl_getmsg('azz-00916',g_dlang)  
   CALL g_gzif_d.clear()   
   #end add-point
   
   CALL azzi310_03_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzi310_03_ui_dialog()
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
  
   #end add-point 
   #add-point:ui_dialog段define(客製用)

   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gzif_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL azzi310_03_init()
      END IF
   
      CALL azzi310_03_b_fill(g_wc2)      
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzif_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               #應用 a48 樣板自動產生(Version:2)
   CALL azzi310_03_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
               #add-point:display array-before row

               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
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
 
            #add-point:ui_dialog段before

            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi310_03_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi310_03_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi310_03_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi310_03_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi310_03_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
            END IF
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzif_d)
               LET g_export_id[1]   = "s_detail1"
 
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
            
         
         
         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL azzi310_03_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi310_03_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi310_03_set_pk_array()
            #add-point:ON ACTION followup

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
         #add-point:ui_dialog段離開dialog前

         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi310_03_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   #add-point:query段define(客製用)
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzif_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON gzif001,gzif002,gzif003,gzif004,gzif005,gzif006,gzif006_desc 
 
         FROM s_detail1[1].gzif001,s_detail1[1].gzif002,s_detail1[1].gzif003,s_detail1[1].gzif004,s_detail1[1].gzif005, 
             s_detail1[1].gzif006,s_detail1[1].gzif006_desc 
      
         
      
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif001
            #add-point:BEFORE FIELD gzif001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif001
            
            #add-point:AFTER FIELD gzif001
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.gzif001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif001
            #add-point:ON ACTION controlp INFIELD gzif001
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif002
            #add-point:BEFORE FIELD gzif002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif002
            
            #add-point:AFTER FIELD gzif002
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.gzif002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif002
            #add-point:ON ACTION controlp INFIELD gzif002
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif003
            #add-point:BEFORE FIELD gzif003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif003
            
            #add-point:AFTER FIELD gzif003
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.gzif003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif003
            #add-point:ON ACTION controlp INFIELD gzif003
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif004
            #add-point:BEFORE FIELD gzif004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif004
            
            #add-point:AFTER FIELD gzif004
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.gzif004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif004
            #add-point:ON ACTION controlp INFIELD gzif004
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif005
            #add-point:BEFORE FIELD gzif005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif005
            
            #add-point:AFTER FIELD gzif005
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.gzif005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif005
            #add-point:ON ACTION controlp INFIELD gzif005
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif006
            #add-point:BEFORE FIELD gzif006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif006
            
            #add-point:AFTER FIELD gzif006
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.gzif006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif006
            #add-point:ON ACTION controlp INFIELD gzif006
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif006_desc
            #add-point:BEFORE FIELD gzif006_desc
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif006_desc
            
            #add-point:AFTER FIELD gzif006_desc
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.gzif006_desc
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif006_desc
            #add-point:ON ACTION controlp INFIELD gzif006_desc
            
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
    
   CALL azzi310_03_b_fill(g_wc2)
   
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
 
{<section id="azzi310_03.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi310_03_insert()
   #add-point:delete段define
   
   #end add-point                
   #add-point:insert段define(客製用)
   
   #end add-point
   
   #add-point:單身新增前
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL azzi310_03_modify()
            
   #add-point:單身新增後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi310_03_modify()
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
   #add-point:modify段define
    DEFINE ldig_curr         ui.Dialog
   #end add-point 
   #add-point:modify段define(客製用)

   #end add-point
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前

   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前
 
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzif_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = 1,  
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzif_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi310_03_b_fill(g_wc2)
            LET g_detail_cnt = g_gzif_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_gzif_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gzif_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzif_d[l_ac].gzif001 IS NOT NULL
               AND g_gzif_d[l_ac].gzif002 IS NOT NULL
               AND g_gzif_d[l_ac].gzif004 IS NOT NULL  #修改程序框架
 
            THEN
               LET l_cmd='u'
               LET g_gzif_d_t.* = g_gzif_d[l_ac].*  #BACKUP
               LET g_gzif_d_o.* = g_gzif_d[l_ac].*  #BACKUP
               IF NOT azzi310_03_lock_b("gzif_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi310_03_bcl INTO g_gzif_d[l_ac].gzif001,g_gzif_d[l_ac].gzif002,g_gzif_d[l_ac].gzif003, 
                      g_gzif_d[l_ac].gzif004,g_gzif_d[l_ac].gzif005,g_gzif_d[l_ac].gzif006
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzif_d_t.gzif001 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzif_d_mask_o[l_ac].* =  g_gzif_d[l_ac].*
                  CALL azzi310_03_gzif_t_mask()
                  LET g_gzif_d_mask_n[l_ac].* =  g_gzif_d[l_ac].*
                  
                  CALL azzi310_03_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
#           IF g_gzif_d[l_ac].gzif005 = '1' THEN
#               CALL ldig_curr.setActionActive("controlp",FALSE)          
#            ELSE
#               CALL ldig_curr.setActionActive("controlp",TRUE)             
#            END IF
#            IF g_gzif_d[l_ac].gzif003 = '1' THEN
#               CALL cl_set_comp_entry("gzif004",TRUE) 
#            ELSE
#               CALL cl_set_comp_entry("gzif004",FALSE) 
#               LET g_gzif_d[l_ac].gzif004 = ''
#            END IF
#            LET g_gzif_d[l_ac].gzif001=g_gzif001
#            LET g_gzif_d[l_ac].gzif002=g_gzif002
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzif_d_t.* TO NULL
            INITIALIZE g_gzif_d_o.* TO NULL
            INITIALIZE g_gzif_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份
              LET g_gzif_d[l_ac].gzif001 = g_gzif001
              LET g_gzif_d[l_ac].gzif002 = g_gzif002                         
              LET g_gzif_d[l_ac].gzif003 = '1'
              LET g_gzif_d[l_ac].gzif005 = '1'
            #end add-point
            LET g_gzif_d_t.* = g_gzif_d[l_ac].*     #新輸入資料
            LET g_gzif_d_o.* = g_gzif_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi310_03_set_entry_b("a")
            CALL azzi310_03_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzif_d[li_reproduce_target].* = g_gzif_d[li_reproduce].*
 
               LET g_gzif_d[g_gzif_d.getLength()].gzif001 = NULL
               LET g_gzif_d[g_gzif_d.getLength()].gzif002 = NULL
 
            END IF
            
            #add-point:modify段before insert
          
              CALL ldig_curr.setActionActive("controlp",FALSE)
              CALL cl_set_comp_entry("gzif004",TRUE) 
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
            SELECT COUNT(*) INTO l_count FROM gzif_t 
             WHERE  gzif001 = g_gzif_d[l_ac].gzif001
                                       AND gzif002 = g_gzif_d[l_ac].gzif002
                                       AND gzif004 = g_gzif_d[l_ac].gzif004    #修改程序框架修改
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzif_d[g_detail_idx].gzif001
               LET gs_keys[2] = g_gzif_d[g_detail_idx].gzif002
               LET gs_keys[3] = g_gzif_d[g_detail_idx].gzif004       #修改程序框架修改
               CALL azzi310_03_insert_b('gzif_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_gzif_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzif_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi310_03_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (gzif001 = '", g_gzif_d[l_ac].gzif001, "' "
                                  ," AND gzif002 = '", g_gzif_d[l_ac].gzif002, "' "
 
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
               
               DELETE FROM gzif_t
                WHERE  
                      gzif001 = g_gzif_d_t.gzif001
                      AND gzif002 = g_gzif_d_t.gzif002
                      AND gzif004 = g_gzif_d_t.gzif004   #修改程序框架修改
 
                      
               #add-point:單身刪除中

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzif_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL azzi310_03_set_pk_array()
                  IF NOT cl_log_modified_record('','') THEN 
                  ELSE
                  END IF
               END IF 
               CLOSE azzi310_03_bcl
               #add-point:單身關閉bcl

               #end add-point
               LET l_count = g_gzif_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzif_d_t.gzif001
               LET gs_keys[2] = g_gzif_d_t.gzif002 
               LET gs_keys[3] = g_gzif_d_t.gzif004   #修改程序框架
               #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL azzi310_03_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
                              CALL azzi310_03_delete_b('gzif_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzif_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3

            #end add-point
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif001
            #add-point:BEFORE FIELD gzif001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif001
            
            #add-point:AFTER FIELD gzif001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzif_d[g_detail_idx].gzif001 IS NOT NULL AND g_gzif_d[g_detail_idx].gzif002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzif_d[g_detail_idx].gzif001 != g_gzif_d_t.gzif001 OR g_gzif_d[g_detail_idx].gzif002 != g_gzif_d_t.gzif002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzif_t WHERE "||"gzif001 = '"||g_gzif_d[g_detail_idx].gzif001 ||"' AND "|| "gzif002 = '"||g_gzif_d[g_detail_idx].gzif002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzif001
            #add-point:ON CHANGE gzif001

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif002
            #add-point:BEFORE FIELD gzif002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif002
            
            #add-point:AFTER FIELD gzif002
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gzif_d[g_detail_idx].gzif001 IS NOT NULL AND g_gzif_d[g_detail_idx].gzif002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzif_d[g_detail_idx].gzif001 != g_gzif_d_t.gzif001 OR g_gzif_d[g_detail_idx].gzif002 != g_gzif_d_t.gzif002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzif_t WHERE "||"gzif001 = '"||g_gzif_d[g_detail_idx].gzif001 ||"' AND "|| "gzif002 = '"||g_gzif_d[g_detail_idx].gzif002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzif002
            #add-point:ON CHANGE gzif002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif003
            #add-point:BEFORE FIELD gzif003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif003
            
            #add-point:AFTER FIELD gzif003
            IF g_gzif_d[l_ac].gzif003 = '1' THEN
               CALL cl_set_comp_entry("gzif004",TRUE) 
            ELSE
               CALL cl_set_comp_entry("gzif004",FALSE) 
               LET g_gzif_d[l_ac].gzif004 = '*'
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzif003
            #add-point:ON CHANGE gzif003
         IF g_gzif_d[l_ac].gzif003 = '1' THEN
            CALL cl_set_comp_entry("gzif004",TRUE) 
         ELSE
            CALL cl_set_comp_entry("gzif004",FALSE) 
            LET g_gzif_d[l_ac].gzif004 = '*'
         END IF
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif004
            #add-point:BEFORE FIELD gzif004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif004
            
            #add-point:AFTER FIELD gzif004
      IF  g_gzif_d[g_detail_idx].gzif001 IS NOT NULL AND g_gzif_d[g_detail_idx].gzif002 IS NOT NULL
      AND g_gzif_d[g_detail_idx].gzif004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzif_d[g_detail_idx].gzif001 != g_gzif_d_t.gzif001 OR g_gzif_d[g_detail_idx].gzif002 != g_gzif_d_t.gzif002 OR g_gzif_d[g_detail_idx].gzif004 != g_gzif_d_t.gzif004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzif_t WHERE "||"gzif001 = '"||g_gzif_d[g_detail_idx].gzif001 ||"' AND "|| "gzif002 = '"||g_gzif_d[g_detail_idx].gzif002 ||"' AND "|| "gzif004 = '"||g_gzif_d[g_detail_idx].gzif004 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzif004
            #add-point:ON CHANGE gzif004
      IF  g_gzif_d[g_detail_idx].gzif001 IS NOT NULL AND g_gzif_d[g_detail_idx].gzif002 IS NOT NULL
      AND g_gzif_d[g_detail_idx].gzif004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzif_d[g_detail_idx].gzif001 != g_gzif_d_t.gzif001 OR g_gzif_d[g_detail_idx].gzif002 != g_gzif_d_t.gzif002 OR g_gzif_d[g_detail_idx].gzif004 != g_gzif_d_t.gzif004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzif_t WHERE "||"gzif001 = '"||g_gzif_d[g_detail_idx].gzif001 ||"' AND "|| "gzif002 = '"||g_gzif_d[g_detail_idx].gzif002 ||"' AND "|| "gzif004 = '"||g_gzif_d[g_detail_idx].gzif004 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif005
            #add-point:BEFORE FIELD gzif005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif005
            
            #add-point:AFTER FIELD gzif005
            IF g_gzif_d[l_ac].gzif005 = '1' THEN
               CALL ldig_curr.setActionActive("controlp",FALSE)                
            ELSE
               CALL ldig_curr.setActionActive("controlp",TRUE)             
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzif005
            #add-point:ON CHANGE gzif005
         IF g_gzif_d[l_ac].gzif005 = '1' THEN          
            CALL ldig_curr.setActionActive("controlp",FALSE)           
         ELSE
            CALL ldig_curr.setActionActive("controlp",TRUE)
         END IF
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif006
            #add-point:BEFORE FIELD gzif006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif006
            
            #add-point:AFTER FIELD gzif006
            LET g_chkparam.arg1 = g_gzif_d[l_ac].gzif006
            IF g_gzif_d[l_ac].gzif005 = '2' THEN
               IF  NOT cl_chk_exist("v_gzze001") THEN
             	     NEXT FIELD CURRENT
               END IF
               LET g_gzif_d[l_ac].gzif006_desc=cl_getmsg(g_gzif_d[l_ac].gzif006,g_dlang) 
            ELSE
                LET g_gzif_d[l_ac].gzif006_desc = g_msg
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzif006
            #add-point:ON CHANGE gzif006
             IF g_gzif_d[l_ac].gzif006 != g_gzif_d_t.gzif006 AND g_gzif_d[l_ac].gzif005 = '2' THEN
               IF  NOT cl_chk_exist("v_gzze001") THEN
             	     NEXT FIELD CURRENT
               END IF
               LET g_gzif_d[l_ac].gzif006_desc=cl_getmsg(g_gzif_d[l_ac].gzif006,g_dlang) 
             ELSE
                 LET g_gzif_d[l_ac].gzif006_desc = g_msg
             END IF
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzif006_desc
            #add-point:BEFORE FIELD gzif006_desc

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzif006_desc
            
            #add-point:AFTER FIELD gzif006_desc

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzif006_desc
            #add-point:ON CHANGE gzif006_desc

            #END add-point 
 
 
                  #Ctrlp:input.c.page1.gzif001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif001
            #add-point:ON ACTION controlp INFIELD gzif001

            #END add-point
 
         #Ctrlp:input.c.page1.gzif002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif002
            #add-point:ON ACTION controlp INFIELD gzif002

            #END add-point
 
         #Ctrlp:input.c.page1.gzif003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif003
            #add-point:ON ACTION controlp INFIELD gzif003

            #END add-point
 
         #Ctrlp:input.c.page1.gzif004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif004
            #add-point:ON ACTION controlp INFIELD gzif004

            #END add-point
 
         #Ctrlp:input.c.page1.gzif005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif005
            #add-point:ON ACTION controlp INFIELD gzif005

            #END add-point
 
         #Ctrlp:input.c.page1.gzif006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif006
            #add-point:ON ACTION controlp INFIELD gzif006
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzif_d[l_ac].gzif006             #給予default值
            LET g_qryparam.default2 = "" #g_gzif_d[l_ac].gzze003 #錯誤訊息
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_gzze001()                                #呼叫開窗

            LET g_gzif_d[l_ac].gzif006 = g_qryparam.return1              
            LET g_gzif_d[l_ac].gzif006_desc = g_qryparam.return2 
            DISPLAY g_gzif_d[l_ac].gzif006 TO gzif006              #
            DISPLAY g_gzif_d[l_ac].gzif006_desc TO gzif006_desc #錯誤訊息
            NEXT FIELD gzif006                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.gzif006_desc
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzif006_desc
            #add-point:ON ACTION controlp INFIELD gzif006_desc

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_gzif_d[l_ac].* = g_gzif_d_t.*
               CLOSE azzi310_03_bcl
               #add-point:單身取消時

               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzif_d[l_ac].gzif001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzif_d[l_ac].* = g_gzif_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前

               #end add-point
               
               #將遮罩欄位還原
               CALL azzi310_03_gzif_t_mask_restore('restore_mask_o')
 
               UPDATE gzif_t SET (gzif001,gzif002,gzif003,gzif004,gzif005,gzif006) = (g_gzif_d[l_ac].gzif001, 
                   g_gzif_d[l_ac].gzif002,g_gzif_d[l_ac].gzif003,g_gzif_d[l_ac].gzif004,g_gzif_d[l_ac].gzif005, 
                   g_gzif_d[l_ac].gzif006)
                WHERE 
                  gzif001 = g_gzif_d_t.gzif001 #項次   
                  AND gzif002 = g_gzif_d_t.gzif002 
                  AND gzif004 = g_gzif_d_t.gzif004  #修改程序框架修改                  
 
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzif_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzif_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzif_d[g_detail_idx].gzif001
               LET gs_keys_bak[1] = g_gzif_d_t.gzif001
               LET gs_keys[2] = g_gzif_d[g_detail_idx].gzif002
               LET gs_keys_bak[2] = g_gzif_d_t.gzif002
               LET gs_keys[3] = g_gzif_d[g_detail_idx].gzif004
               LET gs_keys_bak[3] = g_gzif_d_t.gzif004
               CALL azzi310_03_update_b('gzif_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_gzif_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzif_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi310_03_gzif_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL azzi310_03_unlock_b("gzif_t")
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
            CALL FGL_SET_ARR_CURR(g_gzif_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzif_d.getLength()+1
            
      END INPUT
      
 
      
 
      
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
          LET ldig_curr = ui.Dialog.getCurrent()
          IF l_ac>0 THEN
             LET g_gzif_d[l_ac].gzif001=g_gzif001
             LET g_gzif_d[l_ac].gzif002=g_gzif002
          END IF
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD gzif001
 
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
      IF INT_FLAG OR cl_null(g_gzif_d[g_detail_idx].gzif001) THEN
         CALL g_gzif_d.deleteElement(g_detail_idx)
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_gzif_d[g_detail_idx].* = g_gzif_d_t.*
   END IF
   
   #add-point:modify段修改後

   #end add-point
 
   CLOSE azzi310_03_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi310_03_delete()
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point 
   #add-point:delete段define(客製用)

   #end add-point
   
   #add-point:單身刪除前

   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_gzif_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT azzi310_03_lock_b("gzif_t") THEN
            #已被他人鎖定
            RETURN
         END IF
      END IF
   END FOR
   
   #add-point:單身刪除詢問前

   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_gzif_d.getLength()
      IF g_gzif_d[li_idx].gzif001 IS NOT NULL
         AND g_gzif_d[li_idx].gzif002 IS NOT NULL 
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前

         #end add-point   
         
         DELETE FROM gzif_t
          WHERE  
                gzif001 = g_gzif_d[li_idx].gzif001
                AND gzif002 = g_gzif_d[li_idx].gzif002
    
         #add-point:單身刪除中

         #end add-point  
                
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzif_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
            
 
            #add-point:單身同步刪除前(同層table)

            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzif_d_t.gzif001
               LET gs_keys[2] = g_gzif_d_t.gzif002
               LET gs_keys[3] = g_gzif_d_t.gzif004                #修改程序框架
 
            #add-point:單身同步刪除中(同層table)

            #end add-point
                           CALL azzi310_03_delete_b('gzif_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table)

            #end add-point
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後

   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL azzi310_03_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi310_03_b_fill(p_wc2)              #BODY FILL UP
   DEFINE p_wc2    STRING
   #add-point:b_fill段define
   
   #end add-point
   #add-point:b_fill段define(客製用)
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前
   
   #end add-point
 
   LET g_sql = "SELECT  UNIQUE t0.gzif001,t0.gzif002,t0.gzif003,t0.gzif004,t0.gzif005,t0.gzif006  FROM gzif_t t0", 
 
               "",
               
               " WHERE 1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gzif_t"),
                      " ORDER BY t0.gzif001,t0.gzif002"
   
   #add-point:b_fill段sql之後
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzif_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzi310_03_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzi310_03_pb
   
   OPEN b_fill_curs
 
   CALL g_gzif_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gzif_d[l_ac].gzif001,g_gzif_d[l_ac].gzif002,g_gzif_d[l_ac].gzif003,g_gzif_d[l_ac].gzif004, 
       g_gzif_d[l_ac].gzif005,g_gzif_d[l_ac].gzif006
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
      
      CALL azzi310_03_detail_show()      
 
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
   
 
   
   CALL g_gzif_d.deleteElement(g_gzif_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_gzif_d.getLength()
 
      #add-point:b_fill段key值相關欄位
      
      #end add-point
   END FOR
   
   IF g_cnt > g_gzif_d.getLength() THEN
      LET l_ac = g_gzif_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzif_d.getLength()
      LET g_gzif_d_mask_o[l_ac].* =  g_gzif_d[l_ac].*
      CALL azzi310_03_gzif_t_mask()
      LET g_gzif_d_mask_n[l_ac].* =  g_gzif_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_gzif_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE azzi310_03_pb
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzi310_03_detail_show()
   #add-point:show段define
   
   #end add-point
   #add-point:detail_show段define(客製用)
   
   #end add-point
   
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
   
   #end add-point
   
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi310_03_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段define(客製用)
   
   #end add-point
   
   #add-point:set_entry_b段control
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
 
{</section>}
 
{<section id="azzi310_03.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi310_03_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   #add-point:set_no_entry_b段define(客製用)
   
   #end add-point   
 
   #add-point:set_no_entry_b段control
  CALL cl_set_comp_entry("gzif006_desc",FALSE)
   #end add-point       
                                                                                
END FUNCTION  
 
{</section>}
 
{<section id="azzi310_03.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi310_03_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   #add-point:default_search段define(客製用)
   
   #end add-point
   
   #add-point:default_search段開始前
   LET g_argv[01]=g_gzif001
   LET g_argv[02]=g_gzif002
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " gzif001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gzif002 = '", g_argv[02], "' AND "
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
 
{<section id="azzi310_03.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi310_03_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define

   #end add-point     
   #add-point:delete_b段define(客製用)

   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "gzif_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'gzif_t' THEN
         #add-point:delete_b段刪除前

         #end add-point     
         
         DELETE FROM gzif_t
          WHERE 
            gzif001 = ps_keys_bak[1] AND gzif002 = ps_keys_bak[2]
            AND gzif004 = ps_keys_bak[3]           #修改程序框架
         #add-point:delete_b段刪除中

         #end add-point  
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gzif_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後

      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi310_03_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define

   #end add-point     
   #add-point:insert_b段define(客製用)

   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "gzif_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前

      #end add-point    
      INSERT INTO gzif_t
                  (
                   gzif001,gzif002
                   ,gzif003,gzif004,gzif005,gzif006) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzif_d[l_ac].gzif003,ps_keys[3],g_gzif_d[l_ac].gzif005,g_gzif_d[l_ac].gzif006) 
 
      #add-point:insert_b段新增中
 
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzif_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         #修改程序框架
         
      END IF
      #add-point:insert_b段新增後

      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi310_03_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   #add-point:update_b段define

   #end add-point     
   #add-point:update_b段define(客製用)

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
   LET ls_group = "gzif_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gzif_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE gzif_t 
         SET (gzif001,gzif002
              ,gzif003,gzif004,gzif005,gzif006) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzif_d[l_ac].gzif003,ps_keys[3],g_gzif_d[l_ac].gzif005,g_gzif_d[l_ac].gzif006)  
 
         WHERE gzif001 = ps_keys_bak[1] AND gzif002 = ps_keys_bak[2] 
               AND gzif004= ps_keys_bak[3]   #修改程序框架
      #add-point:update_b段修改中

      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzif_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzif_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi310_03_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point   
   #add-point:lock_b段define(客製用)

   #end add-point
   
   #先刷新資料
   #CALL azzi310_03_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gzif_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi310_03_bcl USING 
                                       g_gzif_d[g_detail_idx].gzif001,g_gzif_d[g_detail_idx].gzif002,
                                       g_gzif_d[g_detail_idx].gzif004  #修改程序框架
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi310_03_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi310_03_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define(客製用)
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE azzi310_03_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION azzi310_03_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   #add-point:modify_detail_chk段define(客製用)
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "gzif001"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_03.mask_functions" >}
&include "erp/azz/azzi310_03_mask.4gl"
 
{</section>}
 
{<section id="azzi310_03.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi310_03_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_gzif_d[l_ac].gzif001
   LET g_pk_array[1].column = 'gzif001'
   LET g_pk_array[2].values = g_gzif_d[l_ac].gzif002
   LET g_pk_array[2].column = 'gzif002'
   LET g_pk_array[3].values = g_gzif_d[l_ac].gzif004     #修改程序框架
   LET g_pk_array[3].column = 'gzif004'
   #add-point:set_pk_array段之後

   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310_03.state_change" >}
   
 
{</section>}
 
{<section id="azzi310_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi310_03.other_function" readonly="Y" >}

 
{</section>}
 
