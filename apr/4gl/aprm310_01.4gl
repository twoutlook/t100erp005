#該程式已解開Section, 不再透過樣板產出!
{<section id="aprm310_01.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000005
#+ 
#+ Filename...: aprm310_01
#+ Description: 專櫃促銷釋出終止和取消終止
#+ Creator....: 01251(2015-07-31 15:24:44)
#+ Modifier...: 01251(2015-07-31 15:32:34) -SD/PR- 00000
 
{</section>}
 
{<section id="aprm310_01.global" >}
#應用 i02 樣板自動產生(Version:14)

 
IMPORT os
IMPORT util
#add-point:增加匯入項目
#160905-00007#12  2016/09/06  by 08742    调整系统中无ENT的SQL条件增加ent
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_prei_d RECORD
       sel LIKE type_t.chr500, 
   prei001 LIKE prei_t.prei001, 
   preiseq LIKE prei_t.preiseq, 
   prei003 LIKE prei_t.prei003, 
   prei003_desc LIKE type_t.chr500, 
   prei004 LIKE prei_t.prei004, 
   prei004_desc LIKE type_t.chr500
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_prei_d          DYNAMIC ARRAY OF type_g_prei_d #單身變數
DEFINE g_prei_d_t        type_g_prei_d                  #單身備份
DEFINE g_prei_d_o        type_g_prei_d                  #單身備份
DEFINE g_prei_d_mask_o   DYNAMIC ARRAY OF type_g_prei_d #單身變數
DEFINE g_prei_d_mask_n   DYNAMIC ARRAY OF type_g_prei_d #單身變數
 
      
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
DEFINE g_preg001     LIKE preg_t.preg001
DEFINE g_flag        LIKE type_t.chr1  #1:终止 2：取消终止
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="aprm310_01.main" >}
#應用 a27 樣板自動產生(Version:4)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION aprm310_01(--)
   #add-point:main段變數傳入
   p_preg001,p_flag
   #end add-point
   )
   #add-point:main段define
DEFINE p_preg001     LIKE preg_t.preg001
DEFINE p_flag        LIKE type_t.chr1
   #end add-point   
   #add-point:main段define(客製用)
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
   LET g_preg001=p_preg001
   LET g_flag =p_flag  
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT prei001,preiseq,prei003,prei004 FROM prei_t WHERE preient=? AND preiseq=?  
       AND prei001=? FOR UPDATE"
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprm310_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aprm310_01 WITH FORM cl_ap_formpath("apr","aprm310_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL aprm310_01_init()   
 
   #進入選單 Menu (="N")
   CALL aprm310_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_aprm310_01
 
   
   
 
   #add-point:離開前
   
   #end add-point
END FUNCTION
 
 
 
{</section>}
 
{<section id="aprm310_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aprm310_01_init()
   #add-point:init段define
   
   #end add-point   
   #add-point:init段define(客製用)
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   CALL aprm310_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aprm310_01_ui_dialog()
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
         CALL g_prei_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aprm310_01_init()
      END IF
   
      CALL aprm310_01_b_fill(g_wc2)
   
      CALL aprm310_01_modify()
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_prei_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aprm310_01_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
               #add-point:display array-before row

               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)          
            FOR li_idx = 1 TO g_prei_d.getLength()
               LET g_prei_d[li_idx].sel = "Y"
 
            END FOR
 
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_prei_d.getLength()
               LET g_prei_d[li_idx].sel = "N"
            END FOR
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
               CALL aprm310_01_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprm310_01_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprm310_01_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprm310_01_insert()
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
               CALL aprm310_01_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
            END IF
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_prei_d)
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
            CALL aprm310_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprm310_01_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprm310_01_set_pk_array()
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
 
{<section id="aprm310_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprm310_01_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   
   #end add-point 
   #add-point:query段define(客製用)
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_prei_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON sel,prei001,preiseq,prei003,prei004 
 
         FROM s_detail1[1].sel,s_detail1[1].prei001,s_detail1[1].preiseq,s_detail1[1].prei003,s_detail1[1].prei004  
 
      
         
      
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.sel
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD prei001
            #add-point:BEFORE FIELD prei001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD prei001
            
            #add-point:AFTER FIELD prei001
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.prei001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD prei001
            #add-point:ON ACTION controlp INFIELD prei001
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD preiseq
            #add-point:BEFORE FIELD preiseq
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD preiseq
            
            #add-point:AFTER FIELD preiseq
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.preiseq
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD preiseq
            #add-point:ON ACTION controlp INFIELD preiseq
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD prei003
            #add-point:BEFORE FIELD prei003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD prei003
            
            #add-point:AFTER FIELD prei003
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.prei003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD prei003
            #add-point:ON ACTION controlp INFIELD prei003
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD prei004
            #add-point:BEFORE FIELD prei004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD prei004
            
            #add-point:AFTER FIELD prei004
            
            #END add-point
            
 
         #Ctrlp:query.c.page1.prei004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD prei004
            #add-point:ON ACTION controlp INFIELD prei004
            
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
    
   CALL aprm310_01_b_fill(g_wc2)
   
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
 
{<section id="aprm310_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprm310_01_insert()
   #add-point:delete段define
   
   #end add-point                
   #add-point:insert段define(客製用)
   
   #end add-point
   
   #add-point:單身新增前
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aprm310_01_modify()
            
   #add-point:單身新增後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprm310_01_modify()
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
   DEFINE li_idx                  LIKE type_t.num10
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
      INPUT ARRAY g_prei_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prei_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprm310_01_b_fill(g_wc2)
            LET g_detail_cnt = g_prei_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_prei_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_prei_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_prei_d[l_ac].preiseq IS NOT NULL
               AND g_prei_d[l_ac].prei001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prei_d_t.* = g_prei_d[l_ac].*  #BACKUP
               LET g_prei_d_o.* = g_prei_d[l_ac].*  #BACKUP
               IF NOT aprm310_01_lock_b("prei_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprm310_01_bcl INTO g_prei_d[l_ac].prei001,g_prei_d[l_ac].preiseq,g_prei_d[l_ac].prei003, 
                      g_prei_d[l_ac].prei004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prei_d_t.preiseq 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prei_d_mask_o[l_ac].* =  g_prei_d[l_ac].*
                  CALL aprm310_01_prei_t_mask()
                  LET g_prei_d_mask_n[l_ac].* =  g_prei_d[l_ac].*
                  
                  CALL aprm310_01_detail_show()
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
            INITIALIZE g_prei_d_t.* TO NULL
            INITIALIZE g_prei_d_o.* TO NULL
            INITIALIZE g_prei_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_prei_d[l_ac].sel = "Y"
 
            #add-point:modify段before備份
            CANCEL INSERT
            #end add-point
            LET g_prei_d_t.* = g_prei_d[l_ac].*     #新輸入資料
            LET g_prei_d_o.* = g_prei_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprm310_01_set_entry_b("a")
            CALL aprm310_01_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prei_d[li_reproduce_target].* = g_prei_d[li_reproduce].*
 
               LET g_prei_d[g_prei_d.getLength()].preiseq = NULL
               LET g_prei_d[g_prei_d.getLength()].prei001 = NULL
 
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
            SELECT COUNT(*) INTO l_count FROM prei_t 
             WHERE preient = g_enterprise AND preiseq = g_prei_d[l_ac].preiseq
                                       AND prei001 = g_prei_d[l_ac].prei001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prei_d[g_detail_idx].preiseq
               LET gs_keys[2] = g_prei_d[g_detail_idx].prei001
               CALL aprm310_01_insert_b('prei_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_prei_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prei_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprm310_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (preiseq = '", g_prei_d[l_ac].preiseq, "' "
                                  ," AND prei001 = '", g_prei_d[l_ac].prei001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前
               CANCEL DELETE
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
               
               DELETE FROM prei_t
                WHERE preient = g_enterprise AND 
                      preiseq = g_prei_d_t.preiseq
                      AND prei001 = g_prei_d_t.prei001
 
                      
               #add-point:單身刪除中

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prei_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aprm310_01_set_pk_array()
                  IF NOT cl_log_modified_record('','') THEN 
                  ELSE
                  END IF
               END IF 
               CLOSE aprm310_01_bcl
               #add-point:單身關閉bcl

               #end add-point
               LET l_count = g_prei_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prei_d_t.preiseq
               LET gs_keys[2] = g_prei_d_t.prei001
 
               #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL aprm310_01_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
                              CALL aprm310_01_delete_b('prei_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_prei_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3

            #end add-point
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE sel
            #add-point:ON CHANGE sel

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD prei001
            #add-point:BEFORE FIELD prei001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD prei001
            
            #add-point:AFTER FIELD prei001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prei_d[g_detail_idx].preiseq IS NOT NULL AND g_prei_d[g_detail_idx].prei001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prei_d[g_detail_idx].preiseq != g_prei_d_t.preiseq OR g_prei_d[g_detail_idx].prei001 != g_prei_d_t.prei001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prei_t WHERE "||"preient = '" ||g_enterprise|| "' AND "||"preiseq = '"||g_prei_d[g_detail_idx].preiseq ||"' AND "|| "prei001 = '"||g_prei_d[g_detail_idx].prei001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE prei001
            #add-point:ON CHANGE prei001

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD preiseq
            #add-point:BEFORE FIELD preiseq

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD preiseq
            
            #add-point:AFTER FIELD preiseq
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prei_d[g_detail_idx].preiseq IS NOT NULL AND g_prei_d[g_detail_idx].prei001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prei_d[g_detail_idx].preiseq != g_prei_d_t.preiseq OR g_prei_d[g_detail_idx].prei001 != g_prei_d_t.prei001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prei_t WHERE "||"preient = '" ||g_enterprise|| "' AND "||"preiseq = '"||g_prei_d[g_detail_idx].preiseq ||"' AND "|| "prei001 = '"||g_prei_d[g_detail_idx].prei001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE preiseq
            #add-point:ON CHANGE preiseq

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD prei003
            
            #add-point:AFTER FIELD prei003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prei_d[l_ac].prei003
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prei_d[l_ac].prei003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prei_d[l_ac].prei003_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD prei003
            #add-point:BEFORE FIELD prei003

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE prei003
            #add-point:ON CHANGE prei003

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD prei004
            
            #add-point:AFTER FIELD prei004


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD prei004
            #add-point:BEFORE FIELD prei004

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE prei004
            #add-point:ON CHANGE prei004

            #END add-point 
 
 
                  #Ctrlp:input.c.page1.sel
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel

            #END add-point
 
         #Ctrlp:input.c.page1.prei001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD prei001
            #add-point:ON ACTION controlp INFIELD prei001

            #END add-point
 
         #Ctrlp:input.c.page1.preiseq
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD preiseq
            #add-point:ON ACTION controlp INFIELD preiseq

            #END add-point
 
         #Ctrlp:input.c.page1.prei003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD prei003
            #add-point:ON ACTION controlp INFIELD prei003

            #END add-point
 
         #Ctrlp:input.c.page1.prei004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD prei004
            #add-point:ON ACTION controlp INFIELD prei004

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_prei_d[l_ac].* = g_prei_d_t.*
               CLOSE aprm310_01_bcl
               #add-point:單身取消時

               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prei_d[l_ac].preiseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_prei_d[l_ac].* = g_prei_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前

               #end add-point
               
               #將遮罩欄位還原
               CALL aprm310_01_prei_t_mask_restore('restore_mask_o')
 
#               UPDATE prei_t SET (prei001,preiseq,prei003,prei004) = (g_prei_d[l_ac].prei001,g_prei_d[l_ac].preiseq, 
#                   g_prei_d[l_ac].prei003,g_prei_d[l_ac].prei004)
#                WHERE preient = g_enterprise AND
#                  preiseq = g_prei_d_t.preiseq #項次   
#                  AND prei001 = g_prei_d_t.prei001  
# 
#                  
#

#
#                 
#              CASE
#                 WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                    INITIALIZE g_errparam TO NULL 
#                    LET g_errparam.extend = "prei_t" 
#                    LET g_errparam.code   = "std-00009" 
#                    LET g_errparam.popup  = TRUE 
#                    CALL cl_err()
#                   WHEN SQLCA.sqlcode #其他錯誤
#                    INITIALIZE g_errparam TO NULL 
#                    LET g_errparam.extend = "prei_t" 
#                    LET g_errparam.code   = SQLCA.sqlcode 
#                    LET g_errparam.popup  = TRUE 
#                    CALL cl_err()
#                 OTHERWISE
#                                   INITIALIZE gs_keys TO NULL 
#              LET gs_keys[1] = g_prei_d[g_detail_idx].preiseq
#              LET gs_keys_bak[1] = g_prei_d_t.preiseq
#              LET gs_keys[2] = g_prei_d[g_detail_idx].prei001
#              LET gs_keys_bak[2] = g_prei_d_t.prei001
#              CALL aprm310_01_update_b('prei_t',gs_keys,gs_keys_bak,"'1'")
#                    #資料多語言用-增/改
#                    
#                    #修改歷程記錄(修改)
#                    LET g_log1 = util.JSON.stringify(g_prei_d_t)
#                    LET g_log2 = util.JSON.stringify(g_prei_d[l_ac])
#                    IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                    END IF
#              END CASE
#              
#              #將遮罩欄位進行遮蔽
#              CALL aprm310_01_prei_t_mask_restore('restore_mask_n')
#              
#              #add-point:單身修改後

#              #end add-point
 
            END IF
            
         AFTER ROW
            CALL aprm310_01_unlock_b("prei_t")
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
            CALL FGL_SET_ARR_CURR(g_prei_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prei_d.getLength()+1
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input
       #全选
       ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)          
            FOR li_idx = 1 TO g_prei_d.getLength()
               LET g_prei_d[li_idx].sel = "Y"
 
            END FOR
 
 
       #取消全部
        ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_prei_d.getLength()
               LET g_prei_d[li_idx].sel = "N"
            END FOR
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
               NEXT FIELD sel
 
         END CASE
   
      ON ACTION accept
         CALL aprm310_01_stop()
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
      IF INT_FLAG OR cl_null(g_prei_d[g_detail_idx].preiseq) THEN
         CALL g_prei_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_prei_d[g_detail_idx].* = g_prei_d_t.*
   END IF
   
   #add-point:modify段修改後

   #end add-point
 
   CLOSE aprm310_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprm310_01_delete()
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
   FOR li_idx = 1 TO g_prei_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aprm310_01_lock_b("prei_t") THEN
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
   
   FOR li_idx = 1 TO g_prei_d.getLength()
      IF g_prei_d[li_idx].preiseq IS NOT NULL
         AND g_prei_d[li_idx].prei001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前
         
         #end add-point   
         
         DELETE FROM prei_t
          WHERE preient = g_enterprise AND 
                preiseq = g_prei_d[li_idx].preiseq
                AND prei001 = g_prei_d[li_idx].prei001
 
         #add-point:單身刪除中
         
         #end add-point  
                
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prei_t" 
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
               LET gs_keys[1] = g_prei_d_t.preiseq
               LET gs_keys[2] = g_prei_d_t.prei001
 
            #add-point:單身同步刪除中(同層table)
            
            #end add-point
                           CALL aprm310_01_delete_b('prei_t',gs_keys,"'1'")
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
   CALL aprm310_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprm310_01_b_fill(p_wc2)              #BODY FILL UP
   DEFINE p_wc2    STRING
   #add-point:b_fill段define
   DEFINE l_pregstus     LIKE preg_t.pregstus
   #end add-point
   #add-point:b_fill段define(客製用)
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前
   LET p_wc2=p_wc2," AND prei001='",g_preg001,"' AND preiacti='Y' "
   
   IF g_flag='1' THEN #终止发布
      SELECT pregstus INTO l_pregstus
        FROM preg_t
       WHERE pregent=g_enterprise
         AND preg001=g_preg001
      IF l_pregstus='F' THEN #单据已发布状态
         LET p_wc2=p_wc2," AND prei081='1'"
      END IF
      IF l_pregstus='Y' THEN #单据已审核状态
         LET p_wc2=p_wc2," AND prei081='0'"
      END IF      
   END IF
   IF g_flag='2' THEN #取消终止发布
      LET p_wc2=p_wc2," AND prei081='2'"
   END IF   
   #end add-point
 
   LET g_sql = "SELECT  UNIQUE t0.prei001,t0.preiseq,t0.prei003,t0.prei004 ,t1.inayl003 ,t2.mhael023 FROM prei_t t0", 
 
               "",
                              " LEFT JOIN inayl_t t1 ON t1.inaylent='"||g_enterprise||"' AND t1.inayl001=t0.prei003 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t2 ON t2.mhaelent='"||g_enterprise||"' AND t2.mhaelsite=t0.preisite AND t2.mhael001=t0.prei004 AND t2.mhael022='"||g_dlang||"' ",
 
               " WHERE t0.preient= ?  AND  1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("prei_t"),
                      " ORDER BY t0.preiseq,t0.prei001"
   
   #add-point:b_fill段sql之後
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"prei_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aprm310_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aprm310_01_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_prei_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_prei_d[l_ac].prei001,g_prei_d[l_ac].preiseq,g_prei_d[l_ac].prei003,g_prei_d[l_ac].prei004, 
       g_prei_d[l_ac].prei003_desc,g_prei_d[l_ac].prei004_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      LET g_prei_d[l_ac].sel='Y'
      #end add-point
      
      CALL aprm310_01_detail_show()      
 
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
   
 
   
   CALL g_prei_d.deleteElement(g_prei_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_prei_d.getLength()
 
      #add-point:b_fill段key值相關欄位
      
      #end add-point
   END FOR
   
   IF g_cnt > g_prei_d.getLength() THEN
      LET l_ac = g_prei_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_prei_d.getLength()
      LET g_prei_d_mask_o[l_ac].* =  g_prei_d[l_ac].*
      CALL aprm310_01_prei_t_mask()
      LET g_prei_d_mask_n[l_ac].* =  g_prei_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_prei_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aprm310_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aprm310_01_detail_show()
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
 
{<section id="aprm310_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprm310_01_set_entry_b(p_cmd)                                                  
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段define(客製用)
   
   #end add-point
   
   #add-point:set_entry_b段control
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                    
 
{</section>}
 
{<section id="aprm310_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprm310_01_set_no_entry_b(p_cmd)                                               
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define
   
   #end add-point
   #add-point:set_no_entry_b段define(客製用)
   
   #end add-point   
 
   #add-point:set_no_entry_b段control
   
   #end add-point       
                                                                                
END FUNCTION  
 
{</section>}
 
{<section id="aprm310_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprm310_01_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   #add-point:default_search段define(客製用)
   
   #end add-point
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " preiseq = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " prei001 = '", g_argv[02], "' AND "
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
 
{<section id="aprm310_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprm310_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "prei_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'prei_t' THEN
         #add-point:delete_b段刪除前
         
         #end add-point     
         
         DELETE FROM prei_t
          WHERE preient = g_enterprise AND
            preiseq = ps_keys_bak[1] AND prei001 = ps_keys_bak[2]
         
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
         CALL g_prei_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprm310_01_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   
   #end add-point     
   #add-point:insert_b段define(客製用)
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "prei_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前
      
      #end add-point    
      INSERT INTO prei_t
                  (preient,
                   preiseq,prei001
                   ,prei003,prei004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prei_d[l_ac].prei003,g_prei_d[l_ac].prei004)
      #add-point:insert_b段新增中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prei_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprm310_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "prei_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "prei_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE prei_t 
         SET (preiseq,prei001
              ,prei003,prei004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prei_d[l_ac].prei003,g_prei_d[l_ac].prei004) 
         #WHERE preiseq = ps_keys_bak[1] AND prei001 = ps_keys_bak[2]   #160905-00007#12 mark
         WHERE preiseq = ps_keys_bak[1] AND prei001 = ps_keys_bak[2]  AND preient = g_enterprise #160905-00007#12 add
      #add-point:update_b段修改中

      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prei_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prei_t" 
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
 
{<section id="aprm310_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprm310_01_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   
   #end add-point   
   #add-point:lock_b段define(客製用)
   
   #end add-point
   
   #先刷新資料
   #CALL aprm310_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "prei_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprm310_01_bcl USING g_enterprise,
                                       g_prei_d[g_detail_idx].preiseq,g_prei_d[g_detail_idx].prei001
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprm310_01_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprm310_01_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define(客製用)
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aprm310_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aprm310_01_modify_detail_chk(ps_record)
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
         LET ls_return = "sel"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aprm310_01.mask_functions" >}
&include "erp/apr/aprm310_01_mask.4gl"
 
{</section>}
 
{<section id="aprm310_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION aprm310_01_set_pk_array()
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
   LET g_pk_array[1].values = g_prei_d[l_ac].preiseq
   LET g_pk_array[1].column = 'preiseq'
   LET g_pk_array[2].values = g_prei_d[l_ac].prei001
   LET g_pk_array[2].column = 'prei001'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="aprm310_01.state_change" >}
   
 
{</section>}
 
{<section id="aprm310_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aprm310_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 终止发布和取消终止发布
# Memo...........:
# Usage..........: CALL aprm310_01_stop()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150731 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprm310_01_stop()
DEFINE l_success    LIKE type_t.num5

   CALL s_transaction_begin()
   
   FOR l_ac = 1 TO g_prei_d.getLength()
       IF g_prei_d[l_ac].sel='Y' AND g_prei_d[l_ac].preiseq IS NOT NULL THEN
          IF g_flag='1' THEN #终止发布
             CALL s_aprp310_release2(g_preg001,g_prei_d[l_ac].preiseq) RETURNING l_success
             IF NOT l_success THEN
                EXIT FOR
             END IF
          END IF
          IF g_flag='2' THEN #取消终止发布
             CALL s_aprp310_release3(g_preg001,g_prei_d[l_ac].preiseq) RETURNING l_success
             IF NOT l_success THEN
                EXIT FOR
             END IF
          END IF          
       END IF

   END FOR
   
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')  
      CALL cl_ask_confirm3("adz-00217","")      
   END IF
   

   
END FUNCTION

 
{</section>}
 
